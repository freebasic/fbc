''
''
'' Xutil -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __Xutil_bi__
#define __Xutil_bi__

#define NoValue &h0000
#define XValue &h0001
#define YValue &h0002
#define WidthValue &h0004
#define HeightValue &h0008
#define AllValues &h000F
#define XNegative &h0010
#define YNegative &h0020

type XSizeHints
	flags as integer
	x as integer
	y as integer
	width as integer
	height as integer
	min_width as integer
	min_height as integer
	max_width as integer
	max_height as integer
	width_inc as integer
	height_inc as integer
	win_gravity as integer
end type

#define USPosition (1L shl 0)
#define USSize (1L shl 1)
#define PPosition (1L shl 2)
#define PSize (1L shl 3)
#define PMinSize (1L shl 4)
#define PMaxSize (1L shl 5)
#define PResizeInc (1L shl 6)
#define PAspect (1L shl 7)
#define PBaseSize (1L shl 8)
#define PWinGravity (1L shl 9)
#define PAllHints ((1L shl 2) or (1L shl 3) or (1L shl 4) or (1L shl 5) or (1L shl 6) or (1L shl 7))

type XWMHints
	flags as integer
	input as Bool
	initial_state as integer
	icon_pixmap as Pixmap
	icon_window as Window
	icon_x as integer
	icon_y as integer
	icon_mask as Pixmap
	window_group as XID
end type

#define InputHint (1L shl 0)
#define StateHint (1L shl 1)
#define IconPixmapHint (1L shl 2)
#define IconWindowHint (1L shl 3)
#define IconPositionHint (1L shl 4)
#define IconMaskHint (1L shl 5)
#define WindowGroupHint (1L shl 6)
#define AllHints ((1L shl 0) or (1L shl 1) or (1L shl 2) or (1L shl 3) or (1L shl 4) or (1L shl 5) or (1L shl 6))
#define XUrgencyHint (1L shl 8)
#define WithdrawnState 0
#define NormalState 1
#define IconicState 3
#define DontCareState 0
#define ZoomState 2
#define InactiveState 4

type XTextProperty
	value as ubyte ptr
	encoding as Atom
	format as integer
	nitems as uinteger
end type

#define XNoMemory -1
#define XLocaleNotSupported -2
#define XConverterNotFound -3

enum XICCEncodingStyle
	XStringStyle
	XCompoundTextStyle
	XTextStyle
	XStdICCTextStyle
	XUTF8StringStyle
end enum


type XIconSize
	min_width as integer
	min_height as integer
	max_width as integer
	max_height as integer
	width_inc as integer
	height_inc as integer
end type

type XClassHint
	res_name as zstring ptr
	res_class as zstring ptr
end type

type _XComposeStatus
	compose_ptr as XPointer
	chars_matched as integer
end type

type XComposeStatus as _XComposeStatus
type Region as _XRegion ptr

#define RectangleOut 0
#define RectangleIn 1
#define RectanglePart 2

type XVisualInfo
	visual as Visual ptr
	visualid as VisualID
	screen as integer
	depth as integer
	class as integer
	red_mask as uinteger
	green_mask as uinteger
	blue_mask as uinteger
	colormap_size as integer
	bits_per_rgb as integer
end type

#define VisualNoMask &h0
#define VisualIDMask &h1
#define VisualScreenMask &h2
#define VisualDepthMask &h4
#define VisualClassMask &h8
#define VisualRedMaskMask &h10
#define VisualGreenMaskMask &h20
#define VisualBlueMaskMask &h40
#define VisualColormapSizeMask &h80
#define VisualBitsPerRGBMask &h100
#define VisualAllMask &h1FF

type XStandardColormap
	colormap as Colormap
	red_max as uinteger
	red_mult as uinteger
	green_max as uinteger
	green_mult as uinteger
	blue_max as uinteger
	blue_mult as uinteger
	base_pixel as uinteger
	visualid as VisualID
	killid as XID
end type

#define BitmapSuccess 0
#define BitmapOpenFailed 1
#define BitmapFileInvalid 2
#define BitmapNoMemory 3
#define XCSUCCESS 0
#define XCNOMEM 1
#define XCNOENT 2

type XContext as integer

declare function XAllocClassHint cdecl alias "XAllocClassHint" () as XClassHint ptr
declare function XAllocIconSize cdecl alias "XAllocIconSize" () as XIconSize ptr
declare function XAllocSizeHints cdecl alias "XAllocSizeHints" () as XSizeHints ptr
declare function XAllocStandardColormap cdecl alias "XAllocStandardColormap" () as XStandardColormap ptr
declare function XAllocWMHints cdecl alias "XAllocWMHints" () as XWMHints ptr
declare function XClipBox cdecl alias "XClipBox" (byval as Region, byval as XRectangle ptr) as integer
declare function XCreateRegion cdecl alias "XCreateRegion" () as Region
declare function XDefaultString cdecl alias "XDefaultString" () as zstring ptr
declare function XDeleteContext cdecl alias "XDeleteContext" (byval as Display ptr, byval as XID, byval as XContext) as integer
declare function XDestroyRegion cdecl alias "XDestroyRegion" (byval as Region) as integer
declare function XEmptyRegion cdecl alias "XEmptyRegion" (byval as Region) as integer
declare function XEqualRegion cdecl alias "XEqualRegion" (byval as Region, byval as Region) as integer
declare function XFindContext cdecl alias "XFindContext" (byval as Display ptr, byval as XID, byval as XContext, byval as XPointer ptr) as integer
declare function XGetClassHint cdecl alias "XGetClassHint" (byval as Display ptr, byval as Window, byval as XClassHint ptr) as Status
declare function XGetIconSizes cdecl alias "XGetIconSizes" (byval as Display ptr, byval as Window, byval as XIconSize ptr ptr, byval as integer ptr) as Status
declare function XGetNormalHints cdecl alias "XGetNormalHints" (byval as Display ptr, byval as Window, byval as XSizeHints ptr) as Status
declare function XGetRGBColormaps cdecl alias "XGetRGBColormaps" (byval as Display ptr, byval as Window, byval as XStandardColormap ptr ptr, byval as integer ptr, byval as Atom) as Status
declare function XGetSizeHints cdecl alias "XGetSizeHints" (byval as Display ptr, byval as Window, byval as XSizeHints ptr, byval as Atom) as Status
declare function XGetStandardColormap cdecl alias "XGetStandardColormap" (byval as Display ptr, byval as Window, byval as XStandardColormap ptr, byval as Atom) as Status
declare function XGetTextProperty cdecl alias "XGetTextProperty" (byval as Display ptr, byval as Window, byval as XTextProperty ptr, byval as Atom) as Status
declare function XGetVisualInfo cdecl alias "XGetVisualInfo" (byval as Display ptr, byval as integer, byval as XVisualInfo ptr, byval as integer ptr) as XVisualInfo ptr
declare function XGetWMClientMachine cdecl alias "XGetWMClientMachine" (byval as Display ptr, byval as Window, byval as XTextProperty ptr) as Status
declare function XGetWMHints cdecl alias "XGetWMHints" (byval as Display ptr, byval as Window) as XWMHints ptr
declare function XGetWMIconName cdecl alias "XGetWMIconName" (byval as Display ptr, byval as Window, byval as XTextProperty ptr) as Status
declare function XGetWMName cdecl alias "XGetWMName" (byval as Display ptr, byval as Window, byval as XTextProperty ptr) as Status
declare function XGetWMNormalHints cdecl alias "XGetWMNormalHints" (byval as Display ptr, byval as Window, byval as XSizeHints ptr, byval as integer ptr) as Status
declare function XGetWMSizeHints cdecl alias "XGetWMSizeHints" (byval as Display ptr, byval as Window, byval as XSizeHints ptr, byval as integer ptr, byval as Atom) as Status
declare function XGetZoomHints cdecl alias "XGetZoomHints" (byval as Display ptr, byval as Window, byval as XSizeHints ptr) as Status
declare function XIntersectRegion cdecl alias "XIntersectRegion" (byval as Region, byval as Region, byval as Region) as integer
declare sub XConvertCase cdecl alias "XConvertCase" (byval as KeySym, byval as KeySym ptr, byval as KeySym ptr)
declare function XLookupString cdecl alias "XLookupString" (byval as XKeyEvent ptr, byval as zstring ptr, byval as integer, byval as KeySym ptr, byval as XComposeStatus ptr) as integer
declare function XMatchVisualInfo cdecl alias "XMatchVisualInfo" (byval as Display ptr, byval as integer, byval as integer, byval as integer, byval as XVisualInfo ptr) as Status
declare function XOffsetRegion cdecl alias "XOffsetRegion" (byval as Region, byval as integer, byval as integer) as integer
declare function XPointInRegion cdecl alias "XPointInRegion" (byval as Region, byval as integer, byval as integer) as Bool
declare function XPolygonRegion cdecl alias "XPolygonRegion" (byval as XPoint ptr, byval as integer, byval as integer) as Region
declare function XRectInRegion cdecl alias "XRectInRegion" (byval as Region, byval as integer, byval as integer, byval as uinteger, byval as uinteger) as integer
declare function XSetClassHint cdecl alias "XSetClassHint" (byval as Display ptr, byval as Window, byval as XClassHint ptr) as integer
declare function XSetIconSizes cdecl alias "XSetIconSizes" (byval as Display ptr, byval as Window, byval as XIconSize ptr, byval as integer) as integer
declare function XSetNormalHints cdecl alias "XSetNormalHints" (byval as Display ptr, byval as Window, byval as XSizeHints ptr) as integer
declare sub XSetRGBColormaps cdecl alias "XSetRGBColormaps" (byval as Display ptr, byval as Window, byval as XStandardColormap ptr, byval as integer, byval as Atom)
declare function XSetSizeHints cdecl alias "XSetSizeHints" (byval as Display ptr, byval as Window, byval as XSizeHints ptr, byval as Atom) as integer
declare sub XSetTextProperty cdecl alias "XSetTextProperty" (byval as Display ptr, byval as Window, byval as XTextProperty ptr, byval as Atom)
declare sub XSetWMClientMachine cdecl alias "XSetWMClientMachine" (byval as Display ptr, byval as Window, byval as XTextProperty ptr)
declare function XSetWMHints cdecl alias "XSetWMHints" (byval as Display ptr, byval as Window, byval as XWMHints ptr) as integer
declare sub XSetWMIconName cdecl alias "XSetWMIconName" (byval as Display ptr, byval as Window, byval as XTextProperty ptr)
declare sub XSetWMName cdecl alias "XSetWMName" (byval as Display ptr, byval as Window, byval as XTextProperty ptr)
declare sub XSetWMNormalHints cdecl alias "XSetWMNormalHints" (byval as Display ptr, byval as Window, byval as XSizeHints ptr)
declare sub XSetWMProperties cdecl alias "XSetWMProperties" (byval as Display ptr, byval as Window, byval as XTextProperty ptr, byval as XTextProperty ptr, byval as byte ptr ptr, byval as integer, byval as XSizeHints ptr, byval as XWMHints ptr, byval as XClassHint ptr)
declare sub XSetWMSizeHints cdecl alias "XSetWMSizeHints" (byval as Display ptr, byval as Window, byval as XSizeHints ptr, byval as Atom)
declare function XSetRegion cdecl alias "XSetRegion" (byval as Display ptr, byval as GC, byval as Region) as integer
declare sub XSetStandardColormap cdecl alias "XSetStandardColormap" (byval as Display ptr, byval as Window, byval as XStandardColormap ptr, byval as Atom)
declare function XSetZoomHints cdecl alias "XSetZoomHints" (byval as Display ptr, byval as Window, byval as XSizeHints ptr) as integer
declare function XShrinkRegion cdecl alias "XShrinkRegion" (byval as Region, byval as integer, byval as integer) as integer
declare function XStringListToTextProperty cdecl alias "XStringListToTextProperty" (byval as byte ptr ptr, byval as integer, byval as XTextProperty ptr) as Status
declare function XSubtractRegion cdecl alias "XSubtractRegion" (byval as Region, byval as Region, byval as Region) as integer
declare function XmbTextListToTextProperty cdecl alias "XmbTextListToTextProperty" (byval display as Display ptr, byval list as byte ptr ptr, byval count as integer, byval style as XICCEncodingStyle, byval text_prop_return as XTextProperty ptr) as integer
declare function XwcTextListToTextProperty cdecl alias "XwcTextListToTextProperty" (byval display as Display ptr, byval list as wchar_t ptr ptr, byval count as integer, byval style as XICCEncodingStyle, byval text_prop_return as XTextProperty ptr) as integer
declare function Xutf8TextListToTextProperty cdecl alias "Xutf8TextListToTextProperty" (byval display as Display ptr, byval list as byte ptr ptr, byval count as integer, byval style as XICCEncodingStyle, byval text_prop_return as XTextProperty ptr) as integer
declare sub XwcFreeStringList cdecl alias "XwcFreeStringList" (byval list as wchar_t ptr ptr)
declare function XTextPropertyToStringList cdecl alias "XTextPropertyToStringList" (byval as XTextProperty ptr, byval as byte ptr ptr ptr, byval as integer ptr) as Status
declare function XmbTextPropertyToTextList cdecl alias "XmbTextPropertyToTextList" (byval display as Display ptr, byval text_prop as XTextProperty ptr, byval list_return as byte ptr ptr ptr, byval count_return as integer ptr) as integer
declare function XwcTextPropertyToTextList cdecl alias "XwcTextPropertyToTextList" (byval display as Display ptr, byval text_prop as XTextProperty ptr, byval list_return as wchar_t ptr ptr ptr, byval count_return as integer ptr) as integer
declare function Xutf8TextPropertyToTextList cdecl alias "Xutf8TextPropertyToTextList" (byval display as Display ptr, byval text_prop as XTextProperty ptr, byval list_return as byte ptr ptr ptr, byval count_return as integer ptr) as integer
declare function XUnionRectWithRegion cdecl alias "XUnionRectWithRegion" (byval as XRectangle ptr, byval as Region, byval as Region) as integer
declare function XUnionRegion cdecl alias "XUnionRegion" (byval as Region, byval as Region, byval as Region) as integer
declare function XXorRegion cdecl alias "XXorRegion" (byval as Region, byval as Region, byval as Region) as integer

#endif
