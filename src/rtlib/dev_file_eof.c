/* detects EOF for file device */

#include "fb.h"

int fb_DevFileEof( FB_FILE *handle )
{
    FILE *fp;

	FB_LOCK();

    fp = (FILE*) handle->opaque;

	if( fp == NULL ) {
		FB_UNLOCK();
		return FB_TRUE;
	}

	int eof;
	switch( handle->mode ) {
	/* non-text mode? */
	case FB_FILE_MODE_BINARY:
	case FB_FILE_MODE_RANDOM:
		/* note: handle->putback_size will be checked by fb_FileEofEx() */
		/* This detects both cases: a) last read reached EOF, b) next
		   read will reach EOF */
		eof = (ftello( fp ) >= handle->size);
		break;

	/* text-mode (INPUT, OUTPUT or APPEND) */
	default:
		/* This also handles the EOF char (27). */
		/* We can't check ftell(), because it's not guaranteed to give
		   a real file offset in text mode. */
		/* a) detect whether last read reached EOF */
		eof = feof( fp );
		if( !eof ) {
			/* b) peek ahead: will the next read reach EOF? */
			int c = getc( fp );
			eof = (c == EOF);
			if( !eof ) {
				ungetc( c, fp );
			}
		}
		break;
	}

	FB_UNLOCK();
	return eof ? FB_TRUE : FB_FALSE;
}
