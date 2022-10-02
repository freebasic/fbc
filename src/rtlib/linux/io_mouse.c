/* console mode mouse functions */

#include "../fb.h"

#include "../unix/fb_private_console.h"

#ifndef DISABLE_GPM

#include "../fb_private_hdynload.h"
#include <gpm.h>
#include <stddef.h>
#include <sys/select.h>

/* Reject compiling against Debian's libgpm 1.19.6-12 - 1.19.6-25 (2002 - 2007),
   which had a custom patch adding the wdx/wdy fields in the middle of struct Gpm_Event,
   instead of at the end like in later versions.
   Only gpm 1.20.4 (2008) or later is supported, see comment below.
   Unfortunately gpm.h does not seem to provide a GPM_VERSION macro or similar to check this. */
STATIC_ASSERT(offsetof(Gpm_Event, wdx) == offsetof(Gpm_Event, margin) + sizeof(enum Gpm_Margin));
STATIC_ASSERT(offsetof(Gpm_Event, wdy) == offsetof(Gpm_Event, wdx) + 2);

typedef int (*GPM_OPEN)(Gpm_Connect *, int);
typedef int (*GPM_CLOSE)(void);
typedef int (*GPM_GETEVENT)(Gpm_Event *);

typedef struct {
	GPM_OPEN Open;
	GPM_CLOSE Close;
	GPM_GETEVENT GetEvent;
	int *fd;
} GPM_FUNCS;

static FB_DYLIB gpm_lib = NULL;
static GPM_FUNCS gpm = { NULL, NULL, NULL, NULL };
static Gpm_Connect conn;

#endif /* #ifndef DISABLE_GPM */

static int has_focus = TRUE;
static int mouse_x = 0, mouse_y = 0, mouse_z = 0, mouse_buttons = 0;

static void mouse_update(int cb, int cx, int cy)
{
	if (has_focus) {
		cb &= ~0x1C;
		if (cb >= 0x60) {
			if (cb - 0x60)
				mouse_z--;
			else
				mouse_z++;
		} else {
			if (cb >= 0x40)
				cb -= 0x20;
			switch (cb) {
				case 0x20:	mouse_buttons |= 0x1; break;
				case 0x21:	mouse_buttons |= 0x4; break;
				case 0x22:	mouse_buttons |= 0x2; break;
				case 0x23:	mouse_buttons = 0; break;
			}
		}
		mouse_x = cx - 0x21;
		mouse_y = cy - 0x21;
	}
}

static void mouse_handler(void)
{
#ifndef DISABLE_X11
	if (__fb_con.inited == INIT_X11) {
		if (fb_hXTermHasFocus()) {
			if (!has_focus)
				mouse_buttons = 0;
			has_focus = TRUE;
		} else {
			if (has_focus) {
				mouse_x = -1;
				mouse_y = -1;
				mouse_buttons = -1;
			}
			has_focus = FALSE;
		}
		return;
	}
#endif

#ifndef DISABLE_GPM
	Gpm_Event event;
	fd_set set;
	struct timeval tv = { 0, 0 };
	int count = 0;

	FD_ZERO(&set);
	FD_SET(*gpm.fd, &set);

	while ((select(FD_SETSIZE, &set, NULL, NULL, &tv) > 0) && (count < 16)) {
		if (gpm.GetEvent(&event) > 0) {
			mouse_x += event.dx;
			mouse_y += event.dy;

			fb_hRecheckConsoleSize( TRUE );
			if (mouse_x < 0) mouse_x = 0;
			if (mouse_x >= __fb_con.w) mouse_x = __fb_con.w - 1;
			if (mouse_y < 0) mouse_y = 0;
			if (mouse_y >= __fb_con.h) mouse_y = __fb_con.h - 1;

			mouse_z += event.wdy;

			if (event.type & GPM_DOWN)
				mouse_buttons |= ((event.buttons & 0x4) >> 2) | ((event.buttons & 0x2) << 1) | ((event.buttons & 0x1) << 1);
			else if (event.type & GPM_UP)
				mouse_buttons &= ~(((event.buttons & 0x4) >> 2) | ((event.buttons & 0x2) << 1) | ((event.buttons & 0x1) << 1));
		}
		count++;
	}
#endif /* #ifndef DISABLE_GPM */
}

static int mouse_init(void)
{
	if (__fb_con.inited == INIT_CONSOLE) {
#ifdef DISABLE_GPM
		return -1;
#else
		/**
		 * Only gpm 1.20.4 (2008) or later (after soname bump from 1 to 2) is supported,
		 * to avoid ABI compatibility issues with older versions.
		 *
		 * libgpm.so.2 (from gpm version 1.20.4 or later) always has wdx/wdy at the *end* of struct Gpm_Event,
		 * both in upstream and Debian versions.
		 * Older versions before the soname bump (i.e. libgpm.so.1) may have them at different offsets,
		 * due to a custom patch in Debian's libgpm 1.19.6-12 - 1.19.6-25 (2002 - 2007), or not at all.
		 *
		 * I found no relevant changes regarding the other parts of the API we use:
		 * The signatures of the Gpm_Open, Gpm_Close, Gpm_GetEvent functions,
		 * the gpm_fd global variable, and the Gpm_Connect struct, are apparently unchanged.
		 */
		const char *const funcs[] = {
			"Gpm_Open", /* functions */
			"Gpm_Close",
			"Gpm_GetEvent",
			"gpm_fd", /* global variable */
			NULL
		};
		gpm_lib = fb_hDynLoad("libgpm.so.2", funcs, (void **)&gpm);
		if (!gpm_lib) {
			return -1;
		}

		conn.eventMask = ~0;
		conn.defaultMask = ~GPM_HARD;
		conn.maxMod = ~0;
		conn.minMod = 0;
		if (gpm.Open(&conn, 0) < 0) {
			fb_hDynUnload(&gpm_lib);
			return -1;
		}
#endif
	}
	else {
		fb_hTermOut(SEQ_INIT_XMOUSE, 0, 0);
		__fb_con.mouse_update = mouse_update;
#ifndef DISABLE_X11
		fb_hXTermInitFocus();
#endif
	}
	return 0;
}

static void mouse_exit(void)
{
	if (__fb_con.inited == INIT_CONSOLE) {
#ifndef DISABLE_GPM
		gpm.Close();
		fb_hDynUnload(&gpm_lib);
#endif
	}
	else {
		fb_hTermOut(SEQ_EXIT_XMOUSE, 0, 0);
#ifndef DISABLE_X11
		fb_hXTermExitFocus();
#endif
		__fb_con.mouse_update = NULL;
	}
	__fb_con.mouse_handler = NULL;
	__fb_con.mouse_exit = NULL;
}

int fb_ConsoleGetMouse(int *x, int *y, int *z, int *buttons, int *clip)
{
	if (!__fb_con.inited) {
		if (x) *x = -1;
		if (y) *y = -1;
		if (z) *z = -1;
		if (buttons) *buttons = -1;
		if (clip) *clip = -1;
		return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);
	}

	BG_LOCK();

	fb_hStartBgThread( );

	if (!__fb_con.mouse_handler) {
		if (!mouse_init()) {
			__fb_con.mouse_init = mouse_init;
			__fb_con.mouse_exit = mouse_exit;
			__fb_con.mouse_handler = mouse_handler;
		} else {
			if (x) *x = -1;
			if (y) *y = -1;
			if (z) *z = -1;
			if (buttons) *buttons = -1;
			if (clip) *clip = -1;
			BG_UNLOCK();
			return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);
		}
	}

	if (__fb_con.inited != INIT_CONSOLE)
		fb_hGetCh(FALSE);

	if (x) *x = mouse_x;
	if (y) *y = mouse_y;
	if (z) *z = mouse_z;
	if (buttons) *buttons = mouse_buttons;
	if (clip) *clip = 0;

	BG_UNLOCK();

	return FB_RTERROR_OK;
}

int fb_ConsoleSetMouse( int x, int y, int cursor, int clip )
{
	return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
}
