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
 * io_serial.c -- serial port access for Windows
 *
 * chng: aug/2005 written [mjs]
 *
 */

#include "fb.h"
#include "fb_rterr.h"

int fb_SerialOpen( struct _FB_FILE *handle,
                   int iPort, FB_SERIAL_OPTIONS *options,
                   const char *pszDevice, void **ppvHandle )
{
    return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
}

int fb_SerialGetRemaining( struct _FB_FILE *handle, 
                           void *pvHandle, long *pLength )
{
    return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
}

int fb_SerialWrite( struct _FB_FILE *handle, 
                    void *pvHandle, const void *data, size_t length )
{
    return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
}

int fb_SerialRead( struct _FB_FILE *handle, 
                   void *pvHandle, void *data, size_t *pLength )
{
    return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
}

int fb_SerialClose( struct _FB_FILE *handle, 
                    void *pvHandle )
{
    return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
}
