''
''
'' atkstateset -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __atkstateset_bi__
#define __atkstateset_bi__

#include once "gtk/glib-object.bi"
#include once "atkobject.bi"
#include once "atkstate.bi"

#define ATK_TYPE_STATE_SET() atk_state_set_get_type ()
#define ATK_STATE_SET(obj) G_TYPE_CHECK_INSTANCE_CAST ((obj), ATK_TYPE_STATE_SET, AtkStateSet)
#define ATK_STATE_SET_CLASS(klass) G_TYPE_CHECK_CLASS_CAST ((klass), ATK_TYPE_STATE_SET, AtkStateSetClass)
#define ATK_IS_STATE_SET(obj) G_TYPE_CHECK_INSTANCE_TYPE ((obj), ATK_TYPE_STATE_SET)
#define ATK_IS_STATE_SET_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE ((klass), ATK_TYPE_STATE_SET)
#define ATK_STATE_SET_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS ((obj), ATK_TYPE_STATE_SET, AtkStateSetClass)

type AtkStateSetClass as _AtkStateSetClass

type _AtkStateSet
	parent as GObject
end type

type _AtkStateSetClass
	parent as GObjectClass
end type

declare function atk_state_set_get_type () as GType
declare function atk_state_set_new () as AtkStateSet ptr
declare function atk_state_set_is_empty (byval set as AtkStateSet ptr) as gboolean
declare function atk_state_set_add_state (byval set as AtkStateSet ptr, byval type as AtkStateType) as gboolean
declare sub atk_state_set_add_states (byval set as AtkStateSet ptr, byval types as AtkStateType ptr, byval n_types as gint)
declare sub atk_state_set_clear_states (byval set as AtkStateSet ptr)
declare function atk_state_set_contains_state (byval set as AtkStateSet ptr, byval type as AtkStateType) as gboolean
declare function atk_state_set_contains_states (byval set as AtkStateSet ptr, byval types as AtkStateType ptr, byval n_types as gint) as gboolean
declare function atk_state_set_remove_state (byval set as AtkStateSet ptr, byval type as AtkStateType) as gboolean
declare function atk_state_set_and_sets (byval set as AtkStateSet ptr, byval compare_set as AtkStateSet ptr) as AtkStateSet ptr
declare function atk_state_set_or_sets (byval set as AtkStateSet ptr, byval compare_set as AtkStateSet ptr) as AtkStateSet ptr
declare function atk_state_set_xor_sets (byval set as AtkStateSet ptr, byval compare_set as AtkStateSet ptr) as AtkStateSet ptr

#endif
