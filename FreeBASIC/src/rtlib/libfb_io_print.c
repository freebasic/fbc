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
#include "fb_rterr.h"

#define FB_PRINT_BUFFER_SIZE 4096

#include <stdlib.h>

static
FBCALL void fb_hPrintPad ( int fnum, int mask, int current_x, int new_x )
{
#if FB_NATIVE_TAB==1
    FB_PRINT_EX(fnum, "\t", 1, mask);
#else
    char tab_char_buffer[FB_TAB_WIDTH+1];
    if (new_x <= current_x) {
        FB_PRINT_EX(fnum, FB_NEWLINE, strlen(FB_NEWLINE), mask);
    } else {
        int i;
        for (i=current_x; i!=new_x; ++i)
            tab_char_buffer[i-current_x] = 32;
        /* the terminating NUL shouldn't be required but it makes
         * debugging easier */
        tab_char_buffer[new_x-current_x] = 0;
        FB_PRINT_EX(fnum, tab_char_buffer, new_x-current_x, mask);
    }
#endif
}

/*:::::*/
FBCALL void fb_PrintPad ( int fnum, int mask )
{
#if USE_NATIVE_TAB==1
    FB_PRINT_EX(fnum, "\t", 1, mask);
#else
    if (fnum==0) {
        int con_width;
        int old_x = fb_stdoutTB.line_length + 1;
        int new_x = ((old_x + (FB_TAB_WIDTH-1)) / FB_TAB_WIDTH) * FB_TAB_WIDTH + 1;
        fb_ConsoleGetSize( &con_width, NULL );
        if (new_x > (con_width - FB_TAB_WIDTH)) {
            new_x = 1;
        }
        fb_hPrintPad(fnum, mask, old_x, new_x);
    } else {
        FB_LOCK();

        if( fnum < 1 || fnum > FB_MAX_FILES ) {
            fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
            return;
        }

        {
            int old_x = fb_fileTB[fnum-1].line_length + 1;
            int new_x = ((old_x + (FB_TAB_WIDTH-1)) / FB_TAB_WIDTH) * FB_TAB_WIDTH + 1;
            fb_hPrintPad(fnum, mask, old_x, new_x);
        }

        FB_UNLOCK();
    }
#endif
}

/*:::::*/
FBCALL void fb_PrintVoid ( int fnum, int mask )
{
    if( mask & FB_PRINT_NEWLINE ) {

        FB_PRINT(fnum, FB_NEWLINE, mask);

    } else if( mask & FB_PRINT_PAD ) {

        fb_PrintPad( fnum, mask & ~FB_PRINT_HLMASK );

    }
}

/*:::::*/
static void fb_hPrintStr( int fnum, const char *s, size_t len, int mask )
{
    int simple_mask = mask & ~FB_PRINT_HLMASK;

    if( len != 0 ) {
        FB_PRINT_EX(fnum, s, len, simple_mask);
    }

    fb_PrintVoid( fnum, mask );
}

/*:::::*/
FBCALL void fb_PrintString ( int fnum, FBSTRING *s, int mask )
{
	FB_STRLOCK();

    if( (s == NULL) || (s->data == NULL) )
    	fb_PrintVoid( fnum, mask );
    else
    	fb_hPrintStr( fnum, s->data, FB_STRSIZE(s), mask );

	/* del if temp */
	fb_hStrDelTemp( s );

	FB_STRUNLOCK();
}

/*:::::*/
FBCALL void fb_PrintFixString ( int fnum, const char *s, int mask )
{
    if( s == NULL )
    	fb_PrintVoid( fnum, mask );
    else
    	fb_hPrintStr( fnum, s, strlen( s ), mask );
}
