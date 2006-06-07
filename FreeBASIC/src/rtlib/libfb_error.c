/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2006 Andre V. T. Vicentini (av1ctor@yahoo.com.br) and
 *  the FreeBASIC development team.
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

static char error_buffer[FB_ERROR_MESSAGE_SIZE];
static const char *error_msg[] = {
	"",									/* FB_RTERROR_OK */
	"illegal function call",			/* FB_RTERROR_ILLEGALFUNCTIONCALL */
	"file not found",					/* FB_RTERROR_FILENOTFOUND */
	"file I/O error",					/* FB_RTERROR_FILEIO */
	"out of memory",					/* FB_RTERROR_OUTOFMEM */
	"illegal resume",					/* FB_RTERROR_ILLEGALRESUME */
	"out of bounds array access",		/* FB_RTERROR_OUTOFBOUNDS */
	"null pointer access",				/* FB_RTERROR_NULLPTR */
	"no priviledges",					/* FB_RTERROR_NOPRIVILEDGES */
	"\"interrupted\" signal",
	"\"illegal instruction\" signal",
	"\"floating point error\" signal",
	"\"segmentation violation\" signal",
	"\"termination request\" signal",
	"\"abnormal termination\" signal",
	"\"quit request\" signal"
};

/*:::::*/
static void fb_Die
	( 
		int err_num, 
		int line_num, 
		const char *fun_name 
	)
{
	int pos = 0;
	
	pos += snprintf( &error_buffer[pos], FB_ERROR_MESSAGE_SIZE - pos,
					 FB_NEWLINE "Aborting due to runtime error %d", err_num );

	if( (err_num >= 0) && (err_num < FB_RTERROR_MAX) )
		pos += snprintf( &error_buffer[pos], FB_ERROR_MESSAGE_SIZE - pos,
						 " (%s)", error_msg[err_num] );

	if( line_num > 0 )
		pos += snprintf( &error_buffer[pos], FB_ERROR_MESSAGE_SIZE - pos,
						 " at line %d", line_num );

	if( fun_name != NULL )
	    pos += snprintf( &error_buffer[pos], FB_ERROR_MESSAGE_SIZE - pos,
	    				 " of %s" FB_NEWLINE FB_NEWLINE, fun_name );
	else
		pos += snprintf( &error_buffer[pos], FB_ERROR_MESSAGE_SIZE - pos, FB_NEWLINE FB_NEWLINE );
	
	error_buffer[FB_ERROR_MESSAGE_SIZE-1] = '\0';
	
	/* save buffer so we can show message after console is cleaned up */
	fb_error_message = error_buffer;

	fb_End( err_num );
}

/*:::::*/
FB_ERRHANDLER fb_ErrorThrowEx 
	( 
		int err_num, 
		int line_num, 
		const char *fun_name,
		void *res_label, 
		void *resnext_label 
	)
{
    FB_ERRORCTX *ctx = FB_TLSGETCTX( ERROR );

    if( ctx->handler )
    {
    	ctx->err_num = err_num;
    	ctx->line_num = line_num;
    	if( fun_name != NULL ) 
    		ctx->fun_name = fun_name;
    	ctx->res_lbl = res_label;
    	ctx->resnxt_lbl = resnext_label;

    	return ctx->handler;
    }

	/* if no user handler defined, die */
	fb_Die( err_num, line_num, (fun_name != NULL? fun_name: ctx->fun_name) );

	return NULL;
}

/*:::::*/
FB_ERRHANDLER fb_ErrorThrowAt 
	( 
		int line_num, 
		const char *fun_name,
		void *res_label, 
		void *resnext_label 
	)
{
	FB_ERRORCTX *ctx = FB_TLSGETCTX( ERROR );

	return fb_ErrorThrowEx( ctx->err_num, line_num, fun_name, res_label, resnext_label );

}

/*:::::*/
FBCALL FB_ERRHANDLER fb_ErrorSetHandler 
	( 
		FB_ERRHANDLER newhandler 
	)
{
	FB_ERRORCTX *ctx = FB_TLSGETCTX( ERROR );
	FB_ERRHANDLER oldhandler;

    oldhandler = ctx->handler;

    ctx->handler = newhandler;

	return oldhandler;
}

/*:::::*/
void *fb_ErrorResume 
	( 
		void 
	)
{
    FB_ERRORCTX *ctx = FB_TLSGETCTX( ERROR );
    void *label = ctx->res_lbl;

	/* not defined? die */
	if( label == NULL )
		fb_Die( FB_RTERROR_ILLEGALRESUME, -1, NULL );

	/* don't loop forever */
	ctx->res_lbl = NULL;
	ctx->resnxt_lbl = NULL;

	return label;
}

/*:::::*/
void *fb_ErrorResumeNext 
	( 
		void 
	)
{
    FB_ERRORCTX *ctx = FB_TLSGETCTX( ERROR );
    void *label = ctx->resnxt_lbl;

	/* not defined? die */
	if( label == NULL )
		fb_Die( FB_RTERROR_ILLEGALRESUME, -1, NULL );

	/* don't loop forever */
	ctx->res_lbl = NULL;
	ctx->resnxt_lbl = NULL;

	return label;
}

