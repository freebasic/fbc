/* file device */

#include "fb.h"

static FB_FILE_HOOKS hooks_dev_scrn_null = {
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
};

/* Update width/line_length after the screen was resized (can happen with
   console/terminal windows but also with graphics window) */
void fb_DevScrnUpdateWidth( void )
{
	int cols;
	fb_GetSize( &cols, NULL );
	FB_HANDLE_SCREEN->line_length = fb_GetX( ) - 1;
	FB_HANDLE_SCREEN->width = cols;
}

void fb_DevScrnMaybeUpdateWidth( void )
{
	/* Only if it was initialized (i.e. used) yet, otherwise we don't need
	   to bother */
	if( FB_HANDLE_SCREEN->hooks ) {
		fb_DevScrnUpdateWidth( );
	}
}


void fb_DevScrnInit_Screen( void )
{
	fb_DevScrnUpdateWidth( );
	FB_HANDLE_SCREEN->opaque = calloc(1, sizeof(DEV_SCRN_INFO));
}

void fb_DevScrnEnd( FB_FILE *handle )
{
	if( handle->opaque ) {
		free( handle->opaque );
		handle->opaque = NULL;
	}
}

void fb_DevScrnInit_NoOpen( void )
{
	FB_LOCK();
    if ( FB_HANDLE_SCREEN->hooks == NULL ) {
        memset(FB_HANDLE_SCREEN, 0, sizeof(*FB_HANDLE_SCREEN));

        FB_HANDLE_SCREEN->mode = FB_FILE_MODE_APPEND;
        FB_HANDLE_SCREEN->type = FB_FILE_TYPE_VFS;
        FB_HANDLE_SCREEN->access = FB_FILE_ACCESS_READWRITE;

        fb_DevScrnInit_Screen( );

        FB_HANDLE_SCREEN->hooks = &hooks_dev_scrn_null;
    }
	FB_UNLOCK();
}
