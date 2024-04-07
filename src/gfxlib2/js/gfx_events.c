#include "../fb_gfx.h"
#include "fb_gfx_js.h"

/*
Comment out unused variable, see tatic void fb_js_sleep(int msecs), below.

static int sleep_called = 0;
*/

void fb_js_events_check(void)
{
    SDL_PumpEvents();

    SDL_Event event;

    while( SDL_PollEvent(&event) )
    {
        switch( event.type )
        {
            case SDL_MOUSEMOTION:
            {
                EVENT e =
                {
                    .type = EVENT_MOUSE_MOVE,
                    .x = event.motion.x,
                    .y = event.motion.y,
                    .dx = event.motion.xrel,
                    .dy = event.motion.yrel,
                };
                if( __fb_gfx->scanline_size != 1 ) {
                    e.y /= __fb_gfx->scanline_size;
                    e.dy /= __fb_gfx->scanline_size;
                } 

                fb_hPostEvent(&e);
                break;
            }

            case SDL_MOUSEBUTTONDOWN:
            {
                EVENT e =
                {
                    .type = EVENT_MOUSE_BUTTON_PRESS,
                    .button = fb_js_sdl_buttons_to_fb_buttons(event.button.button),
                };

                fb_hPostEvent(&e);
                break;
            }

            case SDL_MOUSEBUTTONUP:
            {
                EVENT e =
                {
                    .type = EVENT_MOUSE_BUTTON_RELEASE,
                    .button = fb_js_sdl_buttons_to_fb_buttons(event.button.button),
                };

                fb_hPostEvent(&e);
                break;
            }
        }
    }
}

/*static void fb_js_sleep(int msecs)
{
    if( !sleep_called )
    {
        sleep_called = 1;
        emscripten_log(EM_LOG_WARN, "Warning: Call to SLEEP() ignored. It should not be used in Javascript");
    }
}*/

void fb_js_events_init(void)
{
	//__fb_ctx.hooks.sleepproc = fb_js_sleep;

	// we can't use SDL's key events because CAPSLOCK isn't handled by emscripten and the printable chars are always lowercase in SDL
	__fb_ctx.hooks.inkeyproc  = NULL;
	__fb_ctx.hooks.getkeyproc = NULL;
	__fb_ctx.hooks.keyhitproc = NULL;
	__fb_ctx.hooks.multikeyproc = NULL;
	__fb_ctx.hooks.posteventproc = fb_hPostEvent;

    // don't let SDL capture the keyboard
    __fb_js_ctx.doNotCaptureKeyboard = emscripten_run_script_int("Module['doNotCaptureKeyboard']? 1: 0;");
    if(!__fb_js_ctx.doNotCaptureKeyboard) {
        emscripten_run_script("Module['doNotCaptureKeyboard']=1;");
	}

    return;
}

void fb_js_events_exit(void)
{
    if(!__fb_js_ctx.doNotCaptureKeyboard)
        emscripten_run_script("Module['doNotCaptureKeyboard']=null;");
}
