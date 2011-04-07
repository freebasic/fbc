''
''
'' gtkstatusbar -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkstatusbar_bi__
#define __gtkstatusbar_bi__

#include once "gtkhbox.bi"

#define GTK_TYPE_STATUSBAR (gtk_statusbar_get_type ())
#define GTK_STATUSBAR(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_STATUSBAR, GtkStatusbar))
#define GTK_STATUSBAR_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_STATUSBAR, GtkStatusbarClass))
#define GTK_IS_STATUSBAR(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_STATUSBAR))
#define GTK_IS_STATUSBAR_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_STATUSBAR))
#define GTK_STATUSBAR_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_STATUSBAR, GtkStatusbarClass))

type GtkStatusbar as _GtkStatusbar
type GtkStatusbarClass as _GtkStatusbarClass

type _GtkStatusbar
	parent_widget as GtkHBox
	frame as GtkWidget ptr
	label as GtkWidget ptr
	messages as GSList ptr
	keys as GSList ptr
	seq_context_id as guint
	seq_message_id as guint
	grip_window as GdkWindow ptr
	has_resize_grip as guint
end type

type _GtkStatusbarClass
	parent_class as GtkHBoxClass
	messages_mem_chunk as GMemChunk ptr
	text_pushed as sub cdecl(byval as GtkStatusbar ptr, byval as guint, byval as zstring ptr)
	text_popped as sub cdecl(byval as GtkStatusbar ptr, byval as guint, byval as zstring ptr)
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_statusbar_get_type () as GType
declare function gtk_statusbar_new () as GtkWidget ptr
declare function gtk_statusbar_get_context_id (byval statusbar as GtkStatusbar ptr, byval context_description as zstring ptr) as guint
declare function gtk_statusbar_push (byval statusbar as GtkStatusbar ptr, byval context_id as guint, byval text as zstring ptr) as guint
declare sub gtk_statusbar_pop (byval statusbar as GtkStatusbar ptr, byval context_id as guint)
declare sub gtk_statusbar_remove (byval statusbar as GtkStatusbar ptr, byval context_id as guint, byval message_id as guint)
declare sub gtk_statusbar_set_has_resize_grip (byval statusbar as GtkStatusbar ptr, byval setting as gboolean)
declare function gtk_statusbar_get_has_resize_grip (byval statusbar as GtkStatusbar ptr) as gboolean

#endif
