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
#include "QB_gfx_pal.h"

int fb_GfxPaletteEx (Uint8 attribute, Uint8 r, Uint8 g, Uint8 b)
{
    SDL_Color c;
    
    SANITY_CHECK -1;
    
    fb_GfxInfo.paletteChanged = 1;

    c.r = r;
    c.g = g;
    c.b = b;
    
    return (SDL_SetPalette(fb_GfxInfo.screen, SDL_LOGPAL, &c, attribute, 1) == 0);
}

