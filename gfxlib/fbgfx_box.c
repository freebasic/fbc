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

/*
 *  Used by fb_GfxLine and fb_GfxView
 */
FBCALL int fb_GfxBoxEx (Sint16 x1, Sint16 y1, Sint16 dx, Sint16 dy, Uint32 color)
{
    SDL_Rect r;
    Uint8 * colorptr;
    int ret = 0;

    if (dx < 0)
    {
        dx = -dx;
        x1 -= dx;
    }

    if (dy < 0)
    {
        dy = -dy;
        y1 -= dy;
    }

    if (dx < 2 || dy < 2)
    {
        return fb_GfxFBoxEx(x1, y1, dx, dy, color);
    }

    if (fb_GfxInfo.screen->format->BitsPerPixel > 8)
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
        color &= 255;
    }

    r.x = x1;       r.w = dx + 1;
    r.y = y1;       r.h = 1;
    ret |= SDL_FillRect(fb_GfxInfo.screen, &r, color);

    r.x = x1;       r.w = 1;
    r.y = y1 + 1;   r.h = dy - 1;
    ret |= SDL_FillRect(fb_GfxInfo.screen, &r, color);

    r.x = x1 + dx;  r.w = 1;
    r.y = y1 + 1;   r.h = dy - 1;
    ret |= SDL_FillRect(fb_GfxInfo.screen, &r, color);

    r.x = x1;       r.w = dx + 1;
    r.y = y1 + dy;  r.h = 1;
    ret |= SDL_FillRect(fb_GfxInfo.screen, &r, color);

    return ret;
}

/*
 *   Used by fb_GfxFEllipseEx
 */
FBCALL int fb_GfxFBoxEx (Sint16 x1, Sint16 y1, Sint16 dx, Sint16 dy, Uint32 color)
{
    SDL_Rect r;
    Uint8 * colorptr;

    if (dx < 0)
    {
        dx = -dx;
        x1 -= dx;
    }

    if (dy < 0)
    {
        dy = -dy;
        y1 -= dy;
    }

    if (fb_GfxInfo.screen->format->BitsPerPixel > 8)
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
        color &= 255;
    }

    r.x = x1; r.w = dx + 1;
    r.y = y1; r.h = dy + 1;
    return SDL_FillRect(fb_GfxInfo.screen, &r, color);
}

