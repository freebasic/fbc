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

static __dpmi_regs fb_dos_mouse_regs;
static __dpmi_raddr fb_dos_mouse_isr_rmcb;

/* layout from libfb_gfx_mouse.s */

extern void fb_dos_mouse_isr_start(void);
extern short fb_dos_mouse_x;
extern short fb_dos_mouse_y;
extern short fb_dos_mouse_z;
extern char fb_dos_mouse_buttons;
extern void fb_dos_mouse_isr(void);
extern void fb_dos_mouse_isr_end(void);

/* from libfb_gfx_softcursor.c */

extern char fb_hSoftCursor_data_start;
extern char fb_hSoftCursor_data_end;
extern void fb_hSoftCursor_code_start(void);
extern void fb_hSoftCursor_code_end(void);

/* from libfb_gfx_blitter.c */
extern void fb_hBlit_code_start(void);
extern void fb_hBlit_code_end(void);

/* from libfb_gfx_blitter_mmx.s */
extern char fb_hBlitMMX_data_start;
extern char fb_hBlitMMX_data_end;
extern void fb_hBlitMMX_code_start(void);
extern void fb_hBlitMMX_code_end(void);

/* from libfb_gfx_mmx.s */
extern void fb_MMX_code_start(void);
extern void fb_MMX_code_end(void);

/* from libfb_gfx_core.c */
void fb_hPostEvent_code_start(void);
void fb_hPostEvent_code_end(void);

#define KB_EXTENDED (255 << 8)

#define X KB_EXTENDED
static const unsigned short kb_scan_to_ascii[128][3] = {
	/*
	normal
		   +shift
	                +ctrl
	*/
	{    0,     0,     0},
	{   27,    27,     0},	/* esc */
	{   49,    33,     0},	/* 1 ! */
	{   50,    64,   X|3},	/* 2 @ */
	{   51,    35,     0},	/* 3 # */
	{   52,    36,     0},	/* 4 $ */
	{   53,    37,     0},	/* 5 % */
	{   54,    94,     0},	/* 6 ^ */
	{   55,    38,     0},	/* 7 & */
	{   56,    42,     0},	/* 8 * */
	{   57,    40,     0},	/* 9 ( */
	{   48,    41,     0},	/* 0 ) */
	{   45,    95,     0},	/* - _ */
	{   61,    43,     0},	/* = + */
	{    8,     8,   127},	/* backspace */
	{    9,     9, X|148},	/* tab */
	{  113,    81,    17},	/* q Q */
	{  119,    87,    23},	/* w W */
	{  101,    69,     5},	/* e E */
	{  114,    82,    18},	/* r R */
	{  116,    84,    20},	/* t T */
	{  121,    89,    25},	/* y Y */
	{  117,    85,    21},	/* u U */
	{  105,    73,     9},	/* i I */
	{  111,    79,    15},	/* o O */
	{  112,    80,    16},	/* p P */
	{   91,   123,    27},	/* [ { */
	{   93,   125,    29},	/* ] } */
	{   13,    13,    10},	/* enter */
	{    0,     0,     0},	/* ctrl */
	{   97,    65,     1},	/* a A */
	{  115,    83,     0},	/* s S */
	{  100,    68,     4},	/* d D */
	{  102,    70,     6},	/* f F */
	{  103,    71,     7},	/* g G */
	{  104,    72,     8},	/* h H */
	{  106,    74,    10},	/* j J */
	{  107,    75,    11},	/* k K */
	{  108,    76,    12},	/* l L */
	{   59,    58,     0},	/* ; : */
	{   39,    34,     0},	/* ' " */
	{   96,   126,     0},	/* ` ~ */
	{    0,     0,     0},	/* lshift */
	{   92,   124,    28},	/* \ | */
	{  122,    90,    26},	/* z Z */
	{  120,    88,    24},	/* x X */
	{   99,    67,     0},	/* c C */
	{  118,    86,    22},	/* v V */
	{   98,    66,     2},	/* b B */
	{  110,    78,    14},	/* n N */
	{  109,    77,    13},	/* m M */
	{   44,    60,     0},	/* , < */
	{   46,    62,     0},	/* . > */
	{   47,    63,     0},	/* / ? */
	{    0,     0,     0},	/* rshift */
	{   42,    42,     0},	/* numpad * */
	{    0,     0,     0},	/* alt */
	{   32,    32,    32},	/* space */
	{    0,     0,     0},	/* caps lock */
	{ X|59,  X|84,  X|94},	/* F1  */
	{ X|60,  X|85,  X|95},	/* F2  */
	{ X|61,  X|86,  X|96},	/* F3  */
	{ X|62,  X|87,  X|97},	/* F4  */
	{ X|63,  X|88,  X|98},	/* F5  */
	{ X|64,  X|89,  X|99},	/* F6  */
	{ X|65,  X|90, X|100},	/* F7  */
	{ X|66,  X|91, X|101},	/* F8  */
	{ X|67,  X|92, X|102},	/* F9  */
	{ X|68,  X|93, X|103},	/* F10 */
	{    0,     0,     0},	/* num lock */
	{    0,     0,     0},	/* scroll lock */
	{ X|71,  X|71, X|119},	/* home */
	{ X|72,  X|72, X|141},	/* up */
	{ X|73,  X|73, X|134},	/* page up */
	{ X|75,  X|75, X|115},	/* left */
	{ X|77,  X|77, X|116},	/* right */
	{   43,    43,     0},	/* numpad + */
	{ X|79,  X|79, X|117},	/* end */
	{ X|80,  X|80, X|145},	/* down */
	{ X|81,  X|81, X|118},	/* page down */
	{ X|82,  X|82, X|146},	/* insert */
	{ X|83,  X|83, X|147},	/* delete */
	{X|133, X|135, X|137},	/* F11 */
	{X|134, X|138, X|138}	/* F12 */
};
#undef X


#define lock_var(var)         fb_dos_lock_data( &(var), sizeof(var) )
#define lock_array(array)     fb_dos_lock_data( (array), sizeof(array) )
#define lock_proc(proc)       fb_dos_lock_code( proc, (char *)( end_##proc ) - (char *)(proc) )
#define lock_data(start, end) fb_dos_lock_data( (&start), (const char *)(&end) - (const char *)(&start) )
#define lock_code(start, end) fb_dos_lock_code( (start), (const char *)(end) - (const char *)(start) )

#define unlock_var(var)         fb_dos_unlock_data( &(var), sizeof(var) )
#define unlock_array(array)     fb_dos_unlock_data( (array), sizeof(array) )
#define unlock_proc(proc)       fb_dos_unlock_code( proc, (char *)( end_##proc ) - (char *)(proc) )
#define unlock_data(start, end) fb_dos_unlock_data( (&start), (const char *)(&end) - (const char *)(&start) )
#define unlock_code(start, end) fb_dos_unlock_code( (start), (const char *)(end) - (const char *)(start) )

/*:::::*/
static void fb_dos_kb_init(void)
{
	__fb_ctx.hooks.inkeyproc  = NULL;
	__fb_ctx.hooks.getkeyproc = NULL;
	__fb_ctx.hooks.keyhitproc = NULL;
	__fb_ctx.hooks.multikeyproc = NULL;
	__fb_ctx.hooks.sleepproc = NULL;
	return;
}

/*:::::*/
static void fb_dos_kb_exit(void)
{
}

/*:::::*/
static int fb_dos_mouse_init(void)
{
	
	if (!fb_dos.mouse_ok) return -1; /* set in fb_dos_detect(); return success if no mouse */

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
		return 0; /* failure */
	
	/* set user interrupt routine */
	fb_dos.regs.x.ax = 0x0C;
	fb_dos.regs.x.cx = 0xFF;
	fb_dos.regs.x.es = fb_dos_mouse_isr_rmcb.segment;
	fb_dos.regs.x.dx = fb_dos_mouse_isr_rmcb.offset16;
	__dpmi_int(0x33, &fb_dos.regs);

	return -1; /* success */
}

/*:::::*/
int fb_dos_get_mouse(int *x, int *y, int *z, int *buttons)
{
	if (!fb_dos.mouse_ok) return -1;
	
	*x = fb_dos_mouse_x;
	*y = fb_dos_mouse_y;
	*z = (fb_dos.mouse_wheel_ok ? fb_dos_mouse_z : 0);
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
	int mouse_x = 0, mouse_y = 0;
	int i, mask, key;
	int buttons;
	int ctrl, shift;
	EVENT e;

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
	
	mouse_x = fb_dos_mouse_x;
	mouse_y = fb_dos_mouse_y;
	if ( fb_dos.mouse_ok && fb_dos.mouse_cursor ) {
		fb_hSoftCursorPut(mouse_x, mouse_y);
	}
	
	fb_dos.update();
	fb_hMemSet(fb_mode->dirty, FALSE, fb_dos.h);

	if ( fb_dos.mouse_ok && fb_dos.mouse_cursor ) {
		fb_hSoftCursorUnput(mouse_x, mouse_y);
	}
	
	e.type = 0;

	if ( fb_dos.mouse_ok ) {	
	
		if ( (fb_dos.mouse_x_old != mouse_x) || (fb_dos.mouse_y_old != mouse_y) ) {
			e.type = EVENT_MOUSE_MOVE;
			e.x = mouse_x;
			e.y = mouse_y;
			e.dx = mouse_x - fb_dos.mouse_x_old;
			e.dy = mouse_y - fb_dos.mouse_y_old;
			fb_hPostEvent(&e);
		}
		
		if ( fb_dos.mouse_z_old != fb_dos_mouse_z ) {
			e.type = EVENT_MOUSE_WHEEL;
			e.z = fb_dos_mouse_z;
			fb_hPostEvent(&e);
		}

		if (fb_dos_mouse_buttons != fb_dos.mouse_buttons_old) {
			buttons = (fb_dos_mouse_buttons ^ fb_dos.mouse_buttons_old) & 0x7;
			for (e.button = 0x4; e.button; e.button >>= 1) {
				if (buttons & e.button) {
					if (fb_dos_mouse_buttons & e.button)
						e.type = EVENT_MOUSE_BUTTON_PRESS;
					else
						e.type = EVENT_MOUSE_BUTTON_RELEASE;
					fb_hPostEvent(&e);
				}
			}
		}

		fb_dos.mouse_x_old = mouse_x;
		fb_dos.mouse_y_old = mouse_y;
		fb_dos.mouse_z_old = fb_dos_mouse_z;
		fb_dos.mouse_buttons_old = fb_dos_mouse_buttons;
	}
	
	ctrl = fb_ConsoleMultikey(SC_CONTROL);
	shift = fb_ConsoleMultikey(SC_LSHIFT) || fb_ConsoleMultikey(SC_RSHIFT);
	for (i = 0; i < 128; i++) {
		e.type = 0;
		key = fb_ConsoleMultikey( i );
		if ( key && !fb_dos.key_old[i] ) {
			e.type = EVENT_KEY_PRESS;
		} else if ( !key && fb_dos.key_old[i] ) {
			e.type = EVENT_KEY_RELEASE;
		}
		if ( e.type ) {
			e.scancode = i;
			
			e.ascii = kb_scan_to_ascii[i][ctrl ? 2 : (shift ? 1 : 0)]; /* FIXME */
			fb_hPostEvent(&e);
		}	
		fb_dos.key_old[i] = key;
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
		fb_dos.nearptr_ok = __djgpp_nearptr_enable();
		if ( fb_dos.nearptr_ok )
			__djgpp_nearptr_disable();
	}
	
	/* save current video mode */
	
	fb_dos_save_video_mode();

}

/*:::::*/
int fb_dos_init(char *title, int w, int h, int depth, int refresh_rate, int flags)
{
	int i;
	
	fb_dos.inited = TRUE;
	
	/* lock code and data accessed in int handlers */
	
	lock_var(fb_mode);
	lock_var(*fb_mode);
	fb_dos_lock_data(fb_mode->page, sizeof(unsigned char *) * fb_mode->num_pages);
	for (i = 0; i < fb_mode->num_pages; i++)
		fb_dos_lock_data(fb_mode->page[i], fb_mode->pitch * fb_mode->h);
	fb_dos_lock_data(fb_mode->line, fb_mode->h * sizeof(unsigned char *));
	fb_dos_lock_data(fb_mode->dirty, fb_mode->h * fb_mode->scanline_size);
	fb_dos_lock_data(fb_mode->device_palette, sizeof(int) * 256);
	fb_dos_lock_data(fb_mode->palette, sizeof(int) * 256);
	fb_dos_lock_data(fb_color_conv_16to32, sizeof(int) * 512);
	lock_var(fb_dos);
	fb_dos_lock_data(&fb_mode->key, 128);
	lock_proc(fb_dos_timer_handler);
	lock_proc(fb_dos_timer_handler);
	fb_dos_lock_code(fb_dos.update, fb_dos.update_len);
	lock_code(fb_dos_mouse_isr_start, fb_dos_mouse_isr_end);
	lock_var(fb_dos_mouse_regs);
	lock_data(fb_hSoftCursor_data_start, fb_hSoftCursor_data_end);
	lock_code(fb_hSoftCursor_code_start, fb_hSoftCursor_code_end);
	lock_code(fb_hBlit_code_start, fb_hBlit_code_end);
	lock_data(fb_hBlitMMX_data_start, fb_hBlitMMX_data_end);
	lock_code(fb_hBlitMMX_code_start, fb_hBlitMMX_code_end);
	lock_code(fb_MMX_code_start, fb_MMX_code_end); /* hMemCpyMMX, hMemSetMMX */
	lock_var(fb_hMemCpy);
	lock_var(fb_hMemSet);
	fb_dos_lock_code(memcpy, 1024); /* we don't know how big memcpy and memset are, */
	fb_dos_lock_code(memset, 1024); /* so we guess 1k each... */
	lock_code(fb_hPostEvent_code_start, fb_hPostEvent_code_end);
	fb_dos_lock_data(&fb_mode->event_queue, sizeof(EVENT) * MAX_EVENTS);
	lock_array(kb_scan_to_ascii);
	
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
	
	fb_hMemSet(fb_mode->dirty, TRUE, fb_mode->h);

	return 0;
}

/*:::::*/
void fb_dos_exit(void)
{
	int i;
	
	if (!fb_dos.inited) return;

	fb_dos_cli();

	fb_dos_timer_exit();
	fb_dos_mouse_exit();
	fb_dos_kb_exit();

	fb_dos_sti();

	fb_dos.w = fb_dos.h = fb_dos.depth = fb_dos.refresh = 0;

	/* unlock code and data */

	unlock_var(fb_mode);
	unlock_var(*fb_mode);
	fb_dos_unlock_data(fb_mode->page, sizeof(unsigned char *) * fb_mode->num_pages);
	for (i = 0; i < fb_mode->num_pages; i++)
		fb_dos_unlock_data(fb_mode->page[i], fb_mode->pitch * fb_mode->h);
	fb_dos_unlock_data(fb_mode->line, fb_mode->h * sizeof(unsigned char *));
	fb_dos_unlock_data(fb_mode->dirty, fb_mode->h * fb_mode->scanline_size);
	fb_dos_unlock_data(fb_mode->device_palette, sizeof(int) * 256);
	fb_dos_unlock_data(fb_mode->palette, sizeof(int) * 256);
	fb_dos_unlock_data(fb_color_conv_16to32, sizeof(int) * 512);
	unlock_var(fb_dos);
	fb_dos_unlock_data(&fb_mode->key, 128);
	unlock_proc(fb_dos_timer_handler);
	unlock_proc(fb_dos_timer_handler);
	fb_dos_unlock_code(fb_dos.update, fb_dos.update_len);
	unlock_code(fb_dos_mouse_isr_start, fb_dos_mouse_isr_end);
	unlock_var(fb_dos_mouse_regs);
	unlock_data(fb_hSoftCursor_data_start, fb_hSoftCursor_data_end);
	unlock_code(fb_hSoftCursor_code_start, fb_hSoftCursor_code_end);
	unlock_code(fb_hBlit_code_start, fb_hBlit_code_end);
	unlock_data(fb_hBlitMMX_data_start, fb_hBlitMMX_data_end);
	unlock_code(fb_hBlitMMX_code_start, fb_hBlitMMX_code_end);
	unlock_code(fb_MMX_code_start, fb_MMX_code_end);
	unlock_var(fb_hMemCpy);
	unlock_var(fb_hMemSet);
	fb_dos_unlock_code(memcpy, 1024); /* we don't know how big memcpy and memset are, */
	fb_dos_unlock_code(memset, 1024); /* so we guess 1k each... */
	unlock_code(fb_hPostEvent_code_start, fb_hPostEvent_code_end);
	fb_dos_unlock_data(&fb_mode->event_queue, sizeof(EVENT) * MAX_EVENTS);
	unlock_array(kb_scan_to_ascii);
	
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


/*:::::*/
int fb_hGetWindowHandle(void)
{
	return 0;
}
