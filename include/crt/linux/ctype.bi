''
''
'' fcntl -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __crt_linux_ctype_bi__
#define __crt_linux_ctype_bi__

#include once "crt/sys/types.bi"

declare function _toupper cdecl alias "_toupper" (byval as integer) as integer
declare function _tolower cdecl alias "_tolower" (byval as integer) as integer

#endif