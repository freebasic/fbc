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
 * io_print.c -- print [#] functions
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <stdlib.h>
#include "fb.h"
#include "fb_rterr.h"

/*:::::*/
static void fb_hPrintStrEx( FB_FILE *handle, const char *s, size_t len, int mask )
{
    /* add a lock here or the new-line won't be printed in the right
       place if PRINT is been used in multiple threads and a context
       switch happens between FB_PRINT_EX() and PrintVoidEx() */
    FB_LOCK( );

    if( len != 0 )
        FB_PRINT_EX(handle, s, len, 0);

    fb_PrintVoidEx( handle, mask );

    FB_UNLOCK( );
}

/*:::::*/
void fb_PrintStringEx ( FB_FILE *handle, FBSTRING *s, int mask )
{
    if( (s == NULL) || (s->data == NULL) )
    	fb_PrintVoidEx( handle, mask );
    else
    	fb_hPrintStrEx( handle, s->data, FB_STRSIZE(s), mask );

	/* del if temp */
	fb_hStrDelTemp( s );
}

/*:::::*/
FBCALL void fb_PrintString ( int fnum, FBSTRING *s, int mask )
{
    fb_PrintStringEx(FB_FILE_TO_HANDLE(fnum), s, mask);
}
