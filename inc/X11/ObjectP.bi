'' FreeBASIC binding for libXt-1.1.4

#pragma once

#include once "crt/long.bi"
#include once "X11/Object.bi"

extern "C"

#define _Xt_ObjectP_h_

type _ObjectPart
	self as Widget
	widget_class as WidgetClass
	parent as Widget
	xrm_name as XrmName
	being_destroyed as byte
	destroy_callbacks as XtCallbackList
	constraints as XtPointer
end type

type ObjectPart as _ObjectPart

type _ObjectRec
	object as ObjectPart
end type

type ObjectRec as _ObjectRec

type _ObjectClassPart
	superclass as WidgetClass
	class_name as String_
	widget_size as Cardinal
	class_initialize as XtProc
	class_part_initialize as XtWidgetClassProc
	class_inited as XtEnum
	initialize as XtInitProc
	initialize_hook as XtArgsProc
	obj1 as XtProc
	obj2 as XtPointer
	obj3 as Cardinal
	resources as XtResourceList
	num_resources as Cardinal
	xrm_class as XrmClass
	obj4 as byte
	obj5 as XtEnum
	obj6 as byte
	obj7 as byte
	destroy as XtWidgetProc
	obj8 as XtProc
	obj9 as XtProc
	set_values as XtSetValuesFunc
	set_values_hook as XtArgsFunc
	obj10 as XtProc
	get_values_hook as XtArgsProc
	obj11 as XtProc
	version as XtVersionType
	callback_private as XtPointer
	obj12 as String_
	obj13 as XtProc
	obj14 as XtProc
	extension as XtPointer
end type

type ObjectClassPart as _ObjectClassPart

type ObjectClassExtensionRec
	next_extension as XtPointer
	record_type as XrmQuark
	version as clong
	record_size as Cardinal
	allocate as XtAllocateProc
	deallocate as XtDeallocateProc
end type

type ObjectClassExtension as ObjectClassExtensionRec ptr

type _ObjectClassRec
	object_class as ObjectClassPart
end type

type ObjectClassRec as _ObjectClassRec
extern objectClassRec as ObjectClassRec
const XtObjectExtensionVersion = cast(clong, 1)
#define XtInheritAllocate cast(XtAllocateProc, _XtInherit)
#define XtInheritDeallocate cast(XtDeallocateProc, _XtInherit)

end extern
