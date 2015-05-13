''
''
'' ctype -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __crt_ctype_bi__
#define __crt_ctype_bi__

#include once "crt/stddef.bi"

#if defined(__FB_WIN32__)
#include once "crt/win32/ctype.bi"
#elseif defined(__FB_LINUX__)
#include once "crt/linux/ctype.bi"
#endif

extern "C"

declare function isalnum (byval as long) as long
declare function isalpha (byval as long) as long
declare function iscntrl (byval as long) as long
declare function isdigit (byval as long) as long
declare function isgraph (byval as long) as long
declare function islower (byval as long) as long
declare function isprint (byval as long) as long
declare function ispunct (byval as long) as long
declare function isspace (byval as long) as long
declare function isupper (byval as long) as long
declare function isxdigit (byval as long) as long
declare function tolower (byval as long) as long
declare function toupper (byval as long) as long
declare function isascii (byval as long) as long
declare function toascii (byval as long) as long

end extern

#endif
