#include "QB_gfx_main.h"
#include "QB_gfx_text.h"

int fb_GfxPos (void)
{
    int x;

    if (fb_GfxInfo.fontData == NULL) fb_GfxSetFont(8, 16, (void*)fb_GfxDefaultFont8x16);

    if (fb_GfxInfo.textCoords) {
        x = fb_GfxInfo.text_cursorX / fb_GfxInfo.charWidth + 1;
    } else {
        x = fb_GfxInfo.text_cursorX;
    }

    return x;
}

