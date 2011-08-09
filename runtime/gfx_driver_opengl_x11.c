/* OpenGL gfx driver */

#ifndef DISABLE_X

#include "fb_gfx.h"
#include "fb_gfx_x11.h"
#include <GL/glx.h>

/* For compatibility with old Mesa headers */
#ifndef GLX_SAMPLE_BUFFERS_ARB
# define GLX_SAMPLE_BUFFERS_ARB             100000
#endif
#ifndef GLX_SAMPLES_ARB
# define GLX_SAMPLES_ARB                    100001
#endif

static int driver_init(char *title, int w, int h, int depth, int refresh_rate, int flags);
static void driver_exit(void);
static void driver_flip(void);

GFXDRIVER fb_gfxDriverOpenGL =
{
	"OpenGL",		/* char *name; */
	driver_init,		/* int (*init)(int w, int h, char *title, int fullscreen); */
	driver_exit,		/* void (*exit)(void); */
	fb_hX11Lock,		/* void (*lock)(void); */
	fb_hX11Unlock,		/* void (*unlock)(void); */
	fb_hX11SetPalette,	/* void (*set_palette)(int index, int r, int g, int b); */
	fb_hX11WaitVSync,	/* void (*wait_vsync)(void); */
	fb_hX11GetMouse,	/* int (*get_mouse)(int *x, int *y, int *z, int *buttons, int *clip); */
	fb_hX11SetMouse,	/* void (*set_mouse)(int x, int y, int cursor, int clip); */
	fb_hX11SetWindowTitle,	/* void (*set_window_title)(char *title); */
	fb_hX11SetWindowPos,	/* int (*set_window_pos)(int x, int y); */
	fb_hX11FetchModes,	/* int *(*fetch_modes)(void); */
	driver_flip,		/* void (*flip)(void); */
	NULL			/* void (*poll_events)(void); */
};


typedef XVisualInfo *(*GLXCHOOSEVISUAL)(Display *, int, int *);
typedef GLXContext (*GLXCREATECONTEXT)(Display *, XVisualInfo *, GLXContext, int);
typedef void (*GLXDESTROYCONTEXT)(Display *, GLXContext);
typedef int (*GLXMAKECURRENT)(Display *, GLXDrawable, GLXContext);
typedef void (*GLXSWAPBUFFERS)(Display *, GLXDrawable);

typedef struct {
	GLXCHOOSEVISUAL ChooseVisual;
	GLXCREATECONTEXT CreateContext;
	GLXDESTROYCONTEXT DestroyContext;
	GLXMAKECURRENT MakeCurrent;
	GLXSWAPBUFFERS SwapBuffers;
} GLXFUNCS;

static FB_DYLIB gl_lib = NULL;
static GLXFUNCS __fb_glX = { NULL };
static GLXContext context;


/*:::::*/
void *fb_hGL_GetProcAddress(const char *proc)
{
	void *addr;
	
	if (fb_hDynLoadAlso(gl_lib, &proc, &addr, 1))
		return NULL;
	
	return addr;
}


/*:::::*/
static int opengl_window_init(void)
{
	int x = 0, y = 0;
	int h;
	char *display_name;
	
	if (!(fb_x11.flags & DRIVER_FULLSCREEN)) {
		x = (XDisplayWidth(fb_x11.display, fb_x11.screen) - fb_x11.w) >> 1;
		y = (XDisplayHeight(fb_x11.display, fb_x11.screen) - fb_x11.h) >> 1;
	}
	fb_hX11InitWindow(x, y);
	
	fb_x11.display_offset = 0;
	if (fb_x11.flags & DRIVER_FULLSCREEN) {
		display_name = XDisplayName(NULL);
		if ((!display_name[0]) || (display_name[0] == ':') || (!strncmp(display_name, "unix:", 5))) {
			if (fb_hX11EnterFullscreen(&h) || (h != fb_x11.h)) {
				fb_hX11LeaveFullscreen();
				return -1;
			}
			XReparentWindow(fb_x11.display, fb_x11.window, fb_x11.fswindow, 0, 0);
			XMoveResizeWindow(fb_x11.display, fb_x11.fswindow, 0,0,fb_x11.w, fb_x11.h);
			XMoveResizeWindow(fb_x11.display, fb_x11.window, 0,0,fb_x11.w, fb_x11.h);
		}
		else
			return -1;
	}
	
	XSync(fb_x11.display, False);
	
	return 0;
}

/*:::::*/
static void opengl_window_exit(void)
{
	if (fb_x11.flags & DRIVER_FULLSCREEN)
		fb_hX11LeaveFullscreen();
		
	XUnmapWindow(fb_x11.display, fb_x11.window);
	fb_hX11WaitUnmapped(fb_x11.window);
	if (fb_x11.flags & DRIVER_FULLSCREEN) {
		XUnmapWindow(fb_x11.display, fb_x11.fswindow);
	XSync(fb_x11.display, False);
	} else {
		XUnmapWindow(fb_x11.display, fb_x11.wmwindow);
		fb_hX11WaitUnmapped(fb_x11.wmwindow);
}
	//usleep(500);
	XSync(fb_x11.display, False);
}


/*:::::*/
static void opengl_window_update(void)
{
}


/*:::::*/
static int driver_init(char *title, int w, int h, int depth, int refresh_rate, int flags)
{
	const char *glx_funcs[] = {
		"glXChooseVisual", "glXCreateContext", "glXDestroyContext",
		"glXMakeCurrent", "glXSwapBuffers", NULL
	};
	static Display * dpy = 0;
	GLXFUNCS *funcs = &__fb_glX;
	void **funcs_ptr = (void **)funcs;
	XVisualInfo *info;
	int attribs[64] = { GLX_RGBA, GLX_DOUBLEBUFFER, 0 }, *attrib = &attribs[2], *samples_attrib = NULL;
	int result;
	
	fb_hMemSet(&fb_x11, 0, sizeof(fb_x11));
	
	context = NULL;
	
	if (!(flags & DRIVER_OPENGL))
		return -1;
	fb_hGL_NormalizeParameters(flags);
	*attrib++ = GLX_RED_SIZE;
	*attrib++ = __fb_gl_params.color_red_bits;
	*attrib++ = GLX_GREEN_SIZE;
	*attrib++ = __fb_gl_params.color_green_bits;
	*attrib++ = GLX_BLUE_SIZE;
	*attrib++ = __fb_gl_params.color_blue_bits;
	*attrib++ = GLX_ALPHA_SIZE;
	*attrib++ = __fb_gl_params.color_alpha_bits;
	*attrib++ = GLX_DEPTH_SIZE;
	*attrib++ = __fb_gl_params.depth_bits;
	if (__fb_gl_params.stencil_bits > 0) {
		*attrib++ = GLX_STENCIL_SIZE;
		*attrib++ = __fb_gl_params.stencil_bits;
	}
	if (__fb_gl_params.accum_bits > 0) {
		*attrib++ = GLX_ACCUM_RED_SIZE;
		*attrib++ = __fb_gl_params.accum_red_bits;
		*attrib++ = GLX_ACCUM_GREEN_SIZE;
		*attrib++ = __fb_gl_params.accum_green_bits;
		*attrib++ = GLX_ACCUM_BLUE_SIZE;
		*attrib++ = __fb_gl_params.accum_blue_bits;
		*attrib++ = GLX_ACCUM_ALPHA_SIZE;
		*attrib++ = __fb_gl_params.accum_alpha_bits;
	}
	if (__fb_gl_params.num_samples > 0) {
		*attrib++ = GLX_SAMPLE_BUFFERS_ARB;
		*attrib++ = GL_TRUE;
		*attrib++ = GLX_SAMPLES_ARB;
		samples_attrib = attrib;
		*attrib++ = 4;
	}
	*attrib = None;
	
	fb_x11.init = opengl_window_init;
	fb_x11.exit = opengl_window_exit;
	fb_x11.update = opengl_window_update;
	fb_hXlibInit();
	if(!dpy)
		dpy = XOpenDisplay(NULL);
	if (!dpy)
		return -1;
	fb_x11.screen = XDefaultScreen(dpy);
	if (!gl_lib) gl_lib = fb_hDynLoad("libGL.so.1", glx_funcs, funcs_ptr);
	
	if (!gl_lib)
		return -1;
	
	do {
		if ((info = __fb_glX.ChooseVisual(dpy, fb_x11.screen, attribs))) {
			fb_x11.visual = info->visual;
			context = __fb_glX.CreateContext(dpy, info, NULL, True);
			XFree(info);
			if ((intptr_t)context > 0)
				break;
			else
				__fb_glX.DestroyContext(dpy, context);
		}
	} while ((samples_attrib) && ((*samples_attrib -= 2) >= 0));

	if (!info) {
		return -1;
	}
	fb_x11.display = dpy;
	result = fb_hX11Init(title, w, h, info->depth, refresh_rate, flags);
	if (result)
		return result;
	__fb_glX.MakeCurrent(fb_x11.display, fb_x11.window, context);
	
	if (fb_hGL_Init(gl_lib, NULL))
		return -1;
	if ((samples_attrib) && (*samples_attrib > 0))
		__fb_gl.Enable(GL_MULTISAMPLE_ARB);
	return 0;
}


/*:::::*/
static void driver_exit(void)
{
	if (context > 0) {
		__fb_glX.MakeCurrent(fb_x11.display, None, NULL);
		__fb_glX.DestroyContext(fb_x11.display, context);
	}
	fb_hX11Exit();
    fb_hDynUnload(&gl_lib);
}


/*:::::*/
static void driver_flip(void)
{
	fb_hX11Lock();
	__fb_glX.SwapBuffers(fb_x11.display, fb_x11.window);
	fb_hX11Unlock();
}

#endif
