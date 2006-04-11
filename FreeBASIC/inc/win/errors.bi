''
''
'' errors -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_errors_bi__
#define __win_errors_bi__

#define VFW_FIRST_CODE &h200
#define MAX_ERROR_TEXT_LEN 160

#include once "win/vfwmsgs.bi"

#ifdef UNICODE
type AMGETERRORTEXTPROC as function(byval as HRESULT, byval as WCHAR ptr, byval as DWORD) as BOOL
declare function AMGetErrorText alias "AMGetErrorTextW" (byval hr as HRESULT, byval pbuffer as WCHAR ptr, byval MaxLen as DWORD) as DWORD
#else
type AMGETERRORTEXTPROC as function(byval as HRESULT, byval as zstring ptr, byval as DWORD) as BOOL
declare function AMGetErrorText alias "AMGetErrorTextA" (byval hr as HRESULT, byval pbuffer as zstring ptr, byval MaxLen as DWORD) as DWORD
#endif

#endif
