''
''
'' HookObjI -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __HookObjI_bi__
#define __HookObjI_bi__

type HookObjectClass as _HookObjClassRec ptr

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
	unused as integer
end type

type HookObjClassPart as _HookObjClassPart

type _HookObjClassRec
	object_class as ObjectClassPart
	hook_class as HookObjClassPart
end type

type HookObjClassRec as _HookObjClassRec

#endif
