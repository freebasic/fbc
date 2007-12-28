''
''
'' aclui -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_aclui_bi__
#define __win_aclui_bi__

#inclib "aclui"

#include once "win/objbase.bi"
#include once "win/commctrl.bi"
#include once "win/accctrl.bi"

type SI_OBJECT_INFO
	dwFlags as DWORD
	hInstance as HINSTANCE
	pszServerName as LPWSTR
	pszObjectName as LPWSTR
	pszPageTitle as LPWSTR
	guidObjectType as GUID
end type

type PSI_OBJECT_INFO as SI_OBJECT_INFO ptr

#define SI_EDIT_PERMS &h00000000L
#define SI_EDIT_OWNER &h00000001L
#define SI_EDIT_AUDITS &h00000002L
#define SI_CONTAINER &h00000004L
#define SI_READONLY &h00000008L
#define SI_ADVANCED &h00000010L
#define SI_RESET &h00000020L
#define SI_OWNER_READONLY &h00000040L
#define SI_EDIT_PROPERTIES &h00000080L
#define SI_OWNER_RECURSE &h00000100L
#define SI_NO_ACL_PROTECT &h00000200L
#define SI_NO_TREE_APPLY &h00000400L
#define SI_PAGE_TITLE &h00000800L
#define SI_SERVER_IS_DC &h00001000L
#define SI_RESET_DACL_TREE &h00004000L
#define SI_RESET_SACL_TREE &h00008000L
#define SI_OBJECT_GUID &h00010000L
#define SI_EDIT_EFFECTIVE &h00020000L
#define SI_RESET_DACL &h00040000L
#define SI_RESET_SACL &h00080000L
#define SI_RESET_OWNER &h00100000L
#define SI_NO_ADDITIONAL_PERMISSION &h00200000L
#define SI_MAY_WRITE &h10000000L
#define SI_EDIT_ALL (&h00000000L or &h00000001L or &h00000002L)

type SI_ACCESS
	pguid as GUID ptr
	mask as ACCESS_MASK
	pszName as LPCWSTR
	dwFlags as DWORD
end type

type PSI_ACCESS as SI_ACCESS ptr

#define SI_ACCESS_SPECIFIC &h00010000L
#define SI_ACCESS_GENERAL &h00020000L
#define SI_ACCESS_CONTAINER &h00040000L
#define SI_ACCESS_PROPERTY &h00080000L

type SI_INHERIT_TYPE
	pguid as GUID ptr
	dwFlags as ULONG
	pszName as LPCWSTR
end type

type PSI_INHERIT_TYPE as SI_INHERIT_TYPE ptr

enum SI_PAGE_TYPE
	SI_PAGE_PERM = 0
	SI_PAGE_ADVPERM
	SI_PAGE_AUDIT
	SI_PAGE_OWNER
end enum

#define PSPCB_SI_INITDIALOG (1024+1)

type ISecurityInformationVtbl_ as ISecurityInformationVtbl

type ISecurityInformation
	lpVtbl as ISecurityInformationVtbl_ ptr
end type

type ISecurityInformationVtbl
	QueryInterface as function(byval as ISecurityInformation ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as ISecurityInformation ptr) as ULONG
	Release as function(byval as ISecurityInformation ptr) as ULONG
	GetObjectInformation as function(byval as ISecurityInformation ptr, byval as PSI_OBJECT_INFO) as HRESULT
	GetSecurity as function(byval as ISecurityInformation ptr, byval as SECURITY_INFORMATION, byval as PSECURITY_DESCRIPTOR ptr, byval as BOOL) as HRESULT
	SetSecurity as function(byval as ISecurityInformation ptr, byval as SECURITY_INFORMATION, byval as PSECURITY_DESCRIPTOR) as HRESULT
	GetAccessRights as function(byval as ISecurityInformation ptr, byval as GUID ptr, byval as DWORD, byval as PSI_ACCESS ptr, byval as ULONG ptr, byval as ULONG ptr) as HRESULT
	MapGeneric as function(byval as ISecurityInformation ptr, byval as GUID ptr, byval as UCHAR ptr, byval as ACCESS_MASK ptr) as HRESULT
	GetInheritTypes as function(byval as ISecurityInformation ptr, byval as PSI_INHERIT_TYPE ptr, byval as ULONG ptr) as HRESULT
	PropertySheetPageCallback as function(byval as ISecurityInformation ptr, byval as HWND, byval as UINT, byval as SI_PAGE_TYPE) as HRESULT
end type

type LPSECURITYINFO as ISecurityInformation ptr

extern IID_ISecurityInformation alias "IID_ISecurityInformation" as IID

declare function CreateSecurityPage alias "CreateSecurityPage" (byval psi as LPSECURITYINFO) as HPROPSHEETPAGE
declare function EditSecurity alias "EditSecurity" (byval hwndOwner as HWND, byval psi as LPSECURITYINFO) as BOOL

#endif
