''
''
'' gtktextmark -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtktextmark_bi__
#define __gtktextmark_bi__

#define GTK_TYPE_TEXT_MARK (gtk_text_mark_get_type ())
#define GTK_TEXT_MARK(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GTK_TYPE_TEXT_MARK, GtkTextMark))
#define GTK_TEXT_MARK_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_TEXT_MARK, GtkTextMarkClass))
#define GTK_IS_TEXT_MARK(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GTK_TYPE_TEXT_MARK))
#define GTK_IS_TEXT_MARK_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_TEXT_MARK))
#define GTK_TEXT_MARK_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_TEXT_MARK, GtkTextMarkClass))

type GtkTextMark as _GtkTextMark
type GtkTextMarkClass as _GtkTextMarkClass

type _GtkTextMark
	parent_instance as GObject
	segment as gpointer
end type

type _GtkTextMarkClass
	parent_class as GObjectClass
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_text_mark_get_type () as GType
declare sub gtk_text_mark_set_visible (byval mark as GtkTextMark ptr, byval setting as gboolean)
declare function gtk_text_mark_get_visible (byval mark as GtkTextMark ptr) as gboolean
declare function gtk_text_mark_get_name (byval mark as GtkTextMark ptr) as zstring ptr
declare function gtk_text_mark_get_deleted (byval mark as GtkTextMark ptr) as gboolean
declare function gtk_text_mark_get_buffer (byval mark as GtkTextMark ptr) as GtkTextBuffer ptr
declare function gtk_text_mark_get_left_gravity (byval mark as GtkTextMark ptr) as gboolean

#endif
