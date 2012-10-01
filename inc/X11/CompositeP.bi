''
''
'' CompositeP -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __CompositeP_bi__
#define __CompositeP_bi__

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
	version as integer
	record_size as Cardinal
	accepts_objects as Boolean
	allows_change_managed_set as Boolean
end type

type CompositeClassExtension as CompositeClassExtensionRec ptr

type _CompositeClassRec
	core_class as CoreClassPart
	composite_class as CompositeClassPart
end type

type CompositeClassRec as _CompositeClassRec

#define XtCompositeExtensionVersion 2L

#endif
