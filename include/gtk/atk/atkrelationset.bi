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
#include once "atkobject.bi"
#include once "atkrelation.bi"

#define ATK_TYPE_RELATION_SET() atk_relation_set_get_type ()
#define ATK_RELATION_SET(obj) G_TYPE_CHECK_INSTANCE_CAST ((obj), ATK_TYPE_RELATION_SET, AtkRelationSet)
#define ATK_RELATION_SET_CLASS(klass) G_TYPE_CHECK_CLASS_CAST ((klass), ATK_TYPE_RELATION_SET, AtkRelationSetClass)
#define ATK_IS_RELATION_SET(obj) G_TYPE_CHECK_INSTANCE_TYPE ((obj), ATK_TYPE_RELATION_SET)
#define ATK_IS_RELATION_SET_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE ((klass), ATK_TYPE_RELATION_SET)
#define ATK_RELATION_SET_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS ((obj), ATK_TYPE_RELATION_SET, AtkRelationSetClass)

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

declare function atk_relation_set_get_type () as GType
declare function atk_relation_set_new () as AtkRelationSet ptr
declare function atk_relation_set_contains (byval set as AtkRelationSet ptr, byval relationship as AtkRelationType) as gboolean
declare sub atk_relation_set_remove (byval set as AtkRelationSet ptr, byval relation as AtkRelation ptr)
declare sub atk_relation_set_add (byval set as AtkRelationSet ptr, byval relation as AtkRelation ptr)
declare function atk_relation_set_get_n_relations (byval set as AtkRelationSet ptr) as gint
declare function atk_relation_set_get_relation (byval set as AtkRelationSet ptr, byval i as gint) as AtkRelation ptr
declare function atk_relation_set_get_relation_by_type (byval set as AtkRelationSet ptr, byval relationship as AtkRelationType) as AtkRelation ptr
declare sub atk_relation_set_add_relation_by_type (byval set as AtkRelationSet ptr, byval relationship as AtkRelationType, byval target as AtkObject ptr)

#endif
