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
FBSTRING *fb_hStrAllocTmpDesc( void )
{
	FB_STR_TMPDESC *dsc;

	if( (tmpdsList.fhead == NULL) && (tmpdsList.head == NULL) )
		fb_hListInit( &tmpdsList, fb_tmpdsTB,
					  sizeof(FB_STR_TMPDESC), FB_STR_TMPDESCRIPTORS );

	dsc = (FB_STR_TMPDESC *)fb_hListAllocElem( &tmpdsList );
	if( dsc == NULL )
		return NULL;

	/*  */
	dsc->desc.data = NULL;
	dsc->desc.len  = 0;
	dsc->desc.size = 0;

	return &dsc->desc;
}

/*:::::*/
void fb_hStrFreeTmpDesc( FB_STR_TMPDESC *dsc )
{
	fb_hListFreeElem( &tmpdsList,  &dsc->elem );

	/*  */
	dsc->desc.data = NULL;
	dsc->desc.len  = 0;
	dsc->desc.size = 0;
}

/*:::::*/
int fb_hStrDelTempDesc( FBSTRING *str )
{
    FB_STR_TMPDESC *item =
        (FB_STR_TMPDESC*) ( (char*)str - offsetof( FB_STR_TMPDESC, desc ) );

    /* is this really a temp descriptor? */
	if( (item < fb_tmpdsTB+0) ||
	    (item > fb_tmpdsTB+FB_STR_TMPDESCRIPTORS-1) )
		return -1;

	fb_hStrFreeTmpDesc( item );
	return 0;
}

/**********
 * internal helper routines (these assume the string lock to be already held when called)
 **********/

/*:::::*/
FBSTRING *fb_hStrRealloc( FBSTRING *str, int size, int preserve )
{
	int newsize;

	newsize = (size + 31) & ~31;			/* alloc every 32-bytes */
    newsize += (newsize >> 3);				/* plus 12.5% more */

	if( (str->data == NULL) ||
	    (size > str->size) ||
	    (newsize < (str->size - (str->size >> 3))) )
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
            char *pszOld = str->data;
			str->data = (char *)realloc( pszOld, newsize + 1 );
			/* failed? try the original request */
			if( str->data == NULL )
			{
				str->data = (char *)realloc( pszOld, size + 1 );
				newsize = size;
                if( str->data == NULL )
                {
                    /* restore the old memory block */
                    str->data = pszOld;
                    return NULL;
                }
            }
		}

		if( str->data == NULL )
        {
            str->len = str->size = 0;
			return NULL;
		}

		str->size = newsize;
	}

	fb_hStrSetLength( str, size );

    return str;
}

/*:::::*/
FBSTRING *fb_hStrAllocTemp( FBSTRING *str, int size )
{
    int try_alloc = str==NULL;

    if( try_alloc )
    {
        str = fb_hStrAllocTmpDesc( );
        if( str==NULL )
            return NULL;
    }

    if( fb_hStrRealloc( str, size, FB_FALSE )==NULL )
    {
        if( try_alloc )
            fb_hStrDelTempDesc( str );
        return NULL;
    }
    else
        str->len |= FB_TEMPSTRBIT;

    return str;
}

/*:::::*/
int fb_hStrDelTemp( FBSTRING *str )
{
	if( str == NULL )
		return -1;

	/* is it really a temp? */
	if( FB_ISTEMP( str ) )
	{
        /* del data */
#ifdef MULTITHREADED
        fb_hStrDeleteLocked( str );
#else
        fb_StrDelete( str );
#endif
    }

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

