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
 *	file_openlpt - open LPTx
 *
 * chng: jul/2005 written [mjs]
 *
 */

#include <stdlib.h>
#include "fb.h"
#include "fb_rterr.h"

static void close_printer_handle(void)
{
    if( FB_HANDLE_PRINTER->hooks==NULL )
        return;
    FB_HANDLE_PRINTER->hooks->pfnClose( FB_HANDLE_PRINTER );
}

int LPrintInit(void)
{
    if( FB_HANDLE_PRINTER->hooks==NULL) {
        int res = fb_FileOpenVfsRawEx( FB_HANDLE_PRINTER,
                                       "LPT1:", 5,
                                       FB_FILE_MODE_APPEND,
                                       FB_FILE_ACCESS_WRITE,
                                       FB_FILE_LOCK_READWRITE,
                                       0, fb_DevLptOpen );
        if( res==FB_RTERROR_OK ) {
            atexit(close_printer_handle);
        }
        return res;
    }
    return fb_ErrorSetNum( FB_RTERROR_OK );
}

FBCALL int          fb_FileOpenLpt      ( FBSTRING *str_filename, unsigned int mode,
                                          unsigned int access, unsigned int lock,
                                          int fnum, int len )
{
    return fb_FileOpenVfsEx( FB_FILE_TO_HANDLE(fnum),
                             str_filename, mode, access,
                             lock, len, fb_DevLptOpen );
}

