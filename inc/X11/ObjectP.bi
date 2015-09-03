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
#include once "X11/Object.bi"

extern "C"

#define _Xt_ObjectP_h_

type _ObjectPart
	self as Widget
	widget_class as WidgetClass
	parent as Widget
	xrm_name as XrmName
	being_destroyed as XBoolean
	destroy_callbacks as XtCallbackList
	constraints as XtPointer
end type

type ObjectPart as _ObjectPart

type _ObjectRec
	object as ObjectPart
end type

type ObjectRec as _ObjectRec

type _ObjectClassPart
	superclass as WidgetClass
	class_name as String_
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
	obj4 as XBoolean
	obj5 as XtEnum
	obj6 as XBoolean
	obj7 as XBoolean
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
	obj12 as String_
	obj13 as XtProc
	obj14 as XtProc
	extension as XtPointer
end type

type ObjectClassPart as _ObjectClassPart

type ObjectClassExtensionRec
	next_extension as XtPointer
	record_type as XrmQuark
	version as clong
	record_size as Cardinal
	allocate as XtAllocateProc
	deallocate as XtDeallocateProc
end type

type ObjectClassExtension as ObjectClassExtensionRec ptr

type _ObjectClassRec
	object_class as ObjectClassPart
end type

type ObjectClassRec as _ObjectClassRec
extern objectClassRec as ObjectClassRec
const XtObjectExtensionVersion = cast(clong, 1)
#define XtInheritAllocate cast(XtAllocateProc, _XtInherit)
#define XtInheritDeallocate cast(XtDeallocateProc, _XtInherit)

end extern
