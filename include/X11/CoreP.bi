''
''
'' CoreP -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __CoreP_bi__
#define __CoreP_bi__

type _CorePart
	self as Widget
	widget_class as WidgetClass
	parent as Widget
	xrm_name as XrmName
	being_destroyed as Boolean
	destroy_callbacks as XtCallbackList
	constraints as XtPointer
	x as Position
	y as Position
	width as Dimension
	height as Dimension
	border_width as Dimension
	managed as Boolean
	sensitive as Boolean
	ancestor_sensitive as Boolean
	event_table as XtEventTable
	tm as XtTMRec
	accelerators as XtTranslations
	border_pixel as Pixel
	border_pixmap as Pixmap
	popup_list as WidgetList
	num_popups as Cardinal
	name as String
	screen as Screen ptr
	colormap as Colormap
	window as Window
	depth as Cardinal
	background_pixel as Pixel
	background_pixmap as Pixmap
	visible as Boolean
	mapped_when_managed as Boolean
end type

type CorePart as _CorePart

type _WidgetRec
	core as CorePart
end type

type WidgetRec as _WidgetRec
type CoreRec as _WidgetRec

type _CoreClassPart
	superclass as WidgetClass
	class_name as String
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
	compress_motion as Boolean
	compress_exposure as XtEnum
	compress_enterleave as Boolean
	visible_interest as Boolean
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
	tm_table as String
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

#endif
