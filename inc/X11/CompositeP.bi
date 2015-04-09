'' FreeBASIC binding for libXt-1.1.4

#pragma once

#include once "crt/long.bi"
#include once "X11/Composite.bi"

extern "C"

#define _XtCompositeP_h

type _CompositePart
	children as WidgetList
	num_children as Cardinal
	num_slots as Cardinal
	insert_position as XtOrderProc
end type

type CompositePart as _CompositePart
type CompositePtr as _CompositePart ptr

type _CompositeRec
	core as CorePart
	composite as CompositePart
end type

type CompositeRec as _CompositeRec

type _CompositeClassPart
	geometry_manager as XtGeometryHandler
	change_managed as XtWidgetProc
	insert_child as XtWidgetProc
	delete_child as XtWidgetProc
	extension as XtPointer
end type

type CompositeClassPart as _CompositeClassPart
type CompositePartPtr as _CompositeClassPart ptr

type CompositeClassExtensionRec
	next_extension as XtPointer
	record_type as XrmQuark
	version as clong
	record_size as Cardinal
	accepts_objects as byte
	allows_change_managed_set as byte
end type

type CompositeClassExtension as CompositeClassExtensionRec ptr

type _CompositeClassRec
	core_class as CoreClassPart
	composite_class as CompositeClassPart
end type

type CompositeClassRec as _CompositeClassRec
extern compositeClassRec as CompositeClassRec
const XtCompositeExtensionVersion = cast(clong, 2)
#define XtInheritGeometryManager cast(XtGeometryHandler, _XtInherit)
#define XtInheritChangeManaged cast(XtWidgetProc, _XtInherit)
#define XtInheritInsertChild cast(XtWidgetProc, _XtInherit)
#define XtInheritDeleteChild cast(XtWidgetProc, _XtInherit)

end extern
