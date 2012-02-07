/* freefile function */

#include "fb.h"

/*:::::*/
FBCALL int fb_FileFree( void )
{
	int i;

	FB_LOCK();

    for( i = 1; i <= (FB_MAX_FILES - FB_RESERVED_FILES); i++ ) {
        FB_FILE *handle = FB_FILE_TO_HANDLE(i);
        if (handle->hooks==NULL) {
			FB_UNLOCK();
			return i;
        }
    }

	FB_UNLOCK();

	return 0;
}
