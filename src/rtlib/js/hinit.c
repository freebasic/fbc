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

	emscripten_set_keypress_callback( 0, 0, 1, fb_hKeyPressedCB );
}

void fb_hEnd( int unused )
{
}
