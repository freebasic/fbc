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

#define GTK_TYPE_INVALID G_TYPE_INVALID
#define GTK_TYPE_NONE G_TYPE_NONE
#define GTK_TYPE_ENUM G_TYPE_ENUM
#define GTK_TYPE_FLAGS G_TYPE_FLAGS

#define GTK_TYPE_CHAR G_TYPE_CHAR
#define GTK_TYPE_UCHAR G_TYPE_UCHAR
#define GTK_TYPE_BOOL G_TYPE_BOOLEAN
#define GTK_TYPE_INT G_TYPE_INT
#define GTK_TYPE_UINT G_TYPE_UINT
#define GTK_TYPE_LONG G_TYPE_LONG
#define GTK_TYPE_ULONG G_TYPE_ULONG
#define GTK_TYPE_FLOAT G_TYPE_FLOAT
#define GTK_TYPE_DOUBLE G_TYPE_DOUBLE
#define GTK_TYPE_STRING G_TYPE_STRING
#define GTK_TYPE_BOXED G_TYPE_BOXED
#define GTK_TYPE_POINTER G_TYPE_POINTER

#define GTK_CLASS_NAME(class_) (g_type_name (G_TYPE_FROM_CLASS (class_)))
#define GTK_CLASS_TYPE(class_) (G_TYPE_FROM_CLASS (class_))
#define GTK_TYPE_IS_OBJECT(type_) (g_type_is_a ((type_), GTK_TYPE_OBJECT))

#define	GTK_TYPE_FUNDAMENTAL_LAST (G_TYPE_LAST_RESERVED_FUNDAMENTAL - 1)
#define	GTK_TYPE_FUNDAMENTAL_MAX (G_TYPE_FUNDAMENTAL_MAX)

#define	GTK_FUNDAMENTAL_TYPE G_TYPE_FUNDAMENTAL
#define GTK_STRUCT_OFFSET G_STRUCT_OFFSET

#define	GTK_CHECK_CAST G_TYPE_CHECK_INSTANCE_CAST
#define	GTK_CHECK_CLASS_CAST G_TYPE_CHECK_CLASS_CAST
#define GTK_CHECK_GET_CLASS	G_TYPE_INSTANCE_GET_CLASS
#define	GTK_CHECK_TYPE G_TYPE_CHECK_INSTANCE_TYPE
#define	GTK_CHECK_CLASS_TYPE G_TYPE_CHECK_CLASS_TYPE

#define GTK_TYPE_IDENTIFIER (gtk_identifier_get_type ())

#define GTK_VALUE_CHAR(a) ((a).d.char_data)
#define GTK_VALUE_UCHAR(a) ((a).d.uchar_data)
#define GTK_VALUE_BOOL(a) ((a).d.bool_data)
#define GTK_VALUE_INT(a) ((a).d.int_data)
#define GTK_VALUE_UINT(a) ((a).d.uint_data)
#define GTK_VALUE_LONG(a) ((a).d.long_data)
#define GTK_VALUE_ULONG(a) ((a).d.ulong_data)
#define GTK_VALUE_FLOAT(a) ((a).d.float_data)
#define GTK_VALUE_DOUBLE(a) ((a).d.double_data)
#define GTK_VALUE_STRING(a) ((a).d.string_data)
#define GTK_VALUE_ENUM(a) ((a).d.int_data)
#define GTK_VALUE_FLAGS(a) ((a).d.uint_data)
#define GTK_VALUE_BOXED(a) ((a).d.pointer_data)
#define GTK_VALUE_OBJECT(a) ((a).d.object_data)
#define GTK_VALUE_POINTER(a) ((a).d.pointer_data)
#define GTK_VALUE_SIGNAL(a) ((a).d.signal_data)

#define GTK_RETLOC_CHAR(a) cast(gchar ptr, (a).d.pointer_data)
#define GTK_RETLOC_UCHAR(a) cast(guchar ptr, (a).d.pointer_data)
#define GTK_RETLOC_BOOL(a) cast(gboolean ptr, (a).d.pointer_data)
#define GTK_RETLOC_INT(a) cast(gint ptr, (a).d.pointer_data)
#define GTK_RETLOC_UINT(a) cast(guint ptr, (a).d.pointer_data)
#define GTK_RETLOC_LONG(a) cast(glong ptr, (a).d.pointer_data)
#define GTK_RETLOC_ULONG(a) cast(gulong ptr, (a).d.pointer_data)
#define GTK_RETLOC_FLOAT(a) cast(gfloat ptr, (a).d.pointer_data)
#define GTK_RETLOC_DOUBLE(a) cast(gdouble ptr, (a).d.pointer_data)
#define GTK_RETLOC_STRING(a) cast(gchar ptr ptr, (a).d.pointer_data)
#define GTK_RETLOC_ENUM(a) cast(gint ptr, (a).d.pointer_data)
#define GTK_RETLOC_FLAGS(a) cast(guint ptr, (a).d.pointer_data)
#define GTK_RETLOC_BOXED(a) cast(gpointer ptr, (a).d.pointer_data)
#define GTK_RETLOC_OBJECT(a) cast(GtkObject ptr ptr, (a).d.pointer_data)
#define GTK_RETLOC_POINTER(a) cast(gpointer ptr, (a).d.pointer_data)

#define GTK_SIGNAL_FUNC(f) cast(GtkSignalFunc, f)

type GtkFundamentalType as GType
type GtkType as GType
type GtkTypeObject as GTypeInstance
type GtkTypeClass as GTypeClass
type GtkClassInitFunc as GBaseInitFunc
type GtkObjectInitFunc as GInstanceInitFunc

#include once "gtktypebuiltins.bi"

declare function gtk_identifier_get_type () as GType

type GtkArg as _GtkArg
type GtkObject as _GtkObject
type GtkFunction as function cdecl(byval as gpointer) as gboolean
type GtkDestroyNotify as sub cdecl(byval as gpointer)
type GtkCallbackMarshal as sub cdecl(byval as GtkObject ptr, byval as gpointer, byval as guint, byval as GtkArg ptr)
type GtkSignalFunc as sub cdecl()
type GtkTypeInfo as _GtkTypeInfo
type GtkSignalMarshaller as GSignalCMarshaller

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

declare function gtk_type_class (byval type as GtkType) as gpointer
declare function gtk_type_unique (byval parent_type as GtkType, byval gtkinfo as GtkTypeInfo ptr) as GtkType
declare function gtk_type_new (byval type as GtkType) as gpointer

type GtkEnumValue as GEnumValue
type GtkFlagValue as GFlagsValue

declare function gtk_type_enum_get_values (byval enum_type as GtkType) as GtkEnumValue ptr
declare function gtk_type_flags_get_values (byval flags_type as GtkType) as GtkFlagValue ptr
declare function gtk_type_enum_find_value (byval enum_type as GtkType, byval value_name as zstring ptr) as GtkEnumValue ptr
declare function gtk_type_flags_find_value (byval flags_type as GtkType, byval value_name as zstring ptr) as GtkFlagValue ptr
declare sub gtk_type_init (byval debug_flags as GTypeDebugFlags)

#endif
