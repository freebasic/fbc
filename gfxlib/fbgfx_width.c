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

void fb_GfxWidth (int width, int height)
{
    int h;

    if (fb_GfxInfo.textCoords)
    {
        if (fb_GfxInfo.printAffectedByView) {
            h = fb_GfxInfo.view.h;
        } else {
            h = fb_GfxInfo.screen->h;
        }

        if ( (((h / height) + 4) >> 3) < 2)
        {
            fb_GfxSetFont(8, 8, (void*)fb_GfxDefaultFont8x8);
        }
        else
        {
            fb_GfxSetFont(8, 16, (void*)fb_GfxDefaultFont8x16);
        }
    }
    else
    {
        if (width != 8) return;

        switch (height)
        {
        case 8:
            fb_GfxSetFont(8, 8, (void*)fb_GfxDefaultFont8x8);
            break;
        case 16:
            fb_GfxSetFont(8, 16, (void*)fb_GfxDefaultFont8x16);
            break;
        default:
            return;
//            break;
        }
    }

}

