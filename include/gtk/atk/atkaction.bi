''
''
'' atkaction -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __atkaction_bi__
#define __atkaction_bi__

#include once "atkobject.bi"

#define ATK_TYPE_ACTION() atk_action_get_type())
#define ATK_IS_ACTION(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), ATK_TYPE_ACTION)
#define ATK_ACTION(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), ATK_TYPE_ACTION, AtkAction)
#define ATK_ACTION_GET_IFACE(obj) G_TYPE_INSTANCE_GET_INTERFACE((obj), ATK_TYPE_ACTION, AtkActionIface)

type AtkAction as _AtkAction
type AtkActionIface as _AtkActionIface

type _AtkActionIface
	parent as GTypeInterface
	do_action as function cdecl(byval as AtkAction ptr, byval as gint) as gboolean
	get_n_actions as function cdecl(byval as AtkAction ptr) as gint
	get_description as function cdecl(byval as AtkAction ptr, byval as gint) as gchar
	get_name as function cdecl(byval as AtkAction ptr, byval as gint) as gchar
	get_keybinding as function cdecl(byval as AtkAction ptr, byval as gint) as gchar
	set_description as function cdecl(byval as AtkAction ptr, byval as gint, byval as zstring ptr) as gboolean
	get_localized_name as function cdecl(byval as AtkAction ptr, byval as gint) as gchar
	pad2 as AtkFunction
end type

declare function atk_action_get_type () as GType
declare function atk_action_do_action (byval action as AtkAction ptr, byval i as gint) as gboolean
declare function atk_action_get_n_actions (byval action as AtkAction ptr) as gint
declare function atk_action_get_description (byval action as AtkAction ptr, byval i as gint) as zstring ptr
declare function atk_action_get_name (byval action as AtkAction ptr, byval i as gint) as zstring ptr
declare function atk_action_get_keybinding (byval action as AtkAction ptr, byval i as gint) as zstring ptr
declare function atk_action_set_description (byval action as AtkAction ptr, byval i as gint, byval desc as zstring ptr) as gboolean
declare function atk_action_get_localized_name (byval action as AtkAction ptr, byval i as gint) as zstring ptr

#endif
