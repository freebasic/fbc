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
 * getmouse.c -- GETMOUSE function support.
 *
 * chng: jan/2005 written [lillo]
 *
 */

#include "fb_gfx.h"


/*:::::*/
int fb_GfxGetMouse(int *x, int *y, int *z, int *buttons, int *clip)
{
	int failure = TRUE;
	int temp_z, temp_buttons, temp_clip;

	if (!z)
		z = &temp_z;
	if (!buttons)
		buttons = &temp_buttons;
	if (!clip)
		clip = &temp_clip;
	if ((__fb_gfx) && (__fb_gfx->driver->get_mouse)) {
		DRIVER_LOCK();
		failure = __fb_gfx->driver->get_mouse(x, y, z, buttons, clip);
		DRIVER_UNLOCK();
	}
	if (failure) {
		*x = *y = *z = *buttons = *clip = -1;
		return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);
	}
	return fb_ErrorSetNum( FB_RTERROR_OK );
}
