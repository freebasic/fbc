#include "QB_gfx_main.h"

/*
 *   Translates window coordinates to screen (not view) coordinates
 *   Used by everything (pset, circle, etc) that takes window coordinates
 */
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

