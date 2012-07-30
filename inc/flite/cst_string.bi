''
''
'' cst_string -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __cst_string_bi__
#define __cst_string_bi__

type cst_string as byte

declare function cst_atof cdecl alias "cst_atof" (byval str as zstring ptr) as double
declare function cst_strdup cdecl alias "cst_strdup" (byval s as cst_string ptr) as cst_string ptr
declare function cst_strchr cdecl alias "cst_strchr" (byval s as cst_string ptr, byval c as integer) as cst_string ptr
declare function cst_strrchr cdecl alias "cst_strrchr" (byval str as cst_string ptr, byval c as integer) as cst_string ptr
declare function cst_member_string cdecl alias "cst_member_string" (byval str as zstring ptr, byval slist as byte ptr ptr) as integer
declare function cst_substr cdecl alias "cst_substr" (byval str as zstring ptr, byval start as integer, byval length as integer) as zstring ptr
declare function cst_string_before cdecl alias "cst_string_before" (byval s as zstring ptr, byval c as zstring ptr) as zstring ptr
declare function cst_downcase cdecl alias "cst_downcase" (byval str as cst_string ptr) as cst_string ptr
declare function cst_upcase cdecl alias "cst_upcase" (byval str as cst_string ptr) as cst_string ptr

#endif
