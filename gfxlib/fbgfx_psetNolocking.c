#include "QB_gfx_main.h"

/*
 *   Used by fb_GfxFEllipseEx and fb_GfxSLineEx
 *   No 0xRRGGBBAA->native format conversion, no locking
 */
FBCALL int fb_GfxPsetNoLocking (Sint16 x, Sint16 y, Uint32 color)
{
    int bpp;
    Uint8 *p, *colorptr;

    /*
     * Honor clipping setup at pixel level
     */
    if ((x < clip_xmin) || (x > clip_xmax) || (y < clip_ymin) || (y > clip_ymax))
    {
        return 0;
    }

    /*
     * Get destination format
     */
    bpp = fb_GfxInfo.screen->format->BytesPerPixel;
    p = (Uint8 *) fb_GfxInfo.screen->pixels + y * fb_GfxInfo.screen->pitch + x * bpp;

    switch (bpp) {
    case 1:
        *p = color;
        break;
    case 2:
        *(Uint16 *) p = color;
        break;
    case 3:
        if (SDL_BYTEORDER == SDL_BIG_ENDIAN) {
            p[0] = (Uint8)(color >> 16);
            p[1] = (Uint8)(color >> 8);
            p[2] = (Uint8)color;
        } else {
            p[0] = (Uint8)color;
            p[1] = (Uint8)(color >> 8);
            p[2] = (Uint8)(color >> 16);
        }
        break;
    case 4:
        *(Uint32 *) p = color;
        break;
    }              /* switch */

    return 0;
}

