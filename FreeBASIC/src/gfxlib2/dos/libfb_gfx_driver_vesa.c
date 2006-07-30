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
 * vesa2.c -- banked VESA gfx driver
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


static int vesa_ok;
static VbeInfoBlock vesa_info;
static VesaModeInfo vesa_mode_info;
static VesaModeInfo *vesa_modes;
static int num_vesa_modes;

static int detected = FALSE;

/*:::::*/
static int vesa_get_mode_info(int mode)
{
	int i;

	_farsetsel(_dos_ds);

	for (i = 0; i < sizeof(vesa_mode_info); i++) {
		_farnspokeb(MASK_LINEAR(__tb) + i, 0);
	}

	fb_dos.regs.x.ax = 0x4F01;
	fb_dos.regs.x.di = RM_OFFSET(__tb);
	fb_dos.regs.x.es = RM_SEGMENT(__tb);
	fb_dos.regs.x.cx = mode;
	__dpmi_int(0x10, &fb_dos.regs);
	if (fb_dos.regs.h.ah)
		return -1;

	dosmemget(MASK_LINEAR(__tb), sizeof(vesa_mode_info), &vesa_mode_info);
	return 0;
}

/*:::::*/
static void driver_detect(void)
{

	int i;
	int mode_list[256];
	int number_of_modes;
	long mode_ptr;
	int c;
	
	if (detected)
		return;
	
	detected = TRUE;
	
	/* detect VESA */

	_farsetsel(_dos_ds);

	for (i = 4; i < (int)sizeof(VbeInfoBlock); i++) {
		_farnspokeb(MASK_LINEAR(__tb) + i, 0);
	}

	dosmemput("VBE2", 4, MASK_LINEAR(__tb)); /* get VESA 2 info if available */

	fb_dos.regs.x.ax = 0x4F00;
	fb_dos.regs.x.di = RM_OFFSET(__tb);
	fb_dos.regs.x.es = RM_SEGMENT(__tb);
	__dpmi_int(0x10, &fb_dos.regs);

	if (fb_dos.regs.h.ah != 0x00) {
		vesa_ok = FALSE;
	} else {
		dosmemget(MASK_LINEAR(__tb), sizeof(VbeInfoBlock), &vesa_info);

		if (strncmp(vesa_info.vbe_signature, "VESA", 4) != 0) {
			vesa_ok = FALSE;
		} else {
			vesa_ok = TRUE;
		}
	}

	/* get VESA modes */
	if (vesa_ok) {

		mode_ptr = RM_TO_LINEAR(vesa_info.video_mode_ptr);

		number_of_modes = 0;

		while (_farpeekw(_dos_ds, mode_ptr) != 0xFFFF) {
			mode_list[number_of_modes] = _farpeekw(_dos_ds, mode_ptr);
			number_of_modes++;
			mode_ptr += 2;
		}

		num_vesa_modes = number_of_modes;

		vesa_modes = malloc(number_of_modes * sizeof(VesaModeInfo));

		for (c = 0; c < number_of_modes; c++) {
			if (vesa_get_mode_info(mode_list[c]) != 0)
				continue;

			/* color graphics mode and supported */
			if ((vesa_mode_info.ModeAttributes & 0x19) != 0x19)
				continue;

			if (vesa_mode_info.NumberOfPlanes != 1)
				continue;

			if ((vesa_mode_info.MemoryModel != VMI_MM_PACK) && (vesa_mode_info.MemoryModel != VMI_MM_DIR))
				continue;

			/* clobber WinFuncPtr to hold mode number */
			vesa_mode_info.WinFuncPtr = mode_list[c];

			/* add to list */
			memcpy(&vesa_modes[c], &vesa_mode_info, sizeof(VesaModeInfo));
		}
	}
}

/*:::::*/
static int driver_init(char *title, int w, int h, int depth_arg, int refresh_rate, int flags)
{
	int depth = MAX(8, depth_arg);
	int i, mode;

	fb_dos_detect();
	driver_detect();

	if (flags & DRIVER_OPENGL)
		return -1;

	/*
	if (!fb_dos.nearptr_ok)
		return -1;
	*/

	if (!vesa_ok)
		return -1;

	mode = 0;
	for (i = 0; i < num_vesa_modes; i++) {
		if ((vesa_modes[i].XResolution == w) && (vesa_modes[i].YResolution == h)) {
			if ((vesa_modes[i].BitsPerPixel == depth)) {
				mode = vesa_modes[i].WinFuncPtr;
				memcpy(&vesa_mode_info, &vesa_modes[i], sizeof(VesaModeInfo));
				break;
			}
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

	refresh_rate = 60; /* FIXME */

	fb_dos.update = driver_update;
	fb_dos.update_len = (unsigned int)end_of_driver_update - (unsigned int)driver_update;
	fb_dos.set_palette = fb_dos_vga_set_palette; /* FIXME */

	return fb_dos_init(title, w, h, depth, refresh_rate, flags);
}

/*:::::*/
static __inline void set_vesa_bank(int bank_number)
{
	static __dpmi_regs r;
	
	r.x.ax = 0x4F05;
	r.x.bx = 0;
	r.x.dx = bank_number;
	__dpmi_int(0x10, &r);
}


/*:::::*/
static void driver_update(void)
{
	unsigned char *memory_buffer;
	int framebuffer_start;
	int bank_size = vesa_mode_info.WinSize * 1024;
	int bank_granularity = vesa_mode_info.WinGranularity * 1024;
	int bank_number = 0;
	int todo;
	int copy_size;
	int y1, y2;
	
	for (y1 = 0; y1 < fb_dos.h; y1++) {
		if (fb_mode->dirty[y1]) {
			for (y2 = fb_dos.h - 1; !fb_mode->dirty[y2]; y2--)
				;
			
			bank_number = (y1 * fb_mode->pitch) / bank_granularity;
			
			framebuffer_start = bank_number * bank_granularity;
			
			todo = ((y2 + 1) * fb_mode->pitch) - framebuffer_start;
			
			/* fixme - use blitter here if necessary */
			memory_buffer = fb_mode->framebuffer + framebuffer_start;
			
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
				bank_number += bank_size / bank_granularity;
			}
			
			fb_hMemSet(fb_mode->dirty, FALSE, fb_dos.h);
		}
	}
}

static void end_of_driver_update(void) { /* do not remove */ }

static int *driver_fetch_modes(int depth, int *size)
{
	int *modes;
	int count, i;

	if (!fb_dos.detected) fb_dos_detect();
	if (!detected) driver_detect();

	modes = malloc(sizeof(VesaModeInfo) * num_vesa_modes);

	for (i = 0, count = 0; i < num_vesa_modes; i++) {
		if ((vesa_modes[i].XResolution != 0) && (vesa_modes[i].BitsPerPixel == depth)) {
			modes[count++] = SCREENLIST(vesa_modes[i].XResolution, vesa_modes[i].YResolution);
		}
	}
	*size = count;
	return modes;
}

