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

#include "fb_gfx_linux.h"
#include <GL/glx.h>

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
	fb_hX11SetWindowPos,	/* int (*set_window_pos)(int x, int y); */
	fb_hX11FetchModes,	/* int *(*fetch_modes)(void); */
	driver_flip		/* void (*flip)(void); */
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
static GLXFUNCS fb_glX = { NULL };
static GLXContext context;


/*:::::*/
int fb_hGL_ExtensionSupported(const char *extension)
{
	int len, i;
	char *string = fb_gl.extensions;
	
	if (string) {
		len = strlen(extension);
		while ((string = strstr(string, extension)) != NULL) {
			string += len;
			if ((*string == ' ') || (*string == '\0'))
				return TRUE;
		}
	}
	
	return FALSE;
}


/*:::::*/
static int opengl_window_init(void)
{
	XSetWindowAttributes attribs;
	int x = 0, y = 0;
	char *display_name;
	
	if (!fb_linux.flags & DRIVER_FULLSCREEN) {
		x = (XDisplayWidth(fb_linux.display, fb_linux.screen) - fb_linux.w) >> 1;
		y = (XDisplayHeight(fb_linux.display, fb_linux.screen) - fb_linux.h) >> 1;
	}
	XMoveResizeWindow(fb_linux.display, fb_linux.window, x, y, fb_linux.w, fb_linux.h);
	attribs.override_redirect = ((fb_linux.flags & DRIVER_FULLSCREEN) ? True : False);
	XChangeWindowAttributes(fb_linux.display, fb_linux.window, CWOverrideRedirect, &attribs);
	XMapRaised(fb_linux.display, fb_linux.window);
	
	fb_linux.display_offset = 0;
	if (fb_linux.flags & DRIVER_FULLSCREEN) {
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
	if (fb_linux.flags & DRIVER_FULLSCREEN)
		fb_hX11LeaveFullscreen();
	XUnmapWindow(fb_linux.display, fb_linux.window);
	XSync(fb_linux.display, False);
}


/*:::::*/
static void opengl_window_update(void)
{
}


/*:::::*/
static int driver_init(char *title, int w, int h, int depth_arg, int refresh_rate, int flags)
{
	const char *funcs[] = {
		"glXChooseVisual", "glXCreateContext", "glXDestroyContext",
		"glXMakeCurrent", "glXSwapBuffers", NULL
	};
	int depth = MAX(8, depth_arg);
	XVisualInfo *info;
	int gl_attrs[32] = { GLX_RGBA, GLX_DOUBLEBUFFER,
			     GLX_RED_SIZE, 4, GLX_GREEN_SIZE, 4, GLX_BLUE_SIZE, 4,
			     GLX_DEPTH_SIZE, 16 };
	int *gl_attr, result, try_count, gl_options;
	
	context = NULL;
	gl_options = flags & DRIVER_OPENGL_OPTIONS;

	if (depth > 16)
		gl_attrs[3] = gl_attrs[5] = gl_attrs[7] = 8;
	
	gl_attr = &gl_attrs[10];
	if (gl_options & HAS_MULTISAMPLE) {
		*gl_attr++ = GLX_SAMPLE_BUFFERS_ARB;
		*gl_attr++ = GL_TRUE;
		*gl_attr++ = GLX_SAMPLES_ARB;
		*gl_attr++ = 4;
	}
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
	
	if ((!(flags & DRIVER_OPENGL)) || (flags & DRIVER_NO_FRAME))
		return -1;

	fb_hMemSet(&fb_linux, 0, sizeof(fb_linux));
	fb_linux.init = opengl_window_init;
	fb_linux.exit = opengl_window_exit;
	fb_linux.update = opengl_window_update;

	fb_hXlibInit();
	
	fb_linux.display = XOpenDisplay(NULL);
	if (!fb_linux.display)
		return -1;
	fb_linux.screen = XDefaultScreen(fb_linux.display);
	
	gl_lib = fb_hDynLoad("libGL.so.1", funcs, (void **)&fb_glX);
	if (!gl_lib)
		return -1;
	
	for (try_count = 0; try_count < 3; ++try_count) {
		if ((info = fb_glX.ChooseVisual(fb_linux.display, fb_linux.screen, gl_attrs))) {
			fb_linux.visual = info->visual;
			context = fb_glX.CreateContext(fb_linux.display, info, NULL, True);
			XFree(info);
			if ((int)context > 0)
				break;
			else
				fb_glX.DestroyContext(fb_linux.display, context);
		}
		switch (try_count) {
			case 0:
				if (depth > 16)
					gl_attrs[3] = gl_attrs[5] = gl_attrs[7] = 4;
				else
					gl_attrs[3] = gl_attrs[5] = gl_attrs[7] = 1;
				break;
			case 1:
				if (depth == 16)
					return -1;
				gl_attrs[3] = gl_attrs[5] = gl_attrs[7] = 1;
			case 2:
				if ((gl_options & HAS_MULTISAMPLE) && (gl_attrs[13] > 2)) {
					gl_attrs[3] = gl_attrs[5] = gl_attrs[7] = 8;
					gl_attrs[13] -= 2;
					try_count -= 3;
				}
				else
					return -1;
		}
	}
	
	result = fb_hX11Init(title, w, h, info->depth, refresh_rate, flags);
	if (result)
		return result;
	
	fb_glX.MakeCurrent(fb_linux.display, fb_linux.window, context);
	
	if (fb_hGL_Init(gl_lib))
		return -1;
	
	if (gl_options & HAS_MULTISAMPLE)
		fb_gl.Enable(GL_MULTISAMPLE_ARB);
	
	return 0;
}


/*:::::*/
static void driver_exit(void)
{
	if (context > 0) {
		fb_glX.MakeCurrent(fb_linux.display, None, NULL);
		fb_glX.DestroyContext(fb_linux.display, context);
	}
	fb_hX11Exit();
    fb_hDynUnload(&gl_lib);
}


/*:::::*/
static void driver_flip(void)
{
	fb_hX11Lock();
	fb_glX.SwapBuffers(fb_linux.display, fb_linux.window);
	fb_hX11Unlock();
}
