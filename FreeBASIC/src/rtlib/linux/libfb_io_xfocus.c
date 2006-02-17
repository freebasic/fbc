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

typedef struct {
    XOPENDISPLAY OpenDisplay;
    XCLOSEDISPLAY CloseDisplay;
    XGETINPUTFOCUS GetInputFocus;
} X_FUNCS;

static int ref_count = 0;
static void *xlib;
static X_FUNCS X = { NULL };
static Display *display;
static Window xterm_window;



/*:::::*/
int fb_hXTermInitFocus(void)
{
    const char *funcs[] = { "XOpenDisplay", "XCloseDisplay", "XGetInputFocus", NULL };
	int dummy;
	
	ref_count++;
	if (ref_count > 1)
		return 0;
	
	xlib = fb_hDynLoad("libX11.so", funcs, (void **)&X);
    if (!xlib)
		return -1;
	
	display = X.OpenDisplay(NULL);
	if (!display)
		return -1;
	
	X.GetInputFocus(display, &xterm_window, &dummy);
	
	return 0;
}


/*:::::*/
void fb_hXTermExitFocus(void)
{
	ref_count--;
	if (ref_count > 0)
		return;
	X.CloseDisplay(display);
	fb_hDynUnload(&xlib);
}


/*:::::*/
int fb_hXTermHasFocus(void)
{
	Window focus_window;
	int dummy;
	
	X.GetInputFocus(display, &focus_window, &dummy);
	
	return (focus_window == xterm_window);
}
