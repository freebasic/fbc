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

/* Private function to move the cursor to the center in the viewport in window coordinates
   Does no error checking at all */
static void fb_GfxCenterCursor (void)
{
    if (fb_GfxInfo.winActive)
    {
        fb_GfxInfo.gfx_cursorX = fb_GfxInfo.winW / 2 + fb_GfxInfo.winX;
        fb_GfxInfo.gfx_cursorY = fb_GfxInfo.winH / 2 + fb_GfxInfo.winY;
    }
    else
    {
        fb_GfxInfo.gfx_cursorX = fb_GfxInfo.view.w >> 1 + fb_GfxInfo.view.x;
        fb_GfxInfo.gfx_cursorY = fb_GfxInfo.view.h >> 1 + fb_GfxInfo.view.y;
    }
}

FBCALL int fb_GfxView (int x1, int y1, int x2, int y2, Uint32 fillCol, Uint32 borderCol, int screenFlag)
{
    SDL_Color *c;
    SDL_Rect r;

    SANITY_CHECK

    /* Let's be a little more tolerant than QB (SDL_SetClipRect takes care of clipping boxs that go offscreen) */
    if (x2 < x1 || y2 < y1) return -1;

    if (x1 == -32768 && x2 == -32768 && y1 == -32768 && y2 == -32768)
    {
        r.x = 0; r.w = fb_GfxInfo.screen->w;
        r.y = 0; r.h = fb_GfxInfo.screen->h;
    }
    else
    {
        r.x = x1; r.w = x2 - x1 + 1;
        r.y = y1; r.h = y2 - y1 + 1;

        if (borderCol != DEFAULT_COLOR)
        {
            SDL_SetClipRect(fb_GfxInfo.screen, NULL);
            if (fb_GfxBoxEx(r.x-1, r.y-1, r.w+1, r.h+1, borderCol) != 0) return -1;
        }
    }

    SDL_SetClipRect(fb_GfxInfo.screen, &r);
    if (fillCol != DEFAULT_COLOR) fb_GfxCls(fillCol);

    if (screenFlag)
    {
        fb_GfxInfo.view.x = 0;
        fb_GfxInfo.view.y = 0;
        fb_GfxInfo.view.w = fb_GfxInfo.screen->w;
        fb_GfxInfo.view.h = fb_GfxInfo.screen->h;
    }
    else
    {
        fb_GfxInfo.view = r;
    }

    fb_GfxCenterCursor();

    return 0;
}

