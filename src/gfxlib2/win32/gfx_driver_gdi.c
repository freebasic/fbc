/* GDI gfx driver */

#include "../fb_gfx.h"
#include "fb_gfx_win32.h"

#define SCREENLIST(w, h) ((h) | (w) << 16)
#ifndef LWA_COLORKEY
#define LWA_COLORKEY	0x00000001
#endif

static int driver_init(char *title, int w, int h, int depth, int refresh_rate, int flags);
static int *driver_fetch_modes(int depth, int *size);

/* GFXDRIVER */
const GFXDRIVER fb_gfxDriverGDI =
{
	"GDI",                  /* char *name; */
	driver_init,            /* int (*init)(char *title, int w, int h, int depth, int refresh_rate, int flags); */
	fb_hWin32Exit,          /* void (*exit)(void); */
	fb_hWin32Lock,          /* void (*lock)(void); */
	fb_hWin32Unlock,        /* void (*unlock)(void); */
	fb_hWin32SetPalette,    /* void (*set_palette)(int index, int r, int g, int b); */
	fb_hWin32WaitVSync,     /* void (*wait_vsync)(void); */
	fb_hWin32GetMouse,      /* int (*get_mouse)(int *x, int *y, int *z, int *buttons, int *clip); */
	fb_hWin32SetMouse,      /* void (*set_mouse)(int x, int y, int cursor, int clip); */
	fb_hWin32SetWindowTitle,/* void (*set_window_title)(char *title); */
	fb_hWin32SetWindowPos,  /* int (*set_window_pos)(int x, int y); */
	driver_fetch_modes,     /* int *(*fetch_modes)(int depth, int *size); */
	NULL,                   /* void (*flip)(void); */
	NULL,                   /* void (*poll_events)(void); */
	NULL                    /* void (*update)(void); */
};

static BITMAPINFO *bitmap_info;
static HPALETTE palette;
static unsigned char *buffer;
static int switched_to_fullscreen;

static void alpha_remover_blitter(unsigned char *dest, int pitch)
{
	unsigned int *d, *s;
	unsigned char *src = __fb_gfx->framebuffer;
	unsigned int c;
	char *dirty = __fb_gfx->dirty;
	int x, y;

	DBG_ASSERT((fb_win32.depth == 32) && (__fb_gfx->scanline_size == 1));

	for (y = __fb_gfx->h; y; y--) {
		if (*dirty) {
			s = (unsigned int *)src;
			d = (unsigned int *)dest;
			for (x = __fb_gfx->w; x; x--) {
				c = *s++;
				*d++ = c & ~MASK_A_32;
			}
		}
		src += __fb_gfx->pitch;
		dest += pitch;
	}
}

static void gdi_paint(void)
{
	unsigned char *source;
	HDC hdc;

	if (fb_win32.blitter)
		source = buffer;
	else
		source = __fb_gfx->framebuffer;

	hdc = GetDC(fb_win32.wnd);
	SelectPalette(hdc, palette, FALSE);
	RealizePalette(hdc);
	SetDIBitsToDevice(hdc, 0, 0, fb_win32.w, fb_win32.h, 0, 0, 0, fb_win32.h, source, bitmap_info, DIB_RGB_COLORS);
	InvalidateRect(fb_win32.wnd, NULL, FALSE);
	ReleaseDC(fb_win32.wnd, hdc);
}

static int gdi_init(void)
{
	DEVMODE mode;
	DWORD style, ex_style = 0;
	HDC hdc;
	RECT rect;
	LOGPALETTE *lp;
	int x, y;
	MONITORINFOEX monitor_info;
	const char *devname = NULL;

	bitmap_info = NULL;
	buffer = NULL;
	palette = NULL;

	monitor_info.cbSize = sizeof(MONITORINFOEX);
	monitor_info.szDevice[0] = '\0';

	if (fb_win32.GetMonitorInfo && fb_win32.monitor && fb_win32.GetMonitorInfo(fb_win32.monitor, (LPMONITORINFO)&monitor_info)) {
		devname = monitor_info.szDevice;
	}

	if (fb_win32.flags & DRIVER_FULLSCREEN) {
		fb_hMemSet(&mode, 0, sizeof(mode));
		mode.dmSize = sizeof(mode);
		mode.dmPelsWidth = fb_win32.w;
		mode.dmPelsHeight = fb_win32.h;
		mode.dmBitsPerPel = fb_win32.depth;
		mode.dmDisplayFrequency = fb_win32.refresh_rate;
		mode.dmFields = DM_PELSWIDTH | DM_PELSHEIGHT | DM_BITSPERPEL | DM_DISPLAYFREQUENCY;
		
		if (fb_win32.ChangeDisplaySettingsEx) {
			if (fb_win32.ChangeDisplaySettingsEx(devname, &mode, NULL, CDS_FULLSCREEN, NULL) != DISP_CHANGE_SUCCESSFUL)
				return -1;
		} else if (ChangeDisplaySettings(&mode, CDS_FULLSCREEN) != DISP_CHANGE_SUCCESSFUL) {
			return -1;
		}
		switched_to_fullscreen = 1;
		style = WS_POPUP | WS_CLIPSIBLINGS | WS_CLIPCHILDREN;
	} else {
		style = WS_OVERLAPPEDWINDOW & ~WS_THICKFRAME;
		if (fb_win32.flags & DRIVER_NO_SWITCH)
			style &= ~WS_MAXIMIZEBOX;
		if (fb_win32.flags & DRIVER_NO_FRAME)
			style = WS_POPUP;
		if (fb_win32.flags & DRIVER_SHAPED_WINDOW) {
			if (fb_win32.version < 0x500)
				return -1;
			ex_style = WS_EX_LAYERED;
		}
	}

	rect.left = rect.top = x = y = 0;
	rect.right = fb_win32.w;
	rect.bottom = fb_win32.h;
	if (!(fb_win32.flags & DRIVER_FULLSCREEN)) {
		/* windowed mode: center window on monitor */
		AdjustWindowRect(&rect, style, 0);
		rect.right -= rect.left;
		rect.bottom -= rect.top;
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

	if (fb_hInitWindow(style, ex_style, x, y, rect.right, rect.bottom))
		return -1;
	if (fb_win32.flags & DRIVER_SHAPED_WINDOW) {
		if (!fb_win32.SetLayeredWindowAttributes)
			return -1;
		fb_win32.SetLayeredWindowAttributes(fb_win32.wnd, (fb_win32.depth > 8) ? RGB(255, 0, 255) : 0, 0, LWA_COLORKEY);
	}

	bitmap_info = (BITMAPINFO *)calloc(1, sizeof(BITMAPINFO) + (sizeof(RGBQUAD) * 256));
	if (!bitmap_info)
		return -1;
	bitmap_info->bmiHeader.biSize = sizeof(BITMAPINFOHEADER);
	bitmap_info->bmiHeader.biBitCount = fb_win32.depth;
	bitmap_info->bmiHeader.biPlanes = 1;
	bitmap_info->bmiHeader.biWidth = fb_win32.w;
	bitmap_info->bmiHeader.biHeight = -fb_win32.h;
	bitmap_info->bmiHeader.biClrUsed = 256;
	bitmap_info->bmiHeader.biCompression = BI_RGB;

	if ((fb_win32.depth >= 16) || (fb_win32.w & 0x3) || (__fb_gfx->scanline_size > 1)) {
		if ((fb_win32.flags & DRIVER_SHAPED_WINDOW) && (fb_win32.depth == 32)) {
			fb_win32.blitter = alpha_remover_blitter;
		}
		else if (fb_win32.depth == 16) {
			fb_win32.blitter = fb_hGetBlitter(15, FALSE);
			if (!fb_win32.blitter)
				return -1;
		}
		else if ((fb_win32.w & 0x3) || (__fb_gfx->scanline_size > 1)) {
			fb_win32.blitter = fb_hGetBlitter(fb_win32.depth, FALSE);
			if (!fb_win32.blitter)
				return -1;
		}
		if(fb_win32.blitter) {
			buffer = malloc(((fb_win32.w + 3) & ~3) * fb_win32.h * __fb_gfx->bpp);
			if (!buffer)
				return -1;
		}
	}

	hdc = GetDC(fb_win32.wnd);
	__fb_gfx->refresh_rate = GetDeviceCaps(hdc, VREFRESH);

	lp = (LOGPALETTE *)malloc(sizeof(LOGPALETTE) + (sizeof(PALETTEENTRY) * 256));
	lp->palNumEntries = 256;
	lp->palVersion = 0x300;
	fb_hMemCpy(lp->palPalEntry, fb_win32.palette, sizeof(PALETTEENTRY) * 256);
	palette = CreatePalette(lp);
	free(lp);

	ReleaseDC(fb_win32.wnd, hdc);

	ShowWindow(fb_win32.wnd, SW_SHOWNORMAL);

	return 0;
}

static void gdi_exit(void)
{
	if (buffer)
		free(buffer);
	if (bitmap_info)
		free(bitmap_info);
	if (fb_win32.wnd) {
		DestroyWindow(fb_win32.wnd);
	}
	if(switched_to_fullscreen) {
		switched_to_fullscreen = 0;
		ChangeDisplaySettings(NULL, 0);
	}
	if (palette)
		DeleteObject(palette);
}

#ifdef HOST_MINGW
static unsigned int WINAPI gdi_thread( void *param )
#else
static DWORD WINAPI gdi_thread( LPVOID param )
#endif
{
	HANDLE running_event = param;
	int i, y1, y2, h, scanline_size;
	unsigned char *source, keystate[256];
	HDC hdc;
	RECT rect;

	if (gdi_init()) return 1;

	SetEvent(running_event);
	fb_win32.is_active = TRUE;
	
	rect.left = 0;
	rect.right = fb_win32.w;

	while (fb_win32.is_running)
	{
		fb_hWin32Lock();
		scanline_size = __fb_gfx->scanline_size;

		hdc = GetDC(fb_win32.wnd);
		if (fb_win32.is_palette_changed) {
			/* Can't use fb_hMemCpy as structure layout is different :( */
			for (i = 0; i < 256; i++) {
				bitmap_info->bmiColors[i].rgbRed = fb_win32.palette[i].peRed;
				bitmap_info->bmiColors[i].rgbGreen = fb_win32.palette[i].peGreen;
				bitmap_info->bmiColors[i].rgbBlue = fb_win32.palette[i].peBlue;
			}
			/* Update logical palette */
			SetPaletteEntries(palette, 0, 256, fb_win32.palette);
			SelectPalette(hdc, palette, FALSE);
			RealizePalette(hdc);
			fb_win32.is_palette_changed = FALSE;
		}
		/* Only do a single SetDIBitsToDevice call per frame */
		for (y1 = 0; y1 < __fb_gfx->h; y1++) {
			if (__fb_gfx->dirty[y1]) {
				for (y2 = __fb_gfx->h - 1; !__fb_gfx->dirty[y2]; y2--)
					;

				if (fb_win32.blitter) {
					y1 *= scanline_size;
					y2 *= scanline_size;
					fb_win32.blitter(buffer, (__fb_gfx->pitch + 3) & ~0x3);
					source = buffer + (y1 * ((__fb_gfx->pitch + 3) & ~0x3));
				}
				else
				{
					source = __fb_gfx->framebuffer + (y1 * __fb_gfx->pitch);
				}
				h = (y2 - y1 + 1);

				SetDIBitsToDevice(hdc, 0, y1, fb_win32.w, h, 0, 0, 0, h, source, bitmap_info, DIB_RGB_COLORS);
				
				if (fb_win32.version < 0x500) {
					rect.top = y1;
					rect.bottom = h;
					InvalidateRect(fb_win32.wnd, &rect, FALSE);
				}
				
				break;
			}
		}
		ReleaseDC(fb_win32.wnd, hdc);

		fb_hMemSet(__fb_gfx->dirty, FALSE, fb_win32.h);

        if( fb_win32.is_active ) {
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

		fb_hWin32Unlock();

		Sleep(10);
	}

	return 1;
}

static int driver_init(char *title, int w, int h, int depth, int refresh_rate, int flags)
{
	fb_hMemSet(&fb_win32, 0, sizeof(fb_win32));

	if (flags & DRIVER_OPENGL)
		return -1;
	fb_win32.init = gdi_init;
	fb_win32.exit = gdi_exit;
	fb_win32.paint = gdi_paint;
	fb_win32.thread = gdi_thread;

	return fb_hWin32Init(title, w, h, MAX(8, depth), refresh_rate, flags);
}

static int *driver_fetch_modes(int depth, int *size)
{
	int *data = NULL, *newdata;
	int mode = 0;
	int count = 0;
	DEVMODE dm;

	while (EnumDisplaySettings(NULL, mode, &dm)) {
		if ((dm.dmBitsPerPel == (unsigned int)depth) ||
		    (dm.dmBitsPerPel == 15 && depth == 16) ||
		    (dm.dmBitsPerPel == 16 && depth == 15) ||
		    (dm.dmBitsPerPel == 24 && depth == 32) ||
		    (dm.dmBitsPerPel == 32 && depth == 24)) {
			++count;
			newdata = realloc(data, count * sizeof(int));
			if (!newdata) {
				*size = count - 1;
				return data;
			}
			data = newdata;
			data[count - 1] = SCREENLIST(dm.dmPelsWidth, dm.dmPelsHeight);
		}
		++mode;
	}

	*size = count;
	return data;
}
