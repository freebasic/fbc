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

/* Equivalent to calling POINT with a single parameter in QB
   Gets info about current graphics cursor position:
       0 for viewport x
       1 for viewport y
       2 for window x
       3 for window y */
FBCALL float fb_GfxCursor (int number)
{
    switch (number)
    {
    case 0: /* viewport x */
        return fb_GfxPMap(fb_GfxInfo.gfx_cursorX, 0);
    case 1: /* viewport y */
        return fb_GfxPMap(fb_GfxInfo.gfx_cursorY, 1);
    case 2: /* window x */
        return fb_GfxInfo.gfx_cursorX;
    case 3: /* window y */
        return fb_GfxInfo.gfx_cursorY;
    //default:
        // <><><><><> error... <><><><><>
    }
    
    return -1.0f; // ????
}

