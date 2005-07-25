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
    int simple_mask = mask & ~FB_PRINT_HLMASK;

    if( len != 0 ) {
        FB_PRINT_EX(handle, s, len, simple_mask);
    }

    fb_PrintVoidEx( handle, mask );
}

/*:::::*/
void fb_PrintStringEx ( FB_FILE *handle, FBSTRING *s, int mask )
{
    if( handle==NULL) {
        fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
        return;
    }

	FB_STRLOCK();

    if( (s == NULL) || (s->data == NULL) )
    	fb_PrintVoidEx( handle, mask );
    else
    	fb_hPrintStrEx( handle, s->data, FB_STRSIZE(s), mask );

	/* del if temp */
	fb_hStrDelTemp( s );

	FB_STRUNLOCK();
}

/*:::::*/
FBCALL void fb_PrintString ( int fnum, FBSTRING *s, int mask )
{
    fb_PrintStringEx(FB_FILE_TO_HANDLE(fnum), s, mask);
}

/*:::::*/
void fb_PrintFixStringEx ( FB_FILE *handle, const char *s, int mask )
{
    if( handle==NULL) {
        fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
        return;
    }

    if( s == NULL )
    	fb_PrintVoidEx( handle, mask );
    else
    	fb_hPrintStrEx( handle, s, strlen( s ), mask );
}

/*:::::*/
FBCALL void fb_PrintFixString ( int fnum, const char *s, int mask )
{
    fb_PrintFixStringEx(FB_FILE_TO_HANDLE(fnum), s, mask);
}
