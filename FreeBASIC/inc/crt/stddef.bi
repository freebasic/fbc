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

#if defined(__FB_WIN32__)
	type size_t as uinteger
	type wchar_t as ushort
#elseif defined(__FB_DOS__)
	type size_t as ulong
	type wchar_t as ubyte
#elseif defined(__FB_LINUX__)
	type size_t as uinteger
	type wchar_t as uinteger
#endif

type wint_t as wchar_t

#ifndef NULL
#define NULL 0
#endif

#endif
