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
 * vesa2.c -- VESA 2 linear gfx driver
 *
 * chng: apr/2005 written [DrV]
 *
 */

#include "fb_gfx_dos.h"

static int driver_init(char *title, int w, int h, int depth, int refresh_rate, int flags);
static void driver_update(void);
static void end_of_driver_update(void);
static int *driver_fetch_modes(int depth, int *size);

extern int find_vesa_mode(int w, int h, int color_depth, int vbe_version);

GFXDRIVER fb_gfxDriverVESA =
{
	"VESA",                 /* char *name; */
	driver_init,             /* int (*init)(char *title, int w, int h, int depth, int refresh_rate, int flags); */
	fb_dos_exit,             /* void (*exit)(void); */
	fb_dos_lock,             /* void (*lock)(void); */
	fb_dos_unlock,           /* void (*unlock)(void); */
	fb_dos_set_palette,      /* void (*set_palette)(int index, int r, int g, int b); */
	fb_dos_vga_wait_vsync,   /* void (*wait_vsync)(void); */
	fb_dos_get_mouse,        /* int (*get_mouse)(int *x, int *y, int *z, int *buttons); */
	fb_dos_set_mouse,        /* void (*set_mouse)(int x, int y, int cursor); */
	fb_dos_set_window_title, /* void (*set_window_title)(char *title); */
	driver_fetch_modes,      /* int *(*fetch_modes)(int depth, int *size); */	
	NULL                     /* void (*flip)(void); */
};

/*:::::*/
static int driver_init(char *title, int w, int h, int depth, int refresh_rate, int flags)
{
	int i, mode;
	
	fb_dos_detect();
	
	if (flags & DRIVER_OPENGL)
		return -1;
		
	/*
	if (!fb_dos.nearptr_ok)
		return -1;
	*/
	
	if (!fb_dos.vesa_ok)
		return -1;
	
	mode = 0;	
	for (i = 0; i < fb_dos.num_vesa_modes; i++) {
		if ((fb_dos.vesa_modes[i].XResolution == w) && (fb_dos.vesa_modes[i].YResolution == h)) {
			/* !!!TODO!!! check bpp here!!!! */
			mode = fb_dos.vesa_modes[i].WinFuncPtr;
			memcpy(&fb_dos.vesa_mode_info, &fb_dos.vesa_modes[i], sizeof(VesaModeInfo));
			break;
		}
	}
	
	if (mode == 0) {
		return -1;
	}
	
	/* set video mode */
	fb_dos.regs.x.ax = 0x13;
	__dpmi_int(0x10, &fb_dos.regs);
	
	fb_dos.regs.x.ax = 0x4F02;
	fb_dos.regs.x.bx = mode;
	__dpmi_int(0x10, &fb_dos.regs);
	
	if (fb_dos.regs.h.ah) {
		return -1;
	}
	
	refresh_rate = 60;
	
	fb_dos.update = driver_update;
	fb_dos.update_len = (unsigned int)end_of_driver_update - (unsigned int)driver_update;
	fb_dos.set_palette = fb_dos_vga_set_palette;
	
	fb_dos_init(title, w, h, depth, refresh_rate, flags);
	
	return 0;

}


   void set_vesa_bank(int bank_number)
   {
      __dpmi_regs r;

      r.x.ax = 0x4F05;
      r.x.bx = 0;
      r.x.dx = bank_number;
      __dpmi_int(0x10, &r);
   }


/*:::::*/
static void driver_update(void)
{
/*
	int y;
	unsigned int buffer = (unsigned int)fb_mode->framebuffer;
	unsigned int screen = 0xA0000;
	
	for (y = 0; y < fb_dos.h; y++, buffer += fb_dos.w, screen += fb_dos.w) {
		if (fb_mode->dirty[y]) {
			movedata(_my_ds(), buffer, _dos_ds, screen, fb_dos.w);
		}
	}
*/

      	char *memory_buffer;
	int screen_size;
	
	memory_buffer = fb_mode->framebuffer;
	screen_size = fb_dos.w * fb_dos.h; /* TODO : mul by bytes per pixel or mul bpl * h */

      int bank_size = fb_dos.vesa_mode_info.WinSize*1024;
      int bank_granularity = fb_dos.vesa_mode_info.WinGranularity*1024;
      int bank_number = 0;
      int todo = screen_size;
      int copy_size;
      

	
	

      while (todo > 0) {
	 /* select the appropriate bank */
	 set_vesa_bank(bank_number);

	 /* how much can we copy in one go? */
	 if (todo > bank_size)
	    copy_size = bank_size;
	 else
	    copy_size = todo;

	 /* copy a bank of data to the screen */
	 dosmemput(memory_buffer, copy_size, 0xA0000);

	 /* move on to the next bank of data */
	 todo -= copy_size;
	 memory_buffer += copy_size;
	 bank_number += bank_size/bank_granularity;
      }
}

static void end_of_driver_update(void) { /* do not remove */ }

static int *driver_fetch_modes(int depth, int *size)
{
	int *modes;
	int count, i;
	
	if (!fb_dos.detected) fb_dos_detect();
	
	modes = (int *)malloc(sizeof(VesaModeInfo) * fb_dos.num_vesa_modes);
	
	for (i = 0, count = 0; i < fb_dos.num_vesa_modes; i++) {
		if ((fb_dos.vesa_modes[i].XResolution != 0) && (fb_dos.vesa_modes[i].BitsPerPixel == depth)) {
			modes[count++] = SCREENLIST(fb_dos.vesa_modes[i].XResolution, fb_dos.vesa_modes[i].YResolution);
		}
	}
	*size = count;
	return modes;
}

