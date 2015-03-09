#pragma once

#include once "winapifamily.bi"
#include once "_mingw_unicode.bi"
#include once "windows.bi"
#include once "accctrl.bi"

#inclib "advapi32"

extern "Windows"

#define __ACCESS_CONTROL_API__

type FN_PROGRESS as sub cdecl(byval pObjectName as LPWSTR, byval Status as DWORD, byval pInvokeSetting as PPROG_INVOKE_SETTING, byval Args as PVOID, byval SecuritySet as WINBOOL)

#ifdef UNICODE
	#define SetEntriesInAcl SetEntriesInAclW
	#define GetExplicitEntriesFromAcl GetExplicitEntriesFromAclW
	#define GetEffectiveRightsFromAcl GetEffectiveRightsFromAclW
	#define GetAuditedPermissionsFromAcl GetAuditedPermissionsFromAclW
	#define GetNamedSecurityInfo GetNamedSecurityInfoW
	#define SetNamedSecurityInfo SetNamedSecurityInfoW
	#define GetInheritanceSource GetInheritanceSourceW
	#define TreeResetNamedSecurityInfo TreeResetNamedSecurityInfoW
	#define BuildSecurityDescriptor BuildSecurityDescriptorW
	#define LookupSecurityDescriptorParts LookupSecurityDescriptorPartsW
	#define BuildExplicitAccessWithName BuildExplicitAccessWithNameW
	#define BuildImpersonateExplicitAccessWithName BuildImpersonateExplicitAccessWithNameW
	#define BuildTrusteeWithName BuildTrusteeWithNameW
	#define BuildImpersonateTrustee BuildImpersonateTrusteeW
	#define BuildTrusteeWithSid BuildTrusteeWithSidW
	#define BuildTrusteeWithObjectsAndSid BuildTrusteeWithObjectsAndSidW
	#define BuildTrusteeWithObjectsAndName BuildTrusteeWithObjectsAndNameW
	#define GetTrusteeName GetTrusteeNameW
	#define GetTrusteeType GetTrusteeTypeW
	#define GetTrusteeForm GetTrusteeFormW
	#define GetMultipleTrusteeOperation GetMultipleTrusteeOperationW
	#define GetMultipleTrustee GetMultipleTrusteeW
#endif

#if defined(UNICODE) and (_WIN32_WINNT = &h0602)
	#define TreeSetNamedSecurityInfo TreeSetNamedSecurityInfoW
#elseif not defined(UNICODE)
	#define SetEntriesInAcl SetEntriesInAclA
	#define GetExplicitEntriesFromAcl GetExplicitEntriesFromAclA
	#define GetEffectiveRightsFromAcl GetEffectiveRightsFromAclA
	#define GetAuditedPermissionsFromAcl GetAuditedPermissionsFromAclA
	#define GetNamedSecurityInfo GetNamedSecurityInfoA
	#define SetNamedSecurityInfo SetNamedSecurityInfoA
	#define GetInheritanceSource GetInheritanceSourceA
	#define TreeResetNamedSecurityInfo TreeResetNamedSecurityInfoA
	#define BuildSecurityDescriptor BuildSecurityDescriptorA
	#define LookupSecurityDescriptorParts LookupSecurityDescriptorPartsA
	#define BuildExplicitAccessWithName BuildExplicitAccessWithNameA
	#define BuildImpersonateExplicitAccessWithName BuildImpersonateExplicitAccessWithNameA
	#define BuildTrusteeWithName BuildTrusteeWithNameA
	#define BuildImpersonateTrustee BuildImpersonateTrusteeA
	#define BuildTrusteeWithSid BuildTrusteeWithSidA
	#define BuildTrusteeWithObjectsAndSid BuildTrusteeWithObjectsAndSidA
	#define BuildTrusteeWithObjectsAndName BuildTrusteeWithObjectsAndNameA
	#define GetTrusteeName GetTrusteeNameA
	#define GetTrusteeType GetTrusteeTypeA
	#define GetTrusteeForm GetTrusteeFormA
	#define GetMultipleTrusteeOperation GetMultipleTrusteeOperationA
	#define GetMultipleTrustee GetMultipleTrusteeA
#endif

#if (not defined(UNICODE)) and (_WIN32_WINNT = &h0602)
	#define TreeSetNamedSecurityInfo TreeSetNamedSecurityInfoA
#endif

#define AccProvInit(err)

declare function SetEntriesInAclA(byval cCountOfExplicitEntries as ULONG, byval pListOfExplicitEntries as PEXPLICIT_ACCESS_A, byval OldAcl as PACL, byval NewAcl as PACL ptr) as DWORD
declare function SetEntriesInAclW(byval cCountOfExplicitEntries as ULONG, byval pListOfExplicitEntries as PEXPLICIT_ACCESS_W, byval OldAcl as PACL, byval NewAcl as PACL ptr) as DWORD
declare function GetExplicitEntriesFromAclA(byval pacl as PACL, byval pcCountOfExplicitEntries as PULONG, byval pListOfExplicitEntries as PEXPLICIT_ACCESS_A ptr) as DWORD
declare function GetExplicitEntriesFromAclW(byval pacl as PACL, byval pcCountOfExplicitEntries as PULONG, byval pListOfExplicitEntries as PEXPLICIT_ACCESS_W ptr) as DWORD
declare function GetEffectiveRightsFromAclA(byval pacl as PACL, byval pTrustee as PTRUSTEE_A, byval pAccessRights as PACCESS_MASK) as DWORD
declare function GetEffectiveRightsFromAclW(byval pacl as PACL, byval pTrustee as PTRUSTEE_W, byval pAccessRights as PACCESS_MASK) as DWORD
declare function GetAuditedPermissionsFromAclA(byval pacl as PACL, byval pTrustee as PTRUSTEE_A, byval pSuccessfulAuditedRights as PACCESS_MASK, byval pFailedAuditRights as PACCESS_MASK) as DWORD
declare function GetAuditedPermissionsFromAclW(byval pacl as PACL, byval pTrustee as PTRUSTEE_W, byval pSuccessfulAuditedRights as PACCESS_MASK, byval pFailedAuditRights as PACCESS_MASK) as DWORD
declare function GetNamedSecurityInfoA(byval pObjectName as LPCSTR, byval ObjectType as SE_OBJECT_TYPE, byval SecurityInfo as SECURITY_INFORMATION, byval ppsidOwner as PSID ptr, byval ppsidGroup as PSID ptr, byval ppDacl as PACL ptr, byval ppSacl as PACL ptr, byval ppSecurityDescriptor as PSECURITY_DESCRIPTOR ptr) as DWORD
declare function GetNamedSecurityInfoW(byval pObjectName as LPCWSTR, byval ObjectType as SE_OBJECT_TYPE, byval SecurityInfo as SECURITY_INFORMATION, byval ppsidOwner as PSID ptr, byval ppsidGroup as PSID ptr, byval ppDacl as PACL ptr, byval ppSacl as PACL ptr, byval ppSecurityDescriptor as PSECURITY_DESCRIPTOR ptr) as DWORD
declare function GetSecurityInfo(byval handle as HANDLE, byval ObjectType as SE_OBJECT_TYPE, byval SecurityInfo as SECURITY_INFORMATION, byval ppsidOwner as PSID ptr, byval ppsidGroup as PSID ptr, byval ppDacl as PACL ptr, byval ppSacl as PACL ptr, byval ppSecurityDescriptor as PSECURITY_DESCRIPTOR ptr) as DWORD
declare function SetNamedSecurityInfoA(byval pObjectName as LPSTR, byval ObjectType as SE_OBJECT_TYPE, byval SecurityInfo as SECURITY_INFORMATION, byval psidOwner as PSID, byval psidGroup as PSID, byval pDacl as PACL, byval pSacl as PACL) as DWORD
declare function SetNamedSecurityInfoW(byval pObjectName as LPWSTR, byval ObjectType as SE_OBJECT_TYPE, byval SecurityInfo as SECURITY_INFORMATION, byval psidOwner as PSID, byval psidGroup as PSID, byval pDacl as PACL, byval pSacl as PACL) as DWORD
declare function SetSecurityInfo(byval handle as HANDLE, byval ObjectType as SE_OBJECT_TYPE, byval SecurityInfo as SECURITY_INFORMATION, byval psidOwner as PSID, byval psidGroup as PSID, byval pDacl as PACL, byval pSacl as PACL) as DWORD
declare function GetInheritanceSourceA(byval pObjectName as LPSTR, byval ObjectType as SE_OBJECT_TYPE, byval SecurityInfo as SECURITY_INFORMATION, byval Container as WINBOOL, byval pObjectClassGuids as GUID ptr ptr, byval GuidCount as DWORD, byval pAcl as PACL, byval pfnArray as PFN_OBJECT_MGR_FUNCTS, byval pGenericMapping as PGENERIC_MAPPING, byval pInheritArray as PINHERITED_FROMA) as DWORD
declare function GetInheritanceSourceW(byval pObjectName as LPWSTR, byval ObjectType as SE_OBJECT_TYPE, byval SecurityInfo as SECURITY_INFORMATION, byval Container as WINBOOL, byval pObjectClassGuids as GUID ptr ptr, byval GuidCount as DWORD, byval pAcl as PACL, byval pfnArray as PFN_OBJECT_MGR_FUNCTS, byval pGenericMapping as PGENERIC_MAPPING, byval pInheritArray as PINHERITED_FROMW) as DWORD
declare function FreeInheritedFromArray(byval pInheritArray as PINHERITED_FROMW, byval AceCnt as USHORT, byval pfnArray as PFN_OBJECT_MGR_FUNCTS) as DWORD
declare function TreeResetNamedSecurityInfoA(byval pObjectName as LPSTR, byval ObjectType as SE_OBJECT_TYPE, byval SecurityInfo as SECURITY_INFORMATION, byval pOwner as PSID, byval pGroup as PSID, byval pDacl as PACL, byval pSacl as PACL, byval KeepExplicit as WINBOOL, byval fnProgress as FN_PROGRESS, byval ProgressInvokeSetting as PROG_INVOKE_SETTING, byval Args as PVOID) as DWORD
declare function TreeResetNamedSecurityInfoW(byval pObjectName as LPWSTR, byval ObjectType as SE_OBJECT_TYPE, byval SecurityInfo as SECURITY_INFORMATION, byval pOwner as PSID, byval pGroup as PSID, byval pDacl as PACL, byval pSacl as PACL, byval KeepExplicit as WINBOOL, byval fnProgress as FN_PROGRESS, byval ProgressInvokeSetting as PROG_INVOKE_SETTING, byval Args as PVOID) as DWORD
declare function BuildSecurityDescriptorA(byval pOwner as PTRUSTEE_A, byval pGroup as PTRUSTEE_A, byval cCountOfAccessEntries as ULONG, byval pListOfAccessEntries as PEXPLICIT_ACCESS_A, byval cCountOfAuditEntries as ULONG, byval pListOfAuditEntries as PEXPLICIT_ACCESS_A, byval pOldSD as PSECURITY_DESCRIPTOR, byval pSizeNewSD as PULONG, byval pNewSD as PSECURITY_DESCRIPTOR ptr) as DWORD
declare function BuildSecurityDescriptorW(byval pOwner as PTRUSTEE_W, byval pGroup as PTRUSTEE_W, byval cCountOfAccessEntries as ULONG, byval pListOfAccessEntries as PEXPLICIT_ACCESS_W, byval cCountOfAuditEntries as ULONG, byval pListOfAuditEntries as PEXPLICIT_ACCESS_W, byval pOldSD as PSECURITY_DESCRIPTOR, byval pSizeNewSD as PULONG, byval pNewSD as PSECURITY_DESCRIPTOR ptr) as DWORD
declare function LookupSecurityDescriptorPartsA(byval ppOwner as PTRUSTEE_A ptr, byval ppGroup as PTRUSTEE_A ptr, byval pcCountOfAccessEntries as PULONG, byval ppListOfAccessEntries as PEXPLICIT_ACCESS_A ptr, byval pcCountOfAuditEntries as PULONG, byval ppListOfAuditEntries as PEXPLICIT_ACCESS_A ptr, byval pSD as PSECURITY_DESCRIPTOR) as DWORD
declare function LookupSecurityDescriptorPartsW(byval ppOwner as PTRUSTEE_W ptr, byval ppGroup as PTRUSTEE_W ptr, byval pcCountOfAccessEntries as PULONG, byval ppListOfAccessEntries as PEXPLICIT_ACCESS_W ptr, byval pcCountOfAuditEntries as PULONG, byval ppListOfAuditEntries as PEXPLICIT_ACCESS_W ptr, byval pSD as PSECURITY_DESCRIPTOR) as DWORD
declare sub BuildExplicitAccessWithNameA(byval pExplicitAccess as PEXPLICIT_ACCESS_A, byval pTrusteeName as LPSTR, byval AccessPermissions as DWORD, byval AccessMode as ACCESS_MODE, byval Inheritance as DWORD)
declare sub BuildExplicitAccessWithNameW(byval pExplicitAccess as PEXPLICIT_ACCESS_W, byval pTrusteeName as LPWSTR, byval AccessPermissions as DWORD, byval AccessMode as ACCESS_MODE, byval Inheritance as DWORD)
declare sub BuildImpersonateExplicitAccessWithNameA(byval pExplicitAccess as PEXPLICIT_ACCESS_A, byval pTrusteeName as LPSTR, byval pTrustee as PTRUSTEE_A, byval AccessPermissions as DWORD, byval AccessMode as ACCESS_MODE, byval Inheritance as DWORD)
declare sub BuildImpersonateExplicitAccessWithNameW(byval pExplicitAccess as PEXPLICIT_ACCESS_W, byval pTrusteeName as LPWSTR, byval pTrustee as PTRUSTEE_W, byval AccessPermissions as DWORD, byval AccessMode as ACCESS_MODE, byval Inheritance as DWORD)
declare sub BuildTrusteeWithNameA(byval pTrustee as PTRUSTEE_A, byval pName as LPSTR)
declare sub BuildTrusteeWithNameW(byval pTrustee as PTRUSTEE_W, byval pName as LPWSTR)
declare sub BuildImpersonateTrusteeA(byval pTrustee as PTRUSTEE_A, byval pImpersonateTrustee as PTRUSTEE_A)
declare sub BuildImpersonateTrusteeW(byval pTrustee as PTRUSTEE_W, byval pImpersonateTrustee as PTRUSTEE_W)
declare sub BuildTrusteeWithSidA(byval pTrustee as PTRUSTEE_A, byval pSid as PSID)
declare sub BuildTrusteeWithSidW(byval pTrustee as PTRUSTEE_W, byval pSid as PSID)
declare sub BuildTrusteeWithObjectsAndSidA(byval pTrustee as PTRUSTEE_A, byval pObjSid as POBJECTS_AND_SID, byval pObjectGuid as GUID ptr, byval pInheritedObjectGuid as GUID ptr, byval pSid as PSID)
declare sub BuildTrusteeWithObjectsAndSidW(byval pTrustee as PTRUSTEE_W, byval pObjSid as POBJECTS_AND_SID, byval pObjectGuid as GUID ptr, byval pInheritedObjectGuid as GUID ptr, byval pSid as PSID)
declare sub BuildTrusteeWithObjectsAndNameA(byval pTrustee as PTRUSTEE_A, byval pObjName as POBJECTS_AND_NAME_A, byval ObjectType as SE_OBJECT_TYPE, byval ObjectTypeName as LPSTR, byval InheritedObjectTypeName as LPSTR, byval Name as LPSTR)
declare sub BuildTrusteeWithObjectsAndNameW(byval pTrustee as PTRUSTEE_W, byval pObjName as POBJECTS_AND_NAME_W, byval ObjectType as SE_OBJECT_TYPE, byval ObjectTypeName as LPWSTR, byval InheritedObjectTypeName as LPWSTR, byval Name as LPWSTR)
declare function GetTrusteeNameA(byval pTrustee as PTRUSTEE_A) as LPSTR
declare function GetTrusteeNameW(byval pTrustee as PTRUSTEE_W) as LPWSTR
declare function GetTrusteeTypeA(byval pTrustee as PTRUSTEE_A) as TRUSTEE_TYPE
declare function GetTrusteeTypeW(byval pTrustee as PTRUSTEE_W) as TRUSTEE_TYPE
declare function GetTrusteeFormA(byval pTrustee as PTRUSTEE_A) as TRUSTEE_FORM
declare function GetTrusteeFormW(byval pTrustee as PTRUSTEE_W) as TRUSTEE_FORM
declare function GetMultipleTrusteeOperationA(byval pTrustee as PTRUSTEE_A) as MULTIPLE_TRUSTEE_OPERATION
declare function GetMultipleTrusteeOperationW(byval pTrustee as PTRUSTEE_W) as MULTIPLE_TRUSTEE_OPERATION
declare function GetMultipleTrusteeA(byval pTrustee as PTRUSTEE_A) as PTRUSTEE_A
declare function GetMultipleTrusteeW(byval pTrustee as PTRUSTEE_W) as PTRUSTEE_W

#if _WIN32_WINNT = &h0602
	declare function TreeSetNamedSecurityInfoA(byval pObjectName as LPSTR, byval ObjectType as SE_OBJECT_TYPE, byval SecurityInfo as SECURITY_INFORMATION, byval pOwner as PSID, byval pGroup as PSID, byval pDacl as PACL, byval pSacl as PACL, byval dwAction as DWORD, byval fnProgress as FN_PROGRESS, byval ProgressInvokeSetting as PROG_INVOKE_SETTING, byval Args as PVOID) as DWORD
	declare function TreeSetNamedSecurityInfoW(byval pObjectName as LPWSTR, byval ObjectType as SE_OBJECT_TYPE, byval SecurityInfo as SECURITY_INFORMATION, byval pOwner as PSID, byval pGroup as PSID, byval pDacl as PACL, byval pSacl as PACL, byval dwAction as DWORD, byval fnProgress as FN_PROGRESS, byval ProgressInvokeSetting as PROG_INVOKE_SETTING, byval Args as PVOID) as DWORD
#endif

end extern
