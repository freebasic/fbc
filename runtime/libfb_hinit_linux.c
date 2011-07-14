/* libfb initialization for Linux */

#include "fb.h"

/*:::::*/
void fb_hInit ( void )
{
	fb_unix_hInit( );
	
	__fb_con.has_perm = ioperm(0, 0x400, 1) ? FALSE : TRUE;
}
