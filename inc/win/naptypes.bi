'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   This Software is provided under the Zope Public License (ZPL) Version 2.1.
''
''   Copyright (c) 2009, 2010 by the mingw-w64 project
''
''   See the AUTHORS file for the list of contributors to the mingw-w64 project.
''
''   This license has been certified as open source. It has also been designated
''   as GPL compatible by the Free Software Foundation (FSF).
''
''   Redistribution and use in source and binary forms, with or without
''   modification, are permitted provided that the following conditions are met:
''
''     1. Redistributions in source code must retain the accompanying copyright
''        notice, this list of conditions, and the following disclaimer.
''     2. Redistributions in binary form must reproduce the accompanying
''        copyright notice, this list of conditions, and the following disclaimer
''        in the documentation and/or other materials provided with the
''        distribution.
''     3. Names of the copyright holders must not be used to endorse or promote
''        products derived from this software without prior written permission
''        from the copyright holders.
''     4. The right to distribute this software or to use it for any purpose does
''        not give you the right to use Servicemarks (sm) or Trademarks (tm) of
''        the copyright holders.  Use of them is covered by separate agreement
''        with the copyright holders.
''     5. If any files are modified, you must cause the modified files to carry
''        prominent notices stating that you changed the files and the date of
''        any change.
''
''   Disclaimer
''
''   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS ``AS IS'' AND ANY EXPRESSED
''   OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
''   OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
''   EVENT SHALL THE COPYRIGHT HOLDERS BE LIABLE FOR ANY DIRECT, INDIRECT,
''   INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
''   LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, 
''   OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
''   LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
''   NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
''   EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

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
const maxIpv4CountPerSoHAttribute = maxSoHAttributeSize / 4
const maxIpv6CountPerSoHAttribute = maxSoHAttributeSize / 16
const maxStringLength = 1024
#define maxStringLengthInBytes ((maxStringLength + 1) * sizeof(WCHAR))
const maxSystemHealthEntityCount = 20
const maxEnforcerCount = 20
const maxPrivateDataSize = 200
const maxConnectionCountPerEnforcer = 20
const maxCachedSoHCount = (maxSystemHealthEntityCount * maxEnforcerCount) * maxConnectionCountPerEnforcer
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
