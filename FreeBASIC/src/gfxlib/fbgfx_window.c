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

FBCALL int fb_GfxWindow (float x1, float y1, float x2, float y2, int screenFlag)
{
    SANITY_CHECK -1;

    if (x1 != 0 || y1 != 0 || x2 != 0 || y2 != 0)
    {
        fb_GfxInfo.winActive = 1;
        fb_GfxInfo.winScreenFlag = screenFlag;

        if (x2 >= x1)
        {
            fb_GfxInfo.winX = x1;
            fb_GfxInfo.winW = x2-x1;
        }
        else
        {
            fb_GfxInfo.winX = x2;
            fb_GfxInfo.winW = x1-x2;
        }

        if (y2 >= y1)
        {
            fb_GfxInfo.winY = y1;
            fb_GfxInfo.winH = y2-y1;
        }
        else
        {
            fb_GfxInfo.winY = y2;
            fb_GfxInfo.winH = y1-y2;
        }
    }
    else
    {
        fb_GfxInfo.winActive = 0;
    }
    
    return 0;
}

