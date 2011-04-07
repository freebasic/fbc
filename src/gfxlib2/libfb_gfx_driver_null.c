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
 * driver_null.c -- null driver for non-displayed gfx handling
 *
 * chng: aug/2005 written [lillo]
 *
 */

#include "fb_gfx.h"

static void driver_dummy(void);


const GFXDRIVER __fb_gfxDriverNull =
{
	"Null",			/* char *name; */
	NULL,			/* int (*init)(int w, int h, char *title, int fullscreen); */
	NULL,			/* void (*exit)(void); */
	driver_dummy,	/* void (*lock)(void); */
	driver_dummy,	/* void (*unlock)(void); */
	NULL,			/* void (*set_palette)(int index, int r, int g, int b); */
	NULL,			/* void (*wait_vsync)(void); */
	NULL,			/* int (*get_mouse)(int *x, int *y, int *z, int *buttons); */
	NULL,			/* void (*set_mouse)(int x, int y, int cursor); */
	NULL,			/* void (*set_window_title)(char *title); */
	NULL,			/* int (*set_window_pos)(int x, int y); */
	NULL,			/* int *(*fetch_modes)(int depth, int *size); */
	NULL			/* void (*flip)(void); */
};


/*:::::*/
static void driver_dummy(void)
{
}

