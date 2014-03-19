/* detects EOF for file device */

#include "fb.h"

int fb_DevFileEof( FB_FILE *handle )
{
	int result;
    FILE *fp;

	FB_LOCK();

    fp = (FILE*) handle->opaque;

	if( fp == NULL ) {
		FB_UNLOCK();
		return FB_TRUE;
	}

	result = FB_FALSE;

	switch( handle->mode ) {
	/* non-text mode? */
	case FB_FILE_MODE_BINARY:
	case FB_FILE_MODE_RANDOM:
		/* note: handle->putback_size will be checked by fb_FileEofEx() */
		result = (ftello( fp ) >= handle->size ? FB_TRUE : FB_FALSE);
		break;

	/* text-mode (INPUT, OUTPUT or APPEND) */
	default:
		/* try feof() first, because the EOF char (27) */
		if( feof( fp ) ) {
			result = FB_TRUE;
		/* if in input mode, feof() won't return TRUE if file_pos == file_size */
		} else if( handle->mode == FB_FILE_MODE_INPUT ) {
			/* Check the file size, if known
			   (excluding pipes, for example, which re-use fb_DevFileEof()) */
			if( handle->hooks->pfnTell != NULL && handle->hooks->pfnSeek != NULL ) {
				result = (ftello( fp ) >= handle->size ? FB_TRUE : FB_FALSE);
			}
		}
		break;
	}

	FB_UNLOCK();
	return result;
}
