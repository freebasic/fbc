/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2005 Andre V. T. Vicentini (av1ctor@yahoo.com.br) and others.
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
 * init.c -- libfb initialization for DOS
 *
 * chng: jan/2005 written [DrV]
 *
 */


#include "fb.h"

#include <float.h>
#include <conio.h>
#include <unistd.h>
#include <sys/farptr.h>

/* globals */
int	fb_argc;
char **	fb_argv;

int ScrollWasOff = FALSE;
FB_DOS_TXTMODE fb_dos_txtmode;


extern char fb_commandline[];

extern void (*fb_ConsolePrintBufferProc) (const void *buffer, size_t len, int mask);
extern void fb_ConsolePrintBufferEx_SCRN (const void *buffer, size_t len, int mask);
extern void fb_ConsolePrintBufferEx_STDIO(const void *buffer, size_t len, int mask);


/*:::::*/
void fb_hInit ( int argc, char **argv )
{
    int i;

	/* rebuild command line from argv */
	for( i = 0; i < argc; i++ ) 
	{
		strncat( fb_commandline, argv[i], 1024 );
		if( i != argc-1 ) 
			strncat( fb_commandline, " ", 1024 );
	}
	
	fb_argc = argc;
	fb_argv = argv;

	/* set FPU precision to 64-bit and round to nearest (as in QB) */
	_control87(PC_64|RC_NEAR, MCW_PC|MCW_RC);

	/* turn off blink */
    intensevideo();

	/* use cprintf() if STDOUT is the console; 
     otherwise (with shell I/O redirection) use printf() */
    if( isatty(1) ) {
        fb_ConsolePrintBufferProc = fb_ConsolePrintBufferEx_SCRN;
    } else {
        fb_ConsolePrintBufferProc = fb_ConsolePrintBufferEx_STDIO;
    }
}
