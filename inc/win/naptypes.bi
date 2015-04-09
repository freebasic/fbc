'' FreeBASIC binding for mingw-w64-v3.3.0

#pragma once

#define _INC_NAPTYPES

#if _WIN32_WINNT = &h0602
	const maxSoHAttributeCount = &h64
	const maxSoHAttributeSize = &hFA0
	const minNetworkSoHSize = &hC
	const maxNetworkSoHSize = &hFA0
	#define maxDwordCountPerSoHAttribute (maxSoHAttributeSize / sizeof(DWORD))
	#define maxIpv4CountPerSoHAttribute (maxSoHAttributeSize / &h4)
	#define maxIpv6CountPerSoHAttribute (maxSoHAttributeSize / &h10)
	const maxStringLength = &h400
	#define maxStringLengthInBytes ((maxStringLength + 1) * sizeof(wchar_t))
	const maxSystemHealthEntityCount = &h14
	const maxEnforcerCount = &h14
	const maxPrivateDataSize = &hC8
	const maxConnectionCountPerEnforcer = &h14
	#define maxCachedSoHCount ((maxSystemHealthEntityCount * maxEnforcerCount) * maxConnectionCountPerEnforcer)
	const freshSoHRequest = &h1
	const shaFixup = &h1
	const failureCategoryCount = &h5
	const ComponentTypeEnforcementClientSoH = &h1
	const ComponentTypeEnforcementClientRp = &h2
	#define NAPTypes

	type tagCountedString
		length as UINT16
		string as wstring ptr
	end type

	type CountedString as tagCountedString
	type ProbationTime as FILETIME
	type ProtocolMaxSize as UINT32
	type NapComponentId as UINT32
	type SystemHealthEntityId as NapComponentId
	type EnforcementEntityId as NapComponentId
	type SystemHealthEntityCount as UINT16
	type EnforcementEntityCount as UINT16
	type StringCorrelationId as CountedString
	type ConnectionId as GUID
	type Percentage as UINT8
	type MessageId as UINT32

	type tagFixupState as long
	enum
		fixupStateSuccess = 0
		fixupStateInProgress = 1
		fixupStateCouldNotUpdate = 2
	end enum

	type FixupState as tagFixupState

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

	type tagIsolationState as long
	enum
		isolationStateNotRestricted = 1
		isolationStateInProbation = 2
		isolationStateRestrictedAccess = 3
	end enum

	type IsolationState as tagIsolationState

	type tagExtendedIsolationState as long
	enum
		extendedIsolationStateNoData = 0
		extendedIsolationStateTransition = 1
		extendedIsolationStateInfected = 2
		extendedIsolationStateUnknown = 3
	end enum

	type ExtendedIsolationState as tagExtendedIsolationState

	type tagRemoteConfigurationType as long
	enum
		remoteConfigTypeMachine = 1
		remoteConfigTypeConfigBlob = 2
	end enum

	type RemoteConfigurationType as tagRemoteConfigurationType

	type tagNapNotifyType as long
	enum
		napNotifyTypeUnknown = 0
		napNotifyTypeServiceState = 1
		napNotifyTypeQuarState = 2
	end enum

	type NapNotifyType as tagNapNotifyType

	type tagResultCodes
		count as UINT16
		results as HRESULT ptr
	end type

	type ResultCodes as tagResultCodes

	type tagCorrelationId
		connId as GUID
		timeStamp as FILETIME
	end type

	type CorrelationId as tagCorrelationId

	type tagSoHAttribute
		as UINT16 type
		size as UINT16
		value as UBYTE ptr
	end type

	type SoHAttribute as tagSoHAttribute

	type tagIpv4Address
		addr(0 to 3) as UBYTE
	end type

	type Ipv4Address as tagIpv4Address

	type tagIpv6Address
		addr(0 to 15) as UBYTE
	end type

	type Ipv6Address as tagIpv6Address

	type tagSoH
		count as UINT16
		attributes as SoHAttribute ptr
	end type

	type SoH as tagSoH
	type SoHRequest as tagSoH
	type SoHResponse as tagSoH

	type tagFixupInfo
		state as FixupState
		percentage as Percentage
		resultCodes as ResultCodes
		fixupMsgId as MessageId
	end type

	type FixupInfo as tagFixupInfo

	type tagFailureCategoryMapping
		mappingCompliance(0 to 4) as WINBOOL
	end type

	type FailureCategoryMapping as tagFailureCategoryMapping

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

	type tagPrivateData
		size as UINT16
		data as UBYTE ptr
	end type

	type PrivateData as tagPrivateData

	type tagNetworkSoH
		size as UINT16
		data as UBYTE ptr
	end type

	type NetworkSoH as tagNetworkSoH
	type NetworkSoHRequest as tagNetworkSoH
	type NetworkSoHResponse as tagNetworkSoH

	type tagSystemHealthAgentState
		id as SystemHealthEntityId
		shaResultCodes as ResultCodes
		failureCategory as FailureCategory
		fixupInfo as FixupInfo
	end type

	type SystemHealthAgentState as tagSystemHealthAgentState
#endif
