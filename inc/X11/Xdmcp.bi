''
''
'' Xdmcp -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __Xdmcp_bi__
#define __Xdmcp_bi__

#define XDM_DEFAULT_MCAST_ADDR6 "ff02:0:0:0:0:0:0:12b"
#define XDM_MAX_MSGLEN 8192
#define XDM_MIN_RTX 2
#define XDM_MAX_RTX 32
#define XDM_RTX_LIMIT 7
#define XDM_KA_RTX_LIMIT 4
#define XDM_DEF_DORMANCY (3*60)
#define XDM_MAX_DORMANCY (24*60*60)

enum xdmOpCode
	BROADCAST_QUERY = 1
	QUERY
	INDIRECT_QUERY
	FORWARD_QUERY
	WILLING
	UNWILLING
	REQUEST
	ACCEPT
	DECLINE
	MANAGE
	REFUSE
	FAILED
	KEEPALIVE
	ALIVE
end enum


enum xdmcp_states
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
	data as BYTE ptr
	size as integer
	pointer as integer
	count as integer
end type

type XdmcpBuffer as _XdmcpBuffer
type XdmcpBufferPtr as _XdmcpBuffer ptr

type _XdmAuthKey
	data(0 to 8-1) as BYTE
end type

type XdmAuthKeyRec as _XdmAuthKey
type XdmAuthKeyPtr as _XdmAuthKey ptr
type XdmcpNetaddr as byte ptr

declare function XdmcpWriteARRAY16 cdecl alias "XdmcpWriteARRAY16" (byval buffer as XdmcpBufferPtr, byval array as ARRAY16Ptr) as integer
declare function XdmcpWriteARRAY32 cdecl alias "XdmcpWriteARRAY32" (byval buffer as XdmcpBufferPtr, byval array as ARRAY32Ptr) as integer
declare function XdmcpWriteARRAY8 cdecl alias "XdmcpWriteARRAY8" (byval buffer as XdmcpBufferPtr, byval array as ARRAY8Ptr) as integer
declare function XdmcpWriteARRAYofARRAY8 cdecl alias "XdmcpWriteARRAYofARRAY8" (byval buffer as XdmcpBufferPtr, byval array as ARRAYofARRAY8Ptr) as integer
declare function XdmcpWriteCARD16 cdecl alias "XdmcpWriteCARD16" (byval buffer as XdmcpBufferPtr, byval value as uinteger) as integer
declare function XdmcpWriteCARD32 cdecl alias "XdmcpWriteCARD32" (byval buffer as XdmcpBufferPtr, byval value as uinteger) as integer
declare function XdmcpWriteCARD8 cdecl alias "XdmcpWriteCARD8" (byval buffer as XdmcpBufferPtr, byval value as uinteger) as integer
declare function XdmcpWriteHeader cdecl alias "XdmcpWriteHeader" (byval buffer as XdmcpBufferPtr, byval header as XdmcpHeaderPtr) as integer
declare function XdmcpFlush cdecl alias "XdmcpFlush" (byval fd as integer, byval buffer as XdmcpBufferPtr, byval to as XdmcpNetaddr, byval tolen as integer) as integer
declare function XdmcpReadARRAY16 cdecl alias "XdmcpReadARRAY16" (byval buffer as XdmcpBufferPtr, byval array as ARRAY16Ptr) as integer
declare function XdmcpReadARRAY32 cdecl alias "XdmcpReadARRAY32" (byval buffer as XdmcpBufferPtr, byval array as ARRAY32Ptr) as integer
declare function XdmcpReadARRAY8 cdecl alias "XdmcpReadARRAY8" (byval buffer as XdmcpBufferPtr, byval array as ARRAY8Ptr) as integer
declare function XdmcpReadARRAYofARRAY8 cdecl alias "XdmcpReadARRAYofARRAY8" (byval buffer as XdmcpBufferPtr, byval array as ARRAYofARRAY8Ptr) as integer
declare function XdmcpReadCARD16 cdecl alias "XdmcpReadCARD16" (byval buffer as XdmcpBufferPtr, byval valuep as CARD16Ptr) as integer
declare function XdmcpReadCARD32 cdecl alias "XdmcpReadCARD32" (byval buffer as XdmcpBufferPtr, byval valuep as CARD32Ptr) as integer
declare function XdmcpReadCARD8 cdecl alias "XdmcpReadCARD8" (byval buffer as XdmcpBufferPtr, byval valuep as CARD8Ptr) as integer
declare function XdmcpReadHeader cdecl alias "XdmcpReadHeader" (byval buffer as XdmcpBufferPtr, byval header as XdmcpHeaderPtr) as integer
declare function XdmcpFill cdecl alias "XdmcpFill" (byval fd as integer, byval buffer as XdmcpBufferPtr, byval from as XdmcpNetaddr, byval fromlen as integer ptr) as integer
declare function XdmcpReadRemaining cdecl alias "XdmcpReadRemaining" (byval buffer as XdmcpBufferPtr) as integer
declare sub XdmcpDisposeARRAY8 cdecl alias "XdmcpDisposeARRAY8" (byval array as ARRAY8Ptr)
declare sub XdmcpDisposeARRAY16 cdecl alias "XdmcpDisposeARRAY16" (byval array as ARRAY16Ptr)
declare sub XdmcpDisposeARRAY32 cdecl alias "XdmcpDisposeARRAY32" (byval array as ARRAY32Ptr)
declare sub XdmcpDisposeARRAYofARRAY8 cdecl alias "XdmcpDisposeARRAYofARRAY8" (byval array as ARRAYofARRAY8Ptr)
declare function XdmcpCopyARRAY8 cdecl alias "XdmcpCopyARRAY8" (byval src as ARRAY8Ptr, byval dst as ARRAY8Ptr) as integer
declare function XdmcpARRAY8Equal cdecl alias "XdmcpARRAY8Equal" (byval array1 as ARRAY8Ptr, byval array2 as ARRAY8Ptr) as integer
declare sub XdmcpGenerateKey cdecl alias "XdmcpGenerateKey" (byval key as XdmAuthKeyPtr)
declare sub XdmcpIncrementKey cdecl alias "XdmcpIncrementKey" (byval key as XdmAuthKeyPtr)
declare sub XdmcpDecrementKey cdecl alias "XdmcpDecrementKey" (byval key as XdmAuthKeyPtr)

#define TRUE 1
#define FALSE 0

declare function Xalloc cdecl alias "Xalloc" (byval amount as uinteger) as any ptr
declare function Xrealloc cdecl alias "Xrealloc" (byval old as any ptr, byval amount as uinteger) as any ptr
declare sub Xfree cdecl alias "Xfree" (byval old as any ptr)
declare function XdmcpCompareKeys cdecl alias "XdmcpCompareKeys" (byval a as XdmAuthKeyPtr, byval b as XdmAuthKeyPtr) as integer
declare function XdmcpAllocARRAY16 cdecl alias "XdmcpAllocARRAY16" (byval array as ARRAY16Ptr, byval length as integer) as integer
declare function XdmcpAllocARRAY32 cdecl alias "XdmcpAllocARRAY32" (byval array as ARRAY32Ptr, byval length as integer) as integer
declare function XdmcpAllocARRAY8 cdecl alias "XdmcpAllocARRAY8" (byval array as ARRAY8Ptr, byval length as integer) as integer
declare function XdmcpAllocARRAYofARRAY8 cdecl alias "XdmcpAllocARRAYofARRAY8" (byval array as ARRAYofARRAY8Ptr, byval length as integer) as integer
declare function XdmcpReallocARRAY16 cdecl alias "XdmcpReallocARRAY16" (byval array as ARRAY16Ptr, byval length as integer) as integer
declare function XdmcpReallocARRAY32 cdecl alias "XdmcpReallocARRAY32" (byval array as ARRAY32Ptr, byval length as integer) as integer
declare function XdmcpReallocARRAY8 cdecl alias "XdmcpReallocARRAY8" (byval array as ARRAY8Ptr, byval length as integer) as integer
declare function XdmcpReallocARRAYofARRAY8 cdecl alias "XdmcpReallocARRAYofARRAY8" (byval array as ARRAYofARRAY8Ptr, byval length as integer) as integer

#endif
