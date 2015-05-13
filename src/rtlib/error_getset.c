/* runtime error handling, set & get */

#include "fb.h"

FBCALL int fb_ErrorGetNum( void )
{
	FB_ERRORCTX *ctx = FB_TLSGETCTX( ERROR );
	return ctx->err_num;
}

FBCALL int fb_ErrorSetNum( int err_num )
{
	FB_ERRORCTX *ctx = FB_TLSGETCTX( ERROR );
	ctx->err_num = err_num;
	return err_num;
}

FBCALL int fb_ErrorGetLineNum( void )
{
	FB_ERRORCTX *ctx = FB_TLSGETCTX( ERROR );
	return ctx->line_num;
}

FBCALL const char *fb_ErrorGetModName( void )
{
	FB_ERRORCTX *ctx = FB_TLSGETCTX( ERROR );
	return ctx->mod_name;
}

FBCALL const char *fb_ErrorSetModName( const char *mod_name )
{
	FB_ERRORCTX *ctx = FB_TLSGETCTX( ERROR );
	const char *old_name = ctx->mod_name;
	ctx->mod_name = mod_name;
	return old_name;
}

FBCALL const char *fb_ErrorGetFuncName( void )
{
	FB_ERRORCTX *ctx = FB_TLSGETCTX( ERROR );
	return ctx->fun_name;
}

FBCALL const char *fb_ErrorSetFuncName( const char *fun_name )
{
	FB_ERRORCTX *ctx = FB_TLSGETCTX( ERROR );
	const char *old_name = ctx->fun_name;
	ctx->fun_name = fun_name;
	return old_name;
}
