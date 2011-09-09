/* libfb initialization for DOS */

#include "fb.h"

#include <float.h>
#include <conio.h>
#include <unistd.h>
#include <sys/farptr.h>

/* globals */
FB_CONSOLE_CTX __fb_con;

char *__fb_startup_cwd;


/*:::::*/
void fb_hInit ( void )
{
	/* set FPU precision to 64-bit and round to nearest (as in QB) */
	_control87(PC_64|RC_NEAR, MCW_PC|MCW_RC);

	/* turn off blink */
	intensevideo();

	memset( &__fb_con, 0, sizeof( FB_CONSOLE_CTX ) );
	
	__fb_startup_cwd = getcwd(NULL, 1024);
	
	fb_hConvertPath( __fb_startup_cwd, strlen( __fb_startup_cwd ) );
}
