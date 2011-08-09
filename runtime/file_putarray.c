/* put # function for arrays */

#include <stdio.h>
#include <stdlib.h>
#include "fb.h"

/*:::::*/
FBCALL int fb_FilePutArray( int fnum, long pos, FBARRAY *src )
{

	return fb_FilePutData( fnum, pos, src->ptr, src->size, TRUE, FALSE );

}

/*:::::*/
FBCALL int fb_FilePutArrayLarge( int fnum, long long pos, FBARRAY *src )
{

	return fb_FilePutData( fnum, pos, src->ptr, src->size, TRUE, FALSE );

}
