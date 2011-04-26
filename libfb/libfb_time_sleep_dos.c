/*
 * time_sleep.c -- sleep function
 *
 * chng: oct/2005 written [mjs]
 *
 */

#include "fb.h"

static int iCircBufferStatusInited = FALSE;
static unsigned short usCircBufferStatus = 0;

int fb_hConsoleInputBufferChanged( void )
{
    int is_changed;
    unsigned short usNewStatus;

    FB_LOCK();

    /* This is required to ensure that SLEEP still works even when
     * the input buffer is full (QB quirk) */
    fb_ConsoleMultikeyInit( );

    if( !iCircBufferStatusInited ) {
        iCircBufferStatusInited = TRUE;
        usCircBufferStatus = _farpeekw( _dos_ds, 0x41C );
    }

    usNewStatus = _farpeekw( _dos_ds, 0x41C );
    is_changed = usNewStatus!=usCircBufferStatus;
    if( is_changed )
        usCircBufferStatus = usNewStatus;

    /* Ensure that no IRQ disturbs us ... */
    fb_dos_cli();
    is_changed |= __fb_con.forceInpBufferChanged;
    __fb_con.forceInpBufferChanged = FALSE;
    fb_dos_sti();

    FB_UNLOCK();

    return is_changed;
}

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

	if( msecs > 0 )
		fb_Delay( msecs );

}
