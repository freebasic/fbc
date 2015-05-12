''
''
'' windef -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_windef_bi__
#define __win_windef_bi__

#ifndef WINVER
#define WINVER &h0400
#endif
#ifndef _WIN32_WINNT
#define _WIN32_WINNT WINVER
#endif
#ifndef WIN32
#define WIN32
#endif
#ifndef _WIN32
#define _WIN32
#endif

#undef MAX_PATH
#define MAX_PATH 260

#ifndef NULL
#define NULL 0
#endif
#ifndef FALSE
#define FALSE 0
#endif
#ifndef TRUE
#define TRUE 1
#endif
#define STRICT 1

#define MAKEWORD(a,b) cushort( cubyte(a) or (cushort(cubyte(b)) shl 8) )
#define MAKELONG(a,b) cint( cushort(a) or (cuint(cushort(b)) shl 16) )
#ifndef LOWORD
#define LOWORD(l)	cushort(cuint(l))
#define HIWORD(l)	cushort((cuint(l) shr 16) and &hFFFF)
#endif
#ifndef LOBYTE
#define LOBYTE(w)	cubyte(w)
#define HIBYTE(w)	cubyte((cushort(w) shr 8) and &hFF)
#endif

#ifndef NOMINMAX
#ifndef max
#define max(a,b) iif((a)>(b), a, b)
#endif
#ifndef min
#define min(a,b) iif((a)<(b), a, b)
#endif
#endif

type DWORD as uinteger
type WINBOOL as integer
type PWINBOOL as integer ptr
type LPWINBOOL as integer ptr
type BOOL as WINBOOL
type PBOOL as BOOL ptr
type LPBOOL as BOOL ptr
type WORD as ushort
type FLOAT as single
type PFLOAT as FLOAT ptr
type PBYTE as UBYTE ptr
type LPBYTE as UBYTE ptr
type PINT as integer ptr
type LPINT as integer ptr
type PWORD as WORD ptr
type LPWORD as WORD ptr
type LPLONG as integer ptr
type PDWORD as DWORD ptr
type LPDWORD as DWORD ptr
type PCVOID as any ptr
type LPCVOID as any ptr
type INT_ as integer
type UINT as uinteger
type PUINT as uinteger ptr
type LPUINT as uinteger ptr

#include once "win/winnt.bi"

type WPARAM as UINT_PTR
type LPARAM as LONG_PTR
type LRESULT as LONG_PTR
type HRESULT as LONG
type ATOM as WORD
type HGLOBAL as HANDLE
type HLOCAL as HANDLE
type GLOBALHANDLE as HANDLE
type LOCALHANDLE as HANDLE
type HGDIOBJ as any ptr

type HACCEL__
	i as integer
end type

type HACCEL as HACCEL__ ptr

type HBITMAP__
	i as integer
end type

type HBITMAP as HBITMAP__ ptr

type HBRUSH__
	i as integer
end type

type HBRUSH as HBRUSH__ ptr

type HCOLORSPACE__
	i as integer
end type

type HCOLORSPACE as HCOLORSPACE__ ptr

type HDC__
	i as integer
end type

type HDC as HDC__ ptr

type HGLRC__
	i as integer
end type

type HGLRC as HGLRC__ ptr

type HDESK__
	i as integer
end type

type HDESK as HDESK__ ptr

type HENHMETAFILE__
	i as integer
end type

type HENHMETAFILE as HENHMETAFILE__ ptr

type HFONT__
	i as integer
end type

type HFONT as HFONT__ ptr

type HICON__
	i as integer
end type

type HICON as HICON__ ptr

type HKEY__
	i as integer
end type

type HKEY as HKEY__ ptr

type HMONITOR__
	i as integer
end type

type HMONITOR as HMONITOR__ ptr

#define HMONITOR_DECLARED 1

type HTERMINAL__
	i as integer
end type

type HTERMINAL as HTERMINAL__ ptr

type HWINEVENTHOOK__
	i as integer
end type

type HWINEVENTHOOK as HWINEVENTHOOK__ ptr
type PHKEY as HKEY ptr

type HMENU__
	i as integer
end type

type HMENU as HMENU__ ptr

type HMETAFILE__
	i as integer
end type

type HMETAFILE as HMETAFILE__ ptr

type HINSTANCE__
	i as integer
end type

type HINSTANCE as HINSTANCE__ ptr
type HMODULE as HINSTANCE

type HPALETTE__
	i as integer
end type

type HPALETTE as HPALETTE__ ptr

type HPEN__
	i as integer
end type

type HPEN as HPEN__ ptr

type HRGN__
	i as integer
end type

type HRGN as HRGN__ ptr

type HRSRC__
	i as integer
end type

type HRSRC as HRSRC__ ptr

type HSTR__
	i as integer
end type

type HSTR as HSTR__ ptr

type HTASK__
	i as integer
end type

type HTASK as HTASK__ ptr

type HWND__
	i as integer
end type

type HWND as HWND__ ptr

type HWINSTA__
	i as integer
end type

type HWINSTA as HWINSTA__ ptr

type HKL__
	i as integer
end type

type HKL as HKL__ ptr
type HFILE as integer
type HCURSOR as HICON
type COLORREF as DWORD
type FARPROC as function () as integer
type NEARPROC as function () as integer
type PROC as function () as integer

type RECT
	left as LONG
	top as LONG
	right as LONG
	bottom as LONG
end type

type PRECT as RECT ptr
type LPRECT as RECT ptr
type LPCRECT as RECT ptr

type RECTL
	left as LONG
	top as LONG
	right as LONG
	bottom as LONG
end type

type PRECTL as RECTL ptr
type LPRECTL as RECTL ptr
type LPCRECTL as RECTL ptr

type POINT
	x as LONG
	y as LONG
end type

type POINTL as POINT
type PPOINT as POINT ptr
type LPPOINT as POINT ptr
type PPOINTL as POINT ptr
type LPPOINTL as POINT ptr

type SIZE
	cx as LONG
	cy as LONG
end type

type SIZEL as SIZE
type PSIZE as SIZE ptr
type LPSIZE as SIZE ptr
type PSIZEL as SIZE ptr
type LPSIZEL as SIZE ptr

type POINTS
	x as SHORT
	y as SHORT
end type

type PPOINTS as POINTS ptr
type LPPOINTS as POINTS ptr

#endif
