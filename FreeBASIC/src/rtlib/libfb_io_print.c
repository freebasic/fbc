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
 *       nov/2004 fixed scrolling problem if printing at bottom/right w/o a newline [v1ctor]
 *
 */

#include <stdio.h>
#include "fb.h"


/*:::::*/
FBCALL void fb_PrintVoid ( int fnum, int mask )
{
    char *buffer;
#ifndef WIN32
	char nl[2] = { '\n', '\0' };
#endif

    if( mask & FB_PRINT_NEWLINE )
#ifndef WIN32
		buffer = nl;
#else
    	buffer = "\n";
#endif

    else if( mask & FB_PRINT_PAD )
    	buffer = "%-14";
    else
    	buffer = NULL;

    if( buffer != NULL )
    {
    	if( fnum == 0 )
    		fb_PrintBuffer( buffer, mask );
    	else
    		fb_hFilePrintBuffer( fnum, buffer );
    }
}



#define BUFFLEN 80*25

/*:::::*/
static void fb_hPrintStr( int fnum, char *s, int len, int mask )
{
    char buffer[BUFFLEN+14+1+1], *p;
    int chars, rmask;

    if( len == 0 )
    {
    	fb_PrintVoid( fnum, mask );
    	return;
    }

    rmask = mask;
    mask = 0;

    while( len > 0 )
    {
    	if( len > BUFFLEN )
    		chars = BUFFLEN;
    	else
    		chars = len;

    	p = &buffer[0];
    	if( len == chars )
    	{
    		mask = rmask;

    		if( mask & FB_PRINT_NEWLINE )
    			sprintf( buffer, "%s\n", s );
    		else if( mask & FB_PRINT_PAD )
    			sprintf( buffer, "%-14s", s );
    		else
    			p = s;
    	}
    	else
    	{
    		memcpy( buffer, s, chars );
    		buffer[chars] = '\0';
    	}


    	if( fnum == 0 )
    		fb_PrintBuffer( p, mask );
    	else
    		fb_hFilePrintBuffer( fnum, p );

    	s += chars;
    	len -= chars;
    }
}


/*:::::*/
FBCALL void fb_PrintString ( int fnum, FBSTRING *s, int mask )
{
    if( (s == NULL) || (s->data == NULL) )
    	fb_PrintVoid( fnum, mask );
    else
    	fb_hPrintStr( fnum, s->data, FB_STRSIZE(s), mask );

	/* del if temp */
	fb_hStrDelTemp( s );
}

/*:::::*/
FBCALL void fb_PrintFixString ( int fnum, char *s, int mask )
{
    if( s == NULL )
    	fb_PrintVoid( fnum, mask );
    else
    	fb_hPrintStr( fnum, s, strlen( s ), mask );
}
