/* generic C stdio file copy */
 
#define FILE_COPY_BUF_SIZE 512

#include <stdio.h>
#include "fb.h"

/*:::::*/
int fb_DrvFileCopy( const char *source, const char *destination )
{
	FILE *src, *dst = NULL;
	long len;
	size_t bytes_to_copy;
	char buf[FILE_COPY_BUF_SIZE];
	
	src = fopen(source, "rb");
	
	if (!src)
		goto err;
	
	fseek(src, 0, SEEK_END);
	len = ftell(src);
	fseek(src, 0, SEEK_SET);
	
	dst = fopen(destination, "wb");
	
	if (!dst)
		goto err;
	
	while (len > 0) {
		if (len >= FILE_COPY_BUF_SIZE)
			bytes_to_copy = FILE_COPY_BUF_SIZE;
		else
			bytes_to_copy = len;
		
		if (fread( buf, 1, bytes_to_copy, src ) != bytes_to_copy)
			goto err;
		
		if (fwrite( buf, 1, bytes_to_copy, dst ) != bytes_to_copy)
			goto err;
		
		len -= bytes_to_copy;
	}
	
	fclose( src );
	fclose( dst );
	
	return fb_ErrorSetNum( FB_RTERROR_OK );
	
err:
	
	if (src) fclose( src );
	if (dst) fclose( dst );
	
	return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
	
}
