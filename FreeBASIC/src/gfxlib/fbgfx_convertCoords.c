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
 *   Convert coords to absolute 
 *   Used by fb_GfxLine and fb_GfxGet
 */
FBCALL void fb_GfxConvertCoords(float *x1, float *y1, float *x2, float *y2, int coordType)
{
    switch (coordType)
    {
    case COORD_TYPE_AA:
/*
        x1 = x1;
        y1 = y1;
        x2 = x2;
        y2 = y2;
*/
        break;
    case COORD_TYPE_AR:
/*
        x1 = x1;
        y1 = y1;
*/
        *x2 = *x1 + *x2;
        *y2 = *y1 + *y2;
        break;
    case COORD_TYPE_RA:
        *x1 = fb_GfxInfo.gfx_cursorX + *x1;
        *y1 = fb_GfxInfo.gfx_cursorY + *y1;
/*
        x2 = x2;
        y2 = y2;
*/
        break;
    case COORD_TYPE_RR:
        *x1 = fb_GfxInfo.gfx_cursorX + *x1;
        *y1 = fb_GfxInfo.gfx_cursorY + *y1;
        *x2 = *x1 + *x2;
        *y2 = *y1 + *y2;
        break;
    case COORD_TYPE_A:  /* x1 and y1 are ignored */
        *x1 = fb_GfxInfo.gfx_cursorX;
        *y1 = fb_GfxInfo.gfx_cursorY;
/*
        x2 = x2;
        y2 = y2;
*/
        break;
    case COORD_TYPE_R:  /* x1 and y1 are ignored */
        *x1 = fb_GfxInfo.gfx_cursorX;
        *y1 = fb_GfxInfo.gfx_cursorY;
        *x2 = *x1 + *x2;
        *y2 = *y1 + *y2;
        break;
    }
}

