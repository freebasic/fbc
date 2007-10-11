''
''
'' wchar -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __crt_dos_wchar_bi__
#define __crt_dos_wchar_bi__

#include once "crt/stddef.bi"

#ifndef WEOF
#define WEOF cast(wint_t,-1)
#endif

type mbstate_t
	shift_state as integer
end type

#endif
