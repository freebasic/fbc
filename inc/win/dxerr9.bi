'' FreeBASIC binding for mingw-w64-v4.0.1

#pragma once

#inclib "dxerr9"

#include once "_mingw_unicode.bi"
#include once "dxerr8.bi"

extern "Windows"

#define __WINE_DXERR9_H
declare function DXGetErrorString9A(byval hr as HRESULT) as const zstring ptr
declare function DXGetErrorString9W(byval hr as HRESULT) as const wstring ptr

#ifdef UNICODE
	#define DXGetErrorString9 DXGetErrorString9W
#else
	#define DXGetErrorString9 DXGetErrorString9A
#endif

declare function DXGetErrorDescription9A(byval hr as HRESULT) as const zstring ptr
declare function DXGetErrorDescription9W(byval hr as HRESULT) as const wstring ptr

#ifdef UNICODE
	#define DXGetErrorDescription9 DXGetErrorDescription9W
#else
	#define DXGetErrorDescription9 DXGetErrorDescription9A
#endif

end extern
