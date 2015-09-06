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

#include once "winapifamily.bi"
#include once "windows.bi"
#include once "adtgen.bi"

extern "Windows"

#define __AUTHZ_H__
#define AUTHZAPI DECLSPEC_IMPORT
const AUTHZ_SKIP_TOKEN_GROUPS = &h2
const AUTHZ_REQUIRE_S4U_LOGON = &h4
const AUTHZ_COMPUTE_PRIVILEGES = &h8

type AUTHZ_ACCESS_CHECK_RESULTS_HANDLE__
	unused as long
end type

type AUTHZ_ACCESS_CHECK_RESULTS_HANDLE as AUTHZ_ACCESS_CHECK_RESULTS_HANDLE__ ptr

type AUTHZ_CLIENT_CONTEXT_HANDLE__
	unused as long
end type

type AUTHZ_CLIENT_CONTEXT_HANDLE as AUTHZ_CLIENT_CONTEXT_HANDLE__ ptr

type AUTHZ_RESOURCE_MANAGER_HANDLE__
	unused as long
end type

type AUTHZ_RESOURCE_MANAGER_HANDLE as AUTHZ_RESOURCE_MANAGER_HANDLE__ ptr

type AUTHZ_AUDIT_EVENT_HANDLE__
	unused as long
end type

type AUTHZ_AUDIT_EVENT_HANDLE as AUTHZ_AUDIT_EVENT_HANDLE__ ptr

type AUTHZ_AUDIT_EVENT_TYPE_HANDLE__
	unused as long
end type

type AUTHZ_AUDIT_EVENT_TYPE_HANDLE as AUTHZ_AUDIT_EVENT_TYPE_HANDLE__ ptr

type AUTHZ_SECURITY_EVENT_PROVIDER_HANDLE__
	unused as long
end type

type AUTHZ_SECURITY_EVENT_PROVIDER_HANDLE as AUTHZ_SECURITY_EVENT_PROVIDER_HANDLE__ ptr

#if _WIN32_WINNT = &h0602
	type AUTHZ_CAP_CHANGE_SUBSCRIPTION_HANDLE__
		unused as long
	end type

	type AUTHZ_CAP_CHANGE_SUBSCRIPTION_HANDLE as AUTHZ_CAP_CHANGE_SUBSCRIPTION_HANDLE__ ptr
#endif

type PAUTHZ_ACCESS_CHECK_RESULTS_HANDLE as AUTHZ_ACCESS_CHECK_RESULTS_HANDLE ptr
type PAUTHZ_CLIENT_CONTEXT_HANDLE as AUTHZ_CLIENT_CONTEXT_HANDLE ptr
type PAUTHZ_RESOURCE_MANAGER_HANDLE as AUTHZ_RESOURCE_MANAGER_HANDLE ptr
type PAUTHZ_AUDIT_EVENT_HANDLE as AUTHZ_AUDIT_EVENT_HANDLE ptr
type PAUTHZ_AUDIT_EVENT_TYPE_HANDLE as AUTHZ_AUDIT_EVENT_TYPE_HANDLE ptr
type PAUTHZ_SECURITY_EVENT_PROVIDER_HANDLE as AUTHZ_SECURITY_EVENT_PROVIDER_HANDLE ptr

#if _WIN32_WINNT = &h0602
	type PAUTHZ_CAP_CHANGE_SUBSCRIPTION_HANDLE as AUTHZ_CAP_CHANGE_SUBSCRIPTION_HANDLE ptr
#endif

type _AUTHZ_ACCESS_REQUEST
	DesiredAccess as ACCESS_MASK
	PrincipalSelfSid as PSID
	ObjectTypeList as POBJECT_TYPE_LIST
	ObjectTypeListLength as DWORD
	OptionalArguments as PVOID
end type

type AUTHZ_ACCESS_REQUEST as _AUTHZ_ACCESS_REQUEST
type PAUTHZ_ACCESS_REQUEST as _AUTHZ_ACCESS_REQUEST ptr
const AUTHZ_GENERATE_SUCCESS_AUDIT = &h1
const AUTHZ_GENERATE_FAILURE_AUDIT = &h2

type _AUTHZ_ACCESS_REPLY
	ResultListLength as DWORD
	GrantedAccessMask as PACCESS_MASK
	SaclEvaluationResults as PDWORD
	Error as PDWORD
end type

type AUTHZ_ACCESS_REPLY as _AUTHZ_ACCESS_REPLY
type PAUTHZ_ACCESS_REPLY as _AUTHZ_ACCESS_REPLY ptr
type PFN_AUTHZ_DYNAMIC_ACCESS_CHECK as function(byval hAuthzClientContext as AUTHZ_CLIENT_CONTEXT_HANDLE, byval pAce as PACE_HEADER, byval pArgs as PVOID, byval pbAceApplicable as PBOOL) as WINBOOL
type PFN_AUTHZ_COMPUTE_DYNAMIC_GROUPS as function(byval hAuthzClientContext as AUTHZ_CLIENT_CONTEXT_HANDLE, byval Args as PVOID, byval pSidAttrArray as PSID_AND_ATTRIBUTES ptr, byval pSidCount as PDWORD, byval pRestrictedSidAttrArray as PSID_AND_ATTRIBUTES ptr, byval pRestrictedSidCount as PDWORD) as WINBOOL
type PFN_AUTHZ_FREE_DYNAMIC_GROUPS as sub(byval pSidAttrArray as PSID_AND_ATTRIBUTES)

#if _WIN32_WINNT = &h0602
	type PFN_AUTHZ_GET_CENTRAL_ACCESS_POLICY as function(byval hAuthzClientContext as AUTHZ_CLIENT_CONTEXT_HANDLE, byval capid as PSID, byval pArgs as PVOID, byval pCentralAccessPolicyApplicable as PBOOL, byval ppCentralAccessPolicy as PVOID ptr) as WINBOOL
	type PFN_AUTHZ_FREE_CENTRAL_ACCESS_POLICY as sub(byval pCentralAccessPolicy as PVOID)
#endif

const AUTHZ_SECURITY_ATTRIBUTE_TYPE_INVALID = &h00
const AUTHZ_SECURITY_ATTRIBUTE_TYPE_INT64 = &h01
const AUTHZ_SECURITY_ATTRIBUTE_TYPE_UINT64 = &h02
const AUTHZ_SECURITY_ATTRIBUTE_TYPE_STRING = &h03
const AUTHZ_SECURITY_ATTRIBUTE_TYPE_FQBN = &h04

#if _WIN32_WINNT = &h0602
	const AUTHZ_SECURITY_ATTRIBUTE_TYPE_SID = &h05
	const AUTHZ_SECURITY_ATTRIBUTE_TYPE_BOOLEAN = &h06
#endif

const AUTHZ_SECURITY_ATTRIBUTE_TYPE_OCTET_STRING = &h10

type _AUTHZ_SECURITY_ATTRIBUTE_FQBN_VALUE
	Version as ULONG64
	pName as PWSTR
end type

type AUTHZ_SECURITY_ATTRIBUTE_FQBN_VALUE as _AUTHZ_SECURITY_ATTRIBUTE_FQBN_VALUE
type PAUTHZ_SECURITY_ATTRIBUTE_FQBN_VALUE as _AUTHZ_SECURITY_ATTRIBUTE_FQBN_VALUE ptr

type _AUTHZ_SECURITY_ATTRIBUTE_OCTET_STRING_VALUE
	pValue as PVOID
	ValueLength as ULONG
end type

type AUTHZ_SECURITY_ATTRIBUTE_OCTET_STRING_VALUE as _AUTHZ_SECURITY_ATTRIBUTE_OCTET_STRING_VALUE
type PAUTHZ_SECURITY_ATTRIBUTE_OCTET_STRING_VALUE as _AUTHZ_SECURITY_ATTRIBUTE_OCTET_STRING_VALUE ptr

type AUTHZ_SECURITY_ATTRIBUTE_OPERATION as long
enum
	AUTHZ_SECURITY_ATTRIBUTE_OPERATION_NONE = 0
	AUTHZ_SECURITY_ATTRIBUTE_OPERATION_REPLACE_ALL
	AUTHZ_SECURITY_ATTRIBUTE_OPERATION_ADD
	AUTHZ_SECURITY_ATTRIBUTE_OPERATION_DELETE
	AUTHZ_SECURITY_ATTRIBUTE_OPERATION_REPLACE
end enum

type PAUTHZ_SECURITY_ATTRIBUTE_OPERATION as AUTHZ_SECURITY_ATTRIBUTE_OPERATION ptr

#if _WIN32_WINNT = &h0602
	type AUTHZ_SID_OPERATION as long
	enum
		AUTHZ_SID_OPERATION_NONE = 0
		AUTHZ_SID_OPERATION_REPLACE_ALL
		AUTHZ_SID_OPERATION_ADD
		AUTHZ_SID_OPERATION_DELETE
		AUTHZ_SID_OPERATION_REPLACE
	end enum

	type PAUTHZ_SID_OPERATION as AUTHZ_SID_OPERATION ptr
#endif

const AUTHZ_SECURITY_ATTRIBUTE_NON_INHERITABLE = &h1
const AUTHZ_SECURITY_ATTRIBUTE_VALUE_CASE_SENSITIVE = &h2
const AUTHZ_SECURITY_ATTRIBUTE_VALID_FLAGS = AUTHZ_SECURITY_ATTRIBUTE_NON_INHERITABLE or AUTHZ_SECURITY_ATTRIBUTE_VALUE_CASE_SENSITIVE
const AUTHZ_SECURITY_ATTRIBUTES_INFORMATION_VERSION_V1 = 1
const AUTHZ_SECURITY_ATTRIBUTES_INFORMATION_VERSION = AUTHZ_SECURITY_ATTRIBUTES_INFORMATION_VERSION_V1
const AUTHZ_ACCESS_CHECK_NO_DEEP_COPY_SD = &h1
const AUTHZ_RM_FLAG_NO_AUDIT = &h1
const AUTHZ_RM_FLAG_INITIALIZE_UNDER_IMPERSONATION = &h2
const AUTHZ_RM_FLAG_NO_CENTRAL_ACCESS_POLICIES = &h4
const AUTHZ_VALID_RM_INIT_FLAGS = (AUTHZ_RM_FLAG_NO_AUDIT or AUTHZ_RM_FLAG_INITIALIZE_UNDER_IMPERSONATION) or AUTHZ_RM_FLAG_NO_CENTRAL_ACCESS_POLICIES

union _AUTHZ_SECURITY_ATTRIBUTE_V1_Values
	pInt64 as PLONG64
	pUint64 as PULONG64
	ppString as PWSTR ptr
	pFqbn as PAUTHZ_SECURITY_ATTRIBUTE_FQBN_VALUE
	pOctetString as PAUTHZ_SECURITY_ATTRIBUTE_OCTET_STRING_VALUE
end union

type _AUTHZ_SECURITY_ATTRIBUTE_V1
	pName as PWSTR
	ValueType as USHORT
	Reserved as USHORT
	Flags as ULONG
	ValueCount as ULONG
	Values as _AUTHZ_SECURITY_ATTRIBUTE_V1_Values
end type

type AUTHZ_SECURITY_ATTRIBUTE_V1 as _AUTHZ_SECURITY_ATTRIBUTE_V1
type PAUTHZ_SECURITY_ATTRIBUTE_V1 as _AUTHZ_SECURITY_ATTRIBUTE_V1 ptr

union _AUTHZ_SECURITY_ATTRIBUTES_INFORMATION_Attribute
	pAttributeV1 as PAUTHZ_SECURITY_ATTRIBUTE_V1
end union

type _AUTHZ_SECURITY_ATTRIBUTES_INFORMATION
	Version as USHORT
	Reserved as USHORT
	AttributeCount as ULONG
	Attribute as _AUTHZ_SECURITY_ATTRIBUTES_INFORMATION_Attribute
end type

type AUTHZ_SECURITY_ATTRIBUTES_INFORMATION as _AUTHZ_SECURITY_ATTRIBUTES_INFORMATION
type PAUTHZ_SECURITY_ATTRIBUTES_INFORMATION as _AUTHZ_SECURITY_ATTRIBUTES_INFORMATION ptr
declare function AuthzAccessCheck(byval Flags as DWORD, byval hAuthzClientContext as AUTHZ_CLIENT_CONTEXT_HANDLE, byval pRequest as PAUTHZ_ACCESS_REQUEST, byval hAuditEvent as AUTHZ_AUDIT_EVENT_HANDLE, byval pSecurityDescriptor as PSECURITY_DESCRIPTOR, byval OptionalSecurityDescriptorArray as PSECURITY_DESCRIPTOR ptr, byval OptionalSecurityDescriptorCount as DWORD, byval pReply as PAUTHZ_ACCESS_REPLY, byval phAccessCheckResults as PAUTHZ_ACCESS_CHECK_RESULTS_HANDLE) as WINBOOL
declare function AuthzCachedAccessCheck(byval Flags as DWORD, byval hAccessCheckResults as AUTHZ_ACCESS_CHECK_RESULTS_HANDLE, byval pRequest as PAUTHZ_ACCESS_REQUEST, byval hAuditEvent as AUTHZ_AUDIT_EVENT_HANDLE, byval pReply as PAUTHZ_ACCESS_REPLY) as WINBOOL
declare function AuthzOpenObjectAudit(byval Flags as DWORD, byval hAuthzClientContext as AUTHZ_CLIENT_CONTEXT_HANDLE, byval pRequest as PAUTHZ_ACCESS_REQUEST, byval hAuditEvent as AUTHZ_AUDIT_EVENT_HANDLE, byval pSecurityDescriptor as PSECURITY_DESCRIPTOR, byval OptionalSecurityDescriptorArray as PSECURITY_DESCRIPTOR ptr, byval OptionalSecurityDescriptorCount as DWORD, byval pReply as PAUTHZ_ACCESS_REPLY) as WINBOOL
declare function AuthzFreeHandle(byval hAccessCheckResults as AUTHZ_ACCESS_CHECK_RESULTS_HANDLE) as WINBOOL
declare function AuthzInitializeResourceManager(byval Flags as DWORD, byval pfnDynamicAccessCheck as PFN_AUTHZ_DYNAMIC_ACCESS_CHECK, byval pfnComputeDynamicGroups as PFN_AUTHZ_COMPUTE_DYNAMIC_GROUPS, byval pfnFreeDynamicGroups as PFN_AUTHZ_FREE_DYNAMIC_GROUPS, byval szResourceManagerName as PCWSTR, byval phAuthzResourceManager as PAUTHZ_RESOURCE_MANAGER_HANDLE) as WINBOOL

#if _WIN32_WINNT = &h0602
	const AUTHZ_RPC_INIT_INFO_CLIENT_VERSION_V1 = 1
	const AUTHZ_INIT_INFO_VERSION_V1 = 1

	type _AUTHZ_RPC_INIT_INFO_CLIENT
		version as USHORT
		ObjectUuid as PWSTR
		ProtSeq as PWSTR
		NetworkAddr as PWSTR
		Endpoint as PWSTR
		Options as PWSTR
		ServerSpn as PWSTR
	end type

	type AUTHZ_RPC_INIT_INFO_CLIENT as _AUTHZ_RPC_INIT_INFO_CLIENT
	type PAUTHZ_RPC_INIT_INFO_CLIENT as _AUTHZ_RPC_INIT_INFO_CLIENT ptr

	type _AUTHZ_INIT_INFO
		version as USHORT
		szResourceManagerName as PCWSTR
		pfnDynamicAccessCheck as PFN_AUTHZ_DYNAMIC_ACCESS_CHECK
		pfnComputeDynamicGroups as PFN_AUTHZ_COMPUTE_DYNAMIC_GROUPS
		pfnFreeDynamicGroups as PFN_AUTHZ_FREE_DYNAMIC_GROUPS
		pfnGetCentralAccessPolicy as PFN_AUTHZ_GET_CENTRAL_ACCESS_POLICY
		pfnFreeCentralAccessPolicy as PFN_AUTHZ_FREE_CENTRAL_ACCESS_POLICY
	end type

	type AUTHZ_INIT_INFO as _AUTHZ_INIT_INFO
	type PAUTHZ_INIT_INFO as _AUTHZ_INIT_INFO ptr
	declare function AuthzInitializeResourceManagerEx(byval Flags as DWORD, byval pAuthzInitInfo as PAUTHZ_INIT_INFO, byval phAuthzResourceManager as PAUTHZ_RESOURCE_MANAGER_HANDLE) as WINBOOL
	declare function AuthzInitializeRemoteResourceManager(byval pRpcInitInfo as PAUTHZ_RPC_INIT_INFO_CLIENT, byval phAuthzResourceManager as PAUTHZ_RESOURCE_MANAGER_HANDLE) as WINBOOL
#endif

declare function AuthzFreeResourceManager(byval hAuthzResourceManager as AUTHZ_RESOURCE_MANAGER_HANDLE) as WINBOOL
declare function AuthzInitializeContextFromToken(byval Flags as DWORD, byval TokenHandle as HANDLE, byval hAuthzResourceManager as AUTHZ_RESOURCE_MANAGER_HANDLE, byval pExpirationTime as PLARGE_INTEGER, byval Identifier as LUID, byval DynamicGroupArgs as PVOID, byval phAuthzClientContext as PAUTHZ_CLIENT_CONTEXT_HANDLE) as WINBOOL
declare function AuthzInitializeContextFromSid(byval Flags as DWORD, byval UserSid as PSID, byval hAuthzResourceManager as AUTHZ_RESOURCE_MANAGER_HANDLE, byval pExpirationTime as PLARGE_INTEGER, byval Identifier as LUID, byval DynamicGroupArgs as PVOID, byval phAuthzClientContext as PAUTHZ_CLIENT_CONTEXT_HANDLE) as WINBOOL
declare function AuthzInitializeContextFromAuthzContext(byval Flags as DWORD, byval hAuthzClientContext as AUTHZ_CLIENT_CONTEXT_HANDLE, byval pExpirationTime as PLARGE_INTEGER, byval Identifier as LUID, byval DynamicGroupArgs as PVOID, byval phNewAuthzClientContext as PAUTHZ_CLIENT_CONTEXT_HANDLE) as WINBOOL

#if _WIN32_WINNT = &h0602
	declare function AuthzInitializeCompoundContext(byval UserContext as AUTHZ_CLIENT_CONTEXT_HANDLE, byval DeviceContext as AUTHZ_CLIENT_CONTEXT_HANDLE, byval phCompoundContext as PAUTHZ_CLIENT_CONTEXT_HANDLE) as WINBOOL
#endif

declare function AuthzAddSidsToContext(byval hAuthzClientContext as AUTHZ_CLIENT_CONTEXT_HANDLE, byval Sids as PSID_AND_ATTRIBUTES, byval SidCount as DWORD, byval RestrictedSids as PSID_AND_ATTRIBUTES, byval RestrictedSidCount as DWORD, byval phNewAuthzClientContext as PAUTHZ_CLIENT_CONTEXT_HANDLE) as WINBOOL
declare function AuthzModifySecurityAttributes(byval hAuthzClientContext as AUTHZ_CLIENT_CONTEXT_HANDLE, byval pOperations as PAUTHZ_SECURITY_ATTRIBUTE_OPERATION, byval pAttributes as PAUTHZ_SECURITY_ATTRIBUTES_INFORMATION) as WINBOOL

type _AUTHZ_CONTEXT_INFORMATION_CLASS as long
enum
	AuthzContextInfoUserSid = 1
	AuthzContextInfoGroupsSids
	AuthzContextInfoRestrictedSids
	AuthzContextInfoPrivileges
	AuthzContextInfoExpirationTime
	AuthzContextInfoServerContext
	AuthzContextInfoIdentifier
	AuthzContextInfoSource
	AuthzContextInfoAll
	AuthzContextInfoAuthenticationId
	AuthzContextInfoSecurityAttributes
	AuthzContextInfoDeviceSids
	AuthzContextInfoUserClaims
	AuthzContextInfoDeviceClaims
	AuthzContextInfoAppContainerSid
	AuthzContextInfoCapabilitySids
end enum

type AUTHZ_CONTEXT_INFORMATION_CLASS as _AUTHZ_CONTEXT_INFORMATION_CLASS

#if _WIN32_WINNT = &h0602
	declare function AuthzModifyClaims(byval hAuthzClientContext as AUTHZ_CLIENT_CONTEXT_HANDLE, byval ClaimClass as AUTHZ_CONTEXT_INFORMATION_CLASS, byval pClaimOperations as PAUTHZ_SECURITY_ATTRIBUTE_OPERATION, byval pClaims as PAUTHZ_SECURITY_ATTRIBUTES_INFORMATION) as WINBOOL
	declare function AuthzModifySids(byval hAuthzClientContext as AUTHZ_CLIENT_CONTEXT_HANDLE, byval SidClass as AUTHZ_CONTEXT_INFORMATION_CLASS, byval pSidOperations as PAUTHZ_SID_OPERATION, byval pSids as PTOKEN_GROUPS) as WINBOOL
	declare function AuthzSetAppContainerInformation(byval hAuthzClientContext as AUTHZ_CLIENT_CONTEXT_HANDLE, byval pAppContainerSid as PSID, byval CapabilityCount as DWORD, byval pCapabilitySids as PSID_AND_ATTRIBUTES) as WINBOOL
#endif

declare function AuthzGetInformationFromContext(byval hAuthzClientContext as AUTHZ_CLIENT_CONTEXT_HANDLE, byval InfoClass as AUTHZ_CONTEXT_INFORMATION_CLASS, byval BufferSize as DWORD, byval pSizeRequired as PDWORD, byval Buffer as PVOID) as WINBOOL
declare function AuthzFreeContext(byval hAuthzClientContext as AUTHZ_CLIENT_CONTEXT_HANDLE) as WINBOOL
const AUTHZ_NO_SUCCESS_AUDIT = &h1
const AUTHZ_NO_FAILURE_AUDIT = &h2
const AUTHZ_NO_ALLOC_STRINGS = &h4
const AUTHZ_WPD_CATEGORY_FLAG = &h10
const AUTHZ_VALID_OBJECT_ACCESS_AUDIT_FLAGS = ((AUTHZ_NO_SUCCESS_AUDIT or AUTHZ_NO_FAILURE_AUDIT) or AUTHZ_NO_ALLOC_STRINGS) or AUTHZ_WPD_CATEGORY_FLAG
declare function AuthzInitializeObjectAccessAuditEvent cdecl(byval Flags as DWORD, byval hAuditEventType as AUTHZ_AUDIT_EVENT_TYPE_HANDLE, byval szOperationType as PWSTR, byval szObjectType as PWSTR, byval szObjectName as PWSTR, byval szAdditionalInfo as PWSTR, byval phAuditEvent as PAUTHZ_AUDIT_EVENT_HANDLE, byval dwAdditionalParameterCount as DWORD, ...) as WINBOOL
declare function AuthzInitializeObjectAccessAuditEvent2 cdecl(byval Flags as DWORD, byval hAuditEventType as AUTHZ_AUDIT_EVENT_TYPE_HANDLE, byval szOperationType as PWSTR, byval szObjectType as PWSTR, byval szObjectName as PWSTR, byval szAdditionalInfo as PWSTR, byval szAdditionalInfo2 as PWSTR, byval phAuditEvent as PAUTHZ_AUDIT_EVENT_HANDLE, byval dwAdditionalParameterCount as DWORD, ...) as WINBOOL

type _AUTHZ_AUDIT_EVENT_INFORMATION_CLASS as long
enum
	AuthzAuditEventInfoFlags = 1
	AuthzAuditEventInfoOperationType
	AuthzAuditEventInfoObjectType
	AuthzAuditEventInfoObjectName
	AuthzAuditEventInfoAdditionalInfo
end enum

type AUTHZ_AUDIT_EVENT_INFORMATION_CLASS as _AUTHZ_AUDIT_EVENT_INFORMATION_CLASS
declare function AuthzFreeAuditEvent(byval hAuditEvent as AUTHZ_AUDIT_EVENT_HANDLE) as WINBOOL
declare function AuthzEvaluateSacl(byval AuthzClientContext as AUTHZ_CLIENT_CONTEXT_HANDLE, byval pRequest as PAUTHZ_ACCESS_REQUEST, byval Sacl as PACL, byval GrantedAccess as ACCESS_MASK, byval AccessGranted as WINBOOL, byval pbGenerateAudit as PBOOL) as WINBOOL

type _AUTHZ_REGISTRATION_OBJECT_TYPE_NAME_OFFSET
	szObjectTypeName as PWSTR
	dwOffset as DWORD
end type

type AUTHZ_REGISTRATION_OBJECT_TYPE_NAME_OFFSET as _AUTHZ_REGISTRATION_OBJECT_TYPE_NAME_OFFSET
type PAUTHZ_REGISTRATION_OBJECT_TYPE_NAME_OFFSET as _AUTHZ_REGISTRATION_OBJECT_TYPE_NAME_OFFSET ptr

type _AUTHZ_SOURCE_SCHEMA_REGISTRATION
	dwFlags as DWORD
	szEventSourceName as PWSTR
	szEventMessageFile as PWSTR
	szEventSourceXmlSchemaFile as PWSTR
	szEventAccessStringsFile as PWSTR
	szExecutableImagePath as PWSTR

	union
		pReserved as PVOID
		pProviderGuid as GUID ptr
	end union

	dwObjectTypeNameCount as DWORD
	ObjectTypeNames(0 to 0) as AUTHZ_REGISTRATION_OBJECT_TYPE_NAME_OFFSET
end type

type AUTHZ_SOURCE_SCHEMA_REGISTRATION as _AUTHZ_SOURCE_SCHEMA_REGISTRATION
type PAUTHZ_SOURCE_SCHEMA_REGISTRATION as _AUTHZ_SOURCE_SCHEMA_REGISTRATION ptr
const AUTHZ_FLAG_ALLOW_MULTIPLE_SOURCE_INSTANCES = &h1
declare function AuthzInstallSecurityEventSource(byval dwFlags as DWORD, byval pRegistration as PAUTHZ_SOURCE_SCHEMA_REGISTRATION) as WINBOOL
declare function AuthzUninstallSecurityEventSource(byval dwFlags as DWORD, byval szEventSourceName as PCWSTR) as WINBOOL
declare function AuthzEnumerateSecurityEventSources(byval dwFlags as DWORD, byval Buffer as PAUTHZ_SOURCE_SCHEMA_REGISTRATION, byval pdwCount as PDWORD, byval pdwLength as PDWORD) as WINBOOL
declare function AuthzRegisterSecurityEventSource(byval dwFlags as DWORD, byval szEventSourceName as PCWSTR, byval phEventProvider as PAUTHZ_SECURITY_EVENT_PROVIDER_HANDLE) as WINBOOL
declare function AuthzUnregisterSecurityEventSource(byval dwFlags as DWORD, byval phEventProvider as PAUTHZ_SECURITY_EVENT_PROVIDER_HANDLE) as WINBOOL
declare function AuthzReportSecurityEvent cdecl(byval dwFlags as DWORD, byval hEventProvider as AUTHZ_SECURITY_EVENT_PROVIDER_HANDLE, byval dwAuditId as DWORD, byval pUserSid as PSID, byval dwCount as DWORD, ...) as WINBOOL
declare function AuthzReportSecurityEventFromParams(byval dwFlags as DWORD, byval hEventProvider as AUTHZ_SECURITY_EVENT_PROVIDER_HANDLE, byval dwAuditId as DWORD, byval pUserSid as PSID, byval pParams as PAUDIT_PARAMS) as WINBOOL

#if _WIN32_WINNT = &h0602
	declare function AuthzRegisterCapChangeNotification(byval phCapChangeSubscription as PAUTHZ_CAP_CHANGE_SUBSCRIPTION_HANDLE, byval pfnCapChangeCallback as LPTHREAD_START_ROUTINE, byval pCallbackContext as PVOID) as WINBOOL
	declare function AuthzUnregisterCapChangeNotification(byval hCapChangeSubscription as AUTHZ_CAP_CHANGE_SUBSCRIPTION_HANDLE) as WINBOOL
	declare function AuthzFreeCentralAccessPolicyCache() as WINBOOL
#endif

end extern
