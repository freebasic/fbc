/*
 *  Copyright (C) 2004 A. Schiffler
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

/*
 *   Used by fb_GfxFEllipseEx and fb_GfxSLineEx
 *   No 0xRRGGBBAA->native format conversion, no locking
 */
FBCALL int fb_GfxPsetNoLocking (Sint16 x, Sint16 y, Uint32 color)
{
    int bpp;
    Uint8 *p;

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

    switch (bpp) {
    case 1:
        *p = color;
        break;
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

    return 0;
}

