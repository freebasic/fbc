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
 * vesa.c -- banked VESA gfx driver
 *
 * chng: apr/2005 written [DrV]
 *
 */

#include "fb_gfx_dos.h"

static int driver_init(char *title, int w, int h, int depth, int refresh_rate, int flags);
static void driver_exit(void);
static void driver_update(void);
static void end_of_driver_update(void);
static void fb_dos_vesa_set_bank_int(void);
static void fb_dos_vesa_set_bank_int_end(void);
extern void fb_dos_vesa_set_bank_pm(void);
extern void fb_dos_vesa_set_bank_pm_end(void);

GFXDRIVER fb_gfxDriverVESA =
{
	"VESA banked",           /* char *name; */
	driver_init,             /* int (*init)(char *title, int w, int h, int depth, int refresh_rate, int flags); */
	driver_exit,             /* void (*exit)(void); */
	fb_dos_lock,             /* void (*lock)(void); */
	fb_dos_unlock,           /* void (*unlock)(void); */
	fb_dos_set_palette,      /* void (*set_palette)(int index, int r, int g, int b); */
	fb_dos_vga_wait_vsync,   /* void (*wait_vsync)(void); */
	fb_dos_get_mouse,        /* int (*get_mouse)(int *x, int *y, int *z, int *buttons); */
	fb_dos_set_mouse,        /* void (*set_mouse)(int x, int y, int cursor); */
	fb_dos_set_window_title, /* void (*set_window_title)(char *title); */
	NULL,                    /* int (*set_window_pos)(int x, int y); */
	fb_dos_vesa_fetch_modes, /* int *(*fetch_modes)(int depth, int *size); */
	NULL                     /* void (*flip)(void); */
};

static int detected = FALSE;
static int data_locked = FALSE;
static void (*fb_dos_vesa_set_bank)(void) = NULL;
static VesaPMInfo *vesa_pm_info = NULL;

void *fb_dos_vesa_pm_bank_switcher = NULL;
int fb_dos_vesa_bank_number = 0;

/*:::::*/
static void vesa_get_pm_functions(void)
{
	if (fb_dos.vesa_info.vbe_version < 0x200)
		return;
	
	fb_dos.regs.x.ax = 0x4F0A;
	fb_dos.regs.x.bx = 0;
	__dpmi_int(0x10, &fb_dos.regs);
	if (fb_dos.regs.h.ah)
		return;
	
	vesa_pm_info = malloc(fb_dos.regs.x.cx);
	
	dosmemget(fb_dos.regs.x.es * 16 + fb_dos.regs.x.di, fb_dos.regs.x.cx, vesa_pm_info);
	
	fb_dos_vesa_pm_bank_switcher = (char *)vesa_pm_info + vesa_pm_info->setWindow;
	
}


/*:::::*/
static int vesa_get_mode_info(int mode)
{
	int i;

	_farsetsel(_dos_ds);

	for (i = 0; i < sizeof(fb_dos.vesa_mode_info); i++) {
		_farnspokeb(MASK_LINEAR(__tb) + i, 0);
	}

	fb_dos.regs.x.ax = 0x4F01;
	fb_dos.regs.x.di = RM_OFFSET(__tb);
	fb_dos.regs.x.es = RM_SEGMENT(__tb);
	fb_dos.regs.x.cx = mode;
	__dpmi_int(0x10, &fb_dos.regs);
	if (fb_dos.regs.h.ah)
		return -1;

	dosmemget(MASK_LINEAR(__tb), sizeof(fb_dos.vesa_mode_info), &fb_dos.vesa_mode_info);
	return 0;
}


/*:::::*/
void fb_dos_vesa_detect(void)
{
	int i;
	int mode_list[256];
	int number_of_modes;
	long mode_ptr;
	int c;
	int attribs = VMI_MA_SUPPORTED | VMI_MA_COLOR | VMI_MA_GRAPHICS;
	
	if (detected)
		return;
	
	detected = TRUE;
		
	/* detect VESA */
	
	fb_dos.vesa_ok = FALSE;
	
	_farsetsel(_dos_ds);

	for (i = 4; i < (int)sizeof(VbeInfoBlock); i++)
		_farnspokeb(MASK_LINEAR(__tb) + i, 0);
	
	dosmemput("VBE2", 4, MASK_LINEAR(__tb)); /* get VESA 2 info if available */
	
	fb_dos.regs.x.ax = 0x4F00;
	fb_dos.regs.x.di = RM_OFFSET(__tb);
	fb_dos.regs.x.es = RM_SEGMENT(__tb);
	__dpmi_int(0x10, &fb_dos.regs);
	
	if (fb_dos.regs.h.ah == 0x00)
	{
		dosmemget(MASK_LINEAR(__tb), sizeof(VbeInfoBlock), &fb_dos.vesa_info);
		if (strncmp(fb_dos.vesa_info.vbe_signature, "VESA", 4) == 0)
			fb_dos.vesa_ok = TRUE;
	}
	
	/* get VESA modes */
	if (fb_dos.vesa_ok)
	{
		
		mode_ptr = RM_TO_LINEAR(fb_dos.vesa_info.video_mode_ptr);
		
		number_of_modes = 0;
		
		while (_farpeekw(_dos_ds, mode_ptr) != 0xFFFF)
		{
			mode_list[number_of_modes] = _farpeekw(_dos_ds, mode_ptr);
			number_of_modes++;
			mode_ptr += 2;
		}
		
		fb_dos.num_vesa_modes = number_of_modes;
		
		fb_dos.vesa_modes = malloc(number_of_modes * sizeof(VesaModeInfo));
		
		for (c = 0; c < number_of_modes; c++)
		{
			if ( (vesa_get_mode_info(mode_list[c]) == 0) &&
			     ((fb_dos.vesa_mode_info.ModeAttributes & attribs) == attribs) && /* color graphics mode and supported */
			     (fb_dos.vesa_mode_info.NumberOfPlanes == 1) &&
			     ((fb_dos.vesa_mode_info.MemoryModel == VMI_MM_PACK) || (fb_dos.vesa_mode_info.MemoryModel == VMI_MM_DIR)) )
			{
				/* clobber WinFuncPtr to hold mode number */
				fb_dos.vesa_mode_info.WinFuncPtr = mode_list[c];

				/* add to list */
				memcpy(&fb_dos.vesa_modes[c], &fb_dos.vesa_mode_info, sizeof(VesaModeInfo));
			}
		}
	}
}


/*:::::*/
int fb_dos_vesa_set_mode(int w, int h, int depth, int linear)
{
	int i, mode = 0;
	int bpp;

	for ( i = 0; i < fb_dos.num_vesa_modes; i++ )
	{
		if ( (fb_dos.vesa_modes[i].XResolution == w) && (fb_dos.vesa_modes[i].YResolution == h) )
		{
			bpp = fb_dos.vesa_modes[i].BitsPerPixel;
			if ( (bpp == depth) ||
			     (bpp == 15 && depth == 16) ||
			     (bpp == 16 && depth == 15) ||
			     (bpp == 24 && depth == 32) ||
			     (bpp == 32 && depth == 24) )
			{
				if ( !linear || (fb_dos.vesa_modes[i].ModeAttributes & VMI_MA_LFB) )
				{
					memcpy(&fb_dos.vesa_mode_info, &fb_dos.vesa_modes[i], sizeof(VesaModeInfo));
					mode = fb_dos.vesa_modes[i].WinFuncPtr;
					break;
				}
			}
		}
	}
	
	if (!mode)
		return -1;
	
	fb_dos.regs.x.ax = 0x13;
	__dpmi_int(0x10, &fb_dos.regs);
	
	fb_dos.regs.x.ax = 0x4F02;
	fb_dos.regs.x.bx = mode;
	if (linear) fb_dos.regs.x.bx |= 0x4000;
	__dpmi_int(0x10, &fb_dos.regs);
	
	return (fb_dos.regs.h.ah ? -1 : 0);
}


/*:::::*/
int *fb_dos_vesa_fetch_modes(int depth, int *size)
{
	int *modes;
	int count, i;
	int bpp;

	if (!fb_dos.detected) fb_dos_detect();
	if (!detected) fb_dos_vesa_detect();

	modes = malloc(sizeof(VesaModeInfo) * fb_dos.num_vesa_modes);

	for (i = 0, count = 0; i < fb_dos.num_vesa_modes; i++) {
		if (fb_dos.vesa_modes[i].XResolution != 0)
		{
			bpp = fb_dos.vesa_modes[i].BitsPerPixel;
			if ( (bpp == depth) ||
			     (bpp == 15 && depth == 16) ||
			     (bpp == 16 && depth == 15) ||
			     (bpp == 24 && depth == 32) ||
			     (bpp == 32 && depth == 24) )
			{
				modes[count++] = SCREENLIST(fb_dos.vesa_modes[i].XResolution, fb_dos.vesa_modes[i].YResolution);
			}
		}
	}
	*size = count;
	return modes;
}


/*:::::*/
static int driver_init(char *title, int w, int h, int depth_arg, int refresh_rate, int flags)
{
	int depth = MAX(8, depth_arg);
	
	fb_dos_detect();
	fb_dos_vesa_detect();
	
	if (flags & DRIVER_OPENGL)
		return -1;
	
	if (!fb_dos.vesa_ok)
		return -1;
	
	if (fb_dos_vesa_set_mode(w, h, depth, FALSE))
		return -1;
	
	vesa_get_pm_functions();
	
	if (fb_dos_vesa_pm_bank_switcher)
		fb_dos_vesa_set_bank = fb_dos_vesa_set_bank_pm;
	else
		fb_dos_vesa_set_bank = fb_dos_vesa_set_bank_int;
	
	refresh_rate = 60; /* FIXME */
	
	fb_dos_lock_data(&fb_dos_vesa_set_bank, sizeof(fb_dos_vesa_set_bank));
	fb_dos_lock_data(&vesa_pm_info, sizeof(vesa_pm_info));
	fb_dos_lock_code((void *)fb_dos_vesa_set_bank_pm, (void *)fb_dos_vesa_set_bank_pm_end - (void *)fb_dos_vesa_set_bank_pm);
	fb_dos_lock_code((void *)fb_dos_vesa_set_bank_int, (void *)fb_dos_vesa_set_bank_int_end - (void *)fb_dos_vesa_set_bank_int);
	data_locked = TRUE;

	fb_dos.update = driver_update;
	fb_dos.update_len = (unsigned int)end_of_driver_update - (unsigned int)driver_update;
	fb_dos.set_palette = fb_dos_vga_set_palette; /* FIXME */

	return fb_dos_init(title, w, h, depth, refresh_rate, flags);
}

/*:::::*/
static void driver_exit(void)
{
	if (data_locked) {
			fb_dos_unlock_data(&fb_dos_vesa_set_bank, sizeof(fb_dos_vesa_set_bank));
			fb_dos_unlock_data(&vesa_pm_info, sizeof(vesa_pm_info));
			data_locked = FALSE;
	}
	fb_dos_exit();
}

/*:::::*/
static void fb_dos_vesa_set_bank_int(void)
{
	/* set write bank of window A based on fb_dos_vesa_bank_number */
	fb_dos.regs.x.ax = 0x4F05;
	fb_dos.regs.x.bx = 0;
	fb_dos.regs.x.dx = fb_dos_vesa_bank_number;
	__dpmi_int(0x10, &fb_dos.regs);
}
static void fb_dos_vesa_set_bank_int_end(void) { }


/*:::::*/
static void driver_update(void)
{
	static int curr_bank;
	static unsigned char *memory_buffer;
	static int framebuffer_start;
	static int bank_size;
	static int bank_granularity;
	static int todo;
	static int copy_size;
	static int y1, y2;
	
	bank_size = fb_dos.vesa_mode_info.WinSize * 1024;
	bank_granularity = fb_dos.vesa_mode_info.WinGranularity * 1024;
	
	for (y1 = 0; y1 < fb_dos.h; y1++) {
		if (__fb_gfx->dirty[y1]) {
			for (y2 = fb_dos.h - 1; !__fb_gfx->dirty[y2]; y2--)
				;
			
			fb_dos_vesa_bank_number = (y1 * __fb_gfx->pitch) / bank_granularity;
			
			framebuffer_start = fb_dos_vesa_bank_number * bank_granularity;
			
			todo = ((y2 + 1) * __fb_gfx->pitch) - framebuffer_start;
			
			/* fixme - use blitter here if necessary */
			memory_buffer = __fb_gfx->framebuffer + framebuffer_start;
			
			while (todo > 0) {
				/* select the appropriate bank */
				if (curr_bank != fb_dos_vesa_bank_number) {
					curr_bank = fb_dos_vesa_bank_number;
					
					fb_dos_vesa_set_bank();
				}
				
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
				fb_dos_vesa_bank_number += bank_size / bank_granularity;
			}
			
			break;
		}
	}
}

static void end_of_driver_update(void) { /* do not remove */ }
