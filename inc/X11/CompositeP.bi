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

#include once "crt/long.bi"
#include once "X11/Composite.bi"

extern "C"

#define _XtCompositeP_h

type _CompositePart
	children as WidgetList
	num_children as Cardinal
	num_slots as Cardinal
	insert_position as XtOrderProc
end type

type CompositePart as _CompositePart
type CompositePtr as _CompositePart ptr

type _CompositeRec
	core as CorePart
	composite as CompositePart
end type

type CompositeRec as _CompositeRec

type _CompositeClassPart
	geometry_manager as XtGeometryHandler
	change_managed as XtWidgetProc
	insert_child as XtWidgetProc
	delete_child as XtWidgetProc
	extension as XtPointer
end type

type CompositeClassPart as _CompositeClassPart
type CompositePartPtr as _CompositeClassPart ptr

type CompositeClassExtensionRec
	next_extension as XtPointer
	record_type as XrmQuark
	version as clong
	record_size as Cardinal
	accepts_objects as XBoolean
	allows_change_managed_set as XBoolean
end type

type CompositeClassExtension as CompositeClassExtensionRec ptr

type _CompositeClassRec
	core_class as CoreClassPart
	composite_class as CompositeClassPart
end type

type CompositeClassRec as _CompositeClassRec
extern compositeClassRec as CompositeClassRec
const XtCompositeExtensionVersion = cast(clong, 2)
#define XtInheritGeometryManager cast(XtGeometryHandler, _XtInherit)
#define XtInheritChangeManaged cast(XtWidgetProc, _XtInherit)
#define XtInheritInsertChild cast(XtWidgetProc, _XtInherit)
#define XtInheritDeleteChild cast(XtWidgetProc, _XtInherit)

end extern
