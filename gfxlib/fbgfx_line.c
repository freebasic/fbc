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

FBCALL int fb_GfxSLineEx (Sint16 x, Sint16 y, Sint16 x2, Sint16 y2, Uint32 color, unsigned int style)
{
    int i, sx, sy, dx, dy, e;
    Uint8 *colorptr;
    Uint16 mask;

    dx = x2 - x;
    dy = y2 - y;

    sx = (dx > 0) ? 1 : -1;
    sy = (dy > 0) ? 1 : -1;

    if (dx < 0) dx = -dx;
    if (dy < 0) dy = -dy;

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
        color &= 0xFF;
    }

    /* Lock surface */
    if (SDL_MUSTLOCK(fb_GfxInfo.screen)) {
        if (SDL_LockSurface(fb_GfxInfo.screen) < 0) {
            return (-1);
        }
    }

    mask = 0x8000;

    if(dy > dx)
    {
        e = dx + dx - dy;

        for(i = 0; i < dy; i++)
        {
            if (style & mask) fb_GfxPsetNoLocking(x, y, color);

            /* Portable but slower equivalent to roll-right: */
            mask >>= 1;
            if (!mask) mask = 0x8000;

            while(e >= 0)
            {
                x += sx;
                e -= dy + dy;
            }

            y += sy;
            e += dx + dx;
        }
    }
    else
    {
        e = dy + dy - dx;

        for(i = 0; i < dx; i++)
        {
            if (style & mask) fb_GfxPsetNoLocking(x, y, color);

            /* Portable but slower equivalent to roll-right: */
            mask >>= 1;
            if (!mask) mask = 0x8000;

            while(e >= 0)
            {
                y += sy;
                e -= dx + dx;
            }

            x += sx;
            e += dy + dy;
        }
    }

    if (style & mask) fb_GfxPsetNoLocking(x2, y2, color);

    /*
     * Unlock surface
     */
    if (SDL_MUSTLOCK(fb_GfxInfo.screen)) {
        SDL_UnlockSurface(fb_GfxInfo.screen);
    }

    return 0;
}

/* --------- Clipping routines for line */

/* Clipping based heavily on code from                       */
/* http://www.ncsa.uiuc.edu/Vis/Graphics/src/clipCohSuth.c   */

#define CLIP_LEFT_EDGE   0x1
#define CLIP_RIGHT_EDGE  0x2
#define CLIP_BOTTOM_EDGE 0x4
#define CLIP_TOP_EDGE    0x8
#define CLIP_INSIDE(a)   (!a)
#define CLIP_REJECT(a,b) (a&b)
#define CLIP_ACCEPT(a,b) (!(a|b))

static int fb_GfxClipLine(Sint16 * x1, Sint16 * y1, Sint16 * x2, Sint16 * y2)
{
    Sint16 left, right, top, bottom;
    int code1, code2;
    int draw = 0;
    Sint16 swaptmp;
    float m;

    /*
     * Get clipping boundary
     */
    left   = clip_xmin;
    right  = clip_xmax;
    top    = clip_ymin;
    bottom = clip_ymax;

    while (1) {

        code1 = code2 = 0;

        if (*x1 < left) {
            code1 += CLIP_LEFT_EDGE;
        } else if (*x1 > right) {
            code1 += CLIP_RIGHT_EDGE;
        }
        if (*y1 < top) {
            code1 += CLIP_TOP_EDGE;
        } else if (*y1 > bottom) {
            code1 += CLIP_BOTTOM_EDGE;
        }

        if (*x2 < left) {
            code2 += CLIP_LEFT_EDGE;
        } else if (*x2 > right) {
            code2 += CLIP_RIGHT_EDGE;
        }
        if (*y2 < top) {
            code2 += CLIP_TOP_EDGE;
        } else if (*y2 > bottom) {
            code2 += CLIP_BOTTOM_EDGE;
        }

        if (CLIP_ACCEPT(code1, code2)) {
            draw = 1;
            break;
        } else if (CLIP_REJECT(code1, code2))
            break;
        else {
            if (CLIP_INSIDE(code1)) {
                swaptmp = *x2;
                *x2 = *x1;
                *x1 = swaptmp;
                swaptmp = *y2;
                *y2 = *y1;
                *y1 = swaptmp;
                swaptmp = code2;
                code2 = code1;
                code1 = swaptmp;
            }
            if (*x2 != *x1) {
                m = (*y2 - *y1) / (float) (*x2 - *x1);
            } else {
                m = 1.0f;
            }
            if (code1 & CLIP_LEFT_EDGE) {
                *y1 += (Sint16) ((left - *x1) * m);
                *x1 = left;
            } else if (code1 & CLIP_RIGHT_EDGE) {
                *y1 += (Sint16) ((right - *x1) * m);
                *x1 = right;
            } else if (code1 & CLIP_BOTTOM_EDGE) {
                if (*x2 != *x1) {
                    *x1 += (Sint16) ((bottom - *y1) / m);
                }
                *y1 = bottom;
            } else if (code1 & CLIP_TOP_EDGE) {
                if (*x2 != *x1) {
                    *x1 += (Sint16) ((top - *y1) / m);
                }
                *y1 = top;
            }
        }
    }

    return draw;
}

/* ----- Line */

/* Non-alpha line drawing code adapted from routine          */
/* by Pete Shinners, pete@shinners.org                       */
/* Originally from pygame, http://pygame.seul.org            */

FBCALL int fb_GfxLineEx(Sint16 x1, Sint16 y1, Sint16 x2, Sint16 y2, Uint32 color)
{
    int pixx, pixy;
    int x, y;
    int dx, dy;
    int ax, ay;
    int sx, sy;
    int swaptmp;
    Uint8 *pixel;
    Uint8 *colorptr;

    /*
     * Clip line and test if we have to draw
     */
    if (!(fb_GfxClipLine(&x1, &y1, &x2, &y2))) {
        return (0);
    }

    /*
     * Variable setup
     */
    dx = x2 - x1;
    dy = y2 - y1;
    sx = (dx >= 0) ? 1 : -1;
    sy = (dy >= 0) ? 1 : -1;

    /*
     * Test for special cases of straight lines or single point
     */
    if (dy == 0 || dx == 0) {
        return fb_GfxFBoxEx(x1, y1, dx, dy, color);
    }

    /* Lock surface */
    if (SDL_MUSTLOCK(fb_GfxInfo.screen)) {
        if (SDL_LockSurface(fb_GfxInfo.screen) < 0) {
            return (-1);
        }
    }

    /*
     * Setup color
     */
    if (fb_GfxInfo.screen->format->BytesPerPixel > 1)
    {
        colorptr = (Uint8 *) & color;
        if (SDL_BYTEORDER == SDL_BIG_ENDIAN) {
            color = SDL_MapRGB(fb_GfxInfo.screen->format, colorptr[0], colorptr[1], colorptr[2]);
        } else {
            color = SDL_MapRGB(fb_GfxInfo.screen->format, colorptr[3], colorptr[2], colorptr[1]);
        }
    }

    /*
     * More variable setup
     */
    dx = sx * dx + 1;
    dy = sy * dy + 1;
    pixx = fb_GfxInfo.screen->format->BytesPerPixel;
    pixy = fb_GfxInfo.screen->pitch;
    pixel = ((Uint8 *) fb_GfxInfo.screen->pixels) + pixx * (int) x1 + pixy * (int) y1;
    pixx *= sx;
    pixy *= sy;
    if (dx < dy) {
        swaptmp = dx;
        dx = dy;
        dy = swaptmp;
        swaptmp = pixx;
        pixx = pixy;
        pixy = swaptmp;
    }

	/*
	 * Draw
	 */
	x = 0;
	y = 0;
	switch (fb_GfxInfo.screen->format->BytesPerPixel)
    {
    case 1:
        for (; x < dx; x++, pixel += pixx) {
            *pixel = color;
            y += dy;
            if (y >= dx) {
                y -= dx;
                pixel += pixy;
            }
        }
        break;
    case 2:
        for (; x < dx; x++, pixel += pixx) {
            *(Uint16 *) pixel = color;
            y += dy;
            if (y >= dx) {
                y -= dx;
                pixel += pixy;
            }
        }
        break;
    case 3:
        for (; x < dx; x++, pixel += pixx) {
            if (SDL_BYTEORDER == SDL_BIG_ENDIAN) {
                pixel[0] = (Uint8)(color >> 16);
                pixel[1] = (Uint8)(color >> 8);
                pixel[2] = (Uint8)color;
            } else {
                pixel[0] = (Uint8)color;
                pixel[1] = (Uint8)(color >> 8);
                pixel[2] = (Uint8)(color >> 16);
            }
            y += dy;
            if (y >= dx) {
                y -= dx;
                pixel += pixy;
            }
        }
        break;
    default:        /* case 4 */
        for (; x < dx; x++, pixel += pixx) {
            *(Uint32 *) pixel = color;
            y += dy;
            if (y >= dx) {
                y -= dx;
                pixel += pixy;
            }
        }
        break;
    }

    /* Unlock surface */
    if (SDL_MUSTLOCK(fb_GfxInfo.screen)) {
        SDL_UnlockSurface(fb_GfxInfo.screen);
    }

    return (0);
}

FBCALL int fb_GfxLine (float x1, float y1, float x2, float y2, Uint32 color, int type, unsigned int style, int coordType)
{
    SDL_Color *c;
    Sint16 rx1, ry1, rx2, ry2;

    SANITY_CHECK

    fb_GfxConvertCoords(&x1, &y1, &x2, &y2, coordType);

    if (color == DEFAULT_COLOR) color = fb_GfxInfo.defaultColor;
    fb_GfxInfo.gfx_cursorX = x2;
    fb_GfxInfo.gfx_cursorY = y2;

    fb_GfxTransCoord(x1, y1, &rx1, &ry1);
    fb_GfxTransCoord(x2, y2, &rx2, &ry2);

    switch (type)
    {
    case LINE_TYPE_BF:
        return fb_GfxFBoxEx(rx1, ry1, rx2 - rx1, ry2 - ry1, color);
    case LINE_TYPE_B:
        return fb_GfxBoxEx(rx1, ry1, rx2 - rx1, ry2 - ry1, color);
    default: /* LINE_TYPE_LINE */
        if ((style & 0x0000FFFF) == 0xFFFF) {
            return fb_GfxLineEx(rx1, ry1, rx2, ry2, color);
        } else {
            return fb_GfxSLineEx(rx1, ry1, rx2, ry2, color, style & 0x0000FFFF);
        }
    }
}

