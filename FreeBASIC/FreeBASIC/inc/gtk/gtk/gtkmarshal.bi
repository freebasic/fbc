''
''
'' gtkmarshal -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkmarshal_bi__
#define __gtkmarshal_bi__

#include once "gtk/glib-object.bi"

declare sub gtk_marshal_BOOLEAN__VOID (byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_BOOLEAN__POINTER (byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_BOOLEAN__POINTER_POINTER_INT_INT (byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_BOOLEAN__POINTER_INT_INT (byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_BOOLEAN__POINTER_INT_INT_UINT (byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_BOOLEAN__POINTER_STRING_STRING_POINTER (byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_ENUM__ENUM (byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_INT__POINTER (byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_INT__POINTER_CHAR_CHAR (byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_VOID__ENUM_FLOAT (byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_VOID__ENUM_FLOAT_BOOLEAN (byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_VOID__INT_INT (byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_VOID__INT_INT_POINTER (byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_VOID__POINTER_INT (byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_VOID__POINTER_POINTER (byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_VOID__POINTER_POINTER_POINTER (byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_VOID__POINTER_STRING_STRING (byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_VOID__POINTER_UINT (byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_VOID__POINTER_UINT_ENUM (byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_VOID__POINTER_POINTER_UINT_UINT (byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_VOID__POINTER_INT_INT_POINTER_UINT_UINT (byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_VOID__POINTER_UINT_UINT (byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_VOID__STRING_INT_POINTER (byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_VOID__UINT_POINTER_UINT_ENUM_ENUM_POINTER (byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_VOID__UINT_POINTER_UINT_UINT_ENUM (byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_VOID__UINT_STRING (byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)

#endif
