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

#define FBGFX_NO_PALEMU_EXTERN
#include "QB_gfx_pal.h"
#undef FBGFX_NO_PALEMU_EXTERN


const SDL_Color fb_GfxDefaultPal[256] = {
#include "defaultPalette.h"
};

struct fb_GfxVgaPalEmuStruct fb_GfxVgaPalEmu = {0, 0, 0, 0, {0, 0, 0}};

/*
 *   Used by fb_GfxScreenEx
 */
void fb_GfxResetVgaPalEmu (void)
{
    fb_GfxVgaPalEmu.readColor = 0;
    fb_GfxVgaPalEmu.writeColor = 0;
    fb_GfxVgaPalEmu.readIndex = 0;
    fb_GfxVgaPalEmu.writeIndex = 0;
}

/*
 *   Used by fb_GfxFlip
 */
void fb_GfxFlushPalette (void)
{
    SDL_Palette *p;

    p = fb_GfxInfo.screen->format->palette;
    SDL_SetPalette(fb_GfxInfo.screen, SDL_PHYSPAL, p->colors, 0, p->ncolors);
    fb_GfxInfo.paletteChanged = 0;
}

