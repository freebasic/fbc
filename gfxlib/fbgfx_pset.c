/*
 *  fb_GfxPset Copyright (C) 2004 Sterling Christensen (sterling@engineer.com)
 *
 *  fb_GfxPsetEx Copyright (C) 2004 A. Schiffler
 *  (modified by Sterling Christensen, 2005)
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

FBCALL int fb_GfxPsetEx (Sint16 x, Sint16 y, Uint32 color)
{
    int bpp;
    Uint8 *p, *colorptr;

    /*
     * Honor clipping setup at pixel level
     */
    if ((x < clip_xmin) || (x > clip_xmax) || (y < clip_ymin) || (y > clip_ymax))
    {
        return 0;
    }

    /*
     * Get destination format
     */
    bpp = fb_GfxInfo.screen->format->BytesPerPixel;
    p = (Uint8 *) fb_GfxInfo.screen->pixels + y * fb_GfxInfo.screen->pitch + x * bpp;

    /*
     * Lock the surface
     */
    if (SDL_MUSTLOCK(fb_GfxInfo.screen)) {
        if (SDL_LockSurface(fb_GfxInfo.screen) < 0) {
            return (-1);
        }
    }

    if (bpp == 1)
    {
        *p = color;
    }
    else
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

        switch (bpp) {
        case 2:
            *(Uint16 *) p = color;
            break;
        case 3:
            if (SDL_BYTEORDER == SDL_BIG_ENDIAN) {
                p[0] = (Uint8)(color >> 16);
                p[1] = (Uint8)(color >> 8);
                p[2] = (Uint8)color;
            } else {
                p[0] = (Uint8)color;
                p[1] = (Uint8)(color >> 8);
                p[2] = (Uint8)(color >> 16);
            }
            break;
        case 4:
            *(Uint32 *) p = color;
            break;
        }              /* switch */
    }              /* if (bpp == 1) */

    /*
     * Unlock surface
     */
    if (SDL_MUSTLOCK(fb_GfxInfo.screen)) {
        SDL_UnlockSurface(fb_GfxInfo.screen);
    }

    return 0;
}

FBCALL int fb_GfxPset (float x, float y, Uint32 color, int coordType)
{
    SDL_Color *c;
    Sint16 rx, ry;

    SANITY_CHECK

    if (color == DEFAULT_COLOR) color = fb_GfxInfo.defaultColor;

    if (coordType != COORD_TYPE_A)
    {
        x = fb_GfxInfo.gfx_cursorX + x;
        y = fb_GfxInfo.gfx_cursorY + y;
    }

    fb_GfxInfo.gfx_cursorX = x;
    fb_GfxInfo.gfx_cursorY = y;

    fb_GfxTransCoord(x, y, &rx, &ry);

    return fb_GfxPsetEx(rx, ry, color);
}

