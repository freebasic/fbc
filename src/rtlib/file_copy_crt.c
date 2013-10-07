/* generic C stdio file copy */

#include "fb.h"

#define BUFFER_SIZE 512

FBCALL int fb_CrtFileCopy( const char *source, const char *destination )
{
	FILE *src, *dst;
	unsigned char buffer[BUFFER_SIZE];
	size_t bytesread;

	dst = NULL;
	src = fopen(source, "rb");
	if (!src)
		goto err;

	dst = fopen(destination, "wb");
	if (!dst)
		goto err;

	while( (bytesread = fread( buffer, 1, BUFFER_SIZE, src )) > 0 ) {
		if (fwrite( buffer, 1, bytesread, dst ) != bytesread)
			goto err;
	}

	if( !feof( src ) )
		goto err;

	fclose( src );
	fclose( dst );

	return fb_ErrorSetNum( FB_RTERROR_OK );

err:
	if (src) fclose( src );
	if (dst) fclose( dst );
	return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
}
