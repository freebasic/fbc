#pragma once

#inclib "userenv"

#include once "_mingw_unicode.bi"
#include once "wbemcli.bi"
#include once "profinfo.bi"

extern "Windows"

#define _USERENV_H_
#define PI_NOUI &h00000001
#define PI_APPLYPOLICY &h00000002

#ifdef UNICODE
	#define LoadUserProfile LoadUserProfileW
	#define GetProfilesDirectory GetProfilesDirectoryW
	#define DeleteProfile DeleteProfileW
	#define GetDefaultUserProfileDirectory GetDefaultUserProfileDirectoryW
	#define GetAllUsersProfileDirectory GetAllUsersProfileDirectoryW
	#define GetUserProfileDirectory GetUserProfileDirectoryW
	#define ExpandEnvironmentStringsForUser ExpandEnvironmentStringsForUserW
#else
	#define LoadUserProfile LoadUserProfileA
	#define GetProfilesDirectory GetProfilesDirectoryA
	#define DeleteProfile DeleteProfileA
	#define GetDefaultUserProfileDirectory GetDefaultUserProfileDirectoryA
	#define GetAllUsersProfileDirectory GetAllUsersProfileDirectoryA
	#define GetUserProfileDirectory GetUserProfileDirectoryA
	#define ExpandEnvironmentStringsForUser ExpandEnvironmentStringsForUserA
#endif

declare function LoadUserProfileA(byval hToken as HANDLE, byval lpProfileInfo as LPPROFILEINFOA) as WINBOOL
declare function LoadUserProfileW(byval hToken as HANDLE, byval lpProfileInfo as LPPROFILEINFOW) as WINBOOL
declare function UnloadUserProfile(byval hToken as HANDLE, byval hProfile as HANDLE) as WINBOOL
declare function GetProfilesDirectoryA(byval lpProfilesDir as LPSTR, byval lpcchSize as LPDWORD) as WINBOOL
declare function GetProfilesDirectoryW(byval lpProfilesDir as LPWSTR, byval lpcchSize as LPDWORD) as WINBOOL

#define PT_TEMPORARY &h00000001
#define PT_ROAMING &h00000002
#define PT_MANDATORY &h00000004

declare function GetProfileType(byval dwFlags as DWORD ptr) as WINBOOL
declare function DeleteProfileA(byval lpSidString as LPCSTR, byval lpProfilePath as LPCSTR, byval lpComputerName as LPCSTR) as WINBOOL
declare function DeleteProfileW(byval lpSidString as LPCWSTR, byval lpProfilePath as LPCWSTR, byval lpComputerName as LPCWSTR) as WINBOOL
declare function GetDefaultUserProfileDirectoryA(byval lpProfileDir as LPSTR, byval lpcchSize as LPDWORD) as WINBOOL
declare function GetDefaultUserProfileDirectoryW(byval lpProfileDir as LPWSTR, byval lpcchSize as LPDWORD) as WINBOOL
declare function GetAllUsersProfileDirectoryA(byval lpProfileDir as LPSTR, byval lpcchSize as LPDWORD) as WINBOOL
declare function GetAllUsersProfileDirectoryW(byval lpProfileDir as LPWSTR, byval lpcchSize as LPDWORD) as WINBOOL
declare function GetUserProfileDirectoryA(byval hToken as HANDLE, byval lpProfileDir as LPSTR, byval lpcchSize as LPDWORD) as WINBOOL
declare function GetUserProfileDirectoryW(byval hToken as HANDLE, byval lpProfileDir as LPWSTR, byval lpcchSize as LPDWORD) as WINBOOL
declare function CreateEnvironmentBlock(byval lpEnvironment as LPVOID ptr, byval hToken as HANDLE, byval bInherit as WINBOOL) as WINBOOL
declare function DestroyEnvironmentBlock(byval lpEnvironment as LPVOID) as WINBOOL
declare function ExpandEnvironmentStringsForUserA(byval hToken as HANDLE, byval lpSrc as LPCSTR, byval lpDest as LPSTR, byval dwSize as DWORD) as WINBOOL
declare function ExpandEnvironmentStringsForUserW(byval hToken as HANDLE, byval lpSrc as LPCWSTR, byval lpDest as LPWSTR, byval dwSize as DWORD) as WINBOOL
declare function RefreshPolicy(byval bMachine as WINBOOL) as WINBOOL
#define RP_FORCE 1
declare function RefreshPolicyEx(byval bMachine as WINBOOL, byval dwOptions as DWORD) as WINBOOL
declare function EnterCriticalPolicySection(byval bMachine as WINBOOL) as HANDLE
declare function LeaveCriticalPolicySection(byval hSection as HANDLE) as WINBOOL
declare function RegisterGPNotification(byval hEvent as HANDLE, byval bMachine as WINBOOL) as WINBOOL
declare function UnregisterGPNotification(byval hEvent as HANDLE) as WINBOOL

#define GPC_BLOCK_POLICY &h00000001
#define GPO_FLAG_DISABLE &h00000001
#define GPO_FLAG_FORCE &h00000002

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

#define GPO_LIST_FLAG_MACHINE &h00000001
#define GPO_LIST_FLAG_SITEONLY &h00000002
#define GPO_LIST_FLAG_NO_WMIFILTERS &h00000004

#ifdef UNICODE
	#define GetGPOList GetGPOListW
	#define FreeGPOList FreeGPOListW
	#define GetAppliedGPOList GetAppliedGPOListW
#else
	#define GetGPOList GetGPOListA
	#define FreeGPOList FreeGPOListA
	#define GetAppliedGPOList GetAppliedGPOListA
#endif

declare function GetGPOListA(byval hToken as HANDLE, byval lpName as LPCSTR, byval lpHostName as LPCSTR, byval lpComputerName as LPCSTR, byval dwFlags as DWORD, byval pGPOList as PGROUP_POLICY_OBJECTA ptr) as WINBOOL
declare function GetGPOListW(byval hToken as HANDLE, byval lpName as LPCWSTR, byval lpHostName as LPCWSTR, byval lpComputerName as LPCWSTR, byval dwFlags as DWORD, byval pGPOList as PGROUP_POLICY_OBJECTW ptr) as WINBOOL
declare function FreeGPOListA(byval pGPOList as PGROUP_POLICY_OBJECTA) as WINBOOL
declare function FreeGPOListW(byval pGPOList as PGROUP_POLICY_OBJECTW) as WINBOOL
declare function GetAppliedGPOListA(byval dwFlags as DWORD, byval pMachineName as LPCSTR, byval pSidUser as PSID, byval pGuidExtension as GUID ptr, byval ppGPOList as PGROUP_POLICY_OBJECTA ptr) as DWORD
declare function GetAppliedGPOListW(byval dwFlags as DWORD, byval pMachineName as LPCWSTR, byval pSidUser as PSID, byval pGuidExtension as GUID ptr, byval ppGPOList as PGROUP_POLICY_OBJECTW ptr) as DWORD

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
#define GPO_INFO_FLAG_MACHINE &h00000001
#define GPO_INFO_FLAG_BACKGROUND &h00000010
#define GPO_INFO_FLAG_SLOWLINK &h00000020
#define GPO_INFO_FLAG_VERBOSE &h00000040
#define GPO_INFO_FLAG_NOCHANGES &h00000080
#define GPO_INFO_FLAG_LINKTRANSITION &h00000100
#define GPO_INFO_FLAG_LOGRSOP_TRANSITION &h00000200
#define GPO_INFO_FLAG_FORCED_REFRESH &h00000400
#define GPO_INFO_FLAG_SAFEMODE_BOOT &h00000800
#define GPO_INFO_FLAG_ASYNC_FOREGROUND &h00001000
#define GPO_INFO_FLAG_REPORT &h00002000

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
#define REGISTRY_EXTENSION_GUID (&h35378EAC, &h683F, &h11D2, &hA8, &h9A, &h00, &hC0, &h4F, &hBB, &hCF, &hA2)
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
#define FLAG_NO_GPO_FILTER &h80000000
#define FLAG_NO_CSE_INVOKE &h40000000
#define FLAG_ASSUME_SLOW_LINK &h20000000
#define FLAG_LOOPBACK_MERGE &h10000000
#define FLAG_LOOPBACK_REPLACE &h08000000
#define FLAG_ASSUME_USER_WQLFILTER_TRUE &h04000000
#define FLAG_ASSUME_COMP_WQLFILTER_TRUE &h02000000
#define FLAG_PLANNING_MODE &h01000000
#define FLAG_NO_USER &h00000001
#define FLAG_NO_COMPUTER &h00000002
#define FLAG_FORCE_CREATENAMESPACE &h00000004
#define RSOP_USER_ACCESS_DENIED &h00000001
#define RSOP_COMPUTER_ACCESS_DENIED &h00000002
#define RSOP_TEMPNAMESPACE_EXISTS &h00000004

end extern
