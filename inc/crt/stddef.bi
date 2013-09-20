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

#ifdef __FB_DOS__
	type size_t as ulong
	#ifndef ssize_t
	type ssize_t as long
	#endif
#else
	type size_t as uinteger
	#ifndef ssize_t
	type ssize_t as integer
	#endif
#endif

#ifdef __FB_DOS__
	type wchar_t as ubyte
#elseif defined( __FB_WIN32__ ) or defined( __FB_CYGWIN__ )
	type wchar_t as ushort
#else
	type wchar_t as long
#endif

type wint_t as wchar_t

#ifndef NULL
#define NULL 0
#endif

#endif
