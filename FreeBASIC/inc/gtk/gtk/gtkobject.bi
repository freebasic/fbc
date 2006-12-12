''
''
'' gtkobject -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkobject_bi__
#define __gtkobject_bi__

#include once "gtkenums.bi"
#include once "gtktypeutils.bi"
#include once "gtkdebug.bi"

#define	GTK_TYPE_OBJECT			gtk_object_get_type()
#define GTK_OBJECT(object)		GTK_CHECK_CAST(object, GTK_TYPE_OBJECT, GtkObject)
#define GTK_OBJECT_CLASS(klass)		GTK_CHECK_CLASS_CAST(klass, GTK_TYPE_OBJECT, GtkObjectClass)
#define GTK_IS_OBJECT(object)		GTK_CHECK_TYPE(object, GTK_TYPE_OBJECT)
#define GTK_IS_OBJECT_CLASS(klass)	GTK_CHECK_CLASS_TYPE(klass, GTK_TYPE_OBJECT)
#define	GTK_OBJECT_GET_CLASS(object)	GTK_CHECK_GET_CLASS(object, GTK_TYPE_OBJECT, GtkObjectClass)

#define GTK_OBJECT_TYPE(object) (G_TYPE_FROM_INSTANCE (object))
#define GTK_OBJECT_TYPE_NAME(object) (g_type_name (GTK_OBJECT_TYPE (object)))

#define GTK_OBJECT_FLAGS(obj) (GTK_OBJECT (obj)->flags)
#define GTK_OBJECT_FLOATING(obj) ((GTK_OBJECT_FLAGS (obj) & GTK_FLOATING) != 0)

#define GTK_OBJECT_SET_FLAGS(obj,flag) GTK_OBJECT_FLAGS (obj) or= (flag)
#define GTK_OBJECT_UNSET_FLAGS(obj,flag) GTK_OBJECT_FLAGS (obj) and= not (flag)

enum GtkObjectFlags
	GTK_IN_DESTRUCTION = 1 shl 0
	GTK_FLOATING = 1 shl 1
	GTK_RESERVED_1 = 1 shl 2
	GTK_RESERVED_2 = 1 shl 3
end enum

type GtkObjectClass as _GtkObjectClass

type _GtkObject
	parent_instance as GObject
	flags as guint32
end type

type _GtkObjectClass
	parent_class as GObjectClass
	set_arg as sub cdecl(byval as GtkObject ptr, byval as GtkArg ptr, byval as guint)
	get_arg as sub cdecl(byval as GtkObject ptr, byval as GtkArg ptr, byval as guint)
	destroy as sub cdecl(byval as GtkObject ptr)
end type

declare function gtk_object_get_type () as GtkType
declare sub gtk_object_sink (byval object as GtkObject ptr)
declare sub gtk_object_destroy (byval object as GtkObject ptr)
declare function gtk_object_new (byval type as GtkType, byval first_property_name as zstring ptr, ...) as GtkObject ptr
declare function gtk_object_ref (byval object as GtkObject ptr) as GtkObject ptr
declare sub gtk_object_unref (byval object as GtkObject ptr)
declare sub gtk_object_weakref (byval object as GtkObject ptr, byval notify as GtkDestroyNotify, byval data as gpointer)
declare sub gtk_object_weakunref (byval object as GtkObject ptr, byval notify as GtkDestroyNotify, byval data as gpointer)
declare sub gtk_object_set_data (byval object as GtkObject ptr, byval key as zstring ptr, byval data as gpointer)
declare sub gtk_object_set_data_full (byval object as GtkObject ptr, byval key as zstring ptr, byval data as gpointer, byval destroy as GtkDestroyNotify)
declare sub gtk_object_remove_data (byval object as GtkObject ptr, byval key as zstring ptr)
declare function gtk_object_get_data (byval object as GtkObject ptr, byval key as zstring ptr) as gpointer
declare sub gtk_object_remove_no_notify (byval object as GtkObject ptr, byval key as zstring ptr)
declare sub gtk_object_set_user_data (byval object as GtkObject ptr, byval data as gpointer)
declare function gtk_object_get_user_data (byval object as GtkObject ptr) as gpointer
declare sub gtk_object_set_data_by_id (byval object as GtkObject ptr, byval data_id as GQuark, byval data as gpointer)
declare sub gtk_object_set_data_by_id_full (byval object as GtkObject ptr, byval data_id as GQuark, byval data as gpointer, byval destroy as GtkDestroyNotify)
declare function gtk_object_get_data_by_id (byval object as GtkObject ptr, byval data_id as GQuark) as gpointer
declare sub gtk_object_remove_data_by_id (byval object as GtkObject ptr, byval data_id as GQuark)
declare sub gtk_object_remove_no_notify_by_id (byval object as GtkObject ptr, byval key_id as GQuark)

enum GtkArgFlags
	GTK_ARG_READABLE = G_PARAM_READABLE
	GTK_ARG_WRITABLE = G_PARAM_WRITABLE
	GTK_ARG_CONSTRUCT = G_PARAM_CONSTRUCT
	GTK_ARG_CONSTRUCT_ONLY = G_PARAM_CONSTRUCT_ONLY
	GTK_ARG_CHILD_ARG = 1 shl 4
end enum


declare sub gtk_object_get (byval object as GtkObject ptr, byval first_property_name as zstring ptr, ...)
declare sub gtk_object_set (byval object as GtkObject ptr, byval first_property_name as zstring ptr, ...)
declare sub gtk_object_add_arg_type (byval arg_name as zstring ptr, byval arg_type as GtkType, byval arg_flags as guint, byval arg_id as guint)

#endif
