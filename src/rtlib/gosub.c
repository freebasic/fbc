/* GOSUB support */

#include "fb.h"
#include <setjmp.h>

/* slow but easy to manage dynamic GOSUB call-stack */
typedef struct gosubnode {
	jmp_buf buf;
	struct gosubnode *next;
} GOSUBNODE;

/* the gosub context allocated in auto-local storage by the compiler */
typedef struct {
	GOSUBNODE *top;
} GOSUBCTX;

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
