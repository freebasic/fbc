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
    ToDo: INPUT and LINE INPUT?
          Replace default fonts with more complete rips
*/


#include "QB_gfx_main.h"
#include "QB_gfx_pal.h"

#define FBGFX_NO_FONTDATA_EXTERN
#include "QB_gfx_text.h"
#undef FBGFX_NO_FONTDATA_EXTERN

//#define SANITY_CHECK_CONDITION   (!fb_GfxInfo.sdlIsInitialized || !fb_GfxInfo.screen || !fb_GfxInfo.videoIsInitialized)
//#define SANITY_CHECK             if (SANITY_CHECK_CONDITION) return /*-1*/;

/*
extern struct fb_GfxVgaPalEmuStruct fb_GfxVgaPalEmu;
extern struct fb_GfxInfoStruct fb_GfxInfo;
*/

const Uint8 fb_GfxDefaultFont8x8[2048] = {
#include "font8x8.h"
};

const Uint8 fb_GfxDefaultFont8x16[4096] = {
#include "font8x16.h"
};

FBCALL int fb_GfxSetFont (Uint8 width, Uint8 height, void *fontData)
{
    fb_GfxInfo.fontData = fontData;
    fb_GfxInfo.charWidth  = width;
    fb_GfxInfo.charHeight = height;

    return 0;
}

FBCALL int fb_GfxSetFontBg (Uint32 bgColor, int transBgFlag)
{
    if (transBgFlag < -1 || transBgFlag > 1) return -1;

    if (bgColor != DEFAULT_COLOR)
    {
        if (fb_GfxInfo.screen->format->BytesPerPixel == 1) bgColor &= 0xFF;
        fb_GfxInfo.fontBGColor = bgColor;
    }

    if (transBgFlag != -1)
    {
        fb_GfxInfo.fontBgTransparent = transBgFlag;
    }

    return 0;
}

FBCALL int fb_GfxSetFormat (int tabStopDistance, int affectedByViewFlag,
                               int letterWrapFlag, int scrollFlag, int locateTextCoords)
{
    if (tabStopDistance < -1 ||
        affectedByViewFlag < -1 || affectedByViewFlag > 1 ||
        letterWrapFlag < -1 || letterWrapFlag > 1 ||
        scrollFlag < -1 || scrollFlag > 1 ||
        locateTextCoords < -1 || locateTextCoords > 1)
    {
        return -1;
    }

    if (tabStopDistance != -1) fb_GfxInfo.tabDist = tabStopDistance;
    if (affectedByViewFlag != -1)
    {
        if (fb_GfxInfo.printAffectedByView != affectedByViewFlag)
        {
            fb_GfxInfo.printAffectedByView = affectedByViewFlag;
            fb_GfxInfo.text_cursorX = 0;
            fb_GfxInfo.text_cursorY = 0;
        }
    }
    if (letterWrapFlag != -1) fb_GfxInfo.letterWrap = letterWrapFlag;
    if (scrollFlag != -1) fb_GfxInfo.printScrolls = scrollFlag;
    if (locateTextCoords != -1) fb_GfxInfo.textCoords = locateTextCoords;

    return 0;
}

