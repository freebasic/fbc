/* asmjs fbgfx driver */

#include "../fb_gfx.h"
#include "fb_gfx_js.h"
#include "../fb_gfx_gl.h"

JS_GFXDRIVER_CTX __fb_js_ctx =
{
    .inited = FALSE,
    .changingScreen = FALSE,
    .updated = FALSE,
    .blitting = FALSE,
    .canvas = NULL,
    .doNotCaptureKeyboard = 0,
};

static void driver_exit(void);

static void driver_blit()
{

    if(SDL_LockSurface(__fb_js_ctx.canvas) == 0)
    {
        __fb_js_ctx.blit(__fb_js_ctx.canvas->pixels, __fb_js_ctx.canvas->pitch);

        SDL_UnlockSurface(__fb_js_ctx.canvas);
    }

	SDL_Flip(__fb_js_ctx.canvas);

}

static void driver_update(void *unused)
{
	if( !__fb_js_ctx.inited || __fb_gfx == NULL || __fb_gfx->framebuffer == NULL )
		return;

    int ini_time = SDL_GetTicks();

	if( !__fb_js_ctx.changingScreen && !__fb_js_ctx.blitting )
    {
        __fb_js_ctx.blitting = TRUE;
        driver_blit();
        __fb_js_ctx.blitting = FALSE;

        __fb_js_ctx.updated = TRUE;

        fb_js_events_check( );
	}

	int delay = (1000/GFX_JS_FPS) - (SDL_GetTicks() - ini_time);

	emscripten_async_call(driver_update, NULL, MAX( delay, 1 ) );
}


static int driver_init(char *title, int w, int h, int depth_arg, int refresh_rate, int flags)
{
	if( w == 0 || h == 0 || depth_arg == 0 )
		return 0;

	if (flags & DRIVER_OPENGL)
		return -1;

	__fb_js_ctx.changingScreen = TRUE;

	if( !__fb_js_ctx.inited )
    {
        fb_js_events_init();
        SDL_Init(SDL_INIT_VIDEO);
    }

	if( __fb_js_ctx.canvas != NULL )
		SDL_FreeSurface(__fb_js_ctx.canvas);

	__fb_js_ctx.canvas = SDL_SetVideoMode(w, h, 32, SDL_HWSURFACE);

	__fb_js_ctx.blit = fb_hGetBlitter(__fb_js_ctx.canvas->format->BitsPerPixel, TRUE);

	__fb_js_ctx.changingScreen = FALSE;
	__fb_js_ctx.blitting = FALSE;

	int was_inited = __fb_js_ctx.inited;
	__fb_js_ctx.inited = TRUE;

	if( !was_inited )
	{
		__fb_js_ctx.updated = 0;
		emscripten_async_call(driver_update, NULL, 1000/GFX_JS_FPS);
	}

	return 0;
}

static int WGL_init(char *title, int w, int h, int depth_arg, int refresh_rate, int flags)
{
	if( w == 0 || h == 0 || depth_arg == 0 )
		return 0;

	if (!(flags & DRIVER_OPENGL))
		return -1;

	__fb_js_ctx.changingScreen = TRUE;

	if( !__fb_js_ctx.inited )
    {
        fb_js_events_init();
        SDL_Init(SDL_INIT_VIDEO);
    }

	if( __fb_js_ctx.canvas != NULL )
		SDL_FreeSurface(__fb_js_ctx.canvas);

	fb_hGL_NormalizeParameters(flags);

	SDL_GL_SetAttribute(SDL_GL_RED_SIZE, __fb_gl_params.color_red_bits); 
	SDL_GL_SetAttribute(SDL_GL_GREEN_SIZE, __fb_gl_params.color_green_bits);
	SDL_GL_SetAttribute(SDL_GL_BLUE_SIZE, __fb_gl_params.color_blue_bits);
	SDL_GL_SetAttribute(SDL_GL_ALPHA_SIZE, __fb_gl_params.color_alpha_bits);
	SDL_GL_SetAttribute(SDL_GL_DEPTH_SIZE, __fb_gl_params.depth_bits);
	SDL_GL_SetAttribute(SDL_GL_DOUBLEBUFFER, 1); 
	__fb_js_ctx.canvas = SDL_SetVideoMode(w, h, 32, SDL_DOUBLEBUF | SDL_DOUBLEBUF | SDL_OPENGL);

	__fb_js_ctx.changingScreen = FALSE;
	__fb_js_ctx.blitting = FALSE;

	int was_inited = __fb_js_ctx.inited;
	__fb_js_ctx.inited = TRUE;

	if( !was_inited )
	{
		__fb_js_ctx.updated = 0;
		//emscripten_async_call(driver_update, NULL, 1000/GFX_JS_FPS);
	}

	return 0;
}


static void driver_exit(void)
{
	if( __fb_js_ctx.inited )
	{
		__fb_js_ctx.inited = FALSE;

		if( !__fb_js_ctx.updated )
			driver_blit();

		if( __fb_js_ctx.canvas != NULL )
		{
			SDL_FreeSurface(__fb_js_ctx.canvas);
			__fb_js_ctx.canvas = NULL;
		}

		fb_js_events_exit();

		SDL_Quit();
	}
}

static void WGL_exit(void)
{
	if( __fb_js_ctx.inited )
	{
		__fb_js_ctx.inited = FALSE;

		if( __fb_js_ctx.canvas != NULL )
		{
			SDL_FreeSurface(__fb_js_ctx.canvas);
			__fb_js_ctx.canvas = NULL;
		}

		fb_js_events_exit();

		SDL_Quit();
	}
}

static void driver_lock(void)
{
	/* !!!WRITEME!!! */
}

static void driver_unlock(void)
{
	/* !!!WRITEME!!! */
}

static void driver_wait_vsync(void)
{
	/* !!!WRITEME!!! */
	emscripten_sleep(1000/GFX_JS_FPS);
}

static void WGL_Flip(void)
{
	SDL_GL_SwapBuffers();
}

int fb_js_sdl_buttons_to_fb_buttons(int sdl_buttons)
{
	int fb_buttons = 0;

	if( sdl_buttons & SDL_BUTTON_LMASK)
        fb_buttons |= BUTTON_LEFT;
	if( sdl_buttons & SDL_BUTTON_MMASK)
        fb_buttons |= BUTTON_MIDDLE;
	if( sdl_buttons & SDL_BUTTON_RMASK)
        fb_buttons |= BUTTON_RIGHT;
	if( sdl_buttons & SDL_BUTTON_X1MASK)
        fb_buttons |= BUTTON_X1;
	if( sdl_buttons & SDL_BUTTON_X2MASK)
        fb_buttons |= BUTTON_X2;

    return fb_buttons;
}

static int driver_get_mouse(int *x, int *y, int *z, int *buttons, int *clip)
{
	SDL_PumpEvents();

	uint32_t state = SDL_GetMouseState(x, y);
	if (buttons) *buttons = fb_js_sdl_buttons_to_fb_buttons(state);
	if (z) *z = 0;
	if (clip) *clip = 0;

	return 0;
}

static void driver_set_mouse(int x, int y, int cursor, int clip)
{
	//SDL_WarpMouseInWindow(NULL, x, y);
}

static int modes[] = {
    SCREENLIST(640, 480),
    SCREENLIST(512, 512),
    SCREENLIST(320, 240),
    SCREENLIST(320, 200),
    SCREENLIST(320, 100),
    SCREENLIST(256, 256),
    SCREENLIST(160, 120),
    SCREENLIST(80, 80)
};

static int *driver_fetch_modes(int depth, int *size)
{
	*size = sizeof(modes) / sizeof(int);
	return memcpy((void*)malloc(sizeof(modes)), modes, sizeof(modes));
}

static void driver_poll_events(void)
{
	fb_js_events_check( );
}

static void driver_set_window_title(char *title)
{
    SDL_WM_SetCaption(title, NULL);
}

/* GFXDRIVER */
static const GFXDRIVER fb_gfxDriverJS =
{
	"asmjs",                 /* char *name; */
	driver_init,             /* int (*init)(char *title, int w, int h, int depth, int refresh_rate, int flags); */
	driver_exit,             /* void (*exit)(void); */
	driver_lock,             /* void (*lock)(void); */
	driver_unlock,           /* void (*unlock)(void); */
	NULL,                    /* void (*set_palette)(int index, int r, int g, int b); */
	driver_wait_vsync,       /* void (*wait_vsync)(void); */
	driver_get_mouse,        /* int (*get_mouse)(int *x, int *y, int *z, int *buttons, int *clip); */
	driver_set_mouse,        /* void (*set_mouse)(int x, int y, int cursor, int clip); */
	driver_set_window_title, /* void (*set_window_title)(char *title); */
	NULL,                    /* int (*set_window_pos)(int x, int y); */
	driver_fetch_modes,      /* int *(*fetch_modes)(int depth, int *size); */
	NULL,                    /* void (*flip)(void); */
	driver_poll_events,      /* void (*poll_events)(void); */
	NULL                     /* void (*update)(void); */
};

/* GFXDRIVER */
static const GFXDRIVER fb_gfxWebGL =
{
	"WebGL",                 /* char *name; */
	WGL_init,                /* int (*init)(char *title, int w, int h, int depth, int refresh_rate, int flags); */
	WGL_exit,                /* void (*exit)(void); */
	driver_lock,             /* void (*lock)(void); */
	driver_unlock,           /* void (*unlock)(void); */
	NULL,                    /* void (*set_palette)(int index, int r, int g, int b); */
	driver_wait_vsync,       /* void (*wait_vsync)(void); */
	driver_get_mouse,        /* int (*get_mouse)(int *x, int *y, int *z, int *buttons, int *clip); */
	driver_set_mouse,        /* void (*set_mouse)(int x, int y, int cursor, int clip); */
	driver_set_window_title, /* void (*set_window_title)(char *title); */
	NULL,                    /* int (*set_window_pos)(int x, int y); */
	driver_fetch_modes,      /* int *(*fetch_modes)(int depth, int *size); */
	WGL_Flip,                /* void (*flip)(void); */
	driver_poll_events,      /* void (*poll_events)(void); */
	NULL                     /* void (*update)(void); */
};

const GFXDRIVER *__fb_gfx_drivers_list[] = {
	&fb_gfxDriverJS,
	&fb_gfxWebGL,
	NULL
};

void fb_hScreenInfo(ssize_t *width, ssize_t *height, ssize_t *depth, ssize_t *refresh)
{
	*width = 512;
	*height = 512;
	*depth = 32;
	*refresh = GFX_JS_FPS;
}

FBCALL int fb_GfxGetJoystick(int id, ssize_t *buttons, float *a1, float *a2, float *a3, float *a4, float *a5, float *a6, float *a7, float *a8)
{
	FB_GRAPHICS_LOCK( );

	*buttons = -1;
	*a1 = *a2 = *a3 = *a4 = *a5 = *a6 = *a7 = *a8 = -1000.0f;

	if ((id < 0) || (id >= 4)) {
		FB_GRAPHICS_UNLOCK( );
		return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);
	}

	FB_GRAPHICS_UNLOCK( );
	return fb_ErrorSetNum( FB_RTERROR_OK );
}
