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





/*


TODO:


inkey$

lock all code and data accessed in interrupt handlers

*/


/* driver list */

extern GFXDRIVER fb_gfxDriverVGA;
extern GFXDRIVER fb_gfxDriverModeX;

const GFXDRIVER *fb_gfx_driver_list[] = {
	&fb_gfxDriverVGA,
	&fb_gfxDriverModeX,
	NULL
};


/* globals */

fb_dos_t fb_dos;

#define MOUSE_WIDTH	12
#define MOUSE_HEIGHT	21

/* 12x21 */
unsigned char fb_dos_mouse_image[] = {	2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
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

static unsigned char mouse_save[MOUSE_WIDTH * MOUSE_HEIGHT * 3];


static void fb_dos_save_video_mode(void);
static void fb_dos_restore_video_mode(void);
static void fb_dos_kb_init(void);
static void fb_dos_kb_exit(void);

/*:::::*/				
static void kb_handler(void)
/* keyboard interrupt handler - 
   all accessed code and data must be locked! */
{
	unsigned char scan;
	unsigned char status;
	
	/* read the raw scan code from the keyboard */
	scan = inportb(0x60);		/* read scan code */
	status = inportb(0x61);		/* read keyboard status */
	outportb(0x61, status | 0x80);	/* set bit 7 and write */
	outportb(0x61, status);		/* write again, bit 7 clear */
	outportb(0x20, 0x20);		/* reset PIC */
	
	/* TODO: handle extended keys */
	
	if (scan & 0x80) {		/* release */
		fb_mode->key[scan & ~0x80] = FALSE;
	} else {			/* press */
		fb_mode->key[scan] = TRUE;
		/* TODO: call fb_hPostKey with ASCII equivalent of scancode */
	}
	

}

static void end_kb_handler(void)
{ /* this function exists to get length of kb_handler() code */ }
				

/*:::::*/
static void fb_dos_kb_init(void)
{
	_go32_dpmi_get_protected_mode_interrupt_vector(0x9, &fb_dos.old_kb_int);
	fb_dos.new_kb_int.pm_offset = (unsigned int)kb_handler;
	fb_dos.new_kb_int.pm_selector = _go32_my_cs();
	_go32_dpmi_allocate_iret_wrapper(&fb_dos.new_kb_int);
	_go32_dpmi_set_protected_mode_interrupt_vector(0x9, &fb_dos.new_kb_int);
	return;
}


/*:::::*/
static void fb_dos_kb_exit(void)
{
	_go32_dpmi_set_protected_mode_interrupt_vector(0x9, &fb_dos.old_kb_int);
	//_go32_dpmi_free_iret_wrapper(&fb_dos.new_kb_int);
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
	
	fb_dos.mouse_x = x;
	fb_dos.mouse_y = y;
	fb_dos.mouse_cursor = cursor;
	
	fb_dos.regs.x.ax = 0x4;
	fb_dos.regs.x.cx = x;
	fb_dos.regs.x.dx = y;
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

/*:::::*/
static void fb_dos_timer_handler(void)
{
	if (fb_dos.in_interrupt) return;
	
	fb_dos.in_interrupt = TRUE;
	
	fb_dos.update();
	
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
	//_go32_dpmi_free_iret_wrapper(&fb_dos.new_timer_int);
}


/*:::::*/
void fb_dos_vga_set_palette(int idx, int r, int g, int b)
{
	outportb(0x3C8, idx);
	outportb(0x3C9, r >> 2);
	outportb(0x3C9, g >> 2);
	outportb(0x3C9, b >> 2);
}

/*:::::*/
void fb_dos_vga_wait_vsync(void)
{
	while (inportb(0x3DA) & 8) {
		__dpmi_yield();
	}
}


/*:::::*/
void fb_dos_detect(void)
{
	int i;
	
	/* detect VESA */
	
	_farsetsel(_dos_ds);
	
	for (i = 4; i < (int)sizeof(VbeInfoBlock); i++) {
		_farnspokeb(MASK_LINEAR(__tb) + i, 0);
	}
	
	dosmemput("VBE2", 4, MASK_LINEAR(__tb));
	
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
	
	/* detect mouse */
	
	fb_dos.regs.x.ax = 0x0;
	__dpmi_int(0x33, &fb_dos.regs);
	fb_dos.mouse_ok = (fb_dos.regs.x.ax == 0) ? FALSE : TRUE;
	
	fb_dos.regs.x.ax = 0x11;
	__dpmi_int(0x33, &fb_dos.regs);
	fb_dos.mouse_wheel_ok = ((fb_dos.regs.x.ax == 0x574D) && (fb_dos.regs.x.cx & 1)) ? TRUE : FALSE;
	
	fb_dos_save_video_mode();
	
}



/*:::::*/
void fb_dos_init(char *title, int w, int h, int depth, int refresh_rate, int flags)
{
	__dpmi_meminfo mi;
	
	/* lock code and data */
	
	mi.address = (unsigned int)fb_mode;
	mi.size = sizeof(MODE);
	__dpmi_lock_linear_region(&mi);
	
	mi.address = (int)&fb_mode->key;
	mi.size = 128;
	__dpmi_lock_linear_region(&mi);
	
	mi.address = (unsigned int)&fb_dos;
	mi.size = sizeof(fb_dos);
	__dpmi_lock_linear_region(&mi);
	
	mi.address = (unsigned int)kb_handler;
	mi.size = (unsigned int)end_kb_handler - (unsigned int)kb_handler;
	__dpmi_lock_linear_region(&mi);
	
	mi.address = (unsigned int)fb_dos_timer_handler;
	mi.size = (unsigned int)end_fb_dos_timer_handler;
	__dpmi_lock_linear_region(&mi);
	
	fb_dos.w = w;
	fb_dos.h = h;
	fb_dos.depth = depth;
	fb_dos.Bpp = depth / 8;
	fb_dos.size = fb_dos.w * fb_dos.h * fb_dos.Bpp;
	
	switch (depth) {
		case 8: fb_dos.draw_mouse = fb_dos_draw_mouse_8;
			fb_dos.undraw_mouse = fb_dos_undraw_mouse_8;
			break;
	}
	

	
	fb_dos_kb_init();
	
	fb_dos_mouse_init();
	
	fb_dos_timer_init();
	
	fb_dos_timer_set_rate(refresh_rate);
	
	fb_dos_set_mouse(fb_dos.w / 2, fb_dos.h / 2, 1);
	fb_dos.mouse_z = fb_dos.mouse_wheel_ok ? 0 : -1;
	
	fb_dos.inited = TRUE;
}

/*:::::*/
void fb_dos_exit(void)
{
	__dpmi_meminfo mi;
	
	if (!fb_dos.inited) return;
	
	fb_dos_timer_exit();
	
	fb_dos_mouse_exit();
	
	fb_dos_kb_exit();
	
	fb_dos_restore_video_mode();
	
	/* unlock code and data */
	
	mi.address = (unsigned int)fb_mode;
	mi.size = sizeof(MODE);
	__dpmi_unlock_linear_region(&mi);
	
	mi.address = (int)&fb_mode->key;
	mi.size = 128;
	__dpmi_unlock_linear_region(&mi);
	
	mi.address = (unsigned int)&fb_dos;
	mi.size = sizeof(fb_dos);
	__dpmi_unlock_linear_region(&mi);
	
	mi.address = (unsigned int)kb_handler;
	mi.size = (unsigned int)end_kb_handler - (unsigned int)kb_handler;
	__dpmi_unlock_linear_region(&mi);
	
	mi.address = (unsigned int)fb_dos_timer_handler;
	mi.size = (unsigned int)end_fb_dos_timer_handler;
	__dpmi_unlock_linear_region(&mi);
	
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
}
