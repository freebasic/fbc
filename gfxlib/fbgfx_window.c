#include "QB_gfx_main.h"

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

