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
 * fb_dos.h -- common DOS definitions.
 *
 * chng: jul/2005 written [DrV]
 *
 */

#ifndef __FB_DOS_H__
#define __FB_DOS_H__

#define FB_DOS_USE_CONIO

#include <dpmi.h>
#include <dos.h>
#include <go32.h>
#include <pc.h>
#include <sys/farptr.h>

#ifdef FB_DOS_USE_CONIO
# include <conio.h>
#endif

#define FB_NEWLINE "\r\n"

typedef int FB_DIRCTX; /* dummy to make fb.h happy */

typedef struct {
    unsigned long edi;
    unsigned long esi;
    unsigned long ebp;
    unsigned long res;
    unsigned long ebx;
    unsigned long edx;
    unsigned long ecx;
    unsigned long eax;
} __dpmi_regs_d;

typedef struct _FB_DOS_TXTMODE {
	int w;
	int h;
	unsigned long phys_addr;
} FB_DOS_TXTMODE;

extern FB_DOS_TXTMODE fb_dos_txtmode;

typedef int (*FnIntHandler)(unsigned irq_number);

extern int ScrollWasOff;
extern int fb_force_input_buffer_changed;

int fb_ConsoleLocate_BIOS( int row, int col, int cursor );
void fb_ConsoleGetXY_BIOS( int *col, int *row );
int fb_ConsoleReadXY_BIOS( int col, int row, int colorflag );

void fb_ConsoleScroll_BIOS( int x1, int y1, int x2, int y2, int nrows );
void fb_ConsoleScrollEx( int x1, int y1, int x2, int y2, int nrows );

void fb_ConsoleMultikeyInit( void );
int fb_hConsoleInputBufferChanged( void );

int fb_isr_set( unsigned irq_number,
                FnIntHandler pfnIntHandler,
                size_t fn_size,
                size_t stack_size );

int fb_isr_reset( unsigned irq_number );

FnIntHandler fb_isr_get( unsigned irq_number );

/* To allow recursive CLI/STI */
int fb_dos_cli( void );
int fb_dos_sti( void );

int fb_dos_lock_mem(const void *address, size_t size);
int fb_dos_unlock_mem(const void *address, size_t size);

#endif
