''
''
'' atkstate -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __atkstate_bi__
#define __atkstate_bi__

#include once "gtk/glib-object.bi"

enum AtkStateType
	ATK_STATE_INVALID
	ATK_STATE_ACTIVE
	ATK_STATE_ARMED
	ATK_STATE_BUSY
	ATK_STATE_CHECKED
	ATK_STATE_DEFUNCT
	ATK_STATE_EDITABLE
	ATK_STATE_ENABLED
	ATK_STATE_EXPANDABLE
	ATK_STATE_EXPANDED
	ATK_STATE_FOCUSABLE
	ATK_STATE_FOCUSED
	ATK_STATE_HORIZONTAL
	ATK_STATE_ICONIFIED
	ATK_STATE_MODAL
	ATK_STATE_MULTI_LINE
	ATK_STATE_MULTISELECTABLE
	ATK_STATE_OPAQUE
	ATK_STATE_PRESSED
	ATK_STATE_RESIZABLE
	ATK_STATE_SELECTABLE
	ATK_STATE_SELECTED
	ATK_STATE_SENSITIVE
	ATK_STATE_SHOWING
	ATK_STATE_SINGLE_LINE
	ATK_STATE_STALE
	ATK_STATE_TRANSIENT
	ATK_STATE_VERTICAL
	ATK_STATE_VISIBLE
	ATK_STATE_MANAGES_DESCENDANTS
	ATK_STATE_INDETERMINATE
	ATK_STATE_TRUNCATED
	ATK_STATE_LAST_DEFINED
end enum

type AtkState as guint64

declare function atk_state_type_register (byval name as zstring ptr) as AtkStateType
declare function atk_state_type_get_name (byval type as AtkStateType) as zstring ptr
declare function atk_state_type_for_name (byval name as zstring ptr) as AtkStateType

#endif
