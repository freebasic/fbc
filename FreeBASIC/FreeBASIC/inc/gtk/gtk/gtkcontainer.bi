''
''
'' gtkcontainer -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkcontainer_bi__
#define __gtkcontainer_bi__

#include once "gtk/gdk.bi"
#include once "gtkenums.bi"
#include once "gtkwidget.bi"
#include once "gtkadjustment.bi"

#define GTK_TYPE_CONTAINER              gtk_container_get_type()
#define GTK_CONTAINER(obj)              G_TYPE_CHECK_INSTANCE_CAST(obj, GTK_TYPE_CONTAINER, GtkContainer)
#define GTK_CONTAINER_CLASS(klass)      G_TYPE_CHECK_CLASS_CAST(klass, GTK_TYPE_CONTAINER, GtkContainerClass)
#define GTK_IS_CONTAINER(obj)           G_TYPE_CHECK_INSTANCE_TYPE (obj, GTK_TYPE_CONTAINER)
#define GTK_IS_CONTAINER_CLASS(klass)   G_TYPE_CHECK_CLASS_TYPE(klass, GTK_TYPE_CONTAINER)
#define GTK_CONTAINER_GET_CLASS(obj)    G_TYPE_INSTANCE_GET_CLASS(obj, GTK_TYPE_CONTAINER, GtkContainerClass)

type GtkContainer as _GtkContainer
type GtkContainerClass as _GtkContainerClass

type _GtkContainer
	widget as GtkWidget
	focus_child as GtkWidget ptr
	border_width:16 as guint
	need_resize:1 as guint
	resize_mode:2 as guint
	reallocate_redraws:1 as guint
	has_focus_chain:1 as guint
end type

type _GtkContainerClass
	parent_class as GtkWidgetClass
	add as sub cdecl(byval as GtkContainer ptr, byval as GtkWidget ptr)
	remove as sub cdecl(byval as GtkContainer ptr, byval as GtkWidget ptr)
	check_resize as sub cdecl(byval as GtkContainer ptr)
	forall as sub cdecl(byval as GtkContainer ptr, byval as gboolean, byval as GtkCallback, byval as gpointer)
	set_focus_child as sub cdecl(byval as GtkContainer ptr, byval as GtkWidget ptr)
	child_type as function cdecl(byval as GtkContainer ptr) as GType
	composite_name as function cdecl(byval as GtkContainer ptr, byval as GtkWidget ptr) as gchar
	set_child_property as sub cdecl(byval as GtkContainer ptr, byval as GtkWidget ptr, byval as guint, byval as GValue ptr, byval as GParamSpec ptr)
	get_child_property as sub cdecl(byval as GtkContainer ptr, byval as GtkWidget ptr, byval as guint, byval as GValue ptr, byval as GParamSpec ptr)
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_container_get_type () as GType
declare sub gtk_container_set_border_width (byval container as GtkContainer ptr, byval border_width as guint)
declare function gtk_container_get_border_width (byval container as GtkContainer ptr) as guint
declare sub gtk_container_add (byval container as GtkContainer ptr, byval widget as GtkWidget ptr)
declare sub gtk_container_remove (byval container as GtkContainer ptr, byval widget as GtkWidget ptr)
declare sub gtk_container_set_resize_mode (byval container as GtkContainer ptr, byval resize_mode as GtkResizeMode)
declare function gtk_container_get_resize_mode (byval container as GtkContainer ptr) as GtkResizeMode
declare sub gtk_container_check_resize (byval container as GtkContainer ptr)
declare sub gtk_container_foreach (byval container as GtkContainer ptr, byval callback as GtkCallback, byval callback_data as gpointer)
declare sub gtk_container_foreach_full (byval container as GtkContainer ptr, byval callback as GtkCallback, byval marshal as GtkCallbackMarshal, byval callback_data as gpointer, byval notify as GtkDestroyNotify)
declare function gtk_container_get_children (byval container as GtkContainer ptr) as GList ptr
declare sub gtk_container_propagate_expose (byval container as GtkContainer ptr, byval child as GtkWidget ptr, byval event as GdkEventExpose ptr)
declare sub gtk_container_set_focus_chain (byval container as GtkContainer ptr, byval focusable_widgets as GList ptr)
declare function gtk_container_get_focus_chain (byval container as GtkContainer ptr, byval focusable_widgets as GList ptr ptr) as gboolean
declare sub gtk_container_unset_focus_chain (byval container as GtkContainer ptr)
declare sub gtk_container_set_reallocate_redraws (byval container as GtkContainer ptr, byval needs_redraws as gboolean)
declare sub gtk_container_set_focus_child (byval container as GtkContainer ptr, byval child as GtkWidget ptr)
declare sub gtk_container_set_focus_vadjustment (byval container as GtkContainer ptr, byval adjustment as GtkAdjustment ptr)
declare function gtk_container_get_focus_vadjustment (byval container as GtkContainer ptr) as GtkAdjustment ptr
declare sub gtk_container_set_focus_hadjustment (byval container as GtkContainer ptr, byval adjustment as GtkAdjustment ptr)
declare function gtk_container_get_focus_hadjustment (byval container as GtkContainer ptr) as GtkAdjustment ptr
declare sub gtk_container_resize_children (byval container as GtkContainer ptr)
declare function gtk_container_child_type (byval container as GtkContainer ptr) as GType
declare sub gtk_container_class_install_child_property (byval cclass as GtkContainerClass ptr, byval property_id as guint, byval pspec as GParamSpec ptr)
declare function gtk_container_class_find_child_property (byval cclass as GObjectClass ptr, byval property_name as zstring ptr) as GParamSpec ptr
declare function gtk_container_class_list_child_properties (byval cclass as GObjectClass ptr, byval n_properties as guint ptr) as GParamSpec ptr ptr
declare sub gtk_container_add_with_properties (byval container as GtkContainer ptr, byval widget as GtkWidget ptr, byval first_prop_name as zstring ptr, ...)
declare sub gtk_container_child_set (byval container as GtkContainer ptr, byval child as GtkWidget ptr, byval first_prop_name as zstring ptr, ...)
declare sub gtk_container_child_get (byval container as GtkContainer ptr, byval child as GtkWidget ptr, byval first_prop_name as zstring ptr, ...)
''''''' declare sub gtk_container_child_set_valist (byval container as GtkContainer ptr, byval child as GtkWidget ptr, byval first_property_name as zstring ptr, byval var_args as va_list)
''''''' declare sub gtk_container_child_get_valist (byval container as GtkContainer ptr, byval child as GtkWidget ptr, byval first_property_name as zstring ptr, byval var_args as va_list)
declare sub gtk_container_child_set_property (byval container as GtkContainer ptr, byval child as GtkWidget ptr, byval property_name as zstring ptr, byval value as GValue ptr)
declare sub gtk_container_child_get_property (byval container as GtkContainer ptr, byval child as GtkWidget ptr, byval property_name as zstring ptr, byval value as GValue ptr)
declare sub gtk_container_forall (byval container as GtkContainer ptr, byval callback as GtkCallback, byval callback_data as gpointer)
declare sub _gtk_container_queue_resize (byval container as GtkContainer ptr)
declare sub _gtk_container_clear_resize_widgets (byval container as GtkContainer ptr)
declare function _gtk_container_child_composite_name (byval container as GtkContainer ptr, byval child as GtkWidget ptr) as zstring ptr
declare sub _gtk_container_dequeue_resize_handler (byval container as GtkContainer ptr)
declare function _gtk_container_focus_sort (byval container as GtkContainer ptr, byval children as GList ptr, byval direction as GtkDirectionType, byval old_focus as GtkWidget ptr) as GList ptr

#define gtk_container_children gtk_container_get_children
#define	gtk_container_border_width gtk_container_set_border_width

#endif
