/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2005 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
 *
 *  This library is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU Lesser General Public
 *  License as published by the Free Software Foundation; either
 *  version 2.1 of the License, or (at your option) any later version.
 *
 *  This library is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *  Lesser General Public License for more details.
 *
 *  You should have received a copy of the GNU Lesser General Public
 *  License along with this library; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

/*
 * str_comp.c -- string compare function
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <malloc.h>
#include <string.h>
#include "fb.h"

/*:::::*/
static int fb_hStrComp( const char *str1, int len1, const char *str2, int len2 )
{
    int len, res;
    
    /* min */
    len = (len1 <= len2? len1: len2);

#ifndef TARGET_X86
	for( ; len > 0; len--,str1++,str2++ )
		if( *str1 != *str2 )
			return (*str1 > *str2? 1: -1);
			
#else
		asm (
			"repe\n"
			"cmpsb\n"
			"je 0f\n"
			"movl $1, %%ecx\n"
			"jg 0f\n"
			"neg %%ecx\n"
			"0:\n"
			: "=c" (res)
			: "c" (len), "S" (str1), "D" (str2) );
		
		if( res != 0 ) 
			return res;
#endif

	if( len1 != len2 )
		return (len1 < len2? -1: 1);
	else
		return 0;
}

/*:::::*/
FBCALL int fb_StrCompare ( void *str1, int str1_size, void *str2, int str2_size )
{
	char 	*str1_ptr, *str2_ptr;
	int 	str1_len, str2_len;
	int		res;

	FB_STRLOCK();

	if( (str1 != NULL) && (str2 != NULL) )
	{
		FB_STRSETUP( str1, str1_size, str1_ptr, str1_len )
		FB_STRSETUP( str2, str2_size, str2_ptr, str2_len )

    	res = fb_hStrComp( str1_ptr, str1_len, str2_ptr, str2_len );
	}
	else if( str1 == NULL )
	{
		if( str2 == NULL )
			res = 0;
		else
			res = -1;
	}
	else
		res = 1;
	
	/* delete temps? */
	if( str1_size == -1 )
		fb_hStrDelTemp( (FBSTRING *)str1 );
	if( str2_size == -1 )
		fb_hStrDelTemp( (FBSTRING *)str2 );

	FB_STRUNLOCK();

	return res;
}


