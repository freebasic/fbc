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
#include "QB_gfx_text.h"

static int fb_GfxScrollUp (SDL_Rect r, Uint16 scrollAmount, Uint32 fillColor);

static int fb_GfxScrollUp (SDL_Rect r, Uint16 scrollAmount, Uint32 fillColor)
{
    SDL_Rect dst;

    if (SANITY_CHECK_CONDITION || scrollAmount < 1) return -1;

    r.y += scrollAmount;
    r.h -= scrollAmount;

    dst.x = r.x;
    dst.y = r.y - scrollAmount;

    if ( SDL_BlitSurface(fb_GfxInfo.screen, &r, fb_GfxInfo.screen, &dst) ) return -1;

    if (fillColor != DEFAULT_COLOR)
    {
        r.y += r.h - scrollAmount;
        r.h = scrollAmount;
        SDL_FillRect(fb_GfxInfo.screen, &r, fillColor);
    }

    return 0;
}

void fb_GfxPrintBuffer (char *str, int mask)
{
    SDL_Surface *surface;
    SDL_Color palette[2];
    SDL_Rect src, dst, oldClip, textRect;
    Uint32 backFillCol;
    char c;
    Sint16 ox, x, y;

    if (SANITY_CHECK_CONDITION || str == NULL) return;

    if (fb_GfxInfo.fontData == NULL) fb_GfxSetFont((Uint8*)fb_GfxDefaultFont8x16);

    /* Create a temporary SDL surface for the font data: */
    surface = SDL_CreateRGBSurfaceFrom(fb_GfxInfo.fontData,
                                       fb_GfxInfo.charWidth, fb_GfxInfo.charHeight << 8,
                                       1, (fb_GfxInfo.charWidth+7) >> 3,
                                       0, 0, 0, 0);
    if (surface == NULL) return;

    if (fb_GfxInfo.screen->format->BytesPerPixel == 1)
    {
        palette[0] = fb_GfxInfo.screen->format->palette->colors[fb_GfxInfo.fontBGColor];
        palette[1] = fb_GfxInfo.screen->format->palette->colors[fb_GfxInfo.defaultColor];
        
        backFillCol = fb_GfxInfo.fontBGColor;
    }
    else
    {
        /* Convert from 0xRRGGBBAA: */
        palette[0].r = (Uint8)(fb_GfxInfo.fontBGColor >> 24);
        palette[0].g = (Uint8)(fb_GfxInfo.fontBGColor >> 16);
        palette[0].b = (Uint8)(fb_GfxInfo.fontBGColor >> 8);
        palette[1].r = (Uint8)(fb_GfxInfo.defaultColor >> 24);
        palette[1].g = (Uint8)(fb_GfxInfo.defaultColor >> 16);
        palette[1].b = (Uint8)(fb_GfxInfo.defaultColor >> 8);
        
        backFillCol = SDL_MapRGB(fb_GfxInfo.screen->format, palette[0].r, palette[0].g, palette[0].b);
    }
    
    SDL_SetColors(surface, palette, 0, 2);

    if (fb_GfxInfo.fontBgTransparent) SDL_SetColorKey(surface, SDL_SRCCOLORKEY, 0);

    if (fb_GfxInfo.printAffectedByView)
    {
        textRect = fb_GfxInfo.view;
    }
    else
    {
        oldClip = fb_GfxInfo.screen->clip_rect;
        SDL_SetClipRect(fb_GfxInfo.screen, NULL);
        textRect = fb_GfxInfo.screen->clip_rect;
    }
    
    x = fb_GfxInfo.text_cursorX;
    y = fb_GfxInfo.text_cursorY;
    
    src.x = 0;
    src.w = fb_GfxInfo.charWidth;
    src.h = fb_GfxInfo.charHeight;

    while ( (c = *str++) != '\0' )
    {
        if (fb_GfxInfo.tabDist)  /* If special character checking is on */
        {

            switch (c)
            {
            case 9:
                ox = x;

                x = (x / fb_GfxInfo.tabDist + 1) * fb_GfxInfo.tabDist;

                if (fb_GfxInfo.fontBgTransparent == 0)
                {
                    dst.x = ox + textRect.x;  dst.w = x-ox;
                    dst.y = y  + textRect.y;  dst.h = fb_GfxInfo.charHeight;
                    SDL_FillRect(fb_GfxInfo.screen, &dst, backFillCol);
                }

                if ( fb_GfxInfo.letterWrap && (x + fb_GfxInfo.charWidth > textRect.w) )
                    goto doTheCarriageReturnThang;

                continue;

            case 10:
            case 13:
doTheCarriageReturnThang:
                x = 0;
                y += fb_GfxInfo.charHeight;

                if ( fb_GfxInfo.printScrolls && (y + fb_GfxInfo.charHeight > textRect.h) )
                {
                    fb_GfxScrollUp(textRect, fb_GfxInfo.charHeight, backFillCol);
                    y -= fb_GfxInfo.charHeight;
                }
                
                continue;
            }
        }

        /* Blit the character: */
        src.y = (Uint8)c * fb_GfxInfo.charHeight;
        dst.x = x + textRect.x;
        dst.y = y + textRect.y;
        SDL_BlitSurface(surface, &src, fb_GfxInfo.screen, &dst);

        x += fb_GfxInfo.charWidth;
        if (fb_GfxInfo.letterWrap && (x + fb_GfxInfo.charWidth > textRect.w))
            goto doTheCarriageReturnThang;
        
    } /* while */

    SDL_FreeSurface(surface);

    /* Restore the original clipping rectangle, if it was changed: */
    if (fb_GfxInfo.printAffectedByView == 0)
        SDL_SetClipRect(fb_GfxInfo.screen, &oldClip);

    fb_GfxInfo.text_cursorX = x;
    fb_GfxInfo.text_cursorY = y;

    return;
}
