#include "QB_gfx_main.h"

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

