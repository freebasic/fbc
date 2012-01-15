''
''
'' WidgetNode -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __WidgetNode_bi__
#define __WidgetNode_bi__

type _XmuWidgetNode
	label as zstring ptr
	widget_class_ptr as WidgetClass ptr
	superclass as _XmuWidgetNode ptr
	children as _XmuWidgetNode ptr
	siblings as _XmuWidgetNode ptr
	lowered_label as zstring ptr
	lowered_classname as zstring ptr
	have_resources as Bool
	resources as XtResourceList
	resourcewn as _XmuWidgetNode ptr ptr
	nresources as Cardinal
	constraints as XtResourceList
	constraintwn as _XmuWidgetNode ptr ptr
	nconstraints as Cardinal
	data as XtPointer
end type

type XmuWidgetNode as _XmuWidgetNode

declare sub XmuWnFetchResources cdecl alias "XmuWnFetchResources" (byval node as XmuWidgetNode ptr, byval toplevel as Widget, byval topnode as XmuWidgetNode ptr)
declare function XmuWnCountOwnedResources cdecl alias "XmuWnCountOwnedResources" (byval node as XmuWidgetNode ptr, byval ownernode as XmuWidgetNode ptr, byval constraints as Bool) as integer

#endif
