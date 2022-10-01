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
	DWORD dwMode;

	if( inited == -1 ) {
		inited = GetSystemMetrics( SM_CMOUSEBUTTONS );
		if( inited ) {
			__fb_con.mouseEventHook = ProcessMouseEvent;
			last_x = last_y = 1;
			fb_hConvertToConsole( &last_x, &last_y, NULL, NULL );
		}
	}

	if( inited == 0 ) {
		if (x) *x = -1;
		if (y) *y = -1;
		if (z) *z = -1;
		if (buttons) *buttons = -1;
		if (clip) *clip = -1;
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
	}

	if( inited > 0) {
		GetConsoleMode( __fb_in_handle, &dwMode );
		/* Test for Mouse_Input on and Quick_Edit off */
		if( (dwMode & (ENABLE_MOUSE_INPUT | ENABLE_QUICK_EDIT_MODE) ) != ENABLE_MOUSE_INPUT )
		{
			/* Turning off QuickEdit requires the extended flag value */
			dwMode |= (ENABLE_MOUSE_INPUT | ENABLE_EXTENDED_FLAGS);
			dwMode &= (~ENABLE_QUICK_EDIT_MODE);
			SetConsoleMode( __fb_in_handle, dwMode );
		}
	}

	fb_ConsoleProcessEvents( );

	if (x) *x = last_x - 1;
	if (y) *y = last_y - 1;
	if (z) *z = last_z;
	if (buttons) *buttons = last_buttons;
	if (clip) *clip = 0;

	fb_hConvertFromConsole( x, y, NULL, NULL );

	return FB_RTERROR_OK;
}

int fb_ConsoleSetMouse( int x, int y, int cursor, int clip )
{
	return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
}
