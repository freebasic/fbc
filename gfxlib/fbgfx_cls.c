#include "QB_gfx_main.h"

void fb_GfxCls (int color)
{
    Uint8 *colorptr;

    SANITY_CHECK

    fb_GfxInfo.text_cursorX = 0;
    fb_GfxInfo.text_cursorY = 0;

    if (fb_GfxInfo.screen->format->BitsPerPixel > 8)
    {
        if (color != DEFAULT_COLOR)
        {
            /* Convert 0xRRGGBBAA to screen pixel format: */
            colorptr = (Uint8 *) & color;
            if (SDL_BYTEORDER == SDL_BIG_ENDIAN)
            {
                color = SDL_MapRGB(fb_GfxInfo.screen->format, colorptr[0], colorptr[1], colorptr[2]);
            }
            else
            {
                color = SDL_MapRGB(fb_GfxInfo.screen->format, colorptr[3], colorptr[2], colorptr[1]);
            }
        }
        else
        {
            color = SDL_MapRGB(fb_GfxInfo.screen->format, 0, 0, 0);
        }
    }
    else
    {
        if (color == DEFAULT_COLOR) color = 0;
        color &= 0xFF;
    }

    SDL_FillRect(fb_GfxInfo.screen, NULL, color);
}

