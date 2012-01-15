''
''
'' gtype -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtype_bi__
#define __gtype_bi__

#include once "gtk/glib.bi"

#define G_TYPE_FUNDAMENTAL(_type) (g_type_fundamental_(_type))
#define	G_TYPE_FUNDAMENTAL_MAX (255 shl G_TYPE_FUNDAMENTAL_SHIFT)

#define G_TYPE_INVALID G_TYPE_MAKE_FUNDAMENTAL (0)
#define G_TYPE_NONE	G_TYPE_MAKE_FUNDAMENTAL (1)
#define G_TYPE_INTERFACE G_TYPE_MAKE_FUNDAMENTAL (2)
#define G_TYPE_CHAR	G_TYPE_MAKE_FUNDAMENTAL (3)
#define G_TYPE_UCHAR G_TYPE_MAKE_FUNDAMENTAL (4)
#define G_TYPE_BOOLEAN G_TYPE_MAKE_FUNDAMENTAL (5)
#define G_TYPE_INT G_TYPE_MAKE_FUNDAMENTAL (6)
#define G_TYPE_UINT	G_TYPE_MAKE_FUNDAMENTAL (7)
#define G_TYPE_LONG	G_TYPE_MAKE_FUNDAMENTAL (8)
#define G_TYPE_ULONG G_TYPE_MAKE_FUNDAMENTAL (9)
#define G_TYPE_INT64 G_TYPE_MAKE_FUNDAMENTAL (10)
#define G_TYPE_UINT64 G_TYPE_MAKE_FUNDAMENTAL (11)
#define G_TYPE_ENUM	G_TYPE_MAKE_FUNDAMENTAL (12)
#define G_TYPE_FLAGS G_TYPE_MAKE_FUNDAMENTAL (13)
#define G_TYPE_FLOAT G_TYPE_MAKE_FUNDAMENTAL (14)
#define G_TYPE_DOUBLE G_TYPE_MAKE_FUNDAMENTAL (15)
#define G_TYPE_STRING G_TYPE_MAKE_FUNDAMENTAL (16)
#define G_TYPE_POINTER G_TYPE_MAKE_FUNDAMENTAL (17)
#define G_TYPE_BOXED G_TYPE_MAKE_FUNDAMENTAL (18)
#define G_TYPE_PARAM G_TYPE_MAKE_FUNDAMENTAL (19)
#define G_TYPE_OBJECT G_TYPE_MAKE_FUNDAMENTAL (20)

#define	G_TYPE_FUNDAMENTAL_SHIFT 2
#define	G_TYPE_MAKE_FUNDAMENTAL(x) cuint((x) shl G_TYPE_FUNDAMENTAL_SHIFT)
#define G_TYPE_RESERVED_GLIB_FIRST 21
#define G_TYPE_RESERVED_GLIB_LAST 31
#define G_TYPE_RESERVED_BSE_FIRST 32
#define G_TYPE_RESERVED_BSE_LAST 48
#define G_TYPE_RESERVED_USER_FIRST 49

#define G_TYPE_IS_FUNDAMENTAL(_type) ((_type) <= G_TYPE_FUNDAMENTAL_MAX)
#define G_TYPE_IS_DERIVED(_type) ((_type) > G_TYPE_FUNDAMENTAL_MAX)
#define G_TYPE_IS_INTERFACE(_type) (G_TYPE_FUNDAMENTAL(_type) = G_TYPE_INTERFACE)
#define G_TYPE_IS_CLASSED(_type) (g_type_test_flags((_type), G_TYPE_FLAG_CLASSED))
#define G_TYPE_IS_INSTANTIATABLE(_type) (g_type_test_flags((_type), G_TYPE_FLAG_INSTANTIATABLE))
#define G_TYPE_IS_DERIVABLE(_type) (g_type_test_flags((_type), G_TYPE_FLAG_DERIVABLE))
#define G_TYPE_IS_DEEP_DERIVABLE(_type) (g_type_test_flags((_type), G_TYPE_FLAG_DEEP_DERIVABLE))
#define G_TYPE_IS_ABSTRACT(_type) (g_type_test_flags((_type), G_TYPE_FLAG_ABSTRACT))
#define G_TYPE_IS_VALUE_ABSTRACT(_type) (g_type_test_flags((_type), G_TYPE_FLAG_VALUE_ABSTRACT))
#define G_TYPE_IS_VALUE_TYPE(_type) (g_type_check_is_value_type(_type))
#define G_TYPE_HAS_VALUE_TABLE(_type) (g_type_value_table_peek(_type) <> NULL)


type GType as gulong
type GValue as _GValue
type GTypeCValue as _GTypeCValue
type GTypePlugin as _GTypePlugin
type GTypeClass as _GTypeClass
type GTypeInterface as _GTypeInterface
type GTypeInstance as _GTypeInstance
type GTypeInfo as _GTypeInfo
type GTypeFundamentalInfo as _GTypeFundamentalInfo
type GInterfaceInfo as _GInterfaceInfo
type GTypeValueTable as _GTypeValueTable
type GTypeQuery as _GTypeQuery

type _GTypeClass
	g_type as GType
end type

type _GTypeInstance
	g_class as GTypeClass ptr
end type

type _GTypeInterface
	g_type as GType
	g_instance_type as GType
end type

type _GTypeQuery
	type as GType
	type_name as zstring ptr
	class_size as guint
	instance_size as guint
end type

enum GTypeDebugFlags
	G_TYPE_DEBUG_NONE = 0
	G_TYPE_DEBUG_OBJECTS = 1 shl 0
	G_TYPE_DEBUG_SIGNALS = 1 shl 1
	G_TYPE_DEBUG_MASK = &h03
end enum

declare sub g_type_init ()
declare sub g_type_init_with_debug_flags (byval debug_flags as GTypeDebugFlags)
declare function g_type_name (byval type as GType) as zstring ptr
declare function g_type_qname (byval type as GType) as GQuark
declare function g_type_from_name (byval name as zstring ptr) as GType
declare function g_type_parent (byval type as GType) as GType
declare function g_type_depth (byval type as GType) as guint
declare function g_type_next_base (byval leaf_type as GType, byval root_type as GType) as GType
declare function g_type_is_a (byval type as GType, byval is_a_type as GType) as gboolean
declare function g_type_class_ref (byval type as GType) as gpointer
declare function g_type_class_peek (byval type as GType) as gpointer
declare function g_type_class_peek_static (byval type as GType) as gpointer
declare sub g_type_class_unref (byval g_class as gpointer)
declare function g_type_class_peek_parent (byval g_class as gpointer) as gpointer
declare function g_type_interface_peek (byval instance_class as gpointer, byval iface_type as GType) as gpointer
declare function g_type_interface_peek_parent (byval g_iface as gpointer) as gpointer
declare function g_type_default_interface_ref (byval g_type as GType) as gpointer
declare function g_type_default_interface_peek (byval g_type as GType) as gpointer
declare sub g_type_default_interface_unref (byval g_iface as gpointer)
declare function g_type_children (byval type as GType, byval n_children as guint ptr) as GType ptr
declare function g_type_interfaces (byval type as GType, byval n_interfaces as guint ptr) as GType ptr
declare sub g_type_set_qdata (byval type as GType, byval quark as GQuark, byval data as gpointer)
declare function g_type_get_qdata (byval type as GType, byval quark as GQuark) as gpointer
declare sub g_type_query (byval type as GType, byval query as GTypeQuery ptr)

type GBaseInitFunc as sub cdecl(byval as gpointer)
type GBaseFinalizeFunc as sub cdecl(byval as gpointer)
type GClassInitFunc as sub cdecl(byval as gpointer, byval as gpointer)
type GClassFinalizeFunc as sub cdecl(byval as gpointer, byval as gpointer)
type GInstanceInitFunc as sub cdecl(byval as GTypeInstance ptr, byval as gpointer)
type GInterfaceInitFunc as sub cdecl(byval as gpointer, byval as gpointer)
type GInterfaceFinalizeFunc as sub cdecl(byval as gpointer, byval as gpointer)
type GTypeClassCacheFunc as function cdecl(byval as gpointer, byval as GTypeClass ptr) as gboolean
type GTypeInterfaceCheckFunc as sub cdecl(byval as gpointer, byval as gpointer)

enum GTypeFundamentalFlags
	G_TYPE_FLAG_CLASSED = (1 shl 0)
	G_TYPE_FLAG_INSTANTIATABLE = (1 shl 1)
	G_TYPE_FLAG_DERIVABLE = (1 shl 2)
	G_TYPE_FLAG_DEEP_DERIVABLE = (1 shl 3)
end enum


enum GTypeFlags
	G_TYPE_FLAG_ABSTRACT = (1 shl 4)
	G_TYPE_FLAG_VALUE_ABSTRACT = (1 shl 5)
end enum


type _GTypeInfo
	class_size as guint16
	base_init as GBaseInitFunc
	base_finalize as GBaseFinalizeFunc
	class_init as GClassInitFunc
	class_finalize as GClassFinalizeFunc
	class_data as gconstpointer
	instance_size as guint16
	n_preallocs as guint16
	instance_init as GInstanceInitFunc
	value_table as GTypeValueTable ptr
end type

type _GTypeFundamentalInfo
	type_flags as GTypeFundamentalFlags
end type

type _GInterfaceInfo
	interface_init as GInterfaceInitFunc
	interface_finalize as GInterfaceFinalizeFunc
	interface_data as gpointer
end type

type _GTypeValueTable
	value_init as sub cdecl(byval as GValue ptr)
	value_free as sub cdecl(byval as GValue ptr)
	value_copy as sub cdecl(byval as GValue ptr, byval as GValue ptr)
	value_peek_pointer as function cdecl(byval as GValue ptr) as gpointer
	collect_format as zstring ptr
	collect_value as function cdecl(byval as GValue ptr, byval as guint, byval as GTypeCValue ptr, byval as guint) as gchar
	lcopy_format as zstring ptr
	lcopy_value as function cdecl(byval as GValue ptr, byval as guint, byval as GTypeCValue ptr, byval as guint) as gchar
end type

declare function g_type_register_static (byval parent_type as GType, byval type_name as zstring ptr, byval info as GTypeInfo ptr, byval flags as GTypeFlags) as GType
declare function g_type_register_dynamic (byval parent_type as GType, byval type_name as zstring ptr, byval plugin as GTypePlugin ptr, byval flags as GTypeFlags) as GType
declare function g_type_register_fundamental (byval type_id as GType, byval type_name as zstring ptr, byval info as GTypeInfo ptr, byval finfo as GTypeFundamentalInfo ptr, byval flags as GTypeFlags) as GType
declare sub g_type_add_interface_static (byval instance_type as GType, byval interface_type as GType, byval info as GInterfaceInfo ptr)
declare sub g_type_add_interface_dynamic (byval instance_type as GType, byval interface_type as GType, byval plugin as GTypePlugin ptr)
declare sub g_type_interface_add_prerequisite (byval interface_type as GType, byval prerequisite_type as GType)
declare function g_type_interface_prerequisites (byval interface_type as GType, byval n_prerequisites as guint ptr) as GType ptr
declare sub g_type_class_add_private (byval g_class as gpointer, byval private_size as gsize)
declare function g_type_instance_get_private_ alias "g_type_instance_get_private" (byval instance as GTypeInstance ptr, byval private_type as GType) as gpointer
declare function g_type_get_plugin (byval type as GType) as GTypePlugin ptr
declare function g_type_interface_get_plugin (byval instance_type as GType, byval interface_type as GType) as GTypePlugin ptr
declare function g_type_fundamental_next () as GType
declare function g_type_fundamental_ alias "g_type_fundamental" (byval type_id as GType) as GType
declare function g_type_create_instance (byval type as GType) as GTypeInstance ptr
declare sub g_type_free_instance (byval instance as GTypeInstance ptr)
declare sub g_type_add_class_cache_func (byval cache_data as gpointer, byval cache_func as GTypeClassCacheFunc)
declare sub g_type_remove_class_cache_func (byval cache_data as gpointer, byval cache_func as GTypeClassCacheFunc)
declare sub g_type_class_unref_uncached (byval g_class as gpointer)
declare sub g_type_add_interface_check (byval check_data as gpointer, byval check_func as GTypeInterfaceCheckFunc)
declare sub g_type_remove_interface_check (byval check_data as gpointer, byval check_func as GTypeInterfaceCheckFunc)
declare function g_type_value_table_peek (byval type as GType) as GTypeValueTable ptr
declare function g_type_check_instance_ alias "g_type_check_instance" (byval instance as GTypeInstance ptr) as gboolean
declare function g_type_check_instance_cast_ alias "g_type_check_instance_cast" (byval instance as GTypeInstance ptr, byval iface_type as GType) as GTypeInstance ptr
declare function g_type_check_instance_is_a (byval instance as GTypeInstance ptr, byval iface_type as GType) as gboolean
declare function g_type_check_class_cast_ alias "g_type_check_class_cast" (byval g_class as GTypeClass ptr, byval is_a_type as GType) as GTypeClass ptr
declare function g_type_check_class_is_a (byval g_class as GTypeClass ptr, byval is_a_type as GType) as gboolean
declare function g_type_check_is_value_type (byval type as GType) as gboolean
declare function g_type_check_value_ alias "g_type_check_value" (byval value as GValue ptr) as gboolean
declare function g_type_check_value_holds (byval value as GValue ptr, byval type as GType) as gboolean
declare function g_type_test_flags (byval type as GType, byval flags as guint) as gboolean
declare function g_type_name_from_instance (byval instance as GTypeInstance ptr) as zstring ptr
declare function g_type_name_from_class (byval g_class as GTypeClass ptr) as zstring ptr
declare sub g_value_c_init ()
declare sub g_value_types_init ()
declare sub g_enum_types_init ()
declare sub g_param_type_init ()
declare sub g_boxed_type_init ()
declare sub g_object_type_init ()
declare sub g_param_spec_types_init ()
declare sub g_value_transforms_init ()
declare sub g_signal_init ()

#define G_DEFINE_TYPE(TN, t_n, T_P) G_DEFINE_TYPE_EXTENDED (TN, t_n, T_P, 0, { 0 })
#define G_DEFINE_TYPE_WITH_CODE(TN, t_n, T_P, _C_) G_DEFINE_TYPE_EXTENDED (TN, t_n, T_P, 0, _C_)
#define G_DEFINE_ABSTRACT_TYPE(TN, t_n, T_P) G_DEFINE_TYPE_EXTENDED (TN, t_n, T_P, G_TYPE_FLAG_ABSTRACT, {})
#define G_DEFINE_ABSTRACT_TYPE_WITH_CODE(TN, t_n, T_P, _C_) G_DEFINE_TYPE_EXTENDED (TN, t_n, T_P, G_TYPE_FLAG_ABSTRACT, _C_)

#ifndef G_DISABLE_CAST_CHECKS
#  define _G_TYPE_CIC(ip, gt, ct) cptr(ct ptr, g_type_check_instance_cast_( cptr(GTypeInstance ptr, ip), gt ))
#  define _G_TYPE_CCC(cp, gt, ct) cptr(ct ptr, g_type_check_class_cast_( cptr(GTypeClass ptr, cp), gt ))
#else
#  define _G_TYPE_CIC(ip, gt, ct) cptr(ct ptr, ip)
#  define _G_TYPE_CCC(cp, gt, ct) cptr(ct ptr, cp)
#endif

#define _G_TYPE_CHI(ip)	g_type_check_instance_( cptr(GTypeInstance ptr, ip) )
#define _G_TYPE_CHV(vl)	g_type_check_value_( cptr(GValue ptr, vl) )
#define _G_TYPE_IGC(ip, gt, ct) cptr(ct ptr, cptr(GTypeInstance ptr, ip)->g_class )
#define _G_TYPE_IGI(ip, gt, ct) cptr(ct ptr, g_type_interface_peek( cptr(GTypeInstance ptr, ip)->g_class, gt ))

#define G_TYPE_CHECK_INSTANCE(instance)	_G_TYPE_CHI( cptr(GTypeInstance ptr, instance) )
#define G_TYPE_CHECK_INSTANCE_CAST(instance, g_type, c_type) _G_TYPE_CIC( instance, g_type, c_type )
#define G_TYPE_CHECK_INSTANCE_TYPE(instance, g_type) _G_TYPE_CIT( instance, g_type )
#define G_TYPE_INSTANCE_GET_CLASS(instance, g_type, c_type) _G_TYPE_IGC( instance, g_type, c_type )
#define G_TYPE_INSTANCE_GET_INTERFACE(instance, g_type, c_type) _G_TYPE_IGI( instance, g_type, c_type )
#define G_TYPE_CHECK_CLASS_CAST(g_class, g_type, c_type) _G_TYPE_CCC( g_class, g_type, c_type )
#define G_TYPE_CHECK_CLASS_TYPE(g_class, g_type) _G_TYPE_CCT( g_class, g_type )
#define G_TYPE_CHECK_VALUE(value) _G_TYPE_CHV( value )
#define G_TYPE_CHECK_VALUE_TYPE(value, g_type) _G_TYPE_CVH( value, g_type )
#define G_TYPE_FROM_INSTANCE(instance) G_TYPE_FROM_CLASS( cptr(GTypeInstance ptr, instance)->g_class )
#define G_TYPE_FROM_CLASS(g_class) cptr(GTypeClass ptr, g_class)->g_type
#define G_TYPE_FROM_INTERFACE(g_iface) cptr(GTypeInterface ptr, g_iface)->g_type
#define G_TYPE_INSTANCE_GET_PRIVATE(instance, g_type, c_type) cptr(c_type ptr, g_type_instance_get_private(cptr(GTypeInstance ptr,instance), (g_type)))

#endif
