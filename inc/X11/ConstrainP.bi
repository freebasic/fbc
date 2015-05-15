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
#include once "X11/Constraint.bi"

extern "C"

#define _XtConstraintP_h

type _ConstraintPart
	mumble as XtPointer
end type

type ConstraintPart as _ConstraintPart

type _ConstraintRec
	core as CorePart
	composite as CompositePart
	constraint as ConstraintPart
end type

type ConstraintRec as _ConstraintRec
type ConstraintWidget as _ConstraintRec ptr

type _ConstraintClassPart
	resources as XtResourceList
	num_resources as Cardinal
	constraint_size as Cardinal
	initialize as XtInitProc
	destroy as XtWidgetProc
	set_values as XtSetValuesFunc
	extension as XtPointer
end type

type ConstraintClassPart as _ConstraintClassPart

type ConstraintClassExtensionRec
	next_extension as XtPointer
	record_type as XrmQuark
	version as clong
	record_size as Cardinal
	get_values_hook as XtArgsProc
end type

type ConstraintClassExtension as ConstraintClassExtensionRec ptr

type _ConstraintClassRec
	core_class as CoreClassPart
	composite_class as CompositeClassPart
	constraint_class as ConstraintClassPart
end type

type ConstraintClassRec as _ConstraintClassRec
extern constraintClassRec as ConstraintClassRec
const XtConstraintExtensionVersion = cast(clong, 1)

end extern
