#include "QB_gfx_main.h"

/*
 *   Convert coords to absolute 
 *   Used by fb_GfxLine and fb_GfxGet
 */
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

