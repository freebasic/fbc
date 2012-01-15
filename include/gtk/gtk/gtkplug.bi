''
''
'' gtkplug -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkplug_bi__
#define __gtkplug_bi__

#include once "gtk/gdk.bi"
#include once "gtksocket.bi"
#include once "gtkwindow.bi"

#define GTK_TYPE_PLUG (gtk_plug_get_type ())
#define GTK_PLUG(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_PLUG, GtkPlug))
#define GTK_PLUG_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_PLUG, GtkPlugClass))
#define GTK_IS_PLUG(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_PLUG))
#define GTK_IS_PLUG_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_PLUG))
#define GTK_PLUG_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_PLUG, GtkPlugClass))

type GtkPlug as _GtkPlug
type GtkPlugClass as _GtkPlugClass

type _GtkPlug
	window as GtkWindow
	socket_window as GdkWindow ptr
	modality_window as GtkWidget ptr
	modality_group as GtkWindowGroup ptr
	grabbed_keys as GHashTable ptr
	same_app as guint
end type

type _GtkPlugClass
	parent_class as GtkWindowClass
	embedded as sub cdecl(byval as GtkPlug ptr)
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_plug_get_type () as GType
declare sub gtk_plug_construct (byval plug as GtkPlug ptr, byval socket_id as GdkNativeWindow)
declare function gtk_plug_new (byval socket_id as GdkNativeWindow) as GtkWidget ptr
declare sub gtk_plug_construct_for_display (byval plug as GtkPlug ptr, byval display as GdkDisplay ptr, byval socket_id as GdkNativeWindow)
declare function gtk_plug_new_for_display (byval display as GdkDisplay ptr, byval socket_id as GdkNativeWindow) as GtkWidget ptr
declare function gtk_plug_get_id (byval plug as GtkPlug ptr) as GdkNativeWindow
declare sub _gtk_plug_add_to_socket (byval plug as GtkPlug ptr, byval socket_ as GtkSocket ptr)
declare sub _gtk_plug_remove_from_socket (byval plug as GtkPlug ptr, byval socket_ as GtkSocket ptr)

#endif
