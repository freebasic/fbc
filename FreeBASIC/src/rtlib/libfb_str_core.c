/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2010 The FreeBASIC development team.
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
 *
 *  As a special exception, the copyright holders of this library give
 *  you permission to link this library with independent modules to
 *  produce an executable, regardless of the license terms of these
 *  independent modules, and to copy and distribute the resulting
 *  executable under terms of your choice, provided that you also meet,
 *  for each linked independent module, the terms and conditions of the
 *  license of that module. An independent module is a module which is
 *  not derived from or based on this library. If you modify this library,
 *  you may extend this exception to your version of the library, but
 *  you are not obligated to do so. If you do not wish to do so, delete
 *  this exception statement from your version.
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

#include <stdlib.h>
#include <string.h>
#include <stddef.h>
#include "fb.h"

/**********
 * temp string descriptors (string lock is assumed to be held in the thread-safe rlib version)
 **********/

static FB_LIST tmpdsList = { 0 };

static FB_STR_TMPDESC fb_tmpdsTB[FB_STR_TMPDESCRIPTORS];

/*:::::*/
FBCALL FBSTRING *fb_hStrAllocTmpDesc
	( 
		void 
	)
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
FBCALL void fb_hStrFreeTmpDesc( FB_STR_TMPDESC *dsc )
{
	fb_hListFreeElem( &tmpdsList,  &dsc->elem );

	/*  */
	dsc->desc.data = NULL;
	dsc->desc.len  = 0;
	dsc->desc.size = 0;
}

/*:::::*/
FBCALL int fb_hStrDelTempDesc
	( 
		FBSTRING *str 
	)
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
 * internal helper routines
 **********/

/* alloc every 32-bytes */
#define hStrRoundSize( size ) (((size) + 31) & ~31)

/*:::::*/
FBCALL FBSTRING *fb_hStrAlloc
	( 
		FBSTRING *str, 
		int size 
	)
{
	int newsize = hStrRoundSize( size );
	
	str->data = (char *)malloc( newsize + 1 );
	/* failed? try the original request */
	if( str->data == NULL )
	{
		str->data = (char *)malloc( size + 1 );
		if( str->data == NULL )
    	{
            str->len = str->size = 0;
			return NULL;
		}

		newsize = size;
	}

	str->size = newsize;
	str->len = size;

    return str;
}

/*:::::*/
FBCALL FBSTRING *fb_hStrRealloc
	( 
		FBSTRING *str, 
		int size, 
		int preserve 
	)
{
	int newsize = hStrRoundSize( size );
	/* plus 12.5% more */
	newsize += (newsize >> 3);

	if( (str->data == NULL) ||
	    (size > str->size) ||
	    (newsize < (str->size - (str->size >> 3))) )
	{
		if( preserve == FB_FALSE )
		{
			fb_StrDelete( str );

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
FBCALL FBSTRING *fb_hStrAllocTemp_NoLock
	( 
		FBSTRING *str, 
		int size 
	)
{
    int try_alloc = str==NULL;

    if( try_alloc )
    {
        str = fb_hStrAllocTmpDesc( );
        if( str==NULL )
            return NULL;
    }

    if( fb_hStrRealloc( str, size, FB_FALSE ) == NULL )
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
FBCALL FBSTRING *fb_hStrAllocTemp
	( 
		FBSTRING *str, 
		int size 
	)
{
    FBSTRING *res;

    FB_STRLOCK( );

    res = fb_hStrAllocTemp_NoLock( str, size );

    FB_STRUNLOCK( );

    return res;
}

/*:::::*/
FBCALL int fb_hStrDelTemp_NoLock
	( 
		FBSTRING *str 
	)
{
	if( str == NULL )
		return -1;

	/* is it really a temp? */
	if( FB_ISTEMP( str ) )
        fb_StrDelete( str );

    /* del descriptor (must be done by last as it will be cleared) */
    return fb_hStrDelTempDesc( str );
}

/*:::::*/
FBCALL int fb_hStrDelTemp
	( 
		FBSTRING *str 
	)
{
	int res;

	FB_STRLOCK( );

	res = fb_hStrDelTemp_NoLock( str );

	FB_STRUNLOCK( );

	return res;
}

/*:::::*/
FBCALL void fb_hStrCopy
	( 
		char *dst, 
		const char *src, 
		int bytes 
	)
{
    if( (src != NULL) && (bytes > 0) )
    {
        dst = FB_MEMCPYX( dst, src, bytes );
    }

    /* add the null-term */
    *dst = 0;
}


/*:::::*/
FBCALL char *fb_hStrSkipChar
	( 
		char *s, 
		int len, 
		int c 
	)
{
	char *p = s;

	if( s != NULL )
		while( (--len >= 0) && ((int)*p == c) )
			++p;

    return p;
}

/*:::::*/
FBCALL char *fb_hStrSkipCharRev
	( 
		char *s, 
		int len, 
		int c 
	)
{
	char *p;

	if( (s == NULL) || (len <= 0) )
		return s;

	p = &s[len-1];

    /* fixed-len's are filled with null's as in PB, strip them too */
    while( (--len >= 0) && (((int)*p == c) || ((int)*p == 0) ) )
		--p;

    return p;
}

