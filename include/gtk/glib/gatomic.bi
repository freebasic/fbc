''
''
'' gatomic -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gatomic_bi__
#define __gatomic_bi__

#include once "gtypes.bi"

declare function g_atomic_int_exchange_and_add (byval atomic as gint ptr, byval val as gint) as gint
declare sub g_atomic_int_add (byval atomic as gint ptr, byval val as gint)
declare function g_atomic_int_compare_and_exchange (byval atomic as gint ptr, byval oldval as gint, byval newval as gint) as gboolean
declare function g_atomic_pointer_compare_and_exchange (byval atomic as gpointer ptr, byval oldval as gpointer, byval newval as gpointer) as gboolean

#endif
