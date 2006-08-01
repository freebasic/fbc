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

extern GFXDRIVER fb_gfxDriverVESAlinear;
extern GFXDRIVER fb_gfxDriverVESA;
extern GFXDRIVER fb_gfxDriverBIOS;
extern GFXDRIVER fb_gfxDriverVGA;
extern GFXDRIVER fb_gfxDriverModeX;

const GFXDRIVER *fb_gfx_driver_list[] = {
	&fb_gfxDriverVESAlinear,
	&fb_gfxDriverVESA,
	&fb_gfxDriverVGA,
	&fb_gfxDriverModeX,
	&fb_gfxDriverBIOS,
	NULL
};

fb_dos_t fb_dos;

static void fb_dos_save_video_mode(void);
static void fb_dos_restore_video_mode(void);

/* layout from libfb_gfx_mouse.s */

extern char fb_dos_mouse_isr_start;
extern short fb_dos_mouse_x;
extern short fb_dos_mouse_y;
extern short fb_dos_mouse_z;
extern char fb_dos_mouse_buttons;
extern void fb_dos_mouse_isr(void);
extern char fb_dos_mouse_isr_end;

/* end libfb_gfx_mouse.s */

static __dpmi_regs fb_dos_mouse_regs;
static __dpmi_raddr fb_dos_mouse_isr_rmcb;

#define lock_var(var)        fb_dos_lock_data( &(var), sizeof(var) )
#define lock_array(array)    fb_dos_lock_data( (array), sizeof(array) )
#define lock_proc(proc)      fb_dos_lock_code( proc, (char *)( end_##proc ) - (char *)(proc) )

#define unlock_var(var)      fb_dos_unlock_data( &(var), sizeof(var) )
#define unlock_array(array)  fb_dos_unlock_data( (array), sizeof(array) )
#define unlock_proc(proc)    fb_dos_unlock_code( proc, (char *)( end_##proc ) - (char *)(proc) )

/*:::::*/
static void fb_dos_kb_init(void)
{
	fb_hooks.inkeyproc  = NULL;
	fb_hooks.getkeyproc = NULL;
	fb_hooks.keyhitproc = NULL;
	fb_hooks.multikeyproc = NULL;
	fb_hooks.sleepproc = NULL;
	return;
}

/*:::::*/
static void fb_dos_kb_exit(void)
{
}

/*:::::*/
static int fb_dos_mouse_init(void)
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

	/* ensure that the mouse isn't drawn by the mouse driver */
	fb_dos.regs.x.ax = 0x2;
	__dpmi_int(0x33, &fb_dos.regs);
	
	fb_hSoftCursorInit();

	/* allocate real-mode callback */
	if (__dpmi_allocate_real_mode_callback(fb_dos_mouse_isr, &fb_dos_mouse_regs, &fb_dos_mouse_isr_rmcb))
		return -1;
	
	/* set user interrupt routine */
	fb_dos.regs.x.ax = 0x0C;
	fb_dos.regs.x.cx = 0xFF;
	fb_dos.regs.x.es = fb_dos_mouse_isr_rmcb.segment;
	fb_dos.regs.x.dx = fb_dos_mouse_isr_rmcb.offset16;
	__dpmi_int(0x33, &fb_dos.regs);

}

/*:::::*/
int fb_dos_get_mouse(int *x, int *y, int *z, int *buttons)
{
	if (!fb_dos.mouse_ok) return -1;
	
	*x = fb_dos_mouse_x;
	*y = fb_dos_mouse_y;
	*z = (fb_dos.mouse_wheel_ok ? fb_dos_mouse_z : -1);
	*buttons = fb_dos_mouse_buttons;
	
	return 0;
}

/*:::::*/
void fb_dos_set_mouse(int x, int y, int cursor)
{
	int new_x, new_y;
	
	if (!fb_dos.mouse_ok) return;
	
	new_x = ((x >= 0) ? x : fb_dos_mouse_x);
	new_y = ((y >= 0) ? y : fb_dos_mouse_y);
	fb_dos.mouse_cursor = cursor;
	
	fb_dos.regs.x.ax = 0x4;
	fb_dos.regs.x.cx = new_x;
	fb_dos.regs.x.dx = new_y;
	__dpmi_int(0x33, &fb_dos.regs);
	
	fb_dos_mouse_x = new_x;
	fb_dos_mouse_y = new_y;
}


/*:::::*/
static void fb_dos_mouse_exit(void)
{
	if (!fb_dos.mouse_ok) return;
	
	fb_hSoftCursorExit();

	fb_dos.regs.x.ax = 0x0;
	__dpmi_int(0x33, &fb_dos.regs);
	
	__dpmi_free_real_mode_callback(&fb_dos_mouse_isr_rmcb);
}

/*:::::*/
static int fb_dos_timer_handler(unsigned irq)
{
	int do_abort;

	fb_dos.timer_ticks += fb_dos.timer_step;
	if( (do_abort = fb_dos.timer_ticks < 65536)==FALSE )
		fb_dos.timer_ticks -= 65536;

	if (fb_dos.in_interrupt)
		return do_abort;

	fb_dos.in_interrupt = TRUE;

#if 0 /* Set to 1 if you want to debug a display driver */
	outportb(0x20, 0x20);
	fb_dos_sti();
#endif

	if( fb_dos.set_palette )
		fb_dos.set_palette();
	
	if ( fb_dos.mouse_ok && fb_dos.mouse_cursor )
		fb_hSoftCursorPut(fb_dos_mouse_x, fb_dos_mouse_y);
	
	fb_dos.update();
	fb_hMemSet(fb_mode->dirty, FALSE, fb_dos.h);

	if ( fb_dos.mouse_ok && fb_dos.mouse_cursor ) {
		fb_hSoftCursorUnput(fb_dos_mouse_x, fb_dos_mouse_y);
		fb_hMemSet(fb_mode->dirty + fb_dos_mouse_y, TRUE, MIN(fb_dos.h - fb_dos_mouse_y, 21) );
	}

	fb_dos.in_interrupt = FALSE;

	return do_abort;
}

static void end_fb_dos_timer_handler(void) { /* do not remove */ }

/*:::::*/
static int fb_dos_timer_set_rate(int rate)
{
	int i;
	while (rate > 65536 )
		rate /= 2;
	for (i = 0; i != 4; ++i) {
		outportb(0x43, 0x34);
		outportb(0x40, rate & 0xff);
		outportb(0x40, rate >> 8);
	}
	return rate;
}

/*:::::*/
static int fb_dos_timer_set_freq(int freq)
{
	return fb_dos_timer_set_rate( 1193181 / freq );
}

/*:::::*/
static int fb_dos_timer_init(int freq)
{
	fb_dos.timer_ticks = 0;
	fb_dos.timer_step = fb_dos_timer_set_freq( freq );
	return fb_isr_set( 0, fb_dos_timer_handler, 0, 16384 );
}

/*:::::*/
static void fb_dos_timer_exit(void)
{
	fb_dos_cli();
	fb_isr_reset( 0 );
	fb_dos_timer_set_rate( 0 );
	fb_dos_sti();
}


/*:::::*/
void fb_dos_set_palette(int idx, int r, int g, int b)
{
	fb_dos.pal_dirty = TRUE;
	fb_dos.pal[idx].r = r;
	fb_dos.pal[idx].g = g;
	fb_dos.pal[idx].b = b;
	fb_dos.pal_first = MIN(fb_dos.pal_first, idx);
	fb_dos.pal_last = MAX(fb_dos.pal_last, idx);
}

/*:::::*/
void fb_dos_vga_set_palette(void)
{
	int i, color_count;

	if( fb_dos.depth > 8 )
		return;

	if( !fb_dos.pal_dirty )
		return;
	
	if ( fb_dos.mouse_ok ) fb_hSoftCursorPaletteChanged();

	color_count = MIN( (1 << fb_dos.depth), fb_dos.pal_last + 1 );
	
	outportb(0x3C8, fb_dos.pal_first);
	for (i = fb_dos.pal_first; i < color_count; i++) {
		outportb(0x3C9, fb_dos.pal[i].r >> 2);
		outportb(0x3C9, fb_dos.pal[i].g >> 2);
		outportb(0x3C9, fb_dos.pal[i].b >> 2);
	}
	
	fb_dos.pal_dirty = FALSE;
	fb_dos.pal_last = 0;
	fb_dos.pal_first = 256;
}

/*:::::*/
void fb_dos_vga_wait_vsync(void)
{
	while ((inportb(0x3DA) & 8) != 0);
	while ((inportb(0x3DA) & 8) == 0);
}

/*:::::*/
void fb_dos_detect(void)
{
	
	if (!fb_dos.detected) {
		fb_dos.detected = TRUE;
		
		/* detect mouse */
		
		fb_dos.regs.x.ax = 0x0;
		__dpmi_int(0x33, &fb_dos.regs);
		fb_dos.mouse_ok = (fb_dos.regs.x.ax == 0) ? FALSE : TRUE;
		
		fb_dos.regs.x.ax = 0x11;
		__dpmi_int(0x33, &fb_dos.regs);
		fb_dos.mouse_wheel_ok = ((fb_dos.regs.x.ax == 0x574D) && (fb_dos.regs.x.cx & 1)) ? TRUE : FALSE;
		
		/* detect nearptr */
		if ( fb_dos.nearptr_ok = __djgpp_nearptr_enable() )
			__djgpp_nearptr_disable();
	}
	
	/* save current video mode */
	
	fb_dos_save_video_mode();

}

/*:::::*/
int fb_dos_init(char *title, int w, int h, int depth, int refresh_rate, int flags)
{
	fb_dos.inited = TRUE;
	
	/* lock code and data accessed in int handlers */
	
	lock_var(fb_mode);
	lock_var(fb_dos);
	fb_dos_lock_data(&fb_mode->key, 128);
	lock_proc(fb_dos_timer_handler);
	lock_proc(fb_dos_timer_handler);
	fb_dos_lock_code(fb_dos.update, fb_dos.update_len);
	
	/* TODO: lock fb_hMemCpy and fb_hMemSet (the actual code and the pointers) */
	
	fb_dos.w = w;
	fb_dos.h = h;
	fb_dos.depth = depth;
	fb_dos.Bpp = (depth + 7) / 8;
	fb_mode->refresh_rate = fb_dos.refresh = refresh_rate;
	
	fb_dos_kb_init();
	if (!fb_dos_mouse_init())
		return -1;
	
	if (!fb_dos_timer_init(refresh_rate))
		return -1;
	
	if (fb_dos.mouse_ok)
		fb_dos_set_mouse(fb_dos.w / 2, fb_dos.h / 2, TRUE);
	else
		fb_dos.mouse_cursor = FALSE;

	return 0;
}

/*:::::*/
void fb_dos_exit(void)
{

	if (!fb_dos.inited) return;

	fb_dos_cli();

	fb_dos_timer_exit();
	fb_dos_mouse_exit();
	fb_dos_kb_exit();

	fb_dos_sti();

	fb_dos.w = fb_dos.h = fb_dos.depth = fb_dos.refresh = 0;

	/* unlock code and data */

	unlock_var(fb_mode);
	unlock_var(fb_dos);
	fb_dos_unlock_data(&fb_mode->key, 128);
	unlock_proc(fb_dos_timer_handler);
	fb_dos_unlock_code(fb_dos.update, fb_dos.update_len);
	
	fb_dos_restore_video_mode();

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
	int n = fb_ConsoleWidth(0, 0);
	
	fb_dos.old_rows = n >> 16;
	fb_dos.old_cols = n & 0xFFFF;
}

/*:::::*/
static void fb_dos_restore_video_mode(void)
{
	if (fb_dos.old_rows == 0)
		return;
	
	fb_ConsoleWidth(fb_dos.old_rows, fb_dos.old_cols);
	
	fb_dos.old_rows = fb_dos.old_cols = 0;

}

/*:::::*/
void fb_hScreenInfo(int *width, int *height, int *depth, int *refresh)
{
	*width = fb_dos.w;
	*height = fb_dos.h;
	*depth = fb_dos.depth;
	*refresh = fb_dos.refresh;
}
