/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2011 The FreeBASIC development team.
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
 * gosub.c -- GOSUB support
 *
 * chng: apr/2008 written [jeffm]
 *
 */

#include <stdlib.h>
#include <setjmp.h>
#include "fb.h"

/* slow but easy to manage dynamic GOSUB call-stack */
struct gosubnode
{
	jmp_buf buf;
	struct gosubnode *next;
}; 
typedef struct gosubnode GOSUBNODE;

/* the gosub context allocated in auto-local storage by the compiler */
struct gosubctx
{
	GOSUBNODE *top;
};
typedef struct gosubctx GOSUBCTX;

/*
	NOTES:
		On the compiler side, GOSUBCTX is an ANY PTR.  To extend 
		GOSUBCTX, the compiler must allocate additional	space for 
		the GOSUBCTX pseudo-object.

		GOSUBCTX does not have a constructor, but it is expected that
		the compiler will initialize the variable to zero.

		See ast-gosub.bas::astGosubAddInit()
*/


/*:::::*/
FBCALL void * fb_GosubPush( GOSUBCTX * ctx )
{
	GOSUBNODE *node = malloc( sizeof( GOSUBNODE ) );
	node->next = ctx->top;
	ctx->top = node;

	/* returns address of ctx->top->buf	*/
	return &(ctx->top->buf);
}

/*:::::*/
FBCALL int fb_GosubPop( GOSUBCTX * ctx )
{
	if( ctx && ctx->top )
	{
		GOSUBNODE *node = ctx->top->next;
		free(ctx->top);
		ctx->top = node;

		/* return success */
		return fb_ErrorSetNum( FB_RTERROR_OK );
	}

	/* don't know where to go next so return an error */
	return fb_ErrorSetNum( FB_RTERROR_RETURNWITHOUTGOSUB );
}

/*:::::*/
FBCALL int fb_GosubReturn( GOSUBCTX * ctx )
{
	if( ctx && ctx->top )
	{
		GOSUBNODE *node = ctx->top->next;
		
		/* TODO: with a different stack allocation strategy, this
		 * temporary copy won't be needed */
		jmp_buf buf;
		FB_MEMCPY( buf, ctx->top->buf, sizeof(jmp_buf));

		free(ctx->top);
		ctx->top = node;

		longjmp( buf, -1 );
	}

	/* don't know where to go next so return an error */
	return fb_ErrorSetNum( FB_RTERROR_RETURNWITHOUTGOSUB );
}

/*:::::*/
FBCALL void fb_GosubExit( GOSUBCTX * ctx )
{
	if( ctx )
	{
		while( ctx->top )
		{
			GOSUBNODE *node = ctx->top->next;
			free(ctx->top);
			ctx->top = node;
		}
	}
}
