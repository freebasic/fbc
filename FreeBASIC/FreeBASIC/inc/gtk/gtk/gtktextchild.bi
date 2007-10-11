''
''
'' gtktextchild -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtktextchild_bi__
#define __gtktextchild_bi__

#include once "gtk/glib-object.bi"

#define GTK_TYPE_TEXT_CHILD_ANCHOR (gtk_text_child_anchor_get_type ())
#define GTK_TEXT_CHILD_ANCHOR(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GTK_TYPE_TEXT_CHILD_ANCHOR, GtkTextChildAnchor))
#define GTK_TEXT_CHILD_ANCHOR_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_TEXT_CHILD_ANCHOR, GtkTextChildAnchorClass))
#define GTK_IS_TEXT_CHILD_ANCHOR(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GTK_TYPE_TEXT_CHILD_ANCHOR))
#define GTK_IS_TEXT_CHILD_ANCHOR_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_TEXT_CHILD_ANCHOR))
#define GTK_TEXT_CHILD_ANCHOR_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_TEXT_CHILD_ANCHOR, GtkTextChildAnchorClass))

type GtkTextChildAnchor as _GtkTextChildAnchor
type GtkTextChildAnchorClass as _GtkTextChildAnchorClass

type _GtkTextChildAnchor
	parent_instance as GObject
	segment as gpointer
end type

type _GtkTextChildAnchorClass
	parent_class as GObjectClass
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_text_child_anchor_get_type () as GType
declare function gtk_text_child_anchor_new () as GtkTextChildAnchor ptr
declare function gtk_text_child_anchor_get_widgets (byval anchor as GtkTextChildAnchor ptr) as GList ptr
declare function gtk_text_child_anchor_get_deleted (byval anchor as GtkTextChildAnchor ptr) as gboolean

#endif
