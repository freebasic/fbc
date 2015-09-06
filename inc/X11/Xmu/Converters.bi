'' FreeBASIC binding for libXmu-1.1.2
''
'' based on the C header files:
''
''   Copyright 1988, 1998  The Open Group
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
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "X11/Intrinsic.bi"
#include once "X11/Xfuncproto.bi"

extern "C"

#define _XMU_STRCONVERT_H_
declare sub XmuCvtFunctionToCallback(byval args as XrmValue ptr, byval num_args as Cardinal ptr, byval fromVal as XrmValuePtr, byval toVal as XrmValuePtr)
#define XtNbackingStore "backingStore"
#define XtCBackingStore "BackingStore"
#define XtRBackingStore "BackingStore"
#define XtEnotUseful "notUseful"
#define XtEwhenMapped "whenMapped"
#define XtEalways "always"
#define XtEdefault "default"

declare sub XmuCvtStringToBackingStore(byval args as XrmValue ptr, byval num_args as Cardinal ptr, byval fromVal as XrmValuePtr, byval toVal as XrmValuePtr)
declare function XmuCvtBackingStoreToString(byval dpy as Display ptr, byval args as XrmValue ptr, byval num_args as Cardinal ptr, byval fromVal as XrmValuePtr, byval toVal as XrmValuePtr, byval converter_data as XtPointer ptr) as XBoolean
declare sub XmuCvtStringToCursor(byval args as XrmValue ptr, byval num_args as Cardinal ptr, byval fromVal as XrmValuePtr, byval toVal as XrmValuePtr)

#define XtRColorCursor "ColorCursor"
#define XtNpointerColor "pointerColor"
#define XtNpointerColorBackground "pointerColorBackground"
declare function XmuCvtStringToColorCursor(byval dpy as Display ptr, byval args as XrmValue ptr, byval num_args as Cardinal ptr, byval fromVal as XrmValuePtr, byval toVal as XrmValuePtr, byval converter_data as XtPointer ptr) as XBoolean
type XtGravity as long
#define XtEForget "forget"
#define XtENorthWest "northwest"
#define XtENorth "north"
#define XtENorthEast "northeast"
#define XtEWest "west"
#define XtECenter "center"
#define XtEEast "east"
#define XtESouthWest "southwest"
#define XtESouth "south"
#define XtESouthEast "southeast"
#define XtEStatic "static"
#define XtEUnmap "unmap"
declare sub XmuCvtStringToGravity(byval args as XrmValue ptr, byval num_args as Cardinal ptr, byval fromVal as XrmValuePtr, byval toVal as XrmValuePtr)
declare function XmuCvtGravityToString(byval dpy as Display ptr, byval args as XrmValue ptr, byval num_args as Cardinal ptr, byval fromVal as XrmValuePtr, byval toVal as XrmValuePtr, byval converter_data as XtPointer ptr) as XBoolean

type XtJustify as long
enum
	XtJustifyLeft
	XtJustifyCenter
	XtJustifyRight
end enum

#define XtEleft "left"
#define XtEcenter "center"
#define XtEright "right"
#define XtEtop "top"
#define XtEbottom "bottom"
declare sub XmuCvtStringToJustify(byval args as XrmValue ptr, byval num_args as Cardinal ptr, byval fromVal as XrmValuePtr, byval toVal as XrmValuePtr)
declare function XmuCvtJustifyToString(byval dpy as Display ptr, byval args as XrmValue ptr, byval num_args as Cardinal ptr, byval fromVal as XrmValuePtr, byval toVal as XrmValuePtr, byval converter_data as XtPointer ptr) as XBoolean
#define XtRLong "Long"
declare sub XmuCvtStringToLong(byval args as XrmValue ptr, byval num_args as Cardinal ptr, byval fromVal as XrmValuePtr, byval toVal as XrmValuePtr)
declare function XmuCvtLongToString(byval dpy as Display ptr, byval args as XrmValue ptr, byval num_args as Cardinal ptr, byval fromVal as XrmValuePtr, byval toVal as XrmValuePtr, byval converter_data as XtPointer ptr) as XBoolean

type XtOrientation as long
enum
	XtorientHorizontal
	XtorientVertical
end enum

declare sub XmuCvtStringToOrientation(byval args as XrmValue ptr, byval num_args as Cardinal ptr, byval fromVal as XrmValuePtr, byval toVal as XrmValuePtr)
declare function XmuCvtOrientationToString(byval dpy as Display ptr, byval args as XrmValue ptr, byval num_args as Cardinal ptr, byval fromVal as XrmValuePtr, byval toVal as XrmValuePtr, byval converter_data as XtPointer ptr) as XBoolean
declare sub XmuCvtStringToBitmap(byval args as XrmValue ptr, byval num_args as Cardinal ptr, byval fromVal as XrmValuePtr, byval toVal as XrmValuePtr)

#define XtRShapeStyle "ShapeStyle"
#define XtERectangle "Rectangle"
#define XtEOval "Oval"
#define XtEEllipse "Ellipse"
#define XtERoundedRectangle "RoundedRectangle"
const XmuShapeRectangle = 1
const XmuShapeOval = 2
const XmuShapeEllipse = 3
const XmuShapeRoundedRectangle = 4

declare function XmuCvtStringToShapeStyle(byval dpy as Display ptr, byval args as XrmValue ptr, byval num_args as Cardinal ptr, byval fromVal as XrmValuePtr, byval toVal as XrmValuePtr, byval converter_data as XtPointer ptr) as XBoolean
declare function XmuCvtShapeStyleToString(byval dpy as Display ptr, byval args as XrmValue ptr, byval num_args as Cardinal ptr, byval fromVal as XrmValuePtr, byval toVal as XrmValuePtr, byval converter_data as XtPointer ptr) as XBoolean
declare function XmuReshapeWidget(byval w as Widget, byval shape_style as long, byval corner_width as long, byval corner_height as long) as XBoolean
declare sub XmuCvtStringToWidget(byval args as XrmValue ptr, byval num_args as Cardinal ptr, byval fromVal as XrmValuePtr, byval toVal as XrmValuePtr)
declare function XmuNewCvtStringToWidget(byval display as Display ptr, byval args as XrmValue ptr, byval num_args as Cardinal ptr, byval fromVal as XrmValue ptr, byval toVal as XrmValue ptr, byval converter_data as XtPointer ptr) as XBoolean
declare function XmuCvtWidgetToString(byval dpy as Display ptr, byval args as XrmValue ptr, byval num_args as Cardinal ptr, byval fromVal as XrmValue ptr, byval toVal as XrmValue ptr, byval converter_data as XtPointer ptr) as XBoolean

end extern
