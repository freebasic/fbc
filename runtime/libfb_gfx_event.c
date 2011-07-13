/*
 * event.c -- system events retrieving
 *
 * chng: oct/2006 written [lillo]
 *
 */

#include "fb_gfx.h"


/*:::::*/
FBCALL int fb_GfxEvent(EVENT *event)
{
	EVENT *e = NULL;
	
	if (!__fb_gfx)
		return FB_FALSE;
	
	EVENT_LOCK();
	if (__fb_gfx->event_head != __fb_gfx->event_tail) {
		e = &__fb_gfx->event_queue[__fb_gfx->event_head];
		if (event)
			__fb_gfx->event_head = (__fb_gfx->event_head + 1) & (MAX_EVENTS - 1);
	}
	if (e && event)
		fb_hMemCpy(event, e, sizeof(EVENT));
	EVENT_UNLOCK();
	
	return e ? FB_TRUE : FB_FALSE;
}
