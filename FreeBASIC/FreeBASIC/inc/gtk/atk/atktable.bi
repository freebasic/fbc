''
''
'' atktable -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __atktable_bi__
#define __atktable_bi__

#include once "atkobject.bi"

#define ATK_TYPE_TABLE() atk_table_get_type ()
#define ATK_IS_TABLE(obj) G_TYPE_CHECK_INSTANCE_TYPE ((obj), ATK_TYPE_TABLE)
#define ATK_TABLE(obj) G_TYPE_CHECK_INSTANCE_CAST ((obj), ATK_TYPE_TABLE, AtkTable)
#define ATK_TABLE_GET_IFACE(obj) G_TYPE_INSTANCE_GET_INTERFACE ((obj), ATK_TYPE_TABLE, AtkTableIface)

type AtkTable as _AtkTable
type AtkTableIface as _AtkTableIface

type _AtkTableIface
	parent as GTypeInterface
	ref_at as function cdecl(byval as AtkTable ptr, byval as gint, byval as gint) as AtkObject
	get_index_at as function cdecl(byval as AtkTable ptr, byval as gint, byval as gint) as gint
	get_column_at_index as function cdecl(byval as AtkTable ptr, byval as gint) as gint
	get_row_at_index as function cdecl(byval as AtkTable ptr, byval as gint) as gint
	get_n_columns as function cdecl(byval as AtkTable ptr) as gint
	get_n_rows as function cdecl(byval as AtkTable ptr) as gint
	get_column_extent_at as function cdecl(byval as AtkTable ptr, byval as gint, byval as gint) as gint
	get_row_extent_at as function cdecl(byval as AtkTable ptr, byval as gint, byval as gint) as gint
	get_caption as function cdecl(byval as AtkTable ptr) as AtkObject
	get_column_description as function cdecl(byval as AtkTable ptr, byval as gint) as gchar
	get_column_header as function cdecl(byval as AtkTable ptr, byval as gint) as AtkObject
	get_row_description as function cdecl(byval as AtkTable ptr, byval as gint) as gchar
	get_row_header as function cdecl(byval as AtkTable ptr, byval as gint) as AtkObject
	get_summary as function cdecl(byval as AtkTable ptr) as AtkObject
	set_caption as sub cdecl(byval as AtkTable ptr, byval as AtkObject ptr)
	set_column_description as sub cdecl(byval as AtkTable ptr, byval as gint, byval as zstring ptr)
	set_column_header as sub cdecl(byval as AtkTable ptr, byval as gint, byval as AtkObject ptr)
	set_row_description as sub cdecl(byval as AtkTable ptr, byval as gint, byval as zstring ptr)
	set_row_header as sub cdecl(byval as AtkTable ptr, byval as gint, byval as AtkObject ptr)
	set_summary as sub cdecl(byval as AtkTable ptr, byval as AtkObject ptr)
	get_selected_columns as function cdecl(byval as AtkTable ptr, byval as gint ptr ptr) as gint
	get_selected_rows as function cdecl(byval as AtkTable ptr, byval as gint ptr ptr) as gint
	is_column_selected as function cdecl(byval as AtkTable ptr, byval as gint) as gboolean
	is_row_selected as function cdecl(byval as AtkTable ptr, byval as gint) as gboolean
	is_selected as function cdecl(byval as AtkTable ptr, byval as gint, byval as gint) as gboolean
	add_row_selection as function cdecl(byval as AtkTable ptr, byval as gint) as gboolean
	remove_row_selection as function cdecl(byval as AtkTable ptr, byval as gint) as gboolean
	add_column_selection as function cdecl(byval as AtkTable ptr, byval as gint) as gboolean
	remove_column_selection as function cdecl(byval as AtkTable ptr, byval as gint) as gboolean
	row_inserted as sub cdecl(byval as AtkTable ptr, byval as gint, byval as gint)
	column_inserted as sub cdecl(byval as AtkTable ptr, byval as gint, byval as gint)
	row_deleted as sub cdecl(byval as AtkTable ptr, byval as gint, byval as gint)
	column_deleted as sub cdecl(byval as AtkTable ptr, byval as gint, byval as gint)
	row_reordered as sub cdecl(byval as AtkTable ptr)
	column_reordered as sub cdecl(byval as AtkTable ptr)
	model_changed as sub cdecl(byval as AtkTable ptr)
	pad1 as AtkFunction
	pad2 as AtkFunction
	pad3 as AtkFunction
	pad4 as AtkFunction
end type

declare function atk_table_get_type () as GType
declare function atk_table_ref_at (byval table as AtkTable ptr, byval row as gint, byval column as gint) as AtkObject ptr
declare function atk_table_get_index_at (byval table as AtkTable ptr, byval row as gint, byval column as gint) as gint
declare function atk_table_get_column_at_index (byval table as AtkTable ptr, byval index_ as gint) as gint
declare function atk_table_get_row_at_index (byval table as AtkTable ptr, byval index_ as gint) as gint
declare function atk_table_get_n_columns (byval table as AtkTable ptr) as gint
declare function atk_table_get_n_rows (byval table as AtkTable ptr) as gint
declare function atk_table_get_column_extent_at (byval table as AtkTable ptr, byval row as gint, byval column as gint) as gint
declare function atk_table_get_row_extent_at (byval table as AtkTable ptr, byval row as gint, byval column as gint) as gint
declare function atk_table_get_caption (byval table as AtkTable ptr) as AtkObject ptr
declare function atk_table_get_column_description (byval table as AtkTable ptr, byval column as gint) as zstring ptr
declare function atk_table_get_column_header (byval table as AtkTable ptr, byval column as gint) as AtkObject ptr
declare function atk_table_get_row_description (byval table as AtkTable ptr, byval row as gint) as zstring ptr
declare function atk_table_get_row_header (byval table as AtkTable ptr, byval row as gint) as AtkObject ptr
declare function atk_table_get_summary (byval table as AtkTable ptr) as AtkObject ptr
declare sub atk_table_set_caption (byval table as AtkTable ptr, byval caption as AtkObject ptr)
declare sub atk_table_set_column_description (byval table as AtkTable ptr, byval column as gint, byval description as zstring ptr)
declare sub atk_table_set_column_header (byval table as AtkTable ptr, byval column as gint, byval header as AtkObject ptr)
declare sub atk_table_set_row_description (byval table as AtkTable ptr, byval row as gint, byval description as zstring ptr)
declare sub atk_table_set_row_header (byval table as AtkTable ptr, byval row as gint, byval header as AtkObject ptr)
declare sub atk_table_set_summary (byval table as AtkTable ptr, byval accessible as AtkObject ptr)
declare function atk_table_get_selected_columns (byval table as AtkTable ptr, byval selected as gint ptr ptr) as gint
declare function atk_table_get_selected_rows (byval table as AtkTable ptr, byval selected as gint ptr ptr) as gint
declare function atk_table_is_column_selected (byval table as AtkTable ptr, byval column as gint) as gboolean
declare function atk_table_is_row_selected (byval table as AtkTable ptr, byval row as gint) as gboolean
declare function atk_table_is_selected (byval table as AtkTable ptr, byval row as gint, byval column as gint) as gboolean
declare function atk_table_add_row_selection (byval table as AtkTable ptr, byval row as gint) as gboolean
declare function atk_table_remove_row_selection (byval table as AtkTable ptr, byval row as gint) as gboolean
declare function atk_table_add_column_selection (byval table as AtkTable ptr, byval column as gint) as gboolean
declare function atk_table_remove_column_selection (byval table as AtkTable ptr, byval column as gint) as gboolean

#endif
