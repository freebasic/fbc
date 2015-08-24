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

#include once "rpc.bi"
#include once "rpcndr.bi"
#include once "windows.bi"
#include once "ole2.bi"
#include once "ocidl.bi"
#include once "winapifamily.bi"

extern "Windows"

#define __shldisp_h__
#define __IFolderViewOC_FWD_DEFINED__
#define __DShellFolderViewEvents_FWD_DEFINED__
#define __ShellFolderViewOC_FWD_DEFINED__
#define __DFConstraint_FWD_DEFINED__
#define __Folder_FWD_DEFINED__
#define __Folder2_FWD_DEFINED__
#define __Folder3_FWD_DEFINED__
#define __FolderItem_FWD_DEFINED__
#define __FolderItem2_FWD_DEFINED__
#define __ShellFolderItem_FWD_DEFINED__
#define __FolderItems_FWD_DEFINED__
#define __FolderItems2_FWD_DEFINED__
#define __FolderItems3_FWD_DEFINED__
#define __FolderItemVerb_FWD_DEFINED__
#define __FolderItemVerbs_FWD_DEFINED__
#define __IShellLinkDual_FWD_DEFINED__
#define __IShellLinkDual2_FWD_DEFINED__
#define __ShellLinkObject_FWD_DEFINED__
#define __IShellFolderViewDual_FWD_DEFINED__
#define __IShellFolderViewDual2_FWD_DEFINED__
#define __IShellFolderViewDual3_FWD_DEFINED__
#define __ShellFolderView_FWD_DEFINED__
#define __IShellDispatch_FWD_DEFINED__
#define __IShellDispatch2_FWD_DEFINED__
#define __IShellDispatch3_FWD_DEFINED__
#define __IShellDispatch4_FWD_DEFINED__
#define __IShellDispatch5_FWD_DEFINED__
#define __IShellDispatch6_FWD_DEFINED__
#define __Shell_FWD_DEFINED__
#define __ShellDispatchInproc_FWD_DEFINED__
#define __IFileSearchBand_FWD_DEFINED__
#define __FileSearchBand_FWD_DEFINED__
#define __IWebWizardHost_FWD_DEFINED__
#define __INewWDEvents_FWD_DEFINED__
#define __IAutoComplete_FWD_DEFINED__
#define __IAutoComplete2_FWD_DEFINED__
#define __IEnumACString_FWD_DEFINED__
#define __IDataObjectAsyncCapability_FWD_DEFINED__
extern LIBID_Shell32 as const GUID
#define __IFolderViewOC_INTERFACE_DEFINED__
extern IID_IFolderViewOC as const GUID
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

#define IFolderViewOC_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IFolderViewOC_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IFolderViewOC_Release(This) (This)->lpVtbl->Release(This)
#define IFolderViewOC_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define IFolderViewOC_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define IFolderViewOC_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define IFolderViewOC_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define IFolderViewOC_SetFolderView(This, pdisp) (This)->lpVtbl->SetFolderView(This, pdisp)
declare function IFolderViewOC_SetFolderView_Proxy(byval This as IFolderViewOC ptr, byval pdisp as IDispatch ptr) as HRESULT
declare sub IFolderViewOC_SetFolderView_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __DShellFolderViewEvents_DISPINTERFACE_DEFINED__
extern DIID_DShellFolderViewEvents as const GUID
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

#define DShellFolderViewEvents_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define DShellFolderViewEvents_AddRef(This) (This)->lpVtbl->AddRef(This)
#define DShellFolderViewEvents_Release(This) (This)->lpVtbl->Release(This)
#define DShellFolderViewEvents_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define DShellFolderViewEvents_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define DShellFolderViewEvents_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define DShellFolderViewEvents_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
extern CLSID_ShellFolderViewOC as const GUID
#define __DFConstraint_INTERFACE_DEFINED__
extern IID_DFConstraint as const GUID
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

#define DFConstraint_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define DFConstraint_AddRef(This) (This)->lpVtbl->AddRef(This)
#define DFConstraint_Release(This) (This)->lpVtbl->Release(This)
#define DFConstraint_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define DFConstraint_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define DFConstraint_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define DFConstraint_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define DFConstraint_get_Name(This, pbs) (This)->lpVtbl->get_Name(This, pbs)
#define DFConstraint_get_Value(This, pv) (This)->lpVtbl->get_Value(This, pv)

declare function DFConstraint_get_Name_Proxy(byval This as DFConstraint ptr, byval pbs as BSTR ptr) as HRESULT
declare sub DFConstraint_get_Name_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function DFConstraint_get_Value_Proxy(byval This as DFConstraint ptr, byval pv as VARIANT ptr) as HRESULT
declare sub DFConstraint_get_Value_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __Folder_INTERFACE_DEFINED__
extern IID_Folder as const GUID

type Folder as Folder_
type FolderItems as FolderItems_
type FolderItem as FolderItem_

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

#define Folder_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define Folder_AddRef(This) (This)->lpVtbl->AddRef(This)
#define Folder_Release(This) (This)->lpVtbl->Release(This)
#define Folder_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define Folder_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define Folder_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define Folder_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define Folder_get_Title(This, pbs) (This)->lpVtbl->get_Title(This, pbs)
#define Folder_get_Application(This, ppid) (This)->lpVtbl->get_Application(This, ppid)
#define Folder_get_Parent(This, ppid) (This)->lpVtbl->get_Parent(This, ppid)
#define Folder_get_ParentFolder(This, ppsf) (This)->lpVtbl->get_ParentFolder(This, ppsf)
#define Folder_Items(This, ppid) (This)->lpVtbl->Items(This, ppid)
#define Folder_ParseName(This, bName, ppid) (This)->lpVtbl->ParseName(This, bName, ppid)
#define Folder_NewFolder(This, bName, vOptions) (This)->lpVtbl->NewFolder(This, bName, vOptions)
#define Folder_MoveHere(This, vItem, vOptions) (This)->lpVtbl->MoveHere(This, vItem, vOptions)
#define Folder_CopyHere(This, vItem, vOptions) (This)->lpVtbl->CopyHere(This, vItem, vOptions)
#define Folder_GetDetailsOf(This, vItem, iColumn, pbs) (This)->lpVtbl->GetDetailsOf(This, vItem, iColumn, pbs)

declare function Folder_get_Title_Proxy(byval This as Folder ptr, byval pbs as BSTR ptr) as HRESULT
declare sub Folder_get_Title_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function Folder_get_Application_Proxy(byval This as Folder ptr, byval ppid as IDispatch ptr ptr) as HRESULT
declare sub Folder_get_Application_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function Folder_get_Parent_Proxy(byval This as Folder ptr, byval ppid as IDispatch ptr ptr) as HRESULT
declare sub Folder_get_Parent_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function Folder_get_ParentFolder_Proxy(byval This as Folder ptr, byval ppsf as Folder ptr ptr) as HRESULT
declare sub Folder_get_ParentFolder_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function Folder_Items_Proxy(byval This as Folder ptr, byval ppid as FolderItems ptr ptr) as HRESULT
declare sub Folder_Items_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function Folder_ParseName_Proxy(byval This as Folder ptr, byval bName as BSTR, byval ppid as FolderItem ptr ptr) as HRESULT
declare sub Folder_ParseName_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function Folder_NewFolder_Proxy(byval This as Folder ptr, byval bName as BSTR, byval vOptions as VARIANT) as HRESULT
declare sub Folder_NewFolder_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function Folder_MoveHere_Proxy(byval This as Folder ptr, byval vItem as VARIANT, byval vOptions as VARIANT) as HRESULT
declare sub Folder_MoveHere_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function Folder_CopyHere_Proxy(byval This as Folder ptr, byval vItem as VARIANT, byval vOptions as VARIANT) as HRESULT
declare sub Folder_CopyHere_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function Folder_GetDetailsOf_Proxy(byval This as Folder ptr, byval vItem as VARIANT, byval iColumn as long, byval pbs as BSTR ptr) as HRESULT
declare sub Folder_GetDetailsOf_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __Folder2_INTERFACE_DEFINED__
extern IID_Folder2 as const GUID
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

#define Folder2_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define Folder2_AddRef(This) (This)->lpVtbl->AddRef(This)
#define Folder2_Release(This) (This)->lpVtbl->Release(This)
#define Folder2_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define Folder2_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define Folder2_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define Folder2_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define Folder2_get_Title(This, pbs) (This)->lpVtbl->get_Title(This, pbs)
#define Folder2_get_Application(This, ppid) (This)->lpVtbl->get_Application(This, ppid)
#define Folder2_get_Parent(This, ppid) (This)->lpVtbl->get_Parent(This, ppid)
#define Folder2_get_ParentFolder(This, ppsf) (This)->lpVtbl->get_ParentFolder(This, ppsf)
#define Folder2_Items(This, ppid) (This)->lpVtbl->Items(This, ppid)
#define Folder2_ParseName(This, bName, ppid) (This)->lpVtbl->ParseName(This, bName, ppid)
#define Folder2_NewFolder(This, bName, vOptions) (This)->lpVtbl->NewFolder(This, bName, vOptions)
#define Folder2_MoveHere(This, vItem, vOptions) (This)->lpVtbl->MoveHere(This, vItem, vOptions)
#define Folder2_CopyHere(This, vItem, vOptions) (This)->lpVtbl->CopyHere(This, vItem, vOptions)
#define Folder2_GetDetailsOf(This, vItem, iColumn, pbs) (This)->lpVtbl->GetDetailsOf(This, vItem, iColumn, pbs)
#define Folder2_get_Self(This, ppfi) (This)->lpVtbl->get_Self(This, ppfi)
#define Folder2_get_OfflineStatus(This, pul) (This)->lpVtbl->get_OfflineStatus(This, pul)
#define Folder2_Synchronize(This) (This)->lpVtbl->Synchronize(This)
#define Folder2_get_HaveToShowWebViewBarricade(This, pbHaveToShowWebViewBarricade) (This)->lpVtbl->get_HaveToShowWebViewBarricade(This, pbHaveToShowWebViewBarricade)
#define Folder2_DismissedWebViewBarricade(This) (This)->lpVtbl->DismissedWebViewBarricade(This)

declare function Folder2_get_Self_Proxy(byval This as Folder2 ptr, byval ppfi as FolderItem ptr ptr) as HRESULT
declare sub Folder2_get_Self_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function Folder2_get_OfflineStatus_Proxy(byval This as Folder2 ptr, byval pul as LONG ptr) as HRESULT
declare sub Folder2_get_OfflineStatus_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function Folder2_Synchronize_Proxy(byval This as Folder2 ptr) as HRESULT
declare sub Folder2_Synchronize_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function Folder2_get_HaveToShowWebViewBarricade_Proxy(byval This as Folder2 ptr, byval pbHaveToShowWebViewBarricade as VARIANT_BOOL ptr) as HRESULT
declare sub Folder2_get_HaveToShowWebViewBarricade_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function Folder2_DismissedWebViewBarricade_Proxy(byval This as Folder2 ptr) as HRESULT
declare sub Folder2_DismissedWebViewBarricade_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

type OfflineFolderStatus as long
enum
	OFS_INACTIVE = -1
	OFS_ONLINE = 0
	OFS_OFFLINE = 1
	OFS_SERVERBACK = 2
	OFS_DIRTYCACHE = 3
end enum

#define __Folder3_INTERFACE_DEFINED__
extern IID_Folder3 as const GUID
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

#define Folder3_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define Folder3_AddRef(This) (This)->lpVtbl->AddRef(This)
#define Folder3_Release(This) (This)->lpVtbl->Release(This)
#define Folder3_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define Folder3_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define Folder3_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define Folder3_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define Folder3_get_Title(This, pbs) (This)->lpVtbl->get_Title(This, pbs)
#define Folder3_get_Application(This, ppid) (This)->lpVtbl->get_Application(This, ppid)
#define Folder3_get_Parent(This, ppid) (This)->lpVtbl->get_Parent(This, ppid)
#define Folder3_get_ParentFolder(This, ppsf) (This)->lpVtbl->get_ParentFolder(This, ppsf)
#define Folder3_Items(This, ppid) (This)->lpVtbl->Items(This, ppid)
#define Folder3_ParseName(This, bName, ppid) (This)->lpVtbl->ParseName(This, bName, ppid)
#define Folder3_NewFolder(This, bName, vOptions) (This)->lpVtbl->NewFolder(This, bName, vOptions)
#define Folder3_MoveHere(This, vItem, vOptions) (This)->lpVtbl->MoveHere(This, vItem, vOptions)
#define Folder3_CopyHere(This, vItem, vOptions) (This)->lpVtbl->CopyHere(This, vItem, vOptions)
#define Folder3_GetDetailsOf(This, vItem, iColumn, pbs) (This)->lpVtbl->GetDetailsOf(This, vItem, iColumn, pbs)
#define Folder3_get_Self(This, ppfi) (This)->lpVtbl->get_Self(This, ppfi)
#define Folder3_get_OfflineStatus(This, pul) (This)->lpVtbl->get_OfflineStatus(This, pul)
#define Folder3_Synchronize(This) (This)->lpVtbl->Synchronize(This)
#define Folder3_get_HaveToShowWebViewBarricade(This, pbHaveToShowWebViewBarricade) (This)->lpVtbl->get_HaveToShowWebViewBarricade(This, pbHaveToShowWebViewBarricade)
#define Folder3_DismissedWebViewBarricade(This) (This)->lpVtbl->DismissedWebViewBarricade(This)
#define Folder3_get_ShowWebViewBarricade(This, pbShowWebViewBarricade) (This)->lpVtbl->get_ShowWebViewBarricade(This, pbShowWebViewBarricade)
#define Folder3_put_ShowWebViewBarricade(This, bShowWebViewBarricade) (This)->lpVtbl->put_ShowWebViewBarricade(This, bShowWebViewBarricade)

declare function Folder3_get_ShowWebViewBarricade_Proxy(byval This as Folder3 ptr, byval pbShowWebViewBarricade as VARIANT_BOOL ptr) as HRESULT
declare sub Folder3_get_ShowWebViewBarricade_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function Folder3_put_ShowWebViewBarricade_Proxy(byval This as Folder3 ptr, byval bShowWebViewBarricade as VARIANT_BOOL) as HRESULT
declare sub Folder3_put_ShowWebViewBarricade_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __FolderItem_INTERFACE_DEFINED__
type LPFOLDERITEM as FolderItem ptr
extern IID_FolderItem as const GUID
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

#define FolderItem_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define FolderItem_AddRef(This) (This)->lpVtbl->AddRef(This)
#define FolderItem_Release(This) (This)->lpVtbl->Release(This)
#define FolderItem_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define FolderItem_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define FolderItem_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define FolderItem_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define FolderItem_get_Application(This, ppid) (This)->lpVtbl->get_Application(This, ppid)
#define FolderItem_get_Parent(This, ppid) (This)->lpVtbl->get_Parent(This, ppid)
#define FolderItem_get_Name(This, pbs) (This)->lpVtbl->get_Name(This, pbs)
#define FolderItem_put_Name(This, bs) (This)->lpVtbl->put_Name(This, bs)
#define FolderItem_get_Path(This, pbs) (This)->lpVtbl->get_Path(This, pbs)
#define FolderItem_get_GetLink(This, ppid) (This)->lpVtbl->get_GetLink(This, ppid)
#define FolderItem_get_GetFolder(This, ppid) (This)->lpVtbl->get_GetFolder(This, ppid)
#define FolderItem_get_IsLink(This, pb) (This)->lpVtbl->get_IsLink(This, pb)
#define FolderItem_get_IsFolder(This, pb) (This)->lpVtbl->get_IsFolder(This, pb)
#define FolderItem_get_IsFileSystem(This, pb) (This)->lpVtbl->get_IsFileSystem(This, pb)
#define FolderItem_get_IsBrowsable(This, pb) (This)->lpVtbl->get_IsBrowsable(This, pb)
#define FolderItem_get_ModifyDate(This, pdt) (This)->lpVtbl->get_ModifyDate(This, pdt)
#define FolderItem_put_ModifyDate(This, dt) (This)->lpVtbl->put_ModifyDate(This, dt)
#define FolderItem_get_Size(This, pul) (This)->lpVtbl->get_Size(This, pul)
#define FolderItem_get_Type(This, pbs) (This)->lpVtbl->get_Type(This, pbs)
#define FolderItem_Verbs(This, ppfic) (This)->lpVtbl->Verbs(This, ppfic)
#define FolderItem_InvokeVerb(This, vVerb) (This)->lpVtbl->InvokeVerb(This, vVerb)

declare function FolderItem_get_Application_Proxy(byval This as FolderItem ptr, byval ppid as IDispatch ptr ptr) as HRESULT
declare sub FolderItem_get_Application_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function FolderItem_get_Parent_Proxy(byval This as FolderItem ptr, byval ppid as IDispatch ptr ptr) as HRESULT
declare sub FolderItem_get_Parent_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function FolderItem_get_Name_Proxy(byval This as FolderItem ptr, byval pbs as BSTR ptr) as HRESULT
declare sub FolderItem_get_Name_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function FolderItem_put_Name_Proxy(byval This as FolderItem ptr, byval bs as BSTR) as HRESULT
declare sub FolderItem_put_Name_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function FolderItem_get_Path_Proxy(byval This as FolderItem ptr, byval pbs as BSTR ptr) as HRESULT
declare sub FolderItem_get_Path_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function FolderItem_get_GetLink_Proxy(byval This as FolderItem ptr, byval ppid as IDispatch ptr ptr) as HRESULT
declare sub FolderItem_get_GetLink_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function FolderItem_get_GetFolder_Proxy(byval This as FolderItem ptr, byval ppid as IDispatch ptr ptr) as HRESULT
declare sub FolderItem_get_GetFolder_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function FolderItem_get_IsLink_Proxy(byval This as FolderItem ptr, byval pb as VARIANT_BOOL ptr) as HRESULT
declare sub FolderItem_get_IsLink_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function FolderItem_get_IsFolder_Proxy(byval This as FolderItem ptr, byval pb as VARIANT_BOOL ptr) as HRESULT
declare sub FolderItem_get_IsFolder_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function FolderItem_get_IsFileSystem_Proxy(byval This as FolderItem ptr, byval pb as VARIANT_BOOL ptr) as HRESULT
declare sub FolderItem_get_IsFileSystem_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function FolderItem_get_IsBrowsable_Proxy(byval This as FolderItem ptr, byval pb as VARIANT_BOOL ptr) as HRESULT
declare sub FolderItem_get_IsBrowsable_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function FolderItem_get_ModifyDate_Proxy(byval This as FolderItem ptr, byval pdt as DATE_ ptr) as HRESULT
declare sub FolderItem_get_ModifyDate_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function FolderItem_put_ModifyDate_Proxy(byval This as FolderItem ptr, byval dt as DATE_) as HRESULT
declare sub FolderItem_put_ModifyDate_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function FolderItem_get_Size_Proxy(byval This as FolderItem ptr, byval pul as LONG ptr) as HRESULT
declare sub FolderItem_get_Size_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function FolderItem_get_Type_Proxy(byval This as FolderItem ptr, byval pbs as BSTR ptr) as HRESULT
declare sub FolderItem_get_Type_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function FolderItem_Verbs_Proxy(byval This as FolderItem ptr, byval ppfic as FolderItemVerbs ptr ptr) as HRESULT
declare sub FolderItem_Verbs_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function FolderItem_InvokeVerb_Proxy(byval This as FolderItem ptr, byval vVerb as VARIANT) as HRESULT
declare sub FolderItem_InvokeVerb_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __FolderItem2_INTERFACE_DEFINED__
extern IID_FolderItem2 as const GUID
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

#define FolderItem2_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define FolderItem2_AddRef(This) (This)->lpVtbl->AddRef(This)
#define FolderItem2_Release(This) (This)->lpVtbl->Release(This)
#define FolderItem2_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define FolderItem2_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define FolderItem2_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define FolderItem2_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define FolderItem2_get_Application(This, ppid) (This)->lpVtbl->get_Application(This, ppid)
#define FolderItem2_get_Parent(This, ppid) (This)->lpVtbl->get_Parent(This, ppid)
#define FolderItem2_get_Name(This, pbs) (This)->lpVtbl->get_Name(This, pbs)
#define FolderItem2_put_Name(This, bs) (This)->lpVtbl->put_Name(This, bs)
#define FolderItem2_get_Path(This, pbs) (This)->lpVtbl->get_Path(This, pbs)
#define FolderItem2_get_GetLink(This, ppid) (This)->lpVtbl->get_GetLink(This, ppid)
#define FolderItem2_get_GetFolder(This, ppid) (This)->lpVtbl->get_GetFolder(This, ppid)
#define FolderItem2_get_IsLink(This, pb) (This)->lpVtbl->get_IsLink(This, pb)
#define FolderItem2_get_IsFolder(This, pb) (This)->lpVtbl->get_IsFolder(This, pb)
#define FolderItem2_get_IsFileSystem(This, pb) (This)->lpVtbl->get_IsFileSystem(This, pb)
#define FolderItem2_get_IsBrowsable(This, pb) (This)->lpVtbl->get_IsBrowsable(This, pb)
#define FolderItem2_get_ModifyDate(This, pdt) (This)->lpVtbl->get_ModifyDate(This, pdt)
#define FolderItem2_put_ModifyDate(This, dt) (This)->lpVtbl->put_ModifyDate(This, dt)
#define FolderItem2_get_Size(This, pul) (This)->lpVtbl->get_Size(This, pul)
#define FolderItem2_get_Type(This, pbs) (This)->lpVtbl->get_Type(This, pbs)
#define FolderItem2_Verbs(This, ppfic) (This)->lpVtbl->Verbs(This, ppfic)
#define FolderItem2_InvokeVerb(This, vVerb) (This)->lpVtbl->InvokeVerb(This, vVerb)
#define FolderItem2_InvokeVerbEx(This, vVerb, vArgs) (This)->lpVtbl->InvokeVerbEx(This, vVerb, vArgs)
#define FolderItem2_ExtendedProperty(This, bstrPropName, pvRet) (This)->lpVtbl->ExtendedProperty(This, bstrPropName, pvRet)

declare function FolderItem2_InvokeVerbEx_Proxy(byval This as FolderItem2 ptr, byval vVerb as VARIANT, byval vArgs as VARIANT) as HRESULT
declare sub FolderItem2_InvokeVerbEx_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function FolderItem2_ExtendedProperty_Proxy(byval This as FolderItem2 ptr, byval bstrPropName as BSTR, byval pvRet as VARIANT ptr) as HRESULT
declare sub FolderItem2_ExtendedProperty_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
extern CLSID_ShellFolderItem as const GUID
#define __FolderItems_INTERFACE_DEFINED__
extern IID_FolderItems as const GUID

type FolderItemsVtbl
	QueryInterface as function(byval This as FolderItems ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as FolderItems ptr) as ULONG
	Release as function(byval This as FolderItems ptr) as ULONG
	GetTypeInfoCount as function(byval This as FolderItems ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as FolderItems ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as FolderItems ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as FolderItems ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	get_Count as function(byval This as FolderItems ptr, byval plCount as LONG ptr) as HRESULT
	get_Application as function(byval This as FolderItems ptr, byval ppid as IDispatch ptr ptr) as HRESULT
	get_Parent as function(byval This as FolderItems ptr, byval ppid as IDispatch ptr ptr) as HRESULT
	Item as function(byval This as FolderItems ptr, byval index as VARIANT, byval ppid as FolderItem ptr ptr) as HRESULT
	_NewEnum as function(byval This as FolderItems ptr, byval ppunk as IUnknown ptr ptr) as HRESULT
end type

type FolderItems_
	lpVtbl as FolderItemsVtbl ptr
end type

#define FolderItems_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define FolderItems_AddRef(This) (This)->lpVtbl->AddRef(This)
#define FolderItems_Release(This) (This)->lpVtbl->Release(This)
#define FolderItems_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define FolderItems_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define FolderItems_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define FolderItems_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define FolderItems_get_Count(This, plCount) (This)->lpVtbl->get_Count(This, plCount)
#define FolderItems_get_Application(This, ppid) (This)->lpVtbl->get_Application(This, ppid)
#define FolderItems_get_Parent(This, ppid) (This)->lpVtbl->get_Parent(This, ppid)
#define FolderItems_Item(This, index, ppid) (This)->lpVtbl->Item(This, index, ppid)
#define FolderItems__NewEnum(This, ppunk) (This)->lpVtbl->_NewEnum(This, ppunk)

declare function FolderItems_get_Count_Proxy(byval This as FolderItems ptr, byval plCount as LONG ptr) as HRESULT
declare sub FolderItems_get_Count_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function FolderItems_get_Application_Proxy(byval This as FolderItems ptr, byval ppid as IDispatch ptr ptr) as HRESULT
declare sub FolderItems_get_Application_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function FolderItems_get_Parent_Proxy(byval This as FolderItems ptr, byval ppid as IDispatch ptr ptr) as HRESULT
declare sub FolderItems_get_Parent_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function FolderItems_Item_Proxy(byval This as FolderItems ptr, byval index as VARIANT, byval ppid as FolderItem ptr ptr) as HRESULT
declare sub FolderItems_Item_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function FolderItems__NewEnum_Proxy(byval This as FolderItems ptr, byval ppunk as IUnknown ptr ptr) as HRESULT
declare sub FolderItems__NewEnum_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __FolderItems2_INTERFACE_DEFINED__
extern IID_FolderItems2 as const GUID
type FolderItems2 as FolderItems2_

type FolderItems2Vtbl
	QueryInterface as function(byval This as FolderItems2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as FolderItems2 ptr) as ULONG
	Release as function(byval This as FolderItems2 ptr) as ULONG
	GetTypeInfoCount as function(byval This as FolderItems2 ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as FolderItems2 ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as FolderItems2 ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as FolderItems2 ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	get_Count as function(byval This as FolderItems2 ptr, byval plCount as LONG ptr) as HRESULT
	get_Application as function(byval This as FolderItems2 ptr, byval ppid as IDispatch ptr ptr) as HRESULT
	get_Parent as function(byval This as FolderItems2 ptr, byval ppid as IDispatch ptr ptr) as HRESULT
	Item as function(byval This as FolderItems2 ptr, byval index as VARIANT, byval ppid as FolderItem ptr ptr) as HRESULT
	_NewEnum as function(byval This as FolderItems2 ptr, byval ppunk as IUnknown ptr ptr) as HRESULT
	InvokeVerbEx as function(byval This as FolderItems2 ptr, byval vVerb as VARIANT, byval vArgs as VARIANT) as HRESULT
end type

type FolderItems2_
	lpVtbl as FolderItems2Vtbl ptr
end type

#define FolderItems2_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define FolderItems2_AddRef(This) (This)->lpVtbl->AddRef(This)
#define FolderItems2_Release(This) (This)->lpVtbl->Release(This)
#define FolderItems2_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define FolderItems2_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define FolderItems2_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define FolderItems2_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define FolderItems2_get_Count(This, plCount) (This)->lpVtbl->get_Count(This, plCount)
#define FolderItems2_get_Application(This, ppid) (This)->lpVtbl->get_Application(This, ppid)
#define FolderItems2_get_Parent(This, ppid) (This)->lpVtbl->get_Parent(This, ppid)
#define FolderItems2_Item(This, index, ppid) (This)->lpVtbl->Item(This, index, ppid)
#define FolderItems2__NewEnum(This, ppunk) (This)->lpVtbl->_NewEnum(This, ppunk)
#define FolderItems2_InvokeVerbEx(This, vVerb, vArgs) (This)->lpVtbl->InvokeVerbEx(This, vVerb, vArgs)
declare function FolderItems2_InvokeVerbEx_Proxy(byval This as FolderItems2 ptr, byval vVerb as VARIANT, byval vArgs as VARIANT) as HRESULT
declare sub FolderItems2_InvokeVerbEx_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __FolderItems3_INTERFACE_DEFINED__
extern IID_FolderItems3 as const GUID
type FolderItems3 as FolderItems3_

type FolderItems3Vtbl
	QueryInterface as function(byval This as FolderItems3 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as FolderItems3 ptr) as ULONG
	Release as function(byval This as FolderItems3 ptr) as ULONG
	GetTypeInfoCount as function(byval This as FolderItems3 ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as FolderItems3 ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as FolderItems3 ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as FolderItems3 ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	get_Count as function(byval This as FolderItems3 ptr, byval plCount as LONG ptr) as HRESULT
	get_Application as function(byval This as FolderItems3 ptr, byval ppid as IDispatch ptr ptr) as HRESULT
	get_Parent as function(byval This as FolderItems3 ptr, byval ppid as IDispatch ptr ptr) as HRESULT
	Item as function(byval This as FolderItems3 ptr, byval index as VARIANT, byval ppid as FolderItem ptr ptr) as HRESULT
	_NewEnum as function(byval This as FolderItems3 ptr, byval ppunk as IUnknown ptr ptr) as HRESULT
	InvokeVerbEx as function(byval This as FolderItems3 ptr, byval vVerb as VARIANT, byval vArgs as VARIANT) as HRESULT
	Filter as function(byval This as FolderItems3 ptr, byval grfFlags as LONG, byval bstrFileSpec as BSTR) as HRESULT
	get_Verbs as function(byval This as FolderItems3 ptr, byval ppfic as FolderItemVerbs ptr ptr) as HRESULT
end type

type FolderItems3_
	lpVtbl as FolderItems3Vtbl ptr
end type

#define FolderItems3_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define FolderItems3_AddRef(This) (This)->lpVtbl->AddRef(This)
#define FolderItems3_Release(This) (This)->lpVtbl->Release(This)
#define FolderItems3_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define FolderItems3_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define FolderItems3_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define FolderItems3_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define FolderItems3_get_Count(This, plCount) (This)->lpVtbl->get_Count(This, plCount)
#define FolderItems3_get_Application(This, ppid) (This)->lpVtbl->get_Application(This, ppid)
#define FolderItems3_get_Parent(This, ppid) (This)->lpVtbl->get_Parent(This, ppid)
#define FolderItems3_Item(This, index, ppid) (This)->lpVtbl->Item(This, index, ppid)
#define FolderItems3__NewEnum(This, ppunk) (This)->lpVtbl->_NewEnum(This, ppunk)
#define FolderItems3_InvokeVerbEx(This, vVerb, vArgs) (This)->lpVtbl->InvokeVerbEx(This, vVerb, vArgs)
#define FolderItems3_Filter(This, grfFlags, bstrFileSpec) (This)->lpVtbl->Filter(This, grfFlags, bstrFileSpec)
#define FolderItems3_get_Verbs(This, ppfic) (This)->lpVtbl->get_Verbs(This, ppfic)

declare function FolderItems3_Filter_Proxy(byval This as FolderItems3 ptr, byval grfFlags as LONG, byval bstrFileSpec as BSTR) as HRESULT
declare sub FolderItems3_Filter_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function FolderItems3_get_Verbs_Proxy(byval This as FolderItems3 ptr, byval ppfic as FolderItemVerbs ptr ptr) as HRESULT
declare sub FolderItems3_get_Verbs_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __FolderItemVerb_INTERFACE_DEFINED__
extern IID_FolderItemVerb as const GUID
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

#define FolderItemVerb_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define FolderItemVerb_AddRef(This) (This)->lpVtbl->AddRef(This)
#define FolderItemVerb_Release(This) (This)->lpVtbl->Release(This)
#define FolderItemVerb_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define FolderItemVerb_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define FolderItemVerb_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define FolderItemVerb_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define FolderItemVerb_get_Application(This, ppid) (This)->lpVtbl->get_Application(This, ppid)
#define FolderItemVerb_get_Parent(This, ppid) (This)->lpVtbl->get_Parent(This, ppid)
#define FolderItemVerb_get_Name(This, pbs) (This)->lpVtbl->get_Name(This, pbs)
#define FolderItemVerb_DoIt(This) (This)->lpVtbl->DoIt(This)

declare function FolderItemVerb_get_Application_Proxy(byval This as FolderItemVerb ptr, byval ppid as IDispatch ptr ptr) as HRESULT
declare sub FolderItemVerb_get_Application_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function FolderItemVerb_get_Parent_Proxy(byval This as FolderItemVerb ptr, byval ppid as IDispatch ptr ptr) as HRESULT
declare sub FolderItemVerb_get_Parent_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function FolderItemVerb_get_Name_Proxy(byval This as FolderItemVerb ptr, byval pbs as BSTR ptr) as HRESULT
declare sub FolderItemVerb_get_Name_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function FolderItemVerb_DoIt_Proxy(byval This as FolderItemVerb ptr) as HRESULT
declare sub FolderItemVerb_DoIt_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __FolderItemVerbs_INTERFACE_DEFINED__
extern IID_FolderItemVerbs as const GUID

type FolderItemVerbsVtbl
	QueryInterface as function(byval This as FolderItemVerbs ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as FolderItemVerbs ptr) as ULONG
	Release as function(byval This as FolderItemVerbs ptr) as ULONG
	GetTypeInfoCount as function(byval This as FolderItemVerbs ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as FolderItemVerbs ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as FolderItemVerbs ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as FolderItemVerbs ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	get_Count as function(byval This as FolderItemVerbs ptr, byval plCount as LONG ptr) as HRESULT
	get_Application as function(byval This as FolderItemVerbs ptr, byval ppid as IDispatch ptr ptr) as HRESULT
	get_Parent as function(byval This as FolderItemVerbs ptr, byval ppid as IDispatch ptr ptr) as HRESULT
	Item as function(byval This as FolderItemVerbs ptr, byval index as VARIANT, byval ppid as FolderItemVerb ptr ptr) as HRESULT
	_NewEnum as function(byval This as FolderItemVerbs ptr, byval ppunk as IUnknown ptr ptr) as HRESULT
end type

type FolderItemVerbs_
	lpVtbl as FolderItemVerbsVtbl ptr
end type

#define FolderItemVerbs_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define FolderItemVerbs_AddRef(This) (This)->lpVtbl->AddRef(This)
#define FolderItemVerbs_Release(This) (This)->lpVtbl->Release(This)
#define FolderItemVerbs_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define FolderItemVerbs_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define FolderItemVerbs_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define FolderItemVerbs_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define FolderItemVerbs_get_Count(This, plCount) (This)->lpVtbl->get_Count(This, plCount)
#define FolderItemVerbs_get_Application(This, ppid) (This)->lpVtbl->get_Application(This, ppid)
#define FolderItemVerbs_get_Parent(This, ppid) (This)->lpVtbl->get_Parent(This, ppid)
#define FolderItemVerbs_Item(This, index, ppid) (This)->lpVtbl->Item(This, index, ppid)
#define FolderItemVerbs__NewEnum(This, ppunk) (This)->lpVtbl->_NewEnum(This, ppunk)

declare function FolderItemVerbs_get_Count_Proxy(byval This as FolderItemVerbs ptr, byval plCount as LONG ptr) as HRESULT
declare sub FolderItemVerbs_get_Count_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function FolderItemVerbs_get_Application_Proxy(byval This as FolderItemVerbs ptr, byval ppid as IDispatch ptr ptr) as HRESULT
declare sub FolderItemVerbs_get_Application_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function FolderItemVerbs_get_Parent_Proxy(byval This as FolderItemVerbs ptr, byval ppid as IDispatch ptr ptr) as HRESULT
declare sub FolderItemVerbs_get_Parent_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function FolderItemVerbs_Item_Proxy(byval This as FolderItemVerbs ptr, byval index as VARIANT, byval ppid as FolderItemVerb ptr ptr) as HRESULT
declare sub FolderItemVerbs_Item_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function FolderItemVerbs__NewEnum_Proxy(byval This as FolderItemVerbs ptr, byval ppunk as IUnknown ptr ptr) as HRESULT
declare sub FolderItemVerbs__NewEnum_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IShellLinkDual_INTERFACE_DEFINED__
extern IID_IShellLinkDual as const GUID
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

#define IShellLinkDual_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IShellLinkDual_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IShellLinkDual_Release(This) (This)->lpVtbl->Release(This)
#define IShellLinkDual_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define IShellLinkDual_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define IShellLinkDual_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define IShellLinkDual_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define IShellLinkDual_get_Path(This, pbs) (This)->lpVtbl->get_Path(This, pbs)
#define IShellLinkDual_put_Path(This, bs) (This)->lpVtbl->put_Path(This, bs)
#define IShellLinkDual_get_Description(This, pbs) (This)->lpVtbl->get_Description(This, pbs)
#define IShellLinkDual_put_Description(This, bs) (This)->lpVtbl->put_Description(This, bs)
#define IShellLinkDual_get_WorkingDirectory(This, pbs) (This)->lpVtbl->get_WorkingDirectory(This, pbs)
#define IShellLinkDual_put_WorkingDirectory(This, bs) (This)->lpVtbl->put_WorkingDirectory(This, bs)
#define IShellLinkDual_get_Arguments(This, pbs) (This)->lpVtbl->get_Arguments(This, pbs)
#define IShellLinkDual_put_Arguments(This, bs) (This)->lpVtbl->put_Arguments(This, bs)
#define IShellLinkDual_get_Hotkey(This, piHK) (This)->lpVtbl->get_Hotkey(This, piHK)
#define IShellLinkDual_put_Hotkey(This, iHK) (This)->lpVtbl->put_Hotkey(This, iHK)
#define IShellLinkDual_get_ShowCommand(This, piShowCommand) (This)->lpVtbl->get_ShowCommand(This, piShowCommand)
#define IShellLinkDual_put_ShowCommand(This, iShowCommand) (This)->lpVtbl->put_ShowCommand(This, iShowCommand)
#define IShellLinkDual_Resolve(This, fFlags) (This)->lpVtbl->Resolve(This, fFlags)
#define IShellLinkDual_GetIconLocation(This, pbs, piIcon) (This)->lpVtbl->GetIconLocation(This, pbs, piIcon)
#define IShellLinkDual_SetIconLocation(This, bs, iIcon) (This)->lpVtbl->SetIconLocation(This, bs, iIcon)
#define IShellLinkDual_Save(This, vWhere) (This)->lpVtbl->Save(This, vWhere)

declare function IShellLinkDual_get_Path_Proxy(byval This as IShellLinkDual ptr, byval pbs as BSTR ptr) as HRESULT
declare sub IShellLinkDual_get_Path_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLinkDual_put_Path_Proxy(byval This as IShellLinkDual ptr, byval bs as BSTR) as HRESULT
declare sub IShellLinkDual_put_Path_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLinkDual_get_Description_Proxy(byval This as IShellLinkDual ptr, byval pbs as BSTR ptr) as HRESULT
declare sub IShellLinkDual_get_Description_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLinkDual_put_Description_Proxy(byval This as IShellLinkDual ptr, byval bs as BSTR) as HRESULT
declare sub IShellLinkDual_put_Description_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLinkDual_get_WorkingDirectory_Proxy(byval This as IShellLinkDual ptr, byval pbs as BSTR ptr) as HRESULT
declare sub IShellLinkDual_get_WorkingDirectory_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLinkDual_put_WorkingDirectory_Proxy(byval This as IShellLinkDual ptr, byval bs as BSTR) as HRESULT
declare sub IShellLinkDual_put_WorkingDirectory_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLinkDual_get_Arguments_Proxy(byval This as IShellLinkDual ptr, byval pbs as BSTR ptr) as HRESULT
declare sub IShellLinkDual_get_Arguments_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLinkDual_put_Arguments_Proxy(byval This as IShellLinkDual ptr, byval bs as BSTR) as HRESULT
declare sub IShellLinkDual_put_Arguments_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLinkDual_get_Hotkey_Proxy(byval This as IShellLinkDual ptr, byval piHK as long ptr) as HRESULT
declare sub IShellLinkDual_get_Hotkey_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLinkDual_put_Hotkey_Proxy(byval This as IShellLinkDual ptr, byval iHK as long) as HRESULT
declare sub IShellLinkDual_put_Hotkey_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLinkDual_get_ShowCommand_Proxy(byval This as IShellLinkDual ptr, byval piShowCommand as long ptr) as HRESULT
declare sub IShellLinkDual_get_ShowCommand_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLinkDual_put_ShowCommand_Proxy(byval This as IShellLinkDual ptr, byval iShowCommand as long) as HRESULT
declare sub IShellLinkDual_put_ShowCommand_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLinkDual_Resolve_Proxy(byval This as IShellLinkDual ptr, byval fFlags as long) as HRESULT
declare sub IShellLinkDual_Resolve_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLinkDual_GetIconLocation_Proxy(byval This as IShellLinkDual ptr, byval pbs as BSTR ptr, byval piIcon as long ptr) as HRESULT
declare sub IShellLinkDual_GetIconLocation_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLinkDual_SetIconLocation_Proxy(byval This as IShellLinkDual ptr, byval bs as BSTR, byval iIcon as long) as HRESULT
declare sub IShellLinkDual_SetIconLocation_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellLinkDual_Save_Proxy(byval This as IShellLinkDual ptr, byval vWhere as VARIANT) as HRESULT
declare sub IShellLinkDual_Save_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IShellLinkDual2_INTERFACE_DEFINED__
extern IID_IShellLinkDual2 as const GUID
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

#define IShellLinkDual2_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IShellLinkDual2_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IShellLinkDual2_Release(This) (This)->lpVtbl->Release(This)
#define IShellLinkDual2_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define IShellLinkDual2_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define IShellLinkDual2_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define IShellLinkDual2_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define IShellLinkDual2_get_Path(This, pbs) (This)->lpVtbl->get_Path(This, pbs)
#define IShellLinkDual2_put_Path(This, bs) (This)->lpVtbl->put_Path(This, bs)
#define IShellLinkDual2_get_Description(This, pbs) (This)->lpVtbl->get_Description(This, pbs)
#define IShellLinkDual2_put_Description(This, bs) (This)->lpVtbl->put_Description(This, bs)
#define IShellLinkDual2_get_WorkingDirectory(This, pbs) (This)->lpVtbl->get_WorkingDirectory(This, pbs)
#define IShellLinkDual2_put_WorkingDirectory(This, bs) (This)->lpVtbl->put_WorkingDirectory(This, bs)
#define IShellLinkDual2_get_Arguments(This, pbs) (This)->lpVtbl->get_Arguments(This, pbs)
#define IShellLinkDual2_put_Arguments(This, bs) (This)->lpVtbl->put_Arguments(This, bs)
#define IShellLinkDual2_get_Hotkey(This, piHK) (This)->lpVtbl->get_Hotkey(This, piHK)
#define IShellLinkDual2_put_Hotkey(This, iHK) (This)->lpVtbl->put_Hotkey(This, iHK)
#define IShellLinkDual2_get_ShowCommand(This, piShowCommand) (This)->lpVtbl->get_ShowCommand(This, piShowCommand)
#define IShellLinkDual2_put_ShowCommand(This, iShowCommand) (This)->lpVtbl->put_ShowCommand(This, iShowCommand)
#define IShellLinkDual2_Resolve(This, fFlags) (This)->lpVtbl->Resolve(This, fFlags)
#define IShellLinkDual2_GetIconLocation(This, pbs, piIcon) (This)->lpVtbl->GetIconLocation(This, pbs, piIcon)
#define IShellLinkDual2_SetIconLocation(This, bs, iIcon) (This)->lpVtbl->SetIconLocation(This, bs, iIcon)
#define IShellLinkDual2_Save(This, vWhere) (This)->lpVtbl->Save(This, vWhere)
#define IShellLinkDual2_get_Target(This, ppfi) (This)->lpVtbl->get_Target(This, ppfi)
declare function IShellLinkDual2_get_Target_Proxy(byval This as IShellLinkDual2 ptr, byval ppfi as FolderItem ptr ptr) as HRESULT
declare sub IShellLinkDual2_get_Target_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
extern CLSID_ShellLinkObject as const GUID
#define __IShellFolderViewDual_INTERFACE_DEFINED__
extern IID_IShellFolderViewDual as const GUID
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
	get_ViewOptions as function(byval This as IShellFolderViewDual ptr, byval plViewOptions as LONG ptr) as HRESULT
end type

type IShellFolderViewDual_
	lpVtbl as IShellFolderViewDualVtbl ptr
end type

#define IShellFolderViewDual_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IShellFolderViewDual_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IShellFolderViewDual_Release(This) (This)->lpVtbl->Release(This)
#define IShellFolderViewDual_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define IShellFolderViewDual_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define IShellFolderViewDual_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define IShellFolderViewDual_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define IShellFolderViewDual_get_Application(This, ppid) (This)->lpVtbl->get_Application(This, ppid)
#define IShellFolderViewDual_get_Parent(This, ppid) (This)->lpVtbl->get_Parent(This, ppid)
#define IShellFolderViewDual_get_Folder(This, ppid) (This)->lpVtbl->get_Folder(This, ppid)
#define IShellFolderViewDual_SelectedItems(This, ppid) (This)->lpVtbl->SelectedItems(This, ppid)
#define IShellFolderViewDual_get_FocusedItem(This, ppid) (This)->lpVtbl->get_FocusedItem(This, ppid)
#define IShellFolderViewDual_SelectItem(This, pvfi, dwFlags) (This)->lpVtbl->SelectItem(This, pvfi, dwFlags)
#define IShellFolderViewDual_PopupItemMenu(This, pfi, vx, vy, pbs) (This)->lpVtbl->PopupItemMenu(This, pfi, vx, vy, pbs)
#define IShellFolderViewDual_get_Script(This, ppDisp) (This)->lpVtbl->get_Script(This, ppDisp)
#define IShellFolderViewDual_get_ViewOptions(This, plViewOptions) (This)->lpVtbl->get_ViewOptions(This, plViewOptions)

declare function IShellFolderViewDual_get_Application_Proxy(byval This as IShellFolderViewDual ptr, byval ppid as IDispatch ptr ptr) as HRESULT
declare sub IShellFolderViewDual_get_Application_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellFolderViewDual_get_Parent_Proxy(byval This as IShellFolderViewDual ptr, byval ppid as IDispatch ptr ptr) as HRESULT
declare sub IShellFolderViewDual_get_Parent_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellFolderViewDual_get_Folder_Proxy(byval This as IShellFolderViewDual ptr, byval ppid as Folder ptr ptr) as HRESULT
declare sub IShellFolderViewDual_get_Folder_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellFolderViewDual_SelectedItems_Proxy(byval This as IShellFolderViewDual ptr, byval ppid as FolderItems ptr ptr) as HRESULT
declare sub IShellFolderViewDual_SelectedItems_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellFolderViewDual_get_FocusedItem_Proxy(byval This as IShellFolderViewDual ptr, byval ppid as FolderItem ptr ptr) as HRESULT
declare sub IShellFolderViewDual_get_FocusedItem_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellFolderViewDual_SelectItem_Proxy(byval This as IShellFolderViewDual ptr, byval pvfi as VARIANT ptr, byval dwFlags as long) as HRESULT
declare sub IShellFolderViewDual_SelectItem_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellFolderViewDual_PopupItemMenu_Proxy(byval This as IShellFolderViewDual ptr, byval pfi as FolderItem ptr, byval vx as VARIANT, byval vy as VARIANT, byval pbs as BSTR ptr) as HRESULT
declare sub IShellFolderViewDual_PopupItemMenu_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellFolderViewDual_get_Script_Proxy(byval This as IShellFolderViewDual ptr, byval ppDisp as IDispatch ptr ptr) as HRESULT
declare sub IShellFolderViewDual_get_Script_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellFolderViewDual_get_ViewOptions_Proxy(byval This as IShellFolderViewDual ptr, byval plViewOptions as LONG ptr) as HRESULT
declare sub IShellFolderViewDual_get_ViewOptions_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IShellFolderViewDual2_INTERFACE_DEFINED__
extern IID_IShellFolderViewDual2 as const GUID
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
	get_ViewOptions as function(byval This as IShellFolderViewDual2 ptr, byval plViewOptions as LONG ptr) as HRESULT
	get_CurrentViewMode as function(byval This as IShellFolderViewDual2 ptr, byval pViewMode as UINT ptr) as HRESULT
	put_CurrentViewMode as function(byval This as IShellFolderViewDual2 ptr, byval ViewMode as UINT) as HRESULT
	SelectItemRelative as function(byval This as IShellFolderViewDual2 ptr, byval iRelative as long) as HRESULT
end type

type IShellFolderViewDual2_
	lpVtbl as IShellFolderViewDual2Vtbl ptr
end type

#define IShellFolderViewDual2_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IShellFolderViewDual2_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IShellFolderViewDual2_Release(This) (This)->lpVtbl->Release(This)
#define IShellFolderViewDual2_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define IShellFolderViewDual2_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define IShellFolderViewDual2_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define IShellFolderViewDual2_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define IShellFolderViewDual2_get_Application(This, ppid) (This)->lpVtbl->get_Application(This, ppid)
#define IShellFolderViewDual2_get_Parent(This, ppid) (This)->lpVtbl->get_Parent(This, ppid)
#define IShellFolderViewDual2_get_Folder(This, ppid) (This)->lpVtbl->get_Folder(This, ppid)
#define IShellFolderViewDual2_SelectedItems(This, ppid) (This)->lpVtbl->SelectedItems(This, ppid)
#define IShellFolderViewDual2_get_FocusedItem(This, ppid) (This)->lpVtbl->get_FocusedItem(This, ppid)
#define IShellFolderViewDual2_SelectItem(This, pvfi, dwFlags) (This)->lpVtbl->SelectItem(This, pvfi, dwFlags)
#define IShellFolderViewDual2_PopupItemMenu(This, pfi, vx, vy, pbs) (This)->lpVtbl->PopupItemMenu(This, pfi, vx, vy, pbs)
#define IShellFolderViewDual2_get_Script(This, ppDisp) (This)->lpVtbl->get_Script(This, ppDisp)
#define IShellFolderViewDual2_get_ViewOptions(This, plViewOptions) (This)->lpVtbl->get_ViewOptions(This, plViewOptions)
#define IShellFolderViewDual2_get_CurrentViewMode(This, pViewMode) (This)->lpVtbl->get_CurrentViewMode(This, pViewMode)
#define IShellFolderViewDual2_put_CurrentViewMode(This, ViewMode) (This)->lpVtbl->put_CurrentViewMode(This, ViewMode)
#define IShellFolderViewDual2_SelectItemRelative(This, iRelative) (This)->lpVtbl->SelectItemRelative(This, iRelative)

declare function IShellFolderViewDual2_get_CurrentViewMode_Proxy(byval This as IShellFolderViewDual2 ptr, byval pViewMode as UINT ptr) as HRESULT
declare sub IShellFolderViewDual2_get_CurrentViewMode_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellFolderViewDual2_put_CurrentViewMode_Proxy(byval This as IShellFolderViewDual2 ptr, byval ViewMode as UINT) as HRESULT
declare sub IShellFolderViewDual2_put_CurrentViewMode_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellFolderViewDual2_SelectItemRelative_Proxy(byval This as IShellFolderViewDual2 ptr, byval iRelative as long) as HRESULT
declare sub IShellFolderViewDual2_SelectItemRelative_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IShellFolderViewDual3_INTERFACE_DEFINED__
extern IID_IShellFolderViewDual3 as const GUID
type IShellFolderViewDual3 as IShellFolderViewDual3_

type IShellFolderViewDual3Vtbl
	QueryInterface as function(byval This as IShellFolderViewDual3 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IShellFolderViewDual3 ptr) as ULONG
	Release as function(byval This as IShellFolderViewDual3 ptr) as ULONG
	GetTypeInfoCount as function(byval This as IShellFolderViewDual3 ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IShellFolderViewDual3 ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IShellFolderViewDual3 ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IShellFolderViewDual3 ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	get_Application as function(byval This as IShellFolderViewDual3 ptr, byval ppid as IDispatch ptr ptr) as HRESULT
	get_Parent as function(byval This as IShellFolderViewDual3 ptr, byval ppid as IDispatch ptr ptr) as HRESULT
	get_Folder as function(byval This as IShellFolderViewDual3 ptr, byval ppid as Folder ptr ptr) as HRESULT
	SelectedItems as function(byval This as IShellFolderViewDual3 ptr, byval ppid as FolderItems ptr ptr) as HRESULT
	get_FocusedItem as function(byval This as IShellFolderViewDual3 ptr, byval ppid as FolderItem ptr ptr) as HRESULT
	SelectItem as function(byval This as IShellFolderViewDual3 ptr, byval pvfi as VARIANT ptr, byval dwFlags as long) as HRESULT
	PopupItemMenu as function(byval This as IShellFolderViewDual3 ptr, byval pfi as FolderItem ptr, byval vx as VARIANT, byval vy as VARIANT, byval pbs as BSTR ptr) as HRESULT
	get_Script as function(byval This as IShellFolderViewDual3 ptr, byval ppDisp as IDispatch ptr ptr) as HRESULT
	get_ViewOptions as function(byval This as IShellFolderViewDual3 ptr, byval plViewOptions as LONG ptr) as HRESULT
	get_CurrentViewMode as function(byval This as IShellFolderViewDual3 ptr, byval pViewMode as UINT ptr) as HRESULT
	put_CurrentViewMode as function(byval This as IShellFolderViewDual3 ptr, byval ViewMode as UINT) as HRESULT
	SelectItemRelative as function(byval This as IShellFolderViewDual3 ptr, byval iRelative as long) as HRESULT
	get_GroupBy as function(byval This as IShellFolderViewDual3 ptr, byval pbstrGroupBy as BSTR ptr) as HRESULT
	put_GroupBy as function(byval This as IShellFolderViewDual3 ptr, byval bstrGroupBy as BSTR) as HRESULT
	get_FolderFlags as function(byval This as IShellFolderViewDual3 ptr, byval pdwFlags as DWORD ptr) as HRESULT
	put_FolderFlags as function(byval This as IShellFolderViewDual3 ptr, byval dwFlags as DWORD) as HRESULT
	get_SortColumns as function(byval This as IShellFolderViewDual3 ptr, byval pbstrSortColumns as BSTR ptr) as HRESULT
	put_SortColumns as function(byval This as IShellFolderViewDual3 ptr, byval bstrSortColumns as BSTR) as HRESULT
	put_IconSize as function(byval This as IShellFolderViewDual3 ptr, byval iIconSize as long) as HRESULT
	get_IconSize as function(byval This as IShellFolderViewDual3 ptr, byval piIconSize as long ptr) as HRESULT
	FilterView as function(byval This as IShellFolderViewDual3 ptr, byval bstrFilterText as BSTR) as HRESULT
end type

type IShellFolderViewDual3_
	lpVtbl as IShellFolderViewDual3Vtbl ptr
end type

#define IShellFolderViewDual3_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IShellFolderViewDual3_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IShellFolderViewDual3_Release(This) (This)->lpVtbl->Release(This)
#define IShellFolderViewDual3_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define IShellFolderViewDual3_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define IShellFolderViewDual3_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define IShellFolderViewDual3_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define IShellFolderViewDual3_get_Application(This, ppid) (This)->lpVtbl->get_Application(This, ppid)
#define IShellFolderViewDual3_get_Parent(This, ppid) (This)->lpVtbl->get_Parent(This, ppid)
#define IShellFolderViewDual3_get_Folder(This, ppid) (This)->lpVtbl->get_Folder(This, ppid)
#define IShellFolderViewDual3_SelectedItems(This, ppid) (This)->lpVtbl->SelectedItems(This, ppid)
#define IShellFolderViewDual3_get_FocusedItem(This, ppid) (This)->lpVtbl->get_FocusedItem(This, ppid)
#define IShellFolderViewDual3_SelectItem(This, pvfi, dwFlags) (This)->lpVtbl->SelectItem(This, pvfi, dwFlags)
#define IShellFolderViewDual3_PopupItemMenu(This, pfi, vx, vy, pbs) (This)->lpVtbl->PopupItemMenu(This, pfi, vx, vy, pbs)
#define IShellFolderViewDual3_get_Script(This, ppDisp) (This)->lpVtbl->get_Script(This, ppDisp)
#define IShellFolderViewDual3_get_ViewOptions(This, plViewOptions) (This)->lpVtbl->get_ViewOptions(This, plViewOptions)
#define IShellFolderViewDual3_get_CurrentViewMode(This, pViewMode) (This)->lpVtbl->get_CurrentViewMode(This, pViewMode)
#define IShellFolderViewDual3_put_CurrentViewMode(This, ViewMode) (This)->lpVtbl->put_CurrentViewMode(This, ViewMode)
#define IShellFolderViewDual3_SelectItemRelative(This, iRelative) (This)->lpVtbl->SelectItemRelative(This, iRelative)
#define IShellFolderViewDual3_get_GroupBy(This, pbstrGroupBy) (This)->lpVtbl->get_GroupBy(This, pbstrGroupBy)
#define IShellFolderViewDual3_put_GroupBy(This, bstrGroupBy) (This)->lpVtbl->put_GroupBy(This, bstrGroupBy)
#define IShellFolderViewDual3_get_FolderFlags(This, pdwFlags) (This)->lpVtbl->get_FolderFlags(This, pdwFlags)
#define IShellFolderViewDual3_put_FolderFlags(This, dwFlags) (This)->lpVtbl->put_FolderFlags(This, dwFlags)
#define IShellFolderViewDual3_get_SortColumns(This, pbstrSortColumns) (This)->lpVtbl->get_SortColumns(This, pbstrSortColumns)
#define IShellFolderViewDual3_put_SortColumns(This, bstrSortColumns) (This)->lpVtbl->put_SortColumns(This, bstrSortColumns)
#define IShellFolderViewDual3_put_IconSize(This, iIconSize) (This)->lpVtbl->put_IconSize(This, iIconSize)
#define IShellFolderViewDual3_get_IconSize(This, piIconSize) (This)->lpVtbl->get_IconSize(This, piIconSize)
#define IShellFolderViewDual3_FilterView(This, bstrFilterText) (This)->lpVtbl->FilterView(This, bstrFilterText)

declare function IShellFolderViewDual3_get_GroupBy_Proxy(byval This as IShellFolderViewDual3 ptr, byval pbstrGroupBy as BSTR ptr) as HRESULT
declare sub IShellFolderViewDual3_get_GroupBy_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellFolderViewDual3_put_GroupBy_Proxy(byval This as IShellFolderViewDual3 ptr, byval bstrGroupBy as BSTR) as HRESULT
declare sub IShellFolderViewDual3_put_GroupBy_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellFolderViewDual3_get_FolderFlags_Proxy(byval This as IShellFolderViewDual3 ptr, byval pdwFlags as DWORD ptr) as HRESULT
declare sub IShellFolderViewDual3_get_FolderFlags_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellFolderViewDual3_put_FolderFlags_Proxy(byval This as IShellFolderViewDual3 ptr, byval dwFlags as DWORD) as HRESULT
declare sub IShellFolderViewDual3_put_FolderFlags_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellFolderViewDual3_get_SortColumns_Proxy(byval This as IShellFolderViewDual3 ptr, byval pbstrSortColumns as BSTR ptr) as HRESULT
declare sub IShellFolderViewDual3_get_SortColumns_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellFolderViewDual3_put_SortColumns_Proxy(byval This as IShellFolderViewDual3 ptr, byval bstrSortColumns as BSTR) as HRESULT
declare sub IShellFolderViewDual3_put_SortColumns_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellFolderViewDual3_put_IconSize_Proxy(byval This as IShellFolderViewDual3 ptr, byval iIconSize as long) as HRESULT
declare sub IShellFolderViewDual3_put_IconSize_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellFolderViewDual3_get_IconSize_Proxy(byval This as IShellFolderViewDual3 ptr, byval piIconSize as long ptr) as HRESULT
declare sub IShellFolderViewDual3_get_IconSize_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellFolderViewDual3_FilterView_Proxy(byval This as IShellFolderViewDual3 ptr, byval bstrFilterText as BSTR) as HRESULT
declare sub IShellFolderViewDual3_FilterView_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
extern CLSID_ShellFolderView as const GUID

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

#define __IShellDispatch_INTERFACE_DEFINED__
extern IID_IShellDispatch as const GUID
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
	BrowseForFolder as function(byval This as IShellDispatch ptr, byval Hwnd as LONG, byval Title as BSTR, byval Options as LONG, byval RootFolder as VARIANT, byval ppsdf as Folder ptr ptr) as HRESULT
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
	ControlPanelItem as function(byval This as IShellDispatch ptr, byval bstrDir as BSTR) as HRESULT
end type

type IShellDispatch_
	lpVtbl as IShellDispatchVtbl ptr
end type

#define IShellDispatch_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IShellDispatch_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IShellDispatch_Release(This) (This)->lpVtbl->Release(This)
#define IShellDispatch_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define IShellDispatch_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define IShellDispatch_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define IShellDispatch_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define IShellDispatch_get_Application(This, ppid) (This)->lpVtbl->get_Application(This, ppid)
#define IShellDispatch_get_Parent(This, ppid) (This)->lpVtbl->get_Parent(This, ppid)
#define IShellDispatch_NameSpace(This, vDir, ppsdf) (This)->lpVtbl->NameSpace(This, vDir, ppsdf)
#define IShellDispatch_BrowseForFolder(This, Hwnd, Title, Options, RootFolder, ppsdf) (This)->lpVtbl->BrowseForFolder(This, Hwnd, Title, Options, RootFolder, ppsdf)
#define IShellDispatch_Windows(This, ppid) (This)->lpVtbl->Windows(This, ppid)
#define IShellDispatch_Open(This, vDir) (This)->lpVtbl->Open(This, vDir)
#define IShellDispatch_Explore(This, vDir) (This)->lpVtbl->Explore(This, vDir)
#define IShellDispatch_MinimizeAll(This) (This)->lpVtbl->MinimizeAll(This)
#define IShellDispatch_UndoMinimizeALL(This) (This)->lpVtbl->UndoMinimizeALL(This)
#define IShellDispatch_FileRun(This) (This)->lpVtbl->FileRun(This)
#define IShellDispatch_CascadeWindows(This) (This)->lpVtbl->CascadeWindows(This)
#define IShellDispatch_TileVertically(This) (This)->lpVtbl->TileVertically(This)
#define IShellDispatch_TileHorizontally(This) (This)->lpVtbl->TileHorizontally(This)
#define IShellDispatch_ShutdownWindows(This) (This)->lpVtbl->ShutdownWindows(This)
#define IShellDispatch_Suspend(This) (This)->lpVtbl->Suspend(This)
#define IShellDispatch_EjectPC(This) (This)->lpVtbl->EjectPC(This)
#define IShellDispatch_SetTime(This) (This)->lpVtbl->SetTime(This)
#define IShellDispatch_TrayProperties(This) (This)->lpVtbl->TrayProperties(This)
#define IShellDispatch_Help(This) (This)->lpVtbl->Help(This)
#define IShellDispatch_FindFiles(This) (This)->lpVtbl->FindFiles(This)
#define IShellDispatch_FindComputer(This) (This)->lpVtbl->FindComputer(This)
#define IShellDispatch_RefreshMenu(This) (This)->lpVtbl->RefreshMenu(This)
#define IShellDispatch_ControlPanelItem(This, bstrDir) (This)->lpVtbl->ControlPanelItem(This, bstrDir)

declare function IShellDispatch_get_Application_Proxy(byval This as IShellDispatch ptr, byval ppid as IDispatch ptr ptr) as HRESULT
declare sub IShellDispatch_get_Application_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellDispatch_get_Parent_Proxy(byval This as IShellDispatch ptr, byval ppid as IDispatch ptr ptr) as HRESULT
declare sub IShellDispatch_get_Parent_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellDispatch_NameSpace_Proxy(byval This as IShellDispatch ptr, byval vDir as VARIANT, byval ppsdf as Folder ptr ptr) as HRESULT
declare sub IShellDispatch_NameSpace_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellDispatch_BrowseForFolder_Proxy(byval This as IShellDispatch ptr, byval Hwnd as LONG, byval Title as BSTR, byval Options as LONG, byval RootFolder as VARIANT, byval ppsdf as Folder ptr ptr) as HRESULT
declare sub IShellDispatch_BrowseForFolder_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellDispatch_Windows_Proxy(byval This as IShellDispatch ptr, byval ppid as IDispatch ptr ptr) as HRESULT
declare sub IShellDispatch_Windows_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellDispatch_Open_Proxy(byval This as IShellDispatch ptr, byval vDir as VARIANT) as HRESULT
declare sub IShellDispatch_Open_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellDispatch_Explore_Proxy(byval This as IShellDispatch ptr, byval vDir as VARIANT) as HRESULT
declare sub IShellDispatch_Explore_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellDispatch_MinimizeAll_Proxy(byval This as IShellDispatch ptr) as HRESULT
declare sub IShellDispatch_MinimizeAll_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellDispatch_UndoMinimizeALL_Proxy(byval This as IShellDispatch ptr) as HRESULT
declare sub IShellDispatch_UndoMinimizeALL_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellDispatch_FileRun_Proxy(byval This as IShellDispatch ptr) as HRESULT
declare sub IShellDispatch_FileRun_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellDispatch_CascadeWindows_Proxy(byval This as IShellDispatch ptr) as HRESULT
declare sub IShellDispatch_CascadeWindows_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellDispatch_TileVertically_Proxy(byval This as IShellDispatch ptr) as HRESULT
declare sub IShellDispatch_TileVertically_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellDispatch_TileHorizontally_Proxy(byval This as IShellDispatch ptr) as HRESULT
declare sub IShellDispatch_TileHorizontally_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellDispatch_ShutdownWindows_Proxy(byval This as IShellDispatch ptr) as HRESULT
declare sub IShellDispatch_ShutdownWindows_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellDispatch_Suspend_Proxy(byval This as IShellDispatch ptr) as HRESULT
declare sub IShellDispatch_Suspend_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellDispatch_EjectPC_Proxy(byval This as IShellDispatch ptr) as HRESULT
declare sub IShellDispatch_EjectPC_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellDispatch_SetTime_Proxy(byval This as IShellDispatch ptr) as HRESULT
declare sub IShellDispatch_SetTime_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellDispatch_TrayProperties_Proxy(byval This as IShellDispatch ptr) as HRESULT
declare sub IShellDispatch_TrayProperties_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellDispatch_Help_Proxy(byval This as IShellDispatch ptr) as HRESULT
declare sub IShellDispatch_Help_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellDispatch_FindFiles_Proxy(byval This as IShellDispatch ptr) as HRESULT
declare sub IShellDispatch_FindFiles_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellDispatch_FindComputer_Proxy(byval This as IShellDispatch ptr) as HRESULT
declare sub IShellDispatch_FindComputer_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellDispatch_RefreshMenu_Proxy(byval This as IShellDispatch ptr) as HRESULT
declare sub IShellDispatch_RefreshMenu_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellDispatch_ControlPanelItem_Proxy(byval This as IShellDispatch ptr, byval bstrDir as BSTR) as HRESULT
declare sub IShellDispatch_ControlPanelItem_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IShellDispatch2_INTERFACE_DEFINED__
extern IID_IShellDispatch2 as const GUID
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
	BrowseForFolder as function(byval This as IShellDispatch2 ptr, byval Hwnd as LONG, byval Title as BSTR, byval Options as LONG, byval RootFolder as VARIANT, byval ppsdf as Folder ptr ptr) as HRESULT
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
	ControlPanelItem as function(byval This as IShellDispatch2 ptr, byval bstrDir as BSTR) as HRESULT
	IsRestricted as function(byval This as IShellDispatch2 ptr, byval Group as BSTR, byval Restriction as BSTR, byval plRestrictValue as LONG ptr) as HRESULT

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

#define IShellDispatch2_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IShellDispatch2_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IShellDispatch2_Release(This) (This)->lpVtbl->Release(This)
#define IShellDispatch2_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define IShellDispatch2_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define IShellDispatch2_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define IShellDispatch2_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define IShellDispatch2_get_Application(This, ppid) (This)->lpVtbl->get_Application(This, ppid)
#define IShellDispatch2_get_Parent(This, ppid) (This)->lpVtbl->get_Parent(This, ppid)
#define IShellDispatch2_NameSpace(This, vDir, ppsdf) (This)->lpVtbl->NameSpace(This, vDir, ppsdf)
#define IShellDispatch2_BrowseForFolder(This, Hwnd, Title, Options, RootFolder, ppsdf) (This)->lpVtbl->BrowseForFolder(This, Hwnd, Title, Options, RootFolder, ppsdf)
#define IShellDispatch2_Windows(This, ppid) (This)->lpVtbl->Windows(This, ppid)
#define IShellDispatch2_Open(This, vDir) (This)->lpVtbl->Open(This, vDir)
#define IShellDispatch2_Explore(This, vDir) (This)->lpVtbl->Explore(This, vDir)
#define IShellDispatch2_MinimizeAll(This) (This)->lpVtbl->MinimizeAll(This)
#define IShellDispatch2_UndoMinimizeALL(This) (This)->lpVtbl->UndoMinimizeALL(This)
#define IShellDispatch2_FileRun(This) (This)->lpVtbl->FileRun(This)
#define IShellDispatch2_CascadeWindows(This) (This)->lpVtbl->CascadeWindows(This)
#define IShellDispatch2_TileVertically(This) (This)->lpVtbl->TileVertically(This)
#define IShellDispatch2_TileHorizontally(This) (This)->lpVtbl->TileHorizontally(This)
#define IShellDispatch2_ShutdownWindows(This) (This)->lpVtbl->ShutdownWindows(This)
#define IShellDispatch2_Suspend(This) (This)->lpVtbl->Suspend(This)
#define IShellDispatch2_EjectPC(This) (This)->lpVtbl->EjectPC(This)
#define IShellDispatch2_SetTime(This) (This)->lpVtbl->SetTime(This)
#define IShellDispatch2_TrayProperties(This) (This)->lpVtbl->TrayProperties(This)
#define IShellDispatch2_Help(This) (This)->lpVtbl->Help(This)
#define IShellDispatch2_FindFiles(This) (This)->lpVtbl->FindFiles(This)
#define IShellDispatch2_FindComputer(This) (This)->lpVtbl->FindComputer(This)
#define IShellDispatch2_RefreshMenu(This) (This)->lpVtbl->RefreshMenu(This)
#define IShellDispatch2_ControlPanelItem(This, bstrDir) (This)->lpVtbl->ControlPanelItem(This, bstrDir)
#define IShellDispatch2_IsRestricted(This, Group, Restriction, plRestrictValue) (This)->lpVtbl->IsRestricted(This, Group, Restriction, plRestrictValue)
#define IShellDispatch2_ShellExecute(This, File, vArgs, vDir, vOperation, vShow) (This)->lpVtbl->ShellExecute(This, File, vArgs, vDir, vOperation, vShow)
#define IShellDispatch2_FindPrinter(This, name, location, model) (This)->lpVtbl->FindPrinter(This, name, location, model)
#define IShellDispatch2_GetSystemInformation(This, name, pv) (This)->lpVtbl->GetSystemInformation(This, name, pv)
#define IShellDispatch2_ServiceStart(This, ServiceName, Persistent, pSuccess) (This)->lpVtbl->ServiceStart(This, ServiceName, Persistent, pSuccess)
#define IShellDispatch2_ServiceStop(This, ServiceName, Persistent, pSuccess) (This)->lpVtbl->ServiceStop(This, ServiceName, Persistent, pSuccess)
#define IShellDispatch2_IsServiceRunning(This, ServiceName, pRunning) (This)->lpVtbl->IsServiceRunning(This, ServiceName, pRunning)
#define IShellDispatch2_CanStartStopService(This, ServiceName, pCanStartStop) (This)->lpVtbl->CanStartStopService(This, ServiceName, pCanStartStop)
#define IShellDispatch2_ShowBrowserBar(This, bstrClsid, bShow, pSuccess) (This)->lpVtbl->ShowBrowserBar(This, bstrClsid, bShow, pSuccess)

declare function IShellDispatch2_IsRestricted_Proxy(byval This as IShellDispatch2 ptr, byval Group as BSTR, byval Restriction as BSTR, byval plRestrictValue as LONG ptr) as HRESULT
declare sub IShellDispatch2_IsRestricted_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellDispatch2_ShellExecute_Proxy(byval This as IShellDispatch2 ptr, byval File as BSTR, byval vArgs as VARIANT, byval vDir as VARIANT, byval vOperation as VARIANT, byval vShow as VARIANT) as HRESULT
declare sub IShellDispatch2_ShellExecute_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellDispatch2_FindPrinter_Proxy(byval This as IShellDispatch2 ptr, byval name as BSTR, byval location as BSTR, byval model as BSTR) as HRESULT
declare sub IShellDispatch2_FindPrinter_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellDispatch2_GetSystemInformation_Proxy(byval This as IShellDispatch2 ptr, byval name as BSTR, byval pv as VARIANT ptr) as HRESULT
declare sub IShellDispatch2_GetSystemInformation_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellDispatch2_ServiceStart_Proxy(byval This as IShellDispatch2 ptr, byval ServiceName as BSTR, byval Persistent as VARIANT, byval pSuccess as VARIANT ptr) as HRESULT
declare sub IShellDispatch2_ServiceStart_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellDispatch2_ServiceStop_Proxy(byval This as IShellDispatch2 ptr, byval ServiceName as BSTR, byval Persistent as VARIANT, byval pSuccess as VARIANT ptr) as HRESULT
declare sub IShellDispatch2_ServiceStop_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellDispatch2_IsServiceRunning_Proxy(byval This as IShellDispatch2 ptr, byval ServiceName as BSTR, byval pRunning as VARIANT ptr) as HRESULT
declare sub IShellDispatch2_IsServiceRunning_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellDispatch2_CanStartStopService_Proxy(byval This as IShellDispatch2 ptr, byval ServiceName as BSTR, byval pCanStartStop as VARIANT ptr) as HRESULT
declare sub IShellDispatch2_CanStartStopService_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellDispatch2_ShowBrowserBar_Proxy(byval This as IShellDispatch2 ptr, byval bstrClsid as BSTR, byval bShow as VARIANT, byval pSuccess as VARIANT ptr) as HRESULT
declare sub IShellDispatch2_ShowBrowserBar_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IShellDispatch3_INTERFACE_DEFINED__
extern IID_IShellDispatch3 as const GUID
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
	BrowseForFolder as function(byval This as IShellDispatch3 ptr, byval Hwnd as LONG, byval Title as BSTR, byval Options as LONG, byval RootFolder as VARIANT, byval ppsdf as Folder ptr ptr) as HRESULT
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
	ControlPanelItem as function(byval This as IShellDispatch3 ptr, byval bstrDir as BSTR) as HRESULT
	IsRestricted as function(byval This as IShellDispatch3 ptr, byval Group as BSTR, byval Restriction as BSTR, byval plRestrictValue as LONG ptr) as HRESULT

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

#define IShellDispatch3_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IShellDispatch3_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IShellDispatch3_Release(This) (This)->lpVtbl->Release(This)
#define IShellDispatch3_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define IShellDispatch3_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define IShellDispatch3_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define IShellDispatch3_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define IShellDispatch3_get_Application(This, ppid) (This)->lpVtbl->get_Application(This, ppid)
#define IShellDispatch3_get_Parent(This, ppid) (This)->lpVtbl->get_Parent(This, ppid)
#define IShellDispatch3_NameSpace(This, vDir, ppsdf) (This)->lpVtbl->NameSpace(This, vDir, ppsdf)
#define IShellDispatch3_BrowseForFolder(This, Hwnd, Title, Options, RootFolder, ppsdf) (This)->lpVtbl->BrowseForFolder(This, Hwnd, Title, Options, RootFolder, ppsdf)
#define IShellDispatch3_Windows(This, ppid) (This)->lpVtbl->Windows(This, ppid)
#define IShellDispatch3_Open(This, vDir) (This)->lpVtbl->Open(This, vDir)
#define IShellDispatch3_Explore(This, vDir) (This)->lpVtbl->Explore(This, vDir)
#define IShellDispatch3_MinimizeAll(This) (This)->lpVtbl->MinimizeAll(This)
#define IShellDispatch3_UndoMinimizeALL(This) (This)->lpVtbl->UndoMinimizeALL(This)
#define IShellDispatch3_FileRun(This) (This)->lpVtbl->FileRun(This)
#define IShellDispatch3_CascadeWindows(This) (This)->lpVtbl->CascadeWindows(This)
#define IShellDispatch3_TileVertically(This) (This)->lpVtbl->TileVertically(This)
#define IShellDispatch3_TileHorizontally(This) (This)->lpVtbl->TileHorizontally(This)
#define IShellDispatch3_ShutdownWindows(This) (This)->lpVtbl->ShutdownWindows(This)
#define IShellDispatch3_Suspend(This) (This)->lpVtbl->Suspend(This)
#define IShellDispatch3_EjectPC(This) (This)->lpVtbl->EjectPC(This)
#define IShellDispatch3_SetTime(This) (This)->lpVtbl->SetTime(This)
#define IShellDispatch3_TrayProperties(This) (This)->lpVtbl->TrayProperties(This)
#define IShellDispatch3_Help(This) (This)->lpVtbl->Help(This)
#define IShellDispatch3_FindFiles(This) (This)->lpVtbl->FindFiles(This)
#define IShellDispatch3_FindComputer(This) (This)->lpVtbl->FindComputer(This)
#define IShellDispatch3_RefreshMenu(This) (This)->lpVtbl->RefreshMenu(This)
#define IShellDispatch3_ControlPanelItem(This, bstrDir) (This)->lpVtbl->ControlPanelItem(This, bstrDir)
#define IShellDispatch3_IsRestricted(This, Group, Restriction, plRestrictValue) (This)->lpVtbl->IsRestricted(This, Group, Restriction, plRestrictValue)
#define IShellDispatch3_ShellExecute(This, File, vArgs, vDir, vOperation, vShow) (This)->lpVtbl->ShellExecute(This, File, vArgs, vDir, vOperation, vShow)
#define IShellDispatch3_FindPrinter(This, name, location, model) (This)->lpVtbl->FindPrinter(This, name, location, model)
#define IShellDispatch3_GetSystemInformation(This, name, pv) (This)->lpVtbl->GetSystemInformation(This, name, pv)
#define IShellDispatch3_ServiceStart(This, ServiceName, Persistent, pSuccess) (This)->lpVtbl->ServiceStart(This, ServiceName, Persistent, pSuccess)
#define IShellDispatch3_ServiceStop(This, ServiceName, Persistent, pSuccess) (This)->lpVtbl->ServiceStop(This, ServiceName, Persistent, pSuccess)
#define IShellDispatch3_IsServiceRunning(This, ServiceName, pRunning) (This)->lpVtbl->IsServiceRunning(This, ServiceName, pRunning)
#define IShellDispatch3_CanStartStopService(This, ServiceName, pCanStartStop) (This)->lpVtbl->CanStartStopService(This, ServiceName, pCanStartStop)
#define IShellDispatch3_ShowBrowserBar(This, bstrClsid, bShow, pSuccess) (This)->lpVtbl->ShowBrowserBar(This, bstrClsid, bShow, pSuccess)
#define IShellDispatch3_AddToRecent(This, varFile, bstrCategory) (This)->lpVtbl->AddToRecent(This, varFile, bstrCategory)
declare function IShellDispatch3_AddToRecent_Proxy(byval This as IShellDispatch3 ptr, byval varFile as VARIANT, byval bstrCategory as BSTR) as HRESULT
declare sub IShellDispatch3_AddToRecent_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IShellDispatch4_INTERFACE_DEFINED__
extern IID_IShellDispatch4 as const GUID
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
	BrowseForFolder as function(byval This as IShellDispatch4 ptr, byval Hwnd as LONG, byval Title as BSTR, byval Options as LONG, byval RootFolder as VARIANT, byval ppsdf as Folder ptr ptr) as HRESULT
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
	ControlPanelItem as function(byval This as IShellDispatch4 ptr, byval bstrDir as BSTR) as HRESULT
	IsRestricted as function(byval This as IShellDispatch4 ptr, byval Group as BSTR, byval Restriction as BSTR, byval plRestrictValue as LONG ptr) as HRESULT

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
	GetSetting as function(byval This as IShellDispatch4 ptr, byval lSetting as LONG, byval pResult as VARIANT_BOOL ptr) as HRESULT
end type

type IShellDispatch4_
	lpVtbl as IShellDispatch4Vtbl ptr
end type

#define IShellDispatch4_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IShellDispatch4_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IShellDispatch4_Release(This) (This)->lpVtbl->Release(This)
#define IShellDispatch4_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define IShellDispatch4_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define IShellDispatch4_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define IShellDispatch4_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define IShellDispatch4_get_Application(This, ppid) (This)->lpVtbl->get_Application(This, ppid)
#define IShellDispatch4_get_Parent(This, ppid) (This)->lpVtbl->get_Parent(This, ppid)
#define IShellDispatch4_NameSpace(This, vDir, ppsdf) (This)->lpVtbl->NameSpace(This, vDir, ppsdf)
#define IShellDispatch4_BrowseForFolder(This, Hwnd, Title, Options, RootFolder, ppsdf) (This)->lpVtbl->BrowseForFolder(This, Hwnd, Title, Options, RootFolder, ppsdf)
#define IShellDispatch4_Windows(This, ppid) (This)->lpVtbl->Windows(This, ppid)
#define IShellDispatch4_Open(This, vDir) (This)->lpVtbl->Open(This, vDir)
#define IShellDispatch4_Explore(This, vDir) (This)->lpVtbl->Explore(This, vDir)
#define IShellDispatch4_MinimizeAll(This) (This)->lpVtbl->MinimizeAll(This)
#define IShellDispatch4_UndoMinimizeALL(This) (This)->lpVtbl->UndoMinimizeALL(This)
#define IShellDispatch4_FileRun(This) (This)->lpVtbl->FileRun(This)
#define IShellDispatch4_CascadeWindows(This) (This)->lpVtbl->CascadeWindows(This)
#define IShellDispatch4_TileVertically(This) (This)->lpVtbl->TileVertically(This)
#define IShellDispatch4_TileHorizontally(This) (This)->lpVtbl->TileHorizontally(This)
#define IShellDispatch4_ShutdownWindows(This) (This)->lpVtbl->ShutdownWindows(This)
#define IShellDispatch4_Suspend(This) (This)->lpVtbl->Suspend(This)
#define IShellDispatch4_EjectPC(This) (This)->lpVtbl->EjectPC(This)
#define IShellDispatch4_SetTime(This) (This)->lpVtbl->SetTime(This)
#define IShellDispatch4_TrayProperties(This) (This)->lpVtbl->TrayProperties(This)
#define IShellDispatch4_Help(This) (This)->lpVtbl->Help(This)
#define IShellDispatch4_FindFiles(This) (This)->lpVtbl->FindFiles(This)
#define IShellDispatch4_FindComputer(This) (This)->lpVtbl->FindComputer(This)
#define IShellDispatch4_RefreshMenu(This) (This)->lpVtbl->RefreshMenu(This)
#define IShellDispatch4_ControlPanelItem(This, bstrDir) (This)->lpVtbl->ControlPanelItem(This, bstrDir)
#define IShellDispatch4_IsRestricted(This, Group, Restriction, plRestrictValue) (This)->lpVtbl->IsRestricted(This, Group, Restriction, plRestrictValue)
#define IShellDispatch4_ShellExecute(This, File, vArgs, vDir, vOperation, vShow) (This)->lpVtbl->ShellExecute(This, File, vArgs, vDir, vOperation, vShow)
#define IShellDispatch4_FindPrinter(This, name, location, model) (This)->lpVtbl->FindPrinter(This, name, location, model)
#define IShellDispatch4_GetSystemInformation(This, name, pv) (This)->lpVtbl->GetSystemInformation(This, name, pv)
#define IShellDispatch4_ServiceStart(This, ServiceName, Persistent, pSuccess) (This)->lpVtbl->ServiceStart(This, ServiceName, Persistent, pSuccess)
#define IShellDispatch4_ServiceStop(This, ServiceName, Persistent, pSuccess) (This)->lpVtbl->ServiceStop(This, ServiceName, Persistent, pSuccess)
#define IShellDispatch4_IsServiceRunning(This, ServiceName, pRunning) (This)->lpVtbl->IsServiceRunning(This, ServiceName, pRunning)
#define IShellDispatch4_CanStartStopService(This, ServiceName, pCanStartStop) (This)->lpVtbl->CanStartStopService(This, ServiceName, pCanStartStop)
#define IShellDispatch4_ShowBrowserBar(This, bstrClsid, bShow, pSuccess) (This)->lpVtbl->ShowBrowserBar(This, bstrClsid, bShow, pSuccess)
#define IShellDispatch4_AddToRecent(This, varFile, bstrCategory) (This)->lpVtbl->AddToRecent(This, varFile, bstrCategory)
#define IShellDispatch4_WindowsSecurity(This) (This)->lpVtbl->WindowsSecurity(This)
#define IShellDispatch4_ToggleDesktop(This) (This)->lpVtbl->ToggleDesktop(This)
#define IShellDispatch4_ExplorerPolicy(This, bstrPolicyName, pValue) (This)->lpVtbl->ExplorerPolicy(This, bstrPolicyName, pValue)
#define IShellDispatch4_GetSetting(This, lSetting, pResult) (This)->lpVtbl->GetSetting(This, lSetting, pResult)

declare function IShellDispatch4_WindowsSecurity_Proxy(byval This as IShellDispatch4 ptr) as HRESULT
declare sub IShellDispatch4_WindowsSecurity_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellDispatch4_ToggleDesktop_Proxy(byval This as IShellDispatch4 ptr) as HRESULT
declare sub IShellDispatch4_ToggleDesktop_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellDispatch4_ExplorerPolicy_Proxy(byval This as IShellDispatch4 ptr, byval bstrPolicyName as BSTR, byval pValue as VARIANT ptr) as HRESULT
declare sub IShellDispatch4_ExplorerPolicy_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IShellDispatch4_GetSetting_Proxy(byval This as IShellDispatch4 ptr, byval lSetting as LONG, byval pResult as VARIANT_BOOL ptr) as HRESULT
declare sub IShellDispatch4_GetSetting_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IShellDispatch5_INTERFACE_DEFINED__
extern IID_IShellDispatch5 as const GUID
type IShellDispatch5 as IShellDispatch5_

type IShellDispatch5Vtbl
	QueryInterface as function(byval This as IShellDispatch5 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IShellDispatch5 ptr) as ULONG
	Release as function(byval This as IShellDispatch5 ptr) as ULONG
	GetTypeInfoCount as function(byval This as IShellDispatch5 ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IShellDispatch5 ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IShellDispatch5 ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IShellDispatch5 ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	get_Application as function(byval This as IShellDispatch5 ptr, byval ppid as IDispatch ptr ptr) as HRESULT
	get_Parent as function(byval This as IShellDispatch5 ptr, byval ppid as IDispatch ptr ptr) as HRESULT
	NameSpace as function(byval This as IShellDispatch5 ptr, byval vDir as VARIANT, byval ppsdf as Folder ptr ptr) as HRESULT
	BrowseForFolder as function(byval This as IShellDispatch5 ptr, byval Hwnd as LONG, byval Title as BSTR, byval Options as LONG, byval RootFolder as VARIANT, byval ppsdf as Folder ptr ptr) as HRESULT
	Windows as function(byval This as IShellDispatch5 ptr, byval ppid as IDispatch ptr ptr) as HRESULT
	Open as function(byval This as IShellDispatch5 ptr, byval vDir as VARIANT) as HRESULT
	Explore as function(byval This as IShellDispatch5 ptr, byval vDir as VARIANT) as HRESULT
	MinimizeAll as function(byval This as IShellDispatch5 ptr) as HRESULT
	UndoMinimizeALL as function(byval This as IShellDispatch5 ptr) as HRESULT
	FileRun as function(byval This as IShellDispatch5 ptr) as HRESULT
	CascadeWindows as function(byval This as IShellDispatch5 ptr) as HRESULT
	TileVertically as function(byval This as IShellDispatch5 ptr) as HRESULT
	TileHorizontally as function(byval This as IShellDispatch5 ptr) as HRESULT
	ShutdownWindows as function(byval This as IShellDispatch5 ptr) as HRESULT
	Suspend as function(byval This as IShellDispatch5 ptr) as HRESULT
	EjectPC as function(byval This as IShellDispatch5 ptr) as HRESULT
	SetTime as function(byval This as IShellDispatch5 ptr) as HRESULT
	TrayProperties as function(byval This as IShellDispatch5 ptr) as HRESULT
	Help as function(byval This as IShellDispatch5 ptr) as HRESULT
	FindFiles as function(byval This as IShellDispatch5 ptr) as HRESULT
	FindComputer as function(byval This as IShellDispatch5 ptr) as HRESULT
	RefreshMenu as function(byval This as IShellDispatch5 ptr) as HRESULT
	ControlPanelItem as function(byval This as IShellDispatch5 ptr, byval bstrDir as BSTR) as HRESULT
	IsRestricted as function(byval This as IShellDispatch5 ptr, byval Group as BSTR, byval Restriction as BSTR, byval plRestrictValue as LONG ptr) as HRESULT

	#ifdef UNICODE
		ShellExecuteW as function(byval This as IShellDispatch5 ptr, byval File as BSTR, byval vArgs as VARIANT, byval vDir as VARIANT, byval vOperation as VARIANT, byval vShow as VARIANT) as HRESULT
	#else
		ShellExecuteA as function(byval This as IShellDispatch5 ptr, byval File as BSTR, byval vArgs as VARIANT, byval vDir as VARIANT, byval vOperation as VARIANT, byval vShow as VARIANT) as HRESULT
	#endif

	FindPrinter as function(byval This as IShellDispatch5 ptr, byval name as BSTR, byval location as BSTR, byval model as BSTR) as HRESULT
	GetSystemInformation as function(byval This as IShellDispatch5 ptr, byval name as BSTR, byval pv as VARIANT ptr) as HRESULT
	ServiceStart as function(byval This as IShellDispatch5 ptr, byval ServiceName as BSTR, byval Persistent as VARIANT, byval pSuccess as VARIANT ptr) as HRESULT
	ServiceStop as function(byval This as IShellDispatch5 ptr, byval ServiceName as BSTR, byval Persistent as VARIANT, byval pSuccess as VARIANT ptr) as HRESULT
	IsServiceRunning as function(byval This as IShellDispatch5 ptr, byval ServiceName as BSTR, byval pRunning as VARIANT ptr) as HRESULT
	CanStartStopService as function(byval This as IShellDispatch5 ptr, byval ServiceName as BSTR, byval pCanStartStop as VARIANT ptr) as HRESULT
	ShowBrowserBar as function(byval This as IShellDispatch5 ptr, byval bstrClsid as BSTR, byval bShow as VARIANT, byval pSuccess as VARIANT ptr) as HRESULT
	AddToRecent as function(byval This as IShellDispatch5 ptr, byval varFile as VARIANT, byval bstrCategory as BSTR) as HRESULT
	WindowsSecurity as function(byval This as IShellDispatch5 ptr) as HRESULT
	ToggleDesktop as function(byval This as IShellDispatch5 ptr) as HRESULT
	ExplorerPolicy as function(byval This as IShellDispatch5 ptr, byval bstrPolicyName as BSTR, byval pValue as VARIANT ptr) as HRESULT
	GetSetting as function(byval This as IShellDispatch5 ptr, byval lSetting as LONG, byval pResult as VARIANT_BOOL ptr) as HRESULT
	WindowSwitcher as function(byval This as IShellDispatch5 ptr) as HRESULT
end type

type IShellDispatch5_
	lpVtbl as IShellDispatch5Vtbl ptr
end type

#define IShellDispatch5_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IShellDispatch5_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IShellDispatch5_Release(This) (This)->lpVtbl->Release(This)
#define IShellDispatch5_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define IShellDispatch5_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define IShellDispatch5_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define IShellDispatch5_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define IShellDispatch5_get_Application(This, ppid) (This)->lpVtbl->get_Application(This, ppid)
#define IShellDispatch5_get_Parent(This, ppid) (This)->lpVtbl->get_Parent(This, ppid)
#define IShellDispatch5_NameSpace(This, vDir, ppsdf) (This)->lpVtbl->NameSpace(This, vDir, ppsdf)
#define IShellDispatch5_BrowseForFolder(This, Hwnd, Title, Options, RootFolder, ppsdf) (This)->lpVtbl->BrowseForFolder(This, Hwnd, Title, Options, RootFolder, ppsdf)
#define IShellDispatch5_Windows(This, ppid) (This)->lpVtbl->Windows(This, ppid)
#define IShellDispatch5_Open(This, vDir) (This)->lpVtbl->Open(This, vDir)
#define IShellDispatch5_Explore(This, vDir) (This)->lpVtbl->Explore(This, vDir)
#define IShellDispatch5_MinimizeAll(This) (This)->lpVtbl->MinimizeAll(This)
#define IShellDispatch5_UndoMinimizeALL(This) (This)->lpVtbl->UndoMinimizeALL(This)
#define IShellDispatch5_FileRun(This) (This)->lpVtbl->FileRun(This)
#define IShellDispatch5_CascadeWindows(This) (This)->lpVtbl->CascadeWindows(This)
#define IShellDispatch5_TileVertically(This) (This)->lpVtbl->TileVertically(This)
#define IShellDispatch5_TileHorizontally(This) (This)->lpVtbl->TileHorizontally(This)
#define IShellDispatch5_ShutdownWindows(This) (This)->lpVtbl->ShutdownWindows(This)
#define IShellDispatch5_Suspend(This) (This)->lpVtbl->Suspend(This)
#define IShellDispatch5_EjectPC(This) (This)->lpVtbl->EjectPC(This)
#define IShellDispatch5_SetTime(This) (This)->lpVtbl->SetTime(This)
#define IShellDispatch5_TrayProperties(This) (This)->lpVtbl->TrayProperties(This)
#define IShellDispatch5_Help(This) (This)->lpVtbl->Help(This)
#define IShellDispatch5_FindFiles(This) (This)->lpVtbl->FindFiles(This)
#define IShellDispatch5_FindComputer(This) (This)->lpVtbl->FindComputer(This)
#define IShellDispatch5_RefreshMenu(This) (This)->lpVtbl->RefreshMenu(This)
#define IShellDispatch5_ControlPanelItem(This, bstrDir) (This)->lpVtbl->ControlPanelItem(This, bstrDir)
#define IShellDispatch5_IsRestricted(This, Group, Restriction, plRestrictValue) (This)->lpVtbl->IsRestricted(This, Group, Restriction, plRestrictValue)
#define IShellDispatch5_ShellExecute(This, File, vArgs, vDir, vOperation, vShow) (This)->lpVtbl->ShellExecute(This, File, vArgs, vDir, vOperation, vShow)
#define IShellDispatch5_FindPrinter(This, name, location, model) (This)->lpVtbl->FindPrinter(This, name, location, model)
#define IShellDispatch5_GetSystemInformation(This, name, pv) (This)->lpVtbl->GetSystemInformation(This, name, pv)
#define IShellDispatch5_ServiceStart(This, ServiceName, Persistent, pSuccess) (This)->lpVtbl->ServiceStart(This, ServiceName, Persistent, pSuccess)
#define IShellDispatch5_ServiceStop(This, ServiceName, Persistent, pSuccess) (This)->lpVtbl->ServiceStop(This, ServiceName, Persistent, pSuccess)
#define IShellDispatch5_IsServiceRunning(This, ServiceName, pRunning) (This)->lpVtbl->IsServiceRunning(This, ServiceName, pRunning)
#define IShellDispatch5_CanStartStopService(This, ServiceName, pCanStartStop) (This)->lpVtbl->CanStartStopService(This, ServiceName, pCanStartStop)
#define IShellDispatch5_ShowBrowserBar(This, bstrClsid, bShow, pSuccess) (This)->lpVtbl->ShowBrowserBar(This, bstrClsid, bShow, pSuccess)
#define IShellDispatch5_AddToRecent(This, varFile, bstrCategory) (This)->lpVtbl->AddToRecent(This, varFile, bstrCategory)
#define IShellDispatch5_WindowsSecurity(This) (This)->lpVtbl->WindowsSecurity(This)
#define IShellDispatch5_ToggleDesktop(This) (This)->lpVtbl->ToggleDesktop(This)
#define IShellDispatch5_ExplorerPolicy(This, bstrPolicyName, pValue) (This)->lpVtbl->ExplorerPolicy(This, bstrPolicyName, pValue)
#define IShellDispatch5_GetSetting(This, lSetting, pResult) (This)->lpVtbl->GetSetting(This, lSetting, pResult)
#define IShellDispatch5_WindowSwitcher(This) (This)->lpVtbl->WindowSwitcher(This)
declare function IShellDispatch5_WindowSwitcher_Proxy(byval This as IShellDispatch5 ptr) as HRESULT
declare sub IShellDispatch5_WindowSwitcher_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

#if _WIN32_WINNT = &h0602
	#define __IShellDispatch6_INTERFACE_DEFINED__
	extern IID_IShellDispatch6 as const GUID
	type IShellDispatch6 as IShellDispatch6_

	type IShellDispatch6Vtbl
		QueryInterface as function(byval This as IShellDispatch6 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
		AddRef as function(byval This as IShellDispatch6 ptr) as ULONG
		Release as function(byval This as IShellDispatch6 ptr) as ULONG
		GetTypeInfoCount as function(byval This as IShellDispatch6 ptr, byval pctinfo as UINT ptr) as HRESULT
		GetTypeInfo as function(byval This as IShellDispatch6 ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
		GetIDsOfNames as function(byval This as IShellDispatch6 ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
		Invoke as function(byval This as IShellDispatch6 ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
		get_Application as function(byval This as IShellDispatch6 ptr, byval ppid as IDispatch ptr ptr) as HRESULT
		get_Parent as function(byval This as IShellDispatch6 ptr, byval ppid as IDispatch ptr ptr) as HRESULT
		NameSpace as function(byval This as IShellDispatch6 ptr, byval vDir as VARIANT, byval ppsdf as Folder ptr ptr) as HRESULT
		BrowseForFolder as function(byval This as IShellDispatch6 ptr, byval Hwnd as LONG, byval Title as BSTR, byval Options as LONG, byval RootFolder as VARIANT, byval ppsdf as Folder ptr ptr) as HRESULT
		Windows as function(byval This as IShellDispatch6 ptr, byval ppid as IDispatch ptr ptr) as HRESULT
		Open as function(byval This as IShellDispatch6 ptr, byval vDir as VARIANT) as HRESULT
		Explore as function(byval This as IShellDispatch6 ptr, byval vDir as VARIANT) as HRESULT
		MinimizeAll as function(byval This as IShellDispatch6 ptr) as HRESULT
		UndoMinimizeALL as function(byval This as IShellDispatch6 ptr) as HRESULT
		FileRun as function(byval This as IShellDispatch6 ptr) as HRESULT
		CascadeWindows as function(byval This as IShellDispatch6 ptr) as HRESULT
		TileVertically as function(byval This as IShellDispatch6 ptr) as HRESULT
		TileHorizontally as function(byval This as IShellDispatch6 ptr) as HRESULT
		ShutdownWindows as function(byval This as IShellDispatch6 ptr) as HRESULT
		Suspend as function(byval This as IShellDispatch6 ptr) as HRESULT
		EjectPC as function(byval This as IShellDispatch6 ptr) as HRESULT
		SetTime as function(byval This as IShellDispatch6 ptr) as HRESULT
		TrayProperties as function(byval This as IShellDispatch6 ptr) as HRESULT
		Help as function(byval This as IShellDispatch6 ptr) as HRESULT
		FindFiles as function(byval This as IShellDispatch6 ptr) as HRESULT
		FindComputer as function(byval This as IShellDispatch6 ptr) as HRESULT
		RefreshMenu as function(byval This as IShellDispatch6 ptr) as HRESULT
		ControlPanelItem as function(byval This as IShellDispatch6 ptr, byval bstrDir as BSTR) as HRESULT
		IsRestricted as function(byval This as IShellDispatch6 ptr, byval Group as BSTR, byval Restriction as BSTR, byval plRestrictValue as LONG ptr) as HRESULT

		#if defined(UNICODE) and (_WIN32_WINNT = &h0602)
			ShellExecuteW as function(byval This as IShellDispatch6 ptr, byval File as BSTR, byval vArgs as VARIANT, byval vDir as VARIANT, byval vOperation as VARIANT, byval vShow as VARIANT) as HRESULT
		#elseif (not defined(UNICODE)) and (_WIN32_WINNT = &h0602)
			ShellExecuteA as function(byval This as IShellDispatch6 ptr, byval File as BSTR, byval vArgs as VARIANT, byval vDir as VARIANT, byval vOperation as VARIANT, byval vShow as VARIANT) as HRESULT
		#endif

		FindPrinter as function(byval This as IShellDispatch6 ptr, byval name as BSTR, byval location as BSTR, byval model as BSTR) as HRESULT
		GetSystemInformation as function(byval This as IShellDispatch6 ptr, byval name as BSTR, byval pv as VARIANT ptr) as HRESULT
		ServiceStart as function(byval This as IShellDispatch6 ptr, byval ServiceName as BSTR, byval Persistent as VARIANT, byval pSuccess as VARIANT ptr) as HRESULT
		ServiceStop as function(byval This as IShellDispatch6 ptr, byval ServiceName as BSTR, byval Persistent as VARIANT, byval pSuccess as VARIANT ptr) as HRESULT
		IsServiceRunning as function(byval This as IShellDispatch6 ptr, byval ServiceName as BSTR, byval pRunning as VARIANT ptr) as HRESULT
		CanStartStopService as function(byval This as IShellDispatch6 ptr, byval ServiceName as BSTR, byval pCanStartStop as VARIANT ptr) as HRESULT
		ShowBrowserBar as function(byval This as IShellDispatch6 ptr, byval bstrClsid as BSTR, byval bShow as VARIANT, byval pSuccess as VARIANT ptr) as HRESULT
		AddToRecent as function(byval This as IShellDispatch6 ptr, byval varFile as VARIANT, byval bstrCategory as BSTR) as HRESULT
		WindowsSecurity as function(byval This as IShellDispatch6 ptr) as HRESULT
		ToggleDesktop as function(byval This as IShellDispatch6 ptr) as HRESULT
		ExplorerPolicy as function(byval This as IShellDispatch6 ptr, byval bstrPolicyName as BSTR, byval pValue as VARIANT ptr) as HRESULT
		GetSetting as function(byval This as IShellDispatch6 ptr, byval lSetting as LONG, byval pResult as VARIANT_BOOL ptr) as HRESULT
		WindowSwitcher as function(byval This as IShellDispatch6 ptr) as HRESULT
		SearchCommand as function(byval This as IShellDispatch6 ptr) as HRESULT
	end type

	type IShellDispatch6_
		lpVtbl as IShellDispatch6Vtbl ptr
	end type

	#define IShellDispatch6_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
	#define IShellDispatch6_AddRef(This) (This)->lpVtbl->AddRef(This)
	#define IShellDispatch6_Release(This) (This)->lpVtbl->Release(This)
	#define IShellDispatch6_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
	#define IShellDispatch6_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
	#define IShellDispatch6_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
	#define IShellDispatch6_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
	#define IShellDispatch6_get_Application(This, ppid) (This)->lpVtbl->get_Application(This, ppid)
	#define IShellDispatch6_get_Parent(This, ppid) (This)->lpVtbl->get_Parent(This, ppid)
	#define IShellDispatch6_NameSpace(This, vDir, ppsdf) (This)->lpVtbl->NameSpace(This, vDir, ppsdf)
	#define IShellDispatch6_BrowseForFolder(This, Hwnd, Title, Options, RootFolder, ppsdf) (This)->lpVtbl->BrowseForFolder(This, Hwnd, Title, Options, RootFolder, ppsdf)
	#define IShellDispatch6_Windows(This, ppid) (This)->lpVtbl->Windows(This, ppid)
	#define IShellDispatch6_Open(This, vDir) (This)->lpVtbl->Open(This, vDir)
	#define IShellDispatch6_Explore(This, vDir) (This)->lpVtbl->Explore(This, vDir)
	#define IShellDispatch6_MinimizeAll(This) (This)->lpVtbl->MinimizeAll(This)
	#define IShellDispatch6_UndoMinimizeALL(This) (This)->lpVtbl->UndoMinimizeALL(This)
	#define IShellDispatch6_FileRun(This) (This)->lpVtbl->FileRun(This)
	#define IShellDispatch6_CascadeWindows(This) (This)->lpVtbl->CascadeWindows(This)
	#define IShellDispatch6_TileVertically(This) (This)->lpVtbl->TileVertically(This)
	#define IShellDispatch6_TileHorizontally(This) (This)->lpVtbl->TileHorizontally(This)
	#define IShellDispatch6_ShutdownWindows(This) (This)->lpVtbl->ShutdownWindows(This)
	#define IShellDispatch6_Suspend(This) (This)->lpVtbl->Suspend(This)
	#define IShellDispatch6_EjectPC(This) (This)->lpVtbl->EjectPC(This)
	#define IShellDispatch6_SetTime(This) (This)->lpVtbl->SetTime(This)
	#define IShellDispatch6_TrayProperties(This) (This)->lpVtbl->TrayProperties(This)
	#define IShellDispatch6_Help(This) (This)->lpVtbl->Help(This)
	#define IShellDispatch6_FindFiles(This) (This)->lpVtbl->FindFiles(This)
	#define IShellDispatch6_FindComputer(This) (This)->lpVtbl->FindComputer(This)
	#define IShellDispatch6_RefreshMenu(This) (This)->lpVtbl->RefreshMenu(This)
	#define IShellDispatch6_ControlPanelItem(This, bstrDir) (This)->lpVtbl->ControlPanelItem(This, bstrDir)
	#define IShellDispatch6_IsRestricted(This, Group, Restriction, plRestrictValue) (This)->lpVtbl->IsRestricted(This, Group, Restriction, plRestrictValue)
	#define IShellDispatch6_ShellExecute(This, File, vArgs, vDir, vOperation, vShow) (This)->lpVtbl->ShellExecute(This, File, vArgs, vDir, vOperation, vShow)
	#define IShellDispatch6_FindPrinter(This, name, location, model) (This)->lpVtbl->FindPrinter(This, name, location, model)
	#define IShellDispatch6_GetSystemInformation(This, name, pv) (This)->lpVtbl->GetSystemInformation(This, name, pv)
	#define IShellDispatch6_ServiceStart(This, ServiceName, Persistent, pSuccess) (This)->lpVtbl->ServiceStart(This, ServiceName, Persistent, pSuccess)
	#define IShellDispatch6_ServiceStop(This, ServiceName, Persistent, pSuccess) (This)->lpVtbl->ServiceStop(This, ServiceName, Persistent, pSuccess)
	#define IShellDispatch6_IsServiceRunning(This, ServiceName, pRunning) (This)->lpVtbl->IsServiceRunning(This, ServiceName, pRunning)
	#define IShellDispatch6_CanStartStopService(This, ServiceName, pCanStartStop) (This)->lpVtbl->CanStartStopService(This, ServiceName, pCanStartStop)
	#define IShellDispatch6_ShowBrowserBar(This, bstrClsid, bShow, pSuccess) (This)->lpVtbl->ShowBrowserBar(This, bstrClsid, bShow, pSuccess)
	#define IShellDispatch6_AddToRecent(This, varFile, bstrCategory) (This)->lpVtbl->AddToRecent(This, varFile, bstrCategory)
	#define IShellDispatch6_WindowsSecurity(This) (This)->lpVtbl->WindowsSecurity(This)
	#define IShellDispatch6_ToggleDesktop(This) (This)->lpVtbl->ToggleDesktop(This)
	#define IShellDispatch6_ExplorerPolicy(This, bstrPolicyName, pValue) (This)->lpVtbl->ExplorerPolicy(This, bstrPolicyName, pValue)
	#define IShellDispatch6_GetSetting(This, lSetting, pResult) (This)->lpVtbl->GetSetting(This, lSetting, pResult)
	#define IShellDispatch6_WindowSwitcher(This) (This)->lpVtbl->WindowSwitcher(This)
	#define IShellDispatch6_SearchCommand(This) (This)->lpVtbl->SearchCommand(This)
	declare function IShellDispatch6_SearchCommand_Proxy(byval This as IShellDispatch6 ptr) as HRESULT
	declare sub IShellDispatch6_SearchCommand_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#endif

extern CLSID_Shell as const GUID
extern CLSID_ShellDispatchInproc as const GUID

type ShellSpecialFolderConstants as long
enum
	ssfDESKTOP = &h0
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

#define __IFileSearchBand_INTERFACE_DEFINED__
extern IID_IFileSearchBand as const GUID
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

#define IFileSearchBand_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IFileSearchBand_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IFileSearchBand_Release(This) (This)->lpVtbl->Release(This)
#define IFileSearchBand_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define IFileSearchBand_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define IFileSearchBand_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define IFileSearchBand_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define IFileSearchBand_SetFocus(This) (This)->lpVtbl->SetFocus(This)
#define IFileSearchBand_SetSearchParameters(This, pbstrSearchID, bNavToResults, pvarScope, pvarQueryFile) (This)->lpVtbl->SetSearchParameters(This, pbstrSearchID, bNavToResults, pvarScope, pvarQueryFile)
#define IFileSearchBand_get_SearchID(This, pbstrSearchID) (This)->lpVtbl->get_SearchID(This, pbstrSearchID)
#define IFileSearchBand_get_Scope(This, pvarScope) (This)->lpVtbl->get_Scope(This, pvarScope)
#define IFileSearchBand_get_QueryFile(This, pvarFile) (This)->lpVtbl->get_QueryFile(This, pvarFile)

declare function IFileSearchBand_SetFocus_Proxy(byval This as IFileSearchBand ptr) as HRESULT
declare sub IFileSearchBand_SetFocus_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFileSearchBand_SetSearchParameters_Proxy(byval This as IFileSearchBand ptr, byval pbstrSearchID as BSTR ptr, byval bNavToResults as VARIANT_BOOL, byval pvarScope as VARIANT ptr, byval pvarQueryFile as VARIANT ptr) as HRESULT
declare sub IFileSearchBand_SetSearchParameters_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFileSearchBand_get_SearchID_Proxy(byval This as IFileSearchBand ptr, byval pbstrSearchID as BSTR ptr) as HRESULT
declare sub IFileSearchBand_get_SearchID_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFileSearchBand_get_Scope_Proxy(byval This as IFileSearchBand ptr, byval pvarScope as VARIANT ptr) as HRESULT
declare sub IFileSearchBand_get_Scope_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IFileSearchBand_get_QueryFile_Proxy(byval This as IFileSearchBand ptr, byval pvarFile as VARIANT ptr) as HRESULT
declare sub IFileSearchBand_get_QueryFile_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
extern CLSID_FileSearchBand as const GUID
#define __IWebWizardHost_INTERFACE_DEFINED__
extern IID_IWebWizardHost as const GUID
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

#define IWebWizardHost_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IWebWizardHost_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IWebWizardHost_Release(This) (This)->lpVtbl->Release(This)
#define IWebWizardHost_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define IWebWizardHost_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define IWebWizardHost_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define IWebWizardHost_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define IWebWizardHost_FinalBack(This) (This)->lpVtbl->FinalBack(This)
#define IWebWizardHost_FinalNext(This) (This)->lpVtbl->FinalNext(This)
#define IWebWizardHost_Cancel(This) (This)->lpVtbl->Cancel(This)
#define IWebWizardHost_put_Caption(This, bstrCaption) (This)->lpVtbl->put_Caption(This, bstrCaption)
#define IWebWizardHost_get_Caption(This, pbstrCaption) (This)->lpVtbl->get_Caption(This, pbstrCaption)
#define IWebWizardHost_put_Property(This, bstrPropertyName, pvProperty) (This)->lpVtbl->put_Property(This, bstrPropertyName, pvProperty)
#define IWebWizardHost_get_Property(This, bstrPropertyName, pvProperty) (This)->lpVtbl->get_Property(This, bstrPropertyName, pvProperty)
#define IWebWizardHost_SetWizardButtons(This, vfEnableBack, vfEnableNext, vfLastPage) (This)->lpVtbl->SetWizardButtons(This, vfEnableBack, vfEnableNext, vfLastPage)
#define IWebWizardHost_SetHeaderText(This, bstrHeaderTitle, bstrHeaderSubtitle) (This)->lpVtbl->SetHeaderText(This, bstrHeaderTitle, bstrHeaderSubtitle)

declare function IWebWizardHost_FinalBack_Proxy(byval This as IWebWizardHost ptr) as HRESULT
declare sub IWebWizardHost_FinalBack_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWebWizardHost_FinalNext_Proxy(byval This as IWebWizardHost ptr) as HRESULT
declare sub IWebWizardHost_FinalNext_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWebWizardHost_Cancel_Proxy(byval This as IWebWizardHost ptr) as HRESULT
declare sub IWebWizardHost_Cancel_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWebWizardHost_put_Caption_Proxy(byval This as IWebWizardHost ptr, byval bstrCaption as BSTR) as HRESULT
declare sub IWebWizardHost_put_Caption_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWebWizardHost_get_Caption_Proxy(byval This as IWebWizardHost ptr, byval pbstrCaption as BSTR ptr) as HRESULT
declare sub IWebWizardHost_get_Caption_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWebWizardHost_put_Property_Proxy(byval This as IWebWizardHost ptr, byval bstrPropertyName as BSTR, byval pvProperty as VARIANT ptr) as HRESULT
declare sub IWebWizardHost_put_Property_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWebWizardHost_get_Property_Proxy(byval This as IWebWizardHost ptr, byval bstrPropertyName as BSTR, byval pvProperty as VARIANT ptr) as HRESULT
declare sub IWebWizardHost_get_Property_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWebWizardHost_SetWizardButtons_Proxy(byval This as IWebWizardHost ptr, byval vfEnableBack as VARIANT_BOOL, byval vfEnableNext as VARIANT_BOOL, byval vfLastPage as VARIANT_BOOL) as HRESULT
declare sub IWebWizardHost_SetWizardButtons_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IWebWizardHost_SetHeaderText_Proxy(byval This as IWebWizardHost ptr, byval bstrHeaderTitle as BSTR, byval bstrHeaderSubtitle as BSTR) as HRESULT
declare sub IWebWizardHost_SetHeaderText_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __INewWDEvents_INTERFACE_DEFINED__
extern IID_INewWDEvents as const GUID
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

#define INewWDEvents_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define INewWDEvents_AddRef(This) (This)->lpVtbl->AddRef(This)
#define INewWDEvents_Release(This) (This)->lpVtbl->Release(This)
#define INewWDEvents_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define INewWDEvents_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define INewWDEvents_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define INewWDEvents_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define INewWDEvents_FinalBack(This) (This)->lpVtbl->FinalBack(This)
#define INewWDEvents_FinalNext(This) (This)->lpVtbl->FinalNext(This)
#define INewWDEvents_Cancel(This) (This)->lpVtbl->Cancel(This)
#define INewWDEvents_put_Caption(This, bstrCaption) (This)->lpVtbl->put_Caption(This, bstrCaption)
#define INewWDEvents_get_Caption(This, pbstrCaption) (This)->lpVtbl->get_Caption(This, pbstrCaption)
#define INewWDEvents_put_Property(This, bstrPropertyName, pvProperty) (This)->lpVtbl->put_Property(This, bstrPropertyName, pvProperty)
#define INewWDEvents_get_Property(This, bstrPropertyName, pvProperty) (This)->lpVtbl->get_Property(This, bstrPropertyName, pvProperty)
#define INewWDEvents_SetWizardButtons(This, vfEnableBack, vfEnableNext, vfLastPage) (This)->lpVtbl->SetWizardButtons(This, vfEnableBack, vfEnableNext, vfLastPage)
#define INewWDEvents_SetHeaderText(This, bstrHeaderTitle, bstrHeaderSubtitle) (This)->lpVtbl->SetHeaderText(This, bstrHeaderTitle, bstrHeaderSubtitle)
#define INewWDEvents_PassportAuthenticate(This, bstrSignInUrl, pvfAuthenitcated) (This)->lpVtbl->PassportAuthenticate(This, bstrSignInUrl, pvfAuthenitcated)
declare function INewWDEvents_PassportAuthenticate_Proxy(byval This as INewWDEvents ptr, byval bstrSignInUrl as BSTR, byval pvfAuthenitcated as VARIANT_BOOL ptr) as HRESULT
declare sub INewWDEvents_PassportAuthenticate_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IAutoComplete_INTERFACE_DEFINED__
type IAutoComplete as IAutoComplete_
type LPAUTOCOMPLETE as IAutoComplete ptr
extern IID_IAutoComplete as const GUID

type IAutoCompleteVtbl
	QueryInterface as function(byval This as IAutoComplete ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAutoComplete ptr) as ULONG
	Release as function(byval This as IAutoComplete ptr) as ULONG
	Init as function(byval This as IAutoComplete ptr, byval hwndEdit as HWND, byval punkACL as IUnknown ptr, byval pwszRegKeyPath as LPCWSTR, byval pwszQuickComplete as LPCWSTR) as HRESULT
	Enable as function(byval This as IAutoComplete ptr, byval fEnable as WINBOOL) as HRESULT
end type

type IAutoComplete_
	lpVtbl as IAutoCompleteVtbl ptr
end type

#define IAutoComplete_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IAutoComplete_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IAutoComplete_Release(This) (This)->lpVtbl->Release(This)
#define IAutoComplete_Init(This, hwndEdit, punkACL, pwszRegKeyPath, pwszQuickComplete) (This)->lpVtbl->Init(This, hwndEdit, punkACL, pwszRegKeyPath, pwszQuickComplete)
#define IAutoComplete_Enable(This, fEnable) (This)->lpVtbl->Enable(This, fEnable)

declare function IAutoComplete_Init_Proxy(byval This as IAutoComplete ptr, byval hwndEdit as HWND, byval punkACL as IUnknown ptr, byval pwszRegKeyPath as LPCWSTR, byval pwszQuickComplete as LPCWSTR) as HRESULT
declare sub IAutoComplete_Init_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IAutoComplete_Enable_Proxy(byval This as IAutoComplete ptr, byval fEnable as WINBOOL) as HRESULT
declare sub IAutoComplete_Enable_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IAutoComplete2_INTERFACE_DEFINED__
type IAutoComplete2 as IAutoComplete2_
type LPAUTOCOMPLETE2 as IAutoComplete2 ptr

type _tagAUTOCOMPLETEOPTIONS as long
enum
	ACO_NONE = &h0
	ACO_AUTOSUGGEST = &h1
	ACO_AUTOAPPEND = &h2
	ACO_SEARCH = &h4
	ACO_FILTERPREFIXES = &h8
	ACO_USETAB = &h10
	ACO_UPDOWNKEYDROPSLIST = &h20
	ACO_RTLREADING = &h40
	ACO_WORD_FILTER = &h80
	ACO_NOPREFIXFILTERING = &h100
end enum

type AUTOCOMPLETEOPTIONS as _tagAUTOCOMPLETEOPTIONS
extern IID_IAutoComplete2 as const GUID

type IAutoComplete2Vtbl
	QueryInterface as function(byval This as IAutoComplete2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAutoComplete2 ptr) as ULONG
	Release as function(byval This as IAutoComplete2 ptr) as ULONG
	Init as function(byval This as IAutoComplete2 ptr, byval hwndEdit as HWND, byval punkACL as IUnknown ptr, byval pwszRegKeyPath as LPCWSTR, byval pwszQuickComplete as LPCWSTR) as HRESULT
	Enable as function(byval This as IAutoComplete2 ptr, byval fEnable as WINBOOL) as HRESULT
	SetOptions as function(byval This as IAutoComplete2 ptr, byval dwFlag as DWORD) as HRESULT
	GetOptions as function(byval This as IAutoComplete2 ptr, byval pdwFlag as DWORD ptr) as HRESULT
end type

type IAutoComplete2_
	lpVtbl as IAutoComplete2Vtbl ptr
end type

#define IAutoComplete2_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IAutoComplete2_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IAutoComplete2_Release(This) (This)->lpVtbl->Release(This)
#define IAutoComplete2_Init(This, hwndEdit, punkACL, pwszRegKeyPath, pwszQuickComplete) (This)->lpVtbl->Init(This, hwndEdit, punkACL, pwszRegKeyPath, pwszQuickComplete)
#define IAutoComplete2_Enable(This, fEnable) (This)->lpVtbl->Enable(This, fEnable)
#define IAutoComplete2_SetOptions(This, dwFlag) (This)->lpVtbl->SetOptions(This, dwFlag)
#define IAutoComplete2_GetOptions(This, pdwFlag) (This)->lpVtbl->GetOptions(This, pdwFlag)

declare function IAutoComplete2_SetOptions_Proxy(byval This as IAutoComplete2 ptr, byval dwFlag as DWORD) as HRESULT
declare sub IAutoComplete2_SetOptions_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IAutoComplete2_GetOptions_Proxy(byval This as IAutoComplete2 ptr, byval pdwFlag as DWORD ptr) as HRESULT
declare sub IAutoComplete2_GetOptions_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IEnumACString_INTERFACE_DEFINED__

type IEnumACString as IEnumACString_
type PENUMACSTRING as IEnumACString ptr
type LPENUMACSTRING as IEnumACString ptr

type _tagACENUMOPTION as long
enum
	ACEO_NONE = &h0
	ACEO_MOSTRECENTFIRST = &h1
	ACEO_FIRSTUNUSED = &h10000
end enum

type ACENUMOPTION as _tagACENUMOPTION
extern IID_IEnumACString as const GUID

type IEnumACStringVtbl
	QueryInterface as function(byval This as IEnumACString ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IEnumACString ptr) as ULONG
	Release as function(byval This as IEnumACString ptr) as ULONG
	Next as function(byval This as IEnumACString ptr, byval celt as ULONG, byval rgelt as LPOLESTR ptr, byval pceltFetched as ULONG ptr) as HRESULT
	Skip as function(byval This as IEnumACString ptr, byval celt as ULONG) as HRESULT
	Reset as function(byval This as IEnumACString ptr) as HRESULT
	Clone as function(byval This as IEnumACString ptr, byval ppenum as IEnumString ptr ptr) as HRESULT
	NextItem as function(byval This as IEnumACString ptr, byval pszUrl as LPWSTR, byval cchMax as ULONG, byval pulSortIndex as ULONG ptr) as HRESULT
	SetEnumOptions as function(byval This as IEnumACString ptr, byval dwOptions as DWORD) as HRESULT
	GetEnumOptions as function(byval This as IEnumACString ptr, byval pdwOptions as DWORD ptr) as HRESULT
end type

type IEnumACString_
	lpVtbl as IEnumACStringVtbl ptr
end type

#define IEnumACString_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IEnumACString_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IEnumACString_Release(This) (This)->lpVtbl->Release(This)
#define IEnumACString_Next(This, celt, rgelt, pceltFetched) (This)->lpVtbl->Next(This, celt, rgelt, pceltFetched)
#define IEnumACString_Skip(This, celt) (This)->lpVtbl->Skip(This, celt)
#define IEnumACString_Reset(This) (This)->lpVtbl->Reset(This)
#define IEnumACString_Clone(This, ppenum) (This)->lpVtbl->Clone(This, ppenum)
#define IEnumACString_NextItem(This, pszUrl, cchMax, pulSortIndex) (This)->lpVtbl->NextItem(This, pszUrl, cchMax, pulSortIndex)
#define IEnumACString_SetEnumOptions(This, dwOptions) (This)->lpVtbl->SetEnumOptions(This, dwOptions)
#define IEnumACString_GetEnumOptions(This, pdwOptions) (This)->lpVtbl->GetEnumOptions(This, pdwOptions)

declare function IEnumACString_NextItem_Proxy(byval This as IEnumACString ptr, byval pszUrl as LPWSTR, byval cchMax as ULONG, byval pulSortIndex as ULONG ptr) as HRESULT
declare sub IEnumACString_NextItem_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumACString_SetEnumOptions_Proxy(byval This as IEnumACString ptr, byval dwOptions as DWORD) as HRESULT
declare sub IEnumACString_SetEnumOptions_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IEnumACString_GetEnumOptions_Proxy(byval This as IEnumACString ptr, byval pdwOptions as DWORD ptr) as HRESULT
declare sub IEnumACString_GetEnumOptions_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
#define __IDataObjectAsyncCapability_INTERFACE_DEFINED__
extern IID_IDataObjectAsyncCapability as const GUID
type IDataObjectAsyncCapability as IDataObjectAsyncCapability_

type IDataObjectAsyncCapabilityVtbl
	QueryInterface as function(byval This as IDataObjectAsyncCapability ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDataObjectAsyncCapability ptr) as ULONG
	Release as function(byval This as IDataObjectAsyncCapability ptr) as ULONG
	SetAsyncMode as function(byval This as IDataObjectAsyncCapability ptr, byval fDoOpAsync as WINBOOL) as HRESULT
	GetAsyncMode as function(byval This as IDataObjectAsyncCapability ptr, byval pfIsOpAsync as WINBOOL ptr) as HRESULT
	StartOperation as function(byval This as IDataObjectAsyncCapability ptr, byval pbcReserved as IBindCtx ptr) as HRESULT
	InOperation as function(byval This as IDataObjectAsyncCapability ptr, byval pfInAsyncOp as WINBOOL ptr) as HRESULT
	EndOperation as function(byval This as IDataObjectAsyncCapability ptr, byval hResult as HRESULT, byval pbcReserved as IBindCtx ptr, byval dwEffects as DWORD) as HRESULT
end type

type IDataObjectAsyncCapability_
	lpVtbl as IDataObjectAsyncCapabilityVtbl ptr
end type

#define IDataObjectAsyncCapability_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IDataObjectAsyncCapability_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IDataObjectAsyncCapability_Release(This) (This)->lpVtbl->Release(This)
#define IDataObjectAsyncCapability_SetAsyncMode(This, fDoOpAsync) (This)->lpVtbl->SetAsyncMode(This, fDoOpAsync)
#define IDataObjectAsyncCapability_GetAsyncMode(This, pfIsOpAsync) (This)->lpVtbl->GetAsyncMode(This, pfIsOpAsync)
#define IDataObjectAsyncCapability_StartOperation(This, pbcReserved) (This)->lpVtbl->StartOperation(This, pbcReserved)
#define IDataObjectAsyncCapability_InOperation(This, pfInAsyncOp) (This)->lpVtbl->InOperation(This, pfInAsyncOp)
#define IDataObjectAsyncCapability_EndOperation(This, hResult, pbcReserved, dwEffects) (This)->lpVtbl->EndOperation(This, hResult, pbcReserved, dwEffects)

declare function IDataObjectAsyncCapability_SetAsyncMode_Proxy(byval This as IDataObjectAsyncCapability ptr, byval fDoOpAsync as WINBOOL) as HRESULT
declare sub IDataObjectAsyncCapability_SetAsyncMode_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IDataObjectAsyncCapability_GetAsyncMode_Proxy(byval This as IDataObjectAsyncCapability ptr, byval pfIsOpAsync as WINBOOL ptr) as HRESULT
declare sub IDataObjectAsyncCapability_GetAsyncMode_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IDataObjectAsyncCapability_StartOperation_Proxy(byval This as IDataObjectAsyncCapability ptr, byval pbcReserved as IBindCtx ptr) as HRESULT
declare sub IDataObjectAsyncCapability_StartOperation_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IDataObjectAsyncCapability_InOperation_Proxy(byval This as IDataObjectAsyncCapability ptr, byval pfInAsyncOp as WINBOOL ptr) as HRESULT
declare sub IDataObjectAsyncCapability_InOperation_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IDataObjectAsyncCapability_EndOperation_Proxy(byval This as IDataObjectAsyncCapability ptr, byval hResult as HRESULT, byval pbcReserved as IBindCtx ptr, byval dwEffects as DWORD) as HRESULT
declare sub IDataObjectAsyncCapability_EndOperation_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)

end extern

#include once "ole-common.bi"
