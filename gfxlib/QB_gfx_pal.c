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

#define FBGFX_NO_PALEMU_EXTERN
#include "QB_gfx_pal.h"
#undef FBGFX_NO_PALEMU_EXTERN

//#define SANITY_CHECK_CONDITION   (!fb_GfxInfo.sdlIsInitialized || !fb_GfxInfo.screen || !fb_GfxInfo.videoIsInitialized)
//#define SANITY_CHECK             if (SANITY_CHECK_CONDITION) return -1;

//extern struct fb_GfxInfoStruct fb_GfxInfo;


const SDL_Color fb_GfxDefaultPal[256] = {
#include "defaultPalette.h"
};

struct fb_GfxVgaPalEmuStruct fb_GfxVgaPalEmu = {0, 0, 0, 0, {0, 0, 0}};

/*
 *   Used by fb_GfxScreenEx
 */
void fb_GfxResetVgaPalEmu (void)
{
    fb_GfxVgaPalEmu.readColor = 0;
    fb_GfxVgaPalEmu.writeColor = 0;
    fb_GfxVgaPalEmu.readIndex = 0;
    fb_GfxVgaPalEmu.writeIndex = 0;
}

/*
 *   Used by fb_GfxFlip
 */
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

    if (SANITY_CHECK_CONDITION) return -1;
    
    if( attribute == 0xFFFFFFFF )
    {
        fb_GfxInfo.paletteChanged = 1;

        /* casting to SDL_Color* kills a warning */
        return (SDL_SetPalette(fb_GfxInfo.screen, SDL_LOGPAL, (SDL_Color*)fb_GfxDefaultPal, 0, 256) == 0);
    }

    if (color > 0xFFFFFF || attribute > 255) return -1;
    
    b = (Uint8)(color);
    g = (Uint8)(color >> 8);
    r = (Uint8)(color >> 16);
    
    if (r > 63 || g > 63 || b > 63) return -1;
    
    attribute &= 0xFF;
    
    return fb_GfxPaletteEx(attribute, (Uint8)(r * 255.0f / 63.0f + .5f),
                                      (Uint8)(g * 255.0f / 63.0f + .5f),
                                      (Uint8)(b * 255.0f / 63.0f + .5f) );
}

int fb_GfxPaletteEx (Uint8 attribute, Uint8 r, Uint8 g, Uint8 b)
{
    SDL_Color c;
    
    if (SANITY_CHECK_CONDITION) return -1;
    
    fb_GfxInfo.paletteChanged = 1;

    c.r = r;
    c.g = g;
    c.b = b;
    
    return (SDL_SetPalette(fb_GfxInfo.screen, SDL_LOGPAL, &c, attribute, 1) == 0);
}

FBCALL void fb_GfxPaletteUsing( int *src )
{
    Uint8 r, g, b;
    int i;
    
    for( i = 0; i < 256; i++ )
    	if( src[i] != -1 )
    		fb_GfxPalette( i, src[i] );
    
}

