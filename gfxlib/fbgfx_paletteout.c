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

FBCALL void fb_GfxPaletteOut (int port, int data)
{
    SANITY_CHECK;
    
    data &= 0xFF;

    switch (port)
    {
    case 0x3C7:

        fb_GfxVgaPalEmu.readColor = data;
        fb_GfxVgaPalEmu.readIndex = 0;

        break;
    case 0x3C8:

        fb_GfxVgaPalEmu.writeColor = data;
        fb_GfxVgaPalEmu.writeIndex = 0;

        break;
    case 0x3C9:

        /* shifting right/left by 2 would make the display look slightly
           darker: (0 to 252) instead of (0 to 255), 63 << 2 = 252 */
        fb_GfxVgaPalEmu.rgbOut[fb_GfxVgaPalEmu.writeIndex++] = (Uint8)(data * (255.0f / 63.0f) + .5f);
        
        if (fb_GfxVgaPalEmu.writeIndex >= 3)
        {
            fb_GfxPaletteEx(fb_GfxVgaPalEmu.writeColor++, fb_GfxVgaPalEmu.rgbOut[0],
                                                          fb_GfxVgaPalEmu.rgbOut[1],
                                                          fb_GfxVgaPalEmu.rgbOut[2]);
            fb_GfxVgaPalEmu.writeIndex = 0;
        }
        
        break;
    }
}

