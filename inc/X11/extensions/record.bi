'' FreeBASIC binding for libXtst-1.2.2
''
'' based on the C header files:
''   ************************************************************************
''    Copyright 1995 Network Computing Devices
''
''    Permission to use, copy, modify, distribute, and sell this software and
''    its documentation for any purpose is hereby granted without fee, provided
''    that the above copyright notice appear in all copies and that both that
''    copyright notice and this permission notice appear in supporting
''    documentation, and that the name of Network Computing Devices
''    not be used in advertising or publicity pertaining to distribution
''    of the software without specific, written prior permission.
''
''    NETWORK COMPUTING DEVICES DISCLAIMs ALL WARRANTIES WITH REGARD TO
''    THIS SOFTWARE, INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
''    AND FITNESS, IN NO EVENT SHALL NETWORK COMPUTING DEVICES BE LIABLE
''    FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
''    WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN
''    AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING
''    OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
''   ************************************************************************
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/long.bi"
#include once "X11/extensions/recordconst.bi"

extern "C"

#define _RECORD_H_
type XRecordClientSpec as culong
type XRecordContext as culong

type XRecordRange8
	first as ubyte
	last as ubyte
end type

type XRecordRange16
	first as ushort
	last as ushort
end type

type XRecordExtRange
	ext_major as XRecordRange8
	ext_minor as XRecordRange16
end type

type XRecordRange
	core_requests as XRecordRange8
	core_replies as XRecordRange8
	ext_requests as XRecordExtRange
	ext_replies as XRecordExtRange
	delivered_events as XRecordRange8
	device_events as XRecordRange8
	errors as XRecordRange8
	client_started as long
	client_died as long
end type

type XRecordClientInfo
	client as XRecordClientSpec
	nranges as culong
	ranges as XRecordRange ptr ptr
end type

type XRecordState
	enabled as long
	datum_flags as long
	nclients as culong
	client_info as XRecordClientInfo ptr ptr
end type

type XRecordInterceptData
	id_base as XID
	server_time as Time
	client_seq as culong
	category as long
	client_swapped as long
	data as ubyte ptr
	data_len as culong
end type

declare function XRecordIdBaseMask(byval dpy as Display ptr) as XID
declare function XRecordQueryVersion(byval as Display ptr, byval as long ptr, byval as long ptr) as long
declare function XRecordCreateContext(byval as Display ptr, byval as long, byval as XRecordClientSpec ptr, byval as long, byval as XRecordRange ptr ptr, byval as long) as XRecordContext
declare function XRecordAllocRange() as XRecordRange ptr
declare function XRecordRegisterClients(byval as Display ptr, byval as XRecordContext, byval as long, byval as XRecordClientSpec ptr, byval as long, byval as XRecordRange ptr ptr, byval as long) as long
declare function XRecordUnregisterClients(byval as Display ptr, byval as XRecordContext, byval as XRecordClientSpec ptr, byval as long) as long
declare function XRecordGetContext(byval as Display ptr, byval as XRecordContext, byval as XRecordState ptr ptr) as long
declare sub XRecordFreeState(byval as XRecordState ptr)
type XRecordInterceptProc as sub(byval as XPointer, byval as XRecordInterceptData ptr)
declare function XRecordEnableContext(byval as Display ptr, byval as XRecordContext, byval as XRecordInterceptProc, byval as XPointer) as long
declare function XRecordEnableContextAsync(byval as Display ptr, byval as XRecordContext, byval as XRecordInterceptProc, byval as XPointer) as long
declare sub XRecordProcessReplies(byval as Display ptr)
declare sub XRecordFreeData(byval as XRecordInterceptData ptr)
declare function XRecordDisableContext(byval as Display ptr, byval as XRecordContext) as long
declare function XRecordFreeContext(byval as Display ptr, byval as XRecordContext) as long

end extern
