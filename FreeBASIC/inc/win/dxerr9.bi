''
''
'' dxerr9 -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_dxerr9_bi__
#define __win_dxerr9_bi__

#inclib "dxerr9"

#ifdef UNICODE
declare function DXGetErrorString9 alias "DXGetErrorString9W" (byval as HRESULT) as WCHAR ptr
declare function DXGetErrorDescription9 alias "DXGetErrorDescription9W" (byval as HRESULT) as WCHAR ptr
declare function DXTrace alias "DXTraceW" (byval as zstring ptr, byval as DWORD, byval as HRESULT, byval as WCHAR ptr, byval as BOOL) as HRESULT
#else
declare function DXGetErrorString9 alias "DXGetErrorString9A" (byval as HRESULT) as zstring ptr
declare function DXGetErrorDescription9 alias "DXGetErrorDescription9A" (byval as HRESULT) as zstring ptr
declare function DXTrace alias "DXTraceA" (byval as zstring ptr, byval as DWORD, byval as HRESULT, byval as zstring ptr, byval as BOOL) as HRESULT
#endif

#endif
