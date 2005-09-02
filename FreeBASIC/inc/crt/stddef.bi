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

#ifndef _SIZE_T_
#define _SIZE_T_
type size_t as uinteger
#endif

#ifndef _WCHAR_T_
#define _WCHAR_T_
type wchar_t as ushort
#endif

#ifndef _WINT_T_
#define _WINT_T_
type wint_t as ushort
#endif

#endif
