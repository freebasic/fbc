''
''
'' EditresP -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __EditresP_bi__
#define __EditresP_bi__

#define XER_NBBY 8
#define BYTE_MASK 255
#define HEADER_SIZE 6
#define EDITRES_IS_OBJECT 2
#define EDITRES_IS_UNREALIZED 0
#define EDITRES_FORMAT 8
#define EDITRES_SEND_EVENT_FORMAT 32
#define EDITRES_NAME "Editres"
#define EDITRES_COMMAND_ATOM "EditresCommand"
#define EDITRES_COMM_ATOM "EditresComm"
#define EDITRES_CLIENT_VALUE "EditresClientVal"
#define EDITRES_PROTOCOL_ATOM "EditresProtocol"

enum EditresCommand
	SendWidgetTree = 0
	SetValues = 1
	GetResources = 2
	GetGeometry = 3
	FindChild = 4
	GetValues = 5
end enum


enum ResourceType
	NormalResource = 0
	ConstraintResource = 1
end enum

type ResIdent as ubyte

enum EditResError
	PartialSuccess = 0
	Failure = 1
	ProtocolMismatch = 2
end enum


type _WidgetInfo
	num_widgets as ushort
	ids as uinteger ptr
	real_widget as Widget
end type

type WidgetInfo as _WidgetInfo

type _ProtocolStream
	size as uinteger
	alloc as uinteger
	real_top as ubyte ptr
	top as ubyte ptr
	current as ubyte ptr
end type

type ProtocolStream as _ProtocolStream

declare sub _XEditResPut8 cdecl alias "_XEditResPut8" (byval stream as ProtocolStream ptr, byval value as uinteger)
declare sub _XEditResPut16 cdecl alias "_XEditResPut16" (byval stream as ProtocolStream ptr, byval value as uinteger)
declare sub _XEditResPut32 cdecl alias "_XEditResPut32" (byval stream as ProtocolStream ptr, byval value as uinteger)
declare sub _XEditResPutWidgetInfo cdecl alias "_XEditResPutWidgetInfo" (byval stream as ProtocolStream ptr, byval info as WidgetInfo ptr)
declare sub _XEditResResetStream cdecl alias "_XEditResResetStream" (byval stream as ProtocolStream ptr)
declare function _XEditResGet8 cdecl alias "_XEditResGet8" (byval stream as ProtocolStream ptr, byval value as ubyte ptr) as Bool
declare function _XEditResGet16 cdecl alias "_XEditResGet16" (byval stream as ProtocolStream ptr, byval value as ushort ptr) as Bool
declare function _XEditResGetSigned16 cdecl alias "_XEditResGetSigned16" (byval stream as ProtocolStream ptr, byval value as short ptr) as Bool
declare function _XEditResGet32 cdecl alias "_XEditResGet32" (byval stream as ProtocolStream ptr, byval value as uinteger ptr) as Bool
declare function _XEditResGetString8 cdecl alias "_XEditResGetString8" (byval stream as ProtocolStream ptr, byval str as byte ptr ptr) as Bool
declare function _XEditResGetWidgetInfo cdecl alias "_XEditResGetWidgetInfo" (byval stream as ProtocolStream ptr, byval info as WidgetInfo ptr) as Bool

#endif
