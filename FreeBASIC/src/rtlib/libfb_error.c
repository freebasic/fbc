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
	"",									/* FB_RTERROR_OK */
	"illegal function call",			/* FB_RTERROR_ILLEGALFUNCTIONCALL */
	"file not found",					/* FB_RTERROR_FILENOTFOUND */
	"file I/O error",					/* FB_RTERROR_FILEIO */
	"out of memory",					/* FB_RTERROR_OUTOFMEM */
	"illegal resume",					/* FB_RTERROR_ILLEGALRESUME */
	"out of bounds array access",		/* FB_RTERROR_OUTOFBOUNDS */
	"null pointer access",				/* FB_RTERROR_NULLPTR */
	"\"interrupted\" signal",
	"\"illegal instruction\" signal",
	"\"floating point error\" signal",
	"\"segmentation violation\" signal",
	"\"termination request\" signal",
	"\"abnormal termination\" signal",
	"\"quit request\" signal"
};

/*:::::*/
static void fb_Die( int errnum, int linenum )
{
	printf( FB_NEWLINE "Aborting due to runtime error %d", errnum );

	if( (errnum >= 0) && (errnum < FB_RTERROR_MAX) )
		printf( " (%s)", error_msg[errnum] );

	if( linenum > 0 )
		printf( " at line: %d" FB_NEWLINE, linenum );
	else
		printf( FB_NEWLINE );

	fb_End( errnum );
}

/*:::::*/
FB_ERRHANDLER fb_ErrorThrowEx ( int errnum, int linenum, void *res_label, void *resnext_label )
{

    if( FB_TLSGET( fb_errctx.handler ) )
    {
    	FB_TLSSET( fb_errctx.num, errnum );
    	FB_TLSSET( fb_errctx.linenum, linenum );
    	FB_TLSSET( fb_errctx.reslbl, res_label );
    	FB_TLSSET( fb_errctx.resnxtlbl, resnext_label );

    	return (FB_ERRHANDLER)FB_TLSGET( fb_errctx.handler );
    }

	/* if no user handler defined, die */
	fb_Die( errnum, linenum );

	return NULL;
}

/*:::::*/
FB_ERRHANDLER fb_ErrorThrow ( int linenum, void *res_label, void *resnext_label )
{

	return fb_ErrorThrowEx( (int)FB_TLSGET( fb_errctx.num ), linenum, res_label, resnext_label );

}

/*:::::*/
FBCALL FB_ERRHANDLER fb_ErrorSetHandler ( FB_ERRHANDLER newhandler )
{
	FB_ERRHANDLER oldhandler;

    oldhandler = (FB_ERRHANDLER)FB_TLSGET( fb_errctx.handler );

    FB_TLSSET( fb_errctx.handler, newhandler );

	return oldhandler;
}

/*:::::*/
void *fb_ErrorResume ( void )
{
    void *label = (void *)FB_TLSGET( fb_errctx.reslbl );

	/* not defined? die */
	if( label == NULL )
		fb_Die( FB_RTERROR_ILLEGALRESUME, -1 );

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
		fb_Die( FB_RTERROR_ILLEGALRESUME, -1 );

	/* don't loop forever */
	FB_TLSSET( fb_errctx.reslbl, NULL );
	FB_TLSSET( fb_errctx.resnxtlbl, NULL );

	return label;
}

