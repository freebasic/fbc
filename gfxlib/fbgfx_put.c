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

#include "QB_gfx_main.h"

FBCALL int fb_GfxPut( float x, float y, void *sourceAddress, int coordType, int mode )
{
    SDL_Surface *surface;
    SDL_Rect dst;
    int ret, depth, bytesPP, w, h;
    Uint32 colorKey;

    SANITY_CHECK

    if (coordType != COORD_TYPE_A)
    {
        x = fb_GfxInfo.gfx_cursorX + x;
        y = fb_GfxInfo.gfx_cursorY + y;
    }

    fb_GfxInfo.gfx_cursorX = x;
    fb_GfxInfo.gfx_cursorY = y;

    fb_GfxTransCoord(x, y, &dst.x, &dst.y);

    w = *((Sint16 *)sourceAddress);
    h = *((Sint16 *)sourceAddress + 1);

    depth = w & 7;
    switch (depth)
    {
    case 0:
        bytesPP = 1;
        depth = 8;
        break;
    case 1:
        bytesPP = 2;
        depth = 15;
        break;
    default:
        bytesPP = depth;
        depth <<= 3;
        break;
    }

    w >>= 3;

    surface = SDL_CreateRGBSurfaceFrom((void*)((Uint16*)sourceAddress + 2),
                                       w, h, depth, w * bytesPP,
                                       fb_GfxInfo.screen->format->Rmask,
                                       fb_GfxInfo.screen->format->Gmask,
                                       fb_GfxInfo.screen->format->Bmask,
                                       fb_GfxInfo.screen->format->Amask);

    if (depth == 8 && fb_GfxInfo.screen->format->BitsPerPixel == 8)
    {
        SDL_SetColors(surface, fb_GfxInfo.screen->format->palette->colors, 0, 256);
    }
    
    if( mode == FBGFX_PUTMODE_MASK )
    {
        if (depth > 8)
            colorKey = SDL_MapRGB(fb_GfxInfo.screen->format, 0xFF, 0x00, 0xFF );
        else
            /* Searching the palette for black is slow and unpredictable depending on the palette */
            /* colorKey = SDL_MapRGB(fb_GfxInfo.screen->format, 0x00, 0x00, 0x00 ); */
            colorKey = 0;

        SDL_SetColorKey(surface, SDL_SRCCOLORKEY, colorKey);
    }

    ret = SDL_BlitSurface(surface, NULL, fb_GfxInfo.screen, &dst);

    SDL_FreeSurface(surface);

    return ret;
}
