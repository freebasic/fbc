''
''
'' gtktypeutils -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtktypeutils_bi__
#define __gtktypeutils_bi__

#include once "gtk/glib-object.bi"

type GtkFundamentalType as GType
type GtkType as GType
type GtkTypeObject as GTypeInstance
type GtkTypeClass as GTypeClass
type GtkClassInitFunc as GBaseInitFunc
type GtkObjectInitFunc as GInstanceInitFunc

#define	GTK_CHECK_CAST(instance, g_type, c_type) _G_TYPE_CIC( instance, g_type, c_type )
#define	GTK_CHECK_CLASS_CAST(g_class, g_type, c_type) _G_TYPE_CCC( g_class, g_type, c_type )
#define GTK_CHECK_GET_CLASS(instance, g_type, c_type) _G_TYPE_IGC( instance, g_type, c_type )
#define	GTK_CHECK_TYPE(instance, g_type) _G_TYPE_CIT( instance, g_type )
#define	GTK_CHECK_CLASS_TYPE(g_class, g_type) _G_TYPE_CCT( g_class, g_type )

#include once "gtk/gtk/gtktypebuiltins.bi"

declare function gtk_identifier_get_type cdecl alias "gtk_identifier_get_type" () as GType

type GtkArg as _GtkArg
type GtkObject as _GtkObject
type GtkFunction as function cdecl(byval as gpointer) as gboolean
type GtkDestroyNotify as sub cdecl(byval as gpointer)
type GtkCallbackMarshal as sub cdecl(byval as GtkObject ptr, byval as gpointer, byval as guint, byval as GtkArg ptr)
type GtkSignalFunc as sub cdecl()
type GtkTypeInfo as _GtkTypeInfo
type GtkSignalMarshaller as GSignalCMarshaller

#define GTK_SIGNAL_FUNC(f) cptr(GtkSignalFunc, f)

type _GtkArg_d_signal_data
	f as GtkSignalFunc
	d as gpointer
end type

union _GtkArg_d
	char_data as gchar
	uchar_data as guchar
	bool_data as gboolean
	int_data as gint
	uint_data as guint
	long_data as glong
	ulong_data as gulong
	float_data as gfloat
	double_data as gdouble
	string_data as zstring ptr
	object_data as GtkObject ptr
	pointer_data as gpointer
	signal_data as _GtkArg_d_signal_data
end union

type _GtkArg
	type as GtkType
	name as zstring ptr
	d as _GtkArg_d
end type

type _GtkTypeInfo
	type_name as zstring ptr
	object_size as guint
	class_size as guint
	class_init_func as GtkClassInitFunc
	object_init_func as GtkObjectInitFunc
	reserved_1 as gpointer
	reserved_2 as gpointer
	base_class_init_func as GtkClassInitFunc
end type

declare function gtk_type_class cdecl alias "gtk_type_class" (byval type as GtkType) as gpointer
declare function gtk_type_unique cdecl alias "gtk_type_unique" (byval parent_type as GtkType, byval gtkinfo as GtkTypeInfo ptr) as GtkType
declare function gtk_type_new cdecl alias "gtk_type_new" (byval type as GtkType) as gpointer

type GtkEnumValue as GEnumValue
type GtkFlagValue as GFlagsValue

declare function gtk_type_enum_get_values cdecl alias "gtk_type_enum_get_values" (byval enum_type as GtkType) as GtkEnumValue ptr
declare function gtk_type_flags_get_values cdecl alias "gtk_type_flags_get_values" (byval flags_type as GtkType) as GtkFlagValue ptr
declare function gtk_type_enum_find_value cdecl alias "gtk_type_enum_find_value" (byval enum_type as GtkType, byval value_name as string) as GtkEnumValue ptr
declare function gtk_type_flags_find_value cdecl alias "gtk_type_flags_find_value" (byval flags_type as GtkType, byval value_name as string) as GtkFlagValue ptr
declare sub gtk_type_init cdecl alias "gtk_type_init" (byval debug_flags as GTypeDebugFlags)

#endif
