/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2005 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
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
 * io_multikey.c -- multikey function for DOS console mode apps
 *
 * chng: jun/2005 written [DrV]
 *
 */

#include "fb.h"
#include "fb_scancodes.h"

#include <dpmi.h>
#include <go32.h>
#include <pc.h>

#define X (255 << 8)
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

#define lock_mem(addr, size) _lock_mem( (unsigned int)(addr), (size_t)(size) )
#define lock_var(var)        lock_mem( &(var), sizeof(var) )
#define lock_array(array)    lock_mem( (array), sizeof(array) )
#define lock_proc(proc)      lock_mem( proc, (unsigned) end_##proc - (unsigned) proc )

#define unlock_mem(addr, size) _unlock_mem( (unsigned int)(addr), (size_t)(size) )
#define unlock_var(var)        unlock_mem( &(var), sizeof(var) )
#define unlock_array(array)    unlock_mem( (array), sizeof(array) )
#define unlock_proc(proc)      unlock_mem( proc, (unsigned) end_##proc - (unsigned) proc )

#define END_OF_FUNCTION(proc)               void end_##proc (void) { }
#define END_OF_STATIC_FUNCTION(proc) static void end_##proc (void) { }

#define KEY_BUFFER_LEN	16

#define KEY_QUIT		0x100
#define KEY_UP			0x101
#define KEY_DOWN		0x102
#define KEY_LEFT		0x103
#define KEY_RIGHT		0x104
#define KEY_INS			0x105
#define KEY_DEL			0x106
#define KEY_HOME		0x107
#define KEY_END			0x108
#define KEY_PAGE_UP		0x109
#define KEY_PAGE_DOWN		0x10A
#define KEY_F(n)		(0x10A + (n))
#define KEY_MAX_SPECIALS	(KEY_F(10) - 0x100 + 1)

#ifdef MIN
#undef MIN
#endif
#define MIN(a,b)		((a) < (b) ? (a) : (b))

static int inited = FALSE;
static int locked = FALSE;
static volatile char key[128];
static _go32_dpmi_seginfo old_kb_int, new_kb_int;
static int key_buffer[KEY_BUFFER_LEN], key_head = 0, key_tail = 0;

/*:::::*/
static void _lock_mem(unsigned int address, size_t size)
{
	static __dpmi_meminfo mi;
	mi.address = address;
	mi.size = size;
	__dpmi_lock_linear_region(&mi);
}

/*:::::*/
static void _unlock_mem(unsigned int address, size_t size)
{
	static __dpmi_meminfo mi;
	mi.address = address;
	mi.size = size;
	__dpmi_unlock_linear_region(&mi);
}

/*:::::*/
static void fb_hPostKey(int key)
{
	key_buffer[key_tail] = key;
	if (((key_tail + 1) & (KEY_BUFFER_LEN - 1)) == key_head)
		key_head = (key_head + 1) & (KEY_BUFFER_LEN - 1);
	key_tail = (key_tail + 1) & (KEY_BUFFER_LEN - 1);
}
END_OF_STATIC_FUNCTION(fb_hPostKey);


/*:::::*/
static int get_key(void)
{
	int key = 0;
	
	locked = TRUE;
	
	if (key_head != key_tail) {
		key = key_buffer[key_head];
		key_head = (key_head + 1) & (KEY_BUFFER_LEN - 1);
	}
	
	locked = FALSE;
	
	return key;
}

/*:::::*/
static int fb_ConsoleGetkey2(void)
{
	int key = 0;
	
	do {
		key = get_key();
		fb_Sleep(20);
	} while (key == 0);
	
	return key;
}

/*:::::*/
static int fb_ConsoleKeyHit2(void)
{
	int res;
	
	locked = TRUE;
	
	res = (key_head != key_tail? 1: 0);
	
	locked = FALSE;
	
	return res;
}

/*:::::*/
FBSTRING *fb_ConsoleInkey2(void)
{
	const unsigned char code[KEY_MAX_SPECIALS] = {
		'X', 'H', 'P', 'K', 'M', 'R', 'S', 'G', 'O', 'I', 'Q',
		';', '<', '=', '>', '?', '@', 'A', 'B', 'C', 'D'
	};
	FBSTRING *res;
	int key;
	
	if ((key = get_key())) {
		if (key > 0xFF) {
			key = MIN(key - 0x100, KEY_MAX_SPECIALS - 1);
			res = (FBSTRING *)fb_hStrAllocTmpDesc();
			fb_hStrAllocTemp(res, 2);
			res->data[0] = FB_EXT_CHAR;
			res->data[1] = code[key];
			res->data[2] = '\0';

			return res;
		}
		else
			return fb_CHR( 1, key );
	}
	
	return &fb_strNullDesc;
}

/*:::::*/
static void fb_MultikeyHandler(void)
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
		key[scan & ~0x80] = FALSE;
	} else {                        /* press */
		key[scan] = TRUE;
		
		/* TODO: check state of CapsLock */
		
		if ((key[SC_LSHIFT]) || (key[SC_RSHIFT])) {
			ascii = kb_scan_to_ascii[scan][1];
		} else if (key[SC_CONTROL]) {
			ascii = kb_scan_to_ascii[scan][2];
		} else {
			ascii = kb_scan_to_ascii[scan][0];
		}
		
		if (ascii) fb_hPostKey(ascii);
	}
}
END_OF_STATIC_FUNCTION(fb_MultikeyHandler);

/*:::::*/
static void fb_ConsoleMultikeyExit(void)
{
	_go32_dpmi_set_protected_mode_interrupt_vector(0x9, &old_kb_int);
	
	unlock_proc(fb_MultikeyHandler);
	unlock_proc(fb_hPostKey);
	unlock_array(key);
}

/*:::::*/
int fb_ConsoleMultikey( int scancode )
{
	if (!inited) {
		inited = TRUE;
		memset((void*)key, FALSE, sizeof(key));
		
		_go32_dpmi_get_protected_mode_interrupt_vector(0x9, &old_kb_int);
		new_kb_int.pm_offset = (unsigned int)fb_MultikeyHandler;
		new_kb_int.pm_selector = _go32_my_cs();
		_go32_dpmi_allocate_iret_wrapper(&new_kb_int);
		_go32_dpmi_set_protected_mode_interrupt_vector(0x9, &new_kb_int);
		
		lock_proc(fb_MultikeyHandler);
		lock_proc(fb_hPostKey);
		lock_array(key);
		
		fb_AtExit(fb_ConsoleMultikeyExit);
		
		fb_hooks.inkeyproc = fb_ConsoleInkey2;
		fb_hooks.getkeyproc = fb_ConsoleGetkey2;
		fb_hooks.keyhitproc = fb_ConsoleKeyHit2;
	}
	
	return (scancode < sizeof(key) ? key[scancode] : FALSE);
}
