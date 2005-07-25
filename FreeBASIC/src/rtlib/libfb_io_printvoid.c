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
FBCALL void fb_hPrintPadEx ( FB_FILE *handle, int mask, int current_x, int new_x )
{
#ifdef FB_NATIVE_TAB
    FB_PRINT_EX(handle, "\t", 1, mask);

#else
    char tab_char_buffer[FB_TAB_WIDTH+1];
    if (new_x <= current_x) {
        FB_PRINT_EX(handle, FB_NEWLINE, sizeof(FB_NEWLINE)-1, mask);
    } else {
        memset(tab_char_buffer, 32, new_x-current_x);
        /* the terminating NUL shouldn't be required but it makes
         * debugging easier */
        tab_char_buffer[new_x-current_x] = 0;
        FB_PRINT_EX(handle, tab_char_buffer, new_x-current_x, mask);
    }
#endif
}

/*:::::*/
void fb_PrintPadEx ( FB_FILE *handle, int mask )
{
    if( handle==NULL) {
        fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
        return;
    }

#ifdef FB_NATIVE_TAB
    FB_PRINT_EX(handle, "\t", 1, mask);

#else
   	int old_x;
    int new_x;

    old_x = FB_HANDLE_DEREF(handle)->line_length + 1;
    new_x = ((old_x + (FB_TAB_WIDTH-1)) / FB_TAB_WIDTH) * FB_TAB_WIDTH + 1;
    if (handle->hooks!=NULL) {
        if (handle->hooks->pfnGetWidth!=NULL) {
            unsigned dev_width = handle->hooks->pfnGetWidth(handle);
            if (new_x > (dev_width - FB_TAB_WIDTH)) {
                new_x = 1;
            }
        }
    }
    fb_hPrintPadEx(handle, mask, old_x, new_x);
#endif
}

/*:::::*/
FBCALL void fb_PrintPad ( int fnum, int mask )
{
    fb_PrintPadEx( FB_FILE_TO_HANDLE(fnum), mask );
}

/*:::::*/
void fb_PrintVoidEx ( FB_FILE *handle, int mask )
{
    if( handle==NULL) {
        fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
        return;
    }

    if( mask & FB_PRINT_NEWLINE ) {
        FB_PRINT_EX(handle, FB_NEWLINE, sizeof(FB_NEWLINE)-1, mask);
    } else if( mask & FB_PRINT_PAD ) {
        fb_PrintPadEx( handle, mask & ~FB_PRINT_HLMASK );
    }
}

/*:::::*/
FBCALL void fb_PrintVoid ( int fnum, int mask )
{
    fb_PrintVoidEx( FB_FILE_TO_HANDLE(fnum), mask );
}

