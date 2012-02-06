/* Linux console mouse functions implementation */

#include "fb.h"
#include <gpm.h>

typedef int (*GPM_OPEN)(Gpm_Connect *, int);
typedef int (*GPM_CLOSE)(void);
typedef int (*GPM_GETEVENT)(Gpm_Event *);

typedef struct {
    GPM_OPEN Open;
    GPM_CLOSE Close;
    GPM_GETEVENT GetEvent;
    int *fd;
} GPM_FUNCS;


static void *gpm_lib = NULL;
static GPM_FUNCS gpm = { NULL };
static Gpm_Connect conn;
static int has_focus = TRUE;
static int mouse_x = 0, mouse_y = 0, mouse_z = 0, mouse_buttons = 0;


/*:::::*/
static void mouse_update(int cb, int cx, int cy)
{
	if (has_focus) {
		cb &= ~0x1C;
		if (cb >= 0x60) {
			if (cb - 0x60)
				mouse_z--;
			else
				mouse_z++;
		}
		else {
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


/*:::::*/
static void mouse_handler(void)
{
	Gpm_Event event;
	fd_set set;
	struct timeval tv = { 0, 0 };
	int count = 0;

#ifndef DISABLE_X
	if (__fb_con.inited == INIT_X11) {
		if (fb_hXTermHasFocus()) {
			if (!has_focus)
				mouse_buttons = 0;
			has_focus = TRUE;
		}
		else {
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
	
	FD_ZERO(&set);
	FD_SET(*gpm.fd, &set);
	
	while ((select(FD_SETSIZE, &set, NULL, NULL, &tv) > 0) && (count < 16)) {
		if (gpm.GetEvent(&event) > 0) {
			mouse_x += event.dx;
			mouse_y += event.dy;
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
}


/*:::::*/
static int mouse_init(void)
{
    const char *funcs[] = { "Gpm_Open", "Gpm_Close", "Gpm_GetEvent", "gpm_fd", NULL };
    
	if (__fb_con.inited == INIT_CONSOLE) {
	    gpm_lib = fb_hDynLoad("libgpm.so.1", funcs, (void **)&gpm);
	    if (!gpm_lib)
			return -1;

		conn.eventMask = ~0;
		conn.defaultMask = ~GPM_HARD;
		conn.maxMod = ~0;
		conn.minMod = 0;
		if (gpm.Open(&conn, 0) < 0) {
		    fb_hDynUnload(&gpm_lib);
			return -1;
		}
	}
	else {
		fb_hTermOut(SEQ_INIT_XMOUSE, 0, 0);
		__fb_con.mouse_update = mouse_update;
#ifndef DISABLE_X
		fb_hXTermInitFocus();
#endif
	}
	return 0;
}


/*:::::*/
static void mouse_exit(void)
{
	if (__fb_con.inited == INIT_CONSOLE) {
		gpm.Close();
		fb_hDynUnload(&gpm_lib);
	}
	else {
		fb_hTermOut(SEQ_EXIT_XMOUSE, 0, 0);
#ifndef DISABLE_X
		fb_hXTermExitFocus();
#endif
		__fb_con.mouse_update = NULL;
	}
	__fb_con.mouse_handler = NULL;
	__fb_con.mouse_exit = NULL;
}


/*:::::*/
int fb_ConsoleGetMouse(int *x, int *y, int *z, int *buttons, int *clip)
{
	int temp_z, temp_buttons;
	
	if (!__fb_con.inited)
		return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);
	
	if (!z)
		z = &temp_z;
	if (!buttons)
		buttons = &temp_buttons;

	BG_LOCK();
	
	if (!__fb_con.mouse_handler) {
		if (!mouse_init()) {
			__fb_con.mouse_init = mouse_init;
			__fb_con.mouse_exit = mouse_exit;
			__fb_con.mouse_handler = mouse_handler;
		}
		else {
			*x = *y = *z = *buttons = -1;
			BG_UNLOCK();
			return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);
		}
	}
	if (__fb_con.inited != INIT_CONSOLE)
		fb_hGetCh(FALSE);
	*x = mouse_x;
	*y = mouse_y;
	*z = mouse_z;
	*buttons = mouse_buttons;
	*clip = 0;
	
	BG_UNLOCK();
	
	return FB_RTERROR_OK;
}


/*:::::*/
int fb_ConsoleSetMouse(int x, int y, int cursor, int clip)
{
	return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);
}
