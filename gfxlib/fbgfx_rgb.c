#include "QB_gfx_main.h"

FBCALL Uint32 fb_GfxRgb (Uint8 r, Uint8 g, Uint8 b)
{
    if (SANITY_CHECK_CONDITION || fb_GfxInfo.screen->format->BitsPerPixel > 8)
    {
        return (r << 24) + (g << 16) + (b << 8) + 0xFF;
    }
    else
    {
        return SDL_MapRGB(fb_GfxInfo.screen->format, r, g, b);
    }
}

