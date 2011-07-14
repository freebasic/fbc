/* low-level signal handlers for Windows */

#include <signal.h>
#include "fb.h"

static LPTOP_LEVEL_EXCEPTION_FILTER old_excpfilter;

/*:::::*/
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

/*:::::*/
void fb_hInitSignals( void )
{
	old_excpfilter = SetUnhandledExceptionFilter( exception_filter );
}
