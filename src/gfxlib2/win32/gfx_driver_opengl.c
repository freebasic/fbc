/* OpenGL gfx driver */

#include "../fb_gfx.h"
#include "fb_gfx_win32.h"
#include "../fb_gfx_gl.h"
#include <process.h>

#ifndef DISABLE_OPENGL

#ifndef WGL_ARB_pixel_format
#define WGL_ARB_pixel_format

#define WGL_NUMBER_PIXEL_FORMATS_ARB    0x2000
#define WGL_DRAW_TO_WINDOW_ARB          0x2001
#define WGL_DRAW_TO_BITMAP_ARB          0x2002
#define WGL_ACCELERATION_ARB            0x2003
#define WGL_NEED_PALETTE_ARB            0x2004
#define WGL_NEED_SYSTEM_PALETTE_ARB     0x2005
#define WGL_SWAP_LAYER_BUFFERS_ARB      0x2006
#define WGL_SWAP_METHOD_ARB             0x2007
#define WGL_NUMBER_OVERLAYS_ARB         0x2008
#define WGL_NUMBER_UNDERLAYS_ARB        0x2009
#define WGL_TRANSPARENT_ARB             0x200A
#define WGL_TRANSPARENT_RED_VALUE_ARB   0x2037
#define WGL_TRANSPARENT_GREEN_VALUE_ARB 0x2038
#define WGL_TRANSPARENT_BLUE_VALUE_ARB  0x2039
#define WGL_TRANSPARENT_ALPHA_VALUE_ARB 0x203A
#define WGL_TRANSPARENT_INDEX_VALUE_ARB 0x203B
#define WGL_SHARE_DEPTH_ARB             0x200C
#define WGL_SHARE_STENCIL_ARB           0x200D
#define WGL_SHARE_ACCUM_ARB             0x200E
#define WGL_SUPPORT_GDI_ARB             0x200F
#define WGL_SUPPORT_OPENGL_ARB          0x2010
#define WGL_DOUBLE_BUFFER_ARB           0x2011
#define WGL_STEREO_ARB                  0x2012
#define WGL_PIXEL_TYPE_ARB              0x2013
#define WGL_COLOR_BITS_ARB              0x2014
#define WGL_RED_BITS_ARB                0x2015
#define WGL_RED_SHIFT_ARB               0x2016
#define WGL_GREEN_BITS_ARB              0x2017
#define WGL_GREEN_SHIFT_ARB             0x2018
#define WGL_BLUE_BITS_ARB               0x2019
#define WGL_BLUE_SHIFT_ARB              0x201A
#define WGL_ALPHA_BITS_ARB              0x201B
#define WGL_ALPHA_SHIFT_ARB             0x201C
#define WGL_ACCUM_BITS_ARB              0x201D
#define WGL_ACCUM_RED_BITS_ARB          0x201E
#define WGL_ACCUM_GREEN_BITS_ARB        0x201F
#define WGL_ACCUM_BLUE_BITS_ARB         0x2020
#define WGL_ACCUM_ALPHA_BITS_ARB        0x2021
#define WGL_DEPTH_BITS_ARB              0x2022
#define WGL_STENCIL_BITS_ARB            0x2023
#define WGL_AUX_BUFFERS_ARB             0x2024
#define WGL_NO_ACCELERATION_ARB         0x2025
#define WGL_GENERIC_ACCELERATION_ARB    0x2026
#define WGL_FULL_ACCELERATION_ARB       0x2027
#define WGL_SWAP_EXCHANGE_ARB           0x2028
#define WGL_SWAP_COPY_ARB               0x2029
#define WGL_SWAP_UNDEFINED_ARB          0x202A
#define WGL_TYPE_RGBA_ARB               0x202B
#define WGL_TYPE_COLORINDEX_ARB         0x202C
#define WGL_SAMPLE_BUFFERS_ARB          0x2041
#define WGL_SAMPLES_ARB                 0x2042

#endif

static int driver_init(char *title, int w, int h, int depth, int refresh_rate, int flags);
static void driver_exit(void);
static void driver_lock(void);
static void driver_unlock(void);
static void driver_flip(void);
static int *driver_fetch_modes(int depth, int *size);
static void driver_poll_events(void);
static int opengl_init(void);
static void opengl_exit(void);

/* GFXDRIVER */
const GFXDRIVER fb_gfxDriverOpenGL =
{
	"OpenGL",               /* char *name; */
	driver_init,            /* int (*init)(char *title, int w, int h, int depth, int refresh_rate, int flags); */
	driver_exit,            /* void (*exit)(void); */
	driver_lock,            /* void (*lock)(void); */
	driver_unlock,          /* void (*unlock)(void); */
	fb_hGL_SetPalette,      /* void (*set_palette)(int index, int r, int g, int b); */
	fb_hWin32WaitVSync,     /* void (*wait_vsync)(void); */
	fb_hWin32GetMouse,      /* int (*get_mouse)(int *x, int *y, int *z, int *buttons, int *clip); */
	fb_hWin32SetMouse,      /* void (*set_mouse)(int x, int y, int cursor, int clip); */
	fb_hWin32SetWindowTitle,/* void (*set_window_title)(char *title); */
	fb_hWin32SetWindowPos,  /* int (*set_window_pos)(int x, int y); */
	driver_fetch_modes,     /* int *(*fetch_modes)(int depth, int *size); */
	driver_flip,            /* void (*flip)(void); */
	driver_poll_events,     /* void (*poll_events)(void); */
	NULL                    /* void (*update)(void); */
};


typedef HGLRC (APIENTRY *WGLCREATECONTEXT)(HDC);
typedef BOOL (APIENTRY *WGLMAKECURRENT)(HDC, HGLRC);
typedef BOOL (APIENTRY *WGLDELETECONTEXT)(HGLRC);
typedef PROC (APIENTRY *WGLGETPROCADDRESS)(LPCSTR);
typedef PCHAR (APIENTRY *WGLGETEXTENSIONSTRINGARB)(HDC);
typedef BOOL (APIENTRY *WGLCHOOSEPIXELFORMATARB)(HDC, const int *, const FLOAT *, int, int *, int *);

typedef struct FB_WGL {
	WGLCREATECONTEXT CreateContext;
	WGLMAKECURRENT MakeCurrent;
	WGLDELETECONTEXT DeleteContext;
	WGLGETPROCADDRESS GetProcAddress;
	WGLGETEXTENSIONSTRINGARB GetExtensionStringARB;
	WGLCHOOSEPIXELFORMATARB ChoosePixelFormatARB;
} FB_WGL;

static FB_DYLIB library;
static FB_WGL fb_wgl;
static HGLRC hglrc;
static HDC hdc;

void *fb_hGL_GetProcAddress(const char *proc)
{
	return (void *)fb_wgl.GetProcAddress(proc);
}

static int GL_init(PIXELFORMATDESCRIPTOR *pfd)
{
	HWND wnd;
	HDC hdc;
	HGLRC hglrc;
	int pf, res = 0;
	char *wgl_extensions = NULL;
	
	wnd = CreateWindow(fb_win32.window_class, "OpenGL setup", WS_POPUP | WS_CLIPCHILDREN | WS_CLIPSIBLINGS,
					   0, 0, 8, 8, HWND_DESKTOP, NULL, fb_win32.hinstance, NULL);
	if (!wnd){
		return -1;
	}
	hdc = GetDC(wnd);
	pf = ChoosePixelFormat(hdc, pfd);
	SetPixelFormat(hdc, pf, pfd);

	hglrc = fb_wgl.CreateContext(hdc);
	fb_wgl.MakeCurrent(hdc, hglrc);
	
	fb_wgl.GetProcAddress = (WGLGETPROCADDRESS)(void*)GetProcAddress(library, "wglGetProcAddress");
	fb_wgl.GetExtensionStringARB = (WGLGETEXTENSIONSTRINGARB)(void*)fb_wgl.GetProcAddress("wglGetExtensionsStringARB");
	if (!fb_wgl.GetExtensionStringARB){
		fb_wgl.GetExtensionStringARB = (WGLGETEXTENSIONSTRINGARB)(void*)fb_wgl.GetProcAddress("wglGetExtensionsStringEXT");
	}
	if (fb_wgl.GetExtensionStringARB){
		wgl_extensions = fb_wgl.GetExtensionStringARB(hdc);
	}
	res = fb_hGL_Init(library, wgl_extensions);
	if (res == 0) {
		if (fb_hGL_ExtensionSupported("WGL_ARB_pixel_format\n")){
			fb_wgl.ChoosePixelFormatARB = (WGLCHOOSEPIXELFORMATARB)(void*)fb_wgl.GetProcAddress("wglChoosePixelFormatARB");
		}
	}
	
	fb_wgl.MakeCurrent(NULL, NULL);
	fb_wgl.DeleteContext(hglrc);
	ReleaseDC(wnd, hdc);
	
	DestroyWindow(wnd);
	
	return res;
}

static int *GL_setup_pixel_format(PIXELFORMATDESCRIPTOR *pfd, int *attrib, int **samples_attrib)
{
	*attrib++ = WGL_COLOR_BITS_ARB;
	pfd->cColorBits = *attrib++ = __fb_gl_params.color_bits;
	*attrib++ = WGL_RED_BITS_ARB;
	pfd->cRedBits = *attrib++ = __fb_gl_params.color_red_bits;
	*attrib++ = WGL_GREEN_BITS_ARB;
	pfd->cGreenBits = *attrib++ = __fb_gl_params.color_green_bits;
	*attrib++ = WGL_BLUE_BITS_ARB;
	pfd->cBlueBits = *attrib++ = __fb_gl_params.color_blue_bits;
	*attrib++ = WGL_ALPHA_BITS_ARB;
	pfd->cAlphaBits = *attrib++ = __fb_gl_params.color_alpha_bits;
	*attrib++ = WGL_DEPTH_BITS_ARB;
	pfd->cDepthBits = *attrib++ = __fb_gl_params.depth_bits;
	if (__fb_gl_params.accum_bits) {
		*attrib++ = WGL_ACCUM_BITS_ARB;
		pfd->cAccumBits = *attrib++ = __fb_gl_params.accum_bits;
	}
	if (__fb_gl_params.accum_red_bits) {
		*attrib++ = WGL_ACCUM_RED_BITS_ARB;
		pfd->cAccumRedBits = *attrib++ = __fb_gl_params.accum_red_bits;
	}
	if (__fb_gl_params.accum_green_bits) {
		*attrib++ = WGL_ACCUM_RED_BITS_ARB;
		pfd->cAccumGreenBits = *attrib++ = __fb_gl_params.accum_green_bits;
	}
	if (__fb_gl_params.accum_blue_bits) {
		*attrib++ = WGL_ACCUM_BLUE_BITS_ARB;
		pfd->cAccumBlueBits = *attrib++ = __fb_gl_params.accum_blue_bits;
	}
	if (__fb_gl_params.accum_alpha_bits) {
		*attrib++ = WGL_ACCUM_ALPHA_BITS_ARB;
		pfd->cAccumAlphaBits = *attrib++ = __fb_gl_params.accum_alpha_bits;
	}
	if (__fb_gl_params.stencil_bits) {
		*attrib++ = WGL_STENCIL_BITS_ARB;
		pfd->cStencilBits = *attrib++ = __fb_gl_params.stencil_bits;
	}
	if (__fb_gl_params.num_samples) {
		*attrib++ = WGL_SAMPLE_BUFFERS_ARB;
		*attrib++ = GL_TRUE;
		*attrib++ = WGL_SAMPLES_ARB;
		*samples_attrib = attrib;
		*attrib++ = __fb_gl_params.num_samples;
	}
	*attrib = 0;
	return attrib;
}

static int GL_common_init()
{
	PIXELFORMATDESCRIPTOR pfd = {
		sizeof(PIXELFORMATDESCRIPTOR), 1,
		PFD_DRAW_TO_WINDOW | PFD_SUPPORT_OPENGL | PFD_DOUBLEBUFFER,
		PFD_TYPE_RGBA, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 32, 0, 0,
		PFD_MAIN_PLANE, 0, 0, 0, 0
	};
	int attribs[64] = {
		WGL_DRAW_TO_WINDOW_ARB, GL_TRUE,
		WGL_ACCELERATION_ARB,   WGL_FULL_ACCELERATION_ARB,
		WGL_DOUBLE_BUFFER_ARB,  GL_TRUE,
		0
	}, *attrib = &attribs[6], *samples_attrib = NULL;
	int pf = 0, num_formats, format;

	if (GL_init(&pfd)){
		return -1;
	}
	if (fb_hInitWindow((WS_CLIPSIBLINGS | WS_CLIPCHILDREN) & ~WS_THICKFRAME, 0, 0, 0, fb_win32.w, fb_win32.h)){
		return -1;
	}
	if (opengl_init()){
		return -1;
	}

	/* setup pixel format */

	if (__fb_gl_params.mode_2d != DRIVER_OGL_2D_AUTO_SYNC){
		/* flags?  This logic of not calling fb_hGL_NormalizeParameters()
		   when mode_2d is DRIVER_OGL_2D_AUTO_SYNC is kept from a
		   previous version. */
		fb_hGL_NormalizeParameters( fb_win32.flags);
	}

	attrib = GL_setup_pixel_format( &pfd, attrib, &samples_attrib );
	
	hdc = GetDC(fb_win32.wnd);
	if (fb_wgl.ChoosePixelFormatARB) {
		do {
			if ((fb_wgl.ChoosePixelFormatARB(hdc, attribs, NULL, 1, &format, &num_formats)) && (num_formats > 0)) {
				pf = format;
				break;
			}
		} while ((samples_attrib) && ((*samples_attrib -= 2) >= 0));
	}
	if (!pf) {
		if (__fb_gl_params.mode_2d != DRIVER_OGL_2D_AUTO_SYNC){
			/* flags?  This logic of not excluding HAS_MULTISAMPLE
			   when mode_2d is DRIVER_OGL_2D_AUTO_SYNC is kept from a
			   previous version. */
			fb_win32.flags &= ~HAS_MULTISAMPLE;
		}
		pf = ChoosePixelFormat(hdc, &pfd);
	}
	
	if ((!pf) || (!SetPixelFormat(hdc, pf, &pfd))){
		return -1;
	}
	hglrc = fb_wgl.CreateContext(hdc);
	if (!hglrc){
		return -1;
	}
	fb_wgl.MakeCurrent(hdc, hglrc);

	if ((samples_attrib) && (*samples_attrib > 0)){
		__fb_gl.Enable(GL_MULTISAMPLE_ARB);
	}
	if (__fb_gl_params.mode_2d != DRIVER_OGL_2D_NONE){
		fb_hGL_ScreenCreate();
	}
	return 0;
}

static void opengl_paint(void)
{
}

static int opengl_init(void)
{
	DEVMODE mode;
	DWORD style;
	RECT rect;
	UINT flags;
	int x, y;
	MONITORINFOEX monitor_info;
	const char *devname = NULL;
	
	monitor_info.cbSize = sizeof(MONITORINFOEX);
	monitor_info.szDevice[0] = '\0';
	
	if (fb_win32.GetMonitorInfo && fb_win32.monitor && fb_win32.GetMonitorInfo(fb_win32.monitor, (LPMONITORINFO)&monitor_info)) {
		devname = monitor_info.szDevice;
	}
	
	style = GetWindowLong(fb_win32.wnd, GWL_STYLE);
	flags = SWP_FRAMECHANGED;
	if (fb_win32.flags & DRIVER_FULLSCREEN) {
		fb_hMemSet(&mode, 0, sizeof(mode));
		mode.dmSize = sizeof(mode);
		mode.dmPelsWidth = fb_win32.w;
		mode.dmPelsHeight = fb_win32.h;
		mode.dmBitsPerPel = fb_win32.depth;
		mode.dmDisplayFrequency = fb_win32.refresh_rate;
		mode.dmFields = DM_PELSWIDTH | DM_PELSHEIGHT | DM_BITSPERPEL | DM_DISPLAYFREQUENCY;
		if (fb_win32.ChangeDisplaySettingsEx) {
			if (fb_win32.ChangeDisplaySettingsEx(devname, &mode, NULL, CDS_FULLSCREEN, NULL) != DISP_CHANGE_SUCCESSFUL){
				return -1;
			}
		} else if (ChangeDisplaySettings(&mode, CDS_FULLSCREEN) != DISP_CHANGE_SUCCESSFUL) {
			return -1;
		}
		style &= ~WS_OVERLAPPEDWINDOW;
		style |= WS_POPUP;
	}
	else {
		if (fb_win32.flags & DRIVER_NO_FRAME) {
			style &= ~WS_OVERLAPPEDWINDOW;
			style |= WS_POPUP;
		}
		else {
			style |= WS_OVERLAPPEDWINDOW;
			style &= ~(WS_POPUP | WS_THICKFRAME);
			if (fb_win32.flags & DRIVER_NO_SWITCH)
				style &= ~WS_MAXIMIZEBOX;
		}
		flags |= SWP_NOACTIVATE | SWP_NOOWNERZORDER | SWP_NOSENDCHANGING | SWP_NOZORDER;
	}
	SetWindowLong(fb_win32.wnd, GWL_STYLE, style);
	rect.left = rect.top = x = y = 0;
	rect.right = fb_win32.w;
	rect.bottom = fb_win32.h;
	if (!(fb_win32.flags & DRIVER_FULLSCREEN)) {
		AdjustWindowRect(&rect, style, FALSE);
		if (monitor_info.szDevice[0]) {
			x = monitor_info.rcMonitor.left + ((monitor_info.rcMonitor.right - monitor_info.rcMonitor.left - rect.right) >> 1);
			y = monitor_info.rcMonitor.top + ((monitor_info.rcMonitor.bottom - monitor_info.rcMonitor.top - rect.bottom) >> 1);			
		} else {
			x = (GetSystemMetrics(SM_CXSCREEN) - rect.right) >> 1;
			y = (GetSystemMetrics(SM_CYSCREEN) - rect.bottom) >> 1;
		}
	} else if (monitor_info.szDevice[0]) {
		/* fullscreen with valid monitor_info: place window on proper monitor */
		x = monitor_info.rcMonitor.left;
		y = monitor_info.rcMonitor.top;
	}
	fb_win32.fullw = rect.right - rect.left;
	fb_win32.fullh = rect.bottom - rect.top;
	SetWindowPos(fb_win32.wnd, 0, x, y, fb_win32.fullw, fb_win32.fullh, flags);
	ShowWindow(fb_win32.wnd, SW_SHOW);
	SetForegroundWindow(fb_win32.wnd);
	fb_win32.is_active = TRUE;
	__fb_gfx->refresh_rate = GetDeviceCaps(hdc, VREFRESH);

	return 0;
}

static void opengl_exit(void)
{
	if (fb_win32.flags & DRIVER_FULLSCREEN)
		ChangeDisplaySettings(NULL, 0);
	ShowWindow(fb_win32.wnd, SW_HIDE);
}

#ifdef HOST_MINGW
static unsigned int WINAPI opengl_thread( void *param )
#else
static DWORD WINAPI opengl_thread( LPVOID param )
#endif
{
	/* opengl_thread should be only used when mode_2d == DRIVER_OGL_2D_AUTO_SYNC */

	if( GL_common_init() ) {
		return 1;
	}

	/* thread initialization complete, so release the thread creation lock */
	SetEvent((HANDLE)param);

	while (fb_win32.is_running)
	{
		fb_hWin32Lock();
		/* FB_GRAPHICS_LOCK( ); */
		fb_wgl.MakeCurrent(hdc, hglrc);
		fb_hGL_SetupProjection();
		SwapBuffers(hdc);
		fb_wgl.MakeCurrent(NULL, NULL);
		driver_poll_events();
		/* FB_GRAPHICS_UNLOCK( ); */
		fb_hWin32Unlock();
		Sleep(10);
	}

	return 1;
}

static int driver_init(char *title, int w, int h, int depth_arg, int refresh_rate, int flags)
{
	const char *const wgl_funcs[] = { "wglCreateContext", "wglMakeCurrent", "wglDeleteContext", NULL };
	int depth = MAX(8, depth_arg);

	fb_hMemSet(&fb_win32, 0, sizeof(fb_win32));

	library	= NULL;
	hglrc = NULL;
	hdc = NULL;

	if (!(flags & DRIVER_OPENGL)){
		return -1;
	}
	library = fb_hDynLoad("opengl32.dll", wgl_funcs, (void **)&fb_wgl);
	if (!library){
		return -1;
	}
	fb_win32.init = opengl_init;
	fb_win32.exit = opengl_exit;
	fb_win32.paint = opengl_paint;
	fb_win32.thread = NULL;

	__fb_gl_params.mode_2d = __fb_gl_params.init_mode_2d;

	if (__fb_gl_params.init_scale>1){
		__fb_gl_params.scale = __fb_gl_params.init_scale;
		free(__fb_gfx->dirty);
		__fb_gfx->dirty = (char *)calloc(1, __fb_gfx->h * __fb_gfx->scanline_size * __fb_gl_params.scale);
		w *= __fb_gl_params.scale;
		h *= __fb_gl_params.scale;
	}

	/*  Initialize the graphics window only.  Creation of the window
	    is handled in next fb_hWin32Init() or GL_common_init()
	 */

	if( fb_hWin32Init(title, w, h, depth, refresh_rate, flags) ) {
		return -1;
	}

	if (__fb_gl_params.mode_2d == DRIVER_OGL_2D_AUTO_SYNC){
		fb_win32.thread = opengl_thread;
		fb_wgl.MakeCurrent(NULL, NULL);
		return fb_hWin32Init(title, w, h, depth, refresh_rate, flags);
	}

	return GL_common_init();
}

static void driver_exit(void)
{
	if (library) {
		if (hglrc) {
			fb_wgl.MakeCurrent(NULL, NULL);
			fb_wgl.DeleteContext(hglrc);
		}
		if (hdc)
			ReleaseDC(fb_win32.wnd, hdc);
		if (fb_win32.flags & DRIVER_FULLSCREEN)
			ChangeDisplaySettings(NULL, 0);
		if (fb_win32.wnd)
			DestroyWindow(fb_win32.wnd);
		fb_hDynUnload(&library);
	}

	fb_hWin32Exit();
}

static void driver_lock(void)
{
	if (__fb_gl_params.mode_2d == DRIVER_OGL_2D_AUTO_SYNC){
		fb_hWin32Lock();
		fb_wgl.MakeCurrent(hdc, hglrc);
		fb_hGL_SetupProjection();
	}
}

static void driver_unlock(void)
{
	if (__fb_gl_params.mode_2d == DRIVER_OGL_2D_AUTO_SYNC){
		SwapBuffers(hdc);
		fb_wgl.MakeCurrent(NULL, NULL);
		fb_hWin32Unlock();
	}
}

static void driver_flip(void)
{
	if (__fb_gl_params.mode_2d == DRIVER_OGL_2D_MANUAL_SYNC){
		fb_hGL_SetupProjection();
	}
	SwapBuffers(hdc);
}

static void driver_poll_events(void)
{
    if( fb_win32.is_active ) {
        int i;
        unsigned char keystate[256];
        GetKeyboardState(keystate);
        for (i = 0; __fb_keytable[i][0]; i++) {
            if (__fb_keytable[i][2])
                __fb_gfx->key[__fb_keytable[i][0]] = ((keystate[__fb_keytable[i][1]] & 0x80) |
                                                   (keystate[__fb_keytable[i][2]] & 0x80)) ? TRUE : FALSE;
            else
                __fb_gfx->key[__fb_keytable[i][0]] = (keystate[__fb_keytable[i][1]] & 0x80) ? TRUE : FALSE;
        }
    }

	fb_hHandleMessages();
}

static int *driver_fetch_modes(int depth, int *size)
{
	DEVMODE devmode;
	int *modes = NULL, index = 0;

	*size = 0;

	for (;;) {
		if (!EnumDisplaySettings(NULL, index, &devmode))
			break;
		index++;
		if (devmode.dmBitsPerPel == (unsigned int)depth) {
			(*size)++;
			int *oldModes = modes;
			modes = (int *)realloc(modes, *size * sizeof(int));
			if (modes == NULL) {
				free(oldModes);
				*size = 0;
				return NULL;
			}
			modes[(*size) - 1] = (devmode.dmPelsWidth << 16) | devmode.dmPelsHeight;
		}
	}

	return modes;
}

#endif /* DISABLE_OPENGL */

