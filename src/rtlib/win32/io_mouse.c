/* console mode mouse functions */

#include "../fb.h"
#include "fb_private_console.h"

static int inited = -1;
static int last_x = 0, last_y = 0, last_z = 0, last_buttons = 0;

static void ProcessMouseEvent(const MOUSE_EVENT_RECORD *pEvent)
{
	if( pEvent->dwEventFlags == MOUSE_WHEELED ) {
		last_z += ( ( pEvent->dwButtonState & 0xFF000000 ) ? -1 : 1 );
	} else {
		last_x = pEvent->dwMousePosition.X;
		last_y = pEvent->dwMousePosition.Y;
		last_buttons = pEvent->dwButtonState & 0x7;
	}
}

int fb_ConsoleGetMouse( int *x, int *y, int *z, int *buttons, int *clip )
{
#if 0
	INPUT_RECORD ir;
	DWORD dwRead;
#endif

	DWORD dwMode;

	if( inited == -1 ) {
		inited = GetSystemMetrics( SM_CMOUSEBUTTONS );
		if( inited ) {
			GetConsoleMode( __fb_in_handle, &dwMode );
			dwMode |= ENABLE_MOUSE_INPUT;
			SetConsoleMode( __fb_in_handle, dwMode );
#if 1
			__fb_con.mouseEventHook = ProcessMouseEvent;
#endif
			last_x = last_y = 1;
			fb_hConvertToConsole( &last_x, &last_y, NULL, NULL );
		}
	}

	if( inited == 0 ) {
		*x = *y = *z = *buttons = -1;
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
	}

	if( inited > 0) {
		GetConsoleMode( __fb_in_handle, &dwMode );
		if( !(dwMode & ENABLE_MOUSE_INPUT) )
		{
			dwMode |= ENABLE_MOUSE_INPUT;
			SetConsoleMode( __fb_in_handle, dwMode );
		}
	}

#if 0
	if( PeekConsoleInput( __fb_in_handle, &ir, 1, &dwRead ) ) {
		if( dwRead > 0 ) {
			ReadConsoleInput( __fb_in_handle, &ir, 1, &dwRead );
			if( ir.EventType == MOUSE_EVENT ) {
				ProcessMouseEvent( &ir.Event.MouseEvent );
			}
		}
	}
#else
	fb_ConsoleProcessEvents( );
#endif

	*x = last_x - 1;
	*y = last_y - 1;
	*z = last_z;
	*buttons = last_buttons;
	*clip = 0;

	fb_hConvertFromConsole( x, y, NULL, NULL );

	return FB_RTERROR_OK;
}

int fb_ConsoleSetMouse( int x, int y, int cursor, int clip )
{
	return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
}
