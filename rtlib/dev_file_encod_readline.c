/* UTF-encoded file device LINE INPUT for strings */

#include "fb.h"

int fb_DevFileReadLineEncod( FB_FILE *handle, FBSTRING *dst )
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
	fb_StrDelete( dst );

	/* Read one byte at a time until CR and/or LF is found.
	   The fb_FileGetDataEx() will handle the decoding. */
	while( TRUE ) {
		char c[2];
		size_t len;

		res = fb_FileGetDataEx( handle, 0, c, 1, &len, FALSE, FALSE );
		if( (res != FB_RTERROR_OK) || (len == 0) )
			break;

		/* CR? Check for following LF too, and skip it if it's there */
		if( c[0] == '\r' ) {
			res = fb_FileGetDataEx( handle, 0, c, 1, &len, FALSE, FALSE );
			if( (res != FB_RTERROR_OK) || (len == 0) )
				break;

			/* No LF? Ok then, don't skip it yet */
			if( c[0] != '\n' )
				fb_FilePutBackEx( handle, c, 1 );

			break;
		}

		/* LF? */
		if( c[0] == '\n' ) {
			break;
		}

		/* Any other char? Append to string, and continue... */
		c[1] = 0;
		fb_StrConcatAssign( (void *)dst, -1, c, 1, FB_FALSE );
	}

	FB_UNLOCK();

	return res;
}
