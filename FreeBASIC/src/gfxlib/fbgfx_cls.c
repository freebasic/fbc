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

void fb_GfxCls (int color)
{
    Uint8 *colorptr;

    SANITY_CHECK;

    fb_GfxInfo.text_cursorX = 0;
    fb_GfxInfo.text_cursorY = 0;

    if (fb_GfxInfo.screen->format->BitsPerPixel > 8)
    {
        if (color != DEFAULT_COLOR)
        {
            /* Convert 0xRRGGBBAA to screen pixel format: */
            colorptr = (Uint8 *) & color;
            if (SDL_BYTEORDER == SDL_BIG_ENDIAN)
            {
                color = SDL_MapRGB(fb_GfxInfo.screen->format, colorptr[0], colorptr[1], colorptr[2]);
            }
            else
            {
                color = SDL_MapRGB(fb_GfxInfo.screen->format, colorptr[3], colorptr[2], colorptr[1]);
            }
        }
        else
        {
            color = SDL_MapRGB(fb_GfxInfo.screen->format, 0, 0, 0);
        }
    }
    else
    {
        if (color == DEFAULT_COLOR) color = 0;
        color &= 0xFF;
    }

    SDL_FillRect(fb_GfxInfo.screen, NULL, color);
}

