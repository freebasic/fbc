''
''
'' gobject -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gobject_bi__
#define __gobject_bi__

#include once "gtype.bi"
#include once "gvalue.bi"
#include once "gparam.bi"
#include once "gclosure.bi"
#include once "gsignal.bi"

#define G_TYPE_IS_OBJECT(_type) (G_TYPE_FUNDAMENTAL(_type) = G_TYPE_OBJECT)
#define G_OBJECT(object) G_TYPE_CHECK_INSTANCE_CAST ((object), G_TYPE_OBJECT, GObject)
#define G_OBJECT_CLASS(class) G_TYPE_CHECK_CLASS_CAST ((class), G_TYPE_OBJECT, GObjectClass)
#define G_IS_OBJECT(object) G_TYPE_CHECK_INSTANCE_TYPE ((object), G_TYPE_OBJECT)
#define G_IS_OBJECT_CLASS(class) G_TYPE_CHECK_CLASS_TYPE ((class), G_TYPE_OBJECT)
#define G_OBJECT_GET_CLASS(object) G_TYPE_INSTANCE_GET_CLASS ((object), G_TYPE_OBJECT, GObjectClass)
#define G_OBJECT_TYPE(object) G_TYPE_FROM_INSTANCE (object)
#define G_OBJECT_TYPE_NAME(object) g_type_name (G_OBJECT_TYPE (object))
#define G_OBJECT_CLASS_TYPE(class) G_TYPE_FROM_CLASS (class)
#define G_OBJECT_CLASS_NAME(class) g_type_name (G_OBJECT_CLASS_TYPE (class))
#define G_VALUE_HOLDS_OBJECT(value) G_TYPE_CHECK_VALUE_TYPE ((value), G_TYPE_OBJECT)

type GObject as _GObject
type GObjectClass as _GObjectClass
type GObjectConstructParam as _GObjectConstructParam
type GObjectGetPropertyFunc as sub cdecl(byval as GObject ptr, byval as guint, byval as GValue ptr, byval as GParamSpec ptr)
type GObjectSetPropertyFunc as sub cdecl(byval as GObject ptr, byval as guint, byval as GValue ptr, byval as GParamSpec ptr)
type GObjectFinalizeFunc as sub cdecl(byval as GObject ptr)
type GWeakNotify as sub cdecl(byval as gpointer, byval as GObject ptr)

type _GObject
	g_type_instance as GTypeInstance
	ref_count as guint
	qdata as GData ptr
end type

type _GObjectClass
	g_type_class as GTypeClass
	construct_properties as GSList ptr
	constructor as function cdecl(byval as GType, byval as guint, byval as GObjectConstructParam ptr) as GObject
	set_property as sub cdecl(byval as GObject ptr, byval as guint, byval as GValue ptr, byval as GParamSpec ptr)
	get_property as sub cdecl(byval as GObject ptr, byval as guint, byval as GValue ptr, byval as GParamSpec ptr)
	dispose as sub cdecl(byval as GObject ptr)
	finalize as sub cdecl(byval as GObject ptr)
	dispatch_properties_changed as sub cdecl(byval as GObject ptr, byval as guint, byval as GParamSpec ptr ptr)
	notify as sub cdecl(byval as GObject ptr, byval as GParamSpec ptr)
	pdummy(0 to 8-1) as gpointer
end type

type _GObjectConstructParam
	pspec as GParamSpec ptr
	value as GValue ptr
end type

declare sub g_object_class_install_property (byval oclass as GObjectClass ptr, byval property_id as guint, byval pspec as GParamSpec ptr)
declare function g_object_class_find_property (byval oclass as GObjectClass ptr, byval property_name as zstring ptr) as GParamSpec ptr
declare function g_object_class_list_properties (byval oclass as GObjectClass ptr, byval n_properties as guint ptr) as GParamSpec ptr ptr
declare sub g_object_class_override_property (byval oclass as GObjectClass ptr, byval property_id as guint, byval name as zstring ptr)
declare sub g_object_interface_install_property (byval g_iface as gpointer, byval pspec as GParamSpec ptr)
declare function g_object_interface_find_property (byval g_iface as gpointer, byval property_name as zstring ptr) as GParamSpec ptr
declare function g_object_interface_list_properties (byval g_iface as gpointer, byval n_properties_p as guint ptr) as GParamSpec ptr ptr
declare function g_object_new (byval object_type as GType, byval first_property_name as zstring ptr, ...) as gpointer
declare function g_object_newv (byval object_type as GType, byval n_parameters as guint, byval parameters as GParameter ptr) as gpointer
''''''' declare function g_object_new_valist (byval object_type as GType, byval first_property_name as zstring ptr, byval var_args as va_list) as GObject ptr
declare sub g_object_set (byval object as gpointer, byval first_property_name as zstring ptr, ...)
declare sub g_object_get (byval object as gpointer, byval first_property_name as zstring ptr, ...)
declare function g_object_connect (byval object as gpointer, byval signal_spec as zstring ptr, ...) as gpointer
declare sub g_object_disconnect (byval object as gpointer, byval signal_spec as zstring ptr, ...)
''''''' declare sub g_object_set_valist (byval object as GObject ptr, byval first_property_name as zstring ptr, byval var_args as va_list)
''''''' declare sub g_object_get_valist (byval object as GObject ptr, byval first_property_name as zstring ptr, byval var_args as va_list)
declare sub g_object_set_property (byval object as GObject ptr, byval property_name as zstring ptr, byval value as GValue ptr)
declare sub g_object_get_property (byval object as GObject ptr, byval property_name as zstring ptr, byval value as GValue ptr)
declare sub g_object_freeze_notify (byval object as GObject ptr)
declare sub g_object_notify (byval object as GObject ptr, byval property_name as zstring ptr)
declare sub g_object_thaw_notify (byval object as GObject ptr)
declare function g_object_ref (byval object as gpointer) as gpointer
declare sub g_object_unref (byval object as gpointer)
declare sub g_object_weak_ref (byval object as GObject ptr, byval notify as GWeakNotify, byval data as gpointer)
declare sub g_object_weak_unref (byval object as GObject ptr, byval notify as GWeakNotify, byval data as gpointer)
declare sub g_object_add_weak_pointer (byval object as GObject ptr, byval weak_pointer_location as gpointer ptr)
declare sub g_object_remove_weak_pointer (byval object as GObject ptr, byval weak_pointer_location as gpointer ptr)
declare function g_object_get_qdata (byval object as GObject ptr, byval quark as GQuark) as gpointer
declare sub g_object_set_qdata (byval object as GObject ptr, byval quark as GQuark, byval data as gpointer)
declare sub g_object_set_qdata_full (byval object as GObject ptr, byval quark as GQuark, byval data as gpointer, byval destroy as GDestroyNotify)
declare function g_object_steal_qdata (byval object as GObject ptr, byval quark as GQuark) as gpointer
declare function g_object_get_data (byval object as GObject ptr, byval key as zstring ptr) as gpointer
declare sub g_object_set_data (byval object as GObject ptr, byval key as zstring ptr, byval data as gpointer)
declare sub g_object_set_data_full (byval object as GObject ptr, byval key as zstring ptr, byval data as gpointer, byval destroy as GDestroyNotify)
declare function g_object_steal_data (byval object as GObject ptr, byval key as zstring ptr) as gpointer
declare sub g_object_watch_closure (byval object as GObject ptr, byval closure as GClosure ptr)
declare function g_cclosure_new_object (byval callback_func as GCallback, byval object as GObject ptr) as GClosure ptr
declare function g_cclosure_new_object_swap (byval callback_func as GCallback, byval object as GObject ptr) as GClosure ptr
declare function g_closure_new_object (byval sizeof_closure as guint, byval object as GObject ptr) as GClosure ptr
declare sub g_value_set_object (byval value as GValue ptr, byval v_object as gpointer)
declare function g_value_get_object (byval value as GValue ptr) as gpointer
declare function g_value_dup_object (byval value as GValue ptr) as GObject ptr
declare function g_signal_connect_object (byval instance as gpointer, byval detailed_signal as zstring ptr, byval c_handler as GCallback, byval gobject as gpointer, byval connect_flags as GConnectFlags) as gulong
declare sub g_object_run_dispose (byval object as GObject ptr)
declare sub g_value_take_object (byval value as GValue ptr, byval v_object as gpointer)
declare sub g_value_set_object_take_ownership (byval value as GValue ptr, byval v_object as gpointer)

#endif
