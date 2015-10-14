#include <emscripten/emscripten.h>
#include <emscripten/html5.h>

#define KEY_BUFFER_LEN 256

typedef struct _FB_CONSOLE_MOUSE {
    int           x;
    int           y;
    int           z;
    int           dx;
    int           dy;
    int           button;
} FB_CONSOLE_MOUSE;

typedef struct _FB_CONSOLE_CTX {
	int                 active, visible;
	int                 w, h;
	unsigned long       key_buffer[KEY_BUFFER_LEN];
	int                 key_head;
	int                 key_tail;
	unsigned char       multikey[128];
	FB_CONSOLE_MOUSE    mouse;
} FB_CONSOLE_CTX;

extern FB_CONSOLE_CTX __fb_con;

extern EM_BOOL fb_hKeyEventHandler(int eventType, const EmscriptenKeyboardEvent *keyEvent, void *userData);
extern EM_BOOL fb_hMouseEventHandler(int eventType, const EmscriptenMouseEvent *mouseEvent, void *userData);
extern EM_BOOL fb_hMouseWheelEventHandler(int eventType, const EmscriptenWheelEvent *wheelEvent, void *userData);

