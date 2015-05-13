/* signal handlers */

#include "fb.h"
#include <signal.h>

#if defined( HOST_WIN32 )
#include <windows.h>

static LPTOP_LEVEL_EXCEPTION_FILTER old_excpfilter;

/* low-level signal handler for Windows */
static __stdcall LONG exception_filter( LPEXCEPTION_POINTERS info )
{

	switch( info->ExceptionRecord->ExceptionCode )
	{
	case EXCEPTION_ACCESS_VIOLATION:
	case EXCEPTION_STACK_OVERFLOW:
		raise( SIGSEGV );
	    break;

	case EXCEPTION_FLT_DIVIDE_BY_ZERO:
	case EXCEPTION_FLT_OVERFLOW:
	case EXCEPTION_INT_DIVIDE_BY_ZERO:
	case EXCEPTION_INT_OVERFLOW:
		raise( SIGFPE );
		break;
	}

	return old_excpfilter( info );
}
#endif

typedef struct _FB_SIGHANDLER {
	int		errnum;
	void 	(*oldhnd)(int);
} FB_SIGHANDLER;

static FB_SIGHANDLER sigTb[NSIG];

#define FB_SETUPSIGNAL(n,h) 				\
    sigTb[n].oldhnd = signal( n, h ); 		\
    sigTb[n].errnum = FB_RTERROR_##n;

static void gen_handler( int sig )
{
	FB_ERRHANDLER handler;

	/* don't cause another exception */
	if( (sig < 0) || (sig >= NSIG) || (sigTb[sig].errnum == FB_RTERROR_OK) )
	{
		raise( sig );
		return;
	}

	/* call user handler if any defined */
	handler = fb_ErrorThrowEx( sigTb[sig].errnum, -1, NULL, NULL, NULL );
	if( handler != NULL )
		handler( );

	/* if the user handler returned, exit */
	fb_End( sigTb[sig].errnum );
}

FBCALL void fb_InitSignals( void )
{
	memset( sigTb, 0, sizeof(sigTb) );

	FB_SETUPSIGNAL(SIGABRT, gen_handler)
	FB_SETUPSIGNAL(SIGFPE, gen_handler)
	FB_SETUPSIGNAL(SIGILL, gen_handler)
	FB_SETUPSIGNAL(SIGSEGV, gen_handler)
	FB_SETUPSIGNAL(SIGTERM, gen_handler)
	FB_SETUPSIGNAL(SIGINT, gen_handler)
#ifdef SIGQUIT
	FB_SETUPSIGNAL(SIGQUIT, gen_handler)
#endif

#if defined( HOST_WIN32 )
	old_excpfilter = SetUnhandledExceptionFilter( exception_filter );
#endif
}
