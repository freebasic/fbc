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
#include "QB_gfx_text.h"

void fb_GfxLocate (int xOrRow, int yOrColumn, int cursor)
{
    int x, y, invalid;

    if (fb_GfxInfo.fontData != NULL && fb_GfxInfo.textCoords)
    {
        invalid = 0;
        x = (yOrColumn - 1) * fb_GfxInfo.charWidth;
        y = (xOrRow - 1) * fb_GfxInfo.charHeight;

        if (x < 0 || y < 0) invalid = 1;

        if (fb_GfxInfo.printAffectedByView)
        {
            if (x + fb_GfxInfo.charWidth > fb_GfxInfo.view.w ||
                y + fb_GfxInfo.charHeight > fb_GfxInfo.view.h) invalid = 1;
        }
        else
        {
            if (x + fb_GfxInfo.charWidth > fb_GfxInfo.screen->w ||
                y + fb_GfxInfo.charHeight > fb_GfxInfo.screen->h) invalid = 1;
        }

        if (invalid) return;
    }
    else
    {
        x = xOrRow;
        y = yOrColumn;
    }

    fb_GfxInfo.text_cursorX = x;
    fb_GfxInfo.text_cursorY = y;
}

