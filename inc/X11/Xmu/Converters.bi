'' FreeBASIC binding for libXmu-1.1.2

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
declare function XmuCvtBackingStoreToString(byval dpy as Display ptr, byval args as XrmValue ptr, byval num_args as Cardinal ptr, byval fromVal as XrmValuePtr, byval toVal as XrmValuePtr, byval converter_data as XtPointer ptr) as byte
declare sub XmuCvtStringToCursor(byval args as XrmValue ptr, byval num_args as Cardinal ptr, byval fromVal as XrmValuePtr, byval toVal as XrmValuePtr)

#define XtRColorCursor "ColorCursor"
#define XtNpointerColor "pointerColor"
#define XtNpointerColorBackground "pointerColorBackground"
declare function XmuCvtStringToColorCursor(byval dpy as Display ptr, byval args as XrmValue ptr, byval num_args as Cardinal ptr, byval fromVal as XrmValuePtr, byval toVal as XrmValuePtr, byval converter_data as XtPointer ptr) as byte
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
declare function XmuCvtGravityToString(byval dpy as Display ptr, byval args as XrmValue ptr, byval num_args as Cardinal ptr, byval fromVal as XrmValuePtr, byval toVal as XrmValuePtr, byval converter_data as XtPointer ptr) as byte

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
declare function XmuCvtJustifyToString(byval dpy as Display ptr, byval args as XrmValue ptr, byval num_args as Cardinal ptr, byval fromVal as XrmValuePtr, byval toVal as XrmValuePtr, byval converter_data as XtPointer ptr) as byte
#define XtRLong "Long"
declare sub XmuCvtStringToLong(byval args as XrmValue ptr, byval num_args as Cardinal ptr, byval fromVal as XrmValuePtr, byval toVal as XrmValuePtr)
declare function XmuCvtLongToString(byval dpy as Display ptr, byval args as XrmValue ptr, byval num_args as Cardinal ptr, byval fromVal as XrmValuePtr, byval toVal as XrmValuePtr, byval converter_data as XtPointer ptr) as byte

type XtOrientation as long
enum
	XtorientHorizontal
	XtorientVertical
end enum

declare sub XmuCvtStringToOrientation(byval args as XrmValue ptr, byval num_args as Cardinal ptr, byval fromVal as XrmValuePtr, byval toVal as XrmValuePtr)
declare function XmuCvtOrientationToString(byval dpy as Display ptr, byval args as XrmValue ptr, byval num_args as Cardinal ptr, byval fromVal as XrmValuePtr, byval toVal as XrmValuePtr, byval converter_data as XtPointer ptr) as byte
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

declare function XmuCvtStringToShapeStyle(byval dpy as Display ptr, byval args as XrmValue ptr, byval num_args as Cardinal ptr, byval fromVal as XrmValuePtr, byval toVal as XrmValuePtr, byval converter_data as XtPointer ptr) as byte
declare function XmuCvtShapeStyleToString(byval dpy as Display ptr, byval args as XrmValue ptr, byval num_args as Cardinal ptr, byval fromVal as XrmValuePtr, byval toVal as XrmValuePtr, byval converter_data as XtPointer ptr) as byte
declare function XmuReshapeWidget(byval w as Widget, byval shape_style as long, byval corner_width as long, byval corner_height as long) as byte
declare sub XmuCvtStringToWidget(byval args as XrmValue ptr, byval num_args as Cardinal ptr, byval fromVal as XrmValuePtr, byval toVal as XrmValuePtr)
declare function XmuNewCvtStringToWidget(byval display as Display ptr, byval args as XrmValue ptr, byval num_args as Cardinal ptr, byval fromVal as XrmValue ptr, byval toVal as XrmValue ptr, byval converter_data as XtPointer ptr) as byte
declare function XmuCvtWidgetToString(byval dpy as Display ptr, byval args as XrmValue ptr, byval num_args as Cardinal ptr, byval fromVal as XrmValue ptr, byval toVal as XrmValue ptr, byval converter_data as XtPointer ptr) as byte

end extern
