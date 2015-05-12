/* file size */

#include "fb.h"

/*:::::*/
fb_off_t fb_FileSizeEx( FB_FILE *handle )
{
	fb_off_t res = 0;

	if( !FB_HANDLE_USED(handle) )
		return res;

	FB_LOCK();

	if (handle->hooks->pfnSeek!=NULL && handle->hooks->pfnTell!=NULL) {
		fb_off_t old_pos;
		/* remember old position */
		int result = handle->hooks->pfnTell(handle, &old_pos);
		if (result==0) {
			/* move to end of file */
			result = handle->hooks->pfnSeek(handle, 0, SEEK_END);
		}
		if (result==0) {
			/* get size */
			result = handle->hooks->pfnTell(handle, &res);
			/* restore old position*/
			handle->hooks->pfnSeek(handle, old_pos, SEEK_SET);
		}
	}

	FB_UNLOCK();

	return res;
}

/*:::::*/
FBCALL long long fb_FileSize( int fnum )
{
	return fb_FileSizeEx(FB_FILE_TO_HANDLE(fnum));
}
