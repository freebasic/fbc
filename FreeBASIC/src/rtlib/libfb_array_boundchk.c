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
 * array_boundchk.c -- bound checking functions
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include "fb.h"
#include "fb_rterr.h"

/*:::::*/
static void hThrowError( int linenum )
{
	FB_ERRHANDLER handler;
	
	/* call user handler if any defined */
	handler = fb_ErrorThrowEx( FB_RTERROR_OUTOFBOUNDS, linenum, NULL, NULL );
	if( handler != NULL )
		handler( );

	/* if the user handler returned, exit */
	fb_End( FB_RTERROR_OUTOFBOUNDS );
}

/*:::::*/
FBCALL void fb_ArrayBoundChk( int idx, int lbound, int ubound, int linenum )
{
	if( (idx < lbound) || (idx > ubound) )
		hThrowError( linenum );
}

/*:::::*/
FBCALL void fb_ArraySngBoundChk( unsigned int idx, unsigned int ubound, int linenum )
{
	if( idx > ubound )
		hThrowError( linenum );
}
