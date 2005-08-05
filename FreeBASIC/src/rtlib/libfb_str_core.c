/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2005 Andre V. T. Vicentini (av1ctor@yahoo.com.br) and others.
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
 * str_core.c -- string/descriptor allocation, deletion, assignament, etc
 *
 * obs.: string is interpreted depending on the size argument passed:
 *		 -1 = var-len
 *		  0 = fixed-len, size unknown (ie, returned from a non-FB function)
 *		 >0 = fixed-len, size known (this size isn't used tho, as string will
 *									 have garbage after the null-term, ie: spaces)
 *		 destine string size can't be 0, as it is always known
 *
 * chng: oct/2004 written [v1ctor]
 *       dec/2004 all functions called by FB are now in different modules [v1ctor]
 *       feb/2005 modified to use the generic list routines [lillo]
 *
 */

#include <malloc.h>
#include <string.h>
#include <stddef.h>
#include "fb.h"

/**********
 * temp string descriptors
 **********/

static FB_LIST tmpdsList = { 0 };

static FB_STR_TMPDESC fb_tmpdsTB[FB_STR_TMPDESCRIPTORS];

/*:::::*/
FB_STR_TMPDESC *fb_hStrAllocTmpDesc( void )
{
	FB_STR_TMPDESC *dsc;
	char *addr;

	if( (tmpdsList.fhead == NULL) && (tmpdsList.head == NULL) )
		fb_hListInit( &tmpdsList, (void *)((char *)fb_tmpdsTB + offsetof( FB_STR_TMPDESC, elem )), 
					  sizeof(FB_STR_TMPDESC), FB_STR_TMPDESCRIPTORS );

	addr = (char *)fb_hListAllocElem( &tmpdsList );
	if( addr == NULL )
		return NULL;

	dsc = (FB_STR_TMPDESC *)( addr - offsetof( FB_STR_TMPDESC, elem ) );
	
	/*  */
	dsc->desc.data = NULL;
	dsc->desc.len  = 0;
	dsc->desc.size = 0;

	return dsc;
}

/*:::::*/
void fb_hStrFreeTmpDesc( FB_STR_TMPDESC *dsc )
{
	fb_hListFreeElem( &tmpdsList, (FB_LISTELEM *)((char *)dsc + offsetof( FB_STR_TMPDESC, elem )) );
	
	/*  */
	dsc->desc.data = NULL;
	dsc->desc.len  = 0;
	dsc->desc.size = 0;
}

/*:::::*/
int fb_hStrDelTempDesc( FBSTRING *str )
{
	/* is this really a temp descriptor? */
	if( ((FB_STR_TMPDESC *)str < &fb_tmpdsTB[0]) ||
	    ((FB_STR_TMPDESC *)str > &fb_tmpdsTB[FB_STR_TMPDESCRIPTORS-1]) )
		return -1;

	fb_hStrFreeTmpDesc( (FB_STR_TMPDESC *)str );
	return 0;
}

/**********
 * internal helper routines (these assume the string lock to be already held when called)
 **********/

/*:::::*/
void fb_hStrRealloc( FBSTRING *str, int size, int preserve )
{
	int newsize;

	newsize = (size + 31) & ~31;			/* alloc every 32-bytes */
	newsize += (newsize >> 3);				/* plus 12.5% more */

	if( (str->data == NULL) || (size > str->size) || (newsize < (str->size - (str->size >> 3))) )
	{
		if( preserve == FB_FALSE )
		{
#ifdef MULTITHREADED
			fb_hStrDeleteLocked( str );
#else
			fb_StrDelete( str );
#endif

			str->data = (char *)malloc( newsize + 1 );
			/* failed? try the original request */
			if( str->data == NULL )
			{
				str->data = (char *)malloc( size + 1 );
				newsize = size;
			}
		}
		else
		{
			str->data = (char *)realloc( str->data, newsize + 1 );
			/* failed? try the original request */
			if( str->data == NULL )
			{
				str->data = (char *)realloc( str->data, size + 1 );
				newsize = size;
			}
		}

		if( str->data == NULL )
		{
			str->size = str->len = 0;
			return;
		}

		str->size = newsize;
	}

	str->len = size;
}

/*:::::*/
void fb_hStrAllocTemp( FBSTRING *str, int size )
{
	fb_hStrRealloc( str, size, FB_FALSE );

	str->len |= FB_TEMPSTRBIT;
}

/*:::::*/
int fb_hStrDelTemp( FBSTRING *str )
{
	if( str == NULL )
		return -1;

	/* is it really a temp? */
	if( !FB_ISTEMP( str ) )
	{
		/* even not being a temp, the desc can be */
		return fb_hStrDelTempDesc( str );
	}

    /* del data */
#ifdef MULTITHREADED
	fb_hStrDeleteLocked( str );
#else
    fb_StrDelete( str );
#endif

    /* del descriptor (must be done by last as it will be cleared) */
    return fb_hStrDelTempDesc( str );
}

/*:::::*/
void fb_hStrCopy( char *dst, const char *src, int bytes )
{
    if( (src != NULL) && (bytes > 0 ) ) {
        dst = FB_MEMCPYX( dst, src, bytes );
    }
    *dst = 0;
}


/*:::::*/
char *fb_hStrSkipChar( char *s, int len, int c )
{
	char *p = s;

	if( s != NULL )
		while( (--len >= 0) && ((int)*p == c) )
			++p;

    return p;
}

/*:::::*/
char *fb_hStrSkipCharRev( char *s, int len, int c )
{
	char *p;

	if( (s == NULL) || (len <= 0) )
		return s;

	p = &s[len-1];

	while( (--len >= 0) && (((int)*p == c) || ((int)*p == 0)) )	/* strip nulls too */
		--p;

    return p;
}

