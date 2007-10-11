''
''
'' gtkpaned -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkpaned_bi__
#define __gtkpaned_bi__

#include once "gtkcontainer.bi"

#define GTK_TYPE_PANED (gtk_paned_get_type ())
#define GTK_PANED(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_PANED, GtkPaned))
#define GTK_PANED_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_PANED, GtkPanedClass))
#define GTK_IS_PANED(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_PANED))
#define GTK_IS_PANED_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_PANED))
#define GTK_PANED_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_PANED, GtkPanedClass))

type GtkPaned as _GtkPaned
type GtkPanedClass as _GtkPanedClass
type GtkPanedPrivate as _GtkPanedPrivate

type _GtkPaned
	container as GtkContainer
	child1 as GtkWidget ptr
	child2 as GtkWidget ptr
	handle as GdkWindow ptr
	xor_gc as GdkGC ptr
	cursor_type as GdkCursorType
	handle_pos as GdkRectangle
	child1_size as gint
	last_allocation as gint
	min_position as gint
	max_position as gint
	position_set:1 as guint
	in_drag:1 as guint
	child1_shrink:1 as guint
	child1_resize:1 as guint
	child2_shrink:1 as guint
	child2_resize:1 as guint
	orientation:1 as guint
	in_recursion:1 as guint
	handle_prelit:1 as guint
	last_child1_focus as GtkWidget ptr
	last_child2_focus as GtkWidget ptr
	priv as GtkPanedPrivate ptr
	drag_pos as gint
	original_position as gint
end type

type _GtkPanedClass
	parent_class as GtkContainerClass
	cycle_child_focus as function cdecl(byval as GtkPaned ptr, byval as gboolean) as gboolean
	toggle_handle_focus as function cdecl(byval as GtkPaned ptr) as gboolean
	move_handle as function cdecl(byval as GtkPaned ptr, byval as GtkScrollType) as gboolean
	cycle_handle_focus as function cdecl(byval as GtkPaned ptr, byval as gboolean) as gboolean
	accept_position as function cdecl(byval as GtkPaned ptr) as gboolean
	cancel_position as function cdecl(byval as GtkPaned ptr) as gboolean
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_paned_get_type () as GType
declare sub gtk_paned_add1 (byval paned as GtkPaned ptr, byval child as GtkWidget ptr)
declare sub gtk_paned_add2 (byval paned as GtkPaned ptr, byval child as GtkWidget ptr)
declare sub gtk_paned_pack1 (byval paned as GtkPaned ptr, byval child as GtkWidget ptr, byval resize as gboolean, byval shrink as gboolean)
declare sub gtk_paned_pack2 (byval paned as GtkPaned ptr, byval child as GtkWidget ptr, byval resize as gboolean, byval shrink as gboolean)
declare function gtk_paned_get_position (byval paned as GtkPaned ptr) as gint
declare sub gtk_paned_set_position (byval paned as GtkPaned ptr, byval position as gint)
declare function gtk_paned_get_child1 (byval paned as GtkPaned ptr) as GtkWidget ptr
declare function gtk_paned_get_child2 (byval paned as GtkPaned ptr) as GtkWidget ptr
declare sub gtk_paned_compute_position (byval paned as GtkPaned ptr, byval allocation as gint, byval child1_req as gint, byval child2_req as gint)

#define	gtk_paned_gutter_size(p,s) 
#define	gtk_paned_set_gutter_size(p,s) 

#endif
