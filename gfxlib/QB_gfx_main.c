/*
 *  The following routines are based on code from the SDL_gfx library,
 *  which is licensed under the LGPL and Copyrighted (C) by A. Schiffler:
 *      fb_GfxFEllipseEx, fb_GfxEllipseEx, fb_GfxClipLine, fb_GfxLineEx,
 *      fb_GfxPset, fb_GfxPoint
 *
 *  fb_GfxInkey and fb_GfxInkeyEx are modified versions of code written
 *  and Copyrighted (C) 2004 by Marzec
 *
 *  All other code Copyright (C) 2004 Sterling Christensen
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

/*
    ToDo: Inkey repeat rate?
          throw errors
          document all default values
          fb inkey handler returns pointer to old handler, right?
          arg! why does ellipse from SDL_gfx leave gaps?
          Make numlock work, numpad + should return "+", etc
*/

#include "QB_gfx_main.h"
#include "QB_gfx_text.h"
#include "QB_gfx_pal.h"

static void fb_GfxQuit      			(void);
static int 	fb_GfxScreenEx   			(int width, int height, int depth, int fullscreenFlag);
static void fb_GfxRestoreHandlers 		(void);
static void fb_GfxTakeHandlers 			(void);
static int 	fb_GfxPutKey     			(float x, float y, void *sourceAddress, int coordType);
static int 	fb_GfxGetEx      			(Sint16 x, Sint16 y, Uint16 w, Uint16 h, void *dst);


#define DEFAULT_DEPTH 8

/*#define DEFAULT_FLAGS (int)(SDL_HWSURFACE | SDL_HWPALETTE | SDL_DOUBLEBUF | SDL_FULLSCREEN)*/
/*#define DEFAULT_FLAGS (int)(SDL_HWSURFACE | SDL_HWPALETTE | SDL_FULLSCREEN)*/
/*#define DEFAULT_FLAGS (int)(SDL_HWSURFACE | SDL_HWPALETTE | SDL_DOUBLEBUF)*/
#define DEFAULT_FLAGS (int)(SDL_HWSURFACE | SDL_HWPALETTE)

#define SANITY_CHECK_CONDITION   (!fb_GfxInfo.sdlIsInitialized || !fb_GfxInfo.screen || !fb_GfxInfo.videoIsInitialized)
#define SANITY_CHECK   			 if (SANITY_CHECK_CONDITION) return ;

/* ----- Defines for pixel clipping tests */
#define clip_xmin fb_GfxInfo.screen->clip_rect.x
#define clip_xmax fb_GfxInfo.screen->clip_rect.x + fb_GfxInfo.screen->clip_rect.w-1
#define clip_ymin fb_GfxInfo.screen->clip_rect.y
#define clip_ymax fb_GfxInfo.screen->clip_rect.y + fb_GfxInfo.screen->clip_rect.h-1

extern const SDL_Color fb_GfxDefaultPal[256];
extern const Uint8 fb_GfxDefaultFont8x8[2048];
extern const Uint8 fb_GfxDefaultFont8x16[4096];
extern struct fb_GfxVgaPalEmuStruct fb_GfxVgaPalEmu;

//--------------------------------
//  Private data
//--------------------------------

//struct fb_GfxVgaPalEmuStruct fb_GfxVgaPalEmu = {0, 0, 0, 0, {0, 0, 0}};
struct fb_GfxInfoStruct fb_GfxInfo = { 0 };


/*:::::*/
static void fb_GfxSetDefaultInfo( void )
{

	if( (fb_GfxInfo.sdlIsInitialized != 0) || (fb_GfxInfo.screen != NULL) )
		return;

	memset( &fb_GfxInfo, 0, sizeof( fb_GfxInfo ) );

	fb_GfxInfo.eventMask = SDL_ALLEVENTS;
	fb_GfxInfo.fontBgTransparent = 1;

}


/* Sets what type of events Inkey/InkeyEx removes from the queue
   Default is SDL_ALLEVENTS
   Takes an int in the same format as SDL_PeepEvents */
FBCALL void fb_GfxSetEventMask (int mask)
{
    fb_GfxInfo.eventMask = mask;
}

FBCALL void fb_GfxResetVgaPalEmu (void)
{
    fb_GfxVgaPalEmu.readColor = 0;
    fb_GfxVgaPalEmu.writeColor = 0;
    fb_GfxVgaPalEmu.readIndex = 0;
    fb_GfxVgaPalEmu.writeIndex = 0;
}

/*------------------------------------------------------------------------------
    fb_GfxInkey()
    desc: returns the first key within the keyqueue or "" if no key is in there
------------------------------------------------------------------------------*/
FBSTRING* fb_GfxInkey (void)
{
	FBSTRING *ret;
    int ikey;

    ikey = fb_GfxInkeyEx();

    if (ikey == 0) return &fb_strNullDesc;

    if ((ikey & 0xFF00) != 0xFF00) return fb_CHR(ikey);

    if (ikey == -1)
    {
        ret = (FBSTRING *)fb_hStrAllocTmpDesc();
        fb_hStrAllocTemp(ret, 4);
        ret->data[0] = 'Q';
        ret->data[1] = 'U';
        ret->data[2] = 'I';
        ret->data[3] = 'T';
        ret->data[4] = '\0';
        return ret;
    }

//    if ((ikey & 0xFF00) == 0xFF00)
//    {
//        return fb_MKI(0xFF + ((unsigned char)ikey << 8));
        ret = (FBSTRING *)fb_hStrAllocTmpDesc();
        fb_hStrAllocTemp(ret, 2);
        ret->data[0] = 0xFF;
        ret->data[1] = (char)ikey;
        ret->data[2] = '\0';
        return ret;
//    }

}

int fb_GfxInkeyEx(void)
{
    int n;
    SDL_Event event;

    SDL_PumpEvents();

    do
    {
        n = SDL_PeepEvents(&event, 1, SDL_GETEVENT, fb_GfxInfo.eventMask);
        if (n < 1) return 0;

        if (event.key.type == SDL_QUIT) return -1;
    }
    while (event.key.type != SDL_KEYDOWN);

    n = event.key.keysym.sym;

    if ( (!(event.key.keysym.mod & KMOD_CAPS) + !(event.key.keysym.mod & KMOD_SHIFT) == 1) &&
         (n >= 'a' && n <= 'z')
       )
    {
        return n - 32;
    }

    /* A lookup table might actually be smaller than the opcodes generated by
       this (and possibly faster too): */
    if (event.key.keysym.mod & KMOD_SHIFT)
    {
        if (n == ',' || n == '.' || n == '/') {
            return n + 16;
        } else if (n == ';') {
            return ':';
        } else if (n == '\'') {
            return '"';
        } else if (n >= '[' && n <= ']') {
            return n + 32;
        } else if (n == '-') {
            return '_';
        } else if (n == '=') {
            return '+';
        } else if (n == '`') {
            return '~';
        } else if (n == '1') {
            return '!';
        } else if (n == '2') {
            return '@';
        } else if (n >= '3' && n <= '5') {
            return n - 16;
        } else if (n == '6') {
            return '^';
        } else if (n == '7') {
            return '&';
        } else if (n == '8') {
            return '*';
        } else if (n == '9') {
            return '(';
        } else if (n == '0') {
            return ')';
        }
    }

    if (n == ' ' ||
        n == SDLK_BACKSPACE ||
        n == SDLK_RETURN ||
        n == SDLK_TAB ||
        (n >= SDLK_ESCAPE && n <= 'z') )
    {
        return n;
    }
    else if (n >= SDLK_NUMLOCK && n <= SDLK_COMPOSE)
    {
        return 0;
    }
    else
    {
        return 0xFF00 + event.key.keysym.scancode;
    }
}

FBCALL void fb_GfxTransCoord (float x, float y, Sint16 *rx, Sint16 *ry)
{
    if (fb_GfxInfo.winActive)
    {
        x = (x - fb_GfxInfo.winX) * (fb_GfxInfo.view.w-1) / fb_GfxInfo.winW;
        y = (y - fb_GfxInfo.winY) * (fb_GfxInfo.view.h-1) / fb_GfxInfo.winH;
    }

    *rx = (Sint16)(x + .5f) + fb_GfxInfo.view.x;

    if (fb_GfxInfo.winActive == 0 || fb_GfxInfo.winScreenFlag)
    {
        *ry = (Sint16)(y + .5f) + fb_GfxInfo.view.y;
    }
    else
    {
        *ry = (fb_GfxInfo.view.y + fb_GfxInfo.view.h - 1) - (Sint16)(y + .5f);
    }
}

/* Convert coords to absolute */
static void fb_GfxConvertCoords(float *x1, float *y1, float *x2, float *y2, int coordType)
{
    switch (coordType)
    {
    case COORD_TYPE_AA:
/*
        x1 = x1;
        y1 = y1;
        x2 = x2;
        y2 = y2;
*/
        break;
    case COORD_TYPE_AR:
/*
        x1 = x1;
        y1 = y1;
*/
        *x2 = *x1 + *x2;
        *y2 = *y1 + *y2;
        break;
    case COORD_TYPE_RA:
        *x1 = fb_GfxInfo.gfx_cursorX + *x1;
        *y1 = fb_GfxInfo.gfx_cursorY + *y1;
/*
        x2 = x2;
        y2 = y2;
*/
        break;
    case COORD_TYPE_RR:
        *x1 = fb_GfxInfo.gfx_cursorX + *x1;
        *y1 = fb_GfxInfo.gfx_cursorY + *y1;
        *x2 = *x1 + *x2;
        *y2 = *y1 + *y2;
        break;
    case COORD_TYPE_A:  /* x1 and y1 are ignored */
        *x1 = fb_GfxInfo.gfx_cursorX;
        *y1 = fb_GfxInfo.gfx_cursorY;
/*
        x2 = x2;
        y2 = y2;
*/
        break;
    case COORD_TYPE_R:  /* x1 and y1 are ignored */
        *x1 = fb_GfxInfo.gfx_cursorX;
        *y1 = fb_GfxInfo.gfx_cursorY;
        *x2 = *x1 + *x2;
        *y2 = *y1 + *y2;
        break;
    }
}

/* 0: window x coord to view x coord
   1: window y coord to view y coord
   2: view x coord to window x coord
   3: view y coord to window y coord */
FBCALL float fb_GfxPMap (float coord, int num)
{
    switch (num)
    {

    /* window x coord to view x coord */
    case 0:

        if (fb_GfxInfo.winActive)
        {
            coord = (coord - fb_GfxInfo.winX) * (fb_GfxInfo.view.w-1) / fb_GfxInfo.winW;
        }
        return (int)(coord + .5f);

    /* window y coord to view y coord */
    case 1:

        if (fb_GfxInfo.winActive)
        {
            coord = (coord - fb_GfxInfo.winY) * (fb_GfxInfo.view.h-1) / fb_GfxInfo.winH;
            if (fb_GfxInfo.winScreenFlag == 0)
            {
                return (fb_GfxInfo.view.h - 1) - (Sint16)(coord + .5f);
            }
        }
        return (int)(coord + .5f);

    /* view x coord to window x coord */
    case 2:

        if (fb_GfxInfo.winActive)
        {
            coord = coord * fb_GfxInfo.winW / (fb_GfxInfo.view.w-1) + fb_GfxInfo.winX;
//            if (! fb_GfxInfo.winScreenFlag) coord = fb_GfxInfo.winW - coord;

        }
        return coord;

    /* view y coord to window y coord */
    case 3:

        if (fb_GfxInfo.winActive)
        {
            coord = coord * fb_GfxInfo.winH / (fb_GfxInfo.view.h-1);
            if (fb_GfxInfo.winScreenFlag == 0) coord = fb_GfxInfo.winH - coord;
            coord += fb_GfxInfo.winY;
        }
        return coord;

//    default:
        // <><><><><> error... <><><><><>
    }
}

/* Equivalent to calling POINT witha single parameter in QB
   Gets info about current graphics cursor position:
       0 for viewport x
       1 for viewport y
       2 for window x
       3 for window y */
FBCALL float fb_GfxCursor (int number)
{
    switch (number)
    {
    case 0:
        return fb_GfxPMap(fb_GfxInfo.gfx_cursorX, 0);
    case 1:
        return fb_GfxPMap(fb_GfxInfo.gfx_cursorY, 1);
    case 2:
        return fb_GfxInfo.gfx_cursorX;
    case 3:
        return fb_GfxInfo.gfx_cursorY;
//    default:
        // <><><><><> error... <><><><><>
    }
}

/* Private function to move the cursor to the center in the viewport in window coordinates
   Does no error checking at all */
static void fb_GfxCenterCursor (void)
{
    if (fb_GfxInfo.winActive)
    {
        fb_GfxInfo.gfx_cursorX = fb_GfxInfo.winW / 2 + fb_GfxInfo.winX;
        fb_GfxInfo.gfx_cursorY = fb_GfxInfo.winH / 2 + fb_GfxInfo.winY;
    }
    else
    {
        fb_GfxInfo.gfx_cursorX = fb_GfxInfo.view.w >> 1 + fb_GfxInfo.view.x;
        fb_GfxInfo.gfx_cursorY = fb_GfxInfo.view.h >> 1 + fb_GfxInfo.view.y;
    }
}

static void fb_GfxRestoreHandlers (void)
{
    if (fb_GfxInfo.oldInkeyHandler != NULL)
    {
        fb_SetInkeyProc(fb_GfxInfo.oldInkeyHandler);
        fb_GfxInfo.oldInkeyHandler = NULL;
    }
    if (fb_GfxInfo.oldGetkeyHandler != NULL)
    {
        fb_SetGetkeyProc(fb_GfxInfo.oldGetkeyHandler);
        fb_GfxInfo.oldGetkeyHandler = NULL;
    }
    if (fb_GfxInfo.oldClsHandler != NULL)
    {
        fb_SetClsProc(fb_GfxInfo.oldClsHandler);
        fb_GfxInfo.oldClsHandler = NULL;
    }
    if (fb_GfxInfo.oldColorHandler != NULL)
    {
        fb_SetColorProc(fb_GfxInfo.oldColorHandler);
        fb_GfxInfo.oldColorHandler = NULL;
    }
    if (fb_GfxInfo.oldLocateHandler != NULL)
    {
        fb_SetLocateProc(fb_GfxInfo.oldLocateHandler);
        fb_GfxInfo.oldLocateHandler = NULL;
    }
    if (fb_GfxInfo.oldWidthHandler != NULL)
    {
        fb_SetWidthProc(fb_GfxInfo.oldWidthHandler);
        fb_GfxInfo.oldWidthHandler = NULL;
    }
    if (fb_GfxInfo.oldGetXHandler != NULL)
    {
        fb_SetGetXProc(fb_GfxInfo.oldGetXHandler);
        fb_GfxInfo.oldGetXHandler = NULL;
    }
    if (fb_GfxInfo.oldGetYHandler != NULL)
    {
        fb_SetGetYProc(fb_GfxInfo.oldGetYHandler);
        fb_GfxInfo.oldGetYHandler = NULL;
    }

    if (fb_GfxInfo.oldPrintHandler != NULL)
    {
        fb_SetPrintBufferProc( fb_GfxInfo.oldPrintHandler );
        fb_GfxInfo.oldPrintHandler = NULL;
    }

}

static void fb_GfxTakeHandlers (void)
{
    if (fb_GfxInfo.oldInkeyHandler == NULL)
        fb_GfxInfo.oldInkeyHandler = fb_SetInkeyProc((FB_INKEYPROC)fb_GfxInkey);
    if (fb_GfxInfo.oldGetkeyHandler == NULL)
        fb_GfxInfo.oldGetkeyHandler = fb_SetGetkeyProc((FB_GETKEYPROC)fb_GfxInkeyEx);

    if (fb_GfxInfo.oldClsHandler == NULL)
        fb_GfxInfo.oldClsHandler = fb_SetClsProc((FB_CLSPROC)fb_GfxCls);

    if (fb_GfxInfo.oldColorHandler == NULL)
        fb_GfxInfo.oldColorHandler = fb_SetColorProc((FB_COLORPROC)fb_GfxColor);

    if (fb_GfxInfo.oldLocateHandler == NULL)
        fb_GfxInfo.oldLocateHandler = fb_SetLocateProc((FB_LOCATEPROC)fb_GfxLocate);

    if (fb_GfxInfo.oldWidthHandler == NULL)
        fb_GfxInfo.oldWidthHandler = fb_SetWidthProc((FB_WIDTHPROC)fb_GfxWidth);

    if (fb_GfxInfo.oldGetXHandler == NULL)
        fb_GfxInfo.oldGetXHandler = fb_SetGetXProc((FB_GETXPROC)fb_GfxPos);
    if (fb_GfxInfo.oldGetYHandler == NULL)
        fb_GfxInfo.oldGetYHandler = fb_SetGetYProc((FB_GETYPROC)fb_GfxCsrlin);

    if (fb_GfxInfo.oldPrintHandler == NULL)
        fb_GfxInfo.oldPrintHandler = fb_SetPrintBufferProc((FB_PRINTBUFFPROC)fb_GfxPrintBuffer);

}

static void fb_GfxQuit (void)
{
//    SDL_FreeSurface(fb_GfxInfo.font);

    fb_GfxRestoreHandlers();
    SDL_Quit();
}

/* Returns nonzero on error: */
FBCALL int fb_GfxScreen (int width, int height, int depth, int fullScreenFlag)
{
    int screenNum = width;

	fb_GfxSetDefaultInfo( );

	/* calling the extended version? */
	if( (height != 0) && (depth != 0) )
		return fb_GfxScreenEx( width, height, depth, fullScreenFlag );


    if (screenNum == 0)  // exit graphics mode
    {
        if ( fb_GfxInfo.sdlIsInitialized && SDL_WasInit(SDL_INIT_VIDEO) )
        {
            SDL_QuitSubSystem(SDL_INIT_VIDEO);
        }
        fb_GfxInfo.videoIsInitialized = 0;

        fb_GfxRestoreHandlers();

        return FB_RTERROR_OK;
    }

    /* enter or change graphics mode */

    switch (screenNum)
    {
    case 12:
        width = 640; height = 480;
        fb_GfxSetFont(8, 16, (void*)fb_GfxDefaultFont8x16);
        break;
    case 13:
        width = 320; height = 200;
        fb_GfxSetFont(8, 8, (void*)fb_GfxDefaultFont8x8);
        break;
    default:
        return FB_RTERROR_ILLEGALFUNCTIONCALL;  /* Invalid mode specified */
    }

    if ( fb_GfxScreenEx(width, height, DEFAULT_DEPTH, (DEFAULT_FLAGS & SDL_FULLSCREEN)) )
    {
        return FB_RTERROR_ILLEGALFUNCTIONCALL;
    }

    #if DEFAULT_DEPTH == 8
        /* casting to SDL_Color* kills a warning */
        SDL_SetColors(fb_GfxInfo.screen, (SDL_Color*)fb_GfxDefaultPal, 0, 256);
        fb_GfxSetFontBg(0, -1);
    #else
        fb_GfxSetFontBg(0x000000FF, -1);
    #endif

    fb_GfxInfo.tabDist = 64;
    fb_GfxInfo.printAffectedByView = 1;
    fb_GfxInfo.letterWrap = 1;
    fb_GfxInfo.printScrolls = 1;
    fb_GfxInfo.textCoords = 1;

    return FB_RTERROR_OK;
}

/* Returns nonzero on error: */
static int fb_GfxScreenEx(int width, int height, int depth, int fullScreenFlag)
{
    Uint32 flags;

    if (fb_GfxInfo.sdlIsInitialized == 0)
    {
        if ( SDL_Init(SDL_INIT_VIDEO) ) return -1;
        fb_GfxInfo.sdlIsInitialized = 1;

        SDL_EnableKeyRepeat(SDL_DEFAULT_REPEAT_DELAY, SDL_DEFAULT_REPEAT_INTERVAL);
    }
    else if (SDL_WasInit(SDL_INIT_VIDEO) == 0)
    {
        if ( SDL_InitSubSystem(SDL_INIT_VIDEO) ) return -1;
    }

    fb_GfxInfo.videoIsInitialized = SDL_WasInit(SDL_INIT_VIDEO);

    flags = DEFAULT_FLAGS;
    if (fullScreenFlag)
        flags |= SDL_FULLSCREEN;
    else
        flags &= ~SDL_FULLSCREEN;

    fb_GfxInfo.screen = SDL_SetVideoMode(width, height, depth, flags);
    if (fb_GfxInfo.screen == NULL) return -1;

    if( fullScreenFlag == 0 )
    {
    	char buff[64];
    	sprintf( buff, "%s (%dx%dx%d)", FBGFX_WINDOWTITLE, width, height, depth );
    	SDL_WM_SetCaption( buff, NULL );
    }

    fb_GfxInfo.gfx_cursorX = width >> 1;
    fb_GfxInfo.gfx_cursorY = height >> 1;

    if (depth > 8)
    {
        fb_GfxInfo.defaultColor = 0xFFFFFFFF;
        fb_GfxSetFontBg(0x000000FF, 1);
    }
    else
    {
        fb_GfxInfo.defaultColor = 15;
        fb_GfxSetFontBg(0, 1);
    }

    fb_GfxInfo.view.x = 0; fb_GfxInfo.view.w = width;
    fb_GfxInfo.view.y = 0; fb_GfxInfo.view.h = height;

    fb_GfxInfo.winActive = 0;
    fb_GfxInfo.paletteChanged = 0;

    if (fb_GfxInfo.fontData == NULL) fb_GfxSetFont(8, 16, (void*)fb_GfxDefaultFont8x16);

    fb_GfxInfo.tabDist = 0;
    fb_GfxInfo.printAffectedByView = 0;
    fb_GfxInfo.letterWrap = 0;
    fb_GfxInfo.printScrolls = 0;
    fb_GfxInfo.textCoords = 0;

    fb_GfxTakeHandlers();

    fb_GfxResetVgaPalEmu();
    fb_AtExit(fb_GfxQuit);

    return FB_RTERROR_OK;
}

FBCALL Uint32 fb_GfxRgb (Uint8 r, Uint8 g, Uint8 b)
{
    if (SANITY_CHECK_CONDITION || fb_GfxInfo.screen->format->BitsPerPixel > 8)
    {
        return (r << 24) + (g << 16) + (b << 8) + 0xFF;
    }
    else
    {
        return SDL_MapRGB(fb_GfxInfo.screen->format, r, g, b);
    }
}

FBCALL int fb_GfxWindow (float x1, float y1, float x2, float y2, int screenFlag)
{
    SANITY_CHECK

    if (x1 != 0 || y1 != 0 || x2 != 0 || y2 != 0)
    {
        fb_GfxInfo.winActive = 1;
        fb_GfxInfo.winScreenFlag = screenFlag;

        if (x2 >= x1)
        {
            fb_GfxInfo.winX = x1;
            fb_GfxInfo.winW = x2-x1;
        }
        else
        {
            fb_GfxInfo.winX = x2;
            fb_GfxInfo.winW = x1-x2;
        }

        if (y2 >= y1)
        {
            fb_GfxInfo.winY = y1;
            fb_GfxInfo.winH = y2-y1;
        }
        else
        {
            fb_GfxInfo.winY = y2;
            fb_GfxInfo.winH = y1-y2;
        }
    }
    else
    {
        fb_GfxInfo.winActive = 0;
    }
}

FBCALL int fb_GfxView (int x1, int y1, int x2, int y2, Uint32 fillCol, Uint32 borderCol, int screenFlag)
{
    SDL_Color *c;
    SDL_Rect r;

    SANITY_CHECK

    /* Let's be a little more tolerant than QB (SDL_SetClipRect takes care of clipping boxs that go offscreen) */
    if (x2 < x1 || y2 < y1) return -1;

    if (x1 == -32768 && x2 == -32768 && y1 == -32768 && y2 == -32768)
    {
        r.x = 0; r.w = fb_GfxInfo.screen->w;
        r.y = 0; r.h = fb_GfxInfo.screen->h;
    }
    else
    {
        r.x = x1; r.w = x2 - x1 + 1;
        r.y = y1; r.h = y2 - y1 + 1;

        if (borderCol != DEFAULT_COLOR)
        {
            SDL_SetClipRect(fb_GfxInfo.screen, NULL);
            if (fb_GfxBoxEx(r.x-1, r.y-1, r.w+1, r.h+1, borderCol) != 0) return -1;
        }
    }

    SDL_SetClipRect(fb_GfxInfo.screen, &r);
    if (fillCol != DEFAULT_COLOR) fb_GfxCls(fillCol);

    if (screenFlag)
    {
        fb_GfxInfo.view.x = 0;
        fb_GfxInfo.view.y = 0;
        fb_GfxInfo.view.w = fb_GfxInfo.screen->w;
        fb_GfxInfo.view.h = fb_GfxInfo.screen->h;
    }
    else
    {
        fb_GfxInfo.view = r;
    }

    fb_GfxCenterCursor();

    return 0;
}

void fb_GfxColor ( int fc, int bc )
{
    SDL_Color c;

    SANITY_CHECK

    if (fb_GfxInfo.screen->format->BytesPerPixel == 1) fc &= 0xFF;

    fb_GfxInfo.defaultColor = fc;
}

FBCALL int fb_GfxFlip (int frompage, int topage)
{
    SANITY_CHECK

    if (fb_GfxInfo.paletteChanged)
    {
        fb_GfxFlushPalette();
//        /* Apparently, we don't need to call SDL_Flip because SDL_SetPalette
//           (called by fb_GfxFlushPalette) does that for us ??? (seems to) */

//        return 0;
    }
//    else
//    {
//        return SDL_Flip(fb_GfxInfo.screen);
//    }

    SDL_UpdateRect(fb_GfxInfo.screen, 0, 0, 0, 0);

    return 0;
}

FBCALL int fb_GfxPsetEx (Sint16 x, Sint16 y, Uint32 color)
{
    int bpp;
    Uint8 *p, *colorptr;

    /*
     * Honor clipping setup at pixel level
     */
    if ((x < clip_xmin) || (x > clip_xmax) || (y < clip_ymin) || (y > clip_ymax))
    {
        return 0;
    }

    /*
     * Get destination format
     */
    bpp = fb_GfxInfo.screen->format->BytesPerPixel;
    p = (Uint8 *) fb_GfxInfo.screen->pixels + y * fb_GfxInfo.screen->pitch + x * bpp;

    /*
     * Lock the surface
     */
    if (SDL_MUSTLOCK(fb_GfxInfo.screen)) {
        if (SDL_LockSurface(fb_GfxInfo.screen) < 0) {
            return (-1);
        }
    }

    if (bpp == 1)
    {
        *p = color;
    }
    else
    {
        /* Convert 0xRRGGBBAA to screen pixel format: */
        colorptr = (Uint8 *) & color;
        if (SDL_BYTEORDER == SDL_BIG_ENDIAN)
        {
            color = SDL_MapRGB(fb_GfxInfo.screen->format, colorptr[0], colorptr[1], colorptr[2]);
        }
        else
        {
            color = SDL_MapRGB(fb_GfxInfo.screen->format, colorptr[3], colorptr[2], colorptr[1]);
        }

        switch (bpp) {
        case 2:
            *(Uint16 *) p = color;
            break;
        case 3:
            if (SDL_BYTEORDER == SDL_BIG_ENDIAN) {
                p[0] = (Uint8)(color >> 16);
                p[1] = (Uint8)(color >> 8);
                p[2] = (Uint8)color;
            } else {
                p[0] = (Uint8)color;
                p[1] = (Uint8)(color >> 8);
                p[2] = (Uint8)(color >> 16);
            }
            break;
        case 4:
            *(Uint32 *) p = color;
            break;
        }              /* switch */
    }              /* if (bpp == 1) */

    /*
     * Unlock surface
     */
    if (SDL_MUSTLOCK(fb_GfxInfo.screen)) {
        SDL_UnlockSurface(fb_GfxInfo.screen);
    }

    return 0;
}

/* No 0xRRGGBBAA->native format conversion, no locking: */
FBCALL int fb_GfxPsetNoLocking (Sint16 x, Sint16 y, Uint32 color)
{
    int bpp;
    Uint8 *p, *colorptr;

    /*
     * Honor clipping setup at pixel level
     */
    if ((x < clip_xmin) || (x > clip_xmax) || (y < clip_ymin) || (y > clip_ymax))
    {
        return 0;
    }

    /*
     * Get destination format
     */
    bpp = fb_GfxInfo.screen->format->BytesPerPixel;
    p = (Uint8 *) fb_GfxInfo.screen->pixels + y * fb_GfxInfo.screen->pitch + x * bpp;

    switch (bpp) {
    case 1:
        *p = color;
        break;
    case 2:
        *(Uint16 *) p = color;
        break;
    case 3:
        if (SDL_BYTEORDER == SDL_BIG_ENDIAN) {
            p[0] = (Uint8)(color >> 16);
            p[1] = (Uint8)(color >> 8);
            p[2] = (Uint8)color;
        } else {
            p[0] = (Uint8)color;
            p[1] = (Uint8)(color >> 8);
            p[2] = (Uint8)(color >> 16);
        }
        break;
    case 4:
        *(Uint32 *) p = color;
        break;
    }              /* switch */

    return 0;
}

FBCALL int fb_GfxPset (float x, float y, Uint32 color, int coordType)
{
    SDL_Color *c;
    Sint16 rx, ry;

    SANITY_CHECK

    if (color == DEFAULT_COLOR) color = fb_GfxInfo.defaultColor;

    if (coordType != COORD_TYPE_A)
    {
        x = fb_GfxInfo.gfx_cursorX + x;
        y = fb_GfxInfo.gfx_cursorY + y;
    }

    fb_GfxInfo.gfx_cursorX = x;
    fb_GfxInfo.gfx_cursorY = y;

    fb_GfxTransCoord(x, y, &rx, &ry);

    return fb_GfxPsetEx(rx, ry, color);
}

FBCALL Uint32 fb_GfxPoint (float x, float y)
{
    Sint16 rx, ry;
    Uint8 r, g, b, bpp, *p;
    Uint32 pixel;

    SANITY_CHECK

    bpp = fb_GfxInfo.screen->format->BytesPerPixel;

    fb_GfxTransCoord(x, y, &rx, &ry);

    /*
     * Return -1 (8 bit) or DEFAULT color (> 8 bit) outside of VIEW
     */
    if ( (x < fb_GfxInfo.view.x) || (x > fb_GfxInfo.view.x + fb_GfxInfo.view.w-1) ||
         (y < fb_GfxInfo.view.y) || (y > fb_GfxInfo.view.y + fb_GfxInfo.view.h-1) )
    {
        if (bpp == 1)
            return 0xFFFFFFFF;
        else
            return DEFAULT_COLOR;
    }

    /* Calculate pixel address */
    p = (Uint8 *) fb_GfxInfo.screen->pixels + ry * fb_GfxInfo.screen->pitch + rx * bpp;

    /*
     * Lock the surface
     */
    if (SDL_MUSTLOCK(fb_GfxInfo.screen)) {
        if (SDL_LockSurface(fb_GfxInfo.screen) < 0) {
            return (-1);
        }
    }

    switch (bpp)
    {
    case 1:
        pixel = *p;
        break;
    case 2:
        pixel = *(Uint16 *) p;
        break;
    case 3:
        if (SDL_BYTEORDER == SDL_BIG_ENDIAN) {
            pixel = (p[0] << 16) + (p[1] << 8) + p[2];
        } else {
            pixel = p[0] + (p[1] << 8) + (p[2] << 16);
        }
        break;
    case 4:
        pixel = *(Uint32 *) p;
        break;
    }  /* switch */

    /*
     * Unlock surface
     */
    if (SDL_MUSTLOCK(fb_GfxInfo.screen)) {
        SDL_UnlockSurface(fb_GfxInfo.screen);
    }

    if (bpp > 1)
    {
        /* Convert to 0xRRGGBBAA format and return */
        SDL_GetRGB(pixel, fb_GfxInfo.screen->format, &r, &g, &b);
        return (r << 24) + (g << 16) + (b << 8) + 0xFF;
    }
    else
    {
        return pixel;
    }
}

FBCALL int fb_GfxBoxEx (Sint16 x1, Sint16 y1, Sint16 dx, Sint16 dy, Uint32 color)
{
    SDL_Rect r;
    Uint8 * colorptr;
    int ret = 0;

    if (dx < 0)
    {
        dx = -dx;
        x1 -= dx;
    }

    if (dy < 0)
    {
        dy = -dy;
        y1 -= dy;
    }

    if (dx < 2 || dy < 2)
    {
        return fb_GfxFBoxEx(x1, y1, dx, dy, color);
    }

    if (fb_GfxInfo.screen->format->BitsPerPixel > 8)
    {
        /* Convert 0xRRGGBBAA to screen pixel format: */
        colorptr = (Uint8 *) & color;
        if (SDL_BYTEORDER == SDL_BIG_ENDIAN)
        {
            color = SDL_MapRGB(fb_GfxInfo.screen->format, colorptr[0], colorptr[1], colorptr[2]);
        }
        else
        {
            color = SDL_MapRGB(fb_GfxInfo.screen->format, colorptr[3], colorptr[2], colorptr[1]);
        }
    }
    else
    {
        color &= 255;
    }

    r.x = x1;       r.w = dx + 1;
    r.y = y1;       r.h = 1;
    ret |= SDL_FillRect(fb_GfxInfo.screen, &r, color);

    r.x = x1;       r.w = 1;
    r.y = y1 + 1;   r.h = dy - 1;
    ret |= SDL_FillRect(fb_GfxInfo.screen, &r, color);

    r.x = x1 + dx;  r.w = 1;
    r.y = y1 + 1;   r.h = dy - 1;
    ret |= SDL_FillRect(fb_GfxInfo.screen, &r, color);

    r.x = x1;       r.w = dx + 1;
    r.y = y1 + dy;  r.h = 1;
    ret |= SDL_FillRect(fb_GfxInfo.screen, &r, color);

    return ret;
}

FBCALL int fb_GfxFBoxEx (Sint16 x1, Sint16 y1, Sint16 dx, Sint16 dy, Uint32 color)
{
    SDL_Rect r;
    Uint8 * colorptr;

    if (dx < 0)
    {
        dx = -dx;
        x1 -= dx;
    }

    if (dy < 0)
    {
        dy = -dy;
        y1 -= dy;
    }

    if (fb_GfxInfo.screen->format->BitsPerPixel > 8)
    {
        /* Convert 0xRRGGBBAA to screen pixel format: */
        colorptr = (Uint8 *) & color;
        if (SDL_BYTEORDER == SDL_BIG_ENDIAN)
        {
            color = SDL_MapRGB(fb_GfxInfo.screen->format, colorptr[0], colorptr[1], colorptr[2]);
        }
        else
        {
            color = SDL_MapRGB(fb_GfxInfo.screen->format, colorptr[3], colorptr[2], colorptr[1]);
        }
    }
    else
    {
        color &= 255;
    }

    r.x = x1; r.w = dx + 1;
    r.y = y1; r.h = dy + 1;
    return SDL_FillRect(fb_GfxInfo.screen, &r, color);
}

void fb_GfxCls (int color)
{
    Uint8 *colorptr;

    SANITY_CHECK

    fb_GfxInfo.text_cursorX = 0;
    fb_GfxInfo.text_cursorY = 0;

    if (fb_GfxInfo.screen->format->BitsPerPixel > 8)
    {
        if (color != DEFAULT_COLOR)
        {
            /* Convert 0xRRGGBBAA to screen pixel format: */
            colorptr = (Uint8 *) & color;
            if (SDL_BYTEORDER == SDL_BIG_ENDIAN)
            {
                color = SDL_MapRGB(fb_GfxInfo.screen->format, colorptr[0], colorptr[1], colorptr[2]);
            }
            else
            {
                color = SDL_MapRGB(fb_GfxInfo.screen->format, colorptr[3], colorptr[2], colorptr[1]);
            }
        }
        else
        {
            color = SDL_MapRGB(fb_GfxInfo.screen->format, 0, 0, 0);
        }
    }
    else
    {
        if (color == DEFAULT_COLOR) color = 0;
        color &= 0xFF;
    }

    SDL_FillRect(fb_GfxInfo.screen, NULL, color);
}

FBCALL int fb_GfxSLineEx (Sint16 x, Sint16 y, Sint16 x2, Sint16 y2, Uint32 color, unsigned int style)
{
    int i, sx, sy, dx, dy, e;
    Uint8 *colorptr;
    Uint16 mask;

    dx = x2 - x;
    dy = y2 - y;

    sx = (dx > 0) ? 1 : -1;
    sy = (dy > 0) ? 1 : -1;

    if (dx < 0) dx = -dx;
    if (dy < 0) dy = -dy;

    if (fb_GfxInfo.screen->format->BitsPerPixel > 8)
    {
        /* Convert 0xRRGGBBAA to screen pixel format: */
        colorptr = (Uint8 *) & color;
        if (SDL_BYTEORDER == SDL_BIG_ENDIAN)
        {
            color = SDL_MapRGB(fb_GfxInfo.screen->format, colorptr[0], colorptr[1], colorptr[2]);
        }
        else
        {
            color = SDL_MapRGB(fb_GfxInfo.screen->format, colorptr[3], colorptr[2], colorptr[1]);
        }
    }
    else
    {
        color &= 0xFF;
    }

    /* Lock surface */
    if (SDL_MUSTLOCK(fb_GfxInfo.screen)) {
        if (SDL_LockSurface(fb_GfxInfo.screen) < 0) {
            return (-1);
        }
    }

    mask = 0x8000;

    if(dy > dx)
    {
        e = dx + dx - dy;

        for(i = 0; i < dy; i++)
        {
            if (style & mask) fb_GfxPsetNoLocking(x, y, color);

            /* Portable but slower equivalent to roll-right: */
            mask >>= 1;
            if (!mask) mask = 0x8000;

            while(e >= 0)
            {
                x += sx;
                e -= dy + dy;
            }

            y += sy;
            e += dx + dx;
        }
    }
    else
    {
        e = dy + dy - dx;

        for(i = 0; i < dx; i++)
        {
            if (style & mask) fb_GfxPsetNoLocking(x, y, color);

            /* Portable but slower equivalent to roll-right: */
            mask >>= 1;
            if (!mask) mask = 0x8000;

            while(e >= 0)
            {
                y += sy;
                e -= dx + dx;
            }

            x += sx;
            e += dy + dy;
        }
    }

    if (style & mask) fb_GfxPsetNoLocking(x2, y2, color);

    /*
     * Unlock surface
     */
    if (SDL_MUSTLOCK(fb_GfxInfo.screen)) {
        SDL_UnlockSurface(fb_GfxInfo.screen);
    }

    return 0;
}

/* --------- Clipping routines for line */

/* Clipping based heavily on code from                       */
/* http://www.ncsa.uiuc.edu/Vis/Graphics/src/clipCohSuth.c   */

#define CLIP_LEFT_EDGE   0x1
#define CLIP_RIGHT_EDGE  0x2
#define CLIP_BOTTOM_EDGE 0x4
#define CLIP_TOP_EDGE    0x8
#define CLIP_INSIDE(a)   (!a)
#define CLIP_REJECT(a,b) (a&b)
#define CLIP_ACCEPT(a,b) (!(a|b))

static int fb_GfxClipLine(Sint16 * x1, Sint16 * y1, Sint16 * x2, Sint16 * y2)
{
    Sint16 left, right, top, bottom;
    int code1, code2;
    int draw = 0;
    Sint16 swaptmp;
    float m;

    /*
     * Get clipping boundary
     */
    left   = clip_xmin;
    right  = clip_xmax;
    top    = clip_ymin;
    bottom = clip_ymax;

    while (1) {

        code1 = code2 = 0;

        if (*x1 < left) {
            code1 += CLIP_LEFT_EDGE;
        } else if (*x1 > right) {
            code1 += CLIP_RIGHT_EDGE;
        }
        if (*y1 < top) {
            code1 += CLIP_TOP_EDGE;
        } else if (*y1 > bottom) {
            code1 += CLIP_BOTTOM_EDGE;
        }

        if (*x2 < left) {
            code2 += CLIP_LEFT_EDGE;
        } else if (*x2 > right) {
            code2 += CLIP_RIGHT_EDGE;
        }
        if (*y2 < top) {
            code2 += CLIP_TOP_EDGE;
        } else if (*y2 > bottom) {
            code2 += CLIP_BOTTOM_EDGE;
        }

        if (CLIP_ACCEPT(code1, code2)) {
            draw = 1;
            break;
        } else if (CLIP_REJECT(code1, code2))
            break;
        else {
            if (CLIP_INSIDE(code1)) {
                swaptmp = *x2;
                *x2 = *x1;
                *x1 = swaptmp;
                swaptmp = *y2;
                *y2 = *y1;
                *y1 = swaptmp;
                swaptmp = code2;
                code2 = code1;
                code1 = swaptmp;
            }
            if (*x2 != *x1) {
                m = (*y2 - *y1) / (float) (*x2 - *x1);
            } else {
                m = 1.0f;
            }
            if (code1 & CLIP_LEFT_EDGE) {
                *y1 += (Sint16) ((left - *x1) * m);
                *x1 = left;
            } else if (code1 & CLIP_RIGHT_EDGE) {
                *y1 += (Sint16) ((right - *x1) * m);
                *x1 = right;
            } else if (code1 & CLIP_BOTTOM_EDGE) {
                if (*x2 != *x1) {
                    *x1 += (Sint16) ((bottom - *y1) / m);
                }
                *y1 = bottom;
            } else if (code1 & CLIP_TOP_EDGE) {
                if (*x2 != *x1) {
                    *x1 += (Sint16) ((top - *y1) / m);
                }
                *y1 = top;
            }
        }
    }

    return draw;
}

/* ----- Line */

/* Non-alpha line drawing code adapted from routine          */
/* by Pete Shinners, pete@shinners.org                       */
/* Originally from pygame, http://pygame.seul.org            */

FBCALL int fb_GfxLineEx(Sint16 x1, Sint16 y1, Sint16 x2, Sint16 y2, Uint32 color)
{
    int pixx, pixy;
    int x, y;
    int dx, dy;
    int ax, ay;
    int sx, sy;
    int swaptmp;
    Uint8 *pixel;
    Uint8 *colorptr;

    /*
     * Clip line and test if we have to draw
     */
    if (!(fb_GfxClipLine(&x1, &y1, &x2, &y2))) {
        return (0);
    }

    /*
     * Variable setup
     */
    dx = x2 - x1;
    dy = y2 - y1;
    sx = (dx >= 0) ? 1 : -1;
    sy = (dy >= 0) ? 1 : -1;

    /*
     * Test for special cases of straight lines or single point
     */
    if (dy == 0 || dx == 0) {
        return fb_GfxFBoxEx(x1, y1, dx, dy, color);
    }

    /* Lock surface */
    if (SDL_MUSTLOCK(fb_GfxInfo.screen)) {
        if (SDL_LockSurface(fb_GfxInfo.screen) < 0) {
            return (-1);
        }
    }

    /*
     * Setup color
     */
    if (fb_GfxInfo.screen->format->BytesPerPixel > 1)
    {
        colorptr = (Uint8 *) & color;
        if (SDL_BYTEORDER == SDL_BIG_ENDIAN) {
            color = SDL_MapRGB(fb_GfxInfo.screen->format, colorptr[0], colorptr[1], colorptr[2]);
        } else {
            color = SDL_MapRGB(fb_GfxInfo.screen->format, colorptr[3], colorptr[2], colorptr[1]);
        }
    }

    /*
     * More variable setup
     */
    dx = sx * dx + 1;
    dy = sy * dy + 1;
    pixx = fb_GfxInfo.screen->format->BytesPerPixel;
    pixy = fb_GfxInfo.screen->pitch;
    pixel = ((Uint8 *) fb_GfxInfo.screen->pixels) + pixx * (int) x1 + pixy * (int) y1;
    pixx *= sx;
    pixy *= sy;
    if (dx < dy) {
        swaptmp = dx;
        dx = dy;
        dy = swaptmp;
        swaptmp = pixx;
        pixx = pixy;
        pixy = swaptmp;
    }

	/*
	 * Draw
	 */
	x = 0;
	y = 0;
	switch (fb_GfxInfo.screen->format->BytesPerPixel)
    {
    case 1:
        for (; x < dx; x++, pixel += pixx) {
            *pixel = color;
            y += dy;
            if (y >= dx) {
                y -= dx;
                pixel += pixy;
            }
        }
        break;
    case 2:
        for (; x < dx; x++, pixel += pixx) {
            *(Uint16 *) pixel = color;
            y += dy;
            if (y >= dx) {
                y -= dx;
                pixel += pixy;
            }
        }
        break;
    case 3:
        for (; x < dx; x++, pixel += pixx) {
            if (SDL_BYTEORDER == SDL_BIG_ENDIAN) {
                pixel[0] = (Uint8)(color >> 16);
                pixel[1] = (Uint8)(color >> 8);
                pixel[2] = (Uint8)color;
            } else {
                pixel[0] = (Uint8)color;
                pixel[1] = (Uint8)(color >> 8);
                pixel[2] = (Uint8)(color >> 16);
            }
            y += dy;
            if (y >= dx) {
                y -= dx;
                pixel += pixy;
            }
        }
        break;
    default:        /* case 4 */
        for (; x < dx; x++, pixel += pixx) {
            *(Uint32 *) pixel = color;
            y += dy;
            if (y >= dx) {
                y -= dx;
                pixel += pixy;
            }
        }
        break;
    }

    /* Unlock surface */
    if (SDL_MUSTLOCK(fb_GfxInfo.screen)) {
        SDL_UnlockSurface(fb_GfxInfo.screen);
    }

    return (0);
}

FBCALL int fb_GfxLine (float x1, float y1, float x2, float y2, Uint32 color, int type, unsigned int style, int coordType)
{
    SDL_Color *c;
    Sint16 rx1, ry1, rx2, ry2;

    SANITY_CHECK

    fb_GfxConvertCoords(&x1, &y1, &x2, &y2, coordType);

    if (color == DEFAULT_COLOR) color = fb_GfxInfo.defaultColor;
    fb_GfxInfo.gfx_cursorX = x2;
    fb_GfxInfo.gfx_cursorY = y2;

    fb_GfxTransCoord(x1, y1, &rx1, &ry1);
    fb_GfxTransCoord(x2, y2, &rx2, &ry2);

    switch (type)
    {
    case LINE_TYPE_BF:
        return fb_GfxFBoxEx(rx1, ry1, rx2 - rx1, ry2 - ry1, color);
    case LINE_TYPE_B:
        return fb_GfxBoxEx(rx1, ry1, rx2 - rx1, ry2 - ry1, color);
    default: /* LINE_TYPE_LINE */
        if ((style & 0x0000FFFF) == 0xFFFF) {
            return fb_GfxLineEx(rx1, ry1, rx2, ry2, color);
        } else {
            return fb_GfxSLineEx(rx1, ry1, rx2, ry2, color, style & 0x0000FFFF);
        }
    }
}

/* ----- Ellipse */

/* Note: Based on algorithm from sge library with multiple-hline draw removal */
/* and other speedup changes. */

FBCALL int fb_GfxEllipseEx (Sint16 x, Sint16 y, Sint16 rx, Sint16 ry, Uint32 color)
{
    Sint16 left, right, top, bottom;
    int ix, iy;
    int h, i, j, k;
    int oh, oi, oj, ok;
    Uint8 *colorptr;

    /*
     * Sanity check radii
     */
    if ((rx <= 0) || (ry <= 0)) {

        /*
         * Special case for rx=0 or ry=0 - draw an h/vline
         */
        if (rx == 0 || ry == 0) {
            return fb_GfxFBoxEx(x - rx, y - ry, rx + rx, ry + ry, color);
        }

        /* If rx and ry are nonzero, and at least one of them is < 1, then at least one
           is negative, which is invalid: */
        return -1;
    }

    /*
     * Get clipping boundary
     */
    left   = clip_xmin;
    right  = clip_xmax;
    top    = clip_ymin;
    bottom = clip_ymax;

    /*
     * Test if bounding box of ellipse is visible
     */
    if ( ((x-rx<left)   && (x+rx<left))   ||
         ((x-rx>right)  && (x+rx>right))  ||
         ((y-ry<top)    && (y+ry<top))    ||
         ((y-ry>bottom) && (y+ry>bottom))
       )
    {
        return(0);
    }

    /*
     * Init vars
     */
    oh = oi = oj = ok = 0xFFFF;

    /* Lock surface */
    if (SDL_MUSTLOCK(fb_GfxInfo.screen)) {
        if (SDL_LockSurface(fb_GfxInfo.screen) < 0) {
            return -1;
        }
    }

    /*
     * Setup color
     */
    if (fb_GfxInfo.screen->format->BitsPerPixel > 8)
    {
        colorptr = (Uint8 *) & color;
        if (SDL_BYTEORDER == SDL_BIG_ENDIAN) {
            color = SDL_MapRGB(fb_GfxInfo.screen->format, colorptr[0], colorptr[1], colorptr[2]);
        } else {
            color = SDL_MapRGB(fb_GfxInfo.screen->format, colorptr[3], colorptr[2], colorptr[1]);
        }
    }
    else
    {
        color &= 0xFF;
    }

    /*
     * Draw
     */
    if (rx > ry) {
        ix = 0;
        iy = rx * 64;

        do {
            h = (ix + 32) >> 6;
            i = (iy + 32) >> 6;
            j = (h * ry) / rx;
            k = (i * ry) / rx;

            if (((ok != k) && (oj != k)) || ((oj != j) && (ok != j)) || (k != j)) {

                fb_GfxPsetNoLocking(x - h, y - k, color);
                fb_GfxPsetNoLocking(x + h, y - k, color);
                if (k)
                {
                    fb_GfxPsetNoLocking(x - h, y + k, color);
                    fb_GfxPsetNoLocking(x + h, y + k, color);
                }
                ok = k;

                fb_GfxPsetNoLocking(x - i, y - j, color);
                fb_GfxPsetNoLocking(x + i, y - j, color);
                if (j)
                {
                    fb_GfxPsetNoLocking(x - i, y + j, color);
                    fb_GfxPsetNoLocking(x + i, y + j, color);
                }
                oj = j;
            }

            ix = ix + iy / rx;
            iy = iy - ix / rx;

        } while (i > h);
    } else {
        ix = 0;
        iy = ry * 64;

        do {
            h = (ix + 32) >> 6;
            i = (iy + 32) >> 6;
            j = (h * rx) / ry;
            k = (i * rx) / ry;

            if (((oi != i) && (oh != i)) || ((oh != h) && (oi != h) && (i != h))) {

                fb_GfxPsetNoLocking(x - j, y - i, color);
                fb_GfxPsetNoLocking(x + j, y - i, color);
                if (i)
                {
                    fb_GfxPsetNoLocking(x - j, y + i, color);
                    fb_GfxPsetNoLocking(x + j, y + i, color);
                }
                oi = i;

                fb_GfxPsetNoLocking(x - k, y - h, color);
                fb_GfxPsetNoLocking(x + k, y - h, color);
                if (h)
                {
                    fb_GfxPsetNoLocking(x - k, y + h, color);
                    fb_GfxPsetNoLocking(x + k, y + h, color);
                }
                oh = h;
            }

            ix = ix + iy / ry;
            iy = iy - ix / ry;

        } while (i > h);
    }

    /* Unlock surface */
    if (SDL_MUSTLOCK(fb_GfxInfo.screen)) {
        SDL_UnlockSurface(fb_GfxInfo.screen);
    }

    return 0;
}

/* ---- Filled Ellipse */

/* Note: */
/* Based on algorithm from sge library with multiple-hline draw removal */
/* and other speedup changes. */

FBCALL int fb_GfxFEllipseEx (Sint16 x, Sint16 y, Sint16 rx, Sint16 ry, Uint32 color)
{
    Sint16 left, right, top, bottom;
    int result;
    int ix, iy;
    int h, i, j, k;
    int oh, oi, oj, ok;
//    int xmh, xph;
//    int xmi, xpi;
//    int xmj, xpj;
//    int xmk, xpk;

    /*
     * Sanity check radii
     */
    if ((rx < 0) || (ry < 0)) {
        return (-1);
    }

    /*
     * Special cases for rx=0 - draw a vline
     */
    if (rx == 0) {
        return fb_GfxFBoxEx(x, y - ry, 0, ry + ry, color);
    }
    /*
     * Special case for ry=0 - draw an hline
     */
    if (ry == 0) {
        return fb_GfxFBoxEx(x - rx, y, rx + rx, 0, color);
    }

    /*
     * Get clipping boundary
     */
    left   = clip_xmin;
    right  = clip_xmax;
    top    = clip_ymin;
    bottom = clip_ymax;

    /*
     * Test if bounding box of ellipse is visible
     */
    if ( ((x-rx<left)   && (x+rx<left))   ||
         ((x-rx>right)  && (x+rx>right))  ||
         ((y-ry<top)    && (y+ry<top))    ||
         ((y-ry>bottom) && (y+ry>bottom))
       )
    {
        return(0);
    }

    /*
     * Init vars
     */
    oh = oi = oj = ok = 0xFFFF;

    /*
     * Draw
     */
    result = 0;
    if (rx > ry) {
        ix = 0;
        iy = rx * 64;

        do {
            h = (ix + 32) >> 6;
            i = (iy + 32) >> 6;
            j = (h * ry) / rx;
            k = (i * ry) / rx;

            if ((ok != k) && (oj != k)) {
                result |= fb_GfxFBoxEx(x - h, y + k, h + h, 0, color);
                if (k > 0) result |= fb_GfxFBoxEx(x - h, y - k, h + h, 0, color);
                ok = k;
            }
            if ((oj != j) && (ok != j) && (k != j)) {
                result |= fb_GfxFBoxEx(x - i, y + j, i + i, 0, color);
                if (j > 0) result |= fb_GfxFBoxEx(x - i, y - j, i + i, 0, color);
                oj = j;
            }

            ix = ix + iy / rx;
            iy = iy - ix / rx;

        } while (i > h);
    } else {
        ix = 0;
        iy = ry * 64;

        do {
            h = (ix + 32) >> 6;
            i = (iy + 32) >> 6;
            j = (h * rx) / ry;
            k = (i * rx) / ry;

            if ((oi != i) && (oh != i)) {
                result |= fb_GfxFBoxEx(x - j, y + i, j + j, 0, color);
                if (i > 0) result |= fb_GfxFBoxEx(x - j, y - i, j + j, 0, color);
                oi = i;
            }
            if ((oh != h) && (oi != h) && (i != h)) {
                result |= fb_GfxFBoxEx(x - k, y + h, k + k, 0, color);
                if (h > 0) result |= fb_GfxFBoxEx(x - k, y - h, k + k, 0, color);
                oh = h;
            }

            ix = ix + iy / ry;
            iy = iy - ix / ry;

        } while (i > h);
    }

    return (result);
}

FBCALL int fb_GfxCircle (float x, float y, float radius, Uint32 color,
                            int fillFlag, int coordType)
{
    /* By default make it appear circular on the screen even if the pixels aren't
       square. This can be kinda nice, or harmless at the very least because you
       can always call GfxEllipse with aspect=1 if you want a pixel-perfect circle
       instead: */

    return fb_GfxEllipse(x, y, radius, color,
                         4 * ((float)fb_GfxInfo.screen->h / fb_GfxInfo.screen->w) / 3,
                         0, 3.141593*2,
                         fillFlag, coordType);
}

FBCALL int fb_GfxEllipse (float x, float y, float radius, Uint32 color,
                          float aspect, float arcini, float arcend,
                          int fillFlag, int coordType)
{
//    SDL_Color *c;
//    Uint8 r, g, b;
    Sint16 rx, ry, rradX, rradY;
    float radX, radY;

    SANITY_CHECK

    if (coordType != COORD_TYPE_A)
    {
        x = fb_GfxInfo.gfx_cursorX + x;
        y = fb_GfxInfo.gfx_cursorY + y;
    }

    fb_GfxInfo.gfx_cursorX = x;
    fb_GfxInfo.gfx_cursorY = y;
    fb_GfxTransCoord(x, y, &rx, &ry);
    if (color == DEFAULT_COLOR) color = fb_GfxInfo.defaultColor;

    /* This stuff exactly mimics QB style aspect correction, and I have no words
       for how weird/inconsistant it is and I can't believe how long it took me to
       figure out by trial and error: */

    /* Radius is interpretted as x-radius or y-radius depending
       on which would make a smaller circle. Why? */
    if( aspect == 0.0 )
    	aspect = 4.0 * ((float)fb_GfxInfo.screen->h / fb_GfxInfo.screen->w) / 3.0;

    if (aspect > 1.0)
    {
        radX = radius / aspect;
        radY = radius;
    }
    else
    {
        radY = radius * aspect;
        radX = radius;
    }

    if (fb_GfxInfo.winActive)
    {
        /* This seems to correct for any warping of the circle's height/width ratio
           caused by window->viewport mapping: */
        radY *= ((float)fb_GfxInfo.winH/fb_GfxInfo.winW) / ((float)fb_GfxInfo.view.h/fb_GfxInfo.view.w);

        radY = radY * (float)fb_GfxInfo.view.h / fb_GfxInfo.winH;
        radX = radX * (float)fb_GfxInfo.view.w / fb_GfxInfo.winW;
    }

    rradX = (Sint16)(radX + .5f);
    rradY = (Sint16)(radY + .5f);

    if (fillFlag)
        return fb_GfxFEllipseEx(rx, ry, rradX, rradY, color);
    else
        return fb_GfxEllipseEx(rx, ry, rradX, rradY, color);

    return 0;
}

FBCALL int fb_GfxGet (float x1, float y1, float x2, float y2, void *elementAddress, int coordType, FBARRAY *desc)
{
    Sint16 w, h,
           rx1, ry1, rx2, ry2;

    SANITY_CHECK

    fb_GfxConvertCoords(&x1, &y1, &x2, &y2, coordType);
    fb_GfxTransCoord(x1, y1, &rx1, &ry1);
    fb_GfxTransCoord(x2, y2, &rx2, &ry2);

    if (rx1 > rx2)
    {
        w = rx1;
        rx1 = rx2;
        rx2 = w;
    }
    if (ry1 > ry2)
    {
        h = ry1;
        ry1 = ry2;
        ry2 = h;
    }

    w = rx2 - rx1 + 1;
    h = ry2 - ry1 + 1;

    /* If AddressOfLastByteToBeOverwritten+1 > AddressOfLastByteAllocated+1 */
    if ( (Uint8*)elementAddress + 4 + w * h > (Uint8*)(desc->ptr) + desc->size )
    {
        return -1;
    }

    return fb_GfxGetEx(rx1, ry1, w, h, elementAddress);
}

static int fb_GfxGetEx (Sint16 x, Sint16 y, Uint16 w, Uint16 h, void *dst)
{
    SDL_Surface *surface;
    SDL_Rect r;
    int ret, depth;

    if (w & 0xE000) return -1; /* It's too wide - maximun width is 2**13-1 */

    r.x = x; r.w = w;
    r.y = y; r.h = h;

    depth = fb_GfxInfo.screen->format->BitsPerPixel;

    w <<= 3;
    switch (depth)
    {
    case 8: // QB compatible
        break;
    case 15:
        w += 1;
        break;
    case 16:
        w += 2;
        break;
    case 24:
        w += 3;
        break;
    default:
        w += 4;
        break;
    }

    *((Uint16*)dst) = w;
    *((Uint16*)dst + 1) = h;

    surface = SDL_CreateRGBSurfaceFrom((Uint16*)dst + 2, r.w, r.h, depth,
                                       r.w * fb_GfxInfo.screen->format->BytesPerPixel,
                                       fb_GfxInfo.screen->format->Rmask,
                                       fb_GfxInfo.screen->format->Gmask,
                                       fb_GfxInfo.screen->format->Bmask,
                                       fb_GfxInfo.screen->format->Amask);

    if (depth == 8)
    {
        SDL_SetColors(surface, fb_GfxInfo.screen->format->palette->colors, 0, 256);
    }

    ret = SDL_BlitSurface(fb_GfxInfo.screen, &r, surface, NULL);

    SDL_FreeSurface(surface);

    return ret;
}

FBCALL int fb_GfxPut( float x, float y, void *sourceAddress, int coordType, int mode )
{
    SDL_Surface *surface;
    SDL_Rect dst;
    int ret, depth, bytesPP, w, h;

    SANITY_CHECK

    if( mode == FBGFX_PUTMODE_MASK )
    {
    	return fb_GfxPutKey( x, y, sourceAddress, coordType );
    }

    if (coordType != COORD_TYPE_A)
    {
        x = fb_GfxInfo.gfx_cursorX + x;
        y = fb_GfxInfo.gfx_cursorY + y;
    }

    fb_GfxInfo.gfx_cursorX = x;
    fb_GfxInfo.gfx_cursorY = y;

    fb_GfxTransCoord(x, y, &dst.x, &dst.y);

    w = *((Sint16 *)sourceAddress);
    h = *((Sint16 *)sourceAddress + 1);

    depth = w & 7;
    switch (depth)
    {
    case 0:
        bytesPP = 1;
        depth = 8;
        break;
    case 1:
        bytesPP = 2;
        depth = 15;
        break;
    default:
        bytesPP = depth;
        depth <<= 3;
        break;
    }

    w >>= 3;

    surface = SDL_CreateRGBSurfaceFrom((void*)((Uint16*)sourceAddress + 2),
                                       w, h, depth, w * bytesPP,
                                       fb_GfxInfo.screen->format->Rmask,
                                       fb_GfxInfo.screen->format->Gmask,
                                       fb_GfxInfo.screen->format->Bmask,
                                       fb_GfxInfo.screen->format->Amask);

    if (depth == 8 && fb_GfxInfo.screen->format->BitsPerPixel == 8)
    {
        SDL_SetColors(surface, fb_GfxInfo.screen->format->palette->colors, 0, 256);
    }

    ret = SDL_BlitSurface(surface, NULL, fb_GfxInfo.screen, &dst);

    SDL_FreeSurface(surface);

    return ret;
}

static int fb_GfxPutKey (float x, float y, void *sourceAddress, int coordType)
{
    SDL_Surface *surface;
    SDL_Rect dst;
    int ret, depth, bytesPP, w, h;
    Uint32 colorKey;

    SANITY_CHECK

    if (coordType != COORD_TYPE_A)
    {
        x = fb_GfxInfo.gfx_cursorX + x;
        y = fb_GfxInfo.gfx_cursorY + y;
    }

    fb_GfxInfo.gfx_cursorX = x;
    fb_GfxInfo.gfx_cursorY = y;

    fb_GfxTransCoord(x, y, &dst.x, &dst.y);

    w = *((Sint16 *)sourceAddress);
    h = *((Sint16 *)sourceAddress + 1);

    depth = w & 7;
    switch (depth)
    {
    case 0:
        bytesPP = 1;
        depth = 8;
        break;
    case 1:
        bytesPP = 2;
        depth = 15;
        break;
    default:
        bytesPP = depth;
        depth <<= 3;
        break;
    }

    w >>= 3;

    surface = SDL_CreateRGBSurfaceFrom((void*)((Uint16*)sourceAddress + 2),
                                       w, h, depth, w * bytesPP,
                                       fb_GfxInfo.screen->format->Rmask,
                                       fb_GfxInfo.screen->format->Gmask,
                                       fb_GfxInfo.screen->format->Bmask,
                                       fb_GfxInfo.screen->format->Amask);


    if (depth == 8 && fb_GfxInfo.screen->format->BitsPerPixel == 8)
    {
        SDL_SetColors(surface, fb_GfxInfo.screen->format->palette->colors, 0, 256);
    }

    if (depth > 8)
    	colorKey = SDL_MapRGB(fb_GfxInfo.screen->format, 0xFF, 0x00, 0xFF );
    else
    	colorKey = SDL_MapRGB(fb_GfxInfo.screen->format, 0x00, 0x00, 0x00 );

    SDL_SetColorKey(surface, SDL_SRCCOLORKEY, colorKey);

    ret = SDL_BlitSurface(surface, NULL, fb_GfxInfo.screen, &dst);

    SDL_FreeSurface(surface);

    return ret;
}
