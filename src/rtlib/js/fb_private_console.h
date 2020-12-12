#include <emscripten/emscripten.h>
#include <emscripten/html5.h>

#define KEY_BUFFER_LEN 256

#define FB_COLOR_BLACK     (0)
#define FB_COLOR_BLUE      (1)
#define FB_COLOR_GREEN     (2)
#define FB_COLOR_CYAN      (3)
#define FB_COLOR_RED       (4)
#define FB_COLOR_MAGENTA   (5)
#define FB_COLOR_BROWN     (6)
#define FB_COLOR_WHITE     (7)
#define FB_COLOR_GREY      (8)
#define FB_COLOR_LBLUE     (9)
#define FB_COLOR_LGREEN    (10)
#define FB_COLOR_LCYAN     (11)
#define FB_COLOR_LRED      (12)
#define FB_COLOR_LMAGENTA  (13)
#define FB_COLOR_YELLOW    (14)
#define FB_COLOR_BWHITE    (15)

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
	const char          *color_remap;
} FB_CONSOLE_CTX;

extern FB_CONSOLE_CTX __fb_con;

extern EM_BOOL fb_hKeyEventHandler(int eventType, const EmscriptenKeyboardEvent *keyEvent, void *userData);
extern EM_BOOL fb_hMouseEventHandler(int eventType, const EmscriptenMouseEvent *mouseEvent, void *userData);
extern EM_BOOL fb_hMouseWheelEventHandler(int eventType, const EmscriptenWheelEvent *wheelEvent, void *userData);

