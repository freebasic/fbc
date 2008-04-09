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
 * linux.c -- list of linux gfx drivers
 *
 * chng: jan/2005 written [lillo]
 *
 */

#include "fb_gfx.h"

#ifdef WITH_X
#include "fb_gfx_x11.h"
#endif

#include "fb_gfx_linux.h"
#include <unistd.h>

const GFXDRIVER *__fb_gfx_drivers_list[] = {
#ifdef WITH_X
	&fb_gfxDriverX11,
#ifdef HAVE_GL_GL_H
	&fb_gfxDriverOpenGL,
#endif
#endif
	&fb_gfxDriverFBDev,
	NULL
};

/*:::::*/
void fb_hScreenInfo(int *width, int *height, int *depth, int *refresh)
{
#ifdef WITH_X
	if (fb_hX11ScreenInfo(width, height, depth, refresh))
#endif
		if (fb_hFBDevInfo(width, height, depth, refresh))
			*width = *height = *depth = *refresh = 0;
}
