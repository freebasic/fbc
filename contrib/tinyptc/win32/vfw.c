//
// TinyPTC by Gaffer
// www.gaffer.org/tinyptc
//

// VFW implementation of TinyPTC by raster
// - Uses the DrawDib family of functions

#include "tinyptc.h"

#ifdef __PTC_VFW__

#define WIN32_LEAN_AND_MEAN
#define NOCOMPMAN
#define NOVIDEO
#define NOAVIFMT
#define NOMMREG
#define NOAVIFILE
#define NOMCIWND
#define NOAVICAP
#define NOMSACM

#include <windows.h>
#include <vfw.h>

// VFW function pointers so that the can be dynamically linked
typedef HDRAWDIB (VFWAPI * DRAWDIBOPEN) (void);
typedef BOOL (VFWAPI * DRAWDIBCLOSE) (HDRAWDIB hdd);
typedef BOOL (VFWAPI * DRAWDIBBEGIN) (HDRAWDIB hdd,
																			HDC hdc,
																			int dxDst,
																			int dyDst,
																			LPBITMAPINFOHEADER lpbi,
																			int dxSrc,
																			int dySrc,
																			UINT wFlags);
typedef BOOL (VFWAPI * DRAWDIBDRAW) (HDRAWDIB hdd,
																		 HDC hdc,
																		 int xDst,
																		 int yDst,
																		 int dxDst,
																		 int dyDst,
																		 LPBITMAPINFOHEADER lpbi,
																		 LPVOID lpBits,
																		 int xSrc,
																		 int ySrc,
																		 int dxSrc,
																		 int dySrc,
																		 UINT wFlags);
typedef BOOL (VFWAPI * DRAWDIBEND) (HDRAWDIB hdd);

static HMODULE library = 0;
static WNDCLASS wc;
static HWND wnd;
static BITMAPINFOHEADER bitmap_header;
static int surface_width;
static int surface_height;
static void *cached_buffer = 0;
static HDRAWDIB bitmap_hdd;
static DRAWDIBOPEN draw_dib_open;
static DRAWDIBCLOSE draw_dib_close;
static DRAWDIBBEGIN draw_dib_begin;
static DRAWDIBDRAW draw_dib_draw;
static DRAWDIBEND draw_dib_end;

static int original_window_x;
static int original_window_y;
static int original_window_width;
static int original_window_height;

// this is not meant to be static, in case someone wants to use it.
// (TextOut etc. being rather useful functions)
HDC window_hdc;

// menu option identifier
#define SC_ZOOM_MSK 0x400
#define SC_ZOOM_1x1 0x401
#define SC_ZOOM_2x2 0x402
#define SC_ZOOM_4x4 0x404


static LRESULT CALLBACK WndProc(HWND hWnd,UINT message,WPARAM wParam,LPARAM lParam)
{
	// result data
	int result = 0;

	// handle message
	switch (message)
	{
		case WM_PAINT:
		{
			// check cached buffer
			if (cached_buffer!=0)
			{
				#ifdef __PTC_RESIZE_WINDOW__
					// grab current window size
					RECT windowsize;
					GetClientRect(hWnd, &windowsize);
					draw_dib_draw(bitmap_hdd,
												window_hdc, 
												0, 0, windowsize.right, windowsize.bottom,
												&bitmap_header,
												cached_buffer,
												0, 0, surface_width, surface_height,
												0);
				#else
					draw_dib_draw(bitmap_hdd,
												window_hdc, 
												0, 0, surface_width, surface_height,
												&bitmap_header,
												cached_buffer,
												0, 0, surface_width, surface_height,
												0);
				#endif

				// validate window
				ValidateRect(wnd,NULL);
			}
		}
		break;

#ifdef __PTC_WINDOWED__
#ifdef __PTC_RESIZE_WINDOW__
#ifdef __PTC_SYSTEM_MENU__

		// check for message from our system menu entry
		case WM_SYSCOMMAND:
		{
			if ((wParam&0xFFFFFFF0)==SC_ZOOM_MSK)
			{
				#ifdef __PTC_CENTER_WINDOW__
					int zoom = wParam & 0x7;
					int x = (GetSystemMetrics(SM_CXSCREEN) - original_window_width*zoom) >> 1;
					int y = (GetSystemMetrics(SM_CYSCREEN) - original_window_height*zoom) >> 1;
					SetWindowPos(hWnd, NULL, x, y,original_window_width*zoom, original_window_height*zoom, SWP_NOZORDER);
				#else
					int zoom = wParam & 0x7;
					SetWindowPos(hWnd, NULL, 0, 0,original_window_width*zoom, original_window_height*zoom, SWP_NOMOVE | SWP_NOZORDER);
				#endif
			}
			// pass everything else to the default (this is rather important)
			else return DefWindowProc(hWnd, message, wParam, lParam);
		}
#endif
#endif
#endif

#ifdef __PTC_CLOSE_ON_ESCAPE__

        case WM_KEYDOWN:
        {
            // close on escape key
            if ((wParam&0xFF)!=27) break;
        }

#endif

		case WM_CLOSE:
		{
            #ifdef __PTC_ALLOW_CLOSE__

			    // close ptc
			    ptc_close();

			    // exit process
			    ExitProcess(0);

            #endif
		}
		break;

		default:
		{
			// unhandled messages
			result = DefWindowProc(hWnd,message,wParam,lParam);
		}
	}

	// finished
	return result;
}


int ptc_open(char *title,int width,int height)
{
	RECT rect;

	// load vfw library
	library = (HMODULE) LoadLibrary("msvfw32.dll");
	if (!library) return 0;

	// get DrawDibOpen function address
	draw_dib_open = (DRAWDIBOPEN) GetProcAddress(library, "DrawDibOpen");
	if (!draw_dib_open) return 0;

	// get DrawDibClose function address
	draw_dib_close = (DRAWDIBCLOSE) GetProcAddress(library, "DrawDibClose");
	if (!draw_dib_close) return 0;

	// get DrawDibBegin function address
	draw_dib_begin = (DRAWDIBBEGIN) GetProcAddress(library, "DrawDibBegin");
	if (!draw_dib_begin) return 0;

	// get DrawDibDraw function address
	draw_dib_draw = (DRAWDIBDRAW) GetProcAddress(library, "DrawDibDraw");
	if (!draw_dib_draw) return 0;

	// get DrawDibEnd function address
	draw_dib_end = (DRAWDIBEND) GetProcAddress(library, "DrawDibEnd");
	if (!draw_dib_end) return 0;

	// register window class
	wc.style = CS_OWNDC | CS_VREDRAW | CS_HREDRAW;      // very important
	wc.lpfnWndProc = WndProc;
	wc.cbClsExtra = 0;
	wc.cbWndExtra = 0;
#ifdef __PTC_ICON__
	wc.hInstance = GetModuleHandle(0);
	wc.hIcon = LoadIcon(wc.hInstance, __PTC_ICON__);
#else
	wc.hInstance = 0;
	wc.hIcon = NULL;
#endif
	wc.hCursor = LoadCursor(0,IDC_ARROW);
	wc.hbrBackground = NULL;
	wc.lpszMenuName = NULL;
	wc.lpszClassName = title;
	RegisterClass(&wc);

	// calculate window size
	rect.left = 0;
	rect.top = 0;
	rect.right = width;
	rect.bottom = height;
#ifdef __PTC_RESIZE_WINDOW__
	AdjustWindowRect(&rect, WS_OVERLAPPEDWINDOW, 0);
#else
	AdjustWindowRect(&rect,WS_POPUP|WS_SYSMENU|WS_CAPTION,0);
#endif
	rect.right -= rect.left;
	 rect.bottom -= rect.top;

	// save surface size and original window size
	surface_width = width;
	surface_height = height;
	original_window_width = rect.right;
	original_window_height = rect.bottom;

#ifdef __PTC_CENTER_WINDOW__
	// center window
	original_window_x = (GetSystemMetrics(SM_CXSCREEN) - rect.right) >> 1;
	original_window_y = (GetSystemMetrics(SM_CYSCREEN) - rect.bottom) >> 1;
#else
	// let windows decide
	original_window_x = CW_USEDEFAULT;
	original_window_y = CW_USEDEFAULT;
#endif

	// create window and show it
#ifdef __PTC_RESIZE_WINDOW__
	wnd = CreateWindowEx(0, title,title,WS_OVERLAPPEDWINDOW,original_window_x,original_window_y,rect.right,rect.bottom,0,0,0,0);
#else
	wnd = CreateWindowEx(0, title,title,WS_OVERLAPPEDWINDOW & ~WS_MAXIMIZEBOX & ~WS_THICKFRAME,original_window_x,original_window_y,rect.right,rect.bottom,0,0,0,0);
#endif
	ShowWindow(wnd,SW_NORMAL);

	// get window dc
	window_hdc = GetDC(wnd);

	// create bitmap header
	bitmap_header.biSize = sizeof(BITMAPINFOHEADER);
	bitmap_header.biPlanes = 1;
	bitmap_header.biBitCount = 32;
	bitmap_header.biCompression = BI_RGB;
	bitmap_header.biWidth = surface_width;
	bitmap_header.biHeight = surface_height;

	// initialise drawdib
	bitmap_hdd = draw_dib_open();
	draw_dib_begin(bitmap_hdd, window_hdc, rect.right, rect.bottom, &bitmap_header, surface_width, surface_height, 0);

#ifdef __PTC_RESIZE_WINDOW__
#ifdef __PTC_SYSTEM_MENU__
	{
		// add entry to system menu to restore original window size
		HMENU menu = GetSystemMenu(wnd,FALSE);
		AppendMenu(menu, MF_STRING, SC_ZOOM_1x1, "Zoom 1 x 1");
		AppendMenu(menu, MF_STRING, SC_ZOOM_2x2, "Zoom 2 x 2");
		AppendMenu(menu, MF_STRING, SC_ZOOM_4x4, "Zoom 4 x 4");
	}
#endif
#endif

#ifdef __PTC_DISABLE_SCREENSAVER__

    // disable screensaver while ptc is open
    SystemParametersInfo(SPI_SETSCREENSAVEACTIVE, 0, 0, 0);

#endif

	// success
	return 1;
}


int ptc_update(void *buffer)
{
	MSG message;

	// update buffer ptr cache
	cached_buffer = buffer;             // note: this is kinda naughty... but hey :)

	// invalidate window
	InvalidateRect(wnd,NULL,TRUE);

	// send paint window message
	SendMessage(wnd,WM_PAINT,0,0);

	// process messages
	while (PeekMessage(&message,wnd,0,0,PM_REMOVE))
	{
		// translate and dispatch
		TranslateMessage(&message);
		DispatchMessage(&message);
	}

	// sleep
	Sleep(0);

	// success
	return 1;
}


void ptc_close()
{
	// close down the drawdib library
	draw_dib_end(bitmap_hdd);
	draw_dib_close(bitmap_hdd);

	// clear cached buffer
	cached_buffer = 0;

	// release DC
	ReleaseDC(wnd, window_hdc);
	
	// destroy window
	DestroyWindow(wnd);

#ifdef __PTC_DISABLE_SCREENSAVER__

    // enable screensaver now that ptc is closed
    SystemParametersInfo(SPI_SETSCREENSAVEACTIVE, 1, 0, 0);

#endif
}


#endif
