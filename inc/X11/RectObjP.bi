#pragma once

#include once "X11/RectObj.bi"
#include once "X11/ObjectP.bi"

extern "C"

#define _Xt_RectObjP_h_

type _RectObjPart
	x as Position
	y as Position
	width as Dimension
	height as Dimension
	border_width as Dimension
	managed as byte
	sensitive as byte
	ancestor_sensitive as byte
end type

type RectObjPart as _RectObjPart

type _RectObjRec
	object as ObjectPart
	rectangle as RectObjPart
end type

type RectObjRec as _RectObjRec

type _RectObjClassPart
	superclass as WidgetClass
	class_name as String_
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
	rect4 as byte
	rect5 as XtEnum
	rect6 as byte
	rect7 as byte
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
	rect10 as String_
	query_geometry as XtGeometryHandler
	rect11 as XtProc
	extension as XtPointer
end type

type RectObjClassPart as _RectObjClassPart

type _RectObjClassRec
	rect_class as RectObjClassPart
end type

type RectObjClassRec as _RectObjClassRec
extern rectObjClassRec as RectObjClassRec

end extern
