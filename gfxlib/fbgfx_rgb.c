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

FBCALL Uint32 fb_GfxRgb (Uint8 r, Uint8 g, Uint8 b)
{
    if (SANITY_CHECK_CONDITION || fb_GfxInfo.screen->format->BitsPerPixel > 8)
    {
        return (r << 24) + (g << 16) + (b << 8) + 0xFF;
    }
    else
    {
        return SDL_MapRGB(fb_GfxInfo.screen->format, r, g, b);
    }
}

