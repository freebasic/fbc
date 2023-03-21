/* common linux internal definitions */

#ifndef __FB_GFX_LINUX_H__
#define __FB_GFX_LINUX_H__

#ifndef DISABLE_FBDEV

#define DOUBLE_CLICK_TIME		250

extern const GFXDRIVER fb_gfxDriverFBDev;

extern int fb_hFBDevInfo(ssize_t *width, ssize_t *height, ssize_t *depth, ssize_t *refresh);

#endif

#endif
