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
 * error - runtime error handling, set & get
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include "fb.h"
#include "fb_rterr.h"


/*:::::*/
FBCALL int fb_ErrorGetNum ( void )
{

	return (int)FB_TLSGET( fb_errctx.num );

}

/*:::::*/
FBCALL int fb_ErrorSetNum ( int errnum )
{

	FB_TLSSET( fb_errctx.num, errnum );

	return errnum;

}

/*:::::*/
FBCALL int fb_ErrorGetLineNum ( void )
{

	return (int)FB_TLSGET( fb_errctx.linenum );

}
