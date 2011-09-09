/* sleep function */

#include "fb.h"

/*:::::*/
void fb_ConsoleSleep ( int msecs )
{
    /* FIXME: We need to find a method to set a flag whenver a NEW character
     *        was passed to the input buffer. Maybe we can use something
     *        like ftell( stdin ) + some modifications of key input functions?
     *
     * INFO: Don't clear the input buffer in any case because this will
     *       cause more trouble than not clearing the input buffer.
     *
     * mjs, 2005-10-13
     */

	/* infinite? wait until any key is pressed */
	if( msecs == -1 )
	{
		while( !fb_KeyHit( ) )
			fb_Delay( 50 );
		return;
	}

	/* if above n-mili-seconds, check for key input, otherwise,
	   don't screw the precision with slow console checks */
	if( msecs >= 100 )
		while( msecs > 50 )
		{
			if( fb_KeyHit( ) )
				return;

			fb_Delay( 50 );
			msecs -= 50;
		}

	if( msecs >= 0 )
		fb_Delay( msecs );
}
