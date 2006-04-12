''
''
'' aclapi -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_aclapi_bi__
#define __win_aclapi_bi__

#include once "windows.bi"
#include once "win/accctrl.bi"

#inclib "advapi32"

declare function GetSecurityInfo alias "GetSecurityInfo" (byval as HANDLE, byval as SE_OBJECT_TYPE, byval as SECURITY_INFORMATION, byval as PSID ptr, byval as PSID ptr, byval as PACL ptr, byval as PACL ptr, byval as PSECURITY_DESCRIPTOR ptr) as DWORD
declare function SetSecurityInfo alias "SetSecurityInfo" (byval as HANDLE, byval as SE_OBJECT_TYPE, byval as SECURITY_INFORMATION, byval as PSID, byval as PSID, byval as PACL, byval as PACL) as DWORD

#ifdef UNICODE
declare sub BuildExplicitAccessWithName alias "BuildExplicitAccessWithNameW" (byval as PEXPLICIT_ACCESS_W, byval as LPWSTR, byval as DWORD, byval as ACCESS_MODE, byval as DWORD)
declare function BuildSecurityDescriptor alias "BuildSecurityDescriptorW" (byval as PTRUSTEE_W, byval as PTRUSTEE_W, byval as ULONG, byval as PEXPLICIT_ACCESS_W, byval as ULONG, byval as PEXPLICIT_ACCESS_W, byval as PSECURITY_DESCRIPTOR, byval as PULONG, byval as PSECURITY_DESCRIPTOR ptr) as DWORD
declare sub BuildTrusteeWithName alias "BuildTrusteeWithNameW" (byval as PTRUSTEE_W, byval as LPWSTR)
declare sub BuildTrusteeWithObjectsAndName alias "BuildTrusteeWithObjectsAndNameW" (byval as PTRUSTEE_W, byval as POBJECTS_AND_NAME_W, byval as SE_OBJECT_TYPE, byval as LPWSTR, byval as LPWSTR, byval as LPWSTR)
declare sub BuildTrusteeWithObjectsAndSid alias "BuildTrusteeWithObjectsAndSidW" (byval as PTRUSTEE_W, byval as POBJECTS_AND_SID, byval as GUID ptr, byval as GUID ptr, byval as PSID)
declare sub BuildTrusteeWithSid alias "BuildTrusteeWithSidW" (byval as PTRUSTEE_W, byval as PSID)
declare function GetAuditedPermissionsFromAcl alias "GetAuditedPermissionsFromAclW" (byval as PACL, byval as PTRUSTEE_W, byval as PACCESS_MASK, byval as PACCESS_MASK) as DWORD
declare function GetEffectiveRightsFromAcl alias "GetEffectiveRightsFromAclW" (byval as PACL, byval as PTRUSTEE_W, byval as PACCESS_MASK) as DWORD
declare function GetExplicitEntriesFromAcl alias "GetExplicitEntriesFromAclW" (byval as PACL, byval as PULONG, byval as PEXPLICIT_ACCESS_W ptr) as DWORD
declare function GetNamedSecurityInfo alias "GetNamedSecurityInfoW" (byval as LPWSTR, byval as SE_OBJECT_TYPE, byval as SECURITY_INFORMATION, byval as PSID ptr, byval as PSID ptr, byval as PACL ptr, byval as PACL ptr, byval as PSECURITY_DESCRIPTOR ptr) as DWORD
declare function GetTrusteeForm alias "GetTrusteeFormW" (byval as PTRUSTEE_W) as TRUSTEE_FORM
declare function GetTrusteeName alias "GetTrusteeNameW" (byval as PTRUSTEE_W) as LPWSTR
declare function GetTrusteeType alias "GetTrusteeTypeW" (byval as PTRUSTEE_W) as TRUSTEE_TYPE
declare function LookupSecurityDescriptorParts alias "LookupSecurityDescriptorPartsW" (byval as PTRUSTEE_W ptr, byval as PTRUSTEE_W ptr, byval as PULONG, byval as PEXPLICIT_ACCESS_W ptr, byval as PULONG, byval as PEXPLICIT_ACCESS_W ptr, byval as PSECURITY_DESCRIPTOR) as DWORD
declare function SetEntriesInAcl alias "SetEntriesInAclW" (byval as ULONG, byval as PEXPLICIT_ACCESS_W, byval as PACL, byval as PACL ptr) as DWORD
declare function SetNamedSecurityInfo alias "SetNamedSecurityInfoW" (byval as LPWSTR, byval as SE_OBJECT_TYPE, byval as SECURITY_INFORMATION, byval as PSID, byval as PSID, byval as PACL, byval as PACL) as DWORD
declare sub BuildImpersonateExplicitAccessWithName alias "BuildImpersonateExplicitAccessWithNameW" (byval as PEXPLICIT_ACCESS_W, byval as LPWSTR, byval as PTRUSTEE_W, byval as DWORD, byval as ACCESS_MODE, byval as DWORD)
declare sub BuildImpersonateTrustee alias "BuildImpersonateTrusteeW" (byval as PTRUSTEE_W, byval as PTRUSTEE_W)
declare function GetMultipleTrustee alias "GetMultipleTrusteeW" (byval as PTRUSTEE_W) as PTRUSTEE_W
declare function GetMultipleTrusteeOperation alias "GetMultipleTrusteeOperationW" (byval as PTRUSTEE_W) as MULTIPLE_TRUSTEE_OPERATION

#else ''UNICODE
declare sub BuildExplicitAccessWithName alias "BuildExplicitAccessWithNameA" (byval as PEXPLICIT_ACCESS_A, byval as LPSTR, byval as DWORD, byval as ACCESS_MODE, byval as DWORD)
declare function BuildSecurityDescriptor alias "BuildSecurityDescriptorA" (byval as PTRUSTEE_A, byval as PTRUSTEE_A, byval as ULONG, byval as PEXPLICIT_ACCESS_A, byval as ULONG, byval as PEXPLICIT_ACCESS_A, byval as PSECURITY_DESCRIPTOR, byval as PULONG, byval as PSECURITY_DESCRIPTOR ptr) as DWORD
declare sub BuildTrusteeWithName alias "BuildTrusteeWithNameA" (byval as PTRUSTEE_A, byval as LPSTR)
declare sub BuildTrusteeWithObjectsAndName alias "BuildTrusteeWithObjectsAndNameA" (byval as PTRUSTEE_A, byval as POBJECTS_AND_NAME_A, byval as SE_OBJECT_TYPE, byval as LPSTR, byval as LPSTR, byval as LPSTR)
declare sub BuildTrusteeWithObjectsAndSid alias "BuildTrusteeWithObjectsAndSidA" (byval as PTRUSTEE_A, byval as POBJECTS_AND_SID, byval as GUID ptr, byval as GUID ptr, byval as PSID)
declare sub BuildTrusteeWithSid alias "BuildTrusteeWithSidA" (byval as PTRUSTEE_A, byval as PSID)
declare function GetAuditedPermissionsFromAcl alias "GetAuditedPermissionsFromAclA" (byval as PACL, byval as PTRUSTEE_A, byval as PACCESS_MASK, byval as PACCESS_MASK) as DWORD
declare function GetEffectiveRightsFromAcl alias "GetEffectiveRightsFromAclA" (byval as PACL, byval as PTRUSTEE_A, byval as PACCESS_MASK) as DWORD
declare function GetExplicitEntriesFromAcl alias "GetExplicitEntriesFromAclA" (byval as PACL, byval as PULONG, byval as PEXPLICIT_ACCESS_A ptr) as DWORD
declare function GetNamedSecurityInfo alias "GetNamedSecurityInfoA" (byval as LPSTR, byval as SE_OBJECT_TYPE, byval as SECURITY_INFORMATION, byval as PSID ptr, byval as PSID ptr, byval as PACL ptr, byval as PACL ptr, byval as PSECURITY_DESCRIPTOR ptr) as DWORD
declare function GetTrusteeForm alias "GetTrusteeFormA" (byval as PTRUSTEE_A) as TRUSTEE_FORM
declare function GetTrusteeName alias "GetTrusteeNameA" (byval as PTRUSTEE_A) as LPSTR
declare function GetTrusteeType alias "GetTrusteeTypeA" (byval as PTRUSTEE_A) as TRUSTEE_TYPE
declare function LookupSecurityDescriptorParts alias "LookupSecurityDescriptorPartsA" (byval as PTRUSTEE_A ptr, byval as PTRUSTEE_A ptr, byval as PULONG, byval as PEXPLICIT_ACCESS_A ptr, byval as PULONG, byval as PEXPLICIT_ACCESS_A ptr, byval as PSECURITY_DESCRIPTOR) as DWORD
declare function SetEntriesInAcl alias "SetEntriesInAclA" (byval as ULONG, byval as PEXPLICIT_ACCESS_A, byval as PACL, byval as PACL ptr) as DWORD
declare function SetNamedSecurityInfo alias "SetNamedSecurityInfoA" (byval as LPSTR, byval as SE_OBJECT_TYPE, byval as SECURITY_INFORMATION, byval as PSID, byval as PSID, byval as PACL, byval as PACL) as DWORD
declare sub BuildImpersonateExplicitAccessWithName alias "BuildImpersonateExplicitAccessWithNameA" (byval as PEXPLICIT_ACCESS_A, byval as LPSTR, byval as PTRUSTEE_A, byval as DWORD, byval as ACCESS_MODE, byval as DWORD)
declare sub BuildImpersonateTrustee alias "BuildImpersonateTrusteeA" (byval as PTRUSTEE_A, byval as PTRUSTEE_A)
declare function GetMultipleTrustee alias "GetMultipleTrusteeA" (byval as PTRUSTEE_A) as PTRUSTEE_A
declare function GetMultipleTrusteeOperation alias "GetMultipleTrusteeOperationA" (byval as PTRUSTEE_A) as MULTIPLE_TRUSTEE_OPERATION

#endif ''UNICODE

#endif
