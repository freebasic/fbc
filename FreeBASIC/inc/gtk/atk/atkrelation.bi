''
''
'' atkrelation -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __atkrelation_bi__
#define __atkrelation_bi__

#include once "gtk/glib-object.bi"
#include once "gtk/atk/atkrelationtype.bi"

type AtkRelation as _AtkRelation
type AtkRelationClass as _AtkRelationClass

type _AtkRelation
	parent as GObject
	target as GPtrArray ptr
	relationship as AtkRelationType
end type

type _AtkRelationClass
	parent as GObjectClass
end type

declare function atk_relation_get_type cdecl alias "atk_relation_get_type" () as GType
declare function atk_relation_type_register cdecl alias "atk_relation_type_register" (byval name as gchar ptr) as AtkRelationType
declare function atk_relation_type_get_name cdecl alias "atk_relation_type_get_name" (byval type as AtkRelationType) as gchar ptr
declare function atk_relation_type_for_name cdecl alias "atk_relation_type_for_name" (byval name as gchar ptr) as AtkRelationType
declare function atk_relation_new cdecl alias "atk_relation_new" (byval targets as AtkObject ptr ptr, byval n_targets as gint, byval relationship as AtkRelationType) as AtkRelation ptr
declare function atk_relation_get_relation_type cdecl alias "atk_relation_get_relation_type" (byval relation as AtkRelation ptr) as AtkRelationType
declare function atk_relation_get_target cdecl alias "atk_relation_get_target" (byval relation as AtkRelation ptr) as GPtrArray ptr
declare sub atk_relation_add_target cdecl alias "atk_relation_add_target" (byval relation as AtkRelation ptr, byval target as AtkObject ptr)

#endif
