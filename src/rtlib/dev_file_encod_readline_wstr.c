/* UTF-encoded file device LINE INPUT for wstrings */

#include "fb.h"

int fb_DevFileReadLineEncodWstr( FB_FILE *handle, FB_WCHAR *dst, ssize_t max_chars )
{
	int res;

	FB_LOCK();

	FILE* fp = (FILE *)handle->opaque;
	if( fp == stdout || fp == stderr )
		fp = stdin;

	if( fp == NULL ) {
		FB_UNLOCK();
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
	}

	/* Clear string first, we're only using += concat assign below... */
	dst[0] = _LC('\0');

	/* Read one byte at a time until CR and/or LF is found.
	   The fb_FileGetDataEx() will handle the decoding. The length to read
	   is specified in wchars, not bytes, because we're passing TRUE for
	   is_unicode. */
	while( TRUE ) {
		FB_WCHAR c[2];
		size_t len;

		res = fb_FileGetDataEx( handle, 0, c, 1, &len, FALSE, TRUE );
		if( (res != FB_RTERROR_OK) || (len == 0) )
			break;

		/* CR? Check for following LF too, and skip it if it's there */
		if( c[0] == _LC('\r') ) {
			res = fb_FileGetDataEx( handle, 0, c, 1, &len, FALSE, TRUE );
			if( (res != FB_RTERROR_OK) || (len == 0) )
				break;

			/* No LF? Ok then, don't skip it yet */
			if( c[0] != _LC('\n') )
				fb_FilePutBackEx( handle, c, 1 );

			break;
		}

		/* LF? */
		if( c[0] == _LC('\n') ) {
			break;
		}

		/* Any other char? Append to string, and continue... */
		c[1] = _LC('\0');
		fb_WstrConcatAssign( dst, max_chars, c );
	}

	FB_UNLOCK();

	return res;
}
