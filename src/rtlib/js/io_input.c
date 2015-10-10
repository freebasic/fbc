/* console input helpers */

#include "../fb.h"
#include "fb_private_console.h"

EM_BOOL fb_hKeyPressedCB(int eventType, const EmscriptenKeyboardEvent *keyEvent, void *userData)
{
	if( eventType != EMSCRIPTEN_EVENT_KEYPRESS )
        return 0;

    // !!!FIXME!!! convert ctrlKey, shiftKey and altKey
    // !!!FIXME!!! check repeat

    __fb_con.key_buffer[__fb_con.key_tail] = keyEvent->keyCode != 0? keyEvent->keyCode: keyEvent->charCode;
    __fb_con.key_tail = (__fb_con.key_tail + 1) % KEY_BUFFER_LEN;

    if( __fb_con.key_tail == __fb_con.key_head )
        __fb_con.key_head = (__fb_con.key_head + 1) % KEY_BUFFER_LEN;

	return 1;
}

int fb_hConsoleInputBufferChanged( void )
{
    return fb_ConsoleKeyHit();
}
