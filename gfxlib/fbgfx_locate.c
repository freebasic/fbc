#include "QB_gfx_main.h"
#include "QB_gfx_text.h"

void fb_GfxLocate (int xOrRow, int yOrColumn, int cursor)
{
    int x, y, invalid;

    if (fb_GfxInfo.fontData == NULL) fb_GfxSetFont(8, 16, (void*)fb_GfxDefaultFont8x16);

    if (fb_GfxInfo.textCoords)
    {
        invalid = 0;
        x = (yOrColumn - 1) * fb_GfxInfo.charWidth;
        y = (xOrRow - 1) * fb_GfxInfo.charHeight;

        if (x < 0 || y < 0) invalid = 1;

        if (fb_GfxInfo.printAffectedByView)
        {
            if (x + fb_GfxInfo.charWidth > fb_GfxInfo.view.w ||
                y + fb_GfxInfo.charHeight > fb_GfxInfo.view.h) invalid = 1;
        }
        else
        {
            if (x + fb_GfxInfo.charWidth > fb_GfxInfo.screen->w ||
                y + fb_GfxInfo.charHeight > fb_GfxInfo.screen->h) invalid = 1;
        }

        if (invalid) return;
    }
    else
    {
        x = xOrRow;
        y = yOrColumn;
    }

    fb_GfxInfo.text_cursorX = x;
    fb_GfxInfo.text_cursorY = y;
}

