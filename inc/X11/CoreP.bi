#pragma once

#include once "X11/Core.bi"

extern "C"

#define XtCoreP_h
extern _XtInheritTranslations as long
#define XtInheritTranslations cast(String_, @_XtInheritTranslations)
#define XtInheritRealize cast(XtRealizeProc, _XtInherit)
#define XtInheritResize cast(XtWidgetProc, _XtInherit)
#define XtInheritExpose cast(XtExposeProc, _XtInherit)
#define XtInheritSetValuesAlmost cast(XtAlmostProc, _XtInherit)
#define XtInheritAcceptFocus cast(XtAcceptFocusProc, _XtInherit)
#define XtInheritQueryGeometry cast(XtGeometryHandler, _XtInherit)
#define XtInheritDisplayAccelerator cast(XtStringProc, _XtInherit)

type _CorePart
	self as Widget
	widget_class as WidgetClass
	parent as Widget
	xrm_name as XrmName
	being_destroyed as byte
	destroy_callbacks as XtCallbackList
	constraints as XtPointer
	x as Position
	y as Position
	width as Dimension
	height as Dimension
	border_width as Dimension
	managed as byte
	sensitive as byte
	ancestor_sensitive as byte
	event_table as XtEventTable
	tm as XtTMRec
	accelerators as XtTranslations
	border_pixel as Pixel
	border_pixmap as Pixmap
	popup_list as WidgetList
	num_popups as Cardinal
	name as String_
	screen as Screen ptr
	colormap as Colormap
	window as Window
	depth as Cardinal
	background_pixel as Pixel
	background_pixmap as Pixmap
	visible as byte
	mapped_when_managed as byte
end type

type CorePart as _CorePart

type _WidgetRec
	core as CorePart
end type

type WidgetRec as _WidgetRec
type CoreRec as _WidgetRec

type _CoreClassPart
	superclass as WidgetClass
	class_name as String_
	widget_size as Cardinal
	class_initialize as XtProc
	class_part_initialize as XtWidgetClassProc
	class_inited as XtEnum
	initialize as XtInitProc
	initialize_hook as XtArgsProc
	realize as XtRealizeProc
	actions as XtActionList
	num_actions as Cardinal
	resources as XtResourceList
	num_resources as Cardinal
	xrm_class as XrmClass
	compress_motion as byte
	compress_exposure as XtEnum
	compress_enterleave as byte
	visible_interest as byte
	destroy as XtWidgetProc
	resize as XtWidgetProc
	expose as XtExposeProc
	set_values as XtSetValuesFunc
	set_values_hook as XtArgsFunc
	set_values_almost as XtAlmostProc
	get_values_hook as XtArgsProc
	accept_focus as XtAcceptFocusProc
	version as XtVersionType
	callback_private as XtPointer
	tm_table as String_
	query_geometry as XtGeometryHandler
	display_accelerator as XtStringProc
	extension as XtPointer
end type

type CoreClassPart as _CoreClassPart

type _WidgetClassRec
	core_class as CoreClassPart
end type

type WidgetClassRec as _WidgetClassRec
type CoreClassRec as _WidgetClassRec
extern widgetClassRec as WidgetClassRec
extern coreClassRec alias "widgetClassRec" as WidgetClassRec

end extern
