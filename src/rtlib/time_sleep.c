/* sleep() function */

#include "fb.h"

void fb_ConsoleSleep( int msecs )
{
#if defined( HOST_XBOX )
    /* NOTE: No need to test for input keys because sleep will be hooked
     *       when the application is switched to graphics mode and the
     *       console implementations for keyboard handling are only dummy
     *       functions.
     */
	fb_Delay( msecs );
#else
	/* infinite? wait until any key is pressed */
	if( msecs == -1 ) {
		while( !fb_hConsoleInputBufferChanged( ) )
			fb_Delay( 50 );
		return;
	}

	/* if above n-mili-seconds, check for key input, otherwise,
	   don't screw the precision with slow console checks */
	if( msecs >= 100 ) {
		while( msecs > 50 ) {
			if( fb_hConsoleInputBufferChanged( ) )
				return;

			fb_Delay( 50 );
			msecs -= 50;
		}
	}

	if( msecs >= 0 )
		fb_Delay( msecs );
#endif
}
