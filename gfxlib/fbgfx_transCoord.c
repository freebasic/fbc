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
 *   Translates window coordinates to screen (not view) coordinates
 *   Used by everything (pset, circle, etc) that takes window coordinates
 */
FBCALL void fb_GfxTransCoord (float x, float y, Sint16 *rx, Sint16 *ry)
{
    if (fb_GfxInfo.winActive)
    {
        x = (x - fb_GfxInfo.winX) * (fb_GfxInfo.view.w-1) / fb_GfxInfo.winW;
        y = (y - fb_GfxInfo.winY) * (fb_GfxInfo.view.h-1) / fb_GfxInfo.winH;
    }

    *rx = (Sint16)(x + .5f) + fb_GfxInfo.view.x;

    if (fb_GfxInfo.winActive == 0 || fb_GfxInfo.winScreenFlag)
    {
        *ry = (Sint16)(y + .5f) + fb_GfxInfo.view.y;
    }
    else
    {
        *ry = (fb_GfxInfo.view.y + fb_GfxInfo.view.h - 1) - (Sint16)(y + .5f);
    }
}

