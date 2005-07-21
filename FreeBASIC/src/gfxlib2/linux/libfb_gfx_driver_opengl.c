/*
 *  libgfx2 - FreeBASIC's alternative gfx library
 *	Copyright (C) 2005 Angelo Mottola (a.mottola@libero.it)
 *
 *  This library is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU Lesser General Public
 *  License as published by the Free Software Foundation; either
 *  version 2.1 of the License, or (at your option) any later version.
 *
 *  This library is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *  Lesser General Public License for more details.
 *
 *  You should have received a copy of the GNU Lesser General Public
 *  License along with this library; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/

/*
 * opengl.c -- OpenGL gfx driver
 *
 * chng: feb/2005 written [lillo]
 *
 */

#include "fb_gfx.h"

#ifdef __CYGWIN__

#include "../win32/libfb_gfx_driver_opengl.c"

#else

#include "fb_gfx_linux.h"
#include <GL/glx.h>
#include <dlfcn.h>

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
	fb_hX11GetMouse,	/* int (*get_mouse)(int *x, int *y, int *z, int *buttons); */
	fb_hX11SetMouse,	/* void (*set_mouse)(int x, int y, int cursor); */
	fb_hX11SetWindowTitle,	/* void (*set_window_title)(char *title); */
	fb_hX11FetchModes,	/* int *(*fetch_modes)(void); */
	driver_flip		/* void (*flip)(void); */
};


typedef XVisualInfo *(*GLXCHOOSEVISUAL)(Display *, int, int *);
typedef GLXContext (*GLXCREATECONTEXT)(Display *, XVisualInfo *, GLXContext, int);
typedef void (*GLXDESTROYCONTEXT)(Display *, GLXContext);
typedef int (*GLXMAKECURRENT)(Display *, GLXDrawable, GLXContext);
typedef void (*GLXSWAPBUFFERS)(Display *, GLXDrawable);

static GLXCHOOSEVISUAL fb_glXChooseVisual = NULL;
static GLXCREATECONTEXT fb_glXCreateContext;
static GLXDESTROYCONTEXT fb_glXDestroyContext;
static GLXMAKECURRENT fb_glXMakeCurrent;
static GLXSWAPBUFFERS fb_glXSwapBuffers;

static int gl_options;
static GLXContext context;


/*:::::*/
static int load_library(void)
{
	void *lib;
	
	if (!(lib = dlopen(NULL, RTLD_LAZY)))
		return -1;
	if (!dlsym(lib, "glXChooseVisual")) {
		dlclose(lib);
		if (!(lib = dlopen("libGL.so.1", RTLD_LAZY)))
			return -1;
	}
	fb_glXChooseVisual = (GLXCHOOSEVISUAL)dlsym(lib, "glXChooseVisual");
	fb_glXCreateContext = (GLXCREATECONTEXT)dlsym(lib, "glXCreateContext");
	fb_glXDestroyContext = (GLXDESTROYCONTEXT)dlsym(lib, "glXDestroyContext");
	fb_glXMakeCurrent = (GLXMAKECURRENT)dlsym(lib, "glXMakeCurrent");
	fb_glXSwapBuffers = (GLXSWAPBUFFERS)dlsym(lib, "glXSwapBuffers");
	if ((!fb_glXChooseVisual) || (!fb_glXCreateContext) || (!fb_glXDestroyContext) ||
	    (!fb_glXMakeCurrent) || (!fb_glXSwapBuffers))
		return -1;
	return 0;
}


/*:::::*/
static int opengl_window_init(void)
{
	XSetWindowAttributes attribs;
	int x = 0, y = 0;
	char *display_name;
	
	if (!fb_linux.fullscreen) {
		x = (XDisplayWidth(fb_linux.display, fb_linux.screen) - fb_linux.w) >> 1;
		y = (XDisplayHeight(fb_linux.display, fb_linux.screen) - fb_linux.h) >> 1;
	}
	XMoveResizeWindow(fb_linux.display, fb_linux.window, x, y, fb_linux.w, fb_linux.h);
	attribs.override_redirect = (fb_linux.fullscreen ? True : False);
	XChangeWindowAttributes(fb_linux.display, fb_linux.window, CWOverrideRedirect, &attribs);
	XMapRaised(fb_linux.display, fb_linux.window);
	
	fb_linux.display_offset = 0;
	if (fb_linux.fullscreen) {
		display_name = XDisplayName(NULL);
		if ((!display_name[0]) || (display_name[0] == ':') || (!strncmp(display_name, "unix:", 5))) {
			if (fb_hX11EnterFullscreen(fb_linux.h)) {
				fb_hX11LeaveFullscreen();
				return -1;
			}
		}
		else
			return -1;
	}
	
	XSync(fb_linux.display, False);
	
	return 0;
}


/*:::::*/
static void opengl_window_exit(void)
{
	if (fb_linux.fullscreen)
		fb_hX11LeaveFullscreen();
	XUnmapWindow(fb_linux.display, fb_linux.window);
	XSync(fb_linux.display, False);
}


/*:::::*/
static void opengl_window_update(void)
{
}


/*:::::*/
static int driver_init(char *title, int w, int h, int depth, int refresh_rate, int flags)
{
	XVisualInfo *info;
	int gl_attrs[21] = { GLX_RGBA, GLX_DOUBLEBUFFER,
			     GLX_RED_SIZE, 4, GLX_GREEN_SIZE, 4, GLX_BLUE_SIZE, 4,
			     GLX_DEPTH_SIZE, 16 };
	int *gl_attr, result;
	
	context = NULL;

	if (depth > 16)
		gl_attrs[3] = gl_attrs[5] = gl_attrs[7] = 8;
	
	gl_attr = &gl_attrs[10];
	if (gl_options & HAS_STENCIL_BUFFER) {
		*gl_attr++ = GLX_STENCIL_SIZE;
		*gl_attr++ = 8;
	}
	if (gl_options & HAS_ACCUMULATION_BUFFER) {
		*gl_attr++ = GLX_ACCUM_RED_SIZE;
		*gl_attr++ = 8;
		*gl_attr++ = GLX_ACCUM_GREEN_SIZE;
		*gl_attr++ = 8;
		*gl_attr++ = GLX_ACCUM_BLUE_SIZE;
		*gl_attr++ = 8;
		*gl_attr++ = GLX_ACCUM_ALPHA_SIZE;
		*gl_attr++ = 8;
	}
	*gl_attr = None;
	
	if (!(flags & DRIVER_OPENGL))
		return -1;

	fb_hMemSet(&fb_linux, 0, sizeof(fb_linux));
	fb_linux.init = opengl_window_init;
	fb_linux.exit = opengl_window_exit;
	fb_linux.update = opengl_window_update;
	gl_options = flags & DRIVER_OPENGL_OPTIONS;

	fb_hXlibInit();
	
	fb_linux.display = XOpenDisplay(NULL);
	if (!fb_linux.display)
		return -1;
	fb_linux.screen = XDefaultScreen(fb_linux.display);
	
	if (!fb_glXChooseVisual)
		if (load_library())
			return -1;
	
	if (!(info = fb_glXChooseVisual(fb_linux.display, fb_linux.screen, gl_attrs)))
		return -1;
	fb_linux.visual = info->visual;
	
	context = fb_glXCreateContext(fb_linux.display, info, NULL, True);
	XFree(info);
	if ((int)context <= 0)
		return -1;

	result = fb_hX11Init(title, w, h, info->depth, refresh_rate, flags);
	if (result)
		return result;
	
	fb_glXMakeCurrent(fb_linux.display, fb_linux.window, context);
	
	return 0;
}


/*:::::*/
static void driver_exit(void)
{
	if (context > 0) {
		fb_glXMakeCurrent(fb_linux.display, None, NULL);
		fb_glXDestroyContext(fb_linux.display, context);
	}
	fb_hX11Exit();
}


/*:::::*/
static void driver_flip(void)
{
	fb_hX11Lock();
	fb_glXSwapBuffers(fb_linux.display, fb_linux.window);
	fb_hX11Unlock();
}

#endif
