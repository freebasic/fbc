'' FreeBASIC binding for libX11-1.6.3
''
'' based on the C header files:
''   *********************************************************
''
''   Copyright 1987, 1998  The Open Group
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
''   Copyright 1987 by Digital Equipment Corporation, Maynard, Massachusetts.
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
#include once "X11/Xlib.bi"
#include once "X11/keysym.bi"

extern "C"

#define _X11_XUTIL_H_
const NoValue = &h0000
const XValue = &h0001
const YValue = &h0002
const WidthValue = &h0004
const HeightValue = &h0008
const AllValues = &h000F
const XNegative = &h0010
const YNegative = &h0020

type XSizeHints_min_aspect
	x as long
	y as long
end type

type XSizeHints
	flags as clong
	x as long
	y as long
	width as long
	height as long
	min_width as long
	min_height as long
	max_width as long
	max_height as long
	width_inc as long
	height_inc as long
	min_aspect as XSizeHints_min_aspect
	max_aspect as XSizeHints_min_aspect
	base_width as long
	base_height as long
	win_gravity as long
end type

const USPosition = cast(clong, 1) shl 0
const USSize = cast(clong, 1) shl 1
const PPosition = cast(clong, 1) shl 2
const PSize = cast(clong, 1) shl 3
const PMinSize = cast(clong, 1) shl 4
const PMaxSize = cast(clong, 1) shl 5
const PResizeInc = cast(clong, 1) shl 6
const PAspect = cast(clong, 1) shl 7
const PBaseSize = cast(clong, 1) shl 8
const PWinGravity = cast(clong, 1) shl 9
const PAllHints = ((((PPosition or PSize) or PMinSize) or PMaxSize) or PResizeInc) or PAspect

type XWMHints
	flags as clong
	input as long
	initial_state as long
	icon_pixmap as Pixmap
	icon_window as Window
	icon_x as long
	icon_y as long
	icon_mask as Pixmap
	window_group as XID
end type

const InputHint = cast(clong, 1) shl 0
const StateHint = cast(clong, 1) shl 1
const IconPixmapHint = cast(clong, 1) shl 2
const IconWindowHint = cast(clong, 1) shl 3
const IconPositionHint = cast(clong, 1) shl 4
const IconMaskHint = cast(clong, 1) shl 5
const WindowGroupHint = cast(clong, 1) shl 6
const AllHints = (((((InputHint or StateHint) or IconPixmapHint) or IconWindowHint) or IconPositionHint) or IconMaskHint) or WindowGroupHint
const XUrgencyHint = cast(clong, 1) shl 8
const WithdrawnState = 0
const NormalState = 1
const IconicState = 3
const DontCareState = 0
const ZoomState = 2
const InactiveState = 4

type XTextProperty
	value as ubyte ptr
	encoding as XAtom
	format as long
	nitems as culong
end type

const XNoMemory = -1
const XLocaleNotSupported = -2
const XConverterNotFound = -3

type XICCEncodingStyle as long
enum
	XStringStyle
	XCompoundTextStyle
	XTextStyle
	XStdICCTextStyle
	XUTF8StringStyle
end enum

type XIconSize
	min_width as long
	min_height as long
	max_width as long
	max_height as long
	width_inc as long
	height_inc as long
end type

type XClassHint
	res_name as zstring ptr
	res_class as zstring ptr
end type

#define XDestroyImage(ximage) ((ximage)->f.destroy_image((ximage)))
#define XGetPixel(ximage, x, y) ((ximage)->f.get_pixel((ximage), (x), (y)))
#define XPutPixel(ximage, x, y, pixel) ((ximage)->f.put_pixel((ximage), (x), (y), (pixel)))
#define XSubImage(ximage, x, y, width, height) ((ximage)->f.sub_image((ximage), (x), (y), (width), (height)))
#define XAddPixel(ximage, value) ((ximage)->f.add_pixel((ximage), (value)))

type _XComposeStatus
	compose_ptr as XPointer
	chars_matched as long
end type

type XComposeStatus as _XComposeStatus
#define IsKeypadKey(keysym_) ((cast(KeySym, (keysym_)) >= XK_KP_Space) andalso (cast(KeySym, (keysym_)) <= XK_KP_Equal))
#define IsPrivateKeypadKey(keysym_) ((cast(KeySym, (keysym_)) >= &h11000000) andalso (cast(KeySym, (keysym_)) <= &h1100FFFF))
#define IsCursorKey(keysym_) ((cast(KeySym, (keysym_)) >= XK_Home) andalso (cast(KeySym, (keysym_)) < XK_Select))
#define IsPFKey(keysym_) ((cast(KeySym, (keysym_)) >= XK_KP_F1) andalso (cast(KeySym, (keysym_)) <= XK_KP_F4))
#define IsFunctionKey(keysym_) ((cast(KeySym, (keysym_)) >= XK_F1) andalso (cast(KeySym, (keysym_)) <= XK_F35))
#define IsMiscFunctionKey(keysym_) ((cast(KeySym, (keysym_)) >= XK_Select) andalso (cast(KeySym, (keysym_)) <= XK_Break))
#define IsModifierKey(keysym_) (((((cast(KeySym, (keysym_)) >= XK_Shift_L) andalso (cast(KeySym, (keysym_)) <= XK_Hyper_R)) orelse ((cast(KeySym, (keysym_)) >= XK_ISO_Lock) andalso (cast(KeySym, (keysym_)) <= XK_ISO_Level5_Lock))) orelse (cast(KeySym, (keysym_)) = XK_Mode_switch)) orelse (cast(KeySym, (keysym_)) = XK_Num_Lock))
type Region as _XRegion ptr
const RectangleOut = 0
const RectangleIn = 1
const RectanglePart = 2

type XVisualInfo
	visual as Visual ptr
	visualid as VisualID
	screen as long
	depth as long
	class as long
	red_mask as culong
	green_mask as culong
	blue_mask as culong
	colormap_size as long
	bits_per_rgb as long
end type

const VisualNoMask = &h0
const VisualIDMask = &h1
const VisualScreenMask = &h2
const VisualDepthMask = &h4
const VisualClassMask = &h8
const VisualRedMaskMask = &h10
const VisualGreenMaskMask = &h20
const VisualBlueMaskMask = &h40
const VisualColormapSizeMask = &h80
const VisualBitsPerRGBMask = &h100
const VisualAllMask = &h1FF

type XStandardColormap
	colormap as Colormap
	red_max as culong
	red_mult as culong
	green_max as culong
	green_mult as culong
	blue_max as culong
	blue_mult as culong
	base_pixel as culong
	visualid as VisualID
	killid as XID
end type

const ReleaseByFreeingColormap = cast(XID, cast(clong, 1))
const BitmapSuccess = 0
const BitmapOpenFailed = 1
const BitmapFileInvalid = 2
const BitmapNoMemory = 3
const XCSUCCESS = 0
const XCNOMEM = 1
const XCNOENT = 2
type XContext as long
#define XUniqueContext() cast(XContext, XrmUniqueQuark())
#define XStringToContext(string) cast(XContext, XrmStringToQuark(string))

declare function XAllocClassHint() as XClassHint ptr
declare function XAllocIconSize() as XIconSize ptr
declare function XAllocSizeHints() as XSizeHints ptr
declare function XAllocStandardColormap() as XStandardColormap ptr
declare function XAllocWMHints() as XWMHints ptr
declare function XClipBox(byval as Region, byval as XRectangle ptr) as long
declare function XCreateRegion() as Region
declare function XDefaultString() as const zstring ptr
declare function XDeleteContext(byval as Display ptr, byval as XID, byval as XContext) as long
declare function XDestroyRegion(byval as Region) as long
declare function XEmptyRegion(byval as Region) as long
declare function XEqualRegion(byval as Region, byval as Region) as long
declare function XFindContext(byval as Display ptr, byval as XID, byval as XContext, byval as XPointer ptr) as long
declare function XGetClassHint(byval as Display ptr, byval as Window, byval as XClassHint ptr) as long
declare function XGetIconSizes(byval as Display ptr, byval as Window, byval as XIconSize ptr ptr, byval as long ptr) as long
declare function XGetNormalHints(byval as Display ptr, byval as Window, byval as XSizeHints ptr) as long
declare function XGetRGBColormaps(byval as Display ptr, byval as Window, byval as XStandardColormap ptr ptr, byval as long ptr, byval as XAtom) as long
declare function XGetSizeHints(byval as Display ptr, byval as Window, byval as XSizeHints ptr, byval as XAtom) as long
declare function XGetStandardColormap(byval as Display ptr, byval as Window, byval as XStandardColormap ptr, byval as XAtom) as long
declare function XGetTextProperty(byval as Display ptr, byval as Window, byval as XTextProperty ptr, byval as XAtom) as long
declare function XGetVisualInfo(byval as Display ptr, byval as clong, byval as XVisualInfo ptr, byval as long ptr) as XVisualInfo ptr
declare function XGetWMClientMachine(byval as Display ptr, byval as Window, byval as XTextProperty ptr) as long
declare function XGetWMHints(byval as Display ptr, byval as Window) as XWMHints ptr
declare function XGetWMIconName(byval as Display ptr, byval as Window, byval as XTextProperty ptr) as long
declare function XGetWMName(byval as Display ptr, byval as Window, byval as XTextProperty ptr) as long
declare function XGetWMNormalHints(byval as Display ptr, byval as Window, byval as XSizeHints ptr, byval as clong ptr) as long
declare function XGetWMSizeHints(byval as Display ptr, byval as Window, byval as XSizeHints ptr, byval as clong ptr, byval as XAtom) as long
declare function XGetZoomHints(byval as Display ptr, byval as Window, byval as XSizeHints ptr) as long
declare function XIntersectRegion(byval as Region, byval as Region, byval as Region) as long
declare sub XConvertCase(byval as KeySym, byval as KeySym ptr, byval as KeySym ptr)
declare function XLookupString(byval as XKeyEvent ptr, byval as zstring ptr, byval as long, byval as KeySym ptr, byval as XComposeStatus ptr) as long
declare function XMatchVisualInfo(byval as Display ptr, byval as long, byval as long, byval as long, byval as XVisualInfo ptr) as long
declare function XOffsetRegion(byval as Region, byval as long, byval as long) as long
declare function XPointInRegion(byval as Region, byval as long, byval as long) as long
declare function XPolygonRegion(byval as XPoint ptr, byval as long, byval as long) as Region
declare function XRectInRegion(byval as Region, byval as long, byval as long, byval as ulong, byval as ulong) as long
declare function XSaveContext(byval as Display ptr, byval as XID, byval as XContext, byval as const zstring ptr) as long
declare function XSetClassHint(byval as Display ptr, byval as Window, byval as XClassHint ptr) as long
declare function XSetIconSizes(byval as Display ptr, byval as Window, byval as XIconSize ptr, byval as long) as long
declare function XSetNormalHints(byval as Display ptr, byval as Window, byval as XSizeHints ptr) as long
declare sub XSetRGBColormaps(byval as Display ptr, byval as Window, byval as XStandardColormap ptr, byval as long, byval as XAtom)
declare function XSetSizeHints(byval as Display ptr, byval as Window, byval as XSizeHints ptr, byval as XAtom) as long
declare function XSetStandardProperties(byval as Display ptr, byval as Window, byval as const zstring ptr, byval as const zstring ptr, byval as Pixmap, byval as zstring ptr ptr, byval as long, byval as XSizeHints ptr) as long
declare sub XSetTextProperty(byval as Display ptr, byval as Window, byval as XTextProperty ptr, byval as XAtom)
declare sub XSetWMClientMachine(byval as Display ptr, byval as Window, byval as XTextProperty ptr)
declare function XSetWMHints(byval as Display ptr, byval as Window, byval as XWMHints ptr) as long
declare sub XSetWMIconName(byval as Display ptr, byval as Window, byval as XTextProperty ptr)
declare sub XSetWMName(byval as Display ptr, byval as Window, byval as XTextProperty ptr)
declare sub XSetWMNormalHints(byval as Display ptr, byval as Window, byval as XSizeHints ptr)
declare sub XSetWMProperties(byval as Display ptr, byval as Window, byval as XTextProperty ptr, byval as XTextProperty ptr, byval as zstring ptr ptr, byval as long, byval as XSizeHints ptr, byval as XWMHints ptr, byval as XClassHint ptr)
declare sub XmbSetWMProperties(byval as Display ptr, byval as Window, byval as const zstring ptr, byval as const zstring ptr, byval as zstring ptr ptr, byval as long, byval as XSizeHints ptr, byval as XWMHints ptr, byval as XClassHint ptr)
declare sub Xutf8SetWMProperties(byval as Display ptr, byval as Window, byval as const zstring ptr, byval as const zstring ptr, byval as zstring ptr ptr, byval as long, byval as XSizeHints ptr, byval as XWMHints ptr, byval as XClassHint ptr)
declare sub XSetWMSizeHints(byval as Display ptr, byval as Window, byval as XSizeHints ptr, byval as XAtom)
declare function XSetRegion(byval as Display ptr, byval as GC, byval as Region) as long
declare sub XSetStandardColormap(byval as Display ptr, byval as Window, byval as XStandardColormap ptr, byval as XAtom)
declare function XSetZoomHints(byval as Display ptr, byval as Window, byval as XSizeHints ptr) as long
declare function XShrinkRegion(byval as Region, byval as long, byval as long) as long
declare function XStringListToTextProperty(byval as zstring ptr ptr, byval as long, byval as XTextProperty ptr) as long
declare function XSubtractRegion(byval as Region, byval as Region, byval as Region) as long
declare function XmbTextListToTextProperty(byval display as Display ptr, byval list as zstring ptr ptr, byval count as long, byval style as XICCEncodingStyle, byval text_prop_return as XTextProperty ptr) as long
declare function XwcTextListToTextProperty(byval display as Display ptr, byval list as wstring ptr ptr, byval count as long, byval style as XICCEncodingStyle, byval text_prop_return as XTextProperty ptr) as long
declare function Xutf8TextListToTextProperty(byval display as Display ptr, byval list as zstring ptr ptr, byval count as long, byval style as XICCEncodingStyle, byval text_prop_return as XTextProperty ptr) as long
declare sub XwcFreeStringList(byval list as wstring ptr ptr)
declare function XTextPropertyToStringList(byval as XTextProperty ptr, byval as zstring ptr ptr ptr, byval as long ptr) as long
declare function XmbTextPropertyToTextList(byval display as Display ptr, byval text_prop as const XTextProperty ptr, byval list_return as zstring ptr ptr ptr, byval count_return as long ptr) as long
declare function XwcTextPropertyToTextList(byval display as Display ptr, byval text_prop as const XTextProperty ptr, byval list_return as wstring ptr ptr ptr, byval count_return as long ptr) as long
declare function Xutf8TextPropertyToTextList(byval display as Display ptr, byval text_prop as const XTextProperty ptr, byval list_return as zstring ptr ptr ptr, byval count_return as long ptr) as long
declare function XUnionRectWithRegion(byval as XRectangle ptr, byval as Region, byval as Region) as long
declare function XUnionRegion(byval as Region, byval as Region, byval as Region) as long
declare function XWMGeometry(byval as Display ptr, byval as long, byval as const zstring ptr, byval as const zstring ptr, byval as ulong, byval as XSizeHints ptr, byval as long ptr, byval as long ptr, byval as long ptr, byval as long ptr, byval as long ptr) as long
declare function XXorRegion(byval as Region, byval as Region, byval as Region) as long

end extern
