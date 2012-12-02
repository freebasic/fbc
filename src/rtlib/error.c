/* runtime error handling */

#include "fb.h"

static const char *error_msg[] = {
	"",                                     /* FB_RTERROR_OK */
	"illegal function call",                /* FB_RTERROR_ILLEGALFUNCTIONCALL */
	"file not found",                       /* FB_RTERROR_FILENOTFOUND */
	"file I/O error",                       /* FB_RTERROR_FILEIO */
	"out of memory",                        /* FB_RTERROR_OUTOFMEM */
	"illegal resume",                       /* FB_RTERROR_ILLEGALRESUME */
	"out of bounds array access",           /* FB_RTERROR_OUTOFBOUNDS */
	"null pointer access",                  /* FB_RTERROR_NULLPTR */
	"no priviledges",                       /* FB_RTERROR_NOPRIVILEDGES */
	"\"interrupted\" signal",               /* FB_RTERROR_SIGINT */
	"\"illegal instruction\" signal",       /* FB_RTERROR_SIGILL */
	"\"floating point error\" signal",      /* FB_RTERROR_SIGFPE */
	"\"segmentation violation\" signal",    /* FB_RTERROR_SIGSEGV */
	"\"termination request\" signal",       /* FB_RTERROR_SIGTERM */
	"\"abnormal termination\" signal",      /* FB_RTERROR_SIGTERM */
	"\"quit request\" signal",              /* FB_RTERROR_SIGABRT */
	"return without gosub",                 /* FB_RTERROR_RETURNWITHOUTGOSUB */
	"end of file"                           /* FB_RTERROR_ENDOFFILE */
};

static void fb_Die
	( 
		int err_num, 
		int line_num, 
		const char *mod_name,
		const char *fun_name
	)
{
	#define FB_ERROR_MESSAGE_SIZE 1024
	char errmsg[FB_ERROR_MESSAGE_SIZE];
	int pos = 0;

	pos += snprintf( &errmsg[pos], FB_ERROR_MESSAGE_SIZE - pos,
	                 "\nAborting due to runtime error %d", err_num );

	if( (err_num >= 0) && (err_num < FB_RTERROR_MAX) )
		pos += snprintf( &errmsg[pos], FB_ERROR_MESSAGE_SIZE - pos,
						 " (%s)", error_msg[err_num] );

	if( line_num > 0 )
		pos += snprintf( &errmsg[pos], FB_ERROR_MESSAGE_SIZE - pos,
						 " at line %d", line_num );

	if( mod_name != NULL )
		if( fun_name != NULL )
			pos += snprintf( &errmsg[pos], FB_ERROR_MESSAGE_SIZE - pos,
			                 " %s %s::%s()\n\n", (char *)(line_num > 0? &"of" : &"in"),
			                 (char *)mod_name, (char *)fun_name );
		else
			pos += snprintf( &errmsg[pos], FB_ERROR_MESSAGE_SIZE - pos,
			                 " %s %s()\n\n", (char *)(line_num > 0? &"of" : &"in"),
			                 (char *)mod_name );
	else
		pos += snprintf( &errmsg[pos], FB_ERROR_MESSAGE_SIZE - pos, "\n\n" );

	errmsg[FB_ERROR_MESSAGE_SIZE-1] = '\0';

	/* Printing to stderr should allow the message to be seen when in
	   console mode but also when in graphics mode, at least on program
	   exit.
	   In any case, printing to screen like PRINT would do is not good here
	   in case its a graphics screen that is about to be closed... */
	fputs( errmsg, stderr );

	fb_End( err_num );
}

/*:::::*/
FB_ERRHANDLER fb_ErrorThrowEx 
	( 
		int err_num, 
		int line_num, 
		const char *mod_name,
		void *res_label, 
		void *resnext_label 
	)
{
    FB_ERRORCTX *ctx = FB_TLSGETCTX( ERROR );

    if( ctx->handler )
    {
    	ctx->err_num = err_num;
    	ctx->line_num = line_num;
    	if( mod_name != NULL )
    		ctx->mod_name = mod_name;
    	ctx->res_lbl = res_label;
    	ctx->resnxt_lbl = resnext_label;

    	return ctx->handler;
    }

	/* if no user handler defined, die */
	fb_Die( err_num, 
			line_num, 
			(mod_name != NULL? mod_name: ctx->mod_name),
			ctx->fun_name );

	return NULL;
}

/*:::::*/
FB_ERRHANDLER fb_ErrorThrowAt 
	( 
		int line_num, 
		const char *mod_name,
		void *res_label, 
		void *resnext_label 
	)
{
	FB_ERRORCTX *ctx = FB_TLSGETCTX( ERROR );

	return fb_ErrorThrowEx( ctx->err_num, line_num, mod_name, res_label, resnext_label );

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
		fb_Die( FB_RTERROR_ILLEGALRESUME, -1, ctx->mod_name, ctx->fun_name );

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
		fb_Die( FB_RTERROR_ILLEGALRESUME, -1, ctx->mod_name, ctx->fun_name );

	/* don't loop forever */
	ctx->res_lbl = NULL;
	ctx->resnxt_lbl = NULL;

	return label;
}

