''
''
'' art_misc -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __art_misc_bi__
#define __art_misc_bi__

#include once "art_config.bi"

type art_boolean as integer

#define ART_FALSE 0
#define ART_TRUE 1
#define M_PI 3.14159265358979323846
#define M_SQRT2 1.41421356237309504880

declare sub art_die (byval fmt as zstring ptr, ...)
declare sub art_warn (byval fmt as zstring ptr, ...)
declare sub art_dprint (byval fmt as zstring ptr, ...)

#endif
