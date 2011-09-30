/* null pointer checking function */

#include "fb.h"

/*:::::*/
FBCALL void *fb_NullPtrChk( void *ptr, int linenum, const char *fname )
{
	if( ptr == NULL )
		return (void *)fb_ErrorThrowEx( FB_RTERROR_NULLPTR, linenum, fname, NULL, NULL );
	else
		return NULL;
}
