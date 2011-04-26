/*
 * sys_getexepath.c -- get the executable path for Windows
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <string.h>
#include "fb.h"

/*:::::*/
char *fb_hGetExePath( char *dst, int maxlen )
{
	char *p;

	GetModuleFileName( GetModuleHandle( NULL ), dst, maxlen );

	p = strrchr( dst, '\\' );
	if( p != NULL )
		*p = '\0';
	else
		dst[0] = '\0';

	return p;
}
