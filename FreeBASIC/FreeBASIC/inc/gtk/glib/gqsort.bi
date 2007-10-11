''
''
'' gqsort -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gqsort_bi__
#define __gqsort_bi__

#include once "gtypes.bi"

declare sub g_qsort_with_data (byval pbase as gconstpointer, byval total_elems as gint, byval size as gsize, byval compare_func as GCompareDataFunc, byval user_data as gpointer)

#endif
