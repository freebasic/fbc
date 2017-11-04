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

#inclib "advapi32"

#include once "winapifamily.bi"
#include once "_mingw_unicode.bi"
#include once "windows.bi"
#include once "accctrl.bi"

extern "Windows"

#define __ACCESS_CONTROL_API__
type FN_PROGRESS as sub cdecl(byval pObjectName as LPWSTR, byval Status as DWORD, byval pInvokeSetting as PPROG_INVOKE_SETTING, byval Args as PVOID, byval SecuritySet as WINBOOL)
#define AccProvInit(err)
declare function SetEntriesInAclA(byval cCountOfExplicitEntries as ULONG, byval pListOfExplicitEntries as PEXPLICIT_ACCESS_A, byval OldAcl as PACL, byval NewAcl as PACL ptr) as DWORD

#ifndef UNICODE
	declare function SetEntriesInAcl alias "SetEntriesInAclA"(byval cCountOfExplicitEntries as ULONG, byval pListOfExplicitEntries as PEXPLICIT_ACCESS_A, byval OldAcl as PACL, byval NewAcl as PACL ptr) as DWORD
#endif

declare function SetEntriesInAclW(byval cCountOfExplicitEntries as ULONG, byval pListOfExplicitEntries as PEXPLICIT_ACCESS_W, byval OldAcl as PACL, byval NewAcl as PACL ptr) as DWORD

#ifdef UNICODE
	declare function SetEntriesInAcl alias "SetEntriesInAclW"(byval cCountOfExplicitEntries as ULONG, byval pListOfExplicitEntries as PEXPLICIT_ACCESS_W, byval OldAcl as PACL, byval NewAcl as PACL ptr) as DWORD
#endif

declare function GetExplicitEntriesFromAclA(byval pacl as PACL, byval pcCountOfExplicitEntries as PULONG, byval pListOfExplicitEntries as PEXPLICIT_ACCESS_A ptr) as DWORD

#ifndef UNICODE
	declare function GetExplicitEntriesFromAcl alias "GetExplicitEntriesFromAclA"(byval pacl as PACL, byval pcCountOfExplicitEntries as PULONG, byval pListOfExplicitEntries as PEXPLICIT_ACCESS_A ptr) as DWORD
#endif

declare function GetExplicitEntriesFromAclW(byval pacl as PACL, byval pcCountOfExplicitEntries as PULONG, byval pListOfExplicitEntries as PEXPLICIT_ACCESS_W ptr) as DWORD

#ifdef UNICODE
	declare function GetExplicitEntriesFromAcl alias "GetExplicitEntriesFromAclW"(byval pacl as PACL, byval pcCountOfExplicitEntries as PULONG, byval pListOfExplicitEntries as PEXPLICIT_ACCESS_W ptr) as DWORD
#endif

declare function GetEffectiveRightsFromAclA(byval pacl as PACL, byval pTrustee as PTRUSTEE_A, byval pAccessRights as PACCESS_MASK) as DWORD

#ifndef UNICODE
	declare function GetEffectiveRightsFromAcl alias "GetEffectiveRightsFromAclA"(byval pacl as PACL, byval pTrustee as PTRUSTEE_A, byval pAccessRights as PACCESS_MASK) as DWORD
#endif

declare function GetEffectiveRightsFromAclW(byval pacl as PACL, byval pTrustee as PTRUSTEE_W, byval pAccessRights as PACCESS_MASK) as DWORD

#ifdef UNICODE
	declare function GetEffectiveRightsFromAcl alias "GetEffectiveRightsFromAclW"(byval pacl as PACL, byval pTrustee as PTRUSTEE_W, byval pAccessRights as PACCESS_MASK) as DWORD
#endif

declare function GetAuditedPermissionsFromAclA(byval pacl as PACL, byval pTrustee as PTRUSTEE_A, byval pSuccessfulAuditedRights as PACCESS_MASK, byval pFailedAuditRights as PACCESS_MASK) as DWORD

#ifndef UNICODE
	declare function GetAuditedPermissionsFromAcl alias "GetAuditedPermissionsFromAclA"(byval pacl as PACL, byval pTrustee as PTRUSTEE_A, byval pSuccessfulAuditedRights as PACCESS_MASK, byval pFailedAuditRights as PACCESS_MASK) as DWORD
#endif

declare function GetAuditedPermissionsFromAclW(byval pacl as PACL, byval pTrustee as PTRUSTEE_W, byval pSuccessfulAuditedRights as PACCESS_MASK, byval pFailedAuditRights as PACCESS_MASK) as DWORD

#ifdef UNICODE
	declare function GetAuditedPermissionsFromAcl alias "GetAuditedPermissionsFromAclW"(byval pacl as PACL, byval pTrustee as PTRUSTEE_W, byval pSuccessfulAuditedRights as PACCESS_MASK, byval pFailedAuditRights as PACCESS_MASK) as DWORD
#endif

declare function GetNamedSecurityInfoA(byval pObjectName as LPCSTR, byval ObjectType as SE_OBJECT_TYPE, byval SecurityInfo as SECURITY_INFORMATION, byval ppsidOwner as PSID ptr, byval ppsidGroup as PSID ptr, byval ppDacl as PACL ptr, byval ppSacl as PACL ptr, byval ppSecurityDescriptor as PSECURITY_DESCRIPTOR ptr) as DWORD

#ifndef UNICODE
	declare function GetNamedSecurityInfo alias "GetNamedSecurityInfoA"(byval pObjectName as LPCSTR, byval ObjectType as SE_OBJECT_TYPE, byval SecurityInfo as SECURITY_INFORMATION, byval ppsidOwner as PSID ptr, byval ppsidGroup as PSID ptr, byval ppDacl as PACL ptr, byval ppSacl as PACL ptr, byval ppSecurityDescriptor as PSECURITY_DESCRIPTOR ptr) as DWORD
#endif

declare function GetNamedSecurityInfoW(byval pObjectName as LPCWSTR, byval ObjectType as SE_OBJECT_TYPE, byval SecurityInfo as SECURITY_INFORMATION, byval ppsidOwner as PSID ptr, byval ppsidGroup as PSID ptr, byval ppDacl as PACL ptr, byval ppSacl as PACL ptr, byval ppSecurityDescriptor as PSECURITY_DESCRIPTOR ptr) as DWORD

#ifdef UNICODE
	declare function GetNamedSecurityInfo alias "GetNamedSecurityInfoW"(byval pObjectName as LPCWSTR, byval ObjectType as SE_OBJECT_TYPE, byval SecurityInfo as SECURITY_INFORMATION, byval ppsidOwner as PSID ptr, byval ppsidGroup as PSID ptr, byval ppDacl as PACL ptr, byval ppSacl as PACL ptr, byval ppSecurityDescriptor as PSECURITY_DESCRIPTOR ptr) as DWORD
#endif

declare function GetSecurityInfo(byval handle as HANDLE, byval ObjectType as SE_OBJECT_TYPE, byval SecurityInfo as SECURITY_INFORMATION, byval ppsidOwner as PSID ptr, byval ppsidGroup as PSID ptr, byval ppDacl as PACL ptr, byval ppSacl as PACL ptr, byval ppSecurityDescriptor as PSECURITY_DESCRIPTOR ptr) as DWORD
declare function SetNamedSecurityInfoA(byval pObjectName as LPSTR, byval ObjectType as SE_OBJECT_TYPE, byval SecurityInfo as SECURITY_INFORMATION, byval psidOwner as PSID, byval psidGroup as PSID, byval pDacl as PACL, byval pSacl as PACL) as DWORD

#ifndef UNICODE
	declare function SetNamedSecurityInfo alias "SetNamedSecurityInfoA"(byval pObjectName as LPSTR, byval ObjectType as SE_OBJECT_TYPE, byval SecurityInfo as SECURITY_INFORMATION, byval psidOwner as PSID, byval psidGroup as PSID, byval pDacl as PACL, byval pSacl as PACL) as DWORD
#endif

declare function SetNamedSecurityInfoW(byval pObjectName as LPWSTR, byval ObjectType as SE_OBJECT_TYPE, byval SecurityInfo as SECURITY_INFORMATION, byval psidOwner as PSID, byval psidGroup as PSID, byval pDacl as PACL, byval pSacl as PACL) as DWORD

#ifdef UNICODE
	declare function SetNamedSecurityInfo alias "SetNamedSecurityInfoW"(byval pObjectName as LPWSTR, byval ObjectType as SE_OBJECT_TYPE, byval SecurityInfo as SECURITY_INFORMATION, byval psidOwner as PSID, byval psidGroup as PSID, byval pDacl as PACL, byval pSacl as PACL) as DWORD
#endif

declare function SetSecurityInfo(byval handle as HANDLE, byval ObjectType as SE_OBJECT_TYPE, byval SecurityInfo as SECURITY_INFORMATION, byval psidOwner as PSID, byval psidGroup as PSID, byval pDacl as PACL, byval pSacl as PACL) as DWORD
declare function GetInheritanceSourceA(byval pObjectName as LPSTR, byval ObjectType as SE_OBJECT_TYPE, byval SecurityInfo as SECURITY_INFORMATION, byval Container as WINBOOL, byval pObjectClassGuids as GUID ptr ptr, byval GuidCount as DWORD, byval pAcl as PACL, byval pfnArray as PFN_OBJECT_MGR_FUNCTS, byval pGenericMapping as PGENERIC_MAPPING, byval pInheritArray as PINHERITED_FROMA) as DWORD

#ifndef UNICODE
	declare function GetInheritanceSource alias "GetInheritanceSourceA"(byval pObjectName as LPSTR, byval ObjectType as SE_OBJECT_TYPE, byval SecurityInfo as SECURITY_INFORMATION, byval Container as WINBOOL, byval pObjectClassGuids as GUID ptr ptr, byval GuidCount as DWORD, byval pAcl as PACL, byval pfnArray as PFN_OBJECT_MGR_FUNCTS, byval pGenericMapping as PGENERIC_MAPPING, byval pInheritArray as PINHERITED_FROMA) as DWORD
#endif

declare function GetInheritanceSourceW(byval pObjectName as LPWSTR, byval ObjectType as SE_OBJECT_TYPE, byval SecurityInfo as SECURITY_INFORMATION, byval Container as WINBOOL, byval pObjectClassGuids as GUID ptr ptr, byval GuidCount as DWORD, byval pAcl as PACL, byval pfnArray as PFN_OBJECT_MGR_FUNCTS, byval pGenericMapping as PGENERIC_MAPPING, byval pInheritArray as PINHERITED_FROMW) as DWORD

#ifdef UNICODE
	declare function GetInheritanceSource alias "GetInheritanceSourceW"(byval pObjectName as LPWSTR, byval ObjectType as SE_OBJECT_TYPE, byval SecurityInfo as SECURITY_INFORMATION, byval Container as WINBOOL, byval pObjectClassGuids as GUID ptr ptr, byval GuidCount as DWORD, byval pAcl as PACL, byval pfnArray as PFN_OBJECT_MGR_FUNCTS, byval pGenericMapping as PGENERIC_MAPPING, byval pInheritArray as PINHERITED_FROMW) as DWORD
#endif

declare function FreeInheritedFromArray(byval pInheritArray as PINHERITED_FROMW, byval AceCnt as USHORT, byval pfnArray as PFN_OBJECT_MGR_FUNCTS) as DWORD
declare function TreeResetNamedSecurityInfoA(byval pObjectName as LPSTR, byval ObjectType as SE_OBJECT_TYPE, byval SecurityInfo as SECURITY_INFORMATION, byval pOwner as PSID, byval pGroup as PSID, byval pDacl as PACL, byval pSacl as PACL, byval KeepExplicit as WINBOOL, byval fnProgress as FN_PROGRESS, byval ProgressInvokeSetting as PROG_INVOKE_SETTING, byval Args as PVOID) as DWORD

#ifndef UNICODE
	declare function TreeResetNamedSecurityInfo alias "TreeResetNamedSecurityInfoA"(byval pObjectName as LPSTR, byval ObjectType as SE_OBJECT_TYPE, byval SecurityInfo as SECURITY_INFORMATION, byval pOwner as PSID, byval pGroup as PSID, byval pDacl as PACL, byval pSacl as PACL, byval KeepExplicit as WINBOOL, byval fnProgress as FN_PROGRESS, byval ProgressInvokeSetting as PROG_INVOKE_SETTING, byval Args as PVOID) as DWORD
#endif

declare function TreeResetNamedSecurityInfoW(byval pObjectName as LPWSTR, byval ObjectType as SE_OBJECT_TYPE, byval SecurityInfo as SECURITY_INFORMATION, byval pOwner as PSID, byval pGroup as PSID, byval pDacl as PACL, byval pSacl as PACL, byval KeepExplicit as WINBOOL, byval fnProgress as FN_PROGRESS, byval ProgressInvokeSetting as PROG_INVOKE_SETTING, byval Args as PVOID) as DWORD

#ifdef UNICODE
	declare function TreeResetNamedSecurityInfo alias "TreeResetNamedSecurityInfoW"(byval pObjectName as LPWSTR, byval ObjectType as SE_OBJECT_TYPE, byval SecurityInfo as SECURITY_INFORMATION, byval pOwner as PSID, byval pGroup as PSID, byval pDacl as PACL, byval pSacl as PACL, byval KeepExplicit as WINBOOL, byval fnProgress as FN_PROGRESS, byval ProgressInvokeSetting as PROG_INVOKE_SETTING, byval Args as PVOID) as DWORD
#endif

declare function BuildSecurityDescriptorA(byval pOwner as PTRUSTEE_A, byval pGroup as PTRUSTEE_A, byval cCountOfAccessEntries as ULONG, byval pListOfAccessEntries as PEXPLICIT_ACCESS_A, byval cCountOfAuditEntries as ULONG, byval pListOfAuditEntries as PEXPLICIT_ACCESS_A, byval pOldSD as PSECURITY_DESCRIPTOR, byval pSizeNewSD as PULONG, byval pNewSD as PSECURITY_DESCRIPTOR ptr) as DWORD

#ifndef UNICODE
	declare function BuildSecurityDescriptor alias "BuildSecurityDescriptorA"(byval pOwner as PTRUSTEE_A, byval pGroup as PTRUSTEE_A, byval cCountOfAccessEntries as ULONG, byval pListOfAccessEntries as PEXPLICIT_ACCESS_A, byval cCountOfAuditEntries as ULONG, byval pListOfAuditEntries as PEXPLICIT_ACCESS_A, byval pOldSD as PSECURITY_DESCRIPTOR, byval pSizeNewSD as PULONG, byval pNewSD as PSECURITY_DESCRIPTOR ptr) as DWORD
#endif

declare function BuildSecurityDescriptorW(byval pOwner as PTRUSTEE_W, byval pGroup as PTRUSTEE_W, byval cCountOfAccessEntries as ULONG, byval pListOfAccessEntries as PEXPLICIT_ACCESS_W, byval cCountOfAuditEntries as ULONG, byval pListOfAuditEntries as PEXPLICIT_ACCESS_W, byval pOldSD as PSECURITY_DESCRIPTOR, byval pSizeNewSD as PULONG, byval pNewSD as PSECURITY_DESCRIPTOR ptr) as DWORD

#ifdef UNICODE
	declare function BuildSecurityDescriptor alias "BuildSecurityDescriptorW"(byval pOwner as PTRUSTEE_W, byval pGroup as PTRUSTEE_W, byval cCountOfAccessEntries as ULONG, byval pListOfAccessEntries as PEXPLICIT_ACCESS_W, byval cCountOfAuditEntries as ULONG, byval pListOfAuditEntries as PEXPLICIT_ACCESS_W, byval pOldSD as PSECURITY_DESCRIPTOR, byval pSizeNewSD as PULONG, byval pNewSD as PSECURITY_DESCRIPTOR ptr) as DWORD
#endif

declare function LookupSecurityDescriptorPartsA(byval ppOwner as PTRUSTEE_A ptr, byval ppGroup as PTRUSTEE_A ptr, byval pcCountOfAccessEntries as PULONG, byval ppListOfAccessEntries as PEXPLICIT_ACCESS_A ptr, byval pcCountOfAuditEntries as PULONG, byval ppListOfAuditEntries as PEXPLICIT_ACCESS_A ptr, byval pSD as PSECURITY_DESCRIPTOR) as DWORD

#ifndef UNICODE
	declare function LookupSecurityDescriptorParts alias "LookupSecurityDescriptorPartsA"(byval ppOwner as PTRUSTEE_A ptr, byval ppGroup as PTRUSTEE_A ptr, byval pcCountOfAccessEntries as PULONG, byval ppListOfAccessEntries as PEXPLICIT_ACCESS_A ptr, byval pcCountOfAuditEntries as PULONG, byval ppListOfAuditEntries as PEXPLICIT_ACCESS_A ptr, byval pSD as PSECURITY_DESCRIPTOR) as DWORD
#endif

declare function LookupSecurityDescriptorPartsW(byval ppOwner as PTRUSTEE_W ptr, byval ppGroup as PTRUSTEE_W ptr, byval pcCountOfAccessEntries as PULONG, byval ppListOfAccessEntries as PEXPLICIT_ACCESS_W ptr, byval pcCountOfAuditEntries as PULONG, byval ppListOfAuditEntries as PEXPLICIT_ACCESS_W ptr, byval pSD as PSECURITY_DESCRIPTOR) as DWORD

#ifdef UNICODE
	declare function LookupSecurityDescriptorParts alias "LookupSecurityDescriptorPartsW"(byval ppOwner as PTRUSTEE_W ptr, byval ppGroup as PTRUSTEE_W ptr, byval pcCountOfAccessEntries as PULONG, byval ppListOfAccessEntries as PEXPLICIT_ACCESS_W ptr, byval pcCountOfAuditEntries as PULONG, byval ppListOfAuditEntries as PEXPLICIT_ACCESS_W ptr, byval pSD as PSECURITY_DESCRIPTOR) as DWORD
#endif

declare sub BuildExplicitAccessWithNameA(byval pExplicitAccess as PEXPLICIT_ACCESS_A, byval pTrusteeName as LPSTR, byval AccessPermissions as DWORD, byval AccessMode as ACCESS_MODE, byval Inheritance as DWORD)

#ifndef UNICODE
	declare sub BuildExplicitAccessWithName alias "BuildExplicitAccessWithNameA"(byval pExplicitAccess as PEXPLICIT_ACCESS_A, byval pTrusteeName as LPSTR, byval AccessPermissions as DWORD, byval AccessMode as ACCESS_MODE, byval Inheritance as DWORD)
#endif

declare sub BuildExplicitAccessWithNameW(byval pExplicitAccess as PEXPLICIT_ACCESS_W, byval pTrusteeName as LPWSTR, byval AccessPermissions as DWORD, byval AccessMode as ACCESS_MODE, byval Inheritance as DWORD)

#ifdef UNICODE
	declare sub BuildExplicitAccessWithName alias "BuildExplicitAccessWithNameW"(byval pExplicitAccess as PEXPLICIT_ACCESS_W, byval pTrusteeName as LPWSTR, byval AccessPermissions as DWORD, byval AccessMode as ACCESS_MODE, byval Inheritance as DWORD)
#endif

declare sub BuildImpersonateExplicitAccessWithNameA(byval pExplicitAccess as PEXPLICIT_ACCESS_A, byval pTrusteeName as LPSTR, byval pTrustee as PTRUSTEE_A, byval AccessPermissions as DWORD, byval AccessMode as ACCESS_MODE, byval Inheritance as DWORD)

#ifndef UNICODE
	declare sub BuildImpersonateExplicitAccessWithName alias "BuildImpersonateExplicitAccessWithNameA"(byval pExplicitAccess as PEXPLICIT_ACCESS_A, byval pTrusteeName as LPSTR, byval pTrustee as PTRUSTEE_A, byval AccessPermissions as DWORD, byval AccessMode as ACCESS_MODE, byval Inheritance as DWORD)
#endif

declare sub BuildImpersonateExplicitAccessWithNameW(byval pExplicitAccess as PEXPLICIT_ACCESS_W, byval pTrusteeName as LPWSTR, byval pTrustee as PTRUSTEE_W, byval AccessPermissions as DWORD, byval AccessMode as ACCESS_MODE, byval Inheritance as DWORD)

#ifdef UNICODE
	declare sub BuildImpersonateExplicitAccessWithName alias "BuildImpersonateExplicitAccessWithNameW"(byval pExplicitAccess as PEXPLICIT_ACCESS_W, byval pTrusteeName as LPWSTR, byval pTrustee as PTRUSTEE_W, byval AccessPermissions as DWORD, byval AccessMode as ACCESS_MODE, byval Inheritance as DWORD)
#endif

declare sub BuildTrusteeWithNameA(byval pTrustee as PTRUSTEE_A, byval pName as LPSTR)

#ifndef UNICODE
	declare sub BuildTrusteeWithName alias "BuildTrusteeWithNameA"(byval pTrustee as PTRUSTEE_A, byval pName as LPSTR)
#endif

declare sub BuildTrusteeWithNameW(byval pTrustee as PTRUSTEE_W, byval pName as LPWSTR)

#ifdef UNICODE
	declare sub BuildTrusteeWithName alias "BuildTrusteeWithNameW"(byval pTrustee as PTRUSTEE_W, byval pName as LPWSTR)
#endif

declare sub BuildImpersonateTrusteeA(byval pTrustee as PTRUSTEE_A, byval pImpersonateTrustee as PTRUSTEE_A)

#ifndef UNICODE
	declare sub BuildImpersonateTrustee alias "BuildImpersonateTrusteeA"(byval pTrustee as PTRUSTEE_A, byval pImpersonateTrustee as PTRUSTEE_A)
#endif

declare sub BuildImpersonateTrusteeW(byval pTrustee as PTRUSTEE_W, byval pImpersonateTrustee as PTRUSTEE_W)

#ifdef UNICODE
	declare sub BuildImpersonateTrustee alias "BuildImpersonateTrusteeW"(byval pTrustee as PTRUSTEE_W, byval pImpersonateTrustee as PTRUSTEE_W)
#endif

declare sub BuildTrusteeWithSidA(byval pTrustee as PTRUSTEE_A, byval pSid as PSID)

#ifndef UNICODE
	declare sub BuildTrusteeWithSid alias "BuildTrusteeWithSidA"(byval pTrustee as PTRUSTEE_A, byval pSid as PSID)
#endif

declare sub BuildTrusteeWithSidW(byval pTrustee as PTRUSTEE_W, byval pSid as PSID)

#ifdef UNICODE
	declare sub BuildTrusteeWithSid alias "BuildTrusteeWithSidW"(byval pTrustee as PTRUSTEE_W, byval pSid as PSID)
#endif

declare sub BuildTrusteeWithObjectsAndSidA(byval pTrustee as PTRUSTEE_A, byval pObjSid as POBJECTS_AND_SID, byval pObjectGuid as GUID ptr, byval pInheritedObjectGuid as GUID ptr, byval pSid as PSID)

#ifndef UNICODE
	declare sub BuildTrusteeWithObjectsAndSid alias "BuildTrusteeWithObjectsAndSidA"(byval pTrustee as PTRUSTEE_A, byval pObjSid as POBJECTS_AND_SID, byval pObjectGuid as GUID ptr, byval pInheritedObjectGuid as GUID ptr, byval pSid as PSID)
#endif

declare sub BuildTrusteeWithObjectsAndSidW(byval pTrustee as PTRUSTEE_W, byval pObjSid as POBJECTS_AND_SID, byval pObjectGuid as GUID ptr, byval pInheritedObjectGuid as GUID ptr, byval pSid as PSID)

#ifdef UNICODE
	declare sub BuildTrusteeWithObjectsAndSid alias "BuildTrusteeWithObjectsAndSidW"(byval pTrustee as PTRUSTEE_W, byval pObjSid as POBJECTS_AND_SID, byval pObjectGuid as GUID ptr, byval pInheritedObjectGuid as GUID ptr, byval pSid as PSID)
#endif

declare sub BuildTrusteeWithObjectsAndNameA(byval pTrustee as PTRUSTEE_A, byval pObjName as POBJECTS_AND_NAME_A, byval ObjectType as SE_OBJECT_TYPE, byval ObjectTypeName as LPSTR, byval InheritedObjectTypeName as LPSTR, byval Name as LPSTR)

#ifndef UNICODE
	declare sub BuildTrusteeWithObjectsAndName alias "BuildTrusteeWithObjectsAndNameA"(byval pTrustee as PTRUSTEE_A, byval pObjName as POBJECTS_AND_NAME_A, byval ObjectType as SE_OBJECT_TYPE, byval ObjectTypeName as LPSTR, byval InheritedObjectTypeName as LPSTR, byval Name as LPSTR)
#endif

declare sub BuildTrusteeWithObjectsAndNameW(byval pTrustee as PTRUSTEE_W, byval pObjName as POBJECTS_AND_NAME_W, byval ObjectType as SE_OBJECT_TYPE, byval ObjectTypeName as LPWSTR, byval InheritedObjectTypeName as LPWSTR, byval Name as LPWSTR)

#ifdef UNICODE
	declare sub BuildTrusteeWithObjectsAndName alias "BuildTrusteeWithObjectsAndNameW"(byval pTrustee as PTRUSTEE_W, byval pObjName as POBJECTS_AND_NAME_W, byval ObjectType as SE_OBJECT_TYPE, byval ObjectTypeName as LPWSTR, byval InheritedObjectTypeName as LPWSTR, byval Name as LPWSTR)
#endif

declare function GetTrusteeNameA(byval pTrustee as PTRUSTEE_A) as LPSTR

#ifndef UNICODE
	declare function GetTrusteeName alias "GetTrusteeNameA"(byval pTrustee as PTRUSTEE_A) as LPSTR
#endif

declare function GetTrusteeNameW(byval pTrustee as PTRUSTEE_W) as LPWSTR

#ifdef UNICODE
	declare function GetTrusteeName alias "GetTrusteeNameW"(byval pTrustee as PTRUSTEE_W) as LPWSTR
#endif

declare function GetTrusteeTypeA(byval pTrustee as PTRUSTEE_A) as TRUSTEE_TYPE

#ifndef UNICODE
	declare function GetTrusteeType alias "GetTrusteeTypeA"(byval pTrustee as PTRUSTEE_A) as TRUSTEE_TYPE
#endif

declare function GetTrusteeTypeW(byval pTrustee as PTRUSTEE_W) as TRUSTEE_TYPE

#ifdef UNICODE
	declare function GetTrusteeType alias "GetTrusteeTypeW"(byval pTrustee as PTRUSTEE_W) as TRUSTEE_TYPE
#endif

declare function GetTrusteeFormA(byval pTrustee as PTRUSTEE_A) as TRUSTEE_FORM

#ifndef UNICODE
	declare function GetTrusteeForm alias "GetTrusteeFormA"(byval pTrustee as PTRUSTEE_A) as TRUSTEE_FORM
#endif

declare function GetTrusteeFormW(byval pTrustee as PTRUSTEE_W) as TRUSTEE_FORM

#ifdef UNICODE
	declare function GetTrusteeForm alias "GetTrusteeFormW"(byval pTrustee as PTRUSTEE_W) as TRUSTEE_FORM
#endif

declare function GetMultipleTrusteeOperationA(byval pTrustee as PTRUSTEE_A) as MULTIPLE_TRUSTEE_OPERATION

#ifndef UNICODE
	declare function GetMultipleTrusteeOperation alias "GetMultipleTrusteeOperationA"(byval pTrustee as PTRUSTEE_A) as MULTIPLE_TRUSTEE_OPERATION
#endif

declare function GetMultipleTrusteeOperationW(byval pTrustee as PTRUSTEE_W) as MULTIPLE_TRUSTEE_OPERATION

#ifdef UNICODE
	declare function GetMultipleTrusteeOperation alias "GetMultipleTrusteeOperationW"(byval pTrustee as PTRUSTEE_W) as MULTIPLE_TRUSTEE_OPERATION
#endif

declare function GetMultipleTrusteeA(byval pTrustee as PTRUSTEE_A) as PTRUSTEE_A

#ifndef UNICODE
	declare function GetMultipleTrustee alias "GetMultipleTrusteeA"(byval pTrustee as PTRUSTEE_A) as PTRUSTEE_A
#endif

declare function GetMultipleTrusteeW(byval pTrustee as PTRUSTEE_W) as PTRUSTEE_W

#ifdef UNICODE
	declare function GetMultipleTrustee alias "GetMultipleTrusteeW"(byval pTrustee as PTRUSTEE_W) as PTRUSTEE_W
#endif

#if _WIN32_WINNT >= &h0600
	declare function TreeSetNamedSecurityInfoA(byval pObjectName as LPSTR, byval ObjectType as SE_OBJECT_TYPE, byval SecurityInfo as SECURITY_INFORMATION, byval pOwner as PSID, byval pGroup as PSID, byval pDacl as PACL, byval pSacl as PACL, byval dwAction as DWORD, byval fnProgress as FN_PROGRESS, byval ProgressInvokeSetting as PROG_INVOKE_SETTING, byval Args as PVOID) as DWORD
#endif

#if (not defined(UNICODE)) and (_WIN32_WINNT >= &h0600)
	declare function TreeSetNamedSecurityInfo alias "TreeSetNamedSecurityInfoA"(byval pObjectName as LPSTR, byval ObjectType as SE_OBJECT_TYPE, byval SecurityInfo as SECURITY_INFORMATION, byval pOwner as PSID, byval pGroup as PSID, byval pDacl as PACL, byval pSacl as PACL, byval dwAction as DWORD, byval fnProgress as FN_PROGRESS, byval ProgressInvokeSetting as PROG_INVOKE_SETTING, byval Args as PVOID) as DWORD
#endif

#if _WIN32_WINNT >= &h0600
	declare function TreeSetNamedSecurityInfoW(byval pObjectName as LPWSTR, byval ObjectType as SE_OBJECT_TYPE, byval SecurityInfo as SECURITY_INFORMATION, byval pOwner as PSID, byval pGroup as PSID, byval pDacl as PACL, byval pSacl as PACL, byval dwAction as DWORD, byval fnProgress as FN_PROGRESS, byval ProgressInvokeSetting as PROG_INVOKE_SETTING, byval Args as PVOID) as DWORD
#endif

#if defined(UNICODE) and (_WIN32_WINNT >= &h0600)
	declare function TreeSetNamedSecurityInfo alias "TreeSetNamedSecurityInfoW"(byval pObjectName as LPWSTR, byval ObjectType as SE_OBJECT_TYPE, byval SecurityInfo as SECURITY_INFORMATION, byval pOwner as PSID, byval pGroup as PSID, byval pDacl as PACL, byval pSacl as PACL, byval dwAction as DWORD, byval fnProgress as FN_PROGRESS, byval ProgressInvokeSetting as PROG_INVOKE_SETTING, byval Args as PVOID) as DWORD
#endif

end extern
