/* libfb initialization for js */

#include "../fb.h"
#include "fb_private_console.h"

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
    [FB_COLOR_BLACK] = 0x1,
    [FB_COLOR_BLUE] = 0xD,
    [FB_COLOR_GREEN] = 0xB,
    [FB_COLOR_CYAN] = 0xF,
    [FB_COLOR_RED] = 0xA,
    [FB_COLOR_MAGENTA] = 0xE,
    [FB_COLOR_BROWN] = 0xC,
    [FB_COLOR_WHITE] = 0x8,
    [FB_COLOR_GREY] = 0x9,
    [FB_COLOR_LBLUE] = 0x5,
    [FB_COLOR_LGREEN] = 0x3,
    [FB_COLOR_LCYAN] = 0x7,
    [FB_COLOR_LRED] = 0x2,
    [FB_COLOR_LMAGENTA] = 0x6,
    [FB_COLOR_YELLOW] = 0x4,
    [FB_COLOR_BWHITE] = 0x8,
};

static void fb_fs_init_console(void)
{
	memset( &__fb_con, 0, sizeof(__fb_con) );

	__fb_con.color_remap = color_remap;

	// keyboard
	emscripten_set_keypress_callback( EMSCRIPTEN_EVENT_TARGET_WINDOW, NULL, 1, fb_hKeyEventHandler );
	emscripten_set_keydown_callback( EMSCRIPTEN_EVENT_TARGET_WINDOW, NULL, 1, fb_hKeyEventHandler );
	emscripten_set_keyup_callback( EMSCRIPTEN_EVENT_TARGET_WINDOW, NULL, 1, fb_hKeyEventHandler );

	// mouse
	emscripten_set_mousemove_callback( EMSCRIPTEN_EVENT_TARGET_WINDOW, NULL, 1, fb_hMouseEventHandler );
	emscripten_set_mousedown_callback( EMSCRIPTEN_EVENT_TARGET_WINDOW, NULL, 1, fb_hMouseEventHandler );
	emscripten_set_mouseup_callback( EMSCRIPTEN_EVENT_TARGET_WINDOW, NULL, 1, fb_hMouseEventHandler );
	emscripten_set_dblclick_callback( EMSCRIPTEN_EVENT_TARGET_WINDOW, NULL, 1, fb_hMouseEventHandler );
	//emscripten_set_wheel_callback( EMSCRIPTEN_EVENT_TARGET_WINDOW, NULL, 1, fb_hMouseWheelEventHandler );
}

void fb_hInit( void )
{
    fb_fs_init_console();
}

void fb_hEnd( int unused )
{
}

