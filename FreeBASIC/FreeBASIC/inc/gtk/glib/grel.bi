''
''
'' grel -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __grel_bi__
#define __grel_bi__

#include once "gtypes.bi"

type GRelation as _GRelation
type GTuples as _GTuples

type _GTuples
	len as guint
end type

declare function g_relation_new (byval fields as gint) as GRelation ptr
declare sub g_relation_destroy (byval relation as GRelation ptr)
declare sub g_relation_index (byval relation as GRelation ptr, byval field as gint, byval hash_func as GHashFunc, byval key_equal_func as GEqualFunc)
declare sub g_relation_insert (byval relation as GRelation ptr, ...)
declare function g_relation_delete (byval relation as GRelation ptr, byval key as gconstpointer, byval field as gint) as gint
declare function g_relation_select (byval relation as GRelation ptr, byval key as gconstpointer, byval field as gint) as GTuples ptr
declare function g_relation_count (byval relation as GRelation ptr, byval key as gconstpointer, byval field as gint) as gint
declare function g_relation_exists (byval relation as GRelation ptr, ...) as gboolean
declare sub g_relation_print (byval relation as GRelation ptr)
declare sub g_tuples_destroy (byval tuples as GTuples ptr)
declare function g_tuples_index (byval tuples as GTuples ptr, byval index_ as gint, byval field as gint) as gpointer

#endif
