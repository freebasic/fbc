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
 *	dev_lpt - LPTx device
 *
 * chng: jul/2005 written [mjs]
 *
 */

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <malloc.h>
#include "fb.h"
#include "fb_rterr.h"

int fb_DevLptTestProtocol( struct _FB_FILE *handle, const char *filename, size_t filename_len );

typedef struct _DEV_LPT_INFO {
    char  *pszDevice;
    void  *hPrinter;
    int    iPort;
    size_t uiRefCount;
} DEV_LPT_INFO;

/*:::::*/
static int fb_DevLptClose( struct _FB_FILE *handle )
{
    int res;
    DEV_LPT_INFO *pInfo;

    FB_IO_EXIT_LOCK();

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

    FB_IO_EXIT_UNLOCK();

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
static int fb_DevLptWriteWstr( struct _FB_FILE *handle, const FB_WCHAR* value, size_t valuelen )
{
    int res;
    DEV_LPT_INFO *pInfo;

    FB_LOCK();

    pInfo = (DEV_LPT_INFO*) handle->opaque;
    res = fb_PrinterWriteWstr(pInfo->hPrinter, value, valuelen );

    FB_UNLOCK();

	return res;
}

static FB_FILE_HOOKS fb_hooks_dev_lpt = {
    NULL,
    fb_DevLptClose,
    NULL,
    NULL,
    NULL,
    NULL,
    fb_DevLptWrite,
    fb_DevLptWriteWstr,
    NULL,
    NULL,
    NULL,
    NULL
};

/*:::::*/
int fb_DevLptOpen( struct _FB_FILE *handle, const char *filename, size_t filename_len )
{
    FB_FILE *redir_handle = NULL;
    DEV_LPT_INFO *info;
    size_t i;
    int res;

    if (!fb_DevLptTestProtocol( handle, filename, filename_len ))
        return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

    FB_LOCK();

    /* Determine the port number and a normalized device name */
    info = (DEV_LPT_INFO*) calloc(1, sizeof(DEV_LPT_INFO));
    info->uiRefCount = 1;
    if( strcasecmp(filename, "PRN:")==0 ) {
        info->iPort = 1;
        info->pszDevice = strdup("LPT1:");
    } else {
        size_t i;
        info->iPort = 0;
        for( i = 3;
             i != (filename_len - 1);
             ++i )
        {
            char ch = filename[i];
            if( ch<'0' || ch>'9' )
                break;
            info->iPort = info->iPort * 10 + (ch - '0');
        }
        info->pszDevice = strdup(filename);
        memcpy(info->pszDevice, "LPT", 3);
    }

    /* Test if the printer is already open. */
    for( i=0;
         i!=FB_MAX_FILES;
         ++i )
    {
        FB_FILE *tmp_handle = fb_fileTB + i;
        if( tmp_handle->hooks==&fb_hooks_dev_lpt ) {
            DEV_LPT_INFO *tmp_info = (DEV_LPT_INFO*) tmp_handle->opaque;
            if( strcmp(tmp_info->pszDevice, info->pszDevice)==0 ) {
                free(info);
                /* bugcheck */
                assert( tmp_handle!=FB_HANDLE_PRINTER
                        && handle!=FB_HANDLE_PRINTER );
                redir_handle = tmp_handle;
                info = tmp_info;
                ++info->uiRefCount;
                break;
            }
        }
    }

    /* Open the printer if not opened already */
    if( info->hPrinter == NULL ) {
        res = fb_PrinterOpen( info->iPort, info->pszDevice, &info->hPrinter );
    } else {
        res = fb_ErrorSetNum( FB_RTERROR_OK );
        if( FB_HANDLE_USED(redir_handle) ) {
            /* We only allow redirection between OPEN "LPT1:" and LPRINT */
            if( handle==FB_HANDLE_PRINTER ) {
                redir_handle->redirection_to = handle;
                handle->width = redir_handle->width;
                handle->line_length = redir_handle->line_length;
            } else {
                handle->redirection_to = redir_handle;
            }
        } else {
            handle->width = 80;
        }
    }

    if( res == FB_RTERROR_OK ) {
        handle->hooks = &fb_hooks_dev_lpt;
        handle->opaque = info;
    } else {
        if( info->pszDevice )
            free( info->pszDevice );
        free( info );
    }

    FB_UNLOCK();

	return res;
}

int fb_DevPrinterSetWidth( const char *pszDevice, int width, int default_width )
{
    int cur = ((default_width==-1) ? 80 : default_width);
    size_t i;
    char *pszDev;

    if( !fb_DevLptTestProtocol( NULL, pszDevice, strlen(pszDevice) ) )
        return 0;

    if( strcasecmp( pszDevice, "PRN:" ) == 0 ) {
        pszDev = strdup("LPT1:");
    } else {
        pszDev = strdup(pszDevice);
        memcpy(pszDev, "LPT", 3);
    }
    /* Test all printers. */
    for( i=0;
         i!=FB_MAX_FILES;
         ++i )
    {
        FB_FILE *tmp_handle = fb_fileTB + i;
        if( tmp_handle->hooks==&fb_hooks_dev_lpt
            && tmp_handle->redirection_to==NULL )
        {
            DEV_LPT_INFO *tmp_info = (DEV_LPT_INFO*) tmp_handle->opaque;
            if( strcmp(tmp_info->pszDevice, pszDev)==0 ) {
                if( width!=-1 )
                    tmp_handle->width = width;
                cur = tmp_handle->width;
                break;
            }
        }
    }

    free(pszDev);
    return cur;
}

int fb_DevPrinterGetOffset( const char *pszDevice )
{
    int cur = 0;
    size_t i;
    char *pszDev;

    if( !fb_DevLptTestProtocol( NULL, pszDevice, strlen(pszDevice) ) )
        return 0;

    if( strcasecmp( pszDevice, "PRN:" ) == 0 ) {
        pszDev = strdup("LPT1:");
    } else {
        pszDev = strdup(pszDevice);
        memcpy(pszDev, "LPT", 3);
    }
    /* Test all printers. */
    for( i=0;
         i!=FB_MAX_FILES;
         ++i )
    {
        FB_FILE *tmp_handle = fb_fileTB + i;
        if( tmp_handle->hooks==&fb_hooks_dev_lpt
            && tmp_handle->redirection_to==NULL )
        {
            DEV_LPT_INFO *tmp_info = (DEV_LPT_INFO*) tmp_handle->opaque;
            if( strcmp(tmp_info->pszDevice, pszDev)==0 ) {
                cur = tmp_handle->line_length;
                break;
            }
        }
    }

    free(pszDev);
    return cur;
}
