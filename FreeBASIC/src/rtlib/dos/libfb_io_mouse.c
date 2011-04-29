/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2011 The FreeBASIC development team.
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
 *
 *  As a special exception, the copyright holders of this library give
 *  you permission to link this library with independent modules to
 *  produce an executable, regardless of the license terms of these
 *  independent modules, and to copy and distribute the resulting
 *  executable under terms of your choice, provided that you also meet,
 *  for each linked independent module, the terms and conditions of the
 *  license of that module. An independent module is a module which is
 *  not derived from or based on this library. If you modify this library,
 *  you may extend this exception to your version of the library, but
 *  you are not obligated to do so. If you do not wish to do so, delete
 *  this exception statement from your version.
 */

/*
 * io_mouse.c -- mouse functions for DOS console mode apps
 *
 * chng: jun/2005 written [DrV]
 *
 */

#include "fb.h"

#include <dpmi.h>

static int inited = -1;
static int wheel_ok = FALSE;
static int wheel_pos;
static __dpmi_regs regs;

/*:::::*/
int fb_ConsoleGetMouse( int *x, int *y, int *z, int *buttons, int *clip )
{	
	if (inited == -1) {
		regs.x.ax = 0x0;	/* detect mouse driver and mouse existence */
		__dpmi_int(0x33, &regs);
		inited = (regs.x.ax == 0) ? 0 : 1;
		
		regs.x.ax = 0x11;	/* detect CuteMouse 2.0+ wheel api */
		__dpmi_int(0x33, &regs);
		wheel_ok = ((regs.x.ax == 0x574D) && (regs.x.cx & 1)) ? TRUE : FALSE;
		
		wheel_pos = 0;
	}
	
	if (inited == 0) {
		if (x) *x = -1;
		if (y) *y = -1;
		if (z) *z = -1;
		if (buttons) *buttons = -1;
		return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);
	}
	
	regs.x.ax = 0x3;
	__dpmi_int(0x33, &regs);
	
	if (wheel_ok) wheel_pos -= *(signed char *)(&regs.h.bh);
	
	if (x) *x = regs.x.cx / 8;	/* char width is 8 pixels */
	if (y) *y = regs.x.dx / 8;	/* char height is 8 pixels */
	if (z) *z = wheel_pos;
	if (buttons) *buttons = regs.h.bl;
	if (clip) *clip = 0;
	
	return FB_RTERROR_OK;
}


/*:::::*/
int fb_ConsoleSetMouse( int x, int y, int cursor, int clip )
{
	int mx, my;
	
	fb_ConsoleGetMouse(&mx, &my, NULL, NULL, NULL);
	
	if (inited == 0) return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);
	
	if (x >= 0) mx = x * 8;
	if (y >= 0) my = y * 8;
	
	regs.x.ax = 0x4;
	regs.x.cx = mx;
	regs.x.dx = my;
	__dpmi_int(0x33, &regs);
	
	return FB_RTERROR_OK;
}
