''
''
'' gmarshal -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gmarshal_bi__
#define __gmarshal_bi__

declare sub g_cclosure_marshal_VOID__VOID cdecl alias "g_cclosure_marshal_VOID__VOID" (byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub g_cclosure_marshal_VOID__BOOLEAN cdecl alias "g_cclosure_marshal_VOID__BOOLEAN" (byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub g_cclosure_marshal_VOID__CHAR cdecl alias "g_cclosure_marshal_VOID__CHAR" (byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub g_cclosure_marshal_VOID__UCHAR cdecl alias "g_cclosure_marshal_VOID__UCHAR" (byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub g_cclosure_marshal_VOID__INT cdecl alias "g_cclosure_marshal_VOID__INT" (byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub g_cclosure_marshal_VOID__UINT cdecl alias "g_cclosure_marshal_VOID__UINT" (byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub g_cclosure_marshal_VOID__LONG cdecl alias "g_cclosure_marshal_VOID__LONG" (byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub g_cclosure_marshal_VOID__ULONG cdecl alias "g_cclosure_marshal_VOID__ULONG" (byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub g_cclosure_marshal_VOID__ENUM cdecl alias "g_cclosure_marshal_VOID__ENUM" (byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub g_cclosure_marshal_VOID__FLAGS cdecl alias "g_cclosure_marshal_VOID__FLAGS" (byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub g_cclosure_marshal_VOID__FLOAT cdecl alias "g_cclosure_marshal_VOID__FLOAT" (byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub g_cclosure_marshal_VOID__DOUBLE cdecl alias "g_cclosure_marshal_VOID__DOUBLE" (byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub g_cclosure_marshal_VOID__STRING cdecl alias "g_cclosure_marshal_VOID__STRING" (byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub g_cclosure_marshal_VOID__PARAM cdecl alias "g_cclosure_marshal_VOID__PARAM" (byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub g_cclosure_marshal_VOID__BOXED cdecl alias "g_cclosure_marshal_VOID__BOXED" (byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub g_cclosure_marshal_VOID__POINTER cdecl alias "g_cclosure_marshal_VOID__POINTER" (byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub g_cclosure_marshal_VOID__OBJECT cdecl alias "g_cclosure_marshal_VOID__OBJECT" (byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub g_cclosure_marshal_VOID__UINT_POINTER cdecl alias "g_cclosure_marshal_VOID__UINT_POINTER" (byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub g_cclosure_marshal_BOOLEAN__FLAGS cdecl alias "g_cclosure_marshal_BOOLEAN__FLAGS" (byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub g_cclosure_marshal_STRING__OBJECT_POINTER cdecl alias "g_cclosure_marshal_STRING__OBJECT_POINTER" (byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)

#endif
