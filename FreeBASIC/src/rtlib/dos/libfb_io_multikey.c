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

#define lock_mem(addr, size) _lock_mem( (unsigned int)(addr), (size_t)(size) )
#define lock_var(var)        lock_mem( &(var), sizeof(var) )
#define lock_array(array)    lock_mem( (array), sizeof(array) )
#define lock_proc(proc)      lock_mem( proc, end_##proc - proc )

#define unlock_mem(addr, size) _unlock_mem( (unsigned int)(addr), (size_t)(size) )
#define unlock_var(var)        unlock_mem( &(var), sizeof(var) )
#define unlock_array(array)    unlock_mem( (array), sizeof(array) )
#define unlock_proc(proc)      unlock_mem( proc, end_##proc - proc )

#define END_OF_FUNCTION(proc)               void end_##proc (void) { }
#define END_OF_STATIC_FUNCTION(proc) static void end_##proc (void) { }


static int inited = FALSE;
static volatile char key[128];
static _go32_dpmi_seginfo old_kb_int, new_kb_int;


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
		
#if 0		
		/* TODO: check state of CapsLock */
		
		if ((key[SC_LSHIFT]) || (key[SC_RSHIFT])) {
			ascii = kb_scan_to_ascii[scan][1];
		} else if (key[SC_CONTROL]) {
			ascii = kb_scan_to_ascii[scan][2];
		} else {
			ascii = kb_scan_to_ascii[scan][0];
		}
		
		if (ascii) fb_hPostKey(ascii);
#endif
	}
}
END_OF_STATIC_FUNCTION(fb_MultikeyHandler);

/*:::::*/
static void fb_ConsoleMultikeyExit(void)
{
	_go32_dpmi_set_protected_mode_interrupt_vector(0x9, &old_kb_int);
	
	unlock_proc(fb_MultikeyHandler);
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
		lock_array(key);
		
		fb_AtExit(fb_ConsoleMultikeyExit);
	}
	
	return (scancode < sizeof(key) ? key[scancode] : FALSE);
}
