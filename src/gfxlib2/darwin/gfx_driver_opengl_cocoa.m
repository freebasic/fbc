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
    "Cocoa OpenGL",           /* char *name; */
    driver_init,        /* int (*init)(char *title, int w, int h, int depth, int
                           refresh_rate, int flags); */
    driver_exit,        /* void (*exit)(void); */
    fb_hCocoaLock,      /* void (*lock)(void); */
    fb_hCocoaUnlock,    /* void (*unlock)(void); */
    fb_hGL_SetPalette,  /* void (*set_palette)(int index, int r, int g, int b);
                         */
    fb_hCocoaWaitVSync, /* void (*wait_vsync)(void); */
    fb_hCocoaGetMouse, /* int (*get_mouse)(int *x, int *y, int *z, int *buttons,
                          int *clip); */
    fb_hCocoaSetMouse, /* void (*set_mouse)(int x, int y, int cursor, int clip);
                        */
    fb_hCocoaSetWindowTitle, /* void (*set_window_title)(char *title); */
    fb_hCocoaSetWindowPos,   /* int (*set_window_pos)(int x, int y); */
    fb_hCocoaFetchModes,     /* int *(*fetch_modes)(void); */
    driver_flip,             /* void (*flip)(void); */
    driver_poll_events,                    /* void (*poll_events)(void); */
    NULL                     /* void (*update)(void); */
};

static dispatch_semaphore_t vsyncSema = NULL;

@interface OpenGLView : NSOpenGLView
@property (nonatomic, strong) CADisplayLink *displayLink;
@end

@implementation OpenGLView
- (BOOL)acceptsFirstResponder
{
    return YES;
}
- (void)createDisplayLink
{
    vsyncSema = dispatch_semaphore_create(0);
    self.displayLink = [self displayLinkWithTarget:self
                                                    selector:@selector(waitVSync)];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop]
                           forMode:NSDefaultRunLoopMode];
}

- (void)waitVSync
{
    dispatch_semaphore_signal(vsyncSema);
}

- (void)dealloc
{
    [self.displayLink invalidate];
    self.displayLink = nil;
    dispatch_release(vsyncSema);
    [super dealloc];
}

@end

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
static int mouse_wheel = 0;
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
    driver.closed = YES;
    return YES;
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
		NSOpenGLPixelFormatAttribute attrs[32] = {0};
        NSOpenGLPixelFormatAttribute* attr = attrs;
        *attr++ = NSOpenGLPFADoubleBuffer;
		*attr++ = NSOpenGLPFAAccelerated;
		*attr++ = NSOpenGLPFAOpenGLProfile;
        *attr++ = NSOpenGLProfileVersionLegacy;
		*attr++ = NSOpenGLPFAColorSize;
        *attr++ = __fb_gl_params.color_bits;
		*attr++ = NSOpenGLPFAAlphaSize;
        *attr++ = __fb_gl_params.color_alpha_bits;
		*attr++ = NSOpenGLPFADepthSize;
        *attr++ = depth;
		*attr++ = NSOpenGLPFAStencilSize;
        *attr++ = __fb_gl_params.stencil_bits;
		*attr++ = NSOpenGLPFAAccumSize;
        *attr++ = __fb_gl_params.accum_bits;
        if (flags & HAS_MULTISAMPLE) {
			*attr++ = NSOpenGLPFAMultisample;
            *attr++ = NSOpenGLPFASampleBuffers;
            *attr++ = 1;
            *attr++ = NSOpenGLPFASamples;
            *attr++ = __fb_gl_params.num_samples;
        }

		if (!gl_lib) gl_lib = dlopen("/System/Library/Frameworks/OpenGL.framework/Versions/Current", RTLD_LAZY);
		if (!gl_lib) gl_lib = dlopen("/System/Library/Frameworks/OpenGL.framework/Versions/Current/OpenGL", RTLD_LAZY);
		if (!gl_lib) return -1;

		NSOpenGLPixelFormat *format = [[NSOpenGLPixelFormat alloc] initWithAttributes:attrs];
		driver.context = [[NSOpenGLContext alloc] initWithFormat:format shareContext:nil];
        if (!driver.context) return -1;
		driver.view = [[OpenGLView alloc] initWithFrame:driver.frame];
        if (!driver.view) return -1;
		[driver.view setOpenGLContext:driver.context];

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
		if (![[NSRunningApplication currentApplication] isFinishedLaunching])
            [NSApp run];

		[driver.context makeCurrentContext];

        if (fb_hGL_Init(gl_lib, NULL)) return -1;

        CGDirectDisplayID mainDisplay = CGMainDisplayID();
        CGDisplayModeRef mode = CGDisplayCopyDisplayMode(mainDisplay);
        __fb_gfx->refresh_rate = round(CGDisplayModeGetRefreshRate(mode));
        CFRelease(mode);
  	}
  	return 0;
}

static void driver_exit(void) {
    [driver.context release];
    [driver.view release];
    [driver.window close];
    [driver.window release];
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

void driver_poll_events() {
	@autoreleasepool {
		NSEvent *event;
		while ((event = [NSApp nextEventMatchingMask:NSEventMaskAny
		                                        untilDate:[NSDate distantPast]
		                                           inMode:NSDefaultRunLoopMode
		                                          dequeue:YES]) != nil) {
            if ([event type] == NSEventTypeScrollWheel) {
                mouse_wheel += [event deltaY];
            }
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
	NSArray *modes = (__bridge NSArray *)CGDisplayCopyAllDisplayModes(mainDisplay, NULL);
	*size = modes.count;
	int* modesArray = (int*)malloc(sizeof(int) * modes.count);
	for (size_t i = 0; i < modes.count; i++) {
		CGDisplayModeRef mode = (__bridge CGDisplayModeRef)modes[i];
		modesArray[i] = (CGDisplayModeGetWidth(mode) << 16) | CGDisplayModeGetHeight(mode);
	}

    CFRelease(modes);
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
