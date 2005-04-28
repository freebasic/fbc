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

#include "gfx_dos.h"





/*


TODO:


inkey$
clear keybuf somewhere - on a timer int?
mouse - use timer int to draw + polling or install mouse handler?



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


/* 12x21 */
char fb_dos_mouse_image[] = {		1,	0,
					2, 	0,  0,
					3,	0,  15, 0,
					4,	0,  15, 15, 0,
					5,	0,  15, 15, 15, 0,
					6,	0,  15, 15, 15, 15, 0,
					7,	0,  15, 15, 15, 15, 15, 0,
					8,	0,  15, 15, 15, 15, 15, 15, 0,
					9,	0,  15, 15, 15, 15, 15, 15, 15, 0,
					10,	0,  15, 15, 15, 15, 15, 15, 15, 15, 0,
					11,	0,  15, 15, 15, 15, 15, 15, 15, 15, 15, 0,
					12, 	0,  15, 15, 15, 15, 15, 15, 0,  0,  0,  0,  0,
					8,	0,  15, 15, 15, 0,  15, 15, 0,
					8,	0,  15, 15, 0,  0,  15, 15, 0,
					9,	0,  15, 0,  -1, -1, 0,  15, 15, 0,
					9, 	0,  0, -1,  -1, -1, 0,  15, 15, 0,
					10,	0,  -1, -1, -1, -1, -1, 0,  15, 15, 0,
					10,	-1, -1, -1, -1, -1, -1, 0,  15, 15, 0,
					11,	-1, -1, -1, -1, -1, -1, -1, 0,  15, 15, 0,
					11,	-1, -1, -1, -1, -1, -1, -1, 0,  15, 15, 0,
					10,	-1, -1, -1, -1, -1, -1, -1, -1, 0,  0		};


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

	fb_mode->key[scan] = 1;
}

static void end_kb_handler(void)
{ /* this function exists to get length of kb_handler() code */ }
				

/*:::::*/
void fb_dos_kb_init(void)
{
	fb_dos.new_kb_int.pm_offset = (unsigned int)kb_handler;
	_go32_dpmi_allocate_iret_wrapper(&fb_dos.new_kb_int);
	_go32_dpmi_set_protected_mode_interrupt_vector(0x9, &fb_dos.new_kb_int);
	return;
}


/*:::::*/
void fb_dos_kb_exit(void)
{
	_go32_dpmi_free_iret_wrapper(&fb_dos.new_kb_int);
}

/*:::::*/
void fb_dos_kb_clear(void)
{
	fb_hMemSet(fb_mode->key, 0, 128);
}



/*:::::*/
void fb_dos_mouse_init(void)
{
	
	return;
}


/*:::::*/
int fb_dos_get_mouse(int *x, int *y, int *z, int *buttons)
{
	
	if (!fb_dos.mouse_ok) return -1;
	
	*x = fb_dos.mouse_x;
	*y = fb_dos.mouse_y;
	*buttons = fb_dos.mouse_buttons;
	
	/* TODO: detect CuteMouse driver and use wheel API? */
	*z = -1;
	
	return 0;
}

/*:::::*/
void fb_dos_set_mouse(int x, int y, int cursor)
{
	if (!fb_dos.mouse_ok) return;
	
	fb_dos.mouse_x = x;
	fb_dos.mouse_y = y;
	fb_dos.mouse_cursor = cursor;
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
	
	/* detect Windows */
	
	fb_dos.windows_ok = FALSE;
	fb_dos.win95_ok = FALSE;
	
	fb_dos.regs.x.ax = 0x160A;
	__dpmi_int(0x2F, &fb_dos.regs);
	
	if (fb_dos.regs.x.ax == 0x0000) {
		fb_dos.windows_ok = TRUE;

		if (fb_dos.regs.x.bx >= 0x0400) {
			fb_dos.win95_ok = TRUE;
		}
	}
	
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
	fb_dos.mouse_ok = (fb_dos.regs.x.ax == 0) ? 0 : 1;
	
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
	
	/* save old interrupt vectors */
	_go32_dpmi_get_protected_mode_interrupt_vector(0x9, &fb_dos.old_kb_int);
		
	fb_dos.w = w;
	fb_dos.h = h;
	fb_dos.depth = depth;
	fb_dos.Bpp = depth / 8;
	fb_dos.size = fb_dos.w * fb_dos.h * fb_dos.Bpp;
	
	fb_dos_kb_init();
	
	fb_dos_mouse_init();
	
	fb_dos_set_mouse(fb_dos.w / 2, fb_dos.h / 2, 1);
	
	fb_dos_set_window_title(title);
}

/*:::::*/
void fb_dos_exit(void)
{
	__dpmi_meminfo mi;
	
	fb_dos_set_window_title(NULL);
	
	/* restore old interrupt vectors */
	_go32_dpmi_set_protected_mode_interrupt_vector(0x9, &fb_dos.old_kb_int);
	
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
}


/*:::::*/
void fb_dos_set_window_title(char *title)
{
	int len;
	
	if (!fb_dos.win95_ok) return;
	
	if (title == NULL) title = "";
	
	len = strlen(title);
	if (len > 79) {
		title[80] = '\0';
		len = 79;
	}
	
	dosmemput(title, len + 1, MASK_LINEAR(__tb));
	
	fb_dos.regs.x.ax = 0x168E;
	fb_dos.regs.x.dx = 0x0001;
	fb_dos.regs.x.es = RM_SEGMENT(__tb);
	fb_dos.regs.x.di = RM_OFFSET(__tb);
	__dpmi_int(0x2F, &fb_dos.regs);
}

/*:::::*/
void fb_dos_save_video_mode(void)
{
	fb_dos.old_rows = ScreenRows();
	fb_dos.old_cols = ScreenCols();
}


/*:::::*/
void fb_dos_restore_video_mode(void)
{
	fb_dos.regs.x.ax = 3;
	__dpmi_int(0x10, &fb_dos.regs);
	_set_screen_lines(fb_dos.old_rows);
}
