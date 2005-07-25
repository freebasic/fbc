/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2005 Mark Junker (mjscod@gmx.de)
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
 *	dev_lpt - LPTx device
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

typedef struct _DEV_LPT_INFO {
    char  *pszDevice;
    void  *hPrinter;
    int    iPort;
    size_t uiRefCount;
} DEV_LPT_INFO;

/*:::::*/
static unsigned fb_DevLptGetWidth( struct _FB_FILE *handle )
{
    /* TODO: Return the value set by a WIDTH "LPT1:", 128 */
    return 80;
}

/*:::::*/
static int fb_DevLptClose( struct _FB_FILE *handle )
{
    int res;
    DEV_LPT_INFO *pInfo;

    FB_LOCK();

    pInfo = (DEV_LPT_INFO*) handle->opaque;
    if( pInfo->uiRefCount==1 ) {
        res = fb_PrinterClose(pInfo->hPrinter);
        if( res==FB_RTERROR_OK ) {
            free(pInfo->pszDevice);
            free(pInfo);
        }
    } else {
        --pInfo->uiRefCount;
        res = fb_ErrorSetNum( FB_RTERROR_OK );
    }

    FB_UNLOCK();

	return res;
}

/*:::::*/
static int fb_DevLptWrite( struct _FB_FILE *handle, const void* value, size_t valuelen )
{
    int res;
    DEV_LPT_INFO *pInfo;

    FB_LOCK();

    pInfo = (DEV_LPT_INFO*) handle->opaque;
    res = fb_PrinterWrite(pInfo->hPrinter, value, valuelen );

    FB_UNLOCK();

	return res;
}

/*:::::*/
static int fb_DevLptTestProtocol( struct _FB_FILE *handle, const char *filename, size_t filename_len )
{
    size_t i;

    if( strcasecmp(filename, "PRN:")==0 )
        return TRUE;

    if( filename_len < 5 )
        return FALSE;
    if( strncasecmp(filename, "LPT", 3)!=0 )
        return FALSE;
    if( filename[filename_len-1]!=':' )
        return FALSE;

    for( i = 3;
         i != (filename_len-1);
         ++i )
    {
        char ch = filename[i];
        if( ch<'0' || ch>'9')
            return FALSE;
    }

    return TRUE;
}

static const FB_FILE_HOOKS fb_hooks_dev_lpt = {
    fb_DevLptGetWidth,
    NULL,
    fb_DevLptClose,
    NULL,
    NULL,
    NULL,
    fb_DevLptWrite,
    NULL,
    NULL,
    NULL
};

/*:::::*/
int fb_DevLptOpen( struct _FB_FILE *handle, const char *filename, size_t filename_len )
{
    DEV_LPT_INFO *info;
    size_t i;
    int res;

    FB_LOCK();

    /* Determine the port number and a normalized device name */
    info = (DEV_LPT_INFO*) calloc(1, sizeof(DEV_LPT_INFO));
    info->uiRefCount = 1;
    if( strcasecmp(filename, "PRN:")==0 ) {
        info->iPort = 1;
        info->pszDevice = strdup("LPT1:");
    } else {
        size_t i;
        for( i = 3;
             i != (filename_len - 1);
             ++i )
        {
            info->iPort *= 10;
            info->iPort += (unsigned) (filename[i] - '0');
        }
        info->pszDevice = strdup(filename);
        memcpy(info->pszDevice, "LPT", 3);
    }

    /* Test if the printer is already open. */
    for( i=0;
         i!=FB_MAX_FILES;
         ++i )
    {
        FB_FILE *tmp_handle = handle;
        if( tmp_handle->hooks==&fb_hooks_dev_lpt ) {
            DEV_LPT_INFO *tmp_info = (DEV_LPT_INFO*) tmp_handle->opaque;
            if( strcmp(tmp_info->pszDevice, info->pszDevice)==0 ) {
                free(info);
                ++(info = tmp_info)->uiRefCount;
                break;
            }
        }
    }

    /* Open the printer if not opened already */
    if( info->hPrinter == NULL ) {
        res = fb_PrinterOpen( info->iPort, info->pszDevice, &info->hPrinter );
    } else {
        res = fb_ErrorSetNum( FB_RTERROR_OK );
    }

    if( res == FB_RTERROR_OK ) {
        handle->hooks = &fb_hooks_dev_lpt;
        handle->opaque = info;
    } else {
        free(info);
    }

    FB_UNLOCK();

	return res;
}

void fb_DevRegisterLPT(void)
{
    FB_VFS_PROTOCOL *protocol =
        (FB_VFS_PROTOCOL*) calloc(1, sizeof(FB_VFS_PROTOCOL));
    protocol->id = "lpt";
    protocol->pfnTestProtocol = fb_DevLptTestProtocol;
    protocol->pfnOpen = fb_DevLptOpen;
    fb_ProtocolRegister ( protocol );
}
