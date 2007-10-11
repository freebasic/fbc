''
''
'' rpcndr -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_rpcndr_bi__
#define __win_rpcndr_bi__

#define __RPCNDR_H_VERSION__ (450)

#include once "win/rpcnsip.bi"
#include once "win/objfwd.bi"

#define cbNDRContext 20

type MIDL_STUB_MESSAGE_ as MIDL_STUB_MESSAGE

type NDR_CCONTEXT as any ptr

type NDR_SCONTEXT
	pad(0 to 2-1) as any ptr
	userContext as any ptr
end type

type NDR_RUNDOWN as sub (byval as any ptr)

type SCONTEXT_QUEUE
	NumberOfObjects as uinteger
	ArrayOfObjects as NDR_SCONTEXT ptr
end type

type PSCONTEXT_QUEUE as SCONTEXT_QUEUE ptr
type RPC_BUFPTR as ubyte ptr
type RPC_LENGTH as uinteger
type EXPR_EVAL as sub (byval as MIDL_STUB_MESSAGE_ ptr)
type PFORMAT_STRING as ubyte ptr

type ARRAY_INFO
	Dimension as integer
	BufferConformanceMark as uinteger ptr
	BufferVarianceMark as uinteger ptr
	MaxCountArray as uinteger ptr
	OffsetArray as uinteger ptr
	ActualCountArray as uinteger ptr
end type

type PARRAY_INFO as ARRAY_INFO ptr

declare function NDRCContextBinding alias "NDRCContextBinding" (byval as NDR_CCONTEXT) as RPC_BINDING_HANDLE
declare sub NDRCContextMarshall alias "NDRCContextMarshall" (byval as NDR_CCONTEXT, byval as any ptr)
declare sub NDRCContextUnmarshall alias "NDRCContextUnmarshall" (byval as NDR_CCONTEXT ptr, byval as RPC_BINDING_HANDLE, byval as any ptr, byval as uinteger)
declare sub NDRSContextMarshall alias "NDRSContextMarshall" (byval as NDR_SCONTEXT, byval as any ptr, byval as NDR_RUNDOWN)
declare function NDRSContextUnmarshall alias "NDRSContextUnmarshall" (byval pBuff as any ptr, byval as uinteger) as NDR_SCONTEXT
declare sub RpcSsDestroyClientContext alias "RpcSsDestroyClientContext" (byval as any ptr ptr)
declare sub NDRcopy alias "NDRcopy" (byval as any ptr, byval as any ptr, byval as uinteger)
declare function MIDL_wchar_strlen alias "MIDL_wchar_strlen" (byval as wchar_t ptr) as uinteger
declare sub MIDL_wchar_strcpy alias "MIDL_wchar_strcpy" (byval as any ptr, byval as wchar_t ptr)
declare sub char_from_ndr alias "char_from_ndr" (byval as PRPC_MESSAGE, byval as ubyte ptr)
declare sub char_array_from_ndr alias "char_array_from_ndr" (byval as PRPC_MESSAGE, byval as uinteger, byval as uinteger, byval as ubyte ptr)
declare sub short_from_ndr alias "short_from_ndr" (byval as PRPC_MESSAGE, byval as ushort ptr)
declare sub short_array_from_ndr alias "short_array_from_ndr" (byval as PRPC_MESSAGE, byval as uinteger, byval as uinteger, byval as ushort ptr)
declare sub short_from_ndr_temp alias "short_from_ndr_temp" (byval as ubyte ptr ptr, byval as ushort ptr, byval as uinteger)
declare sub long_from_ndr alias "long_from_ndr" (byval as PRPC_MESSAGE, byval as uinteger ptr)
declare sub long_array_from_ndr alias "long_array_from_ndr" (byval as PRPC_MESSAGE, byval as uinteger, byval as uinteger, byval as uinteger ptr)
declare sub long_from_ndr_temp alias "long_from_ndr_temp" (byval as ubyte ptr ptr, byval as uinteger ptr, byval as uinteger)
declare sub enum_from_ndr alias "enum_from_ndr" (byval as PRPC_MESSAGE, byval as uinteger ptr)
declare sub float_from_ndr alias "float_from_ndr" (byval as PRPC_MESSAGE, byval as any ptr)
declare sub float_array_from_ndr alias "float_array_from_ndr" (byval as PRPC_MESSAGE, byval as uinteger, byval as uinteger, byval as any ptr)
declare sub double_from_ndr alias "double_from_ndr" (byval as PRPC_MESSAGE, byval as any ptr)
declare sub double_array_from_ndr alias "double_array_from_ndr" (byval as PRPC_MESSAGE, byval as uinteger, byval as uinteger, byval as any ptr)
declare sub hyper_from_ndr alias "hyper_from_ndr" (byval as PRPC_MESSAGE, byval as longint ptr)
declare sub hyper_array_from_ndr alias "hyper_array_from_ndr" (byval as PRPC_MESSAGE, byval as uinteger, byval as uinteger, byval as longint ptr)
declare sub hyper_from_ndr_temp alias "hyper_from_ndr_temp" (byval as ubyte ptr ptr, byval as longint ptr, byval as uinteger)
declare sub data_from_ndr alias "data_from_ndr" (byval as PRPC_MESSAGE, byval as any ptr, byval as zstring ptr, byval as ubyte)
declare sub data_into_ndr alias "data_into_ndr" (byval as any ptr, byval as PRPC_MESSAGE, byval as zstring ptr, byval as ubyte)
declare sub tree_into_ndr alias "tree_into_ndr" (byval as any ptr, byval as PRPC_MESSAGE, byval as zstring ptr, byval as ubyte)
declare sub data_size_ndr alias "data_size_ndr" (byval as any ptr, byval as PRPC_MESSAGE, byval as zstring ptr, byval as ubyte)
declare sub tree_size_ndr alias "tree_size_ndr" (byval as any ptr, byval as PRPC_MESSAGE, byval as zstring ptr, byval as ubyte)
declare sub tree_peek_ndr alias "tree_peek_ndr" (byval as PRPC_MESSAGE, byval as ubyte ptr ptr, byval as zstring ptr, byval as ubyte)
declare function midl_allocate alias "midl_allocate" (byval as integer) as any ptr

type MIDL_STUB_DESC_ as MIDL_STUB_DESC
type FULL_PTR_XLAT_TABLES_ as FULL_PTR_XLAT_TABLES

type MIDL_STUB_MESSAGE
	RpcMsg as PRPC_MESSAGE
	Buffer as ubyte ptr
	BufferStart as ubyte ptr
	BufferEnd as ubyte ptr
	BufferMark as ubyte ptr
	BufferLength as uinteger
	MemorySize as uinteger
	Memory as ubyte ptr
	IsClient as integer
	ReuseBuffer as integer
	AllocAllNodesMemory as ubyte ptr
	AllocAllNodesMemoryEnd as ubyte ptr
	IgnoreEmbeddedPointers as integer
	PointerBufferMark as ubyte ptr
	fBufferValid as ubyte
	Unused as ubyte
	MaxCount as uinteger
	Offset as uinteger
	ActualCount as uinteger
	pfnAllocate as sub (byval as uinteger)
	pfnFree as sub (byval as any ptr)
	StackTop as ubyte ptr
	pPresentedType as ubyte ptr
	pTransmitType as ubyte ptr
	SavedHandle as handle_t
	StubDesc as MIDL_STUB_DESC_ ptr
	FullPtrXlatTables as FULL_PTR_XLAT_TABLES_ ptr
	FullPtrRefId as uinteger
	fCheckBounds as integer
	fInDontFree:1 as integer
	fDontCallFreeInst:1 as integer
	fInOnlyParam:1 as integer
	fHasReturn:1 as integer
	dwDestContext as uinteger
	pvDestContext as any ptr
	SavedContextHandles as NDR_SCONTEXT ptr
	ParamNumber as integer
	pRpcChannelBuffer as LPRPCCHANNELBUFFER
	pArrayInfo as PARRAY_INFO
	SizePtrCountArray as uinteger ptr
	SizePtrOffsetArray as uinteger ptr
	SizePtrLengthArray as uinteger ptr
	pArgQueue as any ptr
	dwStubPhase as uinteger
	w2kReserved(0 to 5-1) as uinteger
end type

type PMIDL_STUB_MESSAGE as MIDL_STUB_MESSAGE ptr
type GENERIC_BINDING_ROUTINE as sub (byval as any ptr)
type GENERIC_UNBIND_ROUTINE as sub (byval as any ptr, byval as ubyte ptr)

type GENERIC_BINDING_ROUTINE_PAIR
	pfnBind as GENERIC_BINDING_ROUTINE
	pfnUnbind as GENERIC_UNBIND_ROUTINE
end type

type PGENERIC_BINDING_ROUTINE_PAIR as GENERIC_BINDING_ROUTINE_PAIR ptr

type GENERIC_BINDING_INFO
	pObj as any ptr
	Size as uinteger
	pfnBind as GENERIC_BINDING_ROUTINE
	pfnUnbind as GENERIC_UNBIND_ROUTINE
end type

type PGENERIC_BINDING_INFO as GENERIC_BINDING_INFO ptr
type XMIT_HELPER_ROUTINE as sub (byval as PMIDL_STUB_MESSAGE)

type XMIT_ROUTINE_QUINTUPLE
	pfnTranslateToXmit as XMIT_HELPER_ROUTINE
	pfnTranslateFromXmit as XMIT_HELPER_ROUTINE
	pfnFreeXmit as XMIT_HELPER_ROUTINE
	pfnFreeInst as XMIT_HELPER_ROUTINE
end type

type PXMIT_ROUTINE_QUINTUPLE as XMIT_ROUTINE_QUINTUPLE ptr

type MALLOC_FREE_STRUCT
	pfnAllocate as sub (byval as uinteger)
	pfnFree as sub (byval as any ptr)
end type

type COMM_FAULT_OFFSETS
	CommOffset as short
	FaultOffset as short
end type

union MIDL_STUB_DESC_IMPLICIT_HANDLE_INFO
	pAutoHandle as handle_t ptr
	pPrimitiveHandle as handle_t ptr
	pGenericBindingInfo as PGENERIC_BINDING_INFO
end union

type USER_MARSHAL_SIZING_ROUTINE as function(byval as uinteger ptr, byval as uinteger, byval as any ptr) as uinteger
type USER_MARSHAL_MARSHALLING_ROUTINE as function(byval as uinteger ptr, byval as ubyte ptr, byval as any ptr) as ubyte ptr
type USER_MARSHAL_UNMARSHALLING_ROUTINE as function(byval as uinteger ptr, byval as ubyte ptr, byval as any ptr) as ubyte ptr
type USER_MARSHAL_FREEING_ROUTINE as sub(byval as uinteger ptr, byval as any ptr)

type USER_MARSHAL_ROUTINE_QUADRUPLE
	pfnBufferSize as USER_MARSHAL_SIZING_ROUTINE
	pfnMarshall as USER_MARSHAL_MARSHALLING_ROUTINE
	pfnUnmarshall as USER_MARSHAL_UNMARSHALLING_ROUTINE
	pfnFree as USER_MARSHAL_FREEING_ROUTINE
end type

type NDR_NOTIFY_ROUTINE as sub()

enum IDL_CS_CONVERT
	IDL_CS_NO_CONVERT
	IDL_CS_IN_PLACE_CONVERT
	IDL_CS_NEW_BUFFER_CONVERT
end enum

type CS_TYPE_NET_SIZE_ROUTINE as sub(byval as RPC_BINDING_HANDLE, byval as uinteger, byval as uinteger, byval as IDL_CS_CONVERT ptr, byval as uinteger ptr, byval as error_status_t ptr)
type CS_TYPE_LOCAL_SIZE_ROUTINE as sub(byval as RPC_BINDING_HANDLE, byval as uinteger, byval as uinteger, byval as IDL_CS_CONVERT ptr, byval as uinteger ptr, byval as error_status_t ptr)
type CS_TYPE_TO_NETCS_ROUTINE as sub(byval as RPC_BINDING_HANDLE, byval as uinteger, byval as any ptr, byval as uinteger, byval as byte ptr, byval as uinteger ptr, byval as error_status_t ptr)
type CS_TYPE_FROM_NETCS_ROUTINE as sub(byval as RPC_BINDING_HANDLE, byval as uinteger, byval as byte ptr, byval as uinteger, byval as uinteger, byval as any ptr, byval as uinteger ptr, byval as error_status_t ptr)
type CS_TAG_GETTING_ROUTINE as sub(byval as RPC_BINDING_HANDLE, byval as integer, byval as uinteger ptr, byval as uinteger ptr, byval as uinteger ptr, byval as error_status_t ptr)

type NDR_CS_SIZE_CONVERT_ROUTINES
	pfnNetSize as CS_TYPE_NET_SIZE_ROUTINE
	pfnToNetCs as CS_TYPE_TO_NETCS_ROUTINE
	pfnLocalSize as CS_TYPE_LOCAL_SIZE_ROUTINE
	pfnFromNetCs as CS_TYPE_FROM_NETCS_ROUTINE
end type

type NDR_CS_ROUTINES
	pSizeConvertRoutines as NDR_CS_SIZE_CONVERT_ROUTINES ptr
	pTagGettingRoutines as CS_TAG_GETTING_ROUTINE ptr
end type


type MIDL_STUB_DESC
	RpcInterfaceInformation as any ptr
	pfnAllocate as sub (byval as uinteger)
	pfnFree as sub (byval as any ptr)
	IMPLICIT_HANDLE_INFO as MIDL_STUB_DESC_IMPLICIT_HANDLE_INFO
	apfnNdrRundownRoutines as NDR_RUNDOWN ptr
	aGenericBindingRoutinePairs as GENERIC_BINDING_ROUTINE_PAIR ptr
	apfnExprEval as EXPR_EVAL ptr
	aXmitQuintuple as XMIT_ROUTINE_QUINTUPLE ptr
	pFormatTypes as ubyte ptr
	fCheckBounds as integer
	Version as uinteger
	pMallocFreeStruct as MALLOC_FREE_STRUCT ptr
	MIDLVersion as integer
	CommFaultOffsets as COMM_FAULT_OFFSETS ptr
	aUserMarshalQuadruple as USER_MARSHAL_ROUTINE_QUADRUPLE ptr
	NotifyRoutineTable as NDR_NOTIFY_ROUTINE ptr
	mFlags as ULONG_PTR
	CsRoutineTables as NDR_CS_ROUTINES ptr
	Reserved4 as any ptr
	Reserved5 as ULONG_PTR
end type

type PMIDL_STUB_DESC as MIDL_STUB_DESC ptr
type PMIDL_XMIT_TYPE as any ptr

type MIDL_FORMAT_STRING
	Pad as short
	Format(0 to 1-1) as ubyte
end type

type STUB_THUNK as sub (byval as PMIDL_STUB_MESSAGE)
type SERVER_ROUTINE as function () as integer

type MIDL_SERVER_INFO_
	pStubDesc as PMIDL_STUB_DESC
	DispatchTable as SERVER_ROUTINE ptr
	ProcString as PFORMAT_STRING
	FmtStringOffset as ushort ptr
	ThunkTable as STUB_THUNK ptr
end type

type PMIDL_SERVER_INFO as MIDL_SERVER_INFO_ ptr

type MIDL_STUBLESS_PROXY_INFO
	pStubDesc as PMIDL_STUB_DESC
	ProcFormatString as PFORMAT_STRING
	FormatStringOffset as ushort ptr
end type

type PMIDL_STUBLESS_PROXY_INFO as MIDL_STUBLESS_PROXY_INFO ptr

union CLIENT_CALL_RETURN
	Pointer as any ptr
	Simple as integer
end union

enum XLAT_SIDE
	XLAT_SERVER = 1
	XLAT_CLIENT
end enum

type FULL_PTR_TO_REFID_ELEMENT
	Next as FULL_PTR_TO_REFID_ELEMENT ptr
	Pointer as any ptr
	RefId as uinteger
	State as ubyte
end type

type PFULL_PTR_TO_REFID_ELEMENT as FULL_PTR_TO_REFID_ELEMENT ptr

type FULL_PTR_XLAT_TABLES_PointerToRefId
	XlatTable as PFULL_PTR_TO_REFID_ELEMENT ptr
	NumberOfBuckets as uinteger
	HashMask as uinteger
end type

type FULL_PTR_XLAT_TABLES_RefIdToPointer
	XlatTable as any ptr ptr
	StateTable as ubyte ptr
	NumberOfEntries as uinteger
end type

type FULL_PTR_XLAT_TABLES
	RefIdToPointer as FULL_PTR_XLAT_TABLES_RefIdToPointer
	PointerToRefId as FULL_PTR_XLAT_TABLES_PointerToRefId
	NextRefId as uinteger
	XlatSide as XLAT_SIDE
end type

type PFULL_PTR_XLAT_TABLES as FULL_PTR_XLAT_TABLES ptr

declare sub NdrSimpleTypeMarshall alias "NdrSimpleTypeMarshall" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr, byval as ubyte)
declare function NdrPointerMarshall alias "NdrPointerMarshall" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr, byval pFormat as PFORMAT_STRING) as ubyte ptr
declare function NdrSimpleStructMarshall alias "NdrSimpleStructMarshall" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr, byval as PFORMAT_STRING) as ubyte ptr
declare function NdrConformantStructMarshall alias "NdrConformantStructMarshall" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr, byval as PFORMAT_STRING) as ubyte ptr
declare function NdrConformantVaryingStructMarshall alias "NdrConformantVaryingStructMarshall" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr, byval as PFORMAT_STRING) as ubyte ptr
declare function NdrHardStructMarshall alias "NdrHardStructMarshall" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr, byval as PFORMAT_STRING) as ubyte ptr
declare function NdrComplexStructMarshall alias "NdrComplexStructMarshall" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr, byval as PFORMAT_STRING) as ubyte ptr
declare function NdrFixedArrayMarshall alias "NdrFixedArrayMarshall" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr, byval as PFORMAT_STRING) as ubyte ptr
declare function NdrConformantArrayMarshall alias "NdrConformantArrayMarshall" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr, byval as PFORMAT_STRING) as ubyte ptr
declare function NdrConformantVaryingArrayMarshall alias "NdrConformantVaryingArrayMarshall" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr, byval as PFORMAT_STRING) as ubyte ptr
declare function NdrVaryingArrayMarshall alias "NdrVaryingArrayMarshall" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr, byval as PFORMAT_STRING) as ubyte ptr
declare function NdrComplexArrayMarshall alias "NdrComplexArrayMarshall" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr, byval as PFORMAT_STRING) as ubyte ptr
declare function NdrNonConformantStringMarshall alias "NdrNonConformantStringMarshall" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr, byval as PFORMAT_STRING) as ubyte ptr
declare function NdrConformantStringMarshall alias "NdrConformantStringMarshall" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr, byval as PFORMAT_STRING) as ubyte ptr
declare function NdrEncapsulatedUnionMarshall alias "NdrEncapsulatedUnionMarshall" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr, byval as PFORMAT_STRING) as ubyte ptr
declare function NdrNonEncapsulatedUnionMarshall alias "NdrNonEncapsulatedUnionMarshall" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr, byval as PFORMAT_STRING) as ubyte ptr
declare function NdrByteCountPointerMarshall alias "NdrByteCountPointerMarshall" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr, byval as PFORMAT_STRING) as ubyte ptr
declare function NdrXmitOrRepAsMarshall alias "NdrXmitOrRepAsMarshall" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr, byval as PFORMAT_STRING) as ubyte ptr
declare function NdrInterfacePointerMarshall alias "NdrInterfacePointerMarshall" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr, byval as PFORMAT_STRING) as ubyte ptr
declare sub NdrClientContextMarshall alias "NdrClientContextMarshall" (byval as PMIDL_STUB_MESSAGE, byval as NDR_CCONTEXT, byval as integer)
declare sub NdrServerContextMarshall alias "NdrServerContextMarshall" (byval as PMIDL_STUB_MESSAGE, byval as NDR_SCONTEXT, byval as NDR_RUNDOWN)
declare sub NdrSimpleTypeUnmarshall alias "NdrSimpleTypeUnmarshall" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr, byval as ubyte)
declare function NdrPointerUnmarshall alias "NdrPointerUnmarshall" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr ptr, byval as PFORMAT_STRING, byval as ubyte) as ubyte ptr
declare function NdrSimpleStructUnmarshall alias "NdrSimpleStructUnmarshall" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr ptr, byval as PFORMAT_STRING, byval as ubyte) as ubyte ptr
declare function NdrConformantStructUnmarshall alias "NdrConformantStructUnmarshall" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr ptr, byval as PFORMAT_STRING, byval as ubyte) as ubyte ptr
declare function NdrConformantVaryingStructUnmarshall alias "NdrConformantVaryingStructUnmarshall" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr ptr, byval as PFORMAT_STRING, byval as ubyte) as ubyte ptr
declare function NdrHardStructUnmarshall alias "NdrHardStructUnmarshall" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr ptr, byval as PFORMAT_STRING, byval as ubyte) as ubyte ptr
declare function NdrComplexStructUnmarshall alias "NdrComplexStructUnmarshall" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr ptr, byval as PFORMAT_STRING, byval as ubyte) as ubyte ptr
declare function NdrFixedArrayUnmarshall alias "NdrFixedArrayUnmarshall" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr ptr, byval as PFORMAT_STRING, byval as ubyte) as ubyte ptr
declare function NdrConformantArrayUnmarshall alias "NdrConformantArrayUnmarshall" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr ptr, byval as PFORMAT_STRING, byval as ubyte) as ubyte ptr
declare function NdrConformantVaryingArrayUnmarshall alias "NdrConformantVaryingArrayUnmarshall" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr ptr, byval as PFORMAT_STRING, byval as ubyte) as ubyte ptr
declare function NdrVaryingArrayUnmarshall alias "NdrVaryingArrayUnmarshall" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr ptr, byval as PFORMAT_STRING, byval as ubyte) as ubyte ptr
declare function NdrComplexArrayUnmarshall alias "NdrComplexArrayUnmarshall" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr ptr, byval as PFORMAT_STRING, byval as ubyte) as ubyte ptr
declare function NdrNonConformantStringUnmarshall alias "NdrNonConformantStringUnmarshall" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr ptr, byval as PFORMAT_STRING, byval as ubyte) as ubyte ptr
declare function NdrConformantStringUnmarshall alias "NdrConformantStringUnmarshall" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr ptr, byval as PFORMAT_STRING, byval as ubyte) as ubyte ptr
declare function NdrEncapsulatedUnionUnmarshall alias "NdrEncapsulatedUnionUnmarshall" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr ptr, byval as PFORMAT_STRING, byval as ubyte) as ubyte ptr
declare function NdrNonEncapsulatedUnionUnmarshall alias "NdrNonEncapsulatedUnionUnmarshall" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr ptr, byval as PFORMAT_STRING, byval as ubyte) as ubyte ptr
declare function NdrByteCountPointerUnmarshall alias "NdrByteCountPointerUnmarshall" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr ptr, byval as PFORMAT_STRING, byval as ubyte) as ubyte ptr
declare function NdrXmitOrRepAsUnmarshall alias "NdrXmitOrRepAsUnmarshall" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr ptr, byval as PFORMAT_STRING, byval as ubyte) as ubyte ptr
declare function NdrInterfacePointerUnmarshall alias "NdrInterfacePointerUnmarshall" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr ptr, byval as PFORMAT_STRING, byval as ubyte) as ubyte ptr
declare sub NdrClientContextUnmarshall alias "NdrClientContextUnmarshall" (byval as PMIDL_STUB_MESSAGE, byval as NDR_CCONTEXT ptr, byval as RPC_BINDING_HANDLE)
declare function NdrServerContextUnmarshall alias "NdrServerContextUnmarshall" (byval as PMIDL_STUB_MESSAGE) as NDR_SCONTEXT
declare sub NdrPointerBufferSize alias "NdrPointerBufferSize" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr, byval as PFORMAT_STRING)
declare sub NdrSimpleStructBufferSize alias "NdrSimpleStructBufferSize" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr, byval as PFORMAT_STRING)
declare sub NdrConformantStructBufferSize alias "NdrConformantStructBufferSize" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr, byval as PFORMAT_STRING)
declare sub NdrConformantVaryingStructBufferSize alias "NdrConformantVaryingStructBufferSize" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr, byval as PFORMAT_STRING)
declare sub NdrHardStructBufferSize alias "NdrHardStructBufferSize" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr, byval as PFORMAT_STRING)
declare sub NdrComplexStructBufferSize alias "NdrComplexStructBufferSize" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr, byval as PFORMAT_STRING)
declare sub NdrFixedArrayBufferSize alias "NdrFixedArrayBufferSize" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr, byval as PFORMAT_STRING)
declare sub NdrConformantArrayBufferSize alias "NdrConformantArrayBufferSize" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr, byval as PFORMAT_STRING)
declare sub NdrConformantVaryingArrayBufferSize alias "NdrConformantVaryingArrayBufferSize" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr, byval as PFORMAT_STRING)
declare sub NdrVaryingArrayBufferSize alias "NdrVaryingArrayBufferSize" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr, byval as PFORMAT_STRING)
declare sub NdrComplexArrayBufferSize alias "NdrComplexArrayBufferSize" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr, byval as PFORMAT_STRING)
declare sub NdrConformantStringBufferSize alias "NdrConformantStringBufferSize" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr, byval as PFORMAT_STRING)
declare sub NdrNonConformantStringBufferSize alias "NdrNonConformantStringBufferSize" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr, byval as PFORMAT_STRING)
declare sub NdrEncapsulatedUnionBufferSize alias "NdrEncapsulatedUnionBufferSize" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr, byval as PFORMAT_STRING)
declare sub NdrNonEncapsulatedUnionBufferSize alias "NdrNonEncapsulatedUnionBufferSize" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr, byval as PFORMAT_STRING)
declare sub NdrByteCountPointerBufferSize alias "NdrByteCountPointerBufferSize" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr, byval as PFORMAT_STRING)
declare sub NdrXmitOrRepAsBufferSize alias "NdrXmitOrRepAsBufferSize" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr, byval as PFORMAT_STRING)
declare sub NdrInterfacePointerBufferSize alias "NdrInterfacePointerBufferSize" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr, byval as PFORMAT_STRING)
declare sub NdrContextHandleSize alias "NdrContextHandleSize" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr, byval as PFORMAT_STRING)
declare function NdrPointerMemorySize alias "NdrPointerMemorySize" (byval as PMIDL_STUB_MESSAGE, byval as PFORMAT_STRING) as uinteger
declare function NdrSimpleStructMemorySize alias "NdrSimpleStructMemorySize" (byval as PMIDL_STUB_MESSAGE, byval as PFORMAT_STRING) as uinteger
declare function NdrConformantStructMemorySize alias "NdrConformantStructMemorySize" (byval as PMIDL_STUB_MESSAGE, byval as PFORMAT_STRING) as uinteger
declare function NdrConformantVaryingStructMemorySize alias "NdrConformantVaryingStructMemorySize" (byval as PMIDL_STUB_MESSAGE, byval as PFORMAT_STRING) as uinteger
declare function NdrHardStructMemorySize alias "NdrHardStructMemorySize" (byval as PMIDL_STUB_MESSAGE, byval as PFORMAT_STRING) as uinteger
declare function NdrComplexStructMemorySize alias "NdrComplexStructMemorySize" (byval as PMIDL_STUB_MESSAGE, byval as PFORMAT_STRING) as uinteger
declare function NdrFixedArrayMemorySize alias "NdrFixedArrayMemorySize" (byval as PMIDL_STUB_MESSAGE, byval as PFORMAT_STRING) as uinteger
declare function NdrConformantArrayMemorySize alias "NdrConformantArrayMemorySize" (byval as PMIDL_STUB_MESSAGE, byval as PFORMAT_STRING) as uinteger
declare function NdrConformantVaryingArrayMemorySize alias "NdrConformantVaryingArrayMemorySize" (byval as PMIDL_STUB_MESSAGE, byval as PFORMAT_STRING) as uinteger
declare function NdrVaryingArrayMemorySize alias "NdrVaryingArrayMemorySize" (byval as PMIDL_STUB_MESSAGE, byval as PFORMAT_STRING) as uinteger
declare function NdrComplexArrayMemorySize alias "NdrComplexArrayMemorySize" (byval as PMIDL_STUB_MESSAGE, byval as PFORMAT_STRING) as uinteger
declare function NdrConformantStringMemorySize alias "NdrConformantStringMemorySize" (byval as PMIDL_STUB_MESSAGE, byval as PFORMAT_STRING) as uinteger
declare function NdrNonConformantStringMemorySize alias "NdrNonConformantStringMemorySize" (byval as PMIDL_STUB_MESSAGE, byval as PFORMAT_STRING) as uinteger
declare function NdrEncapsulatedUnionMemorySize alias "NdrEncapsulatedUnionMemorySize" (byval as PMIDL_STUB_MESSAGE, byval as PFORMAT_STRING) as uinteger
declare function NdrNonEncapsulatedUnionMemorySize alias "NdrNonEncapsulatedUnionMemorySize" (byval as PMIDL_STUB_MESSAGE, byval as PFORMAT_STRING) as uinteger
declare function NdrXmitOrRepAsMemorySize alias "NdrXmitOrRepAsMemorySize" (byval as PMIDL_STUB_MESSAGE, byval as PFORMAT_STRING) as uinteger
declare function NdrInterfacePointerMemorySize alias "NdrInterfacePointerMemorySize" (byval as PMIDL_STUB_MESSAGE, byval as PFORMAT_STRING) as uinteger
declare sub NdrPointerFree alias "NdrPointerFree" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr, byval as PFORMAT_STRING)
declare sub NdrSimpleStructFree alias "NdrSimpleStructFree" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr, byval as PFORMAT_STRING)
declare sub NdrConformantStructFree alias "NdrConformantStructFree" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr, byval as PFORMAT_STRING)
declare sub NdrConformantVaryingStructFree alias "NdrConformantVaryingStructFree" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr, byval as PFORMAT_STRING)
declare sub NdrHardStructFree alias "NdrHardStructFree" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr, byval as PFORMAT_STRING)
declare sub NdrComplexStructFree alias "NdrComplexStructFree" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr, byval as PFORMAT_STRING)
declare sub NdrFixedArrayFree alias "NdrFixedArrayFree" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr, byval as PFORMAT_STRING)
declare sub NdrConformantArrayFree alias "NdrConformantArrayFree" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr, byval as PFORMAT_STRING)
declare sub NdrConformantVaryingArrayFree alias "NdrConformantVaryingArrayFree" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr, byval as PFORMAT_STRING)
declare sub NdrVaryingArrayFree alias "NdrVaryingArrayFree" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr, byval as PFORMAT_STRING)
declare sub NdrComplexArrayFree alias "NdrComplexArrayFree" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr, byval as PFORMAT_STRING)
declare sub NdrEncapsulatedUnionFree alias "NdrEncapsulatedUnionFree" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr, byval as PFORMAT_STRING)
declare sub NdrNonEncapsulatedUnionFree alias "NdrNonEncapsulatedUnionFree" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr, byval as PFORMAT_STRING)
declare sub NdrByteCountPointerFree alias "NdrByteCountPointerFree" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr, byval as PFORMAT_STRING)
declare sub NdrXmitOrRepAsFree alias "NdrXmitOrRepAsFree" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr, byval as PFORMAT_STRING)
declare sub NdrInterfacePointerFree alias "NdrInterfacePointerFree" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr, byval as PFORMAT_STRING)
declare sub NdrConvert alias "NdrConvert" (byval as PMIDL_STUB_MESSAGE, byval as PFORMAT_STRING)
declare sub NdrClientInitializeNew alias "NdrClientInitializeNew" (byval as PRPC_MESSAGE, byval as PMIDL_STUB_MESSAGE, byval as PMIDL_STUB_DESC, byval as uinteger)
declare function NdrServerInitializeNew alias "NdrServerInitializeNew" (byval as PRPC_MESSAGE, byval as PMIDL_STUB_MESSAGE, byval as PMIDL_STUB_DESC) as ubyte ptr
declare sub NdrClientInitialize alias "NdrClientInitialize" (byval as PRPC_MESSAGE, byval as PMIDL_STUB_MESSAGE, byval as PMIDL_STUB_DESC, byval as uinteger)
declare function NdrServerInitialize alias "NdrServerInitialize" (byval as PRPC_MESSAGE, byval as PMIDL_STUB_MESSAGE, byval as PMIDL_STUB_DESC) as ubyte ptr
declare function NdrServerInitializeUnmarshall alias "NdrServerInitializeUnmarshall" (byval as PMIDL_STUB_MESSAGE, byval as PMIDL_STUB_DESC, byval as PRPC_MESSAGE) as ubyte ptr
declare sub NdrServerInitializeMarshall alias "NdrServerInitializeMarshall" (byval as PRPC_MESSAGE, byval as PMIDL_STUB_MESSAGE)
declare function NdrGetBuffer alias "NdrGetBuffer" (byval as PMIDL_STUB_MESSAGE, byval as uinteger, byval as RPC_BINDING_HANDLE) as ubyte ptr
declare function NdrNsGetBuffer alias "NdrNsGetBuffer" (byval as PMIDL_STUB_MESSAGE, byval as uinteger, byval as RPC_BINDING_HANDLE) as ubyte ptr
declare function NdrSendReceive alias "NdrSendReceive" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr) as ubyte ptr
declare function NdrNsSendReceive alias "NdrNsSendReceive" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr, byval as RPC_BINDING_HANDLE ptr) as ubyte ptr
declare sub NdrFreeBuffer alias "NdrFreeBuffer" (byval as PMIDL_STUB_MESSAGE)
declare function NdrClientCall cdecl alias "NdrClientCall" (byval as PMIDL_STUB_DESC, byval as PFORMAT_STRING, ...) as CLIENT_CALL_RETURN

enum STUB_PHASE
	STUB_UNMARSHAL
	STUB_CALL_SERVER
	STUB_MARSHAL
	STUB_CALL_SERVER_NO_HRESULT
end enum

enum PROXY_PHASE
	PROXY_CALCSIZE
	PROXY_GETBUFFER
	PROXY_MARSHAL
	PROXY_SENDRECEIVE
	PROXY_UNMARSHAL
end enum

declare function NdrStubCall alias "NdrStubCall" (byval as LPRPCSTUBBUFFER, byval as LPRPCCHANNELBUFFER, byval as PRPC_MESSAGE, byval as uinteger ptr) as integer
declare sub NdrServerCall alias "NdrServerCall" (byval as PRPC_MESSAGE)
declare function NdrServerUnmarshall alias "NdrServerUnmarshall" (byval as LPRPCCHANNELBUFFER, byval as PRPC_MESSAGE, byval as PMIDL_STUB_MESSAGE, byval as PMIDL_STUB_DESC, byval as PFORMAT_STRING, byval as any ptr) as integer
declare sub NdrServerMarshall alias "NdrServerMarshall" (byval as LPRPCSTUBBUFFER, byval as LPRPCCHANNELBUFFER, byval as PMIDL_STUB_MESSAGE, byval as PFORMAT_STRING)
declare function NdrMapCommAndFaultStatus alias "NdrMapCommAndFaultStatus" (byval as PMIDL_STUB_MESSAGE, byval as uinteger ptr, byval as uinteger ptr, byval as RPC_STATUS) as RPC_STATUS
declare function NdrSH_UPDecision alias "NdrSH_UPDecision" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr ptr, byval as RPC_BUFPTR) as integer
declare function NdrSH_TLUPDecision alias "NdrSH_TLUPDecision" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr ptr) as integer
declare function NdrSH_TLUPDecisionBuffer alias "NdrSH_TLUPDecisionBuffer" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr ptr) as integer
declare function NdrSH_IfAlloc alias "NdrSH_IfAlloc" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr ptr, byval as uinteger) as integer
declare function NdrSH_IfAllocRef alias "NdrSH_IfAllocRef" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr ptr, byval as uinteger) as integer
declare function NdrSH_IfAllocSet alias "NdrSH_IfAllocSet" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr ptr, byval as uinteger) as integer
declare function NdrSH_IfCopy alias "NdrSH_IfCopy" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr ptr, byval as uinteger) as RPC_BUFPTR
declare function NdrSH_IfAllocCopy alias "NdrSH_IfAllocCopy" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr ptr, byval as uinteger) as RPC_BUFPTR
declare function NdrSH_Copy alias "NdrSH_Copy" (byval as ubyte ptr, byval as ubyte ptr, byval as uinteger) as uinteger
declare sub NdrSH_IfFree alias "NdrSH_IfFree" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr)
declare function NdrSH_StringMarshall alias "NdrSH_StringMarshall" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr, byval as uinteger, byval as integer) as RPC_BUFPTR
declare function NdrSH_StringUnMarshall alias "NdrSH_StringUnMarshall" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr ptr, byval as integer) as RPC_BUFPTR

type RPC_SS_THREAD_HANDLE as any ptr
type RPC_CLIENT_ALLOC as any
type RPC_CLIENT_FREE as any

declare function RpcSsAllocate alias "RpcSsAllocate" (byval as uinteger) as any ptr
declare sub RpcSsDisableAllocate alias "RpcSsDisableAllocate" ()
declare sub RpcSsEnableAllocate alias "RpcSsEnableAllocate" ()
declare sub RpcSsFree alias "RpcSsFree" (byval as any ptr)
declare function RpcSsGetThreadHandle alias "RpcSsGetThreadHandle" () as RPC_SS_THREAD_HANDLE
declare sub RpcSsSetClientAllocFree alias "RpcSsSetClientAllocFree" (byval as RPC_CLIENT_ALLOC ptr, byval as RPC_CLIENT_FREE ptr)
declare sub RpcSsSetThreadHandle alias "RpcSsSetThreadHandle" (byval as RPC_SS_THREAD_HANDLE)
declare sub RpcSsSwapClientAllocFree alias "RpcSsSwapClientAllocFree" (byval as RPC_CLIENT_ALLOC ptr, byval as RPC_CLIENT_FREE ptr, byval as RPC_CLIENT_ALLOC ptr ptr, byval as RPC_CLIENT_FREE ptr ptr)
declare function RpcSmAllocate alias "RpcSmAllocate" (byval as uinteger, byval as RPC_STATUS ptr) as any ptr
declare function RpcSmClientFree alias "RpcSmClientFree" (byval as any ptr) as RPC_STATUS
declare function RpcSmDestroyClientContext alias "RpcSmDestroyClientContext" (byval as any ptr ptr) as RPC_STATUS
declare function RpcSmDisableAllocate alias "RpcSmDisableAllocate" () as RPC_STATUS
declare function RpcSmEnableAllocate alias "RpcSmEnableAllocate" () as RPC_STATUS
declare function RpcSmFree alias "RpcSmFree" (byval as any ptr) as RPC_STATUS
declare function RpcSmGetThreadHandle alias "RpcSmGetThreadHandle" (byval as RPC_STATUS ptr) as RPC_SS_THREAD_HANDLE
declare function RpcSmSetClientAllocFree alias "RpcSmSetClientAllocFree" (byval as RPC_CLIENT_ALLOC ptr, byval as RPC_CLIENT_FREE ptr) as RPC_STATUS
declare function RpcSmSetThreadHandle alias "RpcSmSetThreadHandle" (byval as RPC_SS_THREAD_HANDLE) as RPC_STATUS
declare function RpcSmSwapClientAllocFree alias "RpcSmSwapClientAllocFree" (byval as RPC_CLIENT_ALLOC ptr, byval as RPC_CLIENT_FREE ptr, byval as RPC_CLIENT_ALLOC ptr ptr, byval as RPC_CLIENT_FREE ptr ptr) as RPC_STATUS
declare sub NdrRpcSsEnableAllocate alias "NdrRpcSsEnableAllocate" (byval as PMIDL_STUB_MESSAGE)
declare sub NdrRpcSsDisableAllocate alias "NdrRpcSsDisableAllocate" (byval as PMIDL_STUB_MESSAGE)
declare sub NdrRpcSmSetClientToOsf alias "NdrRpcSmSetClientToOsf" (byval as PMIDL_STUB_MESSAGE)
declare function NdrRpcSmClientAllocate alias "NdrRpcSmClientAllocate" (byval as uinteger) as any ptr
declare sub NdrRpcSmClientFree alias "NdrRpcSmClientFree" (byval as any ptr)
declare function NdrRpcSsDefaultAllocate alias "NdrRpcSsDefaultAllocate" (byval as uinteger) as any ptr
declare sub NdrRpcSsDefaultFree alias "NdrRpcSsDefaultFree" (byval as any ptr)
declare function NdrFullPointerXlatInit alias "NdrFullPointerXlatInit" (byval as uinteger, byval as XLAT_SIDE) as PFULL_PTR_XLAT_TABLES
declare sub NdrFullPointerXlatFree alias "NdrFullPointerXlatFree" (byval as PFULL_PTR_XLAT_TABLES)
declare function NdrFullPointerQueryPointer alias "NdrFullPointerQueryPointer" (byval as PFULL_PTR_XLAT_TABLES, byval as any ptr, byval as ubyte, byval as uinteger ptr) as integer
declare function NdrFullPointerQueryRefId alias "NdrFullPointerQueryRefId" (byval as PFULL_PTR_XLAT_TABLES, byval as uinteger, byval as ubyte, byval as any ptr ptr) as integer
declare sub NdrFullPointerInsertRefId alias "NdrFullPointerInsertRefId" (byval as PFULL_PTR_XLAT_TABLES, byval as uinteger, byval as any ptr)
declare function NdrFullPointerFree alias "NdrFullPointerFree" (byval as PFULL_PTR_XLAT_TABLES, byval as any ptr) as integer
declare function NdrAllocate alias "NdrAllocate" (byval as PMIDL_STUB_MESSAGE, byval as uinteger) as any ptr
declare sub NdrClearOutParameters alias "NdrClearOutParameters" (byval as PMIDL_STUB_MESSAGE, byval as PFORMAT_STRING, byval as any ptr)
declare function NdrOleAllocate alias "NdrOleAllocate" (byval as uinteger) as any ptr
declare sub NdrOleFree alias "NdrOleFree" (byval as any ptr)
declare function NdrUserMarshalMarshall alias "NdrUserMarshalMarshall" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr, byval as PFORMAT_STRING) as ubyte ptr
declare function NdrUserMarshalUnmarshall alias "NdrUserMarshalUnmarshall" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr ptr, byval as PFORMAT_STRING, byval as ubyte) as ubyte ptr
declare sub NdrUserMarshalBufferSize alias "NdrUserMarshalBufferSize" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr, byval as PFORMAT_STRING)
declare function NdrUserMarshalMemorySize alias "NdrUserMarshalMemorySize" (byval as PMIDL_STUB_MESSAGE, byval as PFORMAT_STRING) as uinteger
declare sub NdrUserMarshalFree alias "NdrUserMarshalFree" (byval as PMIDL_STUB_MESSAGE, byval as ubyte ptr, byval as PFORMAT_STRING)

#endif
