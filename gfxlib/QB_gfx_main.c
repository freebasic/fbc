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

/*
    ToDo: Inkey repeat rate?
          throw errors
          document all default values
          fb inkey handler returns pointer to old handler, right?
          arg! why does ellipse from SDL_gfx leave gaps?
          Make numlock work, numpad + should return "+", etc
*/

#define FBGFX_NO_GFXINFO_EXTERN
#include "QB_gfx_main.h"
#undef FBGFX_NO_GFXINFO_EXTERN

#include "QB_gfx_pal.h"
#include "QB_gfx_text.h"

static int  fb_GfxInitVideo             (void);
static void fb_GfxQuit      			(void);
//static int 	fb_GfxScreenEx   			(int width, int height, int depth, int fullscreenFlag);
static void fb_GfxRestoreHandlers 		(void);
static void fb_GfxTakeHandlers 			(void);

#define DEFAULT_DEPTH 8

/*#define DEFAULT_FLAGS (int)(SDL_HWSURFACE | SDL_HWPALETTE | SDL_DOUBLEBUF)*/
#define DEFAULT_FLAGS (int)(SDL_HWSURFACE | SDL_HWPALETTE)

/*
extern const SDL_Color fb_GfxDefaultPal[256];
extern const Uint8 fb_GfxDefaultFont8x8[2048];
extern const Uint8 fb_GfxDefaultFont8x16[4096];
extern struct fb_GfxVgaPalEmuStruct fb_GfxVgaPalEmu;
*/

//--------------------------------
//  Private data
//--------------------------------

//struct fb_GfxVgaPalEmuStruct fb_GfxVgaPalEmu = {0, 0, 0, 0, {0, 0, 0}};
struct fb_GfxInfoStruct fb_GfxInfo = { 0 };


/*:::::*/
static void fb_GfxSetDefaultInfo( void )
{
	memset( &fb_GfxInfo, 0, sizeof( fb_GfxInfo ) );

	fb_GfxInfo.eventMask = SDL_ALLEVENTS;
	fb_GfxInfo.printAffectedByView = 1;
	fb_GfxInfo.fontBgTransparent = 1;

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
        fb_GfxInfo.oldInkeyHandler = fb_SetInkeyProc(fb_GfxInkey);
    if (fb_GfxInfo.oldGetkeyHandler == NULL)
        fb_GfxInfo.oldGetkeyHandler = fb_SetGetkeyProc(fb_GfxInkeyEx);

    if (fb_GfxInfo.oldClsHandler == NULL)
        fb_GfxInfo.oldClsHandler = fb_SetClsProc(fb_GfxCls);

    if (fb_GfxInfo.oldColorHandler == NULL)
        fb_GfxInfo.oldColorHandler = fb_SetColorProc(fb_GfxColor);

    if (fb_GfxInfo.oldLocateHandler == NULL)
        fb_GfxInfo.oldLocateHandler = fb_SetLocateProc(fb_GfxLocate);

    if (fb_GfxInfo.oldWidthHandler == NULL)
        fb_GfxInfo.oldWidthHandler = fb_SetWidthProc(fb_GfxWidth);

    if (fb_GfxInfo.oldGetXHandler == NULL)
        fb_GfxInfo.oldGetXHandler = fb_SetGetXProc(fb_GfxPos);
    if (fb_GfxInfo.oldGetYHandler == NULL)
        fb_GfxInfo.oldGetYHandler = fb_SetGetYProc(fb_GfxCsrlin);

    if (fb_GfxInfo.oldPrintHandler == NULL)
        fb_GfxInfo.oldPrintHandler = fb_SetPrintBufferProc(fb_GfxPrintBuffer);

}

static void fb_GfxQuit (void)
{
    fb_GfxRestoreHandlers();
    SDL_Quit();
}

/*
 * Makes sure SDL's video subsystem is loaded 
 * Returns nonzero on error
 */
static int fb_GfxInitVideo (void)
{
    if (fb_GfxInfo.sdlIsInitialized == 0)
    {
        if ( SDL_Init(SDL_INIT_VIDEO) ) return 1;
        fb_GfxInfo.sdlIsInitialized = 1;

        SDL_EnableKeyRepeat(SDL_DEFAULT_REPEAT_DELAY, SDL_DEFAULT_REPEAT_INTERVAL);
    }
    else if (SDL_WasInit(SDL_INIT_VIDEO) == 0)
    {
        if ( SDL_InitSubSystem(SDL_INIT_VIDEO) ) return 1;
    }

    fb_GfxInfo.videoIsInitialized = 1;
    return 0;
}

/* Returns FB_RTERROR_* */
FBCALL int fb_GfxScreen (int width, int height, int depth, int fullScreenFlag)
{
    static char haveCalledSetDefaultInfo = 0;
    static char haveSetQuitAtExit = 0;
    
    int screenNum = 0, flags = DEFAULT_FLAGS;
    Uint8 *font = (Uint8*)fb_GfxDefaultFont8x16;
    
    /* call fb_GfxSetDefaultInfo only once */
    if (haveCalledSetDefaultInfo == 0)
    {
        fb_GfxSetDefaultInfo( );
        haveCalledSetDefaultInfo = 1;
    }
    
    switch (depth)
    {
    case 0:
        /* Emulate a QB screen mode: */
        
        screenNum = width;
        fullScreenFlag = height;
        depth = DEFAULT_DEPTH;
        
        switch (screenNum)
        {
        case 0:  /* exit graphics mode */
            SDL_QuitSubSystem(SDL_INIT_VIDEO);
            fb_GfxRestoreHandlers();
            fb_GfxInfo.videoIsInitialized = 0;
            return FB_RTERROR_OK;
        
        case 12:
            width = 640; height = 480;
            font = (Uint8*)fb_GfxDefaultFont8x16;
            break;
        
        case 13:
            width = 320; height = 200;
            font = (Uint8*)fb_GfxDefaultFont8x8;
            break;
        
        default:
            return FB_RTERROR_ILLEGALFUNCTIONCALL;  /* Invalid mode specified */
        }
        break;

    /* Supported color depths: */
    case 8:
    case 15:
    case 16:
    case 24:
    case 32:
        break;
    
    default:
        return FB_RTERROR_ILLEGALFUNCTIONCALL;  /* Invalid depth specified */
    }
    
    if (fullScreenFlag != 0) flags |= SDL_FULLSCREEN;
    
    /*
     * FIXME: If SDL can't set up the video subsystem, it's not exactly
     *        an illegal function call... need a better error code.
     */
    if ( fb_GfxInitVideo() ) return FB_RTERROR_ILLEGALFUNCTIONCALL;
    
    fb_GfxInfo.screen = SDL_SetVideoMode(width, height, depth, flags);
    if (fb_GfxInfo.screen == NULL) return FB_RTERROR_ILLEGALFUNCTIONCALL;

    if( fullScreenFlag == 0 )
    {
    	char buff[64];
    	sprintf( buff, "%s (%dx%dx%d)", FBGFX_WINDOWTITLE, width, height, depth );
    	SDL_WM_SetCaption( buff, NULL );
    }
    else
    {
        /*
         * Prevents a weird bug where you can't draw in (0, 0)-(15, 15)
         * Only happens in fullscreen modes
         */
        SDL_WarpMouse(width >> 1, height >> 1);
        
        /*
         * Hide the cursor:
         * (should we only do this when emulating QB modes?)
         */
        SDL_ShowCursor(SDL_DISABLE);
    }

    fb_GfxInfo.gfx_cursorX = width >> 1;
    fb_GfxInfo.gfx_cursorY = height >> 1;
    fb_GfxInfo.view.x = 0; fb_GfxInfo.view.w = width;
    fb_GfxInfo.view.y = 0; fb_GfxInfo.view.h = height;
    fb_GfxInfo.winActive = 0;

    if (depth > 8)
    {
        fb_GfxInfo.defaultColor = 0xFFFFFFFF;
    }
    else
    {
        fb_GfxInfo.paletteChanged = 0;
        fb_GfxInfo.defaultColor = 15;
    }

    fb_GfxSetFont(font);

    if (screenNum != 0)  // Are we emulating a QB screen mode?
    {
        if (depth == 8)
        {
            /* casting to SDL_Color* kills a warning */
            SDL_SetColors(fb_GfxInfo.screen, (SDL_Color*)fb_GfxDefaultPal, 0, 256);
            fb_GfxSetFontBg(0, 0);
        }
        else
        {
            fb_GfxSetFontBg(0x000000FF, 0);
        }

        fb_GfxInfo.tabDist = 64;
        fb_GfxInfo.printAffectedByView = 0;
        fb_GfxInfo.letterWrap = 1;
        fb_GfxInfo.printScrolls = 1;
        fb_GfxInfo.textCoords = 1;
    }
    else
    {
        if (fb_GfxInfo.fontData == NULL) fb_GfxSetFont((Uint8*)fb_GfxDefaultFont8x16);
    }

    fb_GfxTakeHandlers();
    fb_GfxResetVgaPalEmu();

    /* Shouldn't do this more than once: */
    if (haveSetQuitAtExit == 0)
    {
        fb_AtExit(fb_GfxQuit);
        haveSetQuitAtExit = 1;
    }

    return FB_RTERROR_OK;
}

//{
//    int screenNum = width;
//
//    if (screenNum == 0)  // exit graphics mode
//    {
//        if ( fb_GfxInfo.sdlIsInitialized && SDL_WasInit(SDL_INIT_VIDEO) )
//        {
//            SDL_QuitSubSystem(SDL_INIT_VIDEO);
//        }
//        fb_GfxInfo.videoIsInitialized = 0;
//
//        fb_GfxRestoreHandlers();
//
//        return FB_RTERROR_OK;
//    }
//
//	fb_GfxSetDefaultInfo( );
//
//	/* calling the extended version? */
//	if( (height != 0) && (depth != 0) )
//		return fb_GfxScreenEx( width, height, depth, fullScreenFlag );
//
//
//    /* enter or change graphics mode */
//
//    switch (screenNum)
//    {
//    case 12:
//        width = 640; height = 480;
//        fb_GfxSetFont(8, 16, (void*)fb_GfxDefaultFont8x16);
//        break;
//    case 13:
//        width = 320; height = 200;
//        fb_GfxSetFont(8, 8, (void*)fb_GfxDefaultFont8x8);
//        break;
//    default:
//        return FB_RTERROR_ILLEGALFUNCTIONCALL;  /* Invalid mode specified */
//    }
//
//    if ( fb_GfxScreenEx(width, height, DEFAULT_DEPTH, (DEFAULT_FLAGS & SDL_FULLSCREEN)) )
//    {
//        return FB_RTERROR_ILLEGALFUNCTIONCALL;
//    }
//
//    #if DEFAULT_DEPTH == 8
//        /* casting to SDL_Color* kills a warning */
//        SDL_SetColors(fb_GfxInfo.screen, (SDL_Color*)fb_GfxDefaultPal, 0, 256);
//        fb_GfxSetFontBg(0, -1);
//    #else
//        fb_GfxSetFontBg(0x000000FF, -1);
//    #endif
//
//    fb_GfxInfo.tabDist = 64;
//    fb_GfxInfo.printAffectedByView = 1;
//    fb_GfxInfo.letterWrap = 1;
//    fb_GfxInfo.printScrolls = 1;
//    fb_GfxInfo.textCoords = 1;
//
//    return FB_RTERROR_OK;
//}
//
///* Returns nonzero on error: */
//static int fb_GfxScreenEx(int width, int height, int depth, int fullScreenFlag)
//{
//    Uint32 flags;
//
//    if (fb_GfxInfo.sdlIsInitialized == 0)
//    {
//        if ( SDL_Init(SDL_INIT_VIDEO) ) return -1;
//        fb_GfxInfo.sdlIsInitialized = 1;
//
//        SDL_EnableKeyRepeat(SDL_DEFAULT_REPEAT_DELAY, SDL_DEFAULT_REPEAT_INTERVAL);
//    }
//    else if (SDL_WasInit(SDL_INIT_VIDEO) == 0)
//    {
//        if ( SDL_InitSubSystem(SDL_INIT_VIDEO) ) return -1;
//    }
//
//    fb_GfxInfo.videoIsInitialized = SDL_WasInit(SDL_INIT_VIDEO);
//
//    flags = DEFAULT_FLAGS;
//    if (fullScreenFlag)
//        flags |= SDL_FULLSCREEN;
//    else
//        flags &= ~SDL_FULLSCREEN;
//
//    fb_GfxInfo.screen = SDL_SetVideoMode(width, height, depth, flags);
//    if (fb_GfxInfo.screen == NULL) return -1;
//
//    if( fullScreenFlag == 0 )
//    {
//    	char buff[64];
//    	sprintf( buff, "%s (%dx%dx%d)", FBGFX_WINDOWTITLE, width, height, depth );
//    	SDL_WM_SetCaption( buff, NULL );
//    }
//
//    fb_GfxInfo.gfx_cursorX = width >> 1;
//    fb_GfxInfo.gfx_cursorY = height >> 1;
//
//    if (depth > 8)
//    {
//        fb_GfxInfo.defaultColor = 0xFFFFFFFF;
//        fb_GfxSetFontBg(0x000000FF, 1);
//    }
//    else
//    {
//        fb_GfxInfo.defaultColor = 15;
//        fb_GfxSetFontBg(0, 1);
//    }
//
//    fb_GfxInfo.view.x = 0; fb_GfxInfo.view.w = width;
//    fb_GfxInfo.view.y = 0; fb_GfxInfo.view.h = height;
//
//    fb_GfxInfo.winActive = 0;
//    fb_GfxInfo.paletteChanged = 0;
//
//    if (fb_GfxInfo.fontData == NULL) fb_GfxSetFont(8, 16, (void*)fb_GfxDefaultFont8x16);
//
//    fb_GfxInfo.tabDist = 0;
//    fb_GfxInfo.printAffectedByView = 0;
//    fb_GfxInfo.letterWrap = 0;
//    fb_GfxInfo.printScrolls = 0;
//    fb_GfxInfo.textCoords = 0;
//
//    fb_GfxTakeHandlers();
//
//    fb_GfxResetVgaPalEmu();
//    fb_AtExit(fb_GfxQuit);
//
//    return FB_RTERROR_OK;
//}

void fb_GfxColor ( int fc, int bc )
{
    SANITY_CHECK;

    if (fb_GfxInfo.screen->format->BytesPerPixel == 1)
    {
        fc &= 0xFF;
        bc &= 0xFF;
    }

    fb_GfxInfo.defaultColor = fc;
    fb_GfxInfo.fontBGColor = bc;
}

FBCALL int fb_GfxFlip (int frompage, int topage)
{
    SANITY_CHECK -1;

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

