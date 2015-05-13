''
''
'' ConstrainP -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __ConstrainP_bi__
#define __ConstrainP_bi__

type _ConstraintRec
	core as CorePart
	composite as CompositePart
	constraint as ConstraintPart
end type

type ConstraintRec as _ConstraintRec
type ConstraintWidget as _ConstraintRec ptr

type _ConstraintClassPart
	resources as XtResourceList
	num_resources as Cardinal
	constraint_size as Cardinal
	initialize as XtInitProc
	destroy as XtWidgetProc
	set_values as XtSetValuesFunc
	extension as XtPointer
end type

type ConstraintClassPart as _ConstraintClassPart

type ConstraintClassExtensionRec
	next_extension as XtPointer
	record_type as XrmQuark
	version as integer
	record_size as Cardinal
	get_values_hook as XtArgsProc
end type

type ConstraintClassExtension as ConstraintClassExtensionRec ptr

type _ConstraintClassRec
	core_class as CoreClassPart
	composite_class as CompositeClassPart
	constraint_class as ConstraintClassPart
end type

type ConstraintClassRec as _ConstraintClassRec

#define XtConstraintExtensionVersion 1L

#endif
