/* RESET function */

#include "fb.h"

/*:::::*/
FBCALL void fb_FileReset ( void )
{
	int i;

	if( __fb_ctx.do_file_reset == FALSE )
		return;

	__fb_ctx.do_file_reset = FALSE;

    FB_LOCK();

    for( i = 1; i <= (FB_MAX_FILES - FB_RESERVED_FILES); i++ ) 
	{
        FB_FILE *handle = FB_FILE_TO_HANDLE_VALID( i );
        if( handle->hooks != NULL ) 
		{
            DBG_ASSERT(handle->hooks->pfnClose!=NULL);
            handle->hooks->pfnClose( handle );
        }
    }
    
	/* clear all file handles */
    memset( FB_FILE_TO_HANDLE_VALID( 1 ),
            0,
            sizeof(FB_FILE) * (FB_MAX_FILES - FB_RESERVED_FILES) );

    FB_UNLOCK();
}
