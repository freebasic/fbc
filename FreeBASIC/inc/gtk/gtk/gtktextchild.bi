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

declare function gtk_text_child_anchor_get_type cdecl alias "gtk_text_child_anchor_get_type" () as GType
declare function gtk_text_child_anchor_new cdecl alias "gtk_text_child_anchor_new" () as GtkTextChildAnchor ptr
declare function gtk_text_child_anchor_get_widgets cdecl alias "gtk_text_child_anchor_get_widgets" (byval anchor as GtkTextChildAnchor ptr) as GList ptr
declare function gtk_text_child_anchor_get_deleted cdecl alias "gtk_text_child_anchor_get_deleted" (byval anchor as GtkTextChildAnchor ptr) as gboolean

#endif
