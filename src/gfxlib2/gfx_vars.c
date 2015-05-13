/* all global variables are defined here */

#include "fb_gfx.h"

FBGFX *__fb_gfx = NULL;
void *(*fb_hMemCpy)(void *dest, const void *src, size_t size) = memcpy;
void *(*fb_hMemSet)(void *dest, int value, size_t size) = memset;
void *(*fb_hPixelCpy)(void *dest, const void *src, size_t size) = NULL;
void *(*fb_hPixelSet)(void *dest, int color, size_t size) = NULL;
unsigned int *__fb_color_conv_16to32 = NULL;
char *__fb_window_title = NULL;
char *__fb_gfx_driver_name = NULL;
