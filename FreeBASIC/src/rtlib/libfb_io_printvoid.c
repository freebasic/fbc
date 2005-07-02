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
 * io_printvoid.c -- print functions
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <stdio.h>
#include "fb.h"
#include "fb_rterr.h"

#define FB_PRINT_BUFFER_SIZE 2048

#include <stdlib.h>

static
FBCALL void fb_hPrintPad ( int fnum, int mask, int current_x, int new_x )
{
#ifdef FB_NATIVE_TAB
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
#ifdef FB_NATIVE_TAB
    FB_PRINT_EX(fnum, "\t", 1, mask);

#else
   	int old_x;
    int new_x;

    if (fnum==0)
    {
        int con_width;
        old_x = fb_FileGetLineLen( 0 ) + 1;
        new_x = ((old_x + (FB_TAB_WIDTH-1)) / FB_TAB_WIDTH) * FB_TAB_WIDTH + 1;
        fb_GetSize( &con_width, NULL );
        if (new_x > (con_width - FB_TAB_WIDTH)) {
            new_x = 1;
        }
        fb_hPrintPad(fnum, mask, old_x, new_x);

    }
    else
    {
        FB_LOCK();

        if( fnum < 1 || fnum > FB_MAX_FILES )
        {
            fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
            return;
        }

		old_x = fb_FileGetLineLen( fnum ) + 1;
        new_x = ((old_x + (FB_TAB_WIDTH-1)) / FB_TAB_WIDTH) * FB_TAB_WIDTH + 1;
        fb_hPrintPad(fnum, mask, old_x, new_x);

        FB_UNLOCK();
    }
#endif
}

/*:::::*/
FBCALL void fb_PrintVoid ( int fnum, int mask )
{
    if( mask & FB_PRINT_NEWLINE )
    {
        FB_PRINT(fnum, FB_NEWLINE, mask);
    }
    else if( mask & FB_PRINT_PAD )
    {
        fb_PrintPad( fnum, mask & ~FB_PRINT_HLMASK );
    }
}

