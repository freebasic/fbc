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
	&fb_gfxDriverVESA,
	&fb_gfxDriverVGA,
	&fb_gfxDriverModeX,
	NULL
};

fb_dos_t fb_dos;

/* special externs for locking code */
extern void fb_hPostKey_End(void);

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

#define KB_EXTENDED (255 << 8)

#define X KB_EXTENDED
static unsigned short kb_scan_to_ascii[128][3] = {
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
static void kb_handler(void)
/* keyboard interrupt handler - 
   all accessed code and data must be locked! */
{
	unsigned char scan;
	unsigned char status;
	unsigned short ascii;
	
	/* read the raw scan code from the keyboard */
	scan = inportb(0x60);           /* read scan code */
	status = inportb(0x61);         /* read keyboard status */
	outportb(0x61, status | 0x80);  /* set bit 7 and write */
	outportb(0x61, status);         /* write again, bit 7 clear */
	outportb(0x20, 0x20);           /* reset PIC */
	
	/* TODO: handle extended keys */
	
	if (scan & 0x80) {              /* release */
		fb_mode->key[scan & ~0x80] = FALSE;
	} else {                        /* press */
		fb_mode->key[scan] = TRUE;
		
		/* TODO: check state of CapsLock */
		
		if ((fb_mode->key[SC_LSHIFT]) || (fb_mode->key[SC_RSHIFT])) {
			ascii = kb_scan_to_ascii[scan][1];
		} else if (fb_mode->key[SC_CONTROL]) {
			ascii = kb_scan_to_ascii[scan][2];
		} else {
			ascii = kb_scan_to_ascii[scan][0];
		}
		
		if (ascii) fb_hPostKey(ascii);
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
static inline void wait(int port, int and, int xor)
{
	while (((inportb(port) ^ (xor)) & (and)) == 0) { }
}

/*:::::*/
void fb_dos_vga_wait_vsync(void)
{
	wait(0x3DA, 8, 0);
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
	lock_array(kb_scan_to_ascii);
	
	lock_proc(kb_handler);
	lock_proc(fb_dos_timer_handler);
	lock_proc(fb_dos_update_mouse);
	lock_proc(fb_dos_draw_mouse_8);
	lock_proc(fb_dos_undraw_mouse_8);
	lock_mem(fb_hPostKey, (unsigned)fb_hPostKey_End - (unsigned)fb_hPostKey);
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
	unlock_array(kb_scan_to_ascii);
	
	unlock_proc(kb_handler);
	unlock_proc(fb_dos_timer_handler);
	unlock_proc(fb_dos_update_mouse);
	unlock_proc(fb_dos_draw_mouse_8);
	unlock_proc(fb_dos_undraw_mouse_8);
	unlock_mem(fb_hPostKey, (unsigned)fb_hPostKey_End - (unsigned)fb_hPostKey);
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
}

/*:::::*/
void fb_hScreenInfo(int *width, int *height, int *depth, int *refresh)
{
	*width = fb_dos.w;
	*height = fb_dos.h;
	*depth = fb_dos.depth;
	*refresh = fb_dos.refresh;
}


#if 0
/* find_vesa_mode:
 *  Tries to find a VESA mode number for the specified screen size.
 *  Searches the mode list from the VESA info block, and if that doesn't
 *  work, uses the standard VESA mode numbers.
 */
 
 /* **** to be rewritten !!!! **** */
int find_vesa_mode(int w, int h, int color_depth, int vbe_version)
{
   #define MAX_VESA_MODES 1024

   unsigned short mode[MAX_VESA_MODES];
   int memorymodel, bitsperpixel;
   int redmasksize, greenmasksize, bluemasksize;
   int greenmaskpos;
   int reservedmasksize, reservedmaskpos;
   int rs, gs, bs, gp, rss, rsp;
   int c, modes;
   long mode_ptr;
   
   VesaModeInfo mode_info;

	if (!fb_dos.vesa_ok) return 0;
	
	
   if (fb_dos.vesa_info.vbe_version < (vbe_version<<8)) {
      return 0;
   }

   mode_ptr = RM_TO_LINEAR(fb_dos.vesa_info.video_mode_ptr);
   modes = 0;

   _farsetsel(_dos_ds);

   while ((mode[modes] = _farnspeekw(mode_ptr)) != 0xFFFF) {
      modes++;
      mode_ptr += 2;
   }

   switch (color_depth) {

	 case 8:
	    memorymodel = 4;
	    bitsperpixel = 8;
	    redmasksize = greenmasksize = bluemasksize = 0;
	    greenmaskpos = 0;
	    reservedmasksize = 0;
	    reservedmaskpos = 0;
	    break;

	 case 15:
	    memorymodel = 6;
	    bitsperpixel = 15;
	    redmasksize = greenmasksize = bluemasksize = 5;
	    greenmaskpos = 5;
	    reservedmasksize = 1;
	    reservedmaskpos = 15;
	    break;

	 case 16:
	    memorymodel = 6;
	    bitsperpixel = 16;
	    redmasksize = bluemasksize = 5;
	    greenmasksize = 6;
	    greenmaskpos = 5;
	    reservedmasksize = 0;
	    reservedmaskpos = 0;
	    break;
	    
	 case 24:
	    memorymodel = 6;
	    bitsperpixel = 24;
	    redmasksize = bluemasksize = greenmasksize = 8;
	    greenmaskpos = 8;
	    reservedmasksize = 0;
	    reservedmaskpos = 0;
	    break;

	 case 32:
	    memorymodel = 6;
	    bitsperpixel = 32;
	    redmasksize = greenmasksize = bluemasksize = 8;
	    greenmaskpos = 8;
	    reservedmasksize = 8;
	    reservedmaskpos = 24;
	    break;

      default:
		return 0;
   }

   #define MEM_MATCH(mem, wanted_mem) \
      ((mem == wanted_mem) || ((mem == 4) && (wanted_mem == 6)))

   #define BPP_MATCH(bpp, wanted_bpp) \
      ((bpp == wanted_bpp) || ((bpp == 16) && (wanted_bpp == 15)))

   #define RES_SIZE_MATCH(size, wanted_size, bpp) \
      ((size == wanted_size) || ((size == 0) && ((bpp == 15) || (bpp == 32))))

   #define RES_POS_MATCH(pos, wanted_pos, bpp) \
      ((pos == wanted_pos) || ((pos == 0) && ((bpp == 15) || (bpp == 32))))

   /* search the list of modes */
   for (c=0; c<modes; c++) {
      if (fb_dos_vesa_get_mode_info(mode[c]) == 0) {
      mode_info = fb_dos.vesa_mode_info;
	    rs = mode_info.red_mask_size;
	    gs = mode_info.green_mask_size;
	    bs = mode_info.blue_mask_size;
	    gp = mode_info.green_field_pos;
	    rss = mode_info.rsvd_mask_size;
	    rsp = mode_info.rsvd_field_pos;

	 if (((mode_info.mode_attributes & 25) == 25) &&
	     (mode_info.x_res == w) && 
	     (mode_info.y_res == h) && 
	     (mode_info.number_of_planes == 1) && 
	     MEM_MATCH(mode_info.mem_model, memorymodel) &&
	     BPP_MATCH(mode_info.bits_per_pixel, bitsperpixel) &&
	     (rs == redmasksize) && (gs == greenmasksize) && 
	     (bs == bluemasksize) && (gp == greenmaskpos) &&
	     RES_SIZE_MATCH(rss, reservedmasksize, mode_info.bits_per_pixel) &&
	     RES_POS_MATCH(rsp, reservedmaskpos, mode_info.bits_per_pixel))

	    /* looks like this will do... */
	    return mode[c];
      } 
   }

   /* try the standard mode numbers */
   if ((w == 640) && (h == 400) && (color_depth == 8))
      c = 0x100;
   else if ((w == 640) && (h == 480) && (color_depth == 8))
      c = 0x101;
   else if ((w == 800) && (h == 600) && (color_depth == 8)) 
      c = 0x103;
   else if ((w == 1024) && (h == 768) && (color_depth == 8))
      c = 0x105;
   else if ((w == 1280) && (h == 1024) && (color_depth == 8))
      c = 0x107;
   else {
         return 0; 
   }

   if (fb_dos_vesa_get_mode_info(c) == 0)
      return c;

   return 0;
}
#endif
