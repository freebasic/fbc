#include "QB_gfx_main.h"

static int fb_GfxGetEx (Sint16 x, Sint16 y, Uint16 w, Uint16 h, void *dst)
{
    SDL_Surface *surface;
    SDL_Rect r;
    int ret, depth;

    if (w & 0xE000) return -1; /* It's too wide - maximun width is 2**13-1 */

    r.x = x; r.w = w;
    r.y = y; r.h = h;

    depth = fb_GfxInfo.screen->format->BitsPerPixel;

    w <<= 3;
    switch (depth)
    {
    case 8: // QB compatible
        break;
    case 15:
        w += 1;
        break;
    case 16:
        w += 2;
        break;
    case 24:
        w += 3;
        break;
    default:
        w += 4;
        break;
    }

    *((Uint16*)dst) = w;
    *((Uint16*)dst + 1) = h;

    surface = SDL_CreateRGBSurfaceFrom((Uint16*)dst + 2, r.w, r.h, depth,
                                       r.w * fb_GfxInfo.screen->format->BytesPerPixel,
                                       fb_GfxInfo.screen->format->Rmask,
                                       fb_GfxInfo.screen->format->Gmask,
                                       fb_GfxInfo.screen->format->Bmask,
                                       fb_GfxInfo.screen->format->Amask);

    if (depth == 8)
    {
        SDL_SetColors(surface, fb_GfxInfo.screen->format->palette->colors, 0, 256);
    }

    ret = SDL_BlitSurface(fb_GfxInfo.screen, &r, surface, NULL);

    SDL_FreeSurface(surface);

    return ret;
}

FBCALL int fb_GfxGet (float x1, float y1, float x2, float y2, void *elementAddress, int coordType, FBARRAY *desc)
{
    Sint16 w, h,
           rx1, ry1, rx2, ry2;

    SANITY_CHECK

    fb_GfxConvertCoords(&x1, &y1, &x2, &y2, coordType);
    fb_GfxTransCoord(x1, y1, &rx1, &ry1);
    fb_GfxTransCoord(x2, y2, &rx2, &ry2);

    if (rx1 > rx2)
    {
        w = rx1;
        rx1 = rx2;
        rx2 = w;
    }
    if (ry1 > ry2)
    {
        h = ry1;
        ry1 = ry2;
        ry2 = h;
    }

    w = rx2 - rx1 + 1;
    h = ry2 - ry1 + 1;

    /* If AddressOfLastByteToBeOverwritten+1 > AddressOfLastByteAllocated+1 */
    if ( (Uint8*)elementAddress + 4 + w * h > (Uint8*)(desc->ptr) + desc->size )
    {
        return -1;
    }

    return fb_GfxGetEx(rx1, ry1, w, h, elementAddress);
}
