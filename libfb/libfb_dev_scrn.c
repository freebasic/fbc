/*
 *	dev_file - file device
 *
 * chng: jul/2005 written [mjs]
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include "fb.h"

void fb_DevScrnInit_Screen( void );

static FB_FILE_HOOKS hooks_dev_scrn = {
    fb_DevScrnEof,
    fb_DevScrnClose,
    NULL,
    NULL,
    fb_DevScrnRead,
    fb_DevScrnReadWstr,
    fb_DevScrnWrite,
    fb_DevScrnWriteWstr,
    NULL,
    NULL,
    fb_DevScrnReadLine,
    fb_DevScrnReadLineWstr
};

int fb_DevScrnOpen( struct _FB_FILE *handle, const char *filename, size_t filename_len )
{
    FB_LOCK();

    if (handle!=FB_HANDLE_SCREEN)
    {
        DEV_SCRN_INFO *info = (DEV_SCRN_INFO*) FB_HANDLE_SCREEN->opaque;
        handle->hooks = &hooks_dev_scrn;
        handle->opaque = info;
        handle->redirection_to = FB_HANDLE_SCREEN;

    }
    else if( handle->hooks != &hooks_dev_scrn )
    {
    	if( handle->hooks == NULL )
    		fb_DevScrnInit_Screen( );
    	handle->hooks = &hooks_dev_scrn;
        handle->type = FB_FILE_TYPE_CONSOLE;
    }

    FB_UNLOCK();

	return fb_ErrorSetNum( FB_RTERROR_OK );
}

void fb_DevScrnInit( void )
{
    if ( FB_HANDLE_SCREEN->hooks == NULL )
    {
        FB_LOCK();

        memset(FB_HANDLE_SCREEN, 0, sizeof(*FB_HANDLE_SCREEN));

        FB_HANDLE_SCREEN->mode = FB_FILE_MODE_APPEND;
        FB_HANDLE_SCREEN->encod = FB_FILE_ENCOD_DEFAULT;
        FB_HANDLE_SCREEN->type = FB_FILE_TYPE_VFS;
        FB_HANDLE_SCREEN->access = FB_FILE_ACCESS_READWRITE;

        fb_DevScrnOpen( FB_HANDLE_SCREEN, NULL, 0 );

        FB_UNLOCK();
    }
    else if( FB_HANDLE_SCREEN->hooks != &hooks_dev_scrn )
    {
		FB_HANDLE_SCREEN->hooks = &hooks_dev_scrn;
	}
}
