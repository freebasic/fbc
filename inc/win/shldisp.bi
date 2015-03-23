#pragma once

#include once "rpc.bi"
#include once "rpcndr.bi"
#include once "windows.bi"
#include once "ole2.bi"
#include once "ocidl.bi"

extern "Windows"

#define __shldisp_h__
#define __IFolderViewOC_FWD_DEFINED__
#define __DShellFolderViewEvents_FWD_DEFINED__
#define __ShellFolderViewOC_FWD_DEFINED__
#define __DFConstraint_FWD_DEFINED__
#define __ISearchCommandExt_FWD_DEFINED__
#define __FolderItem_FWD_DEFINED__
#define __FolderItems_FWD_DEFINED__
#define __FolderItemVerb_FWD_DEFINED__
#define __FolderItemVerbs_FWD_DEFINED__
#define __Folder_FWD_DEFINED__
#define __Folder2_FWD_DEFINED__
#define __Folder3_FWD_DEFINED__
#define __FolderItem2_FWD_DEFINED__
#define __ShellFolderItem_FWD_DEFINED__
#define __FolderItems2_FWD_DEFINED__
#define __FolderItems3_FWD_DEFINED__
#define __IShellLinkDual_FWD_DEFINED__
#define __IShellLinkDual2_FWD_DEFINED__
#define __ShellLinkObject_FWD_DEFINED__
#define __IShellFolderViewDual_FWD_DEFINED__
#define __IShellFolderViewDual2_FWD_DEFINED__
#define __ShellFolderView_FWD_DEFINED__
#define __IShellDispatch_FWD_DEFINED__
#define __IShellDispatch2_FWD_DEFINED__
#define __IShellDispatch3_FWD_DEFINED__
#define __IShellDispatch4_FWD_DEFINED__
#define __Shell_FWD_DEFINED__
#define __ShellDispatchInproc_FWD_DEFINED__
#define __WebViewFolderContents_FWD_DEFINED__
#define __DSearchCommandEvents_FWD_DEFINED__
#define __SearchCommand_FWD_DEFINED__
#define __IFileSearchBand_FWD_DEFINED__
#define __FileSearchBand_FWD_DEFINED__
#define __IWebWizardHost_FWD_DEFINED__
#define __INewWDEvents_FWD_DEFINED__
#define __IPassportClientServices_FWD_DEFINED__
#define __PassportClientServices_FWD_DEFINED__
#define __IAutoComplete_FWD_DEFINED__
#define __IAutoComplete2_FWD_DEFINED__
#define __IEnumACString_FWD_DEFINED__
#define __IAsyncOperation_FWD_DEFINED__
extern __MIDL_itf_shldisp_0000_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_shldisp_0000_v0_0_s_ifspec as RPC_IF_HANDLE
#define __Shell32_LIBRARY_DEFINED__

type SearchCommandExecuteErrors as long
enum
	SCEE_PATHNOTFOUND = 1
	SCEE_MAXFILESFOUND
	SCEE_INDEXSEARCH
	SCEE_CONSTRAINT
	SCEE_SCOPEMISMATCH
	SCEE_CASESENINDEX
	SCEE_INDEXNOTCOMPLETE
end enum

type OfflineFolderStatus as long
enum
	OFS_INACTIVE = -1
	OFS_ONLINE = 0
	OFS_OFFLINE
	OFS_SERVERBACK
	OFS_DIRTYCACHE
end enum

type ShellFolderViewOptions as long
enum
	SFVVO_SHOWALLOBJECTS = &h1
	SFVVO_SHOWEXTENSIONS = &h2
	SFVVO_SHOWCOMPCOLOR = &h8
	SFVVO_SHOWSYSFILES = &h20
	SFVVO_WIN95CLASSIC = &h40
	SFVVO_DOUBLECLICKINWEBVIEW = &h80
	SFVVO_DESKTOPHTML = &h200
end enum

type ShellSpecialFolderConstants as long
enum
	ssfDESKTOP = 0
	ssfPROGRAMS = &h2
	ssfCONTROLS = &h3
	ssfPRINTERS = &h4
	ssfPERSONAL = &h5
	ssfFAVORITES = &h6
	ssfSTARTUP = &h7
	ssfRECENT = &h8
	ssfSENDTO = &h9
	ssfBITBUCKET = &ha
	ssfSTARTMENU = &hb
	ssfDESKTOPDIRECTORY = &h10
	ssfDRIVES = &h11
	ssfNETWORK = &h12
	ssfNETHOOD = &h13
	ssfFONTS = &h14
	ssfTEMPLATES = &h15
	ssfCOMMONSTARTMENU = &h16
	ssfCOMMONPROGRAMS = &h17
	ssfCOMMONSTARTUP = &h18
	ssfCOMMONDESKTOPDIR = &h19
	ssfAPPDATA = &h1a
	ssfPRINTHOOD = &h1b
	ssfLOCALAPPDATA = &h1c
	ssfALTSTARTUP = &h1d
	ssfCOMMONALTSTARTUP = &h1e
	ssfCOMMONFAVORITES = &h1f
	ssfINTERNETCACHE = &h20
	ssfCOOKIES = &h21
	ssfHISTORY = &h22
	ssfCOMMONAPPDATA = &h23
	ssfWINDOWS = &h24
	ssfSYSTEM = &h25
	ssfPROGRAMFILES = &h26
	ssfMYPICTURES = &h27
	ssfPROFILE = &h28
	ssfSYSTEMx86 = &h29
	ssfPROGRAMFILESx86 = &h30
end enum

extern LIBID_Shell32 as const IID
#define __IFolderViewOC_INTERFACE_DEFINED__
extern IID_IFolderViewOC as const IID
type IFolderViewOC as IFolderViewOC_

type IFolderViewOCVtbl
	QueryInterface as function(byval This as IFolderViewOC ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IFolderViewOC ptr) as ULONG
	Release as function(byval This as IFolderViewOC ptr) as ULONG
	GetTypeInfoCount as function(byval This as IFolderViewOC ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IFolderViewOC ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IFolderViewOC ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IFolderViewOC ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	SetFolderView as function(byval This as IFolderViewOC ptr, byval pdisp as IDispatch ptr) as HRESULT
end type

type IFolderViewOC_
	lpVtbl as IFolderViewOCVtbl ptr
end type

declare function IFolderViewOC_SetFolderView_Proxy(byval This as IFolderViewOC ptr, byval pdisp as IDispatch ptr) as HRESULT
declare sub IFolderViewOC_SetFolderView_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __DShellFolderViewEvents_DISPINTERFACE_DEFINED__
extern DIID_DShellFolderViewEvents as const IID
type DShellFolderViewEvents as DShellFolderViewEvents_

type DShellFolderViewEventsVtbl
	QueryInterface as function(byval This as DShellFolderViewEvents ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as DShellFolderViewEvents ptr) as ULONG
	Release as function(byval This as DShellFolderViewEvents ptr) as ULONG
	GetTypeInfoCount as function(byval This as DShellFolderViewEvents ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as DShellFolderViewEvents ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as DShellFolderViewEvents ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as DShellFolderViewEvents ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
end type

type DShellFolderViewEvents_
	lpVtbl as DShellFolderViewEventsVtbl ptr
end type

extern CLSID_ShellFolderViewOC as const CLSID
#define __DFConstraint_INTERFACE_DEFINED__
extern IID_DFConstraint as const IID
type DFConstraint as DFConstraint_

type DFConstraintVtbl
	QueryInterface as function(byval This as DFConstraint ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as DFConstraint ptr) as ULONG
	Release as function(byval This as DFConstraint ptr) as ULONG
	GetTypeInfoCount as function(byval This as DFConstraint ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as DFConstraint ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as DFConstraint ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as DFConstraint ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	get_Name as function(byval This as DFConstraint ptr, byval pbs as BSTR ptr) as HRESULT
	get_Value as function(byval This as DFConstraint ptr, byval pv as VARIANT ptr) as HRESULT
end type

type DFConstraint_
	lpVtbl as DFConstraintVtbl ptr
end type

declare function DFConstraint_get_Name_Proxy(byval This as DFConstraint ptr, byval pbs as BSTR ptr) as HRESULT
declare sub DFConstraint_get_Name_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function DFConstraint_get_Value_Proxy(byval This as DFConstraint ptr, byval pv as VARIANT ptr) as HRESULT
declare sub DFConstraint_get_Value_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __ISearchCommandExt_INTERFACE_DEFINED__

type __MIDL_ISearchCommandExt_0001 as long
enum
	SCE_SEARCHFORFILES = 0
	SCE_SEARCHFORCOMPUTERS = 1
end enum

type SEARCH_FOR_TYPE as __MIDL_ISearchCommandExt_0001
extern IID_ISearchCommandExt as const IID
type ISearchCommandExt as ISearchCommandExt_

type ISearchCommandExtVtbl
	QueryInterface as function(byval This as ISearchCommandExt ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as ISearchCommandExt ptr) as ULONG
	Release as function(byval This as ISearchCommandExt ptr) as ULONG
	GetTypeInfoCount as function(byval This as ISearchCommandExt ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as ISearchCommandExt ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as ISearchCommandExt ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as ISearchCommandExt ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	ClearResults as function(byval This as ISearchCommandExt ptr) as HRESULT
	NavigateToSearchResults as function(byval This as ISearchCommandExt ptr) as HRESULT
	get_ProgressText as function(byval This as ISearchCommandExt ptr, byval pbs as BSTR ptr) as HRESULT
	SaveSearch as function(byval This as ISearchCommandExt ptr) as HRESULT
	GetErrorInfo as function(byval This as ISearchCommandExt ptr, byval pbs as BSTR ptr, byval phr as long ptr) as HRESULT
	SearchFor as function(byval This as ISearchCommandExt ptr, byval iFor as long) as HRESULT
	GetScopeInfo as function(byval This as ISearchCommandExt ptr, byval bsScope as BSTR, byval pdwScopeInfo as long ptr) as HRESULT
	RestoreSavedSearch as function(byval This as ISearchCommandExt ptr, byval pvarFile as VARIANT ptr) as HRESULT
	Execute as function(byval This as ISearchCommandExt ptr, byval RecordsAffected as VARIANT ptr, byval Parameters as VARIANT ptr, byval Options as long) as HRESULT
	AddConstraint as function(byval This as ISearchCommandExt ptr, byval Name as BSTR, byval Value as VARIANT) as HRESULT
	GetNextConstraint as function(byval This as ISearchCommandExt ptr, byval fReset as VARIANT_BOOL, byval ppdfc as DFConstraint ptr ptr) as HRESULT
end type

type ISearchCommandExt_
	lpVtbl as ISearchCommandExtVtbl ptr
end type

declare function ISearchCommandExt_ClearResults_Proxy(byval This as ISearchCommandExt ptr) as HRESULT
declare sub ISearchCommandExt_ClearResults_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ISearchCommandExt_NavigateToSearchResults_Proxy(byval This as ISearchCommandExt ptr) as HRESULT
declare sub ISearchCommandExt_NavigateToSearchResults_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ISearchCommandExt_get_ProgressText_Proxy(byval This as ISearchCommandExt ptr, byval pbs as BSTR ptr) as HRESULT
declare sub ISearchCommandExt_get_ProgressText_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ISearchCommandExt_SaveSearch_Proxy(byval This as ISearchCommandExt ptr) as HRESULT
declare sub ISearchCommandExt_SaveSearch_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ISearchCommandExt_GetErrorInfo_Proxy(byval This as ISearchCommandExt ptr, byval pbs as BSTR ptr, byval phr as long ptr) as HRESULT
declare sub ISearchCommandExt_GetErrorInfo_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ISearchCommandExt_SearchFor_Proxy(byval This as ISearchCommandExt ptr, byval iFor as long) as HRESULT
declare sub ISearchCommandExt_SearchFor_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ISearchCommandExt_GetScopeInfo_Proxy(byval This as ISearchCommandExt ptr, byval bsScope as BSTR, byval pdwScopeInfo as long ptr) as HRESULT
declare sub ISearchCommandExt_GetScopeInfo_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ISearchCommandExt_RestoreSavedSearch_Proxy(byval This as ISearchCommandExt ptr, byval pvarFile as VARIANT ptr) as HRESULT
declare sub ISearchCommandExt_RestoreSavedSearch_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ISearchCommandExt_Execute_Proxy(byval This as ISearchCommandExt ptr, byval RecordsAffected as VARIANT ptr, byval Parameters as VARIANT ptr, byval Options as long) as HRESULT
declare sub ISearchCommandExt_Execute_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ISearchCommandExt_AddConstraint_Proxy(byval This as ISearchCommandExt ptr, byval Name as BSTR, byval Value as VARIANT) as HRESULT
declare sub ISearchCommandExt_AddConstraint_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function ISearchCommandExt_GetNextConstraint_Proxy(byval This as ISearchCommandExt ptr, byval fReset as VARIANT_BOOL, byval ppdfc as DFConstraint ptr ptr) as HRESULT
declare sub ISearchCommandExt_GetNextConstraint_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __FolderItem_INTERFACE_DEFINED__
type FolderItem as FolderItem_
type LPFOLDERITEM as FolderItem ptr
extern IID_FolderItem as const IID
type FolderItemVerbs as FolderItemVerbs_

type FolderItemVtbl
	QueryInterface as function(byval This as FolderItem ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as FolderItem ptr) as ULONG
	Release as function(byval This as FolderItem ptr) as ULONG
	GetTypeInfoCount as function(byval This as FolderItem ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as FolderItem ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as FolderItem ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as FolderItem ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	get_Application as function(byval This as FolderItem ptr, byval ppid as IDispatch ptr ptr) as HRESULT
	get_Parent as function(byval This as FolderItem ptr, byval ppid as IDispatch ptr ptr) as HRESULT
	get_Name as function(byval This as FolderItem ptr, byval pbs as BSTR ptr) as HRESULT
	put_Name as function(byval This as FolderItem ptr, byval bs as BSTR) as HRESULT
	get_Path as function(byval This as FolderItem ptr, byval pbs as BSTR ptr) as HRESULT
	get_GetLink as function(byval This as FolderItem ptr, byval ppid as IDispatch ptr ptr) as HRESULT
	get_GetFolder as function(byval This as FolderItem ptr, byval ppid as IDispatch ptr ptr) as HRESULT
	get_IsLink as function(byval This as FolderItem ptr, byval pb as VARIANT_BOOL ptr) as HRESULT
	get_IsFolder as function(byval This as FolderItem ptr, byval pb as VARIANT_BOOL ptr) as HRESULT
	get_IsFileSystem as function(byval This as FolderItem ptr, byval pb as VARIANT_BOOL ptr) as HRESULT
	get_IsBrowsable as function(byval This as FolderItem ptr, byval pb as VARIANT_BOOL ptr) as HRESULT
	get_ModifyDate as function(byval This as FolderItem ptr, byval pdt as DATE_ ptr) as HRESULT
	put_ModifyDate as function(byval This as FolderItem ptr, byval dt as DATE_) as HRESULT
	get_Size as function(byval This as FolderItem ptr, byval pul as LONG ptr) as HRESULT
	get_Type as function(byval This as FolderItem ptr, byval pbs as BSTR ptr) as HRESULT
	Verbs as function(byval This as FolderItem ptr, byval ppfic as FolderItemVerbs ptr ptr) as HRESULT
	InvokeVerb as function(byval This as FolderItem ptr, byval vVerb as VARIANT) as HRESULT
end type

type FolderItem_
	lpVtbl as FolderItemVtbl ptr
end type

declare function FolderItem_get_Application_Proxy(byval This as FolderItem ptr, byval ppid as IDispatch ptr ptr) as HRESULT
declare sub FolderItem_get_Application_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function FolderItem_get_Parent_Proxy(byval This as FolderItem ptr, byval ppid as IDispatch ptr ptr) as HRESULT
declare sub FolderItem_get_Parent_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function FolderItem_get_Name_Proxy(byval This as FolderItem ptr, byval pbs as BSTR ptr) as HRESULT
declare sub FolderItem_get_Name_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function FolderItem_put_Name_Proxy(byval This as FolderItem ptr, byval bs as BSTR) as HRESULT
declare sub FolderItem_put_Name_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function FolderItem_get_Path_Proxy(byval This as FolderItem ptr, byval pbs as BSTR ptr) as HRESULT
declare sub FolderItem_get_Path_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function FolderItem_get_GetLink_Proxy(byval This as FolderItem ptr, byval ppid as IDispatch ptr ptr) as HRESULT
declare sub FolderItem_get_GetLink_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function FolderItem_get_GetFolder_Proxy(byval This as FolderItem ptr, byval ppid as IDispatch ptr ptr) as HRESULT
declare sub FolderItem_get_GetFolder_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function FolderItem_get_IsLink_Proxy(byval This as FolderItem ptr, byval pb as VARIANT_BOOL ptr) as HRESULT
declare sub FolderItem_get_IsLink_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function FolderItem_get_IsFolder_Proxy(byval This as FolderItem ptr, byval pb as VARIANT_BOOL ptr) as HRESULT
declare sub FolderItem_get_IsFolder_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function FolderItem_get_IsFileSystem_Proxy(byval This as FolderItem ptr, byval pb as VARIANT_BOOL ptr) as HRESULT
declare sub FolderItem_get_IsFileSystem_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function FolderItem_get_IsBrowsable_Proxy(byval This as FolderItem ptr, byval pb as VARIANT_BOOL ptr) as HRESULT
declare sub FolderItem_get_IsBrowsable_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function FolderItem_get_ModifyDate_Proxy(byval This as FolderItem ptr, byval pdt as DATE_ ptr) as HRESULT
declare sub FolderItem_get_ModifyDate_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function FolderItem_put_ModifyDate_Proxy(byval This as FolderItem ptr, byval dt as DATE_) as HRESULT
declare sub FolderItem_put_ModifyDate_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function FolderItem_get_Size_Proxy(byval This as FolderItem ptr, byval pul as LONG ptr) as HRESULT
declare sub FolderItem_get_Size_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function FolderItem_get_Type_Proxy(byval This as FolderItem ptr, byval pbs as BSTR ptr) as HRESULT
declare sub FolderItem_get_Type_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function FolderItem_Verbs_Proxy(byval This as FolderItem ptr, byval ppfic as FolderItemVerbs ptr ptr) as HRESULT
declare sub FolderItem_Verbs_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function FolderItem_InvokeVerb_Proxy(byval This as FolderItem ptr, byval vVerb as VARIANT) as HRESULT
declare sub FolderItem_InvokeVerb_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __FolderItems_INTERFACE_DEFINED__
extern IID_FolderItems as const IID
type FolderItems as FolderItems_

type FolderItemsVtbl
	QueryInterface as function(byval This as FolderItems ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as FolderItems ptr) as ULONG
	Release as function(byval This as FolderItems ptr) as ULONG
	GetTypeInfoCount as function(byval This as FolderItems ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as FolderItems ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as FolderItems ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as FolderItems ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	get_Count as function(byval This as FolderItems ptr, byval plCount as long ptr) as HRESULT
	get_Application as function(byval This as FolderItems ptr, byval ppid as IDispatch ptr ptr) as HRESULT
	get_Parent as function(byval This as FolderItems ptr, byval ppid as IDispatch ptr ptr) as HRESULT
	Item as function(byval This as FolderItems ptr, byval index as VARIANT, byval ppid as FolderItem ptr ptr) as HRESULT
	_NewEnum as function(byval This as FolderItems ptr, byval ppunk as IUnknown ptr ptr) as HRESULT
end type

type FolderItems_
	lpVtbl as FolderItemsVtbl ptr
end type

declare function FolderItems_get_Count_Proxy(byval This as FolderItems ptr, byval plCount as long ptr) as HRESULT
declare sub FolderItems_get_Count_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function FolderItems_get_Application_Proxy(byval This as FolderItems ptr, byval ppid as IDispatch ptr ptr) as HRESULT
declare sub FolderItems_get_Application_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function FolderItems_get_Parent_Proxy(byval This as FolderItems ptr, byval ppid as IDispatch ptr ptr) as HRESULT
declare sub FolderItems_get_Parent_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function FolderItems_Item_Proxy(byval This as FolderItems ptr, byval index as VARIANT, byval ppid as FolderItem ptr ptr) as HRESULT
declare sub FolderItems_Item_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function FolderItems__NewEnum_Proxy(byval This as FolderItems ptr, byval ppunk as IUnknown ptr ptr) as HRESULT
declare sub FolderItems__NewEnum_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __FolderItemVerb_INTERFACE_DEFINED__
extern IID_FolderItemVerb as const IID
type FolderItemVerb as FolderItemVerb_

type FolderItemVerbVtbl
	QueryInterface as function(byval This as FolderItemVerb ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as FolderItemVerb ptr) as ULONG
	Release as function(byval This as FolderItemVerb ptr) as ULONG
	GetTypeInfoCount as function(byval This as FolderItemVerb ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as FolderItemVerb ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as FolderItemVerb ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as FolderItemVerb ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	get_Application as function(byval This as FolderItemVerb ptr, byval ppid as IDispatch ptr ptr) as HRESULT
	get_Parent as function(byval This as FolderItemVerb ptr, byval ppid as IDispatch ptr ptr) as HRESULT
	get_Name as function(byval This as FolderItemVerb ptr, byval pbs as BSTR ptr) as HRESULT
	DoIt as function(byval This as FolderItemVerb ptr) as HRESULT
end type

type FolderItemVerb_
	lpVtbl as FolderItemVerbVtbl ptr
end type

declare function FolderItemVerb_get_Application_Proxy(byval This as FolderItemVerb ptr, byval ppid as IDispatch ptr ptr) as HRESULT
declare sub FolderItemVerb_get_Application_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function FolderItemVerb_get_Parent_Proxy(byval This as FolderItemVerb ptr, byval ppid as IDispatch ptr ptr) as HRESULT
declare sub FolderItemVerb_get_Parent_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function FolderItemVerb_get_Name_Proxy(byval This as FolderItemVerb ptr, byval pbs as BSTR ptr) as HRESULT
declare sub FolderItemVerb_get_Name_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function FolderItemVerb_DoIt_Proxy(byval This as FolderItemVerb ptr) as HRESULT
declare sub FolderItemVerb_DoIt_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __FolderItemVerbs_INTERFACE_DEFINED__
extern IID_FolderItemVerbs as const IID

type FolderItemVerbsVtbl
	QueryInterface as function(byval This as FolderItemVerbs ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as FolderItemVerbs ptr) as ULONG
	Release as function(byval This as FolderItemVerbs ptr) as ULONG
	GetTypeInfoCount as function(byval This as FolderItemVerbs ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as FolderItemVerbs ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as FolderItemVerbs ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as FolderItemVerbs ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	get_Count as function(byval This as FolderItemVerbs ptr, byval plCount as long ptr) as HRESULT
	get_Application as function(byval This as FolderItemVerbs ptr, byval ppid as IDispatch ptr ptr) as HRESULT
	get_Parent as function(byval This as FolderItemVerbs ptr, byval ppid as IDispatch ptr ptr) as HRESULT
	Item as function(byval This as FolderItemVerbs ptr, byval index as VARIANT, byval ppid as FolderItemVerb ptr ptr) as HRESULT
	_NewEnum as function(byval This as FolderItemVerbs ptr, byval ppunk as IUnknown ptr ptr) as HRESULT
end type

type FolderItemVerbs_
	lpVtbl as FolderItemVerbsVtbl ptr
end type

declare function FolderItemVerbs_get_Count_Proxy(byval This as FolderItemVerbs ptr, byval plCount as long ptr) as HRESULT
declare sub FolderItemVerbs_get_Count_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function FolderItemVerbs_get_Application_Proxy(byval This as FolderItemVerbs ptr, byval ppid as IDispatch ptr ptr) as HRESULT
declare sub FolderItemVerbs_get_Application_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function FolderItemVerbs_get_Parent_Proxy(byval This as FolderItemVerbs ptr, byval ppid as IDispatch ptr ptr) as HRESULT
declare sub FolderItemVerbs_get_Parent_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function FolderItemVerbs_Item_Proxy(byval This as FolderItemVerbs ptr, byval index as VARIANT, byval ppid as FolderItemVerb ptr ptr) as HRESULT
declare sub FolderItemVerbs_Item_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function FolderItemVerbs__NewEnum_Proxy(byval This as FolderItemVerbs ptr, byval ppunk as IUnknown ptr ptr) as HRESULT
declare sub FolderItemVerbs__NewEnum_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __Folder_INTERFACE_DEFINED__
extern IID_Folder as const IID
type Folder as Folder_

type FolderVtbl
	QueryInterface as function(byval This as Folder ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as Folder ptr) as ULONG
	Release as function(byval This as Folder ptr) as ULONG
	GetTypeInfoCount as function(byval This as Folder ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as Folder ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as Folder ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as Folder ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	get_Title as function(byval This as Folder ptr, byval pbs as BSTR ptr) as HRESULT
	get_Application as function(byval This as Folder ptr, byval ppid as IDispatch ptr ptr) as HRESULT
	get_Parent as function(byval This as Folder ptr, byval ppid as IDispatch ptr ptr) as HRESULT
	get_ParentFolder as function(byval This as Folder ptr, byval ppsf as Folder ptr ptr) as HRESULT
	Items as function(byval This as Folder ptr, byval ppid as FolderItems ptr ptr) as HRESULT
	ParseName as function(byval This as Folder ptr, byval bName as BSTR, byval ppid as FolderItem ptr ptr) as HRESULT
	NewFolder as function(byval This as Folder ptr, byval bName as BSTR, byval vOptions as VARIANT) as HRESULT
	MoveHere as function(byval This as Folder ptr, byval vItem as VARIANT, byval vOptions as VARIANT) as HRESULT
	CopyHere as function(byval This as Folder ptr, byval vItem as VARIANT, byval vOptions as VARIANT) as HRESULT
	GetDetailsOf as function(byval This as Folder ptr, byval vItem as VARIANT, byval iColumn as long, byval pbs as BSTR ptr) as HRESULT
end type

type Folder_
	lpVtbl as FolderVtbl ptr
end type

declare function Folder_get_Title_Proxy(byval This as Folder ptr, byval pbs as BSTR ptr) as HRESULT
declare sub Folder_get_Title_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function Folder_get_Application_Proxy(byval This as Folder ptr, byval ppid as IDispatch ptr ptr) as HRESULT
declare sub Folder_get_Application_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function Folder_get_Parent_Proxy(byval This as Folder ptr, byval ppid as IDispatch ptr ptr) as HRESULT
declare sub Folder_get_Parent_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function Folder_get_ParentFolder_Proxy(byval This as Folder ptr, byval ppsf as Folder ptr ptr) as HRESULT
declare sub Folder_get_ParentFolder_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function Folder_Items_Proxy(byval This as Folder ptr, byval ppid as FolderItems ptr ptr) as HRESULT
declare sub Folder_Items_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function Folder_ParseName_Proxy(byval This as Folder ptr, byval bName as BSTR, byval ppid as FolderItem ptr ptr) as HRESULT
declare sub Folder_ParseName_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function Folder_NewFolder_Proxy(byval This as Folder ptr, byval bName as BSTR, byval vOptions as VARIANT) as HRESULT
declare sub Folder_NewFolder_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function Folder_MoveHere_Proxy(byval This as Folder ptr, byval vItem as VARIANT, byval vOptions as VARIANT) as HRESULT
declare sub Folder_MoveHere_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function Folder_CopyHere_Proxy(byval This as Folder ptr, byval vItem as VARIANT, byval vOptions as VARIANT) as HRESULT
declare sub Folder_CopyHere_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function Folder_GetDetailsOf_Proxy(byval This as Folder ptr, byval vItem as VARIANT, byval iColumn as long, byval pbs as BSTR ptr) as HRESULT
declare sub Folder_GetDetailsOf_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __Folder2_INTERFACE_DEFINED__
extern IID_Folder2 as const IID
type Folder2 as Folder2_

type Folder2Vtbl
	QueryInterface as function(byval This as Folder2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as Folder2 ptr) as ULONG
	Release as function(byval This as Folder2 ptr) as ULONG
	GetTypeInfoCount as function(byval This as Folder2 ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as Folder2 ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as Folder2 ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as Folder2 ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	get_Title as function(byval This as Folder2 ptr, byval pbs as BSTR ptr) as HRESULT
	get_Application as function(byval This as Folder2 ptr, byval ppid as IDispatch ptr ptr) as HRESULT
	get_Parent as function(byval This as Folder2 ptr, byval ppid as IDispatch ptr ptr) as HRESULT
	get_ParentFolder as function(byval This as Folder2 ptr, byval ppsf as Folder ptr ptr) as HRESULT
	Items as function(byval This as Folder2 ptr, byval ppid as FolderItems ptr ptr) as HRESULT
	ParseName as function(byval This as Folder2 ptr, byval bName as BSTR, byval ppid as FolderItem ptr ptr) as HRESULT
	NewFolder as function(byval This as Folder2 ptr, byval bName as BSTR, byval vOptions as VARIANT) as HRESULT
	MoveHere as function(byval This as Folder2 ptr, byval vItem as VARIANT, byval vOptions as VARIANT) as HRESULT
	CopyHere as function(byval This as Folder2 ptr, byval vItem as VARIANT, byval vOptions as VARIANT) as HRESULT
	GetDetailsOf as function(byval This as Folder2 ptr, byval vItem as VARIANT, byval iColumn as long, byval pbs as BSTR ptr) as HRESULT
	get_Self as function(byval This as Folder2 ptr, byval ppfi as FolderItem ptr ptr) as HRESULT
	get_OfflineStatus as function(byval This as Folder2 ptr, byval pul as LONG ptr) as HRESULT
	Synchronize as function(byval This as Folder2 ptr) as HRESULT
	get_HaveToShowWebViewBarricade as function(byval This as Folder2 ptr, byval pbHaveToShowWebViewBarricade as VARIANT_BOOL ptr) as HRESULT
	DismissedWebViewBarricade as function(byval This as Folder2 ptr) as HRESULT
end type

type Folder2_
	lpVtbl as Folder2Vtbl ptr
end type

declare function Folder2_get_Self_Proxy(byval This as Folder2 ptr, byval ppfi as FolderItem ptr ptr) as HRESULT
declare sub Folder2_get_Self_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function Folder2_get_OfflineStatus_Proxy(byval This as Folder2 ptr, byval pul as LONG ptr) as HRESULT
declare sub Folder2_get_OfflineStatus_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function Folder2_Synchronize_Proxy(byval This as Folder2 ptr) as HRESULT
declare sub Folder2_Synchronize_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function Folder2_get_HaveToShowWebViewBarricade_Proxy(byval This as Folder2 ptr, byval pbHaveToShowWebViewBarricade as VARIANT_BOOL ptr) as HRESULT
declare sub Folder2_get_HaveToShowWebViewBarricade_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function Folder2_DismissedWebViewBarricade_Proxy(byval This as Folder2 ptr) as HRESULT
declare sub Folder2_DismissedWebViewBarricade_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __Folder3_INTERFACE_DEFINED__
extern IID_Folder3 as const IID
type Folder3 as Folder3_

type Folder3Vtbl
	QueryInterface as function(byval This as Folder3 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as Folder3 ptr) as ULONG
	Release as function(byval This as Folder3 ptr) as ULONG
	GetTypeInfoCount as function(byval This as Folder3 ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as Folder3 ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as Folder3 ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as Folder3 ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	get_Title as function(byval This as Folder3 ptr, byval pbs as BSTR ptr) as HRESULT
	get_Application as function(byval This as Folder3 ptr, byval ppid as IDispatch ptr ptr) as HRESULT
	get_Parent as function(byval This as Folder3 ptr, byval ppid as IDispatch ptr ptr) as HRESULT
	get_ParentFolder as function(byval This as Folder3 ptr, byval ppsf as Folder ptr ptr) as HRESULT
	Items as function(byval This as Folder3 ptr, byval ppid as FolderItems ptr ptr) as HRESULT
	ParseName as function(byval This as Folder3 ptr, byval bName as BSTR, byval ppid as FolderItem ptr ptr) as HRESULT
	NewFolder as function(byval This as Folder3 ptr, byval bName as BSTR, byval vOptions as VARIANT) as HRESULT
	MoveHere as function(byval This as Folder3 ptr, byval vItem as VARIANT, byval vOptions as VARIANT) as HRESULT
	CopyHere as function(byval This as Folder3 ptr, byval vItem as VARIANT, byval vOptions as VARIANT) as HRESULT
	GetDetailsOf as function(byval This as Folder3 ptr, byval vItem as VARIANT, byval iColumn as long, byval pbs as BSTR ptr) as HRESULT
	get_Self as function(byval This as Folder3 ptr, byval ppfi as FolderItem ptr ptr) as HRESULT
	get_OfflineStatus as function(byval This as Folder3 ptr, byval pul as LONG ptr) as HRESULT
	Synchronize as function(byval This as Folder3 ptr) as HRESULT
	get_HaveToShowWebViewBarricade as function(byval This as Folder3 ptr, byval pbHaveToShowWebViewBarricade as VARIANT_BOOL ptr) as HRESULT
	DismissedWebViewBarricade as function(byval This as Folder3 ptr) as HRESULT
	get_ShowWebViewBarricade as function(byval This as Folder3 ptr, byval pbShowWebViewBarricade as VARIANT_BOOL ptr) as HRESULT
	put_ShowWebViewBarricade as function(byval This as Folder3 ptr, byval bShowWebViewBarricade as VARIANT_BOOL) as HRESULT
end type

type Folder3_
	lpVtbl as Folder3Vtbl ptr
end type

declare function Folder3_get_ShowWebViewBarricade_Proxy(byval This as Folder3 ptr, byval pbShowWebViewBarricade as VARIANT_BOOL ptr) as HRESULT
declare sub Folder3_get_ShowWebViewBarricade_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function Folder3_put_ShowWebViewBarricade_Proxy(byval This as Folder3 ptr, byval bShowWebViewBarricade as VARIANT_BOOL) as HRESULT
declare sub Folder3_put_ShowWebViewBarricade_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __FolderItem2_INTERFACE_DEFINED__
extern IID_FolderItem2 as const IID
type FolderItem2 as FolderItem2_

type FolderItem2Vtbl
	QueryInterface as function(byval This as FolderItem2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as FolderItem2 ptr) as ULONG
	Release as function(byval This as FolderItem2 ptr) as ULONG
	GetTypeInfoCount as function(byval This as FolderItem2 ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as FolderItem2 ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as FolderItem2 ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as FolderItem2 ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	get_Application as function(byval This as FolderItem2 ptr, byval ppid as IDispatch ptr ptr) as HRESULT
	get_Parent as function(byval This as FolderItem2 ptr, byval ppid as IDispatch ptr ptr) as HRESULT
	get_Name as function(byval This as FolderItem2 ptr, byval pbs as BSTR ptr) as HRESULT
	put_Name as function(byval This as FolderItem2 ptr, byval bs as BSTR) as HRESULT
	get_Path as function(byval This as FolderItem2 ptr, byval pbs as BSTR ptr) as HRESULT
	get_GetLink as function(byval This as FolderItem2 ptr, byval ppid as IDispatch ptr ptr) as HRESULT
	get_GetFolder as function(byval This as FolderItem2 ptr, byval ppid as IDispatch ptr ptr) as HRESULT
	get_IsLink as function(byval This as FolderItem2 ptr, byval pb as VARIANT_BOOL ptr) as HRESULT
	get_IsFolder as function(byval This as FolderItem2 ptr, byval pb as VARIANT_BOOL ptr) as HRESULT
	get_IsFileSystem as function(byval This as FolderItem2 ptr, byval pb as VARIANT_BOOL ptr) as HRESULT
	get_IsBrowsable as function(byval This as FolderItem2 ptr, byval pb as VARIANT_BOOL ptr) as HRESULT
	get_ModifyDate as function(byval This as FolderItem2 ptr, byval pdt as DATE_ ptr) as HRESULT
	put_ModifyDate as function(byval This as FolderItem2 ptr, byval dt as DATE_) as HRESULT
	get_Size as function(byval This as FolderItem2 ptr, byval pul as LONG ptr) as HRESULT
	get_Type as function(byval This as FolderItem2 ptr, byval pbs as BSTR ptr) as HRESULT
	Verbs as function(byval This as FolderItem2 ptr, byval ppfic as FolderItemVerbs ptr ptr) as HRESULT
	InvokeVerb as function(byval This as FolderItem2 ptr, byval vVerb as VARIANT) as HRESULT
	InvokeVerbEx as function(byval This as FolderItem2 ptr, byval vVerb as VARIANT, byval vArgs as VARIANT) as HRESULT
	ExtendedProperty as function(byval This as FolderItem2 ptr, byval bstrPropName as BSTR, byval pvRet as VARIANT ptr) as HRESULT
end type

type FolderItem2_
	lpVtbl as FolderItem2Vtbl ptr
end type

declare function FolderItem2_InvokeVerbEx_Proxy(byval This as FolderItem2 ptr, byval vVerb as VARIANT, byval vArgs as VARIANT) as HRESULT
declare sub FolderItem2_InvokeVerbEx_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function FolderItem2_ExtendedProperty_Proxy(byval This as FolderItem2 ptr, byval bstrPropName as BSTR, byval pvRet as VARIANT ptr) as HRESULT
declare sub FolderItem2_ExtendedProperty_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
extern CLSID_ShellFolderItem as const CLSID
#define __FolderItems2_INTERFACE_DEFINED__
extern IID_FolderItems2 as const IID
type FolderItems2 as FolderItems2_

type FolderItems2Vtbl
	QueryInterface as function(byval This as FolderItems2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as FolderItems2 ptr) as ULONG
	Release as function(byval This as FolderItems2 ptr) as ULONG
	GetTypeInfoCount as function(byval This as FolderItems2 ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as FolderItems2 ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as FolderItems2 ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as FolderItems2 ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	get_Count as function(byval This as FolderItems2 ptr, byval plCount as long ptr) as HRESULT
	get_Application as function(byval This as FolderItems2 ptr, byval ppid as IDispatch ptr ptr) as HRESULT
	get_Parent as function(byval This as FolderItems2 ptr, byval ppid as IDispatch ptr ptr) as HRESULT
	Item as function(byval This as FolderItems2 ptr, byval index as VARIANT, byval ppid as FolderItem ptr ptr) as HRESULT
	_NewEnum as function(byval This as FolderItems2 ptr, byval ppunk as IUnknown ptr ptr) as HRESULT
	InvokeVerbEx as function(byval This as FolderItems2 ptr, byval vVerb as VARIANT, byval vArgs as VARIANT) as HRESULT
end type

type FolderItems2_
	lpVtbl as FolderItems2Vtbl ptr
end type

declare function FolderItems2_InvokeVerbEx_Proxy(byval This as FolderItems2 ptr, byval vVerb as VARIANT, byval vArgs as VARIANT) as HRESULT
declare sub FolderItems2_InvokeVerbEx_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __FolderItems3_INTERFACE_DEFINED__
extern IID_FolderItems3 as const IID
type FolderItems3 as FolderItems3_

type FolderItems3Vtbl
	QueryInterface as function(byval This as FolderItems3 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as FolderItems3 ptr) as ULONG
	Release as function(byval This as FolderItems3 ptr) as ULONG
	GetTypeInfoCount as function(byval This as FolderItems3 ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as FolderItems3 ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as FolderItems3 ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as FolderItems3 ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	get_Count as function(byval This as FolderItems3 ptr, byval plCount as long ptr) as HRESULT
	get_Application as function(byval This as FolderItems3 ptr, byval ppid as IDispatch ptr ptr) as HRESULT
	get_Parent as function(byval This as FolderItems3 ptr, byval ppid as IDispatch ptr ptr) as HRESULT
	Item as function(byval This as FolderItems3 ptr, byval index as VARIANT, byval ppid as FolderItem ptr ptr) as HRESULT
	_NewEnum as function(byval This as FolderItems3 ptr, byval ppunk as IUnknown ptr ptr) as HRESULT
	InvokeVerbEx as function(byval This as FolderItems3 ptr, byval vVerb as VARIANT, byval vArgs as VARIANT) as HRESULT
	Filter as function(byval This as FolderItems3 ptr, byval grfFlags as long, byval bstrFileSpec as BSTR) as HRESULT
	get_Verbs as function(byval This as FolderItems3 ptr, byval ppfic as FolderItemVerbs ptr ptr) as HRESULT
end type

type FolderItems3_
	lpVtbl as FolderItems3Vtbl ptr
end type

declare function FolderItems3_Filter_Proxy(byval This as FolderItems3 ptr, byval grfFlags as long, byval bstrFileSpec as BSTR) as HRESULT
declare sub FolderItems3_Filter_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function FolderItems3_get_Verbs_Proxy(byval This as FolderItems3 ptr, byval ppfic as FolderItemVerbs ptr ptr) as HRESULT
declare sub FolderItems3_get_Verbs_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IShellLinkDual_INTERFACE_DEFINED__
extern IID_IShellLinkDual as const IID
type IShellLinkDual as IShellLinkDual_

type IShellLinkDualVtbl
	QueryInterface as function(byval This as IShellLinkDual ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IShellLinkDual ptr) as ULONG
	Release as function(byval This as IShellLinkDual ptr) as ULONG
	GetTypeInfoCount as function(byval This as IShellLinkDual ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IShellLinkDual ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IShellLinkDual ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IShellLinkDual ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	get_Path as function(byval This as IShellLinkDual ptr, byval pbs as BSTR ptr) as HRESULT
	put_Path as function(byval This as IShellLinkDual ptr, byval bs as BSTR) as HRESULT
	get_Description as function(byval This as IShellLinkDual ptr, byval pbs as BSTR ptr) as HRESULT
	put_Description as function(byval This as IShellLinkDual ptr, byval bs as BSTR) as HRESULT
	get_WorkingDirectory as function(byval This as IShellLinkDual ptr, byval pbs as BSTR ptr) as HRESULT
	put_WorkingDirectory as function(byval This as IShellLinkDual ptr, byval bs as BSTR) as HRESULT
	get_Arguments as function(byval This as IShellLinkDual ptr, byval pbs as BSTR ptr) as HRESULT
	put_Arguments as function(byval This as IShellLinkDual ptr, byval bs as BSTR) as HRESULT
	get_Hotkey as function(byval This as IShellLinkDual ptr, byval piHK as long ptr) as HRESULT
	put_Hotkey as function(byval This as IShellLinkDual ptr, byval iHK as long) as HRESULT
	get_ShowCommand as function(byval This as IShellLinkDual ptr, byval piShowCommand as long ptr) as HRESULT
	put_ShowCommand as function(byval This as IShellLinkDual ptr, byval iShowCommand as long) as HRESULT
	Resolve as function(byval This as IShellLinkDual ptr, byval fFlags as long) as HRESULT
	GetIconLocation as function(byval This as IShellLinkDual ptr, byval pbs as BSTR ptr, byval piIcon as long ptr) as HRESULT
	SetIconLocation as function(byval This as IShellLinkDual ptr, byval bs as BSTR, byval iIcon as long) as HRESULT
	Save as function(byval This as IShellLinkDual ptr, byval vWhere as VARIANT) as HRESULT
end type

type IShellLinkDual_
	lpVtbl as IShellLinkDualVtbl ptr
end type

declare function IShellLinkDual_get_Path_Proxy(byval This as IShellLinkDual ptr, byval pbs as BSTR ptr) as HRESULT
declare sub IShellLinkDual_get_Path_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellLinkDual_put_Path_Proxy(byval This as IShellLinkDual ptr, byval bs as BSTR) as HRESULT
declare sub IShellLinkDual_put_Path_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellLinkDual_get_Description_Proxy(byval This as IShellLinkDual ptr, byval pbs as BSTR ptr) as HRESULT
declare sub IShellLinkDual_get_Description_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellLinkDual_put_Description_Proxy(byval This as IShellLinkDual ptr, byval bs as BSTR) as HRESULT
declare sub IShellLinkDual_put_Description_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellLinkDual_get_WorkingDirectory_Proxy(byval This as IShellLinkDual ptr, byval pbs as BSTR ptr) as HRESULT
declare sub IShellLinkDual_get_WorkingDirectory_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellLinkDual_put_WorkingDirectory_Proxy(byval This as IShellLinkDual ptr, byval bs as BSTR) as HRESULT
declare sub IShellLinkDual_put_WorkingDirectory_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellLinkDual_get_Arguments_Proxy(byval This as IShellLinkDual ptr, byval pbs as BSTR ptr) as HRESULT
declare sub IShellLinkDual_get_Arguments_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellLinkDual_put_Arguments_Proxy(byval This as IShellLinkDual ptr, byval bs as BSTR) as HRESULT
declare sub IShellLinkDual_put_Arguments_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellLinkDual_get_Hotkey_Proxy(byval This as IShellLinkDual ptr, byval piHK as long ptr) as HRESULT
declare sub IShellLinkDual_get_Hotkey_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellLinkDual_put_Hotkey_Proxy(byval This as IShellLinkDual ptr, byval iHK as long) as HRESULT
declare sub IShellLinkDual_put_Hotkey_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellLinkDual_get_ShowCommand_Proxy(byval This as IShellLinkDual ptr, byval piShowCommand as long ptr) as HRESULT
declare sub IShellLinkDual_get_ShowCommand_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellLinkDual_put_ShowCommand_Proxy(byval This as IShellLinkDual ptr, byval iShowCommand as long) as HRESULT
declare sub IShellLinkDual_put_ShowCommand_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellLinkDual_Resolve_Proxy(byval This as IShellLinkDual ptr, byval fFlags as long) as HRESULT
declare sub IShellLinkDual_Resolve_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellLinkDual_GetIconLocation_Proxy(byval This as IShellLinkDual ptr, byval pbs as BSTR ptr, byval piIcon as long ptr) as HRESULT
declare sub IShellLinkDual_GetIconLocation_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellLinkDual_SetIconLocation_Proxy(byval This as IShellLinkDual ptr, byval bs as BSTR, byval iIcon as long) as HRESULT
declare sub IShellLinkDual_SetIconLocation_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellLinkDual_Save_Proxy(byval This as IShellLinkDual ptr, byval vWhere as VARIANT) as HRESULT
declare sub IShellLinkDual_Save_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IShellLinkDual2_INTERFACE_DEFINED__
extern IID_IShellLinkDual2 as const IID
type IShellLinkDual2 as IShellLinkDual2_

type IShellLinkDual2Vtbl
	QueryInterface as function(byval This as IShellLinkDual2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IShellLinkDual2 ptr) as ULONG
	Release as function(byval This as IShellLinkDual2 ptr) as ULONG
	GetTypeInfoCount as function(byval This as IShellLinkDual2 ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IShellLinkDual2 ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IShellLinkDual2 ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IShellLinkDual2 ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	get_Path as function(byval This as IShellLinkDual2 ptr, byval pbs as BSTR ptr) as HRESULT
	put_Path as function(byval This as IShellLinkDual2 ptr, byval bs as BSTR) as HRESULT
	get_Description as function(byval This as IShellLinkDual2 ptr, byval pbs as BSTR ptr) as HRESULT
	put_Description as function(byval This as IShellLinkDual2 ptr, byval bs as BSTR) as HRESULT
	get_WorkingDirectory as function(byval This as IShellLinkDual2 ptr, byval pbs as BSTR ptr) as HRESULT
	put_WorkingDirectory as function(byval This as IShellLinkDual2 ptr, byval bs as BSTR) as HRESULT
	get_Arguments as function(byval This as IShellLinkDual2 ptr, byval pbs as BSTR ptr) as HRESULT
	put_Arguments as function(byval This as IShellLinkDual2 ptr, byval bs as BSTR) as HRESULT
	get_Hotkey as function(byval This as IShellLinkDual2 ptr, byval piHK as long ptr) as HRESULT
	put_Hotkey as function(byval This as IShellLinkDual2 ptr, byval iHK as long) as HRESULT
	get_ShowCommand as function(byval This as IShellLinkDual2 ptr, byval piShowCommand as long ptr) as HRESULT
	put_ShowCommand as function(byval This as IShellLinkDual2 ptr, byval iShowCommand as long) as HRESULT
	Resolve as function(byval This as IShellLinkDual2 ptr, byval fFlags as long) as HRESULT
	GetIconLocation as function(byval This as IShellLinkDual2 ptr, byval pbs as BSTR ptr, byval piIcon as long ptr) as HRESULT
	SetIconLocation as function(byval This as IShellLinkDual2 ptr, byval bs as BSTR, byval iIcon as long) as HRESULT
	Save as function(byval This as IShellLinkDual2 ptr, byval vWhere as VARIANT) as HRESULT
	get_Target as function(byval This as IShellLinkDual2 ptr, byval ppfi as FolderItem ptr ptr) as HRESULT
end type

type IShellLinkDual2_
	lpVtbl as IShellLinkDual2Vtbl ptr
end type

declare function IShellLinkDual2_get_Target_Proxy(byval This as IShellLinkDual2 ptr, byval ppfi as FolderItem ptr ptr) as HRESULT
declare sub IShellLinkDual2_get_Target_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
extern CLSID_ShellLinkObject as const CLSID
#define __IShellFolderViewDual_INTERFACE_DEFINED__
extern IID_IShellFolderViewDual as const IID
type IShellFolderViewDual as IShellFolderViewDual_

type IShellFolderViewDualVtbl
	QueryInterface as function(byval This as IShellFolderViewDual ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IShellFolderViewDual ptr) as ULONG
	Release as function(byval This as IShellFolderViewDual ptr) as ULONG
	GetTypeInfoCount as function(byval This as IShellFolderViewDual ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IShellFolderViewDual ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IShellFolderViewDual ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IShellFolderViewDual ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	get_Application as function(byval This as IShellFolderViewDual ptr, byval ppid as IDispatch ptr ptr) as HRESULT
	get_Parent as function(byval This as IShellFolderViewDual ptr, byval ppid as IDispatch ptr ptr) as HRESULT
	get_Folder as function(byval This as IShellFolderViewDual ptr, byval ppid as Folder ptr ptr) as HRESULT
	SelectedItems as function(byval This as IShellFolderViewDual ptr, byval ppid as FolderItems ptr ptr) as HRESULT
	get_FocusedItem as function(byval This as IShellFolderViewDual ptr, byval ppid as FolderItem ptr ptr) as HRESULT
	SelectItem as function(byval This as IShellFolderViewDual ptr, byval pvfi as VARIANT ptr, byval dwFlags as long) as HRESULT
	PopupItemMenu as function(byval This as IShellFolderViewDual ptr, byval pfi as FolderItem ptr, byval vx as VARIANT, byval vy as VARIANT, byval pbs as BSTR ptr) as HRESULT
	get_Script as function(byval This as IShellFolderViewDual ptr, byval ppDisp as IDispatch ptr ptr) as HRESULT
	get_ViewOptions as function(byval This as IShellFolderViewDual ptr, byval plViewOptions as long ptr) as HRESULT
end type

type IShellFolderViewDual_
	lpVtbl as IShellFolderViewDualVtbl ptr
end type

declare function IShellFolderViewDual_get_Application_Proxy(byval This as IShellFolderViewDual ptr, byval ppid as IDispatch ptr ptr) as HRESULT
declare sub IShellFolderViewDual_get_Application_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellFolderViewDual_get_Parent_Proxy(byval This as IShellFolderViewDual ptr, byval ppid as IDispatch ptr ptr) as HRESULT
declare sub IShellFolderViewDual_get_Parent_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellFolderViewDual_get_Folder_Proxy(byval This as IShellFolderViewDual ptr, byval ppid as Folder ptr ptr) as HRESULT
declare sub IShellFolderViewDual_get_Folder_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellFolderViewDual_SelectedItems_Proxy(byval This as IShellFolderViewDual ptr, byval ppid as FolderItems ptr ptr) as HRESULT
declare sub IShellFolderViewDual_SelectedItems_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellFolderViewDual_get_FocusedItem_Proxy(byval This as IShellFolderViewDual ptr, byval ppid as FolderItem ptr ptr) as HRESULT
declare sub IShellFolderViewDual_get_FocusedItem_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellFolderViewDual_SelectItem_Proxy(byval This as IShellFolderViewDual ptr, byval pvfi as VARIANT ptr, byval dwFlags as long) as HRESULT
declare sub IShellFolderViewDual_SelectItem_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellFolderViewDual_PopupItemMenu_Proxy(byval This as IShellFolderViewDual ptr, byval pfi as FolderItem ptr, byval vx as VARIANT, byval vy as VARIANT, byval pbs as BSTR ptr) as HRESULT
declare sub IShellFolderViewDual_PopupItemMenu_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellFolderViewDual_get_Script_Proxy(byval This as IShellFolderViewDual ptr, byval ppDisp as IDispatch ptr ptr) as HRESULT
declare sub IShellFolderViewDual_get_Script_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellFolderViewDual_get_ViewOptions_Proxy(byval This as IShellFolderViewDual ptr, byval plViewOptions as long ptr) as HRESULT
declare sub IShellFolderViewDual_get_ViewOptions_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IShellFolderViewDual2_INTERFACE_DEFINED__
extern IID_IShellFolderViewDual2 as const IID
type IShellFolderViewDual2 as IShellFolderViewDual2_

type IShellFolderViewDual2Vtbl
	QueryInterface as function(byval This as IShellFolderViewDual2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IShellFolderViewDual2 ptr) as ULONG
	Release as function(byval This as IShellFolderViewDual2 ptr) as ULONG
	GetTypeInfoCount as function(byval This as IShellFolderViewDual2 ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IShellFolderViewDual2 ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IShellFolderViewDual2 ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IShellFolderViewDual2 ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	get_Application as function(byval This as IShellFolderViewDual2 ptr, byval ppid as IDispatch ptr ptr) as HRESULT
	get_Parent as function(byval This as IShellFolderViewDual2 ptr, byval ppid as IDispatch ptr ptr) as HRESULT
	get_Folder as function(byval This as IShellFolderViewDual2 ptr, byval ppid as Folder ptr ptr) as HRESULT
	SelectedItems as function(byval This as IShellFolderViewDual2 ptr, byval ppid as FolderItems ptr ptr) as HRESULT
	get_FocusedItem as function(byval This as IShellFolderViewDual2 ptr, byval ppid as FolderItem ptr ptr) as HRESULT
	SelectItem as function(byval This as IShellFolderViewDual2 ptr, byval pvfi as VARIANT ptr, byval dwFlags as long) as HRESULT
	PopupItemMenu as function(byval This as IShellFolderViewDual2 ptr, byval pfi as FolderItem ptr, byval vx as VARIANT, byval vy as VARIANT, byval pbs as BSTR ptr) as HRESULT
	get_Script as function(byval This as IShellFolderViewDual2 ptr, byval ppDisp as IDispatch ptr ptr) as HRESULT
	get_ViewOptions as function(byval This as IShellFolderViewDual2 ptr, byval plViewOptions as long ptr) as HRESULT
	get_CurrentViewMode as function(byval This as IShellFolderViewDual2 ptr, byval pViewMode as UINT ptr) as HRESULT
	put_CurrentViewMode as function(byval This as IShellFolderViewDual2 ptr, byval ViewMode as UINT) as HRESULT
	SelectItemRelative as function(byval This as IShellFolderViewDual2 ptr, byval iRelative as long) as HRESULT
end type

type IShellFolderViewDual2_
	lpVtbl as IShellFolderViewDual2Vtbl ptr
end type

declare function IShellFolderViewDual2_get_CurrentViewMode_Proxy(byval This as IShellFolderViewDual2 ptr, byval pViewMode as UINT ptr) as HRESULT
declare sub IShellFolderViewDual2_get_CurrentViewMode_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellFolderViewDual2_put_CurrentViewMode_Proxy(byval This as IShellFolderViewDual2 ptr, byval ViewMode as UINT) as HRESULT
declare sub IShellFolderViewDual2_put_CurrentViewMode_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellFolderViewDual2_SelectItemRelative_Proxy(byval This as IShellFolderViewDual2 ptr, byval iRelative as long) as HRESULT
declare sub IShellFolderViewDual2_SelectItemRelative_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
extern CLSID_ShellFolderView as const CLSID
#define __IShellDispatch_INTERFACE_DEFINED__
extern IID_IShellDispatch as const IID
type IShellDispatch as IShellDispatch_

type IShellDispatchVtbl
	QueryInterface as function(byval This as IShellDispatch ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IShellDispatch ptr) as ULONG
	Release as function(byval This as IShellDispatch ptr) as ULONG
	GetTypeInfoCount as function(byval This as IShellDispatch ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IShellDispatch ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IShellDispatch ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IShellDispatch ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	get_Application as function(byval This as IShellDispatch ptr, byval ppid as IDispatch ptr ptr) as HRESULT
	get_Parent as function(byval This as IShellDispatch ptr, byval ppid as IDispatch ptr ptr) as HRESULT
	NameSpace as function(byval This as IShellDispatch ptr, byval vDir as VARIANT, byval ppsdf as Folder ptr ptr) as HRESULT
	BrowseForFolder as function(byval This as IShellDispatch ptr, byval Hwnd as long, byval Title as BSTR, byval Options as long, byval RootFolder as VARIANT, byval ppsdf as Folder ptr ptr) as HRESULT
	Windows as function(byval This as IShellDispatch ptr, byval ppid as IDispatch ptr ptr) as HRESULT
	Open as function(byval This as IShellDispatch ptr, byval vDir as VARIANT) as HRESULT
	Explore as function(byval This as IShellDispatch ptr, byval vDir as VARIANT) as HRESULT
	MinimizeAll as function(byval This as IShellDispatch ptr) as HRESULT
	UndoMinimizeALL as function(byval This as IShellDispatch ptr) as HRESULT
	FileRun as function(byval This as IShellDispatch ptr) as HRESULT
	CascadeWindows as function(byval This as IShellDispatch ptr) as HRESULT
	TileVertically as function(byval This as IShellDispatch ptr) as HRESULT
	TileHorizontally as function(byval This as IShellDispatch ptr) as HRESULT
	ShutdownWindows as function(byval This as IShellDispatch ptr) as HRESULT
	Suspend as function(byval This as IShellDispatch ptr) as HRESULT
	EjectPC as function(byval This as IShellDispatch ptr) as HRESULT
	SetTime as function(byval This as IShellDispatch ptr) as HRESULT
	TrayProperties as function(byval This as IShellDispatch ptr) as HRESULT
	Help as function(byval This as IShellDispatch ptr) as HRESULT
	FindFiles as function(byval This as IShellDispatch ptr) as HRESULT
	FindComputer as function(byval This as IShellDispatch ptr) as HRESULT
	RefreshMenu as function(byval This as IShellDispatch ptr) as HRESULT
	ControlPanelItem as function(byval This as IShellDispatch ptr, byval szDir as BSTR) as HRESULT
end type

type IShellDispatch_
	lpVtbl as IShellDispatchVtbl ptr
end type

declare function IShellDispatch_get_Application_Proxy(byval This as IShellDispatch ptr, byval ppid as IDispatch ptr ptr) as HRESULT
declare sub IShellDispatch_get_Application_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellDispatch_get_Parent_Proxy(byval This as IShellDispatch ptr, byval ppid as IDispatch ptr ptr) as HRESULT
declare sub IShellDispatch_get_Parent_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellDispatch_NameSpace_Proxy(byval This as IShellDispatch ptr, byval vDir as VARIANT, byval ppsdf as Folder ptr ptr) as HRESULT
declare sub IShellDispatch_NameSpace_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellDispatch_BrowseForFolder_Proxy(byval This as IShellDispatch ptr, byval Hwnd as long, byval Title as BSTR, byval Options as long, byval RootFolder as VARIANT, byval ppsdf as Folder ptr ptr) as HRESULT
declare sub IShellDispatch_BrowseForFolder_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellDispatch_Windows_Proxy(byval This as IShellDispatch ptr, byval ppid as IDispatch ptr ptr) as HRESULT
declare sub IShellDispatch_Windows_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellDispatch_Open_Proxy(byval This as IShellDispatch ptr, byval vDir as VARIANT) as HRESULT
declare sub IShellDispatch_Open_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellDispatch_Explore_Proxy(byval This as IShellDispatch ptr, byval vDir as VARIANT) as HRESULT
declare sub IShellDispatch_Explore_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellDispatch_MinimizeAll_Proxy(byval This as IShellDispatch ptr) as HRESULT
declare sub IShellDispatch_MinimizeAll_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellDispatch_UndoMinimizeALL_Proxy(byval This as IShellDispatch ptr) as HRESULT
declare sub IShellDispatch_UndoMinimizeALL_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellDispatch_FileRun_Proxy(byval This as IShellDispatch ptr) as HRESULT
declare sub IShellDispatch_FileRun_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellDispatch_CascadeWindows_Proxy(byval This as IShellDispatch ptr) as HRESULT
declare sub IShellDispatch_CascadeWindows_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellDispatch_TileVertically_Proxy(byval This as IShellDispatch ptr) as HRESULT
declare sub IShellDispatch_TileVertically_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellDispatch_TileHorizontally_Proxy(byval This as IShellDispatch ptr) as HRESULT
declare sub IShellDispatch_TileHorizontally_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellDispatch_ShutdownWindows_Proxy(byval This as IShellDispatch ptr) as HRESULT
declare sub IShellDispatch_ShutdownWindows_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellDispatch_Suspend_Proxy(byval This as IShellDispatch ptr) as HRESULT
declare sub IShellDispatch_Suspend_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellDispatch_EjectPC_Proxy(byval This as IShellDispatch ptr) as HRESULT
declare sub IShellDispatch_EjectPC_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellDispatch_SetTime_Proxy(byval This as IShellDispatch ptr) as HRESULT
declare sub IShellDispatch_SetTime_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellDispatch_TrayProperties_Proxy(byval This as IShellDispatch ptr) as HRESULT
declare sub IShellDispatch_TrayProperties_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellDispatch_Help_Proxy(byval This as IShellDispatch ptr) as HRESULT
declare sub IShellDispatch_Help_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellDispatch_FindFiles_Proxy(byval This as IShellDispatch ptr) as HRESULT
declare sub IShellDispatch_FindFiles_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellDispatch_FindComputer_Proxy(byval This as IShellDispatch ptr) as HRESULT
declare sub IShellDispatch_FindComputer_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellDispatch_RefreshMenu_Proxy(byval This as IShellDispatch ptr) as HRESULT
declare sub IShellDispatch_RefreshMenu_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellDispatch_ControlPanelItem_Proxy(byval This as IShellDispatch ptr, byval szDir as BSTR) as HRESULT
declare sub IShellDispatch_ControlPanelItem_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IShellDispatch2_INTERFACE_DEFINED__
extern IID_IShellDispatch2 as const IID
type IShellDispatch2 as IShellDispatch2_

type IShellDispatch2Vtbl
	QueryInterface as function(byval This as IShellDispatch2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IShellDispatch2 ptr) as ULONG
	Release as function(byval This as IShellDispatch2 ptr) as ULONG
	GetTypeInfoCount as function(byval This as IShellDispatch2 ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IShellDispatch2 ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IShellDispatch2 ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IShellDispatch2 ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	get_Application as function(byval This as IShellDispatch2 ptr, byval ppid as IDispatch ptr ptr) as HRESULT
	get_Parent as function(byval This as IShellDispatch2 ptr, byval ppid as IDispatch ptr ptr) as HRESULT
	NameSpace as function(byval This as IShellDispatch2 ptr, byval vDir as VARIANT, byval ppsdf as Folder ptr ptr) as HRESULT
	BrowseForFolder as function(byval This as IShellDispatch2 ptr, byval Hwnd as long, byval Title as BSTR, byval Options as long, byval RootFolder as VARIANT, byval ppsdf as Folder ptr ptr) as HRESULT
	Windows as function(byval This as IShellDispatch2 ptr, byval ppid as IDispatch ptr ptr) as HRESULT
	Open as function(byval This as IShellDispatch2 ptr, byval vDir as VARIANT) as HRESULT
	Explore as function(byval This as IShellDispatch2 ptr, byval vDir as VARIANT) as HRESULT
	MinimizeAll as function(byval This as IShellDispatch2 ptr) as HRESULT
	UndoMinimizeALL as function(byval This as IShellDispatch2 ptr) as HRESULT
	FileRun as function(byval This as IShellDispatch2 ptr) as HRESULT
	CascadeWindows as function(byval This as IShellDispatch2 ptr) as HRESULT
	TileVertically as function(byval This as IShellDispatch2 ptr) as HRESULT
	TileHorizontally as function(byval This as IShellDispatch2 ptr) as HRESULT
	ShutdownWindows as function(byval This as IShellDispatch2 ptr) as HRESULT
	Suspend as function(byval This as IShellDispatch2 ptr) as HRESULT
	EjectPC as function(byval This as IShellDispatch2 ptr) as HRESULT
	SetTime as function(byval This as IShellDispatch2 ptr) as HRESULT
	TrayProperties as function(byval This as IShellDispatch2 ptr) as HRESULT
	Help as function(byval This as IShellDispatch2 ptr) as HRESULT
	FindFiles as function(byval This as IShellDispatch2 ptr) as HRESULT
	FindComputer as function(byval This as IShellDispatch2 ptr) as HRESULT
	RefreshMenu as function(byval This as IShellDispatch2 ptr) as HRESULT
	ControlPanelItem as function(byval This as IShellDispatch2 ptr, byval szDir as BSTR) as HRESULT
	IsRestricted as function(byval This as IShellDispatch2 ptr, byval Group as BSTR, byval Restriction as BSTR, byval plRestrictValue as long ptr) as HRESULT

	#ifdef UNICODE
		ShellExecuteW as function(byval This as IShellDispatch2 ptr, byval File as BSTR, byval vArgs as VARIANT, byval vDir as VARIANT, byval vOperation as VARIANT, byval vShow as VARIANT) as HRESULT
	#else
		ShellExecuteA as function(byval This as IShellDispatch2 ptr, byval File as BSTR, byval vArgs as VARIANT, byval vDir as VARIANT, byval vOperation as VARIANT, byval vShow as VARIANT) as HRESULT
	#endif

	FindPrinter as function(byval This as IShellDispatch2 ptr, byval name as BSTR, byval location as BSTR, byval model as BSTR) as HRESULT
	GetSystemInformation as function(byval This as IShellDispatch2 ptr, byval name as BSTR, byval pv as VARIANT ptr) as HRESULT
	ServiceStart as function(byval This as IShellDispatch2 ptr, byval ServiceName as BSTR, byval Persistent as VARIANT, byval pSuccess as VARIANT ptr) as HRESULT
	ServiceStop as function(byval This as IShellDispatch2 ptr, byval ServiceName as BSTR, byval Persistent as VARIANT, byval pSuccess as VARIANT ptr) as HRESULT
	IsServiceRunning as function(byval This as IShellDispatch2 ptr, byval ServiceName as BSTR, byval pRunning as VARIANT ptr) as HRESULT
	CanStartStopService as function(byval This as IShellDispatch2 ptr, byval ServiceName as BSTR, byval pCanStartStop as VARIANT ptr) as HRESULT
	ShowBrowserBar as function(byval This as IShellDispatch2 ptr, byval bstrClsid as BSTR, byval bShow as VARIANT, byval pSuccess as VARIANT ptr) as HRESULT
end type

type IShellDispatch2_
	lpVtbl as IShellDispatch2Vtbl ptr
end type

declare function IShellDispatch2_IsRestricted_Proxy(byval This as IShellDispatch2 ptr, byval Group as BSTR, byval Restriction as BSTR, byval plRestrictValue as long ptr) as HRESULT
declare sub IShellDispatch2_IsRestricted_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellDispatch2_ShellExecute_Proxy(byval This as IShellDispatch2 ptr, byval File as BSTR, byval vArgs as VARIANT, byval vDir as VARIANT, byval vOperation as VARIANT, byval vShow as VARIANT) as HRESULT
declare sub IShellDispatch2_ShellExecute_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellDispatch2_FindPrinter_Proxy(byval This as IShellDispatch2 ptr, byval name as BSTR, byval location as BSTR, byval model as BSTR) as HRESULT
declare sub IShellDispatch2_FindPrinter_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellDispatch2_GetSystemInformation_Proxy(byval This as IShellDispatch2 ptr, byval name as BSTR, byval pv as VARIANT ptr) as HRESULT
declare sub IShellDispatch2_GetSystemInformation_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellDispatch2_ServiceStart_Proxy(byval This as IShellDispatch2 ptr, byval ServiceName as BSTR, byval Persistent as VARIANT, byval pSuccess as VARIANT ptr) as HRESULT
declare sub IShellDispatch2_ServiceStart_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellDispatch2_ServiceStop_Proxy(byval This as IShellDispatch2 ptr, byval ServiceName as BSTR, byval Persistent as VARIANT, byval pSuccess as VARIANT ptr) as HRESULT
declare sub IShellDispatch2_ServiceStop_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellDispatch2_IsServiceRunning_Proxy(byval This as IShellDispatch2 ptr, byval ServiceName as BSTR, byval pRunning as VARIANT ptr) as HRESULT
declare sub IShellDispatch2_IsServiceRunning_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellDispatch2_CanStartStopService_Proxy(byval This as IShellDispatch2 ptr, byval ServiceName as BSTR, byval pCanStartStop as VARIANT ptr) as HRESULT
declare sub IShellDispatch2_CanStartStopService_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellDispatch2_ShowBrowserBar_Proxy(byval This as IShellDispatch2 ptr, byval bstrClsid as BSTR, byval bShow as VARIANT, byval pSuccess as VARIANT ptr) as HRESULT
declare sub IShellDispatch2_ShowBrowserBar_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IShellDispatch3_INTERFACE_DEFINED__
extern IID_IShellDispatch3 as const IID
type IShellDispatch3 as IShellDispatch3_

type IShellDispatch3Vtbl
	QueryInterface as function(byval This as IShellDispatch3 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IShellDispatch3 ptr) as ULONG
	Release as function(byval This as IShellDispatch3 ptr) as ULONG
	GetTypeInfoCount as function(byval This as IShellDispatch3 ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IShellDispatch3 ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IShellDispatch3 ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IShellDispatch3 ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	get_Application as function(byval This as IShellDispatch3 ptr, byval ppid as IDispatch ptr ptr) as HRESULT
	get_Parent as function(byval This as IShellDispatch3 ptr, byval ppid as IDispatch ptr ptr) as HRESULT
	NameSpace as function(byval This as IShellDispatch3 ptr, byval vDir as VARIANT, byval ppsdf as Folder ptr ptr) as HRESULT
	BrowseForFolder as function(byval This as IShellDispatch3 ptr, byval Hwnd as long, byval Title as BSTR, byval Options as long, byval RootFolder as VARIANT, byval ppsdf as Folder ptr ptr) as HRESULT
	Windows as function(byval This as IShellDispatch3 ptr, byval ppid as IDispatch ptr ptr) as HRESULT
	Open as function(byval This as IShellDispatch3 ptr, byval vDir as VARIANT) as HRESULT
	Explore as function(byval This as IShellDispatch3 ptr, byval vDir as VARIANT) as HRESULT
	MinimizeAll as function(byval This as IShellDispatch3 ptr) as HRESULT
	UndoMinimizeALL as function(byval This as IShellDispatch3 ptr) as HRESULT
	FileRun as function(byval This as IShellDispatch3 ptr) as HRESULT
	CascadeWindows as function(byval This as IShellDispatch3 ptr) as HRESULT
	TileVertically as function(byval This as IShellDispatch3 ptr) as HRESULT
	TileHorizontally as function(byval This as IShellDispatch3 ptr) as HRESULT
	ShutdownWindows as function(byval This as IShellDispatch3 ptr) as HRESULT
	Suspend as function(byval This as IShellDispatch3 ptr) as HRESULT
	EjectPC as function(byval This as IShellDispatch3 ptr) as HRESULT
	SetTime as function(byval This as IShellDispatch3 ptr) as HRESULT
	TrayProperties as function(byval This as IShellDispatch3 ptr) as HRESULT
	Help as function(byval This as IShellDispatch3 ptr) as HRESULT
	FindFiles as function(byval This as IShellDispatch3 ptr) as HRESULT
	FindComputer as function(byval This as IShellDispatch3 ptr) as HRESULT
	RefreshMenu as function(byval This as IShellDispatch3 ptr) as HRESULT
	ControlPanelItem as function(byval This as IShellDispatch3 ptr, byval szDir as BSTR) as HRESULT
	IsRestricted as function(byval This as IShellDispatch3 ptr, byval Group as BSTR, byval Restriction as BSTR, byval plRestrictValue as long ptr) as HRESULT

	#ifdef UNICODE
		ShellExecuteW as function(byval This as IShellDispatch3 ptr, byval File as BSTR, byval vArgs as VARIANT, byval vDir as VARIANT, byval vOperation as VARIANT, byval vShow as VARIANT) as HRESULT
	#else
		ShellExecuteA as function(byval This as IShellDispatch3 ptr, byval File as BSTR, byval vArgs as VARIANT, byval vDir as VARIANT, byval vOperation as VARIANT, byval vShow as VARIANT) as HRESULT
	#endif

	FindPrinter as function(byval This as IShellDispatch3 ptr, byval name as BSTR, byval location as BSTR, byval model as BSTR) as HRESULT
	GetSystemInformation as function(byval This as IShellDispatch3 ptr, byval name as BSTR, byval pv as VARIANT ptr) as HRESULT
	ServiceStart as function(byval This as IShellDispatch3 ptr, byval ServiceName as BSTR, byval Persistent as VARIANT, byval pSuccess as VARIANT ptr) as HRESULT
	ServiceStop as function(byval This as IShellDispatch3 ptr, byval ServiceName as BSTR, byval Persistent as VARIANT, byval pSuccess as VARIANT ptr) as HRESULT
	IsServiceRunning as function(byval This as IShellDispatch3 ptr, byval ServiceName as BSTR, byval pRunning as VARIANT ptr) as HRESULT
	CanStartStopService as function(byval This as IShellDispatch3 ptr, byval ServiceName as BSTR, byval pCanStartStop as VARIANT ptr) as HRESULT
	ShowBrowserBar as function(byval This as IShellDispatch3 ptr, byval bstrClsid as BSTR, byval bShow as VARIANT, byval pSuccess as VARIANT ptr) as HRESULT
	AddToRecent as function(byval This as IShellDispatch3 ptr, byval varFile as VARIANT, byval bstrCategory as BSTR) as HRESULT
end type

type IShellDispatch3_
	lpVtbl as IShellDispatch3Vtbl ptr
end type

declare function IShellDispatch3_AddToRecent_Proxy(byval This as IShellDispatch3 ptr, byval varFile as VARIANT, byval bstrCategory as BSTR) as HRESULT
declare sub IShellDispatch3_AddToRecent_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IShellDispatch4_INTERFACE_DEFINED__
extern IID_IShellDispatch4 as const IID
type IShellDispatch4 as IShellDispatch4_

type IShellDispatch4Vtbl
	QueryInterface as function(byval This as IShellDispatch4 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IShellDispatch4 ptr) as ULONG
	Release as function(byval This as IShellDispatch4 ptr) as ULONG
	GetTypeInfoCount as function(byval This as IShellDispatch4 ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IShellDispatch4 ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IShellDispatch4 ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IShellDispatch4 ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	get_Application as function(byval This as IShellDispatch4 ptr, byval ppid as IDispatch ptr ptr) as HRESULT
	get_Parent as function(byval This as IShellDispatch4 ptr, byval ppid as IDispatch ptr ptr) as HRESULT
	NameSpace as function(byval This as IShellDispatch4 ptr, byval vDir as VARIANT, byval ppsdf as Folder ptr ptr) as HRESULT
	BrowseForFolder as function(byval This as IShellDispatch4 ptr, byval Hwnd as long, byval Title as BSTR, byval Options as long, byval RootFolder as VARIANT, byval ppsdf as Folder ptr ptr) as HRESULT
	Windows as function(byval This as IShellDispatch4 ptr, byval ppid as IDispatch ptr ptr) as HRESULT
	Open as function(byval This as IShellDispatch4 ptr, byval vDir as VARIANT) as HRESULT
	Explore as function(byval This as IShellDispatch4 ptr, byval vDir as VARIANT) as HRESULT
	MinimizeAll as function(byval This as IShellDispatch4 ptr) as HRESULT
	UndoMinimizeALL as function(byval This as IShellDispatch4 ptr) as HRESULT
	FileRun as function(byval This as IShellDispatch4 ptr) as HRESULT
	CascadeWindows as function(byval This as IShellDispatch4 ptr) as HRESULT
	TileVertically as function(byval This as IShellDispatch4 ptr) as HRESULT
	TileHorizontally as function(byval This as IShellDispatch4 ptr) as HRESULT
	ShutdownWindows as function(byval This as IShellDispatch4 ptr) as HRESULT
	Suspend as function(byval This as IShellDispatch4 ptr) as HRESULT
	EjectPC as function(byval This as IShellDispatch4 ptr) as HRESULT
	SetTime as function(byval This as IShellDispatch4 ptr) as HRESULT
	TrayProperties as function(byval This as IShellDispatch4 ptr) as HRESULT
	Help as function(byval This as IShellDispatch4 ptr) as HRESULT
	FindFiles as function(byval This as IShellDispatch4 ptr) as HRESULT
	FindComputer as function(byval This as IShellDispatch4 ptr) as HRESULT
	RefreshMenu as function(byval This as IShellDispatch4 ptr) as HRESULT
	ControlPanelItem as function(byval This as IShellDispatch4 ptr, byval szDir as BSTR) as HRESULT
	IsRestricted as function(byval This as IShellDispatch4 ptr, byval Group as BSTR, byval Restriction as BSTR, byval plRestrictValue as long ptr) as HRESULT

	#ifdef UNICODE
		ShellExecuteW as function(byval This as IShellDispatch4 ptr, byval File as BSTR, byval vArgs as VARIANT, byval vDir as VARIANT, byval vOperation as VARIANT, byval vShow as VARIANT) as HRESULT
	#else
		ShellExecuteA as function(byval This as IShellDispatch4 ptr, byval File as BSTR, byval vArgs as VARIANT, byval vDir as VARIANT, byval vOperation as VARIANT, byval vShow as VARIANT) as HRESULT
	#endif

	FindPrinter as function(byval This as IShellDispatch4 ptr, byval name as BSTR, byval location as BSTR, byval model as BSTR) as HRESULT
	GetSystemInformation as function(byval This as IShellDispatch4 ptr, byval name as BSTR, byval pv as VARIANT ptr) as HRESULT
	ServiceStart as function(byval This as IShellDispatch4 ptr, byval ServiceName as BSTR, byval Persistent as VARIANT, byval pSuccess as VARIANT ptr) as HRESULT
	ServiceStop as function(byval This as IShellDispatch4 ptr, byval ServiceName as BSTR, byval Persistent as VARIANT, byval pSuccess as VARIANT ptr) as HRESULT
	IsServiceRunning as function(byval This as IShellDispatch4 ptr, byval ServiceName as BSTR, byval pRunning as VARIANT ptr) as HRESULT
	CanStartStopService as function(byval This as IShellDispatch4 ptr, byval ServiceName as BSTR, byval pCanStartStop as VARIANT ptr) as HRESULT
	ShowBrowserBar as function(byval This as IShellDispatch4 ptr, byval bstrClsid as BSTR, byval bShow as VARIANT, byval pSuccess as VARIANT ptr) as HRESULT
	AddToRecent as function(byval This as IShellDispatch4 ptr, byval varFile as VARIANT, byval bstrCategory as BSTR) as HRESULT
	WindowsSecurity as function(byval This as IShellDispatch4 ptr) as HRESULT
	ToggleDesktop as function(byval This as IShellDispatch4 ptr) as HRESULT
	ExplorerPolicy as function(byval This as IShellDispatch4 ptr, byval bstrPolicyName as BSTR, byval pValue as VARIANT ptr) as HRESULT
	GetSetting as function(byval This as IShellDispatch4 ptr, byval lSetting as long, byval pResult as VARIANT_BOOL ptr) as HRESULT
end type

type IShellDispatch4_
	lpVtbl as IShellDispatch4Vtbl ptr
end type

declare function IShellDispatch4_WindowsSecurity_Proxy(byval This as IShellDispatch4 ptr) as HRESULT
declare sub IShellDispatch4_WindowsSecurity_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellDispatch4_ToggleDesktop_Proxy(byval This as IShellDispatch4 ptr) as HRESULT
declare sub IShellDispatch4_ToggleDesktop_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellDispatch4_ExplorerPolicy_Proxy(byval This as IShellDispatch4 ptr, byval bstrPolicyName as BSTR, byval pValue as VARIANT ptr) as HRESULT
declare sub IShellDispatch4_ExplorerPolicy_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IShellDispatch4_GetSetting_Proxy(byval This as IShellDispatch4 ptr, byval lSetting as long, byval pResult as VARIANT_BOOL ptr) as HRESULT
declare sub IShellDispatch4_GetSetting_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

extern CLSID_Shell as const CLSID
extern CLSID_ShellDispatchInproc as const CLSID
extern CLSID_WebViewFolderContents as const CLSID
#define __DSearchCommandEvents_DISPINTERFACE_DEFINED__
extern DIID_DSearchCommandEvents as const IID
type DSearchCommandEvents as DSearchCommandEvents_

type DSearchCommandEventsVtbl
	QueryInterface as function(byval This as DSearchCommandEvents ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as DSearchCommandEvents ptr) as ULONG
	Release as function(byval This as DSearchCommandEvents ptr) as ULONG
	GetTypeInfoCount as function(byval This as DSearchCommandEvents ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as DSearchCommandEvents ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as DSearchCommandEvents ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as DSearchCommandEvents ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
end type

type DSearchCommandEvents_
	lpVtbl as DSearchCommandEventsVtbl ptr
end type

extern CLSID_SearchCommand as const CLSID
#define __IFileSearchBand_INTERFACE_DEFINED__
extern IID_IFileSearchBand as const IID
type IFileSearchBand as IFileSearchBand_

type IFileSearchBandVtbl
	QueryInterface as function(byval This as IFileSearchBand ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IFileSearchBand ptr) as ULONG
	Release as function(byval This as IFileSearchBand ptr) as ULONG
	GetTypeInfoCount as function(byval This as IFileSearchBand ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IFileSearchBand ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IFileSearchBand ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IFileSearchBand ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	SetFocus as function(byval This as IFileSearchBand ptr) as HRESULT
	SetSearchParameters as function(byval This as IFileSearchBand ptr, byval pbstrSearchID as BSTR ptr, byval bNavToResults as VARIANT_BOOL, byval pvarScope as VARIANT ptr, byval pvarQueryFile as VARIANT ptr) as HRESULT
	get_SearchID as function(byval This as IFileSearchBand ptr, byval pbstrSearchID as BSTR ptr) as HRESULT
	get_Scope as function(byval This as IFileSearchBand ptr, byval pvarScope as VARIANT ptr) as HRESULT
	get_QueryFile as function(byval This as IFileSearchBand ptr, byval pvarFile as VARIANT ptr) as HRESULT
end type

type IFileSearchBand_
	lpVtbl as IFileSearchBandVtbl ptr
end type

declare function IFileSearchBand_SetFocus_Proxy(byval This as IFileSearchBand ptr) as HRESULT
declare sub IFileSearchBand_SetFocus_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IFileSearchBand_SetSearchParameters_Proxy(byval This as IFileSearchBand ptr, byval pbstrSearchID as BSTR ptr, byval bNavToResults as VARIANT_BOOL, byval pvarScope as VARIANT ptr, byval pvarQueryFile as VARIANT ptr) as HRESULT
declare sub IFileSearchBand_SetSearchParameters_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IFileSearchBand_get_SearchID_Proxy(byval This as IFileSearchBand ptr, byval pbstrSearchID as BSTR ptr) as HRESULT
declare sub IFileSearchBand_get_SearchID_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IFileSearchBand_get_Scope_Proxy(byval This as IFileSearchBand ptr, byval pvarScope as VARIANT ptr) as HRESULT
declare sub IFileSearchBand_get_Scope_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IFileSearchBand_get_QueryFile_Proxy(byval This as IFileSearchBand ptr, byval pvarFile as VARIANT ptr) as HRESULT
declare sub IFileSearchBand_get_QueryFile_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
extern CLSID_FileSearchBand as const CLSID
#define __IWebWizardHost_INTERFACE_DEFINED__
extern IID_IWebWizardHost as const IID
type IWebWizardHost as IWebWizardHost_

type IWebWizardHostVtbl
	QueryInterface as function(byval This as IWebWizardHost ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IWebWizardHost ptr) as ULONG
	Release as function(byval This as IWebWizardHost ptr) as ULONG
	GetTypeInfoCount as function(byval This as IWebWizardHost ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IWebWizardHost ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IWebWizardHost ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IWebWizardHost ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	FinalBack as function(byval This as IWebWizardHost ptr) as HRESULT
	FinalNext as function(byval This as IWebWizardHost ptr) as HRESULT
	Cancel as function(byval This as IWebWizardHost ptr) as HRESULT
	put_Caption as function(byval This as IWebWizardHost ptr, byval bstrCaption as BSTR) as HRESULT
	get_Caption as function(byval This as IWebWizardHost ptr, byval pbstrCaption as BSTR ptr) as HRESULT
	put_Property as function(byval This as IWebWizardHost ptr, byval bstrPropertyName as BSTR, byval pvProperty as VARIANT ptr) as HRESULT
	get_Property as function(byval This as IWebWizardHost ptr, byval bstrPropertyName as BSTR, byval pvProperty as VARIANT ptr) as HRESULT
	SetWizardButtons as function(byval This as IWebWizardHost ptr, byval vfEnableBack as VARIANT_BOOL, byval vfEnableNext as VARIANT_BOOL, byval vfLastPage as VARIANT_BOOL) as HRESULT
	SetHeaderText as function(byval This as IWebWizardHost ptr, byval bstrHeaderTitle as BSTR, byval bstrHeaderSubtitle as BSTR) as HRESULT
end type

type IWebWizardHost_
	lpVtbl as IWebWizardHostVtbl ptr
end type

declare function IWebWizardHost_FinalBack_Proxy(byval This as IWebWizardHost ptr) as HRESULT
declare sub IWebWizardHost_FinalBack_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebWizardHost_FinalNext_Proxy(byval This as IWebWizardHost ptr) as HRESULT
declare sub IWebWizardHost_FinalNext_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebWizardHost_Cancel_Proxy(byval This as IWebWizardHost ptr) as HRESULT
declare sub IWebWizardHost_Cancel_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebWizardHost_put_Caption_Proxy(byval This as IWebWizardHost ptr, byval bstrCaption as BSTR) as HRESULT
declare sub IWebWizardHost_put_Caption_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebWizardHost_get_Caption_Proxy(byval This as IWebWizardHost ptr, byval pbstrCaption as BSTR ptr) as HRESULT
declare sub IWebWizardHost_get_Caption_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebWizardHost_put_Property_Proxy(byval This as IWebWizardHost ptr, byval bstrPropertyName as BSTR, byval pvProperty as VARIANT ptr) as HRESULT
declare sub IWebWizardHost_put_Property_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebWizardHost_get_Property_Proxy(byval This as IWebWizardHost ptr, byval bstrPropertyName as BSTR, byval pvProperty as VARIANT ptr) as HRESULT
declare sub IWebWizardHost_get_Property_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebWizardHost_SetWizardButtons_Proxy(byval This as IWebWizardHost ptr, byval vfEnableBack as VARIANT_BOOL, byval vfEnableNext as VARIANT_BOOL, byval vfLastPage as VARIANT_BOOL) as HRESULT
declare sub IWebWizardHost_SetWizardButtons_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IWebWizardHost_SetHeaderText_Proxy(byval This as IWebWizardHost ptr, byval bstrHeaderTitle as BSTR, byval bstrHeaderSubtitle as BSTR) as HRESULT
declare sub IWebWizardHost_SetHeaderText_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __INewWDEvents_INTERFACE_DEFINED__
extern IID_INewWDEvents as const IID
type INewWDEvents as INewWDEvents_

type INewWDEventsVtbl
	QueryInterface as function(byval This as INewWDEvents ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as INewWDEvents ptr) as ULONG
	Release as function(byval This as INewWDEvents ptr) as ULONG
	GetTypeInfoCount as function(byval This as INewWDEvents ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as INewWDEvents ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as INewWDEvents ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as INewWDEvents ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	FinalBack as function(byval This as INewWDEvents ptr) as HRESULT
	FinalNext as function(byval This as INewWDEvents ptr) as HRESULT
	Cancel as function(byval This as INewWDEvents ptr) as HRESULT
	put_Caption as function(byval This as INewWDEvents ptr, byval bstrCaption as BSTR) as HRESULT
	get_Caption as function(byval This as INewWDEvents ptr, byval pbstrCaption as BSTR ptr) as HRESULT
	put_Property as function(byval This as INewWDEvents ptr, byval bstrPropertyName as BSTR, byval pvProperty as VARIANT ptr) as HRESULT
	get_Property as function(byval This as INewWDEvents ptr, byval bstrPropertyName as BSTR, byval pvProperty as VARIANT ptr) as HRESULT
	SetWizardButtons as function(byval This as INewWDEvents ptr, byval vfEnableBack as VARIANT_BOOL, byval vfEnableNext as VARIANT_BOOL, byval vfLastPage as VARIANT_BOOL) as HRESULT
	SetHeaderText as function(byval This as INewWDEvents ptr, byval bstrHeaderTitle as BSTR, byval bstrHeaderSubtitle as BSTR) as HRESULT
	PassportAuthenticate as function(byval This as INewWDEvents ptr, byval bstrSignInUrl as BSTR, byval pvfAuthenitcated as VARIANT_BOOL ptr) as HRESULT
end type

type INewWDEvents_
	lpVtbl as INewWDEventsVtbl ptr
end type

declare function INewWDEvents_PassportAuthenticate_Proxy(byval This as INewWDEvents ptr, byval bstrSignInUrl as BSTR, byval pvfAuthenitcated as VARIANT_BOOL ptr) as HRESULT
declare sub INewWDEvents_PassportAuthenticate_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IPassportClientServices_INTERFACE_DEFINED__
extern IID_IPassportClientServices as const IID
type IPassportClientServices as IPassportClientServices_

type IPassportClientServicesVtbl
	QueryInterface as function(byval This as IPassportClientServices ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IPassportClientServices ptr) as ULONG
	Release as function(byval This as IPassportClientServices ptr) as ULONG
	GetTypeInfoCount as function(byval This as IPassportClientServices ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IPassportClientServices ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IPassportClientServices ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IPassportClientServices ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	MemberExists as function(byval This as IPassportClientServices ptr, byval bstrUser as BSTR, byval bstrPassword as BSTR, byval pvfExists as VARIANT_BOOL ptr) as HRESULT
end type

type IPassportClientServices_
	lpVtbl as IPassportClientServicesVtbl ptr
end type

declare function IPassportClientServices_MemberExists_Proxy(byval This as IPassportClientServices ptr, byval bstrUser as BSTR, byval bstrPassword as BSTR, byval pvfExists as VARIANT_BOOL ptr) as HRESULT
declare sub IPassportClientServices_MemberExists_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
extern CLSID_PassportClientServices as const CLSID
extern __MIDL_itf_shldisp_0287_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_shldisp_0287_v0_0_s_ifspec as RPC_IF_HANDLE
#define __IAutoComplete_INTERFACE_DEFINED__
type IAutoComplete as IAutoComplete_
type LPAUTOCOMPLETE as IAutoComplete ptr
extern IID_IAutoComplete as const IID

type IAutoCompleteVtbl
	QueryInterface as function(byval This as IAutoComplete ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAutoComplete ptr) as ULONG
	Release as function(byval This as IAutoComplete ptr) as ULONG
	Init as function(byval This as IAutoComplete ptr, byval hwndEdit as HWND, byval punkACL as IUnknown ptr, byval pwszRegKeyPath as LPCOLESTR, byval pwszQuickComplete as LPCOLESTR) as HRESULT
	Enable as function(byval This as IAutoComplete ptr, byval fEnable as WINBOOL) as HRESULT
end type

type IAutoComplete_
	lpVtbl as IAutoCompleteVtbl ptr
end type

declare function IAutoComplete_Init_Proxy(byval This as IAutoComplete ptr, byval hwndEdit as HWND, byval punkACL as IUnknown ptr, byval pwszRegKeyPath as LPCOLESTR, byval pwszQuickComplete as LPCOLESTR) as HRESULT
declare sub IAutoComplete_Init_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAutoComplete_Enable_Proxy(byval This as IAutoComplete ptr, byval fEnable as WINBOOL) as HRESULT
declare sub IAutoComplete_Enable_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IAutoComplete2_INTERFACE_DEFINED__
type IAutoComplete2 as IAutoComplete2_
type LPAUTOCOMPLETE2 as IAutoComplete2 ptr

type _tagAUTOCOMPLETEOPTIONS as long
enum
	ACO_NONE = 0
	ACO_AUTOSUGGEST = &h1
	ACO_AUTOAPPEND = &h2
	ACO_SEARCH = &h4
	ACO_FILTERPREFIXES = &h8
	ACO_USETAB = &h10
	ACO_UPDOWNKEYDROPSLIST = &h20
	ACO_RTLREADING = &h40
end enum

type AUTOCOMPLETEOPTIONS as _tagAUTOCOMPLETEOPTIONS
extern IID_IAutoComplete2 as const IID

type IAutoComplete2Vtbl
	QueryInterface as function(byval This as IAutoComplete2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAutoComplete2 ptr) as ULONG
	Release as function(byval This as IAutoComplete2 ptr) as ULONG
	Init as function(byval This as IAutoComplete2 ptr, byval hwndEdit as HWND, byval punkACL as IUnknown ptr, byval pwszRegKeyPath as LPCOLESTR, byval pwszQuickComplete as LPCOLESTR) as HRESULT
	Enable as function(byval This as IAutoComplete2 ptr, byval fEnable as WINBOOL) as HRESULT
	SetOptions as function(byval This as IAutoComplete2 ptr, byval dwFlag as DWORD) as HRESULT
	GetOptions as function(byval This as IAutoComplete2 ptr, byval pdwFlag as DWORD ptr) as HRESULT
end type

type IAutoComplete2_
	lpVtbl as IAutoComplete2Vtbl ptr
end type

declare function IAutoComplete2_SetOptions_Proxy(byval This as IAutoComplete2 ptr, byval dwFlag as DWORD) as HRESULT
declare sub IAutoComplete2_SetOptions_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAutoComplete2_GetOptions_Proxy(byval This as IAutoComplete2 ptr, byval pdwFlag as DWORD ptr) as HRESULT
declare sub IAutoComplete2_GetOptions_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
extern __MIDL_itf_shldisp_0289_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_shldisp_0289_v0_0_s_ifspec as RPC_IF_HANDLE
#define __IEnumACString_INTERFACE_DEFINED__

type IEnumACString as IEnumACString_
type PENUMACSTRING as IEnumACString ptr
type LPENUMACSTRING as IEnumACString ptr

type _tagACENUMOPTION as long
enum
	ACEO_NONE = 0
	ACEO_MOSTRECENTFIRST = &h1
	ACEO_FIRSTUNUSED = &h10000
end enum

type ACENUMOPTION as _tagACENUMOPTION
extern IID_IEnumACString as const IID

type IEnumACStringVtbl
	QueryInterface as function(byval This as IEnumACString ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IEnumACString ptr) as ULONG
	Release as function(byval This as IEnumACString ptr) as ULONG
	Next as function(byval This as IEnumACString ptr, byval celt as ULONG, byval rgelt as LPOLESTR ptr, byval pceltFetched as ULONG ptr) as HRESULT
	Skip as function(byval This as IEnumACString ptr, byval celt as ULONG) as HRESULT
	Reset as function(byval This as IEnumACString ptr) as HRESULT
	Clone as function(byval This as IEnumACString ptr, byval ppenum as IEnumString ptr ptr) as HRESULT
	NextItem as function(byval This as IEnumACString ptr, byval pszUrl as LPOLESTR, byval cchMax as ULONG, byval pulSortIndex as ULONG ptr) as HRESULT
	SetEnumOptions as function(byval This as IEnumACString ptr, byval dwOptions as DWORD) as HRESULT
	GetEnumOptions as function(byval This as IEnumACString ptr, byval pdwOptions as DWORD ptr) as HRESULT
end type

type IEnumACString_
	lpVtbl as IEnumACStringVtbl ptr
end type

declare function IEnumACString_NextItem_Proxy(byval This as IEnumACString ptr, byval pszUrl as LPOLESTR, byval cchMax as ULONG, byval pulSortIndex as ULONG ptr) as HRESULT
declare sub IEnumACString_NextItem_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IEnumACString_SetEnumOptions_Proxy(byval This as IEnumACString ptr, byval dwOptions as DWORD) as HRESULT
declare sub IEnumACString_SetEnumOptions_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IEnumACString_GetEnumOptions_Proxy(byval This as IEnumACString ptr, byval pdwOptions as DWORD ptr) as HRESULT
declare sub IEnumACString_GetEnumOptions_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
extern __MIDL_itf_shldisp_0290_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_shldisp_0290_v0_0_s_ifspec as RPC_IF_HANDLE
#define __IAsyncOperation_INTERFACE_DEFINED__
type IAsyncOperation as IAsyncOperation_
type LPASYNCOPERATION as IAsyncOperation ptr
extern IID_IAsyncOperation as const IID

type IAsyncOperationVtbl
	QueryInterface as function(byval This as IAsyncOperation ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAsyncOperation ptr) as ULONG
	Release as function(byval This as IAsyncOperation ptr) as ULONG
	SetAsyncMode as function(byval This as IAsyncOperation ptr, byval fDoOpAsync as WINBOOL) as HRESULT
	GetAsyncMode as function(byval This as IAsyncOperation ptr, byval pfIsOpAsync as WINBOOL ptr) as HRESULT
	StartOperation as function(byval This as IAsyncOperation ptr, byval pbcReserved as IBindCtx ptr) as HRESULT
	InOperation as function(byval This as IAsyncOperation ptr, byval pfInAsyncOp as WINBOOL ptr) as HRESULT
	EndOperation as function(byval This as IAsyncOperation ptr, byval hResult as HRESULT, byval pbcReserved as IBindCtx ptr, byval dwEffects as DWORD) as HRESULT
end type

type IAsyncOperation_
	lpVtbl as IAsyncOperationVtbl ptr
end type

declare function IAsyncOperation_SetAsyncMode_Proxy(byval This as IAsyncOperation ptr, byval fDoOpAsync as WINBOOL) as HRESULT
declare sub IAsyncOperation_SetAsyncMode_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAsyncOperation_GetAsyncMode_Proxy(byval This as IAsyncOperation ptr, byval pfIsOpAsync as WINBOOL ptr) as HRESULT
declare sub IAsyncOperation_GetAsyncMode_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAsyncOperation_StartOperation_Proxy(byval This as IAsyncOperation ptr, byval pbcReserved as IBindCtx ptr) as HRESULT
declare sub IAsyncOperation_StartOperation_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAsyncOperation_InOperation_Proxy(byval This as IAsyncOperation ptr, byval pfInAsyncOp as WINBOOL ptr) as HRESULT
declare sub IAsyncOperation_InOperation_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IAsyncOperation_EndOperation_Proxy(byval This as IAsyncOperation ptr, byval hResult as HRESULT, byval pbcReserved as IBindCtx ptr, byval dwEffects as DWORD) as HRESULT
declare sub IAsyncOperation_EndOperation_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

end extern
