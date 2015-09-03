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
	managed as XBoolean
	sensitive as XBoolean
	ancestor_sensitive as XBoolean
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
	rect4 as XBoolean
	rect5 as XtEnum
	rect6 as XBoolean
	rect7 as XBoolean
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
