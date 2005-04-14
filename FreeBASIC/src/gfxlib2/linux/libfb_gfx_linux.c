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
 * linux.c -- list of linux gfx drivers
 *
 * chng: jan/2005 written [lillo]
 *
 */

#include "fb_gfx.h"
#include "fb_gfx_linux.h"
#include <unistd.h>


LINUXDRIVER fb_linux;

const GFXDRIVER *fb_gfx_driver_list[] = {
	&fb_gfxDriverX11,
	&fb_gfxDriverOpenGL,
	NULL
};


static pthread_t thread;
static pthread_mutex_t mutex;
static pthread_cond_t cond;

static XIC xic;
static XIM xim;
static Drawable root_window;
static Atom wm_delete_window;
static Colormap color_map;
static XRRScreenConfiguration* config;
static int orig_size, target_size, current_size;
static int orig_rate, target_rate;
static Rotation orig_rotation;
static Cursor blank_cursor, arrow_cursor;
static int is_running, has_focus, cursor_shown, xlib_inited = FALSE;
static int mouse_x, mouse_y, mouse_wheel, mouse_buttons, mouse_on;

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
static void *window_thread(void *arg)
{
	XEvent event;
	int k;
	unsigned char key[8];
	
	(void)arg;
	
	is_running = TRUE;
	if (fb_linux.init())
		is_running = FALSE;
	cursor_shown = TRUE;
	
	pthread_mutex_lock(&mutex);
	pthread_cond_signal(&cond);
	pthread_mutex_unlock(&mutex);
	
	while (is_running)
	{
		fb_hX11Lock();
		
		fb_linux.update();
		
		XSync(fb_linux.display, False);
		while (XPending(fb_linux.display)) {
			XNextEvent(fb_linux.display, &event);
			switch (event.type) {
				
				case Expose:
				case FocusIn:
					fb_hMemSet(fb_mode->dirty, TRUE, fb_linux.h);
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
					mouse_y = event.xmotion.y - fb_linux.display_offset;
					if ((mouse_y < 0) || (mouse_y >= fb_linux.h))
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
				
				
				case ConfigureNotify:
					if ((event.xconfigure.width != fb_linux.w) || (event.xconfigure.height != fb_linux.h)) {
						/* Window has been maximized: simulate ALT-Enter */
						fb_mode->key[0x1C] = fb_mode->key[0x38] = TRUE;
					}
					else
						break;
					/* fallthrough */

				case KeyPress:
					if (has_focus) {
						if (event.type == KeyPress)
							fb_mode->key[fb_linux.keymap[event.xkey.keycode]] = TRUE;
						if ((fb_mode->key[0x1C]) && (fb_mode->key[0x38])) {
							fb_linux.exit();
							fb_linux.fullscreen ^= TRUE;
							if (fb_linux.init()) {
								fb_linux.exit();
								fb_linux.fullscreen ^= TRUE;
								fb_linux.init();
							}
							fb_hRestorePalette();
							fb_hMemSet(fb_mode->key, FALSE, 128);
						}
						else if ((Xutf8LookupString(xic, &event.xkey, key, 8, NULL, NULL) == 1) && (key[0] != 0x7F))
							fb_hPostKey(key[0]);
						else {
							switch (XKeycodeToKeysym(fb_linux.display, event.xkey.keycode, 0)) {
								case XK_Up:		k = KEY_UP;		break;
								case XK_Down:		k = KEY_DOWN; 		break;
								case XK_Left:		k = KEY_LEFT;		break;
								case XK_Right:		k = KEY_RIGHT;		break;
								case XK_Insert:		k = KEY_INS;		break;
								case XK_Delete:		k = KEY_DEL;		break;
								case XK_Home:		k = KEY_HOME;		break;
								case XK_End:		k = KEY_END;		break;
								case XK_Page_Up:	k = KEY_PAGE_UP;	break;
								case XK_Page_Down:	k = KEY_PAGE_DOWN;	break;
								case XK_F1:		k = KEY_F(1);		break;
								case XK_F2:		k = KEY_F(2);		break;
								case XK_F3:		k = KEY_F(3);		break;
								case XK_F4:		k = KEY_F(4);		break;
								case XK_F5:		k = KEY_F(5);		break;
								case XK_F6:		k = KEY_F(6);		break;
								case XK_F7:		k = KEY_F(7);		break;
								case XK_F8:		k = KEY_F(8);		break;
								case XK_F9:		k = KEY_F(9);		break;
								case XK_F10:		k = KEY_F(10);		break;
								default:		k = 0;			break;
							}
							if (k)
								fb_hPostKey(k);
						}
					}
					break;
				
				case KeyRelease:
					if (has_focus)
						fb_mode->key[fb_linux.keymap[event.xkey.keycode]] = FALSE;
					break;
				
				case ClientMessage:
					if ((Atom)event.xclient.data.l[0] == wm_delete_window)
						fb_hPostKey(KEY_QUIT);
					break;
				
			}
		}
		
		pthread_cond_signal(&cond);
		
		fb_hX11Unlock();
		
		usleep(1000000 / 60);
	}
	
	fb_linux.exit();
	
	return NULL;
}


/*:::::*/
int fb_hX11EnterFullscreen(int h)
{
	if ((!config) || (target_size < 0))
		return -1;
	
	if (target_rate < 0) {
		if (XRRSetScreenConfig(fb_linux.display, config, root_window, target_size, orig_rotation, CurrentTime) == BadValue)
			return -1;
	}
	else {
		if (XRRSetScreenConfigAndRate(fb_linux.display, config, root_window, target_size, orig_rotation, target_rate, CurrentTime) == BadValue)
			return -1;
	}
	
	XWarpPointer(fb_linux.display, None, fb_linux.window, 0, 0, 0, 0, fb_linux.w >> 1, fb_linux.h >> 1);
	XSync(fb_linux.display, False);
	while (XGrabPointer(fb_linux.display, fb_linux.window, True, 0,
			    GrabModeAsync, GrabModeAsync, fb_linux.window, None, CurrentTime) != GrabSuccess)
		usleep(10000);
	if (XGrabKeyboard(fb_linux.display, root_window, False,
	    GrabModeAsync, GrabModeAsync, CurrentTime) != GrabSuccess)
		return -1;

	current_size = target_size;

	return 0;
}


/*:::::*/
void fb_hX11LeaveFullscreen()
{
	if ((!config) || (target_size < 0))
		return;
	
	if (current_size != orig_size) {
		XUngrabPointer(fb_linux.display, CurrentTime);
		XUngrabKeyboard(fb_linux.display, CurrentTime);
		if (XRRSetScreenConfigAndRate(fb_linux.display, config, root_window, orig_size, orig_rotation, orig_rate, CurrentTime) == BadValue)
			return;
		current_size = orig_size;
	}
}


/*:::::*/
int fb_hX11Init(char *title, int w, int h, int depth, int refresh_rate, int flags)
{
	XPixmapFormatValues *format;
	XSetWindowAttributes attribs;
	XWMHints hints;
	XpmAttributes xpm_attribs;
	XSizeHints *size;
	Pixmap pixmap;
	XColor color;
	XGCValues gc_values;
	XRRScreenSize *sizes;
	short *rates;
	int version, dummy;
	int i, j, num_formats, num_sizes, num_rates;
	int gc_mask, keycode_min, keycode_max;
	KeySym keysym;
	
	is_running = FALSE;
	if (!xlib_inited) {
		XInitThreads();
		xlib_inited = TRUE;
	}
	
	fb_linux.w = w;
	fb_linux.h = h;
	fb_linux.depth = depth;
	fb_linux.fullscreen = (flags & DRIVER_FULLSCREEN) ? TRUE : FALSE;
	fb_linux.refresh_rate = refresh_rate;
	
	color_map = None;
	arrow_cursor = None;
	xim = NULL;
	xic = NULL;
	config = NULL;
	fb_linux.display = XOpenDisplay(NULL);
	if (!fb_linux.display)
		return -1;
	fb_linux.screen = XDefaultScreen(fb_linux.display);
	root_window = XDefaultRootWindow(fb_linux.display);
	
	fb_linux.visual = XDefaultVisual(fb_linux.display, fb_linux.screen);
	format = XListPixmapFormats(fb_linux.display, &num_formats);
	for (i = 0; i < num_formats; i++) {
		if (format[i].depth == XDefaultDepth(fb_linux.display, fb_linux.screen)) {
			if (format[i].bits_per_pixel == 16)
				fb_linux.visual_depth = format[i].depth;
			else
				fb_linux.visual_depth = format[i].bits_per_pixel;
			break;
		}
	}
	XFree(format);
	
	attribs.border_pixel = attribs.background_pixel = XBlackPixel(fb_linux.display, fb_linux.screen);
	attribs.event_mask = KeyPressMask | KeyReleaseMask | ButtonPressMask | ButtonReleaseMask |
			     PointerMotionMask | FocusChangeMask | EnterWindowMask | LeaveWindowMask | ExposureMask | StructureNotifyMask;
	attribs.backing_store = NotUseful;
	fb_linux.window = XCreateWindow(fb_linux.display, root_window, 0, 0, fb_linux.w, fb_linux.h,
					0, XDefaultDepth(fb_linux.display, fb_linux.screen), InputOutput, fb_linux.visual,
					CWBackPixel | CWBorderPixel | CWEventMask | CWBackingStore, &attribs);
	if (!fb_linux.window)
		return -1;
	XStoreName(fb_linux.display, fb_linux.window, title);
	if (fb_program_icon) {
		hints.flags = IconPixmapHint | IconMaskHint;
		xpm_attribs.valuemask = XpmReturnAllocPixels | XpmReturnExtensions;
		XpmCreatePixmapFromData(fb_linux.display, fb_linux.window, fb_program_icon, &hints.icon_pixmap, &hints.icon_mask, &xpm_attribs);
		XSetWMHints(fb_linux.display, fb_linux.window, &hints);
	}
	
	size = XAllocSizeHints();
	size->flags = PPosition | PBaseSize | PMinSize | PMaxSize | PResizeInc;
	size->x = size->y = 0;
	size->min_width = size->base_width = fb_linux.w;
	size->min_height = size->base_height = fb_linux.h;
	size->max_width = XDisplayWidth(fb_linux.display, fb_linux.screen);
	size->max_height = XDisplayHeight(fb_linux.display, fb_linux.screen);
	size->width_inc = 0x10000;
	size->height_inc = 0x10000;
	XSetWMNormalHints(fb_linux.display, fb_linux.window, size);
	XFree(size);
	
	wm_delete_window = XInternAtom(fb_linux.display, "WM_DELETE_WINDOW", False);
	XSetWMProtocols(fb_linux.display, fb_linux.window, &wm_delete_window, 1);
	if (!(xim = XOpenIM(fb_linux.display, NULL, NULL, NULL)))
		return -1;
	if (!(xic = XCreateIC(xim, XNInputStyle, XIMPreeditNothing | XIMStatusNothing, XNClientWindow, fb_linux.window, NULL)))
		return -1;
	
	if (fb_linux.visual->class == PseudoColor) {
		color_map = XCreateColormap(fb_linux.display, root_window, fb_linux.visual, AllocAll);
		XSetWindowColormap(fb_linux.display, fb_linux.window, color_map);
	}
	XClearWindow(fb_linux.display, fb_linux.window);
	
	pixmap = XCreatePixmap(fb_linux.display, fb_linux.window, 1, 1, 1);
	gc_mask = GCFunction | GCForeground | GCBackground;
	gc_values.function = GXcopy;
	gc_values.foreground = gc_values.background = 0;
	fb_linux.gc = XCreateGC(fb_linux.display, pixmap, gc_mask, &gc_values);
	XDrawPoint(fb_linux.display, pixmap, fb_linux.gc, 0, 0);
	XFreeGC(fb_linux.display, fb_linux.gc);
	color.pixel = color.red = color.green = color.blue = 0;
	color.flags = DoRed | DoGreen | DoBlue;
	blank_cursor = XCreatePixmapCursor(fb_linux.display, pixmap, pixmap, &color, &color, 0, 0);
	arrow_cursor = XCreateFontCursor(fb_linux.display, XC_left_ptr);
	XFreePixmap(fb_linux.display, pixmap);
	fb_linux.gc = DefaultGC(fb_linux.display, fb_linux.screen);
	XSync(fb_linux.display, False);
	
	if (XRRQueryExtension(fb_linux.display, &dummy, &dummy) &&
	    XRRQueryVersion(fb_linux.display, &version, &dummy) && (version >= 1)) {
		config = XRRGetScreenInfo(fb_linux.display, root_window);
		orig_size = current_size = XRRConfigCurrentConfiguration(config, &orig_rotation);
		orig_rate = XRRConfigCurrentRate(config);
		sizes = XRRConfigSizes(config, &num_sizes);
		target_size = -1;
		for (i = 0; i < num_sizes; i++) {
			if ((sizes[i].width == fb_linux.w) && (sizes[i].height == fb_linux.h)) {
				target_size = i;
				break;
			}
		}
		target_rate = -1;
		if ((fb_linux.refresh_rate > 0) && (target_size >= 0)) {
			rates = XRRConfigRates(config, target_size, &num_rates);
			for (i = 0; i < num_rates; i++) {
				if (rates[i] == fb_linux.refresh_rate) {
					target_rate = i;
					break;
				}
			}
		}
		else {
			rates = XRRConfigRates(config, orig_size, &num_rates);
			fb_linux.refresh_rate = rates[orig_rate];
		}
	}
	
	XDisplayKeycodes(fb_linux.display, &keycode_min, &keycode_max);
	keycode_min = MAX(keycode_min, 0);
	keycode_max = MIN(keycode_max, 255);
	for (i = keycode_min; i <= keycode_max; i++) {
		keysym = XKeycodeToKeysym(fb_linux.display, i, 0);
		if (keysym != NoSymbol) {
			for (j = 0; (keysym_to_scancode[j].scancode) && (keysym_to_scancode[j].keysym != keysym); j++)
				;
			fb_linux.keymap[i] = keysym_to_scancode[j].scancode;
		}
	}
	if (flags & DRIVER_FULLSCREEN) {
		mouse_on = TRUE;
		mouse_x = fb_linux.w >> 1;
		mouse_y = fb_linux.h >> 1;
	}
	else
		mouse_on = FALSE;
	mouse_buttons = mouse_wheel = 0;

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
void fb_hX11Exit(void)
{
	if (!is_running)
		return;
	is_running = FALSE;
	pthread_join(thread, NULL);
	pthread_mutex_destroy(&mutex);
	pthread_cond_destroy(&cond);

	if (fb_linux.display) {
		XSync(fb_linux.display, False);
		if (arrow_cursor != None) {
			XUndefineCursor(fb_linux.display, fb_linux.window);
			XFreeCursor(fb_linux.display, arrow_cursor);
			XFreeCursor(fb_linux.display, blank_cursor);
		}
		if (color_map != None)
			XFreeColormap(fb_linux.display, color_map);
		if (fb_linux.window != None)
			XDestroyWindow(fb_linux.display, fb_linux.window);
		if (xic)
			XDestroyIC(xic);
		if (xim)
			XCloseIM(xim);
		if (config) {
			if ((target_size >= 0) && (current_size != orig_size))
				XRRSetScreenConfig(fb_linux.display, config, root_window, orig_size, orig_rotation, CurrentTime);
			XSync(fb_linux.display, False);
			XRRFreeScreenConfigInfo(config);
			config = NULL;
		}
		XCloseDisplay(fb_linux.display);
	}

}


/*:::::*/
void fb_hX11Lock(void)
{
	pthread_mutex_lock(&mutex);
	XLockDisplay(fb_linux.display);
}


/*:::::*/
void fb_hX11Unlock(void)
{
	XUnlockDisplay(fb_linux.display);
	pthread_mutex_unlock(&mutex);
}


/*:::::*/
void fb_hX11SetPalette(int index, int r, int g, int b)
{
	XColor color;
	
	if (fb_linux.visual->class == PseudoColor) {
		color.pixel = index;
		color.red = (r << 8) | r;
		color.green = (g << 8) | g;
		color.blue = (b << 8) | b;
		color.flags = DoRed | DoGreen | DoBlue;
		XStoreColors(fb_linux.display, color_map, &color, 1);
	}
}


/*:::::*/
void fb_hX11WaitVSync(void)
{
	pthread_mutex_lock(&mutex);
	pthread_cond_wait(&cond, &mutex);
	pthread_mutex_unlock(&mutex);
}


/*:::::*/
int fb_hX11GetMouse(int *x, int *y, int *z, int *buttons)
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
void fb_hX11SetMouse(int x, int y, int show)
{
	if ((x >= 0) && (has_focus)) {
		mouse_on = TRUE;
		mouse_x = MID(0, x, fb_linux.w - 1);
		mouse_y = MID(0, y, fb_linux.h - 1) + fb_linux.display_offset;
		XWarpPointer(fb_linux.display, None, fb_linux.window, 0, 0, 0, 0, mouse_x, mouse_y);
	}
	if ((show > 0) && (!cursor_shown)) {
		XUndefineCursor(fb_linux.display, fb_linux.window);
		XDefineCursor(fb_linux.display, fb_linux.window, arrow_cursor);
		cursor_shown = TRUE;
	}
	else if ((show == 0) && (cursor_shown)) {
		XUndefineCursor(fb_linux.display, fb_linux.window);
		XDefineCursor(fb_linux.display, fb_linux.window, blank_cursor);
		cursor_shown = FALSE;
	}
}


/*:::::*/
void fb_hX11SetWindowTitle(char *title)
{
	XStoreName(fb_linux.display, fb_linux.window, title);
}

