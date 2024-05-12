/* Array bound checking functions */

#include "fb.h"

static void *hThrowError
	(
		ssize_t idx,
		ssize_t lbound,
		ssize_t ubound,
		int linenum,
		const char *fname,
		const char *vname
	)
{
	char msg[FB_ERRMSG_SIZE];
	snprintf( msg, FB_ERRMSG_SIZE,
		"%s -> wrong index = %" FB_LL_FMTMOD "d, lbound = %" FB_LL_FMTMOD "d, ubound = %" FB_LL_FMTMOD "d",
		vname, (long long int)idx, (long long int)lbound, (long long int)ubound);
	msg[FB_ERRMSG_SIZE-1] = '\0';

	/* call user handler if any defined */
	return (void *)fb_ErrorThrowMsg( FB_RTERROR_OUTOFBOUNDS, linenum, fname, msg, NULL, NULL );
}

FBCALL void *fb_ArrayBoundChkEx
	(
		ssize_t idx,
		ssize_t lbound,
		ssize_t ubound,
		int linenum,
		const char *fname,
		const char *vname
	)
{
	if( (idx < lbound) || (idx > ubound) ) {
		return hThrowError( idx, lbound, ubound, linenum, fname, vname );
	} else {
		return NULL;
	}
}

FBCALL void *fb_ArraySngBoundChkEx
	(
		size_t idx,
		size_t ubound,
		int linenum,
		const char *fname,
		const char *vname
	)
{
	/* Assuming lbound is 0, we know ubound must be >= 0, and we can treat
	   index as unsigned too, possibly letting it overflow to a very big
	   value (if it was negative), reducing the bound check to a single
	   unsigned comparison. */

	if( idx > ubound ) {
		return hThrowError( idx, 0, ubound, linenum, fname, vname );
	} else {
		return NULL;
	}
}

/* legacy, before version 1.20.0
** these entry points are needed otherwise it is impossible to
** compile a debug vrsion of newer fbc source from an older fbc
*/
FBCALL void *fb_ArrayBoundChk
	(
		ssize_t idx,
		ssize_t lbound,
		ssize_t ubound,
		int linenum,
		const char *fname
	)
{
	return fb_ArrayBoundChkEx( idx, lbound, ubound, linenum, fname, NULL );
}

FBCALL void *fb_ArraySngBoundChk
	(
		size_t idx,
		size_t ubound,
		int linenum,
		const char *fname
	)
{
	return fb_ArraySngBoundChkEx( idx, ubound, linenum, fname, NULL );
}
