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
 * io_mouse.c -- mouse functions for Windows console mode apps
 *
 * chng: jun/2005 written [lillo]
 *
 */

#include "fb.h"
#include "fb_rterr.h"

static int inited = -1;
static int last_x = 0, last_y = 0, last_z = 0, last_buttons = 0;

static
void ProcessMouseEvent(const MOUSE_EVENT_RECORD *pEvent)
{
    if( pEvent->dwEventFlags == MOUSE_WHEELED ) {
        last_z += ( ( pEvent->dwButtonState & 0xFF000000 ) ? -1 : 1 );
    }
    else {
        last_x = pEvent->dwMousePosition.X;
        last_y = pEvent->dwMousePosition.Y;
        last_buttons = pEvent->dwButtonState & 0x7;
    }
}

/*:::::*/
int fb_ConsoleGetMouse( int *x, int *y, int *z, int *buttons )
{
#if 0
	INPUT_RECORD ir;
    DWORD dwRead;
#endif
    DWORD dwMode;

	if( inited == -1 ) {
		inited = GetSystemMetrics( SM_CMOUSEBUTTONS );
		if( inited ) {
			GetConsoleMode( fb_in_handle, &dwMode );
			dwMode |= ENABLE_MOUSE_INPUT;
			SetConsoleMode( fb_in_handle, dwMode );
#if 1
            MouseEventHook = ProcessMouseEvent;
#endif
            last_x = last_y = 1;
            fb_hConvertToConsole( &last_x, &last_y, NULL, NULL );
		}
	}
	if( inited == 0 ) {
		*x = *y = *z = *buttons = -1;
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
	}

#if 0
	if( PeekConsoleInput( fb_in_handle, &ir, 1, &dwRead ) ) {
		if( dwRead > 0 ) {
			ReadConsoleInput( fb_in_handle, &ir, 1, &dwRead );
            if( ir.EventType == MOUSE_EVENT ) {
                ProcessMouseEvent( &ir.Event.MouseEvent );
			}
		}
	}
#endif

	*x = last_x - 1;
	*y = last_y - 1;
	*z = last_z;
    *buttons = last_buttons;

    fb_hConvertFromConsole( x, y, NULL, NULL );

	return FB_RTERROR_OK;
}


/*:::::*/
int fb_ConsoleSetMouse( int x, int y, int cursor )
{
	return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
}
