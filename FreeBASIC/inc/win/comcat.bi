''
''
'' comcat -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_comcat_bi__
#define __win_comcat_bi__

#inclib "uuid"

#include once "windows.bi"
#include once "win/ole2.bi"

extern IID_IEnumGUID alias "IID_IEnumGUID" as IID

type IEnumGUIDVtbl_ as IEnumGUIDVtbl

type IEnumGUID
	lpVtbl as IEnumGUIDVtbl_ ptr
end type

type LPENUMGUID as IEnumGUID ptr

type IEnumGUIDVtbl
	QueryInterface as function(byval as IEnumGUID ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IEnumGUID ptr) as ULONG
	Release as function(byval as IEnumGUID ptr) as ULONG
	Next as function(byval as IEnumGUID ptr, byval as ULONG, byval as GUID ptr, byval as ULONG ptr) as HRESULT
	Skip as function(byval as IEnumGUID ptr, byval as ULONG) as HRESULT
	Reset as function(byval as IEnumGUID ptr) as HRESULT
	Clone as function(byval as IEnumGUID ptr, byval as LPENUMGUID ptr) as HRESULT
end type

type CATID as GUID
type REFCATID as GUID ptr

type CATEGORYINFO
	catid as CATID
	lcid as LCID
	szDescription(0 to 128-1) as OLECHAR
end type

type LPCATEGORYINFO as CATEGORYINFO ptr

extern CATID_Insertable alias "CATID_Insertable" as CATID
extern CATID_Control alias "CATID_Control" as CATID
extern CATID_Programmable alias "CATID_Programmable" as CATID
extern CATID_IsShortcut alias "CATID_IsShortcut" as CATID
extern CATID_NeverShowExt alias "CATID_NeverShowExt" as CATID
extern CATID_DocObject alias "CATID_DocObject" as CATID
extern CATID_Printable alias "CATID_Printable" as CATID
extern CATID_RequiresDataPathHost alias "CATID_RequiresDataPathHost" as CATID
extern CATID_PersistsToMoniker alias "CATID_PersistsToMoniker" as CATID
extern CATID_PersistsToStorage alias "CATID_PersistsToStorage" as CATID
extern CATID_PersistsToStreamInit alias "CATID_PersistsToStreamInit" as CATID
extern CATID_PersistsToStream alias "CATID_PersistsToStream" as CATID
extern CATID_PersistsToMemory alias "CATID_PersistsToMemory" as CATID
extern CATID_PersistsToFile alias "CATID_PersistsToFile" as CATID
extern CATID_PersistsToPropertyBag alias "CATID_PersistsToPropertyBag" as CATID
extern CATID_InternetAware alias "CATID_InternetAware" as CATID
extern CATID_DesignTimeUIActivatableControl alias "CATID_DesignTimeUIActivatableControl" as CATID
extern IID_ICatInformation alias "IID_ICatInformation" as IID

#define IEnumCATID IEnumGUID
#define LPENUMCATID LPENUMGUID
#define IID_IEnumCATID IID_IEnumGUID

#define IEnumCLSID IEnumGUID
#define LPENUMCLSID LPENUMGUID
#define IID_IEnumCLSID IID_IEnumGUID

type LPCATINFORMATION as ICatInformation ptr
extern IID_ICatRegister alias "IID_ICatRegister" as IID

type LPCATREGISTER as ICatRegister ptr
extern IID_IEnumCATEGORYINFO alias "IID_IEnumCATEGORYINFO" as IID

type LPENUMCATEGORYINFO as IEnumCATEGORYINFO ptr
extern CLSID_StdComponentCategoriesMgr alias "CLSID_StdComponentCategoriesMgr" as CLSID

type ICatInformationVtbl_ as ICatInformationVtbl

type ICatInformation
	lpVtbl as ICatInformationVtbl_ ptr
end type

type ICatInformationVtbl
	QueryInterface as function(byval as ICatInformation ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as ICatInformation ptr) as ULONG
	Release as function(byval as ICatInformation ptr) as ULONG
	EnumCategories as function(byval as ICatInformation ptr, byval as LCID, byval as LPENUMCATEGORYINFO ptr) as HRESULT
	GetCategoryDesc as function(byval as ICatInformation ptr, byval as REFCATID, byval as LCID, byval as PWCHAR ptr) as HRESULT
	EnumClassesOfCategories as function(byval as ICatInformation ptr, byval as ULONG, byval as CATID ptr, byval as ULONG, byval as CATID ptr, byval as LPENUMGUID ptr) as HRESULT
	IsClassOfCategories as function(byval as ICatInformation ptr, byval as CLSID ptr, byval as ULONG, byval as CATID ptr, byval as ULONG, byval as CATID ptr) as HRESULT
	EnumImplCategoriesOfClass as function(byval as ICatInformation ptr, byval as CLSID ptr, byval as LPENUMGUID ptr) as HRESULT
	EnumReqCategoriesOfClass as function(byval as ICatInformation ptr, byval as CLSID ptr, byval as LPENUMGUID ptr) as HRESULT
end type

#define ICatInformation_QueryInterface(p,a,b) (p)->lpVtbl->QueryInterface(p,a,b)
#define ICatInformation_AddRef(p)             (p)->lpVtbl->AddRef(p)
#define ICatInformation_Release(p)            (p)->lpVtbl->Release(p)
#define ICatInformation_EnumCategories(p,a,b) (p)->lpVtbl->EnumCategories(p,a,b)
#define ICatInformation_GetCategoryDesc(p,a,b,c) (p)->lpVtbl->GetCategoryDesc(p,a,b,c)
#define ICatInformation_EnumClassesOfCategories(p,a,b,c,d,e) (p)->lpVtbl->EnumClassesOfCategories(p,a,b,c,d,e)
#define ICatInformation_IsClassOfCategories(p,a,b,c,d,e) (p)->lpVtbl->IsClassOfCategories(p,a,b,c,d,e)
#define ICatInformation_EnumImplCategoriesOfClass(p,a,b) (p)->lpVtbl->EnumImplCategoriesOfClass(p,a,b)
#define ICatInformation_EnumReqCategoriesOfClass(p,a,b) (p)->lpVtbl->EnumReqCategoriesOfClass(p,a,b)

type ICatRegisterVtbl_ as ICatRegisterVtbl

type ICatRegister
	lpVtbl as ICatRegisterVtbl_ ptr
end type

type ICatRegisterVtbl
	QueryInterface as function(byval as ICatRegister ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as ICatRegister ptr) as ULONG
	Release as function(byval as ICatRegister ptr) as ULONG
	RegisterCategories as function(byval as ICatRegister ptr, byval as ULONG, byval as CATEGORYINFO ptr) as HRESULT
	UnRegisterCategories as function(byval as ICatRegister ptr, byval as ULONG, byval as CATID ptr) as HRESULT
	RegisterClassImplCategories as function(byval as ICatRegister ptr, byval as CLSID ptr, byval as ULONG, byval as CATID ptr) as HRESULT
	UnRegisterClassImplCategories as function(byval as ICatRegister ptr, byval as CLSID ptr, byval as ULONG, byval as CATID ptr) as HRESULT
	RegisterClassReqCategories as function(byval as ICatRegister ptr, byval as CLSID ptr, byval as ULONG, byval as CATID ptr) as HRESULT
	UnRegisterClassReqCategories as function(byval as ICatRegister ptr, byval as CLSID ptr, byval as ULONG, byval as CATID ptr) as HRESULT
end type
extern IID_IEnumCATEGORYINFO alias "IID_IEnumCATEGORYINFO" as IID

#define ICatRegister_QueryInterface(p,a,b) (p)->lpVtbl->QueryInterface(p,a,b)
#define ICatRegister_AddRef(p)             (p)->lpVtbl->AddRef(p)
#define ICatRegister_Release(p)            (p)->lpVtbl->Release(p)
#define ICatRegister_RegisterCategories(p,a,b) (p)->lpVtbl->RegisterCategories(p,a,b)
#define ICatRegister_UnRegisterCategories(p,a,b) (p)->lpVtbl->UnRegisterCategories(p,a,b)
#define ICatRegister_RegisterClassImplCategories(p,a,b,c) (p)->lpVtbl->RegisterClassImplCategories(p,a,b,c)
#define ICatRegister_UnRegisterClassImplCategories(p,a,b,c) (p)->lpVtbl->UnRegisterClassImplCategories(p,a,b,c)
#define ICatRegister_RegisterClassReqCategories(p,a,b,c) (p)->lpVtbl->RegisterClassReqCategories(p,a,b,c)
#define ICatRegister_UnRegisterClassReqCategories(p,a,b,c) (p)->lpVtbl->UnRegisterClassReqCategories(p,a,b,c)

type IEnumCATEGORYINFOVtbl_ as IEnumCATEGORYINFOVtbl

type IEnumCATEGORYINFO
	lpVtbl as IEnumCATEGORYINFOVtbl_ ptr
end type

type IEnumCATEGORYINFOVtbl
	QueryInterface as function(byval as IEnumCATEGORYINFO ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IEnumCATEGORYINFO ptr) as ULONG
	Release as function(byval as IEnumCATEGORYINFO ptr) as ULONG
	Next as function(byval as IEnumCATEGORYINFO ptr, byval as ULONG, byval as CATEGORYINFO ptr, byval as ULONG ptr) as HRESULT
	Skip as function(byval as IEnumCATEGORYINFO ptr, byval as ULONG) as HRESULT
	Reset as function(byval as IEnumCATEGORYINFO ptr) as HRESULT
	Clone as function(byval as IEnumCATEGORYINFO ptr, byval as LPENUMCATEGORYINFO ptr) as HRESULT
end type

#define IEnumCATEGORYINFO_QueryInterface(p,a,b) (p)->lpVtbl->QueryInterface(p,a,b)
#define IEnumCATEGORYINFO_AddRef(p)             (p)->lpVtbl->AddRef(p)
#define IEnumCATEGORYINFO_Release(p)            (p)->lpVtbl->Release(p)
#define IEnumCATEGORYINFO_Next(p,a,b,c)         (p)->lpVtbl->Next(p,a,b,c)
#define IEnumCATEGORYINFO_Skip(p,a)             (p)->lpVtbl->Skip(p,a)
#define IEnumCATEGORYINFO_Reset(p)              (p)->lpVtbl->Reset(p)
#define IEnumCATEGORYINFO_Clone(p,a)            (p)->lpVtbl->Clone(p,a)

#endif
