/* Array bound checking functions */

#include "fb.h"

static void *hThrowError
	(
		int errnum,
		ssize_t idx,
		ssize_t lbound,
		ssize_t ubound,
		int linenum,
		const char *filename,
		const char *variablename
	)
{
	int pos = 0;
	char msg[FB_ERRMSG_SIZE];

	pos += snprintf( &msg[pos], FB_ERRMSG_SIZE - pos, "\n" );

	if( variablename ) {
		pos += snprintf( &msg[pos], FB_ERRMSG_SIZE - pos,
			"'%s' ", variablename );
	} else {
		pos += snprintf( &msg[pos], FB_ERRMSG_SIZE - pos,
			"array " );
	}

	if( errnum == FB_RTERROR_NOTDIMENSIONED ) {
		pos += snprintf( &msg[pos], FB_ERRMSG_SIZE - pos,
			"not dimensioned and array elements are not allocated" );
	} else if( errnum == FB_RTERROR_WRONGDIMENSIONS ) {
		pos += snprintf( &msg[pos], FB_ERRMSG_SIZE - pos,
			"accessed with wrong number of dimensions, %" FB_LL_FMTMOD "d given but expected %" FB_LL_FMTMOD "d",
			(long long int)idx, (long long int)ubound);
	} else {
		pos += snprintf( &msg[pos], FB_ERRMSG_SIZE - pos,
			"accessed with invalid index = %" FB_LL_FMTMOD "d, must be between %" FB_LL_FMTMOD "d and %" FB_LL_FMTMOD "d",
			(long long int)idx, (long long int)lbound, (long long int)ubound);
	}
	msg[FB_ERRMSG_SIZE-1] = '\0';

	/* call user handler if any defined */
	return (void *)fb_ErrorThrowMsg( errnum, linenum, filename, msg, NULL, NULL );
}

FBCALL void *fb_ArrayDimensionChk
	( 
		ssize_t dimensions,
		FBARRAY *array,
		int linenum,
		const char *filename,
		const char *variablename
	)
{
	/* unallocated array */
	if( (array == NULL) || (array->data == NULL) ) {
		return hThrowError( FB_RTERROR_NOTDIMENSIONED,
			0, 0, 0, linenum, filename, variablename );
	}

	/* wrong number of dimensions? */
	if( ((size_t)dimensions != array->dimensions) ) {
		return hThrowError( FB_RTERROR_WRONGDIMENSIONS,
			dimensions, 0, array->dimensions, linenum, filename, variablename );
	}

	return NULL;
}

FBCALL void *fb_ArrayBoundChkEx
	(
		ssize_t idx,
		ssize_t lbound,
		ssize_t ubound,
		int linenum,
		const char *filename,
		const char *variablename
	)
{
	if( (idx < lbound) || (idx > ubound) ) {
		return hThrowError( FB_RTERROR_OUTOFBOUNDS, idx, lbound, ubound, linenum, filename, variablename );
	} else {
		return NULL;
	}
}

FBCALL void *fb_ArraySngBoundChkEx
	(
		size_t idx,
		size_t ubound,
		int linenum,
		const char *filename,
		const char *variablename
	)
{
	/* Assuming lbound is 0, we know ubound must be >= 0, and we can treat
	   index as unsigned too, possibly letting it overflow to a very big
	   value (if it was negative), reducing the bound check to a single
	   unsigned comparison. */

	if( idx > ubound ) {
		return hThrowError( FB_RTERROR_OUTOFBOUNDS, idx, 0, ubound, linenum, filename, variablename );
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
		const char *filename
	)
{
	return fb_ArrayBoundChkEx( idx, lbound, ubound, linenum, filename, NULL );
}

FBCALL void *fb_ArraySngBoundChk
	(
		size_t idx,
		size_t ubound,
		int linenum,
		const char *filename
	)
{
	return fb_ArraySngBoundChkEx( idx, ubound, linenum, filename, NULL );
}
