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

#ifndef QB_GFX_MAIN_H
#define QB_GFX_MAIN_H

#include <SDL/SDL.h>
#include "../rtlib/fb.h"
#include "../rtlib/fb_rterr.h"

#define LINE_TYPE_LINE  0
#define LINE_TYPE_B     1
#define LINE_TYPE_BF    2

#define COORD_TYPE_AA   0
#define COORD_TYPE_AR   1
#define COORD_TYPE_RA   2
#define COORD_TYPE_RR   3
#define COORD_TYPE_A    4
#define COORD_TYPE_R    5

#define DEFAULT_COLOR   0xFFFF0000

#define FBGFX_PUTMODE_MASK  0
#define FBGFX_PUTMODE_SOLID 1

#define FBGFX_WINDOWTITLE "FB"

struct fb_GfxInfoStruct
{
    Uint8        * fontData;
    Uint32         fontBGColor;
    int            text_cursorX;
    int            text_cursorY;
    Uint8          charWidth;
    Uint8          charHeight;

    Uint16         tabDist;

    /* These events will be taken off the queue by Inkey/InkeyEx */
    int            eventMask;

    float          gfx_cursorX;
    float          gfx_cursorY;

    Uint32         defaultColor;

    SDL_Surface  * screen;

    SDL_Rect       view;  /* Set by VIEW command */

    /* Set by WINDOW command */
    float          winX;
    float          winY;
    float          winW;
    float          winH;

    FB_INKEYPROC   oldInkeyHandler;
    FB_GETKEYPROC  oldGetkeyHandler;
    FB_CLSPROC     oldClsHandler;
    FB_COLORPROC   oldColorHandler;
    FB_LOCATEPROC  oldLocateHandler;
    FB_WIDTHPROC   oldWidthHandler;
    FB_GETXPROC    oldGetXHandler;
    FB_GETYPROC    oldGetYHandler;
    FB_PRINTBUFFPROC oldPrintHandler;

    /* boolean: */
    char           winActive;      /* Logical coordinate system active */

    char           winScreenFlag;  /* 0 = cartesian (winX1, winY1) is lower left,
                                      nonzero means (winX1, winY1) is upper left */

    char           sdlIsInitialized;
    char           videoIsInitialized;
    char           paletteChanged;
    char           fontBgTransparent;
    char           printAffectedByView;
    char           letterWrap;
    char           printScrolls;
    char           textCoords;
};

#ifndef FBGFX_NO_GFXINFO_EXTERN
extern struct fb_GfxInfoStruct fb_GfxInfo;
#endif

#define SANITY_CHECK_CONDITION   (!fb_GfxInfo.sdlIsInitialized || !fb_GfxInfo.screen || !fb_GfxInfo.videoIsInitialized)
#define SANITY_CHECK   			 if (SANITY_CHECK_CONDITION) return

/* ----- Defines for pixel clipping tests */
#define clip_xmin fb_GfxInfo.screen->clip_rect.x
#define clip_xmax fb_GfxInfo.screen->clip_rect.x + fb_GfxInfo.screen->clip_rect.w-1
#define clip_ymin fb_GfxInfo.screen->clip_rect.y
#define clip_ymax fb_GfxInfo.screen->clip_rect.y + fb_GfxInfo.screen->clip_rect.h-1

/* Sets what type of events Inkey/InkeyEx removes from the queue
   Default is SDL_ALLEVENTS
   Takes an int in the same format as SDL_PeepEvents */
FBCALL void fb_GfxSetEventMask (int mask);

       FBSTRING* fb_GfxInkey(void);
       int fb_GfxInkeyEx    (void);

FBCALL void fb_GfxTransCoord (float x, float y, Sint16 *rx, Sint16 *ry);
FBCALL void fb_GfxConvertCoords (float *x1, float *y1, float *x2, float *y2, int coordType);

FBCALL int fb_GfxScreen (int width, int height, int depth, int fullScreenFlag);

/* -32768 in each for full screen */
FBCALL int fb_GfxView       (int x1, int y1, int x2, int y2,
                             Uint32 fillCol, Uint32 borderCol, int screenFlag);

/* Pass all zeros for coordinates to disable logical coordinate system */
FBCALL int fb_GfxWindow     (float x1, float y1, float x2, float y2, int screenFlag);

FBCALL int fb_GfxFlip       (int frompage, int topage);

FBCALL Uint32 fb_GfxRgb     (Uint8 r, Uint8 g, Uint8 b);
	   void fb_GfxColor      (int fc, int bc);

	   void fb_GfxCls       (int color);

FBCALL int fb_GfxPset       (float x, float y, Uint32 color, int coordType);
FBCALL int fb_GfxPsetEx     (Sint16 x, Sint16 y, Uint32 color);
FBCALL int fb_GfxPsetNoLocking (Sint16 x, Sint16 y, Uint32 color);

/* Returns -1 for out of bounds in 8 bit modes (like QB), DEFAULT_COLOR in other modes
   because -1 (0xFFFFFFFF) is opaque bright white in un-paletted modes (0xRRGGBBAA) */
FBCALL Uint32 fb_GfxPoint   (float x, float y);

/* Equivalent to calling POINT with a single parameter in QB
   Gets info about current graphics cursor position:
       0 for viewport x
       1 for viewport y
       2 for window x
       3 for window y */
FBCALL float fb_GfxCursor   (int number);

/* 0: window x coord to view x coord
   1: window y coord to view y coord
   2: view x coord to window x coord
   3: view y coord to window y coord */
FBCALL float fb_GfxPMap     (float coord, int num);

FBCALL int fb_GfxLine       (float x1, float y1, float x2, float y2, Uint32 color, int type, unsigned int style, int coordType);
FBCALL int fb_GfxLineEx     (Sint16 x1, Sint16 y1, Sint16 x2, Sint16 y2, Uint32 color);
FBCALL int fb_GfxSLineEx    (Sint16 x1, Sint16 y1, Sint16 x2, Sint16 y2, Uint32 color, unsigned int style);
FBCALL int fb_GfxBoxEx      (Sint16 x1, Sint16 y1, Sint16 dx, Sint16 dy, Uint32 color);
FBCALL int fb_GfxFBoxEx     (Sint16 x1, Sint16 y1, Sint16 dx, Sint16 dy, Uint32 color);

FBCALL int fb_GfxCircle     (float x, float y, float radius, Uint32 color,
                             int fillFlag, int coordType);
FBCALL int fb_GfxEllipse    (float x, float y, float radius, Uint32 color,
                             float aspect, float arcini, float arcend,
                             int fillFlag, int coordType);
FBCALL int fb_GfxEllipseEx  (Sint16 x, Sint16 y, Sint16 rx, Sint16 ry, Uint32 color);
FBCALL int fb_GfxFEllipseEx (Sint16 x, Sint16 y, Sint16 rx, Sint16 ry, Uint32 color);

FBCALL int fb_GfxGet        (float x1, float y1, float x2, float y2, void *elementAddress, int coordType, FBARRAY *desc);

FBCALL int fb_GfxPut        (float x, float y, void *sourceAddress, int coordType, int mode);

#endif
