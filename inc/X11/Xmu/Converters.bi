''
''
'' Converters -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __Converters_bi__
#define __Converters_bi__

#define XtNbackingStore "backingStore"
#define XtCBackingStore "BackingStore"
#define XtRBackingStore "BackingStore"
#define XtEnotUseful "notUseful"
#define XtEwhenMapped "whenMapped"
#define XtEalways "always"
#define XtEdefault "default"

declare sub XmuCvtStringToBackingStore cdecl alias "XmuCvtStringToBackingStore" (byval args as XrmValue ptr, byval num_args as Cardinal ptr, byval fromVal as XrmValuePtr, byval toVal as XrmValuePtr)
declare function XmuCvtBackingStoreToString cdecl alias "XmuCvtBackingStoreToString" (byval dpy as Display ptr, byval args as XrmValue ptr, byval num_args as Cardinal ptr, byval fromVal as XrmValuePtr, byval toVal as XrmValuePtr, byval converter_data as XtPointer ptr) as Boolean
declare sub XmuCvtStringToCursor cdecl alias "XmuCvtStringToCursor" (byval args as XrmValue ptr, byval num_args as Cardinal ptr, byval fromVal as XrmValuePtr, byval toVal as XrmValuePtr)

#define XtRColorCursor "ColorCursor"
#define XtNpointerColor "pointerColor"
#define XtNpointerColorBackground "pointerColorBackground"

declare function XmuCvtStringToColorCursor cdecl alias "XmuCvtStringToColorCursor" (byval dpy as Display ptr, byval args as XrmValue ptr, byval num_args as Cardinal ptr, byval fromVal as XrmValuePtr, byval toVal as XrmValuePtr, byval converter_data as XtPointer ptr) as Boolean

type XtGravity as integer

#define XtRGravity "Gravity"
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

declare sub XmuCvtStringToGravity cdecl alias "XmuCvtStringToGravity" (byval args as XrmValue ptr, byval num_args as Cardinal ptr, byval fromVal as XrmValuePtr, byval toVal as XrmValuePtr)
declare function XmuCvtGravityToString cdecl alias "XmuCvtGravityToString" (byval dpy as Display ptr, byval args as XrmValue ptr, byval num_args as Cardinal ptr, byval fromVal as XrmValuePtr, byval toVal as XrmValuePtr, byval converter_data as XtPointer ptr) as Boolean

enum XtJustify
	XtJustifyLeft
	XtJustifyCenter
	XtJustifyRight
end enum


#define XtRJustify "Justify"
#define XtEleft "left"
#define XtEcenter "center"
#define XtEright "right"
#define XtEtop "top"
#define XtEbottom "bottom"

declare sub XmuCvtStringToJustify cdecl alias "XmuCvtStringToJustify" (byval args as XrmValue ptr, byval num_args as Cardinal ptr, byval fromVal as XrmValuePtr, byval toVal as XrmValuePtr)
declare function XmuCvtJustifyToString cdecl alias "XmuCvtJustifyToString" (byval dpy as Display ptr, byval args as XrmValue ptr, byval num_args as Cardinal ptr, byval fromVal as XrmValuePtr, byval toVal as XrmValuePtr, byval converter_data as XtPointer ptr) as Boolean

#define XtRLong "Long"

declare sub XmuCvtStringToLong cdecl alias "XmuCvtStringToLong" (byval args as XrmValue ptr, byval num_args as Cardinal ptr, byval fromVal as XrmValuePtr, byval toVal as XrmValuePtr)
declare function XmuCvtLongToString cdecl alias "XmuCvtLongToString" (byval dpy as Display ptr, byval args as XrmValue ptr, byval num_args as Cardinal ptr, byval fromVal as XrmValuePtr, byval toVal as XrmValuePtr, byval converter_data as XtPointer ptr) as Boolean

enum XtOrientation
	XtorientHorizontal
	XtorientVertical
end enum


declare sub XmuCvtStringToOrientation cdecl alias "XmuCvtStringToOrientation" (byval args as XrmValue ptr, byval num_args as Cardinal ptr, byval fromVal as XrmValuePtr, byval toVal as XrmValuePtr)
declare function XmuCvtOrientationToString cdecl alias "XmuCvtOrientationToString" (byval dpy as Display ptr, byval args as XrmValue ptr, byval num_args as Cardinal ptr, byval fromVal as XrmValuePtr, byval toVal as XrmValuePtr, byval converter_data as XtPointer ptr) as Boolean
declare sub XmuCvtStringToBitmap cdecl alias "XmuCvtStringToBitmap" (byval args as XrmValue ptr, byval num_args as Cardinal ptr, byval fromVal as XrmValuePtr, byval toVal as XrmValuePtr)

#define XtRShapeStyle "ShapeStyle"
#define XtERectangle "Rectangle"
#define XtEOval "Oval"
#define XtEEllipse "Ellipse"
#define XtERoundedRectangle "RoundedRectangle"
#define XmuShapeRectangle 1
#define XmuShapeOval 2
#define XmuShapeEllipse 3
#define XmuShapeRoundedRectangle 4

declare function XmuCvtStringToShapeStyle cdecl alias "XmuCvtStringToShapeStyle" (byval dpy as Display ptr, byval args as XrmValue ptr, byval num_args as Cardinal ptr, byval fromVal as XrmValuePtr, byval toVal as XrmValuePtr, byval converter_data as XtPointer ptr) as Boolean
declare function XmuCvtShapeStyleToString cdecl alias "XmuCvtShapeStyleToString" (byval dpy as Display ptr, byval args as XrmValue ptr, byval num_args as Cardinal ptr, byval fromVal as XrmValuePtr, byval toVal as XrmValuePtr, byval converter_data as XtPointer ptr) as Boolean
declare function XmuReshapeWidget cdecl alias "XmuReshapeWidget" (byval w as Widget, byval shape_style as integer, byval corner_width as integer, byval corner_height as integer) as Boolean
declare sub XmuCvtStringToWidget cdecl alias "XmuCvtStringToWidget" (byval args as XrmValue ptr, byval num_args as Cardinal ptr, byval fromVal as XrmValuePtr, byval toVal as XrmValuePtr)
declare function XmuNewCvtStringToWidget cdecl alias "XmuNewCvtStringToWidget" (byval display as Display ptr, byval args as XrmValue ptr, byval num_args as Cardinal ptr, byval fromVal as XrmValue ptr, byval toVal as XrmValue ptr, byval converter_data as XtPointer ptr) as Boolean
declare function XmuCvtWidgetToString cdecl alias "XmuCvtWidgetToString" (byval dpy as Display ptr, byval args as XrmValue ptr, byval num_args as Cardinal ptr, byval fromVal as XrmValue ptr, byval toVal as XrmValue ptr, byval converter_data as XtPointer ptr) as Boolean

#endif
