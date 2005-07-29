/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2005 Andre V. T. Vicentini (av1ctor@yahoo.com.br) and others.
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
 * io_xfocus.c -- XTerm focus query function
 *
 * chng: jul/2005 written [lillo]
 *
 */

#include "fb.h"
#include "fb_linux.h"
#include <X11/Xlib.h>

typedef Display *(*XOPENDISPLAY)(char *);
typedef int (*XCLOSEDISPLAY)(Display *);
typedef int (*XGETINPUTFOCUS)(Display *, Window *, int *);

static int ref_count = 0;
static void *xlib;
static Display *display;
static Window xterm_window;
static XOPENDISPLAY fb_XOpenDisplay;
static XCLOSEDISPLAY fb_XCloseDisplay;
static XGETINPUTFOCUS fb_XGetInputFocus;


/*:::::*/
int fb_hXTermInitFocus(void)
{
	int dummy;
	
	ref_count++;
	if (ref_count > 1)
		return 0;
	
	if (!(xlib = dlopen(NULL, RTLD_LAZY)))
		return -1;
	if (!dlsym(xlib, "XOpenDisplay")) {
		dlclose(xlib);
		if (!(xlib = dlopen("libX11.so", RTLD_LAZY)))
			return -1;
	}
	fb_XOpenDisplay = (XOPENDISPLAY)dlsym(xlib, "XOpenDisplay");
	fb_XCloseDisplay = (XCLOSEDISPLAY)dlsym(xlib, "XCloseDisplay");
	fb_XGetInputFocus = (XGETINPUTFOCUS)dlsym(xlib, "XGetInputFocus");
	if ((!fb_XOpenDisplay) || (!fb_XCloseDisplay) || (!fb_XGetInputFocus))
		return -1;
	
	display = fb_XOpenDisplay(NULL);
	if (!display)
		return -1;
	
	fb_XGetInputFocus(display, &xterm_window, &dummy);
	
	return 0;
}


/*:::::*/
void fb_hXTermExitFocus(void)
{
	ref_count--;
	if (ref_count > 0)
		return;
	fb_XCloseDisplay(display);
	dlclose(xlib);
}


/*:::::*/
int fb_hXTermHasFocus(void)
{
	Window focus_window;
	int dummy;
	
	fb_XGetInputFocus(display, &focus_window, &dummy);
	
	return (focus_window == xterm_window);
}
