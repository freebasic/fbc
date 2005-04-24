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
 *	error - runtime error handling
 *
 * chng: oct/2004 written [v1ctor]
 *       jan/2005 resume support added [v1ctor]
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include "fb.h"
#include "fb_rterr.h"

static const char *error_msg[] = {
	"",				/* FB_RTERROR_OK */
	"illegal function call",	/* FB_RTERROR_ILLEGALFUNCTIONCALL */
	"file not found",		/* FB_RTERROR_FILENOTFOUND */
	"file I/O error",		/* FB_RTERROR_FILEIO */
	"out of memory",		/* FB_RTERROR_OUTOFMEM */
	"illegal resume"		/* FB_RTERROR_ILLEGALRESUME */
};

/*:::::*/
static void fb_Die( int errnum )
{
	printf( FB_NEWLINE "Aborting program due to runtime error %d", errnum );
	if( (errnum < 0) || (errnum >= FB_RTERROR_MAX) )
		printf( FB_NEWLINE );
	else
		printf( " (%s)" FB_NEWLINE, error_msg[errnum] );

	fb_End( errnum );
}

/*:::::*/
void *fb_ErrorThrowEx ( int errnum, void *res_label, void *resnext_label )
{

    if( FB_TLSGET( fb_errctx.handler ) )
    {
    	FB_TLSSET( fb_errctx.num, errnum );
    	FB_TLSSET( fb_errctx.reslbl, res_label );
    	FB_TLSSET( fb_errctx.resnxtlbl, resnext_label );

    	return (void *)FB_TLSGET( fb_errctx.handler );
    }

	/* if no user handler defined, die */
	fb_Die( errnum );

	return NULL;
}

/*:::::*/
void *fb_ErrorThrow ( void *res_label, void *resnext_label )
{

	return fb_ErrorThrowEx( (int)FB_TLSGET( fb_errctx.num ), res_label, resnext_label );

}

/*:::::*/
FBCALL void *fb_ErrorSetHandler ( void *newhandler )
{
	void *oldhandler;

    oldhandler = (void *)FB_TLSGET( fb_errctx.handler );

    FB_TLSSET( fb_errctx.handler, newhandler );

	return oldhandler;
}

/*:::::*/
void *fb_ErrorResume ( void )
{
    void *label = (void *)FB_TLSGET( fb_errctx.reslbl );

	/* not defined? die */
	if( label == NULL )
		fb_Die( FB_RTERROR_ILLEGALRESUME );

	/* don't loop forever */
	FB_TLSSET( fb_errctx.reslbl, NULL );
	FB_TLSSET( fb_errctx.resnxtlbl, NULL );

	return label;

}

/*:::::*/
void *fb_ErrorResumeNext ( void )
{
    void *label = (void *)FB_TLSGET( fb_errctx.resnxtlbl );

	/* not defined? die */
	if( label == NULL )
		fb_Die( FB_RTERROR_ILLEGALRESUME );

	/* don't loop forever */
	FB_TLSSET( fb_errctx.reslbl, NULL );
	FB_TLSSET( fb_errctx.resnxtlbl, NULL );

	return label;

}

