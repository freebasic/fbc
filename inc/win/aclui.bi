'' FreeBASIC binding for mingw-w64-v3.3.0

#pragma once

#inclib "aclui"

#include once "winapifamily.bi"
#include once "objbase.bi"
#include once "commctrl.bi"
#include once "accctrl.bi"
#include once "authz.bi"

extern "Windows"

#define _ACLUI_H_

type _SI_OBJECT_INFO
	dwFlags as DWORD
	hInstance as HINSTANCE
	pszServerName as LPWSTR
	pszObjectName as LPWSTR
	pszPageTitle as LPWSTR
	guidObjectType as GUID
end type

type SI_OBJECT_INFO as _SI_OBJECT_INFO
type PSI_OBJECT_INFO as _SI_OBJECT_INFO ptr
#define SI_EDIT_PERMS __MSABI_LONG(&h00000000)
#define SI_EDIT_OWNER __MSABI_LONG(&h00000001)
#define SI_EDIT_AUDITS __MSABI_LONG(&h00000002)
#define SI_CONTAINER __MSABI_LONG(&h00000004)
#define SI_READONLY __MSABI_LONG(&h00000008)
#define SI_ADVANCED __MSABI_LONG(&h00000010)
#define SI_RESET __MSABI_LONG(&h00000020)
#define SI_OWNER_READONLY __MSABI_LONG(&h00000040)
#define SI_EDIT_PROPERTIES __MSABI_LONG(&h00000080)
#define SI_OWNER_RECURSE __MSABI_LONG(&h00000100)
#define SI_NO_ACL_PROTECT __MSABI_LONG(&h00000200)
#define SI_NO_TREE_APPLY __MSABI_LONG(&h00000400)
#define SI_PAGE_TITLE __MSABI_LONG(&h00000800)
#define SI_SERVER_IS_DC __MSABI_LONG(&h00001000)
#define SI_RESET_DACL_TREE __MSABI_LONG(&h00004000)
#define SI_RESET_SACL_TREE __MSABI_LONG(&h00008000)
#define SI_OBJECT_GUID __MSABI_LONG(&h00010000)
#define SI_EDIT_EFFECTIVE __MSABI_LONG(&h00020000)
#define SI_RESET_DACL __MSABI_LONG(&h00040000)
#define SI_RESET_SACL __MSABI_LONG(&h00080000)
#define SI_RESET_OWNER __MSABI_LONG(&h00100000)
#define SI_NO_ADDITIONAL_PERMISSION __MSABI_LONG(&h00200000)

#if _WIN32_WINNT = &h0602
	#define SI_VIEW_ONLY __MSABI_LONG(&h00400000)
	#define SI_PERMS_ELEVATION_REQUIRED __MSABI_LONG(&h01000000)
	#define SI_AUDITS_ELEVATION_REQUIRED __MSABI_LONG(&h02000000)
	#define SI_OWNER_ELEVATION_REQUIRED __MSABI_LONG(&h04000000)
	#define SI_SCOPE_ELEVATION_REQUIRED __MSABI_LONG(&h08000000)
#endif

#define SI_MAY_WRITE __MSABI_LONG(&h10000000)

#if _WIN32_WINNT = &h0602
	#define SI_ENABLE_EDIT_ATTRIBUTE_CONDITION __MSABI_LONG(&h20000000)
	#define SI_ENABLE_CENTRAL_POLICY __MSABI_LONG(&h40000000)
	#define SI_DISABLE_DENY_ACE __MSABI_LONG(&h80000000)
#endif

#define SI_EDIT_ALL ((SI_EDIT_PERMS or SI_EDIT_OWNER) or SI_EDIT_AUDITS)

type _SI_ACCESS
	pguid as const GUID ptr
	mask as ACCESS_MASK
	pszName as LPCWSTR
	dwFlags as DWORD
end type

type SI_ACCESS as _SI_ACCESS
type PSI_ACCESS as _SI_ACCESS ptr
#define SI_ACCESS_SPECIFIC __MSABI_LONG(&h00010000)
#define SI_ACCESS_GENERAL __MSABI_LONG(&h00020000)
#define SI_ACCESS_CONTAINER __MSABI_LONG(&h00040000)
#define SI_ACCESS_PROPERTY __MSABI_LONG(&h00080000)

type _SI_INHERIT_TYPE
	pguid as const GUID ptr
	dwFlags as ULONG
	pszName as LPCWSTR
end type

type SI_INHERIT_TYPE as _SI_INHERIT_TYPE
type PSI_INHERIT_TYPE as _SI_INHERIT_TYPE ptr

type _SI_PAGE_TYPE as long
enum
	SI_PAGE_PERM = 0
	SI_PAGE_ADVPERM
	SI_PAGE_AUDIT
	SI_PAGE_OWNER
	SI_PAGE_EFFECTIVE

	#if _WIN32_WINNT = &h0602
		SI_PAGE_TAKEOWNERSHIP
		SI_PAGE_SHARE
	#endif
end enum

type SI_PAGE_TYPE as _SI_PAGE_TYPE

type _SI_PAGE_ACTIVATED as long
enum
	SI_SHOW_DEFAULT = 0
	SI_SHOW_PERM_ACTIVATED
	SI_SHOW_AUDIT_ACTIVATED
	SI_SHOW_OWNER_ACTIVATED
	SI_SHOW_EFFECTIVE_ACTIVATED
	SI_SHOW_SHARE_ACTIVATED
	SI_SHOW_CENTRAL_POLICY_ACTIVATED
end enum

type SI_PAGE_ACTIVATED as _SI_PAGE_ACTIVATED
#define GET_PAGE_TYPE(X) cast(UINT, (X) and &h0000ffff)
#define GET_ACTIVATION_TYPE(Y) cast(UINT, ((Y) shr 16) and &h0000ffff)
#define COMBINE_PAGE_ACTIVATION(X, Y) cast(UINT, ((Y) shl 16) or X)
#define DOBJ_RES_CONT __MSABI_LONG(&h00000001)
#define DOBJ_RES_ROOT __MSABI_LONG(&h00000002)
#define DOBJ_VOL_NTACLS __MSABI_LONG(&h00000004)
#define DOBJ_COND_NTACLS __MSABI_LONG(&h00000008)
#define DOBJ_RIBBON_LAUNCH __MSABI_LONG(&h00000010)
#define PSPCB_SI_INITDIALOG (WM_USER + 1)
type ISecurityInformationVtbl as ISecurityInformationVtbl_

type ISecurityInformation
	lpVtbl as ISecurityInformationVtbl ptr
end type

type ISecurityInformationVtbl_
	QueryInterface as function(byval This as ISecurityInformation ptr, byval riid as const IID const ptr, byval ppvObj as any ptr ptr) as HRESULT
	AddRef as function(byval This as ISecurityInformation ptr) as ULONG
	Release as function(byval This as ISecurityInformation ptr) as ULONG
	GetObjectInformation as function(byval This as ISecurityInformation ptr, byval pObjectInfo as PSI_OBJECT_INFO) as HRESULT
	GetSecurity as function(byval This as ISecurityInformation ptr, byval RequestedInformation as SECURITY_INFORMATION, byval ppSecurityDescriptor as PSECURITY_DESCRIPTOR ptr, byval fDefault as WINBOOL) as HRESULT
	SetSecurity as function(byval This as ISecurityInformation ptr, byval SecurityInformation as SECURITY_INFORMATION, byval pSecurityDescriptor as PSECURITY_DESCRIPTOR) as HRESULT
	GetAccessRights as function(byval This as ISecurityInformation ptr, byval pguidObjectType as const GUID ptr, byval dwFlags as DWORD, byval ppAccess as PSI_ACCESS ptr, byval pcAccesses as ULONG ptr, byval piDefaultAccess as ULONG ptr) as HRESULT
	MapGeneric as function(byval This as ISecurityInformation ptr, byval pguidObjectType as const GUID ptr, byval pAceFlags as UCHAR ptr, byval pMask as ACCESS_MASK ptr) as HRESULT
	GetInheritTypes as function(byval This as ISecurityInformation ptr, byval ppInheritTypes as PSI_INHERIT_TYPE ptr, byval pcInheritTypes as ULONG ptr) as HRESULT
	PropertySheetPageCallback as function(byval This as ISecurityInformation ptr, byval hwnd as HWND, byval uMsg as UINT, byval uPage as SI_PAGE_TYPE) as HRESULT
end type

type LPSECURITYINFO as ISecurityInformation ptr
type ISecurityInformation2Vtbl as ISecurityInformation2Vtbl_

type ISecurityInformation2
	lpVtbl as ISecurityInformation2Vtbl ptr
end type

type ISecurityInformation2Vtbl_
	QueryInterface as function(byval This as ISecurityInformation2 ptr, byval riid as const IID const ptr, byval ppvObj as any ptr ptr) as HRESULT
	AddRef as function(byval This as ISecurityInformation2 ptr) as ULONG
	Release as function(byval This as ISecurityInformation2 ptr) as ULONG
	IsDaclCanonical as function(byval This as ISecurityInformation2 ptr, byval pDacl as PACL) as WINBOOL
	LookupSids as function(byval This as ISecurityInformation2 ptr, byval cSids as ULONG, byval rgpSids as PSID ptr, byval ppdo as LPDATAOBJECT ptr) as HRESULT
end type

type LPSECURITYINFO2 as ISecurityInformation2 ptr
#define CFSTR_ACLUI_SID_INFO_LIST __TEXT("CFSTR_ACLUI_SID_INFO_LIST")

type _SID_INFO
	pSid as PSID
	pwzCommonName as PWSTR
	pwzClass as PWSTR
	pwzUPN as PWSTR
end type

type SID_INFO as _SID_INFO
type PSID_INFO as _SID_INFO ptr

type _SID_INFO_LIST
	cItems as ULONG
	aSidInfo(0 to 0) as SID_INFO
end type

type SID_INFO_LIST as _SID_INFO_LIST
type PSID_INFO_LIST as _SID_INFO_LIST ptr
type IEffectivePermissionVtbl as IEffectivePermissionVtbl_

type IEffectivePermission
	lpVtbl as IEffectivePermissionVtbl ptr
end type

type IEffectivePermissionVtbl_
	QueryInterface as function(byval This as IEffectivePermission ptr, byval riid as const IID const ptr, byval ppvObj as any ptr ptr) as HRESULT
	AddRef as function(byval This as IEffectivePermission ptr) as ULONG
	Release as function(byval This as IEffectivePermission ptr) as ULONG
	GetEffectivePermission as function(byval This as IEffectivePermission ptr, byval pguidObjectType as const GUID ptr, byval pUserSid as PSID, byval pszServerName as LPCWSTR, byval pSD as PSECURITY_DESCRIPTOR, byval ppObjectTypeList as POBJECT_TYPE_LIST ptr, byval pcObjectTypeListLength as ULONG ptr, byval ppGrantedAccessList as PACCESS_MASK ptr, byval pcGrantedAccessListLength as ULONG ptr) as HRESULT
end type

type LPEFFECTIVEPERMISSION as IEffectivePermission ptr
type ISecurityObjectTypeInfoVtbl as ISecurityObjectTypeInfoVtbl_

type ISecurityObjectTypeInfo
	lpVtbl as ISecurityObjectTypeInfoVtbl ptr
end type

type ISecurityObjectTypeInfoVtbl_
	QueryInterface as function(byval This as ISecurityObjectTypeInfo ptr, byval riid as const IID const ptr, byval ppvObj as any ptr ptr) as HRESULT
	AddRef as function(byval This as ISecurityObjectTypeInfo ptr) as ULONG
	Release as function(byval This as ISecurityObjectTypeInfo ptr) as ULONG
	GetInheritSource as function(byval si as SECURITY_INFORMATION, byval pACL as PACL, byval ppInheritArray as PINHERITED_FROM ptr) as HRESULT
end type

type LPSecurityObjectTypeInfo as ISecurityObjectTypeInfo ptr

#if _WIN32_WINNT = &h0602
	type ISecurityInformation3Vtbl as ISecurityInformation3Vtbl_

	type ISecurityInformation3
		lpVtbl as ISecurityInformation3Vtbl ptr
	end type

	type ISecurityInformation3Vtbl_
		QueryInterface as function(byval This as ISecurityInformation3 ptr, byval riid as const IID const ptr, byval ppvObj as any ptr ptr) as HRESULT
		AddRef as function(byval This as ISecurityInformation3 ptr) as ULONG
		Release as function(byval This as ISecurityInformation3 ptr) as ULONG
		GetFullResourceName as function(byval This as ISecurityInformation3 ptr, byval ppszResourceName as LPWSTR ptr) as HRESULT
		OpenElevatedEditor as function(byval This as ISecurityInformation3 ptr, byval hWnd as HWND, byval uPage as SI_PAGE_TYPE) as HRESULT
	end type

	type LPSECURITYINFO3 as ISecurityInformation3 ptr

	type _SECURITY_OBJECT
		pwszName as PWSTR
		pData as PVOID
		cbData as DWORD
		pData2 as PVOID
		cbData2 as DWORD
		Id as DWORD
		fWellKnown as BOOLEAN
	end type

	type SECURITY_OBJECT as _SECURITY_OBJECT
	type PSECURITY_OBJECT as _SECURITY_OBJECT ptr
	const SECURITY_OBJECT_ID_OBJECT_SD = 1
	const SECURITY_OBJECT_ID_SHARE = 2
	const SECURITY_OBJECT_ID_CENTRAL_POLICY = 3
	const SECURITY_OBJECT_ID_CENTRAL_ACCESS_RULE = 4

	type _EFFPERM_RESULT_LIST
		fEvaluated as BOOLEAN
		cObjectTypeListLength as ULONG
		pObjectTypeList as OBJECT_TYPE_LIST ptr
		pGrantedAccessList as ACCESS_MASK ptr
	end type

	type EFFPERM_RESULT_LIST as _EFFPERM_RESULT_LIST
	type PEFFPERM_RESULT_LIST as _EFFPERM_RESULT_LIST ptr
	type ISecurityInformation4Vtbl as ISecurityInformation4Vtbl_

	type ISecurityInformation4
		lpVtbl as ISecurityInformation4Vtbl ptr
	end type

	type ISecurityInformation4Vtbl_
		QueryInterface as function(byval This as ISecurityInformation4 ptr, byval riid as const IID const ptr, byval ppvObj as any ptr ptr) as HRESULT
		AddRef as function(byval This as ISecurityInformation4 ptr) as ULONG
		Release as function(byval This as ISecurityInformation4 ptr) as ULONG
		GetSecondarySecurity as function(byval This as ISecurityInformation4 ptr, byval pSecurityObjects as PSECURITY_OBJECT ptr, byval pSecurityObjectCount as PULONG) as HRESULT
	end type

	type LPSECURITYINFO4 as ISecurityInformation4 ptr
	type IEffectivePermission2Vtbl as IEffectivePermission2Vtbl_

	type IEffectivePermission2
		lpVtbl as IEffectivePermission2Vtbl ptr
	end type

	type IEffectivePermission2Vtbl_
		QueryInterface as function(byval This as IEffectivePermission ptr, byval riid as const IID const ptr, byval ppvObj as any ptr ptr) as HRESULT
		AddRef as function(byval This as IEffectivePermission ptr) as ULONG
		Release as function(byval This as IEffectivePermission ptr) as ULONG
		ComputeEffectivePermissionWithSecondarySecurity as function(byval This as IEffectivePermission ptr, byval pSid as PSID, byval pDeviceSid as PSID, byval pszServerName as PCWSTR, byval pSecurityObjects as PSECURITY_OBJECT, byval dwSecurityObjectCount as DWORD, byval pUserGroups as PTOKEN_GROUPS, byval pAuthzUserGroupsOperations as PAUTHZ_SID_OPERATION, byval pDeviceGroups as PTOKEN_GROUPS, byval pAuthzDeviceGroupsOperations as PAUTHZ_SID_OPERATION, byval pAuthzUserClaims as PAUTHZ_SECURITY_ATTRIBUTES_INFORMATION, byval pAuthzUserClaimsOperations as PAUTHZ_SECURITY_ATTRIBUTE_OPERATION, byval pAuthzDeviceClaims as PAUTHZ_SECURITY_ATTRIBUTES_INFORMATION, byval pAuthzDeviceClaimsOperations as PAUTHZ_SECURITY_ATTRIBUTE_OPERATION, byval pEffpermResultLists as PEFFPERM_RESULT_LIST) as HRESULT
	end type

	type LPEFFECTIVEPERMISSION2 as IEffectivePermission2 ptr
#endif

extern IID_ISecurityInformation as const IID
extern IID_ISecurityInformation2 as const IID
extern IID_IEffectivePermission as const IID
extern IID_ISecurityObjectTypeInfo as const IID

#if _WIN32_WINNT = &h0602
	extern IID_ISecurityInformation3 as const IID
	extern IID_ISecurityInformation4 as const IID
	extern IID_IEffectivePermission2 as const IID
#endif

declare function CreateSecurityPage(byval psi as LPSECURITYINFO) as HPROPSHEETPAGE
declare function EditSecurity(byval hwndOwner as HWND, byval psi as LPSECURITYINFO) as WINBOOL

#if _WIN32_WINNT = &h0602
	declare function EditSecurityAdvanced(byval hwndOwner as HWND, byval psi as LPSECURITYINFO, byval uSIPage as SI_PAGE_TYPE) as HRESULT
#endif

end extern
