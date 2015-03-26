#pragma once

#include once "crt/long.bi"
#include once "X11/Constraint.bi"

extern "C"

#define _XtConstraintP_h

type _ConstraintPart
	mumble as XtPointer
end type

type ConstraintPart as _ConstraintPart

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
	version as clong
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
extern constraintClassRec as ConstraintClassRec
const XtConstraintExtensionVersion = cast(clong, 1)

end extern
