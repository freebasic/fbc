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

#inclib "userenv"

#include once "winapifamily.bi"
#include once "_mingw_unicode.bi"
#include once "wbemcli.bi"
#include once "profinfo.bi"

extern "Windows"

#define _INC_USERENV
const PI_NOUI = &h00000001
const PI_APPLYPOLICY = &h00000002
const PT_TEMPORARY = &h00000001
const PT_ROAMING = &h00000002
const PT_MANDATORY = &h00000004
const RP_FORCE = 1
const RP_SYNC = 2
const GPC_BLOCK_POLICY = &h00000001
const GPO_FLAG_DISABLE = &h00000001
const GPO_FLAG_FORCE = &h00000002
declare function LoadUserProfileA(byval hToken as HANDLE, byval lpProfileInfo as LPPROFILEINFOA) as WINBOOL

#ifndef UNICODE
	declare function LoadUserProfile alias "LoadUserProfileA"(byval hToken as HANDLE, byval lpProfileInfo as LPPROFILEINFOA) as WINBOOL
#endif

declare function LoadUserProfileW(byval hToken as HANDLE, byval lpProfileInfo as LPPROFILEINFOW) as WINBOOL

#ifdef UNICODE
	declare function LoadUserProfile alias "LoadUserProfileW"(byval hToken as HANDLE, byval lpProfileInfo as LPPROFILEINFOW) as WINBOOL
#endif

declare function UnloadUserProfile(byval hToken as HANDLE, byval hProfile as HANDLE) as WINBOOL
declare function GetProfilesDirectoryA(byval lpProfileDir as LPSTR, byval lpcchSize as LPDWORD) as WINBOOL

#ifndef UNICODE
	declare function GetProfilesDirectory alias "GetProfilesDirectoryA"(byval lpProfileDir as LPSTR, byval lpcchSize as LPDWORD) as WINBOOL
#endif

declare function GetProfilesDirectoryW(byval lpProfileDir as LPWSTR, byval lpcchSize as LPDWORD) as WINBOOL

#ifdef UNICODE
	declare function GetProfilesDirectory alias "GetProfilesDirectoryW"(byval lpProfileDir as LPWSTR, byval lpcchSize as LPDWORD) as WINBOOL
#endif

declare function GetProfileType(byval dwFlags as DWORD ptr) as WINBOOL
declare function DeleteProfileA(byval lpSidString as LPCSTR, byval lpProfilePath as LPCSTR, byval lpComputerName as LPCSTR) as WINBOOL

#ifndef UNICODE
	declare function DeleteProfile alias "DeleteProfileA"(byval lpSidString as LPCSTR, byval lpProfilePath as LPCSTR, byval lpComputerName as LPCSTR) as WINBOOL
#endif

declare function DeleteProfileW(byval lpSidString as LPCWSTR, byval lpProfilePath as LPCWSTR, byval lpComputerName as LPCWSTR) as WINBOOL

#ifdef UNICODE
	declare function DeleteProfile alias "DeleteProfileW"(byval lpSidString as LPCWSTR, byval lpProfilePath as LPCWSTR, byval lpComputerName as LPCWSTR) as WINBOOL
#endif

declare function GetDefaultUserProfileDirectoryA(byval lpProfileDir as LPSTR, byval lpcchSize as LPDWORD) as WINBOOL

#ifndef UNICODE
	declare function GetDefaultUserProfileDirectory alias "GetDefaultUserProfileDirectoryA"(byval lpProfileDir as LPSTR, byval lpcchSize as LPDWORD) as WINBOOL
#endif

declare function GetDefaultUserProfileDirectoryW(byval lpProfileDir as LPWSTR, byval lpcchSize as LPDWORD) as WINBOOL

#ifdef UNICODE
	declare function GetDefaultUserProfileDirectory alias "GetDefaultUserProfileDirectoryW"(byval lpProfileDir as LPWSTR, byval lpcchSize as LPDWORD) as WINBOOL
#endif

declare function GetAllUsersProfileDirectoryA(byval lpProfileDir as LPSTR, byval lpcchSize as LPDWORD) as WINBOOL

#ifndef UNICODE
	declare function GetAllUsersProfileDirectory alias "GetAllUsersProfileDirectoryA"(byval lpProfileDir as LPSTR, byval lpcchSize as LPDWORD) as WINBOOL
#endif

declare function GetAllUsersProfileDirectoryW(byval lpProfileDir as LPWSTR, byval lpcchSize as LPDWORD) as WINBOOL

#ifdef UNICODE
	declare function GetAllUsersProfileDirectory alias "GetAllUsersProfileDirectoryW"(byval lpProfileDir as LPWSTR, byval lpcchSize as LPDWORD) as WINBOOL
#endif

declare function GetUserProfileDirectoryA(byval hToken as HANDLE, byval lpProfileDir as LPSTR, byval lpcchSize as LPDWORD) as WINBOOL

#ifndef UNICODE
	declare function GetUserProfileDirectory alias "GetUserProfileDirectoryA"(byval hToken as HANDLE, byval lpProfileDir as LPSTR, byval lpcchSize as LPDWORD) as WINBOOL
#endif

declare function GetUserProfileDirectoryW(byval hToken as HANDLE, byval lpProfileDir as LPWSTR, byval lpcchSize as LPDWORD) as WINBOOL

#ifdef UNICODE
	declare function GetUserProfileDirectory alias "GetUserProfileDirectoryW"(byval hToken as HANDLE, byval lpProfileDir as LPWSTR, byval lpcchSize as LPDWORD) as WINBOOL
#endif

declare function CreateEnvironmentBlock(byval lpEnvironment as LPVOID ptr, byval hToken as HANDLE, byval bInherit as WINBOOL) as WINBOOL
declare function DestroyEnvironmentBlock(byval lpEnvironment as LPVOID) as WINBOOL
declare function ExpandEnvironmentStringsForUserA(byval hToken as HANDLE, byval lpSrc as LPCSTR, byval lpDest as LPSTR, byval dwSize as DWORD) as WINBOOL

#ifndef UNICODE
	declare function ExpandEnvironmentStringsForUser alias "ExpandEnvironmentStringsForUserA"(byval hToken as HANDLE, byval lpSrc as LPCSTR, byval lpDest as LPSTR, byval dwSize as DWORD) as WINBOOL
#endif

declare function ExpandEnvironmentStringsForUserW(byval hToken as HANDLE, byval lpSrc as LPCWSTR, byval lpDest as LPWSTR, byval dwSize as DWORD) as WINBOOL

#ifdef UNICODE
	declare function ExpandEnvironmentStringsForUser alias "ExpandEnvironmentStringsForUserW"(byval hToken as HANDLE, byval lpSrc as LPCWSTR, byval lpDest as LPWSTR, byval dwSize as DWORD) as WINBOOL
#endif

declare function RefreshPolicy(byval bMachine as WINBOOL) as WINBOOL
declare function RefreshPolicyEx(byval bMachine as WINBOOL, byval dwOptions as DWORD) as WINBOOL
declare function EnterCriticalPolicySection(byval bMachine as WINBOOL) as HANDLE
declare function LeaveCriticalPolicySection(byval hSection as HANDLE) as WINBOOL
declare function RegisterGPNotification(byval hEvent as HANDLE, byval bMachine as WINBOOL) as WINBOOL
declare function UnregisterGPNotification(byval hEvent as HANDLE) as WINBOOL

#if _WIN32_WINNT >= &h0600
	declare function CreateProfile(byval pszUserSid as LPCWSTR, byval pszUserName as LPCWSTR, byval pszProfilePath as LPWSTR, byval cchProfilePath as DWORD) as HRESULT
#endif

type _GPO_LINK as long
enum
	GPLinkUnknown = 0
	GPLinkMachine
	GPLinkSite
	GPLinkDomain
	GPLinkOrganizationalUnit
end enum

type GPO_LINK as _GPO_LINK
type PGPO_LINK as _GPO_LINK ptr

type _GROUP_POLICY_OBJECTA
	dwOptions as DWORD
	dwVersion as DWORD
	lpDSPath as LPSTR
	lpFileSysPath as LPSTR
	lpDisplayName as LPSTR
	szGPOName as zstring * 50
	GPOLink as GPO_LINK
	lParam as LPARAM
	pNext as _GROUP_POLICY_OBJECTA ptr
	pPrev as _GROUP_POLICY_OBJECTA ptr
	lpExtensions as LPSTR
	lParam2 as LPARAM
	lpLink as LPSTR
end type

type GROUP_POLICY_OBJECTA as _GROUP_POLICY_OBJECTA
type PGROUP_POLICY_OBJECTA as _GROUP_POLICY_OBJECTA ptr

type _GROUP_POLICY_OBJECTW
	dwOptions as DWORD
	dwVersion as DWORD
	lpDSPath as LPWSTR
	lpFileSysPath as LPWSTR
	lpDisplayName as LPWSTR
	szGPOName as wstring * 50
	GPOLink as GPO_LINK
	lParam as LPARAM
	pNext as _GROUP_POLICY_OBJECTW ptr
	pPrev as _GROUP_POLICY_OBJECTW ptr
	lpExtensions as LPWSTR
	lParam2 as LPARAM
	lpLink as LPWSTR
end type

type GROUP_POLICY_OBJECTW as _GROUP_POLICY_OBJECTW
type PGROUP_POLICY_OBJECTW as _GROUP_POLICY_OBJECTW ptr

#ifdef UNICODE
	type GROUP_POLICY_OBJECT as GROUP_POLICY_OBJECTW
	type PGROUP_POLICY_OBJECT as PGROUP_POLICY_OBJECTW
#else
	type GROUP_POLICY_OBJECT as GROUP_POLICY_OBJECTA
	type PGROUP_POLICY_OBJECT as PGROUP_POLICY_OBJECTA
#endif

const GPO_LIST_FLAG_MACHINE = &h00000001
const GPO_LIST_FLAG_SITEONLY = &h00000002
const GPO_LIST_FLAG_NO_WMIFILTERS = &h00000004
const GPO_LIST_FLAG_NO_SECURITYFILTERS = &h00000008
declare function GetGPOListA(byval hToken as HANDLE, byval lpName as LPCSTR, byval lpHostName as LPCSTR, byval lpComputerName as LPCSTR, byval dwFlags as DWORD, byval pGPOList as PGROUP_POLICY_OBJECTA ptr) as WINBOOL

#ifndef UNICODE
	declare function GetGPOList alias "GetGPOListA"(byval hToken as HANDLE, byval lpName as LPCSTR, byval lpHostName as LPCSTR, byval lpComputerName as LPCSTR, byval dwFlags as DWORD, byval pGPOList as PGROUP_POLICY_OBJECTA ptr) as WINBOOL
#endif

declare function GetGPOListW(byval hToken as HANDLE, byval lpName as LPCWSTR, byval lpHostName as LPCWSTR, byval lpComputerName as LPCWSTR, byval dwFlags as DWORD, byval pGPOList as PGROUP_POLICY_OBJECTW ptr) as WINBOOL

#ifdef UNICODE
	declare function GetGPOList alias "GetGPOListW"(byval hToken as HANDLE, byval lpName as LPCWSTR, byval lpHostName as LPCWSTR, byval lpComputerName as LPCWSTR, byval dwFlags as DWORD, byval pGPOList as PGROUP_POLICY_OBJECTW ptr) as WINBOOL
#endif

declare function FreeGPOListA(byval pGPOList as PGROUP_POLICY_OBJECTA) as WINBOOL

#ifndef UNICODE
	declare function FreeGPOList alias "FreeGPOListA"(byval pGPOList as PGROUP_POLICY_OBJECTA) as WINBOOL
#endif

declare function FreeGPOListW(byval pGPOList as PGROUP_POLICY_OBJECTW) as WINBOOL

#ifdef UNICODE
	declare function FreeGPOList alias "FreeGPOListW"(byval pGPOList as PGROUP_POLICY_OBJECTW) as WINBOOL
#endif

declare function GetAppliedGPOListA(byval dwFlags as DWORD, byval pMachineName as LPCSTR, byval pSidUser as PSID, byval pGuidExtension as GUID ptr, byval ppGPOList as PGROUP_POLICY_OBJECTA ptr) as DWORD

#ifndef UNICODE
	declare function GetAppliedGPOList alias "GetAppliedGPOListA"(byval dwFlags as DWORD, byval pMachineName as LPCSTR, byval pSidUser as PSID, byval pGuidExtension as GUID ptr, byval ppGPOList as PGROUP_POLICY_OBJECTA ptr) as DWORD
#endif

declare function GetAppliedGPOListW(byval dwFlags as DWORD, byval pMachineName as LPCWSTR, byval pSidUser as PSID, byval pGuidExtension as GUID ptr, byval ppGPOList as PGROUP_POLICY_OBJECTW ptr) as DWORD

#ifdef UNICODE
	declare function GetAppliedGPOList alias "GetAppliedGPOListW"(byval dwFlags as DWORD, byval pMachineName as LPCWSTR, byval pSidUser as PSID, byval pGuidExtension as GUID ptr, byval ppGPOList as PGROUP_POLICY_OBJECTW ptr) as DWORD
#endif

#define GP_DLLNAME __TEXT("DllName")
#define GP_ENABLEASYNCHRONOUSPROCESSING __TEXT("EnableAsynchronousProcessing")
#define GP_MAXNOGPOLISTCHANGESINTERVAL __TEXT("MaxNoGPOListChangesInterval")
#define GP_NOBACKGROUNDPOLICY __TEXT("NoBackgroundPolicy")
#define GP_NOGPOLISTCHANGES __TEXT("NoGPOListChanges")
#define GP_NOMACHINEPOLICY __TEXT("NoMachinePolicy")
#define GP_NOSLOWLINK __TEXT("NoSlowLink")
#define GP_NOTIFYLINKTRANSITION __TEXT("NotifyLinkTransition")
#define GP_NOUSERPOLICY __TEXT("NoUserPolicy")
#define GP_PERUSERLOCALSETTINGS __TEXT("PerUserLocalSettings")
#define GP_PROCESSGROUPPOLICY __TEXT("ProcessGroupPolicy")
#define GP_REQUIRESSUCCESSFULREGISTRY __TEXT("RequiresSuccessfulRegistry")
const GPO_INFO_FLAG_MACHINE = &h00000001
const GPO_INFO_FLAG_BACKGROUND = &h00000010
const GPO_INFO_FLAG_SLOWLINK = &h00000020
const GPO_INFO_FLAG_VERBOSE = &h00000040
const GPO_INFO_FLAG_NOCHANGES = &h00000080
const GPO_INFO_FLAG_LINKTRANSITION = &h00000100
const GPO_INFO_FLAG_LOGRSOP_TRANSITION = &h00000200
const GPO_INFO_FLAG_FORCED_REFRESH = &h00000400
const GPO_INFO_FLAG_SAFEMODE_BOOT = &h00000800
const GPO_INFO_FLAG_ASYNC_FOREGROUND = &h00001000

type ASYNCCOMPLETIONHANDLE as UINT_PTR
type PFNSTATUSMESSAGECALLBACK as function cdecl(byval bVerbose as WINBOOL, byval lpMessage as LPWSTR) as DWORD
type PFNPROCESSGROUPPOLICY as function cdecl(byval dwFlags as DWORD, byval hToken as HANDLE, byval hKeyRoot as HKEY, byval pDeletedGPOList as PGROUP_POLICY_OBJECT, byval pChangedGPOList as PGROUP_POLICY_OBJECT, byval pHandle as ASYNCCOMPLETIONHANDLE, byval pbAbort as WINBOOL ptr, byval pStatusCallback as PFNSTATUSMESSAGECALLBACK) as DWORD
type PFNPROCESSGROUPPOLICYEX as function cdecl(byval dwFlags as DWORD, byval hToken as HANDLE, byval hKeyRoot as HKEY, byval pDeletedGPOList as PGROUP_POLICY_OBJECT, byval pChangedGPOList as PGROUP_POLICY_OBJECT, byval pHandle as ASYNCCOMPLETIONHANDLE, byval pbAbort as WINBOOL ptr, byval pStatusCallback as PFNSTATUSMESSAGECALLBACK, byval pWbemServices as IWbemServices ptr, byval pRsopStatus as HRESULT ptr) as DWORD
type PRSOPTOKEN as PVOID

type _RSOP_TARGET
	pwszAccountName as wstring ptr
	pwszNewSOM as wstring ptr
	psaSecurityGroups as SAFEARRAY ptr
	pRsopToken as PRSOPTOKEN
	pGPOList as PGROUP_POLICY_OBJECT
	pWbemServices as IWbemServices ptr
end type

type RSOP_TARGET as _RSOP_TARGET
type PRSOP_TARGET as _RSOP_TARGET ptr
type PFNGENERATEGROUPPOLICY as function cdecl(byval dwFlags as DWORD, byval pbAbort as WINBOOL ptr, byval pwszSite as wstring ptr, byval pComputerTarget as PRSOP_TARGET, byval pUserTarget as PRSOP_TARGET) as DWORD

#define REGISTRY_EXTENSION_GUID (&h35378eac, &h683f, &h11d2, &ha8, &h9a, &h00, &hc0, &h4f, &hbb, &hcf, &ha2)
#define GROUP_POLICY_TRIGGER_EVENT_PROVIDER_GUID (&hbd2f4252, &h5e1e, &h49fc, &h9a, &h30, &hf3, &h97, &h8a, &hd8, &h9e, &he2)
#define MACHINE_POLICY_PRESENT_TRIGGER_GUID (&h659fcae6, &h5bdb, &h4da9, &hb1, &hff, &hca, &h2a, &h17, &h8d, &h46, &he0)
#define USER_POLICY_PRESENT_TRIGGER_GUID (&h54fb46c8, &hf089, &h464c, &hb1, &hfd, &h59, &hd1, &hb6, &h2c, &h3b, &h50)
type REFGPEXTENSIONID as GUID ptr

declare function ProcessGroupPolicyCompleted(byval extensionId as REFGPEXTENSIONID, byval pAsyncHandle as ASYNCCOMPLETIONHANDLE, byval dwStatus as DWORD) as DWORD
declare function ProcessGroupPolicyCompletedEx(byval extensionId as REFGPEXTENSIONID, byval pAsyncHandle as ASYNCCOMPLETIONHANDLE, byval dwStatus as DWORD, byval RsopStatus as HRESULT) as DWORD
declare function RsopAccessCheckByType(byval pSecurityDescriptor as PSECURITY_DESCRIPTOR, byval pPrincipalSelfSid as PSID, byval pRsopToken as PRSOPTOKEN, byval dwDesiredAccessMask as DWORD, byval pObjectTypeList as POBJECT_TYPE_LIST, byval ObjectTypeListLength as DWORD, byval pGenericMapping as PGENERIC_MAPPING, byval pPrivilegeSet as PPRIVILEGE_SET, byval pdwPrivilegeSetLength as LPDWORD, byval pdwGrantedAccessMask as LPDWORD, byval pbAccessStatus as LPBOOL) as HRESULT
declare function RsopFileAccessCheck(byval pszFileName as LPWSTR, byval pRsopToken as PRSOPTOKEN, byval dwDesiredAccessMask as DWORD, byval pdwGrantedAccessMask as LPDWORD, byval pbAccessStatus as LPBOOL) as HRESULT

type _SETTINGSTATUS as long
enum
	RSOPUnspecified = 0
	RSOPApplied
	RSOPIgnored
	RSOPFailed
	RSOPSubsettingFailed
end enum

type SETTINGSTATUS as _SETTINGSTATUS

type _POLICYSETTINGSTATUSINFO
	szKey as LPWSTR
	szEventSource as LPWSTR
	szEventLogName as LPWSTR
	dwEventID as DWORD
	dwErrorCode as DWORD
	status as SETTINGSTATUS
	timeLogged as SYSTEMTIME
end type

type POLICYSETTINGSTATUSINFO as _POLICYSETTINGSTATUSINFO
type LPPOLICYSETTINGSTATUSINFO as _POLICYSETTINGSTATUSINFO ptr
declare function RsopSetPolicySettingStatus(byval dwFlags as DWORD, byval pServices as IWbemServices ptr, byval pSettingInstance as IWbemClassObject ptr, byval nInfo as DWORD, byval pStatus as POLICYSETTINGSTATUSINFO ptr) as HRESULT
declare function RsopResetPolicySettingStatus(byval dwFlags as DWORD, byval pServices as IWbemServices ptr, byval pSettingInstance as IWbemClassObject ptr) as HRESULT
const FLAG_NO_GPO_FILTER = &h80000000
const FLAG_NO_CSE_INVOKE = &h40000000
const FLAG_ASSUME_SLOW_LINK = &h20000000
const FLAG_LOOPBACK_MERGE = &h10000000
const FLAG_LOOPBACK_REPLACE = &h08000000
const FLAG_ASSUME_USER_WQLFILTER_TRUE = &h04000000
const FLAG_ASSUME_COMP_WQLFILTER_TRUE = &h02000000
const FLAG_PLANNING_MODE = &h01000000
const FLAG_NO_USER = &h00000001
const FLAG_NO_COMPUTER = &h00000002
const FLAG_FORCE_CREATENAMESPACE = &h00000004
const RSOP_USER_ACCESS_DENIED = &h00000001
const RSOP_COMPUTER_ACCESS_DENIED = &h00000002
const RSOP_TEMPNAMESPACE_EXISTS = &h00000004

#if _WIN32_WINNT >= &h0600
	declare function GenerateGPNotification(byval bMachine as WINBOOL, byval lpwszMgmtProduct as LPCWSTR, byval dwMgmtProductOptions as DWORD) as DWORD
#endif

#if _WIN32_WINNT = &h0602
	declare function CreateAppContainerProfile(byval pszAppContainerName as PCWSTR, byval pszDisplayName as PCWSTR, byval pszDescription as PCWSTR, byval pCapabilities as PSID_AND_ATTRIBUTES, byval dwCapabilityCount as DWORD, byval ppSidAppContainerSid as PSID ptr) as HRESULT
	declare function DeleteAppContainerProfile(byval pszAppContainerName as PCWSTR) as HRESULT
	declare function GetAppContainerRegistryLocation(byval desiredAccess as REGSAM, byval phAppContainerKey as PHKEY) as HRESULT
	declare function GetAppContainerFolderPath(byval pszAppContainerSid as PCWSTR, byval ppszPath as PWSTR ptr) as HRESULT
	declare function DeriveAppContainerSidFromAppContainerName(byval pszAppContainerName as PCWSTR, byval ppsidAppContainerSid as PSID ptr) as HRESULT
#endif

end extern
