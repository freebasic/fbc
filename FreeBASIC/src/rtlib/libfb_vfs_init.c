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
 *	vfs_init - open file (vfs) functions
 *
 * chng: jul/2005 written [mjs]
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <malloc.h>
#include <assert.h>
#include "fb.h"
#include "fb_rterr.h"

void fb_hFileCtx ( int doinit );
void fb_DevRegisterFILE(void);
void fb_DevRegisterSCRN(void);
void fb_DevRegisterPIPE(void);
void fb_DevRegisterCONS(void);
void fb_DevRegisterERR(void);
void fb_DevRegisterLPT(void);

void fb_VfsInit(void)
{
    static int vfs_init_done = FALSE;
    FB_LOCK();
    if (vfs_init_done==FALSE) {
        /* avoid endless loop between fb_ProtocolRegister and fb_VfsInit */
        vfs_init_done = TRUE;

        /* initialize all file handles */
        fb_hFileCtx( TRUE );

        /* register all default device handlers */
        fb_DevRegisterFILE();
        fb_DevRegisterSCRN();
        fb_DevRegisterPIPE();
        fb_DevRegisterCONS();
        fb_DevRegisterERR();
        fb_DevRegisterLPT();

        /* initialize the first handle to "SCRN:" */
        if (FB_HANDLE_SCREEN->hooks==NULL)
            fb_FileOpenVfsRawEx( FB_HANDLE_SCREEN, "scrn:", 5,
                                 FB_FILE_MODE_APPEND,
                                 FB_FILE_ACCESS_READWRITE,
                                 FB_FILE_LOCK_SHARED, 0);

#if 0
        /* initialize the second handle to "PRN:" */
        if (FB_HANDLE_PRINTER->hooks==NULL)
            fb_FileOpenVfsRawEx( FB_HANDLE_PRINTER, "PRN:", 5,
                                 FB_FILE_MODE_APPEND,
                                 FB_FILE_ACCESS_WRITE,
                                 FB_FILE_LOCK_SHARED, 0);
#endif
    }
    FB_UNLOCK();
}
