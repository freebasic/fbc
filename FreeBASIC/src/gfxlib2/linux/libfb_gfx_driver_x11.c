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
 * x11.c -- X11 gfx driver
 *
 * chng: jan/2005 written [lillo]
 *
 */

#include <pthread.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <X11/Xlib.h>
#include <X11/Xutil.h>
#include <X11/keysym.h>
#include <X11/cursorfont.h>
#include <X11/extensions/XShm.h>
#include <X11/extensions/xf86vmode.h>

#include "../fb_gfx.h"

#define CURSOR_ARROW		1
#define CURSOR_NONE		0


static int x11_init(char *title, int w, int h, int depth, int flags);
static void x11_exit(void);
static void x11_lock(void);
static void x11_unlock(void);
static void x11_set_palette(int index, int r, int g, int b);
static void x11_wait_vsync(void);
static int x11_get_mouse(int *x, int *y, int *z, int *buttons);
static void x11_set_mouse(int x, int y, int cursor);
static void x11_set_window_title(char *title);



GFXDRIVER fb_gfxDriverX11 =
{
	"X11",			/* char *name; */
	x11_init,		/* int (*init)(int w, int h, char *title, int fullscreen); */
	x11_exit,		/* void (*exit)(void); */
	x11_lock,		/* void (*lock)(void); */
	x11_unlock,		/* void (*unlock)(void); */
	x11_set_palette,	/* void (*set_palette)(int index, int r, int g, int b); */
	x11_wait_vsync,		/* void (*wait_vsync)(void); */
	x11_get_mouse,		/* int (*get_mouse)(int *x, int *y, int *z, int *buttons); */
	x11_set_mouse,		/* void (*set_mouse)(int x, int y, int cursor); */
	x11_set_window_title	/* void (*set_window_title)(char *title); */
};


static pthread_t thread;
static pthread_mutex_t mutex;
static pthread_cond_t cond;
static Display *display;
static Visual *visual;
static XF86VidModeModeInfo *mode;
static XF86VidModeModeInfo **modes_info;
static int screen;
static Window window;
static Atom wm_delete_window;
static Cursor blank_cursor, arrow_cursor;
static Colormap color_map;
static XImage *image;
static XShmSegmentInfo shm_info;
static GC gc;
static char *window_title;
static BLITTER *blitter;
static int mode_w, mode_h, mode_depth, mode_fullscreen;
static int display_offset;
static int is_running, is_shm, num_modes, has_focus, cursor;
static int mouse_x, mouse_y, mouse_wheel, mouse_buttons, mouse_on;
static unsigned char keycode_to_scancode[256];

static const struct
{
	KeySym keysym;
	int scancode;
} keysym_to_scancode[] = {
	{ XK_Escape,		0x01 },	{ XK_F1,		0x3B }, { XK_F2,		0x3C },
	{ XK_F3,		0x3D }, { XK_F4,		0x3E }, { XK_F5,		0x3F },
	{ XK_F6,		0x40 }, { XK_F7,		0x41 },	{ XK_F8,		0x42 },
	{ XK_F9,		0x43 }, { XK_F10,		0x44 }, { XK_F11,		0x57 },
	{ XK_F12,		0x58 }, { XK_Scroll_Lock,	0x46 }, { XK_grave,		0x29 },
	{ XK_quoteleft,		0x29 }, { XK_asciitilde,	0x29 }, { XK_1,			0x02 },
	{ XK_2,			0x03 }, { XK_3,			0x04 }, { XK_4,			0x05 },
	{ XK_5,			0x06 }, { XK_6,			0x07 }, { XK_7,			0x08 },
	{ XK_8,			0x09 }, { XK_9,			0x0A }, { XK_0,			0x0B },
	{ XK_minus,		0x0C }, { XK_equal,		0x0D }, { XK_backslash,		0x2B },
	{ XK_BackSpace,		0x0E }, { XK_Tab,		0x0F }, { XK_q,			0x10 },
	{ XK_w,			0x11 }, { XK_e,			0x12 }, { XK_r,			0x13 },
	{ XK_t,			0x14 }, { XK_y,			0x15 }, { XK_u,			0x16 },
	{ XK_i,			0x17 }, { XK_o,			0x18 }, { XK_p,			0x19 },
	{ XK_bracketleft,	0x1A }, { XK_bracketright,	0x1B }, { XK_Return,		0x1C },
	{ XK_Caps_Lock,		0x3A }, { XK_a,			0x1E }, { XK_s,			0x1F },
	{ XK_d,			0x20 }, { XK_f,			0x21 }, { XK_g,			0x22 },
	{ XK_h,			0x23 }, { XK_j,			0x24 }, { XK_k,			0x25 },
	{ XK_l,			0x26 }, { XK_semicolon,		0x27 }, { XK_apostrophe,	0x28 },
	{ XK_Shift_L,		0x2A }, { XK_z,			0x2C }, { XK_x,			0x2D },
	{ XK_c,			0x2E }, { XK_v,			0x2F }, { XK_b,			0x30 },
	{ XK_n,			0x31 }, { XK_m,			0x32 }, { XK_comma,		0x33 },
	{ XK_period,		0x34 }, { XK_slash,		0x35 }, { XK_Shift_R,		0x36 },
	{ XK_Control_L,		0x1D }, { XK_Meta_L,		0x7D }, { XK_Alt_L,		0x38 },
	{ XK_space,		0x39 }, { XK_Alt_R,		0x38 }, { XK_Meta_R,		0x7E },
	{ XK_Menu,		0x7F }, { XK_Control_R,		0x1D }, { XK_Insert,		0x52 },
	{ XK_Home,		0x47 }, { XK_Prior,		0x49 }, { XK_Delete,		0x53 },
	{ XK_End,		0x4F }, { XK_Next,		0x51 }, { XK_Up,		0x48 },
	{ XK_Left,		0x4B }, { XK_Down,		0x50 }, { XK_Right,		0x4D },
	{ XK_Num_Lock,		0x45 }, { XK_KP_Divide,		0x35 }, { XK_KP_Multiply,	0x37 },
	{ XK_KP_Subtract,	0x4A }, { XK_KP_Home,		0x47 }, { XK_KP_Up,		0x48 },
	{ XK_KP_Prior,		0x49 }, { XK_KP_Add,		0x4E }, { XK_KP_Left,		0x4B },
	{ XK_KP_Begin,		0x4C }, { XK_KP_Right,		0x4D }, { XK_KP_End,		0x4F },
	{ XK_KP_Down,		0x50 }, { XK_KP_Next,		0x51 }, { XK_KP_Enter,		0x1C },
	{ XK_KP_Insert,		0x52 }, { XK_KP_Delete,		0x53 }, { NoSymbol,		0x00 }
};


/*:::::*/
static int calc_comp_height( int h )
{
	if( h < 240 )
		return 240;
	else if( h < 480 )
		return 480;
	else if( h < 600 )
		return 600;
	else if( h < 768 )
		return 768;
	else if( h < 1024 )
		return 1024;
	else
		return 0;
}


/*:::::*/
static void set_cursor(Cursor c)
{
	XUndefineCursor(display, window);
	if (mode_fullscreen)
		c = blank_cursor;
	XDefineCursor(display, window, c);
}


/*:::::*/
static int private_init(void)
{
	XPixmapFormatValues *format;
	XSetWindowAttributes attribs;
	XSizeHints size;
	Pixmap pixmap;
	XColor color;
	XGCValues gc_values;
	int i, j, x, y, h, num_formats, depth = 0, is_rgb = FALSE;
	int gc_mask, keycode_min, keycode_max, dummy, version;
	KeySym keysym;
	char *display_name;
	
	mode = NULL;
	modes_info = NULL;
	window = None;
	color_map = None;
	image = NULL;
	is_shm = FALSE;
	mouse_on = FALSE;
	blank_cursor = None;
	arrow_cursor = None;
	
	display = XOpenDisplay(NULL);
	if (!display)
		return -1;
	screen = XDefaultScreen(display);
	
	visual = XDefaultVisual(display, screen);
	format = XListPixmapFormats(display, &num_formats);
	for (i = 0; i < num_formats; i++) {
		if (format[i].depth == XDefaultDepth(display, screen)) {
			if (format[i].bits_per_pixel == 16)
				depth = format[i].depth;
			else
				depth = format[i].bits_per_pixel;
			break;
		}
	}
	XFree(format);
	if ((depth >= 24) && (visual->red_mask == 0xFF))
		is_rgb = TRUE;
	else if ((depth >= 15) && (visual->red_mask == 0x1F))
		is_rgb = TRUE;
	blitter = fb_hGetBlitter(depth, is_rgb);
	if (!blitter)
		return -1;
	
	x = (XDisplayWidth(display, screen) - mode_w) >> 1;
	y = (XDisplayHeight(display, screen) - mode_h) >> 1;
	
	attribs.border_pixel = attribs.background_pixel = XBlackPixel(display, screen);
	attribs.event_mask = KeyPressMask | KeyReleaseMask | ButtonPressMask | ButtonReleaseMask |
			     PointerMotionMask | FocusChangeMask | EnterWindowMask | LeaveWindowMask | ExposureMask;
	attribs.override_redirect = (mode_fullscreen ? True : False);
	attribs.backing_store = NotUseful;
	window = XCreateWindow(display, XDefaultRootWindow(display), x, y, mode_w, mode_h, 0,
			       XDefaultDepth(display, screen), InputOutput, visual,
			       CWBackPixel | CWBorderPixel | CWEventMask | CWOverrideRedirect | CWBackingStore, &attribs);
	if (!window)
		return -1;
	XStoreName(display, window, window_title);
	size.flags = PPosition | PMinSize | PMaxSize;
	size.x = size.y = 0;
	size.min_width = size.max_width = mode_w;
	size.min_height = size.max_height = mode_h;
	XSetWMNormalHints(display, window, &size);
	wm_delete_window = XInternAtom(display, "WM_DELETE_WINDOW", False);
	XSetWMProtocols(display, window, &wm_delete_window, 1);
	if (visual->class == PseudoColor) {
		color_map = XCreateColormap(display, XDefaultRootWindow(display), visual, AllocAll);
		XSetWindowColormap(display, window, color_map);
	}
	XClearWindow(display, window);
	XMapRaised(display, window);
	XFlush(display);
	
	display_offset = 0;
	display_name = XDisplayName(NULL);
	if (((!display_name[0]) || (display_name[0] == ':') || (!strncmp(display_name, "unix:", 5))) &&
	    (XShmQueryExtension(display))) {
		if (mode_fullscreen) {
			if (!XF86VidModeQueryExtension(display, &dummy, &dummy))
				return -1;
			if ((!XF86VidModeQueryVersion(display, &version, &dummy)) || (version < 2))
				return -1;
			if (!XF86VidModeGetAllModeLines(display, screen, &num_modes, &modes_info))
				return -1;
			h = mode_h;
			for (i = 0; i < num_modes; i++) {
				if ((modes_info[i]->hdisplay == mode_w) && (modes_info[i]->vdisplay == h))
					break;
			}
			if (i == num_modes) {
				h = calc_comp_height(mode_h);
				if (h) {
					for (i = 0; i < num_modes; i++) {
						if ((modes_info[i]->hdisplay == mode_w) && (modes_info[i]->vdisplay == h))
							break;
					}
				}
				if (i == num_modes)
					return -1;
				XResizeWindow(display, window, mode_w, h);
			}
			display_offset = (h - mode_h) >> 1;
			if (!XF86VidModeSwitchToMode(display, screen, modes_info[i]))
				return -1;
			mode = modes_info[i];
			XF86VidModeLockModeSwitch(display, screen, True);
			XMoveWindow(display, window, 0, 0);
			XF86VidModeSetViewPort(display, screen, 0, 0);
			mouse_on = TRUE;
			mouse_x = mode_w >> 1;
			mouse_y = mode_h >> 1;
			XWarpPointer(display, None, window, 0, 0, 0, 0, mouse_x, mouse_y);
			XSync(display, False);
			if (XGrabKeyboard(display, XDefaultRootWindow(display), False,
			    GrabModeAsync, GrabModeAsync, CurrentTime) != GrabSuccess)
				return -1;
			if (XGrabPointer(display, window, False, PointerMotionMask | ButtonPressMask | ButtonReleaseMask,
			    GrabModeAsync, GrabModeAsync, window, None, CurrentTime) != GrabSuccess)
				return -1;
		}
		is_shm = TRUE;
		image = XShmCreateImage(display, visual, XDefaultDepth(display, screen),
					ZPixmap, 0, &shm_info, mode_w, mode_h);
		if (image) {
			shm_info.shmid = shmget(IPC_PRIVATE, image->bytes_per_line * image->height, IPC_CREAT | 0777);
			shm_info.shmaddr = image->data = shmat(shm_info.shmid, 0, 0);
			shm_info.readOnly = False;
			if (!XShmAttach(display, &shm_info)) {
				shmdt(shm_info.shmaddr);
				shmctl(shm_info.shmid, IPC_RMID, 0);
				XDestroyImage(image);
				image = NULL;
			}
		}
	}
	else if (mode_fullscreen)
		return -1;
	if (!image) {
		is_shm = FALSE;
		image = XCreateImage(display, visual, XDefaultDepth(display, screen),
				     ZPixmap, 0, NULL, mode_w, mode_h, 32, 0);
		image->data = malloc(image->bytes_per_line * image->height);
		if (!image->data) {
			XDestroyImage(image);
			image = NULL;
		}
	}
	if (!image)
		return -1;
	
	pixmap = XCreatePixmap(display, window, 1, 1, 1);
	gc_mask = GCFunction | GCForeground | GCBackground;
	gc_values.function = GXcopy;
	gc_values.foreground = gc_values.background = 0;
	gc = XCreateGC(display, pixmap, gc_mask, &gc_values);
	XDrawPoint(display, pixmap, gc, 0, 0);
	XFreeGC(display, gc);
	color.pixel = color.red = color.green = color.blue = 0;
	color.flags = DoRed | DoGreen | DoBlue;
	blank_cursor = XCreatePixmapCursor(display, pixmap, pixmap, &color, &color, 0, 0);
	arrow_cursor = XCreateFontCursor(display, XC_left_ptr);
	XFreePixmap(display, pixmap);
	gc = DefaultGC(display, screen);
	
	XDisplayKeycodes(display, &keycode_min, &keycode_max);
	keycode_min = MAX(keycode_min, 0);
	keycode_max = MIN(keycode_max, 255);
	for (i = keycode_min; i <= keycode_max; i++) {
		keysym = XKeycodeToKeysym(display, i, 0);
		if (keysym != NoSymbol) {
			for (j = 0; (keysym_to_scancode[j].scancode) && (keysym_to_scancode[j].keysym != keysym); j++)
				;
			keycode_to_scancode[i] = keysym_to_scancode[j].scancode;
		}
	}
	mouse_buttons = mouse_wheel = 0;
	
	return 0;
}


/*:::::*/
static void private_exit(void)
{
	int i;
	
	if (display) {
		XSync(display, False);
		if (mode) {
			XUngrabPointer(display, CurrentTime);
			XUngrabKeyboard(display, CurrentTime);
			XF86VidModeLockModeSwitch(display, screen, False);
			XF86VidModeSwitchToMode(display, screen, modes_info[0]);
		}
		if (modes_info) {
			for (i = 0; i < num_modes; i++) {
				if (modes_info[i]->privsize)
					XFree(modes_info[i]->private);
			}
			XFree(modes_info);
		}
		if (image) {
			if (is_shm) {
				XShmDetach(display, &shm_info);
				shmdt(shm_info.shmaddr);
				shmctl(shm_info.shmid, IPC_RMID, 0);
			}
			else
				free(image->data);
			XDestroyImage(image);
		}
		if (arrow_cursor != None) {
			XUndefineCursor(display, window);
			XFreeCursor(display, arrow_cursor);
			XFreeCursor(display, blank_cursor);
		}
		if (color_map != None)
			XFreeColormap(display, color_map);
		if (window != None)
			XDestroyWindow(display, window);
		XCloseDisplay(display);
	}
}


/*:::::*/
static void *window_thread(void *arg)
{
	XEvent event;
	int i, y, h;
	char key;
	
	(void)arg;
	
	is_running = TRUE;
	if (private_init())
		is_running = FALSE;
	cursor = CURSOR_ARROW;
	if (mode_fullscreen)
		XDefineCursor(display, window, blank_cursor);
	else
		XDefineCursor(display, window, arrow_cursor);
	
	pthread_mutex_lock(&mutex);
	pthread_cond_signal(&cond);
	pthread_mutex_unlock(&mutex);
	
	while (is_running)
	{
		x11_lock();
		
		blitter(image->data, image->bytes_per_line);
		for (i = 0; i < mode_h; i++) {
			if (fb_mode->dirty[i]) {
				for (y = i, h = 0; (fb_mode->dirty[i]) && (i < mode_h); h++, i++)
					;
				if (is_shm)
					XShmPutImage(display, window, gc, image, 0, y, 0, y + display_offset, mode_w, h, False);
				else
					XPutImage(display, window, gc, image, 0, y, 0, y + display_offset, mode_w, h);
			}
		}
		fb_hMemSet(fb_mode->dirty, FALSE, mode_h);
		
		XSync(display, False);
		while (XPending(display)) {
			XNextEvent(display, &event);
			switch (event.type) {
				
				case Expose:
				case FocusIn:
					fb_hMemSet(fb_mode->dirty, TRUE, mode_h);
					has_focus = TRUE;
					break;
				
				case FocusOut:
					fb_hMemSet(fb_mode->key, FALSE, 128);
					has_focus = mouse_on = FALSE;
					break;
				
				case EnterNotify:
					mouse_on = TRUE;
					break;
				
				case LeaveNotify:
					mouse_on = FALSE;
					break;
				
				case MotionNotify:
					mouse_x = event.xmotion.x;
					mouse_y = event.xmotion.y - display_offset;
					if ((mouse_y < 0) || (mouse_y >= mode_h))
						mouse_on = FALSE;
					else
						mouse_on = TRUE;
					break;
				
				case ButtonPress:
					switch (event.xbutton.button) {
						case Button1:	mouse_buttons |= 0x1; break;
						case Button3:	mouse_buttons |= 0x2; break;
						case Button2:	mouse_buttons |= 0x4; break;
						case Button4:	mouse_wheel++; break;
						case Button5:	mouse_wheel--; break;
					}
					break;
					
				case ButtonRelease:
					switch (event.xbutton.button) {
						case Button1:	mouse_buttons &= ~0x1; break;
						case Button3:	mouse_buttons &= ~0x2; break;
						case Button2:	mouse_buttons &= ~0x4; break;
					}
					break;
				
				case KeyPress:
					if (has_focus) {
						fb_mode->key[keycode_to_scancode[event.xkey.keycode]] = TRUE;
						if ((fb_mode->key[0x1C]) && (fb_mode->key[0x38])) {
							private_exit();
							mode_fullscreen ^= DRIVER_FULLSCREEN;
							if (private_init()) {
								private_exit();
								mode_fullscreen ^= DRIVER_FULLSCREEN;
								private_init();
							}
							fb_hRestorePalette();
							fb_hMemSet(fb_mode->key, FALSE, 128);
							set_cursor(cursor == CURSOR_ARROW ? arrow_cursor : blank_cursor);
						}
						else if ((XLookupString(&event.xkey, &key, 1, NULL, NULL) == 1) && (key != 0x7F))
							fb_hPostKey(key);
						else {
							switch (XKeycodeToKeysym(display, event.xkey.keycode, 0)) {
								case XK_Up:	fb_hPostKey(KEY_UP);		break;
								case XK_Down:	fb_hPostKey(KEY_DOWN);		break;
								case XK_Left:	fb_hPostKey(KEY_LEFT);		break;
								case XK_Right:	fb_hPostKey(KEY_RIGHT);		break;
								case XK_Insert:	fb_hPostKey(KEY_INS);		break;
								case XK_Delete: fb_hPostKey(KEY_DEL);		break;
								case XK_Home:	fb_hPostKey(KEY_HOME);		break;
								case XK_End:	fb_hPostKey(KEY_END);		break;
								case XK_Page_Up:fb_hPostKey(KEY_PAGE_UP);	break;
								case XK_Page_Down:fb_hPostKey(KEY_PAGE_DOWN);	break;
							}
						}
					}
					break;
				
				case KeyRelease:
					if (has_focus)
						fb_mode->key[keycode_to_scancode[event.xkey.keycode]] = FALSE;
					break;
				
				case ClientMessage:
					if ((Atom)event.xclient.data.l[0] == wm_delete_window)
						fb_hPostKey(KEY_QUIT);
					break;
				
			}
		}
		
		pthread_cond_signal(&cond);
		
		x11_unlock();
		
		usleep(1000000 / 60);
	}
	
	private_exit();
	
	return NULL;
}



/*:::::*/
static int x11_init(char *title, int w, int h, int depth, int flags)
{
	window_title = title;
	mode_w = w;
	mode_h = h;
	mode_depth = depth;
	mode_fullscreen = flags & DRIVER_FULLSCREEN;

	pthread_mutex_init(&mutex, NULL);
	pthread_cond_init(&cond, NULL);
	pthread_mutex_lock(&mutex);
	if (!pthread_create(&thread, NULL, window_thread, NULL)) {
		pthread_cond_wait(&cond, &mutex);
		pthread_mutex_unlock(&mutex);
		if (is_running)
			return 0;
		pthread_join(thread, NULL);
	}
	pthread_cond_destroy(&cond);
	pthread_mutex_destroy(&mutex);
	
	return -1;
}


/*:::::*/
static void x11_exit(void)
{
	is_running = FALSE;
	pthread_join(thread, NULL);
	pthread_mutex_destroy(&mutex);
	pthread_cond_destroy(&cond);
}


/*:::::*/
static void x11_lock(void)
{
	pthread_mutex_lock(&mutex);
}


/*:::::*/
static void x11_unlock(void)
{
	pthread_mutex_unlock(&mutex);
}


/*:::::*/
static void x11_set_palette(int index, int r, int g, int b)
{
	XColor color;
	
	if (visual->class == PseudoColor) {
		color.pixel = index;
		color.red = (r << 8) | r;
		color.green = (g << 8) | g;
		color.blue = (b << 8) | b;
		color.flags = DoRed | DoGreen | DoBlue;
		XStoreColors(display, color_map, &color, 1);
	}
}


/*:::::*/
static void x11_wait_vsync(void)
{
	x11_lock();
	pthread_cond_wait(&cond, &mutex);
	x11_unlock();
}


/*:::::*/
static int x11_get_mouse(int *x, int *y, int *z, int *buttons)
{
	if ((!mouse_on) || (!has_focus))
		return -1;
	
	*x = mouse_x;
	*y = mouse_y;
	*z = mouse_wheel;
	*buttons = mouse_buttons;
	
	return 0;
}


/*:::::*/
static void x11_set_mouse(int x, int y, int show)
{
	if ((x >= 0) && (has_focus)) {
		mouse_on = TRUE;
		mouse_x = MID(0, x, mode_w - 1);
		mouse_y = MID(0, y, mode_h - 1) + display_offset;
		XWarpPointer(display, None, window, 0, 0, 0, 0, mouse_x, mouse_y);
	}
	if ((show > 0) && (cursor == CURSOR_NONE)) {
		set_cursor(arrow_cursor);
		cursor = CURSOR_ARROW;
	}
	else if ((show == 0) && (cursor == CURSOR_ARROW)) {
		set_cursor(blank_cursor);
		cursor = CURSOR_NONE;
	}
}


/*:::::*/
static void x11_set_window_title(char *title)
{
	XStoreName(display, window, title);
}
