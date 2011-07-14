/* file device */

#include <stdio.h>
#include <stdlib.h>
#include "fb.h"

static FB_FILE_HOOKS hooks_dev_scrn_null = { 0 };

void fb_DevScrnInit_Screen( void )
{
    int cols;
	DEV_SCRN_INFO *info = (DEV_SCRN_INFO*) malloc(sizeof(DEV_SCRN_INFO));

    fb_GetSize( &cols, NULL );
    info->length = 0;

    FB_HANDLE_SCREEN->opaque = info;
    FB_HANDLE_SCREEN->line_length = fb_GetX() - 1;
    FB_HANDLE_SCREEN->width = cols;
}

void fb_DevScrnInit_NoOpen( void )
{
    if ( FB_HANDLE_SCREEN->hooks == NULL ) {
        FB_LOCK();

        memset(FB_HANDLE_SCREEN, 0, sizeof(*FB_HANDLE_SCREEN));

        FB_HANDLE_SCREEN->mode = FB_FILE_MODE_APPEND;
        FB_HANDLE_SCREEN->type = FB_FILE_TYPE_VFS;
        FB_HANDLE_SCREEN->access = FB_FILE_ACCESS_READWRITE;

        fb_DevScrnInit_Screen( );

        FB_HANDLE_SCREEN->hooks = &hooks_dev_scrn_null;

        FB_UNLOCK();
    }
}
