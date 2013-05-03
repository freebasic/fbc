#ifndef DISABLE_X11

#include <X11/Xlib.h>
#include <X11/keysym.h>

typedef Display *(*XOPENDISPLAY)(char *);
typedef int (*XCLOSEDISPLAY)(Display *);
typedef void (*XQUERYKEYMAP)(Display *, unsigned char *);
typedef int (*XDISPLAYKEYCODES)(Display *, int *, int *);
typedef KeySym* (*XKEYCODETOKEYSYM)(Display *, KeyCode, int, int *);

extern unsigned char fb_x11keycode_to_scancode[256];

void fb_hInitX11KeycodeToScancodeTb
	(
		Display *display,
		XDISPLAYKEYCODES DisplayKeycodes,
		XKEYCODETOKEYSYM KeycodeToKeysym
	);

#endif
