/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2011 The FreeBASIC development team.
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
 * io_printer.c -- dos printer driver
 *
 * chng: jul/2006 written [jeffmarshall]
 * chng: 
 *
 */

#include <stdio.h>
#include <stddef.h>
#include <stdlib.h>
#include <string.h>
#include "fb.h"

/* _DEV_LPT_INFO->driver_opaque := (FILE *) file_handle */

int fb_PrinterOpen( struct _DEV_LPT_INFO *devInfo, int iPort, const char *pszDevice )
{
    int result;
    char filename[64];
    FILE *fp;
		
    if( iPort==0 ) {
				/* "LPT:" selects default "LPT1:" */
				devInfo->iPort = 1;
		} else {
				devInfo->iPort = iPort;
		}

		sprintf(filename, "LPT%d", devInfo->iPort);
		fp = fopen(filename, "wb");

		devInfo->driver_opaque = fp;

		if( fp==NULL ) {
				result = fb_ErrorSetNum( FB_RTERROR_FILENOTFOUND );
		} else {
				result = fb_ErrorSetNum( FB_RTERROR_OK );
		}

    return result;
}

int fb_PrinterWrite( struct _DEV_LPT_INFO *devInfo, const void *data, size_t length )
{
    FILE *fp = (FILE*) devInfo->driver_opaque;
    if( fwrite( data, length, 1, fp ) != 1 ) {
        return fb_ErrorSetNum( FB_RTERROR_FILEIO );
    }
    return fb_ErrorSetNum( FB_RTERROR_OK );
}

int fb_PrinterWriteWstr( struct _DEV_LPT_INFO *devInfo, const FB_WCHAR *data, size_t length )
{
    /* !!!FIXME!!! no support for unicode output */

    char *temp = alloca( length + 1 );

    if( length > 0 )
    	fb_wstr_ConvToA( temp, data, length );
    else
    	*temp = '\0';

    return fb_PrinterWrite( devInfo, (void *)temp, length );
}

int fb_PrinterClose( struct _DEV_LPT_INFO *devInfo )
{
    FILE *fp = (FILE*) devInfo->driver_opaque;

    fclose(fp);
		devInfo->driver_opaque = NULL;

    return fb_ErrorSetNum( FB_RTERROR_OK );
}
