#include "QB_gfx_main.h"
#include "QB_gfx_text.h"

int fb_GfxCsrlin (void)
{
    int y;

    if (fb_GfxInfo.fontData == NULL) fb_GfxSetFont(8, 16, (void*)fb_GfxDefaultFont8x16);

    if (fb_GfxInfo.textCoords) {
        y = fb_GfxInfo.text_cursorY / fb_GfxInfo.charHeight + 1;
    } else {
        y = fb_GfxInfo.text_cursorY;
    }

    return y;
}

