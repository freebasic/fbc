'' FreeBASIC binding for libX11-1.6.3
''
'' based on the C header files:
''
''   Copyright 1984, 1985, 1987, 1989, 1998  The Open Group
''
''   Permission to use, copy, modify, distribute, and sell this software and its
''   documentation for any purpose is hereby granted without fee, provided that
''   the above copyright notice appear in all copies and that both that
''   copyright notice and this permission notice appear in supporting
''   documentation.
''
''   The above copyright notice and this permission notice shall be included
''   in all copies or substantial portions of the Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
''   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
''   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
''   IN NO EVENT SHALL THE OPEN GROUP BE LIABLE FOR ANY CLAIM, DAMAGES OR
''   OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
''   ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
''   OTHER DEALINGS IN THE SOFTWARE.
''
''   Except as contained in this notice, the name of The Open Group shall
''   not be used in advertising or otherwise to promote the sale, use or
''   other dealings in this Software without prior written authorization
''   from The Open Group.
''
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/long.bi"
#include once "X11/Xlib.bi"
#include once "X11/Xproto.bi"
#include once "X11/XlibConf.bi"
#include once "crt/errno.bi"
#include once "X11/Xfuncs.bi"
#include once "X11/Xosdefs.bi"
#include once "crt/stdlib.bi"
#include once "crt/string.bi"
#include once "X11/Xfuncproto.bi"
#include once "crt/stddef.bi"
#include once "crt/sys/types.bi"
#include once "X11/Xtrans/Xtrans.bi"

'' The following symbols have been renamed:
''     #define Xfree => Xfree_
''     #define Data => Data_

extern "C"

const _X11_XLIBINT_H_ = 1
const XCONN_CHECK_FREQ = 256

type _XGC
	ext_data as XExtData ptr
	gid as GContext
	rects as long
	dashes as long
	dirty as culong
	values as XGCValues
end type

type _XDisplay_cms
	defaultCCCs as XPointer
	clientCmaps as XPointer
	perVisualIntensityMaps as XPointer
end type

type _XFreeFuncs as _XFreeFuncs_
type _XSQEvent as _XSQEvent_
type _XExten as _XExten_
type _XLockInfo as _XLockInfo_
type _XInternalAsync as _XInternalAsync_
type _XLockPtrs as _XLockPtrs_
type _XKeytrans as _XKeytrans_
type _XDisplayAtoms as _XDisplayAtoms_
type _XContextDB as _XContextDB_
type _XIMFilter as _XIMFilter_
type _XConnectionInfo as _XConnectionInfo_
type _XConnWatchInfo as _XConnWatchInfo_
type _XkbInfoRec as _XkbInfoRec_
type _X11XCBPrivate as _X11XCBPrivate_

type _XDisplay_
	ext_data as XExtData ptr
	free_funcs as _XFreeFuncs ptr
	fd as long
	conn_checker as long
	proto_major_version as long
	proto_minor_version as long
	vendor as zstring ptr
	resource_base as XID
	resource_mask as XID
	resource_id as XID
	resource_shift as long
	resource_alloc as function(byval as _XDisplay ptr) as XID
	byte_order as long
	bitmap_unit as long
	bitmap_pad as long
	bitmap_bit_order as long
	nformats as long
	pixmap_format as ScreenFormat ptr
	vnumber as long
	release as long
	head as _XSQEvent ptr
	tail as _XSQEvent ptr
	qlen as long
	last_request_read as culong
	request as culong
	last_req as zstring ptr
	buffer as zstring ptr
	bufptr as zstring ptr
	bufmax as zstring ptr
	max_request_size as ulong
	db as _XrmHashBucketRec ptr
	synchandler as function(byval as _XDisplay ptr) as long
	display_name as zstring ptr
	default_screen as long
	nscreens as long
	screens as Screen ptr
	motion_buffer as culong
	flags as culong
	min_keycode as long
	max_keycode as long
	keysyms as KeySym ptr
	modifiermap as XModifierKeymap ptr
	keysyms_per_keycode as long
	xdefaults as zstring ptr
	scratch_buffer as zstring ptr
	scratch_length as culong
	ext_number as long
	ext_procs as _XExten ptr
	event_vec(0 to 127) as function(byval as Display ptr, byval as XEvent ptr, byval as xEvent_ ptr) as long
	wire_vec(0 to 127) as function(byval as Display ptr, byval as XEvent ptr, byval as xEvent_ ptr) as long
	lock_meaning as KeySym
	lock as _XLockInfo ptr
	async_handlers as _XInternalAsync ptr
	bigreq_size as culong
	lock_fns as _XLockPtrs ptr
	idlist_alloc as sub(byval as Display ptr, byval as XID ptr, byval as long)
	key_bindings as _XKeytrans ptr
	cursor_font as Font
	atoms as _XDisplayAtoms ptr
	mode_switch as ulong
	num_lock as ulong
	context_db as _XContextDB ptr
	error_vec as typeof(function(byval as Display ptr, byval as XErrorEvent ptr, byval as xError ptr) as long) ptr
	cms as _XDisplay_cms
	im_filters as _XIMFilter ptr
	qfree as _XSQEvent ptr
	next_event_serial_num as culong
	flushes as _XExten ptr
	im_fd_info as _XConnectionInfo ptr
	im_fd_length as long
	conn_watchers as _XConnWatchInfo ptr
	watcher_count as long
	filedes as XPointer
	savedsynchandler as function(byval as Display ptr) as long
	resource_max as XID
	xcmisc_opcode as long
	xkb_info as _XkbInfoRec ptr
	trans_conn as _XtransConnInfo ptr
	xcb as _X11XCBPrivate ptr
	next_cookie as ulong
	generic_event_vec(0 to 127) as function(byval as Display ptr, byval as XGenericEventCookie ptr, byval as xEvent_ ptr) as long
	generic_event_copy_vec(0 to 127) as function(byval as Display ptr, byval as XGenericEventCookie ptr, byval as XGenericEventCookie ptr) as long
	cookiejar as any ptr
end type

#define XAllocIDs(dpy, ids, n) ((dpy)->idlist_alloc)(dpy, ids, n)

type _XSQEvent_
	next as _XSQEvent ptr
	event as XEvent
	qserial_num as culong
end type

type _XQEvent as _XSQEvent
#define _XBCOPYFUNC _Xbcopy
type LockInfoPtr as _LockInfoRec ptr

type _XLockPtrs_
	lock_display as sub(byval dpy as Display ptr)
	unlock_display as sub(byval dpy as Display ptr)
end type

#ifdef __FB_UNIX__
	extern _XCreateMutex_fn as sub(byval as LockInfoPtr)
	extern _XFreeMutex_fn as sub(byval as LockInfoPtr)
	extern _XLockMutex_fn as sub(byval as LockInfoPtr)
	extern _XUnlockMutex_fn as sub(byval as LockInfoPtr)
	extern _Xglobal_lock as LockInfoPtr
#else
	#define _XCreateMutex_fn (*_XCreateMutex_fn_p)
	#define _XFreeMutex_fn (*_XFreeMutex_fn_p)
	#define _XLockMutex_fn (*_XLockMutex_fn_p)
	#define _XUnlockMutex_fn (*_XUnlockMutex_fn_p)
	#define _Xglobal_lock (*_Xglobal_lock_p)

	extern _XCreateMutex_fn_p as typeof(sub(byval as LockInfoPtr)) ptr
	extern _XFreeMutex_fn_p as typeof(sub(byval as LockInfoPtr)) ptr
	extern _XLockMutex_fn_p as typeof(sub(byval as LockInfoPtr)) ptr
	extern _XUnlockMutex_fn_p as typeof(sub(byval as LockInfoPtr)) ptr
	extern _Xglobal_lock_p as LockInfoPtr ptr
#endif

#macro LockDisplay(d)
	if (d)->lock_fns then
		(d)->lock_fns->lock_display(d)
	end if
#endmacro
#macro UnlockDisplay(d)
	if (d)->lock_fns then
		(d)->lock_fns->unlock_display(d)
	end if
#endmacro
#macro _XLockMutex(lock)
	if _XLockMutex_fn then
		_XLockMutex_fn(lock)
	end if
#endmacro
#macro _XUnlockMutex(lock)
	if _XUnlockMutex_fn then
		_XUnlockMutex_fn(lock)
	end if
#endmacro
#macro _XCreateMutex(lock)
	if _XCreateMutex_fn then
		_XCreateMutex_fn(lock)
	end if
#endmacro
#macro _XFreeMutex(lock)
	if _XFreeMutex_fn then
		_XFreeMutex_fn(lock)
	end if
#endmacro
#define Xfree_(ptr) free((ptr))
#define Xmalloc(size) malloc((size))
#define Xrealloc(ptr, size) realloc((ptr), (size))
#define Xcalloc(nelem, elsize) calloc((nelem), (elsize))
const LOCKED = 1
const UNLOCKED = 0
const BUFSIZE = 2048
const PTSPERBATCH = 1024
const WLNSPERBATCH = 50
const ZLNSPERBATCH = 1024
const WRCTSPERBATCH = 10
const ZRCTSPERBATCH = 256
const FRCTSPERBATCH = 256
const FARCSPERBATCH = 256
#define CURSORFONT "cursor"
const XlibDisplayIOError = cast(clong, 1) shl 0
const XlibDisplayClosing = cast(clong, 1) shl 1
const XlibDisplayNoXkb = cast(clong, 1) shl 2
const XlibDisplayPrivSync = cast(clong, 1) shl 3
const XlibDisplayProcConni = cast(clong, 1) shl 4
const XlibDisplayReadEvents = cast(clong, 1) shl 5
const XlibDisplayReply = cast(clong, 1) shl 5
const XlibDisplayWriting = cast(clong, 1) shl 6
const XlibDisplayDfltRMDB = cast(clong, 1) shl 7
declare function _XGetRequest(byval dpy as Display ptr, byval type as CARD8, byval len as uinteger) as any ptr
#macro GetReqSized(name, sz, req)
	scope
		req = cptr(x##name##Req ptr, _XGetRequest(dpy, X_##name, sz))
	end scope
#endmacro
#define GetReq(name, req_) GetReqSized(name, XSIZEOF(x##name##Req), req_)
#define GetReqExtra(name, n, req_) GetReqSized(name, XSIZEOF(x##name##Req) + n, req_)
#macro GetResReq(name, rid, req)
	scope
		req = cptr(xResourceReq ptr, _XGetRequest(dpy, X_##name, XSIZEOF(xResourceReq)))
		req->id = (rid)
	end scope
#endmacro
#define GetEmptyReq(name, req) scope : req = cptr(xReq ptr, _XGetRequest(dpy, X_##name, XSIZEOF(xReq))) : end scope

#ifdef __FB_64BIT__
	#macro MakeBigReq(req, n)
		scope
			dim _BRdat as CARD64
			dim _BRlen as CARD32 = req->length - 1
			req->length = 0
			_BRdat = cptr(CARD32 ptr, req)[_BRlen]
			memmove(cptr(zstring ptr, req) + 8, cptr(zstring ptr, req) + 4, (_BRlen - 1) shl 2)
			cptr(CARD32 ptr, req)[1] = (_BRlen + n) + 2
			Data32(dpy, @_BRdat, 4)
		end scope
	#endmacro
#else
	#macro MakeBigReq(req, n)
		scope
			dim _BRdat as CARD32
			dim _BRlen as CARD32 = req->length - 1
			req->length = 0
			_BRdat = cptr(CARD32 ptr, req)[_BRlen]
			memmove(cptr(zstring ptr, req) + 8, cptr(zstring ptr, req) + 4, (_BRlen - 1) shl 2)
			cptr(CARD32 ptr, req)[1] = (_BRlen + n) + 2
			Data32(dpy, @_BRdat, 4)
		end scope
	#endmacro
#endif

#macro SetReqLen(req, n, badlen)
	if (req->length + n) > 65535ul then
		if dpy->bigreq_size then
			MakeBigReq(req,n)
		else
			n = badlen
			req->length += n
		end if
	else
		req->length += n
	end if
#endmacro
#macro SyncHandle()
	if dpy->synchandler then
		dpy->synchandler(dpy)
	end if
#endmacro
declare sub _XFlushGCCache(byval dpy as Display ptr, byval gc as GC)
#macro FlushGC(dpy, gc)
	if (gc)->dirty then
		_XFlushGCCache((dpy), (gc))
	end if
#endmacro
#macro Data_(dpy, data, len)
	if (dpy->bufptr + (len)) <= dpy->bufmax then
		memcpy(dpy->bufptr, data, clng(len))
		dpy->bufptr += ((len) + 3) and (not 3)
	else
		_XSend(dpy, data, len)
	end if
#endmacro
#macro BufAlloc(type, ptr, n)
	if dpy->bufptr + (n) > dpy->bufmax then
		_XFlush(dpy)
		ptr = cast(type, dpy->bufptr)
		memset(ptr, 0, n)
		dpy->bufptr += (n)
	end if
#endmacro
#define Data16(dpy, data, len) Data_((dpy), cptr(const zstring ptr, (data)), (len))
#define _XRead16Pad(dpy, data, len) _XReadPad((dpy), cptr(zstring ptr, (data)), (len))
#define _XRead16(dpy, data, len) _XRead((dpy), cptr(zstring ptr, (data)), (len))

#ifdef __FB_64BIT__
	#define Data32(dpy, data, len) _XData32(dpy, cptr(const clong ptr, data), len)
	declare function _XData32(byval dpy as Display ptr, byval data as const clong ptr, byval len as ulong) as long
	declare sub _XRead32(byval dpy as Display ptr, byval data as clong ptr, byval len as clong)
#else
	#define Data32(dpy, data, len) Data_((dpy), cptr(const zstring ptr, (data)), (len))
	#define _XRead32(dpy, data, len) _XRead((dpy), cptr(zstring ptr, (data)), (len))
#endif

#define PackData16(dpy, data, len) Data16(dpy, data, len)
#define PackData32(dpy, data, len) Data32(dpy, data, len)
#define PackData(dpy, data, len) PackData16(dpy, data, len)
#define CI_NONEXISTCHAR(cs) (((cs)->width = 0) andalso (((((cs)->rbearing or (cs)->lbearing) or (cs)->ascent) or (cs)->descent) = 0))
#macro CI_GET_CHAR_INFO_1D(fs, col, def, cs)
	scope
		cs = def
		if (col >= fs->min_char_or_byte2) andalso (col <= fs->max_char_or_byte2) then
			if fs->per_char = NULL then
				cs = @fs->min_bounds
			else
				cs = @fs->per_char[(col - fs->min_char_or_byte2)]
				if CI_NONEXISTCHAR(cs) then
					cs = def
				end if
			end if
		end if
	end scope
#endmacro
#define CI_GET_DEFAULT_INFO_1D(fs, cs) CI_GET_CHAR_INFO_1D(fs, fs->default_char, NULL, cs)
#macro CI_GET_CHAR_INFO_2D(fs, row, col, def, cs)
	scope
		cs = def
		if (((row >= fs->min_byte1) andalso (row <= fs->max_byte1)) andalso (col >= fs->min_char_or_byte2)) andalso (col <= fs->max_char_or_byte2) then
			if fs->per_char = NULL then
				cs = @fs->min_bounds
			else
				cs = @fs->per_char[(((row - fs->min_byte1) * ((fs->max_char_or_byte2 - fs->min_char_or_byte2) + 1)) + (col - fs->min_char_or_byte2))]
				if CI_NONEXISTCHAR(cs) then
					cs = def
				end if
			end if
		end if
	end scope
#endmacro
#macro CI_GET_DEFAULT_INFO_2D(fs, cs)
	scope
		dim r as ulong = fs->default_char shr 8
		dim c as ulong = fs->default_char and &hff
		CI_GET_CHAR_INFO_2D(fs, r, c, NULL, cs)
	end scope
#endmacro
#define OneDataCard32(dpy, dstaddr, srcvar) scope : (*cptr(CARD32 ptr, (dstaddr))) = (srcvar) : end scope

type _XInternalAsync_
	next as _XInternalAsync ptr
	handler as function(byval as Display ptr, byval as xReply ptr, byval as zstring ptr, byval as long, byval as XPointer) as long
	data as XPointer
end type

type _XAsyncHandler as _XInternalAsync

type _XAsyncEState
	min_sequence_number as culong
	max_sequence_number as culong
	error_code as ubyte
	major_opcode as ubyte
	minor_opcode as ushort
	last_error_received as ubyte
	error_count as long
end type

type _XAsyncErrorState as _XAsyncEState
declare sub _XDeqAsyncHandler(byval dpy as Display ptr, byval handler as _XAsyncHandler ptr)
#macro DeqAsyncHandler(dpy, handler)
	if dpy->async_handlers = (handler) then
		dpy->async_handlers = (handler)->next
	else
		_XDeqAsyncHandler(dpy, handler)
	end if
#endmacro
type FreeFuncType as sub(byval as Display ptr)
type FreeModmapType as function(byval as XModifierKeymap ptr) as long

type _XFreeFuncs_
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
type CreateGCType as function(byval as Display ptr, byval as GC, byval as XExtCodes ptr) as long
type CopyGCType as function(byval as Display ptr, byval as GC, byval as XExtCodes ptr) as long
type FlushGCType as function(byval as Display ptr, byval as GC, byval as XExtCodes ptr) as long
type FreeGCType as function(byval as Display ptr, byval as GC, byval as XExtCodes ptr) as long
type CreateFontType as function(byval as Display ptr, byval as XFontStruct ptr, byval as XExtCodes ptr) as long
type FreeFontType as function(byval as Display ptr, byval as XFontStruct ptr, byval as XExtCodes ptr) as long
type CloseDisplayType as function(byval as Display ptr, byval as XExtCodes ptr) as long
type ErrorType as function(byval as Display ptr, byval as xError ptr, byval as XExtCodes ptr, byval as long ptr) as long
type ErrorStringType as function(byval as Display ptr, byval as long, byval as XExtCodes ptr, byval as zstring ptr, byval as long) as zstring ptr
type PrintErrorType as sub(byval as Display ptr, byval as XErrorEvent ptr, byval as any ptr)
type BeforeFlushType as sub(byval as Display ptr, byval as XExtCodes ptr, byval as const zstring ptr, byval as clong)

type _XExten_
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
#define _XLIB_COLD _X_COLD
declare function _XError(byval as Display ptr, byval as xError ptr) as long
declare function _XIOError(byval as Display ptr) as long
extern _XIOErrorFunction as function(byval as Display ptr) as long
extern _XErrorFunction as function(byval as Display ptr, byval as XErrorEvent ptr) as long
declare sub _XEatData(byval as Display ptr, byval as culong)
declare sub _XEatDataWords(byval as Display ptr, byval as culong)
declare function _XAllocScratch(byval as Display ptr, byval as culong) as zstring ptr
declare function _XAllocTemp(byval as Display ptr, byval as culong) as zstring ptr
declare sub _XFreeTemp(byval as Display ptr, byval as zstring ptr, byval as culong)
declare function _XVIDtoVisual(byval as Display ptr, byval as VisualID) as Visual ptr
declare function _XSetLastRequestRead(byval as Display ptr, byval as xGenericReply ptr) as culong
declare function _XGetHostname(byval as zstring ptr, byval as long) as long
declare function _XScreenOfWindow(byval as Display ptr, byval as Window) as Screen ptr
declare function _XAsyncErrorHandler(byval as Display ptr, byval as xReply ptr, byval as zstring ptr, byval as long, byval as XPointer) as long
declare function _XGetAsyncReply(byval as Display ptr, byval as zstring ptr, byval as xReply ptr, byval as zstring ptr, byval as long, byval as long, byval as long) as zstring ptr
declare sub _XGetAsyncData(byval as Display ptr, byval as zstring ptr, byval as zstring ptr, byval as long, byval as long, byval as long, byval as long)

#ifdef __FB_UNIX__
	declare sub _XFlush(byval as Display ptr)
#else
	declare sub _XFlushIt(byval as Display ptr)
	declare sub _XFlush alias "_XFlushIt"(byval as Display ptr)
#endif

declare function _XEventsQueued(byval as Display ptr, byval as long) as long
declare sub _XReadEvents(byval as Display ptr)
declare function _XRead(byval as Display ptr, byval as zstring ptr, byval as clong) as long
declare sub _XReadPad(byval as Display ptr, byval as zstring ptr, byval as clong)
declare sub _XSend(byval as Display ptr, byval as const zstring ptr, byval as clong)
declare function _XReply(byval as Display ptr, byval as xReply ptr, byval as long, byval as long) as long
declare sub _XEnq(byval as Display ptr, byval as xEvent_ ptr)
declare sub _XDeq(byval as Display ptr, byval as _XQEvent ptr, byval as _XQEvent ptr)
declare function _XUnknownWireEvent(byval as Display ptr, byval as XEvent ptr, byval as xEvent_ ptr) as long
declare function _XUnknownWireEventCookie(byval as Display ptr, byval as XGenericEventCookie ptr, byval as xEvent_ ptr) as long
declare function _XUnknownCopyEventCookie(byval as Display ptr, byval as XGenericEventCookie ptr, byval as XGenericEventCookie ptr) as long
declare function _XUnknownNativeEvent(byval as Display ptr, byval as XEvent ptr, byval as xEvent_ ptr) as long
declare function _XWireToEvent(byval dpy as Display ptr, byval re as XEvent ptr, byval event as xEvent_ ptr) as long
declare function _XDefaultWireError(byval display as Display ptr, byval he as XErrorEvent ptr, byval we as xError ptr) as long
declare function _XPollfdCacheInit(byval dpy as Display ptr) as long
declare sub _XPollfdCacheAdd(byval dpy as Display ptr, byval fd as long)
declare sub _XPollfdCacheDel(byval dpy as Display ptr, byval fd as long)
declare function _XAllocID(byval dpy as Display ptr) as XID
declare sub _XAllocIDs(byval dpy as Display ptr, byval ids as XID ptr, byval count as long)
declare function _XFreeExtData(byval as XExtData ptr) as long
declare function XESetCreateGC(byval as Display ptr, byval as long, byval as function(byval as Display ptr, byval as GC, byval as XExtCodes ptr) as long) as function(byval as Display ptr, byval as GC, byval as XExtCodes ptr) as long
declare function XESetCopyGC(byval as Display ptr, byval as long, byval as function(byval as Display ptr, byval as GC, byval as XExtCodes ptr) as long) as function(byval as Display ptr, byval as GC, byval as XExtCodes ptr) as long
declare function XESetFlushGC(byval as Display ptr, byval as long, byval as function(byval as Display ptr, byval as GC, byval as XExtCodes ptr) as long) as function(byval as Display ptr, byval as GC, byval as XExtCodes ptr) as long
declare function XESetFreeGC(byval as Display ptr, byval as long, byval as function(byval as Display ptr, byval as GC, byval as XExtCodes ptr) as long) as function(byval as Display ptr, byval as GC, byval as XExtCodes ptr) as long
declare function XESetCreateFont(byval as Display ptr, byval as long, byval as function(byval as Display ptr, byval as XFontStruct ptr, byval as XExtCodes ptr) as long) as function(byval as Display ptr, byval as XFontStruct ptr, byval as XExtCodes ptr) as long
declare function XESetFreeFont(byval as Display ptr, byval as long, byval as function(byval as Display ptr, byval as XFontStruct ptr, byval as XExtCodes ptr) as long) as function(byval as Display ptr, byval as XFontStruct ptr, byval as XExtCodes ptr) as long
declare function XESetCloseDisplay(byval as Display ptr, byval as long, byval as function(byval as Display ptr, byval as XExtCodes ptr) as long) as function(byval as Display ptr, byval as XExtCodes ptr) as long
declare function XESetError(byval as Display ptr, byval as long, byval as function(byval as Display ptr, byval as xError ptr, byval as XExtCodes ptr, byval as long ptr) as long) as function(byval as Display ptr, byval as xError ptr, byval as XExtCodes ptr, byval as long ptr) as long
declare function XESetErrorString(byval as Display ptr, byval as long, byval as function(byval as Display ptr, byval as long, byval as XExtCodes ptr, byval as zstring ptr, byval as long) as zstring ptr) as function(byval as Display ptr, byval as long, byval as XExtCodes ptr, byval as zstring ptr, byval as long) as zstring ptr
declare function XESetPrintErrorValues(byval as Display ptr, byval as long, byval as sub(byval as Display ptr, byval as XErrorEvent ptr, byval as any ptr)) as sub(byval as Display ptr, byval as XErrorEvent ptr, byval as any ptr)
declare function XESetWireToEvent(byval as Display ptr, byval as long, byval as function(byval as Display ptr, byval as XEvent ptr, byval as xEvent_ ptr) as long) as function(byval as Display ptr, byval as XEvent ptr, byval as xEvent_ ptr) as long
declare function XESetWireToEventCookie(byval as Display ptr, byval as long, byval as function(byval as Display ptr, byval as XGenericEventCookie ptr, byval as xEvent_ ptr) as long) as function(byval as Display ptr, byval as XGenericEventCookie ptr, byval as xEvent_ ptr) as long
declare function XESetCopyEventCookie(byval as Display ptr, byval as long, byval as function(byval as Display ptr, byval as XGenericEventCookie ptr, byval as XGenericEventCookie ptr) as long) as function(byval as Display ptr, byval as XGenericEventCookie ptr, byval as XGenericEventCookie ptr) as long
declare function XESetEventToWire(byval as Display ptr, byval as long, byval as function(byval as Display ptr, byval as XEvent ptr, byval as xEvent_ ptr) as long) as function(byval as Display ptr, byval as XEvent ptr, byval as xEvent_ ptr) as long
declare function XESetWireToError(byval as Display ptr, byval as long, byval as function(byval as Display ptr, byval as XErrorEvent ptr, byval as xError ptr) as long) as function(byval as Display ptr, byval as XErrorEvent ptr, byval as xError ptr) as long
declare function XESetBeforeFlush(byval as Display ptr, byval as long, byval as sub(byval as Display ptr, byval as XExtCodes ptr, byval as const zstring ptr, byval as clong)) as sub(byval as Display ptr, byval as XExtCodes ptr, byval as const zstring ptr, byval as clong)
type _XInternalConnectionProc as sub(byval as Display ptr, byval as long, byval as XPointer)
declare function _XRegisterInternalConnection(byval as Display ptr, byval as long, byval as _XInternalConnectionProc, byval as XPointer) as long
declare sub _XUnregisterInternalConnection(byval as Display ptr, byval as long)
declare sub _XProcessInternalConnection(byval as Display ptr, byval as _XConnectionInfo ptr)

type _XConnectionInfo_
	fd as long
	read_callback as _XInternalConnectionProc
	call_data as XPointer
	watch_data as XPointer ptr
	next as _XConnectionInfo ptr
end type

type _XConnWatchInfo_
	fn as XConnectionWatchProc
	client_data as XPointer
	next as _XConnWatchInfo ptr
end type

declare function _XTextHeight(byval as XFontStruct ptr, byval as const zstring ptr, byval as long) as long
declare function _XTextHeight16(byval as XFontStruct ptr, byval as const XChar2b ptr, byval as long) as long

#ifdef __FB_UNIX__
	#define _XOpenFile(path, flags) open(path, flags)
	#define _XOpenFileMode(path, flags, mode) open(path, flags, mode)
	#define _XFopenFile(path, mode) fopen(path, mode)
#else
	declare function _XOpenFile(byval as const zstring ptr, byval as long) as long
	declare function _XOpenFileMode(byval as const zstring ptr, byval as long, byval as _mode_t) as long
	declare function _XFopenFile(byval as const zstring ptr, byval as const zstring ptr) as any ptr
	declare function _XAccessFile(byval as const zstring ptr) as long
#endif

declare function _XEventToWire(byval dpy as Display ptr, byval re as XEvent ptr, byval event as xEvent_ ptr) as long
declare function _XF86LoadQueryLocaleFont(byval as Display ptr, byval as const zstring ptr, byval as XFontStruct ptr ptr, byval as Font ptr) as long
declare sub _XProcessWindowAttributes(byval dpy as Display ptr, byval req as xChangeWindowAttributesReq ptr, byval valuemask as culong, byval attributes as XSetWindowAttributes ptr)
declare function _XDefaultError(byval dpy as Display ptr, byval event as XErrorEvent ptr) as long
declare function _XDefaultIOError(byval dpy as Display ptr) as long
declare sub _XSetClipRectangles(byval dpy as Display ptr, byval gc as GC, byval clip_x_origin as long, byval clip_y_origin as long, byval rectangles as XRectangle ptr, byval n as long, byval ordering as long)
declare function _XGetWindowAttributes(byval dpy as Display ptr, byval w as Window, byval attr as XWindowAttributes ptr) as long
declare function _XPutBackEvent(byval dpy as Display ptr, byval event as XEvent ptr) as long
declare function _XIsEventCookie(byval dpy as Display ptr, byval ev as XEvent ptr) as long
declare sub _XFreeEventCookies(byval dpy as Display ptr)
declare sub _XStoreEventCookie(byval dpy as Display ptr, byval ev as XEvent ptr)
declare function _XFetchEventCookie(byval dpy as Display ptr, byval ev as XGenericEventCookie ptr) as long
declare function _XCopyEventCookie(byval dpy as Display ptr, byval in as XGenericEventCookie ptr, byval out as XGenericEventCookie ptr) as long
declare sub xlocaledir(byval buf as zstring ptr, byval buf_len as long)

end extern
