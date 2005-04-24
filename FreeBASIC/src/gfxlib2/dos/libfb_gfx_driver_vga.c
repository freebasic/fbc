/*
 *  libgfx2 - FreeBASIC's alternative gfx library
 *	Copyright (C) 2005 Angelo Mottola (a.mottola@libero.it)
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
 * vga.c -- VGA gfx driver
 *
 * chng: apr/2005 written [DrV]
 *
 */

#include "gfx_dos.h"

static int driver_init(char *title, int w, int h, int depth, int refresh_rate, int flags);
static void driver_exit(void);
static void driver_lock(void);
static void driver_unlock(void);

static void draw_mouse(void);

GFXDRIVER fb_gfxDriverVGA =
{
	"VGA",			/* char *name; */
	driver_init,		/* int (*init)(char *title, int w, int h, int depth, int refresh_rate, int flags); */
	driver_exit,		/* void (*exit)(void); */
	driver_lock,		/* void (*lock)(void); */
	driver_unlock,		/* void (*unlock)(void); */
	fb_dos_vga_set_palette,	/* void (*set_palette)(int index, int r, int g, int b); */
	fb_dos_vga_wait_vsync,	/* void (*wait_vsync)(void); */
	fb_dos_get_mouse,	/* int (*get_mouse)(int *x, int *y, int *z, int *buttons); */
	fb_dos_set_mouse,	/* void (*set_mouse)(int x, int y, int cursor); */
	fb_dos_set_window_title,/* void (*set_window_title)(char *title); */
	NULL			/* void (*flip)(void); */
};

static unsigned char mouse_buffer[320 * MOUSE_HEIGHT];

static unsigned char temp_buffer[320 * 200];

/*:::::*/
static int driver_init(char *title, int w, int h, int depth, int refresh_rate, int flags)
{
	fb_dos_detect();
	
	if (flags & DRIVER_OPENGL)
		return -1;
	
	if ((w != 320) || (h != 200) || (depth > 8)) {
		return -1;
	}
	
	fb_dos_save_video_mode();
	
	/* set video mode */
	fb_dos.regs.x.ax = 0x13;
	__dpmi_int(0x10, &fb_dos.regs);
		
	fb_dos_init(title, w, h, depth, refresh_rate, flags);
	
	fb_dos.mouse_draw = draw_mouse;
	
	return 0;

}

/*:::::*/
static void driver_exit(void)
{
	fb_dos_restore_video_mode();
	
	fb_dos_exit();
}

/*:::::*/
static void driver_lock(void)
{

}

/*:::::*/
static void driver_unlock(void)
{
	// copy the entire buffer
	//movedata(_my_ds(), (unsigned)fb_mode->framebuffer, _dos_ds, 0xA0000, _size);
	
	int y;
	unsigned int buffer = (unsigned int)fb_mode->framebuffer;
	unsigned int screen = 0xA0000;

	int i;
	int x;
	int count;
	int excess;
	char *dest;
	char *p;
	
	int mouse_count = 0;
	
	//fb_hMemCpy(temp_buffer, fb_mode->framebuffer, 320 * 200);
	
	//buffer = (unsigned int)temp_buffer;


	/* ***** */
	//fb_dos.regs.x.ax = 0x3;
	//__dpmi_int(0x33, &fb_dos.regs);
	//fb_dos.mouse_x = fb_dos.regs.x.cx;
	//fb_dos.mouse_y = fb_dos.regs.x.dx;
	/* ***** */

	#if 0
	/* draw mouse pointer on buffer */
	dest = fb_dos.mouse_y * fb_dos.w + fb_dos.mouse_x + temp_buffer;
	p = fb_dos_mouse_image;
	for (i = 0; (i < MOUSE_HEIGHT) && (i + fb_dos.mouse_y < fb_dos.h); i++)
	{
		count = *p;
		excess = fb_dos.w - count;
		
		_farsetsel(_dos_ds);
		x = fb_dos.mouse_x;
		for (p++ ; (count > 0); count--, p++, dest++, x++) {
			if ((*p != -1) && (x < fb_dos.w)) *dest = *p;
		}
		dest += excess;
		p += count;
		fb_mode->dirty[i + fb_dos.mouse_y] = TRUE;
	}
	#endif
	
	for (y = fb_dos.mouse_y; y < fb_dos.mouse_y + MOUSE_HEIGHT; y++) {
		fb_mode->dirty[y] = TRUE;
	}
	
	for (y = 0; y < fb_dos.h; y++, buffer += fb_dos.w, screen += fb_dos.w) {
		if (fb_mode->dirty[y]) {
			if (y == fb_dos.mouse_y) {
				mouse_count = MOUSE_HEIGHT;
				p = fb_dos_mouse_image;
			}
#if 0
			if (mouse_count > 0) {

				fb_hMemCpy(temp_buffer, buffer, 320);
				count = *p;
				excess = fb_dos.w - count;
				
				x = fb_dos.mouse_x;
				dest = temp_buffer + x;
				for (p++ ; (count > 0); count--, p++, dest++, x++) {
					if ((*p != -1) && (x < fb_dos.w)) *dest = *p;
				}
				dest += excess;
				p += count;
				movedata(_my_ds(), temp_buffer, _dos_ds, screen, fb_dos.w);

				mouse_count--;

			} else {
#endif
				movedata(_my_ds(), buffer, _dos_ds, screen, fb_dos.w);
//			}
		}
	}
	
	fb_hMemSet(fb_mode->dirty, FALSE, fb_dos.h);
	
	/* draw mouse ? */
	//fb_dos.mouse_draw();
}



/*:::::*/
static void draw_mouse(void)
{
	int i;
	int x;
	int count;
	int excess;
	unsigned long offset;
	char *p;
	
	
	/* ***** */
	fb_dos.regs.x.ax = 0x3;
	__dpmi_int(0x33, &fb_dos.regs);
	fb_dos.mouse_x = fb_dos.regs.x.cx;
	fb_dos.mouse_y = fb_dos.regs.x.dx;
	/* ***** */

	offset = fb_dos.mouse_y * fb_dos.w + fb_dos.mouse_x + 0xA0000;
	
	fb_dos_vga_wait_vsync();
	
	for (i = 0; i < MOUSE_HEIGHT; i++, offset += 320) {
		dosmemget(offset, MOUSE_WIDTH, mouse_buffer);
	
		mouse_buffer[0] = 0;
	
		dosmemput(mouse_buffer, MOUSE_WIDTH, offset);
	}
	


	
	#if 0
	offset = fb_dos.mouse_y * fb_dos.w + fb_dos.mouse_x + 0xA0000;
	
	p = fb_dos_mouse_image;
	for (i = 0; (i < MOUSE_HEIGHT) && (i + fb_dos.mouse_y < fb_dos.h); i++)
	{
		count = *p;
		excess = fb_dos.w - count;
		
		_farsetsel(_dos_ds);
		x = fb_dos.mouse_x;
		for (p++ ; (count > 0); count--, p++, offset++, x++) {
			if ((*p != -1) && (x < fb_dos.w)) _farnspokeb(offset, *p);
		}
		offset += excess;
		p += count;
	}
	#endif
}
