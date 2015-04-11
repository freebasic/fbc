'' FreeBASIC binding for mingw-w64-v4.0.1

#pragma once

#include once "rpc.bi"
#include once "rpcndr.bi"
#include once "windows.bi"
#include once "ole2.bi"
#include once "oaidl.bi"
#include once "ocidl.bi"
#include once "winapifamily.bi"

extern "C"

#define __naptypes_h__
#define __INapTypes_INTERFACE_DEFINED__
extern INapTypes_v0_0_c_ifspec as RPC_IF_HANDLE
extern INapTypes_v0_0_s_ifspec as RPC_IF_HANDLE
const freshSoHRequest = &h1
const shaFixup = &h1
const percentageNotSupported = 101
const maxSoHAttributeCount = 100
const maxSoHAttributeSize = 4000
const minNetworkSoHSize = 12
const maxNetworkSoHSize = 4000
#define maxDwordCountPerSoHAttribute (maxSoHAttributeSize / sizeof(DWORD))
#define maxIpv4CountPerSoHAttribute (maxSoHAttributeSize / 4)
#define maxIpv6CountPerSoHAttribute (maxSoHAttributeSize / 16)
const maxStringLength = 1024
#define maxStringLengthInBytes ((maxStringLength + 1) * sizeof(wchar_t))
const maxSystemHealthEntityCount = 20
const maxEnforcerCount = 20
const maxPrivateDataSize = 200
const maxConnectionCountPerEnforcer = 20
#define maxCachedSoHCount ((maxSystemHealthEntityCount * maxEnforcerCount) * maxConnectionCountPerEnforcer)
const failureCategoryCount = 5
const ComponentTypeEnforcementClientSoH = &h1
const ComponentTypeEnforcementClientRp = &h2

type tagIsolationState as long
enum
	isolationStateNotRestricted = 1
	isolationStateInProbation = 2
	isolationStateRestrictedAccess = 3
end enum

type IsolationState as tagIsolationState

type tagExtendedIsolationState as long
enum
	extendedIsolationStateNoData = &h0
	extendedIsolationStateTransition = &h1
	extendedIsolationStateInfected = &h2
	extendedIsolationStateUnknown = &h3
end enum

type ExtendedIsolationState as tagExtendedIsolationState

type tagNapTracingLevel as long
enum
	tracingLevelUndefined = 0
	tracingLevelBasic = 1
	tracingLevelAdvanced = 2
	tracingLevelDebug = 3
end enum

type NapTracingLevel as tagNapTracingLevel

type tagFailureCategory as long
enum
	failureCategoryNone = 0
	failureCategoryOther = 1
	failureCategoryClientComponent = 2
	failureCategoryClientCommunication = 3
	failureCategoryServerComponent = 4
	failureCategoryServerCommunication = 5
end enum

type FailureCategory as tagFailureCategory

type tagFixupState as long
enum
	fixupStateSuccess = 0
	fixupStateInProgress = 1
	fixupStateCouldNotUpdate = 2
end enum

type FixupState as tagFixupState

type tagNapNotifyType as long
enum
	napNotifyTypeUnknown = 0
	napNotifyTypeServiceState = 1
	napNotifyTypeQuarState = 2
end enum

type NapNotifyType as tagNapNotifyType

type tagRemoteConfigurationType as long
enum
	remoteConfigTypeMachine = 1
	remoteConfigTypeConfigBlob = 2
end enum

type RemoteConfigurationType as tagRemoteConfigurationType
type ProbationTime as FILETIME
type MessageId as UINT32
type NapComponentId as UINT32
type SystemHealthEntityId as NapComponentId
type EnforcementEntityId as NapComponentId

type tagCountedString
	length as UINT16
	string as wstring ptr
end type

type CountedString as tagCountedString
type StringCorrelationId as CountedString

type tagIsolationInfo
	isolationState as IsolationState
	probEndTime as ProbationTime
	failureUrl as CountedString
end type

type IsolationInfo as tagIsolationInfo

type tagIsolationInfoEx
	isolationState as IsolationState
	extendedIsolationState as ExtendedIsolationState
	probEndTime as ProbationTime
	failureUrl as CountedString
end type

type IsolationInfoEx as tagIsolationInfoEx

type tagFailureCategoryMapping
	mappingCompliance(0 to 4) as WINBOOL
end type

type FailureCategoryMapping as tagFailureCategoryMapping
type SystemHealthEntityCount as UINT16
type EnforcementEntityCount as UINT16

type tagCorrelationId
	connId as GUID
	timeStamp as FILETIME
end type

type CorrelationId as tagCorrelationId
type ConnectionId as GUID
type Percentage as UINT8

type tagResultCodes
	count as UINT16
	results as HRESULT ptr
end type

type ResultCodes as tagResultCodes

type tagIpv4Address
	addr(0 to 3) as UBYTE
end type

type Ipv4Address as tagIpv4Address

type tagIpv6Address
	addr(0 to 15) as UBYTE
end type

type Ipv6Address as tagIpv6Address

type tagFixupInfo
	state as FixupState
	percentage as Percentage
	resultCodes as ResultCodes
	fixupMsgId as MessageId
end type

type FixupInfo as tagFixupInfo

type tagSystemHealthAgentState
	id as SystemHealthEntityId
	shaResultCodes as ResultCodes
	failureCategory as FailureCategory
	fixupInfo as FixupInfo
end type

type SystemHealthAgentState as tagSystemHealthAgentState

type tagSoHAttribute
	as UINT16 type
	size as UINT16
	value as UBYTE ptr
end type

type SoHAttribute as tagSoHAttribute

type tagSoH
	count as UINT16
	attributes as SoHAttribute ptr
end type

type SoH as tagSoH
type SoHRequest as tagSoH
type SoHResponse as tagSoH

type tagNetworkSoH
	size as UINT16
	data as UBYTE ptr
end type

type NetworkSoH as tagNetworkSoH
type NetworkSoHRequest as tagNetworkSoH
type NetworkSoHResponse as tagNetworkSoH

type tagPrivateData
	size as UINT16
	data as UBYTE ptr
end type

type PrivateData as tagPrivateData

type tagNapComponentRegistrationInfo
	id as NapComponentId
	friendlyName as CountedString
	description as CountedString
	version as CountedString
	vendorName as CountedString
	infoClsid as CLSID
	configClsid as CLSID
	registrationDate as FILETIME
	componentType as UINT32
end type

type NapComponentRegistrationInfo as tagNapComponentRegistrationInfo

end extern
