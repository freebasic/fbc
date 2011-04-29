/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2011 The FreeBASIC development team.
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
 *
 *  As a special exception, the copyright holders of this library give
 *  you permission to link this library with independent modules to
 *  produce an executable, regardless of the license terms of these
 *  independent modules, and to copy and distribute the resulting
 *  executable under terms of your choice, provided that you also meet,
 *  for each linked independent module, the terms and conditions of the
 *  license of that module. An independent module is a module which is
 *  not derived from or based on this library. If you modify this library,
 *  you may extend this exception to your version of the library, but
 *  you are not obligated to do so. If you do not wish to do so, delete
 *  this exception statement from your version.
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
