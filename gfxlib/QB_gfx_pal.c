/*
 *  Copyright (C) 2004 Sterling Christensen (sterling@engineer.com)
 *
 *  This library is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU Lesser General Public
 *  License as published by the Free Software Foundation; either
 *  version 2.1 of the License, or (at your option) any later version.
 *
 *  This library is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *  Lesser General Public License for more details.
 *
 *  You should have received a copy of the GNU Lesser General Public
 *  License along with this library; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/

/*
    ToDo: palette using?
*/

#include "QB_gfx_main.h"
#include "QB_gfx_pal.h"

#define SANITY_CHECK_CONDITION   (!fb_GfxInfo.sdlIsInitialized || !fb_GfxInfo.screen || !fb_GfxInfo.videoIsInitialized)
#define SANITY_CHECK             if (SANITY_CHECK_CONDITION) return -1;

extern struct fb_GfxInfoStruct fb_GfxInfo;

const SDL_Color fb_GfxDefaultPal[256] = {
#include "defaultPalette.h"
};

struct fb_GfxVgaPalEmuStruct fb_GfxVgaPalEmu = {0, 0, 0, 0, {0, 0, 0}};


void fb_GfxFlushPalette (void)
{
    SDL_Palette *p;

    p = fb_GfxInfo.screen->format->palette;
    SDL_SetPalette(fb_GfxInfo.screen, SDL_PHYSPAL, p->colors, 0, p->ncolors);
    fb_GfxInfo.paletteChanged = 0;
}

FBCALL int fb_GfxPalette (Uint32 attribute, Uint32 color)
{
    Uint8 r, g, b;

    SANITY_CHECK
    
    if (attribute == 0xFFFFFFFF && color == 0xFFFFFFFF)
    {
        fb_GfxInfo.paletteChanged = 1;

        /* casting to SDL_Color* kills a warning */
        return (SDL_SetPalette(fb_GfxInfo.screen, SDL_LOGPAL, (SDL_Color*)fb_GfxDefaultPal, 0, 256) == 0);
    }

    if (color > 0xFFFFFF || attribute > 255) return -1;
    
    r = (Uint8)(color);
    g = (Uint8)(color >> 8);
    b = (Uint8)(color >> 16);
    
    if (r > 63 || g > 63 || b > 63) return -1;
    
    return fb_GfxPaletteEx(attribute, (Uint32)(r * 255.0f / 63.0f + .5f),
                                      (Uint32)(g * 255.0f / 63.0f + .5f),
                                      (Uint32)(b * 255.0f / 63.0f + .5f) );
}

FBCALL int fb_GfxPaletteEx (Uint8 attribute, Uint8 r, Uint8 g, Uint8 b)
{
    SDL_Color c;
    
    SANITY_CHECK
    
    fb_GfxInfo.paletteChanged = 1;

    c.r = r;
    c.g = g;
    c.b = b;
    
    return (SDL_SetPalette(fb_GfxInfo.screen, SDL_LOGPAL, &c, attribute, 1) == 0);
}

FBCALL void fb_GfxOut (Uint32 port, Uint8 data)
{
    if (SANITY_CHECK_CONDITION) return;

    switch (port)
    {
    case 0x3C7:

        fb_GfxVgaPalEmu.readColor = data;
        fb_GfxVgaPalEmu.readIndex = 0;

        break;
    case 0x3C8:

        fb_GfxVgaPalEmu.writeColor = data;
        fb_GfxVgaPalEmu.writeIndex = 0;

        break;
    case 0x3C9:

        /* shifting right/left by 2 would make the display look slightly
           darker: (0 to 252) instead of (0 to 255), 63 << 2 = 252 */
        fb_GfxVgaPalEmu.rgbOut[fb_GfxVgaPalEmu.writeIndex++] = (Uint8)(data * (255.0f / 63.0f) + .5f);
        
        if (fb_GfxVgaPalEmu.writeIndex >= 3)
        {
            fb_GfxPaletteEx(fb_GfxVgaPalEmu.writeColor++, fb_GfxVgaPalEmu.rgbOut[0],
                                                          fb_GfxVgaPalEmu.rgbOut[1],
                                                          fb_GfxVgaPalEmu.rgbOut[2]);
            fb_GfxVgaPalEmu.writeIndex = 0;
        }
        
        break;
    }
}

FBCALL Uint8 fb_GfxInpEx (void)
{
    Uint8 ret;
    SDL_Color *c;
    
    SANITY_CHECK
    
    if (fb_GfxInfo.screen->format->BytesPerPixel != 1) return 0;
    
    c = fb_GfxInfo.screen->format->palette->colors + fb_GfxVgaPalEmu.readColor;
    
    switch (fb_GfxVgaPalEmu.readIndex)
    {
    case 0:
        ret = c->r;
        break;
    case 1:
        ret = c->g;
        break;
    default:  /* could only be 2 */
        ret = c->b;
        break;
    }

    if (++fb_GfxVgaPalEmu.readIndex >= 3)
    {
        fb_GfxVgaPalEmu.readColor++;
        fb_GfxVgaPalEmu.readIndex = 0;
    }
    
    /* shifting right/left by 2 would make the display look slightly
       darker: (0 to 252) instead of (0 to 255), 63 << 2 = 252 */
    return (Uint8)(ret * (63.0f / 255.0f) + .5f);  
}

FBCALL Uint8 fb_GfxInp (Uint32 port)
{
    if (port == 0x3C9) return fb_GfxInpEx();
    
    return 0;
}
