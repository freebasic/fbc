#ifndef QB_GFX_PAL_H_
#define QB_GFX_PAL_H_

#include <sdl/SDL.h>

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
FBCALL int fb_GfxPalette    (Uint32 attribute, Uint32 color);

/*  r, g, and b range from 0 to 255 */
FBCALL int fb_GfxPaletteEx  (Uint8 attribute, Uint8 r, Uint8 g, Uint8 b);

/* Emulates OUT &H3C7-9 and INP(&H3C9), other port are ignored */
FBCALL void fb_GfxOut       (Uint32 port, Uint8 data);
FBCALL Uint8 fb_GfxInp      (Uint32 port);

#endif
