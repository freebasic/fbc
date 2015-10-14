/* libfb initialization for js */

#include "../fb.h"
#include "fb_private_console.h"
#include <emscripten/emscripten.h>
#include <emscripten/html5.h>

FB_CONSOLE_CTX __fb_con;

#ifdef ENABLE_MT
FBCALL void fb_Lock( void )      { return; }
FBCALL void fb_Unlock( void )    { return; }
FBCALL void fb_StrLock( void )   { return; }
FBCALL void fb_StrUnlock( void ) { return; }
FBCALL void fb_GraphicsLock  ( void ) { return; }
FBCALL void fb_GraphicsUnlock( void ) { return; }
#endif

void fb_hInit( void )
{
	memset( &__fb_con, 0, sizeof(__fb_con) );

	// keyboard
	emscripten_set_keypress_callback( 0, NULL, 1, fb_hKeyEventHandler );
	emscripten_set_keydown_callback( 0, NULL, 1, fb_hKeyEventHandler );
	emscripten_set_keyup_callback( 0, NULL, 1, fb_hKeyEventHandler );

	// mouse
	emscripten_set_mousemove_callback( 0, NULL, 1, fb_hMouseEventHandler );
	emscripten_set_mousedown_callback( 0, NULL, 1, fb_hMouseEventHandler );
	emscripten_set_mouseup_callback( 0, NULL, 1, fb_hMouseEventHandler );
	emscripten_set_dblclick_callback( 0, NULL, 1, fb_hMouseEventHandler );
	//emscripten_set_wheel_callback( 0, NULL, 1, fb_hMouseWheelEventHandler );
}

void fb_hEnd( int unused )
{
}
