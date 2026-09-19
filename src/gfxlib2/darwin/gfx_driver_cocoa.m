/* Native Cocoa 2D graphics driver for gfxlib2 (macOS)

   Presents FreeBASIC's software framebuffer in a real NSWindow through
   CoreGraphics, so that a plain ScreenRes works without XQuartz and without
   OpenGL (which is deprecated on macOS).

   The window/view/event handling is modelled on the Cocoa/OpenGL driver from
   PR #448 by Markos-Th09; the software-framebuffer present path is new.

   How the pieces fit together in gfxlib2:

     - the core renders into __fb_gfx->page[] / framebuffer and marks changed
       scanlines in __fb_gfx->dirty[];
     - a refresh thread converts the framebuffer to 32-bit BGRA with the
       gfxlib2 blitter (fb_hGetBlitter) and hands the image to the layer;
     - AppKit itself is only touched on the main thread, from the driver
       hooks the core calls (flip/unlock/poll_events/wait_vsync).

   There is no NSApplication run loop here: an FB program owns the process
   main thread, so events are pumped on demand instead.
*/

#include <sys/types.h>
#include <string.h>
#include <unistd.h>
#include <pthread.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>

#include "../fb_gfx.h"
#include "fb_gfx_cocoa.h"
#include "../../rtlib/darwin/fb_private_scancodes_cocoa.h"

#if defined(HOST_DARWIN)

#import <AppKit/AppKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>

/* ------------------------------------------------------------ driver state */

typedef struct {
	NSWindow *window;
	NSView *view;
	CGContextRef ctx;			/* bitmap context over buf */
	unsigned char *buf;			/* w * h * 4, BGRA */
	BLITTER *blitter;			/* framebuffer -> BGRA converter */
	pthread_mutex_t mutex;
	pthread_t thread;
	volatile int running;
	volatile int present_pending;
	int w, h;
	int mouse_x, mouse_y, mouse_z;
	int mouse_buttons;
	int mouse_visible;
	int has_focus;
	int cursor_shown;
} COCOA_CTX;

static COCOA_CTX cocoa;

static int cocoa_ready = 0;
static int cocoa_app_ready = 0;

/* ------------------------------------------------------------------ present */

/* Convert the FB framebuffer into our BGRA buffer.  Caller holds the mutex. */
static void cocoa_convert(void)
{
	if (!__fb_gfx || !cocoa.buf || !cocoa.blitter)
		return;

	cocoa.blitter(cocoa.buf, cocoa.w * 4);

	if (__fb_gfx->dirty)
		fb_hMemSet(__fb_gfx->dirty, 0, __fb_gfx->h);
}

/* Publish the buffer to the window.  Main thread only (AppKit). */
static void cocoa_present(void)
{
	CGImageRef image;

	if (!cocoa_ready || !__fb_gfx)
		return;

	pthread_mutex_lock(&cocoa.mutex);
	cocoa_convert();
	image = CGBitmapContextCreateImage(cocoa.ctx);
	pthread_mutex_unlock(&cocoa.mutex);

	if (image == NULL)
		return;

	/* Layer contents are set on the main thread here; the refresh thread
	   does its own best-effort publish for programs that never reach a
	   driver hook. */
	cocoa.view.layer.contents = (__bridge id)image;
	CGImageRelease(image);
}

/* Best-effort publish from the refresh thread: Core Animation is thread-safe
   for layer property mutation, and an explicit flush pushes the change to the
   render server without relying on a main-thread run loop. */
static void cocoa_present_background(CGImageRef image)
{
	cocoa.view.layer.contents = (__bridge id)image;
	[CATransaction flush];
}

/* --------------------------------------------------------------- event pump */

/* Optional diagnostics: set FBCOCOA_DEBUG=<file> to log the raw AppKit events
   the driver receives, which is the quickest way to tell an input delivery
   problem from a translation problem. */
static FILE *cocoa_debug = NULL;

static void cocoa_debug_init(void)
{
	char *p = getenv("FBCOCOA_DEBUG");

	if (p && *p)
		cocoa_debug = fopen(p, "a");
}

static void cocoa_debug_log(const char *fmt, ...)
{
	va_list ap;

	if (cocoa_debug == NULL)
		return;

	va_start(ap, fmt);
	vfprintf(cocoa_debug, fmt, ap);
	va_end(ap);
	fflush(cocoa_debug);
}

static void cocoa_post_key(int scancode, int ascii, int type)
{
	EVENT e;

	if (!__fb_gfx)
		return;

	fb_hMemSet(&e, 0, sizeof(EVENT));
	e.type = type;
	e.scancode = scancode;
	e.ascii = ascii;
	fb_hPostEvent(&e);
}

static void cocoa_post_mouse(int type, int x, int y, int button)
{
	EVENT e;

	if (!__fb_gfx)
		return;

	fb_hMemSet(&e, 0, sizeof(EVENT));
	e.type = type;
	e.x = x;
	e.y = y;
	e.button = button;
	fb_hPostEvent(&e);
}

/* Map an NSEvent to FB's keycode convention: plain characters as-is, extended
   keys (arrows, function keys, ...) through the scancode table, mirroring what
   the X11 driver does with XLookupString/translate_key. */
static int cocoa_translate_key(NSEvent *event, int scancode)
{
	NSString *chars = [event characters];
	unichar c;

	if ([chars length] >= 1) {
		c = [chars characterAtIndex:0];
		/* Remap ASCII DEL to FB's extended DELETE keycode, as the other
		   drivers do */
		if (c == 0x7F)
			return KEY_DEL;
		if (c < 0x80)
			return (int)c;
	}

	return fb_hScancodeToExtendedKey(scancode);
}

static void cocoa_handle_event(NSEvent *event)
{
	NSPoint p;
	int scancode;

	if (!__fb_gfx)
		return;

	cocoa_debug_log("event type=%d\n", (int)[event type]);

	switch ([event type]) {
	case NSEventTypeKeyDown:
	case NSEventTypeKeyUp:
		scancode = fb_cocoakeycode_to_scancode[[event keyCode] & 0xFF];
		cocoa_debug_log("  key keyCode=%d scancode=%d down=%d\n",
		                (int)[event keyCode], scancode,
		                [event type] == NSEventTypeKeyDown);
		if (scancode == 0)
			break;
		if ([event type] == NSEventTypeKeyDown) {
			int key = cocoa_translate_key(event, scancode);

			cocoa_debug_log("  translated key=%d\n", key);
			__fb_gfx->key[scancode] = TRUE;
			/* InKey() reads the key buffer, GetKey()/the event queue read
			   the posted event, so feed both like the other drivers do */
			if (key)
				fb_hPostKey(key);
			cocoa_post_key(scancode, ((key < 0) || (key > 0xFF)) ? 0 : key,
			               [event isARepeat] ? EVENT_KEY_REPEAT : EVENT_KEY_PRESS);
		} else {
			__fb_gfx->key[scancode] = FALSE;
			cocoa_post_key(scancode, 0, EVENT_KEY_RELEASE);
		}
		break;

	case NSEventTypeFlagsChanged:
		/* Modifier keys arrive here rather than as key down/up */
		scancode = fb_cocoakeycode_to_scancode[[event keyCode] & 0xFF];
		if (scancode == 0)
			break;
		if (__fb_gfx->key[scancode]) {
			__fb_gfx->key[scancode] = FALSE;
			cocoa_post_key(scancode, 0, EVENT_KEY_RELEASE);
		} else {
			__fb_gfx->key[scancode] = TRUE;
			cocoa_post_key(scancode, 0, EVENT_KEY_PRESS);
		}
		break;

	case NSEventTypeMouseMoved:
		/* Only report motion inside the window; this driver sees moves for
		   the whole app, unlike the X11 one which only gets in-window
		   motion events. */
		p = [event locationInWindow];
		if ((p.x < 0) || (p.x >= cocoa.w) || (p.y < 0) || (p.y >= cocoa.h))
			break;
		cocoa.mouse_x = (int)p.x;
		cocoa.mouse_y = cocoa.h - (int)p.y - 1;
		cocoa_post_mouse(EVENT_MOUSE_MOVE, cocoa.mouse_x, cocoa.mouse_y, 0);
		break;

	case NSEventTypeLeftMouseDragged:
	case NSEventTypeRightMouseDragged:
	case NSEventTypeOtherMouseDragged:
		/* Dragging may legitimately leave the window */
		p = [event locationInWindow];
		cocoa.mouse_x = (int)p.x;
		cocoa.mouse_y = cocoa.h - (int)p.y - 1;
		cocoa_post_mouse(EVENT_MOUSE_MOVE, cocoa.mouse_x, cocoa.mouse_y, 0);
		break;

	case NSEventTypeLeftMouseDown:
	case NSEventTypeRightMouseDown:
	case NSEventTypeOtherMouseDown:
		cocoa.mouse_buttons |= 1 << [event buttonNumber];
		cocoa_post_mouse(EVENT_MOUSE_BUTTON_PRESS, cocoa.mouse_x, cocoa.mouse_y,
		                 1 << [event buttonNumber]);
		break;

	case NSEventTypeLeftMouseUp:
	case NSEventTypeRightMouseUp:
	case NSEventTypeOtherMouseUp:
		cocoa.mouse_buttons &= ~(1 << [event buttonNumber]);
		cocoa_post_mouse(EVENT_MOUSE_BUTTON_RELEASE, cocoa.mouse_x, cocoa.mouse_y,
		                 1 << [event buttonNumber]);
		break;

	case NSEventTypeScrollWheel:
		cocoa.mouse_z += (int)[event scrollingDeltaY];
		cocoa_post_mouse(EVENT_MOUSE_WHEEL, cocoa.mouse_x, cocoa.mouse_y, 0);
		break;

	default:
		break;
	}
}

/* Pump pending AppKit events.  Main thread only. */
static void cocoa_pump_events(void)
{
	NSEvent *event;
	static int last_active = -1, last_key = -1;
	int active, keywin;

	if (!cocoa_ready)
		return;

	active = [NSApp isActive] ? 1 : 0;
	keywin = [cocoa.window isKeyWindow] ? 1 : 0;
	if ((active != last_active) || (keywin != last_key)) {
		last_active = active;
		last_key = keywin;
		cocoa_debug_log("state isActive=%d isKeyWindow=%d\n", active, keywin);
	}

	while ((event = [NSApp nextEventMatchingMask:NSEventMaskAny
	                                   untilDate:[NSDate distantPast]
	                                      inMode:NSDefaultRunLoopMode
	                                     dequeue:YES]) != nil) {
		cocoa_handle_event(event);
		[NSApp sendEvent:event];
	}

	/* Focus follows the window, which is what InKey/GetMouse care about */
	cocoa.has_focus = keywin ? TRUE : FALSE;
}

/* --------------------------------------------------------- refresh thread */

/* Converts the framebuffer and publishes it; no AppKit window management or
   event handling happens here. */
static void *cocoa_thread(void *arg)
{
	(void)arg;

	while (cocoa.running) {
		CGImageRef image;

		pthread_mutex_lock(&cocoa.mutex);
		cocoa_convert();
		image = CGBitmapContextCreateImage(cocoa.ctx);
		pthread_mutex_unlock(&cocoa.mutex);

		if (image) {
			cocoa_present_background(image);
			CGImageRelease(image);
		}

		usleep(1000 * 1000 / 60);
	}

	return NULL;
}

/* --------------------------------------------------------------- callbacks */

void fb_hCocoaLock(void)
{
	pthread_mutex_lock(&cocoa.mutex);
}

void fb_hCocoaUnlock(void)
{
	/* Called whenever the program unlocks the screen; a natural point to
	   push the current frame out on the main thread. */
	if (cocoa_ready) {
		CGImageRef image;

		cocoa_convert();
		image = CGBitmapContextCreateImage(cocoa.ctx);
		if (image) {
			cocoa.view.layer.contents = (__bridge id)image;
			CGImageRelease(image);
		}
		cocoa_pump_events();
	}

	pthread_mutex_unlock(&cocoa.mutex);
}

void fb_hCocoaWaitVSync(void)
{
	usleep(1000000 / ((__fb_gfx && __fb_gfx->refresh_rate > 0) ? __fb_gfx->refresh_rate : 60));
}

void fb_hCocoaSetPalette(int index, int r, int g, int b)
{
	/* The blitter reads __fb_gfx->palette directly, so nothing to do here. */
	(void)index; (void)r; (void)g; (void)b;
}

int fb_hCocoaGetMouse(int *x, int *y, int *z, int *buttons, int *clip)
{
	/* Always report the last known state.  Gating this on the window being
	   key (as the X11 driver does with its focus tracking) makes GetMouse()
	   return -1 whenever another application is frontmost, which breaks
	   programs that poll the mouse while unattended. */
	*x = cocoa.mouse_x;
	*y = cocoa.mouse_y;
	*z = cocoa.mouse_z;
	*buttons = cocoa.mouse_buttons;
	*clip = 0;
	return 0;
}

void fb_hCocoaSetMouse(int x, int y, int cursor, int clip)
{
	(void)clip;

	cocoa.mouse_x = x;
	cocoa.mouse_y = y;

	if (cursor != 0) {
		if (!cocoa.cursor_shown) {
			[NSCursor unhide];
			cocoa.cursor_shown = 1;
		}
	} else {
		if (cocoa.cursor_shown) {
			[NSCursor hide];
			cocoa.cursor_shown = 0;
		}
	}
}

void fb_hCocoaSetWindowTitle(char *title)
{
	if (cocoa_ready && title)
		cocoa.window.title = [NSString stringWithUTF8String:title];
}

int fb_hCocoaSetWindowPos(int x, int y)
{
	if (!cocoa_ready)
		return -1;

	/* FB coordinates are top-left based; Cocoa's are bottom-left based */
	NSRect screen = [[NSScreen mainScreen] frame];
	[cocoa.window setFrameTopLeftPoint:NSMakePoint(x, screen.size.height - y)];
	return 0;
}

int fb_hCocoaScreenInfo(ssize_t *width, ssize_t *height, ssize_t *depth, ssize_t *refresh)
{
	NSRect frame = [[NSScreen mainScreen] frame];

	*width = (ssize_t)frame.size.width;
	*height = (ssize_t)frame.size.height;
	*depth = 32;
	*refresh = 60;
	return 0;
}

int *fb_hCocoaFetchModes(int depth, int *size)
{
	/* No fullscreen modes: the driver is windowed only */
	(void)depth;
	if (size)
		*size = 0;
	return NULL;
}

/* ---------------------------------------------------------- driver entry pts */

static void cocoa_poll_events_hook(void)
{
	/* Called by the core (also from ScreenControl POLL_EVENTS) */
	if (!cocoa_ready)
		return;

	cocoa_pump_events();
}

static void cocoa_flip_hook(void)
{
	if (!cocoa_ready)
		return;

	cocoa_present();
	cocoa_pump_events();
}

static void cocoa_update_hook(void)
{
	if (!cocoa_ready)
		return;

	cocoa_present();
}

static int driver_init(char *title, int w, int h, int depth, int refresh_rate, int flags)
{
	@autoreleasepool {
		NSRect rect;
		NSInteger style;
		CGColorSpaceRef cs;
		int stride;

		/* OpenGL screens are handled by the X11/GLX driver (via XQuartz) */
		if (flags & DRIVER_OPENGL)
			return -1;

		if (w <= 0 || h <= 0)
			return -1;

		fb_hMemSet(&cocoa, 0, sizeof(cocoa));
		cocoa.w = w;
		cocoa.h = h;
		cocoa.mouse_visible = 1;
		cocoa.has_focus = 1;
		pthread_mutex_init(&cocoa.mutex, NULL);
		cocoa_debug_init();
		cocoa_debug_log("--- driver_init w=%d h=%d depth=%d flags=%d\n", w, h, depth, flags);

		if (!cocoa_app_ready) {
			[NSApplication sharedApplication];
			[NSApp setActivationPolicy:NSApplicationActivationPolicyRegular];
			cocoa_app_ready = 1;
		}

		style = NSWindowStyleMaskTitled | NSWindowStyleMaskClosable |
		        NSWindowStyleMaskMiniaturizable;
		rect = NSMakeRect(0, 0, w, h);
		cocoa.window = [[NSWindow alloc] initWithContentRect:rect
		                                          styleMask:style
		                                            backing:NSBackingStoreBuffered
		                                              defer:NO];
		if (cocoa.window == nil)
			return -1;

		cocoa.window.title = [NSString stringWithUTF8String:(title ? title : "FreeBASIC")];
		[cocoa.window setReleasedWhenClosed:NO];
		[cocoa.window center];

		cocoa.view = [[NSView alloc] initWithFrame:rect];
		cocoa.view.wantsLayer = YES;
		/* 1:1 pixels: the image is w x h and so is the layer in points, so
		   a 2x backing store upscales it with nearest-neighbour filtering
		   rather than smoothing it. */
		cocoa.view.layer.contentsGravity = kCAGravityResize;
		cocoa.view.layer.magnificationFilter = kCAFilterNearest;
		cocoa.view.layer.contentsScale = 1.0;
		cocoa.window.contentView = cocoa.view;

		/* Closing the window should end the program, as ALT+F4 does
		   elsewhere: post the close event and the quit key. */
		[[NSNotificationCenter defaultCenter]
		    addObserverForName:NSWindowWillCloseNotification
		                object:cocoa.window
		                 queue:nil
		            usingBlock:^(NSNotification *note) {
			EVENT e;
			(void)note;
			if (!__fb_gfx)
				return;
			fb_hMemSet(&e, 0, sizeof(EVENT));
			e.type = EVENT_WINDOW_CLOSE;
			fb_hPostEvent(&e);
			fb_hPostKey(KEY_QUIT);
		}];

		[cocoa.window makeKeyAndOrderFront:nil];
		[NSApp activateIgnoringOtherApps:YES];

		/* The gfxlib2 blitter for a 32-bit device depth writes R,G,B,X
		   bytes: component order R,G,B with a trailing skipped byte, i.e.
		   kCGImageAlphaNoneSkipLast with big-endian 32-bit words. */
		stride = w * 4;
		cocoa.buf = (unsigned char *)calloc(1, (size_t)stride * h);
		if (cocoa.buf == NULL)
			return -1;

		cs = CGColorSpaceCreateDeviceRGB();
		cocoa.ctx = CGBitmapContextCreate(cocoa.buf, w, h, 8, stride, cs,
		                                  kCGImageAlphaNoneSkipLast |
		                                  kCGBitmapByteOrder32Big);
		CGColorSpaceRelease(cs);
		if (cocoa.ctx == NULL)
			return -1;

		cocoa.blitter = fb_hGetBlitter(32, TRUE);
		if (cocoa.blitter == NULL)
			return -1;

		cocoa_ready = 1;
		cocoa.running = 1;
		if (pthread_create(&cocoa.thread, NULL, cocoa_thread, NULL) != 0) {
			cocoa.running = 0;
			cocoa_ready = 0;
			return -1;
		}

		if (refresh_rate > 0 && __fb_gfx)
			__fb_gfx->refresh_rate = refresh_rate;

		return 0;
	}
}

static void driver_exit(void)
{
	if (!cocoa_ready)
		return;

	cocoa.running = 0;
	pthread_join(cocoa.thread, NULL);
	cocoa_ready = 0;

	@autoreleasepool {
		if (cocoa.ctx) {
			CGContextRelease(cocoa.ctx);
			cocoa.ctx = NULL;
		}
		if (cocoa.buf) {
			free(cocoa.buf);
			cocoa.buf = NULL;
		}
		if (cocoa.window) {
			[cocoa.window orderOut:nil];
			cocoa.window = nil;
		}
		cocoa.view = nil;
	}

	pthread_mutex_destroy(&cocoa.mutex);
}

/* GFXDRIVER */
const GFXDRIVER fb_gfxDriverCocoa =
{
	"Cocoa",                    /* char *name; */
	driver_init,                /* int (*init)(...) */
	driver_exit,                /* void (*exit)(void); */
	fb_hCocoaLock,              /* void (*lock)(void); */
	fb_hCocoaUnlock,            /* void (*unlock)(void); */
	fb_hCocoaSetPalette,        /* void (*set_palette)(...); */
	fb_hCocoaWaitVSync,         /* void (*wait_vsync)(void); */
	fb_hCocoaGetMouse,          /* int (*get_mouse)(...); */
	fb_hCocoaSetMouse,          /* void (*set_mouse)(...); */
	fb_hCocoaSetWindowTitle,    /* void (*set_window_title)(char *); */
	fb_hCocoaSetWindowPos,      /* int (*set_window_pos)(int, int); */
	fb_hCocoaFetchModes,        /* int *(*fetch_modes)(int, int *); */
	cocoa_flip_hook,            /* void (*flip)(void); */
	cocoa_poll_events_hook,     /* void (*poll_events)(void); */
	cocoa_update_hook            /* void (*update)(void); */
};

#else
typedef int fb_cocoa_driver_disabled_t;		/* avoid an empty translation unit */
#endif
