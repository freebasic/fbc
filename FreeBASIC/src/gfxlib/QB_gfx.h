/*
    Everything returns nonzero on error
    For all colors: alpha not supported
        Because if it were supported, and you tried to draw 100% translucent
        yellow (DEFAULT_COLOR), you'd get the current foreground color instead (see below)
    use DEFAULT_COLOR for color when the color parameter is omitted
    color is 0 to 255 in 8 bit, otherwise 0xRRGGBBAA (black is 0x000000FF)
    palette changes take effect at next Flip
    Get/Put don't store palette, so putting 8 bit to 15-32 bit won't work
    style not supported for boxes yet
*/

#ifndef QB_GFX_H_
#define QB_GFX_H_

#include <SDL/SDL.h>
#include "QB_gfx_main.h"
#include "QB_gfx_text.h"
#include "QB_gfx_pal.h"

#endif
