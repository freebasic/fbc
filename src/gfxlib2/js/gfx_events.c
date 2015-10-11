#include "../fb_gfx.h"
#include "fb_gfx_js.h"

static int fb_js_gfx_Getkey( void )
{
	if( __fb_js_ctx.key_head == __fb_js_ctx.key_tail)
        return 0;

	int key = __fb_js_ctx.key_buffer[__fb_js_ctx.key_head];
	__fb_js_ctx.key_head = (__fb_js_ctx.key_head + 1) % KEY_BUFFER_LEN;

	return key;
}

static int fb_js_gfx_KeyHit( void )
{
	return __fb_js_ctx.key_head != __fb_js_ctx.key_tail;
}

static FBSTRING *fb_js_gfx_Inkey( void )
{
	FBSTRING *res = &__fb_ctx.null_desc;

	if( fb_js_gfx_KeyHit( ) != 0 )
	{
        res = fb_hMakeInkeyStr( fb_js_gfx_Getkey( ) );
	}

	return res;
}

static void fb_js_key_down(SDL_Event *event)
{
    __fb_js_ctx.key_buffer[__fb_js_ctx.key_tail] = event->key.keysym.sym;
    __fb_js_ctx.key_tail = (__fb_js_ctx.key_tail + 1) % KEY_BUFFER_LEN;

    if( __fb_js_ctx.key_tail == __fb_js_ctx.key_head )
        __fb_js_ctx.key_head = (__fb_js_ctx.key_head + 1) % KEY_BUFFER_LEN;

    //keys(event.key.keysym.sym) = 1
}

static void fb_js_key_up(SDL_Event *event)
{
    //keys(event.key.keysym.sym) = 0
}

void fb_js_events_check(void)
{
    SDL_PumpEvents();

    SDL_Event event;

    while( SDL_PollEvent(&event) )
    {
        switch( event.type )
        {
            case SDL_KEYDOWN:
                fb_js_key_down(&event);
                break;
            case SDL_KEYUP:
                fb_js_key_up(&event);
                break;
        }
    }
}

void fb_js_events_init(void)
{
	__fb_ctx.hooks.inkeyproc  = fb_js_gfx_Inkey;
	__fb_ctx.hooks.getkeyproc = fb_js_gfx_Getkey;
	__fb_ctx.hooks.keyhitproc = fb_js_gfx_KeyHit;
	__fb_ctx.hooks.multikeyproc = NULL;
	__fb_ctx.hooks.sleepproc = NULL;

	return;
}
