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
 * init.c -- libfb initialization for DOS
 *
 * chng: jan/2005 written [DrV]
 *
 */


#include "fb.h"

#include <float.h>
#include <conio.h>


/* globals */
int	fb_argc;
char **	fb_argv;

extern char fb_commandline[];

/*:::::*/
void fb_hInit ( void )
{

	int i;

	/* set FPU precision to 64-bit and round to nearest (as in QB) */
	_control87(PC_64|RC_NEAR, MCW_PC|MCW_RC);

	/* rebuild command line from argv */
	for (i = 0; i < fb_argc; i++) {
		strncat(fb_commandline, fb_argv[i], 1024);
		if (i != fb_argc-1) strncat(fb_commandline, " ", 1024);
	}

	/* turn off blink */
	intensevideo();

}
