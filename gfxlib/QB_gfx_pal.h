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

#ifndef QB_GFX_PAL_H_
#define QB_GFX_PAL_H_

#include <SDL/SDL.h>

struct fb_GfxVgaPalEmuStruct
{
    Uint8          readColor;
    Uint8          writeColor;
    Uint8          readIndex;
    Uint8          writeIndex;
    Uint8          rgbOut[3];
};

#ifndef FBGFX_NO_PALEMU_EXTERN
extern struct fb_GfxVgaPalEmuStruct fb_GfxVgaPalEmu;
extern const SDL_Color fb_GfxDefaultPal[256];
#endif

       void     fb_GfxFlushPalette   ( void );

/* color = b * 0x10000 + g * 0x100 + r
   r, g, and b range from 0 to 63
   pass 0xFFFFFFFF to both for default palette */
FBCALL int 		fb_GfxPalette    	 ( Uint32 attribute, Uint32 color );
FBCALL void		fb_GfxPaletteUsing	 ( int *src );

       void     fb_GfxResetVgaPalEmu ( void );

/* Emulates OUT &H3C7-9 and INP(&H3C9), other port are ignored */
FBCALL void 	fb_GfxPaletteOut     ( int port, int data );
FBCALL int 		fb_GfxPaletteInp     ( int port );

#endif
