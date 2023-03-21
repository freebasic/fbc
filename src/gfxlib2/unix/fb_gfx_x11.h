/* common x11 internal definitions */

#ifndef DISABLE_X11

#ifndef __FB_GFX_X11_H__
#define __FB_GFX_X11_H__

#include <X11/Xlib.h>
#include <X11/Xutil.h>
#include <X11/xpm.h>
#include <X11/keysym.h>
#include <X11/cursorfont.h>
#include <X11/extensions/XShm.h>
#include <X11/extensions/Xrandr.h>
#include <X11/extensions/shape.h>

#define DOUBLE_CLICK_TIME		250

typedef struct X11DRIVER
{
	Display *display;
	Visual *visual;
	int screen;
	Window window;
	Window wmwindow;
	Window fswindow;
	GC gc;
	XRRScreenConfiguration *config;
	int w, h, depth, visual_depth, flags;
	int refresh_rate, display_offset;
	int (*init)(void);
	void (*exit)(void);
	void (*update)(void);
	int mouse_clip;
} X11DRIVER;


extern X11DRIVER fb_x11;
extern const GFXDRIVER fb_gfxDriverX11;
extern const GFXDRIVER fb_gfxDriverOpenGL;

extern char **fb_program_icon;

void fb_hX11WaitUnmapped(Window w);

extern void fb_hXlibInit(void);
extern int fb_hX11Init(char *title, int w, int h, int depth, int refresh_rate, int flags);
extern void fb_hX11Exit(void);
extern void fb_hX11Lock(void);
extern void fb_hX11Unlock(void);
extern void fb_hX11SetPalette(int index, int r, int g, int b);
extern void fb_hX11WaitVSync(void);
extern int fb_hX11GetMouse(int *x, int *y, int *z, int *buttons, int *clip);
extern void fb_hX11SetMouse(int x, int y, int cursor, int clip);
extern void fb_hX11SetWindowTitle(char *title);
extern int fb_hX11SetWindowPos(int x, int y);
extern int *fb_hX11FetchModes(int depth, int *size);
extern int fb_hX11EnterFullscreen(int *h);
extern void fb_hX11LeaveFullscreen(void);
extern void fb_hX11InitWindow(int x, int y);
extern int fb_hX11ScreenInfo(ssize_t *width, ssize_t *height, ssize_t *depth, ssize_t *refresh);

#endif

#endif
