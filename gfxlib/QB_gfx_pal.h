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

void fb_GfxFlushPalette (void);

/* color = b * 0x10000 + g * 0x100 + r
   r, g, and b range from 0 to 63
   pass 0xFFFFFFFF to both for default palette */
FBCALL int 		fb_GfxPalette    	( Uint32 attribute, Uint32 color );
FBCALL void		fb_GfxPaletteUsing	( int *src );

/* Emulates OUT &H3C7-9 and INP(&H3C9), other port are ignored */
FBCALL void 	fb_GfxPaletteOut    ( int port, int data );
FBCALL int 		fb_GfxPaletteInp    ( int port );

#endif
