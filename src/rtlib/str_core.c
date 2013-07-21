/* string/descriptor allocation, deletion, assignament, etc
 *
 * string is interpreted depending on the size argument passed:
 * -1 = var-len
 *  0 = fixed-len, size unknown (ie, returned from a non-FB function)
 * >0 = fixed-len, size known (this size isn't used tho, as string will
 *      have garbage after the null-term, ie: spaces)
 *      destine string size can't be 0, as it is always known
 */

#include "fb.h"
#include <stddef.h>

/**********
 * temp string descriptors (string lock is assumed to be held in the thread-safe rlib version)
 **********/

static FB_LIST tmpdsList = { 0, NULL, NULL, NULL };

static FB_STR_TMPDESC fb_tmpdsTB[FB_STR_TMPDESCRIPTORS];

FBCALL FBSTRING *fb_hStrAllocTmpDesc( void )
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

static void fb_hStrFreeTmpDesc( FB_STR_TMPDESC *dsc )
{
	fb_hListFreeElem( &tmpdsList,  &dsc->elem );

	/*  */
	dsc->desc.data = NULL;
	dsc->desc.len  = 0;
	dsc->desc.size = 0;
}

FBCALL int fb_hStrDelTempDesc( FBSTRING *str )
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

FBCALL FBSTRING *fb_hStrAlloc( FBSTRING *str, ssize_t size )
{
	ssize_t newsize = hStrRoundSize( size );

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

FBCALL FBSTRING *fb_hStrRealloc( FBSTRING *str, ssize_t size, int preserve )
{
	ssize_t newsize = hStrRoundSize( size );
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

FBCALL FBSTRING *fb_hStrAllocTemp_NoLock( FBSTRING *str, ssize_t size )
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

FBCALL FBSTRING *fb_hStrAllocTemp( FBSTRING *str, ssize_t size )
{
    FBSTRING *res;

    FB_STRLOCK( );

    res = fb_hStrAllocTemp_NoLock( str, size );

    FB_STRUNLOCK( );

    return res;
}

FBCALL int fb_hStrDelTemp_NoLock( FBSTRING *str )
{
	if( str == NULL )
		return -1;

	/* is it really a temp? */
	if( FB_ISTEMP( str ) )
        fb_StrDelete( str );

    /* del descriptor (must be done by last as it will be cleared) */
    return fb_hStrDelTempDesc( str );
}

FBCALL int fb_hStrDelTemp( FBSTRING *str )
{
	int res;

	FB_STRLOCK( );

	res = fb_hStrDelTemp_NoLock( str );

	FB_STRUNLOCK( );

	return res;
}

FBCALL void fb_hStrCopy( char *dst, const char *src, ssize_t bytes )
{
    if( (src != NULL) && (bytes > 0) )
    {
        dst = (char *) FB_MEMCPYX( dst, src, bytes );
    }

    /* add the null-term */
    *dst = 0;
}
