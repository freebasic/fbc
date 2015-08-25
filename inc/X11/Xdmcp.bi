'' FreeBASIC binding for libXdmcp-1.1.2
''
'' based on the C header files:
''   Copyright 1989 Network Computing Devices, Inc., Mountain View, California.
''
''   Permission to use, copy, modify, and distribute this software and its
''   documentation for any purpose and without fee is hereby granted, provided
''   that the above copyright notice appear in all copies and that both that
''   copyright notice and this permission notice appear in supporting
''   documentation, and that the name of N.C.D. not be used in advertising or
''   publicity pertaining to distribution of the software without specific,
''   written prior permission.  N.C.D. makes no representations about the
''   suitability of this software for any purpose.  It is provided "as is"
''   without express or implied warranty.
''
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "X11/Xmd.bi"
#include once "X11/Xfuncproto.bi"

'' The following symbols have been renamed:
''     constant ACCEPT => XACCEPT
''     constant FAILED => XFAILED

extern "C"

#define _XDMCP_H_
const XDM_PROTOCOL_VERSION = 1
const XDM_UDP_PORT = 177
#define XDM_DEFAULT_MCAST_ADDR6 "ff02:0:0:0:0:0:0:12b"
const XDM_MAX_MSGLEN = 8192
const XDM_MIN_RTX = 2
const XDM_MAX_RTX = 32
const XDM_RTX_LIMIT = 7
const XDM_KA_RTX_LIMIT = 4
const XDM_DEF_DORMANCY = 3 * 60
const XDM_MAX_DORMANCY = (24 * 60) * 60

type xdmOpCode as long
enum
	BROADCAST_QUERY = 1
	QUERY
	INDIRECT_QUERY
	FORWARD_QUERY
	WILLING
	UNWILLING
	REQUEST
	XACCEPT
	DECLINE
	MANAGE
	REFUSE
	XFAILED
	KEEPALIVE
	ALIVE
end enum

type xdmcp_states as long
enum
	XDM_QUERY
	XDM_BROADCAST
	XDM_INDIRECT
	XDM_COLLECT_QUERY
	XDM_COLLECT_BROADCAST_QUERY
	XDM_COLLECT_INDIRECT_QUERY
	XDM_START_CONNECTION
	XDM_AWAIT_REQUEST_RESPONSE
	XDM_AWAIT_MANAGE_RESPONSE
	XDM_MANAGE
	XDM_RUN_SESSION
	XDM_OFF
	XDM_AWAIT_USER_INPUT
	XDM_KEEPALIVE
	XDM_AWAIT_ALIVE_RESPONSE
	XDM_KEEP_ME_LAST
end enum

type CARD8Ptr as CARD8 ptr
type CARD16Ptr as CARD16 ptr
type CARD32Ptr as CARD32 ptr

type _ARRAY8
	length as CARD16
	data as CARD8Ptr
end type

type ARRAY8 as _ARRAY8
type ARRAY8Ptr as _ARRAY8 ptr

type _ARRAY16
	length as CARD8
	data as CARD16Ptr
end type

type ARRAY16 as _ARRAY16
type ARRAY16Ptr as _ARRAY16 ptr

type _ARRAY32
	length as CARD8
	data as CARD32Ptr
end type

type ARRAY32 as _ARRAY32
type ARRAY32Ptr as _ARRAY32 ptr

type _ARRAYofARRAY8
	length as CARD8
	data as ARRAY8Ptr
end type

type ARRAYofARRAY8 as _ARRAYofARRAY8
type ARRAYofARRAY8Ptr as _ARRAYofARRAY8 ptr

type _XdmcpHeader
	version as CARD16
	opcode as CARD16
	length as CARD16
end type

type XdmcpHeader as _XdmcpHeader
type XdmcpHeaderPtr as _XdmcpHeader ptr

type _XdmcpBuffer
	data as UBYTE ptr
	size as long
	pointer as long
	count as long
end type

type XdmcpBuffer as _XdmcpBuffer
type XdmcpBufferPtr as _XdmcpBuffer ptr

type _XdmAuthKey
	data(0 to 7) as UBYTE
end type

type XdmAuthKeyRec as _XdmAuthKey
type XdmAuthKeyPtr as _XdmAuthKey ptr
type XdmcpNetaddr as zstring ptr

declare function XdmcpWriteARRAY16(byval buffer as XdmcpBufferPtr, byval array as const ARRAY16Ptr) as long
declare function XdmcpWriteARRAY32(byval buffer as XdmcpBufferPtr, byval array as const ARRAY32Ptr) as long
declare function XdmcpWriteARRAY8(byval buffer as XdmcpBufferPtr, byval array as const ARRAY8Ptr) as long
declare function XdmcpWriteARRAYofARRAY8(byval buffer as XdmcpBufferPtr, byval array as const ARRAYofARRAY8Ptr) as long
declare function XdmcpWriteCARD16(byval buffer as XdmcpBufferPtr, byval value as ulong) as long
declare function XdmcpWriteCARD32(byval buffer as XdmcpBufferPtr, byval value as ulong) as long
declare function XdmcpWriteCARD8(byval buffer as XdmcpBufferPtr, byval value as ulong) as long
declare function XdmcpWriteHeader(byval buffer as XdmcpBufferPtr, byval header as const XdmcpHeaderPtr) as long
declare function XdmcpFlush(byval fd as long, byval buffer as XdmcpBufferPtr, byval to as XdmcpNetaddr, byval tolen as long) as long
declare function XdmcpReadARRAY16(byval buffer as XdmcpBufferPtr, byval array as ARRAY16Ptr) as long
declare function XdmcpReadARRAY32(byval buffer as XdmcpBufferPtr, byval array as ARRAY32Ptr) as long
declare function XdmcpReadARRAY8(byval buffer as XdmcpBufferPtr, byval array as ARRAY8Ptr) as long
declare function XdmcpReadARRAYofARRAY8(byval buffer as XdmcpBufferPtr, byval array as ARRAYofARRAY8Ptr) as long
declare function XdmcpReadCARD16(byval buffer as XdmcpBufferPtr, byval valuep as CARD16Ptr) as long
declare function XdmcpReadCARD32(byval buffer as XdmcpBufferPtr, byval valuep as CARD32Ptr) as long
declare function XdmcpReadCARD8(byval buffer as XdmcpBufferPtr, byval valuep as CARD8Ptr) as long
declare function XdmcpReadHeader(byval buffer as XdmcpBufferPtr, byval header as XdmcpHeaderPtr) as long
declare function XdmcpFill(byval fd as long, byval buffer as XdmcpBufferPtr, byval from as XdmcpNetaddr, byval fromlen as long ptr) as long
declare function XdmcpReadRemaining(byval buffer as const XdmcpBufferPtr) as long
declare sub XdmcpDisposeARRAY8(byval array as ARRAY8Ptr)
declare sub XdmcpDisposeARRAY16(byval array as ARRAY16Ptr)
declare sub XdmcpDisposeARRAY32(byval array as ARRAY32Ptr)
declare sub XdmcpDisposeARRAYofARRAY8(byval array as ARRAYofARRAY8Ptr)
declare function XdmcpCopyARRAY8(byval src as const ARRAY8Ptr, byval dst as ARRAY8Ptr) as long
declare function XdmcpARRAY8Equal(byval array1 as const ARRAY8Ptr, byval array2 as const ARRAY8Ptr) as long
declare sub XdmcpGenerateKey(byval key as XdmAuthKeyPtr)
declare sub XdmcpIncrementKey(byval key as XdmAuthKeyPtr)
declare sub XdmcpDecrementKey(byval key as XdmAuthKeyPtr)
declare function XdmcpCompareKeys(byval a as const XdmAuthKeyPtr, byval b as const XdmAuthKeyPtr) as long
declare function XdmcpAllocARRAY16(byval array as ARRAY16Ptr, byval length as long) as long
declare function XdmcpAllocARRAY32(byval array as ARRAY32Ptr, byval length as long) as long
declare function XdmcpAllocARRAY8(byval array as ARRAY8Ptr, byval length as long) as long
declare function XdmcpAllocARRAYofARRAY8(byval array as ARRAYofARRAY8Ptr, byval length as long) as long
declare function XdmcpReallocARRAY16(byval array as ARRAY16Ptr, byval length as long) as long
declare function XdmcpReallocARRAY32(byval array as ARRAY32Ptr, byval length as long) as long
declare function XdmcpReallocARRAY8(byval array as ARRAY8Ptr, byval length as long) as long
declare function XdmcpReallocARRAYofARRAY8(byval array as ARRAYofARRAY8Ptr, byval length as long) as long

end extern
