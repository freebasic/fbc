''
''
'' atkrelationset -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __atkrelationset_bi__
#define __atkrelationset_bi__

#include once "gtk/glib-object.bi"
#include once "gtk/atk/atkobject.bi"
#include once "gtk/atk/atkrelation.bi"

type AtkRelationSetClass as _AtkRelationSetClass

type _AtkRelationSet
	parent as GObject
	relations as GPtrArray ptr
end type

type _AtkRelationSetClass
	parent as GObjectClass
	pad1 as AtkFunction
	pad2 as AtkFunction
end type

declare function atk_relation_set_get_type cdecl alias "atk_relation_set_get_type" () as GType
declare function atk_relation_set_new cdecl alias "atk_relation_set_new" () as AtkRelationSet ptr
declare function atk_relation_set_contains cdecl alias "atk_relation_set_contains" (byval set as AtkRelationSet ptr, byval relationship as AtkRelationType) as gboolean
declare sub atk_relation_set_remove cdecl alias "atk_relation_set_remove" (byval set as AtkRelationSet ptr, byval relation as AtkRelation ptr)
declare sub atk_relation_set_add cdecl alias "atk_relation_set_add" (byval set as AtkRelationSet ptr, byval relation as AtkRelation ptr)
declare function atk_relation_set_get_n_relations cdecl alias "atk_relation_set_get_n_relations" (byval set as AtkRelationSet ptr) as gint
declare function atk_relation_set_get_relation cdecl alias "atk_relation_set_get_relation" (byval set as AtkRelationSet ptr, byval i as gint) as AtkRelation ptr
declare function atk_relation_set_get_relation_by_type cdecl alias "atk_relation_set_get_relation_by_type" (byval set as AtkRelationSet ptr, byval relationship as AtkRelationType) as AtkRelation ptr
declare sub atk_relation_set_add_relation_by_type cdecl alias "atk_relation_set_add_relation_by_type" (byval set as AtkRelationSet ptr, byval relationship as AtkRelationType, byval target as AtkObject ptr)

#endif
