#include "QB_gfx_main.h"
#include "QB_gfx_text.h"

void fb_GfxWidth (int width, int height)
{
    int h;

    if (fb_GfxInfo.textCoords)
    {
        if (fb_GfxInfo.printAffectedByView) {
            h = fb_GfxInfo.view.h;
        } else {
            h = fb_GfxInfo.screen->h;
        }

        if ( (((h / height) + 4) >> 3) < 2)
        {
            fb_GfxSetFont(8, 8, (void*)fb_GfxDefaultFont8x8);
        }
        else
        {
            fb_GfxSetFont(8, 16, (void*)fb_GfxDefaultFont8x16);
        }
    }
    else
    {
        if (width != 8) return;

        switch (height)
        {
        case 8:
            fb_GfxSetFont(8, 8, (void*)fb_GfxDefaultFont8x8);
            break;
        case 16:
            fb_GfxSetFont(8, 16, (void*)fb_GfxDefaultFont8x16);
            break;
        default:
            return;
//            break;
        }
    }

}

