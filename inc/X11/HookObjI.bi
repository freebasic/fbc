'' FreeBASIC binding for libXt-1.1.4

#pragma once

extern "C"

#define _XtHookObjI_h
type HookObject as _HookObjRec ptr
type HookObjectClass as _HookObjClassRec ptr
extern hookObjectClass as WidgetClass

type _HookObjPart
	createhook_callbacks as XtCallbackList
	changehook_callbacks as XtCallbackList
	confighook_callbacks as XtCallbackList
	geometryhook_callbacks as XtCallbackList
	destroyhook_callbacks as XtCallbackList
	shells as WidgetList
	num_shells as Cardinal
	max_shells as Cardinal
	screen as Screen ptr
end type

type HookObjPart as _HookObjPart

type _HookObjRec
	object as ObjectPart
	hooks as HookObjPart
end type

type HookObjRec as _HookObjRec

type _HookObjClassPart
	unused as long
end type

type HookObjClassPart as _HookObjClassPart

type _HookObjClassRec
	object_class as ObjectClassPart
	hook_class as HookObjClassPart
end type

type HookObjClassRec as _HookObjClassRec
extern hookObjClassRec as HookObjClassRec

end extern
