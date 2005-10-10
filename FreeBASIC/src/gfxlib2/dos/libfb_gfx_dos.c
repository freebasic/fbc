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
 * libfb_gfx_dos.c -- list of dos gfx drivers and common code
 *
 * chng: mar/2005 written [DrV]
 *
 */

#include "fb_gfx_dos.h"

#include <limits.h>
#include <sys/nearptr.h>

/* driver list */

extern GFXDRIVER fb_gfxDriverVESA;
extern GFXDRIVER fb_gfxDriverVGA;
extern GFXDRIVER fb_gfxDriverModeX;

const GFXDRIVER *fb_gfx_driver_list[] = {
	//&fb_gfxDriverVESA,
	&fb_gfxDriverVGA,
	&fb_gfxDriverModeX,
	NULL
};

fb_dos_t fb_dos;

#define MOUSE_WIDTH     12
#define MOUSE_HEIGHT    21

static unsigned char fb_dos_mouse_image[] = {
	2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	2, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	2, 1, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0,
	2, 1, 1, 1, 2, 0, 0, 0, 0, 0, 0, 0,
	2, 1, 1, 1, 1, 2, 0, 0, 0, 0, 0, 0,
	2, 1, 1, 1, 1, 1, 2, 0, 0, 0, 0, 0,
	2, 1, 1, 1, 1, 1, 1, 2, 0, 0, 0, 0,
	2, 1, 1, 1, 1, 1, 1, 1, 2, 0, 0, 0,
	2, 1, 1, 1, 1, 1, 1, 1, 1, 2, 0, 0,
	2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 0,
	2, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2,
	2, 1, 1, 1, 2, 1, 1, 2, 0, 0, 0, 0,
	2, 1, 1, 2, 2, 1, 1, 2, 0, 0, 0, 0,
	2, 1, 2, 0, 0, 2, 1, 1, 2, 0, 0, 0,
	2, 2, 0, 0, 0, 2, 1, 1, 2, 0, 0, 0,
	2, 0, 0, 0, 0, 0, 2, 1, 1, 2, 0, 0,
	0, 0, 0, 0, 0, 0, 2, 1, 1, 2, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 2, 1, 1, 2, 0,
	0, 0, 0, 0, 0, 0, 0, 2, 1, 1, 2, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0 };


static unsigned char mouse_color[3] = {0, 15, 0};

static unsigned char mouse_save[MOUSE_WIDTH * MOUSE_HEIGHT * 3 + 4];

static void fb_dos_save_video_mode(void);
static void fb_dos_restore_video_mode(void);
static void fb_dos_kb_init(void);
static void fb_dos_kb_exit(void);

static void _lock_mem(unsigned int address, size_t size)
{
	static __dpmi_meminfo mi;
	mi.address = address;
	mi.size = size;
	__dpmi_lock_linear_region(&mi);
}

#define lock_mem(addr, size) _lock_mem( (unsigned int)(addr), (size_t)(size) )
#define lock_var(var)        lock_mem( &(var), sizeof(var) )
#define lock_array(array)    lock_mem( (array), sizeof(array) )
#define lock_proc(proc)      lock_mem( proc, end_##proc )

static void _unlock_mem(unsigned int address, size_t size)
{
	static __dpmi_meminfo mi;
	mi.address = address;
	mi.size = size;
	__dpmi_unlock_linear_region(&mi);
}

#define unlock_mem(addr, size) _unlock_mem( (unsigned int)(addr), (size_t)(size) )
#define unlock_var(var)        unlock_mem( &(var), sizeof(var) )
#define unlock_array(array)    unlock_mem( (array), sizeof(array) )
#define unlock_proc(proc)      unlock_mem( proc, end_##proc )

/*:::::*/
static void fb_dos_kb_init(void)
{
    fb_hooks.inkeyproc  = NULL;
    fb_hooks.getkeyproc = NULL;
    fb_hooks.keyhitproc = NULL;
    fb_hooks.multikeyproc = NULL;
	return;
}


/*:::::*/
static void fb_dos_kb_exit(void)
{
}


/*:::::*/
static void fb_dos_mouse_init(void)
{
	if (!fb_dos.mouse_ok) return;
	
	/* set horizontal range */
	fb_dos.regs.x.ax = 0x7;
	fb_dos.regs.x.cx = 0;
	fb_dos.regs.x.dx = fb_dos.w - 1;
	__dpmi_int(0x33, &fb_dos.regs);
	
	/* set vertical range */
	fb_dos.regs.x.ax = 0x8;
	fb_dos.regs.x.cx = 0;
	fb_dos.regs.x.dx = fb_dos.h - 1;
	__dpmi_int(0x33, &fb_dos.regs);
	
}


/*:::::*/
int fb_dos_get_mouse(int *x, int *y, int *z, int *buttons)
{
	
	if (!fb_dos.mouse_ok) return -1;
	
	*x = fb_dos.mouse_x;
	*y = fb_dos.mouse_y;
	*z = fb_dos.mouse_z;
	*buttons = fb_dos.mouse_buttons;
	
	return 0;
}

/*:::::*/
void fb_dos_set_mouse(int x, int y, int cursor)
{
	if (!fb_dos.mouse_ok) return;
	
	if (x >= 0) fb_dos.mouse_x = x;
	if (y >= 0) fb_dos.mouse_y = y;
	fb_dos.mouse_cursor = cursor;
	
	fb_dos.regs.x.ax = 0x4;
	fb_dos.regs.x.cx = fb_dos.mouse_x;
	fb_dos.regs.x.dx = fb_dos.mouse_y;
	__dpmi_int(0x33, &fb_dos.regs);
}

/*:::::*/
void fb_dos_update_mouse(void)
{
	if (!fb_dos.mouse_ok) return;
	
	fb_dos.regs.x.ax = 0x3;
	__dpmi_int(0x33, &fb_dos.regs);
	
	fb_dos.mouse_buttons = fb_dos.regs.h.bl;
	
	fb_dos.mouse_x = fb_dos.regs.x.cx;
	fb_dos.mouse_y = fb_dos.regs.x.dx;
	
	if (fb_dos.mouse_wheel_ok) fb_dos.mouse_z -= fb_dos.regs.h.bh;
	
}

static void end_fb_dos_update_mouse(void) {}

/*:::::*/
static void fb_dos_mouse_exit(void)
{
	if (!fb_dos.mouse_ok) return;
	
	fb_dos.regs.x.ax = 0x0;
	__dpmi_int(0x33, &fb_dos.regs);
}

/*:::::*/
static void fb_dos_draw_mouse_8(void)
{
	/* TODO: replace array indexing with pointers */
	
	int src_x, src_y, dst_x, dst_y;
	unsigned char src;
	
	for (src_y = fb_dos.mouse_y, dst_y = 0; (dst_y < MOUSE_HEIGHT) && (src_y < fb_dos.h); src_y++, dst_y++) {
		fb_hMemCpy(&mouse_save[dst_y * MOUSE_WIDTH], &fb_mode->framebuffer[src_y * fb_dos.w + fb_dos.mouse_x], MOUSE_WIDTH);
	}
	
	if (!fb_dos.mouse_cursor) return;
	
	for (src_y = 0, dst_y = fb_dos.mouse_y; ((src_y < MOUSE_HEIGHT) && (dst_y < fb_dos.h)); src_y++, dst_y++) {
		fb_mode->dirty[dst_y] = TRUE;
		for (src_x = 0, dst_x = fb_dos.mouse_x; ((src_x < MOUSE_WIDTH) && (dst_x < fb_dos.w)); src_x++, dst_x++) {
			src = fb_dos_mouse_image[src_y * MOUSE_WIDTH + src_x];
			if (src != 0) {
				fb_mode->framebuffer[fb_dos.w * dst_y + dst_x] = mouse_color[src];
			}
		}
	}
}

static void end_fb_dos_draw_mouse_8(void) {}

/*:::::*/
static void fb_dos_undraw_mouse_8(void)
{
	int src_y, dst_y;
	
	if (!fb_dos.mouse_cursor) return;
	
	for (dst_y = fb_dos.mouse_y, src_y = 0; (src_y < MOUSE_HEIGHT) && (dst_y < fb_dos.h); src_y++, dst_y++) {
		fb_mode->dirty[dst_y] = TRUE;
		fb_hMemCpy(&fb_mode->framebuffer[dst_y * fb_dos.w + fb_dos.mouse_x], &mouse_save[src_y * MOUSE_WIDTH], MOUSE_WIDTH);
	}
}

static void end_fb_dos_undraw_mouse_8(void) {}

/*:::::*/
static void fb_dos_timer_handler(void)
{
	if (fb_dos.in_interrupt) return;
	
	fb_dos.in_interrupt = TRUE;
	
	fb_dos.set_palette();
	fb_dos_update_mouse();
	fb_dos.draw_mouse();
	fb_dos.update();
	fb_hMemSet(fb_mode->dirty, FALSE, fb_dos.h);
	fb_dos.undraw_mouse();
	
	fb_dos.in_interrupt = FALSE;
}

static void end_fb_dos_timer_handler(void) { /* do not remove */ }

/*:::::*/
static void fb_dos_timer_set_rate(int freq)
{
	int time, i;
	
	time = 1193181 / freq;
	
	for (i = 0; i < 4; i++) {
		outportb(0x43, 0x34);
		outportb(0x40, time & 0xff);
		outportb(0x40, time >> 8);
	}
}

/*:::::*/
static void fb_dos_timer_init(void)
{
	_go32_dpmi_get_protected_mode_interrupt_vector(0x8, &fb_dos.old_timer_int);
	fb_dos.new_timer_int.pm_offset = (unsigned int)fb_dos_timer_handler;
	fb_dos.new_timer_int.pm_selector = _go32_my_cs();
	_go32_dpmi_chain_protected_mode_interrupt_vector(0x8, &fb_dos.new_timer_int);
}

/*:::::*/
static void fb_dos_timer_exit(void)
{
	_go32_dpmi_set_protected_mode_interrupt_vector(0x8, &fb_dos.old_timer_int);
}


/*:::::*/
void fb_dos_set_palette(int idx, int r, int g, int b)
{
	fb_dos.pal_dirty = TRUE;
	fb_dos.pal[idx].r = r;
	fb_dos.pal[idx].g = g;
	fb_dos.pal[idx].b = b;
}

/*:::::*/
static int fb_dos_find_nearest_color(unsigned char r, unsigned char g, unsigned char b)
{
	int i, curr_idx;
	int dr, dg, db;
	int err, curr_err;
	
	curr_idx = -1;
	curr_err = INT_MAX;
	
	/* find nearest color with least-squares */
	
	for (i = 0; i < 256; i++) {
		dr = abs(fb_dos.pal[i].r - r);
		dg = abs(fb_dos.pal[i].g - g);
		db = abs(fb_dos.pal[i].b - b);
		err = (dr * dr) + (dg * dg) + (db * db);
		
		if (err < curr_err) {
			curr_idx = i;
			curr_err = err;
		}
	}
	
	return curr_idx;
}

/*:::::*/
void fb_dos_vga_set_palette(void)
{
	int i;
	
	if (!fb_dos.pal_dirty) return;
	
	/* find best colors for mouse pointer */
	mouse_color[1] = fb_dos_find_nearest_color(255, 255, 255);
	mouse_color[2] = fb_dos_find_nearest_color(0, 0, 0);
	
	for (i = 0; i < 256; i++) {
		outportb(0x3C8, i);
		outportb(0x3C9, fb_dos.pal[i].r >> 2);
		outportb(0x3C9, fb_dos.pal[i].g >> 2);
		outportb(0x3C9, fb_dos.pal[i].b >> 2);
	}
}

/*:::::*/
void fb_dos_vga_wait_vsync(void)
{
	/* !!!FIXME!!! using this creates a delay of approx. 18 FPS on WinXP (not tested on real DOS yet)
	   maybe something to do with changing rate of PIC? */
	while ((inportb(0x3DA) & 8) != 0);
	while ((inportb(0x3DA) & 8) == 0);
}

/*:::::*/
static int fb_dos_vesa_get_mode_info(int mode)
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
void fb_dos_detect(void)
{
	int i;
	int mode_list[256];
	int number_of_modes;
	long mode_ptr;
	int c;
	
	if (!fb_dos.detected) {
		fb_dos.detected = TRUE;
		/* detect VESA */
		
		_farsetsel(_dos_ds);
		
		for (i = 4; i < (int)sizeof(VbeInfoBlock); i++) {
			_farnspokeb(MASK_LINEAR(__tb) + i, 0);
		}
		
		dosmemput("VBE2", 4, MASK_LINEAR(__tb));	/* get VESA 2 info if available */
		
		fb_dos.regs.x.ax = 0x4F00;
		fb_dos.regs.x.di = RM_OFFSET(__tb);
		fb_dos.regs.x.es = RM_SEGMENT(__tb);
		__dpmi_int(0x10, &fb_dos.regs);
		
		if (fb_dos.regs.h.ah != 0x00) {
			fb_dos.vesa_ok = FALSE;
		} else {
			dosmemget(MASK_LINEAR(__tb), sizeof(VbeInfoBlock), &fb_dos.vesa_info);
			
			if (strncmp(fb_dos.vesa_info.vbe_signature, "VESA", 4) != 0) {
				fb_dos.vesa_ok = FALSE;
			} else {
				fb_dos.vesa_ok = TRUE;
			}
		}
		
		/* get VESA modes */
		if (fb_dos.vesa_ok) {
			
			mode_ptr = ((fb_dos.vesa_info.video_mode_ptr & 0xFFFF0000) >> 12) + (fb_dos.vesa_info.video_mode_ptr & 0xFFFF);
			
			number_of_modes = 0;
			
			while (_farpeekw(_dos_ds, mode_ptr) != 0xFFFF) {
				mode_list[number_of_modes] = _farpeekw(_dos_ds, mode_ptr);
				number_of_modes++;
				mode_ptr += 2;
			}
			
			fb_dos.num_vesa_modes = number_of_modes;
			
			fb_dos.vesa_modes = (VesaModeInfo *)malloc(number_of_modes * sizeof(VesaModeInfo));
			
			for (c = 0; c < number_of_modes; c++) {
				if (fb_dos_vesa_get_mode_info(mode_list[c]) != 0)
					continue;
				
				/* color graphics mode and supported */
				if ((fb_dos.vesa_mode_info.ModeAttributes & 0x19) != 0x19)
					continue;
				
				if (fb_dos.vesa_mode_info.NumberOfPlanes != 1)
					continue;
				
				if ((fb_dos.vesa_mode_info.MemoryModel != VMI_MM_PACK) && (fb_dos.vesa_mode_info.MemoryModel != VMI_MM_DIR))
					continue;
			
				/* clobber WinFuncPtr to hold mode number */
				fb_dos.vesa_mode_info.WinFuncPtr = mode_list[c];
				
				/* add to list */
				memcpy(&fb_dos.vesa_modes[c], &fb_dos.vesa_mode_info, sizeof(VesaModeInfo));
			}
		}
		
		/* detect mouse */
		
		fb_dos.regs.x.ax = 0x0;
		__dpmi_int(0x33, &fb_dos.regs);
		fb_dos.mouse_ok = (fb_dos.regs.x.ax == 0) ? FALSE : TRUE;
		
		fb_dos.regs.x.ax = 0x11;
		__dpmi_int(0x33, &fb_dos.regs);
		fb_dos.mouse_wheel_ok = ((fb_dos.regs.x.ax == 0x574D) && (fb_dos.regs.x.cx & 1)) ? TRUE : FALSE;
		
		/* detect nearptr */
		fb_dos.nearptr_ok = __djgpp_nearptr_enable();
	}
	
	/* save current video mode */
	
	fb_dos_save_video_mode();
	
}

/*:::::*/
void fb_dos_init(char *title, int w, int h, int depth, int refresh_rate, int flags)
{
	
	/* lock code and data accessed in int handlers */
	
	lock_var(fb_mode);
	lock_var(fb_dos);
	
	lock_mem(fb_mode->key, 128);
	
	lock_array(fb_dos_mouse_image);
	lock_array(mouse_color);
    lock_array(mouse_save);

	lock_proc(fb_dos_timer_handler);
	lock_proc(fb_dos_update_mouse);
	lock_proc(fb_dos_draw_mouse_8);
    lock_proc(fb_dos_undraw_mouse_8);
	lock_mem(fb_dos.update, fb_dos.update_len);
	
	/* TODO: lock fb_hMemCpy and fb_hMemSet (the actual code and the pointers) */
	
	fb_dos.w = w;
	fb_dos.h = h;
	fb_dos.depth = depth;
	fb_dos.Bpp = depth / 8;
	fb_mode->refresh_rate = fb_dos.refresh = refresh_rate;
	
	switch (depth) {
		case 8: fb_dos.draw_mouse = fb_dos_draw_mouse_8;
			fb_dos.undraw_mouse = fb_dos_undraw_mouse_8;
			break;
	}

    fb_dos_kb_init();
	fb_dos_mouse_init();
	fb_dos_timer_init();
	fb_dos_timer_set_rate(refresh_rate);
	
	if (fb_dos.mouse_ok) {
		fb_dos_set_mouse(fb_dos.w / 2, fb_dos.h / 2, TRUE);
	} else {
		fb_dos.mouse_cursor = FALSE;
	}
	
	fb_dos.mouse_z = fb_dos.mouse_wheel_ok ? 0 : -1;
		
	fb_dos.inited = TRUE;
}

/*:::::*/
void fb_dos_exit(void)
{
	fb_dos_restore_video_mode();
	
	if (!fb_dos.inited) return;
	
	fb_dos_timer_exit();
	fb_dos_mouse_exit();
	fb_dos_kb_exit();
	
	
	fb_dos.w = fb_dos.h = fb_dos.depth = fb_dos.refresh = 0;
	
	/* unlock code and data */
	
	unlock_var(fb_mode);
	unlock_var(fb_dos);
	
	unlock_mem(fb_mode->key, 128);
	
	unlock_array(fb_dos_mouse_image);
	unlock_array(mouse_color);
    unlock_array(mouse_save);

	unlock_proc(fb_dos_timer_handler);
	unlock_proc(fb_dos_update_mouse);
	unlock_proc(fb_dos_draw_mouse_8);
    unlock_proc(fb_dos_undraw_mouse_8);
	unlock_mem(fb_dos.update, fb_dos.update_len);
	
	fb_dos.inited = FALSE;
}

/*:::::*/
void fb_dos_lock(void)
{
	fb_dos.locked = TRUE;
}

/*:::::*/
void fb_dos_unlock(void)
{
	fb_dos.locked = FALSE;
}

/*:::::*/
void fb_dos_set_window_title(char *title)
{
	/* */
}

/*:::::*/
static void fb_dos_save_video_mode(void)
{
	fb_dos.old_rows = ScreenRows();
	fb_dos.old_cols = ScreenCols();
}

/*:::::*/
static void fb_dos_restore_video_mode(void)
{
	fb_dos.regs.x.ax = 3;
	__dpmi_int(0x10, &fb_dos.regs);
	_set_screen_lines(fb_dos.old_rows);
	intensevideo();	/* no blink */
}

/*:::::*/
void fb_hScreenInfo(int *width, int *height, int *depth, int *refresh)
{
	*width = fb_dos.w;
	*height = fb_dos.h;
	*depth = fb_dos.depth;
	*refresh = fb_dos.refresh;
}
