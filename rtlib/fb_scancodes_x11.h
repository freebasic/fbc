#ifndef __FB_SCANCODES_X11_H__
#define __FB_SCANCODES_X11_H__

#include <X11/Xlib.h>
#include <X11/keysym.h>

typedef struct KeysymToScancode {
	KeySym keysym;
	int scancode;
} KeysymToScancode;

extern const KeysymToScancode fb_keysym_to_scancode[];

#endif
