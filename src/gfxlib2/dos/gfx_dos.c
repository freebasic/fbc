/* list of dos gfx drivers and common code */

#include "../fb_gfx.h"
#include "fb_gfx_dos.h"
#include <pc.h>
#include <sys/nearptr.h>

/* timer ticks per second */
#define TIMER_HZ 1000

/* driver list */
extern const GFXDRIVER fb_gfxDriverVESAlinear;
extern const GFXDRIVER fb_gfxDriverVESA;
extern const GFXDRIVER fb_gfxDriverBIOS;
extern const GFXDRIVER fb_gfxDriverVGA;
extern const GFXDRIVER fb_gfxDriverModeX;

const GFXDRIVER *__fb_gfx_drivers_list[] = {
	&fb_gfxDriverVESAlinear,
	&fb_gfxDriverVESA,
	&fb_gfxDriverVGA,
	&fb_gfxDriverModeX,
	&fb_gfxDriverBIOS,
	NULL
};

fb_dos_t fb_dos;

volatile int __fb_dos_junk;
volatile int __fb_dos_update_ticks = 0;
int __fb_dos_ticks_per_update;

static void fb_dos_save_video_mode(void);
static void fb_dos_restore_video_mode(void);

static __dpmi_regs fb_dos_mouse_regs;
static __dpmi_raddr fb_dos_mouse_isr_rmcb;

/* layout from gfx_mouse.s */
extern void fb_dos_mouse_isr_start(void);
extern short fb_dos_mouse_x;
extern short fb_dos_mouse_y;
extern short fb_dos_mouse_z;
extern char fb_dos_mouse_buttons;
extern void fb_dos_mouse_isr(void);
extern void fb_dos_mouse_isr_end(void);

/* from gfx_softcursor.c */
extern char fb_hSoftCursor_data_start;
extern char fb_hSoftCursor_data_end;
extern void fb_hSoftCursor_code_start(void);
extern void fb_hSoftCursor_code_end(void);

/* from gfx_blitter.c */
extern void fb_hBlit_code_start(void);
extern void fb_hBlit_code_end(void);

/* from gfx_blitter_mmx.s */
extern char fb_hBlitMMX_data_start;
extern char fb_hBlitMMX_data_end;
extern void fb_hBlitMMX_code_start(void);
extern void fb_hBlitMMX_code_end(void);

/* from gfx_mmx.s */
extern void fb_MMX_code_start(void);
extern void fb_MMX_code_end(void);

/* from gfx_core.c */
void fb_hPostEvent_code_start(void);
void fb_hPostEvent_code_end(void);

static const unsigned char kb_scan_to_ascii[128][3] = {
	/*
	normal
		   +shift
	                +ctrl
	*/
	{    0,     0,     0},
	{   27,    27,     0},	/* esc */
	{   49,    33,     0},	/* 1 ! */
	{   50,    64,     0},	/* 2 @ */
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
	{    9,     9,     0},	/* tab */
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
	{    0,     0,     0},	/* F1  */
	{    0,     0,     0},	/* F2  */
	{    0,     0,     0},	/* F3  */
	{    0,     0,     0},	/* F4  */
	{    0,     0,     0},	/* F5  */
	{    0,     0,     0},	/* F6  */
	{    0,     0,     0},	/* F7  */
	{    0,     0,     0},	/* F8  */
	{    0,     0,     0},	/* F9  */
	{    0,     0,     0},	/* F10 */
	{    0,     0,     0},	/* num lock */
	{    0,     0,     0},	/* scroll lock */
	{    0,     0,     0},	/* home */
	{    0,     0,     0},	/* up */
	{    0,     0,     0},	/* page up */
	{   45,    45,     0},	/* numpad - */
	{    0,     0,     0},	/* left */
	{    0,     0,     0},	/* numpad 5 */
	{    0,     0,     0},	/* right */
	{   43,	   43,     0},	/* numpad + */
	{    0,     0,     0},	/* end */
	{    0,     0,     0},	/* down */
	{    0,     0,     0},	/* page down */
	{    0,     0,     0},	/* insert */
	{    0,     0,     0},  /* delete */
	{    0,     0,     0},	/* F11 */
	{    0,     0,     0}	/* F12 */
};

static const char kb_numpad_to_ascii[13] = {
	'7', '8', '9',  0,
	'4', '5', '6', '+',
	'1', '2', '3',
	'0', '.'
};

static void fb_dos_multikey_hook(int scancode, int flags);

static void fb_dos_kb_init(void)
{
	__fb_ctx.hooks.inkeyproc  = NULL;
	__fb_ctx.hooks.getkeyproc = NULL;
	__fb_ctx.hooks.keyhitproc = NULL;
	__fb_ctx.hooks.multikeyproc = NULL;
	__fb_ctx.hooks.sleepproc = NULL;
	
	__fb_dos_multikey_hook = fb_dos_multikey_hook;
	(void)fb_ConsoleMultikey(0); /* ensure the ISR is installed */
	
	return;
}

static void fb_dos_kb_exit(void)
{
	__fb_dos_multikey_hook = NULL;
}

static void fb_dos_multikey_hook(int scancode, int flags)
{
	EVENT e;
	
	e.type = (flags & KB_PRESS) ? ((flags & KB_REPEAT) ? EVENT_KEY_REPEAT : EVENT_KEY_PRESS) : EVENT_KEY_RELEASE;
	
	e.scancode = scancode;
	
	if ( flags & KB_ALT )
	{
		e.ascii = 0;
	}
	else
	{
		e.ascii = kb_scan_to_ascii[scancode][(flags & KB_CTRL) ? 2 : (flags & KB_SHIFT) ? 1 : 0];
		
		if ( flags & KB_CAPSLOCK )
		{
			if ( (flags & KB_SHIFT) && ((e.ascii >= 'A') && (e.ascii <= 'Z') ) )
				e.ascii += ('a' - 'A');
			else if ( ((e.ascii >= 'a') && (e.ascii <= 'z') ) )
				e.ascii -= ('a' - 'A');
		}
		
		if ( (flags & KB_NUMLOCK) && !(flags & (KB_EXTENDED | KB_CTRL)) && !(flags & (KB_SHIFT )) )
		{
			if ( scancode >= 71 && scancode <= 83 )
			{
				e.ascii = kb_numpad_to_ascii[scancode - 71];
			}
		}
	}
	
	fb_hPostEvent(&e);
}

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

int fb_dos_get_mouse(int *x, int *y, int *z, int *buttons, int *clip)
{
	if (!fb_dos.mouse_ok) return -1;
	
	if (x) *x = fb_dos_mouse_x;
	if (y) *y = fb_dos_mouse_y;
	if (z) *z = (fb_dos.mouse_wheel_ok ? fb_dos_mouse_z : 0);
	if (buttons) *buttons = fb_dos_mouse_buttons;
	if (clip) *clip = fb_dos.mouse_clip;
	
	return 0;
}

void fb_dos_set_mouse(int x, int y, int cursor, int clip)
{

	if (!fb_dos.mouse_ok) return;

	fb_dos.mouse_cursor = cursor;

	if (x != (int)0x80000000 || y != (int)0x80000000) {
		if (x == (int)0x80000000) {
			x = fb_dos_mouse_x;
		}
		else if (y == (int)0x80000000) {
			y = fb_dos_mouse_y;
		}

		x = MID(0, x, fb_dos.w - 1);
		y = MID(0, y, fb_dos.h - 1);

		fb_dos_mouse_x = x;
		fb_dos_mouse_y = y;

		fb_dos.regs.x.ax = 0x4;
		fb_dos.regs.x.cx = x;
		fb_dos.regs.x.dx = y;
		__dpmi_int(0x33, &fb_dos.regs);
	}

	if (clip == 0)
		fb_dos.mouse_clip = FALSE;
	else if (clip > 0)
		fb_dos.mouse_clip = TRUE;
}

static void fb_dos_mouse_exit(void)
{
	if (!fb_dos.mouse_ok) return;
	
	fb_hSoftCursorExit();

	fb_dos.regs.x.ax = 0x0;
	__dpmi_int(0x33, &fb_dos.regs);
	
	__dpmi_free_real_mode_callback(&fb_dos_mouse_isr_rmcb);
}

static int fb_dos_timer_handler(unsigned irq)
{
	int do_abort;
	int mouse_x = 0, mouse_y = 0;
	int buttons;
	EVENT e;

	fb_dos.timer_ticks += fb_dos.timer_step;
	if( (do_abort = fb_dos.timer_ticks < 65536)==FALSE )
		fb_dos.timer_ticks -= 65536;
		
	__fb_dos_update_ticks++;
	
	if (fb_dos.in_interrupt || fb_dos.locked || __fb_dos_update_ticks < __fb_dos_ticks_per_update)
		return do_abort;

	fb_dos.in_interrupt = TRUE;
	
	__fb_dos_update_ticks -= __fb_dos_ticks_per_update;

#if 0 /* Set to 1 if you want to debug a display driver */
	outportb(0x20, 0x20);
	fb_dos_sti();
#endif

	if( fb_dos.depth <= 8 && fb_dos.set_palette && fb_dos.pal_dirty )
	{
		fb_dos.set_palette( );
		if( fb_dos.mouse_ok ) fb_hSoftCursorPaletteChanged( );
	}
	
	mouse_x = fb_dos_mouse_x;
	mouse_y = fb_dos_mouse_y;

	if ( fb_dos.mouse_ok ) {
		if( __fb_gfx->scanline_size != 1 ) {
			mouse_y /= __fb_gfx->scanline_size;
		}
	}

	if ( fb_dos.mouse_ok && fb_dos.mouse_cursor ) {
		fb_hSoftCursorPut(mouse_x, mouse_y);
	}
	
	fb_dos.update();
	fb_hMemSet(__fb_gfx->dirty, FALSE, __fb_gfx->h * __fb_gfx->scanline_size);

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
	
	fb_dos.in_interrupt = FALSE;

	return do_abort;
}
static void end_fb_dos_timer_handler(void) { /* do not remove */ }

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

static int fb_dos_timer_set_freq(int freq)
{
	return fb_dos_timer_set_rate( 1193181 / freq );
}

static int fb_dos_timer_init(int freq)
{
	fb_dos.timer_ticks = 0;
	fb_dos.timer_step = fb_dos_timer_set_freq( freq );
	return fb_isr_set( 0, fb_dos_timer_handler, 0, 16384 );
}

static void fb_dos_timer_exit(void)
{
	fb_dos_cli();
	fb_isr_reset( 0 );
	fb_dos_timer_set_rate( 0 );
	fb_dos_sti();
}

void fb_dos_set_palette(int idx, int r, int g, int b)
{
	fb_dos.pal_dirty = TRUE;
	fb_dos.pal[idx].r = r >> 2;
	fb_dos.pal[idx].g = g >> 2;
	fb_dos.pal[idx].b = b >> 2;
	fb_dos.pal_first = MIN(fb_dos.pal_first, idx);
	fb_dos.pal_last = MAX(fb_dos.pal_last, idx);
}

void fb_dos_vga_set_palette(void)
{
	int i, color_count;
	
	color_count = MIN( (1 << fb_dos.depth), fb_dos.pal_last + 1 );
	
	outportb(0x3C8, fb_dos.pal_first);
	for (i = fb_dos.pal_first; i < color_count; i++) {
		outportb(0x3C9, fb_dos.pal[i].r);
		outportb(0x3C9, fb_dos.pal[i].g);
		outportb(0x3C9, fb_dos.pal[i].b);
	}
	
	fb_dos.pal_dirty = FALSE;
	fb_dos.pal_last = 0;
	fb_dos.pal_first = 256;
}

void fb_dos_vga_wait_vsync(void)
{
	while ((inportb(0x3DA) & 8) != 0);
	while ((inportb(0x3DA) & 8) == 0);
}

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

int fb_dos_init(char *title, int w, int h, int depth, int refresh_rate, int flags)
{
	int i;
	
	fb_dos.inited = TRUE;
	
	/* lock code and data accessed in int handlers */
	
	lock_var(__fb_gfx);
	lock_var(*__fb_gfx);
	fb_dos_lock_data(__fb_gfx->page, sizeof(unsigned char *) * __fb_gfx->num_pages);
	for (i = 0; i < __fb_gfx->num_pages; i++)
		fb_dos_lock_data(__fb_gfx->page[i], __fb_gfx->pitch * __fb_gfx->h);
	fb_dos_lock_data(__fb_gfx->dirty, __fb_gfx->h * __fb_gfx->scanline_size);
	fb_dos_lock_data(__fb_gfx->device_palette, sizeof(int) * 256);
	fb_dos_lock_data(__fb_gfx->palette, sizeof(int) * 256);
	fb_dos_lock_data(__fb_color_conv_16to32, sizeof(int) * 512);
	lock_var(fb_dos);
	fb_dos_lock_data(&__fb_gfx->key, 128);
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
	fb_dos_lock_data(&__fb_gfx->event_queue, sizeof(EVENT) * MAX_EVENTS);
	lock_array(kb_scan_to_ascii);
	lock_array(kb_numpad_to_ascii);
	lock_code(fb_dos_vesa_set_palette, fb_dos_vesa_set_palette_end);
	lock_var(__fb_dos_update_ticks);
	lock_var(__fb_dos_ticks_per_update);
	
	fb_dos.w = w;
	fb_dos.h = h;
	fb_dos.depth = depth;
	fb_dos.Bpp = (depth + 7) / 8;
	__fb_gfx->refresh_rate = fb_dos.refresh = refresh_rate;
	
	fb_dos_kb_init();
	
	if (!fb_dos_mouse_init())
		return -1;
	
	if (fb_dos.mouse_ok)
	{
		fb_dos_set_mouse(fb_dos.w / 2, fb_dos.h / 2, TRUE, 0);
		fb_dos.mouse_x_old = fb_dos.w / 2;
		fb_dos.mouse_y_old = fb_dos.h / 2;
	}
	else
	{
		fb_dos.mouse_cursor = FALSE;
	}
		
	__fb_dos_ticks_per_update = TIMER_HZ / refresh_rate;
	
	if (!fb_dos_timer_init(TIMER_HZ))
		return -1;
	
	fb_hMemSet(__fb_gfx->dirty, TRUE, __fb_gfx->h * __fb_gfx->scanline_size);
	
	fb_dos.locked = 0;
	
	return 0;
}

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
	
	if( fb_dos.palbuf_sel )
	{
		__dpmi_free_dos_memory( fb_dos.palbuf_sel );
		fb_dos.palbuf_sel = fb_dos.palbuf_seg = 0;
	}

	/* unlock code and data */

	unlock_var(__fb_gfx);
	unlock_var(*__fb_gfx);
	fb_dos_unlock_data(__fb_gfx->page, sizeof(unsigned char *) * __fb_gfx->num_pages);
	for (i = 0; i < __fb_gfx->num_pages; i++)
		fb_dos_unlock_data(__fb_gfx->page[i], __fb_gfx->pitch * __fb_gfx->h);
	fb_dos_unlock_data(__fb_gfx->dirty, __fb_gfx->h * __fb_gfx->scanline_size);
	fb_dos_unlock_data(__fb_gfx->device_palette, sizeof(int) * 256);
	fb_dos_unlock_data(__fb_gfx->palette, sizeof(int) * 256);
	fb_dos_unlock_data(__fb_color_conv_16to32, sizeof(int) * 512);
	unlock_var(fb_dos);
	fb_dos_unlock_data(&__fb_gfx->key, 128);
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
	fb_dos_unlock_data(&__fb_gfx->event_queue, sizeof(EVENT) * MAX_EVENTS);
	unlock_array(kb_scan_to_ascii);
	unlock_array(kb_numpad_to_ascii);
	unlock_code(fb_dos_vesa_set_palette, fb_dos_vesa_set_palette_end);
	unlock_var(__fb_dos_update_ticks);
	unlock_var(__fb_dos_ticks_per_update);
	
	fb_dos_restore_video_mode();

	fb_dos.inited = FALSE;
}

void fb_dos_lock(void)
{
	if (!fb_dos.locked)
		while (__fb_dos_update_ticks >= __fb_dos_ticks_per_update)
			__fb_dos_junk = 0; /* just something to make sure the loop is not optimized away */
	fb_dos.locked++;
}

void fb_dos_unlock(void)
{
	fb_dos.locked--;
}

void fb_dos_set_window_title(char *title)
{
}

static void fb_dos_save_video_mode(void)
{
	int n = fb_ConsoleWidth(0, 0);
	fb_dos.old_rows = n >> 16;
	fb_dos.old_cols = n & 0xFFFF;
}

static void fb_dos_restore_video_mode(void)
{
	if (fb_dos.old_rows == 0)
		return;
	fb_ConsoleWidth(fb_dos.old_rows, fb_dos.old_cols);
	fb_dos.old_rows = fb_dos.old_cols = 0;
}

void fb_hScreenInfo(ssize_t *width, ssize_t *height, ssize_t *depth, ssize_t *refresh)
{
	*width = fb_dos.w;
	*height = fb_dos.h;
	*depth = fb_dos.depth;
	*refresh = fb_dos.refresh;
}

ssize_t fb_hGetWindowHandle(void)
{
	return 0;
}

ssize_t fb_hGetDisplayHandle(void)
{
	return 0;
}
