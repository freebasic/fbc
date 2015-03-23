#pragma once

#inclib "dxerr9"

#include once "_mingw_unicode.bi"

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

declare function DXTraceA(byval strFile as const zstring ptr, byval dwLine as DWORD, byval hr as HRESULT, byval strMsg as const zstring ptr, byval bPopMsgBox as WINBOOL) as HRESULT
declare function DXTraceW(byval strFile as const zstring ptr, byval dwLine as DWORD, byval hr as HRESULT, byval strMsg as const wstring ptr, byval bPopMsgBox as WINBOOL) as HRESULT

#ifdef UNICODE
	#define DXTrace DXTraceW
#else
	#define DXTrace DXTraceA
#endif

#define DXTRACE_MSG(str) __MSABI_LONG(0)
#define DXTRACE_ERR(str, hr) (hr)
#define DXTRACE_ERR_NOMSGBOX(str, hr) (hr)

end extern
