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
 * ddraw.c -- DirectDraw gfx driver
 *
 * chng: jan/2005 written [lillo]
 *
 */

#define WIN32_LEAN_AND_MEAN
#define INITGUID
#include <objbase.h>
#include <ddraw.h>
#include <dinput.h>

#include "fb_gfx.h"


#define KEY_BUFFER_LEN		16

#define WINDOW_CLASS_PREFIX "fbgfxclass_"

static int ddraw_init(char *title, int w, int h, int depth, int flags);
static void ddraw_exit(void);
static void ddraw_lock(void);
static void ddraw_unlock(void);
static void ddraw_set_palette(int index, int r, int g, int b);
static void ddraw_wait_vsync(void);
static int ddraw_get_key(int wait);
static int ddraw_get_mouse(int *x, int *y, int *z, int *buttons);
static void ddraw_set_window_title(char *title);



GFXDRIVER fb_gfxDriverDirectDraw =
{
	ddraw_init,		/* int (*init)(int w, int h, char *title, int fullscreen); */
	ddraw_exit,		/* void (*exit)(void); */
	ddraw_lock,		/* void (*lock)(void); */
	ddraw_unlock,		/* void (*unlock)(void); */
	ddraw_set_palette,	/* void (*set_palette)(int index, int r, int g, int b); */
	ddraw_wait_vsync,	/* void (*wait_vsync)(void); */
	ddraw_get_key,		/* int (*get_key)(int wait); */
	ddraw_get_mouse,	/* int (*get_mouse)(int *x, int *y, int *z, int *buttons); */
	ddraw_set_window_title	/* void (*set_window_title)(char *title); */
};


/* We don't want to directly link with DDRAW.DLL and DINPUT.DLL,
 * as this way generated exes will not depend on them to run.
 * This will ensure if DirectX is not installed in the system,
 * the programs will still run, maybe fallbacking on a GDI
 * driver.
 */
typedef HRESULT (WINAPI *DIRECTDRAWCREATE)(GUID FAR *lpGUID,LPDIRECTDRAW FAR *lplpDD,IUnknown FAR *pUnkOuter);
typedef HRESULT (WINAPI *DIRECTINPUTCREATE)(GUID FAR *lpGUID,DWORD dwVersion,LPDIRECTINPUT FAR *lplpDI,IUnknown FAR *pUnkOuter);

/* Unfortunately c_dfDIKeyboard is a required global variable
 * defined in import library LIBDINPUT.A, and as we're not
 * linking with it, we need to define it here...
 */
static DIOBJECTDATAFORMAT c_rgodfDIKeyboard[256] = {
	{ &GUID_Key, 0, 0x8000000C, 0 }, 	{ &GUID_Key, 1, 0x8000010C, 0 },
	{ &GUID_Key, 2, 0x8000020C, 0 }, 	{ &GUID_Key, 3, 0x8000030C, 0 },
	{ &GUID_Key, 4, 0x8000040C, 0 }, 	{ &GUID_Key, 5, 0x8000050C, 0 },
	{ &GUID_Key, 6, 0x8000060C, 0 }, 	{ &GUID_Key, 7, 0x8000070C, 0 },
	{ &GUID_Key, 8, 0x8000080C, 0 }, 	{ &GUID_Key, 9, 0x8000090C, 0 },
	{ &GUID_Key, 10, 0x80000A0C, 0 }, 	{ &GUID_Key, 11, 0x80000B0C, 0 },
	{ &GUID_Key, 12, 0x80000C0C, 0 }, 	{ &GUID_Key, 13, 0x80000D0C, 0 },
	{ &GUID_Key, 14, 0x80000E0C, 0 }, 	{ &GUID_Key, 15, 0x80000F0C, 0 },
	{ &GUID_Key, 16, 0x8000100C, 0 }, 	{ &GUID_Key, 17, 0x8000110C, 0 },
	{ &GUID_Key, 18, 0x8000120C, 0 }, 	{ &GUID_Key, 19, 0x8000130C, 0 },
	{ &GUID_Key, 20, 0x8000140C, 0 }, 	{ &GUID_Key, 21, 0x8000150C, 0 },
	{ &GUID_Key, 22, 0x8000160C, 0 }, 	{ &GUID_Key, 23, 0x8000170C, 0 },
	{ &GUID_Key, 24, 0x8000180C, 0 }, 	{ &GUID_Key, 25, 0x8000190C, 0 },
	{ &GUID_Key, 26, 0x80001A0C, 0 }, 	{ &GUID_Key, 27, 0x80001B0C, 0 },
	{ &GUID_Key, 28, 0x80001C0C, 0 }, 	{ &GUID_Key, 29, 0x80001D0C, 0 },
	{ &GUID_Key, 30, 0x80001E0C, 0 }, 	{ &GUID_Key, 31, 0x80001F0C, 0 },
	{ &GUID_Key, 32, 0x8000200C, 0 }, 	{ &GUID_Key, 33, 0x8000210C, 0 },
	{ &GUID_Key, 34, 0x8000220C, 0 }, 	{ &GUID_Key, 35, 0x8000230C, 0 },
	{ &GUID_Key, 36, 0x8000240C, 0 }, 	{ &GUID_Key, 37, 0x8000250C, 0 },
	{ &GUID_Key, 38, 0x8000260C, 0 }, 	{ &GUID_Key, 39, 0x8000270C, 0 },
	{ &GUID_Key, 40, 0x8000280C, 0 }, 	{ &GUID_Key, 41, 0x8000290C, 0 },
	{ &GUID_Key, 42, 0x80002A0C, 0 }, 	{ &GUID_Key, 43, 0x80002B0C, 0 },
	{ &GUID_Key, 44, 0x80002C0C, 0 }, 	{ &GUID_Key, 45, 0x80002D0C, 0 },
	{ &GUID_Key, 46, 0x80002E0C, 0 }, 	{ &GUID_Key, 47, 0x80002F0C, 0 },
	{ &GUID_Key, 48, 0x8000300C, 0 }, 	{ &GUID_Key, 49, 0x8000310C, 0 },
	{ &GUID_Key, 50, 0x8000320C, 0 }, 	{ &GUID_Key, 51, 0x8000330C, 0 },
	{ &GUID_Key, 52, 0x8000340C, 0 }, 	{ &GUID_Key, 53, 0x8000350C, 0 },
	{ &GUID_Key, 54, 0x8000360C, 0 }, 	{ &GUID_Key, 55, 0x8000370C, 0 },
	{ &GUID_Key, 56, 0x8000380C, 0 }, 	{ &GUID_Key, 57, 0x8000390C, 0 },
	{ &GUID_Key, 58, 0x80003A0C, 0 }, 	{ &GUID_Key, 59, 0x80003B0C, 0 },
	{ &GUID_Key, 60, 0x80003C0C, 0 }, 	{ &GUID_Key, 61, 0x80003D0C, 0 },
	{ &GUID_Key, 62, 0x80003E0C, 0 }, 	{ &GUID_Key, 63, 0x80003F0C, 0 },
	{ &GUID_Key, 64, 0x8000400C, 0 }, 	{ &GUID_Key, 65, 0x8000410C, 0 },
	{ &GUID_Key, 66, 0x8000420C, 0 }, 	{ &GUID_Key, 67, 0x8000430C, 0 },
	{ &GUID_Key, 68, 0x8000440C, 0 }, 	{ &GUID_Key, 69, 0x8000450C, 0 },
	{ &GUID_Key, 70, 0x8000460C, 0 }, 	{ &GUID_Key, 71, 0x8000470C, 0 },
	{ &GUID_Key, 72, 0x8000480C, 0 }, 	{ &GUID_Key, 73, 0x8000490C, 0 },
	{ &GUID_Key, 74, 0x80004A0C, 0 }, 	{ &GUID_Key, 75, 0x80004B0C, 0 },
	{ &GUID_Key, 76, 0x80004C0C, 0 }, 	{ &GUID_Key, 77, 0x80004D0C, 0 },
	{ &GUID_Key, 78, 0x80004E0C, 0 }, 	{ &GUID_Key, 79, 0x80004F0C, 0 },
	{ &GUID_Key, 80, 0x8000500C, 0 }, 	{ &GUID_Key, 81, 0x8000510C, 0 },
	{ &GUID_Key, 82, 0x8000520C, 0 }, 	{ &GUID_Key, 83, 0x8000530C, 0 },
	{ &GUID_Key, 84, 0x8000540C, 0 }, 	{ &GUID_Key, 85, 0x8000550C, 0 },
	{ &GUID_Key, 86, 0x8000560C, 0 }, 	{ &GUID_Key, 87, 0x8000570C, 0 },
	{ &GUID_Key, 88, 0x8000580C, 0 }, 	{ &GUID_Key, 89, 0x8000590C, 0 },
	{ &GUID_Key, 90, 0x80005A0C, 0 }, 	{ &GUID_Key, 91, 0x80005B0C, 0 },
	{ &GUID_Key, 92, 0x80005C0C, 0 }, 	{ &GUID_Key, 93, 0x80005D0C, 0 },
	{ &GUID_Key, 94, 0x80005E0C, 0 }, 	{ &GUID_Key, 95, 0x80005F0C, 0 },
	{ &GUID_Key, 96, 0x8000600C, 0 }, 	{ &GUID_Key, 97, 0x8000610C, 0 },
	{ &GUID_Key, 98, 0x8000620C, 0 }, 	{ &GUID_Key, 99, 0x8000630C, 0 },
	{ &GUID_Key, 100, 0x8000640C, 0 }, 	{ &GUID_Key, 101, 0x8000650C, 0 },
	{ &GUID_Key, 102, 0x8000660C, 0 }, 	{ &GUID_Key, 103, 0x8000670C, 0 },
	{ &GUID_Key, 104, 0x8000680C, 0 }, 	{ &GUID_Key, 105, 0x8000690C, 0 },
	{ &GUID_Key, 106, 0x80006A0C, 0 }, 	{ &GUID_Key, 107, 0x80006B0C, 0 },
	{ &GUID_Key, 108, 0x80006C0C, 0 }, 	{ &GUID_Key, 109, 0x80006D0C, 0 },
	{ &GUID_Key, 110, 0x80006E0C, 0 }, 	{ &GUID_Key, 111, 0x80006F0C, 0 },
	{ &GUID_Key, 112, 0x8000700C, 0 }, 	{ &GUID_Key, 113, 0x8000710C, 0 },
	{ &GUID_Key, 114, 0x8000720C, 0 }, 	{ &GUID_Key, 115, 0x8000730C, 0 },
	{ &GUID_Key, 116, 0x8000740C, 0 }, 	{ &GUID_Key, 117, 0x8000750C, 0 },
	{ &GUID_Key, 118, 0x8000760C, 0 }, 	{ &GUID_Key, 119, 0x8000770C, 0 },
	{ &GUID_Key, 120, 0x8000780C, 0 }, 	{ &GUID_Key, 121, 0x8000790C, 0 },
	{ &GUID_Key, 122, 0x80007A0C, 0 }, 	{ &GUID_Key, 123, 0x80007B0C, 0 },
	{ &GUID_Key, 124, 0x80007C0C, 0 }, 	{ &GUID_Key, 125, 0x80007D0C, 0 },
	{ &GUID_Key, 126, 0x80007E0C, 0 }, 	{ &GUID_Key, 127, 0x80007F0C, 0 },
	{ &GUID_Key, 128, 0x8000800C, 0 }, 	{ &GUID_Key, 129, 0x8000810C, 0 },
	{ &GUID_Key, 130, 0x8000820C, 0 }, 	{ &GUID_Key, 131, 0x8000830C, 0 },
	{ &GUID_Key, 132, 0x8000840C, 0 }, 	{ &GUID_Key, 133, 0x8000850C, 0 },
	{ &GUID_Key, 134, 0x8000860C, 0 }, 	{ &GUID_Key, 135, 0x8000870C, 0 },
	{ &GUID_Key, 136, 0x8000880C, 0 }, 	{ &GUID_Key, 137, 0x8000890C, 0 },
	{ &GUID_Key, 138, 0x80008A0C, 0 }, 	{ &GUID_Key, 139, 0x80008B0C, 0 },
	{ &GUID_Key, 140, 0x80008C0C, 0 }, 	{ &GUID_Key, 141, 0x80008D0C, 0 },
	{ &GUID_Key, 142, 0x80008E0C, 0 }, 	{ &GUID_Key, 143, 0x80008F0C, 0 },
	{ &GUID_Key, 144, 0x8000900C, 0 }, 	{ &GUID_Key, 145, 0x8000910C, 0 },
	{ &GUID_Key, 146, 0x8000920C, 0 }, 	{ &GUID_Key, 147, 0x8000930C, 0 },
	{ &GUID_Key, 148, 0x8000940C, 0 }, 	{ &GUID_Key, 149, 0x8000950C, 0 },
	{ &GUID_Key, 150, 0x8000960C, 0 }, 	{ &GUID_Key, 151, 0x8000970C, 0 },
	{ &GUID_Key, 152, 0x8000980C, 0 }, 	{ &GUID_Key, 153, 0x8000990C, 0 },
	{ &GUID_Key, 154, 0x80009A0C, 0 }, 	{ &GUID_Key, 155, 0x80009B0C, 0 },
	{ &GUID_Key, 156, 0x80009C0C, 0 }, 	{ &GUID_Key, 157, 0x80009D0C, 0 },
	{ &GUID_Key, 158, 0x80009E0C, 0 }, 	{ &GUID_Key, 159, 0x80009F0C, 0 },
	{ &GUID_Key, 160, 0x8000A00C, 0 }, 	{ &GUID_Key, 161, 0x8000A10C, 0 },
	{ &GUID_Key, 162, 0x8000A20C, 0 }, 	{ &GUID_Key, 163, 0x8000A30C, 0 },
	{ &GUID_Key, 164, 0x8000A40C, 0 }, 	{ &GUID_Key, 165, 0x8000A50C, 0 },
	{ &GUID_Key, 166, 0x8000A60C, 0 }, 	{ &GUID_Key, 167, 0x8000A70C, 0 },
	{ &GUID_Key, 168, 0x8000A80C, 0 }, 	{ &GUID_Key, 169, 0x8000A90C, 0 },
	{ &GUID_Key, 170, 0x8000AA0C, 0 }, 	{ &GUID_Key, 171, 0x8000AB0C, 0 },
	{ &GUID_Key, 172, 0x8000AC0C, 0 }, 	{ &GUID_Key, 173, 0x8000AD0C, 0 },
	{ &GUID_Key, 174, 0x8000AE0C, 0 }, 	{ &GUID_Key, 175, 0x8000AF0C, 0 },
	{ &GUID_Key, 176, 0x8000B00C, 0 }, 	{ &GUID_Key, 177, 0x8000B10C, 0 },
	{ &GUID_Key, 178, 0x8000B20C, 0 }, 	{ &GUID_Key, 179, 0x8000B30C, 0 },
	{ &GUID_Key, 180, 0x8000B40C, 0 }, 	{ &GUID_Key, 181, 0x8000B50C, 0 },
	{ &GUID_Key, 182, 0x8000B60C, 0 }, 	{ &GUID_Key, 183, 0x8000B70C, 0 },
	{ &GUID_Key, 184, 0x8000B80C, 0 }, 	{ &GUID_Key, 185, 0x8000B90C, 0 },
	{ &GUID_Key, 186, 0x8000BA0C, 0 }, 	{ &GUID_Key, 187, 0x8000BB0C, 0 },
	{ &GUID_Key, 188, 0x8000BC0C, 0 }, 	{ &GUID_Key, 189, 0x8000BD0C, 0 },
	{ &GUID_Key, 190, 0x8000BE0C, 0 }, 	{ &GUID_Key, 191, 0x8000BF0C, 0 },
	{ &GUID_Key, 192, 0x8000C00C, 0 }, 	{ &GUID_Key, 193, 0x8000C10C, 0 },
	{ &GUID_Key, 194, 0x8000C20C, 0 }, 	{ &GUID_Key, 195, 0x8000C30C, 0 },
	{ &GUID_Key, 196, 0x8000C40C, 0 }, 	{ &GUID_Key, 197, 0x8000C50C, 0 },
	{ &GUID_Key, 198, 0x8000C60C, 0 }, 	{ &GUID_Key, 199, 0x8000C70C, 0 },
	{ &GUID_Key, 200, 0x8000C80C, 0 }, 	{ &GUID_Key, 201, 0x8000C90C, 0 },
	{ &GUID_Key, 202, 0x8000CA0C, 0 }, 	{ &GUID_Key, 203, 0x8000CB0C, 0 },
	{ &GUID_Key, 204, 0x8000CC0C, 0 }, 	{ &GUID_Key, 205, 0x8000CD0C, 0 },
	{ &GUID_Key, 206, 0x8000CE0C, 0 }, 	{ &GUID_Key, 207, 0x8000CF0C, 0 },
	{ &GUID_Key, 208, 0x8000D00C, 0 }, 	{ &GUID_Key, 209, 0x8000D10C, 0 },
	{ &GUID_Key, 210, 0x8000D20C, 0 }, 	{ &GUID_Key, 211, 0x8000D30C, 0 },
	{ &GUID_Key, 212, 0x8000D40C, 0 }, 	{ &GUID_Key, 213, 0x8000D50C, 0 },
	{ &GUID_Key, 214, 0x8000D60C, 0 }, 	{ &GUID_Key, 215, 0x8000D70C, 0 },
	{ &GUID_Key, 216, 0x8000D80C, 0 }, 	{ &GUID_Key, 217, 0x8000D90C, 0 },
	{ &GUID_Key, 218, 0x8000DA0C, 0 }, 	{ &GUID_Key, 219, 0x8000DB0C, 0 },
	{ &GUID_Key, 220, 0x8000DC0C, 0 }, 	{ &GUID_Key, 221, 0x8000DD0C, 0 },
	{ &GUID_Key, 222, 0x8000DE0C, 0 }, 	{ &GUID_Key, 223, 0x8000DF0C, 0 },
	{ &GUID_Key, 224, 0x8000E00C, 0 }, 	{ &GUID_Key, 225, 0x8000E10C, 0 },
	{ &GUID_Key, 226, 0x8000E20C, 0 }, 	{ &GUID_Key, 227, 0x8000E30C, 0 },
	{ &GUID_Key, 228, 0x8000E40C, 0 }, 	{ &GUID_Key, 229, 0x8000E50C, 0 },
	{ &GUID_Key, 230, 0x8000E60C, 0 }, 	{ &GUID_Key, 231, 0x8000E70C, 0 },
	{ &GUID_Key, 232, 0x8000E80C, 0 }, 	{ &GUID_Key, 233, 0x8000E90C, 0 },
	{ &GUID_Key, 234, 0x8000EA0C, 0 }, 	{ &GUID_Key, 235, 0x8000EB0C, 0 },
	{ &GUID_Key, 236, 0x8000EC0C, 0 }, 	{ &GUID_Key, 237, 0x8000ED0C, 0 },
	{ &GUID_Key, 238, 0x8000EE0C, 0 }, 	{ &GUID_Key, 239, 0x8000EF0C, 0 },
	{ &GUID_Key, 240, 0x8000F00C, 0 }, 	{ &GUID_Key, 241, 0x8000F10C, 0 },
	{ &GUID_Key, 242, 0x8000F20C, 0 }, 	{ &GUID_Key, 243, 0x8000F30C, 0 },
	{ &GUID_Key, 244, 0x8000F40C, 0 }, 	{ &GUID_Key, 245, 0x8000F50C, 0 },
	{ &GUID_Key, 246, 0x8000F60C, 0 }, 	{ &GUID_Key, 247, 0x8000F70C, 0 },
	{ &GUID_Key, 248, 0x8000F80C, 0 }, 	{ &GUID_Key, 249, 0x8000F90C, 0 },
	{ &GUID_Key, 250, 0x8000FA0C, 0 }, 	{ &GUID_Key, 251, 0x8000FB0C, 0 },
	{ &GUID_Key, 252, 0x8000FC0C, 0 }, 	{ &GUID_Key, 253, 0x8000FD0C, 0 },
	{ &GUID_Key, 254, 0x8000FE0C, 0 }, 	{ &GUID_Key, 255, 0x8000FF0C, 0 }
};
static const DIDATAFORMAT c_dfDIKeyboard = { 24, 16, 0x2, 256, 256, c_rgodfDIKeyboard };

static LRESULT CALLBACK win_proc(HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam);


static HMODULE dd_library = NULL;
static HMODULE di_library = NULL;
static LPDIRECTDRAW lpDD = NULL;
static LPDIRECTDRAWSURFACE lpDDS = NULL;
static LPDIRECTDRAWSURFACE lpDDS_back = NULL;
static LPDIRECTDRAWPALETTE lpDDP = NULL;
static PALETTEENTRY palette[256];
static BLITTER *blitter;
static LPDIRECTINPUT lpDI = NULL;
static LPDIRECTINPUTDEVICE lpDID = NULL;
static short key_buffer[KEY_BUFFER_LEN], key_head = 0, key_tail = 0;
static int mouse_buttons, mouse_wheel;
static HWND wnd;
static RECT rect;
static HANDLE handle = NULL;
static CRITICAL_SECTION update_lock;
static int is_running, is_palette_changed, is_active;
static int mode_w, mode_h, mode_depth, mode_fullscreen;
static char *window_title;
static char window_class[WINDOW_TITLE_SIZE+sizeof( WINDOW_CLASS_PREFIX )] = { 0 };
static int display_offset;
static BOOL screensaver_active;


/*:::::*/
static void update_screen()
{
	RECT src, dest;
	POINT point;

	if (mode_fullscreen)
		return;

	src.left = src.top = 0;
	src.right = mode_w;
	src.bottom = mode_h;
	point.x = point.y = 0;
	ClientToScreen(wnd, &point);
	GetClientRect(wnd, &dest);
	dest.left += point.x;
	dest.top += point.y;
	dest.right += point.x;
	dest.bottom += point.y;
	IDirectDrawSurface_Blt(lpDDS, &dest, lpDDS_back, &src, DDBLT_WAIT, NULL);
}

/*:::::*/
static int calc_comp_height( int h )
{
	if( h < 240 )
		return 240;
	else if( h < 480 )
		return 480;
	else if( h < 600 )
		return 480;
	else if( h < 768 )
		return 768;
	else if( h < 1024 )
		return 1024;
	else
		return 0;
}

/*:::::*/
static int private_init()
{
	WNDCLASS wndclass;
	LPDIRECTDRAWCLIPPER lpDDC = NULL;
	DIRECTDRAWCREATE DirectDrawCreate;
	DIRECTINPUTCREATE DirectInputCreate;
	DDSURFACEDESC desc;
	DDPIXELFORMAT format;
	int depth, is_rgb = FALSE, height;

	lpDD = NULL;
	lpDDS = NULL;
	lpDDS_back = NULL;
	lpDDP = NULL;
	lpDI = NULL;
	lpDID = NULL;

	dd_library = (HMODULE)LoadLibrary("ddraw.dll");
	if (!dd_library)
		return -1;
	di_library = (HMODULE)LoadLibrary("dinput.dll");
	if (!di_library)
		return -1;

	DirectDrawCreate = (DIRECTDRAWCREATE)GetProcAddress(dd_library, "DirectDrawCreate");
	DirectInputCreate = (DIRECTINPUTCREATE)GetProcAddress(di_library, "DirectInputCreateA");
	
	if (DirectDrawCreate(NULL, &lpDD, NULL) != DD_OK)
		return -1;
	if (DirectInputCreate(NULL, 0x0300, &lpDI, NULL) != DI_OK)
		return -1;

	fb_hMemSet(&wndclass, 0, sizeof(wndclass));
	wndclass.lpfnWndProc = win_proc;
	wndclass.lpszClassName = window_class;

	rect.left = rect.top = 0;
	rect.right = mode_w;
	rect.bottom = mode_h;

	if (mode_fullscreen) {
		RegisterClass(&wndclass);
		wnd = CreateWindow(window_class, window_title, WS_POPUP | WS_VISIBLE, 0, 0,
				   GetSystemMetrics(SM_CXSCREEN), GetSystemMetrics(SM_CYSCREEN), NULL, NULL, 0, NULL);
		if (IDirectDraw_SetCooperativeLevel(lpDD, wnd, DDSCL_ALLOWREBOOT | DDSCL_FULLSCREEN | DDSCL_EXCLUSIVE) != DD_OK)
			return -1;

		height = mode_h;
		while( 1 )
		{
			if (IDirectDraw_SetDisplayMode(lpDD, mode_w, height, mode_depth) == DD_OK)
				break;

			depth = mode_depth;
			switch (mode_depth)
			{
				case 15: depth = 16; break;
				case 16: depth = 15; break;
				case 24: depth = 32; break;
				case 32: depth = 24; break;
			}

			if ((depth == mode_depth) || (IDirectDraw_SetDisplayMode(lpDD, mode_w, height, depth) != DD_OK))
			{
				height = calc_comp_height( height );
				if( height == 0 )
					return -1;
			}
			else
				break;
		}
		display_offset = ((height - mode_h) >> 1);
	}
	else {
		wndclass.style = CS_VREDRAW | CS_HREDRAW;
		wndclass.hCursor = LoadCursor(0, IDC_ARROW);
		RegisterClass(&wndclass);
		AdjustWindowRect(&rect, WS_OVERLAPPEDWINDOW, 0);
		rect.right -= rect.left;
		rect.bottom -= rect.top;
		wnd = CreateWindow(window_class, window_title, (WS_OVERLAPPEDWINDOW & ~WS_THICKFRAME) | WS_VISIBLE,
				   (GetSystemMetrics(SM_CXSCREEN) - rect.right) >> 1,
				   (GetSystemMetrics(SM_CYSCREEN) - rect.bottom) >> 1,
				   rect.right, rect.bottom, 0, 0, 0, 0);
		if ( wnd == 0 )
			return -1;
		if (IDirectDraw_SetCooperativeLevel(lpDD, wnd, DDSCL_NORMAL) != DD_OK)
			return -1;
		if (IDirectDraw_CreateClipper(lpDD, 0, &lpDDC, NULL) != DD_OK)
			return -1;
		if (IDirectDrawClipper_SetHWnd(lpDDC, 0, wnd) != DD_OK)
			return -1;
		display_offset = 0;
	}
	desc.dwSize = sizeof(desc);
	desc.dwFlags = DDSD_CAPS;
	desc.ddsCaps.dwCaps = DDSCAPS_PRIMARYSURFACE;
	if (IDirectDraw_CreateSurface(lpDD, &desc, &lpDDS, NULL) != DD_OK)
		return -1;

	if (!mode_fullscreen) {
		if (IDirectDrawSurface_SetClipper(lpDDS, lpDDC) != DD_OK)
			return -1;
		desc.dwFlags = DDSD_CAPS | DDSD_HEIGHT | DDSD_WIDTH;
		desc.dwWidth = mode_w;
		desc.dwHeight = mode_h;
		desc.ddsCaps.dwCaps = DDSCAPS_VIDEOMEMORY;
		if (IDirectDraw_CreateSurface(lpDD, &desc, &lpDDS_back, 0) != DD_OK)
			return -1;
	}
	else
		lpDDS_back = lpDDS;

	format.dwSize = sizeof(format);
	if (IDirectDrawSurface_GetPixelFormat(lpDDS, &format) != DD_OK)
		return -1;
	if (!(format.dwFlags & DDPF_RGB))
		return -1;

	if (format.dwRGBBitCount == 8) {
		if (IDirectDraw_CreatePalette(lpDD, DDPCAPS_8BIT | DDPCAPS_INITIALIZE | DDPCAPS_ALLOW256,
					      palette, &lpDDP, NULL) != DD_OK)
			return -1;
		IDirectDrawSurface_SetPalette(lpDDS, lpDDP);
		is_palette_changed = FALSE;
	}

	depth = format.dwRGBBitCount;
	if ((format.dwRGBBitCount == 16) && (format.dwGBitMask == 0x03E0))
		depth = 15;
	if ((format.dwRGBBitCount >= 24) && (format.dwRBitMask == 0xFF))
		is_rgb = TRUE;
	else if ((format.dwRGBBitCount >= 16) && (format.dwRBitMask == 0x1F))
		is_rgb = TRUE;
	blitter = fb_hGetBlitter(depth, is_rgb);
	if (!blitter)
		return -1;

	SetForegroundWindow(wnd);
	
	if (IDirectInput_CreateDevice(lpDI, &GUID_SysKeyboard, &lpDID, NULL) != DI_OK)
		return -1;
	if (IDirectInputDevice_SetCooperativeLevel(lpDID, wnd, DISCL_FOREGROUND | DISCL_NONEXCLUSIVE) != DI_OK)
		return -1;
	if (IDirectInputDevice_SetDataFormat(lpDID, &c_dfDIKeyboard) != DI_OK)
		return -1;
	if (IDirectInputDevice_Acquire(lpDID) != DI_OK)
		return -1;
	mouse_buttons = mouse_wheel = 0;
	
	return 0;
}


/*:::::*/
static void private_exit()
{
	DDBLTFX bltfx;
	
	if (lpDI) {
		if (lpDID) {
			IDirectInputDevice_Unacquire(lpDID);
			IDirectInputDevice_Release(lpDID);
		}
		IDirectInput_Release(lpDI);
	}
	
	if (lpDD) {
		if (mode_fullscreen && lpDDS) {
			bltfx.dwSize = sizeof(bltfx);
			bltfx.dwDDFX = 0;
			bltfx.dwFillColor = 0;
			IDirectDrawSurface_Blt(lpDDS, &rect, NULL, NULL, DDBLT_COLORFILL, &bltfx);
		}
		if (lpDDS)
			IDirectDrawSurface_Release(lpDDS);
		if ((!mode_fullscreen) && (lpDDS_back))
			IDirectDrawSurface_Release(lpDDS_back);
		if (mode_fullscreen)
			IDirectDraw_RestoreDisplayMode(lpDD);
		if (mode_fullscreen)
			IDirectDraw_SetCooperativeLevel(lpDD, wnd, DDSCL_NORMAL);
		IDirectDraw_Release(lpDD);
	}
	if (wnd)
		DestroyWindow(wnd);
	if (dd_library)
		FreeLibrary(dd_library);
	if (di_library)
		FreeLibrary(di_library);
}


/*:::::*/
static LRESULT CALLBACK win_proc(HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam)
{
	int result;
	char key_state[256];
	WORD key = 0;

	switch (message)
	{
		case WM_SETCURSOR:
			if (mode_fullscreen) {
				SetCursor(0);
				return 0;
			}
			break;

		case WM_ACTIVATEAPP:
			is_active = (int)wParam;
			fb_hMemSet(fb_mode->key, FALSE, 256);
			mouse_buttons = 0;
			fb_hMemSet(fb_mode->dirty, TRUE, mode_h);
			break;
		
		case WM_LBUTTONDOWN:
			mouse_buttons |= 0x1;
			break;
		
		case WM_LBUTTONUP:
			mouse_buttons &= ~0x1;
			break;
		
		case WM_RBUTTONDOWN:
			mouse_buttons |= 0x2;
			break;
		
		case WM_RBUTTONUP:
			mouse_buttons &= ~0x2;
			break;
		
		case WM_MBUTTONDOWN:
			mouse_buttons |= 0x4;
			break;
		
		case WM_MBUTTONUP:
			mouse_buttons &= ~0x4;
			break;
		
		case WM_MOUSEWHEEL:
			if ((signed)wParam > 0)
				mouse_wheel++;
			else
				mouse_wheel--;
			break;
		
		case WM_SIZE:
		case WM_SYSKEYDOWN:
			if (((message == WM_SIZE) && (wParam == SIZE_MAXIMIZED)) ||
			    ((message == WM_SYSKEYDOWN) && (wParam == VK_RETURN) && (lParam & 0x20000000))) {
				private_exit();
				mode_fullscreen ^= DRIVER_FULLSCREEN;
				if (private_init()) {
					private_exit();
					mode_fullscreen ^= DRIVER_FULLSCREEN;
					private_init();
				}
				fb_hMemSet(fb_mode->dirty, TRUE, mode_h);
				is_active = TRUE;
			}
			return 0;

		case WM_KEYDOWN:
			switch (wParam) {

				case VK_UP:		key = KEY_UP;		break;
				case VK_DOWN:		key = KEY_DOWN;		break;
				case VK_LEFT:		key = KEY_LEFT;		break;
				case VK_RIGHT:		key = KEY_RIGHT;	break;
				case VK_INSERT:		key = KEY_INS;		break;
				case VK_DELETE:		key = KEY_DEL;		break;
				case VK_HOME:		key = KEY_HOME;		break;
				case VK_END:		key = KEY_END;		break;
				case VK_PRIOR:		key = KEY_PAGE_UP;	break;
				case VK_NEXT:		key = KEY_PAGE_DOWN;	break;
				case VK_F1:
				case VK_F2:
				case VK_F3:
				case VK_F4:
				case VK_F5:
				case VK_F6:
				case VK_F7:
				case VK_F8:
				case VK_F9:
				case VK_F10:		key = KEY_F(wParam - VK_F1 + 1); break;

				default:
					GetKeyboardState(key_state);
					if (ToAscii(wParam, (lParam >> 16) & 0xff, key_state, &key, 0) != 1)
						key = 0;
					break;
			}
			if (key) {
				key_buffer[key_tail] = key;
				if (((key_tail + 1) & (KEY_BUFFER_LEN - 1)) != key_head)
					key_tail = (key_tail + 1) & (KEY_BUFFER_LEN - 1);
			}
			return 0;

		case WM_CLOSE:
			key_buffer[key_tail] = KEY_QUIT;
			if (((key_tail + 1) & (KEY_BUFFER_LEN - 1)) != key_head)
				key_tail = (key_tail + 1) & (KEY_BUFFER_LEN - 1);
			return 0;

		case WM_PAINT:
			update_screen();
			break;
	}

	return DefWindowProc(hWnd, message, wParam, lParam);
}


/*:::::*/
static void window_thread(HANDLE running_event)
{
	DDSURFACEDESC desc;
	MSG message;
	HRESULT result;
	unsigned char keystate[256];
	int i;

	if (private_init())
		goto error;

	SetEvent(running_event);
	is_active = TRUE;

	while (is_running)
	{
		ddraw_lock();

		if ((is_active) || (!mode_fullscreen)) {
			IDirectDrawSurface_Restore(lpDDS);
			if (!mode_fullscreen)
				IDirectDrawSurface_Restore(lpDDS_back);

			if (is_palette_changed && lpDDP) {
				IDirectDrawPalette_SetEntries(lpDDP, 0, 0, 256, palette);
				is_palette_changed = FALSE;
			}
			desc.dwSize = sizeof(desc);
			if (IDirectDrawSurface_Lock(lpDDS_back, NULL, &desc, DDLOCK_WAIT | DDLOCK_SURFACEMEMORYPTR, NULL) == DD_OK) {
				blitter((unsigned char *)desc.lpSurface + display_offset * desc.lPitch, desc.lPitch);
				IDirectDrawSurface_Unlock(lpDDS_back, desc.lpSurface);
				fb_hMemSet(fb_mode->dirty, FALSE, mode_h);
			}

			update_screen();
		}

		result = IDirectInputDevice_GetDeviceState(lpDID, 256, keystate);
		if ((result == DIERR_NOTACQUIRED) || (result == DIERR_INPUTLOST))
			IDirectInputDevice_Acquire(lpDID);
		else {
			for (i = 0; i < 256; i++)
				fb_mode->key[i] = (keystate[i] & 0x80) ? TRUE : FALSE;
		}
		
		while (PeekMessage(&message, wnd, 0, 0, PM_REMOVE)) {
			TranslateMessage(&message);
			DispatchMessage(&message);
		}

		ddraw_unlock();

		Sleep(10);
		ddraw_wait_vsync();
	}

error:
	private_exit();
}


/*:::::*/
static int ddraw_init(char *title, int w, int h, int depth, int flags)
{
	DIRECTDRAWCREATE DirectDrawCreate;
	HANDLE events[2];
	long result;

	window_title = title;
	strcpy( window_class, WINDOW_CLASS_PREFIX );
	strcat( window_class, window_title );
	mode_w = w;
	mode_h = h;
	mode_depth = depth;
	mode_fullscreen = flags & DRIVER_FULLSCREEN;

	is_running = TRUE;

	InitializeCriticalSection(&update_lock);
	events[0] = CreateEvent(NULL, FALSE, FALSE, NULL);
	events[1] = (HANDLE)_beginthread(window_thread, 0, events[0]);
	result = WaitForMultipleObjects(2, events, FALSE, INFINITE);
	CloseHandle(events[0]);
	handle = events[1];
	if (result != WAIT_OBJECT_0) {
		DeleteCriticalSection(&update_lock);
		return -1;
	}

	SetThreadPriority(handle, THREAD_PRIORITY_ABOVE_NORMAL);

	SystemParametersInfo(SPI_GETSCREENSAVEACTIVE, 0, &screensaver_active, 0);
	SystemParametersInfo(SPI_SETSCREENSAVEACTIVE, FALSE, NULL, 0);

	return 0;
}


/*:::::*/
static void ddraw_exit(void)
{
	is_running = FALSE;
	WaitForSingleObject(handle, INFINITE);
	DeleteCriticalSection(&update_lock);
	SystemParametersInfo(SPI_SETSCREENSAVEACTIVE, screensaver_active, NULL, 0);
}


/*:::::*/
static void ddraw_lock(void)
{
	EnterCriticalSection(&update_lock);
}


/*:::::*/
static void ddraw_unlock(void)
{
	LeaveCriticalSection(&update_lock);
}


/*:::::*/
static void ddraw_set_palette(int index, int r, int g, int b)
{
	/* assumes lock to be held */

	palette[index].peRed = r;
	palette[index].peGreen = g;
	palette[index].peBlue = b;
	palette[index].peFlags = PC_NOCOLLAPSE;
	is_palette_changed = TRUE;
}


/*:::::*/
static void ddraw_wait_vsync(void)
{
	IDirectDraw_WaitForVerticalBlank(lpDD, DDWAITVB_BLOCKBEGIN, 0);
}


/*:::::*/
static int ddraw_get_key(int wait)
{
	int key = 0;

	if (wait) {
		do {
			key = ddraw_get_key(FALSE);
			Sleep(20);
		} while(!key);
		return key;
	}

	ddraw_lock();

	if (key_head != key_tail) {
		key = key_buffer[key_head];
		key_head = (key_head + 1) & (KEY_BUFFER_LEN - 1);
	}

	ddraw_unlock();

	return key;
}


/*:::::*/
int ddraw_get_mouse(int *x, int *y, int *z, int *buttons)
{
	POINT point;
	
	if (!is_active)
		return -1;
	
	GetCursorPos(&point);
	
	if (mode_fullscreen) {
		*x = MID(0, point.x, mode_w - 1);
		*y = MID(0, point.y, mode_h - 1);
	}
	else {
		ScreenToClient(wnd, &point);
		if ((point.x < 0) || (point.x >= mode_w) || (point.y < 0) || (point.y >= mode_h)) {
			mouse_buttons = 0;
			return -1;
		}
		else {
			*x = point.x;
			*y = point.y;
		}
	}
	*z = mouse_wheel;
	*buttons = mouse_buttons;
	
	return 0;
}


/*:::::*/
static void ddraw_set_window_title(char *title)
{
	SetWindowText(wnd, title);
}
