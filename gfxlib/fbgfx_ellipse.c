/*
 *  Copyright (C) 2004 A. Schiffler
 *  (modified by Sterling Christensen, 2004)
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

/* ----- Ellipse */

/* Note: Based on algorithm from sge library with multiple-hline draw removal */
/* and other speedup changes. */

FBCALL int fb_GfxEllipseEx (Sint16 x, Sint16 y, Sint16 rx, Sint16 ry, Uint32 color)
{
    Sint16 left, right, top, bottom;
    int ix, iy;
    int h, i, j, k;
    int oh, oi, oj, ok;
    Uint8 *colorptr;

    /*
     * Sanity check radii
     */
    if ((rx <= 0) || (ry <= 0)) {

        /*
         * Special case for rx=0 or ry=0 - draw an h/vline
         */
        if (rx == 0 || ry == 0) {
            return fb_GfxFBoxEx(x - rx, y - ry, rx + rx, ry + ry, color);
        }

        /* If rx and ry are nonzero, and at least one of them is < 1, then at least one
           is negative, which is invalid: */
        return -1;
    }

    /*
     * Get clipping boundary
     */
    left   = clip_xmin;
    right  = clip_xmax;
    top    = clip_ymin;
    bottom = clip_ymax;

    /*
     * Test if bounding box of ellipse is visible
     */
    if ( ((x-rx<left)   && (x+rx<left))   ||
         ((x-rx>right)  && (x+rx>right))  ||
         ((y-ry<top)    && (y+ry<top))    ||
         ((y-ry>bottom) && (y+ry>bottom))
       )
    {
        return(0);
    }

    /*
     * Init vars
     */
    oh = oi = oj = ok = 0xFFFF;

    /* Lock surface */
    if (SDL_MUSTLOCK(fb_GfxInfo.screen)) {
        if (SDL_LockSurface(fb_GfxInfo.screen) < 0) {
            return -1;
        }
    }

    /*
     * Setup color
     */
    if (fb_GfxInfo.screen->format->BitsPerPixel > 8)
    {
        colorptr = (Uint8 *) & color;
        if (SDL_BYTEORDER == SDL_BIG_ENDIAN) {
            color = SDL_MapRGB(fb_GfxInfo.screen->format, colorptr[0], colorptr[1], colorptr[2]);
        } else {
            color = SDL_MapRGB(fb_GfxInfo.screen->format, colorptr[3], colorptr[2], colorptr[1]);
        }
    }
    else
    {
        color &= 0xFF;
    }

    /*
     * Draw
     */
    if (rx > ry) {
        ix = 0;
        iy = rx * 64;

        do {
            h = (ix + 32) >> 6;
            i = (iy + 32) >> 6;
            j = (h * ry) / rx;
            k = (i * ry) / rx;

            if (((ok != k) && (oj != k)) || ((oj != j) && (ok != j)) || (k != j)) {

                fb_GfxPsetNoLocking(x - h, y - k, color);
                fb_GfxPsetNoLocking(x + h, y - k, color);
                if (k)
                {
                    fb_GfxPsetNoLocking(x - h, y + k, color);
                    fb_GfxPsetNoLocking(x + h, y + k, color);
                }
                ok = k;

                fb_GfxPsetNoLocking(x - i, y - j, color);
                fb_GfxPsetNoLocking(x + i, y - j, color);
                if (j)
                {
                    fb_GfxPsetNoLocking(x - i, y + j, color);
                    fb_GfxPsetNoLocking(x + i, y + j, color);
                }
                oj = j;
            }

            ix = ix + iy / rx;
            iy = iy - ix / rx;

        } while (i > h);
    } else {
        ix = 0;
        iy = ry * 64;

        do {
            h = (ix + 32) >> 6;
            i = (iy + 32) >> 6;
            j = (h * rx) / ry;
            k = (i * rx) / ry;

            if (((oi != i) && (oh != i)) || ((oh != h) && (oi != h) && (i != h))) {

                fb_GfxPsetNoLocking(x - j, y - i, color);
                fb_GfxPsetNoLocking(x + j, y - i, color);
                if (i)
                {
                    fb_GfxPsetNoLocking(x - j, y + i, color);
                    fb_GfxPsetNoLocking(x + j, y + i, color);
                }
                oi = i;

                fb_GfxPsetNoLocking(x - k, y - h, color);
                fb_GfxPsetNoLocking(x + k, y - h, color);
                if (h)
                {
                    fb_GfxPsetNoLocking(x - k, y + h, color);
                    fb_GfxPsetNoLocking(x + k, y + h, color);
                }
                oh = h;
            }

            ix = ix + iy / ry;
            iy = iy - ix / ry;

        } while (i > h);
    }

    /* Unlock surface */
    if (SDL_MUSTLOCK(fb_GfxInfo.screen)) {
        SDL_UnlockSurface(fb_GfxInfo.screen);
    }

    return 0;
}

/* ---- Filled Ellipse */

/* Note: */
/* Based on algorithm from sge library with multiple-hline draw removal */
/* and other speedup changes. */

FBCALL int fb_GfxFEllipseEx (Sint16 x, Sint16 y, Sint16 rx, Sint16 ry, Uint32 color)
{
    Sint16 left, right, top, bottom;
    int result;
    int ix, iy;
    int h, i, j, k;
    int oh, oi, oj, ok;
//    int xmh, xph;
//    int xmi, xpi;
//    int xmj, xpj;
//    int xmk, xpk;

    /*
     * Sanity check radii
     */
    if ((rx < 0) || (ry < 0)) {
        return (-1);
    }

    /*
     * Special cases for rx=0 - draw a vline
     */
    if (rx == 0) {
        return fb_GfxFBoxEx(x, y - ry, 0, ry + ry, color);
    }
    /*
     * Special case for ry=0 - draw an hline
     */
    if (ry == 0) {
        return fb_GfxFBoxEx(x - rx, y, rx + rx, 0, color);
    }

    /*
     * Get clipping boundary
     */
    left   = clip_xmin;
    right  = clip_xmax;
    top    = clip_ymin;
    bottom = clip_ymax;

    /*
     * Test if bounding box of ellipse is visible
     */
    if ( ((x-rx<left)   && (x+rx<left))   ||
         ((x-rx>right)  && (x+rx>right))  ||
         ((y-ry<top)    && (y+ry<top))    ||
         ((y-ry>bottom) && (y+ry>bottom))
       )
    {
        return(0);
    }

    /*
     * Init vars
     */
    oh = oi = oj = ok = 0xFFFF;

    /*
     * Draw
     */
    result = 0;
    if (rx > ry) {
        ix = 0;
        iy = rx * 64;

        do {
            h = (ix + 32) >> 6;
            i = (iy + 32) >> 6;
            j = (h * ry) / rx;
            k = (i * ry) / rx;

            if ((ok != k) && (oj != k)) {
                result |= fb_GfxFBoxEx(x - h, y + k, h + h, 0, color);
                if (k > 0) result |= fb_GfxFBoxEx(x - h, y - k, h + h, 0, color);
                ok = k;
            }
            if ((oj != j) && (ok != j) && (k != j)) {
                result |= fb_GfxFBoxEx(x - i, y + j, i + i, 0, color);
                if (j > 0) result |= fb_GfxFBoxEx(x - i, y - j, i + i, 0, color);
                oj = j;
            }

            ix = ix + iy / rx;
            iy = iy - ix / rx;

        } while (i > h);
    } else {
        ix = 0;
        iy = ry * 64;

        do {
            h = (ix + 32) >> 6;
            i = (iy + 32) >> 6;
            j = (h * rx) / ry;
            k = (i * rx) / ry;

            if ((oi != i) && (oh != i)) {
                result |= fb_GfxFBoxEx(x - j, y + i, j + j, 0, color);
                if (i > 0) result |= fb_GfxFBoxEx(x - j, y - i, j + j, 0, color);
                oi = i;
            }
            if ((oh != h) && (oi != h) && (i != h)) {
                result |= fb_GfxFBoxEx(x - k, y + h, k + k, 0, color);
                if (h > 0) result |= fb_GfxFBoxEx(x - k, y - h, k + k, 0, color);
                oh = h;
            }

            ix = ix + iy / ry;
            iy = iy - ix / ry;

        } while (i > h);
    }

    return (result);
}

FBCALL int fb_GfxCircle (float x, float y, float radius, Uint32 color,
                            int fillFlag, int coordType)
{
    /* By default make it appear circular on the screen even if the pixels aren't
       square. This can be kinda nice, or harmless at the very least because you
       can always call GfxEllipse with aspect=1 if you want a pixel-perfect circle
       instead: */

    return fb_GfxEllipse(x, y, radius, color,
                         4 * ((float)fb_GfxInfo.screen->h / fb_GfxInfo.screen->w) / 3,
                         0, 3.141593*2,
                         fillFlag, coordType);
}

FBCALL int fb_GfxEllipse (float x, float y, float radius, Uint32 color,
                          float aspect, float arcini, float arcend,
                          int fillFlag, int coordType)
{
//    SDL_Color *c;
//    Uint8 r, g, b;
    Sint16 rx, ry, rradX, rradY;
    float radX, radY;

    SANITY_CHECK

    if (coordType != COORD_TYPE_A)
    {
        x = fb_GfxInfo.gfx_cursorX + x;
        y = fb_GfxInfo.gfx_cursorY + y;
    }

    fb_GfxInfo.gfx_cursorX = x;
    fb_GfxInfo.gfx_cursorY = y;
    fb_GfxTransCoord(x, y, &rx, &ry);
    if (color == DEFAULT_COLOR) color = fb_GfxInfo.defaultColor;

    /* This stuff exactly mimics QB style aspect correction, and I have no words
       for how weird/inconsistant it is and I can't believe how long it took me to
       figure out by trial and error: */

    /* Radius is interpretted as x-radius or y-radius depending
       on which would make a smaller circle. Why? */
    if( aspect == 0.0 )
    	aspect = 4.0 * ((float)fb_GfxInfo.screen->h / fb_GfxInfo.screen->w) / 3.0;

    if (aspect > 1.0)
    {
        radX = radius / aspect;
        radY = radius;
    }
    else
    {
        radY = radius * aspect;
        radX = radius;
    }

    if (fb_GfxInfo.winActive)
    {
        /* This seems to correct for any warping of the circle's height/width ratio
           caused by window->viewport mapping: */
        radY *= ((float)fb_GfxInfo.winH/fb_GfxInfo.winW) / ((float)fb_GfxInfo.view.h/fb_GfxInfo.view.w);

        radY = radY * (float)fb_GfxInfo.view.h / fb_GfxInfo.winH;
        radX = radX * (float)fb_GfxInfo.view.w / fb_GfxInfo.winW;
    }

    rradX = (Sint16)(radX + .5f);
    rradY = (Sint16)(radY + .5f);

    if (fillFlag)
        return fb_GfxFEllipseEx(rx, ry, rradX, rradY, color);
    else
        return fb_GfxEllipseEx(rx, ry, rradX, rradY, color);

    return 0;
}

