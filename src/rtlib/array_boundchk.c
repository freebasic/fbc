/* Array bound checking functions */

#include "fb.h"

static void *hThrowError( int linenum, const char *fname )
{
	/* call user handler if any defined */
    return (void *)fb_ErrorThrowEx( FB_RTERROR_OUTOFBOUNDS, linenum, fname, NULL, NULL );
}

FBCALL void *fb_ArrayBoundChk
	(
		ssize_t idx,
		ssize_t lbound,
		ssize_t ubound,
		int linenum,
		const char *fname
	)
{
	if( (idx < lbound) || (idx > ubound) )
		return hThrowError( linenum, fname );
	else
		return NULL;
}

FBCALL void *fb_ArraySngBoundChk
	(
		size_t idx,
		size_t ubound,
		int linenum,
		const char *fname
	)
{
	/* Assuming lbound is 0, we know ubound must be >= 0, and we can treat
	   index as unsigned too, possibly letting it overflow to a very big
	   value (if it was negative), reducing the bound check to a single
	   unsigned comparison. */
	if( idx > ubound )
		return hThrowError( linenum, fname );
	else
		return NULL;
}
