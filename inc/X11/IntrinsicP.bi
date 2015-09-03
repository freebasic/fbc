'' FreeBASIC binding for libXt-1.1.4
''
'' based on the C header files:
''   *********************************************************
''
''   Copyright 1987, 1988, 1994, 1998  The Open Group
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

#include once "crt/long.bi"
#include once "X11/Intrinsic.bi"

extern "C"

#define _XtintrinsicP_h

type XrmResource
	xrm_name as clong
	xrm_class as clong
	xrm_type as clong
	xrm_size as Cardinal
	xrm_offset as long
	xrm_default_type as clong
	xrm_default_addr as XtPointer
end type

type XrmResourceList as XrmResource ptr
type XtVersionType as culong
const XT_VERSION = 11
const XT_REVISION = 6
const XtVersion = (XT_VERSION * 1000) + XT_REVISION
const XtVersionDontCheck = 0

type XtProc as sub()
type XtWidgetClassProc as sub(byval as WidgetClass)
type XtWidgetProc as sub(byval as Widget)
type XtAcceptFocusProc as function(byval as Widget, byval as Time ptr) as XBoolean
type XtArgsProc as sub(byval as Widget, byval as ArgList, byval as Cardinal ptr)
type XtInitProc as sub(byval as Widget, byval as Widget, byval as ArgList, byval as Cardinal ptr)
type XtSetValuesFunc as function(byval as Widget, byval as Widget, byval as Widget, byval as ArgList, byval as Cardinal ptr) as XBoolean
type XtArgsFunc as function(byval as Widget, byval as ArgList, byval as Cardinal ptr) as XBoolean
type XtAlmostProc as sub(byval as Widget, byval as Widget, byval as XtWidgetGeometry ptr, byval as XtWidgetGeometry ptr)
type XtExposeProc as sub(byval as Widget, byval as XEvent ptr, byval as Region)

#define XtExposeNoCompress cast(XtEnum, False)
#define XtExposeCompressSeries cast(XtEnum, True)
const XtExposeCompressMultiple = 2
const XtExposeCompressMaximal = 3
const XtExposeGraphicsExpose = &h10
const XtExposeGraphicsExposeMerged = &h20
const XtExposeNoExpose = &h40
const XtExposeNoRegion = &h80

type XtRealizeProc as sub(byval as Widget, byval as XtValueMask ptr, byval as XSetWindowAttributes ptr)
type XtGeometryHandler as function(byval as Widget, byval as XtWidgetGeometry ptr, byval as XtWidgetGeometry ptr) as XtGeometryResult
type XtStringProc as sub(byval as Widget, byval as String_)

type XtTypedArg
	name as String_
	as String_ type
	value as XtArgVal
	size as long
end type

type XtTypedArgList as XtTypedArg ptr
type XtAllocateProc as sub(byval as WidgetClass, byval as Cardinal ptr, byval as Cardinal ptr, byval as ArgList, byval as Cardinal ptr, byval as XtTypedArgList, byval as Cardinal ptr, byval as Widget ptr, byval as XtPointer ptr)
type XtDeallocateProc as sub(byval as Widget, byval as XtPointer)
type _XtStateRec as _XtStateRec_

type _XtTMRec
	translations as XtTranslations
	proc_table as XtBoundActions
	current_state as _XtStateRec ptr
	lastEventTime as culong
end type

type XtTMRec as _XtTMRec
type XtTM as _XtTMRec ptr
#undef XtDisplay
#define XtDisplay(widget) DisplayOfScreen((widget)->core.screen)
#undef XtScreen
#define XtScreen(widget) (widget)->core.screen
#undef XtWindow
#define XtWindow(widget) (widget)->core.window
#undef XtClass
#define XtClass(widget) (widget)->core.widget_class
#undef XtSuperclass
#define XtSuperclass(widget) XtClass(widget)->core_class.superclass
#undef XtIsRealized
#define XtIsRealized(object) (XtWindowOfObject(object) <> None)
#undef XtParent
#define XtParent(widget) (widget)->core.parent
#undef XtIsRectObj
#define XtIsRectObj(obj) (cast(Object_, (obj))->object.widget_class->core_class.class_inited and &h02)
#undef XtIsWidget
#define XtIsWidget(obj) (cast(Object_, (obj))->object.widget_class->core_class.class_inited and &h04)
#undef XtIsComposite
#define XtIsComposite(obj) (cast(Object_, (obj))->object.widget_class->core_class.class_inited and &h08)
#undef XtIsConstraint
#define XtIsConstraint(obj) (cast(Object_, (obj))->object.widget_class->core_class.class_inited and &h10)
#undef XtIsShell
#define XtIsShell(obj) (cast(Object_, (obj))->object.widget_class->core_class.class_inited and &h20)
#undef XtIsWMShell
#define XtIsWMShell(obj) (cast(Object_, (obj))->object.widget_class->core_class.class_inited and &h40)
#undef XtIsTopLevelShell
#define XtIsTopLevelShell(obj) (cast(Object_, (obj))->object.widget_class->core_class.class_inited and &h80)
#define XtCheckSubclass(w, widget_class, message)

declare function _XtWindowedAncestor(byval as Widget) as Widget
declare sub _XtInherit()
declare sub _XtHandleFocus(byval as Widget, byval as XtPointer, byval as XEvent ptr, byval as XBoolean ptr)
declare sub XtCreateWindow(byval as Widget, byval as ulong, byval as Visual ptr, byval as XtValueMask, byval as XSetWindowAttributes ptr)
declare sub XtResizeWidget(byval as Widget, byval as Dimension, byval as Dimension, byval as Dimension)
declare sub XtMoveWidget(byval as Widget, byval as Position, byval as Position)
declare sub XtConfigureWidget(byval as Widget, byval as Position, byval as Position, byval as Dimension, byval as Dimension, byval as Dimension)
declare sub XtResizeWindow(byval as Widget)
declare sub XtProcessLock()
declare sub XtProcessUnlock()

end extern

#include once "X11/CoreP.bi"
#include once "X11/CompositeP.bi"
#include once "X11/ConstrainP.bi"
#include once "X11/ObjectP.bi"
#include once "X11/RectObjP.bi"
