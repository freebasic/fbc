/* file device size calc */

#include "fb.h"

int fb_hDevFileSeekStart( FILE *fp, int mode, FB_FILE_ENCOD encod, int seek_zero )
{
	/* skip the BOM if in UTF-mode */
	size_t ofs;

	switch( encod )
	{
	case FB_FILE_ENCOD_UTF8:
		ofs = 3;
		break;

	case FB_FILE_ENCOD_UTF16:
		ofs = sizeof( UTF_16 );
		break;

	case FB_FILE_ENCOD_UTF32:
		ofs = sizeof( UTF_32 );
		break;

	default:
		if( seek_zero == FALSE )
			return 0;

		ofs = 0;
	}

	return fseeko( fp, ofs, SEEK_SET );
}

fb_off_t fb_DevFileGetSize( FILE *fp, int mode, FB_FILE_ENCOD encod, int seek_back )
{
	fb_off_t size = 0;

	switch( mode )
	{
	case FB_FILE_MODE_BINARY:
	case FB_FILE_MODE_RANDOM:
	case FB_FILE_MODE_INPUT:

		if( fseeko( fp, 0, SEEK_END ) != 0 )
			return -1;

		size = ftello( fp );

		if( seek_back )
			fb_hDevFileSeekStart( fp, mode, encod, TRUE );

		break;

	case FB_FILE_MODE_APPEND:
		size = ftello( fp );
	}

	return size;
}
