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

type size_t as uinteger

#ifndef wchar_t
type wchar_t as ushort
#endif

#ifndef wint_t
type wint_t as ushort
#endif

#endif
