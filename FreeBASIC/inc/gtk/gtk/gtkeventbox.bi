''
''
'' gtkeventbox -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkeventbox_bi__
#define __gtkeventbox_bi__

#include once "gtk/gdk.bi"
#include once "gtkbin.bi"

#define GTK_TYPE_EVENT_BOX (gtk_event_box_get_type ())
#define GTK_EVENT_BOX(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_EVENT_BOX, GtkEventBox))
#define GTK_EVENT_BOX_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_EVENT_BOX, GtkEventBoxClass))
#define GTK_IS_EVENT_BOX(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_EVENT_BOX))
#define GTK_IS_EVENT_BOX_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_EVENT_BOX))
#define GTK_EVENT_BOX_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_EVENT_BOX, GtkEventBoxClass))

type GtkEventBox as _GtkEventBox
type GtkEventBoxClass as _GtkEventBoxClass

type _GtkEventBox
	bin as GtkBin
end type

type _GtkEventBoxClass
	parent_class as GtkBinClass
end type

declare function gtk_event_box_get_type () as GType
declare function gtk_event_box_new () as GtkWidget ptr
declare function gtk_event_box_get_visible_window (byval event_box as GtkEventBox ptr) as gboolean
declare sub gtk_event_box_set_visible_window (byval event_box as GtkEventBox ptr, byval visible_window as gboolean)
declare function gtk_event_box_get_above_child (byval event_box as GtkEventBox ptr) as gboolean
declare sub gtk_event_box_set_above_child (byval event_box as GtkEventBox ptr, byval above_child as gboolean)

#endif
