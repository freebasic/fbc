/*
 *  libgfx2 - FreeBASIC's alternative gfx library
 *	Copyright (C) 2005 Angelo Mottola (a.mottola@libero.it)
 *
 *  This library is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU Lesser General Public
 *  License as published by the Free Software Foundation; either
 *  version 2.1 of the License, or (at your option) any later version.
 *
 *  This library is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *  Lesser General Public License for more details.
 *
 *  You should have received a copy of the GNU Lesser General Public
 *  License along with this library; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/

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
