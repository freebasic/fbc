#ifdef DISABLE_X11

#include "../../rtlib/darwin/fb_private_scancodes_cocoa.h"
#include "../fb_gfx.h"
#include "../fb_gfx_gl.h"
#include "fb_gfx_cocoa.h"

#import <AppKit/AppKit.h>
#import <CoreVideo/CoreVideo.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreFoundation/CoreFoundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <OpenGL/OpenGL.h>
#import <Cocoa/Cocoa.h>
#import <Foundation/Foundation.h>
#include <dispatch/dispatch.h>
#include <dlfcn.h>

static int driver_init(char *title, int w, int h, int depth, int refresh_rate, int flags);
static void driver_exit(void);
static void driver_flip(void);
static void driver_poll_events(void);

/* GFXDRIVER */
const GFXDRIVER fb_gfxDriverCocoaOpenGL = {
	"Cocoa OpenGL",		  /* char *name; */
	driver_init,			 /* int (*init)(char *title, int w, int h, int depth, int refresh_rate, int flags); */
	driver_exit,			 /* void (*exit)(void); */
	fb_hCocoaLock,		   /* void (*lock)(void); */
	fb_hCocoaUnlock,		 /* void (*unlock)(void); */
	fb_hGL_SetPalette,	   /* void (*set_palette)(int index, int r, int g, int b); */
	fb_hCocoaWaitVSync,	  /* void (*wait_vsync)(void); */
	fb_hCocoaGetMouse,	   /* int (*get_mouse)(int *x, int *y, int *z, int *buttons, int *clip); */
	fb_hCocoaSetMouse,	   /* void (*set_mouse)(int x, int y, int cursor, int clip); */
	fb_hCocoaSetWindowTitle, /* void (*set_window_title)(char *title); */
	fb_hCocoaSetWindowPos,   /* int (*set_window_pos)(int x, int y); */
	fb_hCocoaFetchModes,	 /* int *(*fetch_modes)(void); */
	driver_flip,			 /* void (*flip)(void); */
	driver_poll_events,	  /* void (*poll_events)(void); */
	NULL,					/* void (*update)(void); */
};

static dispatch_semaphore_t vsyncSema = NULL;

@interface OpenGLView : NSOpenGLView
#if __MAC_OS_X_VERSION_MIN_REQUIRED >= 140000
@property (nonatomic, strong) CADisplayLink *displayLink;
#endif
@end

#if __MAC_OS_X_VERSION_MIN_REQUIRED < 140000
static CVDisplayLinkRef cvDisplayLink = NULL;
static CVReturn DisplayLinkCallback(CVDisplayLinkRef displayLink,
									const CVTimeStamp *now,
									const CVTimeStamp *outputTime,
									CVOptionFlags flagsIn,
									CVOptionFlags *flagsOut,
									void *displayLinkContext);
#endif
@implementation OpenGLView
- (BOOL)acceptsFirstResponder
{
	return YES;
}
- (void)createDisplayLink
{
	vsyncSema = dispatch_semaphore_create(0);
	#if __MAC_OS_X_VERSION_MIN_REQUIRED >= 140000
		self.displayLink = [self displayLinkWithTarget:self selector:@selector(waitVSync)];
		[self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
	#else
		CVDisplayLinkCreateWithActiveCGDisplays(&cvDisplayLink);
		CVDisplayLinkSetOutputCallback(cvDisplayLink, &DisplayLinkCallback, (__bridge void *)self);
		CVDisplayLinkStart(cvDisplayLink);
	#endif
}

- (void)waitVSync
{
	dispatch_semaphore_signal(vsyncSema);
}

- (void)dealloc
{
	#if __MAC_OS_X_VERSION_MIN_REQUIRED >= 140000
		[self.displayLink invalidate];
		self.displayLink = nil;
	#else
		CVDisplayLinkStop(cvDisplayLink);
		CVDisplayLinkRelease(cvDisplayLink);
	#endif
	dispatch_release(vsyncSema);
	[super dealloc];
}

@end

#if __MAC_OS_X_VERSION_MIN_REQUIRED < 140000
static CVReturn DisplayLinkCallback(CVDisplayLinkRef displayLink,
									const CVTimeStamp *now,
									const CVTimeStamp *outputTime,
									CVOptionFlags flagsIn,
									CVOptionFlags *flagsOut,
									void *displayLinkContext)
{
	OpenGLView *self = (__bridge OpenGLView *)displayLinkContext;
	[self waitVSync];
	return kCVReturnSuccess;
}
#endif

extern char **_NSGetProgname(void);

static void create_menu_bar(void)
{
	NSString *appName = nil;
	NSDictionary *bundleInfo = [[NSBundle mainBundle] infoDictionary];
	NSString *nameKeys[] =
		{
			@"CFBundleDisplayName",
			@"CFBundleName",
			@"CFBundleExecutable",
		};

	// Try to figure out what the calling application is called

	for (size_t i = 0; i < sizeof(nameKeys) / sizeof(nameKeys[0]); i++) {
		id name = bundleInfo[nameKeys[i]];
		if (name &&
			[name isKindOfClass:[NSString class]] &&
			![name isEqualToString:@""]) {
			appName = name;
			break;
		}
	}

	if (!appName) {
		char **progname = _NSGetProgname();
		if (progname && *progname)
			appName = @(*progname);
		else
			appName = @"Application";
	}

	NSMenu *bar = [[NSMenu alloc] init];
	[NSApp setMainMenu:bar];

	NSMenuItem *appMenuItem =
		[bar addItemWithTitle:@""
					   action:NULL
				keyEquivalent:@""];
	NSMenu *appMenu = [[NSMenu alloc] init];
	[appMenuItem setSubmenu:appMenu];

	[appMenu addItemWithTitle:[NSString stringWithFormat:@"About %@", appName]
					   action:@selector(orderFrontStandardAboutPanel:)
				keyEquivalent:@""];
	[appMenu addItem:[NSMenuItem separatorItem]];
	NSMenu *servicesMenu = [[NSMenu alloc] init];
	[NSApp setServicesMenu:servicesMenu];
	[[appMenu addItemWithTitle:@"Services"
						action:NULL
				 keyEquivalent:@""] setSubmenu:servicesMenu];
	[servicesMenu release];
	[appMenu addItem:[NSMenuItem separatorItem]];
	[appMenu addItemWithTitle:[NSString stringWithFormat:@"Hide %@", appName]
					   action:@selector(hide:)
				keyEquivalent:@"h"];
	[[appMenu addItemWithTitle:@"Hide Others"
						action:@selector(hideOtherApplications:)
				 keyEquivalent:@"h"]
		setKeyEquivalentModifierMask:NSEventModifierFlagOption | NSEventModifierFlagCommand];
	[appMenu addItemWithTitle:@"Show All"
					   action:@selector(unhideAllApplications:)
				keyEquivalent:@""];
	[appMenu addItem:[NSMenuItem separatorItem]];
	[appMenu addItemWithTitle:[NSString stringWithFormat:@"Quit %@", appName]
					   action:@selector(terminate:)
				keyEquivalent:@"q"];

	NSMenuItem *windowMenuItem =
		[bar addItemWithTitle:@""
					   action:NULL
				keyEquivalent:@""];
	[bar release];
	NSMenu *windowMenu = [[NSMenu alloc] initWithTitle:@"Window"];
	[NSApp setWindowsMenu:windowMenu];
	[windowMenuItem setSubmenu:windowMenu];

	[windowMenu addItemWithTitle:@"Minimize"
						  action:@selector(performMiniaturize:)
				   keyEquivalent:@"m"];
	[windowMenu addItemWithTitle:@"Zoom"
						  action:@selector(performZoom:)
				   keyEquivalent:@""];
	[windowMenu addItem:[NSMenuItem separatorItem]];
	[windowMenu addItemWithTitle:@"Bring All to Front"
						  action:@selector(arrangeInFront:)
				   keyEquivalent:@""];

	// TODO: Make this appear at the bottom of the menu (for consistency)
	[windowMenu addItem:[NSMenuItem separatorItem]];
	[[windowMenu addItemWithTitle:@"Enter Full Screen"
						   action:@selector(toggleFullScreen:)
					keyEquivalent:@"f"]
		setKeyEquivalentModifierMask:NSEventModifierFlagControl | NSEventModifierFlagCommand];

	// Prior to Snow Leopard, we need to use this oddly-named semi-private API
	// to get the application menu working properly.
	SEL setAppleMenuSelector = NSSelectorFromString(@"setAppleMenu:");
	[NSApp performSelector:setAppleMenuSelector withObject:appMenu];
}

@interface AppDelegate : NSObject <NSApplicationDelegate>
@end

@interface WindowDelegate : NSObject <NSWindowDelegate>
@end

@interface OpenGLWindow : NSWindow
@end

typedef struct {
	bool closed;
	OpenGLWindow *window;
	OpenGLView *view;
	NSOpenGLContext *context;
	NSRect frame;
} OpenGLDriver;

static OpenGLDriver driver;
static int mouse_wheel, mouse_hwheel = 0;
static bool has_focus = false;
static void* gl_lib = NULL;
static NSRecursiveLock* lock = nil;

@implementation AppDelegate
- (void)applicationWillFinishLaunching:(NSNotification *)notification
{
	create_menu_bar();
}
- (void)applicationDidFinishLaunching:(NSNotification *)notification
{
	[NSApp stop:nil];
}
- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
		return YES;
}
- (void)applicationWillTerminate:(NSNotification *)notification
{
	driver.closed = YES;
}
@end

@implementation WindowDelegate
- (BOOL)windowShouldClose:(NSWindow *)sender
{
	EVENT e;
	e.type = EVENT_WINDOW_CLOSE;
	fb_hPostEvent(&e);
	driver.closed = YES;
	return YES;
}
- (void)windowDidBecomeKey:(NSNotification *)notification
{
	EVENT e;
	e.type = EVENT_WINDOW_GOT_FOCUS;
	fb_hPostEvent(&e);
	has_focus = true;
}

- (void)windowDidResignKey:(NSNotification *)notification {
	EVENT e;
	e.type = EVENT_WINDOW_LOST_FOCUS;
	fb_hPostEvent(&e);
	has_focus = false;
}
@end

@implementation OpenGLWindow
- (BOOL)canBecomeKeyWindow
{
	return YES;
}

- (BOOL)canBecomeMainWindow
{
	return YES;
}
@end

static int driver_init(char *title, int w, int h, int depth, int refresh_rate,
					   int flags) {
	if (!(flags & DRIVER_OPENGL))
		return -1;
  	@autoreleasepool {
		lock = [[NSRecursiveLock alloc] init];
		[NSApplication sharedApplication];
		[NSApp setDelegate:[[AppDelegate alloc] init]];
		[NSApp setActivationPolicy:NSApplicationActivationPolicyRegular];

		driver.frame = NSMakeRect(0, 0, w, h);

		fb_hGL_NormalizeParameters(flags);
		NSOpenGLPixelFormatAttribute attribs[32] = {0};
		NSOpenGLPixelFormatAttribute* attrib = attribs;
		NSOpenGLPixelFormatAttribute* samples_attrib = NULL;

		*attrib++ = NSOpenGLPFADoubleBuffer;
		*attrib++ = NSOpenGLPFAAccelerated;
		*attrib++ = NSOpenGLPFAOpenGLProfile;
		*attrib++ = NSOpenGLProfileVersionLegacy;
		*attrib++ = NSOpenGLPFAColorSize;
		*attrib++ = __fb_gl_params.color_bits;
		*attrib++ = NSOpenGLPFAAlphaSize;
		*attrib++ = __fb_gl_params.color_alpha_bits;
		*attrib++ = NSOpenGLPFADepthSize;
		*attrib++ = depth;
		if (__fb_gl_params.stencil_bits > 0) {
			*attrib++ = NSOpenGLPFAStencilSize;
			*attrib++ = __fb_gl_params.stencil_bits;
		}
		if (__fb_gl_params.accum_bits > 0) {
			*attrib++ = NSOpenGLPFAAccumSize;
			*attrib++ = __fb_gl_params.accum_bits;
		}
		if (__fb_gl_params.num_samples > 0) {
			*attrib++ = NSOpenGLPFAMultisample;
			*attrib++ = NSOpenGLPFASampleBuffers;
			*attrib++ = 1;
			*attrib++ = NSOpenGLPFASamples;
			*attrib++ = __fb_gl_params.num_samples;
			samples_attrib = attrib;
		}

		if (!gl_lib) gl_lib = dlopen("/System/Library/Frameworks/OpenGL.framework/Versions/Current", RTLD_LAZY);
		if (!gl_lib) gl_lib = dlopen("/System/Library/Frameworks/OpenGL.framework/Versions/Current/OpenGL", RTLD_LAZY);
		if (!gl_lib) return -1;

		NSOpenGLPixelFormat *format = [[NSOpenGLPixelFormat alloc] initWithAttributes:attribs];
		driver.context = [[NSOpenGLContext alloc] initWithFormat:format shareContext:nil];
		[format release];
		if (!driver.context) return -1;
		driver.view = [[OpenGLView alloc] initWithFrame:driver.frame];
		if (!driver.view) return -1;
		[driver.view setOpenGLContext:driver.context];
		[driver.view setWantsBestResolutionOpenGLSurface:YES];

		driver.window =
			[[OpenGLWindow alloc] initWithContentRect:driver.frame
										styleMask:(NSWindowStyleMaskTitled |
												   NSWindowStyleMaskClosable |
												   NSWindowStyleMaskResizable |
												   NSWindowStyleMaskMiniaturizable)
										  backing:NSBackingStoreBuffered
											defer:NO];

		[driver.window setDelegate:[[WindowDelegate alloc] init]];

		[driver.window setContentView:driver.view];
		[driver.window makeFirstResponder:driver.view];
		[driver.window setTitle:[NSString stringWithUTF8String:title]];
		[driver.window setCollectionBehavior:NSWindowCollectionBehaviorFullScreenPrimary | NSWindowCollectionBehaviorManaged];
		[driver.window setAcceptsMouseMovedEvents:YES];
		[driver.window setRestorable:NO];
		[driver.window center];

		[NSApp activateIgnoringOtherApps:YES];
		[driver.window makeKeyAndOrderFront:nil];
		has_focus = true;
		if (![[NSRunningApplication currentApplication] isFinishedLaunching])
			[NSApp run];

		[driver.context makeCurrentContext];

		__fb_gl_params.mode_2d = __fb_gl_params.init_mode_2d;
		if (__fb_gl_params.init_scale>=1){
			__fb_gl_params.scale = __fb_gl_params.init_scale;
		}

		if (__fb_gl_params.scale>1){
			free(__fb_gfx->dirty);
			__fb_gfx->dirty = (char *)calloc(1, __fb_gfx->h * __fb_gfx->scanline_size * __fb_gl_params.scale);
		}

		if (fb_hGL_Init(gl_lib, NULL)) return -1;

		if ((samples_attrib) && (*samples_attrib > 0))
			__fb_gl.Enable(GL_MULTISAMPLE_ARB);

		if (__fb_gl_params.mode_2d != DRIVER_OGL_2D_NONE)
			fb_hGL_ScreenCreate();

		CGDirectDisplayID mainDisplay = CGMainDisplayID();
		CGDisplayModeRef mode = CGDisplayCopyDisplayMode(mainDisplay);
		__fb_gfx->refresh_rate = round(CGDisplayModeGetRefreshRate(mode));
		CFRelease(mode);

		[driver.view createDisplayLink];
  	}
  	return 0;
}

static void driver_exit(void) {
	[driver.context release];
	[driver.view release];
	[driver.window close];
	[driver.window release];
	[lock release];
	if (gl_lib) dlclose(gl_lib);
	if ([NSApp isRunning]) {
		[NSApp terminate:nil];
	}
}

static void driver_flip(void) {
	fb_hCocoaLock();
	if (__fb_gl_params.mode_2d == DRIVER_OGL_2D_MANUAL_SYNC) {
		fb_hGL_SetupProjection();
	}
	[driver.context flushBuffer];
	fb_hCocoaUnlock();
}

void fb_hCocoaLock() {
	[lock lock];
}

void fb_hCocoaUnlock() {
	[lock unlock];
}

void fb_hCocoaWaitVSync() {
	dispatch_semaphore_wait(vsyncSema, DISPATCH_TIME_FOREVER);
}

// TODO: Handle all extended keys properly
static inline int translate_key(NSEvent* event, int scancode) {
	unsigned char key = [event charactersIgnoringModifiers].UTF8String[0];
	int extendedKey = fb_hScancodeToExtendedKey(scancode);
	if (extendedKey) return extendedKey;

	return key;
}

static void driver_poll_events() {
	@autoreleasepool {
		NSEvent *event;
		EVENT e;
		unsigned char key;

		while ((event = [NSApp nextEventMatchingMask:NSEventMaskAny
												untilDate:[NSDate distantPast]
												   inMode:NSDefaultRunLoopMode
												  dequeue:YES]) != nil) {
			e.type = 0;
			switch(event.type) {
				case NSEventTypeKeyDown:
					e.type = event.isARepeat ? EVENT_KEY_REPEAT : EVENT_KEY_PRESS;
					e.scancode = fb_cocoakeycode_to_scancode[event.keyCode];
					__fb_gfx->key[e.scancode] = TRUE;

					key = translate_key(event, e.scancode);
					if (key) {
						fb_hPostKey(key);
						e.ascii = (key > 0 && key < 0xFF) ? key : 0;
					}
					break;
				case NSEventTypeKeyUp:
					e.type = EVENT_KEY_RELEASE;
					e.scancode = fb_cocoakeycode_to_scancode[event.keyCode];
					__fb_gfx->key[e.scancode] = FALSE;

					key = [event charactersIgnoringModifiers].UTF8String[0];
					e.ascii = (key > 0 && key < 0xFF) ? key : 0;
					break;
				case NSEventTypeScrollWheel:
					mouse_wheel += [event scrollingDeltaY];
					mouse_hwheel += [event scrollingDeltaX];

					if ([event scrollingDeltaX] != 0) {
						e.type = EVENT_MOUSE_HWHEEL;
						e.z = mouse_hwheel;
					} else {
						e.type = EVENT_MOUSE_WHEEL;
						e.z = mouse_wheel;
					}
					break;
				case NSEventTypeMouseEntered:
					e.type = EVENT_MOUSE_ENTER;
					has_focus = true;
					break;
				case NSEventTypeMouseExited:
					e.type = EVENT_MOUSE_EXIT;
					has_focus = false;
					break;
				case NSEventTypeMouseMoved:
				case NSEventTypeLeftMouseDragged:
				case NSEventTypeRightMouseDragged:
				case NSEventTypeOtherMouseDragged:
					if (has_focus) {
						e.type = EVENT_MOUSE_MOVE;
						e.x = [event locationInWindow].x;
						e.y = [event locationInWindow].y;
						e.dx = [event deltaX];
						e.dy = [event deltaY];

						if( __fb_gfx->scanline_size != 1 ) {
							e.y /= __fb_gfx->scanline_size;
							e.dy /= __fb_gfx->scanline_size;
						}
					}
					break;
				case NSEventTypeLeftMouseDown:
					e.type = event.clickCount == 1 ? EVENT_MOUSE_BUTTON_PRESS : EVENT_MOUSE_DOUBLE_CLICK;
					e.button = 1;
					break;
				case NSEventTypeLeftMouseUp:
					e.type = EVENT_MOUSE_BUTTON_RELEASE;
					e.button = BUTTON_LEFT;
					break;
				case NSEventTypeRightMouseDown:
					e.type = event.clickCount == 1 ? EVENT_MOUSE_BUTTON_PRESS : EVENT_MOUSE_DOUBLE_CLICK;
					e.button = 2;
					break;
				case NSEventTypeRightMouseUp:
					e.type = EVENT_MOUSE_BUTTON_RELEASE;
					e.button = BUTTON_RIGHT;
					break;
				case NSEventTypeOtherMouseDown:
					e.type = event.clickCount == 1 ? EVENT_MOUSE_BUTTON_PRESS : EVENT_MOUSE_DOUBLE_CLICK;
					e.button = 1 << [event buttonNumber];
					break;
				case NSEventTypeOtherMouseUp:
					e.type = EVENT_MOUSE_BUTTON_RELEASE;
					e.button = 1 << [event buttonNumber];
					break;
				default:
					break;
			}
			if (e.type)
				fb_hPostEvent(&e);

			[NSApp sendEvent:event];
		}
	}
}

int fb_hCocoaGetMouse(int *x, int *y, int *z, int *buttons, int *clip) {
	NSPoint mouse = [driver.window mouseLocationOutsideOfEventStream];
	*x = mouse.x;
	*y = mouse.y;
	*z = mouse_wheel;
	*buttons = NSEvent.pressedMouseButtons;
	*clip = NSPointInRect(mouse, driver.frame);

	return 0;
}

void fb_hCocoaSetMouse(int x, int y, int cursor, int clip) {
	NSPoint mouse = [NSEvent mouseLocation];
	CGFloat screenX = mouse.x;
	CGFloat screenY = mouse.y;

	if (x >= 0) {
		screenX = driver.frame.origin.x + x;
	}
	if (y >= 0) {
		screenY = driver.frame.origin.y + driver.frame.size.height - y;
	}

	CGEventRef move = CGEventCreateMouseEvent(NULL, kCGEventMouseMoved, CGPointMake(screenX, screenY), kCGMouseButtonLeft);
	CGEventPost(kCGHIDEventTap, move);
	CFRelease(move);

	if (cursor == 0) {
		[NSCursor hide];
	} else if (cursor > 0) {
		[NSCursor unhide];
		[NSCursor setHiddenUntilMouseMoves:YES];
	}

	return;
}

void fb_hCocoaSetWindowTitle(char *title) {
	[driver.window setTitle:[NSString stringWithUTF8String:title]];
}

int fb_hCocoaSetWindowPos(int x, int y) {
	if (x == (int)0x80000000) x=driver.window.frame.origin.x;
	if (y == (int)0x80000000) y=driver.window.frame.origin.y;

	[driver.window setFrameOrigin:NSMakePoint(x, y)];

	return ((int)driver.window.frame.origin.x & 0xFFFF) | ((int)driver.window.frame.origin.y << 16);
}

int* fb_hCocoaFetchModes(int depth, int* size) {
	if ((depth != 8) && (depth != 15) && (depth != 16) && (depth != 24) && (depth != 32))
		return NULL;

	CGDirectDisplayID mainDisplay = CGMainDisplayID();
	CFArrayRef modesRef = CGDisplayCopyAllDisplayModes(mainDisplay, NULL);
	NSArray *modes = (__bridge NSArray *)modesRef;
	*size = modes.count;
	int* modesArray = (int*)malloc(sizeof(int) * modes.count);
	for (size_t i = 0; i < modes.count; i++) {
		CGDisplayModeRef mode = (__bridge CGDisplayModeRef)modes[i];
		modesArray[i] = (CGDisplayModeGetWidth(mode) << 16) | CGDisplayModeGetHeight(mode);
	}

	CFRelease(modesRef);
	return modesArray;
}

int fb_hCocoaScreenInfo(ssize_t *width, ssize_t *height, ssize_t *depth, ssize_t *refresh) {
	CGDirectDisplayID mainDisplay = CGMainDisplayID();
	CGDisplayModeRef mode = CGDisplayCopyDisplayMode(mainDisplay);
	*width = CGDisplayModeGetWidth(mode);
	*height = CGDisplayModeGetHeight(mode);

	CFDictionaryRef dict = (CFDictionaryRef)*((int64_t *)mode + 2);
	CFNumberRef num;

	if (CFGetTypeID(dict) == CFDictionaryGetTypeID()
		&& CFDictionaryGetValueIfPresent(dict, kCGDisplayBitsPerPixel, (const void**)&num))
	{
		int32_t out;
		CFNumberGetValue(num, kCFNumberSInt32Type, &out);
		*depth = out;
	} else {
		*depth = 32;
	}

	*refresh = round(CGDisplayModeGetRefreshRate(mode));

	CFRelease(mode);
	return 0;
}

void* fb_hGL_GetProcAddress(const char *name) {
	return dlsym(gl_lib, name);
}

#endif
