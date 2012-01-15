''
''
'' jit-objmodel-private -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __jit_objmodel_private_bi__
#define __jit_objmodel_private_bi__

#include "jit/jit-objmodel.bi"

type jit_objmodel
	size as uinteger
	reserved0 as any ptr
	reserved1 as any ptr
	reserved2 as any ptr
	reserved3 as any ptr
	destroy_model as sub cdecl(byval as jit_objmodel_t)
	get_class_by_name as function cdecl(byval as jit_objmodel_t, byval as zstring ptr) as jitom_class_t
	class_get_name as function cdecl(byval as jit_objmodel_t, byval as jitom_class_t) as byte ptr
	class_get_modifiers as function cdecl(byval as jit_objmodel_t, byval as jitom_class_t) as integer
	class_get_type as function cdecl(byval as jit_objmodel_t, byval as jitom_class_t) as jit_type_t
	class_get_value_type as function cdecl(byval as jit_objmodel_t, byval as jitom_class_t) as jit_type_t
	class_get_primary_super as function cdecl(byval as jit_objmodel_t, byval as jitom_class_t) as jitom_class_t
	class_get_all_supers as function cdecl(byval as jit_objmodel_t, byval as jitom_class_t, byval as uinteger ptr) as jitom_class_t ptr
	class_get_interfaces as function cdecl(byval as jit_objmodel_t, byval as jitom_class_t, byval as uinteger ptr) as jitom_class_t ptr
	class_get_fields as function cdecl(byval as jit_objmodel_t, byval as jitom_class_t, byval as uinteger ptr) as jitom_field_t ptr
	class_get_methods as function cdecl(byval as jit_objmodel_t, byval as jitom_class_t, byval as uinteger ptr) as jitom_method_t ptr
	class_new as function cdecl(byval as jit_objmodel_t, byval as jitom_class_t, byval as jitom_method_t, byval as jit_function_t, byval as jit_value_t ptr, byval as uinteger, byval as integer) as jit_value_t
	class_new_value as function cdecl(byval as jit_objmodel_t, byval as jitom_class_t, byval as jitom_method_t, byval as jit_function_t, byval as jit_value_t ptr, byval as uinteger, byval as integer) as jit_value_t
	class_delete as function cdecl(byval as jit_objmodel_t, byval as jitom_class_t, byval as jit_value_t) as integer
	class_add_ref as function cdecl(byval as jit_objmodel_t, byval as jitom_class_t, byval as jit_value_t) as integer
	field_get_name as function cdecl(byval as jit_objmodel_t, byval as jitom_class_t, byval as jitom_field_t) as byte ptr
	field_get_type as function cdecl(byval as jit_objmodel_t, byval as jitom_class_t, byval as jitom_field_t) as jit_type_t
	field_get_modifiers as function cdecl(byval as jit_objmodel_t, byval as jitom_class_t, byval as jitom_field_t) as integer
	field_load as function cdecl(byval as jit_objmodel_t, byval as jitom_class_t, byval as jitom_field_t, byval as jit_function_t, byval as jit_value_t) as jit_value_t
	field_load_address as function cdecl(byval as jit_objmodel_t, byval as jitom_class_t, byval as jitom_field_t, byval as jit_function_t, byval as jit_value_t) as jit_value_t
	field_store as function cdecl(byval as jit_objmodel_t, byval as jitom_class_t, byval as jitom_field_t, byval as jit_function_t, byval as jit_value_t, byval as jit_value_t) as integer
	method_get_name as function cdecl(byval as jit_objmodel_t, byval as jitom_class_t, byval as jitom_method_t) as byte ptr
	method_get_type as function cdecl(byval as jit_objmodel_t, byval as jitom_class_t, byval as jitom_method_t) as jit_type_t
	method_get_modifiers as function cdecl(byval as jit_objmodel_t, byval as jitom_class_t, byval as jitom_method_t) as integer
	method_invoke as function cdecl(byval as jit_objmodel_t, byval as jitom_class_t, byval as jitom_method_t, byval as jit_function_t, byval as jit_value_t ptr, byval as uinteger, byval as integer) as jit_value_t
	method_invoke_virtual as function cdecl(byval as jit_objmodel_t, byval as jitom_class_t, byval as jitom_method_t, byval as jit_function_t, byval as jit_value_t ptr, byval as uinteger, byval as integer) as jit_value_t
end type

#endif
