#ifndef QB_GFX_MAIN_H_
#define QB_GFX_MAIN_H_

#include <sdl/SDL.h>
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

/* Sets what type of events Inkey/InkeyEx removes from the queue
   Default is SDL_ALLEVENTS
   Takes an int in the same format as SDL_PeepEvents */
FBCALL void fb_GfxSetEventMask (int mask);

       FBSTRING* fb_GfxInkey(void);
       int fb_GfxInkeyEx    (void);

FBCALL int fb_GfxScreen     (int width, int height, int depth, int fullScreenFlag);

/* fb_GfxScreen & Ex set this up to be called automatically at program exit: */
          void fb_GfxQuit      (void);

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
