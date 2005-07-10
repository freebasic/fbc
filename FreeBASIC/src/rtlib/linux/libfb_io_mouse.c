/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2005 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
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
 * io_mouse.c -- Linux console mouse functions implementation
 *
 * chng: jul/2005 written [lillo]
 *
 */

#include "fb.h"
#include "fb_rterr.h"
#include "fb_linux.h"
#include <gpm.h>

typedef int (*GPM_OPEN)(Gpm_Connect *, int);
typedef int (*GPM_CLOSE)(void);
typedef int (*GPM_GETEVENT)(Gpm_Event *);

static void *gpm_lib;
static GPM_OPEN fb_Gpm_Open;
static GPM_CLOSE fb_Gpm_Close;
static GPM_GETEVENT fb_Gpm_GetEvent;
static int *fb_gpm_fd;
static Gpm_Connect conn;
static int mouse_x = 0, mouse_y = 0, mouse_z = 0, mouse_buttons = 0;


/*:::::*/
static void mouse_update(int cb, int cx, int cy)
{
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


/*:::::*/
static void mouse_handler(void)
{
	Gpm_Event event;
	fd_set set;
	struct timeval tv = { 0, 0 };
	int count = 0;
	
	if (fb_con.inited != INIT_CONSOLE)
		return;
	
	FD_ZERO(&set);
	FD_SET(*fb_gpm_fd, &set);
	
	while ((select(FD_SETSIZE, &set, NULL, NULL, &tv) > 0) && (count < 16)) {
		if (fb_Gpm_GetEvent(&event) > 0) {
			mouse_x += event.dx;
			mouse_y += event.dy;
			if (mouse_x < 0) mouse_x = 0;
			if (mouse_x >= fb_con.w) mouse_x = fb_con.w - 1;
			if (mouse_y < 0) mouse_y = 0;
			if (mouse_y >= fb_con.h) mouse_y = fb_con.h - 1;
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
	if (fb_con.inited == INIT_CONSOLE) {
		if (!(gpm_lib = dlopen(NULL, RTLD_LAZY)))
			return -1;
		if (!dlsym(gpm_lib, "Gpm_Open")) {
			dlclose(gpm_lib);
			if (!(gpm_lib = dlopen("libgpm.so.1", RTLD_LAZY)))
				return -1;
		}
		fb_Gpm_Open = (GPM_OPEN)dlsym(gpm_lib, "Gpm_Open");
		fb_Gpm_Close = (GPM_CLOSE)dlsym(gpm_lib, "Gpm_Close");
		fb_Gpm_GetEvent = (GPM_GETEVENT)dlsym(gpm_lib, "Gpm_GetEvent");
		fb_gpm_fd = (int *)dlsym(gpm_lib, "gpm_fd");

		conn.eventMask = ~0;
		conn.defaultMask = ~GPM_HARD;
		conn.maxMod = ~0;
		conn.minMod = 0;
		if ((!fb_Gpm_Open) || (!fb_Gpm_Close) || (!fb_Gpm_GetEvent) || (!fb_gpm_fd) || (fb_Gpm_Open(&conn, 0) < 0)) {
			dlclose(gpm_lib);
			return -1;
		}
	}
	else {
		fputs("\e[?1003h", fb_con.f_out);
		fb_con.mouse_update = mouse_update;
	}
	return 0;
}


/*:::::*/
static void mouse_exit(void)
{
	if (fb_con.inited == INIT_CONSOLE) {
		fb_Gpm_Close();
		dlclose(gpm_lib);
	}
	else {
		fputs("\e[?1003l", fb_con.f_out);
		fb_con.mouse_update = NULL;
	}
	fb_con.mouse_handler = NULL;
}


/*:::::*/
int fb_ConsoleGetMouse(int *x, int *y, int *z, int *buttons)
{
	int temp_z, temp_buttons;
	
	if (!fb_con.inited)
		return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);
	
	if (!z)
		z = &temp_z;
	if (!buttons)
		buttons = &temp_buttons;

	BG_LOCK();
	
	if (!fb_con.mouse_handler) {
		if (!mouse_init()) {
			fb_con.mouse_init = mouse_init;
			fb_con.mouse_exit = mouse_exit;
			fb_con.mouse_handler = mouse_handler;
		}
		else {
			*x = *y = *z = *buttons = -1;
			BG_UNLOCK();
			return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);
		}
	}
	else {
		if (fb_con.inited != INIT_CONSOLE)
			fb_hGetCh(FALSE);
		*x = mouse_x;
		*y = mouse_y;
		*z = mouse_z;
		*buttons = mouse_buttons;
	}
	
	BG_UNLOCK();
	
	return FB_RTERROR_OK;
}


/*:::::*/
int fb_ConsoleSetMouse(int x, int y, int cursor)
{
	return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);
}
