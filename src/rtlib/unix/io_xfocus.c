/* XTerm focus query helpers */

#include "../fb.h"

#ifndef DISABLE_X11
#include "../fb_private_hdynload.h"
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
static FB_DYLIB xlib;
static X_FUNCS X = { NULL, NULL, NULL };
static Display *display;
static Window xterm_window;
#endif

int fb_hXTermInitFocus(void)
{
#ifndef DISABLE_X11
	const char *const funcs[] = { "XOpenDisplay", "XCloseDisplay", "XGetInputFocus", NULL };
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

void fb_hXTermExitFocus(void)
{
#ifndef DISABLE_X11
	ref_count--;
	if (ref_count > 0)
		return;
	X.CloseDisplay(display);
	fb_hDynUnload(&xlib);
#endif
}

int fb_hXTermHasFocus(void)
{
#ifndef DISABLE_X11
	Window focus_window;
	int dummy;

	X.GetInputFocus(display, &focus_window, &dummy);

	return (focus_window == xterm_window);
#else
	return 0;
#endif
}
