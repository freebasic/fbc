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

#ifndef __FB_PRINTER_H__
#define __FB_PRINTER_H__

#include "fb_file.h"

typedef struct _DEV_LPT_PROTOCOL 
{
	char * proto;
	int iPort;
	char * name;
	char * title;
	char * emu;
	char raw[];
} DEV_LPT_PROTOCOL;

typedef struct _DEV_LPT_INFO {
    void  *driver_opaque; /* this member must be first */
    char  *pszDevice;
    int    iPort;
    size_t uiRefCount;
} DEV_LPT_INFO;

int fb_DevLptParseProtocol( 
	DEV_LPT_PROTOCOL ** lpt_proto_out, 
	const char * proto_raw, 
	size_t proto_raw_len,  
	int substprn
	);

       int          fb_DevLptOpen       ( struct _FB_FILE *handle, const char *filename, size_t filename_len );
       int          fb_DevLptWrite      ( struct _FB_FILE *handle, const void* value, size_t valuelen );
       int          fb_DevLptWriteWstr  ( struct _FB_FILE *handle, const FB_WCHAR* value, size_t valuelen );
       int          fb_DevLptClose      ( struct _FB_FILE *handle );

       int          fb_DevPrinterSetWidth ( const char *pszDevice, int width,int default_width );
       int          fb_DevPrinterGetOffset( const char *pszDevice );

       int          fb_PrinterOpen      ( struct _DEV_LPT_INFO *devInfo, int iPort, const char *pszDevice );
       int          fb_PrinterWrite     ( struct _DEV_LPT_INFO *devInfo, const void *data, size_t length );
       int          fb_PrinterWriteWstr ( struct _DEV_LPT_INFO *devInfo, const FB_WCHAR *data,size_t length );
       int          fb_PrinterClose     ( struct _DEV_LPT_INFO *devInfo );

#endif /*__FB_PRINTER_H__*/
