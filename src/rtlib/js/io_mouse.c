/* console mode mouse functions */

#include "../fb.h"
#include "fb_private_console.h"
#include "../../gfxlib2/fb_gfx.h"

int fb_ConsoleGetMouse( int *x, int *y, int *z, int *buttons, int *clip )
{
	EmscriptenMouseEvent mouseState;

	if( emscripten_get_mouse_status( &mouseState ) != EMSCRIPTEN_RESULT_SUCCESS ) {
		if (x) *x = -1;
		if (y) *y = -1;
		if (z) *z = -1;
		if (buttons) *buttons = -1;
		if (clip) *clip = -1;
        return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
	}

    if( x != NULL )
        *x = mouseState.clientX;

    if( y != NULL )
        *y = mouseState.clientY;

    if( z != NULL )
        *z = 0;

    if( buttons != NULL )
    {
        int mbuttons = 0;
        if( mouseState.buttons & 1)
            mbuttons |= BUTTON_LEFT;
        if( mouseState.buttons & 2)
            mbuttons |= BUTTON_RIGHT;
        if( mouseState.buttons & 4)
            mbuttons |= BUTTON_MIDDLE;
        if( mouseState.buttons & 8)
            mbuttons |= BUTTON_X1;
        if( mouseState.buttons & 16)
            mbuttons |= BUTTON_X2;

        *buttons = mbuttons;
    }

    if( clip != NULL )
        *clip = 0;

    return fb_ErrorSetNum( FB_RTERROR_OK );
}

int fb_ConsoleSetMouse( int x, int y, int cursor, int clip )
{
	return fb_ErrorSetNum( FB_RTERROR_OK );
}
