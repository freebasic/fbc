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

    int doNotCaptureKeyboard;
} JS_GFXDRIVER_CTX;

extern JS_GFXDRIVER_CTX __fb_js_ctx;


extern void fb_js_events_init(void);
extern void fb_js_events_exit(void);
extern void fb_js_events_check(void);
extern int fb_js_sdl_buttons_to_fb_buttons(int sdl_buttons);
