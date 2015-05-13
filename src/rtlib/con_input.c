/* input function */

#include "fb.h"

FBCALL int fb_ConsoleInput( FBSTRING *text, int addquestion, int addnewline )
{
	FB_INPUTCTX *ctx;
	int res;

	fb_DevScrnInit_Read( );

	if( fb_IsRedirected( TRUE ) )
	{
		/* del if temp */
		fb_hStrDelTemp( text );

		return fb_FileInput( 0 );
	}

    ctx = FB_TLSGETCTX( INPUT );

	fb_StrDelete( &ctx->str );
	ctx->handle = 0;
	ctx->status = 0;
	ctx->index = 0;

	res = fb_LineInput( text, &ctx->str, -1, 0, addquestion, addnewline );

	return res;
}
