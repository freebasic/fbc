''
''
'' ObjectP -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __ObjectP_bi__
#define __ObjectP_bi__

type _ObjectRec
	object as ObjectPart
end type

type ObjectRec as _ObjectRec

type _ObjectClassPart
	superclass as WidgetClass
	class_name as String
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
	obj4 as Boolean
	obj5 as XtEnum
	obj6 as Boolean
	obj7 as Boolean
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
	obj12 as String
	obj13 as XtProc
	obj14 as XtProc
	extension as XtPointer
end type

type ObjectClassPart as _ObjectClassPart

type ObjectClassExtensionRec
	next_extension as XtPointer
	record_type as XrmQuark
	version as integer
	record_size as Cardinal
	allocate as XtAllocateProc
	deallocate as XtDeallocateProc
end type

type ObjectClassExtension as ObjectClassExtensionRec ptr

type _ObjectClassRec
	object_class as ObjectClassPart
end type

type ObjectClassRec as _ObjectClassRec

#define XtObjectExtensionVersion 1L

#endif
