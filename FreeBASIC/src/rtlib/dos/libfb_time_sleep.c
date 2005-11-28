/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2005 Andre V. T. Vicentini (av1ctor@yahoo.com.br) and others.
 *
 *  This library is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU Lesser General Public
 *  License as published by the Free Software Foundation; either
 *  version 2.1 of the License, or (at your option) any later version.
 *
 *  This library is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *  Lesser General Public License for more details.
 *
 *  You should have received a copy of the GNU Lesser General Public
 *  License along with this library; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

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
        _movedataw( _dos_ds, 0x41C, _my_ds(), (int) &usCircBufferStatus, 1 );
    }

    _movedataw( _dos_ds, 0x41C, _my_ds(), (int) &usNewStatus, 1 );
    is_changed = usNewStatus!=usCircBufferStatus;
    if( is_changed )
        usCircBufferStatus = usNewStatus;

    /* Ensure that no IRQ disturbs us ... */
    fb_dos_cli();
    is_changed |= fb_force_input_buffer_changed;
    fb_force_input_buffer_changed = FALSE;
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
