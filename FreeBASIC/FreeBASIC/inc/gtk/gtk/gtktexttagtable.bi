''
''
'' gtktexttagtable -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtktexttagtable_bi__
#define __gtktexttagtable_bi__

#include once "gtktexttag.bi"
#include once "gtktexttag.bi"

#define GTK_TYPE_TEXT_TAG_TABLE (gtk_text_tag_table_get_type ())
#define GTK_TEXT_TAG_TABLE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_TEXT_TAG_TABLE, GtkTextTagTable))
#define GTK_TEXT_TAG_TABLE_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_TEXT_TAG_TABLE, GtkTextTagTableClass))
#define GTK_IS_TEXT_TAG_TABLE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_TEXT_TAG_TABLE))
#define GTK_IS_TEXT_TAG_TABLE_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_TEXT_TAG_TABLE))
#define GTK_TEXT_TAG_TABLE_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_TEXT_TAG_TABLE, GtkTextTagTableClass))

type GtkTextTagTableForeach as sub cdecl(byval as GtkTextTag ptr, byval as gpointer)
type GtkTextTagTableClass as _GtkTextTagTableClass

type _GtkTextTagTable
	parent_instance as GObject
	hash as GHashTable ptr
	anonymous as GSList ptr
	anon_count as gint
	buffers as GSList ptr
end type

type _GtkTextTagTableClass
	parent_class as GObjectClass
	tag_changed as sub cdecl(byval as GtkTextTagTable ptr, byval as GtkTextTag ptr, byval as gboolean)
	tag_added as sub cdecl(byval as GtkTextTagTable ptr, byval as GtkTextTag ptr)
	tag_removed as sub cdecl(byval as GtkTextTagTable ptr, byval as GtkTextTag ptr)
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_text_tag_table_get_type () as GType
declare function gtk_text_tag_table_new () as GtkTextTagTable ptr
declare sub gtk_text_tag_table_add (byval table as GtkTextTagTable ptr, byval tag as GtkTextTag ptr)
declare sub gtk_text_tag_table_remove (byval table as GtkTextTagTable ptr, byval tag as GtkTextTag ptr)
declare function gtk_text_tag_table_lookup (byval table as GtkTextTagTable ptr, byval name as zstring ptr) as GtkTextTag ptr
declare sub gtk_text_tag_table_foreach (byval table as GtkTextTagTable ptr, byval func as GtkTextTagTableForeach, byval data as gpointer)
declare function gtk_text_tag_table_get_size (byval table as GtkTextTagTable ptr) as gint
declare sub _gtk_text_tag_table_add_buffer (byval table as GtkTextTagTable ptr, byval buffer as gpointer)
declare sub _gtk_text_tag_table_remove_buffer (byval table as GtkTextTagTable ptr, byval buffer as gpointer)

#endif
