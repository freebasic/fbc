#ifndef __FB_GFX_COCOA_H__
#define __FB_GFX_COCOA_H__

#include <sys/types.h>
#include "../fb_gfx.h"

extern const GFXDRIVER fb_gfxDriverCocoa;

extern void fb_hCocoaLock(void);
extern void fb_hCocoaUnlock(void);
extern void fb_hCocoaWaitVSync(void);
extern void fb_hCocoaSetPalette(int index, int r, int g, int b);
extern int fb_hCocoaGetMouse(int *x, int *y, int *z, int *buttons, int *clip);
extern void fb_hCocoaSetMouse(int x, int y, int cursor, int clip);
extern void fb_hCocoaSetWindowTitle(char *title);
extern int fb_hCocoaSetWindowPos(int x, int y);
extern int *fb_hCocoaFetchModes(int depth, int *size);
extern int fb_hCocoaScreenInfo(ssize_t *width, ssize_t *height, ssize_t *depth, ssize_t *refresh);

#endif
