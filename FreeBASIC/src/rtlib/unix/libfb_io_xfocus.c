/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2010 The FreeBASIC development team.
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
 * io_xfocus.c -- XTerm focus query function
 *
 * chng: jul/2005 written [lillo]
 *
 */

#include "fb.h"

#ifdef WITH_X
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

#endif /* WITH_X */

/*:::::*/
int fb_hXTermInitFocus(void)
{
#if WITH_X
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

#endif

	return 0;
}


/*:::::*/
void fb_hXTermExitFocus(void)
{
#if WITH_X
	ref_count--;
	if (ref_count > 0)
		return;
	X.CloseDisplay(display);
	fb_hDynUnload(&xlib);
#endif
}


/*:::::*/
int fb_hXTermHasFocus(void)
{
#if WITH_X
	Window focus_window;
	int dummy;
	
	X.GetInputFocus(display, &focus_window, &dummy);
	
	return (focus_window == xterm_window);
#else
	return 0;
#endif
}

