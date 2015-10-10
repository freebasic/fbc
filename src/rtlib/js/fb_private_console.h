#include <emscripten/emscripten.h>
#include <emscripten/html5.h>

#define KEY_BUFFER_LEN 256

typedef struct _FB_CONSOLE_CTX {
	int           active, visible;
	int           w, h;
	unsigned long key_buffer[KEY_BUFFER_LEN];
	int           key_head;
	int           key_tail;
} FB_CONSOLE_CTX;

extern FB_CONSOLE_CTX __fb_con;

extern EM_BOOL fb_hKeyPressedCB(int eventType, const EmscriptenKeyboardEvent *keyEvent, void *userData);

