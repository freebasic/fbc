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

#define BUFFER_SIZE		256

#define MOUSE_NONE		0
#define MOUSE_GPM		1
#define MOUSE_PS2		2
#define MOUSE_IMPS2		3
#define MOUSE_MS		4
#define MOUSE_XTERM		5


static int mouse_fd, mouse_driver;
static int mouse_x = 0, mouse_y = 0, mouse_z = 0, mouse_buttons = 0;
static int buffer_start = 0;
static unsigned char buffer[BUFFER_SIZE];


/*:::::*/
static void mouse_sync(void)
{
	fd_set set;
	int result;
	struct timeval tv = { 0, 0 };
	char bitbucket;

	do {
		FD_ZERO(&set);
		FD_SET(mouse_fd, &set);
		result = select(FD_SETSIZE, &set, NULL, NULL, &tv);
		if (result > 0)
			read(mouse_fd, &bitbucket, 1);
	} while (result > 0);
}


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
	const int packet_size[5] = { 0, 5, 3, 4, 3 };
	int bytes_read, i, dx = 0, dy = 0;
	fd_set set;
	struct timeval tv = { 0, 0 };
	
	if ((mouse_driver == MOUSE_NONE) || (mouse_driver == MOUSE_XTERM))
		return;
	
	FD_ZERO(&set);
	FD_SET(mouse_fd, &set);
	if (select(FD_SETSIZE, &set, NULL, NULL, &tv) <= 0)
		return;
	bytes_read = read(mouse_fd, &buffer[buffer_start], BUFFER_SIZE - buffer_start);
	if (bytes_read > 0) {
		bytes_read += buffer_start;
		for (i = 0; i < (bytes_read - (packet_size[mouse_driver] - 1)); i += packet_size[mouse_driver]) {
			switch (mouse_driver) {
				case MOUSE_GPM:
					if ((buffer[i] & 0xF8) != 0x80) {
						i -= packet_size[mouse_driver] - 1;
						continue;
					}
					mouse_buttons = (((~buffer[i]) & 0x4) >> 2) | ((~buffer[i]) & 0x2) | (((~buffer[i]) & 0x1) << 2);
					dx = (signed char)buffer[i + 1] + (signed char)buffer[i + 3];
					dy = -((signed char)buffer[i + 2] + (signed char)buffer[i + 4]);
					break;
				case MOUSE_PS2:
					if ((buffer[i] & 0xC0) != 0) {
						i -= packet_size[mouse_driver] - 1;
						continue;
					}
					mouse_buttons = buffer[i] & 0x7;
					dx = (buffer[i] & 0x10) ? (buffer[i + 1] - 256) : buffer[i + 1];
					dy = (buffer[i] & 0x20) ? -(buffer[i + 2] - 256) : -buffer[i + 2];
					break;
				case MOUSE_IMPS2:
					mouse_buttons = (buffer[i] & 0x7) | ((buffer[i] & 0xC0) >> 3);
					dx = (buffer[i] & 0x10) ? (buffer[i + 1] - 256) : buffer[i + 1];
					dy = (buffer[i] & 0x20) ? -(buffer[i + 2] - 256) : -buffer[i + 2];
					switch (buffer[i + 3] & 0xF) {
						case 0xF:	mouse_z++; break;
						case 0x1:	mouse_z--; break;
					}
					break;
				case MOUSE_MS:
					if ((buffer[i] & 0x40) != 0x40) {
						i -= packet_size[mouse_driver] - 1;
						continue;
					}
					mouse_buttons = (buffer[i] & 0x30) >> 4;
					dx = (signed char)(((buffer[i] & 0x3) << 6) | (buffer[i + 1] & 0x3F));
					dy = (signed char)(((buffer[i] & 0xC) << 4) | (buffer[i + 2] & 0x3F));
					break;
			}
			mouse_x += dx;
			mouse_y += dy;
			if (mouse_x < 0) mouse_x = 0;
			if (mouse_x >= fb_con.w) mouse_x = fb_con.w - 1;
			if (mouse_y < 0) mouse_y = 0;
			if (mouse_y >= fb_con.h) mouse_y = fb_con.h - 1;
		}
		if (i < bytes_read) {
			memcpy(buffer, &buffer[i], bytes_read - i);
			buffer_start = bytes_read - i;
		}
		else
			buffer_start = 0;
	}
}


/*:::::*/
static int mouse_init(void)
{
	const char *gpm_device = "/dev/gpmdata";
	const char *ps2_device[] = { "/dev/input/mice", "/dev/usbmouse", "/dev/psaux", NULL };
	const char *ms_device = "/dev/mouse";
	const char set_imps2[] = { 0xF3, 200, 0xF3, 100, 0xF3, 80 };
	unsigned char reset = 0xFF, query_ps2 = 0xF2, ch;
	fd_set set;
	struct timeval tv;
	struct termios mouse_termios;
	int i;
	
	mouse_driver = MOUSE_NONE;
	
	if (fb_con.inited == INIT_CONSOLE) {
		mouse_fd = open(gpm_device, O_RDONLY | O_NONBLOCK);
		if (mouse_fd >= 0) {
			mouse_sync();
			mouse_driver = MOUSE_GPM;
		}
		else {
			for (i = 0; ps2_device[i]; i++) {
				mouse_fd = open(ps2_device[i], O_RDWR | O_NONBLOCK);
				if (mouse_fd < 0)
					mouse_fd = open(ps2_device[i], O_RDONLY | O_NONBLOCK);
				if (mouse_fd >= 0) {
					mouse_driver = MOUSE_PS2;
					if (i == 0) {
						write(mouse_fd, &set_imps2, 6);
						write(mouse_fd, &reset, 1);
					}
					mouse_sync();
					if (write(mouse_fd, &query_ps2, 1) == 1) {
						do {
							FD_ZERO(&set);
							FD_SET(mouse_fd, &set);
							tv.tv_sec = 1;
							tv.tv_usec = 0;
							if (select(FD_SETSIZE, &set, NULL, NULL, &tv) < 1)
								break;
						} while ((read(mouse_fd, &ch, 1) == 1) && ((ch == 0xFA) || (ch == 0xAA)));
						if ((ch == 3) || (ch == 4))
							mouse_driver = MOUSE_IMPS2;
					}
					break;
				}
			}
			if (mouse_fd < 0) {
				mouse_fd = open(ms_device, O_RDONLY | O_NONBLOCK);
				if (mouse_fd >= 0) {
					tcgetattr(mouse_fd, &mouse_termios);
					mouse_termios.c_iflag = IGNBRK | IGNPAR;
					mouse_termios.c_oflag = 0;
					mouse_termios.c_lflag = 0;
					mouse_termios.c_line = 0;
					mouse_termios.c_cc[VTIME] = 0;
					mouse_termios.c_cc[VMIN] = 1;
					mouse_termios.c_cflag = CREAD | CLOCAL | HUPCL;
					mouse_termios.c_cflag |= CS8;
					mouse_termios.c_cflag |= B1200;
					tcsetattr(mouse_fd, TCSAFLUSH, &mouse_termios);
					mouse_driver = MOUSE_MS;
				}
			}
		}
		if (mouse_fd < 0)
			return -1;
	}
	else {
		fputs("\e[?1003h", fb_con.f_out);
		fb_con.mouse_update = mouse_update;
		mouse_driver = MOUSE_XTERM;
	}
	return 0;
}


/*:::::*/
static void mouse_exit(void)
{
	if (fb_con.inited == INIT_CONSOLE) {
		close(mouse_fd);
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
	}
	if (mouse_driver == MOUSE_NONE) {
		*x = *y = *z = *buttons = -1;
		BG_UNLOCK();
		return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);
	}
	else {
		if (mouse_driver == MOUSE_XTERM)
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
	if ((mouse_driver == MOUSE_NONE) || (mouse_driver == MOUSE_XTERM))
		return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);
	else {
		mouse_x = x;
		mouse_y = y;
	}
	
	return FB_RTERROR_OK;
}
