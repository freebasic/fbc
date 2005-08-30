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
 *	file_open - short version of OPEN
 *
 * chng: jul/2005 written [mjs]
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "fb.h"
#include "fb_rterr.h"

/*:::::*/
FBCALL int fb_FileOpenShort( FBSTRING *str_file_mode,
                             int fnum,
                             FBSTRING *filename,
                             int len,
                             FBSTRING *str_access_mode,
                             FBSTRING *str_lock_mode)
{
    unsigned file_mode = 0;
    int access_mode = -1, lock_mode = -1;
    size_t file_mode_len, access_mode_len, lock_mode_len;

    file_mode_len = FB_STRSIZE( str_file_mode );
    access_mode_len = FB_STRSIZE( str_access_mode );
    lock_mode_len = FB_STRSIZE( str_lock_mode );

    if( file_mode_len != 1 || access_mode_len>2 || lock_mode_len>2 ) {
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    }

    if( strcasecmp(str_file_mode->data, "B")==0 ) {
        file_mode = FB_FILE_MODE_BINARY;
    } else if( strcasecmp(str_file_mode->data, "I")==0 ) {
        file_mode = FB_FILE_MODE_INPUT;
    } else if( strcasecmp(str_file_mode->data, "O")==0 ) {
        file_mode = FB_FILE_MODE_OUTPUT;
    } else if( strcasecmp(str_file_mode->data, "A")==0 ) {
        file_mode = FB_FILE_MODE_APPEND;
    } else if( strcasecmp(str_file_mode->data, "R")==0 ) {
        file_mode = FB_FILE_MODE_RANDOM;
    } else {
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    }

    if( access_mode_len!=0 ) {
        if ( strcasecmp(str_access_mode->data, "R")==0 ) {
            access_mode = FB_FILE_ACCESS_READ;
        } else if ( strcasecmp(str_access_mode->data, "W")==0 ) {
            access_mode = FB_FILE_ACCESS_WRITE;
        } else if ( strcasecmp(str_access_mode->data, "RW")==0 ) {
            access_mode = FB_FILE_ACCESS_READWRITE;
        } else {
            return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
        }
    }

    if( lock_mode_len!=0 ) {
        if ( strcasecmp(str_lock_mode->data, "S")==0 ) {
            lock_mode = FB_FILE_LOCK_SHARED;
        } else if ( strcasecmp(str_lock_mode->data, "R")==0 ) {
            lock_mode = FB_FILE_LOCK_READ;
        } else if ( strcasecmp(str_lock_mode->data, "W")==0 ) {
            lock_mode = FB_FILE_LOCK_WRITE;
        } else if ( strcasecmp(str_lock_mode->data, "RW")==0 ) {
            lock_mode = FB_FILE_LOCK_READWRITE;
        } else {
            return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
        }
    }

    if( access_mode == -1 ) {
        /* determine the default access mode for a given file mode */
        switch (file_mode) {
        case FB_FILE_MODE_INPUT:
            access_mode = FB_FILE_ACCESS_READ;
            break;
        case FB_FILE_MODE_OUTPUT:
        case FB_FILE_MODE_APPEND:
            access_mode = FB_FILE_ACCESS_WRITE;
            break;
        default:
            access_mode = FB_FILE_ACCESS_ANY;
            break;
        }
    }

    if( lock_mode == -1 ) {
        /* determine the default lock mode for a given file mode */
        switch (file_mode) {
        case FB_FILE_MODE_INPUT:
            lock_mode = FB_FILE_LOCK_SHARED;
            break;
        default:
            lock_mode = FB_FILE_LOCK_WRITE;
            break;
        }
    }

    return fb_FileOpen( filename,
                        file_mode,
                        access_mode,
                        lock_mode,
                        fnum,
                        len );
}
