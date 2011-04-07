//
// TinyPTC by Gaffer
// www.gaffer.org/tinyptc
//

#include "tinyptc.h"

#ifdef __PTC_DDRAW__

#include "convert.h"
#define WIN32_LEAN_AND_MEAN
#include "ddraw.h"

PTC_CONVERTER convert;
static HMODULE library = 0;
static LPDIRECTDRAW lpDD = 0;
static LPDIRECTDRAWSURFACE lpDDS = 0;
static LPDIRECTDRAWSURFACE lpDDS_back;
static WNDCLASS wc;
static HWND wnd;
static int active = TRUE;
static int dx;
static int dy;

#ifdef __PTC_WINDOWED__
static LPDIRECTDRAWCLIPPER lpDDC = 0;
static LPDIRECTDRAWSURFACE lpDDS_secondary = 0;
#endif

#ifdef __PTC_SYSTEM_MENU__
static int original_window_width;
static int original_window_height;
static HMENU system_menu;
#endif


typedef HRESULT (WINAPI * DIRECTDRAWCREATE) (GUID FAR *lpGUID,LPDIRECTDRAW FAR *lplpDD,IUnknown FAR *pUnkOuter);


#ifdef __PTC_WINDOWED__

static void ptc_paint_primary()
{
    RECT source;
    RECT destination;
    POINT point;

    // check
    if (lpDDS)
    {
        // setup source rectangle
        source.left = 0;
        source.top = 0;
        source.right = dx;
        source.bottom = dy;

        // get origin of client area
        point.x = 0;
        point.y = 0;
        ClientToScreen(wnd,&point);

        // get window client area
        GetClientRect(wnd,&destination);

        // offset destination rectangle
        destination.left += point.x;
        destination.top += point.y;
        destination.right += point.x;
        destination.bottom += point.y;

        // blt secondary to primary surface
        IDirectDrawSurface_Blt(lpDDS,&destination,lpDDS_secondary,&source,DDBLT_WAIT,0);
    }
}

#endif


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
#ifdef __PTC_WINDOWED__

    case WM_PAINT:
        {
            // paint primary
            ptc_paint_primary();

            // call default window painting
            return DefWindowProc(hWnd,message,wParam,lParam);
        }
        break;

#endif

    case WM_ACTIVATEAPP:
        {
            // update active flag
            active = (BOOL) wParam;
        }
        break;

#ifndef __PTC_WINDOWED__
    case WM_SETCURSOR:
        {
            // hide cursor
            SetCursor(0);
        }
        break;

#endif


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

    case WM_SYSKEYDOWN:
        if (!active)
            break;

    case WM_KEYDOWN:
        {
            WORD wVkCode = (WORD) wParam;
            WORD wVsCode = (WORD) (( lParam & 0xFF0000 ) >> 16);
            int is_ext_keycode = ( lParam & 0x1000000 )!=0;
            size_t repeat_count = ( lParam & 0xFFFF );
            DWORD dwControlKeyState = 0;
            char chAsciiChar;
            int is_dead_key;
            int key;
            BYTE key_state[256];

            GetKeyboardState(key_state);

            if( (key_state[VK_SHIFT] | key_state[VK_LSHIFT] | key_state[VK_RSHIFT]) & 0x80 )
                dwControlKeyState ^= SHIFT_PRESSED;
            if( (key_state[VK_LCONTROL] | key_state[VK_CONTROL]) & 0x80 )
                dwControlKeyState ^= LEFT_CTRL_PRESSED;
            if( key_state[VK_RCONTROL] & 0x80 )
                dwControlKeyState ^= RIGHT_CTRL_PRESSED;
            if( (key_state[VK_LMENU] | key_state[VK_MENU]) & 0x80 )
                dwControlKeyState ^= LEFT_ALT_PRESSED;
            if( key_state[VK_RMENU] & 0x80 )
                dwControlKeyState ^= RIGHT_ALT_PRESSED;
            if( is_ext_keycode )
                dwControlKeyState |= ENHANCED_KEY;

            is_dead_key = (MapVirtualKey( wVkCode, 2 ) & 0x80000000)!=0;
            if( !is_dead_key ) {
                WORD wKey = 0;
                if( ToAscii( wVkCode, wVsCode, key_state, &wKey, 0 )==1 ) {
                    chAsciiChar = (char) wKey;
                } else {
                    chAsciiChar = 0;
                }
            } else {
                /* Never use ToAscii when a dead key is used - otherwise
                 * we don't get the combined character (for accents) */
                chAsciiChar = 0;
            }
            key =
                fb_hConsoleTranslateKey( chAsciiChar,
                                         wVsCode,
                                         wVkCode,
                                         dwControlKeyState,
                                         FALSE );
            if ( key>255 ) {
                while( repeat_count-- ) {
                    fb_hTinyPtcPostKey(key);
                }
            }

            /* We don't want to enter the menu ... */
            if( wVkCode==VK_F10 || wVkCode==VK_MENU || key==0x6BFF )
                return FALSE;
        }
        break;

    case WM_CHAR:
        {
            size_t repeat_count = ( lParam & 0xFFFF );
            int key = (int) wParam;
            if( key < 256 ) {
                int target_cp = FB_GFX_GET_CODEPAGE();
                if( target_cp!=-1 ) {
                    char ch[2] = {
                        (char) key,
                        0
                    };
                    FBSTRING *result =
                        fb_StrAllocTempDescF( ch, 2 );
                    result = fb_hIntlConvertString( result,
                                                    CP_ACP,
                                                    target_cp );
                    key = (unsigned) (unsigned char) result->data[0];
                    fb_hStrDelTemp( result );
                }

                while( repeat_count-- ) {
                    fb_hTinyPtcPostKey(key);
                }
            }
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
#ifdef __PTC_WINDOWED__
    int x;
    int y;
    RECT rect;
    //DEVMODE mode;
#else
    DDSCAPS capabilities;
#endif
    DDPIXELFORMAT format;
    DDSURFACEDESC descriptor;
    DIRECTDRAWCREATE DirectDrawCreate;

    // setup data
    dx = width;
    dy = height;

    // load direct draw library
    library = (HMODULE) LoadLibrary("ddraw.dll");
    if (!library) return 0;

    // get directdraw create function address
    DirectDrawCreate = (DIRECTDRAWCREATE) GetProcAddress(library,"DirectDrawCreate");
    if (!DirectDrawCreate) return 0;

    // create directdraw interface
    if (FAILED(DirectDrawCreate(0,&lpDD,0))) return 0;

#ifndef __PTC_WINDOWED__

    // register window class
    wc.style = 0;
    wc.lpfnWndProc = WndProc;
    wc.cbClsExtra = 0;
    wc.cbWndExtra = 0;
#ifdef __PTC_ICON__
    wc.hInstance = GetModuleHandle(0);
    wc.hIcon = LoadIcon(wc.hInstance,__PTC_ICON__);
#else
    wc.hInstance = 0;
    wc.hIcon = 0;
#endif
    wc.hCursor = 0;
    wc.hbrBackground = 0;
    wc.lpszMenuName = 0;
    wc.lpszClassName = title;
    RegisterClass(&wc);

    // create window
#ifdef __PTC_ICON__
    wnd = CreateWindow(title,title,WS_POPUP | WS_SYSMENU,0,0,0,0,0,0,0,0);
#else
    wnd = CreateWindow(title,title,WS_POPUP,0,0,0,0,0,0,0,0);
#endif

    // enter exclusive mode
    if (FAILED(IDirectDraw_SetCooperativeLevel(lpDD,wnd,DDSCL_EXCLUSIVE | DDSCL_FULLSCREEN))) return 0;

    // enter display mode
    if (FAILED(IDirectDraw_SetDisplayMode(lpDD,width,height,32)))
    {
        if (FAILED(IDirectDraw_SetDisplayMode(lpDD,width,height,24)))
        {
            if (FAILED(IDirectDraw_SetDisplayMode(lpDD,width,height,16)))
            {
                // failure
                return 0;
            }
        }
    }

    // primary with two back buffers
    descriptor.dwSize  = sizeof(descriptor);
    descriptor.dwFlags = DDSD_CAPS | DDSD_BACKBUFFERCOUNT;
    descriptor.dwBackBufferCount = 2;
    descriptor.ddsCaps.dwCaps = DDSCAPS_PRIMARYSURFACE | DDSCAPS_VIDEOMEMORY | DDSCAPS_COMPLEX | DDSCAPS_FLIP;
    if (FAILED(IDirectDraw_CreateSurface(lpDD,&descriptor,&lpDDS,0)))
    {
        // primary with one back buffer
        descriptor.dwBackBufferCount = 1;
        if (FAILED(IDirectDraw_CreateSurface(lpDD,&descriptor,&lpDDS,0)))
        {
            // primary with no back buffers
            descriptor.dwFlags = DDSD_CAPS;
            descriptor.ddsCaps.dwCaps = DDSCAPS_PRIMARYSURFACE | DDSCAPS_VIDEOMEMORY;
            if (FAILED(IDirectDraw_CreateSurface(lpDD,&descriptor,&lpDDS,0)))
            {
                // failure
                return 0;
            }
        }
    }

    // get back surface
    capabilities.dwCaps = DDSCAPS_BACKBUFFER;
    if (FAILED(IDirectDrawSurface_GetAttachedSurface(lpDDS,&capabilities,&lpDDS_back))) return 0;

#else

    // register window class
    wc.style = CS_VREDRAW | CS_HREDRAW;
    wc.lpfnWndProc = WndProc;
    wc.cbClsExtra = 0;
    wc.cbWndExtra = 0;
#ifdef __PTC_ICON__
    wc.hInstance = GetModuleHandle(0);
    wc.hIcon = LoadIcon(wc.hInstance,__PTC_ICON__);
#else
    wc.hInstance = 0;
    wc.hIcon = 0;
#endif
    wc.hCursor = LoadCursor(0,IDC_ARROW);
    wc.hbrBackground = 0;
    wc.lpszMenuName = 0;
    wc.lpszClassName = title;
    RegisterClass(&wc);

    // calculate window size
    rect.left = 0;
    rect.top = 0;
    rect.right = width;
    rect.bottom = height;
    AdjustWindowRect(&rect,WS_OVERLAPPEDWINDOW,0);
    rect.right -= rect.left;
    rect.bottom -= rect.top;

#ifdef __PTC_CENTER_WINDOW__

    // center window
    x = (GetSystemMetrics(SM_CXSCREEN) - rect.right) >> 1;
    y = (GetSystemMetrics(SM_CYSCREEN) - rect.bottom) >> 1;

#else

    // let windows decide
    x = CW_USEDEFAULT;
    y = CW_USEDEFAULT;

#endif

#ifdef __PTC_RESIZE_WINDOW__

    // create resizable window
    wnd = CreateWindow(title,title,WS_OVERLAPPEDWINDOW,x,y,rect.right,rect.bottom,0,0,0,0);

#else

    // create fixed window
    wnd = CreateWindow(title,title,WS_OVERLAPPEDWINDOW & ~WS_MAXIMIZEBOX & ~WS_THICKFRAME,x,y,rect.right,rect.bottom,0,0,0,0);

#endif

    // show window
    ShowWindow(wnd,SW_NORMAL);

#ifdef __PTC_RESIZE_WINDOW__
#ifdef __PTC_SYSTEM_MENU__

    // add entry to system menu to restore original window size
    system_menu = GetSystemMenu(wnd,FALSE);
    AppendMenu(system_menu, MF_STRING, SC_ZOOM_1x1, "Zoom 1 x 1");
    AppendMenu(system_menu, MF_STRING, SC_ZOOM_2x2, "Zoom 2 x 2");
    AppendMenu(system_menu, MF_STRING, SC_ZOOM_4x4, "Zoom 4 x 4");

    // save original window size
    original_window_width = rect.right;
    original_window_height = rect.bottom;

#endif
#endif

    // enter cooperative mode
    if (FAILED(IDirectDraw_SetCooperativeLevel(lpDD,wnd,DDSCL_NORMAL))) return 0;

    // primary with no back buffers
    descriptor.dwSize  = sizeof(descriptor);
    descriptor.dwFlags = DDSD_CAPS;
    descriptor.ddsCaps.dwCaps = DDSCAPS_PRIMARYSURFACE | DDSCAPS_VIDEOMEMORY;
    if (FAILED(IDirectDraw_CreateSurface(lpDD,&descriptor,&lpDDS,0))) return 0;

    // create secondary surface
    descriptor.dwFlags = DDSD_CAPS | DDSD_HEIGHT | DDSD_WIDTH;
    descriptor.ddsCaps.dwCaps = DDSCAPS_OFFSCREENPLAIN;
    descriptor.dwWidth = width;
    descriptor.dwHeight = height;
    if (FAILED(IDirectDraw_CreateSurface(lpDD,&descriptor,&lpDDS_secondary,0))) return 0;

    // create clipper
    if (FAILED(IDirectDraw_CreateClipper(lpDD,0,&lpDDC,0))) return 0;

    // set clipper to window
    if (FAILED(IDirectDrawClipper_SetHWnd(lpDDC,0,wnd))) return 0;

    // attach clipper object to primary surface
    if (FAILED(IDirectDrawSurface_SetClipper(lpDDS,lpDDC))) return 0;

    // set back to secondary
    lpDDS_back = lpDDS_secondary;

#endif

    // get pixel format
    format.dwSize = sizeof(format);
    if (FAILED(IDirectDrawSurface_GetPixelFormat(lpDDS,&format))) return 0;

    // check that format is direct color
    if (!(format.dwFlags & DDPF_RGB)) return 0;

    // request converter function
    convert = ptc_request_converter(format.dwRGBBitCount,format.dwRBitMask,format.dwGBitMask,format.dwBBitMask);
    if (!convert) return 0;

#ifdef __PTC_DISABLE_SCREENSAVER__

    // disable screensaver while ptc is open
    SystemParametersInfo(SPI_SETSCREENSAVEACTIVE, 0, 0, 0);

#endif

    __fb_ctx.hooks.inkeyproc = fb_TinyPtcInkey;
    __fb_ctx.hooks.getkeyproc = fb_TinyPtcGetkey;
    __fb_ctx.hooks.keyhitproc = fb_TinyPtcKeyHit;

    // success
    return 1;
}


int ptc_update(void *buffer)
{
    int y;
    char8 *src;
    char8 *dst;
    int src_pitch;
    int dst_pitch;
    MSG message;
    DDSURFACEDESC descriptor;

    // process messages
    while (PeekMessage(&message,wnd,0,0,PM_REMOVE))
    {
        // translate and dispatch
        TranslateMessage(&message);
        DispatchMessage(&message);
    }

#ifndef __PTC_WINDOWED__
    if (active)
#endif
    {
        // restore surfaces
        IDirectDrawSurface_Restore(lpDDS);
#ifdef __PTC_WINDOWED__
        IDirectDrawSurface_Restore(lpDDS_secondary);
#endif

        // lock back surface
        descriptor.dwSize = sizeof descriptor;
        if (FAILED(IDirectDrawSurface_Lock(lpDDS_back,0,&descriptor,DDLOCK_WAIT,0))) return 0;

        // calculate pitches
        src_pitch = dx * 4;
        dst_pitch = descriptor.lPitch;

        // copy pixels to back surface
        src = (char8*) buffer;
        dst = (char8*) descriptor.lpSurface;
        for (y=0; y<dy; y++)
        {
            // convert line
            convert(src,dst,dx);
            src += src_pitch;
            dst += dst_pitch;
        }

        // unlock back surface
        IDirectDrawSurface_Unlock(lpDDS_back,descriptor.lpSurface);

#ifndef __PTC_WINDOWED__

        // flip primary surface
        IDirectDrawSurface_Flip(lpDDS,0,DDFLIP_DONOTWAIT | DDFLIP_NOVSYNC /*DDFLIP_WAIT*/);

#else

        // paint primary
        ptc_paint_primary();

#endif

        // sleep
        Sleep(0);
    }
#ifndef __PTC_WINDOWED__
    else
    {
        // sleep
        Sleep(1);
    }
#endif

    // success
    return 1;
}


void ptc_close()
{
#ifdef __PTC_WINDOWED__

    // check secondary
    if (lpDDS_secondary)
    {
        // release secondary
        IDirectDrawSurface_Release(lpDDS_secondary);
        lpDDS_secondary = 0;
    }

#endif

    // check
    if (lpDDS)
    {
        // release primary
        IDirectDrawSurface_Release(lpDDS);
        lpDDS = 0;
    }

    // check
    if (lpDD)
    {
        // leave display mode
        IDirectDraw_RestoreDisplayMode(lpDD);

        // leave exclusive mode
        IDirectDraw_SetCooperativeLevel(lpDD,wnd,DDSCL_NORMAL);

        // free direct draw
        IDirectDraw_Release(lpDD);
        lpDD = 0;
    }

    // hide window
    DestroyWindow(wnd);

    // check
    if (library)
    {
        // free library
        FreeLibrary(library);
        library = 0;
    }

#ifdef __PTC_DISABLE_SCREENSAVER__

    // enable screensaver now that ptc is closed
    SystemParametersInfo(SPI_SETSCREENSAVEACTIVE, 1, 0, 0);

#endif

    __fb_ctx.hooks.inkeyproc = NULL;
    __fb_ctx.hooks.getkeyproc = NULL;
    __fb_ctx.hooks.keyhitproc = NULL;
}


#endif
