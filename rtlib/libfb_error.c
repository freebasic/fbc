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


typedef struct _FB_ERRORCTX {
	void 	*handler;
	int		num;
	void 	*reslbl;
	void 	*resnxtlbl;
} FB_ERRORCTX;

/* FIXME: not thread safe */
static FB_ERRORCTX ctx = { NULL, FB_RTERROR_OK, NULL, NULL };

/*:::::*/
static void fb_Die( int errnum )
{
	printf( "\nRuntime error: %d\n", errnum );

	fb_End( errnum );
}

/*:::::*/
void *fb_ErrorThrow ( int errnum, void *res_label, void *resnext_label )
{

    if( ctx.handler != NULL )
    {
    	ctx.num 		= errnum;
    	ctx.reslbl 		= res_label;
    	ctx.resnxtlbl 	= resnext_label;

    	return ctx.handler;
    }

	/* if no user handler defined, die */
	fb_Die( errnum );

}

/*:::::*/
FBCALL void *fb_ErrorSetHandler ( void *newhandler )
{
	void *oldhandler;

    oldhandler = ctx.handler;

    ctx.handler = newhandler;

	return oldhandler;
}

/*:::::*/
FBCALL int fb_ErrorGetNum ( void )
{

	return ctx.num;

}


/*:::::*/
FBCALL void fb_ErrorSetNum ( int errnum )
{

	ctx.num = errnum;

}

/*:::::*/
void *fb_ErrorResume ( void )
{
    void *label = ctx.reslbl;

	/* not defined? die */
	if( label == NULL )
		fb_Die( FB_RTERROR_ILLEGALRESUME );

	/* don't loop forever */
	ctx.reslbl 		= NULL;
	ctx.resnxtlbl 	= NULL;

	return label;

}

/*:::::*/
void *fb_ErrorResumeNext ( void )
{
    void *label = ctx.resnxtlbl;

	/* not defined? die */
	if( label == NULL )
		fb_Die( FB_RTERROR_ILLEGALRESUME );

	/* don't loop forever */
	ctx.reslbl 		= NULL;
	ctx.resnxtlbl 	= NULL;

	return label;

}

