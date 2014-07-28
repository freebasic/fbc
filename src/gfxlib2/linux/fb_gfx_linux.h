/* common linux internal definitions */

#ifndef __FB_GFX_LINUX_H__
#define __FB_GFX_LINUX_H__

/* Disable fbdev driver on ARM, because it currently uses x86 inline asm */
#if !defined HOST_X86 && !defined HOST_X86_64
	#define DISABLE_FBDEV
#endif

#ifndef DISABLE_FBDEV

#define DOUBLE_CLICK_TIME		250

extern GFXDRIVER fb_gfxDriverFBDev;

extern int fb_hFBDevInfo(ssize_t *width, ssize_t *height, ssize_t *depth, ssize_t *refresh);

#endif

#endif
