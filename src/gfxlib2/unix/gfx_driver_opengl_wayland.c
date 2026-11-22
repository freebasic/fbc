/* OpenGL gfx driver for Wayland */

#include "../fb_gfx.h"
#include "fb_gfx_wayland.h"
#include "../fb_gfx_gl.h"

#if !defined DISABLE_WAYLAND && !defined DISABLE_OPENGL

#include <EGL/egl.h>
#include <EGL/eglext.h>
#include <wayland-egl.h>
#include <GL/gl.h>

static int driver_init(char *title, int w, int h, int depth, int refresh_rate, int flags);
static void driver_exit(void);
static void driver_flip(void);

/* GFXDRIVER */
const GFXDRIVER fb_gfxDriverOpenGLWayland =
{
	"OpenGL",               /* char *name; */
	driver_init,            /* int (*init)(...); */
	driver_exit,            /* void (*exit)(void); */
	fb_hWaylandLock,        /* void (*lock)(void); */
	fb_hWaylandUnlock,      /* void (*unlock)(void); */
	fb_hGL_SetPalette,      /* void (*set_palette)(...); */
	fb_hWaylandWaitVSync,   /* void (*wait_vsync)(void); */
	fb_hWaylandGetMouse,    /* int (*get_mouse)(...); */
	fb_hWaylandSetMouse,    /* void (*set_mouse)(...); */
	fb_hWaylandSetWindowTitle, /* void (*set_window_title)(...); */
	fb_hWaylandSetWindowPos,/* int (*set_window_pos)(...); */
	fb_hWaylandFetchModes,  /* int *(*fetch_modes)(...); */
	driver_flip,            /* void (*flip)(void); */
	NULL,                   /* void (*poll_events)(void); */
	NULL                    /* void (*update)(void); */
};

typedef void *(*EGLGETPROCADDRESS)(const char *);
/* EGL state */
static EGLDisplay egl_display = EGL_NO_DISPLAY;
static EGLSurface egl_surface = EGL_NO_SURFACE;
static EGLContext egl_context = EGL_NO_CONTEXT;
static struct wl_egl_window *egl_window = NULL;
static FB_DYLIB gl_lib = NULL;

static void *wayland_gl_getproc(const char *proc)
{
	void *addr = NULL;
	if (gl_lib) {
		const char *name = proc;
		if (!fb_hDynLoadAlso(gl_lib, &name, &addr, 1)) return addr;
	}
	addr = (void *)eglGetProcAddress(proc);
	return addr;
}

static int opengl_window_init(void) {
	fb_wayland.display_offset = 0;
	return 0;
}
static void opengl_window_exit(void) {
	/* nothing extra */
}
static void opengl_window_idle(void) { }

static int driver_init(char *title, int w, int h, int depth, int refresh_rate, int flags) {
	const char *const gl_funcs[] = {
		"glXChooseVisual", NULL
	};
	(void)gl_funcs;
	if (!(flags & DRIVER_OPENGL)) return -1;
	fb_hGL_NormalizeParameters(flags);
	fb_hMemSet(&fb_wayland, 0, sizeof(fb_wayland));

	/* connect display for EGL */
	fb_wayland.display = wl_display_connect(NULL);
	if (!fb_wayland.display) return -1;

	egl_display = eglGetPlatformDisplay(EGL_PLATFORM_WAYLAND_EXT, fb_wayland.display, NULL);
	if (egl_display == EGL_NO_DISPLAY) {
		/* fallback */
		egl_display = eglGetDisplay((EGLNativeDisplayType)fb_wayland.display);
	}
	if (!eglInitialize(egl_display, NULL, NULL)) {
		wl_display_disconnect(fb_wayland.display);
		fb_wayland.display = NULL;
		return -1;
	}

	/* choose config */
	EGLint attribs[] = {
		EGL_SURFACE_TYPE, EGL_WINDOW_BIT,
		EGL_RED_SIZE, __fb_gl_params.color_red_bits,
		EGL_GREEN_SIZE, __fb_gl_params.color_green_bits,
		EGL_BLUE_SIZE, __fb_gl_params.color_blue_bits,
		EGL_ALPHA_SIZE, __fb_gl_params.color_alpha_bits,
		EGL_DEPTH_SIZE, __fb_gl_params.depth_bits,
		EGL_NONE
	};
	EGLConfig config;
	EGLint num_config;
	if (!eglChooseConfig(egl_display, attribs, &config, 1, &num_config) || num_config < 1) {
		eglTerminate(egl_display);
		wl_display_disconnect(fb_wayland.display);
		fb_wayland.display = NULL;
		return -1;
	}

	/* load libGL */
	if (!gl_lib) {
		const char *const names[] = { "glEnable", NULL };
		void *ptrs[1];
		gl_lib = fb_hDynLoad("libGL.so.1", names, ptrs);
	}
	fb_hGL_GetProcAddress_ptr = wayland_gl_getproc;

	fb_wayland.init = opengl_window_init;
	fb_wayland.exit = opengl_window_exit;
	fb_wayland.update = opengl_window_idle;

	int result = fb_hWaylandInit(title, w * ( (__fb_gl_params.scale>1)?__fb_gl_params.scale:1 ), h * ( (__fb_gl_params.scale>1)?__fb_gl_params.scale:1 ), 24, refresh_rate, flags);
	if (result) {
		eglTerminate(egl_display);
		wl_display_disconnect(fb_wayland.display);
		fb_wayland.display = NULL;
		return result;
	}

	/* create egl window */
	egl_window = wl_egl_window_create(fb_wayland.surface, fb_wayland.w, fb_wayland.h);
	fb_wayland.egl_window = egl_window;
	egl_surface = eglCreatePlatformWindowSurface(egl_display, config, egl_window, NULL);
	if (egl_surface == EGL_NO_SURFACE) {
		wl_egl_window_destroy(egl_window);
		fb_hWaylandExit();
		return -1;
	}
	EGLint ctx_attribs[] = { EGL_CONTEXT_CLIENT_VERSION, 2, EGL_NONE };
	egl_context = eglCreateContext(egl_display, config, EGL_NO_CONTEXT, ctx_attribs);
	if (egl_context == EGL_NO_CONTEXT) {
		/* try default */
		egl_context = eglCreateContext(egl_display, config, EGL_NO_CONTEXT, NULL);
	}
	if (egl_context == EGL_NO_CONTEXT) {
		eglDestroySurface(egl_display, egl_surface);
		wl_egl_window_destroy(egl_window);
		fb_hWaylandExit();
		return -1;
	}
	if (!eglMakeCurrent(egl_display, egl_surface, egl_surface, egl_context)) {
		eglDestroyContext(egl_display, egl_context);
		eglDestroySurface(egl_display, egl_surface);
		wl_egl_window_destroy(egl_window);
		fb_hWaylandExit();
		return -1;
	}

	if (fb_hGL_Init(gl_lib, NULL)) {
		/* continue anyway */
	}

	if (__fb_gl_params.mode_2d != DRIVER_OGL_2D_NONE) {
		fb_hGL_ScreenCreate();
	}

	return 0;
}

static void driver_exit(void) {
	if (egl_display != EGL_NO_DISPLAY) {
		eglMakeCurrent(egl_display, EGL_NO_SURFACE, EGL_NO_SURFACE, EGL_NO_CONTEXT);
		if (egl_context != EGL_NO_CONTEXT) eglDestroyContext(egl_display, egl_context);
		if (egl_surface != EGL_NO_SURFACE) eglDestroySurface(egl_display, egl_surface);
		eglTerminate(egl_display);
	}
	if (egl_window) { wl_egl_window_destroy(egl_window); egl_window = NULL; }
	fb_hWaylandExit();
	if (gl_lib) { fb_hDynUnload(&gl_lib); gl_lib = NULL; }
}

static void driver_flip(void) {
	fb_hWaylandLock();
	if (__fb_gl_params.mode_2d == DRIVER_OGL_2D_MANUAL_SYNC)
		fb_hGL_SetupProjection();
	eglSwapBuffers(egl_display, egl_surface);
	fb_hWaylandUnlock();
}

#endif
