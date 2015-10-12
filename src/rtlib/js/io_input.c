/* console input helpers */

#include "../fb.h"
#include "fb_private_console.h"

EM_BOOL fb_hKeyPressedCB(int eventType, const EmscriptenKeyboardEvent *keyEvent, void *userData)
{
	if( eventType != EMSCRIPTEN_EVENT_KEYPRESS )
        return 0;

    // !!!FIXME!!! convert ctrlKey, shiftKey and altKey
    // !!!FIXME!!! check repeat

    unsigned long key = keyEvent->keyCode != 0? keyEvent->keyCode: keyEvent->charCode;

    //emscripten_log(EM_LOG_CONSOLE, "%d, %d, %d, %d, %d", keyEvent->keyCode, keyEvent->charCode, key > 0x00FF? ((key & 0x00FF) << 8 | 0x00FF): key, keyEvent->key[0], keyEvent->code[0]);

    __fb_con.key_buffer[__fb_con.key_tail] = key;
    __fb_con.key_tail = (__fb_con.key_tail + 1) % KEY_BUFFER_LEN;

    if( __fb_con.key_tail == __fb_con.key_head )
        __fb_con.key_head = (__fb_con.key_head + 1) % KEY_BUFFER_LEN;

	return 1;
}

int fb_hConsoleInputBufferChanged( void )
{
    return fb_ConsoleKeyHit();
}
