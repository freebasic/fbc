''
''
'' RectObjP -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __RectObjP_bi__
#define __RectObjP_bi__

type _RectObjRec
	object as ObjectPart
	rectangle as RectObjPart
end type

type RectObjRec as _RectObjRec

type _RectObjClassPart
	superclass as WidgetClass
	class_name as String
	widget_size as Cardinal
	class_initialize as XtProc
	class_part_initialize as XtWidgetClassProc
	class_inited as XtEnum
	initialize as XtInitProc
	initialize_hook as XtArgsProc
	rect1 as XtProc
	rect2 as XtPointer
	rect3 as Cardinal
	resources as XtResourceList
	num_resources as Cardinal
	xrm_class as XrmClass
	rect4 as Boolean
	rect5 as XtEnum
	rect6 as Boolean
	rect7 as Boolean
	destroy as XtWidgetProc
	resize as XtWidgetProc
	expose as XtExposeProc
	set_values as XtSetValuesFunc
	set_values_hook as XtArgsFunc
	set_values_almost as XtAlmostProc
	get_values_hook as XtArgsProc
	rect9 as XtProc
	version as XtVersionType
	callback_private as XtPointer
	rect10 as String
	query_geometry as XtGeometryHandler
	rect11 as XtProc
	extension as XtPointer
end type

type RectObjClassPart as _RectObjClassPart

type _RectObjClassRec
	rect_class as RectObjClassPart
end type

type RectObjClassRec as _RectObjClassRec

#endif
