#include <emscripten/emscripten.h>
#include <SDL/SDL.h>

#define SCREENLIST(w, h) ((h) | (w) << 16)

#define GFX_JS_FPS 60

#define KEY_BUFFER_LEN 256

typedef struct JS_GFXDRIVER_CTX_
{
    int inited;
    int changingScreen;
    int updated;
    int blitting;

    SDL_Surface *canvas;
    BLITTER *blit;

	unsigned long key_buffer[KEY_BUFFER_LEN];
	int           key_head;
	int           key_tail;
} JS_GFXDRIVER_CTX;

extern JS_GFXDRIVER_CTX __fb_js_ctx;


void fb_js_events_init(void);
void fb_js_events_check(void);
