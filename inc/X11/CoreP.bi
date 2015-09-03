'' FreeBASIC binding for libXt-1.1.4
''
'' based on the C header files:
''   *********************************************************
''
''   Copyright 1987, 1988, 1998  The Open Group
''
''   Permission to use, copy, modify, distribute, and sell this software and its
''   documentation for any purpose is hereby granted without fee, provided that
''   the above copyright notice appear in all copies and that both that
''   copyright notice and this permission notice appear in supporting
''   documentation.
''
''   The above copyright notice and this permission notice shall be included in
''   all copies or substantial portions of the Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
''   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
''   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
''   OPEN GROUP BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
''   AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
''   CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
''
''   Except as contained in this notice, the name of The Open Group shall not be
''   used in advertising or otherwise to promote the sale, use or other dealings
''   in this Software without prior written authorization from The Open Group.
''
''
''   Copyright 1987, 1988 by Digital Equipment Corporation, Maynard, Massachusetts.
''
''                           All Rights Reserved
''
''   Permission to use, copy, modify, and distribute this software and its
''   documentation for any purpose and without fee is hereby granted,
''   provided that the above copyright notice appear in all copies and that
''   both that copyright notice and this permission notice appear in
''   supporting documentation, and that the name of Digital not be
''   used in advertising or publicity pertaining to distribution of the
''   software without specific, written prior permission.
''
''   DIGITAL DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING
''   ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO EVENT SHALL
''   DIGITAL BE LIABLE FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR
''   ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS,
''   WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION,
''   ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS
''   SOFTWARE.
''
''   *****************************************************************
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

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
	being_destroyed as XBoolean
	destroy_callbacks as XtCallbackList
	constraints as XtPointer
	x as Position
	y as Position
	width as Dimension
	height as Dimension
	border_width as Dimension
	managed as XBoolean
	sensitive as XBoolean
	ancestor_sensitive as XBoolean
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
	visible as XBoolean
	mapped_when_managed as XBoolean
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
	compress_motion as XBoolean
	compress_exposure as XtEnum
	compress_enterleave as XBoolean
	visible_interest as XBoolean
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
