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

#define FB_PRINT_EX(fnum, s, len, mask)           \
    do {                                          \
        if( fnum == 0 ) {                         \
            fb_PrintBufferEx( s, len, mask );     \
        } else {                                  \
            fb_hFilePrintBufferEx( fnum, s, len ); \
        }                                         \
    } while (0)

#define FB_PRINT(fnum, s, mask)           \
    FB_PRINT_EX(fnum, s, strlen(s), mask)

#define FB_TAB_WIDTH   14
#define USE_NATIVE_TAB (FB_TAB_WIDTH == 8)
#define FB_PRINT_BUFFER_SIZE 4096

#include <stdlib.h>

/*:::::*/
FBCALL void fb_PrintTab ( int fnum, int mask )
{
#if USE_NATIVE_TAB==1
    FB_PRINT_EX(fnum, "\t", 1, mask);
#else
    if (fnum==0) {
        int con_width, con_height;
        int new_x = ((fb_ConsoleGetX() + (FB_TAB_WIDTH-1)) / FB_TAB_WIDTH) * FB_TAB_WIDTH + 1;
        fb_ConsoleGetSize( &con_width, &con_height );
        if (new_x > con_width) {
            FB_PRINT(fnum, FB_NEWLINE, mask);
        } else {
            fb_ConsoleLocate(0, new_x, -1);
        }
    } else {
        FB_PRINT_EX(fnum, "\t", 1, mask);
    }
#endif
}

/*:::::*/
FBCALL void fb_PrintVoid ( int fnum, int mask )
{
    if( mask & FB_PRINT_NEWLINE )
        FB_PRINT(fnum, FB_NEWLINE, mask);

    else if( mask & FB_PRINT_PAD )
        fb_PrintTab( fnum, mask & ~FB_PRINT_HLMASK );

}

/*:::::*/
static void fb_hPrintStr( int fnum, const char *s, size_t len, int mask )
{
    int simple_mask = mask & ~FB_PRINT_HLMASK;
#if USE_NATIVE_TAB!=1
    char OutputBuffer[FB_PRINT_BUFFER_SIZE];
    size_t iCurrentChar, iBufferSize;
    int iDoPrint;
#endif

    if( len == 0 )
    {
    	fb_PrintVoid( fnum, mask );
    	return;
    }

#if USE_NATIVE_TAB==1

    FB_PRINT_EX(fnum, s, len, simple_mask);

#else

    if (fnum==0) {

        iBufferSize = 0;
        for (iCurrentChar=0; iCurrentChar!=len; ++iCurrentChar) {
            char ch = s[iCurrentChar];
            if (ch=='\t') {
                iDoPrint = TRUE;
            } else {
                OutputBuffer[iBufferSize++] = ch;
                iDoPrint = iBufferSize==FB_PRINT_BUFFER_SIZE;
            }

            if (iDoPrint) {
                FB_PRINT_EX(fnum, OutputBuffer, iBufferSize, simple_mask);
                iBufferSize = 0;
                iDoPrint = FALSE;

                if (ch=='\t') {
                    fb_PrintTab( fnum, simple_mask );
                }
            }
        }

        if (iBufferSize!=0) {
            FB_PRINT_EX(fnum, OutputBuffer, iBufferSize, simple_mask);
        }

    } else {
        FB_PRINT_EX(fnum, s, len, simple_mask);
    }

#endif

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
