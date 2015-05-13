''
''
'' Xlib -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __Xlib_bi__
#define __Xlib_bi__

#define XlibSpecificationRelease 6

declare function _Xmblen cdecl alias "_Xmblen" (byval str as zstring ptr, byval len as integer) as integer

#define X_HAVE_UTF8_STRING 1

type XPointer as byte ptr

#define True 1
#define False 0
#define QueuedAlready 0
#define QueuedAfterReading 1
#define QueuedAfterFlush 2

type _XExtData
	number as integer
	next as _XExtData ptr
	free_private as function cdecl(byval as _XExtData ptr) as integer
	private_data as XPointer
end type

type XExtData as _XExtData

type XExtCodes
	extension as integer
	major_opcode as integer
	first_event as integer
	first_error as integer
end type

type XPixmapFormatValues
	depth as integer
	bits_per_pixel as integer
	scanline_pad as integer
end type

type XGCValues
	function as integer
	plane_mask as uinteger
	foreground as uinteger
	background as uinteger
	line_width as integer
	line_style as integer
	cap_style as integer
	join_style as integer
	fill_style as integer
	fill_rule as integer
	arc_mode as integer
	tile as Pixmap
	stipple as Pixmap
	ts_x_origin as integer
	ts_y_origin as integer
	font as Font
	subwindow_mode as integer
	graphics_exposures as integer
	clip_x_origin as integer
	clip_y_origin as integer
	clip_mask as Pixmap
	dash_offset as integer
	dashes as byte
end type

type GC as _XGC ptr

type Visual
	ext_data as XExtData ptr
	visualid as VisualID
	class as integer
	red_mask as uinteger
	green_mask as uinteger
	blue_mask as uinteger
	bits_per_rgb as integer
	map_entries as integer
end type

type Depth
	depth as integer
	nvisuals as integer
	visuals as Visual ptr
end type

type Screen
	ext_data as XExtData ptr
	display as _XDisplay ptr
	root as Window
	width as integer
	height as integer
	mwidth as integer
	mheight as integer
	ndepths as integer
	depths as Depth ptr
	root_depth as integer
	root_visual as Visual ptr
	default_gc as GC
	cmap as Colormap
	white_pixel as uinteger
	black_pixel as uinteger
	max_maps as integer
	min_maps as integer
	backing_store as integer
	save_unders as integer
	root_input_mask as integer
end type

type ScreenFormat
	ext_data as XExtData ptr
	depth as integer
	bits_per_pixel as integer
	scanline_pad as integer
end type

type XSetWindowAttributes
	background_pixmap as Pixmap
	background_pixel as uinteger
	border_pixmap as Pixmap
	border_pixel as uinteger
	bit_gravity as integer
	win_gravity as integer
	backing_store as integer
	backing_planes as uinteger
	backing_pixel as uinteger
	save_under as integer
	event_mask as integer
	do_not_propagate_mask as integer
	override_redirect as integer
	colormap as Colormap
	cursor as Cursor
end type

type XWindowAttributes
	x as integer
	y as integer
	width as integer
	height as integer
	border_width as integer
	depth as integer
	visual as Visual ptr
	root as Window
	class as integer
	bit_gravity as integer
	win_gravity as integer
	backing_store as integer
	backing_planes as uinteger
	backing_pixel as uinteger
	save_under as integer
	colormap as Colormap
	map_installed as integer
	map_state as integer
	all_event_masks as integer
	your_event_mask as integer
	do_not_propagate_mask as integer
	override_redirect as integer
	screen as Screen ptr
end type

type XHostAddress
	family as integer
	length as integer
	address as zstring ptr
end type

type XServerInterpretedAddress
	typelength as integer
	valuelength as integer
	type as zstring ptr
	value as zstring ptr
end type

type _XImage
	width as integer
	height as integer
	xoffset as integer
	format as integer
	data as zstring ptr
	byte_order as integer
	bitmap_unit as integer
	bitmap_bit_order as integer
	bitmap_pad as integer
	depth as integer
	bytes_per_line as integer
	bits_per_pixel as integer
	red_mask as uinteger
	green_mask as uinteger
	blue_mask as uinteger
	obdata as XPointer
	f as XImage__NESTED__f
end type

type XImage as _XImage

type XImage__NESTED__f
	create_image as function cdecl(byval as _XDisplay ptr, byval as Visual ptr, byval as uinteger, byval as integer, byval as integer, byval as zstring ptr, byval as uinteger, byval as uinteger, byval as integer, byval as integer) as _XImage ptr
	destroy_image as function cdecl(byval as _XImage ptr) as integer
	get_pixel as function cdecl(byval as _XImage ptr, byval as integer, byval as integer) as uinteger
	put_pixel as function cdecl(byval as _XImage ptr, byval as integer, byval as integer, byval as uinteger) as integer
	sub_image as function cdecl(byval as _XImage ptr, byval as integer, byval as integer, byval as uinteger, byval as uinteger) as _XImage ptr
	add_pixel as function cdecl(byval as _XImage ptr, byval as integer) as integer
end type

type XWindowChanges
	x as integer
	y as integer
	width as integer
	height as integer
	border_width as integer
	sibling as Window
	stack_mode as integer
end type

type XColor
	pixel as uinteger
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
	key_click_percent as integer
	bell_percent as integer
	bell_pitch as integer
	bell_duration as integer
	led as integer
	led_mode as integer
	key as integer
	auto_repeat_mode as integer
end type

type XKeyboardState
	key_click_percent as integer
	bell_percent as integer
	bell_pitch as uinteger
	bell_duration as uinteger
	led_mask as uinteger
	global_auto_repeat as integer
	auto_repeats as zstring * 32
end type

type XTimeCoord
	time as Time
	x as short
	y as short
end type

type XModifierKeymap
	max_keypermod as integer
	modifiermap as KeyCode ptr
end type

type Display as _XDisplay

type 
	ext_data as XExtData ptr
	private1 as _XPrivate ptr
	fd as integer
	private2 as integer
	proto_major_version as integer
	proto_minor_version as integer
	vendor as zstring ptr
	private3 as XID
	private4 as XID
	private5 as XID
	private6 as integer
	resource_alloc as function cdecl(byval as _XDisplay ptr) as XID
	byte_order as integer
	bitmap_unit as integer
	bitmap_pad as integer
	bitmap_bit_order as integer
	nformats as integer
	pixmap_format as ScreenFormat ptr
	private8 as integer
	release as integer
	private9 as _XPrivate ptr
	private10 as _XPrivate ptr
	qlen as integer
	last_request_read as uinteger
	request as uinteger
	private11 as XPointer
	private12 as XPointer
	private13 as XPointer
	private14 as XPointer
	max_request_size as uinteger
	db as _XrmHashBucketRec ptr
	private15 as function cdecl(byval as _XDisplay ptr) as integer
	display_name as zstring ptr
	default_screen as integer
	nscreens as integer
	screens as Screen ptr
	motion_buffer as uinteger
	private16 as uinteger
	min_keycode as integer
	max_keycode as integer
	private17 as XPointer
	private18 as XPointer
	private19 as integer
	xdefaults as zstring ptr
end type

type _XPrivDisplay as XModifierKeymap ptr

type XKeyEvent
	type as integer
	serial as uinteger
	send_event as integer
	display as Display ptr
	window as Window
	root as Window
	subwindow as Window
	time as Time
	x as integer
	y as integer
	x_root as integer
	y_root as integer
	state as uinteger
	keycode as uinteger
	same_screen as integer
end type

type XKeyPressedEvent as XKeyEvent
type XKeyReleasedEvent as XKeyEvent

type XButtonEvent
	type as integer
	serial as uinteger
	send_event as integer
	display as Display ptr
	window as Window
	root as Window
	subwindow as Window
	time as Time
	x as integer
	y as integer
	x_root as integer
	y_root as integer
	state as uinteger
	button as uinteger
	same_screen as integer
end type

type XButtonPressedEvent as XButtonEvent
type XButtonReleasedEvent as XButtonEvent

type XMotionEvent
	type as integer
	serial as uinteger
	send_event as integer
	display as Display ptr
	window as Window
	root as Window
	subwindow as Window
	time as Time
	x as integer
	y as integer
	x_root as integer
	y_root as integer
	state as uinteger
	is_hint as byte
	same_screen as integer
end type

type XPointerMovedEvent as XMotionEvent

type XCrossingEvent
	type as integer
	serial as uinteger
	send_event as integer
	display as Display ptr
	window as Window
	root as Window
	subwindow as Window
	time as Time
	x as integer
	y as integer
	x_root as integer
	y_root as integer
	mode as integer
	detail as integer
	same_screen as integer
	focus as integer
	state as uinteger
end type

type XEnterWindowEvent as XCrossingEvent
type XLeaveWindowEvent as XCrossingEvent

type XFocusChangeEvent
	type as integer
	serial as uinteger
	send_event as integer
	display as Display ptr
	window as Window
	mode as integer
	detail as integer
end type

type XFocusInEvent as XFocusChangeEvent
type XFocusOutEvent as XFocusChangeEvent

type XKeymapEvent
	type as integer
	serial as uinteger
	send_event as integer
	display as Display ptr
	window as Window
	key_vector as zstring * 32
end type

type XExposeEvent
	type as integer
	serial as uinteger
	send_event as integer
	display as Display ptr
	window as Window
	x as integer
	y as integer
	width as integer
	height as integer
	count as integer
end type

type XGraphicsExposeEvent
	type as integer
	serial as uinteger
	send_event as integer
	display as Display ptr
	drawable as Drawable
	x as integer
	y as integer
	width as integer
	height as integer
	count as integer
	major_code as integer
	minor_code as integer
end type

type XNoExposeEvent
	type as integer
	serial as uinteger
	send_event as integer
	display as Display ptr
	drawable as Drawable
	major_code as integer
	minor_code as integer
end type

type XVisibilityEvent
	type as integer
	serial as uinteger
	send_event as integer
	display as Display ptr
	window as Window
	state as integer
end type

type XCreateWindowEvent
	type as integer
	serial as uinteger
	send_event as integer
	display as Display ptr
	parent as Window
	window as Window
	x as integer
	y as integer
	width as integer
	height as integer
	border_width as integer
	override_redirect as integer
end type

type XDestroyWindowEvent
	type as integer
	serial as uinteger
	send_event as integer
	display as Display ptr
	event as Window
	window as Window
end type

type XUnmapEvent
	type as integer
	serial as uinteger
	send_event as integer
	display as Display ptr
	event as Window
	window as Window
	from_configure as integer
end type

type XMapEvent
	type as integer
	serial as uinteger
	send_event as integer
	display as Display ptr
	event as Window
	window as Window
	override_redirect as integer
end type

type XMapRequestEvent
	type as integer
	serial as uinteger
	send_event as integer
	display as Display ptr
	parent as Window
	window as Window
end type

type XReparentEvent
	type as integer
	serial as uinteger
	send_event as integer
	display as Display ptr
	event as Window
	window as Window
	parent as Window
	x as integer
	y as integer
	override_redirect as integer
end type

type XConfigureEvent
	type as integer
	serial as uinteger
	send_event as integer
	display as Display ptr
	event as Window
	window as Window
	x as integer
	y as integer
	width as integer
	height as integer
	border_width as integer
	above as Window
	override_redirect as integer
end type

type XGravityEvent
	type as integer
	serial as uinteger
	send_event as integer
	display as Display ptr
	event as Window
	window as Window
	x as integer
	y as integer
end type

type XResizeRequestEvent
	type as integer
	serial as uinteger
	send_event as integer
	display as Display ptr
	window as Window
	width as integer
	height as integer
end type

type XConfigureRequestEvent
	type as integer
	serial as uinteger
	send_event as integer
	display as Display ptr
	parent as Window
	window as Window
	x as integer
	y as integer
	width as integer
	height as integer
	border_width as integer
	above as Window
	detail as integer
	value_mask as uinteger
end type

type XCirculateEvent
	type as integer
	serial as uinteger
	send_event as integer
	display as Display ptr
	event as Window
	window as Window
	place as integer
end type

type XCirculateRequestEvent
	type as integer
	serial as uinteger
	send_event as integer
	display as Display ptr
	parent as Window
	window as Window
	place as integer
end type

type XPropertyEvent
	type as integer
	serial as uinteger
	send_event as integer
	display as Display ptr
	window as Window
	atom as Atom
	time as Time
	state as integer
end type

type XSelectionClearEvent
	type as integer
	serial as uinteger
	send_event as integer
	display as Display ptr
	window as Window
	selection as Atom
	time as Time
end type

type XSelectionRequestEvent
	type as integer
	serial as uinteger
	send_event as integer
	display as Display ptr
	owner as Window
	requestor as Window
	selection as Atom
	target as Atom
	property as Atom
	time as Time
end type

type XSelectionEvent
	type as integer
	serial as uinteger
	send_event as integer
	display as Display ptr
	requestor as Window
	selection as Atom
	target as Atom
	property as Atom
	time as Time
end type

type XColormapEvent
	type as integer
	serial as uinteger
	send_event as integer
	display as Display ptr
	window as Window
	colormap as Colormap
	new as integer
	state as integer
end type

type XClientMessageEvent
	type as integer
	serial as uinteger
	send_event as integer
	display as Display ptr
	window as Window
	message_type as Atom
	format as integer
	data as XClientMessageEvent__NESTED__data
end type

union XClientMessageEvent__NESTED__data
	b as zstring * 20
	s(0 to 10-1) as short
	l(0 to 5-1) as integer
end union

type XMappingEvent
	type as integer
	serial as uinteger
	send_event as integer
	display as Display ptr
	window as Window
	request as integer
	first_keycode as integer
	count as integer
end type

type XErrorEvent
	type as integer
	display as Display ptr
	resourceid as XID
	serial as uinteger
	error_code as ubyte
	request_code as ubyte
	minor_code as ubyte
end type

type XAnyEvent
	type as integer
	serial as uinteger
	send_event as integer
	display as Display ptr
	window as Window
end type

type XGenericEvent
	type as integer
	serial as uinteger
	send_event as integer
	display as Display ptr
	extension as integer
	evtype as integer
end type

union _XEvent
	type as integer
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
	pad(0 to 24-1) as integer
end union

type XEvent as _XEvent

type XCharStruct
	lbearing as short
	rbearing as short
	width as short
	ascent as short
	descent as short
	attributes as ushort
end type

type XFontProp
	name as Atom
	card32 as uinteger
end type

type XFontStruct
	ext_data as XExtData ptr
	fid as Font
	direction as uinteger
	min_char_or_byte2 as uinteger
	max_char_or_byte2 as uinteger
	min_byte1 as uinteger
	max_byte1 as uinteger
	all_chars_exist as integer
	default_char as uinteger
	n_properties as integer
	properties as XFontProp ptr
	min_bounds as XCharStruct
	max_bounds as XCharStruct
	per_char as XCharStruct ptr
	ascent as integer
	descent as integer
end type

type XTextItem
	chars as zstring ptr
	nchars as integer
	delta as integer
	font as Font
end type

type XChar2b
	byte1 as ubyte
	byte2 as ubyte
end type

type XTextItem16
	chars as XChar2b ptr
	nchars as integer
	delta as integer
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
	nchars as integer
	delta as integer
	font_set as XFontSet
end type

type XwcTextItem
	chars as wchar_t ptr
	nchars as integer
	delta as integer
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
	charset_count as integer
	charset_list as byte ptr ptr
end type

enum XOrientation
	XOMOrientation_LTR_TTB
	XOMOrientation_RTL_TTB
	XOMOrientation_TTB_LTR
	XOMOrientation_TTB_RTL
	XOMOrientation_Context
end enum


type XOMOrientation
	num_orientation as integer
	orientation as XOrientation ptr
end type

type XOMFontInfo
	num_font as integer
	font_struct_list as XFontStruct ptr ptr
	font_name_list as byte ptr ptr
end type

type XIM as _XIM ptr
type XIC as _XIC ptr
type XIMProc as sub cdecl(byval as XIM, byval as XPointer, byval as XPointer)
type XICProc as function cdecl(byval as XIC, byval as XPointer, byval as XPointer) as integer
type XIDProc as sub cdecl(byval as Display ptr, byval as XPointer, byval as XPointer)
type XIMStyle as uinteger

type XIMStyles
	count_styles as ushort
	supported_styles as XIMStyle ptr
end type

#define XIMPreeditArea &h0001L
#define XIMPreeditCallbacks &h0002L
#define XIMPreeditPosition &h0004L
#define XIMPreeditNothing &h0008L
#define XIMPreeditNone &h0010L
#define XIMStatusArea &h0100L
#define XIMStatusCallbacks &h0200L
#define XIMStatusNothing &h0400L
#define XIMStatusNone &h0800L
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
#define XBufferOverflow -1
#define XLookupNone 1
#define XLookupChars 2
#define XLookupKeySym 3
#define XLookupBoth 4

type XVaNestedList as any ptr

type XIMCallback
	client_data as XPointer
	callback as XIMProc
end type

type XICCallback
	client_data as XPointer
	callback as XICProc
end type

type XIMFeedback as uinteger

#define XIMReverse 1L
#define XIMUnderline (1L shl 1)
#define XIMHighlight (1L shl 2)
#define XIMPrimary (1L shl 5)
#define XIMSecondary (1L shl 6)
#define XIMTertiary (1L shl 7)
#define XIMVisibleToForward (1L shl 8)
#define XIMVisibleToBackword (1L shl 9)
#define XIMVisibleToCenter (1L shl 10)

type _XIMText
	length as ushort
	feedback as XIMFeedback ptr
	encoding_is_wchar as integer
	string as XIMText__NESTED__string
end type

type XIMText as _XIMText

union XIMText__NESTED__string
	multi_byte as zstring ptr
	wide_char as wchar_t ptr
end union

type XIMPreeditState as uinteger

#define XIMPreeditUnKnown 0L
#define XIMPreeditEnable 1L
#define XIMPreeditDisable (1L shl 1)

type _XIMPreeditStateNotifyCallbackStruct
	state as XIMPreeditState
end type

type XIMPreeditStateNotifyCallbackStruct as _XIMPreeditStateNotifyCallbackStruct
type XIMResetState as uinteger

#define XIMInitialState 1L
#define XIMPreserveState (1L shl 1)

type XIMStringConversionFeedback as uinteger

#define XIMStringConversionLeftEdge (&h00000001)
#define XIMStringConversionRightEdge (&h00000002)
#define XIMStringConversionTopEdge (&h00000004)
#define XIMStringConversionBottomEdge (&h00000008)
#define XIMStringConversionConcealed (&h00000010)
#define XIMStringConversionWrapped (&h00000020)

type _XIMStringConversionText
	length as ushort
	feedback as XIMStringConversionFeedback ptr
	encoding_is_wchar as integer
	string as XIMStringConversionText__NESTED__string
end type

type XIMStringConversionText as _XIMStringConversionText

union XIMStringConversionText__NESTED__string
	mbs as zstring ptr
	wcs as wchar_t ptr
end union

type XIMStringConversionPosition as ushort
type XIMStringConversionType as ushort

#define XIMStringConversionBuffer (&h0001)
#define XIMStringConversionLine (&h0002)
#define XIMStringConversionWord (&h0003)
#define XIMStringConversionChar (&h0004)

type XIMStringConversionOperation as ushort

#define XIMStringConversionSubstitution (&h0001)
#define XIMStringConversionRetrieval (&h0002)

enum XIMCaretDirection
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
	caret as integer
	chg_first as integer
	chg_length as integer
	text as XIMText ptr
end type

type XIMPreeditDrawCallbackStruct as _XIMPreeditDrawCallbackStruct

enum XIMCaretStyle
	XIMIsInvisible
	XIMIsPrimary
	XIMIsSecondary
end enum


type _XIMPreeditCaretCallbackStruct
	position as integer
	direction as XIMCaretDirection
	style as XIMCaretStyle
end type

type XIMPreeditCaretCallbackStruct as _XIMPreeditCaretCallbackStruct

enum XIMStatusDataType
	XIMTextType
	XIMBitmapType
end enum


type _XIMStatusDrawCallbackStruct
	type as XIMStatusDataType
	data as XIMStatusDrawCallbackStruct__NESTED__data
end type

type XIMStatusDrawCallbackStruct as _XIMStatusDrawCallbackStruct

union XIMStatusDrawCallbackStruct__NESTED__data
	text as XIMText ptr
	bitmap as Pixmap
end union

type _XIMHotKeyTrigger
	keysym as KeySym
	modifier as integer
	modifier_mask as integer
end type

type XIMHotKeyTrigger as _XIMHotKeyTrigger

type _XIMHotKeyTriggers
	num_hot_key as integer
	key as XIMHotKeyTrigger ptr
end type

type XIMHotKeyTriggers as _XIMHotKeyTriggers
type XIMHotKeyState as uinteger

#define XIMHotKeyStateON (&h0001L)
#define XIMHotKeyStateOFF (&h0002L)

type XIMValuesList
	count_values as ushort
	supported_values as byte ptr ptr
end type

declare function XQueryFont cdecl alias "XQueryFont" (byval as Display ptr, byval as XID) as XFontStruct ptr
declare function XGetMotionEvents cdecl alias "XGetMotionEvents" (byval as Display ptr, byval as Window, byval as Time, byval as Time, byval as integer ptr) as XTimeCoord ptr
declare function XDeleteModifiermapEntry cdecl alias "XDeleteModifiermapEntry" (byval as XModifierKeymap ptr, byval as KeyCode, byval as integer) as XModifierKeymap ptr
declare function XGetModifierMapping cdecl alias "XGetModifierMapping" (byval as Display ptr) as XModifierKeymap ptr
declare function XInsertModifiermapEntry cdecl alias "XInsertModifiermapEntry" (byval as XModifierKeymap ptr, byval as KeyCode, byval as integer) as XModifierKeymap ptr
declare function XNewModifiermap cdecl alias "XNewModifiermap" (byval as integer) as XModifierKeymap ptr
declare function XCreateImage cdecl alias "XCreateImage" (byval as Display ptr, byval as Visual ptr, byval as uinteger, byval as integer, byval as integer, byval as zstring ptr, byval as uinteger, byval as uinteger, byval as integer, byval as integer) as XImage ptr
declare function XInitImage cdecl alias "XInitImage" (byval as XImage ptr) as integer
declare function XGetImage cdecl alias "XGetImage" (byval as Display ptr, byval as Drawable, byval as integer, byval as integer, byval as uinteger, byval as uinteger, byval as uinteger, byval as integer) as XImage ptr
declare function XGetSubImage cdecl alias "XGetSubImage" (byval as Display ptr, byval as Drawable, byval as integer, byval as integer, byval as uinteger, byval as uinteger, byval as uinteger, byval as integer, byval as XImage ptr, byval as integer, byval as integer) as XImage ptr
declare sub XrmInitialize cdecl alias "XrmInitialize" ()
declare function XFetchBytes cdecl alias "XFetchBytes" (byval as Display ptr, byval as integer ptr) as zstring ptr
declare function XFetchBuffer cdecl alias "XFetchBuffer" (byval as Display ptr, byval as integer ptr, byval as integer) as zstring ptr
declare function XGetAtomName cdecl alias "XGetAtomName" (byval as Display ptr, byval as Atom) as zstring ptr
declare function XGetAtomNames cdecl alias "XGetAtomNames" (byval as Display ptr, byval as Atom ptr, byval as integer, byval as byte ptr ptr) as integer
declare function XKeysymToString cdecl alias "XKeysymToString" (byval as KeySym) as zstring ptr
declare function XSynchronize cdecl alias "XSynchronize" (byval as Display ptr, byval as integer) as integer ptr
declare function XSetAfterFunction cdecl alias "XSetAfterFunction" (byval as Display ptr, byval as function cdecl(byval as Display ptr) as integer) as integer ptr
declare function XInternAtoms cdecl alias "XInternAtoms" (byval as Display ptr, byval as byte ptr ptr, byval as integer, byval as integer, byval as Atom ptr) as integer
declare function XCopyColormapAndFree cdecl alias "XCopyColormapAndFree" (byval as Display ptr, byval as Colormap) as Colormap
declare function XCreateColormap cdecl alias "XCreateColormap" (byval as Display ptr, byval as Window, byval as Visual ptr, byval as integer) as Colormap
declare function XCreatePixmapCursor cdecl alias "XCreatePixmapCursor" (byval as Display ptr, byval as Pixmap, byval as Pixmap, byval as XColor ptr, byval as XColor ptr, byval as uinteger, byval as uinteger) as Cursor
declare function XCreateFontCursor cdecl alias "XCreateFontCursor" (byval as Display ptr, byval as uinteger) as Cursor
declare function XCreateGC cdecl alias "XCreateGC" (byval as Display ptr, byval as Drawable, byval as uinteger, byval as XGCValues ptr) as GC
declare function XGContextFromGC cdecl alias "XGContextFromGC" (byval as GC) as GContext
declare sub XFlushGC cdecl alias "XFlushGC" (byval as Display ptr, byval as GC)
declare function XCreatePixmap cdecl alias "XCreatePixmap" (byval as Display ptr, byval as Drawable, byval as uinteger, byval as uinteger, byval as uinteger) as Pixmap
declare function XCreatePixmapFromBitmapData cdecl alias "XCreatePixmapFromBitmapData" (byval as Display ptr, byval as Drawable, byval as zstring ptr, byval as uinteger, byval as uinteger, byval as uinteger, byval as uinteger, byval as uinteger) as Pixmap
declare function XCreateSimpleWindow cdecl alias "XCreateSimpleWindow" (byval as Display ptr, byval as Window, byval as integer, byval as integer, byval as uinteger, byval as uinteger, byval as uinteger, byval as uinteger, byval as uinteger) as Window
declare function XGetSelectionOwner cdecl alias "XGetSelectionOwner" (byval as Display ptr, byval as Atom) as Window
declare function XCreateWindow cdecl alias "XCreateWindow" (byval as Display ptr, byval as Window, byval as integer, byval as integer, byval as uinteger, byval as uinteger, byval as uinteger, byval as integer, byval as uinteger, byval as Visual ptr, byval as uinteger, byval as XSetWindowAttributes ptr) as Window
declare function XListInstalledColormaps cdecl alias "XListInstalledColormaps" (byval as Display ptr, byval as Window, byval as integer ptr) as Colormap ptr
declare function XGetFontPath cdecl alias "XGetFontPath" (byval as Display ptr, byval as integer ptr) as byte ptr ptr
declare function XListExtensions cdecl alias "XListExtensions" (byval as Display ptr, byval as integer ptr) as byte ptr ptr
declare function XListProperties cdecl alias "XListProperties" (byval as Display ptr, byval as Window, byval as integer ptr) as Atom ptr
declare function XListHosts cdecl alias "XListHosts" (byval as Display ptr, byval as integer ptr, byval as integer ptr) as XHostAddress ptr
declare function XKeycodeToKeysym cdecl alias "XKeycodeToKeysym" (byval as Display ptr, byval as KeyCode, byval as integer) as KeySym
declare function XLookupKeysym cdecl alias "XLookupKeysym" (byval as XKeyEvent ptr, byval as integer) as KeySym
declare function XGetKeyboardMapping cdecl alias "XGetKeyboardMapping" (byval as Display ptr, byval as KeyCode, byval as integer, byval as integer ptr) as KeySym ptr
declare function XMaxRequestSize cdecl alias "XMaxRequestSize" (byval as Display ptr) as integer
declare function XExtendedMaxRequestSize cdecl alias "XExtendedMaxRequestSize" (byval as Display ptr) as integer
declare function XResourceManagerString cdecl alias "XResourceManagerString" (byval as Display ptr) as zstring ptr
declare function XScreenResourceString cdecl alias "XScreenResourceString" (byval as Screen ptr) as zstring ptr
declare function XDisplayMotionBufferSize cdecl alias "XDisplayMotionBufferSize" (byval as Display ptr) as uinteger
declare function XVisualIDFromVisual cdecl alias "XVisualIDFromVisual" (byval as Visual ptr) as VisualID
declare function XInitThreads cdecl alias "XInitThreads" () as integer
declare sub XLockDisplay cdecl alias "XLockDisplay" (byval as Display ptr)
declare sub XUnlockDisplay cdecl alias "XUnlockDisplay" (byval as Display ptr)
declare function XAddExtension cdecl alias "XAddExtension" (byval as Display ptr) as XExtCodes ptr
declare function XFindOnExtensionList cdecl alias "XFindOnExtensionList" (byval as XExtData ptr ptr, byval as integer) as XExtData ptr
declare function XEHeadOfExtensionList cdecl alias "XEHeadOfExtensionList" (byval as XEDataObject) as XExtData ptr ptr
declare function XRootWindow cdecl alias "XRootWindow" (byval as Display ptr, byval as integer) as Window
declare function XDefaultRootWindow cdecl alias "XDefaultRootWindow" (byval as Display ptr) as Window
declare function XRootWindowOfScreen cdecl alias "XRootWindowOfScreen" (byval as Screen ptr) as Window
declare function XDefaultVisual cdecl alias "XDefaultVisual" (byval as Display ptr, byval as integer) as Visual ptr
declare function XDefaultVisualOfScreen cdecl alias "XDefaultVisualOfScreen" (byval as Screen ptr) as Visual ptr
declare function XDefaultGC cdecl alias "XDefaultGC" (byval as Display ptr, byval as integer) as GC
declare function XDefaultGCOfScreen cdecl alias "XDefaultGCOfScreen" (byval as Screen ptr) as GC
declare function XBlackPixel cdecl alias "XBlackPixel" (byval as Display ptr, byval as integer) as uinteger
declare function XWhitePixel cdecl alias "XWhitePixel" (byval as Display ptr, byval as integer) as uinteger
declare function XAllPlanes cdecl alias "XAllPlanes" () as uinteger
declare function XBlackPixelOfScreen cdecl alias "XBlackPixelOfScreen" (byval as Screen ptr) as uinteger
declare function XWhitePixelOfScreen cdecl alias "XWhitePixelOfScreen" (byval as Screen ptr) as uinteger
declare function XNextRequest cdecl alias "XNextRequest" (byval as Display ptr) as uinteger
declare function XLastKnownRequestProcessed cdecl alias "XLastKnownRequestProcessed" (byval as Display ptr) as uinteger
declare function XServerVendor cdecl alias "XServerVendor" (byval as Display ptr) as zstring ptr
declare function XDisplayString cdecl alias "XDisplayString" (byval as Display ptr) as zstring ptr
declare function XDefaultColormap cdecl alias "XDefaultColormap" (byval as Display ptr, byval as integer) as Colormap
declare function XDefaultColormapOfScreen cdecl alias "XDefaultColormapOfScreen" (byval as Screen ptr) as Colormap
declare function XDisplayOfScreen cdecl alias "XDisplayOfScreen" (byval as Screen ptr) as Display ptr
declare function XScreenOfDisplay cdecl alias "XScreenOfDisplay" (byval as Display ptr, byval as integer) as Screen ptr
declare function XDefaultScreenOfDisplay cdecl alias "XDefaultScreenOfDisplay" (byval as Display ptr) as Screen ptr
declare function XEventMaskOfScreen cdecl alias "XEventMaskOfScreen" (byval as Screen ptr) as integer
declare function XScreenNumberOfScreen cdecl alias "XScreenNumberOfScreen" (byval as Screen ptr) as integer

type XErrorHandler as function cdecl(byval as Display ptr, byval as XErrorEvent ptr) as integer

declare function XSetErrorHandler cdecl alias "XSetErrorHandler" (byval as XErrorHandler) as XErrorHandler

type XIOErrorHandler as function cdecl(byval as Display ptr) as integer

declare function XSetIOErrorHandler cdecl alias "XSetIOErrorHandler" (byval as XIOErrorHandler) as XIOErrorHandler
declare function XListPixmapFormats cdecl alias "XListPixmapFormats" (byval as Display ptr, byval as integer ptr) as XPixmapFormatValues ptr
declare function XListDepths cdecl alias "XListDepths" (byval as Display ptr, byval as integer, byval as integer ptr) as integer ptr
declare function XReconfigureWMWindow cdecl alias "XReconfigureWMWindow" (byval as Display ptr, byval as Window, byval as integer, byval as uinteger, byval as XWindowChanges ptr) as integer
declare function XGetWMProtocols cdecl alias "XGetWMProtocols" (byval as Display ptr, byval as Window, byval as Atom ptr ptr, byval as integer ptr) as integer
declare function XSetWMProtocols cdecl alias "XSetWMProtocols" (byval as Display ptr, byval as Window, byval as Atom ptr, byval as integer) as integer
declare function XIconifyWindow cdecl alias "XIconifyWindow" (byval as Display ptr, byval as Window, byval as integer) as integer
declare function XWithdrawWindow cdecl alias "XWithdrawWindow" (byval as Display ptr, byval as Window, byval as integer) as integer
declare function XGetCommand cdecl alias "XGetCommand" (byval as Display ptr, byval as Window, byval as byte ptr ptr ptr, byval as integer ptr) as integer
declare function XGetWMColormapWindows cdecl alias "XGetWMColormapWindows" (byval as Display ptr, byval as Window, byval as Window ptr ptr, byval as integer ptr) as integer
declare function XSetWMColormapWindows cdecl alias "XSetWMColormapWindows" (byval as Display ptr, byval as Window, byval as Window ptr, byval as integer) as integer
declare sub XFreeStringList cdecl alias "XFreeStringList" (byval as byte ptr ptr)
declare function XSetTransientForHint cdecl alias "XSetTransientForHint" (byval as Display ptr, byval as Window, byval as Window) as integer
declare function XActivateScreenSaver cdecl alias "XActivateScreenSaver" (byval as Display ptr) as integer
declare function XAddHost cdecl alias "XAddHost" (byval as Display ptr, byval as XHostAddress ptr) as integer
declare function XAddHosts cdecl alias "XAddHosts" (byval as Display ptr, byval as XHostAddress ptr, byval as integer) as integer
declare function XAddToExtensionList cdecl alias "XAddToExtensionList" (byval as _XExtData ptr ptr, byval as XExtData ptr) as integer
declare function XAddToSaveSet cdecl alias "XAddToSaveSet" (byval as Display ptr, byval as Window) as integer
declare function XAllocColor cdecl alias "XAllocColor" (byval as Display ptr, byval as Colormap, byval as XColor ptr) as integer
declare function XAllocColorCells cdecl alias "XAllocColorCells" (byval as Display ptr, byval as Colormap, byval as integer, byval as uinteger ptr, byval as uinteger, byval as uinteger ptr, byval as uinteger) as integer
declare function XAllocColorPlanes cdecl alias "XAllocColorPlanes" (byval as Display ptr, byval as Colormap, byval as integer, byval as uinteger ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as uinteger ptr, byval as uinteger ptr, byval as uinteger ptr) as integer
declare function XAllowEvents cdecl alias "XAllowEvents" (byval as Display ptr, byval as integer, byval as Time) as integer
declare function XAutoRepeatOff cdecl alias "XAutoRepeatOff" (byval as Display ptr) as integer
declare function XAutoRepeatOn cdecl alias "XAutoRepeatOn" (byval as Display ptr) as integer
declare function XBell cdecl alias "XBell" (byval as Display ptr, byval as integer) as integer
declare function XBitmapBitOrder cdecl alias "XBitmapBitOrder" (byval as Display ptr) as integer
declare function XBitmapPad cdecl alias "XBitmapPad" (byval as Display ptr) as integer
declare function XBitmapUnit cdecl alias "XBitmapUnit" (byval as Display ptr) as integer
declare function XCellsOfScreen cdecl alias "XCellsOfScreen" (byval as Screen ptr) as integer
declare function XChangeActivePointerGrab cdecl alias "XChangeActivePointerGrab" (byval as Display ptr, byval as uinteger, byval as Cursor, byval as Time) as integer
declare function XChangeGC cdecl alias "XChangeGC" (byval as Display ptr, byval as GC, byval as uinteger, byval as XGCValues ptr) as integer
declare function XChangeKeyboardControl cdecl alias "XChangeKeyboardControl" (byval as Display ptr, byval as uinteger, byval as XKeyboardControl ptr) as integer
declare function XChangeKeyboardMapping cdecl alias "XChangeKeyboardMapping" (byval as Display ptr, byval as integer, byval as integer, byval as KeySym ptr, byval as integer) as integer
declare function XChangePointerControl cdecl alias "XChangePointerControl" (byval as Display ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer) as integer
declare function XChangeSaveSet cdecl alias "XChangeSaveSet" (byval as Display ptr, byval as Window, byval as integer) as integer
declare function XChangeWindowAttributes cdecl alias "XChangeWindowAttributes" (byval as Display ptr, byval as Window, byval as uinteger, byval as XSetWindowAttributes ptr) as integer
declare function XCheckIfEvent cdecl alias "XCheckIfEvent" (byval as Display ptr, byval as XEvent ptr, byval as function cdecl(byval as Display ptr, byval as XEvent ptr, byval as XPointer) as integer, byval as XPointer) as integer
declare function XCheckMaskEvent cdecl alias "XCheckMaskEvent" (byval as Display ptr, byval as integer, byval as XEvent ptr) as integer
declare function XCheckTypedEvent cdecl alias "XCheckTypedEvent" (byval as Display ptr, byval as integer, byval as XEvent ptr) as integer
declare function XCheckTypedWindowEvent cdecl alias "XCheckTypedWindowEvent" (byval as Display ptr, byval as Window, byval as integer, byval as XEvent ptr) as integer
declare function XCheckWindowEvent cdecl alias "XCheckWindowEvent" (byval as Display ptr, byval as Window, byval as integer, byval as XEvent ptr) as integer
declare function XCirculateSubwindows cdecl alias "XCirculateSubwindows" (byval as Display ptr, byval as Window, byval as integer) as integer
declare function XCirculateSubwindowsDown cdecl alias "XCirculateSubwindowsDown" (byval as Display ptr, byval as Window) as integer
declare function XCirculateSubwindowsUp cdecl alias "XCirculateSubwindowsUp" (byval as Display ptr, byval as Window) as integer
declare function XClearArea cdecl alias "XClearArea" (byval as Display ptr, byval as Window, byval as integer, byval as integer, byval as uinteger, byval as uinteger, byval as integer) as integer
declare function XClearWindow cdecl alias "XClearWindow" (byval as Display ptr, byval as Window) as integer
declare function XCloseDisplay cdecl alias "XCloseDisplay" (byval as Display ptr) as integer
declare function XConfigureWindow cdecl alias "XConfigureWindow" (byval as Display ptr, byval as Window, byval as uinteger, byval as XWindowChanges ptr) as integer
declare function XConnectionNumber cdecl alias "XConnectionNumber" (byval as Display ptr) as integer
declare function XConvertSelection cdecl alias "XConvertSelection" (byval as Display ptr, byval as Atom, byval as Atom, byval as Atom, byval as Window, byval as Time) as integer
declare function XCopyArea cdecl alias "XCopyArea" (byval as Display ptr, byval as Drawable, byval as Drawable, byval as GC, byval as integer, byval as integer, byval as uinteger, byval as uinteger, byval as integer, byval as integer) as integer
declare function XCopyGC cdecl alias "XCopyGC" (byval as Display ptr, byval as GC, byval as uinteger, byval as GC) as integer
declare function XCopyPlane cdecl alias "XCopyPlane" (byval as Display ptr, byval as Drawable, byval as Drawable, byval as GC, byval as integer, byval as integer, byval as uinteger, byval as uinteger, byval as integer, byval as integer, byval as uinteger) as integer
declare function XDefaultDepth cdecl alias "XDefaultDepth" (byval as Display ptr, byval as integer) as integer
declare function XDefaultDepthOfScreen cdecl alias "XDefaultDepthOfScreen" (byval as Screen ptr) as integer
declare function XDefaultScreen cdecl alias "XDefaultScreen" (byval as Display ptr) as integer
declare function XDefineCursor cdecl alias "XDefineCursor" (byval as Display ptr, byval as Window, byval as Cursor) as integer
declare function XDeleteProperty cdecl alias "XDeleteProperty" (byval as Display ptr, byval as Window, byval as Atom) as integer
declare function XDestroyWindow cdecl alias "XDestroyWindow" (byval as Display ptr, byval as Window) as integer
declare function XDestroySubwindows cdecl alias "XDestroySubwindows" (byval as Display ptr, byval as Window) as integer
declare function XDoesBackingStore cdecl alias "XDoesBackingStore" (byval as Screen ptr) as integer
declare function XDoesSaveUnders cdecl alias "XDoesSaveUnders" (byval as Screen ptr) as integer
declare function XDisableAccessControl cdecl alias "XDisableAccessControl" (byval as Display ptr) as integer
declare function XDisplayCells cdecl alias "XDisplayCells" (byval as Display ptr, byval as integer) as integer
declare function XDisplayHeight cdecl alias "XDisplayHeight" (byval as Display ptr, byval as integer) as integer
declare function XDisplayHeightMM cdecl alias "XDisplayHeightMM" (byval as Display ptr, byval as integer) as integer
declare function XDisplayKeycodes cdecl alias "XDisplayKeycodes" (byval as Display ptr, byval as integer ptr, byval as integer ptr) as integer
declare function XDisplayPlanes cdecl alias "XDisplayPlanes" (byval as Display ptr, byval as integer) as integer
declare function XDisplayWidth cdecl alias "XDisplayWidth" (byval as Display ptr, byval as integer) as integer
declare function XDisplayWidthMM cdecl alias "XDisplayWidthMM" (byval as Display ptr, byval as integer) as integer
declare function XDrawArc cdecl alias "XDrawArc" (byval as Display ptr, byval as Drawable, byval as GC, byval as integer, byval as integer, byval as uinteger, byval as uinteger, byval as integer, byval as integer) as integer
declare function XDrawArcs cdecl alias "XDrawArcs" (byval as Display ptr, byval as Drawable, byval as GC, byval as XArc ptr, byval as integer) as integer
declare function XDrawLine cdecl alias "XDrawLine" (byval as Display ptr, byval as Drawable, byval as GC, byval as integer, byval as integer, byval as integer, byval as integer) as integer
declare function XDrawLines cdecl alias "XDrawLines" (byval as Display ptr, byval as Drawable, byval as GC, byval as XPoint ptr, byval as integer, byval as integer) as integer
declare function XDrawPoint cdecl alias "XDrawPoint" (byval as Display ptr, byval as Drawable, byval as GC, byval as integer, byval as integer) as integer
declare function XDrawPoints cdecl alias "XDrawPoints" (byval as Display ptr, byval as Drawable, byval as GC, byval as XPoint ptr, byval as integer, byval as integer) as integer
declare function XDrawRectangle cdecl alias "XDrawRectangle" (byval as Display ptr, byval as Drawable, byval as GC, byval as integer, byval as integer, byval as uinteger, byval as uinteger) as integer
declare function XDrawRectangles cdecl alias "XDrawRectangles" (byval as Display ptr, byval as Drawable, byval as GC, byval as XRectangle ptr, byval as integer) as integer
declare function XDrawSegments cdecl alias "XDrawSegments" (byval as Display ptr, byval as Drawable, byval as GC, byval as XSegment ptr, byval as integer) as integer
declare function XDrawText cdecl alias "XDrawText" (byval as Display ptr, byval as Drawable, byval as GC, byval as integer, byval as integer, byval as XTextItem ptr, byval as integer) as integer
declare function XDrawText16 cdecl alias "XDrawText16" (byval as Display ptr, byval as Drawable, byval as GC, byval as integer, byval as integer, byval as XTextItem16 ptr, byval as integer) as integer
declare function XEnableAccessControl cdecl alias "XEnableAccessControl" (byval as Display ptr) as integer
declare function XEventsQueued cdecl alias "XEventsQueued" (byval as Display ptr, byval as integer) as integer
declare function XFetchName cdecl alias "XFetchName" (byval as Display ptr, byval as Window, byval as byte ptr ptr) as integer
declare function XFillArc cdecl alias "XFillArc" (byval as Display ptr, byval as Drawable, byval as GC, byval as integer, byval as integer, byval as uinteger, byval as uinteger, byval as integer, byval as integer) as integer
declare function XFillArcs cdecl alias "XFillArcs" (byval as Display ptr, byval as Drawable, byval as GC, byval as XArc ptr, byval as integer) as integer
declare function XFillPolygon cdecl alias "XFillPolygon" (byval as Display ptr, byval as Drawable, byval as GC, byval as XPoint ptr, byval as integer, byval as integer, byval as integer) as integer
declare function XFillRectangle cdecl alias "XFillRectangle" (byval as Display ptr, byval as Drawable, byval as GC, byval as integer, byval as integer, byval as uinteger, byval as uinteger) as integer
declare function XFillRectangles cdecl alias "XFillRectangles" (byval as Display ptr, byval as Drawable, byval as GC, byval as XRectangle ptr, byval as integer) as integer
declare function XFlush cdecl alias "XFlush" (byval as Display ptr) as integer
declare function XForceScreenSaver cdecl alias "XForceScreenSaver" (byval as Display ptr, byval as integer) as integer
declare function XFree cdecl alias "XFree" (byval as any ptr) as integer
declare function XFreeColormap cdecl alias "XFreeColormap" (byval as Display ptr, byval as Colormap) as integer
declare function XFreeColors cdecl alias "XFreeColors" (byval as Display ptr, byval as Colormap, byval as uinteger ptr, byval as integer, byval as uinteger) as integer
declare function XFreeCursor cdecl alias "XFreeCursor" (byval as Display ptr, byval as Cursor) as integer
declare function XFreeExtensionList cdecl alias "XFreeExtensionList" (byval as byte ptr ptr) as integer
declare function XFreeFont cdecl alias "XFreeFont" (byval as Display ptr, byval as XFontStruct ptr) as integer
declare function XFreeFontInfo cdecl alias "XFreeFontInfo" (byval as byte ptr ptr, byval as XFontStruct ptr, byval as integer) as integer
declare function XFreeFontNames cdecl alias "XFreeFontNames" (byval as byte ptr ptr) as integer
declare function XFreeFontPath cdecl alias "XFreeFontPath" (byval as byte ptr ptr) as integer
declare function XFreeGC cdecl alias "XFreeGC" (byval as Display ptr, byval as GC) as integer
declare function XFreeModifiermap cdecl alias "XFreeModifiermap" (byval as XModifierKeymap ptr) as integer
declare function XFreePixmap cdecl alias "XFreePixmap" (byval as Display ptr, byval as Pixmap) as integer
declare function XGetErrorText cdecl alias "XGetErrorText" (byval as Display ptr, byval as integer, byval as zstring ptr, byval as integer) as integer
declare function XGetFontProperty cdecl alias "XGetFontProperty" (byval as XFontStruct ptr, byval as Atom, byval as uinteger ptr) as integer
declare function XGetGCValues cdecl alias "XGetGCValues" (byval as Display ptr, byval as GC, byval as uinteger, byval as XGCValues ptr) as integer
declare function XGetGeometry cdecl alias "XGetGeometry" (byval as Display ptr, byval as Drawable, byval as Window ptr, byval as integer ptr, byval as integer ptr, byval as uinteger ptr, byval as uinteger ptr, byval as uinteger ptr, byval as uinteger ptr) as integer
declare function XGetIconName cdecl alias "XGetIconName" (byval as Display ptr, byval as Window, byval as byte ptr ptr) as integer
declare function XGetInputFocus cdecl alias "XGetInputFocus" (byval as Display ptr, byval as Window ptr, byval as integer ptr) as integer
declare function XGetKeyboardControl cdecl alias "XGetKeyboardControl" (byval as Display ptr, byval as XKeyboardState ptr) as integer
declare function XGetPointerControl cdecl alias "XGetPointerControl" (byval as Display ptr, byval as integer ptr, byval as integer ptr, byval as integer ptr) as integer
declare function XGetPointerMapping cdecl alias "XGetPointerMapping" (byval as Display ptr, byval as ubyte ptr, byval as integer) as integer
declare function XGetScreenSaver cdecl alias "XGetScreenSaver" (byval as Display ptr, byval as integer ptr, byval as integer ptr, byval as integer ptr, byval as integer ptr) as integer
declare function XGetTransientForHint cdecl alias "XGetTransientForHint" (byval as Display ptr, byval as Window, byval as Window ptr) as integer
declare function XGetWindowProperty cdecl alias "XGetWindowProperty" (byval as Display ptr, byval as Window, byval as Atom, byval as integer, byval as integer, byval as integer, byval as Atom, byval as Atom ptr, byval as integer ptr, byval as uinteger ptr, byval as uinteger ptr, byval as ubyte ptr ptr) as integer
declare function XGetWindowAttributes cdecl alias "XGetWindowAttributes" (byval as Display ptr, byval as Window, byval as XWindowAttributes ptr) as integer
declare function XGrabButton cdecl alias "XGrabButton" (byval as Display ptr, byval as uinteger, byval as uinteger, byval as Window, byval as integer, byval as uinteger, byval as integer, byval as integer, byval as Window, byval as Cursor) as integer
declare function XGrabKey cdecl alias "XGrabKey" (byval as Display ptr, byval as integer, byval as uinteger, byval as Window, byval as integer, byval as integer, byval as integer) as integer
declare function XGrabKeyboard cdecl alias "XGrabKeyboard" (byval as Display ptr, byval as Window, byval as integer, byval as integer, byval as integer, byval as Time) as integer
declare function XGrabPointer cdecl alias "XGrabPointer" (byval as Display ptr, byval as Window, byval as integer, byval as uinteger, byval as integer, byval as integer, byval as Window, byval as Cursor, byval as Time) as integer
declare function XGrabServer cdecl alias "XGrabServer" (byval as Display ptr) as integer
declare function XHeightMMOfScreen cdecl alias "XHeightMMOfScreen" (byval as Screen ptr) as integer
declare function XHeightOfScreen cdecl alias "XHeightOfScreen" (byval as Screen ptr) as integer
declare function XIfEvent cdecl alias "XIfEvent" (byval as Display ptr, byval as XEvent ptr, byval as function cdecl(byval as Display ptr, byval as XEvent ptr, byval as XPointer) as integer, byval as XPointer) as integer
declare function XImageByteOrder cdecl alias "XImageByteOrder" (byval as Display ptr) as integer
declare function XInstallColormap cdecl alias "XInstallColormap" (byval as Display ptr, byval as Colormap) as integer
declare function XKeysymToKeycode cdecl alias "XKeysymToKeycode" (byval as Display ptr, byval as KeySym) as KeyCode
declare function XKillClient cdecl alias "XKillClient" (byval as Display ptr, byval as XID) as integer
declare function XLowerWindow cdecl alias "XLowerWindow" (byval as Display ptr, byval as Window) as integer
declare function XMapRaised cdecl alias "XMapRaised" (byval as Display ptr, byval as Window) as integer
declare function XMapSubwindows cdecl alias "XMapSubwindows" (byval as Display ptr, byval as Window) as integer
declare function XMapWindow cdecl alias "XMapWindow" (byval as Display ptr, byval as Window) as integer
declare function XMaskEvent cdecl alias "XMaskEvent" (byval as Display ptr, byval as integer, byval as XEvent ptr) as integer
declare function XMaxCmapsOfScreen cdecl alias "XMaxCmapsOfScreen" (byval as Screen ptr) as integer
declare function XMinCmapsOfScreen cdecl alias "XMinCmapsOfScreen" (byval as Screen ptr) as integer
declare function XMoveResizeWindow cdecl alias "XMoveResizeWindow" (byval as Display ptr, byval as Window, byval as integer, byval as integer, byval as uinteger, byval as uinteger) as integer
declare function XMoveWindow cdecl alias "XMoveWindow" (byval as Display ptr, byval as Window, byval as integer, byval as integer) as integer
declare function XNextEvent cdecl alias "XNextEvent" (byval as Display ptr, byval as XEvent ptr) as integer
declare function XNoOp cdecl alias "XNoOp" (byval as Display ptr) as integer
declare function XPeekEvent cdecl alias "XPeekEvent" (byval as Display ptr, byval as XEvent ptr) as integer
declare function XPeekIfEvent cdecl alias "XPeekIfEvent" (byval as Display ptr, byval as XEvent ptr, byval as function cdecl(byval as Display ptr, byval as XEvent ptr, byval as XPointer) as integer, byval as XPointer) as integer
declare function XPending cdecl alias "XPending" (byval as Display ptr) as integer
declare function XPlanesOfScreen cdecl alias "XPlanesOfScreen" (byval as Screen ptr) as integer
declare function XProtocolRevision cdecl alias "XProtocolRevision" (byval as Display ptr) as integer
declare function XProtocolVersion cdecl alias "XProtocolVersion" (byval as Display ptr) as integer
declare function XPutBackEvent cdecl alias "XPutBackEvent" (byval as Display ptr, byval as XEvent ptr) as integer
declare function XPutImage cdecl alias "XPutImage" (byval as Display ptr, byval as Drawable, byval as GC, byval as XImage ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as uinteger, byval as uinteger) as integer
declare function XQLength cdecl alias "XQLength" (byval as Display ptr) as integer
declare function XQueryBestCursor cdecl alias "XQueryBestCursor" (byval as Display ptr, byval as Drawable, byval as uinteger, byval as uinteger, byval as uinteger ptr, byval as uinteger ptr) as integer
declare function XQueryBestSize cdecl alias "XQueryBestSize" (byval as Display ptr, byval as integer, byval as Drawable, byval as uinteger, byval as uinteger, byval as uinteger ptr, byval as uinteger ptr) as integer
declare function XQueryBestStipple cdecl alias "XQueryBestStipple" (byval as Display ptr, byval as Drawable, byval as uinteger, byval as uinteger, byval as uinteger ptr, byval as uinteger ptr) as integer
declare function XQueryBestTile cdecl alias "XQueryBestTile" (byval as Display ptr, byval as Drawable, byval as uinteger, byval as uinteger, byval as uinteger ptr, byval as uinteger ptr) as integer
declare function XQueryColor cdecl alias "XQueryColor" (byval as Display ptr, byval as Colormap, byval as XColor ptr) as integer
declare function XQueryColors cdecl alias "XQueryColors" (byval as Display ptr, byval as Colormap, byval as XColor ptr, byval as integer) as integer
declare function XQueryKeymap cdecl alias "XQueryKeymap" (byval as Display ptr, byval as zstring ptr) as integer
declare function XQueryPointer cdecl alias "XQueryPointer" (byval as Display ptr, byval as Window, byval as Window ptr, byval as Window ptr, byval as integer ptr, byval as integer ptr, byval as integer ptr, byval as integer ptr, byval as uinteger ptr) as integer
declare function XQueryTree cdecl alias "XQueryTree" (byval as Display ptr, byval as Window, byval as Window ptr, byval as Window ptr, byval as Window ptr ptr, byval as uinteger ptr) as integer
declare function XRaiseWindow cdecl alias "XRaiseWindow" (byval as Display ptr, byval as Window) as integer
declare function XRecolorCursor cdecl alias "XRecolorCursor" (byval as Display ptr, byval as Cursor, byval as XColor ptr, byval as XColor ptr) as integer
declare function XRefreshKeyboardMapping cdecl alias "XRefreshKeyboardMapping" (byval as XMappingEvent ptr) as integer
declare function XRemoveFromSaveSet cdecl alias "XRemoveFromSaveSet" (byval as Display ptr, byval as Window) as integer
declare function XRemoveHost cdecl alias "XRemoveHost" (byval as Display ptr, byval as XHostAddress ptr) as integer
declare function XRemoveHosts cdecl alias "XRemoveHosts" (byval as Display ptr, byval as XHostAddress ptr, byval as integer) as integer
declare function XReparentWindow cdecl alias "XReparentWindow" (byval as Display ptr, byval as Window, byval as Window, byval as integer, byval as integer) as integer
declare function XResetScreenSaver cdecl alias "XResetScreenSaver" (byval as Display ptr) as integer
declare function XResizeWindow cdecl alias "XResizeWindow" (byval as Display ptr, byval as Window, byval as uinteger, byval as uinteger) as integer
declare function XRestackWindows cdecl alias "XRestackWindows" (byval as Display ptr, byval as Window ptr, byval as integer) as integer
declare function XRotateBuffers cdecl alias "XRotateBuffers" (byval as Display ptr, byval as integer) as integer
declare function XRotateWindowProperties cdecl alias "XRotateWindowProperties" (byval as Display ptr, byval as Window, byval as Atom ptr, byval as integer, byval as integer) as integer
declare function XScreenCount cdecl alias "XScreenCount" (byval as Display ptr) as integer
declare function XSelectInput cdecl alias "XSelectInput" (byval as Display ptr, byval as Window, byval as integer) as integer
declare function XSendEvent cdecl alias "XSendEvent" (byval as Display ptr, byval as Window, byval as integer, byval as integer, byval as XEvent ptr) as integer
declare function XSetAccessControl cdecl alias "XSetAccessControl" (byval as Display ptr, byval as integer) as integer
declare function XSetArcMode cdecl alias "XSetArcMode" (byval as Display ptr, byval as GC, byval as integer) as integer
declare function XSetBackground cdecl alias "XSetBackground" (byval as Display ptr, byval as GC, byval as uinteger) as integer
declare function XSetClipMask cdecl alias "XSetClipMask" (byval as Display ptr, byval as GC, byval as Pixmap) as integer
declare function XSetClipOrigin cdecl alias "XSetClipOrigin" (byval as Display ptr, byval as GC, byval as integer, byval as integer) as integer
declare function XSetClipRectangles cdecl alias "XSetClipRectangles" (byval as Display ptr, byval as GC, byval as integer, byval as integer, byval as XRectangle ptr, byval as integer, byval as integer) as integer
declare function XSetCloseDownMode cdecl alias "XSetCloseDownMode" (byval as Display ptr, byval as integer) as integer
declare function XSetCommand cdecl alias "XSetCommand" (byval as Display ptr, byval as Window, byval as byte ptr ptr, byval as integer) as integer
declare function XSetFillRule cdecl alias "XSetFillRule" (byval as Display ptr, byval as GC, byval as integer) as integer
declare function XSetFillStyle cdecl alias "XSetFillStyle" (byval as Display ptr, byval as GC, byval as integer) as integer
declare function XSetFont cdecl alias "XSetFont" (byval as Display ptr, byval as GC, byval as Font) as integer
declare function XSetFontPath cdecl alias "XSetFontPath" (byval as Display ptr, byval as byte ptr ptr, byval as integer) as integer
declare function XSetForeground cdecl alias "XSetForeground" (byval as Display ptr, byval as GC, byval as uinteger) as integer
declare function XSetFunction cdecl alias "XSetFunction" (byval as Display ptr, byval as GC, byval as integer) as integer
declare function XSetGraphicsExposures cdecl alias "XSetGraphicsExposures" (byval as Display ptr, byval as GC, byval as integer) as integer
declare function XSetInputFocus cdecl alias "XSetInputFocus" (byval as Display ptr, byval as Window, byval as integer, byval as Time) as integer
declare function XSetLineAttributes cdecl alias "XSetLineAttributes" (byval as Display ptr, byval as GC, byval as uinteger, byval as integer, byval as integer, byval as integer) as integer
declare function XSetModifierMapping cdecl alias "XSetModifierMapping" (byval as Display ptr, byval as XModifierKeymap ptr) as integer
declare function XSetPlaneMask cdecl alias "XSetPlaneMask" (byval as Display ptr, byval as GC, byval as uinteger) as integer
declare function XSetScreenSaver cdecl alias "XSetScreenSaver" (byval as Display ptr, byval as integer, byval as integer, byval as integer, byval as integer) as integer
declare function XSetSelectionOwner cdecl alias "XSetSelectionOwner" (byval as Display ptr, byval as Atom, byval as Window, byval as Time) as integer
declare function XSetState cdecl alias "XSetState" (byval as Display ptr, byval as GC, byval as uinteger, byval as uinteger, byval as integer, byval as uinteger) as integer
declare function XSetStipple cdecl alias "XSetStipple" (byval as Display ptr, byval as GC, byval as Pixmap) as integer
declare function XSetSubwindowMode cdecl alias "XSetSubwindowMode" (byval as Display ptr, byval as GC, byval as integer) as integer
declare function XSetTSOrigin cdecl alias "XSetTSOrigin" (byval as Display ptr, byval as GC, byval as integer, byval as integer) as integer
declare function XSetTile cdecl alias "XSetTile" (byval as Display ptr, byval as GC, byval as Pixmap) as integer
declare function XSetWindowBackground cdecl alias "XSetWindowBackground" (byval as Display ptr, byval as Window, byval as uinteger) as integer
declare function XSetWindowBackgroundPixmap cdecl alias "XSetWindowBackgroundPixmap" (byval as Display ptr, byval as Window, byval as Pixmap) as integer
declare function XSetWindowBorder cdecl alias "XSetWindowBorder" (byval as Display ptr, byval as Window, byval as uinteger) as integer
declare function XSetWindowBorderPixmap cdecl alias "XSetWindowBorderPixmap" (byval as Display ptr, byval as Window, byval as Pixmap) as integer
declare function XSetWindowBorderWidth cdecl alias "XSetWindowBorderWidth" (byval as Display ptr, byval as Window, byval as uinteger) as integer
declare function XSetWindowColormap cdecl alias "XSetWindowColormap" (byval as Display ptr, byval as Window, byval as Colormap) as integer
declare function XStoreColor cdecl alias "XStoreColor" (byval as Display ptr, byval as Colormap, byval as XColor ptr) as integer
declare function XStoreColors cdecl alias "XStoreColors" (byval as Display ptr, byval as Colormap, byval as XColor ptr, byval as integer) as integer
declare function XSync cdecl alias "XSync" (byval as Display ptr, byval as integer) as integer
declare function XTranslateCoordinates cdecl alias "XTranslateCoordinates" (byval as Display ptr, byval as Window, byval as Window, byval as integer, byval as integer, byval as integer ptr, byval as integer ptr, byval as Window ptr) as integer
declare function XUndefineCursor cdecl alias "XUndefineCursor" (byval as Display ptr, byval as Window) as integer
declare function XUngrabButton cdecl alias "XUngrabButton" (byval as Display ptr, byval as uinteger, byval as uinteger, byval as Window) as integer
declare function XUngrabKey cdecl alias "XUngrabKey" (byval as Display ptr, byval as integer, byval as uinteger, byval as Window) as integer
declare function XUngrabKeyboard cdecl alias "XUngrabKeyboard" (byval as Display ptr, byval as Time) as integer
declare function XUngrabPointer cdecl alias "XUngrabPointer" (byval as Display ptr, byval as Time) as integer
declare function XUngrabServer cdecl alias "XUngrabServer" (byval as Display ptr) as integer
declare function XUninstallColormap cdecl alias "XUninstallColormap" (byval as Display ptr, byval as Colormap) as integer
declare function XUnloadFont cdecl alias "XUnloadFont" (byval as Display ptr, byval as Font) as integer
declare function XUnmapSubwindows cdecl alias "XUnmapSubwindows" (byval as Display ptr, byval as Window) as integer
declare function XUnmapWindow cdecl alias "XUnmapWindow" (byval as Display ptr, byval as Window) as integer
declare function XVendorRelease cdecl alias "XVendorRelease" (byval as Display ptr) as integer
declare function XWarpPointer cdecl alias "XWarpPointer" (byval as Display ptr, byval as Window, byval as Window, byval as integer, byval as integer, byval as uinteger, byval as uinteger, byval as integer, byval as integer) as integer
declare function XWidthMMOfScreen cdecl alias "XWidthMMOfScreen" (byval as Screen ptr) as integer
declare function XWidthOfScreen cdecl alias "XWidthOfScreen" (byval as Screen ptr) as integer
declare function XWindowEvent cdecl alias "XWindowEvent" (byval as Display ptr, byval as Window, byval as integer, byval as XEvent ptr) as integer
declare function XSupportsLocale cdecl alias "XSupportsLocale" () as integer
declare function XSetLocaleModifiers cdecl alias "XSetLocaleModifiers" (byval as zstring ptr) as zstring ptr
declare function XCloseOM cdecl alias "XCloseOM" (byval as XOM) as integer
declare function XDisplayOfOM cdecl alias "XDisplayOfOM" (byval as XOM) as Display ptr
declare function XLocaleOfOM cdecl alias "XLocaleOfOM" (byval as XOM) as zstring ptr
declare sub XDestroyOC cdecl alias "XDestroyOC" (byval as XOC)
declare function XOMOfOC cdecl alias "XOMOfOC" (byval as XOC) as XOM
declare sub XFreeFontSet cdecl alias "XFreeFontSet" (byval as Display ptr, byval as XFontSet)
declare function XFontsOfFontSet cdecl alias "XFontsOfFontSet" (byval as XFontSet, byval as XFontStruct ptr ptr ptr, byval as byte ptr ptr ptr) as integer
declare function XBaseFontNameListOfFontSet cdecl alias "XBaseFontNameListOfFontSet" (byval as XFontSet) as zstring ptr
declare function XLocaleOfFontSet cdecl alias "XLocaleOfFontSet" (byval as XFontSet) as zstring ptr
declare function XContextDependentDrawing cdecl alias "XContextDependentDrawing" (byval as XFontSet) as integer
declare function XDirectionalDependentDrawing cdecl alias "XDirectionalDependentDrawing" (byval as XFontSet) as integer
declare function XContextualDrawing cdecl alias "XContextualDrawing" (byval as XFontSet) as integer
declare function XExtentsOfFontSet cdecl alias "XExtentsOfFontSet" (byval as XFontSet) as XFontSetExtents ptr
declare sub XmbDrawText cdecl alias "XmbDrawText" (byval as Display ptr, byval as Drawable, byval as GC, byval as integer, byval as integer, byval as XmbTextItem ptr, byval as integer)
declare sub XwcDrawText cdecl alias "XwcDrawText" (byval as Display ptr, byval as Drawable, byval as GC, byval as integer, byval as integer, byval as XwcTextItem ptr, byval as integer)
declare sub Xutf8DrawText cdecl alias "Xutf8DrawText" (byval as Display ptr, byval as Drawable, byval as GC, byval as integer, byval as integer, byval as XmbTextItem ptr, byval as integer)
declare function XOpenIM cdecl alias "XOpenIM" (byval as Display ptr, byval as _XrmHashBucketRec ptr, byval as zstring ptr, byval as zstring ptr) as XIM
declare function XCloseIM cdecl alias "XCloseIM" (byval as XIM) as integer
declare function XDisplayOfIM cdecl alias "XDisplayOfIM" (byval as XIM) as Display ptr
declare function XLocaleOfIM cdecl alias "XLocaleOfIM" (byval as XIM) as zstring ptr
declare sub XDestroyIC cdecl alias "XDestroyIC" (byval as XIC)
declare sub XSetICFocus cdecl alias "XSetICFocus" (byval as XIC)
declare sub XUnsetICFocus cdecl alias "XUnsetICFocus" (byval as XIC)
declare function XwcResetIC cdecl alias "XwcResetIC" (byval as XIC) as wchar_t ptr
declare function XmbResetIC cdecl alias "XmbResetIC" (byval as XIC) as zstring ptr
declare function Xutf8ResetIC cdecl alias "Xutf8ResetIC" (byval as XIC) as zstring ptr
declare function XIMOfIC cdecl alias "XIMOfIC" (byval as XIC) as XIM
declare function XFilterEvent cdecl alias "XFilterEvent" (byval as XEvent ptr, byval as Window) as integer
declare function XmbLookupString cdecl alias "XmbLookupString" (byval as XIC, byval as XKeyPressedEvent ptr, byval as zstring ptr, byval as integer, byval as KeySym ptr, byval as integer ptr) as integer
declare function XwcLookupString cdecl alias "XwcLookupString" (byval as XIC, byval as XKeyPressedEvent ptr, byval as wchar_t ptr, byval as integer, byval as KeySym ptr, byval as integer ptr) as integer
declare function Xutf8LookupString cdecl alias "Xutf8LookupString" (byval as XIC, byval as XKeyPressedEvent ptr, byval as zstring ptr, byval as integer, byval as KeySym ptr, byval as integer ptr) as integer
declare function XRegisterIMInstantiateCallback cdecl alias "XRegisterIMInstantiateCallback" (byval as Display ptr, byval as _XrmHashBucketRec ptr, byval as zstring ptr, byval as zstring ptr, byval as XIDProc, byval as XPointer) as integer
declare function XUnregisterIMInstantiateCallback cdecl alias "XUnregisterIMInstantiateCallback" (byval as Display ptr, byval as _XrmHashBucketRec ptr, byval as zstring ptr, byval as zstring ptr, byval as XIDProc, byval as XPointer) as integer

type XConnectionWatchProc as sub cdecl(byval as Display ptr, byval as XPointer, byval as integer, byval as integer, byval as XPointer ptr)

declare function XInternalConnectionNumbers cdecl alias "XInternalConnectionNumbers" (byval as Display ptr, byval as integer ptr ptr, byval as integer ptr) as integer
declare sub XProcessInternalConnection cdecl alias "XProcessInternalConnection" (byval as Display ptr, byval as integer)
declare function XAddConnectionWatch cdecl alias "XAddConnectionWatch" (byval as Display ptr, byval as XConnectionWatchProc, byval as XPointer) as integer
declare sub XRemoveConnectionWatch cdecl alias "XRemoveConnectionWatch" (byval as Display ptr, byval as XConnectionWatchProc, byval as XPointer)
declare sub XSetAuthorization cdecl alias "XSetAuthorization" (byval as zstring ptr, byval as integer, byval as zstring ptr, byval as integer)
declare function _Xmbtowc cdecl alias "_Xmbtowc" (byval as wchar_t ptr, byval as zstring ptr, byval as integer) as integer
declare function _Xwctomb cdecl alias "_Xwctomb" (byval as zstring ptr, byval as wchar_t) as integer

#endif
