''
''
'' win32config -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win32config_bi__
#define __win32config_bi__

#include once "libxml/xmlversion.bi"

#define HAVE_CTYPE_H 1
#define HAVE_STDLIB_H 1
#define HAVE_MALLOC_H 1
#define HAVE_TIME_H 1
#define HAVE_LOCALTIME 1
#define HAVE_GMTIME 1
#define HAVE_TIME 1
#define HAVE_MATH_H 1
#define HAVE_FCNTL_H 1

declare function isinf cdecl alias "isinf" (byval d as double) as integer
declare function isnan cdecl alias "isnan" (byval d as double) as integer

#endif
