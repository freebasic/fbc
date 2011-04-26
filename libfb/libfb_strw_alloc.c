/*
 * strw_alloc.c -- wstring allocation function
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include "fb.h"

/*:::::*/
FBCALL FB_WCHAR *fb_WstrAlloc ( int chars )
{
	if( chars <= 0 )
		return NULL;

	return fb_wstr_AllocTemp( chars );
}

