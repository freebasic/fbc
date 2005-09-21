''
''
'' stddef -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __stddef_bi__
#define __stddef_bi__

#ifndef size_t
type size_t as uinteger
#endif

#ifndef wchar_t
# ifdef __FB_LINUX__
type wchar_t as uinteger
# else
type wchar_t as ushort
# endif
#endif

#ifndef wint_t
type wint_t as wchar_t
#endif

#ifndef NULL
#define NULL 0
#endif

#endif
