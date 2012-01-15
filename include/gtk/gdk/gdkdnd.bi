''
''
'' gdkdnd -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gdkdnd_bi__
#define __gdkdnd_bi__

#include once "gdktypes.bi"

#define GDK_TYPE_DRAG_CONTEXT (gdk_drag_context_get_type ())
#define GDK_DRAG_CONTEXT(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GDK_TYPE_DRAG_CONTEXT, GdkDragContext))
#define GDK_DRAG_CONTEXT_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GDK_TYPE_DRAG_CONTEXT, GdkDragContextClass))
#define GDK_IS_DRAG_CONTEXT(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GDK_TYPE_DRAG_CONTEXT))
#define GDK_IS_DRAG_CONTEXT_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GDK_TYPE_DRAG_CONTEXT))
#define GDK_DRAG_CONTEXT_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GDK_TYPE_DRAG_CONTEXT, GdkDragContextClass))

type GdkDragContext as _GdkDragContext

enum GdkDragAction
	GDK_ACTION_DEFAULT = 1 shl 0
	GDK_ACTION_COPY = 1 shl 1
	GDK_ACTION_MOVE = 1 shl 2
	GDK_ACTION_LINK = 1 shl 3
	GDK_ACTION_PRIVATE = 1 shl 4
	GDK_ACTION_ASK = 1 shl 5
end enum


enum GdkDragProtocol
	GDK_DRAG_PROTO_MOTIF
	GDK_DRAG_PROTO_XDND
	GDK_DRAG_PROTO_ROOTWIN
	GDK_DRAG_PROTO_NONE
	GDK_DRAG_PROTO_WIN32_DROPFILES
	GDK_DRAG_PROTO_OLE2
	GDK_DRAG_PROTO_LOCAL
end enum

type GdkDragContextClass as _GdkDragContextClass

type _GdkDragContext
	parent_instance as GObject
	protocol as GdkDragProtocol
	is_source as gboolean
	source_window as GdkWindow ptr
	dest_window as GdkWindow ptr
	targets as GList ptr
	actions as GdkDragAction
	suggested_action as GdkDragAction
	action as GdkDragAction
	start_time as guint32
	windowing_data as gpointer
end type

type _GdkDragContextClass
	parent_class as GObjectClass
end type

declare function gdk_drag_context_get_type () as GType
declare function gdk_drag_context_new () as GdkDragContext ptr
declare sub gdk_drag_context_ref (byval context as GdkDragContext ptr)
declare sub gdk_drag_context_unref (byval context as GdkDragContext ptr)
declare sub gdk_drag_status (byval context as GdkDragContext ptr, byval action as GdkDragAction, byval time_ as guint32)
declare sub gdk_drop_reply (byval context as GdkDragContext ptr, byval ok as gboolean, byval time_ as guint32)
declare sub gdk_drop_finish (byval context as GdkDragContext ptr, byval success as gboolean, byval time_ as guint32)
declare function gdk_drag_get_selection (byval context as GdkDragContext ptr) as GdkAtom
declare function gdk_drag_begin (byval window as GdkWindow ptr, byval targets as GList ptr) as GdkDragContext ptr
declare function gdk_drag_get_protocol_for_display (byval display as GdkDisplay ptr, byval xid as guint32, byval protocol as GdkDragProtocol ptr) as guint32
declare sub gdk_drag_find_window_for_screen (byval context as GdkDragContext ptr, byval drag_window as GdkWindow ptr, byval screen as GdkScreen ptr, byval x_root as gint, byval y_root as gint, byval dest_window as GdkWindow ptr ptr, byval protocol as GdkDragProtocol ptr)
declare function gdk_drag_get_protocol (byval xid as guint32, byval protocol as GdkDragProtocol ptr) as guint32
declare sub gdk_drag_find_window (byval context as GdkDragContext ptr, byval drag_window as GdkWindow ptr, byval x_root as gint, byval y_root as gint, byval dest_window as GdkWindow ptr ptr, byval protocol as GdkDragProtocol ptr)
declare function gdk_drag_motion (byval context as GdkDragContext ptr, byval dest_window as GdkWindow ptr, byval protocol as GdkDragProtocol, byval x_root as gint, byval y_root as gint, byval suggested_action as GdkDragAction, byval possible_actions as GdkDragAction, byval time_ as guint32) as gboolean
declare sub gdk_drag_drop (byval context as GdkDragContext ptr, byval time_ as guint32)
declare sub gdk_drag_abort (byval context as GdkDragContext ptr, byval time_ as guint32)
declare function gdk_drag_drop_succeeded (byval context as GdkDragContext ptr) as gboolean

#endif
