#ifndef QB_GFX_TEXT_H_
#define QB_GFX_TEXT_H_

#include <SDL/SDL.h>
#include "../rtlib/fb.h"

#ifndef FBGFX_NO_FONTDATA_EXTERN
extern const Uint8 fb_GfxDefaultFont8x8[2048];
extern const Uint8 fb_GfxDefaultFont8x16[4096];
#endif

/* If using text coordinates: width x height is the desired text resolution, width will
                              select the best match (either 8x8 or 8x16) for the
                              screen/view (depending on affectedByViewFlag)
                                 Examples: 41x3 in 320x200 selects the 8x16 font
                                           78x1000 in 640x480 selects the 8x8 font
                      if not: Sets the default font with character size width x height */
      void fb_GfxWidth      (int width, int height);

/* transBgFlag: -1=no change, 0=solid background, 1=transparent */
FBCALL int fb_GfxSetFontBg  (Uint32 bgColor, int transBgFlag);

FBCALL int fb_GfxSetFont    (Uint8 width, Uint8 height, void *fontData);
FBCALL int fb_GfxSetFormat  (int tabStopDistance, int affectedByViewFlag,
                                int letterWrapFlag, int scrollFlag, int locateTextCoords);

	   int fb_GfxCsrlin     (void);
	   int fb_GfxPos        (void);
      void fb_GfxLocate     (int xOrRow, int yOrColumn, int cursor);

FBCALL int fb_GfxScrollUp   (Sint16 x1, Sint16 y1, Sint16 x2, Sint16 y2,
                                Uint16 scrollAmount, Uint32 fillColor);

	  void fb_GfxPrintBuffer(char *str, int mask);

#endif
