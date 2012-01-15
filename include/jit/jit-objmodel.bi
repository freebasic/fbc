''
''
'' jit-objmodel -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __jit_objmodel_bi__
#define __jit_objmodel_bi__

#include "jit/jit-common.bi"

type jit_objmodel_t as jit_objmodel ptr
type jitom_class_t as jitom_class ptr
type jitom_field_t as jitom_field ptr
type jitom_method_t as jitom_method ptr

#define JITOM_MODIFIER_ACCESS_MASK &h0007
#define JITOM_MODIFIER_PUBLIC &h0000
#define JITOM_MODIFIER_PRIVATE &h0001
#define JITOM_MODIFIER_PROTECTED &h0002
#define JITOM_MODIFIER_PACKAGE &h0003
#define JITOM_MODIFIER_PACKAGE_OR_PROTECTED &h0004
#define JITOM_MODIFIER_PACKAGE_AND_PROTECTED &h0005
#define JITOM_MODIFIER_OTHER1 &h0006
#define JITOM_MODIFIER_OTHER2 &h0007
#define JITOM_MODIFIER_STATIC &h0008
#define JITOM_MODIFIER_VIRTUAL &h0010
#define JITOM_MODIFIER_NEW_SLOT &h0020
#define JITOM_MODIFIER_ABSTRACT &h0040
#define JITOM_MODIFIER_LITERAL &h0080
#define JITOM_MODIFIER_CTOR &h0100
#define JITOM_MODIFIER_STATIC_CTOR &h0200
#define JITOM_MODIFIER_DTOR &h0400
#define JITOM_MODIFIER_INTERFACE &h0800
#define JITOM_MODIFIER_VALUE &h1000
#define JITOM_MODIFIER_FINAL &h2000
#define JITOM_MODIFIER_DELETE &h4000
#define JITOM_MODIFIER_REFERENCE_COUNTED &h8000
#define JITOM_TYPETAG_CLASS 11000
#define JITOM_TYPETAG_VALUE 11001

declare sub jitom_destroy_model cdecl alias "jitom_destroy_model" (byval model as jit_objmodel_t)
declare function jitom_get_class_by_name cdecl alias "jitom_get_class_by_name" (byval model as jit_objmodel_t, byval name as zstring ptr) as jitom_class_t
declare function jitom_class_get_name cdecl alias "jitom_class_get_name" (byval model as jit_objmodel_t, byval klass as jitom_class_t) as zstring ptr
declare function jitom_class_get_modifiers cdecl alias "jitom_class_get_modifiers" (byval model as jit_objmodel_t, byval klass as jitom_class_t) as integer
declare function jitom_class_get_type cdecl alias "jitom_class_get_type" (byval model as jit_objmodel_t, byval klass as jitom_class_t) as jit_type_t
declare function jitom_class_get_value_type cdecl alias "jitom_class_get_value_type" (byval model as jit_objmodel_t, byval klass as jitom_class_t) as jit_type_t
declare function jitom_class_get_primary_super cdecl alias "jitom_class_get_primary_super" (byval model as jit_objmodel_t, byval klass as jitom_class_t) as jitom_class_t
declare function jitom_class_get_all_supers cdecl alias "jitom_class_get_all_supers" (byval model as jit_objmodel_t, byval klass as jitom_class_t, byval num as uinteger ptr) as jitom_class_t ptr
declare function jitom_class_get_interfaces cdecl alias "jitom_class_get_interfaces" (byval model as jit_objmodel_t, byval klass as jitom_class_t, byval num as uinteger ptr) as jitom_class_t ptr
declare function jitom_class_get_fields cdecl alias "jitom_class_get_fields" (byval model as jit_objmodel_t, byval klass as jitom_class_t, byval num as uinteger ptr) as jitom_field_t ptr
declare function jitom_class_get_methods cdecl alias "jitom_class_get_methods" (byval model as jit_objmodel_t, byval klass as jitom_class_t, byval num as uinteger ptr) as jitom_method_t ptr
declare function jitom_class_new cdecl alias "jitom_class_new" (byval model as jit_objmodel_t, byval klass as jitom_class_t, byval ctor as jitom_method_t, byval func as jit_function_t, byval args as jit_value_t ptr, byval num_args as uinteger, byval flags as integer) as jit_value_t
declare function jitom_class_new_value cdecl alias "jitom_class_new_value" (byval model as jit_objmodel_t, byval klass as jitom_class_t, byval ctor as jitom_method_t, byval func as jit_function_t, byval args as jit_value_t ptr, byval num_args as uinteger, byval flags as integer) as jit_value_t
declare function jitom_class_delete cdecl alias "jitom_class_delete" (byval model as jit_objmodel_t, byval klass as jitom_class_t, byval obj_value as jit_value_t) as integer
declare function jitom_class_add_ref cdecl alias "jitom_class_add_ref" (byval model as jit_objmodel_t, byval klass as jitom_class_t, byval obj_value as jit_value_t) as integer
declare function jitom_field_get_name cdecl alias "jitom_field_get_name" (byval model as jit_objmodel_t, byval klass as jitom_class_t, byval field as jitom_field_t) as zstring ptr
declare function jitom_field_get_type cdecl alias "jitom_field_get_type" (byval model as jit_objmodel_t, byval klass as jitom_class_t, byval field as jitom_field_t) as jit_type_t
declare function jitom_field_get_modifiers cdecl alias "jitom_field_get_modifiers" (byval model as jit_objmodel_t, byval klass as jitom_class_t, byval field as jitom_field_t) as integer
declare function jitom_field_load cdecl alias "jitom_field_load" (byval model as jit_objmodel_t, byval klass as jitom_class_t, byval field as jitom_field_t, byval func as jit_function_t, byval obj_value as jit_value_t) as jit_value_t
declare function jitom_field_load_address cdecl alias "jitom_field_load_address" (byval model as jit_objmodel_t, byval klass as jitom_class_t, byval field as jitom_field_t, byval func as jit_function_t, byval obj_value as jit_value_t) as jit_value_t
declare function jitom_field_store cdecl alias "jitom_field_store" (byval model as jit_objmodel_t, byval klass as jitom_class_t, byval field as jitom_field_t, byval func as jit_function_t, byval obj_value as jit_value_t, byval value as jit_value_t) as integer
declare function jitom_method_get_name cdecl alias "jitom_method_get_name" (byval model as jit_objmodel_t, byval klass as jitom_class_t, byval method as jitom_method_t) as zstring ptr
declare function jitom_method_get_type cdecl alias "jitom_method_get_type" (byval model as jit_objmodel_t, byval klass as jitom_class_t, byval method as jitom_method_t) as jit_type_t
declare function jitom_method_get_modifiers cdecl alias "jitom_method_get_modifiers" (byval model as jit_objmodel_t, byval klass as jitom_class_t, byval method as jitom_method_t) as integer
declare function jitom_method_invoke cdecl alias "jitom_method_invoke" (byval model as jit_objmodel_t, byval klass as jitom_class_t, byval method as jitom_method_t, byval func as jit_function_t, byval args as jit_value_t ptr, byval num_args as uinteger, byval flags as integer) as jit_value_t
declare function jitom_method_invoke_virtual cdecl alias "jitom_method_invoke_virtual" (byval model as jit_objmodel_t, byval klass as jitom_class_t, byval method as jitom_method_t, byval func as jit_function_t, byval args as jit_value_t ptr, byval num_args as uinteger, byval flags as integer) as jit_value_t
declare function jitom_type_tag_as_class cdecl alias "jitom_type_tag_as_class" (byval type as jit_type_t, byval model as jit_objmodel_t, byval klass as jitom_class_t, byval incref as integer) as jit_type_t
declare function jitom_type_tag_as_value cdecl alias "jitom_type_tag_as_value" (byval type as jit_type_t, byval model as jit_objmodel_t, byval klass as jitom_class_t, byval incref as integer) as jit_type_t
declare function jitom_type_is_class cdecl alias "jitom_type_is_class" (byval type as jit_type_t) as integer
declare function jitom_type_is_value cdecl alias "jitom_type_is_value" (byval type as jit_type_t) as integer
declare function jitom_type_get_model cdecl alias "jitom_type_get_model" (byval type as jit_type_t) as jit_objmodel_t
declare function jitom_type_get_class cdecl alias "jitom_type_get_class" (byval type as jit_type_t) as jitom_class_t

#endif
