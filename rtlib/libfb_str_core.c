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
 *
 */

#include <malloc.h>
#include <string.h>
#include "fb.h"

/* globals */
static char fb_strNull = '\0';

FBSTRING fb_strNullDesc = { &fb_strNull, 0 };

/**********
 * temp string descriptors
 **********/

static FB_STR_TMPDESCLIST tmpdsList = { 0 };

static FB_STR_TMPDESC fb_tmpdsTB[FB_STR_TMPDESCRIPTORS] = { 0 };

/*:::::*/
static void fb_hStrInitTmpDesc( void )
{
    int 			i;
    FB_STR_TMPDESC  *next;

	tmpdsList.head 	= NULL;
	tmpdsList.tail 	= NULL;
	tmpdsList.fhead = &fb_tmpdsTB[0];
	tmpdsList.cnt	= 0;

	for( i = 0; i < FB_STR_TMPDESCRIPTORS; i++ )
	{
    	fb_tmpdsTB[i].data = NULL;
    	fb_tmpdsTB[i].len  = 0;

    	if( i < FB_STR_TMPDESCRIPTORS-1 )
    		next = &fb_tmpdsTB[i+1];
    	else
    		next = NULL;

    	fb_tmpdsTB[i].prev 	= NULL;
    	fb_tmpdsTB[i].next 	= next;
	}
}

/*:::::*/
FB_STR_TMPDESC *fb_hStrAllocTmpDesc( void )
{
	FB_STR_TMPDESC *dsc;

	if( (tmpdsList.fhead == NULL) && (tmpdsList.head == NULL) )
		fb_hStrInitTmpDesc( );

	/* take from free list */
	dsc = tmpdsList.fhead;
	if( dsc == NULL )
		return NULL;

	tmpdsList.fhead = dsc->next;

	/* add to entry used list */
	if( tmpdsList.tail != NULL )
		tmpdsList.tail->next = dsc;
	else
		tmpdsList.head = dsc;

	dsc->prev = tmpdsList.tail;
	dsc->next = NULL;

	tmpdsList.tail = dsc;

	++tmpdsList.cnt;

	/*  */
	dsc->data = NULL;
	dsc->len  = 0;

	return dsc;
}

/*:::::*/
void fb_hStrFreeTmpDesc( FB_STR_TMPDESC *dsc )
{

    /* del from used list */
	if( dsc->prev != NULL )
		dsc->prev->next = dsc->next;
	else
		tmpdsList.head = dsc->next;

	if( dsc->next != NULL )
		dsc->next->prev = dsc->prev;
	else
		tmpdsList.tail = dsc->prev;

	/* add to free list */
	dsc->prev = NULL;
	dsc->next = tmpdsList.fhead;
	tmpdsList.fhead = dsc;

	--tmpdsList.cnt;

	/*  */
	dsc->data = NULL;
	dsc->len  = 0;
}

/*:::::*/
void fb_hStrDelTempDesc( FBSTRING *str )
{
	/* is this really a temp descriptor? */
	if( ((FB_STR_TMPDESC *)str < &fb_tmpdsTB[0]) ||
	    ((FB_STR_TMPDESC *)str > &fb_tmpdsTB[FB_STR_TMPDESCRIPTORS-1]) )
		return ;

	fb_hStrFreeTmpDesc( (FB_STR_TMPDESC *)str );
}

/**********
 * internal helper routines
 **********/

/*:::::*/
void fb_hStrRealloc( FBSTRING *str, int size )
{
	fb_StrDelete( str );

	str->data = (char *)malloc( size + 1 );
	if( str->data == NULL )
		return;
	str->len  = size;
}

/*:::::*/
void fb_hStrAllocTemp( FBSTRING *str, int size )
{
	fb_hStrRealloc( str, size );

	str->len |= FB_TEMPSTRBIT;
}

/*:::::*/
void fb_hStrDelTemp( FBSTRING *str )
{
	if( str == NULL )
		return ;

	/* is it really a temp? */
	if( !FB_ISTEMP( str ) )
	{
		fb_hStrDelTempDesc( str );			/* even not being a temp, the desc can be */
		return;
	}

    fb_StrDelete( str );

    fb_hStrDelTempDesc( str );				/* must be done after Delete, as desc is destroyed */
}

/*:::::*/
int fb_hStrLen ( char *str )
{
	return strlen( str );
}

/*:::::*/
void fb_hStrCopy( char *dst, char *src, int bytes )
{
	if( src != NULL )
		while( --bytes >= 0 )
			*dst++ = *src++;

	*dst = '\0';
}

/*:::::*/
void fb_hStrRevCopy( char *dst, char *src, int bytes )
{
	if( src != NULL )
		while( --bytes >= 0 )
			*dst++ = *src--;

	*dst = '\0';
}

/*:::::*/
static void fb_hStrConcat( char *dst, char *str1, int len1, char *str2, int len2 )
{
	if( str1 != NULL )
		while( --len1 >= 0 )
			*dst++ = *str1++;

	if( str2 != NULL )
		while( --len2 >= 0 )
			*dst++ = *str2++;

	*dst = '\0';
}

/*:::::*/
static int fb_hStrComp( char *str1, int len1, char *str2, int len2 )
{
    int len;

    /* min */
    len = (len1 <= len2? len1: len2);

	for( ; len > 0; len--,str1++,str2++ )
		if( *str1 != *str2 )
			return (*str1 > *str2? 1: -1);

	if( len1 != len2 )
		return (len1 < len2? -1: 1);

	return 0;
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

	while( (--len >= 0) && (((int)*p == c) || ((int)*p == 0)) )	/* hack! strip nulls too */
		--p;

    return p;
}

/**********
 * public routines
 **********/

/*:::::*/
__stdcall void fb_StrDelete ( FBSTRING *str )
{
    if( (str == NULL) || (str->data == NULL) || (str->data == &fb_strNull) )
    	return;

    free( (void *)str->data );

	str->data = NULL;
	str->len  = 0;
}

/*:::::*/
__stdcall int fb_StrLen( void *str, int str_size )
{
	int len;

	if( str == NULL )
		return 0;

	/* is dst var-len? */
	if( str_size == -1 )
	{
		len = FB_STRSIZE( str );

		/* delete temp? */
		fb_hStrDelTemp( (FBSTRING *)str );
	}
	else if( str_size == 0 )
		len = strlen( (char *)str );
	else
		len = str_size;

	return len;
}

/*:::::*/
__stdcall void fb_StrAssign ( void *dst, int dst_size, void *src, int src_size )
{
	FBSTRING 	*dstr;
	char 		*src_ptr;
	int 		src_len, dst_len;

	if( (dst == NULL) || (src == NULL) )
		return;

	/* src */
	FB_STRSETUP( src, src_size, src_ptr, src_len )

	/* is dst var-len? */
	if( dst_size == -1 )
	{
        dstr = (FBSTRING *)dst;

		/* if src is a temp, just copy the descriptor */
		if( (src_size == -1) && FB_ISTEMP(src) )
		{
			fb_StrDelete( dstr );

			dstr->data = src_ptr;
			dstr->len  = src_len;

			((FBSTRING *)src)->data = NULL;
			((FBSTRING *)src)->len  = 0;

			fb_hStrDelTempDesc( (FBSTRING *)src );

			return;
		}

        /* else, realloc dst if needed and copy src */
        dst_len = FB_STRSIZE( dst );

		/* NULL? */
		if( src_len == 0 )
		{
			fb_StrDelete( dstr );
			dstr->data = &fb_strNull;
		}
		else
		{
			if( dst_len != src_len )
				fb_hStrRealloc( dstr, src_len );

			fb_hStrCopy( dstr->data, src_ptr, src_len );
		}
	}
	else
	{
		if( dst_size < src_len )
			src_len = dst_size;

		fb_hStrCopy( (char *)dst, src_ptr, src_len );

		/* fill reminder with null's */
		dst_size -= src_len;
		if( dst_size > 0 )
			memset( &(((char *)dst)[src_len]), 0, dst_size );
	}


	/* delete temp? */
	if( src_size == -1 )
		fb_hStrDelTemp( (FBSTRING *)src );

}

/*:::::*/
__stdcall FBSTRING *fb_StrConcat ( FBSTRING *dst, void *str1, int str1_size, void *str2, int str2_size )
{
	char 	*str1_ptr, *str2_ptr;
	int 	str1_len, str2_len;

	if( (str1 == NULL) || (str1 == NULL) )
		return NULL;

	FB_STRSETUP( str1, str1_size, str1_ptr, str1_len )

	FB_STRSETUP( str2, str2_size, str2_ptr, str2_len )

	/* NULL? */
	if( str1_len+str2_len == 0 )
	{
		fb_StrDelete( dst );
		dst->data = &fb_strNull;
	}
	else
	{
		/* alloc temp string */
		fb_hStrAllocTemp( dst, str1_len+str2_len );

		/* do the concatenation */
		fb_hStrConcat( dst->data, str1_ptr, str1_len, str2_ptr, str2_len );
	}

	/* delete temps? */
	if( str1_size == -1 )
		fb_hStrDelTemp( (FBSTRING *)str1 );
	if( str2_size == -1 )
		fb_hStrDelTemp( (FBSTRING *)str2 );

	return dst;
}

/*:::::*/
__stdcall int fb_StrCompare ( void *str1, int str1_size, void *str2, int str2_size )
{
	char 	*str1_ptr, *str2_ptr;
	int 	str1_len, str2_len;
	int		res;

	if( (str1 == NULL) || (str1 == NULL) )
		return 0;

	FB_STRSETUP( str1, str1_size, str1_ptr, str1_len )
	FB_STRSETUP( str2, str2_size, str2_ptr, str2_len )

    res = fb_hStrComp( str1_ptr, str1_len, str2_ptr, str2_len );

	/* delete temps? */
	if( str1_size == -1 )
		fb_hStrDelTemp( (FBSTRING *)str1 );
	if( str2_size == -1 )
		fb_hStrDelTemp( (FBSTRING *)str2 );

	return res;
}

/*:::::*/
__stdcall FBSTRING *fb_StrAllocTempResult ( FBSTRING *src )
{
 	FB_STR_TMPDESC *dsc;

 	/* alloc a temporary descriptor (the current one at stack will be trashed) */
 	dsc = fb_hStrAllocTmpDesc( );
    if( dsc == NULL )
    	return &fb_strNullDesc;

    /* copy just the descriptor, setting it as a temp string */
    dsc->data = src->data;
    dsc->len  = src->len | FB_TEMPSTRBIT;

	/* just for safety.. */
	src->data = NULL;
	src->len  = 0;

	return (FBSTRING *)dsc;
}

/*:::::*/
__stdcall FBSTRING *fb_StrAllocTempDesc( void *str, int str_size )
{
	FB_STR_TMPDESC 	*dsc;

 	/* alloc a temporary descriptor */
 	dsc = fb_hStrAllocTmpDesc( );
    if( dsc == NULL )
    	return &fb_strNullDesc;

	/* fill it */
	if( str_size == -1 )
	{
		dsc->data = ((FBSTRING *)str)->data;
		dsc->len  = FB_STRSIZE( str );
	}
	else
	{
		dsc->data = (char *)str;
		if( str_size != 0 )
			dsc->len  = str_size;
		else
			dsc->len  = strlen( str );
	}

	return (FBSTRING *)dsc;
}
