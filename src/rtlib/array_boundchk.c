/* Array bound checking functions */

#include "fb.h"

static void *hThrowError( fbinteger linenum, const char *fname )
{
	/* call user handler if any defined */
    return (void *)fb_ErrorThrowEx( FB_RTERROR_OUTOFBOUNDS, linenum, fname, NULL, NULL );
}

FBCALL void *fb_ArrayBoundChk
	(
		fbinteger idx,
		fbinteger lbound,
		fbinteger ubound,
		fbinteger linenum,
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
		fbinteger idx,
		fbinteger ubound,
		fbinteger linenum,
		const char *fname
	)
{
	if( idx > ubound )
		return hThrowError( linenum, fname );
	else
		return NULL;
}
