''
''
'' dxerr8 -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_dxerr8_bi__
#define __win_dxerr8_bi__

#inclib "dxerr8"

#ifdef UNICODE
declare function DXGetErrorString8 alias "DXGetErrorString8W" (byval as HRESULT) as WCHAR ptr
declare function DXGetErrorDescription8 alias "DXGetErrorDescription8W" (byval as HRESULT) as WCHAR ptr
declare function DXTrace alias "DXTraceW" (byval as zstring ptr, byval as DWORD, byval as HRESULT, byval as WCHAR ptr, byval as BOOL) as HRESULT

#else
declare function DXGetErrorString8 alias "DXGetErrorString8A" (byval as HRESULT) as zstring ptr
declare function DXGetErrorDescription8 alias "DXGetErrorDescription8A" (byval as HRESULT) as zstring ptr
declare function DXTrace alias "DXTraceA" (byval as zstring ptr, byval as DWORD, byval as HRESULT, byval as zstring ptr, byval as BOOL) as HRESULT
#endif

#endif
