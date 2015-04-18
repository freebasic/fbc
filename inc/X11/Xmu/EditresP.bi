'' FreeBASIC binding for libXmu-1.1.2
''
'' based on the C header files:
''
''   Copyright 1989, 1998  The Open Group
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
#include once "X11/Intrinsic.bi"
#include once "X11/Xfuncproto.bi"

extern "C"

const XER_NBBY = 8
const BYTE_MASK = 255
const HEADER_SIZE = 6
const EDITRES_IS_OBJECT = 2
const EDITRES_IS_UNREALIZED = 0
const EDITRES_FORMAT = 8
const EDITRES_SEND_EVENT_FORMAT = 32
#define EDITRES_NAME "Editres"
#define EDITRES_COMMAND_ATOM "EditresCommand"
#define EDITRES_COMM_ATOM "EditresComm"
#define EDITRES_CLIENT_VALUE "EditresClientVal"
#define EDITRES_PROTOCOL_ATOM "EditresProtocol"

type EditresCommand as long
enum
	SendWidgetTree = 0
	SetValues = 1
	GetResources = 2
	GetGeometry = 3
	FindChild = 4
	GetValues = 5
end enum

type ResourceType as long
enum
	NormalResource = 0
	ConstraintResource = 1
end enum

type ResIdent as ubyte

type EditResError as long
enum
	PartialSuccess = 0
	Failure = 1
	ProtocolMismatch = 2
end enum

type _WidgetInfo
	num_widgets as ushort
	ids as culong ptr
	real_widget as Widget
end type

type WidgetInfo as _WidgetInfo

type _ProtocolStream
	size as culong
	alloc as culong
	real_top as ubyte ptr
	top as ubyte ptr
	current as ubyte ptr
end type

type ProtocolStream as _ProtocolStream
declare sub _XEditResPutString8(byval stream as ProtocolStream ptr, byval str as const zstring ptr)
declare sub _XEditResPut8(byval stream as ProtocolStream ptr, byval value as ulong)
declare sub _XEditResPut16(byval stream as ProtocolStream ptr, byval value as ulong)
declare sub _XEditResPut32(byval stream as ProtocolStream ptr, byval value as culong)
declare sub _XEditResPutWidgetInfo(byval stream as ProtocolStream ptr, byval info as WidgetInfo ptr)
declare sub _XEditResResetStream(byval stream as ProtocolStream ptr)
declare function _XEditResGet8(byval stream as ProtocolStream ptr, byval value as ubyte ptr) as long
declare function _XEditResGet16(byval stream as ProtocolStream ptr, byval value as ushort ptr) as long
declare function _XEditResGetSigned16(byval stream as ProtocolStream ptr, byval value as short ptr) as long
declare function _XEditResGet32(byval stream as ProtocolStream ptr, byval value as culong ptr) as long
declare function _XEditResGetString8(byval stream as ProtocolStream ptr, byval str as zstring ptr ptr) as long
declare function _XEditResGetWidgetInfo(byval stream as ProtocolStream ptr, byval info as WidgetInfo ptr) as long

end extern
