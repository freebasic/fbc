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

FBCALL int fb_GfxPalette (Uint32 attribute, Uint32 color)
{
    Uint8 r, g, b;

    SANITY_CHECK -1;
    
    if( attribute == 0xFFFFFFFF )
    {
        fb_GfxInfo.paletteChanged = 1;

        /* casting to SDL_Color* kills a warning */
        return (SDL_SetPalette(fb_GfxInfo.screen, SDL_LOGPAL, (SDL_Color*)fb_GfxDefaultPal, 0, 256) == 0);
    }

    if (color > 0xFFFFFF || attribute > 255) return -1;
    
    b = (Uint8)(color);
    g = (Uint8)(color >> 8);
    r = (Uint8)(color >> 16);
    
    if (r > 63 || g > 63 || b > 63) return -1;
    
    attribute &= 0xFF;
    
    return fb_GfxPaletteEx(attribute, (Uint8)(r * 255.0f / 63.0f + .5f),
                                      (Uint8)(g * 255.0f / 63.0f + .5f),
                                      (Uint8)(b * 255.0f / 63.0f + .5f) );
}

FBCALL void fb_GfxPaletteUsing( int *src )
{
    int i;
    
    for( i = 0; i < 256; i++ )
    	if( src[i] != -1 )
    		fb_GfxPalette( i, src[i] );
    
}

