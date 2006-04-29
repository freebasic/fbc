''
''
'' stddef -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __crt_stddef_bi__
#define __crt_stddef_bi__

type ptrdiff_t as integer
type size_t as uinteger

#if defined(__FB_WIN32__)
type wchar_t as ushort
#elseif defined(__FB_DOS__)
type wchar_t as ushort
#elseif defined(__FB_LINUX__)
type wchar_t as ushort
#endif

type wint_t as wchar_t

#ifndef NULL
#define NULL 0
#endif

#endif
