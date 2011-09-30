/* Array bound checking functions */

#include "fb.h"

/*:::::*/
static void *hThrowError
	( 
		int linenum, 
		const char *fname 
	)
{
	/* call user handler if any defined */
    return (void *)fb_ErrorThrowEx( FB_RTERROR_OUTOFBOUNDS, linenum, fname, NULL, NULL );
}

/*:::::*/
FBCALL void *fb_ArrayBoundChk
	( 
		int idx, 
		int lbound, 
		int ubound,
		int linenum, 
		const char *fname 
	)
{
	if( (idx < lbound) || (idx > ubound) )
		return hThrowError( linenum, fname );
	else
		return NULL;
}

/*:::::*/
FBCALL void *fb_ArraySngBoundChk
	( 
		unsigned int idx, 
		unsigned int ubound,
		int linenum, 
		const char *fname 
	)
{
	if( idx > ubound )
		return hThrowError( linenum, fname );
	else
		return NULL;
}
