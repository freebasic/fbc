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
 * io_printer.c -- printer access for Windows
 *
 * chng: jul/2005 written [mjs]
 *
 */

#include <stdio.h>
#include <stddef.h>
#include <stdlib.h>
#include <string.h>
#include "fb.h"
#include "fb_rterr.h"

int fb_PrinterOpen( int iPort, const char *pszDevice, void **ppvHandle )
{
    int result;
    char filename[64];
    FILE *fp;

    sprintf(filename, "/dev/lp%d", (iPort-1));
    fp = fopen(filename, "w");
    if( fp==NULL ) {
        result = fb_ErrorSetNum( FB_RTERROR_FILENOTFOUND );
    } else {
        *ppvHandle = fp;
        result = fb_ErrorSetNum( FB_RTERROR_OK );
    }

    return result;
}

int fb_PrinterWrite( void *pvHandle, const void *data, size_t length )
{
    FILE *fp = (FILE*) pvHandle;
    if( fwrite( data, length, 1, fp ) != 1 ) {
        return fb_ErrorSetNum( FB_RTERROR_FILEIO );
    }
    return fb_ErrorSetNum( FB_RTERROR_OK );
}

int fb_PrinterClose( void *pvHandle )
{
    FILE *fp = (FILE*) pvHandle;
    fclose(fp);
    return fb_ErrorSetNum( FB_RTERROR_OK );
}
