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
 *       dec/2004 all functions called by FB are now in different modules [v1ctor]
 *
 */

#include <malloc.h>
#include <string.h>
#include "fb.h"

/* globals */
FBSTRING fb_strNullDesc = { NULL, 0 };

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
void fb_hStrRealloc( FBSTRING *str, int size, int preserve )
{
#define FB_STR_REALSIZE(v) (((v) + 31) & ~31)

	int realsize = FB_STR_REALSIZE( FB_STRSIZE( str ) );

	if( str->data == NULL || realsize == 0 || size > realsize )
	{
		if( preserve == FB_FALSE )
		{
			fb_StrDelete( str );
			str->data = (char *)malloc( FB_STR_REALSIZE( size ) + 1 );
		}
		else
			str->data = (char *)realloc( str->data, FB_STR_REALSIZE( size ) + 1 );

		if( str->data == NULL )
			return;
	}

	str->len  = size;

}

/*:::::*/
void fb_hStrAllocTemp( FBSTRING *str, int size )
{
	fb_hStrRealloc( str, size, FB_FALSE );

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
void fb_hStrCopy( char *dst, char *src, int bytes )
{
	int i;

	if( (src != NULL) && (bytes > 0 ) )
	{
		/* words */
		for( i = 0; i < (bytes >> 2); i++ )
		{
			*(unsigned int *)dst = *(unsigned int *)src;
			src += sizeof(unsigned int);
			dst += sizeof(unsigned int);
		}

		/* remainder */
		for( i = 0; i < (bytes & 3); i++ )
			*dst++ = *src++;
	}

	*dst = '\0';
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

