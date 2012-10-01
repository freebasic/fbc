/* file copy */

#include "../fb.h"

FBCALL int fb_FileCopy( const char *source, const char *destination )
{
	return fb_CrtFileCopy( source, destination );
}
