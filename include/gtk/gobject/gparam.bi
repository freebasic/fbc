''
''
'' gparam -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gparam_bi__
#define __gparam_bi__

#include once "gvalue.bi"

#define G_TYPE_IS_PARAM(_type) (G_TYPE_FUNDAMENTAL (_type) == G_TYPE_PARAM)
#define G_PARAM_SPEC(pspec) G_TYPE_CHECK_INSTANCE_CAST ((pspec), G_TYPE_PARAM, GParamSpec)
#define G_IS_PARAM_SPEC(pspec) G_TYPE_CHECK_INSTANCE_TYPE ((pspec), G_TYPE_PARAM)
#define G_PARAM_SPEC_CLASS(pclass) G_TYPE_CHECK_CLASS_CAST ((pclass), G_TYPE_PARAM, GParamSpecClass)
#define G_IS_PARAM_SPEC_CLASS(pclass) G_TYPE_CHECK_CLASS_TYPE ((pclass), G_TYPE_PARAM)
#define G_PARAM_SPEC_GET_CLASS(pspec) G_TYPE_INSTANCE_GET_CLASS ((pspec), G_TYPE_PARAM, GParamSpecClass)

#define G_PARAM_SPEC_TYPE(pspec) G_TYPE_FROM_INSTANCE (pspec)
#define G_PARAM_SPEC_TYPE_NAME(pspec) g_type_name (G_PARAM_SPEC_TYPE (pspec))
#define	G_PARAM_SPEC_VALUE_TYPE(pspec) (G_PARAM_SPEC (pspec)->value_type)
#define G_VALUE_HOLDS_PARAM(value) G_TYPE_CHECK_VALUE_TYPE ((value), G_TYPE_PARAM)

enum GParamFlags
	G_PARAM_READABLE = 1 shl 0
	G_PARAM_WRITABLE = 1 shl 1
	G_PARAM_CONSTRUCT = 1 shl 2
	G_PARAM_CONSTRUCT_ONLY = 1 shl 3
	G_PARAM_LAX_VALIDATION = 1 shl 4
	G_PARAM_PRIVATE = 1 shl 5
end enum


#define G_PARAM_MASK (&h000000ff)
#define G_PARAM_USER_SHIFT (8)

type GParamSpec as _GParamSpec
type GParamSpecClass as _GParamSpecClass
type GParameter as _GParameter
type GParamSpecPool as _GParamSpecPool

type _GParamSpec
	g_type_instance as GTypeInstance
	name as zstring ptr
	flags as GParamFlags
	value_type as GType
	owner_type as GType
	_nick as zstring ptr
	_blurb as zstring ptr
	qdata as GData ptr
	ref_count as guint
	param_id as guint
end type

type _GParamSpecClass
	g_type_class as GTypeClass
	value_type as GType
	finalize as sub cdecl(byval as GParamSpec ptr)
	value_set_default as sub cdecl(byval as GParamSpec ptr, byval as GValue ptr)
	value_validate as function cdecl(byval as GParamSpec ptr, byval as GValue ptr) as gboolean
	values_cmp as function cdecl(byval as GParamSpec ptr, byval as GValue ptr, byval as GValue ptr) as gint
	dummy(0 to 4-1) as gpointer
end type

type _GParameter
	name as zstring ptr
	value as GValue
end type

declare function g_param_spec_ref (byval pspec as GParamSpec ptr) as GParamSpec ptr
declare sub g_param_spec_unref (byval pspec as GParamSpec ptr)
declare sub g_param_spec_sink (byval pspec as GParamSpec ptr)
declare function g_param_spec_get_qdata (byval pspec as GParamSpec ptr, byval quark as GQuark) as gpointer
declare sub g_param_spec_set_qdata (byval pspec as GParamSpec ptr, byval quark as GQuark, byval data as gpointer)
declare sub g_param_spec_set_qdata_full (byval pspec as GParamSpec ptr, byval quark as GQuark, byval data as gpointer, byval destroy as GDestroyNotify)
declare function g_param_spec_steal_qdata (byval pspec as GParamSpec ptr, byval quark as GQuark) as gpointer
declare function g_param_spec_get_redirect_target (byval pspec as GParamSpec ptr) as GParamSpec ptr
declare sub g_param_value_set_default (byval pspec as GParamSpec ptr, byval value as GValue ptr)
declare function g_param_value_defaults (byval pspec as GParamSpec ptr, byval value as GValue ptr) as gboolean
declare function g_param_value_validate (byval pspec as GParamSpec ptr, byval value as GValue ptr) as gboolean
declare function g_param_value_convert (byval pspec as GParamSpec ptr, byval src_value as GValue ptr, byval dest_value as GValue ptr, byval strict_validation as gboolean) as gboolean
declare function g_param_values_cmp (byval pspec as GParamSpec ptr, byval value1 as GValue ptr, byval value2 as GValue ptr) as gint
declare function g_param_spec_get_name (byval pspec as GParamSpec ptr) as zstring ptr
declare function g_param_spec_get_nick (byval pspec as GParamSpec ptr) as zstring ptr
declare function g_param_spec_get_blurb (byval pspec as GParamSpec ptr) as zstring ptr
declare sub g_value_set_param (byval value as GValue ptr, byval param as GParamSpec ptr)
declare function g_value_get_param (byval value as GValue ptr) as GParamSpec ptr
declare function g_value_dup_param (byval value as GValue ptr) as GParamSpec ptr
declare sub g_value_take_param (byval value as GValue ptr, byval param as GParamSpec ptr)
declare sub g_value_set_param_take_ownership (byval value as GValue ptr, byval param as GParamSpec ptr)

type GParamSpecTypeInfo as _GParamSpecTypeInfo

type _GParamSpecTypeInfo
	instance_size as guint16
	n_preallocs as guint16
	instance_init as sub cdecl(byval as GParamSpec ptr)
	value_type as GType
	finalize as sub cdecl(byval as GParamSpec ptr)
	value_set_default as sub cdecl(byval as GParamSpec ptr, byval as GValue ptr)
	value_validate as function cdecl(byval as GParamSpec ptr, byval as GValue ptr) as gboolean
	values_cmp as function cdecl(byval as GParamSpec ptr, byval as GValue ptr, byval as GValue ptr) as gint
end type

declare function g_param_type_register_static (byval name as zstring ptr, byval pspec_info as GParamSpecTypeInfo ptr) as GType
declare function _g_param_type_register_static_constant (byval name as zstring ptr, byval pspec_info as GParamSpecTypeInfo ptr, byval opt_type as GType) as GType
declare function g_param_spec_internal (byval param_type as GType, byval name as zstring ptr, byval nick as zstring ptr, byval blurb as zstring ptr, byval flags as GParamFlags) as gpointer
declare function g_param_spec_pool_new (byval type_prefixing as gboolean) as GParamSpecPool ptr
declare sub g_param_spec_pool_insert (byval pool as GParamSpecPool ptr, byval pspec as GParamSpec ptr, byval owner_type as GType)
declare sub g_param_spec_pool_remove (byval pool as GParamSpecPool ptr, byval pspec as GParamSpec ptr)
declare function g_param_spec_pool_lookup (byval pool as GParamSpecPool ptr, byval param_name as zstring ptr, byval owner_type as GType, byval walk_ancestors as gboolean) as GParamSpec ptr
declare function g_param_spec_pool_list_owned (byval pool as GParamSpecPool ptr, byval owner_type as GType) as GList ptr
declare function g_param_spec_pool_list (byval pool as GParamSpecPool ptr, byval owner_type as GType, byval n_pspecs_p as guint ptr) as GParamSpec ptr ptr

#endif
