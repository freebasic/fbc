''
''
'' gtkliststore -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkliststore_bi__
#define __gtkliststore_bi__

#include once "gtk/gtk/gtktreemodel.bi"
#include once "gtk/gtk/gtktreesortable.bi"

type GtkListStore as _GtkListStore
type GtkListStoreClass as _GtkListStoreClass

type _GtkListStore
	parent as GObject
	stamp as gint
	seq as gpointer
	_gtk_reserved1 as gpointer
	sort_list as GList ptr
	n_columns as gint
	sort_column_id as gint
	order as GtkSortType
	column_headers as GType ptr
	length as gint
	default_sort_func as GtkTreeIterCompareFunc
	default_sort_data as gpointer
	default_sort_destroy as GtkDestroyNotify
	columns_dirty as guint
end type

type _GtkListStoreClass
	parent_class as GObjectClass
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_list_store_get_type cdecl alias "gtk_list_store_get_type" () as GType
declare function gtk_list_store_new cdecl alias "gtk_list_store_new" (byval n_columns as gint, ...) as GtkListStore ptr
declare function gtk_list_store_newv cdecl alias "gtk_list_store_newv" (byval n_columns as gint, byval types as GType ptr) as GtkListStore ptr
declare sub gtk_list_store_set_column_types cdecl alias "gtk_list_store_set_column_types" (byval list_store as GtkListStore ptr, byval n_columns as gint, byval types as GType ptr)
declare sub gtk_list_store_set_value cdecl alias "gtk_list_store_set_value" (byval list_store as GtkListStore ptr, byval iter as GtkTreeIter ptr, byval column as gint, byval value as GValue ptr)
declare sub gtk_list_store_set cdecl alias "gtk_list_store_set" (byval list_store as GtkListStore ptr, byval iter as GtkTreeIter ptr, ...)
''''''' declare sub gtk_list_store_set_valist cdecl alias "gtk_list_store_set_valist" (byval list_store as GtkListStore ptr, byval iter as GtkTreeIter ptr, byval var_args as va_list)
declare function gtk_list_store_remove cdecl alias "gtk_list_store_remove" (byval list_store as GtkListStore ptr, byval iter as GtkTreeIter ptr) as gboolean
declare sub gtk_list_store_insert cdecl alias "gtk_list_store_insert" (byval list_store as GtkListStore ptr, byval iter as GtkTreeIter ptr, byval position as gint)
declare sub gtk_list_store_insert_before cdecl alias "gtk_list_store_insert_before" (byval list_store as GtkListStore ptr, byval iter as GtkTreeIter ptr, byval sibling as GtkTreeIter ptr)
declare sub gtk_list_store_insert_after cdecl alias "gtk_list_store_insert_after" (byval list_store as GtkListStore ptr, byval iter as GtkTreeIter ptr, byval sibling as GtkTreeIter ptr)
declare sub gtk_list_store_insert_with_values cdecl alias "gtk_list_store_insert_with_values" (byval list_store as GtkListStore ptr, byval iter as GtkTreeIter ptr, byval position as gint, ...)
declare sub gtk_list_store_insert_with_valuesv cdecl alias "gtk_list_store_insert_with_valuesv" (byval list_store as GtkListStore ptr, byval iter as GtkTreeIter ptr, byval position as gint, byval columns as gint ptr, byval values as GValue ptr, byval n_values as gint)
declare sub gtk_list_store_prepend cdecl alias "gtk_list_store_prepend" (byval list_store as GtkListStore ptr, byval iter as GtkTreeIter ptr)
declare sub gtk_list_store_append cdecl alias "gtk_list_store_append" (byval list_store as GtkListStore ptr, byval iter as GtkTreeIter ptr)
declare sub gtk_list_store_clear cdecl alias "gtk_list_store_clear" (byval list_store as GtkListStore ptr)
declare function gtk_list_store_iter_is_valid cdecl alias "gtk_list_store_iter_is_valid" (byval list_store as GtkListStore ptr, byval iter as GtkTreeIter ptr) as gboolean
declare sub gtk_list_store_reorder cdecl alias "gtk_list_store_reorder" (byval store as GtkListStore ptr, byval new_order as gint ptr)
declare sub gtk_list_store_swap cdecl alias "gtk_list_store_swap" (byval store as GtkListStore ptr, byval a as GtkTreeIter ptr, byval b as GtkTreeIter ptr)
declare sub gtk_list_store_move_after cdecl alias "gtk_list_store_move_after" (byval store as GtkListStore ptr, byval iter as GtkTreeIter ptr, byval position as GtkTreeIter ptr)
declare sub gtk_list_store_move_before cdecl alias "gtk_list_store_move_before" (byval store as GtkListStore ptr, byval iter as GtkTreeIter ptr, byval position as GtkTreeIter ptr)

#endif
