#include "QB_gfx_main.h"

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
