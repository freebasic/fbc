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
extern GFXDRIVER fb_gfxDriverBIOS;
extern GFXDRIVER fb_gfxDriverVGA;
extern GFXDRIVER fb_gfxDriverModeX;

const GFXDRIVER *fb_gfx_driver_list[] = {
	&fb_gfxDriverVESA,
	&fb_gfxDriverVGA,
    &fb_gfxDriverModeX,
    &fb_gfxDriverBIOS,
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

static unsigned char mouse_save[MOUSE_WIDTH * MOUSE_HEIGHT * 4 + 4];

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
    fb_hooks.sleepproc = NULL;
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

	/* ensure that the mouse isn't drawn by the mouse driver */
	fb_dos.regs.x.ax = 0x2;
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
    int new_x, new_y;

	if (!fb_dos.mouse_ok) return;

    new_x = ((x >= 0) ? x : fb_dos.mouse_x);
    new_y = ((y >= 0) ? y : fb_dos.mouse_y);
	fb_dos.mouse_cursor = cursor;

	fb_dos.regs.x.ax = 0x4;
	fb_dos.regs.x.cx = new_x;
	fb_dos.regs.x.dx = new_y;
	__dpmi_int(0x33, &fb_dos.regs);
}

/*:::::*/
int fb_dos_update_mouse(void)
{
    int old_buttons, old_x, old_y, old_z;

    if (!fb_dos.mouse_ok)
        return FALSE;

	fb_dos.regs.x.ax = 0x3;
	__dpmi_int(0x33, &fb_dos.regs);

    old_buttons = fb_dos.mouse_buttons;
    old_x = fb_dos.mouse_x;
    old_y = fb_dos.mouse_y;
    old_z = fb_dos.mouse_z;

	fb_dos.mouse_buttons = fb_dos.regs.h.bl;

	fb_dos.mouse_x = fb_dos.regs.x.cx;
	fb_dos.mouse_y = fb_dos.regs.x.dx;

    if (fb_dos.mouse_wheel_ok)
        fb_dos.mouse_z -= fb_dos.regs.h.bh;

    return (old_buttons!=fb_dos.mouse_buttons)
        || (old_x!=fb_dos.mouse_x)
        || (old_y!=fb_dos.mouse_y)
        || (old_z!=fb_dos.mouse_z);
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
    int x1 = fb_dos.mouse_x;
    int y1 = fb_dos.mouse_y;
    int x2 = x1 + MOUSE_WIDTH;
    int y2 = y1 + MOUSE_HEIGHT;
    int lines, width;
    int frame_byte_width, copy_byte_width;
    unsigned char *pMouseImage, *pBuffer, *pFrame;

    if (!fb_dos.mouse_cursor)
        return;

    if( y2 > fb_dos.h )
        y2 = fb_dos.h;
    if( x2 > fb_dos.w )
        x2 = fb_dos.w;

    lines = y2 - y1;
    width = x2 - x1;

    frame_byte_width = fb_dos.Bpp * fb_dos.w;
    copy_byte_width = fb_dos.Bpp * width;

    pFrame = fb_mode->framebuffer + (y1 * fb_dos.w + x1) * fb_dos.Bpp;
    pBuffer = mouse_save;

    pMouseImage = fb_dos_mouse_image;
    while( lines-- ) {
        int x;
        fb_hMemCpy( pBuffer, pFrame, copy_byte_width );

        fb_mode->dirty[ y1++ ] = TRUE;
        for( x=0; x!=width; ++x ) {
            unsigned mouse_color_index = *pMouseImage++;
            if( mouse_color_index!=0 ) {
                /* Only draw non-transparent pixels */
                pFrame[x] = mouse_color[ mouse_color_index ];
            }
        }

        pMouseImage += MOUSE_WIDTH - width;
        pBuffer += copy_byte_width;
        pFrame += frame_byte_width;
    }
}

static void end_fb_dos_draw_mouse_8(void) {}

/*:::::*/
static void fb_dos_undraw_mouse_8(void)
{
    int x1 = fb_dos.mouse_x;
    int y1 = fb_dos.mouse_y;
    int x2 = x1 + MOUSE_WIDTH;
    int y2 = y1 + MOUSE_HEIGHT;
    int lines, width;
    int frame_byte_width, copy_byte_width;
    unsigned char *pBuffer, *pFrame;

    if( !fb_dos.mouse_cursor )
        return;

    if( y2 > fb_dos.h )
        y2 = fb_dos.h;
    if( x2 > fb_dos.w )
        x2 = fb_dos.w;

    lines = y2 - y1;
    width = x2 - x1;

    frame_byte_width = fb_dos.Bpp * fb_dos.w;
    copy_byte_width = fb_dos.Bpp * width;

    pFrame = fb_mode->framebuffer + (y1 * fb_dos.w + x1) * fb_dos.Bpp;
    pBuffer = mouse_save;

    while( lines-- ) {
        fb_hMemCpy( pFrame, pBuffer, copy_byte_width );

        fb_mode->dirty[ y1++ ] = TRUE;

        pBuffer += copy_byte_width;
        pFrame += frame_byte_width;
    }
}

static void end_fb_dos_undraw_mouse_8(void) {}

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
    fb_dos_update_mouse();
    if( fb_dos.draw_mouse )
        fb_dos.draw_mouse();
    fb_dos.update();
    fb_hMemSet(fb_mode->dirty, FALSE, fb_dos.h);
    if( fb_dos.undraw_mouse )
        fb_dos.undraw_mouse();

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
static void fb_dos_timer_init(int freq)
{
    fb_dos.timer_ticks = 0;
    fb_dos.timer_step = fb_dos_timer_set_freq( freq );
    fb_isr_set( 0, fb_dos_timer_handler, 0, 16384 );
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
}

/*:::::*/
static int fb_dos_find_nearest_color(unsigned char r, unsigned char g, unsigned char b)
{
    if( fb_dos.depth <= 8 ) {
        int i, curr_idx = -1;
        int dr, dg, db;
        int err, curr_err = INT_MAX;
        int color_count = 1 << fb_dos.depth;

        /* find nearest color with least-squares */
        for (i = 0; i!=color_count ; i++) {
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
    } else {
        /* FIXME: Return the correct RGB value */
        return 0;
    }
}

/*:::::*/
void fb_dos_vga_set_palette(void)
{
    int i, color_count;

    if( fb_dos.depth > 8 )
        return;

    if( !fb_dos.pal_dirty )
        return;

	/* find best colors for mouse pointer */
	mouse_color[1] = fb_dos_find_nearest_color(255, 255, 255);
	mouse_color[2] = fb_dos_find_nearest_color(0, 0, 0);

    color_count = (1 << fb_dos.depth);
	for (i = 0; i!=color_count; i++) {
		outportb(0x3C8, i);
		outportb(0x3C9, fb_dos.pal[i].r >> 2);
		outportb(0x3C9, fb_dos.pal[i].g >> 2);
		outportb(0x3C9, fb_dos.pal[i].b >> 2);
    }

    fb_dos.pal_dirty = FALSE;
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
	fb_dos.Bpp = (depth + 7) / 8;
	fb_mode->refresh_rate = fb_dos.refresh = refresh_rate;

	if (depth <= 8) {
        fb_dos.draw_mouse = fb_dos_draw_mouse_8;
        fb_dos.undraw_mouse = fb_dos_undraw_mouse_8;
    } else {
        fb_dos.draw_mouse = NULL;
        fb_dos.undraw_mouse = NULL;
	}

    fb_dos_kb_init();
	fb_dos_mouse_init();
	fb_dos_timer_init(refresh_rate);

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

    fb_dos_cli();

	fb_dos_timer_exit();
	fb_dos_mouse_exit();
    fb_dos_kb_exit();

    fb_dos_sti();



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
