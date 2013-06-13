''
''
'' begin_code -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __begin_code_bi__
#define __begin_code_bi__

#inclib "SDL"

#ifdef __FB_WIN32__
#inclib "gdi32"
#inclib "user32"
#inclib "winmm"
#inclib "dxguid"
#inclib "advapi32"
#endif

#ifndef SDLCALL
#define SDLCALL cdecl
#endif

#ifndef NULL
#define NULL 0
#endif

#endif
