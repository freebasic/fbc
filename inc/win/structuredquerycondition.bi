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
#include once "oaidl.bi"
#include once "ocidl.bi"
#include once "objidl.bi"
#include once "propidl.bi"
#include once "winapifamily.bi"

extern "Windows"

#define __structuredquerycondition_h__
#define __IRichChunk_FWD_DEFINED__
#define __ICondition_FWD_DEFINED__
#define __ICondition2_FWD_DEFINED__

type tagCONDITION_TYPE as long
enum
	CT_AND_CONDITION = 0
	CT_OR_CONDITION = 1
	CT_NOT_CONDITION = 2
	CT_LEAF_CONDITION = 3
end enum

type CONDITION_TYPE as tagCONDITION_TYPE

type tagCONDITION_OPERATION as long
enum
	COP_IMPLICIT = 0
	COP_EQUAL = 1
	COP_NOTEQUAL = 2
	COP_LESSTHAN = 3
	COP_GREATERTHAN = 4
	COP_LESSTHANOREQUAL = 5
	COP_GREATERTHANOREQUAL = 6
	COP_VALUE_STARTSWITH = 7
	COP_VALUE_ENDSWITH = 8
	COP_VALUE_CONTAINS = 9
	COP_VALUE_NOTCONTAINS = 10
	COP_DOSWILDCARDS = 11
	COP_WORD_EQUAL = 12
	COP_WORD_STARTSWITH = 13
	COP_APPLICATION_SPECIFIC = 14
end enum

type CONDITION_OPERATION as tagCONDITION_OPERATION
#define __IRichChunk_INTERFACE_DEFINED__
extern IID_IRichChunk as const GUID
type IRichChunk as IRichChunk_

type IRichChunkVtbl
	QueryInterface as function(byval This as IRichChunk ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IRichChunk ptr) as ULONG
	Release as function(byval This as IRichChunk ptr) as ULONG
	GetData as function(byval This as IRichChunk ptr, byval pFirstPos as ULONG ptr, byval pLength as ULONG ptr, byval ppsz as LPWSTR ptr, byval pValue as PROPVARIANT ptr) as HRESULT
end type

type IRichChunk_
	lpVtbl as IRichChunkVtbl ptr
end type

#define IRichChunk_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IRichChunk_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IRichChunk_Release(This) (This)->lpVtbl->Release(This)
#define IRichChunk_GetData(This, pFirstPos, pLength, ppsz, pValue) (This)->lpVtbl->GetData(This, pFirstPos, pLength, ppsz, pValue)

declare function IRichChunk_RemoteGetData_Proxy(byval This as IRichChunk ptr, byval pFirstPos as ULONG ptr, byval pLength as ULONG ptr, byval ppsz as LPWSTR ptr, byval pValue as PROPVARIANT ptr) as HRESULT
declare sub IRichChunk_RemoteGetData_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function IRichChunk_GetData_Proxy(byval This as IRichChunk ptr, byval pFirstPos as ULONG ptr, byval pLength as ULONG ptr, byval ppsz as LPWSTR ptr, byval pValue as PROPVARIANT ptr) as HRESULT
declare function IRichChunk_GetData_Stub(byval This as IRichChunk ptr, byval pFirstPos as ULONG ptr, byval pLength as ULONG ptr, byval ppsz as LPWSTR ptr, byval pValue as PROPVARIANT ptr) as HRESULT
#define __ICondition_INTERFACE_DEFINED__
extern IID_ICondition as const GUID
type ICondition as ICondition_

type IConditionVtbl
	QueryInterface as function(byval This as ICondition ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as ICondition ptr) as ULONG
	Release as function(byval This as ICondition ptr) as ULONG
	GetClassID as function(byval This as ICondition ptr, byval pClassID as CLSID ptr) as HRESULT
	IsDirty as function(byval This as ICondition ptr) as HRESULT
	Load as function(byval This as ICondition ptr, byval pStm as IStream ptr) as HRESULT
	Save as function(byval This as ICondition ptr, byval pStm as IStream ptr, byval fClearDirty as WINBOOL) as HRESULT
	GetSizeMax as function(byval This as ICondition ptr, byval pcbSize as ULARGE_INTEGER ptr) as HRESULT
	GetConditionType as function(byval This as ICondition ptr, byval pNodeType as CONDITION_TYPE ptr) as HRESULT
	GetSubConditions as function(byval This as ICondition ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	GetComparisonInfo as function(byval This as ICondition ptr, byval ppszPropertyName as LPWSTR ptr, byval pcop as CONDITION_OPERATION ptr, byval ppropvar as PROPVARIANT ptr) as HRESULT
	GetValueType as function(byval This as ICondition ptr, byval ppszValueTypeName as LPWSTR ptr) as HRESULT
	GetValueNormalization as function(byval This as ICondition ptr, byval ppszNormalization as LPWSTR ptr) as HRESULT
	GetInputTerms as function(byval This as ICondition ptr, byval ppPropertyTerm as IRichChunk ptr ptr, byval ppOperationTerm as IRichChunk ptr ptr, byval ppValueTerm as IRichChunk ptr ptr) as HRESULT
	Clone as function(byval This as ICondition ptr, byval ppc as ICondition ptr ptr) as HRESULT
end type

type ICondition_
	lpVtbl as IConditionVtbl ptr
end type

#define ICondition_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define ICondition_AddRef(This) (This)->lpVtbl->AddRef(This)
#define ICondition_Release(This) (This)->lpVtbl->Release(This)
#define ICondition_GetClassID(This, pClassID) (This)->lpVtbl->GetClassID(This, pClassID)
#define ICondition_IsDirty(This) (This)->lpVtbl->IsDirty(This)
#define ICondition_Load(This, pStm) (This)->lpVtbl->Load(This, pStm)
#define ICondition_Save(This, pStm, fClearDirty) (This)->lpVtbl->Save(This, pStm, fClearDirty)
#define ICondition_GetSizeMax(This, pcbSize) (This)->lpVtbl->GetSizeMax(This, pcbSize)
#define ICondition_GetConditionType(This, pNodeType) (This)->lpVtbl->GetConditionType(This, pNodeType)
#define ICondition_GetSubConditions(This, riid, ppv) (This)->lpVtbl->GetSubConditions(This, riid, ppv)
#define ICondition_GetComparisonInfo(This, ppszPropertyName, pcop, ppropvar) (This)->lpVtbl->GetComparisonInfo(This, ppszPropertyName, pcop, ppropvar)
#define ICondition_GetValueType(This, ppszValueTypeName) (This)->lpVtbl->GetValueType(This, ppszValueTypeName)
#define ICondition_GetValueNormalization(This, ppszNormalization) (This)->lpVtbl->GetValueNormalization(This, ppszNormalization)
#define ICondition_GetInputTerms(This, ppPropertyTerm, ppOperationTerm, ppValueTerm) (This)->lpVtbl->GetInputTerms(This, ppPropertyTerm, ppOperationTerm, ppValueTerm)
#define ICondition_Clone(This, ppc) (This)->lpVtbl->Clone(This, ppc)

declare function ICondition_GetConditionType_Proxy(byval This as ICondition ptr, byval pNodeType as CONDITION_TYPE ptr) as HRESULT
declare sub ICondition_GetConditionType_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICondition_GetSubConditions_Proxy(byval This as ICondition ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
declare sub ICondition_GetSubConditions_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICondition_RemoteGetComparisonInfo_Proxy(byval This as ICondition ptr, byval ppszPropertyName as LPWSTR ptr, byval pcop as CONDITION_OPERATION ptr, byval ppropvar as PROPVARIANT ptr) as HRESULT
declare sub ICondition_RemoteGetComparisonInfo_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICondition_GetValueType_Proxy(byval This as ICondition ptr, byval ppszValueTypeName as LPWSTR ptr) as HRESULT
declare sub ICondition_GetValueType_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICondition_GetValueNormalization_Proxy(byval This as ICondition ptr, byval ppszNormalization as LPWSTR ptr) as HRESULT
declare sub ICondition_GetValueNormalization_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICondition_RemoteGetInputTerms_Proxy(byval This as ICondition ptr, byval ppPropertyTerm as IRichChunk ptr ptr, byval ppOperationTerm as IRichChunk ptr ptr, byval ppValueTerm as IRichChunk ptr ptr) as HRESULT
declare sub ICondition_RemoteGetInputTerms_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICondition_Clone_Proxy(byval This as ICondition ptr, byval ppc as ICondition ptr ptr) as HRESULT
declare sub ICondition_Clone_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICondition_GetComparisonInfo_Proxy(byval This as ICondition ptr, byval ppszPropertyName as LPWSTR ptr, byval pcop as CONDITION_OPERATION ptr, byval ppropvar as PROPVARIANT ptr) as HRESULT
declare function ICondition_GetComparisonInfo_Stub(byval This as ICondition ptr, byval ppszPropertyName as LPWSTR ptr, byval pcop as CONDITION_OPERATION ptr, byval ppropvar as PROPVARIANT ptr) as HRESULT
declare function ICondition_GetInputTerms_Proxy(byval This as ICondition ptr, byval ppPropertyTerm as IRichChunk ptr ptr, byval ppOperationTerm as IRichChunk ptr ptr, byval ppValueTerm as IRichChunk ptr ptr) as HRESULT
declare function ICondition_GetInputTerms_Stub(byval This as ICondition ptr, byval ppPropertyTerm as IRichChunk ptr ptr, byval ppOperationTerm as IRichChunk ptr ptr, byval ppValueTerm as IRichChunk ptr ptr) as HRESULT
#define __ICondition2_INTERFACE_DEFINED__
extern IID_ICondition2 as const GUID
type ICondition2 as ICondition2_

type ICondition2Vtbl
	QueryInterface as function(byval This as ICondition2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as ICondition2 ptr) as ULONG
	Release as function(byval This as ICondition2 ptr) as ULONG
	GetClassID as function(byval This as ICondition2 ptr, byval pClassID as CLSID ptr) as HRESULT
	IsDirty as function(byval This as ICondition2 ptr) as HRESULT
	Load as function(byval This as ICondition2 ptr, byval pStm as IStream ptr) as HRESULT
	Save as function(byval This as ICondition2 ptr, byval pStm as IStream ptr, byval fClearDirty as WINBOOL) as HRESULT
	GetSizeMax as function(byval This as ICondition2 ptr, byval pcbSize as ULARGE_INTEGER ptr) as HRESULT
	GetConditionType as function(byval This as ICondition2 ptr, byval pNodeType as CONDITION_TYPE ptr) as HRESULT
	GetSubConditions as function(byval This as ICondition2 ptr, byval riid as const IID const ptr, byval ppv as any ptr ptr) as HRESULT
	GetComparisonInfo as function(byval This as ICondition2 ptr, byval ppszPropertyName as LPWSTR ptr, byval pcop as CONDITION_OPERATION ptr, byval ppropvar as PROPVARIANT ptr) as HRESULT
	GetValueType as function(byval This as ICondition2 ptr, byval ppszValueTypeName as LPWSTR ptr) as HRESULT
	GetValueNormalization as function(byval This as ICondition2 ptr, byval ppszNormalization as LPWSTR ptr) as HRESULT
	GetInputTerms as function(byval This as ICondition2 ptr, byval ppPropertyTerm as IRichChunk ptr ptr, byval ppOperationTerm as IRichChunk ptr ptr, byval ppValueTerm as IRichChunk ptr ptr) as HRESULT
	Clone as function(byval This as ICondition2 ptr, byval ppc as ICondition ptr ptr) as HRESULT
	GetLocale as function(byval This as ICondition2 ptr, byval ppszLocaleName as LPWSTR ptr) as HRESULT
	GetLeafConditionInfo as function(byval This as ICondition2 ptr, byval ppropkey as PROPERTYKEY ptr, byval pcop as CONDITION_OPERATION ptr, byval ppropvar as PROPVARIANT ptr) as HRESULT
end type

type ICondition2_
	lpVtbl as ICondition2Vtbl ptr
end type

#define ICondition2_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define ICondition2_AddRef(This) (This)->lpVtbl->AddRef(This)
#define ICondition2_Release(This) (This)->lpVtbl->Release(This)
#define ICondition2_GetClassID(This, pClassID) (This)->lpVtbl->GetClassID(This, pClassID)
#define ICondition2_IsDirty(This) (This)->lpVtbl->IsDirty(This)
#define ICondition2_Load(This, pStm) (This)->lpVtbl->Load(This, pStm)
#define ICondition2_Save(This, pStm, fClearDirty) (This)->lpVtbl->Save(This, pStm, fClearDirty)
#define ICondition2_GetSizeMax(This, pcbSize) (This)->lpVtbl->GetSizeMax(This, pcbSize)
#define ICondition2_GetConditionType(This, pNodeType) (This)->lpVtbl->GetConditionType(This, pNodeType)
#define ICondition2_GetSubConditions(This, riid, ppv) (This)->lpVtbl->GetSubConditions(This, riid, ppv)
#define ICondition2_GetComparisonInfo(This, ppszPropertyName, pcop, ppropvar) (This)->lpVtbl->GetComparisonInfo(This, ppszPropertyName, pcop, ppropvar)
#define ICondition2_GetValueType(This, ppszValueTypeName) (This)->lpVtbl->GetValueType(This, ppszValueTypeName)
#define ICondition2_GetValueNormalization(This, ppszNormalization) (This)->lpVtbl->GetValueNormalization(This, ppszNormalization)
#define ICondition2_GetInputTerms(This, ppPropertyTerm, ppOperationTerm, ppValueTerm) (This)->lpVtbl->GetInputTerms(This, ppPropertyTerm, ppOperationTerm, ppValueTerm)
#define ICondition2_Clone(This, ppc) (This)->lpVtbl->Clone(This, ppc)
#define ICondition2_GetLocale(This, ppszLocaleName) (This)->lpVtbl->GetLocale(This, ppszLocaleName)
#define ICondition2_GetLeafConditionInfo(This, ppropkey, pcop, ppropvar) (This)->lpVtbl->GetLeafConditionInfo(This, ppropkey, pcop, ppropvar)

declare function ICondition2_GetLocale_Proxy(byval This as ICondition2 ptr, byval ppszLocaleName as LPWSTR ptr) as HRESULT
declare sub ICondition2_GetLocale_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICondition2_RemoteGetLeafConditionInfo_Proxy(byval This as ICondition2 ptr, byval ppropkey as PROPERTYKEY ptr, byval pcop as CONDITION_OPERATION ptr, byval ppropvar as PROPVARIANT ptr) as HRESULT
declare sub ICondition2_RemoteGetLeafConditionInfo_Stub(byval This as IRpcStubBuffer ptr, byval pRpcChannelBuffer as IRpcChannelBuffer ptr, byval pRpcMessage as PRPC_MESSAGE, byval pdwStubPhase as DWORD ptr)
declare function ICondition2_GetLeafConditionInfo_Proxy(byval This as ICondition2 ptr, byval ppropkey as PROPERTYKEY ptr, byval pcop as CONDITION_OPERATION ptr, byval ppropvar as PROPVARIANT ptr) as HRESULT
declare function ICondition2_GetLeafConditionInfo_Stub(byval This as ICondition2 ptr, byval ppropkey as PROPERTYKEY ptr, byval pcop as CONDITION_OPERATION ptr, byval ppropvar as PROPVARIANT ptr) as HRESULT

end extern

#include once "ole-common.bi"
