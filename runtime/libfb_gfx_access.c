/*
 * access.c -- low level screen access routines
 *
 * chng: jan/2005 written [lillo]
 *
 */

#include "fb_gfx.h"


/*:::::*/
FBCALL void fb_GfxLock(void)
{
	if (!__fb_gfx)
		return;

	if (__fb_gfx->lock_count == 0)
		__fb_gfx->driver->lock();

	++__fb_gfx->lock_count;
}


/*:::::*/
FBCALL void fb_GfxUnlock(int start_line, int end_line)
{
	FB_GFXCTX *context = fb_hGetContext();
	
	if (!__fb_gfx)
		return;
	if (start_line < 0)
		start_line = 0;
	if (end_line < 0)
		end_line = __fb_gfx->h - 1;
	if ((__fb_gfx->visible_page == context->work_page) && (start_line <= end_line) && (end_line < __fb_gfx->h))
		fb_hMemSet(__fb_gfx->dirty + start_line, TRUE, end_line - start_line + 1);

	if (__fb_gfx->lock_count != 0) {
		--__fb_gfx->lock_count;
		if (__fb_gfx->lock_count == 0)
			__fb_gfx->driver->unlock();
	}
}


/*:::::*/
FBCALL void *fb_GfxScreenPtr(void)
{
	FB_GFXCTX *context = fb_hGetContext();
	
	if (!__fb_gfx)
		return NULL;
	fb_hPrepareTarget(context, NULL);
	fb_hSetPixelTransfer(context, MASK_A_32);
	
	return context->line[0];
}
