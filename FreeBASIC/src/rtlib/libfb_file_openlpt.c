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
 *	file_openlpt - open LPTx
 *
 * chng: jul/2005 written [mjs]
 *
 */

#include <stdlib.h>
#include "fb.h"

static void close_printer_handle(void)
{
    if( FB_HANDLE_PRINTER->hooks==NULL )
        return;
    FB_HANDLE_PRINTER->hooks->pfnClose( FB_HANDLE_PRINTER );
}

#if defined( TARGET_WIN32 ) || defined( TARGET_CYGWIN )
static const char *pszPrinterDev = "LPT:EMU=TTY";
#else
#if defined( TARGET_LINUX )
static const char *pszPrinterDev = "LPT:";
#else
static const char *pszPrinterDev = "LPT1:";
#endif
#endif

int LPrintInit(void)
{
    if( FB_HANDLE_PRINTER->hooks==NULL) {
        int res = fb_FileOpenVfsRawEx( FB_HANDLE_PRINTER,
                                       pszPrinterDev,
                                       strlen(pszPrinterDev),
                                       FB_FILE_MODE_APPEND,
                                       FB_FILE_ACCESS_WRITE,
                                       FB_FILE_LOCK_READWRITE,
                                       0,
                                       FB_FILE_ENCOD_DEFAULT,
                                       fb_DevLptOpen );
        if( res==FB_RTERROR_OK ) {
            atexit(close_printer_handle);
        }
        return res;
    }
    return fb_ErrorSetNum( FB_RTERROR_OK );
}

/*:::::*/
FBCALL int fb_FileOpenLpt ( FBSTRING *str_filename, unsigned int mode,
                            unsigned int access, unsigned int lock,
                            int fnum, int len, const char *encoding )
{
    if( !FB_FILE_INDEX_VALID( fnum ) )
    	return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

    return fb_FileOpenVfsEx( FB_FILE_TO_HANDLE(fnum),
                             str_filename,
                             mode,
                             access,
                             lock,
                             len,
                             fb_hFileStrToEncoding( encoding ),
                             fb_DevLptOpen );

}

