''
''
'' Xlibint -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __Xlibint_bi__
#define __Xlibint_bi__

#define _XLIBINT_H_ 1
#define XCONN_CHECK_FREQ 256

type _XGC
	ext_data as XExtData ptr
	gid as GContext
	rects as Bool
	dashes as Bool
	dirty as uinteger
	values as XGCValues
end type

type _XDisplay
	ext_data as XExtData ptr
	free_funcs as _XFreeFuncs ptr
	fd as integer
	conn_checker as integer
	proto_major_version as integer
	proto_minor_version as integer
	vendor as zstring ptr
	resource_base as XID
	resource_mask as XID
	resource_id as XID
	resource_shift as integer
	resource_alloc as function cdecl(byval as _XDisplay ptr) as XID
	byte_order as integer
	bitmap_unit as integer
	bitmap_pad as integer
	bitmap_bit_order as integer
	nformats as integer
	pixmap_format as ScreenFormat ptr
	vnumber as integer
	release as integer
	head as _XSQEvent ptr
	tail as _XSQEvent ptr
	qlen as integer
	last_request_read as uinteger
	request as uinteger
	last_req as zstring ptr
	buffer as zstring ptr
	bufptr as zstring ptr
	bufmax as zstring ptr
	max_request_size as uinteger
	db as _XrmHashBucketRec ptr
	synchandler as function cdecl(byval as _XDisplay ptr) as integer
	display_name as zstring ptr
	default_screen as integer
	nscreens as integer
	screens as Screen ptr
	motion_buffer as uinteger
	flags as uinteger
	min_keycode as integer
	max_keycode as integer
	keysyms as KeySym ptr
	modifiermap as XModifierKeymap ptr
	keysyms_per_keycode as integer
	xdefaults as zstring ptr
	scratch_buffer as zstring ptr
	scratch_length as uinteger
	ext_number as integer
	ext_procs as _XExten ptr
	event_vec(0 to 128-1) as Bool ptr
	wire_vec(0 to 128-1) as Status ptr
	lock_meaning as KeySym
	lock as _XLockInfo ptr
	async_handlers as _XInternalAsync ptr
	bigreq_size as uinteger
	lock_fns as _XLockPtrs ptr
	idlist_alloc as sub cdecl(byval as Display ptr, byval as XID ptr, byval as integer)
	key_bindings as _XKeytrans ptr
	cursor_font as Font
	atoms as _XDisplayAtoms ptr
	mode_switch as uinteger
	num_lock as uinteger
	context_db as _XContextDB ptr
	error_vec as Bool ptr ptr
	im_filters as _XIMFilter ptr
	qfree as _XSQEvent ptr
	next_event_serial_num as uinteger
	flushes as _XExten ptr
	im_fd_info as _XConnectionInfo ptr
	im_fd_length as integer
	conn_watchers as _XConnWatchInfo ptr
	watcher_count as integer
	filedes as XPointer
	savedsynchandler as function cdecl(byval as Display ptr) as integer
	resource_max as XID
	xcmisc_opcode as integer
	xkb_info as _XkbInfoRec ptr
	trans_conn as _XtransConnInfo ptr
	xcb as _X11XCBPrivate ptr
	cms as _XDisplay__NESTED__cms
end type

type _XDisplay__NESTED__cms
	defaultCCCs as XPointer
	clientCmaps as XPointer
	perVisualIntensityMaps as XPointer
end type

type _XSQEvent
	next as _XSQEvent ptr
	event as XEvent
	qserial_num as uinteger
end type

type _XQEvent as _XSQEvent

#define BUFSIZE 2048
#define PTSPERBATCH 1024
#define WLNSPERBATCH 50
#define ZLNSPERBATCH 1024
#define WRCTSPERBATCH 10
#define ZRCTSPERBATCH 256
#define FRCTSPERBATCH 256
#define FARCSPERBATCH 256
#define CURSORFONT "cursor"
#define XlibDisplayIOError (1L shl 0)
#define XlibDisplayClosing (1L shl 1)
#define XlibDisplayNoXkb (1L shl 2)
#define XlibDisplayPrivSync (1L shl 3)
#define XlibDisplayProcConni (1L shl 4)
#define XlibDisplayReadEvents (1L shl 5)
#define XlibDisplayReply (1L shl 5)
#define XlibDisplayWriting (1L shl 6)
#define XlibDisplayDfltRMDB (1L shl 7)

declare sub _XFlushGCCache cdecl alias "_XFlushGCCache" (byval dpy as Display ptr, byval gc as GC)

type _XInternalAsync
	next as _XInternalAsync ptr
	handler as function cdecl(byval as Display ptr, byval as xReply ptr, byval as zstring ptr, byval as integer, byval as XPointer) as Bool
	data as XPointer
end type

type _XAsyncHandler as _XInternalAsync

type _XAsyncEState
	min_sequence_number as uinteger
	max_sequence_number as uinteger
	error_code as ubyte
	major_opcode as ubyte
	minor_opcode as ushort
	last_error_received as ubyte
	error_count as integer
end type

type _XAsyncErrorState as _XAsyncEState

declare sub _XDeqAsyncHandler cdecl alias "_XDeqAsyncHandler" (byval dpy as Display ptr, byval handler as _XAsyncHandler ptr)

type FreeFuncType as sub cdecl(byval as Display ptr)
type FreeModmapType as function cdecl(byval as XModifierKeymap ptr) as integer

type _XFreeFuncs
	atoms as FreeFuncType
	modifiermap as FreeModmapType
	key_bindings as FreeFuncType
	context_db as FreeFuncType
	defaultCCCs as FreeFuncType
	clientCmaps as FreeFuncType
	intensityMaps as FreeFuncType
	im_filters as FreeFuncType
	xkb as FreeFuncType
end type

type _XFreeFuncRec as _XFreeFuncs
type CreateGCType as function cdecl(byval as Display ptr, byval as GC, byval as XExtCodes ptr) as integer
type CopyGCType as function cdecl(byval as Display ptr, byval as GC, byval as XExtCodes ptr) as integer
type FlushGCType as function cdecl(byval as Display ptr, byval as GC, byval as XExtCodes ptr) as integer
type FreeGCType as function cdecl(byval as Display ptr, byval as GC, byval as XExtCodes ptr) as integer
type CreateFontType as function cdecl(byval as Display ptr, byval as XFontStruct ptr, byval as XExtCodes ptr) as integer
type FreeFontType as function cdecl(byval as Display ptr, byval as XFontStruct ptr, byval as XExtCodes ptr) as integer
type CloseDisplayType as function cdecl(byval as Display ptr, byval as XExtCodes ptr) as integer
type ErrorType as function cdecl(byval as Display ptr, byval as xError ptr, byval as XExtCodes ptr, byval as integer ptr) as integer
type ErrorStringType as function cdecl(byval as Display ptr, byval as integer, byval as XExtCodes ptr, byval as zstring ptr, byval as integer) as byte ptr
type PrintErrorType as sub cdecl(byval as Display ptr, byval as XErrorEvent ptr, byval as any ptr)

type _XExten
	next as _XExten ptr
	codes as XExtCodes
	create_GC as CreateGCType
	copy_GC as CopyGCType
	flush_GC as FlushGCType
	free_GC as FreeGCType
	create_Font as CreateFontType
	free_Font as FreeFontType
	close_display as CloseDisplayType
	error as ErrorType
	error_string as ErrorStringType
	name as zstring ptr
	error_values as PrintErrorType
	before_flush as BeforeFlushType
	next_flush as _XExten ptr
end type

type _XExtension as _XExten

declare function _XError cdecl alias "_XError" (byval as Display ptr, byval as xError ptr) as integer
declare function _XIOError cdecl alias "_XIOError" (byval as Display ptr) as integer
extern _XIOErrorFunction alias "_XIOErrorFunction" as function cdecl(byval as Display ptr) as integer
extern _XErrorFunction alias "_XErrorFunction" as function cdecl(byval as Display ptr, byval as XErrorEvent ptr) as integer
declare sub _XEatData cdecl alias "_XEatData" (byval as Display ptr, byval as uinteger)
declare function _XAllocScratch cdecl alias "_XAllocScratch" (byval as Display ptr, byval as uinteger) as zstring ptr
declare function _XAllocTemp cdecl alias "_XAllocTemp" (byval as Display ptr, byval as uinteger) as zstring ptr
declare sub _XFreeTemp cdecl alias "_XFreeTemp" (byval as Display ptr, byval as zstring ptr, byval as uinteger)
declare function _XVIDtoVisual cdecl alias "_XVIDtoVisual" (byval as Display ptr, byval as VisualID) as Visual ptr
declare function _XSetLastRequestRead cdecl alias "_XSetLastRequestRead" (byval as Display ptr, byval as xGenericReply ptr) as uinteger
declare function _XGetHostname cdecl alias "_XGetHostname" (byval as zstring ptr, byval as integer) as integer
declare function _XScreenOfWindow cdecl alias "_XScreenOfWindow" (byval as Display ptr, byval as Window) as Screen ptr
declare function _XAsyncErrorHandler cdecl alias "_XAsyncErrorHandler" (byval as Display ptr, byval as xReply ptr, byval as zstring ptr, byval as integer, byval as XPointer) as Bool
declare function _XGetAsyncReply cdecl alias "_XGetAsyncReply" (byval as Display ptr, byval as zstring ptr, byval as xReply ptr, byval as zstring ptr, byval as integer, byval as integer, byval as Bool) as zstring ptr
declare sub _XGetAsyncData cdecl alias "_XGetAsyncData" (byval as Display ptr, byval as zstring ptr, byval as zstring ptr, byval as integer, byval as integer, byval as integer, byval as integer)
declare sub _XFlush cdecl alias "_XFlush" (byval as Display ptr)
declare function _XEventsQueued cdecl alias "_XEventsQueued" (byval as Display ptr, byval as integer) as integer
declare sub _XReadEvents cdecl alias "_XReadEvents" (byval as Display ptr)
declare function _XRead cdecl alias "_XRead" (byval as Display ptr, byval as zstring ptr, byval as integer) as integer
declare sub _XReadPad cdecl alias "_XReadPad" (byval as Display ptr, byval as zstring ptr, byval as integer)
declare function _XReply cdecl alias "_XReply" (byval as Display ptr, byval as xReply ptr, byval as integer, byval as Bool) as Status
declare sub _XEnq cdecl alias "_XEnq" (byval as Display ptr, byval as xEvent ptr)
declare sub _XDeq cdecl alias "_XDeq" (byval as Display ptr, byval as _XQEvent ptr, byval as _XQEvent ptr)
declare function _XUnknownWireEvent cdecl alias "_XUnknownWireEvent" (byval as Display ptr, byval as XEvent ptr, byval as xEvent ptr) as Bool
declare function _XUnknownNativeEvent cdecl alias "_XUnknownNativeEvent" (byval as Display ptr, byval as XEvent ptr, byval as xEvent ptr) as Status
declare function _XWireToEvent cdecl alias "_XWireToEvent" (byval dpy as Display ptr, byval re as XEvent ptr, byval event as xEvent ptr) as Bool
declare function _XDefaultWireError cdecl alias "_XDefaultWireError" (byval display as Display ptr, byval he as XErrorEvent ptr, byval we as xError ptr) as Bool
declare function _XPollfdCacheInit cdecl alias "_XPollfdCacheInit" (byval dpy as Display ptr) as Bool
declare sub _XPollfdCacheAdd cdecl alias "_XPollfdCacheAdd" (byval dpy as Display ptr, byval fd as integer)
declare sub _XPollfdCacheDel cdecl alias "_XPollfdCacheDel" (byval dpy as Display ptr, byval fd as integer)
declare function _XAllocID cdecl alias "_XAllocID" (byval dpy as Display ptr) as XID
declare sub _XAllocIDs cdecl alias "_XAllocIDs" (byval dpy as Display ptr, byval ids as XID ptr, byval count as integer)
declare function _XFreeExtData cdecl alias "_XFreeExtData" (byval as XExtData ptr) as integer
declare function XESetCreateGC cdecl alias "XESetCreateGC" (byval as Display ptr, byval as integer, byval as function cdecl(byval as Display ptr, byval as GC, byval as XExtCodes ptr) as integer) as integer ptr
declare function XESetCopyGC cdecl alias "XESetCopyGC" (byval as Display ptr, byval as integer, byval as function cdecl(byval as Display ptr, byval as GC, byval as XExtCodes ptr) as integer) as integer ptr
declare function XESetFlushGC cdecl alias "XESetFlushGC" (byval as Display ptr, byval as integer, byval as function cdecl(byval as Display ptr, byval as GC, byval as XExtCodes ptr) as integer) as integer ptr
declare function XESetFreeGC cdecl alias "XESetFreeGC" (byval as Display ptr, byval as integer, byval as function cdecl(byval as Display ptr, byval as GC, byval as XExtCodes ptr) as integer) as integer ptr
declare function XESetCreateFont cdecl alias "XESetCreateFont" (byval as Display ptr, byval as integer, byval as function cdecl(byval as Display ptr, byval as XFontStruct ptr, byval as XExtCodes ptr) as integer) as integer ptr
declare function XESetFreeFont cdecl alias "XESetFreeFont" (byval as Display ptr, byval as integer, byval as function cdecl(byval as Display ptr, byval as XFontStruct ptr, byval as XExtCodes ptr) as integer) as integer ptr
declare function XESetCloseDisplay cdecl alias "XESetCloseDisplay" (byval as Display ptr, byval as integer, byval as function cdecl(byval as Display ptr, byval as XExtCodes ptr) as integer) as integer ptr
declare function XESetError cdecl alias "XESetError" (byval as Display ptr, byval as integer, byval as function cdecl(byval as Display ptr, byval as xError ptr, byval as XExtCodes ptr, byval as integer ptr) as integer) as integer ptr
declare function XESetErrorString cdecl alias "XESetErrorString" (byval as Display ptr, byval as integer, byval as function cdecl(byval as Display ptr, byval as integer, byval as XExtCodes ptr, byval as zstring ptr, byval as integer) as byte ptr) as zstring ptr
declare function XESetPrintErrorValues cdecl alias "XESetPrintErrorValues" (byval as Display ptr, byval as integer, byval as sub cdecl(byval as Display ptr, byval as XErrorEvent ptr, byval as any ptr)) as any ptr
declare function XESetWireToEvent cdecl alias "XESetWireToEvent" (byval as Display ptr, byval as integer, byval as function cdecl(byval as Display ptr, byval as XEvent ptr, byval as xEvent ptr) as Bool) as Bool ptr
declare function XESetEventToWire cdecl alias "XESetEventToWire" (byval as Display ptr, byval as integer, byval as function cdecl(byval as Display ptr, byval as XEvent ptr, byval as xEvent ptr) as Status) as Status ptr
declare function XESetWireToError cdecl alias "XESetWireToError" (byval as Display ptr, byval as integer, byval as function cdecl(byval as Display ptr, byval as XErrorEvent ptr, byval as xError ptr) as Bool) as Bool ptr

type _XInternalConnectionProc as sub cdecl(byval as Display ptr, byval as integer, byval as XPointer)

declare function _XRegisterInternalConnection cdecl alias "_XRegisterInternalConnection" (byval as Display ptr, byval as integer, byval as _XInternalConnectionProc, byval as XPointer) as Status
declare sub _XUnregisterInternalConnection cdecl alias "_XUnregisterInternalConnection" (byval as Display ptr, byval as integer)
declare sub _XProcessInternalConnection cdecl alias "_XProcessInternalConnection" (byval as Display ptr, byval as _XConnectionInfo ptr)

type _XConnectionInfo
	fd as integer
	read_callback as _XInternalConnectionProc
	call_data as XPointer
	watch_data as XPointer ptr
	next as _XConnectionInfo ptr
end type

type _XConnWatchInfo
	fn as XConnectionWatchProc
	client_data as XPointer
	next as _XConnWatchInfo ptr
end type

declare function _XEventToWire cdecl alias "_XEventToWire" (byval dpy as Display ptr, byval re as XEvent ptr, byval event as xEvent ptr) as Status
declare sub _XProcessWindowAttributes cdecl alias "_XProcessWindowAttributes" (byval dpy as Display ptr, byval req as xChangeWindowAttributesReq ptr, byval valuemask as uinteger, byval attributes as XSetWindowAttributes ptr)
declare function _XDefaultError cdecl alias "_XDefaultError" (byval dpy as Display ptr, byval event as XErrorEvent ptr) as integer
declare function _XDefaultIOError cdecl alias "_XDefaultIOError" (byval dpy as Display ptr) as integer
declare sub _XSetClipRectangles cdecl alias "_XSetClipRectangles" (byval dpy as Display ptr, byval gc as GC, byval clip_x_origin as integer, byval clip_y_origin as integer, byval rectangles as XRectangle ptr, byval n as integer, byval ordering as integer)
declare function _XGetWindowAttributes cdecl alias "_XGetWindowAttributes" (byval dpy as Display ptr, byval w as Window, byval attr as XWindowAttributes ptr) as Status
declare function _XPutBackEvent cdecl alias "_XPutBackEvent" (byval dpy as Display ptr, byval event as XEvent ptr) as integer

#endif
