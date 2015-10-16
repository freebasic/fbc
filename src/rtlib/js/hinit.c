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

static const char color_remap[16] =
{
    [FB_COLOR_BLACK] = '1',
    [FB_COLOR_BLUE] = 'D',
    [FB_COLOR_GREEN] = 'B',
    [FB_COLOR_CYAN] = 'F',
    [FB_COLOR_RED] = 'A',
    [FB_COLOR_MAGENTA] = 'E',
    [FB_COLOR_BROWN] = 'C',
    [FB_COLOR_WHITE] = '8',
    [FB_COLOR_GREY] = '9',
    [FB_COLOR_LBLUE] = '5',
    [FB_COLOR_LGREEN] = '3',
    [FB_COLOR_LCYAN] = '7',
    [FB_COLOR_LRED] = '2',
    [FB_COLOR_LMAGENTA] = '6',
    [FB_COLOR_YELLOW] = '4',
    [FB_COLOR_BWHITE] = '8',
};

static void fb_fs_init_console(void)
{
	memset( &__fb_con, 0, sizeof(__fb_con) );

	__fb_con.color_remap = color_remap;

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

void fb_hInit( void )
{
    fb_fs_init_console();
}

void fb_hEnd( int unused )
{
}

