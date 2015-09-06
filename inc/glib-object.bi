'' FreeBASIC binding for glib-2.44.1
''
'' based on the C header files:
''   GObject - GLib Type, Object, Parameter and Signal Library
''   Copyright (C) 1998, 1999, 2000 Tim Janik and Red Hat, Inc.
''
''   This library is free software; you can redistribute it and/or
''   modify it under the terms of the GNU Lesser General Public
''   License as published by the Free Software Foundation; either
''   version 2 of the License, or (at your option) any later version.
''
''   This library is distributed in the hope that it will be useful,
''   but WITHOUT ANY WARRANTY; without even the implied warranty of
''   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the GNU
''   Lesser General Public License for more details.
''
''   You should have received a copy of the GNU Lesser General
''   Public License along with this library; if not, see <http://www.gnu.org/licenses/>.
''
'' translated to FreeBASIC by:
''   (C) 2011, 2012 Thomas[ dot ]Freiherr[ at ]gmx[ dot ]net
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "gobject-2.0"

#include once "crt/long.bi"
#include once "glib.bi"

'' The following symbols have been renamed:
''     procedure g_type_instance_get_private => g_type_instance_get_private_
''     procedure g_type_class_get_private => g_type_class_get_private_
''     procedure g_type_fundamental => g_type_fundamental_
''     procedure g_type_check_instance => g_type_check_instance_
''     procedure g_type_check_instance_cast => g_type_check_instance_cast_
''     procedure g_type_check_class_cast => g_type_check_class_cast_
''     procedure g_type_check_value => g_type_check_value_
''     procedure g_value_init => g_value_init_
''     procedure g_clear_object => g_clear_object_
''     procedure g_set_object => g_set_object_
''     procedure g_param_spec_char => g_param_spec_char_
''     procedure g_param_spec_uchar => g_param_spec_uchar_
''     procedure g_param_spec_boolean => g_param_spec_boolean_
''     procedure g_param_spec_int => g_param_spec_int_
''     procedure g_param_spec_uint => g_param_spec_uint_
''     procedure g_param_spec_long => g_param_spec_long_
''     procedure g_param_spec_ulong => g_param_spec_ulong_
''     procedure g_param_spec_int64 => g_param_spec_int64_
''     procedure g_param_spec_uint64 => g_param_spec_uint64_
''     procedure g_param_spec_unichar => g_param_spec_unichar_
''     procedure g_param_spec_enum => g_param_spec_enum_
''     procedure g_param_spec_flags => g_param_spec_flags_
''     procedure g_param_spec_float => g_param_spec_float_
''     procedure g_param_spec_double => g_param_spec_double_
''     procedure g_param_spec_string => g_param_spec_string_
''     procedure g_param_spec_param => g_param_spec_param_
''     procedure g_param_spec_boxed => g_param_spec_boxed_
''     procedure g_param_spec_pointer => g_param_spec_pointer_
''     procedure g_param_spec_value_array => g_param_spec_value_array_
''     procedure g_param_spec_object => g_param_spec_object_
''     procedure g_param_spec_override => g_param_spec_override_
''     procedure g_param_spec_gtype => g_param_spec_gtype_
''     procedure g_param_spec_variant => g_param_spec_variant_

#ifdef __FB_WIN32__
#pragma push(msbitfields)
#endif

extern "C"

#define __GLIB_GOBJECT_H__
#define __GLIB_GOBJECT_H_INSIDE__
#define __G_BINDING_H__
#define __G_OBJECT_H__
#define __G_TYPE_H__
#define G_TYPE_FUNDAMENTAL(type) g_type_fundamental_(type)
#define G_TYPE_FUNDAMENTAL_MAX (255 shl G_TYPE_FUNDAMENTAL_SHIFT)
#define G_TYPE_INVALID G_TYPE_MAKE_FUNDAMENTAL(0)
#define G_TYPE_NONE G_TYPE_MAKE_FUNDAMENTAL(1)
#define G_TYPE_INTERFACE G_TYPE_MAKE_FUNDAMENTAL(2)
#define G_TYPE_CHAR G_TYPE_MAKE_FUNDAMENTAL(3)
#define G_TYPE_UCHAR G_TYPE_MAKE_FUNDAMENTAL(4)
#define G_TYPE_BOOLEAN G_TYPE_MAKE_FUNDAMENTAL(5)
#define G_TYPE_INT G_TYPE_MAKE_FUNDAMENTAL(6)
#define G_TYPE_UINT G_TYPE_MAKE_FUNDAMENTAL(7)
#define G_TYPE_LONG G_TYPE_MAKE_FUNDAMENTAL(8)
#define G_TYPE_ULONG G_TYPE_MAKE_FUNDAMENTAL(9)
#define G_TYPE_INT64 G_TYPE_MAKE_FUNDAMENTAL(10)
#define G_TYPE_UINT64 G_TYPE_MAKE_FUNDAMENTAL(11)
#define G_TYPE_ENUM G_TYPE_MAKE_FUNDAMENTAL(12)
#define G_TYPE_FLAGS G_TYPE_MAKE_FUNDAMENTAL(13)
#define G_TYPE_FLOAT G_TYPE_MAKE_FUNDAMENTAL(14)
#define G_TYPE_DOUBLE G_TYPE_MAKE_FUNDAMENTAL(15)
#define G_TYPE_STRING G_TYPE_MAKE_FUNDAMENTAL(16)
#define G_TYPE_POINTER G_TYPE_MAKE_FUNDAMENTAL(17)
#define G_TYPE_BOXED G_TYPE_MAKE_FUNDAMENTAL(18)
#define G_TYPE_PARAM G_TYPE_MAKE_FUNDAMENTAL(19)
#define G_TYPE_OBJECT G_TYPE_MAKE_FUNDAMENTAL(20)
#define G_TYPE_VARIANT G_TYPE_MAKE_FUNDAMENTAL(21)
const G_TYPE_FUNDAMENTAL_SHIFT = 2
#define G_TYPE_MAKE_FUNDAMENTAL(x) cast(GType, (x) shl G_TYPE_FUNDAMENTAL_SHIFT)
const G_TYPE_RESERVED_GLIB_FIRST = 22
const G_TYPE_RESERVED_GLIB_LAST = 31
const G_TYPE_RESERVED_BSE_FIRST = 32
const G_TYPE_RESERVED_BSE_LAST = 48
const G_TYPE_RESERVED_USER_FIRST = 49
#define G_TYPE_IS_FUNDAMENTAL(type) ((type) <= G_TYPE_FUNDAMENTAL_MAX)
#define G_TYPE_IS_DERIVED(type) ((type) > G_TYPE_FUNDAMENTAL_MAX)
#define G_TYPE_IS_INTERFACE(type) (G_TYPE_FUNDAMENTAL(type) = G_TYPE_INTERFACE)
#define G_TYPE_IS_CLASSED(type) g_type_test_flags((type), G_TYPE_FLAG_CLASSED)
#define G_TYPE_IS_INSTANTIATABLE(type) g_type_test_flags((type), G_TYPE_FLAG_INSTANTIATABLE)
#define G_TYPE_IS_DERIVABLE(type) g_type_test_flags((type), G_TYPE_FLAG_DERIVABLE)
#define G_TYPE_IS_DEEP_DERIVABLE(type) g_type_test_flags((type), G_TYPE_FLAG_DEEP_DERIVABLE)
#define G_TYPE_IS_ABSTRACT(type) g_type_test_flags((type), G_TYPE_FLAG_ABSTRACT)
#define G_TYPE_IS_VALUE_ABSTRACT(type) g_type_test_flags((type), G_TYPE_FLAG_VALUE_ABSTRACT)
#define G_TYPE_IS_VALUE_TYPE(type) g_type_check_is_value_type(type)
#define G_TYPE_HAS_VALUE_TABLE(type) (g_type_value_table_peek(type) <> NULL)

type GType as gsize
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
	as GType type
	type_name as const gchar ptr
	class_size as guint
	instance_size as guint
end type

#define G_TYPE_CHECK_INSTANCE(instance) _G_TYPE_CHI(cptr(GTypeInstance ptr, (instance)))
#define G_TYPE_CHECK_INSTANCE_CAST(instance, g_type, c_type) _G_TYPE_CIC((instance), (g_type), c_type)
#define G_TYPE_CHECK_INSTANCE_TYPE(instance, g_type) _G_TYPE_CIT((instance), (g_type))
#define G_TYPE_CHECK_INSTANCE_FUNDAMENTAL_TYPE(instance, g_type) _G_TYPE_CIFT((instance), (g_type))
#define G_TYPE_INSTANCE_GET_CLASS(instance, g_type, c_type) _G_TYPE_IGC((instance), (g_type), c_type)
#define G_TYPE_INSTANCE_GET_INTERFACE(instance, g_type, c_type) _G_TYPE_IGI((instance), (g_type), c_type)
#define G_TYPE_CHECK_CLASS_CAST(g_class, g_type, c_type) _G_TYPE_CCC((g_class), (g_type), c_type)
#define G_TYPE_CHECK_CLASS_TYPE(g_class, g_type) _G_TYPE_CCT((g_class), (g_type))
#define G_TYPE_CHECK_VALUE(value) _G_TYPE_CHV((value))
#define G_TYPE_CHECK_VALUE_TYPE(value, g_type) _G_TYPE_CVH((value), (g_type))
#define G_TYPE_FROM_INSTANCE(instance) G_TYPE_FROM_CLASS(cptr(GTypeInstance ptr, (instance))->g_class)
#define G_TYPE_FROM_CLASS(g_class) cptr(GTypeClass ptr, (g_class))->g_type
#define G_TYPE_FROM_INTERFACE(g_iface) cptr(GTypeInterface ptr, (g_iface))->g_type
#define G_TYPE_INSTANCE_GET_PRIVATE(instance, g_type, c_type) cptr(c_type ptr, g_type_instance_get_private_(cptr(GTypeInstance ptr, (instance)), (g_type)))
#define G_TYPE_CLASS_GET_PRIVATE(klass, g_type, c_type) cptr(c_type ptr, g_type_class_get_private_(cptr(GTypeClass ptr, (klass)), (g_type)))

type GTypeDebugFlags as long
enum
	G_TYPE_DEBUG_NONE = 0
	G_TYPE_DEBUG_OBJECTS = 1 shl 0
	G_TYPE_DEBUG_SIGNALS = 1 shl 1
	G_TYPE_DEBUG_INSTANCE_COUNT = 1 shl 2
	G_TYPE_DEBUG_MASK = &h07
end enum

declare sub g_type_init()
declare sub g_type_init_with_debug_flags(byval debug_flags as GTypeDebugFlags)
declare function g_type_name(byval type as GType) as const gchar ptr
declare function g_type_qname(byval type as GType) as GQuark
declare function g_type_from_name(byval name as const gchar ptr) as GType
declare function g_type_parent(byval type as GType) as GType
declare function g_type_depth(byval type as GType) as guint
declare function g_type_next_base(byval leaf_type as GType, byval root_type as GType) as GType
declare function g_type_is_a(byval type as GType, byval is_a_type as GType) as gboolean
declare function g_type_class_ref(byval type as GType) as gpointer
declare function g_type_class_peek(byval type as GType) as gpointer
declare function g_type_class_peek_static(byval type as GType) as gpointer
declare sub g_type_class_unref(byval g_class as gpointer)
declare function g_type_class_peek_parent(byval g_class as gpointer) as gpointer
declare function g_type_interface_peek(byval instance_class as gpointer, byval iface_type as GType) as gpointer
declare function g_type_interface_peek_parent(byval g_iface as gpointer) as gpointer
declare function g_type_default_interface_ref(byval g_type as GType) as gpointer
declare function g_type_default_interface_peek(byval g_type as GType) as gpointer
declare sub g_type_default_interface_unref(byval g_iface as gpointer)
declare function g_type_children(byval type as GType, byval n_children as guint ptr) as GType ptr
declare function g_type_interfaces(byval type as GType, byval n_interfaces as guint ptr) as GType ptr
declare sub g_type_set_qdata(byval type as GType, byval quark as GQuark, byval data as gpointer)
declare function g_type_get_qdata(byval type as GType, byval quark as GQuark) as gpointer
declare sub g_type_query(byval type as GType, byval query as GTypeQuery ptr)
declare function g_type_get_instance_count(byval type as GType) as long

type GBaseInitFunc as sub(byval g_class as gpointer)
type GBaseFinalizeFunc as sub(byval g_class as gpointer)
type GClassInitFunc as sub(byval g_class as gpointer, byval class_data as gpointer)
type GClassFinalizeFunc as sub(byval g_class as gpointer, byval class_data as gpointer)
type GInstanceInitFunc as sub(byval instance as GTypeInstance ptr, byval g_class as gpointer)
type GInterfaceInitFunc as sub(byval g_iface as gpointer, byval iface_data as gpointer)
type GInterfaceFinalizeFunc as sub(byval g_iface as gpointer, byval iface_data as gpointer)
type GTypeClassCacheFunc as function(byval cache_data as gpointer, byval g_class as GTypeClass ptr) as gboolean
type GTypeInterfaceCheckFunc as sub(byval check_data as gpointer, byval g_iface as gpointer)

type GTypeFundamentalFlags as long
enum
	G_TYPE_FLAG_CLASSED = 1 shl 0
	G_TYPE_FLAG_INSTANTIATABLE = 1 shl 1
	G_TYPE_FLAG_DERIVABLE = 1 shl 2
	G_TYPE_FLAG_DEEP_DERIVABLE = 1 shl 3
end enum

type GTypeFlags as long
enum
	G_TYPE_FLAG_ABSTRACT = 1 shl 4
	G_TYPE_FLAG_VALUE_ABSTRACT = 1 shl 5
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
	value_table as const GTypeValueTable ptr
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
	value_init as sub(byval value as GValue ptr)
	value_free as sub(byval value as GValue ptr)
	value_copy as sub(byval src_value as const GValue ptr, byval dest_value as GValue ptr)
	value_peek_pointer as function(byval value as const GValue ptr) as gpointer
	collect_format as const gchar ptr
	collect_value as function(byval value as GValue ptr, byval n_collect_values as guint, byval collect_values as GTypeCValue ptr, byval collect_flags as guint) as gchar ptr
	lcopy_format as const gchar ptr
	lcopy_value as function(byval value as const GValue ptr, byval n_collect_values as guint, byval collect_values as GTypeCValue ptr, byval collect_flags as guint) as gchar ptr
end type

declare function g_type_register_static(byval parent_type as GType, byval type_name as const gchar ptr, byval info as const GTypeInfo ptr, byval flags as GTypeFlags) as GType
declare function g_type_register_static_simple(byval parent_type as GType, byval type_name as const gchar ptr, byval class_size as guint, byval class_init as GClassInitFunc, byval instance_size as guint, byval instance_init as GInstanceInitFunc, byval flags as GTypeFlags) as GType
declare function g_type_register_dynamic(byval parent_type as GType, byval type_name as const gchar ptr, byval plugin as GTypePlugin ptr, byval flags as GTypeFlags) as GType
declare function g_type_register_fundamental(byval type_id as GType, byval type_name as const gchar ptr, byval info as const GTypeInfo ptr, byval finfo as const GTypeFundamentalInfo ptr, byval flags as GTypeFlags) as GType
declare sub g_type_add_interface_static(byval instance_type as GType, byval interface_type as GType, byval info as const GInterfaceInfo ptr)
declare sub g_type_add_interface_dynamic(byval instance_type as GType, byval interface_type as GType, byval plugin as GTypePlugin ptr)
declare sub g_type_interface_add_prerequisite(byval interface_type as GType, byval prerequisite_type as GType)
declare function g_type_interface_prerequisites(byval interface_type as GType, byval n_prerequisites as guint ptr) as GType ptr
declare sub g_type_class_add_private(byval g_class as gpointer, byval private_size as gsize)
declare function g_type_add_instance_private(byval class_type as GType, byval private_size as gsize) as gint
declare function g_type_instance_get_private_ alias "g_type_instance_get_private"(byval instance as GTypeInstance ptr, byval private_type as GType) as gpointer
declare sub g_type_class_adjust_private_offset(byval g_class as gpointer, byval private_size_or_offset as gint ptr)
declare sub g_type_add_class_private(byval class_type as GType, byval private_size as gsize)
declare function g_type_class_get_private_ alias "g_type_class_get_private"(byval klass as GTypeClass ptr, byval private_type as GType) as gpointer
declare function g_type_class_get_instance_private_offset(byval g_class as gpointer) as gint
declare sub g_type_ensure(byval type as GType)
declare function g_type_get_type_registration_serial() as guint
#macro G_DECLARE_FINAL_TYPE(ModuleObjName, module_obj_name, MODULE, OBJ_NAME, ParentName)
	extern "C"
		declare function module_obj_name##_get_type() as GType
		type ModuleObjName as _##ModuleObjName
		type ModuleObjName##Class
			parent_class as ParentName##Class
		end type
		_GLIB_DEFINE_AUTOPTR_CHAINUP(ModuleObjName, ParentName)
		#define MODULE##_##OBJ_NAME(ptr_) cptr(ModuleObjName ptr, G_TYPE_CHECK_INSTANCE_CAST(ptr_, module_obj_name##_get_type(), ModuleObjName))
		#define MODULE##_IS_##OBJ_NAME(ptr_) cast(gboolean, G_TYPE_CHECK_INSTANCE_TYPE(ptr_, module_obj_name##_get_type()))
	end extern
#endmacro
#macro G_DECLARE_DERIVABLE_TYPE(ModuleObjName, module_obj_name, MODULE, OBJ_NAME, ParentName)
	extern "C"
		declare function module_obj_name##_get_type() as GType
		type ModuleObjName as _##ModuleObjName
		type ModuleObjName##Class as _##ModuleObjName##Class
		type _##ModuleObjName
			parent_instance as ParentName
		end type
		_GLIB_DEFINE_AUTOPTR_CHAINUP(ModuleObjName, ParentName)
		#define MODULE##_##OBJ_NAME(ptr_) cptr(ModuleObjName ptr, G_TYPE_CHECK_INSTANCE_CAST(ptr_, module_obj_name##_get_type(), ModuleObjName))
		#define MODULE##_##OBJ_NAME##_CLASS(ptr_) cptr(ModuleObjName##Class ptr, G_TYPE_CHECK_CLASS_CAST(ptr_, module_obj_name##_get_type(), ModuleObjName##Class))
		#define MODULE##_IS_##OBJ_NAME(ptr_) cast(gboolean, G_TYPE_CHECK_INSTANCE_TYPE(ptr_, module_obj_name##_get_type()))
		#define MODULE##_IS_##OBJ_NAME##_CLASS(ptr_) cast(gboolean, G_TYPE_CHECK_CLASS_TYPE(ptr_, module_obj_name##_get_type()))
		#define MODULE##_##OBJ_NAME##_GET_CLASS(ptr_) cptr(ModuleObjName##Class ptr, G_TYPE_INSTANCE_GET_CLASS(ptr_, module_obj_name##_get_type(), ModuleObjName##Class))
	end extern
#endmacro
#macro G_DECLARE_INTERFACE(ModuleObjName, module_obj_name, MODULE, OBJ_NAME, PrerequisiteName)
	extern "C"
		declare function module_obj_name##_get_type() as GType
		type ModuleObjName as _##ModuleObjName
		type ModuleObjName##Interface as _##ModuleObjName##Interface
		_GLIB_DEFINE_AUTOPTR_CHAINUP(ModuleObjName, PrerequisiteName)
		#define MODULE##_##OBJ_NAME(ptr_) cptr(ModuleObjName ptr, G_TYPE_CHECK_INSTANCE_CAST(ptr_, module_obj_name##_get_type(), ModuleObjName))
		#define MODULE##_IS_##OBJ_NAME(ptr_) cast(gboolean, G_TYPE_CHECK_INSTANCE_TYPE(ptr_, module_obj_name##_get_type()))
		#define MODULE##_##OBJ_NAME##_GET_IFACE(ptr_) cptr(ModuleObjName##Interface ptr, G_TYPE_INSTANCE_GET_INTERFACE(ptr_, module_obj_name##_get_type(), ModuleObjName##Interface))
	end extern
#endmacro
#define G_DEFINE_TYPE(TN, t_n, T_P) G_DEFINE_TYPE_EXTENDED(TN, t_n, T_P, 0, )
#macro G_DEFINE_TYPE_WITH_CODE(TN, t_n, T_P, _C_)
	_G_DEFINE_TYPE_EXTENDED_BEGIN(TN, t_n, T_P, 0)
	scope
		_C_
	end scope
	_G_DEFINE_TYPE_EXTENDED_END()
#endmacro

#define G_DEFINE_TYPE_WITH_PRIVATE(TN, t_n, T_P) G_DEFINE_TYPE_EXTENDED(TN, t_n, T_P, 0, G_ADD_PRIVATE(TN))
#define G_DEFINE_ABSTRACT_TYPE(TN, t_n, T_P) G_DEFINE_TYPE_EXTENDED(TN, t_n, T_P, G_TYPE_FLAG_ABSTRACT, )
#macro G_DEFINE_ABSTRACT_TYPE_WITH_CODE(TN, t_n, T_P, _C_)
	_G_DEFINE_TYPE_EXTENDED_BEGIN(TN, t_n, T_P, G_TYPE_FLAG_ABSTRACT)
	scope
		_C_
	end scope
	_G_DEFINE_TYPE_EXTENDED_END()
#endmacro
#define G_DEFINE_ABSTRACT_TYPE_WITH_PRIVATE(TN, t_n, T_P) G_DEFINE_TYPE_EXTENDED(TN, t_n, T_P, G_TYPE_FLAG_ABSTRACT, G_ADD_PRIVATE(TN))
#macro G_DEFINE_TYPE_EXTENDED(TN, t_n, T_P, _f_, _C_)
	_G_DEFINE_TYPE_EXTENDED_BEGIN(TN, t_n, T_P, _f_)
	scope
		_C_
	end scope
	_G_DEFINE_TYPE_EXTENDED_END()
#endmacro
#define G_DEFINE_INTERFACE(TN, t_n, T_P) G_DEFINE_INTERFACE_WITH_CODE(TN, t_n, T_P, )
#macro G_DEFINE_INTERFACE_WITH_CODE(TN, t_n, T_P, _C_)
	_G_DEFINE_INTERFACE_EXTENDED_BEGIN(TN, t_n, T_P)
	scope
		_C_
	end scope
	_G_DEFINE_INTERFACE_EXTENDED_END()
#endmacro
#macro G_IMPLEMENT_INTERFACE(TYPE_IFACE, iface_init)
	scope
		dim g_implement_interface_info as const GInterfaceInfo = (cast(GInterfaceInitFunc, iface_init), NULL, NULL)
		g_type_add_interface_static(g_define_type_id, TYPE_IFACE, @g_implement_interface_info)
	end scope
#endmacro
#macro G_ADD_PRIVATE(TypeName)
	scope
		TypeName##_private_offset = g_type_add_instance_private(g_define_type_id, sizeof(TypeName##Private))
	end scope
#endmacro
#define G_PRIVATE_OFFSET(TypeName, field) (TypeName##_private_offset + G_STRUCT_OFFSET(TypeName##Private, field))
#define G_PRIVATE_FIELD_P(TypeName, inst, field_name) G_STRUCT_MEMBER_P(inst, G_PRIVATE_OFFSET(TypeName, field_name))
#define G_PRIVATE_FIELD(TypeName, inst, field_type, field_name) G_STRUCT_MEMBER(field_type, inst, G_PRIVATE_OFFSET(TypeName, field_name))
#macro _G_DEFINE_TYPE_EXTENDED_CLASS_INIT(TypeName, type_name)
	extern "C"
		private sub type_name##_class_intern_init(byval klass as gpointer)
			type_name##_parent_class = g_type_class_peek_parent(klass)
			if TypeName##_private_offset <> 0 then
				g_type_class_adjust_private_offset(klass, @TypeName##_private_offset)
			end if
			type_name##_class_init(cptr(TypeName##Class ptr, klass))
		end sub
	end extern
#endmacro
#macro _G_DEFINE_TYPE_EXTENDED_BEGIN(TypeName, type_name, TYPE_PARENT, flags)
	extern "C"
		declare sub type_name##_init(byval self as TypeName ptr)
		declare sub type_name##_class_init(byval klass as TypeName##Class ptr)
		dim shared as gpointer type_name##_parent_class = NULL
		dim shared as gint TypeName##_private_offset
		_G_DEFINE_TYPE_EXTENDED_CLASS_INIT(TypeName, type_name)
		private function type_name##_get_instance_private(byval self as const TypeName ptr) as gpointer
			return G_STRUCT_MEMBER_P(self, TypeName##_private_offset)
		end function
		function type_name##_get_type() as GType
			static as gsize g_define_type_id__volatile = 0
			if g_once_init_enter(@g_define_type_id__volatile) then
				var g_define_type_id = g_type_register_static_simple( _
					TYPE_PARENT, _
					g_intern_static_string(#TypeName), _
					sizeof(TypeName##Class), _
					cast(GClassInitFunc, @type_name##_class_intern_init), _
					sizeof(TypeName), _
					cast(GInstanceInitFunc, @type_name##_init), _
					cast(GTypeFlags, flags) _
				)
				scope
#endmacro
#macro _G_DEFINE_TYPE_EXTENDED_END()
				end scope
				g_once_init_leave(@g_define_type_id__volatile, g_define_type_id)
			end if
			return g_define_type_id__volatile
		end function
	end extern
#endmacro
#macro _G_DEFINE_INTERFACE_EXTENDED_BEGIN(TypeName, type_name, TYPE_PREREQ)
	extern "C"
		declare sub type_name##_default_init(byval klass as TypeName##Interface ptr)
		function type_name##_get_type() as GType
			static as gsize g_define_type_id__volatile = 0
			if g_once_init_enter(@g_define_type_id__volatile) then
				var g_define_type_id = g_type_register_static_simple( _
					G_TYPE_INTERFACE, _
					g_intern_static_string(#TypeName), _
					sizeof(TypeName##Interface), _
					cast(GClassInitFunc, @type_name##_default_init), _
					0, _
					cast(GInstanceInitFunc, NULL), _
					cast(GTypeFlags, 0) _
				)
				if TYPE_PREREQ then
					g_type_interface_add_prerequisite(g_define_type_id, TYPE_PREREQ)
				end if
				scope
#endmacro
#macro _G_DEFINE_INTERFACE_EXTENDED_END()
				end scope
				g_once_init_leave(@g_define_type_id__volatile, g_define_type_id)
			end if
			return g_define_type_id__volatile
		end function
	end extern
#endmacro
#define G_DEFINE_BOXED_TYPE(TypeName, type_name, copy_func, free_func) G_DEFINE_BOXED_TYPE_WITH_CODE(TypeName, type_name, copy_func, free_func, )
#macro G_DEFINE_BOXED_TYPE_WITH_CODE(TypeName, type_name, copy_func, free_func, _C_)
	_G_DEFINE_BOXED_TYPE_BEGIN(TypeName, type_name, copy_func, free_func)
	scope
		_C_
	end scope
	_G_DEFINE_TYPE_EXTENDED_END()
#endmacro
#macro _G_DEFINE_BOXED_TYPE_BEGIN(TypeName, type_name, copy_func, free_func)
	extern "C"
		function type_name##_get_type() as GType
			static as gsize g_define_type_id__volatile = 0
			if g_once_init_enter(@g_define_type_id__volatile) then
				var g_define_type_id = g_boxed_type_register_static( _
					g_intern_static_string(#TypeName), _
					cast(GBoxedCopyFunc, copy_func), _
					cast(GBoxedFreeFunc, free_func) _
				)
				scope
#endmacro
#define G_DEFINE_POINTER_TYPE(TypeName, type_name) G_DEFINE_POINTER_TYPE_WITH_CODE(TypeName, type_name, )
#macro G_DEFINE_POINTER_TYPE_WITH_CODE(TypeName, type_name, _C_)
	_G_DEFINE_POINTER_TYPE_BEGIN(TypeName, type_name)
	scope
		_C_
	end scope
	_G_DEFINE_TYPE_EXTENDED_END()
#endmacro
#macro _G_DEFINE_POINTER_TYPE_BEGIN(TypeName, type_name)
	extern "C"
		function type_name##_get_type() as GType
			static as gsize g_define_type_id__volatile = 0
			if g_once_init_enter(@g_define_type_id__volatile) then
				var g_define_type_id = g_pointer_type_register_static(g_intern_static_string(#TypeName))
				scope
#endmacro

declare function g_type_get_plugin(byval type as GType) as GTypePlugin ptr
declare function g_type_interface_get_plugin(byval instance_type as GType, byval interface_type as GType) as GTypePlugin ptr
declare function g_type_fundamental_next() as GType
declare function g_type_fundamental_ alias "g_type_fundamental"(byval type_id as GType) as GType
declare function g_type_create_instance(byval type as GType) as GTypeInstance ptr
declare sub g_type_free_instance(byval instance as GTypeInstance ptr)
declare sub g_type_add_class_cache_func(byval cache_data as gpointer, byval cache_func as GTypeClassCacheFunc)
declare sub g_type_remove_class_cache_func(byval cache_data as gpointer, byval cache_func as GTypeClassCacheFunc)
declare sub g_type_class_unref_uncached(byval g_class as gpointer)
declare sub g_type_add_interface_check(byval check_data as gpointer, byval check_func as GTypeInterfaceCheckFunc)
declare sub g_type_remove_interface_check(byval check_data as gpointer, byval check_func as GTypeInterfaceCheckFunc)
declare function g_type_value_table_peek(byval type as GType) as GTypeValueTable ptr
declare function g_type_check_instance_ alias "g_type_check_instance"(byval instance as GTypeInstance ptr) as gboolean
declare function g_type_check_instance_cast_ alias "g_type_check_instance_cast"(byval instance as GTypeInstance ptr, byval iface_type as GType) as GTypeInstance ptr
declare function g_type_check_instance_is_a(byval instance as GTypeInstance ptr, byval iface_type as GType) as gboolean
declare function g_type_check_instance_is_fundamentally_a(byval instance as GTypeInstance ptr, byval fundamental_type as GType) as gboolean
declare function g_type_check_class_cast_ alias "g_type_check_class_cast"(byval g_class as GTypeClass ptr, byval is_a_type as GType) as GTypeClass ptr
declare function g_type_check_class_is_a(byval g_class as GTypeClass ptr, byval is_a_type as GType) as gboolean
declare function g_type_check_is_value_type(byval type as GType) as gboolean
declare function g_type_check_value_ alias "g_type_check_value"(byval value as GValue ptr) as gboolean
declare function g_type_check_value_holds(byval value as GValue ptr, byval type as GType) as gboolean
declare function g_type_test_flags(byval type as GType, byval flags as guint) as gboolean
declare function g_type_name_from_instance(byval instance as GTypeInstance ptr) as const gchar ptr
declare function g_type_name_from_class(byval g_class as GTypeClass ptr) as const gchar ptr

#define _G_TYPE_CIC(ip, gt, ct) cptr(ct ptr, g_type_check_instance_cast_(cptr(GTypeInstance ptr, ip), gt))
#define _G_TYPE_CCC(cp, gt, ct) cptr(ct ptr, g_type_check_class_cast_(cptr(GTypeClass ptr, cp), gt))
#define _G_TYPE_CHI(ip) g_type_check_instance_(cptr(GTypeInstance ptr, ip))
#define _G_TYPE_CHV(vl) g_type_check_value_(cptr(GValue ptr, vl))
#define _G_TYPE_IGC(ip, gt, ct) cptr(ct ptr, cptr(GTypeInstance ptr, ip)->g_class)
#define _G_TYPE_IGI(ip, gt, ct) cptr(ct ptr, g_type_interface_peek(cptr(GTypeInstance ptr, ip)->g_class, gt))
#define _G_TYPE_CIFT(ip, ft) g_type_check_instance_is_fundamentally_a(cptr(GTypeInstance ptr, ip), ft)
#define _G_TYPE_CIT(ip, gt) _
	iif(cptr(GTypeInstance ptr, ip) = 0, _
		FALSE, _
		iif(cptr(GTypeInstance ptr, ip)->g_class andalso cptr(GTypeInstance ptr, ip)->g_class->g_type = gt, _
			CTRUE, _
			g_type_check_instance_is_a(cptr(GTypeInstance ptr, ip), gt)))
#define _G_TYPE_CCT(cp, gt) _
	iif(cptr(GTypeClass ptr, cp) = 0, _
		FALSE, _
		iif(cptr(GTypeClass ptr, cp)->g_type = gt, _
			CTRUE, _
			g_type_check_class_is_a(cptr(GTypeClass ptr, cp), gt)))
#define _G_TYPE_CVH(vl, gt) _
	iif(cptr(GValue ptr, vl) = 0 _
		FALSE, _
		iif(cptr(GValue ptr, vl)->g_type = gt, _
			CTRUE, _
			g_type_check_value_holds(cptr(GValue ptr, vl), gt)))
const G_TYPE_FLAG_RESERVED_ID_BIT = cast(GType, 1 shl 0)
#define __G_VALUE_H__
#define G_TYPE_IS_VALUE(type) g_type_check_is_value_type(type)
#define G_IS_VALUE(value) G_TYPE_CHECK_VALUE(value)
#define G_VALUE_TYPE(value) cptr(GValue ptr, (value))->g_type
#define G_VALUE_TYPE_NAME(value) g_type_name(G_VALUE_TYPE(value))
#define G_VALUE_HOLDS(value, type) G_TYPE_CHECK_VALUE_TYPE((value), (type))
type GValueTransform as sub(byval src_value as const GValue ptr, byval dest_value as GValue ptr)

union _GValue_data
	v_int as gint
	v_uint as guint
	v_long as glong
	v_ulong as gulong
	v_int64 as gint64
	v_uint64 as guint64
	v_float as gfloat
	v_double as gdouble
	v_pointer as gpointer
end union

type _GValue
	g_type as GType
	data(0 to 1) as _GValue_data
end type

declare function g_value_init_ alias "g_value_init"(byval value as GValue ptr, byval g_type as GType) as GValue ptr
declare sub g_value_copy(byval src_value as const GValue ptr, byval dest_value as GValue ptr)
declare function g_value_reset(byval value as GValue ptr) as GValue ptr
declare sub g_value_unset(byval value as GValue ptr)
declare sub g_value_set_instance(byval value as GValue ptr, byval instance as gpointer)
declare sub g_value_init_from_instance(byval value as GValue ptr, byval instance as gpointer)
declare function g_value_fits_pointer(byval value as const GValue ptr) as gboolean
declare function g_value_peek_pointer(byval value as const GValue ptr) as gpointer
declare function g_value_type_compatible(byval src_type as GType, byval dest_type as GType) as gboolean
declare function g_value_type_transformable(byval src_type as GType, byval dest_type as GType) as gboolean
declare function g_value_transform(byval src_value as const GValue ptr, byval dest_value as GValue ptr) as gboolean
declare sub g_value_register_transform_func(byval src_type as GType, byval dest_type as GType, byval transform_func as GValueTransform)

const G_VALUE_NOCOPY_CONTENTS = 1 shl 27
#define G_VALUE_INIT (0, ((0)))
#define __G_PARAM_H__
#define G_TYPE_IS_PARAM(type) (G_TYPE_FUNDAMENTAL(type) = G_TYPE_PARAM)
#define G_PARAM_SPEC(pspec) G_TYPE_CHECK_INSTANCE_CAST((pspec), G_TYPE_PARAM, GParamSpec)
#define G_IS_PARAM_SPEC(pspec) G_TYPE_CHECK_INSTANCE_FUNDAMENTAL_TYPE((pspec), G_TYPE_PARAM)
#define G_PARAM_SPEC_CLASS(pclass) G_TYPE_CHECK_CLASS_CAST((pclass), G_TYPE_PARAM, GParamSpecClass)
#define G_IS_PARAM_SPEC_CLASS(pclass) G_TYPE_CHECK_CLASS_TYPE((pclass), G_TYPE_PARAM)
#define G_PARAM_SPEC_GET_CLASS(pspec) G_TYPE_INSTANCE_GET_CLASS((pspec), G_TYPE_PARAM, GParamSpecClass)
#define G_PARAM_SPEC_TYPE(pspec) G_TYPE_FROM_INSTANCE(pspec)
#define G_PARAM_SPEC_TYPE_NAME(pspec) g_type_name(G_PARAM_SPEC_TYPE(pspec))
#define G_PARAM_SPEC_VALUE_TYPE(pspec) G_PARAM_SPEC(pspec)->value_type
#define G_VALUE_HOLDS_PARAM(value) G_TYPE_CHECK_VALUE_TYPE((value), G_TYPE_PARAM)

type GParamFlags as long
enum
	G_PARAM_READABLE = 1 shl 0
	G_PARAM_WRITABLE = 1 shl 1
	G_PARAM_READWRITE = G_PARAM_READABLE or G_PARAM_WRITABLE
	G_PARAM_CONSTRUCT = 1 shl 2
	G_PARAM_CONSTRUCT_ONLY = 1 shl 3
	G_PARAM_LAX_VALIDATION = 1 shl 4
	G_PARAM_STATIC_NAME = 1 shl 5
	G_PARAM_PRIVATE = G_PARAM_STATIC_NAME
	G_PARAM_STATIC_NICK = 1 shl 6
	G_PARAM_STATIC_BLURB = 1 shl 7
	G_PARAM_EXPLICIT_NOTIFY = 1 shl 30
	G_PARAM_DEPRECATED = 1 shl 31
end enum

const G_PARAM_STATIC_STRINGS = (G_PARAM_STATIC_NAME or G_PARAM_STATIC_NICK) or G_PARAM_STATIC_BLURB
const G_PARAM_MASK = &h000000ff
const G_PARAM_USER_SHIFT = 8

type GParamSpec as _GParamSpec
type GParamSpecClass as _GParamSpecClass
type GParameter as _GParameter
type GParamSpecPool as _GParamSpecPool

type _GParamSpec
	g_type_instance as GTypeInstance
	name as const gchar ptr
	flags as GParamFlags
	value_type as GType
	owner_type as GType
	_nick as gchar ptr
	_blurb as gchar ptr
	qdata as GData ptr
	ref_count as guint
	param_id as guint
end type

type _GParamSpecClass
	g_type_class as GTypeClass
	value_type as GType
	finalize as sub(byval pspec as GParamSpec ptr)
	value_set_default as sub(byval pspec as GParamSpec ptr, byval value as GValue ptr)
	value_validate as function(byval pspec as GParamSpec ptr, byval value as GValue ptr) as gboolean
	values_cmp as function(byval pspec as GParamSpec ptr, byval value1 as const GValue ptr, byval value2 as const GValue ptr) as gint
	dummy(0 to 3) as gpointer
end type

type _GParameter
	name as const gchar ptr
	value as GValue
end type

declare function g_param_spec_ref(byval pspec as GParamSpec ptr) as GParamSpec ptr
declare sub g_param_spec_unref(byval pspec as GParamSpec ptr)
declare sub g_param_spec_sink(byval pspec as GParamSpec ptr)
declare function g_param_spec_ref_sink(byval pspec as GParamSpec ptr) as GParamSpec ptr
declare function g_param_spec_get_qdata(byval pspec as GParamSpec ptr, byval quark as GQuark) as gpointer
declare sub g_param_spec_set_qdata(byval pspec as GParamSpec ptr, byval quark as GQuark, byval data as gpointer)
declare sub g_param_spec_set_qdata_full(byval pspec as GParamSpec ptr, byval quark as GQuark, byval data as gpointer, byval destroy as GDestroyNotify)
declare function g_param_spec_steal_qdata(byval pspec as GParamSpec ptr, byval quark as GQuark) as gpointer
declare function g_param_spec_get_redirect_target(byval pspec as GParamSpec ptr) as GParamSpec ptr
declare sub g_param_value_set_default(byval pspec as GParamSpec ptr, byval value as GValue ptr)
declare function g_param_value_defaults(byval pspec as GParamSpec ptr, byval value as GValue ptr) as gboolean
declare function g_param_value_validate(byval pspec as GParamSpec ptr, byval value as GValue ptr) as gboolean
declare function g_param_value_convert(byval pspec as GParamSpec ptr, byval src_value as const GValue ptr, byval dest_value as GValue ptr, byval strict_validation as gboolean) as gboolean
declare function g_param_values_cmp(byval pspec as GParamSpec ptr, byval value1 as const GValue ptr, byval value2 as const GValue ptr) as gint
declare function g_param_spec_get_name(byval pspec as GParamSpec ptr) as const gchar ptr
declare function g_param_spec_get_nick(byval pspec as GParamSpec ptr) as const gchar ptr
declare function g_param_spec_get_blurb(byval pspec as GParamSpec ptr) as const gchar ptr
declare sub g_value_set_param(byval value as GValue ptr, byval param as GParamSpec ptr)
declare function g_value_get_param(byval value as const GValue ptr) as GParamSpec ptr
declare function g_value_dup_param(byval value as const GValue ptr) as GParamSpec ptr
declare sub g_value_take_param(byval value as GValue ptr, byval param as GParamSpec ptr)
declare sub g_value_set_param_take_ownership(byval value as GValue ptr, byval param as GParamSpec ptr)
declare function g_param_spec_get_default_value(byval param as GParamSpec ptr) as const GValue ptr
type GParamSpecTypeInfo as _GParamSpecTypeInfo

type _GParamSpecTypeInfo
	instance_size as guint16
	n_preallocs as guint16
	instance_init as sub(byval pspec as GParamSpec ptr)
	value_type as GType
	finalize as sub(byval pspec as GParamSpec ptr)
	value_set_default as sub(byval pspec as GParamSpec ptr, byval value as GValue ptr)
	value_validate as function(byval pspec as GParamSpec ptr, byval value as GValue ptr) as gboolean
	values_cmp as function(byval pspec as GParamSpec ptr, byval value1 as const GValue ptr, byval value2 as const GValue ptr) as gint
end type

declare function g_param_type_register_static(byval name as const gchar ptr, byval pspec_info as const GParamSpecTypeInfo ptr) as GType
declare function _g_param_type_register_static_constant(byval name as const gchar ptr, byval pspec_info as const GParamSpecTypeInfo ptr, byval opt_type as GType) as GType
declare function g_param_spec_internal(byval param_type as GType, byval name as const gchar ptr, byval nick as const gchar ptr, byval blurb as const gchar ptr, byval flags as GParamFlags) as gpointer
declare function g_param_spec_pool_new(byval type_prefixing as gboolean) as GParamSpecPool ptr
declare sub g_param_spec_pool_insert(byval pool as GParamSpecPool ptr, byval pspec as GParamSpec ptr, byval owner_type as GType)
declare sub g_param_spec_pool_remove(byval pool as GParamSpecPool ptr, byval pspec as GParamSpec ptr)
declare function g_param_spec_pool_lookup(byval pool as GParamSpecPool ptr, byval param_name as const gchar ptr, byval owner_type as GType, byval walk_ancestors as gboolean) as GParamSpec ptr
declare function g_param_spec_pool_list_owned(byval pool as GParamSpecPool ptr, byval owner_type as GType) as GList ptr
declare function g_param_spec_pool_list(byval pool as GParamSpecPool ptr, byval owner_type as GType, byval n_pspecs_p as guint ptr) as GParamSpec ptr ptr

#define __G_CLOSURE_H__
#define G_CLOSURE_NEEDS_MARSHAL(closure) (cptr(GClosure ptr, (closure))->marshal = NULL)
#define G_CLOSURE_N_NOTIFIERS(cl) ((((cl)->n_guards shl cast(clong, 1)) + (cl)->n_fnotifiers) + (cl)->n_inotifiers)
#define G_CCLOSURE_SWAP_DATA(cclosure) cptr(GClosure ptr, (cclosure))->derivative_flag
#define G_CALLBACK(f) cast(GCallback, (f))

type GClosure as _GClosure
type GClosureNotifyData as _GClosureNotifyData
type GCallback as sub()
type GClosureNotify as sub(byval data as gpointer, byval closure as GClosure ptr)
type GClosureMarshal as sub(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
type GVaClosureMarshal as sub(byval closure as GClosure ptr, byval return_value as GValue ptr, byval instance as gpointer, byval args as va_list, byval marshal_data as gpointer, byval n_params as long, byval param_types as GType ptr)
type GCClosure as _GCClosure

type _GClosureNotifyData
	data as gpointer
	notify as GClosureNotify
end type

type _GClosure
	ref_count : 15 as guint
	meta_marshal_nouse : 1 as guint
	n_guards : 1 as guint
	n_fnotifiers : 2 as guint
	n_inotifiers : 8 as guint
	in_inotify : 1 as guint
	floating : 1 as guint
	derivative_flag : 1 as guint
	in_marshal : 1 as guint
	is_invalid : 1 as guint
	marshal as sub(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
	data as gpointer
	notifiers as GClosureNotifyData ptr
end type

type _GCClosure
	closure as GClosure
	callback as gpointer
end type

declare function g_cclosure_new(byval callback_func as GCallback, byval user_data as gpointer, byval destroy_data as GClosureNotify) as GClosure ptr
declare function g_cclosure_new_swap(byval callback_func as GCallback, byval user_data as gpointer, byval destroy_data as GClosureNotify) as GClosure ptr
declare function g_signal_type_cclosure_new(byval itype as GType, byval struct_offset as guint) as GClosure ptr
declare function g_closure_ref(byval closure as GClosure ptr) as GClosure ptr
declare sub g_closure_sink(byval closure as GClosure ptr)
declare sub g_closure_unref(byval closure as GClosure ptr)
declare function g_closure_new_simple(byval sizeof_closure as guint, byval data as gpointer) as GClosure ptr
declare sub g_closure_add_finalize_notifier(byval closure as GClosure ptr, byval notify_data as gpointer, byval notify_func as GClosureNotify)
declare sub g_closure_remove_finalize_notifier(byval closure as GClosure ptr, byval notify_data as gpointer, byval notify_func as GClosureNotify)
declare sub g_closure_add_invalidate_notifier(byval closure as GClosure ptr, byval notify_data as gpointer, byval notify_func as GClosureNotify)
declare sub g_closure_remove_invalidate_notifier(byval closure as GClosure ptr, byval notify_data as gpointer, byval notify_func as GClosureNotify)
declare sub g_closure_add_marshal_guards(byval closure as GClosure ptr, byval pre_marshal_data as gpointer, byval pre_marshal_notify as GClosureNotify, byval post_marshal_data as gpointer, byval post_marshal_notify as GClosureNotify)
declare sub g_closure_set_marshal(byval closure as GClosure ptr, byval marshal as GClosureMarshal)
declare sub g_closure_set_meta_marshal(byval closure as GClosure ptr, byval marshal_data as gpointer, byval meta_marshal as GClosureMarshal)
declare sub g_closure_invalidate(byval closure as GClosure ptr)
declare sub g_closure_invoke(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer)
declare sub g_cclosure_marshal_generic(byval closure as GClosure ptr, byval return_gvalue as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub g_cclosure_marshal_generic_va(byval closure as GClosure ptr, byval return_value as GValue ptr, byval instance as gpointer, byval args_list as va_list, byval marshal_data as gpointer, byval n_params as long, byval param_types as GType ptr)
#define __G_SIGNAL_H__
#define __G_MARSHAL_H__
declare sub g_cclosure_marshal_VOID__VOID(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub g_cclosure_marshal_VOID__VOIDv(byval closure as GClosure ptr, byval return_value as GValue ptr, byval instance as gpointer, byval args as va_list, byval marshal_data as gpointer, byval n_params as long, byval param_types as GType ptr)
declare sub g_cclosure_marshal_VOID__BOOLEAN(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub g_cclosure_marshal_VOID__BOOLEANv(byval closure as GClosure ptr, byval return_value as GValue ptr, byval instance as gpointer, byval args as va_list, byval marshal_data as gpointer, byval n_params as long, byval param_types as GType ptr)
declare sub g_cclosure_marshal_VOID__CHAR(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub g_cclosure_marshal_VOID__CHARv(byval closure as GClosure ptr, byval return_value as GValue ptr, byval instance as gpointer, byval args as va_list, byval marshal_data as gpointer, byval n_params as long, byval param_types as GType ptr)
declare sub g_cclosure_marshal_VOID__UCHAR(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub g_cclosure_marshal_VOID__UCHARv(byval closure as GClosure ptr, byval return_value as GValue ptr, byval instance as gpointer, byval args as va_list, byval marshal_data as gpointer, byval n_params as long, byval param_types as GType ptr)
declare sub g_cclosure_marshal_VOID__INT(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub g_cclosure_marshal_VOID__INTv(byval closure as GClosure ptr, byval return_value as GValue ptr, byval instance as gpointer, byval args as va_list, byval marshal_data as gpointer, byval n_params as long, byval param_types as GType ptr)
declare sub g_cclosure_marshal_VOID__UINT(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub g_cclosure_marshal_VOID__UINTv(byval closure as GClosure ptr, byval return_value as GValue ptr, byval instance as gpointer, byval args as va_list, byval marshal_data as gpointer, byval n_params as long, byval param_types as GType ptr)
declare sub g_cclosure_marshal_VOID__LONG(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub g_cclosure_marshal_VOID__LONGv(byval closure as GClosure ptr, byval return_value as GValue ptr, byval instance as gpointer, byval args as va_list, byval marshal_data as gpointer, byval n_params as long, byval param_types as GType ptr)
declare sub g_cclosure_marshal_VOID__ULONG(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub g_cclosure_marshal_VOID__ULONGv(byval closure as GClosure ptr, byval return_value as GValue ptr, byval instance as gpointer, byval args as va_list, byval marshal_data as gpointer, byval n_params as long, byval param_types as GType ptr)
declare sub g_cclosure_marshal_VOID__ENUM(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub g_cclosure_marshal_VOID__ENUMv(byval closure as GClosure ptr, byval return_value as GValue ptr, byval instance as gpointer, byval args as va_list, byval marshal_data as gpointer, byval n_params as long, byval param_types as GType ptr)
declare sub g_cclosure_marshal_VOID__FLAGS(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub g_cclosure_marshal_VOID__FLAGSv(byval closure as GClosure ptr, byval return_value as GValue ptr, byval instance as gpointer, byval args as va_list, byval marshal_data as gpointer, byval n_params as long, byval param_types as GType ptr)
declare sub g_cclosure_marshal_VOID__FLOAT(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub g_cclosure_marshal_VOID__FLOATv(byval closure as GClosure ptr, byval return_value as GValue ptr, byval instance as gpointer, byval args as va_list, byval marshal_data as gpointer, byval n_params as long, byval param_types as GType ptr)
declare sub g_cclosure_marshal_VOID__DOUBLE(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub g_cclosure_marshal_VOID__DOUBLEv(byval closure as GClosure ptr, byval return_value as GValue ptr, byval instance as gpointer, byval args as va_list, byval marshal_data as gpointer, byval n_params as long, byval param_types as GType ptr)
declare sub g_cclosure_marshal_VOID__STRING(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub g_cclosure_marshal_VOID__STRINGv(byval closure as GClosure ptr, byval return_value as GValue ptr, byval instance as gpointer, byval args as va_list, byval marshal_data as gpointer, byval n_params as long, byval param_types as GType ptr)
declare sub g_cclosure_marshal_VOID__PARAM(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub g_cclosure_marshal_VOID__PARAMv(byval closure as GClosure ptr, byval return_value as GValue ptr, byval instance as gpointer, byval args as va_list, byval marshal_data as gpointer, byval n_params as long, byval param_types as GType ptr)
declare sub g_cclosure_marshal_VOID__BOXED(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub g_cclosure_marshal_VOID__BOXEDv(byval closure as GClosure ptr, byval return_value as GValue ptr, byval instance as gpointer, byval args as va_list, byval marshal_data as gpointer, byval n_params as long, byval param_types as GType ptr)
declare sub g_cclosure_marshal_VOID__POINTER(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub g_cclosure_marshal_VOID__POINTERv(byval closure as GClosure ptr, byval return_value as GValue ptr, byval instance as gpointer, byval args as va_list, byval marshal_data as gpointer, byval n_params as long, byval param_types as GType ptr)
declare sub g_cclosure_marshal_VOID__OBJECT(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub g_cclosure_marshal_VOID__OBJECTv(byval closure as GClosure ptr, byval return_value as GValue ptr, byval instance as gpointer, byval args as va_list, byval marshal_data as gpointer, byval n_params as long, byval param_types as GType ptr)
declare sub g_cclosure_marshal_VOID__VARIANT(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub g_cclosure_marshal_VOID__VARIANTv(byval closure as GClosure ptr, byval return_value as GValue ptr, byval instance as gpointer, byval args as va_list, byval marshal_data as gpointer, byval n_params as long, byval param_types as GType ptr)
declare sub g_cclosure_marshal_VOID__UINT_POINTER(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub g_cclosure_marshal_VOID__UINT_POINTERv(byval closure as GClosure ptr, byval return_value as GValue ptr, byval instance as gpointer, byval args as va_list, byval marshal_data as gpointer, byval n_params as long, byval param_types as GType ptr)
declare sub g_cclosure_marshal_BOOLEAN__FLAGS(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub g_cclosure_marshal_BOOLEAN__FLAGSv(byval closure as GClosure ptr, byval return_value as GValue ptr, byval instance as gpointer, byval args as va_list, byval marshal_data as gpointer, byval n_params as long, byval param_types as GType ptr)
declare sub g_cclosure_marshal_BOOL__FLAGS alias "g_cclosure_marshal_BOOLEAN__FLAGS"(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub g_cclosure_marshal_STRING__OBJECT_POINTER(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub g_cclosure_marshal_STRING__OBJECT_POINTERv(byval closure as GClosure ptr, byval return_value as GValue ptr, byval instance as gpointer, byval args as va_list, byval marshal_data as gpointer, byval n_params as long, byval param_types as GType ptr)
declare sub g_cclosure_marshal_BOOLEAN__BOXED_BOXED(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub g_cclosure_marshal_BOOLEAN__BOXED_BOXEDv(byval closure as GClosure ptr, byval return_value as GValue ptr, byval instance as gpointer, byval args as va_list, byval marshal_data as gpointer, byval n_params as long, byval param_types as GType ptr)
declare sub g_cclosure_marshal_BOOL__BOXED_BOXED alias "g_cclosure_marshal_BOOLEAN__BOXED_BOXED"(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)

type GSignalQuery as _GSignalQuery
type GSignalInvocationHint as _GSignalInvocationHint
type GSignalCMarshaller as GClosureMarshal
type GSignalCVaMarshaller as GVaClosureMarshal
type GSignalEmissionHook as function(byval ihint as GSignalInvocationHint ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval data as gpointer) as gboolean
type GSignalAccumulator as function(byval ihint as GSignalInvocationHint ptr, byval return_accu as GValue ptr, byval handler_return as const GValue ptr, byval data as gpointer) as gboolean

type GSignalFlags as long
enum
	G_SIGNAL_RUN_FIRST = 1 shl 0
	G_SIGNAL_RUN_LAST = 1 shl 1
	G_SIGNAL_RUN_CLEANUP = 1 shl 2
	G_SIGNAL_NO_RECURSE = 1 shl 3
	G_SIGNAL_DETAILED = 1 shl 4
	G_SIGNAL_ACTION = 1 shl 5
	G_SIGNAL_NO_HOOKS = 1 shl 6
	G_SIGNAL_MUST_COLLECT = 1 shl 7
	G_SIGNAL_DEPRECATED = 1 shl 8
end enum

const G_SIGNAL_FLAGS_MASK = &h1ff

type GConnectFlags as long
enum
	G_CONNECT_AFTER = 1 shl 0
	G_CONNECT_SWAPPED = 1 shl 1
end enum

type GSignalMatchType as long
enum
	G_SIGNAL_MATCH_ID = 1 shl 0
	G_SIGNAL_MATCH_DETAIL = 1 shl 1
	G_SIGNAL_MATCH_CLOSURE = 1 shl 2
	G_SIGNAL_MATCH_FUNC = 1 shl 3
	G_SIGNAL_MATCH_DATA = 1 shl 4
	G_SIGNAL_MATCH_UNBLOCKED = 1 shl 5
end enum

const G_SIGNAL_MATCH_MASK = &h3f
const G_SIGNAL_TYPE_STATIC_SCOPE = G_TYPE_FLAG_RESERVED_ID_BIT

type _GSignalInvocationHint
	signal_id as guint
	detail as GQuark
	run_type as GSignalFlags
end type

type _GSignalQuery
	signal_id as guint
	signal_name as const gchar ptr
	itype as GType
	signal_flags as GSignalFlags
	return_type as GType
	n_params as guint
	param_types as const GType ptr
end type

declare function g_signal_newv(byval signal_name as const gchar ptr, byval itype as GType, byval signal_flags as GSignalFlags, byval class_closure as GClosure ptr, byval accumulator as GSignalAccumulator, byval accu_data as gpointer, byval c_marshaller as GSignalCMarshaller, byval return_type as GType, byval n_params as guint, byval param_types as GType ptr) as guint
declare function g_signal_new_valist(byval signal_name as const gchar ptr, byval itype as GType, byval signal_flags as GSignalFlags, byval class_closure as GClosure ptr, byval accumulator as GSignalAccumulator, byval accu_data as gpointer, byval c_marshaller as GSignalCMarshaller, byval return_type as GType, byval n_params as guint, byval args as va_list) as guint
declare function g_signal_new(byval signal_name as const gchar ptr, byval itype as GType, byval signal_flags as GSignalFlags, byval class_offset as guint, byval accumulator as GSignalAccumulator, byval accu_data as gpointer, byval c_marshaller as GSignalCMarshaller, byval return_type as GType, byval n_params as guint, ...) as guint
declare function g_signal_new_class_handler(byval signal_name as const gchar ptr, byval itype as GType, byval signal_flags as GSignalFlags, byval class_handler as GCallback, byval accumulator as GSignalAccumulator, byval accu_data as gpointer, byval c_marshaller as GSignalCMarshaller, byval return_type as GType, byval n_params as guint, ...) as guint
declare sub g_signal_set_va_marshaller(byval signal_id as guint, byval instance_type as GType, byval va_marshaller as GSignalCVaMarshaller)
declare sub g_signal_emitv(byval instance_and_params as const GValue ptr, byval signal_id as guint, byval detail as GQuark, byval return_value as GValue ptr)
declare sub g_signal_emit_valist(byval instance as gpointer, byval signal_id as guint, byval detail as GQuark, byval var_args as va_list)
declare sub g_signal_emit(byval instance as gpointer, byval signal_id as guint, byval detail as GQuark, ...)
declare sub g_signal_emit_by_name(byval instance as gpointer, byval detailed_signal as const gchar ptr, ...)
declare function g_signal_lookup(byval name as const gchar ptr, byval itype as GType) as guint
declare function g_signal_name(byval signal_id as guint) as const gchar ptr
declare sub g_signal_query(byval signal_id as guint, byval query as GSignalQuery ptr)
declare function g_signal_list_ids(byval itype as GType, byval n_ids as guint ptr) as guint ptr
declare function g_signal_parse_name(byval detailed_signal as const gchar ptr, byval itype as GType, byval signal_id_p as guint ptr, byval detail_p as GQuark ptr, byval force_detail_quark as gboolean) as gboolean
declare function g_signal_get_invocation_hint(byval instance as gpointer) as GSignalInvocationHint ptr
declare sub g_signal_stop_emission(byval instance as gpointer, byval signal_id as guint, byval detail as GQuark)
declare sub g_signal_stop_emission_by_name(byval instance as gpointer, byval detailed_signal as const gchar ptr)
declare function g_signal_add_emission_hook(byval signal_id as guint, byval detail as GQuark, byval hook_func as GSignalEmissionHook, byval hook_data as gpointer, byval data_destroy as GDestroyNotify) as gulong
declare sub g_signal_remove_emission_hook(byval signal_id as guint, byval hook_id as gulong)
declare function g_signal_has_handler_pending(byval instance as gpointer, byval signal_id as guint, byval detail as GQuark, byval may_be_blocked as gboolean) as gboolean
declare function g_signal_connect_closure_by_id(byval instance as gpointer, byval signal_id as guint, byval detail as GQuark, byval closure as GClosure ptr, byval after as gboolean) as gulong
declare function g_signal_connect_closure(byval instance as gpointer, byval detailed_signal as const gchar ptr, byval closure as GClosure ptr, byval after as gboolean) as gulong
declare function g_signal_connect_data(byval instance as gpointer, byval detailed_signal as const gchar ptr, byval c_handler as GCallback, byval data as gpointer, byval destroy_data as GClosureNotify, byval connect_flags as GConnectFlags) as gulong
declare sub g_signal_handler_block(byval instance as gpointer, byval handler_id as gulong)
declare sub g_signal_handler_unblock(byval instance as gpointer, byval handler_id as gulong)
declare sub g_signal_handler_disconnect(byval instance as gpointer, byval handler_id as gulong)
declare function g_signal_handler_is_connected(byval instance as gpointer, byval handler_id as gulong) as gboolean
declare function g_signal_handler_find(byval instance as gpointer, byval mask as GSignalMatchType, byval signal_id as guint, byval detail as GQuark, byval closure as GClosure ptr, byval func as gpointer, byval data as gpointer) as gulong
declare function g_signal_handlers_block_matched(byval instance as gpointer, byval mask as GSignalMatchType, byval signal_id as guint, byval detail as GQuark, byval closure as GClosure ptr, byval func as gpointer, byval data as gpointer) as guint
declare function g_signal_handlers_unblock_matched(byval instance as gpointer, byval mask as GSignalMatchType, byval signal_id as guint, byval detail as GQuark, byval closure as GClosure ptr, byval func as gpointer, byval data as gpointer) as guint
declare function g_signal_handlers_disconnect_matched(byval instance as gpointer, byval mask as GSignalMatchType, byval signal_id as guint, byval detail as GQuark, byval closure as GClosure ptr, byval func as gpointer, byval data as gpointer) as guint
declare sub g_signal_override_class_closure(byval signal_id as guint, byval instance_type as GType, byval class_closure as GClosure ptr)
declare sub g_signal_override_class_handler(byval signal_name as const gchar ptr, byval instance_type as GType, byval class_handler as GCallback)
declare sub g_signal_chain_from_overridden(byval instance_and_params as const GValue ptr, byval return_value as GValue ptr)
declare sub g_signal_chain_from_overridden_handler(byval instance as gpointer, ...)

#define g_signal_connect(instance, detailed_signal, c_handler, data) g_signal_connect_data((instance), (detailed_signal), (c_handler), (data), NULL, cast(GConnectFlags, 0))
#define g_signal_connect_after(instance, detailed_signal, c_handler, data) g_signal_connect_data((instance), (detailed_signal), (c_handler), (data), NULL, G_CONNECT_AFTER)
#define g_signal_connect_swapped(instance, detailed_signal, c_handler, data) g_signal_connect_data((instance), (detailed_signal), (c_handler), (data), NULL, G_CONNECT_SWAPPED)
#define g_signal_handlers_disconnect_by_func(instance, func, data) g_signal_handlers_disconnect_matched((instance), cast(GSignalMatchType, G_SIGNAL_MATCH_FUNC or G_SIGNAL_MATCH_DATA), 0, 0, NULL, (func), (data))
#define g_signal_handlers_disconnect_by_data(instance, data) g_signal_handlers_disconnect_matched((instance), G_SIGNAL_MATCH_DATA, 0, 0, NULL, NULL, (data))
#define g_signal_handlers_block_by_func(instance, func, data) g_signal_handlers_block_matched((instance), cast(GSignalMatchType, G_SIGNAL_MATCH_FUNC or G_SIGNAL_MATCH_DATA), 0, 0, NULL, (func), (data))
#define g_signal_handlers_unblock_by_func(instance, func, data) g_signal_handlers_unblock_matched((instance), cast(GSignalMatchType, G_SIGNAL_MATCH_FUNC or G_SIGNAL_MATCH_DATA), 0, 0, NULL, (func), (data))

declare function g_signal_accumulator_true_handled(byval ihint as GSignalInvocationHint ptr, byval return_accu as GValue ptr, byval handler_return as const GValue ptr, byval dummy as gpointer) as gboolean
declare function g_signal_accumulator_first_wins(byval ihint as GSignalInvocationHint ptr, byval return_accu as GValue ptr, byval handler_return as const GValue ptr, byval dummy as gpointer) as gboolean
declare sub g_signal_handlers_destroy(byval instance as gpointer)
declare sub _g_signals_destroy(byval itype as GType)

#define __G_BOXED_H__
#define __GLIB_TYPES_H__
#define G_TYPE_DATE g_date_get_type()
#define G_TYPE_STRV g_strv_get_type()
#define G_TYPE_GSTRING g_gstring_get_type()
#define G_TYPE_HASH_TABLE g_hash_table_get_type()
#define G_TYPE_REGEX g_regex_get_type()
#define G_TYPE_MATCH_INFO g_match_info_get_type()
#define G_TYPE_ARRAY g_array_get_type()
#define G_TYPE_BYTE_ARRAY g_byte_array_get_type()
#define G_TYPE_PTR_ARRAY g_ptr_array_get_type()
#define G_TYPE_BYTES g_bytes_get_type()
#define G_TYPE_VARIANT_TYPE g_variant_type_get_gtype()
#define G_TYPE_ERROR g_error_get_type()
#define G_TYPE_DATE_TIME g_date_time_get_type()
#define G_TYPE_TIME_ZONE g_time_zone_get_type()
#define G_TYPE_IO_CHANNEL g_io_channel_get_type()
#define G_TYPE_IO_CONDITION g_io_condition_get_type()
#define G_TYPE_VARIANT_BUILDER g_variant_builder_get_type()
#define G_TYPE_VARIANT_DICT g_variant_dict_get_type()
#define G_TYPE_MAIN_LOOP g_main_loop_get_type()
#define G_TYPE_MAIN_CONTEXT g_main_context_get_type()
#define G_TYPE_SOURCE g_source_get_type()
#define G_TYPE_POLLFD g_pollfd_get_type()
#define G_TYPE_MARKUP_PARSE_CONTEXT g_markup_parse_context_get_type()
#define G_TYPE_KEY_FILE g_key_file_get_type()
#define G_TYPE_MAPPED_FILE g_mapped_file_get_type()
#define G_TYPE_THREAD g_thread_get_type()
#define G_TYPE_CHECKSUM g_checksum_get_type()
#define G_TYPE_OPTION_GROUP g_option_group_get_type()

declare function g_date_get_type() as GType
declare function g_strv_get_type() as GType
declare function g_gstring_get_type() as GType
declare function g_hash_table_get_type() as GType
declare function g_array_get_type() as GType
declare function g_byte_array_get_type() as GType
declare function g_ptr_array_get_type() as GType
declare function g_bytes_get_type() as GType
declare function g_variant_type_get_gtype() as GType
declare function g_regex_get_type() as GType
declare function g_match_info_get_type() as GType
declare function g_error_get_type() as GType
declare function g_date_time_get_type() as GType
declare function g_time_zone_get_type() as GType
declare function g_io_channel_get_type() as GType
declare function g_io_condition_get_type() as GType
declare function g_variant_builder_get_type() as GType
declare function g_variant_dict_get_type() as GType
declare function g_key_file_get_type() as GType
declare function g_main_loop_get_type() as GType
declare function g_main_context_get_type() as GType
declare function g_source_get_type() as GType
declare function g_pollfd_get_type() as GType
declare function g_thread_get_type() as GType
declare function g_checksum_get_type() as GType
declare function g_markup_parse_context_get_type() as GType
declare function g_mapped_file_get_type() as GType
declare function g_option_group_get_type() as GType
declare function g_variant_get_gtype() as GType
type GStrv as gchar ptr ptr
#define G_TYPE_IS_BOXED(type) (G_TYPE_FUNDAMENTAL(type) = G_TYPE_BOXED)
#define G_VALUE_HOLDS_BOXED(value) G_TYPE_CHECK_VALUE_TYPE((value), G_TYPE_BOXED)
type GBoxedCopyFunc as function(byval boxed as gpointer) as gpointer
type GBoxedFreeFunc as sub(byval boxed as gpointer)
declare function g_boxed_copy(byval boxed_type as GType, byval src_boxed as gconstpointer) as gpointer
declare sub g_boxed_free(byval boxed_type as GType, byval boxed as gpointer)
declare sub g_value_set_boxed(byval value as GValue ptr, byval v_boxed as gconstpointer)
declare sub g_value_set_static_boxed(byval value as GValue ptr, byval v_boxed as gconstpointer)
declare sub g_value_take_boxed(byval value as GValue ptr, byval v_boxed as gconstpointer)
declare sub g_value_set_boxed_take_ownership(byval value as GValue ptr, byval v_boxed as gconstpointer)
declare function g_value_get_boxed(byval value as const GValue ptr) as gpointer
declare function g_value_dup_boxed(byval value as const GValue ptr) as gpointer
declare function g_boxed_type_register_static(byval name as const gchar ptr, byval boxed_copy as GBoxedCopyFunc, byval boxed_free as GBoxedFreeFunc) as GType
#define G_TYPE_CLOSURE g_closure_get_type()
#define G_TYPE_VALUE g_value_get_type()
declare function g_closure_get_type() as GType
declare function g_value_get_type() as GType

#define G_TYPE_IS_OBJECT(type) (G_TYPE_FUNDAMENTAL(type) = G_TYPE_OBJECT)
#define G_OBJECT(object) G_TYPE_CHECK_INSTANCE_CAST((object), G_TYPE_OBJECT, GObject)
#define G_OBJECT_CLASS(class) G_TYPE_CHECK_CLASS_CAST((class), G_TYPE_OBJECT, GObjectClass)
#define G_IS_OBJECT(object) G_TYPE_CHECK_INSTANCE_FUNDAMENTAL_TYPE((object), G_TYPE_OBJECT)
#define G_IS_OBJECT_CLASS(class) G_TYPE_CHECK_CLASS_TYPE((class), G_TYPE_OBJECT)
#define G_OBJECT_GET_CLASS(object) G_TYPE_INSTANCE_GET_CLASS((object), G_TYPE_OBJECT, GObjectClass)
#define G_OBJECT_TYPE(object) G_TYPE_FROM_INSTANCE(object)
#define G_OBJECT_TYPE_NAME(object) g_type_name(G_OBJECT_TYPE(object))
#define G_OBJECT_CLASS_TYPE(class) G_TYPE_FROM_CLASS(class)
#define G_OBJECT_CLASS_NAME(class) g_type_name(G_OBJECT_CLASS_TYPE(class))
#define G_VALUE_HOLDS_OBJECT(value) G_TYPE_CHECK_VALUE_TYPE((value), G_TYPE_OBJECT)
#define G_TYPE_INITIALLY_UNOWNED g_initially_unowned_get_type()
#define G_INITIALLY_UNOWNED(object) G_TYPE_CHECK_INSTANCE_CAST((object), G_TYPE_INITIALLY_UNOWNED, GInitiallyUnowned)
#define G_INITIALLY_UNOWNED_CLASS(class) G_TYPE_CHECK_CLASS_CAST((class), G_TYPE_INITIALLY_UNOWNED, GInitiallyUnownedClass)
#define G_IS_INITIALLY_UNOWNED(object) G_TYPE_CHECK_INSTANCE_TYPE((object), G_TYPE_INITIALLY_UNOWNED)
#define G_IS_INITIALLY_UNOWNED_CLASS(class) G_TYPE_CHECK_CLASS_TYPE((class), G_TYPE_INITIALLY_UNOWNED)
#define G_INITIALLY_UNOWNED_GET_CLASS(object) G_TYPE_INSTANCE_GET_CLASS((object), G_TYPE_INITIALLY_UNOWNED, GInitiallyUnownedClass)

type GObject as _GObject
type GObjectClass as _GObjectClass
type GInitiallyUnowned as _GObject
type GInitiallyUnownedClass as _GObjectClass
type GObjectConstructParam as _GObjectConstructParam
type GObjectGetPropertyFunc as sub(byval object as GObject ptr, byval property_id as guint, byval value as GValue ptr, byval pspec as GParamSpec ptr)
type GObjectSetPropertyFunc as sub(byval object as GObject ptr, byval property_id as guint, byval value as const GValue ptr, byval pspec as GParamSpec ptr)
type GObjectFinalizeFunc as sub(byval object as GObject ptr)
type GWeakNotify as sub(byval data as gpointer, byval where_the_object_was as GObject ptr)

type _GObject
	g_type_instance as GTypeInstance
	ref_count as guint
	qdata as GData ptr
end type

type _GObjectClass
	g_type_class as GTypeClass
	construct_properties as GSList ptr
	constructor as function(byval type as GType, byval n_construct_properties as guint, byval construct_properties as GObjectConstructParam ptr) as GObject ptr
	set_property as sub(byval object as GObject ptr, byval property_id as guint, byval value as const GValue ptr, byval pspec as GParamSpec ptr)
	get_property as sub(byval object as GObject ptr, byval property_id as guint, byval value as GValue ptr, byval pspec as GParamSpec ptr)
	dispose as sub(byval object as GObject ptr)
	finalize as sub(byval object as GObject ptr)
	dispatch_properties_changed as sub(byval object as GObject ptr, byval n_pspecs as guint, byval pspecs as GParamSpec ptr ptr)
	notify as sub(byval object as GObject ptr, byval pspec as GParamSpec ptr)
	constructed as sub(byval object as GObject ptr)
	flags as gsize
	pdummy(0 to 5) as gpointer
end type

type _GObjectConstructParam
	pspec as GParamSpec ptr
	value as GValue ptr
end type

declare function g_initially_unowned_get_type() as GType
declare sub g_object_class_install_property(byval oclass as GObjectClass ptr, byval property_id as guint, byval pspec as GParamSpec ptr)
declare function g_object_class_find_property(byval oclass as GObjectClass ptr, byval property_name as const gchar ptr) as GParamSpec ptr
declare function g_object_class_list_properties(byval oclass as GObjectClass ptr, byval n_properties as guint ptr) as GParamSpec ptr ptr
declare sub g_object_class_override_property(byval oclass as GObjectClass ptr, byval property_id as guint, byval name as const gchar ptr)
declare sub g_object_class_install_properties(byval oclass as GObjectClass ptr, byval n_pspecs as guint, byval pspecs as GParamSpec ptr ptr)
declare sub g_object_interface_install_property(byval g_iface as gpointer, byval pspec as GParamSpec ptr)
declare function g_object_interface_find_property(byval g_iface as gpointer, byval property_name as const gchar ptr) as GParamSpec ptr
declare function g_object_interface_list_properties(byval g_iface as gpointer, byval n_properties_p as guint ptr) as GParamSpec ptr ptr
declare function g_object_get_type() as GType
declare function g_object_new(byval object_type as GType, byval first_property_name as const gchar ptr, ...) as gpointer
declare function g_object_newv(byval object_type as GType, byval n_parameters as guint, byval parameters as GParameter ptr) as gpointer
declare function g_object_new_valist(byval object_type as GType, byval first_property_name as const gchar ptr, byval var_args as va_list) as GObject ptr
declare sub g_object_set(byval object as gpointer, byval first_property_name as const gchar ptr, ...)
declare sub g_object_get(byval object as gpointer, byval first_property_name as const gchar ptr, ...)
declare function g_object_connect(byval object as gpointer, byval signal_spec as const gchar ptr, ...) as gpointer
declare sub g_object_disconnect(byval object as gpointer, byval signal_spec as const gchar ptr, ...)
declare sub g_object_set_valist(byval object as GObject ptr, byval first_property_name as const gchar ptr, byval var_args as va_list)
declare sub g_object_get_valist(byval object as GObject ptr, byval first_property_name as const gchar ptr, byval var_args as va_list)
declare sub g_object_set_property(byval object as GObject ptr, byval property_name as const gchar ptr, byval value as const GValue ptr)
declare sub g_object_get_property(byval object as GObject ptr, byval property_name as const gchar ptr, byval value as GValue ptr)
declare sub g_object_freeze_notify(byval object as GObject ptr)
declare sub g_object_notify(byval object as GObject ptr, byval property_name as const gchar ptr)
declare sub g_object_notify_by_pspec(byval object as GObject ptr, byval pspec as GParamSpec ptr)
declare sub g_object_thaw_notify(byval object as GObject ptr)
declare function g_object_is_floating(byval object as gpointer) as gboolean
declare function g_object_ref_sink(byval object as gpointer) as gpointer
declare function g_object_ref(byval object as gpointer) as gpointer
declare sub g_object_unref(byval object as gpointer)
declare sub g_object_weak_ref(byval object as GObject ptr, byval notify as GWeakNotify, byval data as gpointer)
declare sub g_object_weak_unref(byval object as GObject ptr, byval notify as GWeakNotify, byval data as gpointer)
declare sub g_object_add_weak_pointer(byval object as GObject ptr, byval weak_pointer_location as gpointer ptr)
declare sub g_object_remove_weak_pointer(byval object as GObject ptr, byval weak_pointer_location as gpointer ptr)
type GToggleNotify as sub(byval data as gpointer, byval object as GObject ptr, byval is_last_ref as gboolean)
declare sub g_object_add_toggle_ref(byval object as GObject ptr, byval notify as GToggleNotify, byval data as gpointer)
declare sub g_object_remove_toggle_ref(byval object as GObject ptr, byval notify as GToggleNotify, byval data as gpointer)
declare function g_object_get_qdata(byval object as GObject ptr, byval quark as GQuark) as gpointer
declare sub g_object_set_qdata(byval object as GObject ptr, byval quark as GQuark, byval data as gpointer)
declare sub g_object_set_qdata_full(byval object as GObject ptr, byval quark as GQuark, byval data as gpointer, byval destroy as GDestroyNotify)
declare function g_object_steal_qdata(byval object as GObject ptr, byval quark as GQuark) as gpointer
declare function g_object_dup_qdata(byval object as GObject ptr, byval quark as GQuark, byval dup_func as GDuplicateFunc, byval user_data as gpointer) as gpointer
declare function g_object_replace_qdata(byval object as GObject ptr, byval quark as GQuark, byval oldval as gpointer, byval newval as gpointer, byval destroy as GDestroyNotify, byval old_destroy as GDestroyNotify ptr) as gboolean
declare function g_object_get_data(byval object as GObject ptr, byval key as const gchar ptr) as gpointer
declare sub g_object_set_data(byval object as GObject ptr, byval key as const gchar ptr, byval data as gpointer)
declare sub g_object_set_data_full(byval object as GObject ptr, byval key as const gchar ptr, byval data as gpointer, byval destroy as GDestroyNotify)
declare function g_object_steal_data(byval object as GObject ptr, byval key as const gchar ptr) as gpointer
declare function g_object_dup_data(byval object as GObject ptr, byval key as const gchar ptr, byval dup_func as GDuplicateFunc, byval user_data as gpointer) as gpointer
declare function g_object_replace_data(byval object as GObject ptr, byval key as const gchar ptr, byval oldval as gpointer, byval newval as gpointer, byval destroy as GDestroyNotify, byval old_destroy as GDestroyNotify ptr) as gboolean
declare sub g_object_watch_closure(byval object as GObject ptr, byval closure as GClosure ptr)
declare function g_cclosure_new_object(byval callback_func as GCallback, byval object as GObject ptr) as GClosure ptr
declare function g_cclosure_new_object_swap(byval callback_func as GCallback, byval object as GObject ptr) as GClosure ptr
declare function g_closure_new_object(byval sizeof_closure as guint, byval object as GObject ptr) as GClosure ptr
declare sub g_value_set_object(byval value as GValue ptr, byval v_object as gpointer)
declare function g_value_get_object(byval value as const GValue ptr) as gpointer
declare function g_value_dup_object(byval value as const GValue ptr) as gpointer
declare function g_signal_connect_object(byval instance as gpointer, byval detailed_signal as const gchar ptr, byval c_handler as GCallback, byval gobject as gpointer, byval connect_flags as GConnectFlags) as gulong
declare sub g_object_force_floating(byval object as GObject ptr)
declare sub g_object_run_dispose(byval object as GObject ptr)
declare sub g_value_take_object(byval value as GValue ptr, byval v_object as gpointer)
declare sub g_value_set_object_take_ownership(byval value as GValue ptr, byval v_object as gpointer)
declare function g_object_compat_control(byval what as gsize, byval data as gpointer) as gsize
#macro G_OBJECT_WARN_INVALID_PSPEC(object, pname, property_id, pspec)
	scope
		dim _glib__object as GObject ptr = cptr(GObject ptr, (object))
		dim _glib__pspec as GParamSpec ptr = cptr(GParamSpec ptr, (pspec))
		dim _glib__property_id as guint = (property_id)
		g_warning("%s:%d: invalid %s id %u for ""%s"" of type '%s' in '%s'", __FILE__, __LINE__, (pname), _glib__property_id, _glib__pspec->name, g_type_name(G_PARAM_SPEC_TYPE(_glib__pspec)), G_OBJECT_TYPE_NAME(_glib__object))
	end scope
#endmacro
#define G_OBJECT_WARN_INVALID_PROPERTY_ID(object, property_id, pspec) G_OBJECT_WARN_INVALID_PSPEC((object), "property", (property_id), (pspec))
declare sub g_clear_object_ alias "g_clear_object"(byval object_ptr as GObject ptr ptr)
#define g_clear_object(object_ptr) g_clear_pointer((object_ptr), g_object_unref)

private function g_set_object_ alias "g_set_object"(byval object_ptr as GObject ptr ptr, byval new_object as GObject ptr) as gboolean
	if (*object_ptr) = new_object then
		return 0
	end if
	if new_object <> cptr(any ptr, 0) then
		g_object_ref(new_object)
	end if
	if (*object_ptr) <> cptr(any ptr, 0) then
		g_object_unref(*object_ptr)
	end if
	(*object_ptr) = new_object
	return -(0 = 0)
end function

#define g_set_object(object_ptr, new_object) g_set_object_(cptr(GObject ptr ptr, (object_ptr)), cptr(GObject ptr, (new_object)))

union GWeakRef_priv
	p as gpointer
end union

type GWeakRef
	priv as GWeakRef_priv
end type

declare sub g_weak_ref_init(byval weak_ref as GWeakRef ptr, byval object as gpointer)
declare sub g_weak_ref_clear(byval weak_ref as GWeakRef ptr)
declare function g_weak_ref_get(byval weak_ref as GWeakRef ptr) as gpointer
declare sub g_weak_ref_set(byval weak_ref as GWeakRef ptr, byval object as gpointer)

#define G_TYPE_BINDING_FLAGS g_binding_flags_get_type()
#define G_TYPE_BINDING g_binding_get_type()
#define G_BINDING(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), G_TYPE_BINDING, GBinding)
#define G_IS_BINDING(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), G_TYPE_BINDING)
type GBinding as _GBinding
type GBindingTransformFunc as function(byval binding as GBinding ptr, byval from_value as const GValue ptr, byval to_value as GValue ptr, byval user_data as gpointer) as gboolean

type GBindingFlags as long
enum
	G_BINDING_DEFAULT = 0
	G_BINDING_BIDIRECTIONAL = 1 shl 0
	G_BINDING_SYNC_CREATE = 1 shl 1
	G_BINDING_INVERT_BOOLEAN = 1 shl 2
end enum

declare function g_binding_flags_get_type() as GType
declare function g_binding_get_type() as GType
declare function g_binding_get_flags(byval binding as GBinding ptr) as GBindingFlags
declare function g_binding_get_source(byval binding as GBinding ptr) as GObject ptr
declare function g_binding_get_target(byval binding as GBinding ptr) as GObject ptr
declare function g_binding_get_source_property(byval binding as GBinding ptr) as const gchar ptr
declare function g_binding_get_target_property(byval binding as GBinding ptr) as const gchar ptr
declare sub g_binding_unbind(byval binding as GBinding ptr)
declare function g_object_bind_property(byval source as gpointer, byval source_property as const gchar ptr, byval target as gpointer, byval target_property as const gchar ptr, byval flags as GBindingFlags) as GBinding ptr
declare function g_object_bind_property_full(byval source as gpointer, byval source_property as const gchar ptr, byval target as gpointer, byval target_property as const gchar ptr, byval flags as GBindingFlags, byval transform_to as GBindingTransformFunc, byval transform_from as GBindingTransformFunc, byval user_data as gpointer, byval notify as GDestroyNotify) as GBinding ptr
declare function g_object_bind_property_with_closures(byval source as gpointer, byval source_property as const gchar ptr, byval target as gpointer, byval target_property as const gchar ptr, byval flags as GBindingFlags, byval transform_to as GClosure ptr, byval transform_from as GClosure ptr) as GBinding ptr

#define __G_ENUMS_H__
#define G_TYPE_IS_ENUM(type) (G_TYPE_FUNDAMENTAL(type) = G_TYPE_ENUM)
#define G_ENUM_CLASS(class) G_TYPE_CHECK_CLASS_CAST((class), G_TYPE_ENUM, GEnumClass)
#define G_IS_ENUM_CLASS(class) G_TYPE_CHECK_CLASS_TYPE((class), G_TYPE_ENUM)
#define G_ENUM_CLASS_TYPE(class) G_TYPE_FROM_CLASS(class)
#define G_ENUM_CLASS_TYPE_NAME(class) g_type_name(G_ENUM_CLASS_TYPE(class))
#define G_TYPE_IS_FLAGS(type) (G_TYPE_FUNDAMENTAL(type) = G_TYPE_FLAGS)
#define G_FLAGS_CLASS(class) G_TYPE_CHECK_CLASS_CAST((class), G_TYPE_FLAGS, GFlagsClass)
#define G_IS_FLAGS_CLASS(class) G_TYPE_CHECK_CLASS_TYPE((class), G_TYPE_FLAGS)
#define G_FLAGS_CLASS_TYPE(class) G_TYPE_FROM_CLASS(class)
#define G_FLAGS_CLASS_TYPE_NAME(class) g_type_name(G_FLAGS_CLASS_TYPE(class))
#define G_VALUE_HOLDS_ENUM(value) G_TYPE_CHECK_VALUE_TYPE((value), G_TYPE_ENUM)
#define G_VALUE_HOLDS_FLAGS(value) G_TYPE_CHECK_VALUE_TYPE((value), G_TYPE_FLAGS)

type GEnumClass as _GEnumClass
type GFlagsClass as _GFlagsClass
type GEnumValue as _GEnumValue
type GFlagsValue as _GFlagsValue

type _GEnumClass
	g_type_class as GTypeClass
	minimum as gint
	maximum as gint
	n_values as guint
	values as GEnumValue ptr
end type

type _GFlagsClass
	g_type_class as GTypeClass
	mask as guint
	n_values as guint
	values as GFlagsValue ptr
end type

type _GEnumValue
	value as gint
	value_name as const gchar ptr
	value_nick as const gchar ptr
end type

type _GFlagsValue
	value as guint
	value_name as const gchar ptr
	value_nick as const gchar ptr
end type

declare function g_enum_get_value(byval enum_class as GEnumClass ptr, byval value as gint) as GEnumValue ptr
declare function g_enum_get_value_by_name(byval enum_class as GEnumClass ptr, byval name as const gchar ptr) as GEnumValue ptr
declare function g_enum_get_value_by_nick(byval enum_class as GEnumClass ptr, byval nick as const gchar ptr) as GEnumValue ptr
declare function g_flags_get_first_value(byval flags_class as GFlagsClass ptr, byval value as guint) as GFlagsValue ptr
declare function g_flags_get_value_by_name(byval flags_class as GFlagsClass ptr, byval name as const gchar ptr) as GFlagsValue ptr
declare function g_flags_get_value_by_nick(byval flags_class as GFlagsClass ptr, byval nick as const gchar ptr) as GFlagsValue ptr
declare sub g_value_set_enum(byval value as GValue ptr, byval v_enum as gint)
declare function g_value_get_enum(byval value as const GValue ptr) as gint
declare sub g_value_set_flags(byval value as GValue ptr, byval v_flags as guint)
declare function g_value_get_flags(byval value as const GValue ptr) as guint
declare function g_enum_register_static(byval name as const gchar ptr, byval const_static_values as const GEnumValue ptr) as GType
declare function g_flags_register_static(byval name as const gchar ptr, byval const_static_values as const GFlagsValue ptr) as GType
declare sub g_enum_complete_type_info(byval g_enum_type as GType, byval info as GTypeInfo ptr, byval const_values as const GEnumValue ptr)
declare sub g_flags_complete_type_info(byval g_flags_type as GType, byval info as GTypeInfo ptr, byval const_values as const GFlagsValue ptr)

#define __G_PARAMSPECS_H__
#define G_TYPE_PARAM_CHAR g_param_spec_types[0]
#define G_IS_PARAM_SPEC_CHAR(pspec) G_TYPE_CHECK_INSTANCE_TYPE((pspec), G_TYPE_PARAM_CHAR)
#define G_PARAM_SPEC_CHAR(pspec) G_TYPE_CHECK_INSTANCE_CAST((pspec), G_TYPE_PARAM_CHAR, GParamSpecChar)
#define G_TYPE_PARAM_UCHAR g_param_spec_types[1]
#define G_IS_PARAM_SPEC_UCHAR(pspec) G_TYPE_CHECK_INSTANCE_TYPE((pspec), G_TYPE_PARAM_UCHAR)
#define G_PARAM_SPEC_UCHAR(pspec) G_TYPE_CHECK_INSTANCE_CAST((pspec), G_TYPE_PARAM_UCHAR, GParamSpecUChar)
#define G_TYPE_PARAM_BOOLEAN g_param_spec_types[2]
#define G_IS_PARAM_SPEC_BOOLEAN(pspec) G_TYPE_CHECK_INSTANCE_TYPE((pspec), G_TYPE_PARAM_BOOLEAN)
#define G_PARAM_SPEC_BOOLEAN(pspec) G_TYPE_CHECK_INSTANCE_CAST((pspec), G_TYPE_PARAM_BOOLEAN, GParamSpecBoolean)
#define G_TYPE_PARAM_INT g_param_spec_types[3]
#define G_IS_PARAM_SPEC_INT(pspec) G_TYPE_CHECK_INSTANCE_TYPE((pspec), G_TYPE_PARAM_INT)
#define G_PARAM_SPEC_INT(pspec) G_TYPE_CHECK_INSTANCE_CAST((pspec), G_TYPE_PARAM_INT, GParamSpecInt)
#define G_TYPE_PARAM_UINT g_param_spec_types[4]
#define G_IS_PARAM_SPEC_UINT(pspec) G_TYPE_CHECK_INSTANCE_TYPE((pspec), G_TYPE_PARAM_UINT)
#define G_PARAM_SPEC_UINT(pspec) G_TYPE_CHECK_INSTANCE_CAST((pspec), G_TYPE_PARAM_UINT, GParamSpecUInt)
#define G_TYPE_PARAM_LONG g_param_spec_types[5]
#define G_IS_PARAM_SPEC_LONG(pspec) G_TYPE_CHECK_INSTANCE_TYPE((pspec), G_TYPE_PARAM_LONG)
#define G_PARAM_SPEC_LONG(pspec) G_TYPE_CHECK_INSTANCE_CAST((pspec), G_TYPE_PARAM_LONG, GParamSpecLong)
#define G_TYPE_PARAM_ULONG g_param_spec_types[6]
#define G_IS_PARAM_SPEC_ULONG(pspec) G_TYPE_CHECK_INSTANCE_TYPE((pspec), G_TYPE_PARAM_ULONG)
#define G_PARAM_SPEC_ULONG(pspec) G_TYPE_CHECK_INSTANCE_CAST((pspec), G_TYPE_PARAM_ULONG, GParamSpecULong)
#define G_TYPE_PARAM_INT64 g_param_spec_types[7]
#define G_IS_PARAM_SPEC_INT64(pspec) G_TYPE_CHECK_INSTANCE_TYPE((pspec), G_TYPE_PARAM_INT64)
#define G_PARAM_SPEC_INT64(pspec) G_TYPE_CHECK_INSTANCE_CAST((pspec), G_TYPE_PARAM_INT64, GParamSpecInt64)
#define G_TYPE_PARAM_UINT64 g_param_spec_types[8]
#define G_IS_PARAM_SPEC_UINT64(pspec) G_TYPE_CHECK_INSTANCE_TYPE((pspec), G_TYPE_PARAM_UINT64)
#define G_PARAM_SPEC_UINT64(pspec) G_TYPE_CHECK_INSTANCE_CAST((pspec), G_TYPE_PARAM_UINT64, GParamSpecUInt64)
#define G_TYPE_PARAM_UNICHAR g_param_spec_types[9]
#define G_PARAM_SPEC_UNICHAR(pspec) G_TYPE_CHECK_INSTANCE_CAST((pspec), G_TYPE_PARAM_UNICHAR, GParamSpecUnichar)
#define G_IS_PARAM_SPEC_UNICHAR(pspec) G_TYPE_CHECK_INSTANCE_TYPE((pspec), G_TYPE_PARAM_UNICHAR)
#define G_TYPE_PARAM_ENUM g_param_spec_types[10]
#define G_IS_PARAM_SPEC_ENUM(pspec) G_TYPE_CHECK_INSTANCE_TYPE((pspec), G_TYPE_PARAM_ENUM)
#define G_PARAM_SPEC_ENUM(pspec) G_TYPE_CHECK_INSTANCE_CAST((pspec), G_TYPE_PARAM_ENUM, GParamSpecEnum)
#define G_TYPE_PARAM_FLAGS g_param_spec_types[11]
#define G_IS_PARAM_SPEC_FLAGS(pspec) G_TYPE_CHECK_INSTANCE_TYPE((pspec), G_TYPE_PARAM_FLAGS)
#define G_PARAM_SPEC_FLAGS(pspec) G_TYPE_CHECK_INSTANCE_CAST((pspec), G_TYPE_PARAM_FLAGS, GParamSpecFlags)
#define G_TYPE_PARAM_FLOAT g_param_spec_types[12]
#define G_IS_PARAM_SPEC_FLOAT(pspec) G_TYPE_CHECK_INSTANCE_TYPE((pspec), G_TYPE_PARAM_FLOAT)
#define G_PARAM_SPEC_FLOAT(pspec) G_TYPE_CHECK_INSTANCE_CAST((pspec), G_TYPE_PARAM_FLOAT, GParamSpecFloat)
#define G_TYPE_PARAM_DOUBLE g_param_spec_types[13]
#define G_IS_PARAM_SPEC_DOUBLE(pspec) G_TYPE_CHECK_INSTANCE_TYPE((pspec), G_TYPE_PARAM_DOUBLE)
#define G_PARAM_SPEC_DOUBLE(pspec) G_TYPE_CHECK_INSTANCE_CAST((pspec), G_TYPE_PARAM_DOUBLE, GParamSpecDouble)
#define G_TYPE_PARAM_STRING g_param_spec_types[14]
#define G_IS_PARAM_SPEC_STRING(pspec) G_TYPE_CHECK_INSTANCE_TYPE((pspec), G_TYPE_PARAM_STRING)
#define G_PARAM_SPEC_STRING(pspec) G_TYPE_CHECK_INSTANCE_CAST((pspec), G_TYPE_PARAM_STRING, GParamSpecString)
#define G_TYPE_PARAM_PARAM g_param_spec_types[15]
#define G_IS_PARAM_SPEC_PARAM(pspec) G_TYPE_CHECK_INSTANCE_TYPE((pspec), G_TYPE_PARAM_PARAM)
#define G_PARAM_SPEC_PARAM(pspec) G_TYPE_CHECK_INSTANCE_CAST((pspec), G_TYPE_PARAM_PARAM, GParamSpecParam)
#define G_TYPE_PARAM_BOXED g_param_spec_types[16]
#define G_IS_PARAM_SPEC_BOXED(pspec) G_TYPE_CHECK_INSTANCE_TYPE((pspec), G_TYPE_PARAM_BOXED)
#define G_PARAM_SPEC_BOXED(pspec) G_TYPE_CHECK_INSTANCE_CAST((pspec), G_TYPE_PARAM_BOXED, GParamSpecBoxed)
#define G_TYPE_PARAM_POINTER g_param_spec_types[17]
#define G_IS_PARAM_SPEC_POINTER(pspec) G_TYPE_CHECK_INSTANCE_TYPE((pspec), G_TYPE_PARAM_POINTER)
#define G_PARAM_SPEC_POINTER(pspec) G_TYPE_CHECK_INSTANCE_CAST((pspec), G_TYPE_PARAM_POINTER, GParamSpecPointer)
#define G_TYPE_PARAM_VALUE_ARRAY g_param_spec_types[18]
#define G_IS_PARAM_SPEC_VALUE_ARRAY(pspec) G_TYPE_CHECK_INSTANCE_TYPE((pspec), G_TYPE_PARAM_VALUE_ARRAY)
#define G_PARAM_SPEC_VALUE_ARRAY(pspec) G_TYPE_CHECK_INSTANCE_CAST((pspec), G_TYPE_PARAM_VALUE_ARRAY, GParamSpecValueArray)
#define G_TYPE_PARAM_OBJECT g_param_spec_types[19]
#define G_IS_PARAM_SPEC_OBJECT(pspec) G_TYPE_CHECK_INSTANCE_TYPE((pspec), G_TYPE_PARAM_OBJECT)
#define G_PARAM_SPEC_OBJECT(pspec) G_TYPE_CHECK_INSTANCE_CAST((pspec), G_TYPE_PARAM_OBJECT, GParamSpecObject)
#define G_TYPE_PARAM_OVERRIDE g_param_spec_types[20]
#define G_IS_PARAM_SPEC_OVERRIDE(pspec) G_TYPE_CHECK_INSTANCE_TYPE((pspec), G_TYPE_PARAM_OVERRIDE)
#define G_PARAM_SPEC_OVERRIDE(pspec) G_TYPE_CHECK_INSTANCE_CAST((pspec), G_TYPE_PARAM_OVERRIDE, GParamSpecOverride)
#define G_TYPE_PARAM_GTYPE g_param_spec_types[21]
#define G_IS_PARAM_SPEC_GTYPE(pspec) G_TYPE_CHECK_INSTANCE_TYPE((pspec), G_TYPE_PARAM_GTYPE)
#define G_PARAM_SPEC_GTYPE(pspec) G_TYPE_CHECK_INSTANCE_CAST((pspec), G_TYPE_PARAM_GTYPE, GParamSpecGType)
#define G_TYPE_PARAM_VARIANT g_param_spec_types[22]
#define G_IS_PARAM_SPEC_VARIANT(pspec) G_TYPE_CHECK_INSTANCE_TYPE((pspec), G_TYPE_PARAM_VARIANT)
#define G_PARAM_SPEC_VARIANT(pspec) G_TYPE_CHECK_INSTANCE_CAST((pspec), G_TYPE_PARAM_VARIANT, GParamSpecVariant)

type GParamSpecChar as _GParamSpecChar
type GParamSpecUChar as _GParamSpecUChar
type GParamSpecBoolean as _GParamSpecBoolean
type GParamSpecInt as _GParamSpecInt
type GParamSpecUInt as _GParamSpecUInt
type GParamSpecLong as _GParamSpecLong
type GParamSpecULong as _GParamSpecULong
type GParamSpecInt64 as _GParamSpecInt64
type GParamSpecUInt64 as _GParamSpecUInt64
type GParamSpecUnichar as _GParamSpecUnichar
type GParamSpecEnum as _GParamSpecEnum
type GParamSpecFlags as _GParamSpecFlags
type GParamSpecFloat as _GParamSpecFloat
type GParamSpecDouble as _GParamSpecDouble
type GParamSpecString as _GParamSpecString
type GParamSpecParam as _GParamSpecParam
type GParamSpecBoxed as _GParamSpecBoxed
type GParamSpecPointer as _GParamSpecPointer
type GParamSpecValueArray as _GParamSpecValueArray
type GParamSpecObject as _GParamSpecObject
type GParamSpecOverride as _GParamSpecOverride
type GParamSpecGType as _GParamSpecGType
type GParamSpecVariant as _GParamSpecVariant

type _GParamSpecChar
	parent_instance as GParamSpec
	minimum as gint8
	maximum as gint8
	default_value as gint8
end type

type _GParamSpecUChar
	parent_instance as GParamSpec
	minimum as guint8
	maximum as guint8
	default_value as guint8
end type

type _GParamSpecBoolean
	parent_instance as GParamSpec
	default_value as gboolean
end type

type _GParamSpecInt
	parent_instance as GParamSpec
	minimum as gint
	maximum as gint
	default_value as gint
end type

type _GParamSpecUInt
	parent_instance as GParamSpec
	minimum as guint
	maximum as guint
	default_value as guint
end type

type _GParamSpecLong
	parent_instance as GParamSpec
	minimum as glong
	maximum as glong
	default_value as glong
end type

type _GParamSpecULong
	parent_instance as GParamSpec
	minimum as gulong
	maximum as gulong
	default_value as gulong
end type

type _GParamSpecInt64
	parent_instance as GParamSpec
	minimum as gint64
	maximum as gint64
	default_value as gint64
end type

type _GParamSpecUInt64
	parent_instance as GParamSpec
	minimum as guint64
	maximum as guint64
	default_value as guint64
end type

type _GParamSpecUnichar
	parent_instance as GParamSpec
	default_value as gunichar
end type

type _GParamSpecEnum
	parent_instance as GParamSpec
	enum_class as GEnumClass ptr
	default_value as gint
end type

type _GParamSpecFlags
	parent_instance as GParamSpec
	flags_class as GFlagsClass ptr
	default_value as guint
end type

type _GParamSpecFloat
	parent_instance as GParamSpec
	minimum as gfloat
	maximum as gfloat
	default_value as gfloat
	epsilon as gfloat
end type

type _GParamSpecDouble
	parent_instance as GParamSpec
	minimum as gdouble
	maximum as gdouble
	default_value as gdouble
	epsilon as gdouble
end type

type _GParamSpecString
	parent_instance as GParamSpec
	default_value as gchar ptr
	cset_first as gchar ptr
	cset_nth as gchar ptr
	substitutor as byte
	null_fold_if_empty : 1 as guint
	ensure_non_null : 1 as guint
end type

type _GParamSpecParam
	parent_instance as GParamSpec
end type

type _GParamSpecBoxed
	parent_instance as GParamSpec
end type

type _GParamSpecPointer
	parent_instance as GParamSpec
end type

type _GParamSpecValueArray
	parent_instance as GParamSpec
	element_spec as GParamSpec ptr
	fixed_n_elements as guint
end type

type _GParamSpecObject
	parent_instance as GParamSpec
end type

type _GParamSpecOverride
	parent_instance as GParamSpec
	overridden as GParamSpec ptr
end type

type _GParamSpecGType
	parent_instance as GParamSpec
	is_a_type as GType
end type

type _GParamSpecVariant
	parent_instance as GParamSpec
	as GVariantType ptr type
	default_value as GVariant ptr
	padding(0 to 3) as gpointer
end type

declare function g_param_spec_char_ alias "g_param_spec_char"(byval name as const gchar ptr, byval nick as const gchar ptr, byval blurb as const gchar ptr, byval minimum as gint8, byval maximum as gint8, byval default_value as gint8, byval flags as GParamFlags) as GParamSpec ptr
declare function g_param_spec_uchar_ alias "g_param_spec_uchar"(byval name as const gchar ptr, byval nick as const gchar ptr, byval blurb as const gchar ptr, byval minimum as guint8, byval maximum as guint8, byval default_value as guint8, byval flags as GParamFlags) as GParamSpec ptr
declare function g_param_spec_boolean_ alias "g_param_spec_boolean"(byval name as const gchar ptr, byval nick as const gchar ptr, byval blurb as const gchar ptr, byval default_value as gboolean, byval flags as GParamFlags) as GParamSpec ptr
declare function g_param_spec_int_ alias "g_param_spec_int"(byval name as const gchar ptr, byval nick as const gchar ptr, byval blurb as const gchar ptr, byval minimum as gint, byval maximum as gint, byval default_value as gint, byval flags as GParamFlags) as GParamSpec ptr
declare function g_param_spec_uint_ alias "g_param_spec_uint"(byval name as const gchar ptr, byval nick as const gchar ptr, byval blurb as const gchar ptr, byval minimum as guint, byval maximum as guint, byval default_value as guint, byval flags as GParamFlags) as GParamSpec ptr
declare function g_param_spec_long_ alias "g_param_spec_long"(byval name as const gchar ptr, byval nick as const gchar ptr, byval blurb as const gchar ptr, byval minimum as glong, byval maximum as glong, byval default_value as glong, byval flags as GParamFlags) as GParamSpec ptr
declare function g_param_spec_ulong_ alias "g_param_spec_ulong"(byval name as const gchar ptr, byval nick as const gchar ptr, byval blurb as const gchar ptr, byval minimum as gulong, byval maximum as gulong, byval default_value as gulong, byval flags as GParamFlags) as GParamSpec ptr
declare function g_param_spec_int64_ alias "g_param_spec_int64"(byval name as const gchar ptr, byval nick as const gchar ptr, byval blurb as const gchar ptr, byval minimum as gint64, byval maximum as gint64, byval default_value as gint64, byval flags as GParamFlags) as GParamSpec ptr
declare function g_param_spec_uint64_ alias "g_param_spec_uint64"(byval name as const gchar ptr, byval nick as const gchar ptr, byval blurb as const gchar ptr, byval minimum as guint64, byval maximum as guint64, byval default_value as guint64, byval flags as GParamFlags) as GParamSpec ptr
declare function g_param_spec_unichar_ alias "g_param_spec_unichar"(byval name as const gchar ptr, byval nick as const gchar ptr, byval blurb as const gchar ptr, byval default_value as gunichar, byval flags as GParamFlags) as GParamSpec ptr
declare function g_param_spec_enum_ alias "g_param_spec_enum"(byval name as const gchar ptr, byval nick as const gchar ptr, byval blurb as const gchar ptr, byval enum_type as GType, byval default_value as gint, byval flags as GParamFlags) as GParamSpec ptr
declare function g_param_spec_flags_ alias "g_param_spec_flags"(byval name as const gchar ptr, byval nick as const gchar ptr, byval blurb as const gchar ptr, byval flags_type as GType, byval default_value as guint, byval flags as GParamFlags) as GParamSpec ptr
declare function g_param_spec_float_ alias "g_param_spec_float"(byval name as const gchar ptr, byval nick as const gchar ptr, byval blurb as const gchar ptr, byval minimum as gfloat, byval maximum as gfloat, byval default_value as gfloat, byval flags as GParamFlags) as GParamSpec ptr
declare function g_param_spec_double_ alias "g_param_spec_double"(byval name as const gchar ptr, byval nick as const gchar ptr, byval blurb as const gchar ptr, byval minimum as gdouble, byval maximum as gdouble, byval default_value as gdouble, byval flags as GParamFlags) as GParamSpec ptr
declare function g_param_spec_string_ alias "g_param_spec_string"(byval name as const gchar ptr, byval nick as const gchar ptr, byval blurb as const gchar ptr, byval default_value as const gchar ptr, byval flags as GParamFlags) as GParamSpec ptr
declare function g_param_spec_param_ alias "g_param_spec_param"(byval name as const gchar ptr, byval nick as const gchar ptr, byval blurb as const gchar ptr, byval param_type as GType, byval flags as GParamFlags) as GParamSpec ptr
declare function g_param_spec_boxed_ alias "g_param_spec_boxed"(byval name as const gchar ptr, byval nick as const gchar ptr, byval blurb as const gchar ptr, byval boxed_type as GType, byval flags as GParamFlags) as GParamSpec ptr
declare function g_param_spec_pointer_ alias "g_param_spec_pointer"(byval name as const gchar ptr, byval nick as const gchar ptr, byval blurb as const gchar ptr, byval flags as GParamFlags) as GParamSpec ptr
declare function g_param_spec_value_array_ alias "g_param_spec_value_array"(byval name as const gchar ptr, byval nick as const gchar ptr, byval blurb as const gchar ptr, byval element_spec as GParamSpec ptr, byval flags as GParamFlags) as GParamSpec ptr
declare function g_param_spec_object_ alias "g_param_spec_object"(byval name as const gchar ptr, byval nick as const gchar ptr, byval blurb as const gchar ptr, byval object_type as GType, byval flags as GParamFlags) as GParamSpec ptr
declare function g_param_spec_override_ alias "g_param_spec_override"(byval name as const gchar ptr, byval overridden as GParamSpec ptr) as GParamSpec ptr
declare function g_param_spec_gtype_ alias "g_param_spec_gtype"(byval name as const gchar ptr, byval nick as const gchar ptr, byval blurb as const gchar ptr, byval is_a_type as GType, byval flags as GParamFlags) as GParamSpec ptr
declare function g_param_spec_variant_ alias "g_param_spec_variant"(byval name as const gchar ptr, byval nick as const gchar ptr, byval blurb as const gchar ptr, byval type as const GVariantType ptr, byval default_value as GVariant ptr, byval flags as GParamFlags) as GParamSpec ptr

#if defined(__FB_WIN32__) or defined(__FB_CYGWIN__)
	extern import g_param_spec_types as GType ptr
#else
	extern g_param_spec_types as GType ptr
#endif

#define __G_SOURCECLOSURE_H__
declare sub g_source_set_closure(byval source as GSource ptr, byval closure as GClosure ptr)
declare sub g_source_set_dummy_callback(byval source as GSource ptr)
#define __G_TYPE_MODULE_H__
type GTypeModule as _GTypeModule
type GTypeModuleClass as _GTypeModuleClass
#define G_TYPE_TYPE_MODULE g_type_module_get_type()
#define G_TYPE_MODULE(module) G_TYPE_CHECK_INSTANCE_CAST((module), G_TYPE_TYPE_MODULE, GTypeModule)
#define G_TYPE_MODULE_CLASS(class) G_TYPE_CHECK_CLASS_CAST((class), G_TYPE_TYPE_MODULE, GTypeModuleClass)
#define G_IS_TYPE_MODULE(module) G_TYPE_CHECK_INSTANCE_TYPE((module), G_TYPE_TYPE_MODULE)
#define G_IS_TYPE_MODULE_CLASS(class) G_TYPE_CHECK_CLASS_TYPE((class), G_TYPE_TYPE_MODULE)
#define G_TYPE_MODULE_GET_CLASS(module) G_TYPE_INSTANCE_GET_CLASS((module), G_TYPE_TYPE_MODULE, GTypeModuleClass)

type _GTypeModule
	parent_instance as GObject
	use_count as guint
	type_infos as GSList ptr
	interface_infos as GSList ptr
	name as gchar ptr
end type

type _GTypeModuleClass
	parent_class as GObjectClass
	load as function(byval module as GTypeModule ptr) as gboolean
	unload as sub(byval module as GTypeModule ptr)
	reserved1 as sub()
	reserved2 as sub()
	reserved3 as sub()
	reserved4 as sub()
end type

#define G_DEFINE_DYNAMIC_TYPE(TN, t_n, T_P) G_DEFINE_DYNAMIC_TYPE_EXTENDED(TN, t_n, T_P, 0, )
#macro G_DEFINE_DYNAMIC_TYPE_EXTENDED(TypeName, type_name, TYPE_PARENT, flags, CODE)
	extern "C"
		declare sub type_name##_init(byval self as TypeName ptr)
		declare sub type_name##_class_init(byval klass as TypeName##Class ptr)
		declare sub type_name##_class_finalize(byval klass as TypeName##Class ptr)
		dim shared as gpointer type_name##_parent_class = NULL
		dim shared as GType type_name##_type_id = 0
		dim shared as gint TypeName##_private_offset
		_G_DEFINE_TYPE_EXTENDED_CLASS_INIT(TypeName, type_name)
		private function type_name##_get_instance_private(byval self as TypeName ptr) as gpointer
			return G_STRUCT_MEMBER_P(self, TypeName##_private_offset)
		end function
		function type_name##_get_type() as GType
			return type_name##_type_id
		end function
		private sub type_name##_register_type(byval type_module as GTypeModule ptr)
			dim as GType g_define_type_id
			dim as const GTypeInfo g_define_type_info = ( _
				sizeof(TypeName##Class), _
				cast(GBaseInitFunc, NULL), _
				cast(GBaseFinalizeFunc, NULL), _
				cast(GClassInitFunc, @type_name##_class_intern_init), _
				cast(GClassFinalizeFunc, @type_name##_class_finalize), _
				NULL, _
				sizeof(TypeName), _
				0, _
				cast(GInstanceInitFunc, @type_name##_init), _
				NULL
			)
			type_name##_type_id = g_type_module_register_type( _
				type_module, _
				TYPE_PARENT, _
				#TypeName, _
				@g_define_type_info, _
				cast(GTypeFlags, flags) _
			)
			g_define_type_id = type_name##_type_id
			scope
				CODE
			end scope
		end sub
	end extern
#endmacro
#macro G_IMPLEMENT_INTERFACE_DYNAMIC(TYPE_IFACE, iface_init)
	scope
		dim g_implement_interface_info as const GInterfaceInfo = (cast(GInterfaceInitFunc, iface_init), NULL, NULL)
		g_type_module_add_interface(type_module, g_define_type_id, TYPE_IFACE, @g_implement_interface_info)
	end scope
#endmacro
#macro G_ADD_PRIVATE_DYNAMIC(TypeName)
	scope
		TypeName##_private_offset = sizeof(TypeName##Private)
	end scope
#endmacro
declare function g_type_module_get_type() as GType
declare function g_type_module_use(byval module as GTypeModule ptr) as gboolean
declare sub g_type_module_unuse(byval module as GTypeModule ptr)
declare sub g_type_module_set_name(byval module as GTypeModule ptr, byval name as const gchar ptr)
declare function g_type_module_register_type(byval module as GTypeModule ptr, byval parent_type as GType, byval type_name as const gchar ptr, byval type_info as const GTypeInfo ptr, byval flags as GTypeFlags) as GType
declare sub g_type_module_add_interface(byval module as GTypeModule ptr, byval instance_type as GType, byval interface_type as GType, byval interface_info as const GInterfaceInfo ptr)
declare function g_type_module_register_enum(byval module as GTypeModule ptr, byval name as const gchar ptr, byval const_static_values as const GEnumValue ptr) as GType
declare function g_type_module_register_flags(byval module as GTypeModule ptr, byval name as const gchar ptr, byval const_static_values as const GFlagsValue ptr) as GType
#define __G_TYPE_PLUGIN_H__
#define G_TYPE_TYPE_PLUGIN g_type_plugin_get_type()
#define G_TYPE_PLUGIN(inst) G_TYPE_CHECK_INSTANCE_CAST((inst), G_TYPE_TYPE_PLUGIN, GTypePlugin)
#define G_TYPE_PLUGIN_CLASS(vtable) G_TYPE_CHECK_CLASS_CAST((vtable), G_TYPE_TYPE_PLUGIN, GTypePluginClass)
#define G_IS_TYPE_PLUGIN(inst) G_TYPE_CHECK_INSTANCE_TYPE((inst), G_TYPE_TYPE_PLUGIN)
#define G_IS_TYPE_PLUGIN_CLASS(vtable) G_TYPE_CHECK_CLASS_TYPE((vtable), G_TYPE_TYPE_PLUGIN)
#define G_TYPE_PLUGIN_GET_CLASS(inst) G_TYPE_INSTANCE_GET_INTERFACE((inst), G_TYPE_TYPE_PLUGIN, GTypePluginClass)
type GTypePluginClass as _GTypePluginClass
type GTypePluginUse as sub(byval plugin as GTypePlugin ptr)
type GTypePluginUnuse as sub(byval plugin as GTypePlugin ptr)
type GTypePluginCompleteTypeInfo as sub(byval plugin as GTypePlugin ptr, byval g_type as GType, byval info as GTypeInfo ptr, byval value_table as GTypeValueTable ptr)
type GTypePluginCompleteInterfaceInfo as sub(byval plugin as GTypePlugin ptr, byval instance_type as GType, byval interface_type as GType, byval info as GInterfaceInfo ptr)

type _GTypePluginClass
	base_iface as GTypeInterface
	use_plugin as GTypePluginUse
	unuse_plugin as GTypePluginUnuse
	complete_type_info as GTypePluginCompleteTypeInfo
	complete_interface_info as GTypePluginCompleteInterfaceInfo
end type

declare function g_type_plugin_get_type() as GType
declare sub g_type_plugin_use(byval plugin as GTypePlugin ptr)
declare sub g_type_plugin_unuse(byval plugin as GTypePlugin ptr)
declare sub g_type_plugin_complete_type_info(byval plugin as GTypePlugin ptr, byval g_type as GType, byval info as GTypeInfo ptr, byval value_table as GTypeValueTable ptr)
declare sub g_type_plugin_complete_interface_info(byval plugin as GTypePlugin ptr, byval instance_type as GType, byval interface_type as GType, byval info as GInterfaceInfo ptr)
#define __G_VALUE_ARRAY_H__
#define G_TYPE_VALUE_ARRAY g_value_array_get_type()
type GValueArray as _GValueArray

type _GValueArray
	n_values as guint
	values as GValue ptr
	n_prealloced as guint
end type

declare function g_value_array_get_type() as GType
declare function g_value_array_get_nth(byval value_array as GValueArray ptr, byval index_ as guint) as GValue ptr
declare function g_value_array_new(byval n_prealloced as guint) as GValueArray ptr
declare sub g_value_array_free(byval value_array as GValueArray ptr)
declare function g_value_array_copy(byval value_array as const GValueArray ptr) as GValueArray ptr
declare function g_value_array_prepend(byval value_array as GValueArray ptr, byval value as const GValue ptr) as GValueArray ptr
declare function g_value_array_append(byval value_array as GValueArray ptr, byval value as const GValue ptr) as GValueArray ptr
declare function g_value_array_insert(byval value_array as GValueArray ptr, byval index_ as guint, byval value as const GValue ptr) as GValueArray ptr
declare function g_value_array_remove(byval value_array as GValueArray ptr, byval index_ as guint) as GValueArray ptr
declare function g_value_array_sort(byval value_array as GValueArray ptr, byval compare_func as GCompareFunc) as GValueArray ptr
declare function g_value_array_sort_with_data(byval value_array as GValueArray ptr, byval compare_func as GCompareDataFunc, byval user_data as gpointer) as GValueArray ptr

#define __G_VALUETYPES_H__
#define G_VALUE_HOLDS_CHAR(value) G_TYPE_CHECK_VALUE_TYPE((value), G_TYPE_CHAR)
#define G_VALUE_HOLDS_UCHAR(value) G_TYPE_CHECK_VALUE_TYPE((value), G_TYPE_UCHAR)
#define G_VALUE_HOLDS_BOOLEAN(value) G_TYPE_CHECK_VALUE_TYPE((value), G_TYPE_BOOLEAN)
#define G_VALUE_HOLDS_INT(value) G_TYPE_CHECK_VALUE_TYPE((value), G_TYPE_INT)
#define G_VALUE_HOLDS_UINT(value) G_TYPE_CHECK_VALUE_TYPE((value), G_TYPE_UINT)
#define G_VALUE_HOLDS_LONG(value) G_TYPE_CHECK_VALUE_TYPE((value), G_TYPE_LONG)
#define G_VALUE_HOLDS_ULONG(value) G_TYPE_CHECK_VALUE_TYPE((value), G_TYPE_ULONG)
#define G_VALUE_HOLDS_INT64(value) G_TYPE_CHECK_VALUE_TYPE((value), G_TYPE_INT64)
#define G_VALUE_HOLDS_UINT64(value) G_TYPE_CHECK_VALUE_TYPE((value), G_TYPE_UINT64)
#define G_VALUE_HOLDS_FLOAT(value) G_TYPE_CHECK_VALUE_TYPE((value), G_TYPE_FLOAT)
#define G_VALUE_HOLDS_DOUBLE(value) G_TYPE_CHECK_VALUE_TYPE((value), G_TYPE_DOUBLE)
#define G_VALUE_HOLDS_STRING(value) G_TYPE_CHECK_VALUE_TYPE((value), G_TYPE_STRING)
#define G_VALUE_HOLDS_POINTER(value) G_TYPE_CHECK_VALUE_TYPE((value), G_TYPE_POINTER)
#define G_TYPE_GTYPE g_gtype_get_type()
#define G_VALUE_HOLDS_GTYPE(value) G_TYPE_CHECK_VALUE_TYPE((value), G_TYPE_GTYPE)
#define G_VALUE_HOLDS_VARIANT(value) G_TYPE_CHECK_VALUE_TYPE((value), G_TYPE_VARIANT)

declare sub g_value_set_char(byval value as GValue ptr, byval v_char as byte)
declare function g_value_get_char(byval value as const GValue ptr) as byte
declare sub g_value_set_schar(byval value as GValue ptr, byval v_char as gint8)
declare function g_value_get_schar(byval value as const GValue ptr) as gint8
declare sub g_value_set_uchar(byval value as GValue ptr, byval v_uchar as guchar)
declare function g_value_get_uchar(byval value as const GValue ptr) as guchar
declare sub g_value_set_boolean(byval value as GValue ptr, byval v_boolean as gboolean)
declare function g_value_get_boolean(byval value as const GValue ptr) as gboolean
declare sub g_value_set_int(byval value as GValue ptr, byval v_int as gint)
declare function g_value_get_int(byval value as const GValue ptr) as gint
declare sub g_value_set_uint(byval value as GValue ptr, byval v_uint as guint)
declare function g_value_get_uint(byval value as const GValue ptr) as guint
declare sub g_value_set_long(byval value as GValue ptr, byval v_long as glong)
declare function g_value_get_long(byval value as const GValue ptr) as glong
declare sub g_value_set_ulong(byval value as GValue ptr, byval v_ulong as gulong)
declare function g_value_get_ulong(byval value as const GValue ptr) as gulong
declare sub g_value_set_int64(byval value as GValue ptr, byval v_int64 as gint64)
declare function g_value_get_int64(byval value as const GValue ptr) as gint64
declare sub g_value_set_uint64(byval value as GValue ptr, byval v_uint64 as guint64)
declare function g_value_get_uint64(byval value as const GValue ptr) as guint64
declare sub g_value_set_float(byval value as GValue ptr, byval v_float as gfloat)
declare function g_value_get_float(byval value as const GValue ptr) as gfloat
declare sub g_value_set_double(byval value as GValue ptr, byval v_double as gdouble)
declare function g_value_get_double(byval value as const GValue ptr) as gdouble
declare sub g_value_set_string(byval value as GValue ptr, byval v_string as const gchar ptr)
declare sub g_value_set_static_string(byval value as GValue ptr, byval v_string as const gchar ptr)
declare function g_value_get_string(byval value as const GValue ptr) as const gchar ptr
declare function g_value_dup_string(byval value as const GValue ptr) as gchar ptr
declare sub g_value_set_pointer(byval value as GValue ptr, byval v_pointer as gpointer)
declare function g_value_get_pointer(byval value as const GValue ptr) as gpointer
declare function g_gtype_get_type() as GType
declare sub g_value_set_gtype(byval value as GValue ptr, byval v_gtype as GType)
declare function g_value_get_gtype(byval value as const GValue ptr) as GType
declare sub g_value_set_variant(byval value as GValue ptr, byval variant as GVariant ptr)
declare sub g_value_take_variant(byval value as GValue ptr, byval variant as GVariant ptr)
declare function g_value_get_variant(byval value as const GValue ptr) as GVariant ptr
declare function g_value_dup_variant(byval value as const GValue ptr) as GVariant ptr
declare function g_pointer_type_register_static(byval name as const gchar ptr) as GType
declare function g_strdup_value_contents(byval value as const GValue ptr) as gchar ptr
declare sub g_value_take_string(byval value as GValue ptr, byval v_string as gchar ptr)
declare sub g_value_set_string_take_ownership(byval value as GValue ptr, byval v_string as gchar ptr)
type gchararray as gchar ptr

private sub glib_auto_cleanup_GStrv(byval _ptr as GStrv ptr)
	if (*_ptr) <> cptr(any ptr, 0) then
		g_strfreev(*_ptr)
	end if
end sub

type GObject_autoptr as GObject ptr

private sub glib_autoptr_cleanup_GObject(byval _ptr as GObject ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GInitiallyUnowned_autoptr as GInitiallyUnowned ptr

private sub glib_autoptr_cleanup_GInitiallyUnowned(byval _ptr as GInitiallyUnowned ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

private sub glib_auto_cleanup_GValue(byval _ptr as GValue ptr)
	g_value_unset(_ptr)
end sub

#undef __GLIB_GOBJECT_H_INSIDE__

end extern

#ifdef __FB_WIN32__
#pragma pop(msbitfields)
#endif
