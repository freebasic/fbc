/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2010 The FreeBASIC development team.
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
 *
 *  As a special exception, the copyright holders of this library give
 *  you permission to link this library with independent modules to
 *  produce an executable, regardless of the license terms of these
 *  independent modules, and to copy and distribute the resulting
 *  executable under terms of your choice, provided that you also meet,
 *  for each linked independent module, the terms and conditions of the
 *  license of that module. An independent module is a module which is
 *  not derived from or based on this library. If you modify this library,
 *  you may extend this exception to your version of the library, but
 *  you are not obligated to do so. If you do not wish to do so, delete
 *  this exception statement from your version.
 */

/*
 * io_printpad.c -- print functions
 *
 * chng: oct/2004 written [v1ctor]
 *       jul/2004 moved to separate file [mjs]
 *
 */

#include <stdio.h>
#include "fb.h"

#define FB_PRINT_BUFFER_SIZE 2048

#include <stdlib.h>

static void fb_hPrintPadEx ( FB_FILE *handle, int mask, int current_x, int new_x )
{
#ifdef FB_NATIVE_TAB
    FB_PRINT_EX(handle, "\t", 1, mask);

#else
    char tab_char_buffer[FB_TAB_WIDTH+1];
    if (new_x <= current_x) {
        FB_PRINT_EX(handle, FB_NEWLINE, sizeof(FB_NEWLINE)-1, mask);
    } else {
        size_t count = new_x - current_x;
        memset(tab_char_buffer, 32, count);
        /* the terminating NUL shouldn't be required but it makes
         * debugging easier */
        tab_char_buffer[count] = 0;
        FB_PRINT_EX(handle, tab_char_buffer, count, mask);
    }
#endif
}

/*:::::*/
void fb_PrintPadEx ( FB_FILE *handle, int mask )
{
#ifdef FB_NATIVE_TAB
    FB_PRINT_EX(handle, "\t", 1, mask);

#else
    FB_FILE *tmp_handle;
   	int old_x;
    int new_x;

    fb_DevScrnInit_Write( );

    tmp_handle = FB_HANDLE_DEREF(handle);

    old_x = tmp_handle->line_length + 1;
    new_x = old_x + FB_TAB_WIDTH - 1;
    new_x /= FB_TAB_WIDTH;
    new_x *= FB_TAB_WIDTH;
    new_x += 1;
    if (tmp_handle->width!=0) {
        unsigned dev_width = tmp_handle->width;
        if (new_x > (dev_width - FB_TAB_WIDTH)) {
            new_x = 1;
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
