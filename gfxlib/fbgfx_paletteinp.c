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

static int fb_GfxInpEx (void)
{
    int ret;
    SDL_Color *c;
    
    if (SANITY_CHECK_CONDITION) return -1;
    
    if (fb_GfxInfo.screen->format->BytesPerPixel != 1) return 0;
    
    c = fb_GfxInfo.screen->format->palette->colors + fb_GfxVgaPalEmu.readColor;
    
    switch (fb_GfxVgaPalEmu.readIndex)
    {
    case 0:
        ret = c->r;
        break;
    case 1:
        ret = c->g;
        break;
    default:  /* could only be 2 */
        ret = c->b;
        break;
    }

    if (++fb_GfxVgaPalEmu.readIndex >= 3)
    {
        fb_GfxVgaPalEmu.readColor++;
        fb_GfxVgaPalEmu.readIndex = 0;
    }
    
    /* shifting right/left by 2 would make the display look slightly
       darker: (0 to 252) instead of (0 to 255), 63 << 2 = 252 */
    return (int)(ret * (63.0f / 255.0f) + .5f);  
}

FBCALL int fb_GfxPaletteInp (int port)
{
    if (port == 0x3C9) return fb_GfxInpEx();
    
    return 0;
}
