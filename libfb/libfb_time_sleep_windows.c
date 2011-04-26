/*
 * time_sleep.c -- sleep function
 *
 * chng: oct/2005 written [mjs]
 *
 */

#include "fb.h"

int fb_hConsoleInputBufferChanged( void );

/*:::::*/
void fb_ConsoleSleep ( int msecs )
{
	/* infinite? wait until any key is pressed */
	if( msecs == -1 )
	{
		while( !fb_hConsoleInputBufferChanged( ) )
			fb_Delay( 50 );
		return;
	}

	/* if above n-mili-seconds, check for key input, otherwise,
	   don't screw the precision with slow console checks */
	if( msecs >= 100 )
		while( msecs > 50 )
		{
			if( fb_hConsoleInputBufferChanged( ) )
				return;

			fb_Delay( 50 );
			msecs -= 50;
		}

	if( msecs >= 0 )
		fb_Delay( msecs );

}
