'' FreeBASIC binding for libX11-1.6.3
''
'' based on the C header files:
''
''   Copyright 1985, 1986, 1987, 1991, 1998  The Open Group
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

#include once "crt/long.bi"
#include once "crt/sys/types.bi"
#include once "X11/X.bi"
#include once "X11/Xfuncproto.bi"
#include once "X11/Xosdefs.bi"
#include once "crt/stddef.bi"

'' The following symbols have been renamed:
''     constant XLookupKeySym => XLookupKeySym_

extern "C"

#define _X11_XLIB_H_
const XlibSpecificationRelease = 6
declare function _Xmblen(byval str as zstring ptr, byval len as long) as long
const X_HAVE_UTF8_STRING = 1
type XPointer as zstring ptr
const QueuedAlready = 0
const QueuedAfterReading = 1
const QueuedAfterFlush = 2
#define ConnectionNumber(dpy) cast(_XPrivDisplay, dpy)->fd
#define RootWindow(dpy, scr) ScreenOfDisplay(dpy, scr)->root
#define DefaultScreen(dpy) cast(_XPrivDisplay, dpy)->default_screen
#define DefaultRootWindow(dpy) ScreenOfDisplay(dpy, DefaultScreen(dpy))->root
#define DefaultVisual(dpy, scr) ScreenOfDisplay(dpy, scr)->root_visual
#define DefaultGC(dpy, scr) ScreenOfDisplay(dpy, scr)->default_gc
#define BlackPixel(dpy, scr) ScreenOfDisplay(dpy, scr)->black_pixel
#define WhitePixel(dpy, scr) ScreenOfDisplay(dpy, scr)->white_pixel
const AllPlanes = cast(culong, not cast(clong, 0))
#define QLength(dpy) cast(_XPrivDisplay, dpy)->qlen
#define DisplayWidth(dpy, scr) ScreenOfDisplay(dpy, scr)->width
#define DisplayHeight(dpy, scr) ScreenOfDisplay(dpy, scr)->height
#define DisplayWidthMM(dpy, scr) ScreenOfDisplay(dpy, scr)->mwidth
#define DisplayHeightMM(dpy, scr) ScreenOfDisplay(dpy, scr)->mheight
#define DisplayPlanes(dpy, scr) ScreenOfDisplay(dpy, scr)->root_depth
#define DisplayCells(dpy, scr) DefaultVisual(dpy, scr)->map_entries
#define ScreenCount(dpy) cast(_XPrivDisplay, dpy)->nscreens
#define ServerVendor(dpy) cast(_XPrivDisplay, dpy)->vendor
#define ProtocolVersion(dpy) cast(_XPrivDisplay, dpy)->proto_major_version
#define ProtocolRevision(dpy) cast(_XPrivDisplay, dpy)->proto_minor_version
#define VendorRelease(dpy) cast(_XPrivDisplay, dpy)->release
#define DisplayString(dpy) cast(_XPrivDisplay, dpy)->display_name
#define DefaultDepth(dpy, scr) ScreenOfDisplay(dpy, scr)->root_depth
#define DefaultColormap(dpy, scr) ScreenOfDisplay(dpy, scr)->cmap
#define BitmapUnit(dpy) cast(_XPrivDisplay, dpy)->bitmap_unit
#define BitmapBitOrder(dpy) cast(_XPrivDisplay, dpy)->bitmap_bit_order
#define BitmapPad(dpy) cast(_XPrivDisplay, dpy)->bitmap_pad
#define ImageByteOrder(dpy) cast(_XPrivDisplay, dpy)->byte_order
#define NextRequest(dpy) (cast(_XPrivDisplay, dpy)->request + 1)
#define LastKnownRequestProcessed(dpy) cast(_XPrivDisplay, dpy)->last_request_read
#define ScreenOfDisplay(dpy, scr) (@cast(_XPrivDisplay, dpy)->screens[scr])
#define DefaultScreenOfDisplay(dpy) ScreenOfDisplay(dpy, DefaultScreen(dpy))
#define DisplayOfScreen(s) (s)->display
#define RootWindowOfScreen(s) (s)->root
#define BlackPixelOfScreen(s) (s)->black_pixel
#define WhitePixelOfScreen(s) (s)->white_pixel
#define DefaultColormapOfScreen(s) (s)->cmap
#define DefaultDepthOfScreen(s) (s)->root_depth
#define DefaultGCOfScreen(s) (s)->default_gc
#define DefaultVisualOfScreen(s) (s)->root_visual
#define WidthOfScreen(s) (s)->width
#define HeightOfScreen(s) (s)->height
#define WidthMMOfScreen(s) (s)->mwidth
#define HeightMMOfScreen(s) (s)->mheight
#define PlanesOfScreen(s) (s)->root_depth
#define CellsOfScreen(s) DefaultVisualOfScreen((s))->map_entries
#define MinCmapsOfScreen(s) (s)->min_maps
#define MaxCmapsOfScreen(s) (s)->max_maps
#define DoesSaveUnders(s) (s)->save_unders
#define DoesBackingStore(s) (s)->backing_store
#define EventMaskOfScreen(s) (s)->root_input_mask

type _XExtData
	number as long
	next as _XExtData ptr
	free_private as function(byval extension as _XExtData ptr) as long
	private_data as XPointer
end type

type XExtData as _XExtData

type XExtCodes
	extension as long
	major_opcode as long
	first_event as long
	first_error as long
end type

type XPixmapFormatValues
	depth as long
	bits_per_pixel as long
	scanline_pad as long
end type

type XGCValues
	function as long
	plane_mask as culong
	foreground as culong
	background as culong
	line_width as long
	line_style as long
	cap_style as long
	join_style as long
	fill_style as long
	fill_rule as long
	arc_mode as long
	tile as Pixmap
	stipple as Pixmap
	ts_x_origin as long
	ts_y_origin as long
	font as Font
	subwindow_mode as long
	graphics_exposures as long
	clip_x_origin as long
	clip_y_origin as long
	clip_mask as Pixmap
	dash_offset as long
	dashes as byte
end type

type GC as _XGC ptr

type Visual
	ext_data as XExtData ptr
	visualid as VisualID
	class as long
	red_mask as culong
	green_mask as culong
	blue_mask as culong
	bits_per_rgb as long
	map_entries as long
end type

type Depth
	depth as long
	nvisuals as long
	visuals as Visual ptr
end type

type _XDisplay as _XDisplay_

type Screen
	ext_data as XExtData ptr
	display as _XDisplay ptr
	root as Window
	width as long
	height as long
	mwidth as long
	mheight as long
	ndepths as long
	depths as Depth ptr
	root_depth as long
	root_visual as Visual ptr
	default_gc as GC
	cmap as Colormap
	white_pixel as culong
	black_pixel as culong
	max_maps as long
	min_maps as long
	backing_store as long
	save_unders as long
	root_input_mask as clong
end type

type ScreenFormat
	ext_data as XExtData ptr
	depth as long
	bits_per_pixel as long
	scanline_pad as long
end type

type XSetWindowAttributes
	background_pixmap as Pixmap
	background_pixel as culong
	border_pixmap as Pixmap
	border_pixel as culong
	bit_gravity as long
	win_gravity as long
	backing_store as long
	backing_planes as culong
	backing_pixel as culong
	save_under as long
	event_mask as clong
	do_not_propagate_mask as clong
	override_redirect as long
	colormap as Colormap
	cursor as Cursor
end type

type XWindowAttributes
	x as long
	y as long
	width as long
	height as long
	border_width as long
	depth as long
	visual as Visual ptr
	root as Window
	class as long
	bit_gravity as long
	win_gravity as long
	backing_store as long
	backing_planes as culong
	backing_pixel as culong
	save_under as long
	colormap as Colormap
	map_installed as long
	map_state as long
	all_event_masks as clong
	your_event_mask as clong
	do_not_propagate_mask as clong
	override_redirect as long
	screen as Screen ptr
end type

type XHostAddress
	family as long
	length as long
	address as zstring ptr
end type

type XServerInterpretedAddress
	typelength as long
	valuelength as long
	as zstring ptr type
	value as zstring ptr
end type

type _XImage as _XImage_

type funcs
	create_image as function(byval as _XDisplay ptr, byval as Visual ptr, byval as ulong, byval as long, byval as long, byval as zstring ptr, byval as ulong, byval as ulong, byval as long, byval as long) as _XImage ptr
	destroy_image as function(byval as _XImage ptr) as long
	get_pixel as function(byval as _XImage ptr, byval as long, byval as long) as culong
	put_pixel as function(byval as _XImage ptr, byval as long, byval as long, byval as culong) as long
	sub_image as function(byval as _XImage ptr, byval as long, byval as long, byval as ulong, byval as ulong) as _XImage ptr
	add_pixel as function(byval as _XImage ptr, byval as clong) as long
end type

type _XImage_
	width as long
	height as long
	xoffset as long
	format as long
	data as zstring ptr
	byte_order as long
	bitmap_unit as long
	bitmap_bit_order as long
	bitmap_pad as long
	depth as long
	bytes_per_line as long
	bits_per_pixel as long
	red_mask as culong
	green_mask as culong
	blue_mask as culong
	obdata as XPointer
	f as funcs
end type

type XImage as _XImage

type XWindowChanges
	x as long
	y as long
	width as long
	height as long
	border_width as long
	sibling as Window
	stack_mode as long
end type

type XColor
	pixel as culong
	red as ushort
	green as ushort
	blue as ushort
	flags as byte
	pad as byte
end type

type XSegment
	x1 as short
	y1 as short
	x2 as short
	y2 as short
end type

type XPoint
	x as short
	y as short
end type

type XRectangle
	x as short
	y as short
	width as ushort
	height as ushort
end type

type XArc
	x as short
	y as short
	width as ushort
	height as ushort
	angle1 as short
	angle2 as short
end type

type XKeyboardControl
	key_click_percent as long
	bell_percent as long
	bell_pitch as long
	bell_duration as long
	led as long
	led_mode as long
	key as long
	auto_repeat_mode as long
end type

type XKeyboardState
	key_click_percent as long
	bell_percent as long
	bell_pitch as ulong
	bell_duration as ulong
	led_mask as culong
	global_auto_repeat as long
	auto_repeats as zstring * 32
end type

type XTimeCoord
	time as Time
	x as short
	y as short
end type

type XModifierKeymap
	max_keypermod as long
	modifiermap as KeyCode ptr
end type

type Display as _XDisplay
type _XPrivate as _XPrivate_
type _XrmHashBucketRec as _XrmHashBucketRec_

type _XPrivDisplay_0
	ext_data as XExtData ptr
	private1 as _XPrivate ptr
	fd as long
	private2 as long
	proto_major_version as long
	proto_minor_version as long
	vendor as zstring ptr
	private3 as XID
	private4 as XID
	private5 as XID
	private6 as long
	resource_alloc as function(byval as _XDisplay ptr) as XID
	byte_order as long
	bitmap_unit as long
	bitmap_pad as long
	bitmap_bit_order as long
	nformats as long
	pixmap_format as ScreenFormat ptr
	private8 as long
	release as long
	private9 as _XPrivate ptr
	private10 as _XPrivate ptr
	qlen as long
	last_request_read as culong
	request as culong
	private11 as XPointer
	private12 as XPointer
	private13 as XPointer
	private14 as XPointer
	max_request_size as ulong
	db as _XrmHashBucketRec ptr
	private15 as function(byval as _XDisplay ptr) as long
	display_name as zstring ptr
	default_screen as long
	nscreens as long
	screens as Screen ptr
	motion_buffer as culong
	private16 as culong
	min_keycode as long
	max_keycode as long
	private17 as XPointer
	private18 as XPointer
	private19 as long
	xdefaults as zstring ptr
end type

type _XPrivDisplay as _XPrivDisplay_0 ptr

type XKeyEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	window as Window
	root as Window
	subwindow as Window
	time as Time
	x as long
	y as long
	x_root as long
	y_root as long
	state as ulong
	keycode as ulong
	same_screen as long
end type

type XKeyPressedEvent as XKeyEvent
type XKeyReleasedEvent as XKeyEvent

type XButtonEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	window as Window
	root as Window
	subwindow as Window
	time as Time
	x as long
	y as long
	x_root as long
	y_root as long
	state as ulong
	button as ulong
	same_screen as long
end type

type XButtonPressedEvent as XButtonEvent
type XButtonReleasedEvent as XButtonEvent

type XMotionEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	window as Window
	root as Window
	subwindow as Window
	time as Time
	x as long
	y as long
	x_root as long
	y_root as long
	state as ulong
	is_hint as byte
	same_screen as long
end type

type XPointerMovedEvent as XMotionEvent

type XCrossingEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	window as Window
	root as Window
	subwindow as Window
	time as Time
	x as long
	y as long
	x_root as long
	y_root as long
	mode as long
	detail as long
	same_screen as long
	focus as long
	state as ulong
end type

type XEnterWindowEvent as XCrossingEvent
type XLeaveWindowEvent as XCrossingEvent

type XFocusChangeEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	window as Window
	mode as long
	detail as long
end type

type XFocusInEvent as XFocusChangeEvent
type XFocusOutEvent as XFocusChangeEvent

type XKeymapEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	window as Window
	key_vector as zstring * 32
end type

type XExposeEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	window as Window
	x as long
	y as long
	width as long
	height as long
	count as long
end type

type XGraphicsExposeEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	drawable as Drawable
	x as long
	y as long
	width as long
	height as long
	count as long
	major_code as long
	minor_code as long
end type

type XNoExposeEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	drawable as Drawable
	major_code as long
	minor_code as long
end type

type XVisibilityEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	window as Window
	state as long
end type

type XCreateWindowEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	parent as Window
	window as Window
	x as long
	y as long
	width as long
	height as long
	border_width as long
	override_redirect as long
end type

type XDestroyWindowEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	event as Window
	window as Window
end type

type XUnmapEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	event as Window
	window as Window
	from_configure as long
end type

type XMapEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	event as Window
	window as Window
	override_redirect as long
end type

type XMapRequestEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	parent as Window
	window as Window
end type

type XReparentEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	event as Window
	window as Window
	parent as Window
	x as long
	y as long
	override_redirect as long
end type

type XConfigureEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	event as Window
	window as Window
	x as long
	y as long
	width as long
	height as long
	border_width as long
	above as Window
	override_redirect as long
end type

type XGravityEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	event as Window
	window as Window
	x as long
	y as long
end type

type XResizeRequestEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	window as Window
	width as long
	height as long
end type

type XConfigureRequestEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	parent as Window
	window as Window
	x as long
	y as long
	width as long
	height as long
	border_width as long
	above as Window
	detail as long
	value_mask as culong
end type

type XCirculateEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	event as Window
	window as Window
	place as long
end type

type XCirculateRequestEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	parent as Window
	window as Window
	place as long
end type

type XPropertyEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	window as Window
	atom as XAtom
	time as Time
	state as long
end type

type XSelectionClearEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	window as Window
	selection as XAtom
	time as Time
end type

type XSelectionRequestEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	owner as Window
	requestor as Window
	selection as XAtom
	target as XAtom
	property as XAtom
	time as Time
end type

type XSelectionEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	requestor as Window
	selection as XAtom
	target as XAtom
	property as XAtom
	time as Time
end type

type XColormapEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	window as Window
	colormap as Colormap
	new_ as long
	state as long
end type

union XClientMessageEvent_data
	b as zstring * 20
	s(0 to 9) as short
	l(0 to 4) as clong
end union

type XClientMessageEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	window as Window
	message_type as XAtom
	format as long
	data as XClientMessageEvent_data
end type

type XMappingEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	window as Window
	request as long
	first_keycode as long
	count as long
end type

type XErrorEvent
	as long type
	display as Display ptr
	resourceid as XID
	serial as culong
	error_code as ubyte
	request_code as ubyte
	minor_code as ubyte
end type

type XAnyEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	window as Window
end type

type XGenericEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	extension as long
	evtype as long
end type

type XGenericEventCookie
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	extension as long
	evtype as long
	cookie as ulong
	data as any ptr
end type

union XEvent
	as long type
	xany as XAnyEvent
	xkey as XKeyEvent
	xbutton as XButtonEvent
	xmotion as XMotionEvent
	xcrossing as XCrossingEvent
	xfocus as XFocusChangeEvent
	xexpose as XExposeEvent
	xgraphicsexpose as XGraphicsExposeEvent
	xnoexpose as XNoExposeEvent
	xvisibility as XVisibilityEvent
	xcreatewindow as XCreateWindowEvent
	xdestroywindow as XDestroyWindowEvent
	xunmap as XUnmapEvent
	xmap as XMapEvent
	xmaprequest as XMapRequestEvent
	xreparent as XReparentEvent
	xconfigure as XConfigureEvent
	xgravity as XGravityEvent
	xresizerequest as XResizeRequestEvent
	xconfigurerequest as XConfigureRequestEvent
	xcirculate as XCirculateEvent
	xcirculaterequest as XCirculateRequestEvent
	xproperty as XPropertyEvent
	xselectionclear as XSelectionClearEvent
	xselectionrequest as XSelectionRequestEvent
	xselection as XSelectionEvent
	xcolormap as XColormapEvent
	xclient as XClientMessageEvent
	xmapping as XMappingEvent
	xerror as XErrorEvent
	xkeymap as XKeymapEvent
	xgeneric as XGenericEvent
	xcookie as XGenericEventCookie
	pad(0 to 23) as clong
end union

#define XAllocID(dpy) (cptr(_XPrivDisplay, dpy)->resource_alloc(dpy))

type XCharStruct
	lbearing as short
	rbearing as short
	width as short
	ascent as short
	descent as short
	attributes as ushort
end type

type XFontProp
	name as XAtom
	card32 as culong
end type

type XFontStruct
	ext_data as XExtData ptr
	fid as Font
	direction as ulong
	min_char_or_byte2 as ulong
	max_char_or_byte2 as ulong
	min_byte1 as ulong
	max_byte1 as ulong
	all_chars_exist as long
	default_char as ulong
	n_properties as long
	properties as XFontProp ptr
	min_bounds as XCharStruct
	max_bounds as XCharStruct
	per_char as XCharStruct ptr
	ascent as long
	descent as long
end type

type XTextItem
	chars as zstring ptr
	nchars as long
	delta as long
	font as Font
end type

type XChar2b
	byte1 as ubyte
	byte2 as ubyte
end type

type XTextItem16
	chars as XChar2b ptr
	nchars as long
	delta as long
	font as Font
end type

union XEDataObject
	display as Display ptr
	gc as GC
	visual as Visual ptr
	screen as Screen ptr
	pixmap_format as ScreenFormat ptr
	font as XFontStruct ptr
end union

type XFontSetExtents
	max_ink_extent as XRectangle
	max_logical_extent as XRectangle
end type

type XOM as _XOM ptr
type XOC as _XOC ptr
type XFontSet as _XOC ptr

type XmbTextItem
	chars as zstring ptr
	nchars as long
	delta as long
	font_set as XFontSet
end type

type XwcTextItem
	chars as wstring ptr
	nchars as long
	delta as long
	font_set as XFontSet
end type

#define XNRequiredCharSet "requiredCharSet"
#define XNQueryOrientation "queryOrientation"
#define XNBaseFontName "baseFontName"
#define XNOMAutomatic "omAutomatic"
#define XNMissingCharSet "missingCharSet"
#define XNDefaultString "defaultString"
#define XNOrientation "orientation"
#define XNDirectionalDependentDrawing "directionalDependentDrawing"
#define XNContextualDrawing "contextualDrawing"
#define XNFontInfo "fontInfo"

type XOMCharSetList
	charset_count as long
	charset_list as zstring ptr ptr
end type

type XOrientation as long
enum
	XOMOrientation_LTR_TTB
	XOMOrientation_RTL_TTB
	XOMOrientation_TTB_LTR
	XOMOrientation_TTB_RTL
	XOMOrientation_Context
end enum

type XOMOrientation
	num_orientation as long
	orientation as XOrientation ptr
end type

type XOMFontInfo
	num_font as long
	font_struct_list as XFontStruct ptr ptr
	font_name_list as zstring ptr ptr
end type

type XIM as _XIM ptr
type XIC as _XIC ptr
type XIMProc as sub(byval as XIM, byval as XPointer, byval as XPointer)
type XICProc as function(byval as XIC, byval as XPointer, byval as XPointer) as long
type XIDProc as sub(byval as Display ptr, byval as XPointer, byval as XPointer)
type XIMStyle as culong

type XIMStyles
	count_styles as ushort
	supported_styles as XIMStyle ptr
end type

const XIMPreeditArea = cast(clong, &h0001)
const XIMPreeditCallbacks = cast(clong, &h0002)
const XIMPreeditPosition = cast(clong, &h0004)
const XIMPreeditNothing = cast(clong, &h0008)
const XIMPreeditNone = cast(clong, &h0010)
const XIMStatusArea = cast(clong, &h0100)
const XIMStatusCallbacks = cast(clong, &h0200)
const XIMStatusNothing = cast(clong, &h0400)
const XIMStatusNone = cast(clong, &h0800)
#define XNVaNestedList "XNVaNestedList"
#define XNQueryInputStyle "queryInputStyle"
#define XNClientWindow "clientWindow"
#define XNInputStyle "inputStyle"
#define XNFocusWindow "focusWindow"
#define XNResourceName "resourceName"
#define XNResourceClass "resourceClass"
#define XNGeometryCallback "geometryCallback"
#define XNDestroyCallback "destroyCallback"
#define XNFilterEvents "filterEvents"
#define XNPreeditStartCallback "preeditStartCallback"
#define XNPreeditDoneCallback "preeditDoneCallback"
#define XNPreeditDrawCallback "preeditDrawCallback"
#define XNPreeditCaretCallback "preeditCaretCallback"
#define XNPreeditStateNotifyCallback "preeditStateNotifyCallback"
#define XNPreeditAttributes "preeditAttributes"
#define XNStatusStartCallback "statusStartCallback"
#define XNStatusDoneCallback "statusDoneCallback"
#define XNStatusDrawCallback "statusDrawCallback"
#define XNStatusAttributes "statusAttributes"
#define XNArea "area"
#define XNAreaNeeded "areaNeeded"
#define XNSpotLocation "spotLocation"
#define XNColormap "colorMap"
#define XNStdColormap "stdColorMap"
#define XNForeground "foreground"
#define XNBackground "background"
#define XNBackgroundPixmap "backgroundPixmap"
#define XNFontSet "fontSet"
#define XNLineSpace "lineSpace"
#define XNCursor "cursor"
#define XNQueryIMValuesList "queryIMValuesList"
#define XNQueryICValuesList "queryICValuesList"
#define XNVisiblePosition "visiblePosition"
#define XNR6PreeditCallback "r6PreeditCallback"
#define XNStringConversionCallback "stringConversionCallback"
#define XNStringConversion "stringConversion"
#define XNResetState "resetState"
#define XNHotKey "hotKey"
#define XNHotKeyState "hotKeyState"
#define XNPreeditState "preeditState"
#define XNSeparatorofNestedList "separatorofNestedList"
const XBufferOverflow = -1
const XLookupNone = 1
const XLookupChars = 2
const XLookupKeySym_ = 3
const XLookupBoth = 4
type XVaNestedList as any ptr

type XIMCallback
	client_data as XPointer
	callback as XIMProc
end type

type XICCallback
	client_data as XPointer
	callback as XICProc
end type

type XIMFeedback as culong
const XIMReverse = cast(clong, 1)
const XIMUnderline = cast(clong, 1) shl 1
const XIMHighlight = cast(clong, 1) shl 2
const XIMPrimary = cast(clong, 1) shl 5
const XIMSecondary = cast(clong, 1) shl 6
const XIMTertiary = cast(clong, 1) shl 7
const XIMVisibleToForward = cast(clong, 1) shl 8
const XIMVisibleToBackword = cast(clong, 1) shl 9
const XIMVisibleToCenter = cast(clong, 1) shl 10

union _XIMText_string
	multi_byte as zstring ptr
	wide_char as wstring ptr
end union

type _XIMText
	length as ushort
	feedback as XIMFeedback ptr
	encoding_is_wchar as long
	string as _XIMText_string
end type

type XIMText as _XIMText
type XIMPreeditState as culong
const XIMPreeditUnKnown = cast(clong, 0)
const XIMPreeditEnable = cast(clong, 1)
const XIMPreeditDisable = cast(clong, 1) shl 1

type _XIMPreeditStateNotifyCallbackStruct
	state as XIMPreeditState
end type

type XIMPreeditStateNotifyCallbackStruct as _XIMPreeditStateNotifyCallbackStruct
type XIMResetState as culong
const XIMInitialState = cast(clong, 1)
const XIMPreserveState = cast(clong, 1) shl 1
type XIMStringConversionFeedback as culong
const XIMStringConversionLeftEdge = &h00000001
const XIMStringConversionRightEdge = &h00000002
const XIMStringConversionTopEdge = &h00000004
const XIMStringConversionBottomEdge = &h00000008
const XIMStringConversionConcealed = &h00000010
const XIMStringConversionWrapped = &h00000020

union _XIMStringConversionText_string
	mbs as zstring ptr
	wcs as wstring ptr
end union

type _XIMStringConversionText
	length as ushort
	feedback as XIMStringConversionFeedback ptr
	encoding_is_wchar as long
	string as _XIMStringConversionText_string
end type

type XIMStringConversionText as _XIMStringConversionText
type XIMStringConversionPosition as ushort
type XIMStringConversionType as ushort

const XIMStringConversionBuffer = &h0001
const XIMStringConversionLine = &h0002
const XIMStringConversionWord = &h0003
const XIMStringConversionChar = &h0004
type XIMStringConversionOperation as ushort
const XIMStringConversionSubstitution = &h0001
const XIMStringConversionRetrieval = &h0002

type XIMCaretDirection as long
enum
	XIMForwardChar
	XIMBackwardChar
	XIMForwardWord
	XIMBackwardWord
	XIMCaretUp
	XIMCaretDown
	XIMNextLine
	XIMPreviousLine
	XIMLineStart
	XIMLineEnd
	XIMAbsolutePosition
	XIMDontChange
end enum

type _XIMStringConversionCallbackStruct
	position as XIMStringConversionPosition
	direction as XIMCaretDirection
	operation as XIMStringConversionOperation
	factor as ushort
	text as XIMStringConversionText ptr
end type

type XIMStringConversionCallbackStruct as _XIMStringConversionCallbackStruct

type _XIMPreeditDrawCallbackStruct
	caret as long
	chg_first as long
	chg_length as long
	text as XIMText ptr
end type

type XIMPreeditDrawCallbackStruct as _XIMPreeditDrawCallbackStruct

type XIMCaretStyle as long
enum
	XIMIsInvisible
	XIMIsPrimary
	XIMIsSecondary
end enum

type _XIMPreeditCaretCallbackStruct
	position as long
	direction as XIMCaretDirection
	style as XIMCaretStyle
end type

type XIMPreeditCaretCallbackStruct as _XIMPreeditCaretCallbackStruct

type XIMStatusDataType as long
enum
	XIMTextType
	XIMBitmapType
end enum

union _XIMStatusDrawCallbackStruct_data
	text as XIMText ptr
	bitmap as Pixmap
end union

type _XIMStatusDrawCallbackStruct
	as XIMStatusDataType type
	data as _XIMStatusDrawCallbackStruct_data
end type

type XIMStatusDrawCallbackStruct as _XIMStatusDrawCallbackStruct

type _XIMHotKeyTrigger
	keysym as KeySym
	modifier as long
	modifier_mask as long
end type

type XIMHotKeyTrigger as _XIMHotKeyTrigger

type _XIMHotKeyTriggers
	num_hot_key as long
	key as XIMHotKeyTrigger ptr
end type

type XIMHotKeyTriggers as _XIMHotKeyTriggers
type XIMHotKeyState as culong
const XIMHotKeyStateON = cast(clong, &h0001)
const XIMHotKeyStateOFF = cast(clong, &h0002)

type XIMValuesList
	count_values as ushort
	supported_values as zstring ptr ptr
end type

#ifdef __FB_UNIX__
	extern _Xdebug as long
#else
	#define _Xdebug (*_Xdebug_p)
	extern _Xdebug_p as long ptr
#endif

declare function XLoadQueryFont(byval as Display ptr, byval as const zstring ptr) as XFontStruct ptr
declare function XQueryFont(byval as Display ptr, byval as XID) as XFontStruct ptr
declare function XGetMotionEvents(byval as Display ptr, byval as Window, byval as Time, byval as Time, byval as long ptr) as XTimeCoord ptr
declare function XDeleteModifiermapEntry(byval as XModifierKeymap ptr, byval as KeyCode, byval as long) as XModifierKeymap ptr
declare function XGetModifierMapping(byval as Display ptr) as XModifierKeymap ptr
declare function XInsertModifiermapEntry(byval as XModifierKeymap ptr, byval as KeyCode, byval as long) as XModifierKeymap ptr
declare function XNewModifiermap(byval as long) as XModifierKeymap ptr
declare function XCreateImage(byval as Display ptr, byval as Visual ptr, byval as ulong, byval as long, byval as long, byval as zstring ptr, byval as ulong, byval as ulong, byval as long, byval as long) as XImage ptr
declare function XInitImage(byval as XImage ptr) as long
declare function XGetImage(byval as Display ptr, byval as Drawable, byval as long, byval as long, byval as ulong, byval as ulong, byval as culong, byval as long) as XImage ptr
declare function XGetSubImage(byval as Display ptr, byval as Drawable, byval as long, byval as long, byval as ulong, byval as ulong, byval as culong, byval as long, byval as XImage ptr, byval as long, byval as long) as XImage ptr
declare function XOpenDisplay(byval as const zstring ptr) as Display ptr
declare sub XrmInitialize()
declare function XFetchBytes(byval as Display ptr, byval as long ptr) as zstring ptr
declare function XFetchBuffer(byval as Display ptr, byval as long ptr, byval as long) as zstring ptr
declare function XGetAtomName(byval as Display ptr, byval as XAtom) as zstring ptr
declare function XGetAtomNames(byval as Display ptr, byval as XAtom ptr, byval as long, byval as zstring ptr ptr) as long
declare function XGetDefault(byval as Display ptr, byval as const zstring ptr, byval as const zstring ptr) as zstring ptr
declare function XDisplayName(byval as const zstring ptr) as zstring ptr
declare function XKeysymToString(byval as KeySym) as zstring ptr
declare function XSynchronize(byval as Display ptr, byval as long) as function(byval as Display ptr) as long
declare function XSetAfterFunction(byval as Display ptr, byval as function(byval as Display ptr) as long) as function(byval as Display ptr) as long
declare function XInternAtom(byval as Display ptr, byval as const zstring ptr, byval as long) as XAtom
declare function XInternAtoms(byval as Display ptr, byval as zstring ptr ptr, byval as long, byval as long, byval as XAtom ptr) as long
declare function XCopyColormapAndFree(byval as Display ptr, byval as Colormap) as Colormap
declare function XCreateColormap(byval as Display ptr, byval as Window, byval as Visual ptr, byval as long) as Colormap
declare function XCreatePixmapCursor(byval as Display ptr, byval as Pixmap, byval as Pixmap, byval as XColor ptr, byval as XColor ptr, byval as ulong, byval as ulong) as Cursor
declare function XCreateGlyphCursor(byval as Display ptr, byval as Font, byval as Font, byval as ulong, byval as ulong, byval as const XColor ptr, byval as const XColor ptr) as Cursor
declare function XCreateFontCursor(byval as Display ptr, byval as ulong) as Cursor
declare function XLoadFont(byval as Display ptr, byval as const zstring ptr) as Font
declare function XCreateGC(byval as Display ptr, byval as Drawable, byval as culong, byval as XGCValues ptr) as GC
declare function XGContextFromGC(byval as GC) as GContext
declare sub XFlushGC(byval as Display ptr, byval as GC)
declare function XCreatePixmap(byval as Display ptr, byval as Drawable, byval as ulong, byval as ulong, byval as ulong) as Pixmap
declare function XCreateBitmapFromData(byval as Display ptr, byval as Drawable, byval as const zstring ptr, byval as ulong, byval as ulong) as Pixmap
declare function XCreatePixmapFromBitmapData(byval as Display ptr, byval as Drawable, byval as zstring ptr, byval as ulong, byval as ulong, byval as culong, byval as culong, byval as ulong) as Pixmap
declare function XCreateSimpleWindow(byval as Display ptr, byval as Window, byval as long, byval as long, byval as ulong, byval as ulong, byval as ulong, byval as culong, byval as culong) as Window
declare function XGetSelectionOwner(byval as Display ptr, byval as XAtom) as Window
declare function XCreateWindow(byval as Display ptr, byval as Window, byval as long, byval as long, byval as ulong, byval as ulong, byval as ulong, byval as long, byval as ulong, byval as Visual ptr, byval as culong, byval as XSetWindowAttributes ptr) as Window
declare function XListInstalledColormaps(byval as Display ptr, byval as Window, byval as long ptr) as Colormap ptr
declare function XListFonts(byval as Display ptr, byval as const zstring ptr, byval as long, byval as long ptr) as zstring ptr ptr
declare function XListFontsWithInfo(byval as Display ptr, byval as const zstring ptr, byval as long, byval as long ptr, byval as XFontStruct ptr ptr) as zstring ptr ptr
declare function XGetFontPath(byval as Display ptr, byval as long ptr) as zstring ptr ptr
declare function XListExtensions(byval as Display ptr, byval as long ptr) as zstring ptr ptr
declare function XListProperties(byval as Display ptr, byval as Window, byval as long ptr) as XAtom ptr
declare function XListHosts(byval as Display ptr, byval as long ptr, byval as long ptr) as XHostAddress ptr
declare function XKeycodeToKeysym(byval as Display ptr, byval as KeyCode, byval as long) as KeySym
declare function XLookupKeysym(byval as XKeyEvent ptr, byval as long) as KeySym
declare function XGetKeyboardMapping(byval as Display ptr, byval as KeyCode, byval as long, byval as long ptr) as KeySym ptr
declare function XStringToKeysym(byval as const zstring ptr) as KeySym
declare function XMaxRequestSize(byval as Display ptr) as clong
declare function XExtendedMaxRequestSize(byval as Display ptr) as clong
declare function XResourceManagerString(byval as Display ptr) as zstring ptr
declare function XScreenResourceString(byval as Screen ptr) as zstring ptr
declare function XDisplayMotionBufferSize(byval as Display ptr) as culong
declare function XVisualIDFromVisual(byval as Visual ptr) as VisualID
declare function XInitThreads() as long
declare sub XLockDisplay(byval as Display ptr)
declare sub XUnlockDisplay(byval as Display ptr)
declare function XInitExtension(byval as Display ptr, byval as const zstring ptr) as XExtCodes ptr
declare function XAddExtension(byval as Display ptr) as XExtCodes ptr
declare function XFindOnExtensionList(byval as XExtData ptr ptr, byval as long) as XExtData ptr
declare function XEHeadOfExtensionList(byval as XEDataObject) as XExtData ptr ptr
declare function XRootWindow(byval as Display ptr, byval as long) as Window
declare function XDefaultRootWindow(byval as Display ptr) as Window
declare function XRootWindowOfScreen(byval as Screen ptr) as Window
declare function XDefaultVisual(byval as Display ptr, byval as long) as Visual ptr
declare function XDefaultVisualOfScreen(byval as Screen ptr) as Visual ptr
declare function XDefaultGC(byval as Display ptr, byval as long) as GC
declare function XDefaultGCOfScreen(byval as Screen ptr) as GC
declare function XBlackPixel(byval as Display ptr, byval as long) as culong
declare function XWhitePixel(byval as Display ptr, byval as long) as culong
declare function XAllPlanes() as culong
declare function XBlackPixelOfScreen(byval as Screen ptr) as culong
declare function XWhitePixelOfScreen(byval as Screen ptr) as culong
declare function XNextRequest(byval as Display ptr) as culong
declare function XLastKnownRequestProcessed(byval as Display ptr) as culong
declare function XServerVendor(byval as Display ptr) as zstring ptr
declare function XDisplayString(byval as Display ptr) as zstring ptr
declare function XDefaultColormap(byval as Display ptr, byval as long) as Colormap
declare function XDefaultColormapOfScreen(byval as Screen ptr) as Colormap
declare function XDisplayOfScreen(byval as Screen ptr) as Display ptr
declare function XScreenOfDisplay(byval as Display ptr, byval as long) as Screen ptr
declare function XDefaultScreenOfDisplay(byval as Display ptr) as Screen ptr
declare function XEventMaskOfScreen(byval as Screen ptr) as clong
declare function XScreenNumberOfScreen(byval as Screen ptr) as long
type XErrorHandler as function(byval as Display ptr, byval as XErrorEvent ptr) as long
declare function XSetErrorHandler(byval as XErrorHandler) as XErrorHandler
type XIOErrorHandler as function(byval as Display ptr) as long
declare function XSetIOErrorHandler(byval as XIOErrorHandler) as XIOErrorHandler
declare function XListPixmapFormats(byval as Display ptr, byval as long ptr) as XPixmapFormatValues ptr
declare function XListDepths(byval as Display ptr, byval as long, byval as long ptr) as long ptr
declare function XReconfigureWMWindow(byval as Display ptr, byval as Window, byval as long, byval as ulong, byval as XWindowChanges ptr) as long
declare function XGetWMProtocols(byval as Display ptr, byval as Window, byval as XAtom ptr ptr, byval as long ptr) as long
declare function XSetWMProtocols(byval as Display ptr, byval as Window, byval as XAtom ptr, byval as long) as long
declare function XIconifyWindow(byval as Display ptr, byval as Window, byval as long) as long
declare function XWithdrawWindow(byval as Display ptr, byval as Window, byval as long) as long
declare function XGetCommand(byval as Display ptr, byval as Window, byval as zstring ptr ptr ptr, byval as long ptr) as long
declare function XGetWMColormapWindows(byval as Display ptr, byval as Window, byval as Window ptr ptr, byval as long ptr) as long
declare function XSetWMColormapWindows(byval as Display ptr, byval as Window, byval as Window ptr, byval as long) as long
declare sub XFreeStringList(byval as zstring ptr ptr)
declare function XSetTransientForHint(byval as Display ptr, byval as Window, byval as Window) as long
declare function XActivateScreenSaver(byval as Display ptr) as long
declare function XAddHost(byval as Display ptr, byval as XHostAddress ptr) as long
declare function XAddHosts(byval as Display ptr, byval as XHostAddress ptr, byval as long) as long
declare function XAddToExtensionList(byval as _XExtData ptr ptr, byval as XExtData ptr) as long
declare function XAddToSaveSet(byval as Display ptr, byval as Window) as long
declare function XAllocColor(byval as Display ptr, byval as Colormap, byval as XColor ptr) as long
declare function XAllocColorCells(byval as Display ptr, byval as Colormap, byval as long, byval as culong ptr, byval as ulong, byval as culong ptr, byval as ulong) as long
declare function XAllocColorPlanes(byval as Display ptr, byval as Colormap, byval as long, byval as culong ptr, byval as long, byval as long, byval as long, byval as long, byval as culong ptr, byval as culong ptr, byval as culong ptr) as long
declare function XAllocNamedColor(byval as Display ptr, byval as Colormap, byval as const zstring ptr, byval as XColor ptr, byval as XColor ptr) as long
declare function XAllowEvents(byval as Display ptr, byval as long, byval as Time) as long
declare function XAutoRepeatOff(byval as Display ptr) as long
declare function XAutoRepeatOn(byval as Display ptr) as long
declare function XBell(byval as Display ptr, byval as long) as long
declare function XBitmapBitOrder(byval as Display ptr) as long
declare function XBitmapPad(byval as Display ptr) as long
declare function XBitmapUnit(byval as Display ptr) as long
declare function XCellsOfScreen(byval as Screen ptr) as long
declare function XChangeActivePointerGrab(byval as Display ptr, byval as ulong, byval as Cursor, byval as Time) as long
declare function XChangeGC(byval as Display ptr, byval as GC, byval as culong, byval as XGCValues ptr) as long
declare function XChangeKeyboardControl(byval as Display ptr, byval as culong, byval as XKeyboardControl ptr) as long
declare function XChangeKeyboardMapping(byval as Display ptr, byval as long, byval as long, byval as KeySym ptr, byval as long) as long
declare function XChangePointerControl(byval as Display ptr, byval as long, byval as long, byval as long, byval as long, byval as long) as long
declare function XChangeProperty(byval as Display ptr, byval as Window, byval as XAtom, byval as XAtom, byval as long, byval as long, byval as const ubyte ptr, byval as long) as long
declare function XChangeSaveSet(byval as Display ptr, byval as Window, byval as long) as long
declare function XChangeWindowAttributes(byval as Display ptr, byval as Window, byval as culong, byval as XSetWindowAttributes ptr) as long
declare function XCheckIfEvent(byval as Display ptr, byval as XEvent ptr, byval as function(byval as Display ptr, byval as XEvent ptr, byval as XPointer) as long, byval as XPointer) as long
declare function XCheckMaskEvent(byval as Display ptr, byval as clong, byval as XEvent ptr) as long
declare function XCheckTypedEvent(byval as Display ptr, byval as long, byval as XEvent ptr) as long
declare function XCheckTypedWindowEvent(byval as Display ptr, byval as Window, byval as long, byval as XEvent ptr) as long
declare function XCheckWindowEvent(byval as Display ptr, byval as Window, byval as clong, byval as XEvent ptr) as long
declare function XCirculateSubwindows(byval as Display ptr, byval as Window, byval as long) as long
declare function XCirculateSubwindowsDown(byval as Display ptr, byval as Window) as long
declare function XCirculateSubwindowsUp(byval as Display ptr, byval as Window) as long
declare function XClearArea(byval as Display ptr, byval as Window, byval as long, byval as long, byval as ulong, byval as ulong, byval as long) as long
declare function XClearWindow(byval as Display ptr, byval as Window) as long
declare function XCloseDisplay(byval as Display ptr) as long
declare function XConfigureWindow(byval as Display ptr, byval as Window, byval as ulong, byval as XWindowChanges ptr) as long
declare function XConnectionNumber(byval as Display ptr) as long
declare function XConvertSelection(byval as Display ptr, byval as XAtom, byval as XAtom, byval as XAtom, byval as Window, byval as Time) as long
declare function XCopyArea(byval as Display ptr, byval as Drawable, byval as Drawable, byval as GC, byval as long, byval as long, byval as ulong, byval as ulong, byval as long, byval as long) as long
declare function XCopyGC(byval as Display ptr, byval as GC, byval as culong, byval as GC) as long
declare function XCopyPlane(byval as Display ptr, byval as Drawable, byval as Drawable, byval as GC, byval as long, byval as long, byval as ulong, byval as ulong, byval as long, byval as long, byval as culong) as long
declare function XDefaultDepth(byval as Display ptr, byval as long) as long
declare function XDefaultDepthOfScreen(byval as Screen ptr) as long
declare function XDefaultScreen(byval as Display ptr) as long
declare function XDefineCursor(byval as Display ptr, byval as Window, byval as Cursor) as long
declare function XDeleteProperty(byval as Display ptr, byval as Window, byval as XAtom) as long
declare function XDestroyWindow(byval as Display ptr, byval as Window) as long
declare function XDestroySubwindows(byval as Display ptr, byval as Window) as long
declare function XDoesBackingStore(byval as Screen ptr) as long
declare function XDoesSaveUnders(byval as Screen ptr) as long
declare function XDisableAccessControl(byval as Display ptr) as long
declare function XDisplayCells(byval as Display ptr, byval as long) as long
declare function XDisplayHeight(byval as Display ptr, byval as long) as long
declare function XDisplayHeightMM(byval as Display ptr, byval as long) as long
declare function XDisplayKeycodes(byval as Display ptr, byval as long ptr, byval as long ptr) as long
declare function XDisplayPlanes(byval as Display ptr, byval as long) as long
declare function XDisplayWidth(byval as Display ptr, byval as long) as long
declare function XDisplayWidthMM(byval as Display ptr, byval as long) as long
declare function XDrawArc(byval as Display ptr, byval as Drawable, byval as GC, byval as long, byval as long, byval as ulong, byval as ulong, byval as long, byval as long) as long
declare function XDrawArcs(byval as Display ptr, byval as Drawable, byval as GC, byval as XArc ptr, byval as long) as long
declare function XDrawImageString(byval as Display ptr, byval as Drawable, byval as GC, byval as long, byval as long, byval as const zstring ptr, byval as long) as long
declare function XDrawImageString16(byval as Display ptr, byval as Drawable, byval as GC, byval as long, byval as long, byval as const XChar2b ptr, byval as long) as long
declare function XDrawLine(byval as Display ptr, byval as Drawable, byval as GC, byval as long, byval as long, byval as long, byval as long) as long
declare function XDrawLines(byval as Display ptr, byval as Drawable, byval as GC, byval as XPoint ptr, byval as long, byval as long) as long
declare function XDrawPoint(byval as Display ptr, byval as Drawable, byval as GC, byval as long, byval as long) as long
declare function XDrawPoints(byval as Display ptr, byval as Drawable, byval as GC, byval as XPoint ptr, byval as long, byval as long) as long
declare function XDrawRectangle(byval as Display ptr, byval as Drawable, byval as GC, byval as long, byval as long, byval as ulong, byval as ulong) as long
declare function XDrawRectangles(byval as Display ptr, byval as Drawable, byval as GC, byval as XRectangle ptr, byval as long) as long
declare function XDrawSegments(byval as Display ptr, byval as Drawable, byval as GC, byval as XSegment ptr, byval as long) as long
declare function XDrawString(byval as Display ptr, byval as Drawable, byval as GC, byval as long, byval as long, byval as const zstring ptr, byval as long) as long
declare function XDrawString16(byval as Display ptr, byval as Drawable, byval as GC, byval as long, byval as long, byval as const XChar2b ptr, byval as long) as long
declare function XDrawText(byval as Display ptr, byval as Drawable, byval as GC, byval as long, byval as long, byval as XTextItem ptr, byval as long) as long
declare function XDrawText16(byval as Display ptr, byval as Drawable, byval as GC, byval as long, byval as long, byval as XTextItem16 ptr, byval as long) as long
declare function XEnableAccessControl(byval as Display ptr) as long
declare function XEventsQueued(byval as Display ptr, byval as long) as long
declare function XFetchName(byval as Display ptr, byval as Window, byval as zstring ptr ptr) as long
declare function XFillArc(byval as Display ptr, byval as Drawable, byval as GC, byval as long, byval as long, byval as ulong, byval as ulong, byval as long, byval as long) as long
declare function XFillArcs(byval as Display ptr, byval as Drawable, byval as GC, byval as XArc ptr, byval as long) as long
declare function XFillPolygon(byval as Display ptr, byval as Drawable, byval as GC, byval as XPoint ptr, byval as long, byval as long, byval as long) as long
declare function XFillRectangle(byval as Display ptr, byval as Drawable, byval as GC, byval as long, byval as long, byval as ulong, byval as ulong) as long
declare function XFillRectangles(byval as Display ptr, byval as Drawable, byval as GC, byval as XRectangle ptr, byval as long) as long
declare function XFlush(byval as Display ptr) as long
declare function XForceScreenSaver(byval as Display ptr, byval as long) as long
declare function XFree(byval as any ptr) as long
declare function XFreeColormap(byval as Display ptr, byval as Colormap) as long
declare function XFreeColors(byval as Display ptr, byval as Colormap, byval as culong ptr, byval as long, byval as culong) as long
declare function XFreeCursor(byval as Display ptr, byval as Cursor) as long
declare function XFreeExtensionList(byval as zstring ptr ptr) as long
declare function XFreeFont(byval as Display ptr, byval as XFontStruct ptr) as long
declare function XFreeFontInfo(byval as zstring ptr ptr, byval as XFontStruct ptr, byval as long) as long
declare function XFreeFontNames(byval as zstring ptr ptr) as long
declare function XFreeFontPath(byval as zstring ptr ptr) as long
declare function XFreeGC(byval as Display ptr, byval as GC) as long
declare function XFreeModifiermap(byval as XModifierKeymap ptr) as long
declare function XFreePixmap(byval as Display ptr, byval as Pixmap) as long
declare function XGeometry(byval as Display ptr, byval as long, byval as const zstring ptr, byval as const zstring ptr, byval as ulong, byval as ulong, byval as ulong, byval as long, byval as long, byval as long ptr, byval as long ptr, byval as long ptr, byval as long ptr) as long
declare function XGetErrorDatabaseText(byval as Display ptr, byval as const zstring ptr, byval as const zstring ptr, byval as const zstring ptr, byval as zstring ptr, byval as long) as long
declare function XGetErrorText(byval as Display ptr, byval as long, byval as zstring ptr, byval as long) as long
declare function XGetFontProperty(byval as XFontStruct ptr, byval as XAtom, byval as culong ptr) as long
declare function XGetGCValues(byval as Display ptr, byval as GC, byval as culong, byval as XGCValues ptr) as long
declare function XGetGeometry(byval as Display ptr, byval as Drawable, byval as Window ptr, byval as long ptr, byval as long ptr, byval as ulong ptr, byval as ulong ptr, byval as ulong ptr, byval as ulong ptr) as long
declare function XGetIconName(byval as Display ptr, byval as Window, byval as zstring ptr ptr) as long
declare function XGetInputFocus(byval as Display ptr, byval as Window ptr, byval as long ptr) as long
declare function XGetKeyboardControl(byval as Display ptr, byval as XKeyboardState ptr) as long
declare function XGetPointerControl(byval as Display ptr, byval as long ptr, byval as long ptr, byval as long ptr) as long
declare function XGetPointerMapping(byval as Display ptr, byval as ubyte ptr, byval as long) as long
declare function XGetScreenSaver(byval as Display ptr, byval as long ptr, byval as long ptr, byval as long ptr, byval as long ptr) as long
declare function XGetTransientForHint(byval as Display ptr, byval as Window, byval as Window ptr) as long
declare function XGetWindowProperty(byval as Display ptr, byval as Window, byval as XAtom, byval as clong, byval as clong, byval as long, byval as XAtom, byval as XAtom ptr, byval as long ptr, byval as culong ptr, byval as culong ptr, byval as ubyte ptr ptr) as long
declare function XGetWindowAttributes(byval as Display ptr, byval as Window, byval as XWindowAttributes ptr) as long
declare function XGrabButton(byval as Display ptr, byval as ulong, byval as ulong, byval as Window, byval as long, byval as ulong, byval as long, byval as long, byval as Window, byval as Cursor) as long
declare function XGrabKey(byval as Display ptr, byval as long, byval as ulong, byval as Window, byval as long, byval as long, byval as long) as long
declare function XGrabKeyboard(byval as Display ptr, byval as Window, byval as long, byval as long, byval as long, byval as Time) as long
declare function XGrabPointer(byval as Display ptr, byval as Window, byval as long, byval as ulong, byval as long, byval as long, byval as Window, byval as Cursor, byval as Time) as long
declare function XGrabServer(byval as Display ptr) as long
declare function XHeightMMOfScreen(byval as Screen ptr) as long
declare function XHeightOfScreen(byval as Screen ptr) as long
declare function XIfEvent(byval as Display ptr, byval as XEvent ptr, byval as function(byval as Display ptr, byval as XEvent ptr, byval as XPointer) as long, byval as XPointer) as long
declare function XImageByteOrder(byval as Display ptr) as long
declare function XInstallColormap(byval as Display ptr, byval as Colormap) as long
declare function XKeysymToKeycode(byval as Display ptr, byval as KeySym) as KeyCode
declare function XKillClient(byval as Display ptr, byval as XID) as long
declare function XLookupColor(byval as Display ptr, byval as Colormap, byval as const zstring ptr, byval as XColor ptr, byval as XColor ptr) as long
declare function XLowerWindow(byval as Display ptr, byval as Window) as long
declare function XMapRaised(byval as Display ptr, byval as Window) as long
declare function XMapSubwindows(byval as Display ptr, byval as Window) as long
declare function XMapWindow(byval as Display ptr, byval as Window) as long
declare function XMaskEvent(byval as Display ptr, byval as clong, byval as XEvent ptr) as long
declare function XMaxCmapsOfScreen(byval as Screen ptr) as long
declare function XMinCmapsOfScreen(byval as Screen ptr) as long
declare function XMoveResizeWindow(byval as Display ptr, byval as Window, byval as long, byval as long, byval as ulong, byval as ulong) as long
declare function XMoveWindow(byval as Display ptr, byval as Window, byval as long, byval as long) as long
declare function XNextEvent(byval as Display ptr, byval as XEvent ptr) as long
declare function XNoOp(byval as Display ptr) as long
declare function XParseColor(byval as Display ptr, byval as Colormap, byval as const zstring ptr, byval as XColor ptr) as long
declare function XParseGeometry(byval as const zstring ptr, byval as long ptr, byval as long ptr, byval as ulong ptr, byval as ulong ptr) as long
declare function XPeekEvent(byval as Display ptr, byval as XEvent ptr) as long
declare function XPeekIfEvent(byval as Display ptr, byval as XEvent ptr, byval as function(byval as Display ptr, byval as XEvent ptr, byval as XPointer) as long, byval as XPointer) as long
declare function XPending(byval as Display ptr) as long
declare function XPlanesOfScreen(byval as Screen ptr) as long
declare function XProtocolRevision(byval as Display ptr) as long
declare function XProtocolVersion(byval as Display ptr) as long
declare function XPutBackEvent(byval as Display ptr, byval as XEvent ptr) as long
declare function XPutImage(byval as Display ptr, byval as Drawable, byval as GC, byval as XImage ptr, byval as long, byval as long, byval as long, byval as long, byval as ulong, byval as ulong) as long
declare function XQLength(byval as Display ptr) as long
declare function XQueryBestCursor(byval as Display ptr, byval as Drawable, byval as ulong, byval as ulong, byval as ulong ptr, byval as ulong ptr) as long
declare function XQueryBestSize(byval as Display ptr, byval as long, byval as Drawable, byval as ulong, byval as ulong, byval as ulong ptr, byval as ulong ptr) as long
declare function XQueryBestStipple(byval as Display ptr, byval as Drawable, byval as ulong, byval as ulong, byval as ulong ptr, byval as ulong ptr) as long
declare function XQueryBestTile(byval as Display ptr, byval as Drawable, byval as ulong, byval as ulong, byval as ulong ptr, byval as ulong ptr) as long
declare function XQueryColor(byval as Display ptr, byval as Colormap, byval as XColor ptr) as long
declare function XQueryColors(byval as Display ptr, byval as Colormap, byval as XColor ptr, byval as long) as long
declare function XQueryExtension(byval as Display ptr, byval as const zstring ptr, byval as long ptr, byval as long ptr, byval as long ptr) as long
declare function XQueryKeymap(byval as Display ptr, byval as zstring ptr) as long
declare function XQueryPointer(byval as Display ptr, byval as Window, byval as Window ptr, byval as Window ptr, byval as long ptr, byval as long ptr, byval as long ptr, byval as long ptr, byval as ulong ptr) as long
declare function XQueryTextExtents(byval as Display ptr, byval as XID, byval as const zstring ptr, byval as long, byval as long ptr, byval as long ptr, byval as long ptr, byval as XCharStruct ptr) as long
declare function XQueryTextExtents16(byval as Display ptr, byval as XID, byval as const XChar2b ptr, byval as long, byval as long ptr, byval as long ptr, byval as long ptr, byval as XCharStruct ptr) as long
declare function XQueryTree(byval as Display ptr, byval as Window, byval as Window ptr, byval as Window ptr, byval as Window ptr ptr, byval as ulong ptr) as long
declare function XRaiseWindow(byval as Display ptr, byval as Window) as long
declare function XReadBitmapFile(byval as Display ptr, byval as Drawable, byval as const zstring ptr, byval as ulong ptr, byval as ulong ptr, byval as Pixmap ptr, byval as long ptr, byval as long ptr) as long
declare function XReadBitmapFileData(byval as const zstring ptr, byval as ulong ptr, byval as ulong ptr, byval as ubyte ptr ptr, byval as long ptr, byval as long ptr) as long
declare function XRebindKeysym(byval as Display ptr, byval as KeySym, byval as KeySym ptr, byval as long, byval as const ubyte ptr, byval as long) as long
declare function XRecolorCursor(byval as Display ptr, byval as Cursor, byval as XColor ptr, byval as XColor ptr) as long
declare function XRefreshKeyboardMapping(byval as XMappingEvent ptr) as long
declare function XRemoveFromSaveSet(byval as Display ptr, byval as Window) as long
declare function XRemoveHost(byval as Display ptr, byval as XHostAddress ptr) as long
declare function XRemoveHosts(byval as Display ptr, byval as XHostAddress ptr, byval as long) as long
declare function XReparentWindow(byval as Display ptr, byval as Window, byval as Window, byval as long, byval as long) as long
declare function XResetScreenSaver(byval as Display ptr) as long
declare function XResizeWindow(byval as Display ptr, byval as Window, byval as ulong, byval as ulong) as long
declare function XRestackWindows(byval as Display ptr, byval as Window ptr, byval as long) as long
declare function XRotateBuffers(byval as Display ptr, byval as long) as long
declare function XRotateWindowProperties(byval as Display ptr, byval as Window, byval as XAtom ptr, byval as long, byval as long) as long
declare function XScreenCount(byval as Display ptr) as long
declare function XSelectInput(byval as Display ptr, byval as Window, byval as clong) as long
declare function XSendEvent(byval as Display ptr, byval as Window, byval as long, byval as clong, byval as XEvent ptr) as long
declare function XSetAccessControl(byval as Display ptr, byval as long) as long
declare function XSetArcMode(byval as Display ptr, byval as GC, byval as long) as long
declare function XSetBackground(byval as Display ptr, byval as GC, byval as culong) as long
declare function XSetClipMask(byval as Display ptr, byval as GC, byval as Pixmap) as long
declare function XSetClipOrigin(byval as Display ptr, byval as GC, byval as long, byval as long) as long
declare function XSetClipRectangles(byval as Display ptr, byval as GC, byval as long, byval as long, byval as XRectangle ptr, byval as long, byval as long) as long
declare function XSetCloseDownMode(byval as Display ptr, byval as long) as long
declare function XSetCommand(byval as Display ptr, byval as Window, byval as zstring ptr ptr, byval as long) as long
declare function XSetDashes(byval as Display ptr, byval as GC, byval as long, byval as const zstring ptr, byval as long) as long
declare function XSetFillRule(byval as Display ptr, byval as GC, byval as long) as long
declare function XSetFillStyle(byval as Display ptr, byval as GC, byval as long) as long
declare function XSetFont(byval as Display ptr, byval as GC, byval as Font) as long
declare function XSetFontPath(byval as Display ptr, byval as zstring ptr ptr, byval as long) as long
declare function XSetForeground(byval as Display ptr, byval as GC, byval as culong) as long
declare function XSetFunction(byval as Display ptr, byval as GC, byval as long) as long
declare function XSetGraphicsExposures(byval as Display ptr, byval as GC, byval as long) as long
declare function XSetIconName(byval as Display ptr, byval as Window, byval as const zstring ptr) as long
declare function XSetInputFocus(byval as Display ptr, byval as Window, byval as long, byval as Time) as long
declare function XSetLineAttributes(byval as Display ptr, byval as GC, byval as ulong, byval as long, byval as long, byval as long) as long
declare function XSetModifierMapping(byval as Display ptr, byval as XModifierKeymap ptr) as long
declare function XSetPlaneMask(byval as Display ptr, byval as GC, byval as culong) as long
declare function XSetPointerMapping(byval as Display ptr, byval as const ubyte ptr, byval as long) as long
declare function XSetScreenSaver(byval as Display ptr, byval as long, byval as long, byval as long, byval as long) as long
declare function XSetSelectionOwner(byval as Display ptr, byval as XAtom, byval as Window, byval as Time) as long
declare function XSetState(byval as Display ptr, byval as GC, byval as culong, byval as culong, byval as long, byval as culong) as long
declare function XSetStipple(byval as Display ptr, byval as GC, byval as Pixmap) as long
declare function XSetSubwindowMode(byval as Display ptr, byval as GC, byval as long) as long
declare function XSetTSOrigin(byval as Display ptr, byval as GC, byval as long, byval as long) as long
declare function XSetTile(byval as Display ptr, byval as GC, byval as Pixmap) as long
declare function XSetWindowBackground(byval as Display ptr, byval as Window, byval as culong) as long
declare function XSetWindowBackgroundPixmap(byval as Display ptr, byval as Window, byval as Pixmap) as long
declare function XSetWindowBorder(byval as Display ptr, byval as Window, byval as culong) as long
declare function XSetWindowBorderPixmap(byval as Display ptr, byval as Window, byval as Pixmap) as long
declare function XSetWindowBorderWidth(byval as Display ptr, byval as Window, byval as ulong) as long
declare function XSetWindowColormap(byval as Display ptr, byval as Window, byval as Colormap) as long
declare function XStoreBuffer(byval as Display ptr, byval as const zstring ptr, byval as long, byval as long) as long
declare function XStoreBytes(byval as Display ptr, byval as const zstring ptr, byval as long) as long
declare function XStoreColor(byval as Display ptr, byval as Colormap, byval as XColor ptr) as long
declare function XStoreColors(byval as Display ptr, byval as Colormap, byval as XColor ptr, byval as long) as long
declare function XStoreName(byval as Display ptr, byval as Window, byval as const zstring ptr) as long
declare function XStoreNamedColor(byval as Display ptr, byval as Colormap, byval as const zstring ptr, byval as culong, byval as long) as long
declare function XSync(byval as Display ptr, byval as long) as long
declare function XTextExtents(byval as XFontStruct ptr, byval as const zstring ptr, byval as long, byval as long ptr, byval as long ptr, byval as long ptr, byval as XCharStruct ptr) as long
declare function XTextExtents16(byval as XFontStruct ptr, byval as const XChar2b ptr, byval as long, byval as long ptr, byval as long ptr, byval as long ptr, byval as XCharStruct ptr) as long
declare function XTextWidth(byval as XFontStruct ptr, byval as const zstring ptr, byval as long) as long
declare function XTextWidth16(byval as XFontStruct ptr, byval as const XChar2b ptr, byval as long) as long
declare function XTranslateCoordinates(byval as Display ptr, byval as Window, byval as Window, byval as long, byval as long, byval as long ptr, byval as long ptr, byval as Window ptr) as long
declare function XUndefineCursor(byval as Display ptr, byval as Window) as long
declare function XUngrabButton(byval as Display ptr, byval as ulong, byval as ulong, byval as Window) as long
declare function XUngrabKey(byval as Display ptr, byval as long, byval as ulong, byval as Window) as long
declare function XUngrabKeyboard(byval as Display ptr, byval as Time) as long
declare function XUngrabPointer(byval as Display ptr, byval as Time) as long
declare function XUngrabServer(byval as Display ptr) as long
declare function XUninstallColormap(byval as Display ptr, byval as Colormap) as long
declare function XUnloadFont(byval as Display ptr, byval as Font) as long
declare function XUnmapSubwindows(byval as Display ptr, byval as Window) as long
declare function XUnmapWindow(byval as Display ptr, byval as Window) as long
declare function XVendorRelease(byval as Display ptr) as long
declare function XWarpPointer(byval as Display ptr, byval as Window, byval as Window, byval as long, byval as long, byval as ulong, byval as ulong, byval as long, byval as long) as long
declare function XWidthMMOfScreen(byval as Screen ptr) as long
declare function XWidthOfScreen(byval as Screen ptr) as long
declare function XWindowEvent(byval as Display ptr, byval as Window, byval as clong, byval as XEvent ptr) as long
declare function XWriteBitmapFile(byval as Display ptr, byval as const zstring ptr, byval as Pixmap, byval as ulong, byval as ulong, byval as long, byval as long) as long
declare function XSupportsLocale() as long
declare function XSetLocaleModifiers(byval as const zstring ptr) as zstring ptr
declare function XOpenOM(byval as Display ptr, byval as _XrmHashBucketRec ptr, byval as const zstring ptr, byval as const zstring ptr) as XOM
declare function XCloseOM(byval as XOM) as long
declare function XSetOMValues(byval as XOM, ...) as zstring ptr
declare function XGetOMValues(byval as XOM, ...) as zstring ptr
declare function XDisplayOfOM(byval as XOM) as Display ptr
declare function XLocaleOfOM(byval as XOM) as zstring ptr
declare function XCreateOC(byval as XOM, ...) as XOC
declare sub XDestroyOC(byval as XOC)
declare function XOMOfOC(byval as XOC) as XOM
declare function XSetOCValues(byval as XOC, ...) as zstring ptr
declare function XGetOCValues(byval as XOC, ...) as zstring ptr
declare function XCreateFontSet(byval as Display ptr, byval as const zstring ptr, byval as zstring ptr ptr ptr, byval as long ptr, byval as zstring ptr ptr) as XFontSet
declare sub XFreeFontSet(byval as Display ptr, byval as XFontSet)
declare function XFontsOfFontSet(byval as XFontSet, byval as XFontStruct ptr ptr ptr, byval as zstring ptr ptr ptr) as long
declare function XBaseFontNameListOfFontSet(byval as XFontSet) as zstring ptr
declare function XLocaleOfFontSet(byval as XFontSet) as zstring ptr
declare function XContextDependentDrawing(byval as XFontSet) as long
declare function XDirectionalDependentDrawing(byval as XFontSet) as long
declare function XContextualDrawing(byval as XFontSet) as long
declare function XExtentsOfFontSet(byval as XFontSet) as XFontSetExtents ptr
declare function XmbTextEscapement(byval as XFontSet, byval as const zstring ptr, byval as long) as long
declare function XwcTextEscapement(byval as XFontSet, byval as const wstring ptr, byval as long) as long
declare function Xutf8TextEscapement(byval as XFontSet, byval as const zstring ptr, byval as long) as long
declare function XmbTextExtents(byval as XFontSet, byval as const zstring ptr, byval as long, byval as XRectangle ptr, byval as XRectangle ptr) as long
declare function XwcTextExtents(byval as XFontSet, byval as const wstring ptr, byval as long, byval as XRectangle ptr, byval as XRectangle ptr) as long
declare function Xutf8TextExtents(byval as XFontSet, byval as const zstring ptr, byval as long, byval as XRectangle ptr, byval as XRectangle ptr) as long
declare function XmbTextPerCharExtents(byval as XFontSet, byval as const zstring ptr, byval as long, byval as XRectangle ptr, byval as XRectangle ptr, byval as long, byval as long ptr, byval as XRectangle ptr, byval as XRectangle ptr) as long
declare function XwcTextPerCharExtents(byval as XFontSet, byval as const wstring ptr, byval as long, byval as XRectangle ptr, byval as XRectangle ptr, byval as long, byval as long ptr, byval as XRectangle ptr, byval as XRectangle ptr) as long
declare function Xutf8TextPerCharExtents(byval as XFontSet, byval as const zstring ptr, byval as long, byval as XRectangle ptr, byval as XRectangle ptr, byval as long, byval as long ptr, byval as XRectangle ptr, byval as XRectangle ptr) as long
declare sub XmbDrawText(byval as Display ptr, byval as Drawable, byval as GC, byval as long, byval as long, byval as XmbTextItem ptr, byval as long)
declare sub XwcDrawText(byval as Display ptr, byval as Drawable, byval as GC, byval as long, byval as long, byval as XwcTextItem ptr, byval as long)
declare sub Xutf8DrawText(byval as Display ptr, byval as Drawable, byval as GC, byval as long, byval as long, byval as XmbTextItem ptr, byval as long)
declare sub XmbDrawString(byval as Display ptr, byval as Drawable, byval as XFontSet, byval as GC, byval as long, byval as long, byval as const zstring ptr, byval as long)
declare sub XwcDrawString(byval as Display ptr, byval as Drawable, byval as XFontSet, byval as GC, byval as long, byval as long, byval as const wstring ptr, byval as long)
declare sub Xutf8DrawString(byval as Display ptr, byval as Drawable, byval as XFontSet, byval as GC, byval as long, byval as long, byval as const zstring ptr, byval as long)
declare sub XmbDrawImageString(byval as Display ptr, byval as Drawable, byval as XFontSet, byval as GC, byval as long, byval as long, byval as const zstring ptr, byval as long)
declare sub XwcDrawImageString(byval as Display ptr, byval as Drawable, byval as XFontSet, byval as GC, byval as long, byval as long, byval as const wstring ptr, byval as long)
declare sub Xutf8DrawImageString(byval as Display ptr, byval as Drawable, byval as XFontSet, byval as GC, byval as long, byval as long, byval as const zstring ptr, byval as long)
declare function XOpenIM(byval as Display ptr, byval as _XrmHashBucketRec ptr, byval as zstring ptr, byval as zstring ptr) as XIM
declare function XCloseIM(byval as XIM) as long
declare function XGetIMValues(byval as XIM, ...) as zstring ptr
declare function XSetIMValues(byval as XIM, ...) as zstring ptr
declare function XDisplayOfIM(byval as XIM) as Display ptr
declare function XLocaleOfIM(byval as XIM) as zstring ptr
declare function XCreateIC(byval as XIM, ...) as XIC
declare sub XDestroyIC(byval as XIC)
declare sub XSetICFocus(byval as XIC)
declare sub XUnsetICFocus(byval as XIC)
declare function XwcResetIC(byval as XIC) as wstring ptr
declare function XmbResetIC(byval as XIC) as zstring ptr
declare function Xutf8ResetIC(byval as XIC) as zstring ptr
declare function XSetICValues(byval as XIC, ...) as zstring ptr
declare function XGetICValues(byval as XIC, ...) as zstring ptr
declare function XIMOfIC(byval as XIC) as XIM
declare function XFilterEvent(byval as XEvent ptr, byval as Window) as long
declare function XmbLookupString(byval as XIC, byval as XKeyPressedEvent ptr, byval as zstring ptr, byval as long, byval as KeySym ptr, byval as long ptr) as long
declare function XwcLookupString(byval as XIC, byval as XKeyPressedEvent ptr, byval as wstring ptr, byval as long, byval as KeySym ptr, byval as long ptr) as long
declare function Xutf8LookupString(byval as XIC, byval as XKeyPressedEvent ptr, byval as zstring ptr, byval as long, byval as KeySym ptr, byval as long ptr) as long
declare function XVaCreateNestedList(byval as long, ...) as XVaNestedList
declare function XRegisterIMInstantiateCallback(byval as Display ptr, byval as _XrmHashBucketRec ptr, byval as zstring ptr, byval as zstring ptr, byval as XIDProc, byval as XPointer) as long
declare function XUnregisterIMInstantiateCallback(byval as Display ptr, byval as _XrmHashBucketRec ptr, byval as zstring ptr, byval as zstring ptr, byval as XIDProc, byval as XPointer) as long
type XConnectionWatchProc as sub(byval as Display ptr, byval as XPointer, byval as long, byval as long, byval as XPointer ptr)
declare function XInternalConnectionNumbers(byval as Display ptr, byval as long ptr ptr, byval as long ptr) as long
declare sub XProcessInternalConnection(byval as Display ptr, byval as long)
declare function XAddConnectionWatch(byval as Display ptr, byval as XConnectionWatchProc, byval as XPointer) as long
declare sub XRemoveConnectionWatch(byval as Display ptr, byval as XConnectionWatchProc, byval as XPointer)
declare sub XSetAuthorization(byval as zstring ptr, byval as long, byval as zstring ptr, byval as long)
declare function _Xmbtowc(byval as wstring ptr, byval as zstring ptr, byval as long) as long
declare function _Xwctomb(byval as zstring ptr, byval as wchar_t) as long
declare function XGetEventData(byval as Display ptr, byval as XGenericEventCookie ptr) as long
declare sub XFreeEventData(byval as Display ptr, byval as XGenericEventCookie ptr)

end extern
