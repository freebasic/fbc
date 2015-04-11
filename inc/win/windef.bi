'' FreeBASIC binding for mingw-w64-v4.0.1

#pragma once

#include once "_mingw.bi"
#include once "winapifamily.bi"
#include once "basetsd.bi"

'' The following symbols have been renamed:
''     typedef BYTE => UBYTE
''     typedef INT => INT_

extern "Windows"

#define _WINDEF_
#define _MINWINDEF_
#define BASETYPES

type PULONG as ULONG ptr
type PUSHORT as USHORT ptr
type UCHAR as ubyte
type PUCHAR as UCHAR ptr
type PSZ as zstring ptr

#ifndef MAX_PATH
const MAX_PATH = 260
#endif
#ifndef NULL
const NULL = 0
#endif
#ifndef FALSE
const FALSE = 0
#endif
#ifndef TRUE
const TRUE = 1
#endif
#define _DEF_WINBOOL_

type WINBOOL as long
type BOOL as long
type PBOOL as WINBOOL ptr
type LPBOOL as WINBOOL ptr
type WORD as ushort
type DWORD as ulong
type FLOAT as single
type PFLOAT as FLOAT ptr
type PBYTE as UBYTE ptr
type LPBYTE as UBYTE ptr
type PINT as long ptr
type LPINT as long ptr
type PWORD as WORD ptr
type LPWORD as WORD ptr
type LPLONG as long ptr
type PDWORD as DWORD ptr
type LPDWORD as DWORD ptr
type LPVOID as any ptr
#define _LPCVOID_DEFINED
type LPCVOID as const any ptr
type INT_ as long
type UINT as ulong
type PUINT as ulong ptr
type WPARAM as UINT_PTR
type LPARAM as LONG_PTR
type LRESULT as LONG_PTR

#define max(a, b) iif((a) > (b), (a), (b))
#define min(a, b) iif((a) < (b), (a), (b))
#define MAKEWORD(a, b) cast(WORD, cast(UBYTE, cast(DWORD_PTR, (a)) and &hff) or (cast(WORD, cast(UBYTE, cast(DWORD_PTR, (b)) and &hff)) shl 8))
#define MAKELONG(a, b) cast(LONG, cast(WORD, cast(DWORD_PTR, (a)) and &hffff) or (cast(DWORD, cast(WORD, cast(DWORD_PTR, (b)) and &hffff)) shl 16))

type SPHANDLE as HANDLE ptr
type LPHANDLE as HANDLE ptr
type HGLOBAL as HANDLE
type HLOCAL as HANDLE
type GLOBALHANDLE as HANDLE
type LOCALHANDLE as HANDLE

#ifdef __FB_64BIT__
	type FARPROC as function() as INT_PTR
	type NEARPROC as function() as INT_PTR
	type PROC as function() as INT_PTR
#else
	type FARPROC as function() as long
	type NEARPROC as function() as long
	type PROC as function() as long
#endif

type ATOM as WORD
type HFILE as long

type HINSTANCE__
	unused as long
end type

type HINSTANCE as HINSTANCE__ ptr

type HKEY__
	unused as long
end type

type HKEY as HKEY__ ptr
type PHKEY as HKEY ptr

type HKL__
	unused as long
end type

type HKL as HKL__ ptr

type HLSURF__
	unused as long
end type

type HLSURF as HLSURF__ ptr

type HMETAFILE__
	unused as long
end type

type HMETAFILE as HMETAFILE__ ptr
type HMODULE as HINSTANCE

type HRGN__
	unused as long
end type

type HRGN as HRGN__ ptr

type HRSRC__
	unused as long
end type

type HRSRC as HRSRC__ ptr

type HSPRITE__
	unused as long
end type

type HSPRITE as HSPRITE__ ptr

type HSTR__
	unused as long
end type

type HSTR as HSTR__ ptr

type HTASK__
	unused as long
end type

type HTASK as HTASK__ ptr

type HWINSTA__
	unused as long
end type

type HWINSTA as HWINSTA__ ptr

type _FILETIME
	dwLowDateTime as DWORD
	dwHighDateTime as DWORD
end type

type FILETIME as _FILETIME
type PFILETIME as _FILETIME ptr
type LPFILETIME as _FILETIME ptr
#define _FILETIME_

type HWND__
	unused as long
end type

type HWND as HWND__ ptr

type HHOOK__
	unused as long
end type

type HHOOK as HHOOK__ ptr
type HGDIOBJ as any ptr

type HACCEL__
	unused as long
end type

type HACCEL as HACCEL__ ptr

type HBITMAP__
	unused as long
end type

type HBITMAP as HBITMAP__ ptr

type HBRUSH__
	unused as long
end type

type HBRUSH as HBRUSH__ ptr

type HCOLORSPACE__
	unused as long
end type

type HCOLORSPACE as HCOLORSPACE__ ptr

type HDC__
	unused as long
end type

type HDC as HDC__ ptr

type HGLRC__
	unused as long
end type

type HGLRC as HGLRC__ ptr

type HDESK__
	unused as long
end type

type HDESK as HDESK__ ptr

type HENHMETAFILE__
	unused as long
end type

type HENHMETAFILE as HENHMETAFILE__ ptr

type HFONT__
	unused as long
end type

type HFONT as HFONT__ ptr

type HICON__
	unused as long
end type

type HICON as HICON__ ptr

type HMENU__
	unused as long
end type

type HMENU as HMENU__ ptr

type HPALETTE__
	unused as long
end type

type HPALETTE as HPALETTE__ ptr

type HPEN__
	unused as long
end type

type HPEN as HPEN__ ptr

type HMONITOR__
	unused as long
end type

type HMONITOR as HMONITOR__ ptr

type HWINEVENTHOOK__
	unused as long
end type

type HWINEVENTHOOK as HWINEVENTHOOK__ ptr
type HCURSOR as HICON
type COLORREF as DWORD

type HUMPD__
	unused as long
end type

type HUMPD as HUMPD__ ptr
type LPCOLORREF as DWORD ptr
#define HFILE_ERROR cast(HFILE, -1)

type tagRECT
	left as LONG
	top as LONG
	right as LONG
	bottom as LONG
end type

type RECT as tagRECT
type PRECT as tagRECT ptr
type NPRECT as tagRECT ptr
type LPRECT as tagRECT ptr
type LPCRECT as const RECT ptr

type _RECTL
	left as LONG
	top as LONG
	right as LONG
	bottom as LONG
end type

type RECTL as _RECTL
type PRECTL as _RECTL ptr
type LPRECTL as _RECTL ptr
type LPCRECTL as const RECTL ptr

type tagPOINT
	x as LONG
	y as LONG
end type

type POINT as tagPOINT
type PPOINT as tagPOINT ptr
type NPPOINT as tagPOINT ptr
type LPPOINT as tagPOINT ptr

type _POINTL
	x as LONG
	y as LONG
end type

type POINTL as _POINTL
type PPOINTL as _POINTL ptr

type tagSIZE
	cx as LONG
	cy as LONG
end type

type SIZE as tagSIZE
type PSIZE as tagSIZE ptr
type LPSIZE as tagSIZE ptr
type SIZEL as SIZE
type PSIZEL as SIZE ptr
type LPSIZEL as SIZE ptr

type tagPOINTS
	x as SHORT
	y as SHORT
end type

type POINTS as tagPOINTS
type PPOINTS as tagPOINTS ptr
type LPPOINTS as tagPOINTS ptr

end extern

#include once "winnt.bi"
