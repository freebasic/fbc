/* console mode mouse functions */

#include "../fb.h"
#include "fb_private_console.h"
#include <dpmi.h>

static int inited = -1;
static int wheel_ok = FALSE;
static int wheel_pos;
static __dpmi_regs regs;

int fb_ConsoleGetMouse( int *x, int *y, int *z, int *buttons, int *clip )
{
	if (inited == -1) {
		regs.x.ax = 0x0;	/* detect mouse driver and mouse existence */
		__dpmi_int(0x33, &regs);
		inited = (regs.x.ax == 0) ? 0 : 1;

		regs.x.ax = 0x11;	/* detect CuteMouse 2.0+ wheel api */
		__dpmi_int(0x33, &regs);
		wheel_ok = ((regs.x.ax == 0x574D) && (regs.x.cx & 1));

		wheel_pos = 0;
	}

	if (inited == 0) {
		if (x) *x = -1;
		if (y) *y = -1;
		if (z) *z = -1;
		if (buttons) *buttons = -1;
		if (clip) *clip = -1;
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
