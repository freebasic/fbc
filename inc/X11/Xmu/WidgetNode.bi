'' FreeBASIC binding for libXmu-1.1.2

#pragma once

#include once "X11/Intrinsic.bi"
#include once "X11/Xfuncproto.bi"

extern "C"

#define _XmuWidgetNode_h

type _XmuWidgetNode
	label as zstring ptr
	widget_class_ptr as WidgetClass ptr
	superclass as _XmuWidgetNode ptr
	children as _XmuWidgetNode ptr
	siblings as _XmuWidgetNode ptr
	lowered_label as zstring ptr
	lowered_classname as zstring ptr
	have_resources as long
	resources as XtResourceList
	resourcewn as _XmuWidgetNode ptr ptr
	nresources as Cardinal
	constraints as XtResourceList
	constraintwn as _XmuWidgetNode ptr ptr
	nconstraints as Cardinal
	data as XtPointer
end type

type XmuWidgetNode as _XmuWidgetNode
#define XmuWnClass(wn) (wn)->widget_class_ptr[0]
#define XmuWnClassname(wn) XmuWnClass(wn)->core_class.class_name
#define XmuWnSuperclass(wn) XmuWnClass(wn)->core_class.superclass

declare sub XmuWnInitializeNodes(byval nodearray as XmuWidgetNode ptr, byval nnodes as long)
declare sub XmuWnFetchResources(byval node as XmuWidgetNode ptr, byval toplevel as Widget, byval topnode as XmuWidgetNode ptr)
declare function XmuWnCountOwnedResources(byval node as XmuWidgetNode ptr, byval ownernode as XmuWidgetNode ptr, byval constraints as long) as long
declare function XmuWnNameToNode(byval nodelist as XmuWidgetNode ptr, byval nnodes as long, byval name as const zstring ptr) as XmuWidgetNode ptr

end extern
