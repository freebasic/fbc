'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   DISCLAIMER
''   This file has no copyright assigned and is placed in the Public Domain.
''   This file is part of the mingw-w64 runtime package.
''
''   The mingw-w64 runtime package and its code is distributed in the hope that it 
''   will be useful but WITHOUT ANY WARRANTY.  ALL WARRANTIES, EXPRESSED OR 
''   IMPLIED ARE HEREBY DISCLAIMED.  This includes but is not limited to 
''   warranties of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "rpc.bi"
#include once "rpcndr.bi"
#include once "windows.bi"
#include once "ole2.bi"
#include once "unknwn.bi"
#include once "objidl.bi"
#include once "oaidl.bi"

extern "Windows"

#define __msxml_h__
#define __IXMLDOMImplementation_FWD_DEFINED__
#define __IXMLDOMNode_FWD_DEFINED__
#define __IXMLDOMDocumentFragment_FWD_DEFINED__
#define __IXMLDOMDocument_FWD_DEFINED__
#define __IXMLDOMNodeList_FWD_DEFINED__
#define __IXMLDOMNamedNodeMap_FWD_DEFINED__
#define __IXMLDOMCharacterData_FWD_DEFINED__
#define __IXMLDOMAttribute_FWD_DEFINED__
#define __IXMLDOMElement_FWD_DEFINED__
#define __IXMLDOMText_FWD_DEFINED__
#define __IXMLDOMComment_FWD_DEFINED__
#define __IXMLDOMProcessingInstruction_FWD_DEFINED__
#define __IXMLDOMCDATASection_FWD_DEFINED__
#define __IXMLDOMDocumentType_FWD_DEFINED__
#define __IXMLDOMNotation_FWD_DEFINED__
#define __IXMLDOMEntity_FWD_DEFINED__
#define __IXMLDOMEntityReference_FWD_DEFINED__
#define __IXMLDOMParseError_FWD_DEFINED__
#define __IXTLRuntime_FWD_DEFINED__
#define __XMLDOMDocumentEvents_FWD_DEFINED__
#define __DOMDocument_FWD_DEFINED__
#define __DOMFreeThreadedDocument_FWD_DEFINED__
#define __IXMLHttpRequest_FWD_DEFINED__
#define __XMLHTTPRequest_FWD_DEFINED__
#define __IXMLDSOControl_FWD_DEFINED__
#define __XMLDSOControl_FWD_DEFINED__
#define __IXMLElementCollection_FWD_DEFINED__
#define __IXMLDocument_FWD_DEFINED__
#define __IXMLDocument2_FWD_DEFINED__
#define __IXMLElement_FWD_DEFINED__
#define __IXMLElement2_FWD_DEFINED__
#define __IXMLAttribute_FWD_DEFINED__
#define __IXMLError_FWD_DEFINED__
#define __XMLDocument_FWD_DEFINED__

type _xml_error
	_nLine as ulong
	_pchBuf as BSTR
	_cchBuf as ulong
	_ich as ulong
	_pszFound as BSTR
	_pszExpected as BSTR
	_reserved1 as DWORD
	_reserved2 as DWORD
end type

type XML_ERROR as _xml_error
extern __MIDL_itf_msxml_0000_v0_0_c_ifspec as RPC_IF_HANDLE
extern __MIDL_itf_msxml_0000_v0_0_s_ifspec as RPC_IF_HANDLE
#define __MSXML_LIBRARY_DEFINED__

type tagDOMNodeType as long
enum
	NODE_INVALID = 0
	NODE_ELEMENT
	NODE_ATTRIBUTE
	NODE_TEXT
	NODE_CDATA_SECTION
	NODE_ENTITY_REFERENCE
	NODE_ENTITY
	NODE_PROCESSING_INSTRUCTION
	NODE_COMMENT
	NODE_DOCUMENT
	NODE_DOCUMENT_TYPE
	NODE_DOCUMENT_FRAGMENT
	NODE_NOTATION
end enum

type DOMNodeType as tagDOMNodeType

type tagXMLEMEM_TYPE as long
enum
	XMLELEMTYPE_ELEMENT = 0
	XMLELEMTYPE_TEXT
	XMLELEMTYPE_COMMENT
	XMLELEMTYPE_DOCUMENT
	XMLELEMTYPE_DTD
	XMLELEMTYPE_PI
	XMLELEMTYPE_OTHER
end enum

type XMLELEM_TYPE as tagXMLEMEM_TYPE
extern LIBID_MSXML as const IID
#define __IXMLDOMImplementation_INTERFACE_DEFINED__
extern IID_IXMLDOMImplementation as const IID
type IXMLDOMImplementation as IXMLDOMImplementation_

type IXMLDOMImplementationVtbl
	QueryInterface as function(byval This as IXMLDOMImplementation ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IXMLDOMImplementation ptr) as ULONG
	Release as function(byval This as IXMLDOMImplementation ptr) as ULONG
	GetTypeInfoCount as function(byval This as IXMLDOMImplementation ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IXMLDOMImplementation ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IXMLDOMImplementation ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IXMLDOMImplementation ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	hasFeature as function(byval This as IXMLDOMImplementation ptr, byval feature as BSTR, byval version as BSTR, byval hasFeature as VARIANT_BOOL ptr) as HRESULT
end type

type IXMLDOMImplementation_
	lpVtbl as IXMLDOMImplementationVtbl ptr
end type

#define IXMLDOMImplementation_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IXMLDOMImplementation_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IXMLDOMImplementation_Release(This) (This)->lpVtbl->Release(This)
#define IXMLDOMImplementation_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define IXMLDOMImplementation_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define IXMLDOMImplementation_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define IXMLDOMImplementation_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define IXMLDOMImplementation_hasFeature(This, feature, version, hasFeature) (This)->lpVtbl->hasFeature(This, feature, version, hasFeature)
declare function IXMLDOMImplementation_hasFeature_Proxy(byval This as IXMLDOMImplementation ptr, byval feature as BSTR, byval version as BSTR, byval hasFeature as VARIANT_BOOL ptr) as HRESULT
declare sub IXMLDOMImplementation_hasFeature_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IXMLDOMNode_INTERFACE_DEFINED__
extern IID_IXMLDOMNode as const IID

type IXMLDOMNode as IXMLDOMNode_
type IXMLDOMNodeList as IXMLDOMNodeList_
type IXMLDOMNamedNodeMap as IXMLDOMNamedNodeMap_
type IXMLDOMDocument as IXMLDOMDocument_

type IXMLDOMNodeVtbl
	QueryInterface as function(byval This as IXMLDOMNode ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IXMLDOMNode ptr) as ULONG
	Release as function(byval This as IXMLDOMNode ptr) as ULONG
	GetTypeInfoCount as function(byval This as IXMLDOMNode ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IXMLDOMNode ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IXMLDOMNode ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IXMLDOMNode ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	get_nodeName as function(byval This as IXMLDOMNode ptr, byval name as BSTR ptr) as HRESULT
	get_nodeValue as function(byval This as IXMLDOMNode ptr, byval value as VARIANT ptr) as HRESULT
	put_nodeValue as function(byval This as IXMLDOMNode ptr, byval value as VARIANT) as HRESULT
	get_nodeType as function(byval This as IXMLDOMNode ptr, byval type as DOMNodeType ptr) as HRESULT
	get_parentNode as function(byval This as IXMLDOMNode ptr, byval parent as IXMLDOMNode ptr ptr) as HRESULT
	get_childNodes as function(byval This as IXMLDOMNode ptr, byval childList as IXMLDOMNodeList ptr ptr) as HRESULT
	get_firstChild as function(byval This as IXMLDOMNode ptr, byval firstChild as IXMLDOMNode ptr ptr) as HRESULT
	get_lastChild as function(byval This as IXMLDOMNode ptr, byval lastChild as IXMLDOMNode ptr ptr) as HRESULT
	get_previousSibling as function(byval This as IXMLDOMNode ptr, byval previousSibling as IXMLDOMNode ptr ptr) as HRESULT
	get_nextSibling as function(byval This as IXMLDOMNode ptr, byval nextSibling as IXMLDOMNode ptr ptr) as HRESULT
	get_attributes as function(byval This as IXMLDOMNode ptr, byval attributeMap as IXMLDOMNamedNodeMap ptr ptr) as HRESULT
	insertBefore as function(byval This as IXMLDOMNode ptr, byval newChild as IXMLDOMNode ptr, byval refChild as VARIANT, byval outNewChild as IXMLDOMNode ptr ptr) as HRESULT
	replaceChild as function(byval This as IXMLDOMNode ptr, byval newChild as IXMLDOMNode ptr, byval oldChild as IXMLDOMNode ptr, byval outOldChild as IXMLDOMNode ptr ptr) as HRESULT
	removeChild as function(byval This as IXMLDOMNode ptr, byval childNode as IXMLDOMNode ptr, byval oldChild as IXMLDOMNode ptr ptr) as HRESULT
	appendChild as function(byval This as IXMLDOMNode ptr, byval newChild as IXMLDOMNode ptr, byval outNewChild as IXMLDOMNode ptr ptr) as HRESULT
	hasChildNodes as function(byval This as IXMLDOMNode ptr, byval hasChild as VARIANT_BOOL ptr) as HRESULT
	get_ownerDocument as function(byval This as IXMLDOMNode ptr, byval DOMDocument as IXMLDOMDocument ptr ptr) as HRESULT
	cloneNode as function(byval This as IXMLDOMNode ptr, byval deep as VARIANT_BOOL, byval cloneRoot as IXMLDOMNode ptr ptr) as HRESULT
	get_nodeTypeString as function(byval This as IXMLDOMNode ptr, byval nodeType as BSTR ptr) as HRESULT
	get_text as function(byval This as IXMLDOMNode ptr, byval text as BSTR ptr) as HRESULT
	put_text as function(byval This as IXMLDOMNode ptr, byval text as BSTR) as HRESULT
	get_specified as function(byval This as IXMLDOMNode ptr, byval isSpecified as VARIANT_BOOL ptr) as HRESULT
	get_definition as function(byval This as IXMLDOMNode ptr, byval definitionNode as IXMLDOMNode ptr ptr) as HRESULT
	get_nodeTypedValue as function(byval This as IXMLDOMNode ptr, byval typedValue as VARIANT ptr) as HRESULT
	put_nodeTypedValue as function(byval This as IXMLDOMNode ptr, byval typedValue as VARIANT) as HRESULT
	get_dataType as function(byval This as IXMLDOMNode ptr, byval dataTypeName as VARIANT ptr) as HRESULT
	put_dataType as function(byval This as IXMLDOMNode ptr, byval dataTypeName as BSTR) as HRESULT
	get_xml as function(byval This as IXMLDOMNode ptr, byval xmlString as BSTR ptr) as HRESULT
	transformNode as function(byval This as IXMLDOMNode ptr, byval stylesheet as IXMLDOMNode ptr, byval xmlString as BSTR ptr) as HRESULT
	selectNodes as function(byval This as IXMLDOMNode ptr, byval queryString as BSTR, byval resultList as IXMLDOMNodeList ptr ptr) as HRESULT
	selectSingleNode as function(byval This as IXMLDOMNode ptr, byval queryString as BSTR, byval resultNode as IXMLDOMNode ptr ptr) as HRESULT
	get_parsed as function(byval This as IXMLDOMNode ptr, byval isParsed as VARIANT_BOOL ptr) as HRESULT
	get_namespaceURI as function(byval This as IXMLDOMNode ptr, byval namespaceURI as BSTR ptr) as HRESULT
	get_prefix as function(byval This as IXMLDOMNode ptr, byval prefixString as BSTR ptr) as HRESULT
	get_baseName as function(byval This as IXMLDOMNode ptr, byval nameString as BSTR ptr) as HRESULT
	transformNodeToObject as function(byval This as IXMLDOMNode ptr, byval stylesheet as IXMLDOMNode ptr, byval outputObject as VARIANT) as HRESULT
end type

type IXMLDOMNode_
	lpVtbl as IXMLDOMNodeVtbl ptr
end type

#define IXMLDOMNode_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IXMLDOMNode_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IXMLDOMNode_Release(This) (This)->lpVtbl->Release(This)
#define IXMLDOMNode_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define IXMLDOMNode_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define IXMLDOMNode_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define IXMLDOMNode_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define IXMLDOMNode_get_nodeName(This, name) (This)->lpVtbl->get_nodeName(This, name)
#define IXMLDOMNode_get_nodeValue(This, value) (This)->lpVtbl->get_nodeValue(This, value)
#define IXMLDOMNode_put_nodeValue(This, value) (This)->lpVtbl->put_nodeValue(This, value)
#define IXMLDOMNode_get_nodeType(This, type) (This)->lpVtbl->get_nodeType(This, type)
#define IXMLDOMNode_get_parentNode(This, parent) (This)->lpVtbl->get_parentNode(This, parent)
#define IXMLDOMNode_get_childNodes(This, childList) (This)->lpVtbl->get_childNodes(This, childList)
#define IXMLDOMNode_get_firstChild(This, firstChild) (This)->lpVtbl->get_firstChild(This, firstChild)
#define IXMLDOMNode_get_lastChild(This, lastChild) (This)->lpVtbl->get_lastChild(This, lastChild)
#define IXMLDOMNode_get_previousSibling(This, previousSibling) (This)->lpVtbl->get_previousSibling(This, previousSibling)
#define IXMLDOMNode_get_nextSibling(This, nextSibling) (This)->lpVtbl->get_nextSibling(This, nextSibling)
#define IXMLDOMNode_get_attributes(This, attributeMap) (This)->lpVtbl->get_attributes(This, attributeMap)
#define IXMLDOMNode_insertBefore(This, newChild, refChild, outNewChild) (This)->lpVtbl->insertBefore(This, newChild, refChild, outNewChild)
#define IXMLDOMNode_replaceChild(This, newChild, oldChild, outOldChild) (This)->lpVtbl->replaceChild(This, newChild, oldChild, outOldChild)
#define IXMLDOMNode_removeChild(This, childNode, oldChild) (This)->lpVtbl->removeChild(This, childNode, oldChild)
#define IXMLDOMNode_appendChild(This, newChild, outNewChild) (This)->lpVtbl->appendChild(This, newChild, outNewChild)
#define IXMLDOMNode_hasChildNodes(This, hasChild) (This)->lpVtbl->hasChildNodes(This, hasChild)
#define IXMLDOMNode_get_ownerDocument(This, DOMDocument) (This)->lpVtbl->get_ownerDocument(This, DOMDocument)
#define IXMLDOMNode_cloneNode(This, deep, cloneRoot) (This)->lpVtbl->cloneNode(This, deep, cloneRoot)
#define IXMLDOMNode_get_nodeTypeString(This, nodeType) (This)->lpVtbl->get_nodeTypeString(This, nodeType)
#define IXMLDOMNode_get_text(This, text) (This)->lpVtbl->get_text(This, text)
#define IXMLDOMNode_put_text(This, text) (This)->lpVtbl->put_text(This, text)
#define IXMLDOMNode_get_specified(This, isSpecified) (This)->lpVtbl->get_specified(This, isSpecified)
#define IXMLDOMNode_get_definition(This, definitionNode) (This)->lpVtbl->get_definition(This, definitionNode)
#define IXMLDOMNode_get_nodeTypedValue(This, typedValue) (This)->lpVtbl->get_nodeTypedValue(This, typedValue)
#define IXMLDOMNode_put_nodeTypedValue(This, typedValue) (This)->lpVtbl->put_nodeTypedValue(This, typedValue)
#define IXMLDOMNode_get_dataType(This, dataTypeName) (This)->lpVtbl->get_dataType(This, dataTypeName)
#define IXMLDOMNode_put_dataType(This, dataTypeName) (This)->lpVtbl->put_dataType(This, dataTypeName)
#define IXMLDOMNode_get_xml(This, xmlString) (This)->lpVtbl->get_xml(This, xmlString)
#define IXMLDOMNode_transformNode(This, stylesheet, xmlString) (This)->lpVtbl->transformNode(This, stylesheet, xmlString)
#define IXMLDOMNode_selectNodes(This, queryString, resultList) (This)->lpVtbl->selectNodes(This, queryString, resultList)
#define IXMLDOMNode_selectSingleNode(This, queryString, resultNode) (This)->lpVtbl->selectSingleNode(This, queryString, resultNode)
#define IXMLDOMNode_get_parsed(This, isParsed) (This)->lpVtbl->get_parsed(This, isParsed)
#define IXMLDOMNode_get_namespaceURI(This, namespaceURI) (This)->lpVtbl->get_namespaceURI(This, namespaceURI)
#define IXMLDOMNode_get_prefix(This, prefixString) (This)->lpVtbl->get_prefix(This, prefixString)
#define IXMLDOMNode_get_baseName(This, nameString) (This)->lpVtbl->get_baseName(This, nameString)
#define IXMLDOMNode_transformNodeToObject(This, stylesheet, outputObject) (This)->lpVtbl->transformNodeToObject(This, stylesheet, outputObject)

declare function IXMLDOMNode_get_nodeName_Proxy(byval This as IXMLDOMNode ptr, byval name as BSTR ptr) as HRESULT
declare sub IXMLDOMNode_get_nodeName_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMNode_get_nodeValue_Proxy(byval This as IXMLDOMNode ptr, byval value as VARIANT ptr) as HRESULT
declare sub IXMLDOMNode_get_nodeValue_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMNode_put_nodeValue_Proxy(byval This as IXMLDOMNode ptr, byval value as VARIANT) as HRESULT
declare sub IXMLDOMNode_put_nodeValue_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMNode_get_nodeType_Proxy(byval This as IXMLDOMNode ptr, byval type as DOMNodeType ptr) as HRESULT
declare sub IXMLDOMNode_get_nodeType_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMNode_get_parentNode_Proxy(byval This as IXMLDOMNode ptr, byval parent as IXMLDOMNode ptr ptr) as HRESULT
declare sub IXMLDOMNode_get_parentNode_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMNode_get_childNodes_Proxy(byval This as IXMLDOMNode ptr, byval childList as IXMLDOMNodeList ptr ptr) as HRESULT
declare sub IXMLDOMNode_get_childNodes_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMNode_get_firstChild_Proxy(byval This as IXMLDOMNode ptr, byval firstChild as IXMLDOMNode ptr ptr) as HRESULT
declare sub IXMLDOMNode_get_firstChild_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMNode_get_lastChild_Proxy(byval This as IXMLDOMNode ptr, byval lastChild as IXMLDOMNode ptr ptr) as HRESULT
declare sub IXMLDOMNode_get_lastChild_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMNode_get_previousSibling_Proxy(byval This as IXMLDOMNode ptr, byval previousSibling as IXMLDOMNode ptr ptr) as HRESULT
declare sub IXMLDOMNode_get_previousSibling_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMNode_get_nextSibling_Proxy(byval This as IXMLDOMNode ptr, byval nextSibling as IXMLDOMNode ptr ptr) as HRESULT
declare sub IXMLDOMNode_get_nextSibling_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMNode_get_attributes_Proxy(byval This as IXMLDOMNode ptr, byval attributeMap as IXMLDOMNamedNodeMap ptr ptr) as HRESULT
declare sub IXMLDOMNode_get_attributes_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMNode_insertBefore_Proxy(byval This as IXMLDOMNode ptr, byval newChild as IXMLDOMNode ptr, byval refChild as VARIANT, byval outNewChild as IXMLDOMNode ptr ptr) as HRESULT
declare sub IXMLDOMNode_insertBefore_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMNode_replaceChild_Proxy(byval This as IXMLDOMNode ptr, byval newChild as IXMLDOMNode ptr, byval oldChild as IXMLDOMNode ptr, byval outOldChild as IXMLDOMNode ptr ptr) as HRESULT
declare sub IXMLDOMNode_replaceChild_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMNode_removeChild_Proxy(byval This as IXMLDOMNode ptr, byval childNode as IXMLDOMNode ptr, byval oldChild as IXMLDOMNode ptr ptr) as HRESULT
declare sub IXMLDOMNode_removeChild_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMNode_appendChild_Proxy(byval This as IXMLDOMNode ptr, byval newChild as IXMLDOMNode ptr, byval outNewChild as IXMLDOMNode ptr ptr) as HRESULT
declare sub IXMLDOMNode_appendChild_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMNode_hasChildNodes_Proxy(byval This as IXMLDOMNode ptr, byval hasChild as VARIANT_BOOL ptr) as HRESULT
declare sub IXMLDOMNode_hasChildNodes_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMNode_get_ownerDocument_Proxy(byval This as IXMLDOMNode ptr, byval DOMDocument as IXMLDOMDocument ptr ptr) as HRESULT
declare sub IXMLDOMNode_get_ownerDocument_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMNode_cloneNode_Proxy(byval This as IXMLDOMNode ptr, byval deep as VARIANT_BOOL, byval cloneRoot as IXMLDOMNode ptr ptr) as HRESULT
declare sub IXMLDOMNode_cloneNode_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMNode_get_nodeTypeString_Proxy(byval This as IXMLDOMNode ptr, byval nodeType as BSTR ptr) as HRESULT
declare sub IXMLDOMNode_get_nodeTypeString_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMNode_get_text_Proxy(byval This as IXMLDOMNode ptr, byval text as BSTR ptr) as HRESULT
declare sub IXMLDOMNode_get_text_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMNode_put_text_Proxy(byval This as IXMLDOMNode ptr, byval text as BSTR) as HRESULT
declare sub IXMLDOMNode_put_text_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMNode_get_specified_Proxy(byval This as IXMLDOMNode ptr, byval isSpecified as VARIANT_BOOL ptr) as HRESULT
declare sub IXMLDOMNode_get_specified_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMNode_get_definition_Proxy(byval This as IXMLDOMNode ptr, byval definitionNode as IXMLDOMNode ptr ptr) as HRESULT
declare sub IXMLDOMNode_get_definition_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMNode_get_nodeTypedValue_Proxy(byval This as IXMLDOMNode ptr, byval typedValue as VARIANT ptr) as HRESULT
declare sub IXMLDOMNode_get_nodeTypedValue_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMNode_put_nodeTypedValue_Proxy(byval This as IXMLDOMNode ptr, byval typedValue as VARIANT) as HRESULT
declare sub IXMLDOMNode_put_nodeTypedValue_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMNode_get_dataType_Proxy(byval This as IXMLDOMNode ptr, byval dataTypeName as VARIANT ptr) as HRESULT
declare sub IXMLDOMNode_get_dataType_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMNode_put_dataType_Proxy(byval This as IXMLDOMNode ptr, byval dataTypeName as BSTR) as HRESULT
declare sub IXMLDOMNode_put_dataType_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMNode_get_xml_Proxy(byval This as IXMLDOMNode ptr, byval xmlString as BSTR ptr) as HRESULT
declare sub IXMLDOMNode_get_xml_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMNode_transformNode_Proxy(byval This as IXMLDOMNode ptr, byval stylesheet as IXMLDOMNode ptr, byval xmlString as BSTR ptr) as HRESULT
declare sub IXMLDOMNode_transformNode_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMNode_selectNodes_Proxy(byval This as IXMLDOMNode ptr, byval queryString as BSTR, byval resultList as IXMLDOMNodeList ptr ptr) as HRESULT
declare sub IXMLDOMNode_selectNodes_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMNode_selectSingleNode_Proxy(byval This as IXMLDOMNode ptr, byval queryString as BSTR, byval resultNode as IXMLDOMNode ptr ptr) as HRESULT
declare sub IXMLDOMNode_selectSingleNode_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMNode_get_parsed_Proxy(byval This as IXMLDOMNode ptr, byval isParsed as VARIANT_BOOL ptr) as HRESULT
declare sub IXMLDOMNode_get_parsed_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMNode_get_namespaceURI_Proxy(byval This as IXMLDOMNode ptr, byval namespaceURI as BSTR ptr) as HRESULT
declare sub IXMLDOMNode_get_namespaceURI_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMNode_get_prefix_Proxy(byval This as IXMLDOMNode ptr, byval prefixString as BSTR ptr) as HRESULT
declare sub IXMLDOMNode_get_prefix_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMNode_get_baseName_Proxy(byval This as IXMLDOMNode ptr, byval nameString as BSTR ptr) as HRESULT
declare sub IXMLDOMNode_get_baseName_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMNode_transformNodeToObject_Proxy(byval This as IXMLDOMNode ptr, byval stylesheet as IXMLDOMNode ptr, byval outputObject as VARIANT) as HRESULT
declare sub IXMLDOMNode_transformNodeToObject_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IXMLDOMDocumentFragment_INTERFACE_DEFINED__
extern IID_IXMLDOMDocumentFragment as const IID
type IXMLDOMDocumentFragment as IXMLDOMDocumentFragment_

type IXMLDOMDocumentFragmentVtbl
	QueryInterface as function(byval This as IXMLDOMDocumentFragment ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IXMLDOMDocumentFragment ptr) as ULONG
	Release as function(byval This as IXMLDOMDocumentFragment ptr) as ULONG
	GetTypeInfoCount as function(byval This as IXMLDOMDocumentFragment ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IXMLDOMDocumentFragment ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IXMLDOMDocumentFragment ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IXMLDOMDocumentFragment ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	get_nodeName as function(byval This as IXMLDOMDocumentFragment ptr, byval name as BSTR ptr) as HRESULT
	get_nodeValue as function(byval This as IXMLDOMDocumentFragment ptr, byval value as VARIANT ptr) as HRESULT
	put_nodeValue as function(byval This as IXMLDOMDocumentFragment ptr, byval value as VARIANT) as HRESULT
	get_nodeType as function(byval This as IXMLDOMDocumentFragment ptr, byval type as DOMNodeType ptr) as HRESULT
	get_parentNode as function(byval This as IXMLDOMDocumentFragment ptr, byval parent as IXMLDOMNode ptr ptr) as HRESULT
	get_childNodes as function(byval This as IXMLDOMDocumentFragment ptr, byval childList as IXMLDOMNodeList ptr ptr) as HRESULT
	get_firstChild as function(byval This as IXMLDOMDocumentFragment ptr, byval firstChild as IXMLDOMNode ptr ptr) as HRESULT
	get_lastChild as function(byval This as IXMLDOMDocumentFragment ptr, byval lastChild as IXMLDOMNode ptr ptr) as HRESULT
	get_previousSibling as function(byval This as IXMLDOMDocumentFragment ptr, byval previousSibling as IXMLDOMNode ptr ptr) as HRESULT
	get_nextSibling as function(byval This as IXMLDOMDocumentFragment ptr, byval nextSibling as IXMLDOMNode ptr ptr) as HRESULT
	get_attributes as function(byval This as IXMLDOMDocumentFragment ptr, byval attributeMap as IXMLDOMNamedNodeMap ptr ptr) as HRESULT
	insertBefore as function(byval This as IXMLDOMDocumentFragment ptr, byval newChild as IXMLDOMNode ptr, byval refChild as VARIANT, byval outNewChild as IXMLDOMNode ptr ptr) as HRESULT
	replaceChild as function(byval This as IXMLDOMDocumentFragment ptr, byval newChild as IXMLDOMNode ptr, byval oldChild as IXMLDOMNode ptr, byval outOldChild as IXMLDOMNode ptr ptr) as HRESULT
	removeChild as function(byval This as IXMLDOMDocumentFragment ptr, byval childNode as IXMLDOMNode ptr, byval oldChild as IXMLDOMNode ptr ptr) as HRESULT
	appendChild as function(byval This as IXMLDOMDocumentFragment ptr, byval newChild as IXMLDOMNode ptr, byval outNewChild as IXMLDOMNode ptr ptr) as HRESULT
	hasChildNodes as function(byval This as IXMLDOMDocumentFragment ptr, byval hasChild as VARIANT_BOOL ptr) as HRESULT
	get_ownerDocument as function(byval This as IXMLDOMDocumentFragment ptr, byval DOMDocument as IXMLDOMDocument ptr ptr) as HRESULT
	cloneNode as function(byval This as IXMLDOMDocumentFragment ptr, byval deep as VARIANT_BOOL, byval cloneRoot as IXMLDOMNode ptr ptr) as HRESULT
	get_nodeTypeString as function(byval This as IXMLDOMDocumentFragment ptr, byval nodeType as BSTR ptr) as HRESULT
	get_text as function(byval This as IXMLDOMDocumentFragment ptr, byval text as BSTR ptr) as HRESULT
	put_text as function(byval This as IXMLDOMDocumentFragment ptr, byval text as BSTR) as HRESULT
	get_specified as function(byval This as IXMLDOMDocumentFragment ptr, byval isSpecified as VARIANT_BOOL ptr) as HRESULT
	get_definition as function(byval This as IXMLDOMDocumentFragment ptr, byval definitionNode as IXMLDOMNode ptr ptr) as HRESULT
	get_nodeTypedValue as function(byval This as IXMLDOMDocumentFragment ptr, byval typedValue as VARIANT ptr) as HRESULT
	put_nodeTypedValue as function(byval This as IXMLDOMDocumentFragment ptr, byval typedValue as VARIANT) as HRESULT
	get_dataType as function(byval This as IXMLDOMDocumentFragment ptr, byval dataTypeName as VARIANT ptr) as HRESULT
	put_dataType as function(byval This as IXMLDOMDocumentFragment ptr, byval dataTypeName as BSTR) as HRESULT
	get_xml as function(byval This as IXMLDOMDocumentFragment ptr, byval xmlString as BSTR ptr) as HRESULT
	transformNode as function(byval This as IXMLDOMDocumentFragment ptr, byval stylesheet as IXMLDOMNode ptr, byval xmlString as BSTR ptr) as HRESULT
	selectNodes as function(byval This as IXMLDOMDocumentFragment ptr, byval queryString as BSTR, byval resultList as IXMLDOMNodeList ptr ptr) as HRESULT
	selectSingleNode as function(byval This as IXMLDOMDocumentFragment ptr, byval queryString as BSTR, byval resultNode as IXMLDOMNode ptr ptr) as HRESULT
	get_parsed as function(byval This as IXMLDOMDocumentFragment ptr, byval isParsed as VARIANT_BOOL ptr) as HRESULT
	get_namespaceURI as function(byval This as IXMLDOMDocumentFragment ptr, byval namespaceURI as BSTR ptr) as HRESULT
	get_prefix as function(byval This as IXMLDOMDocumentFragment ptr, byval prefixString as BSTR ptr) as HRESULT
	get_baseName as function(byval This as IXMLDOMDocumentFragment ptr, byval nameString as BSTR ptr) as HRESULT
	transformNodeToObject as function(byval This as IXMLDOMDocumentFragment ptr, byval stylesheet as IXMLDOMNode ptr, byval outputObject as VARIANT) as HRESULT
end type

type IXMLDOMDocumentFragment_
	lpVtbl as IXMLDOMDocumentFragmentVtbl ptr
end type

#define IXMLDOMDocumentFragment_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IXMLDOMDocumentFragment_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IXMLDOMDocumentFragment_Release(This) (This)->lpVtbl->Release(This)
#define IXMLDOMDocumentFragment_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define IXMLDOMDocumentFragment_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define IXMLDOMDocumentFragment_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define IXMLDOMDocumentFragment_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define IXMLDOMDocumentFragment_get_nodeName(This, name) (This)->lpVtbl->get_nodeName(This, name)
#define IXMLDOMDocumentFragment_get_nodeValue(This, value) (This)->lpVtbl->get_nodeValue(This, value)
#define IXMLDOMDocumentFragment_put_nodeValue(This, value) (This)->lpVtbl->put_nodeValue(This, value)
#define IXMLDOMDocumentFragment_get_nodeType(This, type) (This)->lpVtbl->get_nodeType(This, type)
#define IXMLDOMDocumentFragment_get_parentNode(This, parent) (This)->lpVtbl->get_parentNode(This, parent)
#define IXMLDOMDocumentFragment_get_childNodes(This, childList) (This)->lpVtbl->get_childNodes(This, childList)
#define IXMLDOMDocumentFragment_get_firstChild(This, firstChild) (This)->lpVtbl->get_firstChild(This, firstChild)
#define IXMLDOMDocumentFragment_get_lastChild(This, lastChild) (This)->lpVtbl->get_lastChild(This, lastChild)
#define IXMLDOMDocumentFragment_get_previousSibling(This, previousSibling) (This)->lpVtbl->get_previousSibling(This, previousSibling)
#define IXMLDOMDocumentFragment_get_nextSibling(This, nextSibling) (This)->lpVtbl->get_nextSibling(This, nextSibling)
#define IXMLDOMDocumentFragment_get_attributes(This, attributeMap) (This)->lpVtbl->get_attributes(This, attributeMap)
#define IXMLDOMDocumentFragment_insertBefore(This, newChild, refChild, outNewChild) (This)->lpVtbl->insertBefore(This, newChild, refChild, outNewChild)
#define IXMLDOMDocumentFragment_replaceChild(This, newChild, oldChild, outOldChild) (This)->lpVtbl->replaceChild(This, newChild, oldChild, outOldChild)
#define IXMLDOMDocumentFragment_removeChild(This, childNode, oldChild) (This)->lpVtbl->removeChild(This, childNode, oldChild)
#define IXMLDOMDocumentFragment_appendChild(This, newChild, outNewChild) (This)->lpVtbl->appendChild(This, newChild, outNewChild)
#define IXMLDOMDocumentFragment_hasChildNodes(This, hasChild) (This)->lpVtbl->hasChildNodes(This, hasChild)
#define IXMLDOMDocumentFragment_get_ownerDocument(This, DOMDocument) (This)->lpVtbl->get_ownerDocument(This, DOMDocument)
#define IXMLDOMDocumentFragment_cloneNode(This, deep, cloneRoot) (This)->lpVtbl->cloneNode(This, deep, cloneRoot)
#define IXMLDOMDocumentFragment_get_nodeTypeString(This, nodeType) (This)->lpVtbl->get_nodeTypeString(This, nodeType)
#define IXMLDOMDocumentFragment_get_text(This, text) (This)->lpVtbl->get_text(This, text)
#define IXMLDOMDocumentFragment_put_text(This, text) (This)->lpVtbl->put_text(This, text)
#define IXMLDOMDocumentFragment_get_specified(This, isSpecified) (This)->lpVtbl->get_specified(This, isSpecified)
#define IXMLDOMDocumentFragment_get_definition(This, definitionNode) (This)->lpVtbl->get_definition(This, definitionNode)
#define IXMLDOMDocumentFragment_get_nodeTypedValue(This, typedValue) (This)->lpVtbl->get_nodeTypedValue(This, typedValue)
#define IXMLDOMDocumentFragment_put_nodeTypedValue(This, typedValue) (This)->lpVtbl->put_nodeTypedValue(This, typedValue)
#define IXMLDOMDocumentFragment_get_dataType(This, dataTypeName) (This)->lpVtbl->get_dataType(This, dataTypeName)
#define IXMLDOMDocumentFragment_put_dataType(This, dataTypeName) (This)->lpVtbl->put_dataType(This, dataTypeName)
#define IXMLDOMDocumentFragment_get_xml(This, xmlString) (This)->lpVtbl->get_xml(This, xmlString)
#define IXMLDOMDocumentFragment_transformNode(This, stylesheet, xmlString) (This)->lpVtbl->transformNode(This, stylesheet, xmlString)
#define IXMLDOMDocumentFragment_selectNodes(This, queryString, resultList) (This)->lpVtbl->selectNodes(This, queryString, resultList)
#define IXMLDOMDocumentFragment_selectSingleNode(This, queryString, resultNode) (This)->lpVtbl->selectSingleNode(This, queryString, resultNode)
#define IXMLDOMDocumentFragment_get_parsed(This, isParsed) (This)->lpVtbl->get_parsed(This, isParsed)
#define IXMLDOMDocumentFragment_get_namespaceURI(This, namespaceURI) (This)->lpVtbl->get_namespaceURI(This, namespaceURI)
#define IXMLDOMDocumentFragment_get_prefix(This, prefixString) (This)->lpVtbl->get_prefix(This, prefixString)
#define IXMLDOMDocumentFragment_get_baseName(This, nameString) (This)->lpVtbl->get_baseName(This, nameString)
#define IXMLDOMDocumentFragment_transformNodeToObject(This, stylesheet, outputObject) (This)->lpVtbl->transformNodeToObject(This, stylesheet, outputObject)
#define __IXMLDOMDocument_INTERFACE_DEFINED__
extern IID_IXMLDOMDocument as const IID

type IXMLDOMDocumentType as IXMLDOMDocumentType_
type IXMLDOMElement as IXMLDOMElement_
type IXMLDOMText as IXMLDOMText_
type IXMLDOMComment as IXMLDOMComment_
type IXMLDOMCDATASection as IXMLDOMCDATASection_
type IXMLDOMProcessingInstruction as IXMLDOMProcessingInstruction_
type IXMLDOMAttribute as IXMLDOMAttribute_
type IXMLDOMEntityReference as IXMLDOMEntityReference_
type IXMLDOMParseError as IXMLDOMParseError_

type IXMLDOMDocumentVtbl
	QueryInterface as function(byval This as IXMLDOMDocument ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IXMLDOMDocument ptr) as ULONG
	Release as function(byval This as IXMLDOMDocument ptr) as ULONG
	GetTypeInfoCount as function(byval This as IXMLDOMDocument ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IXMLDOMDocument ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IXMLDOMDocument ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IXMLDOMDocument ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	get_nodeName as function(byval This as IXMLDOMDocument ptr, byval name as BSTR ptr) as HRESULT
	get_nodeValue as function(byval This as IXMLDOMDocument ptr, byval value as VARIANT ptr) as HRESULT
	put_nodeValue as function(byval This as IXMLDOMDocument ptr, byval value as VARIANT) as HRESULT
	get_nodeType as function(byval This as IXMLDOMDocument ptr, byval type as DOMNodeType ptr) as HRESULT
	get_parentNode as function(byval This as IXMLDOMDocument ptr, byval parent as IXMLDOMNode ptr ptr) as HRESULT
	get_childNodes as function(byval This as IXMLDOMDocument ptr, byval childList as IXMLDOMNodeList ptr ptr) as HRESULT
	get_firstChild as function(byval This as IXMLDOMDocument ptr, byval firstChild as IXMLDOMNode ptr ptr) as HRESULT
	get_lastChild as function(byval This as IXMLDOMDocument ptr, byval lastChild as IXMLDOMNode ptr ptr) as HRESULT
	get_previousSibling as function(byval This as IXMLDOMDocument ptr, byval previousSibling as IXMLDOMNode ptr ptr) as HRESULT
	get_nextSibling as function(byval This as IXMLDOMDocument ptr, byval nextSibling as IXMLDOMNode ptr ptr) as HRESULT
	get_attributes as function(byval This as IXMLDOMDocument ptr, byval attributeMap as IXMLDOMNamedNodeMap ptr ptr) as HRESULT
	insertBefore as function(byval This as IXMLDOMDocument ptr, byval newChild as IXMLDOMNode ptr, byval refChild as VARIANT, byval outNewChild as IXMLDOMNode ptr ptr) as HRESULT
	replaceChild as function(byval This as IXMLDOMDocument ptr, byval newChild as IXMLDOMNode ptr, byval oldChild as IXMLDOMNode ptr, byval outOldChild as IXMLDOMNode ptr ptr) as HRESULT
	removeChild as function(byval This as IXMLDOMDocument ptr, byval childNode as IXMLDOMNode ptr, byval oldChild as IXMLDOMNode ptr ptr) as HRESULT
	appendChild as function(byval This as IXMLDOMDocument ptr, byval newChild as IXMLDOMNode ptr, byval outNewChild as IXMLDOMNode ptr ptr) as HRESULT
	hasChildNodes as function(byval This as IXMLDOMDocument ptr, byval hasChild as VARIANT_BOOL ptr) as HRESULT
	get_ownerDocument as function(byval This as IXMLDOMDocument ptr, byval DOMDocument as IXMLDOMDocument ptr ptr) as HRESULT
	cloneNode as function(byval This as IXMLDOMDocument ptr, byval deep as VARIANT_BOOL, byval cloneRoot as IXMLDOMNode ptr ptr) as HRESULT
	get_nodeTypeString as function(byval This as IXMLDOMDocument ptr, byval nodeType as BSTR ptr) as HRESULT
	get_text as function(byval This as IXMLDOMDocument ptr, byval text as BSTR ptr) as HRESULT
	put_text as function(byval This as IXMLDOMDocument ptr, byval text as BSTR) as HRESULT
	get_specified as function(byval This as IXMLDOMDocument ptr, byval isSpecified as VARIANT_BOOL ptr) as HRESULT
	get_definition as function(byval This as IXMLDOMDocument ptr, byval definitionNode as IXMLDOMNode ptr ptr) as HRESULT
	get_nodeTypedValue as function(byval This as IXMLDOMDocument ptr, byval typedValue as VARIANT ptr) as HRESULT
	put_nodeTypedValue as function(byval This as IXMLDOMDocument ptr, byval typedValue as VARIANT) as HRESULT
	get_dataType as function(byval This as IXMLDOMDocument ptr, byval dataTypeName as VARIANT ptr) as HRESULT
	put_dataType as function(byval This as IXMLDOMDocument ptr, byval dataTypeName as BSTR) as HRESULT
	get_xml as function(byval This as IXMLDOMDocument ptr, byval xmlString as BSTR ptr) as HRESULT
	transformNode as function(byval This as IXMLDOMDocument ptr, byval stylesheet as IXMLDOMNode ptr, byval xmlString as BSTR ptr) as HRESULT
	selectNodes as function(byval This as IXMLDOMDocument ptr, byval queryString as BSTR, byval resultList as IXMLDOMNodeList ptr ptr) as HRESULT
	selectSingleNode as function(byval This as IXMLDOMDocument ptr, byval queryString as BSTR, byval resultNode as IXMLDOMNode ptr ptr) as HRESULT
	get_parsed as function(byval This as IXMLDOMDocument ptr, byval isParsed as VARIANT_BOOL ptr) as HRESULT
	get_namespaceURI as function(byval This as IXMLDOMDocument ptr, byval namespaceURI as BSTR ptr) as HRESULT
	get_prefix as function(byval This as IXMLDOMDocument ptr, byval prefixString as BSTR ptr) as HRESULT
	get_baseName as function(byval This as IXMLDOMDocument ptr, byval nameString as BSTR ptr) as HRESULT
	transformNodeToObject as function(byval This as IXMLDOMDocument ptr, byval stylesheet as IXMLDOMNode ptr, byval outputObject as VARIANT) as HRESULT
	get_doctype as function(byval This as IXMLDOMDocument ptr, byval documentType as IXMLDOMDocumentType ptr ptr) as HRESULT
	get_implementation as function(byval This as IXMLDOMDocument ptr, byval impl as IXMLDOMImplementation ptr ptr) as HRESULT
	get_documentElement as function(byval This as IXMLDOMDocument ptr, byval DOMElement as IXMLDOMElement ptr ptr) as HRESULT
	putref_documentElement as function(byval This as IXMLDOMDocument ptr, byval DOMElement as IXMLDOMElement ptr) as HRESULT
	createElement as function(byval This as IXMLDOMDocument ptr, byval tagName as BSTR, byval element as IXMLDOMElement ptr ptr) as HRESULT
	createDocumentFragment as function(byval This as IXMLDOMDocument ptr, byval docFrag as IXMLDOMDocumentFragment ptr ptr) as HRESULT
	createTextNode as function(byval This as IXMLDOMDocument ptr, byval data as BSTR, byval text as IXMLDOMText ptr ptr) as HRESULT
	createComment as function(byval This as IXMLDOMDocument ptr, byval data as BSTR, byval comment as IXMLDOMComment ptr ptr) as HRESULT
	createCDATASection as function(byval This as IXMLDOMDocument ptr, byval data as BSTR, byval cdata as IXMLDOMCDATASection ptr ptr) as HRESULT
	createProcessingInstruction as function(byval This as IXMLDOMDocument ptr, byval target as BSTR, byval data as BSTR, byval pi as IXMLDOMProcessingInstruction ptr ptr) as HRESULT
	createAttribute as function(byval This as IXMLDOMDocument ptr, byval name as BSTR, byval attribute as IXMLDOMAttribute ptr ptr) as HRESULT
	createEntityReference as function(byval This as IXMLDOMDocument ptr, byval name as BSTR, byval entityRef as IXMLDOMEntityReference ptr ptr) as HRESULT
	getElementsByTagName as function(byval This as IXMLDOMDocument ptr, byval tagName as BSTR, byval resultList as IXMLDOMNodeList ptr ptr) as HRESULT
	createNode as function(byval This as IXMLDOMDocument ptr, byval Type as VARIANT, byval name as BSTR, byval namespaceURI as BSTR, byval node as IXMLDOMNode ptr ptr) as HRESULT
	nodeFromID as function(byval This as IXMLDOMDocument ptr, byval idString as BSTR, byval node as IXMLDOMNode ptr ptr) as HRESULT
	load as function(byval This as IXMLDOMDocument ptr, byval xmlSource as VARIANT, byval isSuccessful as VARIANT_BOOL ptr) as HRESULT
	get_readyState as function(byval This as IXMLDOMDocument ptr, byval value as LONG ptr) as HRESULT
	get_parseError as function(byval This as IXMLDOMDocument ptr, byval errorObj as IXMLDOMParseError ptr ptr) as HRESULT
	get_url as function(byval This as IXMLDOMDocument ptr, byval urlString as BSTR ptr) as HRESULT
	get_async as function(byval This as IXMLDOMDocument ptr, byval isAsync as VARIANT_BOOL ptr) as HRESULT
	put_async as function(byval This as IXMLDOMDocument ptr, byval isAsync as VARIANT_BOOL) as HRESULT
	abort as function(byval This as IXMLDOMDocument ptr) as HRESULT
	loadXML as function(byval This as IXMLDOMDocument ptr, byval bstrXML as BSTR, byval isSuccessful as VARIANT_BOOL ptr) as HRESULT
	save as function(byval This as IXMLDOMDocument ptr, byval destination as VARIANT) as HRESULT
	get_validateOnParse as function(byval This as IXMLDOMDocument ptr, byval isValidating as VARIANT_BOOL ptr) as HRESULT
	put_validateOnParse as function(byval This as IXMLDOMDocument ptr, byval isValidating as VARIANT_BOOL) as HRESULT
	get_resolveExternals as function(byval This as IXMLDOMDocument ptr, byval isResolving as VARIANT_BOOL ptr) as HRESULT
	put_resolveExternals as function(byval This as IXMLDOMDocument ptr, byval isResolving as VARIANT_BOOL) as HRESULT
	get_preserveWhiteSpace as function(byval This as IXMLDOMDocument ptr, byval isPreserving as VARIANT_BOOL ptr) as HRESULT
	put_preserveWhiteSpace as function(byval This as IXMLDOMDocument ptr, byval isPreserving as VARIANT_BOOL) as HRESULT
	put_onreadystatechange as function(byval This as IXMLDOMDocument ptr, byval readystatechangeSink as VARIANT) as HRESULT
	put_ondataavailable as function(byval This as IXMLDOMDocument ptr, byval ondataavailableSink as VARIANT) as HRESULT
	put_ontransformnode as function(byval This as IXMLDOMDocument ptr, byval ontransformnodeSink as VARIANT) as HRESULT
end type

type IXMLDOMDocument_
	lpVtbl as IXMLDOMDocumentVtbl ptr
end type

#define IXMLDOMDocument_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IXMLDOMDocument_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IXMLDOMDocument_Release(This) (This)->lpVtbl->Release(This)
#define IXMLDOMDocument_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define IXMLDOMDocument_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define IXMLDOMDocument_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define IXMLDOMDocument_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define IXMLDOMDocument_get_nodeName(This, name) (This)->lpVtbl->get_nodeName(This, name)
#define IXMLDOMDocument_get_nodeValue(This, value) (This)->lpVtbl->get_nodeValue(This, value)
#define IXMLDOMDocument_put_nodeValue(This, value) (This)->lpVtbl->put_nodeValue(This, value)
#define IXMLDOMDocument_get_nodeType(This, type) (This)->lpVtbl->get_nodeType(This, type)
#define IXMLDOMDocument_get_parentNode(This, parent) (This)->lpVtbl->get_parentNode(This, parent)
#define IXMLDOMDocument_get_childNodes(This, childList) (This)->lpVtbl->get_childNodes(This, childList)
#define IXMLDOMDocument_get_firstChild(This, firstChild) (This)->lpVtbl->get_firstChild(This, firstChild)
#define IXMLDOMDocument_get_lastChild(This, lastChild) (This)->lpVtbl->get_lastChild(This, lastChild)
#define IXMLDOMDocument_get_previousSibling(This, previousSibling) (This)->lpVtbl->get_previousSibling(This, previousSibling)
#define IXMLDOMDocument_get_nextSibling(This, nextSibling) (This)->lpVtbl->get_nextSibling(This, nextSibling)
#define IXMLDOMDocument_get_attributes(This, attributeMap) (This)->lpVtbl->get_attributes(This, attributeMap)
#define IXMLDOMDocument_insertBefore(This, newChild, refChild, outNewChild) (This)->lpVtbl->insertBefore(This, newChild, refChild, outNewChild)
#define IXMLDOMDocument_replaceChild(This, newChild, oldChild, outOldChild) (This)->lpVtbl->replaceChild(This, newChild, oldChild, outOldChild)
#define IXMLDOMDocument_removeChild(This, childNode, oldChild) (This)->lpVtbl->removeChild(This, childNode, oldChild)
#define IXMLDOMDocument_appendChild(This, newChild, outNewChild) (This)->lpVtbl->appendChild(This, newChild, outNewChild)
#define IXMLDOMDocument_hasChildNodes(This, hasChild) (This)->lpVtbl->hasChildNodes(This, hasChild)
#define IXMLDOMDocument_get_ownerDocument(This, DOMDocument) (This)->lpVtbl->get_ownerDocument(This, DOMDocument)
#define IXMLDOMDocument_cloneNode(This, deep, cloneRoot) (This)->lpVtbl->cloneNode(This, deep, cloneRoot)
#define IXMLDOMDocument_get_nodeTypeString(This, nodeType) (This)->lpVtbl->get_nodeTypeString(This, nodeType)
#define IXMLDOMDocument_get_text(This, text) (This)->lpVtbl->get_text(This, text)
#define IXMLDOMDocument_put_text(This, text) (This)->lpVtbl->put_text(This, text)
#define IXMLDOMDocument_get_specified(This, isSpecified) (This)->lpVtbl->get_specified(This, isSpecified)
#define IXMLDOMDocument_get_definition(This, definitionNode) (This)->lpVtbl->get_definition(This, definitionNode)
#define IXMLDOMDocument_get_nodeTypedValue(This, typedValue) (This)->lpVtbl->get_nodeTypedValue(This, typedValue)
#define IXMLDOMDocument_put_nodeTypedValue(This, typedValue) (This)->lpVtbl->put_nodeTypedValue(This, typedValue)
#define IXMLDOMDocument_get_dataType(This, dataTypeName) (This)->lpVtbl->get_dataType(This, dataTypeName)
#define IXMLDOMDocument_put_dataType(This, dataTypeName) (This)->lpVtbl->put_dataType(This, dataTypeName)
#define IXMLDOMDocument_get_xml(This, xmlString) (This)->lpVtbl->get_xml(This, xmlString)
#define IXMLDOMDocument_transformNode(This, stylesheet, xmlString) (This)->lpVtbl->transformNode(This, stylesheet, xmlString)
#define IXMLDOMDocument_selectNodes(This, queryString, resultList) (This)->lpVtbl->selectNodes(This, queryString, resultList)
#define IXMLDOMDocument_selectSingleNode(This, queryString, resultNode) (This)->lpVtbl->selectSingleNode(This, queryString, resultNode)
#define IXMLDOMDocument_get_parsed(This, isParsed) (This)->lpVtbl->get_parsed(This, isParsed)
#define IXMLDOMDocument_get_namespaceURI(This, namespaceURI) (This)->lpVtbl->get_namespaceURI(This, namespaceURI)
#define IXMLDOMDocument_get_prefix(This, prefixString) (This)->lpVtbl->get_prefix(This, prefixString)
#define IXMLDOMDocument_get_baseName(This, nameString) (This)->lpVtbl->get_baseName(This, nameString)
#define IXMLDOMDocument_transformNodeToObject(This, stylesheet, outputObject) (This)->lpVtbl->transformNodeToObject(This, stylesheet, outputObject)
#define IXMLDOMDocument_get_doctype(This, documentType) (This)->lpVtbl->get_doctype(This, documentType)
#define IXMLDOMDocument_get_implementation(This, impl) (This)->lpVtbl->get_implementation(This, impl)
#define IXMLDOMDocument_get_documentElement(This, DOMElement) (This)->lpVtbl->get_documentElement(This, DOMElement)
#define IXMLDOMDocument_putref_documentElement(This, DOMElement) (This)->lpVtbl->putref_documentElement(This, DOMElement)
#define IXMLDOMDocument_createElement(This, tagName, element) (This)->lpVtbl->createElement(This, tagName, element)
#define IXMLDOMDocument_createDocumentFragment(This, docFrag) (This)->lpVtbl->createDocumentFragment(This, docFrag)
#define IXMLDOMDocument_createTextNode(This, data, text) (This)->lpVtbl->createTextNode(This, data, text)
#define IXMLDOMDocument_createComment(This, data, comment) (This)->lpVtbl->createComment(This, data, comment)
#define IXMLDOMDocument_createCDATASection(This, data, cdata) (This)->lpVtbl->createCDATASection(This, data, cdata)
#define IXMLDOMDocument_createProcessingInstruction(This, target, data, pi) (This)->lpVtbl->createProcessingInstruction(This, target, data, pi)
#define IXMLDOMDocument_createAttribute(This, name, attribute) (This)->lpVtbl->createAttribute(This, name, attribute)
#define IXMLDOMDocument_createEntityReference(This, name, entityRef) (This)->lpVtbl->createEntityReference(This, name, entityRef)
#define IXMLDOMDocument_getElementsByTagName(This, tagName, resultList) (This)->lpVtbl->getElementsByTagName(This, tagName, resultList)
#define IXMLDOMDocument_createNode(This, Type, name, namespaceURI, node) (This)->lpVtbl->createNode(This, Type, name, namespaceURI, node)
#define IXMLDOMDocument_nodeFromID(This, idString, node) (This)->lpVtbl->nodeFromID(This, idString, node)
#define IXMLDOMDocument_load(This, xmlSource, isSuccessful) (This)->lpVtbl->load(This, xmlSource, isSuccessful)
#define IXMLDOMDocument_get_readyState(This, value) (This)->lpVtbl->get_readyState(This, value)
#define IXMLDOMDocument_get_parseError(This, errorObj) (This)->lpVtbl->get_parseError(This, errorObj)
#define IXMLDOMDocument_get_url(This, urlString) (This)->lpVtbl->get_url(This, urlString)
#define IXMLDOMDocument_get_async(This, isAsync) (This)->lpVtbl->get_async(This, isAsync)
#define IXMLDOMDocument_put_async(This, isAsync) (This)->lpVtbl->put_async(This, isAsync)
#define IXMLDOMDocument_abort(This) (This)->lpVtbl->abort(This)
#define IXMLDOMDocument_loadXML(This, bstrXML, isSuccessful) (This)->lpVtbl->loadXML(This, bstrXML, isSuccessful)
#define IXMLDOMDocument_save(This, destination) (This)->lpVtbl->save(This, destination)
#define IXMLDOMDocument_get_validateOnParse(This, isValidating) (This)->lpVtbl->get_validateOnParse(This, isValidating)
#define IXMLDOMDocument_put_validateOnParse(This, isValidating) (This)->lpVtbl->put_validateOnParse(This, isValidating)
#define IXMLDOMDocument_get_resolveExternals(This, isResolving) (This)->lpVtbl->get_resolveExternals(This, isResolving)
#define IXMLDOMDocument_put_resolveExternals(This, isResolving) (This)->lpVtbl->put_resolveExternals(This, isResolving)
#define IXMLDOMDocument_get_preserveWhiteSpace(This, isPreserving) (This)->lpVtbl->get_preserveWhiteSpace(This, isPreserving)
#define IXMLDOMDocument_put_preserveWhiteSpace(This, isPreserving) (This)->lpVtbl->put_preserveWhiteSpace(This, isPreserving)
#define IXMLDOMDocument_put_onreadystatechange(This, readystatechangeSink) (This)->lpVtbl->put_onreadystatechange(This, readystatechangeSink)
#define IXMLDOMDocument_put_ondataavailable(This, ondataavailableSink) (This)->lpVtbl->put_ondataavailable(This, ondataavailableSink)
#define IXMLDOMDocument_put_ontransformnode(This, ontransformnodeSink) (This)->lpVtbl->put_ontransformnode(This, ontransformnodeSink)

declare function IXMLDOMDocument_get_doctype_Proxy(byval This as IXMLDOMDocument ptr, byval documentType as IXMLDOMDocumentType ptr ptr) as HRESULT
declare sub IXMLDOMDocument_get_doctype_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMDocument_get_implementation_Proxy(byval This as IXMLDOMDocument ptr, byval impl as IXMLDOMImplementation ptr ptr) as HRESULT
declare sub IXMLDOMDocument_get_implementation_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMDocument_get_documentElement_Proxy(byval This as IXMLDOMDocument ptr, byval DOMElement as IXMLDOMElement ptr ptr) as HRESULT
declare sub IXMLDOMDocument_get_documentElement_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMDocument_putref_documentElement_Proxy(byval This as IXMLDOMDocument ptr, byval DOMElement as IXMLDOMElement ptr) as HRESULT
declare sub IXMLDOMDocument_putref_documentElement_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMDocument_createElement_Proxy(byval This as IXMLDOMDocument ptr, byval tagName as BSTR, byval element as IXMLDOMElement ptr ptr) as HRESULT
declare sub IXMLDOMDocument_createElement_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMDocument_createDocumentFragment_Proxy(byval This as IXMLDOMDocument ptr, byval docFrag as IXMLDOMDocumentFragment ptr ptr) as HRESULT
declare sub IXMLDOMDocument_createDocumentFragment_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMDocument_createTextNode_Proxy(byval This as IXMLDOMDocument ptr, byval data as BSTR, byval text as IXMLDOMText ptr ptr) as HRESULT
declare sub IXMLDOMDocument_createTextNode_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMDocument_createComment_Proxy(byval This as IXMLDOMDocument ptr, byval data as BSTR, byval comment as IXMLDOMComment ptr ptr) as HRESULT
declare sub IXMLDOMDocument_createComment_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMDocument_createCDATASection_Proxy(byval This as IXMLDOMDocument ptr, byval data as BSTR, byval cdata as IXMLDOMCDATASection ptr ptr) as HRESULT
declare sub IXMLDOMDocument_createCDATASection_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMDocument_createProcessingInstruction_Proxy(byval This as IXMLDOMDocument ptr, byval target as BSTR, byval data as BSTR, byval pi as IXMLDOMProcessingInstruction ptr ptr) as HRESULT
declare sub IXMLDOMDocument_createProcessingInstruction_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMDocument_createAttribute_Proxy(byval This as IXMLDOMDocument ptr, byval name as BSTR, byval attribute as IXMLDOMAttribute ptr ptr) as HRESULT
declare sub IXMLDOMDocument_createAttribute_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMDocument_createEntityReference_Proxy(byval This as IXMLDOMDocument ptr, byval name as BSTR, byval entityRef as IXMLDOMEntityReference ptr ptr) as HRESULT
declare sub IXMLDOMDocument_createEntityReference_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMDocument_getElementsByTagName_Proxy(byval This as IXMLDOMDocument ptr, byval tagName as BSTR, byval resultList as IXMLDOMNodeList ptr ptr) as HRESULT
declare sub IXMLDOMDocument_getElementsByTagName_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMDocument_createNode_Proxy(byval This as IXMLDOMDocument ptr, byval Type as VARIANT, byval name as BSTR, byval namespaceURI as BSTR, byval node as IXMLDOMNode ptr ptr) as HRESULT
declare sub IXMLDOMDocument_createNode_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMDocument_nodeFromID_Proxy(byval This as IXMLDOMDocument ptr, byval idString as BSTR, byval node as IXMLDOMNode ptr ptr) as HRESULT
declare sub IXMLDOMDocument_nodeFromID_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMDocument_load_Proxy(byval This as IXMLDOMDocument ptr, byval xmlSource as VARIANT, byval isSuccessful as VARIANT_BOOL ptr) as HRESULT
declare sub IXMLDOMDocument_load_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMDocument_get_readyState_Proxy(byval This as IXMLDOMDocument ptr, byval value as LONG ptr) as HRESULT
declare sub IXMLDOMDocument_get_readyState_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMDocument_get_parseError_Proxy(byval This as IXMLDOMDocument ptr, byval errorObj as IXMLDOMParseError ptr ptr) as HRESULT
declare sub IXMLDOMDocument_get_parseError_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMDocument_get_url_Proxy(byval This as IXMLDOMDocument ptr, byval urlString as BSTR ptr) as HRESULT
declare sub IXMLDOMDocument_get_url_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMDocument_get_async_Proxy(byval This as IXMLDOMDocument ptr, byval isAsync as VARIANT_BOOL ptr) as HRESULT
declare sub IXMLDOMDocument_get_async_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMDocument_put_async_Proxy(byval This as IXMLDOMDocument ptr, byval isAsync as VARIANT_BOOL) as HRESULT
declare sub IXMLDOMDocument_put_async_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMDocument_abort_Proxy(byval This as IXMLDOMDocument ptr) as HRESULT
declare sub IXMLDOMDocument_abort_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMDocument_loadXML_Proxy(byval This as IXMLDOMDocument ptr, byval bstrXML as BSTR, byval isSuccessful as VARIANT_BOOL ptr) as HRESULT
declare sub IXMLDOMDocument_loadXML_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMDocument_save_Proxy(byval This as IXMLDOMDocument ptr, byval destination as VARIANT) as HRESULT
declare sub IXMLDOMDocument_save_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMDocument_get_validateOnParse_Proxy(byval This as IXMLDOMDocument ptr, byval isValidating as VARIANT_BOOL ptr) as HRESULT
declare sub IXMLDOMDocument_get_validateOnParse_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMDocument_put_validateOnParse_Proxy(byval This as IXMLDOMDocument ptr, byval isValidating as VARIANT_BOOL) as HRESULT
declare sub IXMLDOMDocument_put_validateOnParse_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMDocument_get_resolveExternals_Proxy(byval This as IXMLDOMDocument ptr, byval isResolving as VARIANT_BOOL ptr) as HRESULT
declare sub IXMLDOMDocument_get_resolveExternals_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMDocument_put_resolveExternals_Proxy(byval This as IXMLDOMDocument ptr, byval isResolving as VARIANT_BOOL) as HRESULT
declare sub IXMLDOMDocument_put_resolveExternals_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMDocument_get_preserveWhiteSpace_Proxy(byval This as IXMLDOMDocument ptr, byval isPreserving as VARIANT_BOOL ptr) as HRESULT
declare sub IXMLDOMDocument_get_preserveWhiteSpace_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMDocument_put_preserveWhiteSpace_Proxy(byval This as IXMLDOMDocument ptr, byval isPreserving as VARIANT_BOOL) as HRESULT
declare sub IXMLDOMDocument_put_preserveWhiteSpace_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMDocument_put_onreadystatechange_Proxy(byval This as IXMLDOMDocument ptr, byval readystatechangeSink as VARIANT) as HRESULT
declare sub IXMLDOMDocument_put_onreadystatechange_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMDocument_put_ondataavailable_Proxy(byval This as IXMLDOMDocument ptr, byval ondataavailableSink as VARIANT) as HRESULT
declare sub IXMLDOMDocument_put_ondataavailable_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMDocument_put_ontransformnode_Proxy(byval This as IXMLDOMDocument ptr, byval ontransformnodeSink as VARIANT) as HRESULT
declare sub IXMLDOMDocument_put_ontransformnode_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IXMLDOMNodeList_INTERFACE_DEFINED__
extern IID_IXMLDOMNodeList as const IID

type IXMLDOMNodeListVtbl
	QueryInterface as function(byval This as IXMLDOMNodeList ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IXMLDOMNodeList ptr) as ULONG
	Release as function(byval This as IXMLDOMNodeList ptr) as ULONG
	GetTypeInfoCount as function(byval This as IXMLDOMNodeList ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IXMLDOMNodeList ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IXMLDOMNodeList ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IXMLDOMNodeList ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	get_item as function(byval This as IXMLDOMNodeList ptr, byval index as LONG, byval listItem as IXMLDOMNode ptr ptr) as HRESULT
	get_length as function(byval This as IXMLDOMNodeList ptr, byval listLength as LONG ptr) as HRESULT
	nextNode as function(byval This as IXMLDOMNodeList ptr, byval nextItem as IXMLDOMNode ptr ptr) as HRESULT
	reset as function(byval This as IXMLDOMNodeList ptr) as HRESULT
	get__newEnum as function(byval This as IXMLDOMNodeList ptr, byval ppUnk as IUnknown ptr ptr) as HRESULT
end type

type IXMLDOMNodeList_
	lpVtbl as IXMLDOMNodeListVtbl ptr
end type

#define IXMLDOMNodeList_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IXMLDOMNodeList_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IXMLDOMNodeList_Release(This) (This)->lpVtbl->Release(This)
#define IXMLDOMNodeList_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define IXMLDOMNodeList_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define IXMLDOMNodeList_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define IXMLDOMNodeList_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define IXMLDOMNodeList_get_item(This, index, listItem) (This)->lpVtbl->get_item(This, index, listItem)
#define IXMLDOMNodeList_get_length(This, listLength) (This)->lpVtbl->get_length(This, listLength)
#define IXMLDOMNodeList_nextNode(This, nextItem) (This)->lpVtbl->nextNode(This, nextItem)
#define IXMLDOMNodeList_reset(This) (This)->lpVtbl->reset(This)
#define IXMLDOMNodeList_get__newEnum(This, ppUnk) (This)->lpVtbl->get__newEnum(This, ppUnk)

declare function IXMLDOMNodeList_get_item_Proxy(byval This as IXMLDOMNodeList ptr, byval index as LONG, byval listItem as IXMLDOMNode ptr ptr) as HRESULT
declare sub IXMLDOMNodeList_get_item_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMNodeList_get_length_Proxy(byval This as IXMLDOMNodeList ptr, byval listLength as LONG ptr) as HRESULT
declare sub IXMLDOMNodeList_get_length_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMNodeList_nextNode_Proxy(byval This as IXMLDOMNodeList ptr, byval nextItem as IXMLDOMNode ptr ptr) as HRESULT
declare sub IXMLDOMNodeList_nextNode_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMNodeList_reset_Proxy(byval This as IXMLDOMNodeList ptr) as HRESULT
declare sub IXMLDOMNodeList_reset_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMNodeList_get__newEnum_Proxy(byval This as IXMLDOMNodeList ptr, byval ppUnk as IUnknown ptr ptr) as HRESULT
declare sub IXMLDOMNodeList_get__newEnum_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IXMLDOMNamedNodeMap_INTERFACE_DEFINED__
extern IID_IXMLDOMNamedNodeMap as const IID

type IXMLDOMNamedNodeMapVtbl
	QueryInterface as function(byval This as IXMLDOMNamedNodeMap ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IXMLDOMNamedNodeMap ptr) as ULONG
	Release as function(byval This as IXMLDOMNamedNodeMap ptr) as ULONG
	GetTypeInfoCount as function(byval This as IXMLDOMNamedNodeMap ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IXMLDOMNamedNodeMap ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IXMLDOMNamedNodeMap ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IXMLDOMNamedNodeMap ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	getNamedItem as function(byval This as IXMLDOMNamedNodeMap ptr, byval name as BSTR, byval namedItem as IXMLDOMNode ptr ptr) as HRESULT
	setNamedItem as function(byval This as IXMLDOMNamedNodeMap ptr, byval newItem as IXMLDOMNode ptr, byval nameItem as IXMLDOMNode ptr ptr) as HRESULT
	removeNamedItem as function(byval This as IXMLDOMNamedNodeMap ptr, byval name as BSTR, byval namedItem as IXMLDOMNode ptr ptr) as HRESULT
	get_item as function(byval This as IXMLDOMNamedNodeMap ptr, byval index as LONG, byval listItem as IXMLDOMNode ptr ptr) as HRESULT
	get_length as function(byval This as IXMLDOMNamedNodeMap ptr, byval listLength as LONG ptr) as HRESULT
	getQualifiedItem as function(byval This as IXMLDOMNamedNodeMap ptr, byval baseName as BSTR, byval namespaceURI as BSTR, byval qualifiedItem as IXMLDOMNode ptr ptr) as HRESULT
	removeQualifiedItem as function(byval This as IXMLDOMNamedNodeMap ptr, byval baseName as BSTR, byval namespaceURI as BSTR, byval qualifiedItem as IXMLDOMNode ptr ptr) as HRESULT
	nextNode as function(byval This as IXMLDOMNamedNodeMap ptr, byval nextItem as IXMLDOMNode ptr ptr) as HRESULT
	reset as function(byval This as IXMLDOMNamedNodeMap ptr) as HRESULT
	get__newEnum as function(byval This as IXMLDOMNamedNodeMap ptr, byval ppUnk as IUnknown ptr ptr) as HRESULT
end type

type IXMLDOMNamedNodeMap_
	lpVtbl as IXMLDOMNamedNodeMapVtbl ptr
end type

#define IXMLDOMNamedNodeMap_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IXMLDOMNamedNodeMap_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IXMLDOMNamedNodeMap_Release(This) (This)->lpVtbl->Release(This)
#define IXMLDOMNamedNodeMap_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define IXMLDOMNamedNodeMap_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define IXMLDOMNamedNodeMap_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define IXMLDOMNamedNodeMap_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define IXMLDOMNamedNodeMap_getNamedItem(This, name, namedItem) (This)->lpVtbl->getNamedItem(This, name, namedItem)
#define IXMLDOMNamedNodeMap_setNamedItem(This, newItem, nameItem) (This)->lpVtbl->setNamedItem(This, newItem, nameItem)
#define IXMLDOMNamedNodeMap_removeNamedItem(This, name, namedItem) (This)->lpVtbl->removeNamedItem(This, name, namedItem)
#define IXMLDOMNamedNodeMap_get_item(This, index, listItem) (This)->lpVtbl->get_item(This, index, listItem)
#define IXMLDOMNamedNodeMap_get_length(This, listLength) (This)->lpVtbl->get_length(This, listLength)
#define IXMLDOMNamedNodeMap_getQualifiedItem(This, baseName, namespaceURI, qualifiedItem) (This)->lpVtbl->getQualifiedItem(This, baseName, namespaceURI, qualifiedItem)
#define IXMLDOMNamedNodeMap_removeQualifiedItem(This, baseName, namespaceURI, qualifiedItem) (This)->lpVtbl->removeQualifiedItem(This, baseName, namespaceURI, qualifiedItem)
#define IXMLDOMNamedNodeMap_nextNode(This, nextItem) (This)->lpVtbl->nextNode(This, nextItem)
#define IXMLDOMNamedNodeMap_reset(This) (This)->lpVtbl->reset(This)
#define IXMLDOMNamedNodeMap_get__newEnum(This, ppUnk) (This)->lpVtbl->get__newEnum(This, ppUnk)

declare function IXMLDOMNamedNodeMap_getNamedItem_Proxy(byval This as IXMLDOMNamedNodeMap ptr, byval name as BSTR, byval namedItem as IXMLDOMNode ptr ptr) as HRESULT
declare sub IXMLDOMNamedNodeMap_getNamedItem_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMNamedNodeMap_setNamedItem_Proxy(byval This as IXMLDOMNamedNodeMap ptr, byval newItem as IXMLDOMNode ptr, byval nameItem as IXMLDOMNode ptr ptr) as HRESULT
declare sub IXMLDOMNamedNodeMap_setNamedItem_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMNamedNodeMap_removeNamedItem_Proxy(byval This as IXMLDOMNamedNodeMap ptr, byval name as BSTR, byval namedItem as IXMLDOMNode ptr ptr) as HRESULT
declare sub IXMLDOMNamedNodeMap_removeNamedItem_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMNamedNodeMap_get_item_Proxy(byval This as IXMLDOMNamedNodeMap ptr, byval index as LONG, byval listItem as IXMLDOMNode ptr ptr) as HRESULT
declare sub IXMLDOMNamedNodeMap_get_item_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMNamedNodeMap_get_length_Proxy(byval This as IXMLDOMNamedNodeMap ptr, byval listLength as LONG ptr) as HRESULT
declare sub IXMLDOMNamedNodeMap_get_length_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMNamedNodeMap_getQualifiedItem_Proxy(byval This as IXMLDOMNamedNodeMap ptr, byval baseName as BSTR, byval namespaceURI as BSTR, byval qualifiedItem as IXMLDOMNode ptr ptr) as HRESULT
declare sub IXMLDOMNamedNodeMap_getQualifiedItem_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMNamedNodeMap_removeQualifiedItem_Proxy(byval This as IXMLDOMNamedNodeMap ptr, byval baseName as BSTR, byval namespaceURI as BSTR, byval qualifiedItem as IXMLDOMNode ptr ptr) as HRESULT
declare sub IXMLDOMNamedNodeMap_removeQualifiedItem_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMNamedNodeMap_nextNode_Proxy(byval This as IXMLDOMNamedNodeMap ptr, byval nextItem as IXMLDOMNode ptr ptr) as HRESULT
declare sub IXMLDOMNamedNodeMap_nextNode_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMNamedNodeMap_reset_Proxy(byval This as IXMLDOMNamedNodeMap ptr) as HRESULT
declare sub IXMLDOMNamedNodeMap_reset_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMNamedNodeMap_get__newEnum_Proxy(byval This as IXMLDOMNamedNodeMap ptr, byval ppUnk as IUnknown ptr ptr) as HRESULT
declare sub IXMLDOMNamedNodeMap_get__newEnum_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IXMLDOMCharacterData_INTERFACE_DEFINED__
extern IID_IXMLDOMCharacterData as const IID
type IXMLDOMCharacterData as IXMLDOMCharacterData_

type IXMLDOMCharacterDataVtbl
	QueryInterface as function(byval This as IXMLDOMCharacterData ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IXMLDOMCharacterData ptr) as ULONG
	Release as function(byval This as IXMLDOMCharacterData ptr) as ULONG
	GetTypeInfoCount as function(byval This as IXMLDOMCharacterData ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IXMLDOMCharacterData ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IXMLDOMCharacterData ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IXMLDOMCharacterData ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	get_nodeName as function(byval This as IXMLDOMCharacterData ptr, byval name as BSTR ptr) as HRESULT
	get_nodeValue as function(byval This as IXMLDOMCharacterData ptr, byval value as VARIANT ptr) as HRESULT
	put_nodeValue as function(byval This as IXMLDOMCharacterData ptr, byval value as VARIANT) as HRESULT
	get_nodeType as function(byval This as IXMLDOMCharacterData ptr, byval type as DOMNodeType ptr) as HRESULT
	get_parentNode as function(byval This as IXMLDOMCharacterData ptr, byval parent as IXMLDOMNode ptr ptr) as HRESULT
	get_childNodes as function(byval This as IXMLDOMCharacterData ptr, byval childList as IXMLDOMNodeList ptr ptr) as HRESULT
	get_firstChild as function(byval This as IXMLDOMCharacterData ptr, byval firstChild as IXMLDOMNode ptr ptr) as HRESULT
	get_lastChild as function(byval This as IXMLDOMCharacterData ptr, byval lastChild as IXMLDOMNode ptr ptr) as HRESULT
	get_previousSibling as function(byval This as IXMLDOMCharacterData ptr, byval previousSibling as IXMLDOMNode ptr ptr) as HRESULT
	get_nextSibling as function(byval This as IXMLDOMCharacterData ptr, byval nextSibling as IXMLDOMNode ptr ptr) as HRESULT
	get_attributes as function(byval This as IXMLDOMCharacterData ptr, byval attributeMap as IXMLDOMNamedNodeMap ptr ptr) as HRESULT
	insertBefore as function(byval This as IXMLDOMCharacterData ptr, byval newChild as IXMLDOMNode ptr, byval refChild as VARIANT, byval outNewChild as IXMLDOMNode ptr ptr) as HRESULT
	replaceChild as function(byval This as IXMLDOMCharacterData ptr, byval newChild as IXMLDOMNode ptr, byval oldChild as IXMLDOMNode ptr, byval outOldChild as IXMLDOMNode ptr ptr) as HRESULT
	removeChild as function(byval This as IXMLDOMCharacterData ptr, byval childNode as IXMLDOMNode ptr, byval oldChild as IXMLDOMNode ptr ptr) as HRESULT
	appendChild as function(byval This as IXMLDOMCharacterData ptr, byval newChild as IXMLDOMNode ptr, byval outNewChild as IXMLDOMNode ptr ptr) as HRESULT
	hasChildNodes as function(byval This as IXMLDOMCharacterData ptr, byval hasChild as VARIANT_BOOL ptr) as HRESULT
	get_ownerDocument as function(byval This as IXMLDOMCharacterData ptr, byval DOMDocument as IXMLDOMDocument ptr ptr) as HRESULT
	cloneNode as function(byval This as IXMLDOMCharacterData ptr, byval deep as VARIANT_BOOL, byval cloneRoot as IXMLDOMNode ptr ptr) as HRESULT
	get_nodeTypeString as function(byval This as IXMLDOMCharacterData ptr, byval nodeType as BSTR ptr) as HRESULT
	get_text as function(byval This as IXMLDOMCharacterData ptr, byval text as BSTR ptr) as HRESULT
	put_text as function(byval This as IXMLDOMCharacterData ptr, byval text as BSTR) as HRESULT
	get_specified as function(byval This as IXMLDOMCharacterData ptr, byval isSpecified as VARIANT_BOOL ptr) as HRESULT
	get_definition as function(byval This as IXMLDOMCharacterData ptr, byval definitionNode as IXMLDOMNode ptr ptr) as HRESULT
	get_nodeTypedValue as function(byval This as IXMLDOMCharacterData ptr, byval typedValue as VARIANT ptr) as HRESULT
	put_nodeTypedValue as function(byval This as IXMLDOMCharacterData ptr, byval typedValue as VARIANT) as HRESULT
	get_dataType as function(byval This as IXMLDOMCharacterData ptr, byval dataTypeName as VARIANT ptr) as HRESULT
	put_dataType as function(byval This as IXMLDOMCharacterData ptr, byval dataTypeName as BSTR) as HRESULT
	get_xml as function(byval This as IXMLDOMCharacterData ptr, byval xmlString as BSTR ptr) as HRESULT
	transformNode as function(byval This as IXMLDOMCharacterData ptr, byval stylesheet as IXMLDOMNode ptr, byval xmlString as BSTR ptr) as HRESULT
	selectNodes as function(byval This as IXMLDOMCharacterData ptr, byval queryString as BSTR, byval resultList as IXMLDOMNodeList ptr ptr) as HRESULT
	selectSingleNode as function(byval This as IXMLDOMCharacterData ptr, byval queryString as BSTR, byval resultNode as IXMLDOMNode ptr ptr) as HRESULT
	get_parsed as function(byval This as IXMLDOMCharacterData ptr, byval isParsed as VARIANT_BOOL ptr) as HRESULT
	get_namespaceURI as function(byval This as IXMLDOMCharacterData ptr, byval namespaceURI as BSTR ptr) as HRESULT
	get_prefix as function(byval This as IXMLDOMCharacterData ptr, byval prefixString as BSTR ptr) as HRESULT
	get_baseName as function(byval This as IXMLDOMCharacterData ptr, byval nameString as BSTR ptr) as HRESULT
	transformNodeToObject as function(byval This as IXMLDOMCharacterData ptr, byval stylesheet as IXMLDOMNode ptr, byval outputObject as VARIANT) as HRESULT
	get_data as function(byval This as IXMLDOMCharacterData ptr, byval data as BSTR ptr) as HRESULT
	put_data as function(byval This as IXMLDOMCharacterData ptr, byval data as BSTR) as HRESULT
	get_length as function(byval This as IXMLDOMCharacterData ptr, byval dataLength as LONG ptr) as HRESULT
	substringData as function(byval This as IXMLDOMCharacterData ptr, byval offset as LONG, byval count as LONG, byval data as BSTR ptr) as HRESULT
	appendData as function(byval This as IXMLDOMCharacterData ptr, byval data as BSTR) as HRESULT
	insertData as function(byval This as IXMLDOMCharacterData ptr, byval offset as LONG, byval data as BSTR) as HRESULT
	deleteData as function(byval This as IXMLDOMCharacterData ptr, byval offset as LONG, byval count as LONG) as HRESULT
	replaceData as function(byval This as IXMLDOMCharacterData ptr, byval offset as LONG, byval count as LONG, byval data as BSTR) as HRESULT
end type

type IXMLDOMCharacterData_
	lpVtbl as IXMLDOMCharacterDataVtbl ptr
end type

#define IXMLDOMCharacterData_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IXMLDOMCharacterData_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IXMLDOMCharacterData_Release(This) (This)->lpVtbl->Release(This)
#define IXMLDOMCharacterData_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define IXMLDOMCharacterData_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define IXMLDOMCharacterData_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define IXMLDOMCharacterData_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define IXMLDOMCharacterData_get_nodeName(This, name) (This)->lpVtbl->get_nodeName(This, name)
#define IXMLDOMCharacterData_get_nodeValue(This, value) (This)->lpVtbl->get_nodeValue(This, value)
#define IXMLDOMCharacterData_put_nodeValue(This, value) (This)->lpVtbl->put_nodeValue(This, value)
#define IXMLDOMCharacterData_get_nodeType(This, type) (This)->lpVtbl->get_nodeType(This, type)
#define IXMLDOMCharacterData_get_parentNode(This, parent) (This)->lpVtbl->get_parentNode(This, parent)
#define IXMLDOMCharacterData_get_childNodes(This, childList) (This)->lpVtbl->get_childNodes(This, childList)
#define IXMLDOMCharacterData_get_firstChild(This, firstChild) (This)->lpVtbl->get_firstChild(This, firstChild)
#define IXMLDOMCharacterData_get_lastChild(This, lastChild) (This)->lpVtbl->get_lastChild(This, lastChild)
#define IXMLDOMCharacterData_get_previousSibling(This, previousSibling) (This)->lpVtbl->get_previousSibling(This, previousSibling)
#define IXMLDOMCharacterData_get_nextSibling(This, nextSibling) (This)->lpVtbl->get_nextSibling(This, nextSibling)
#define IXMLDOMCharacterData_get_attributes(This, attributeMap) (This)->lpVtbl->get_attributes(This, attributeMap)
#define IXMLDOMCharacterData_insertBefore(This, newChild, refChild, outNewChild) (This)->lpVtbl->insertBefore(This, newChild, refChild, outNewChild)
#define IXMLDOMCharacterData_replaceChild(This, newChild, oldChild, outOldChild) (This)->lpVtbl->replaceChild(This, newChild, oldChild, outOldChild)
#define IXMLDOMCharacterData_removeChild(This, childNode, oldChild) (This)->lpVtbl->removeChild(This, childNode, oldChild)
#define IXMLDOMCharacterData_appendChild(This, newChild, outNewChild) (This)->lpVtbl->appendChild(This, newChild, outNewChild)
#define IXMLDOMCharacterData_hasChildNodes(This, hasChild) (This)->lpVtbl->hasChildNodes(This, hasChild)
#define IXMLDOMCharacterData_get_ownerDocument(This, DOMDocument) (This)->lpVtbl->get_ownerDocument(This, DOMDocument)
#define IXMLDOMCharacterData_cloneNode(This, deep, cloneRoot) (This)->lpVtbl->cloneNode(This, deep, cloneRoot)
#define IXMLDOMCharacterData_get_nodeTypeString(This, nodeType) (This)->lpVtbl->get_nodeTypeString(This, nodeType)
#define IXMLDOMCharacterData_get_text(This, text) (This)->lpVtbl->get_text(This, text)
#define IXMLDOMCharacterData_put_text(This, text) (This)->lpVtbl->put_text(This, text)
#define IXMLDOMCharacterData_get_specified(This, isSpecified) (This)->lpVtbl->get_specified(This, isSpecified)
#define IXMLDOMCharacterData_get_definition(This, definitionNode) (This)->lpVtbl->get_definition(This, definitionNode)
#define IXMLDOMCharacterData_get_nodeTypedValue(This, typedValue) (This)->lpVtbl->get_nodeTypedValue(This, typedValue)
#define IXMLDOMCharacterData_put_nodeTypedValue(This, typedValue) (This)->lpVtbl->put_nodeTypedValue(This, typedValue)
#define IXMLDOMCharacterData_get_dataType(This, dataTypeName) (This)->lpVtbl->get_dataType(This, dataTypeName)
#define IXMLDOMCharacterData_put_dataType(This, dataTypeName) (This)->lpVtbl->put_dataType(This, dataTypeName)
#define IXMLDOMCharacterData_get_xml(This, xmlString) (This)->lpVtbl->get_xml(This, xmlString)
#define IXMLDOMCharacterData_transformNode(This, stylesheet, xmlString) (This)->lpVtbl->transformNode(This, stylesheet, xmlString)
#define IXMLDOMCharacterData_selectNodes(This, queryString, resultList) (This)->lpVtbl->selectNodes(This, queryString, resultList)
#define IXMLDOMCharacterData_selectSingleNode(This, queryString, resultNode) (This)->lpVtbl->selectSingleNode(This, queryString, resultNode)
#define IXMLDOMCharacterData_get_parsed(This, isParsed) (This)->lpVtbl->get_parsed(This, isParsed)
#define IXMLDOMCharacterData_get_namespaceURI(This, namespaceURI) (This)->lpVtbl->get_namespaceURI(This, namespaceURI)
#define IXMLDOMCharacterData_get_prefix(This, prefixString) (This)->lpVtbl->get_prefix(This, prefixString)
#define IXMLDOMCharacterData_get_baseName(This, nameString) (This)->lpVtbl->get_baseName(This, nameString)
#define IXMLDOMCharacterData_transformNodeToObject(This, stylesheet, outputObject) (This)->lpVtbl->transformNodeToObject(This, stylesheet, outputObject)
#define IXMLDOMCharacterData_get_data(This, data) (This)->lpVtbl->get_data(This, data)
#define IXMLDOMCharacterData_put_data(This, data) (This)->lpVtbl->put_data(This, data)
#define IXMLDOMCharacterData_get_length(This, dataLength) (This)->lpVtbl->get_length(This, dataLength)
#define IXMLDOMCharacterData_substringData(This, offset, count, data) (This)->lpVtbl->substringData(This, offset, count, data)
#define IXMLDOMCharacterData_appendData(This, data) (This)->lpVtbl->appendData(This, data)
#define IXMLDOMCharacterData_insertData(This, offset, data) (This)->lpVtbl->insertData(This, offset, data)
#define IXMLDOMCharacterData_deleteData(This, offset, count) (This)->lpVtbl->deleteData(This, offset, count)
#define IXMLDOMCharacterData_replaceData(This, offset, count, data) (This)->lpVtbl->replaceData(This, offset, count, data)

declare function IXMLDOMCharacterData_get_data_Proxy(byval This as IXMLDOMCharacterData ptr, byval data as BSTR ptr) as HRESULT
declare sub IXMLDOMCharacterData_get_data_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMCharacterData_put_data_Proxy(byval This as IXMLDOMCharacterData ptr, byval data as BSTR) as HRESULT
declare sub IXMLDOMCharacterData_put_data_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMCharacterData_get_length_Proxy(byval This as IXMLDOMCharacterData ptr, byval dataLength as LONG ptr) as HRESULT
declare sub IXMLDOMCharacterData_get_length_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMCharacterData_substringData_Proxy(byval This as IXMLDOMCharacterData ptr, byval offset as LONG, byval count as LONG, byval data as BSTR ptr) as HRESULT
declare sub IXMLDOMCharacterData_substringData_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMCharacterData_appendData_Proxy(byval This as IXMLDOMCharacterData ptr, byval data as BSTR) as HRESULT
declare sub IXMLDOMCharacterData_appendData_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMCharacterData_insertData_Proxy(byval This as IXMLDOMCharacterData ptr, byval offset as LONG, byval data as BSTR) as HRESULT
declare sub IXMLDOMCharacterData_insertData_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMCharacterData_deleteData_Proxy(byval This as IXMLDOMCharacterData ptr, byval offset as LONG, byval count as LONG) as HRESULT
declare sub IXMLDOMCharacterData_deleteData_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMCharacterData_replaceData_Proxy(byval This as IXMLDOMCharacterData ptr, byval offset as LONG, byval count as LONG, byval data as BSTR) as HRESULT
declare sub IXMLDOMCharacterData_replaceData_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IXMLDOMAttribute_INTERFACE_DEFINED__
extern IID_IXMLDOMAttribute as const IID

type IXMLDOMAttributeVtbl
	QueryInterface as function(byval This as IXMLDOMAttribute ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IXMLDOMAttribute ptr) as ULONG
	Release as function(byval This as IXMLDOMAttribute ptr) as ULONG
	GetTypeInfoCount as function(byval This as IXMLDOMAttribute ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IXMLDOMAttribute ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IXMLDOMAttribute ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IXMLDOMAttribute ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	get_nodeName as function(byval This as IXMLDOMAttribute ptr, byval name as BSTR ptr) as HRESULT
	get_nodeValue as function(byval This as IXMLDOMAttribute ptr, byval value as VARIANT ptr) as HRESULT
	put_nodeValue as function(byval This as IXMLDOMAttribute ptr, byval value as VARIANT) as HRESULT
	get_nodeType as function(byval This as IXMLDOMAttribute ptr, byval type as DOMNodeType ptr) as HRESULT
	get_parentNode as function(byval This as IXMLDOMAttribute ptr, byval parent as IXMLDOMNode ptr ptr) as HRESULT
	get_childNodes as function(byval This as IXMLDOMAttribute ptr, byval childList as IXMLDOMNodeList ptr ptr) as HRESULT
	get_firstChild as function(byval This as IXMLDOMAttribute ptr, byval firstChild as IXMLDOMNode ptr ptr) as HRESULT
	get_lastChild as function(byval This as IXMLDOMAttribute ptr, byval lastChild as IXMLDOMNode ptr ptr) as HRESULT
	get_previousSibling as function(byval This as IXMLDOMAttribute ptr, byval previousSibling as IXMLDOMNode ptr ptr) as HRESULT
	get_nextSibling as function(byval This as IXMLDOMAttribute ptr, byval nextSibling as IXMLDOMNode ptr ptr) as HRESULT
	get_attributes as function(byval This as IXMLDOMAttribute ptr, byval attributeMap as IXMLDOMNamedNodeMap ptr ptr) as HRESULT
	insertBefore as function(byval This as IXMLDOMAttribute ptr, byval newChild as IXMLDOMNode ptr, byval refChild as VARIANT, byval outNewChild as IXMLDOMNode ptr ptr) as HRESULT
	replaceChild as function(byval This as IXMLDOMAttribute ptr, byval newChild as IXMLDOMNode ptr, byval oldChild as IXMLDOMNode ptr, byval outOldChild as IXMLDOMNode ptr ptr) as HRESULT
	removeChild as function(byval This as IXMLDOMAttribute ptr, byval childNode as IXMLDOMNode ptr, byval oldChild as IXMLDOMNode ptr ptr) as HRESULT
	appendChild as function(byval This as IXMLDOMAttribute ptr, byval newChild as IXMLDOMNode ptr, byval outNewChild as IXMLDOMNode ptr ptr) as HRESULT
	hasChildNodes as function(byval This as IXMLDOMAttribute ptr, byval hasChild as VARIANT_BOOL ptr) as HRESULT
	get_ownerDocument as function(byval This as IXMLDOMAttribute ptr, byval DOMDocument as IXMLDOMDocument ptr ptr) as HRESULT
	cloneNode as function(byval This as IXMLDOMAttribute ptr, byval deep as VARIANT_BOOL, byval cloneRoot as IXMLDOMNode ptr ptr) as HRESULT
	get_nodeTypeString as function(byval This as IXMLDOMAttribute ptr, byval nodeType as BSTR ptr) as HRESULT
	get_text as function(byval This as IXMLDOMAttribute ptr, byval text as BSTR ptr) as HRESULT
	put_text as function(byval This as IXMLDOMAttribute ptr, byval text as BSTR) as HRESULT
	get_specified as function(byval This as IXMLDOMAttribute ptr, byval isSpecified as VARIANT_BOOL ptr) as HRESULT
	get_definition as function(byval This as IXMLDOMAttribute ptr, byval definitionNode as IXMLDOMNode ptr ptr) as HRESULT
	get_nodeTypedValue as function(byval This as IXMLDOMAttribute ptr, byval typedValue as VARIANT ptr) as HRESULT
	put_nodeTypedValue as function(byval This as IXMLDOMAttribute ptr, byval typedValue as VARIANT) as HRESULT
	get_dataType as function(byval This as IXMLDOMAttribute ptr, byval dataTypeName as VARIANT ptr) as HRESULT
	put_dataType as function(byval This as IXMLDOMAttribute ptr, byval dataTypeName as BSTR) as HRESULT
	get_xml as function(byval This as IXMLDOMAttribute ptr, byval xmlString as BSTR ptr) as HRESULT
	transformNode as function(byval This as IXMLDOMAttribute ptr, byval stylesheet as IXMLDOMNode ptr, byval xmlString as BSTR ptr) as HRESULT
	selectNodes as function(byval This as IXMLDOMAttribute ptr, byval queryString as BSTR, byval resultList as IXMLDOMNodeList ptr ptr) as HRESULT
	selectSingleNode as function(byval This as IXMLDOMAttribute ptr, byval queryString as BSTR, byval resultNode as IXMLDOMNode ptr ptr) as HRESULT
	get_parsed as function(byval This as IXMLDOMAttribute ptr, byval isParsed as VARIANT_BOOL ptr) as HRESULT
	get_namespaceURI as function(byval This as IXMLDOMAttribute ptr, byval namespaceURI as BSTR ptr) as HRESULT
	get_prefix as function(byval This as IXMLDOMAttribute ptr, byval prefixString as BSTR ptr) as HRESULT
	get_baseName as function(byval This as IXMLDOMAttribute ptr, byval nameString as BSTR ptr) as HRESULT
	transformNodeToObject as function(byval This as IXMLDOMAttribute ptr, byval stylesheet as IXMLDOMNode ptr, byval outputObject as VARIANT) as HRESULT
	get_name as function(byval This as IXMLDOMAttribute ptr, byval attributeName as BSTR ptr) as HRESULT
	get_value as function(byval This as IXMLDOMAttribute ptr, byval attributeValue as VARIANT ptr) as HRESULT
	put_value as function(byval This as IXMLDOMAttribute ptr, byval attributeValue as VARIANT) as HRESULT
end type

type IXMLDOMAttribute_
	lpVtbl as IXMLDOMAttributeVtbl ptr
end type

#define IXMLDOMAttribute_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IXMLDOMAttribute_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IXMLDOMAttribute_Release(This) (This)->lpVtbl->Release(This)
#define IXMLDOMAttribute_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define IXMLDOMAttribute_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define IXMLDOMAttribute_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define IXMLDOMAttribute_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define IXMLDOMAttribute_get_nodeName(This, name) (This)->lpVtbl->get_nodeName(This, name)
#define IXMLDOMAttribute_get_nodeValue(This, value) (This)->lpVtbl->get_nodeValue(This, value)
#define IXMLDOMAttribute_put_nodeValue(This, value) (This)->lpVtbl->put_nodeValue(This, value)
#define IXMLDOMAttribute_get_nodeType(This, type) (This)->lpVtbl->get_nodeType(This, type)
#define IXMLDOMAttribute_get_parentNode(This, parent) (This)->lpVtbl->get_parentNode(This, parent)
#define IXMLDOMAttribute_get_childNodes(This, childList) (This)->lpVtbl->get_childNodes(This, childList)
#define IXMLDOMAttribute_get_firstChild(This, firstChild) (This)->lpVtbl->get_firstChild(This, firstChild)
#define IXMLDOMAttribute_get_lastChild(This, lastChild) (This)->lpVtbl->get_lastChild(This, lastChild)
#define IXMLDOMAttribute_get_previousSibling(This, previousSibling) (This)->lpVtbl->get_previousSibling(This, previousSibling)
#define IXMLDOMAttribute_get_nextSibling(This, nextSibling) (This)->lpVtbl->get_nextSibling(This, nextSibling)
#define IXMLDOMAttribute_get_attributes(This, attributeMap) (This)->lpVtbl->get_attributes(This, attributeMap)
#define IXMLDOMAttribute_insertBefore(This, newChild, refChild, outNewChild) (This)->lpVtbl->insertBefore(This, newChild, refChild, outNewChild)
#define IXMLDOMAttribute_replaceChild(This, newChild, oldChild, outOldChild) (This)->lpVtbl->replaceChild(This, newChild, oldChild, outOldChild)
#define IXMLDOMAttribute_removeChild(This, childNode, oldChild) (This)->lpVtbl->removeChild(This, childNode, oldChild)
#define IXMLDOMAttribute_appendChild(This, newChild, outNewChild) (This)->lpVtbl->appendChild(This, newChild, outNewChild)
#define IXMLDOMAttribute_hasChildNodes(This, hasChild) (This)->lpVtbl->hasChildNodes(This, hasChild)
#define IXMLDOMAttribute_get_ownerDocument(This, DOMDocument) (This)->lpVtbl->get_ownerDocument(This, DOMDocument)
#define IXMLDOMAttribute_cloneNode(This, deep, cloneRoot) (This)->lpVtbl->cloneNode(This, deep, cloneRoot)
#define IXMLDOMAttribute_get_nodeTypeString(This, nodeType) (This)->lpVtbl->get_nodeTypeString(This, nodeType)
#define IXMLDOMAttribute_get_text(This, text) (This)->lpVtbl->get_text(This, text)
#define IXMLDOMAttribute_put_text(This, text) (This)->lpVtbl->put_text(This, text)
#define IXMLDOMAttribute_get_specified(This, isSpecified) (This)->lpVtbl->get_specified(This, isSpecified)
#define IXMLDOMAttribute_get_definition(This, definitionNode) (This)->lpVtbl->get_definition(This, definitionNode)
#define IXMLDOMAttribute_get_nodeTypedValue(This, typedValue) (This)->lpVtbl->get_nodeTypedValue(This, typedValue)
#define IXMLDOMAttribute_put_nodeTypedValue(This, typedValue) (This)->lpVtbl->put_nodeTypedValue(This, typedValue)
#define IXMLDOMAttribute_get_dataType(This, dataTypeName) (This)->lpVtbl->get_dataType(This, dataTypeName)
#define IXMLDOMAttribute_put_dataType(This, dataTypeName) (This)->lpVtbl->put_dataType(This, dataTypeName)
#define IXMLDOMAttribute_get_xml(This, xmlString) (This)->lpVtbl->get_xml(This, xmlString)
#define IXMLDOMAttribute_transformNode(This, stylesheet, xmlString) (This)->lpVtbl->transformNode(This, stylesheet, xmlString)
#define IXMLDOMAttribute_selectNodes(This, queryString, resultList) (This)->lpVtbl->selectNodes(This, queryString, resultList)
#define IXMLDOMAttribute_selectSingleNode(This, queryString, resultNode) (This)->lpVtbl->selectSingleNode(This, queryString, resultNode)
#define IXMLDOMAttribute_get_parsed(This, isParsed) (This)->lpVtbl->get_parsed(This, isParsed)
#define IXMLDOMAttribute_get_namespaceURI(This, namespaceURI) (This)->lpVtbl->get_namespaceURI(This, namespaceURI)
#define IXMLDOMAttribute_get_prefix(This, prefixString) (This)->lpVtbl->get_prefix(This, prefixString)
#define IXMLDOMAttribute_get_baseName(This, nameString) (This)->lpVtbl->get_baseName(This, nameString)
#define IXMLDOMAttribute_transformNodeToObject(This, stylesheet, outputObject) (This)->lpVtbl->transformNodeToObject(This, stylesheet, outputObject)
#define IXMLDOMAttribute_get_name(This, attributeName) (This)->lpVtbl->get_name(This, attributeName)
#define IXMLDOMAttribute_get_value(This, attributeValue) (This)->lpVtbl->get_value(This, attributeValue)
#define IXMLDOMAttribute_put_value(This, attributeValue) (This)->lpVtbl->put_value(This, attributeValue)

declare function IXMLDOMAttribute_get_name_Proxy(byval This as IXMLDOMAttribute ptr, byval attributeName as BSTR ptr) as HRESULT
declare sub IXMLDOMAttribute_get_name_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMAttribute_get_value_Proxy(byval This as IXMLDOMAttribute ptr, byval attributeValue as VARIANT ptr) as HRESULT
declare sub IXMLDOMAttribute_get_value_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMAttribute_put_value_Proxy(byval This as IXMLDOMAttribute ptr, byval attributeValue as VARIANT) as HRESULT
declare sub IXMLDOMAttribute_put_value_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IXMLDOMElement_INTERFACE_DEFINED__
extern IID_IXMLDOMElement as const IID

type IXMLDOMElementVtbl
	QueryInterface as function(byval This as IXMLDOMElement ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IXMLDOMElement ptr) as ULONG
	Release as function(byval This as IXMLDOMElement ptr) as ULONG
	GetTypeInfoCount as function(byval This as IXMLDOMElement ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IXMLDOMElement ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IXMLDOMElement ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IXMLDOMElement ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	get_nodeName as function(byval This as IXMLDOMElement ptr, byval name as BSTR ptr) as HRESULT
	get_nodeValue as function(byval This as IXMLDOMElement ptr, byval value as VARIANT ptr) as HRESULT
	put_nodeValue as function(byval This as IXMLDOMElement ptr, byval value as VARIANT) as HRESULT
	get_nodeType as function(byval This as IXMLDOMElement ptr, byval type as DOMNodeType ptr) as HRESULT
	get_parentNode as function(byval This as IXMLDOMElement ptr, byval parent as IXMLDOMNode ptr ptr) as HRESULT
	get_childNodes as function(byval This as IXMLDOMElement ptr, byval childList as IXMLDOMNodeList ptr ptr) as HRESULT
	get_firstChild as function(byval This as IXMLDOMElement ptr, byval firstChild as IXMLDOMNode ptr ptr) as HRESULT
	get_lastChild as function(byval This as IXMLDOMElement ptr, byval lastChild as IXMLDOMNode ptr ptr) as HRESULT
	get_previousSibling as function(byval This as IXMLDOMElement ptr, byval previousSibling as IXMLDOMNode ptr ptr) as HRESULT
	get_nextSibling as function(byval This as IXMLDOMElement ptr, byval nextSibling as IXMLDOMNode ptr ptr) as HRESULT
	get_attributes as function(byval This as IXMLDOMElement ptr, byval attributeMap as IXMLDOMNamedNodeMap ptr ptr) as HRESULT
	insertBefore as function(byval This as IXMLDOMElement ptr, byval newChild as IXMLDOMNode ptr, byval refChild as VARIANT, byval outNewChild as IXMLDOMNode ptr ptr) as HRESULT
	replaceChild as function(byval This as IXMLDOMElement ptr, byval newChild as IXMLDOMNode ptr, byval oldChild as IXMLDOMNode ptr, byval outOldChild as IXMLDOMNode ptr ptr) as HRESULT
	removeChild as function(byval This as IXMLDOMElement ptr, byval childNode as IXMLDOMNode ptr, byval oldChild as IXMLDOMNode ptr ptr) as HRESULT
	appendChild as function(byval This as IXMLDOMElement ptr, byval newChild as IXMLDOMNode ptr, byval outNewChild as IXMLDOMNode ptr ptr) as HRESULT
	hasChildNodes as function(byval This as IXMLDOMElement ptr, byval hasChild as VARIANT_BOOL ptr) as HRESULT
	get_ownerDocument as function(byval This as IXMLDOMElement ptr, byval DOMDocument as IXMLDOMDocument ptr ptr) as HRESULT
	cloneNode as function(byval This as IXMLDOMElement ptr, byval deep as VARIANT_BOOL, byval cloneRoot as IXMLDOMNode ptr ptr) as HRESULT
	get_nodeTypeString as function(byval This as IXMLDOMElement ptr, byval nodeType as BSTR ptr) as HRESULT
	get_text as function(byval This as IXMLDOMElement ptr, byval text as BSTR ptr) as HRESULT
	put_text as function(byval This as IXMLDOMElement ptr, byval text as BSTR) as HRESULT
	get_specified as function(byval This as IXMLDOMElement ptr, byval isSpecified as VARIANT_BOOL ptr) as HRESULT
	get_definition as function(byval This as IXMLDOMElement ptr, byval definitionNode as IXMLDOMNode ptr ptr) as HRESULT
	get_nodeTypedValue as function(byval This as IXMLDOMElement ptr, byval typedValue as VARIANT ptr) as HRESULT
	put_nodeTypedValue as function(byval This as IXMLDOMElement ptr, byval typedValue as VARIANT) as HRESULT
	get_dataType as function(byval This as IXMLDOMElement ptr, byval dataTypeName as VARIANT ptr) as HRESULT
	put_dataType as function(byval This as IXMLDOMElement ptr, byval dataTypeName as BSTR) as HRESULT
	get_xml as function(byval This as IXMLDOMElement ptr, byval xmlString as BSTR ptr) as HRESULT
	transformNode as function(byval This as IXMLDOMElement ptr, byval stylesheet as IXMLDOMNode ptr, byval xmlString as BSTR ptr) as HRESULT
	selectNodes as function(byval This as IXMLDOMElement ptr, byval queryString as BSTR, byval resultList as IXMLDOMNodeList ptr ptr) as HRESULT
	selectSingleNode as function(byval This as IXMLDOMElement ptr, byval queryString as BSTR, byval resultNode as IXMLDOMNode ptr ptr) as HRESULT
	get_parsed as function(byval This as IXMLDOMElement ptr, byval isParsed as VARIANT_BOOL ptr) as HRESULT
	get_namespaceURI as function(byval This as IXMLDOMElement ptr, byval namespaceURI as BSTR ptr) as HRESULT
	get_prefix as function(byval This as IXMLDOMElement ptr, byval prefixString as BSTR ptr) as HRESULT
	get_baseName as function(byval This as IXMLDOMElement ptr, byval nameString as BSTR ptr) as HRESULT
	transformNodeToObject as function(byval This as IXMLDOMElement ptr, byval stylesheet as IXMLDOMNode ptr, byval outputObject as VARIANT) as HRESULT
	get_tagName as function(byval This as IXMLDOMElement ptr, byval tagName as BSTR ptr) as HRESULT
	getAttribute as function(byval This as IXMLDOMElement ptr, byval name as BSTR, byval value as VARIANT ptr) as HRESULT
	setAttribute as function(byval This as IXMLDOMElement ptr, byval name as BSTR, byval value as VARIANT) as HRESULT
	removeAttribute as function(byval This as IXMLDOMElement ptr, byval name as BSTR) as HRESULT
	getAttributeNode as function(byval This as IXMLDOMElement ptr, byval name as BSTR, byval attributeNode as IXMLDOMAttribute ptr ptr) as HRESULT
	setAttributeNode as function(byval This as IXMLDOMElement ptr, byval DOMAttribute as IXMLDOMAttribute ptr, byval attributeNode as IXMLDOMAttribute ptr ptr) as HRESULT
	removeAttributeNode as function(byval This as IXMLDOMElement ptr, byval DOMAttribute as IXMLDOMAttribute ptr, byval attributeNode as IXMLDOMAttribute ptr ptr) as HRESULT
	getElementsByTagName as function(byval This as IXMLDOMElement ptr, byval tagName as BSTR, byval resultList as IXMLDOMNodeList ptr ptr) as HRESULT
	normalize as function(byval This as IXMLDOMElement ptr) as HRESULT
end type

type IXMLDOMElement_
	lpVtbl as IXMLDOMElementVtbl ptr
end type

#define IXMLDOMElement_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IXMLDOMElement_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IXMLDOMElement_Release(This) (This)->lpVtbl->Release(This)
#define IXMLDOMElement_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define IXMLDOMElement_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define IXMLDOMElement_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define IXMLDOMElement_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define IXMLDOMElement_get_nodeName(This, name) (This)->lpVtbl->get_nodeName(This, name)
#define IXMLDOMElement_get_nodeValue(This, value) (This)->lpVtbl->get_nodeValue(This, value)
#define IXMLDOMElement_put_nodeValue(This, value) (This)->lpVtbl->put_nodeValue(This, value)
#define IXMLDOMElement_get_nodeType(This, type) (This)->lpVtbl->get_nodeType(This, type)
#define IXMLDOMElement_get_parentNode(This, parent) (This)->lpVtbl->get_parentNode(This, parent)
#define IXMLDOMElement_get_childNodes(This, childList) (This)->lpVtbl->get_childNodes(This, childList)
#define IXMLDOMElement_get_firstChild(This, firstChild) (This)->lpVtbl->get_firstChild(This, firstChild)
#define IXMLDOMElement_get_lastChild(This, lastChild) (This)->lpVtbl->get_lastChild(This, lastChild)
#define IXMLDOMElement_get_previousSibling(This, previousSibling) (This)->lpVtbl->get_previousSibling(This, previousSibling)
#define IXMLDOMElement_get_nextSibling(This, nextSibling) (This)->lpVtbl->get_nextSibling(This, nextSibling)
#define IXMLDOMElement_get_attributes(This, attributeMap) (This)->lpVtbl->get_attributes(This, attributeMap)
#define IXMLDOMElement_insertBefore(This, newChild, refChild, outNewChild) (This)->lpVtbl->insertBefore(This, newChild, refChild, outNewChild)
#define IXMLDOMElement_replaceChild(This, newChild, oldChild, outOldChild) (This)->lpVtbl->replaceChild(This, newChild, oldChild, outOldChild)
#define IXMLDOMElement_removeChild(This, childNode, oldChild) (This)->lpVtbl->removeChild(This, childNode, oldChild)
#define IXMLDOMElement_appendChild(This, newChild, outNewChild) (This)->lpVtbl->appendChild(This, newChild, outNewChild)
#define IXMLDOMElement_hasChildNodes(This, hasChild) (This)->lpVtbl->hasChildNodes(This, hasChild)
#define IXMLDOMElement_get_ownerDocument(This, DOMDocument) (This)->lpVtbl->get_ownerDocument(This, DOMDocument)
#define IXMLDOMElement_cloneNode(This, deep, cloneRoot) (This)->lpVtbl->cloneNode(This, deep, cloneRoot)
#define IXMLDOMElement_get_nodeTypeString(This, nodeType) (This)->lpVtbl->get_nodeTypeString(This, nodeType)
#define IXMLDOMElement_get_text(This, text) (This)->lpVtbl->get_text(This, text)
#define IXMLDOMElement_put_text(This, text) (This)->lpVtbl->put_text(This, text)
#define IXMLDOMElement_get_specified(This, isSpecified) (This)->lpVtbl->get_specified(This, isSpecified)
#define IXMLDOMElement_get_definition(This, definitionNode) (This)->lpVtbl->get_definition(This, definitionNode)
#define IXMLDOMElement_get_nodeTypedValue(This, typedValue) (This)->lpVtbl->get_nodeTypedValue(This, typedValue)
#define IXMLDOMElement_put_nodeTypedValue(This, typedValue) (This)->lpVtbl->put_nodeTypedValue(This, typedValue)
#define IXMLDOMElement_get_dataType(This, dataTypeName) (This)->lpVtbl->get_dataType(This, dataTypeName)
#define IXMLDOMElement_put_dataType(This, dataTypeName) (This)->lpVtbl->put_dataType(This, dataTypeName)
#define IXMLDOMElement_get_xml(This, xmlString) (This)->lpVtbl->get_xml(This, xmlString)
#define IXMLDOMElement_transformNode(This, stylesheet, xmlString) (This)->lpVtbl->transformNode(This, stylesheet, xmlString)
#define IXMLDOMElement_selectNodes(This, queryString, resultList) (This)->lpVtbl->selectNodes(This, queryString, resultList)
#define IXMLDOMElement_selectSingleNode(This, queryString, resultNode) (This)->lpVtbl->selectSingleNode(This, queryString, resultNode)
#define IXMLDOMElement_get_parsed(This, isParsed) (This)->lpVtbl->get_parsed(This, isParsed)
#define IXMLDOMElement_get_namespaceURI(This, namespaceURI) (This)->lpVtbl->get_namespaceURI(This, namespaceURI)
#define IXMLDOMElement_get_prefix(This, prefixString) (This)->lpVtbl->get_prefix(This, prefixString)
#define IXMLDOMElement_get_baseName(This, nameString) (This)->lpVtbl->get_baseName(This, nameString)
#define IXMLDOMElement_transformNodeToObject(This, stylesheet, outputObject) (This)->lpVtbl->transformNodeToObject(This, stylesheet, outputObject)
#define IXMLDOMElement_get_tagName(This, tagName) (This)->lpVtbl->get_tagName(This, tagName)
#define IXMLDOMElement_getAttribute(This, name, value) (This)->lpVtbl->getAttribute(This, name, value)
#define IXMLDOMElement_setAttribute(This, name, value) (This)->lpVtbl->setAttribute(This, name, value)
#define IXMLDOMElement_removeAttribute(This, name) (This)->lpVtbl->removeAttribute(This, name)
#define IXMLDOMElement_getAttributeNode(This, name, attributeNode) (This)->lpVtbl->getAttributeNode(This, name, attributeNode)
#define IXMLDOMElement_setAttributeNode(This, DOMAttribute, attributeNode) (This)->lpVtbl->setAttributeNode(This, DOMAttribute, attributeNode)
#define IXMLDOMElement_removeAttributeNode(This, DOMAttribute, attributeNode) (This)->lpVtbl->removeAttributeNode(This, DOMAttribute, attributeNode)
#define IXMLDOMElement_getElementsByTagName(This, tagName, resultList) (This)->lpVtbl->getElementsByTagName(This, tagName, resultList)
#define IXMLDOMElement_normalize(This) (This)->lpVtbl->normalize(This)

declare function IXMLDOMElement_get_tagName_Proxy(byval This as IXMLDOMElement ptr, byval tagName as BSTR ptr) as HRESULT
declare sub IXMLDOMElement_get_tagName_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMElement_getAttribute_Proxy(byval This as IXMLDOMElement ptr, byval name as BSTR, byval value as VARIANT ptr) as HRESULT
declare sub IXMLDOMElement_getAttribute_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMElement_setAttribute_Proxy(byval This as IXMLDOMElement ptr, byval name as BSTR, byval value as VARIANT) as HRESULT
declare sub IXMLDOMElement_setAttribute_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMElement_removeAttribute_Proxy(byval This as IXMLDOMElement ptr, byval name as BSTR) as HRESULT
declare sub IXMLDOMElement_removeAttribute_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMElement_getAttributeNode_Proxy(byval This as IXMLDOMElement ptr, byval name as BSTR, byval attributeNode as IXMLDOMAttribute ptr ptr) as HRESULT
declare sub IXMLDOMElement_getAttributeNode_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMElement_setAttributeNode_Proxy(byval This as IXMLDOMElement ptr, byval DOMAttribute as IXMLDOMAttribute ptr, byval attributeNode as IXMLDOMAttribute ptr ptr) as HRESULT
declare sub IXMLDOMElement_setAttributeNode_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMElement_removeAttributeNode_Proxy(byval This as IXMLDOMElement ptr, byval DOMAttribute as IXMLDOMAttribute ptr, byval attributeNode as IXMLDOMAttribute ptr ptr) as HRESULT
declare sub IXMLDOMElement_removeAttributeNode_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMElement_getElementsByTagName_Proxy(byval This as IXMLDOMElement ptr, byval tagName as BSTR, byval resultList as IXMLDOMNodeList ptr ptr) as HRESULT
declare sub IXMLDOMElement_getElementsByTagName_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMElement_normalize_Proxy(byval This as IXMLDOMElement ptr) as HRESULT
declare sub IXMLDOMElement_normalize_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IXMLDOMText_INTERFACE_DEFINED__
extern IID_IXMLDOMText as const IID

type IXMLDOMTextVtbl
	QueryInterface as function(byval This as IXMLDOMText ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IXMLDOMText ptr) as ULONG
	Release as function(byval This as IXMLDOMText ptr) as ULONG
	GetTypeInfoCount as function(byval This as IXMLDOMText ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IXMLDOMText ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IXMLDOMText ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IXMLDOMText ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	get_nodeName as function(byval This as IXMLDOMText ptr, byval name as BSTR ptr) as HRESULT
	get_nodeValue as function(byval This as IXMLDOMText ptr, byval value as VARIANT ptr) as HRESULT
	put_nodeValue as function(byval This as IXMLDOMText ptr, byval value as VARIANT) as HRESULT
	get_nodeType as function(byval This as IXMLDOMText ptr, byval type as DOMNodeType ptr) as HRESULT
	get_parentNode as function(byval This as IXMLDOMText ptr, byval parent as IXMLDOMNode ptr ptr) as HRESULT
	get_childNodes as function(byval This as IXMLDOMText ptr, byval childList as IXMLDOMNodeList ptr ptr) as HRESULT
	get_firstChild as function(byval This as IXMLDOMText ptr, byval firstChild as IXMLDOMNode ptr ptr) as HRESULT
	get_lastChild as function(byval This as IXMLDOMText ptr, byval lastChild as IXMLDOMNode ptr ptr) as HRESULT
	get_previousSibling as function(byval This as IXMLDOMText ptr, byval previousSibling as IXMLDOMNode ptr ptr) as HRESULT
	get_nextSibling as function(byval This as IXMLDOMText ptr, byval nextSibling as IXMLDOMNode ptr ptr) as HRESULT
	get_attributes as function(byval This as IXMLDOMText ptr, byval attributeMap as IXMLDOMNamedNodeMap ptr ptr) as HRESULT
	insertBefore as function(byval This as IXMLDOMText ptr, byval newChild as IXMLDOMNode ptr, byval refChild as VARIANT, byval outNewChild as IXMLDOMNode ptr ptr) as HRESULT
	replaceChild as function(byval This as IXMLDOMText ptr, byval newChild as IXMLDOMNode ptr, byval oldChild as IXMLDOMNode ptr, byval outOldChild as IXMLDOMNode ptr ptr) as HRESULT
	removeChild as function(byval This as IXMLDOMText ptr, byval childNode as IXMLDOMNode ptr, byval oldChild as IXMLDOMNode ptr ptr) as HRESULT
	appendChild as function(byval This as IXMLDOMText ptr, byval newChild as IXMLDOMNode ptr, byval outNewChild as IXMLDOMNode ptr ptr) as HRESULT
	hasChildNodes as function(byval This as IXMLDOMText ptr, byval hasChild as VARIANT_BOOL ptr) as HRESULT
	get_ownerDocument as function(byval This as IXMLDOMText ptr, byval DOMDocument as IXMLDOMDocument ptr ptr) as HRESULT
	cloneNode as function(byval This as IXMLDOMText ptr, byval deep as VARIANT_BOOL, byval cloneRoot as IXMLDOMNode ptr ptr) as HRESULT
	get_nodeTypeString as function(byval This as IXMLDOMText ptr, byval nodeType as BSTR ptr) as HRESULT
	get_text as function(byval This as IXMLDOMText ptr, byval text as BSTR ptr) as HRESULT
	put_text as function(byval This as IXMLDOMText ptr, byval text as BSTR) as HRESULT
	get_specified as function(byval This as IXMLDOMText ptr, byval isSpecified as VARIANT_BOOL ptr) as HRESULT
	get_definition as function(byval This as IXMLDOMText ptr, byval definitionNode as IXMLDOMNode ptr ptr) as HRESULT
	get_nodeTypedValue as function(byval This as IXMLDOMText ptr, byval typedValue as VARIANT ptr) as HRESULT
	put_nodeTypedValue as function(byval This as IXMLDOMText ptr, byval typedValue as VARIANT) as HRESULT
	get_dataType as function(byval This as IXMLDOMText ptr, byval dataTypeName as VARIANT ptr) as HRESULT
	put_dataType as function(byval This as IXMLDOMText ptr, byval dataTypeName as BSTR) as HRESULT
	get_xml as function(byval This as IXMLDOMText ptr, byval xmlString as BSTR ptr) as HRESULT
	transformNode as function(byval This as IXMLDOMText ptr, byval stylesheet as IXMLDOMNode ptr, byval xmlString as BSTR ptr) as HRESULT
	selectNodes as function(byval This as IXMLDOMText ptr, byval queryString as BSTR, byval resultList as IXMLDOMNodeList ptr ptr) as HRESULT
	selectSingleNode as function(byval This as IXMLDOMText ptr, byval queryString as BSTR, byval resultNode as IXMLDOMNode ptr ptr) as HRESULT
	get_parsed as function(byval This as IXMLDOMText ptr, byval isParsed as VARIANT_BOOL ptr) as HRESULT
	get_namespaceURI as function(byval This as IXMLDOMText ptr, byval namespaceURI as BSTR ptr) as HRESULT
	get_prefix as function(byval This as IXMLDOMText ptr, byval prefixString as BSTR ptr) as HRESULT
	get_baseName as function(byval This as IXMLDOMText ptr, byval nameString as BSTR ptr) as HRESULT
	transformNodeToObject as function(byval This as IXMLDOMText ptr, byval stylesheet as IXMLDOMNode ptr, byval outputObject as VARIANT) as HRESULT
	get_data as function(byval This as IXMLDOMText ptr, byval data as BSTR ptr) as HRESULT
	put_data as function(byval This as IXMLDOMText ptr, byval data as BSTR) as HRESULT
	get_length as function(byval This as IXMLDOMText ptr, byval dataLength as LONG ptr) as HRESULT
	substringData as function(byval This as IXMLDOMText ptr, byval offset as LONG, byval count as LONG, byval data as BSTR ptr) as HRESULT
	appendData as function(byval This as IXMLDOMText ptr, byval data as BSTR) as HRESULT
	insertData as function(byval This as IXMLDOMText ptr, byval offset as LONG, byval data as BSTR) as HRESULT
	deleteData as function(byval This as IXMLDOMText ptr, byval offset as LONG, byval count as LONG) as HRESULT
	replaceData as function(byval This as IXMLDOMText ptr, byval offset as LONG, byval count as LONG, byval data as BSTR) as HRESULT
	splitText as function(byval This as IXMLDOMText ptr, byval offset as LONG, byval rightHandTextNode as IXMLDOMText ptr ptr) as HRESULT
end type

type IXMLDOMText_
	lpVtbl as IXMLDOMTextVtbl ptr
end type

#define IXMLDOMText_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IXMLDOMText_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IXMLDOMText_Release(This) (This)->lpVtbl->Release(This)
#define IXMLDOMText_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define IXMLDOMText_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define IXMLDOMText_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define IXMLDOMText_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define IXMLDOMText_get_nodeName(This, name) (This)->lpVtbl->get_nodeName(This, name)
#define IXMLDOMText_get_nodeValue(This, value) (This)->lpVtbl->get_nodeValue(This, value)
#define IXMLDOMText_put_nodeValue(This, value) (This)->lpVtbl->put_nodeValue(This, value)
#define IXMLDOMText_get_nodeType(This, type) (This)->lpVtbl->get_nodeType(This, type)
#define IXMLDOMText_get_parentNode(This, parent) (This)->lpVtbl->get_parentNode(This, parent)
#define IXMLDOMText_get_childNodes(This, childList) (This)->lpVtbl->get_childNodes(This, childList)
#define IXMLDOMText_get_firstChild(This, firstChild) (This)->lpVtbl->get_firstChild(This, firstChild)
#define IXMLDOMText_get_lastChild(This, lastChild) (This)->lpVtbl->get_lastChild(This, lastChild)
#define IXMLDOMText_get_previousSibling(This, previousSibling) (This)->lpVtbl->get_previousSibling(This, previousSibling)
#define IXMLDOMText_get_nextSibling(This, nextSibling) (This)->lpVtbl->get_nextSibling(This, nextSibling)
#define IXMLDOMText_get_attributes(This, attributeMap) (This)->lpVtbl->get_attributes(This, attributeMap)
#define IXMLDOMText_insertBefore(This, newChild, refChild, outNewChild) (This)->lpVtbl->insertBefore(This, newChild, refChild, outNewChild)
#define IXMLDOMText_replaceChild(This, newChild, oldChild, outOldChild) (This)->lpVtbl->replaceChild(This, newChild, oldChild, outOldChild)
#define IXMLDOMText_removeChild(This, childNode, oldChild) (This)->lpVtbl->removeChild(This, childNode, oldChild)
#define IXMLDOMText_appendChild(This, newChild, outNewChild) (This)->lpVtbl->appendChild(This, newChild, outNewChild)
#define IXMLDOMText_hasChildNodes(This, hasChild) (This)->lpVtbl->hasChildNodes(This, hasChild)
#define IXMLDOMText_get_ownerDocument(This, DOMDocument) (This)->lpVtbl->get_ownerDocument(This, DOMDocument)
#define IXMLDOMText_cloneNode(This, deep, cloneRoot) (This)->lpVtbl->cloneNode(This, deep, cloneRoot)
#define IXMLDOMText_get_nodeTypeString(This, nodeType) (This)->lpVtbl->get_nodeTypeString(This, nodeType)
#define IXMLDOMText_get_text(This, text) (This)->lpVtbl->get_text(This, text)
#define IXMLDOMText_put_text(This, text) (This)->lpVtbl->put_text(This, text)
#define IXMLDOMText_get_specified(This, isSpecified) (This)->lpVtbl->get_specified(This, isSpecified)
#define IXMLDOMText_get_definition(This, definitionNode) (This)->lpVtbl->get_definition(This, definitionNode)
#define IXMLDOMText_get_nodeTypedValue(This, typedValue) (This)->lpVtbl->get_nodeTypedValue(This, typedValue)
#define IXMLDOMText_put_nodeTypedValue(This, typedValue) (This)->lpVtbl->put_nodeTypedValue(This, typedValue)
#define IXMLDOMText_get_dataType(This, dataTypeName) (This)->lpVtbl->get_dataType(This, dataTypeName)
#define IXMLDOMText_put_dataType(This, dataTypeName) (This)->lpVtbl->put_dataType(This, dataTypeName)
#define IXMLDOMText_get_xml(This, xmlString) (This)->lpVtbl->get_xml(This, xmlString)
#define IXMLDOMText_transformNode(This, stylesheet, xmlString) (This)->lpVtbl->transformNode(This, stylesheet, xmlString)
#define IXMLDOMText_selectNodes(This, queryString, resultList) (This)->lpVtbl->selectNodes(This, queryString, resultList)
#define IXMLDOMText_selectSingleNode(This, queryString, resultNode) (This)->lpVtbl->selectSingleNode(This, queryString, resultNode)
#define IXMLDOMText_get_parsed(This, isParsed) (This)->lpVtbl->get_parsed(This, isParsed)
#define IXMLDOMText_get_namespaceURI(This, namespaceURI) (This)->lpVtbl->get_namespaceURI(This, namespaceURI)
#define IXMLDOMText_get_prefix(This, prefixString) (This)->lpVtbl->get_prefix(This, prefixString)
#define IXMLDOMText_get_baseName(This, nameString) (This)->lpVtbl->get_baseName(This, nameString)
#define IXMLDOMText_transformNodeToObject(This, stylesheet, outputObject) (This)->lpVtbl->transformNodeToObject(This, stylesheet, outputObject)
#define IXMLDOMText_get_data(This, data) (This)->lpVtbl->get_data(This, data)
#define IXMLDOMText_put_data(This, data) (This)->lpVtbl->put_data(This, data)
#define IXMLDOMText_get_length(This, dataLength) (This)->lpVtbl->get_length(This, dataLength)
#define IXMLDOMText_substringData(This, offset, count, data) (This)->lpVtbl->substringData(This, offset, count, data)
#define IXMLDOMText_appendData(This, data) (This)->lpVtbl->appendData(This, data)
#define IXMLDOMText_insertData(This, offset, data) (This)->lpVtbl->insertData(This, offset, data)
#define IXMLDOMText_deleteData(This, offset, count) (This)->lpVtbl->deleteData(This, offset, count)
#define IXMLDOMText_replaceData(This, offset, count, data) (This)->lpVtbl->replaceData(This, offset, count, data)
#define IXMLDOMText_splitText(This, offset, rightHandTextNode) (This)->lpVtbl->splitText(This, offset, rightHandTextNode)
declare function IXMLDOMText_splitText_Proxy(byval This as IXMLDOMText ptr, byval offset as LONG, byval rightHandTextNode as IXMLDOMText ptr ptr) as HRESULT
declare sub IXMLDOMText_splitText_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IXMLDOMComment_INTERFACE_DEFINED__
extern IID_IXMLDOMComment as const IID

type IXMLDOMCommentVtbl
	QueryInterface as function(byval This as IXMLDOMComment ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IXMLDOMComment ptr) as ULONG
	Release as function(byval This as IXMLDOMComment ptr) as ULONG
	GetTypeInfoCount as function(byval This as IXMLDOMComment ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IXMLDOMComment ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IXMLDOMComment ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IXMLDOMComment ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	get_nodeName as function(byval This as IXMLDOMComment ptr, byval name as BSTR ptr) as HRESULT
	get_nodeValue as function(byval This as IXMLDOMComment ptr, byval value as VARIANT ptr) as HRESULT
	put_nodeValue as function(byval This as IXMLDOMComment ptr, byval value as VARIANT) as HRESULT
	get_nodeType as function(byval This as IXMLDOMComment ptr, byval type as DOMNodeType ptr) as HRESULT
	get_parentNode as function(byval This as IXMLDOMComment ptr, byval parent as IXMLDOMNode ptr ptr) as HRESULT
	get_childNodes as function(byval This as IXMLDOMComment ptr, byval childList as IXMLDOMNodeList ptr ptr) as HRESULT
	get_firstChild as function(byval This as IXMLDOMComment ptr, byval firstChild as IXMLDOMNode ptr ptr) as HRESULT
	get_lastChild as function(byval This as IXMLDOMComment ptr, byval lastChild as IXMLDOMNode ptr ptr) as HRESULT
	get_previousSibling as function(byval This as IXMLDOMComment ptr, byval previousSibling as IXMLDOMNode ptr ptr) as HRESULT
	get_nextSibling as function(byval This as IXMLDOMComment ptr, byval nextSibling as IXMLDOMNode ptr ptr) as HRESULT
	get_attributes as function(byval This as IXMLDOMComment ptr, byval attributeMap as IXMLDOMNamedNodeMap ptr ptr) as HRESULT
	insertBefore as function(byval This as IXMLDOMComment ptr, byval newChild as IXMLDOMNode ptr, byval refChild as VARIANT, byval outNewChild as IXMLDOMNode ptr ptr) as HRESULT
	replaceChild as function(byval This as IXMLDOMComment ptr, byval newChild as IXMLDOMNode ptr, byval oldChild as IXMLDOMNode ptr, byval outOldChild as IXMLDOMNode ptr ptr) as HRESULT
	removeChild as function(byval This as IXMLDOMComment ptr, byval childNode as IXMLDOMNode ptr, byval oldChild as IXMLDOMNode ptr ptr) as HRESULT
	appendChild as function(byval This as IXMLDOMComment ptr, byval newChild as IXMLDOMNode ptr, byval outNewChild as IXMLDOMNode ptr ptr) as HRESULT
	hasChildNodes as function(byval This as IXMLDOMComment ptr, byval hasChild as VARIANT_BOOL ptr) as HRESULT
	get_ownerDocument as function(byval This as IXMLDOMComment ptr, byval DOMDocument as IXMLDOMDocument ptr ptr) as HRESULT
	cloneNode as function(byval This as IXMLDOMComment ptr, byval deep as VARIANT_BOOL, byval cloneRoot as IXMLDOMNode ptr ptr) as HRESULT
	get_nodeTypeString as function(byval This as IXMLDOMComment ptr, byval nodeType as BSTR ptr) as HRESULT
	get_text as function(byval This as IXMLDOMComment ptr, byval text as BSTR ptr) as HRESULT
	put_text as function(byval This as IXMLDOMComment ptr, byval text as BSTR) as HRESULT
	get_specified as function(byval This as IXMLDOMComment ptr, byval isSpecified as VARIANT_BOOL ptr) as HRESULT
	get_definition as function(byval This as IXMLDOMComment ptr, byval definitionNode as IXMLDOMNode ptr ptr) as HRESULT
	get_nodeTypedValue as function(byval This as IXMLDOMComment ptr, byval typedValue as VARIANT ptr) as HRESULT
	put_nodeTypedValue as function(byval This as IXMLDOMComment ptr, byval typedValue as VARIANT) as HRESULT
	get_dataType as function(byval This as IXMLDOMComment ptr, byval dataTypeName as VARIANT ptr) as HRESULT
	put_dataType as function(byval This as IXMLDOMComment ptr, byval dataTypeName as BSTR) as HRESULT
	get_xml as function(byval This as IXMLDOMComment ptr, byval xmlString as BSTR ptr) as HRESULT
	transformNode as function(byval This as IXMLDOMComment ptr, byval stylesheet as IXMLDOMNode ptr, byval xmlString as BSTR ptr) as HRESULT
	selectNodes as function(byval This as IXMLDOMComment ptr, byval queryString as BSTR, byval resultList as IXMLDOMNodeList ptr ptr) as HRESULT
	selectSingleNode as function(byval This as IXMLDOMComment ptr, byval queryString as BSTR, byval resultNode as IXMLDOMNode ptr ptr) as HRESULT
	get_parsed as function(byval This as IXMLDOMComment ptr, byval isParsed as VARIANT_BOOL ptr) as HRESULT
	get_namespaceURI as function(byval This as IXMLDOMComment ptr, byval namespaceURI as BSTR ptr) as HRESULT
	get_prefix as function(byval This as IXMLDOMComment ptr, byval prefixString as BSTR ptr) as HRESULT
	get_baseName as function(byval This as IXMLDOMComment ptr, byval nameString as BSTR ptr) as HRESULT
	transformNodeToObject as function(byval This as IXMLDOMComment ptr, byval stylesheet as IXMLDOMNode ptr, byval outputObject as VARIANT) as HRESULT
	get_data as function(byval This as IXMLDOMComment ptr, byval data as BSTR ptr) as HRESULT
	put_data as function(byval This as IXMLDOMComment ptr, byval data as BSTR) as HRESULT
	get_length as function(byval This as IXMLDOMComment ptr, byval dataLength as LONG ptr) as HRESULT
	substringData as function(byval This as IXMLDOMComment ptr, byval offset as LONG, byval count as LONG, byval data as BSTR ptr) as HRESULT
	appendData as function(byval This as IXMLDOMComment ptr, byval data as BSTR) as HRESULT
	insertData as function(byval This as IXMLDOMComment ptr, byval offset as LONG, byval data as BSTR) as HRESULT
	deleteData as function(byval This as IXMLDOMComment ptr, byval offset as LONG, byval count as LONG) as HRESULT
	replaceData as function(byval This as IXMLDOMComment ptr, byval offset as LONG, byval count as LONG, byval data as BSTR) as HRESULT
end type

type IXMLDOMComment_
	lpVtbl as IXMLDOMCommentVtbl ptr
end type

#define IXMLDOMComment_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IXMLDOMComment_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IXMLDOMComment_Release(This) (This)->lpVtbl->Release(This)
#define IXMLDOMComment_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define IXMLDOMComment_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define IXMLDOMComment_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define IXMLDOMComment_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define IXMLDOMComment_get_nodeName(This, name) (This)->lpVtbl->get_nodeName(This, name)
#define IXMLDOMComment_get_nodeValue(This, value) (This)->lpVtbl->get_nodeValue(This, value)
#define IXMLDOMComment_put_nodeValue(This, value) (This)->lpVtbl->put_nodeValue(This, value)
#define IXMLDOMComment_get_nodeType(This, type) (This)->lpVtbl->get_nodeType(This, type)
#define IXMLDOMComment_get_parentNode(This, parent) (This)->lpVtbl->get_parentNode(This, parent)
#define IXMLDOMComment_get_childNodes(This, childList) (This)->lpVtbl->get_childNodes(This, childList)
#define IXMLDOMComment_get_firstChild(This, firstChild) (This)->lpVtbl->get_firstChild(This, firstChild)
#define IXMLDOMComment_get_lastChild(This, lastChild) (This)->lpVtbl->get_lastChild(This, lastChild)
#define IXMLDOMComment_get_previousSibling(This, previousSibling) (This)->lpVtbl->get_previousSibling(This, previousSibling)
#define IXMLDOMComment_get_nextSibling(This, nextSibling) (This)->lpVtbl->get_nextSibling(This, nextSibling)
#define IXMLDOMComment_get_attributes(This, attributeMap) (This)->lpVtbl->get_attributes(This, attributeMap)
#define IXMLDOMComment_insertBefore(This, newChild, refChild, outNewChild) (This)->lpVtbl->insertBefore(This, newChild, refChild, outNewChild)
#define IXMLDOMComment_replaceChild(This, newChild, oldChild, outOldChild) (This)->lpVtbl->replaceChild(This, newChild, oldChild, outOldChild)
#define IXMLDOMComment_removeChild(This, childNode, oldChild) (This)->lpVtbl->removeChild(This, childNode, oldChild)
#define IXMLDOMComment_appendChild(This, newChild, outNewChild) (This)->lpVtbl->appendChild(This, newChild, outNewChild)
#define IXMLDOMComment_hasChildNodes(This, hasChild) (This)->lpVtbl->hasChildNodes(This, hasChild)
#define IXMLDOMComment_get_ownerDocument(This, DOMDocument) (This)->lpVtbl->get_ownerDocument(This, DOMDocument)
#define IXMLDOMComment_cloneNode(This, deep, cloneRoot) (This)->lpVtbl->cloneNode(This, deep, cloneRoot)
#define IXMLDOMComment_get_nodeTypeString(This, nodeType) (This)->lpVtbl->get_nodeTypeString(This, nodeType)
#define IXMLDOMComment_get_text(This, text) (This)->lpVtbl->get_text(This, text)
#define IXMLDOMComment_put_text(This, text) (This)->lpVtbl->put_text(This, text)
#define IXMLDOMComment_get_specified(This, isSpecified) (This)->lpVtbl->get_specified(This, isSpecified)
#define IXMLDOMComment_get_definition(This, definitionNode) (This)->lpVtbl->get_definition(This, definitionNode)
#define IXMLDOMComment_get_nodeTypedValue(This, typedValue) (This)->lpVtbl->get_nodeTypedValue(This, typedValue)
#define IXMLDOMComment_put_nodeTypedValue(This, typedValue) (This)->lpVtbl->put_nodeTypedValue(This, typedValue)
#define IXMLDOMComment_get_dataType(This, dataTypeName) (This)->lpVtbl->get_dataType(This, dataTypeName)
#define IXMLDOMComment_put_dataType(This, dataTypeName) (This)->lpVtbl->put_dataType(This, dataTypeName)
#define IXMLDOMComment_get_xml(This, xmlString) (This)->lpVtbl->get_xml(This, xmlString)
#define IXMLDOMComment_transformNode(This, stylesheet, xmlString) (This)->lpVtbl->transformNode(This, stylesheet, xmlString)
#define IXMLDOMComment_selectNodes(This, queryString, resultList) (This)->lpVtbl->selectNodes(This, queryString, resultList)
#define IXMLDOMComment_selectSingleNode(This, queryString, resultNode) (This)->lpVtbl->selectSingleNode(This, queryString, resultNode)
#define IXMLDOMComment_get_parsed(This, isParsed) (This)->lpVtbl->get_parsed(This, isParsed)
#define IXMLDOMComment_get_namespaceURI(This, namespaceURI) (This)->lpVtbl->get_namespaceURI(This, namespaceURI)
#define IXMLDOMComment_get_prefix(This, prefixString) (This)->lpVtbl->get_prefix(This, prefixString)
#define IXMLDOMComment_get_baseName(This, nameString) (This)->lpVtbl->get_baseName(This, nameString)
#define IXMLDOMComment_transformNodeToObject(This, stylesheet, outputObject) (This)->lpVtbl->transformNodeToObject(This, stylesheet, outputObject)
#define IXMLDOMComment_get_data(This, data) (This)->lpVtbl->get_data(This, data)
#define IXMLDOMComment_put_data(This, data) (This)->lpVtbl->put_data(This, data)
#define IXMLDOMComment_get_length(This, dataLength) (This)->lpVtbl->get_length(This, dataLength)
#define IXMLDOMComment_substringData(This, offset, count, data) (This)->lpVtbl->substringData(This, offset, count, data)
#define IXMLDOMComment_appendData(This, data) (This)->lpVtbl->appendData(This, data)
#define IXMLDOMComment_insertData(This, offset, data) (This)->lpVtbl->insertData(This, offset, data)
#define IXMLDOMComment_deleteData(This, offset, count) (This)->lpVtbl->deleteData(This, offset, count)
#define IXMLDOMComment_replaceData(This, offset, count, data) (This)->lpVtbl->replaceData(This, offset, count, data)
#define __IXMLDOMProcessingInstruction_INTERFACE_DEFINED__
extern IID_IXMLDOMProcessingInstruction as const IID

type IXMLDOMProcessingInstructionVtbl
	QueryInterface as function(byval This as IXMLDOMProcessingInstruction ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IXMLDOMProcessingInstruction ptr) as ULONG
	Release as function(byval This as IXMLDOMProcessingInstruction ptr) as ULONG
	GetTypeInfoCount as function(byval This as IXMLDOMProcessingInstruction ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IXMLDOMProcessingInstruction ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IXMLDOMProcessingInstruction ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IXMLDOMProcessingInstruction ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	get_nodeName as function(byval This as IXMLDOMProcessingInstruction ptr, byval name as BSTR ptr) as HRESULT
	get_nodeValue as function(byval This as IXMLDOMProcessingInstruction ptr, byval value as VARIANT ptr) as HRESULT
	put_nodeValue as function(byval This as IXMLDOMProcessingInstruction ptr, byval value as VARIANT) as HRESULT
	get_nodeType as function(byval This as IXMLDOMProcessingInstruction ptr, byval type as DOMNodeType ptr) as HRESULT
	get_parentNode as function(byval This as IXMLDOMProcessingInstruction ptr, byval parent as IXMLDOMNode ptr ptr) as HRESULT
	get_childNodes as function(byval This as IXMLDOMProcessingInstruction ptr, byval childList as IXMLDOMNodeList ptr ptr) as HRESULT
	get_firstChild as function(byval This as IXMLDOMProcessingInstruction ptr, byval firstChild as IXMLDOMNode ptr ptr) as HRESULT
	get_lastChild as function(byval This as IXMLDOMProcessingInstruction ptr, byval lastChild as IXMLDOMNode ptr ptr) as HRESULT
	get_previousSibling as function(byval This as IXMLDOMProcessingInstruction ptr, byval previousSibling as IXMLDOMNode ptr ptr) as HRESULT
	get_nextSibling as function(byval This as IXMLDOMProcessingInstruction ptr, byval nextSibling as IXMLDOMNode ptr ptr) as HRESULT
	get_attributes as function(byval This as IXMLDOMProcessingInstruction ptr, byval attributeMap as IXMLDOMNamedNodeMap ptr ptr) as HRESULT
	insertBefore as function(byval This as IXMLDOMProcessingInstruction ptr, byval newChild as IXMLDOMNode ptr, byval refChild as VARIANT, byval outNewChild as IXMLDOMNode ptr ptr) as HRESULT
	replaceChild as function(byval This as IXMLDOMProcessingInstruction ptr, byval newChild as IXMLDOMNode ptr, byval oldChild as IXMLDOMNode ptr, byval outOldChild as IXMLDOMNode ptr ptr) as HRESULT
	removeChild as function(byval This as IXMLDOMProcessingInstruction ptr, byval childNode as IXMLDOMNode ptr, byval oldChild as IXMLDOMNode ptr ptr) as HRESULT
	appendChild as function(byval This as IXMLDOMProcessingInstruction ptr, byval newChild as IXMLDOMNode ptr, byval outNewChild as IXMLDOMNode ptr ptr) as HRESULT
	hasChildNodes as function(byval This as IXMLDOMProcessingInstruction ptr, byval hasChild as VARIANT_BOOL ptr) as HRESULT
	get_ownerDocument as function(byval This as IXMLDOMProcessingInstruction ptr, byval DOMDocument as IXMLDOMDocument ptr ptr) as HRESULT
	cloneNode as function(byval This as IXMLDOMProcessingInstruction ptr, byval deep as VARIANT_BOOL, byval cloneRoot as IXMLDOMNode ptr ptr) as HRESULT
	get_nodeTypeString as function(byval This as IXMLDOMProcessingInstruction ptr, byval nodeType as BSTR ptr) as HRESULT
	get_text as function(byval This as IXMLDOMProcessingInstruction ptr, byval text as BSTR ptr) as HRESULT
	put_text as function(byval This as IXMLDOMProcessingInstruction ptr, byval text as BSTR) as HRESULT
	get_specified as function(byval This as IXMLDOMProcessingInstruction ptr, byval isSpecified as VARIANT_BOOL ptr) as HRESULT
	get_definition as function(byval This as IXMLDOMProcessingInstruction ptr, byval definitionNode as IXMLDOMNode ptr ptr) as HRESULT
	get_nodeTypedValue as function(byval This as IXMLDOMProcessingInstruction ptr, byval typedValue as VARIANT ptr) as HRESULT
	put_nodeTypedValue as function(byval This as IXMLDOMProcessingInstruction ptr, byval typedValue as VARIANT) as HRESULT
	get_dataType as function(byval This as IXMLDOMProcessingInstruction ptr, byval dataTypeName as VARIANT ptr) as HRESULT
	put_dataType as function(byval This as IXMLDOMProcessingInstruction ptr, byval dataTypeName as BSTR) as HRESULT
	get_xml as function(byval This as IXMLDOMProcessingInstruction ptr, byval xmlString as BSTR ptr) as HRESULT
	transformNode as function(byval This as IXMLDOMProcessingInstruction ptr, byval stylesheet as IXMLDOMNode ptr, byval xmlString as BSTR ptr) as HRESULT
	selectNodes as function(byval This as IXMLDOMProcessingInstruction ptr, byval queryString as BSTR, byval resultList as IXMLDOMNodeList ptr ptr) as HRESULT
	selectSingleNode as function(byval This as IXMLDOMProcessingInstruction ptr, byval queryString as BSTR, byval resultNode as IXMLDOMNode ptr ptr) as HRESULT
	get_parsed as function(byval This as IXMLDOMProcessingInstruction ptr, byval isParsed as VARIANT_BOOL ptr) as HRESULT
	get_namespaceURI as function(byval This as IXMLDOMProcessingInstruction ptr, byval namespaceURI as BSTR ptr) as HRESULT
	get_prefix as function(byval This as IXMLDOMProcessingInstruction ptr, byval prefixString as BSTR ptr) as HRESULT
	get_baseName as function(byval This as IXMLDOMProcessingInstruction ptr, byval nameString as BSTR ptr) as HRESULT
	transformNodeToObject as function(byval This as IXMLDOMProcessingInstruction ptr, byval stylesheet as IXMLDOMNode ptr, byval outputObject as VARIANT) as HRESULT
	get_target as function(byval This as IXMLDOMProcessingInstruction ptr, byval name as BSTR ptr) as HRESULT
	get_data as function(byval This as IXMLDOMProcessingInstruction ptr, byval value as BSTR ptr) as HRESULT
	put_data as function(byval This as IXMLDOMProcessingInstruction ptr, byval value as BSTR) as HRESULT
end type

type IXMLDOMProcessingInstruction_
	lpVtbl as IXMLDOMProcessingInstructionVtbl ptr
end type

#define IXMLDOMProcessingInstruction_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IXMLDOMProcessingInstruction_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IXMLDOMProcessingInstruction_Release(This) (This)->lpVtbl->Release(This)
#define IXMLDOMProcessingInstruction_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define IXMLDOMProcessingInstruction_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define IXMLDOMProcessingInstruction_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define IXMLDOMProcessingInstruction_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define IXMLDOMProcessingInstruction_get_nodeName(This, name) (This)->lpVtbl->get_nodeName(This, name)
#define IXMLDOMProcessingInstruction_get_nodeValue(This, value) (This)->lpVtbl->get_nodeValue(This, value)
#define IXMLDOMProcessingInstruction_put_nodeValue(This, value) (This)->lpVtbl->put_nodeValue(This, value)
#define IXMLDOMProcessingInstruction_get_nodeType(This, type) (This)->lpVtbl->get_nodeType(This, type)
#define IXMLDOMProcessingInstruction_get_parentNode(This, parent) (This)->lpVtbl->get_parentNode(This, parent)
#define IXMLDOMProcessingInstruction_get_childNodes(This, childList) (This)->lpVtbl->get_childNodes(This, childList)
#define IXMLDOMProcessingInstruction_get_firstChild(This, firstChild) (This)->lpVtbl->get_firstChild(This, firstChild)
#define IXMLDOMProcessingInstruction_get_lastChild(This, lastChild) (This)->lpVtbl->get_lastChild(This, lastChild)
#define IXMLDOMProcessingInstruction_get_previousSibling(This, previousSibling) (This)->lpVtbl->get_previousSibling(This, previousSibling)
#define IXMLDOMProcessingInstruction_get_nextSibling(This, nextSibling) (This)->lpVtbl->get_nextSibling(This, nextSibling)
#define IXMLDOMProcessingInstruction_get_attributes(This, attributeMap) (This)->lpVtbl->get_attributes(This, attributeMap)
#define IXMLDOMProcessingInstruction_insertBefore(This, newChild, refChild, outNewChild) (This)->lpVtbl->insertBefore(This, newChild, refChild, outNewChild)
#define IXMLDOMProcessingInstruction_replaceChild(This, newChild, oldChild, outOldChild) (This)->lpVtbl->replaceChild(This, newChild, oldChild, outOldChild)
#define IXMLDOMProcessingInstruction_removeChild(This, childNode, oldChild) (This)->lpVtbl->removeChild(This, childNode, oldChild)
#define IXMLDOMProcessingInstruction_appendChild(This, newChild, outNewChild) (This)->lpVtbl->appendChild(This, newChild, outNewChild)
#define IXMLDOMProcessingInstruction_hasChildNodes(This, hasChild) (This)->lpVtbl->hasChildNodes(This, hasChild)
#define IXMLDOMProcessingInstruction_get_ownerDocument(This, DOMDocument) (This)->lpVtbl->get_ownerDocument(This, DOMDocument)
#define IXMLDOMProcessingInstruction_cloneNode(This, deep, cloneRoot) (This)->lpVtbl->cloneNode(This, deep, cloneRoot)
#define IXMLDOMProcessingInstruction_get_nodeTypeString(This, nodeType) (This)->lpVtbl->get_nodeTypeString(This, nodeType)
#define IXMLDOMProcessingInstruction_get_text(This, text) (This)->lpVtbl->get_text(This, text)
#define IXMLDOMProcessingInstruction_put_text(This, text) (This)->lpVtbl->put_text(This, text)
#define IXMLDOMProcessingInstruction_get_specified(This, isSpecified) (This)->lpVtbl->get_specified(This, isSpecified)
#define IXMLDOMProcessingInstruction_get_definition(This, definitionNode) (This)->lpVtbl->get_definition(This, definitionNode)
#define IXMLDOMProcessingInstruction_get_nodeTypedValue(This, typedValue) (This)->lpVtbl->get_nodeTypedValue(This, typedValue)
#define IXMLDOMProcessingInstruction_put_nodeTypedValue(This, typedValue) (This)->lpVtbl->put_nodeTypedValue(This, typedValue)
#define IXMLDOMProcessingInstruction_get_dataType(This, dataTypeName) (This)->lpVtbl->get_dataType(This, dataTypeName)
#define IXMLDOMProcessingInstruction_put_dataType(This, dataTypeName) (This)->lpVtbl->put_dataType(This, dataTypeName)
#define IXMLDOMProcessingInstruction_get_xml(This, xmlString) (This)->lpVtbl->get_xml(This, xmlString)
#define IXMLDOMProcessingInstruction_transformNode(This, stylesheet, xmlString) (This)->lpVtbl->transformNode(This, stylesheet, xmlString)
#define IXMLDOMProcessingInstruction_selectNodes(This, queryString, resultList) (This)->lpVtbl->selectNodes(This, queryString, resultList)
#define IXMLDOMProcessingInstruction_selectSingleNode(This, queryString, resultNode) (This)->lpVtbl->selectSingleNode(This, queryString, resultNode)
#define IXMLDOMProcessingInstruction_get_parsed(This, isParsed) (This)->lpVtbl->get_parsed(This, isParsed)
#define IXMLDOMProcessingInstruction_get_namespaceURI(This, namespaceURI) (This)->lpVtbl->get_namespaceURI(This, namespaceURI)
#define IXMLDOMProcessingInstruction_get_prefix(This, prefixString) (This)->lpVtbl->get_prefix(This, prefixString)
#define IXMLDOMProcessingInstruction_get_baseName(This, nameString) (This)->lpVtbl->get_baseName(This, nameString)
#define IXMLDOMProcessingInstruction_transformNodeToObject(This, stylesheet, outputObject) (This)->lpVtbl->transformNodeToObject(This, stylesheet, outputObject)
#define IXMLDOMProcessingInstruction_get_target(This, name) (This)->lpVtbl->get_target(This, name)
#define IXMLDOMProcessingInstruction_get_data(This, value) (This)->lpVtbl->get_data(This, value)
#define IXMLDOMProcessingInstruction_put_data(This, value) (This)->lpVtbl->put_data(This, value)

declare function IXMLDOMProcessingInstruction_get_target_Proxy(byval This as IXMLDOMProcessingInstruction ptr, byval name as BSTR ptr) as HRESULT
declare sub IXMLDOMProcessingInstruction_get_target_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMProcessingInstruction_get_data_Proxy(byval This as IXMLDOMProcessingInstruction ptr, byval value as BSTR ptr) as HRESULT
declare sub IXMLDOMProcessingInstruction_get_data_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMProcessingInstruction_put_data_Proxy(byval This as IXMLDOMProcessingInstruction ptr, byval value as BSTR) as HRESULT
declare sub IXMLDOMProcessingInstruction_put_data_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IXMLDOMCDATASection_INTERFACE_DEFINED__
extern IID_IXMLDOMCDATASection as const IID

type IXMLDOMCDATASectionVtbl
	QueryInterface as function(byval This as IXMLDOMCDATASection ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IXMLDOMCDATASection ptr) as ULONG
	Release as function(byval This as IXMLDOMCDATASection ptr) as ULONG
	GetTypeInfoCount as function(byval This as IXMLDOMCDATASection ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IXMLDOMCDATASection ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IXMLDOMCDATASection ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IXMLDOMCDATASection ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	get_nodeName as function(byval This as IXMLDOMCDATASection ptr, byval name as BSTR ptr) as HRESULT
	get_nodeValue as function(byval This as IXMLDOMCDATASection ptr, byval value as VARIANT ptr) as HRESULT
	put_nodeValue as function(byval This as IXMLDOMCDATASection ptr, byval value as VARIANT) as HRESULT
	get_nodeType as function(byval This as IXMLDOMCDATASection ptr, byval type as DOMNodeType ptr) as HRESULT
	get_parentNode as function(byval This as IXMLDOMCDATASection ptr, byval parent as IXMLDOMNode ptr ptr) as HRESULT
	get_childNodes as function(byval This as IXMLDOMCDATASection ptr, byval childList as IXMLDOMNodeList ptr ptr) as HRESULT
	get_firstChild as function(byval This as IXMLDOMCDATASection ptr, byval firstChild as IXMLDOMNode ptr ptr) as HRESULT
	get_lastChild as function(byval This as IXMLDOMCDATASection ptr, byval lastChild as IXMLDOMNode ptr ptr) as HRESULT
	get_previousSibling as function(byval This as IXMLDOMCDATASection ptr, byval previousSibling as IXMLDOMNode ptr ptr) as HRESULT
	get_nextSibling as function(byval This as IXMLDOMCDATASection ptr, byval nextSibling as IXMLDOMNode ptr ptr) as HRESULT
	get_attributes as function(byval This as IXMLDOMCDATASection ptr, byval attributeMap as IXMLDOMNamedNodeMap ptr ptr) as HRESULT
	insertBefore as function(byval This as IXMLDOMCDATASection ptr, byval newChild as IXMLDOMNode ptr, byval refChild as VARIANT, byval outNewChild as IXMLDOMNode ptr ptr) as HRESULT
	replaceChild as function(byval This as IXMLDOMCDATASection ptr, byval newChild as IXMLDOMNode ptr, byval oldChild as IXMLDOMNode ptr, byval outOldChild as IXMLDOMNode ptr ptr) as HRESULT
	removeChild as function(byval This as IXMLDOMCDATASection ptr, byval childNode as IXMLDOMNode ptr, byval oldChild as IXMLDOMNode ptr ptr) as HRESULT
	appendChild as function(byval This as IXMLDOMCDATASection ptr, byval newChild as IXMLDOMNode ptr, byval outNewChild as IXMLDOMNode ptr ptr) as HRESULT
	hasChildNodes as function(byval This as IXMLDOMCDATASection ptr, byval hasChild as VARIANT_BOOL ptr) as HRESULT
	get_ownerDocument as function(byval This as IXMLDOMCDATASection ptr, byval DOMDocument as IXMLDOMDocument ptr ptr) as HRESULT
	cloneNode as function(byval This as IXMLDOMCDATASection ptr, byval deep as VARIANT_BOOL, byval cloneRoot as IXMLDOMNode ptr ptr) as HRESULT
	get_nodeTypeString as function(byval This as IXMLDOMCDATASection ptr, byval nodeType as BSTR ptr) as HRESULT
	get_text as function(byval This as IXMLDOMCDATASection ptr, byval text as BSTR ptr) as HRESULT
	put_text as function(byval This as IXMLDOMCDATASection ptr, byval text as BSTR) as HRESULT
	get_specified as function(byval This as IXMLDOMCDATASection ptr, byval isSpecified as VARIANT_BOOL ptr) as HRESULT
	get_definition as function(byval This as IXMLDOMCDATASection ptr, byval definitionNode as IXMLDOMNode ptr ptr) as HRESULT
	get_nodeTypedValue as function(byval This as IXMLDOMCDATASection ptr, byval typedValue as VARIANT ptr) as HRESULT
	put_nodeTypedValue as function(byval This as IXMLDOMCDATASection ptr, byval typedValue as VARIANT) as HRESULT
	get_dataType as function(byval This as IXMLDOMCDATASection ptr, byval dataTypeName as VARIANT ptr) as HRESULT
	put_dataType as function(byval This as IXMLDOMCDATASection ptr, byval dataTypeName as BSTR) as HRESULT
	get_xml as function(byval This as IXMLDOMCDATASection ptr, byval xmlString as BSTR ptr) as HRESULT
	transformNode as function(byval This as IXMLDOMCDATASection ptr, byval stylesheet as IXMLDOMNode ptr, byval xmlString as BSTR ptr) as HRESULT
	selectNodes as function(byval This as IXMLDOMCDATASection ptr, byval queryString as BSTR, byval resultList as IXMLDOMNodeList ptr ptr) as HRESULT
	selectSingleNode as function(byval This as IXMLDOMCDATASection ptr, byval queryString as BSTR, byval resultNode as IXMLDOMNode ptr ptr) as HRESULT
	get_parsed as function(byval This as IXMLDOMCDATASection ptr, byval isParsed as VARIANT_BOOL ptr) as HRESULT
	get_namespaceURI as function(byval This as IXMLDOMCDATASection ptr, byval namespaceURI as BSTR ptr) as HRESULT
	get_prefix as function(byval This as IXMLDOMCDATASection ptr, byval prefixString as BSTR ptr) as HRESULT
	get_baseName as function(byval This as IXMLDOMCDATASection ptr, byval nameString as BSTR ptr) as HRESULT
	transformNodeToObject as function(byval This as IXMLDOMCDATASection ptr, byval stylesheet as IXMLDOMNode ptr, byval outputObject as VARIANT) as HRESULT
	get_data as function(byval This as IXMLDOMCDATASection ptr, byval data as BSTR ptr) as HRESULT
	put_data as function(byval This as IXMLDOMCDATASection ptr, byval data as BSTR) as HRESULT
	get_length as function(byval This as IXMLDOMCDATASection ptr, byval dataLength as LONG ptr) as HRESULT
	substringData as function(byval This as IXMLDOMCDATASection ptr, byval offset as LONG, byval count as LONG, byval data as BSTR ptr) as HRESULT
	appendData as function(byval This as IXMLDOMCDATASection ptr, byval data as BSTR) as HRESULT
	insertData as function(byval This as IXMLDOMCDATASection ptr, byval offset as LONG, byval data as BSTR) as HRESULT
	deleteData as function(byval This as IXMLDOMCDATASection ptr, byval offset as LONG, byval count as LONG) as HRESULT
	replaceData as function(byval This as IXMLDOMCDATASection ptr, byval offset as LONG, byval count as LONG, byval data as BSTR) as HRESULT
	splitText as function(byval This as IXMLDOMCDATASection ptr, byval offset as LONG, byval rightHandTextNode as IXMLDOMText ptr ptr) as HRESULT
end type

type IXMLDOMCDATASection_
	lpVtbl as IXMLDOMCDATASectionVtbl ptr
end type

#define IXMLDOMCDATASection_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IXMLDOMCDATASection_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IXMLDOMCDATASection_Release(This) (This)->lpVtbl->Release(This)
#define IXMLDOMCDATASection_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define IXMLDOMCDATASection_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define IXMLDOMCDATASection_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define IXMLDOMCDATASection_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define IXMLDOMCDATASection_get_nodeName(This, name) (This)->lpVtbl->get_nodeName(This, name)
#define IXMLDOMCDATASection_get_nodeValue(This, value) (This)->lpVtbl->get_nodeValue(This, value)
#define IXMLDOMCDATASection_put_nodeValue(This, value) (This)->lpVtbl->put_nodeValue(This, value)
#define IXMLDOMCDATASection_get_nodeType(This, type) (This)->lpVtbl->get_nodeType(This, type)
#define IXMLDOMCDATASection_get_parentNode(This, parent) (This)->lpVtbl->get_parentNode(This, parent)
#define IXMLDOMCDATASection_get_childNodes(This, childList) (This)->lpVtbl->get_childNodes(This, childList)
#define IXMLDOMCDATASection_get_firstChild(This, firstChild) (This)->lpVtbl->get_firstChild(This, firstChild)
#define IXMLDOMCDATASection_get_lastChild(This, lastChild) (This)->lpVtbl->get_lastChild(This, lastChild)
#define IXMLDOMCDATASection_get_previousSibling(This, previousSibling) (This)->lpVtbl->get_previousSibling(This, previousSibling)
#define IXMLDOMCDATASection_get_nextSibling(This, nextSibling) (This)->lpVtbl->get_nextSibling(This, nextSibling)
#define IXMLDOMCDATASection_get_attributes(This, attributeMap) (This)->lpVtbl->get_attributes(This, attributeMap)
#define IXMLDOMCDATASection_insertBefore(This, newChild, refChild, outNewChild) (This)->lpVtbl->insertBefore(This, newChild, refChild, outNewChild)
#define IXMLDOMCDATASection_replaceChild(This, newChild, oldChild, outOldChild) (This)->lpVtbl->replaceChild(This, newChild, oldChild, outOldChild)
#define IXMLDOMCDATASection_removeChild(This, childNode, oldChild) (This)->lpVtbl->removeChild(This, childNode, oldChild)
#define IXMLDOMCDATASection_appendChild(This, newChild, outNewChild) (This)->lpVtbl->appendChild(This, newChild, outNewChild)
#define IXMLDOMCDATASection_hasChildNodes(This, hasChild) (This)->lpVtbl->hasChildNodes(This, hasChild)
#define IXMLDOMCDATASection_get_ownerDocument(This, DOMDocument) (This)->lpVtbl->get_ownerDocument(This, DOMDocument)
#define IXMLDOMCDATASection_cloneNode(This, deep, cloneRoot) (This)->lpVtbl->cloneNode(This, deep, cloneRoot)
#define IXMLDOMCDATASection_get_nodeTypeString(This, nodeType) (This)->lpVtbl->get_nodeTypeString(This, nodeType)
#define IXMLDOMCDATASection_get_text(This, text) (This)->lpVtbl->get_text(This, text)
#define IXMLDOMCDATASection_put_text(This, text) (This)->lpVtbl->put_text(This, text)
#define IXMLDOMCDATASection_get_specified(This, isSpecified) (This)->lpVtbl->get_specified(This, isSpecified)
#define IXMLDOMCDATASection_get_definition(This, definitionNode) (This)->lpVtbl->get_definition(This, definitionNode)
#define IXMLDOMCDATASection_get_nodeTypedValue(This, typedValue) (This)->lpVtbl->get_nodeTypedValue(This, typedValue)
#define IXMLDOMCDATASection_put_nodeTypedValue(This, typedValue) (This)->lpVtbl->put_nodeTypedValue(This, typedValue)
#define IXMLDOMCDATASection_get_dataType(This, dataTypeName) (This)->lpVtbl->get_dataType(This, dataTypeName)
#define IXMLDOMCDATASection_put_dataType(This, dataTypeName) (This)->lpVtbl->put_dataType(This, dataTypeName)
#define IXMLDOMCDATASection_get_xml(This, xmlString) (This)->lpVtbl->get_xml(This, xmlString)
#define IXMLDOMCDATASection_transformNode(This, stylesheet, xmlString) (This)->lpVtbl->transformNode(This, stylesheet, xmlString)
#define IXMLDOMCDATASection_selectNodes(This, queryString, resultList) (This)->lpVtbl->selectNodes(This, queryString, resultList)
#define IXMLDOMCDATASection_selectSingleNode(This, queryString, resultNode) (This)->lpVtbl->selectSingleNode(This, queryString, resultNode)
#define IXMLDOMCDATASection_get_parsed(This, isParsed) (This)->lpVtbl->get_parsed(This, isParsed)
#define IXMLDOMCDATASection_get_namespaceURI(This, namespaceURI) (This)->lpVtbl->get_namespaceURI(This, namespaceURI)
#define IXMLDOMCDATASection_get_prefix(This, prefixString) (This)->lpVtbl->get_prefix(This, prefixString)
#define IXMLDOMCDATASection_get_baseName(This, nameString) (This)->lpVtbl->get_baseName(This, nameString)
#define IXMLDOMCDATASection_transformNodeToObject(This, stylesheet, outputObject) (This)->lpVtbl->transformNodeToObject(This, stylesheet, outputObject)
#define IXMLDOMCDATASection_get_data(This, data) (This)->lpVtbl->get_data(This, data)
#define IXMLDOMCDATASection_put_data(This, data) (This)->lpVtbl->put_data(This, data)
#define IXMLDOMCDATASection_get_length(This, dataLength) (This)->lpVtbl->get_length(This, dataLength)
#define IXMLDOMCDATASection_substringData(This, offset, count, data) (This)->lpVtbl->substringData(This, offset, count, data)
#define IXMLDOMCDATASection_appendData(This, data) (This)->lpVtbl->appendData(This, data)
#define IXMLDOMCDATASection_insertData(This, offset, data) (This)->lpVtbl->insertData(This, offset, data)
#define IXMLDOMCDATASection_deleteData(This, offset, count) (This)->lpVtbl->deleteData(This, offset, count)
#define IXMLDOMCDATASection_replaceData(This, offset, count, data) (This)->lpVtbl->replaceData(This, offset, count, data)
#define IXMLDOMCDATASection_splitText(This, offset, rightHandTextNode) (This)->lpVtbl->splitText(This, offset, rightHandTextNode)
#define __IXMLDOMDocumentType_INTERFACE_DEFINED__
extern IID_IXMLDOMDocumentType as const IID

type IXMLDOMDocumentTypeVtbl
	QueryInterface as function(byval This as IXMLDOMDocumentType ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IXMLDOMDocumentType ptr) as ULONG
	Release as function(byval This as IXMLDOMDocumentType ptr) as ULONG
	GetTypeInfoCount as function(byval This as IXMLDOMDocumentType ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IXMLDOMDocumentType ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IXMLDOMDocumentType ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IXMLDOMDocumentType ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	get_nodeName as function(byval This as IXMLDOMDocumentType ptr, byval name as BSTR ptr) as HRESULT
	get_nodeValue as function(byval This as IXMLDOMDocumentType ptr, byval value as VARIANT ptr) as HRESULT
	put_nodeValue as function(byval This as IXMLDOMDocumentType ptr, byval value as VARIANT) as HRESULT
	get_nodeType as function(byval This as IXMLDOMDocumentType ptr, byval type as DOMNodeType ptr) as HRESULT
	get_parentNode as function(byval This as IXMLDOMDocumentType ptr, byval parent as IXMLDOMNode ptr ptr) as HRESULT
	get_childNodes as function(byval This as IXMLDOMDocumentType ptr, byval childList as IXMLDOMNodeList ptr ptr) as HRESULT
	get_firstChild as function(byval This as IXMLDOMDocumentType ptr, byval firstChild as IXMLDOMNode ptr ptr) as HRESULT
	get_lastChild as function(byval This as IXMLDOMDocumentType ptr, byval lastChild as IXMLDOMNode ptr ptr) as HRESULT
	get_previousSibling as function(byval This as IXMLDOMDocumentType ptr, byval previousSibling as IXMLDOMNode ptr ptr) as HRESULT
	get_nextSibling as function(byval This as IXMLDOMDocumentType ptr, byval nextSibling as IXMLDOMNode ptr ptr) as HRESULT
	get_attributes as function(byval This as IXMLDOMDocumentType ptr, byval attributeMap as IXMLDOMNamedNodeMap ptr ptr) as HRESULT
	insertBefore as function(byval This as IXMLDOMDocumentType ptr, byval newChild as IXMLDOMNode ptr, byval refChild as VARIANT, byval outNewChild as IXMLDOMNode ptr ptr) as HRESULT
	replaceChild as function(byval This as IXMLDOMDocumentType ptr, byval newChild as IXMLDOMNode ptr, byval oldChild as IXMLDOMNode ptr, byval outOldChild as IXMLDOMNode ptr ptr) as HRESULT
	removeChild as function(byval This as IXMLDOMDocumentType ptr, byval childNode as IXMLDOMNode ptr, byval oldChild as IXMLDOMNode ptr ptr) as HRESULT
	appendChild as function(byval This as IXMLDOMDocumentType ptr, byval newChild as IXMLDOMNode ptr, byval outNewChild as IXMLDOMNode ptr ptr) as HRESULT
	hasChildNodes as function(byval This as IXMLDOMDocumentType ptr, byval hasChild as VARIANT_BOOL ptr) as HRESULT
	get_ownerDocument as function(byval This as IXMLDOMDocumentType ptr, byval DOMDocument as IXMLDOMDocument ptr ptr) as HRESULT
	cloneNode as function(byval This as IXMLDOMDocumentType ptr, byval deep as VARIANT_BOOL, byval cloneRoot as IXMLDOMNode ptr ptr) as HRESULT
	get_nodeTypeString as function(byval This as IXMLDOMDocumentType ptr, byval nodeType as BSTR ptr) as HRESULT
	get_text as function(byval This as IXMLDOMDocumentType ptr, byval text as BSTR ptr) as HRESULT
	put_text as function(byval This as IXMLDOMDocumentType ptr, byval text as BSTR) as HRESULT
	get_specified as function(byval This as IXMLDOMDocumentType ptr, byval isSpecified as VARIANT_BOOL ptr) as HRESULT
	get_definition as function(byval This as IXMLDOMDocumentType ptr, byval definitionNode as IXMLDOMNode ptr ptr) as HRESULT
	get_nodeTypedValue as function(byval This as IXMLDOMDocumentType ptr, byval typedValue as VARIANT ptr) as HRESULT
	put_nodeTypedValue as function(byval This as IXMLDOMDocumentType ptr, byval typedValue as VARIANT) as HRESULT
	get_dataType as function(byval This as IXMLDOMDocumentType ptr, byval dataTypeName as VARIANT ptr) as HRESULT
	put_dataType as function(byval This as IXMLDOMDocumentType ptr, byval dataTypeName as BSTR) as HRESULT
	get_xml as function(byval This as IXMLDOMDocumentType ptr, byval xmlString as BSTR ptr) as HRESULT
	transformNode as function(byval This as IXMLDOMDocumentType ptr, byval stylesheet as IXMLDOMNode ptr, byval xmlString as BSTR ptr) as HRESULT
	selectNodes as function(byval This as IXMLDOMDocumentType ptr, byval queryString as BSTR, byval resultList as IXMLDOMNodeList ptr ptr) as HRESULT
	selectSingleNode as function(byval This as IXMLDOMDocumentType ptr, byval queryString as BSTR, byval resultNode as IXMLDOMNode ptr ptr) as HRESULT
	get_parsed as function(byval This as IXMLDOMDocumentType ptr, byval isParsed as VARIANT_BOOL ptr) as HRESULT
	get_namespaceURI as function(byval This as IXMLDOMDocumentType ptr, byval namespaceURI as BSTR ptr) as HRESULT
	get_prefix as function(byval This as IXMLDOMDocumentType ptr, byval prefixString as BSTR ptr) as HRESULT
	get_baseName as function(byval This as IXMLDOMDocumentType ptr, byval nameString as BSTR ptr) as HRESULT
	transformNodeToObject as function(byval This as IXMLDOMDocumentType ptr, byval stylesheet as IXMLDOMNode ptr, byval outputObject as VARIANT) as HRESULT
	get_name as function(byval This as IXMLDOMDocumentType ptr, byval rootName as BSTR ptr) as HRESULT
	get_entities as function(byval This as IXMLDOMDocumentType ptr, byval entityMap as IXMLDOMNamedNodeMap ptr ptr) as HRESULT
	get_notations as function(byval This as IXMLDOMDocumentType ptr, byval notationMap as IXMLDOMNamedNodeMap ptr ptr) as HRESULT
end type

type IXMLDOMDocumentType_
	lpVtbl as IXMLDOMDocumentTypeVtbl ptr
end type

#define IXMLDOMDocumentType_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IXMLDOMDocumentType_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IXMLDOMDocumentType_Release(This) (This)->lpVtbl->Release(This)
#define IXMLDOMDocumentType_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define IXMLDOMDocumentType_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define IXMLDOMDocumentType_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define IXMLDOMDocumentType_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define IXMLDOMDocumentType_get_nodeName(This, name) (This)->lpVtbl->get_nodeName(This, name)
#define IXMLDOMDocumentType_get_nodeValue(This, value) (This)->lpVtbl->get_nodeValue(This, value)
#define IXMLDOMDocumentType_put_nodeValue(This, value) (This)->lpVtbl->put_nodeValue(This, value)
#define IXMLDOMDocumentType_get_nodeType(This, type) (This)->lpVtbl->get_nodeType(This, type)
#define IXMLDOMDocumentType_get_parentNode(This, parent) (This)->lpVtbl->get_parentNode(This, parent)
#define IXMLDOMDocumentType_get_childNodes(This, childList) (This)->lpVtbl->get_childNodes(This, childList)
#define IXMLDOMDocumentType_get_firstChild(This, firstChild) (This)->lpVtbl->get_firstChild(This, firstChild)
#define IXMLDOMDocumentType_get_lastChild(This, lastChild) (This)->lpVtbl->get_lastChild(This, lastChild)
#define IXMLDOMDocumentType_get_previousSibling(This, previousSibling) (This)->lpVtbl->get_previousSibling(This, previousSibling)
#define IXMLDOMDocumentType_get_nextSibling(This, nextSibling) (This)->lpVtbl->get_nextSibling(This, nextSibling)
#define IXMLDOMDocumentType_get_attributes(This, attributeMap) (This)->lpVtbl->get_attributes(This, attributeMap)
#define IXMLDOMDocumentType_insertBefore(This, newChild, refChild, outNewChild) (This)->lpVtbl->insertBefore(This, newChild, refChild, outNewChild)
#define IXMLDOMDocumentType_replaceChild(This, newChild, oldChild, outOldChild) (This)->lpVtbl->replaceChild(This, newChild, oldChild, outOldChild)
#define IXMLDOMDocumentType_removeChild(This, childNode, oldChild) (This)->lpVtbl->removeChild(This, childNode, oldChild)
#define IXMLDOMDocumentType_appendChild(This, newChild, outNewChild) (This)->lpVtbl->appendChild(This, newChild, outNewChild)
#define IXMLDOMDocumentType_hasChildNodes(This, hasChild) (This)->lpVtbl->hasChildNodes(This, hasChild)
#define IXMLDOMDocumentType_get_ownerDocument(This, DOMDocument) (This)->lpVtbl->get_ownerDocument(This, DOMDocument)
#define IXMLDOMDocumentType_cloneNode(This, deep, cloneRoot) (This)->lpVtbl->cloneNode(This, deep, cloneRoot)
#define IXMLDOMDocumentType_get_nodeTypeString(This, nodeType) (This)->lpVtbl->get_nodeTypeString(This, nodeType)
#define IXMLDOMDocumentType_get_text(This, text) (This)->lpVtbl->get_text(This, text)
#define IXMLDOMDocumentType_put_text(This, text) (This)->lpVtbl->put_text(This, text)
#define IXMLDOMDocumentType_get_specified(This, isSpecified) (This)->lpVtbl->get_specified(This, isSpecified)
#define IXMLDOMDocumentType_get_definition(This, definitionNode) (This)->lpVtbl->get_definition(This, definitionNode)
#define IXMLDOMDocumentType_get_nodeTypedValue(This, typedValue) (This)->lpVtbl->get_nodeTypedValue(This, typedValue)
#define IXMLDOMDocumentType_put_nodeTypedValue(This, typedValue) (This)->lpVtbl->put_nodeTypedValue(This, typedValue)
#define IXMLDOMDocumentType_get_dataType(This, dataTypeName) (This)->lpVtbl->get_dataType(This, dataTypeName)
#define IXMLDOMDocumentType_put_dataType(This, dataTypeName) (This)->lpVtbl->put_dataType(This, dataTypeName)
#define IXMLDOMDocumentType_get_xml(This, xmlString) (This)->lpVtbl->get_xml(This, xmlString)
#define IXMLDOMDocumentType_transformNode(This, stylesheet, xmlString) (This)->lpVtbl->transformNode(This, stylesheet, xmlString)
#define IXMLDOMDocumentType_selectNodes(This, queryString, resultList) (This)->lpVtbl->selectNodes(This, queryString, resultList)
#define IXMLDOMDocumentType_selectSingleNode(This, queryString, resultNode) (This)->lpVtbl->selectSingleNode(This, queryString, resultNode)
#define IXMLDOMDocumentType_get_parsed(This, isParsed) (This)->lpVtbl->get_parsed(This, isParsed)
#define IXMLDOMDocumentType_get_namespaceURI(This, namespaceURI) (This)->lpVtbl->get_namespaceURI(This, namespaceURI)
#define IXMLDOMDocumentType_get_prefix(This, prefixString) (This)->lpVtbl->get_prefix(This, prefixString)
#define IXMLDOMDocumentType_get_baseName(This, nameString) (This)->lpVtbl->get_baseName(This, nameString)
#define IXMLDOMDocumentType_transformNodeToObject(This, stylesheet, outputObject) (This)->lpVtbl->transformNodeToObject(This, stylesheet, outputObject)
#define IXMLDOMDocumentType_get_name(This, rootName) (This)->lpVtbl->get_name(This, rootName)
#define IXMLDOMDocumentType_get_entities(This, entityMap) (This)->lpVtbl->get_entities(This, entityMap)
#define IXMLDOMDocumentType_get_notations(This, notationMap) (This)->lpVtbl->get_notations(This, notationMap)

declare function IXMLDOMDocumentType_get_name_Proxy(byval This as IXMLDOMDocumentType ptr, byval rootName as BSTR ptr) as HRESULT
declare sub IXMLDOMDocumentType_get_name_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMDocumentType_get_entities_Proxy(byval This as IXMLDOMDocumentType ptr, byval entityMap as IXMLDOMNamedNodeMap ptr ptr) as HRESULT
declare sub IXMLDOMDocumentType_get_entities_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMDocumentType_get_notations_Proxy(byval This as IXMLDOMDocumentType ptr, byval notationMap as IXMLDOMNamedNodeMap ptr ptr) as HRESULT
declare sub IXMLDOMDocumentType_get_notations_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IXMLDOMNotation_INTERFACE_DEFINED__
extern IID_IXMLDOMNotation as const IID
type IXMLDOMNotation as IXMLDOMNotation_

type IXMLDOMNotationVtbl
	QueryInterface as function(byval This as IXMLDOMNotation ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IXMLDOMNotation ptr) as ULONG
	Release as function(byval This as IXMLDOMNotation ptr) as ULONG
	GetTypeInfoCount as function(byval This as IXMLDOMNotation ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IXMLDOMNotation ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IXMLDOMNotation ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IXMLDOMNotation ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	get_nodeName as function(byval This as IXMLDOMNotation ptr, byval name as BSTR ptr) as HRESULT
	get_nodeValue as function(byval This as IXMLDOMNotation ptr, byval value as VARIANT ptr) as HRESULT
	put_nodeValue as function(byval This as IXMLDOMNotation ptr, byval value as VARIANT) as HRESULT
	get_nodeType as function(byval This as IXMLDOMNotation ptr, byval type as DOMNodeType ptr) as HRESULT
	get_parentNode as function(byval This as IXMLDOMNotation ptr, byval parent as IXMLDOMNode ptr ptr) as HRESULT
	get_childNodes as function(byval This as IXMLDOMNotation ptr, byval childList as IXMLDOMNodeList ptr ptr) as HRESULT
	get_firstChild as function(byval This as IXMLDOMNotation ptr, byval firstChild as IXMLDOMNode ptr ptr) as HRESULT
	get_lastChild as function(byval This as IXMLDOMNotation ptr, byval lastChild as IXMLDOMNode ptr ptr) as HRESULT
	get_previousSibling as function(byval This as IXMLDOMNotation ptr, byval previousSibling as IXMLDOMNode ptr ptr) as HRESULT
	get_nextSibling as function(byval This as IXMLDOMNotation ptr, byval nextSibling as IXMLDOMNode ptr ptr) as HRESULT
	get_attributes as function(byval This as IXMLDOMNotation ptr, byval attributeMap as IXMLDOMNamedNodeMap ptr ptr) as HRESULT
	insertBefore as function(byval This as IXMLDOMNotation ptr, byval newChild as IXMLDOMNode ptr, byval refChild as VARIANT, byval outNewChild as IXMLDOMNode ptr ptr) as HRESULT
	replaceChild as function(byval This as IXMLDOMNotation ptr, byval newChild as IXMLDOMNode ptr, byval oldChild as IXMLDOMNode ptr, byval outOldChild as IXMLDOMNode ptr ptr) as HRESULT
	removeChild as function(byval This as IXMLDOMNotation ptr, byval childNode as IXMLDOMNode ptr, byval oldChild as IXMLDOMNode ptr ptr) as HRESULT
	appendChild as function(byval This as IXMLDOMNotation ptr, byval newChild as IXMLDOMNode ptr, byval outNewChild as IXMLDOMNode ptr ptr) as HRESULT
	hasChildNodes as function(byval This as IXMLDOMNotation ptr, byval hasChild as VARIANT_BOOL ptr) as HRESULT
	get_ownerDocument as function(byval This as IXMLDOMNotation ptr, byval DOMDocument as IXMLDOMDocument ptr ptr) as HRESULT
	cloneNode as function(byval This as IXMLDOMNotation ptr, byval deep as VARIANT_BOOL, byval cloneRoot as IXMLDOMNode ptr ptr) as HRESULT
	get_nodeTypeString as function(byval This as IXMLDOMNotation ptr, byval nodeType as BSTR ptr) as HRESULT
	get_text as function(byval This as IXMLDOMNotation ptr, byval text as BSTR ptr) as HRESULT
	put_text as function(byval This as IXMLDOMNotation ptr, byval text as BSTR) as HRESULT
	get_specified as function(byval This as IXMLDOMNotation ptr, byval isSpecified as VARIANT_BOOL ptr) as HRESULT
	get_definition as function(byval This as IXMLDOMNotation ptr, byval definitionNode as IXMLDOMNode ptr ptr) as HRESULT
	get_nodeTypedValue as function(byval This as IXMLDOMNotation ptr, byval typedValue as VARIANT ptr) as HRESULT
	put_nodeTypedValue as function(byval This as IXMLDOMNotation ptr, byval typedValue as VARIANT) as HRESULT
	get_dataType as function(byval This as IXMLDOMNotation ptr, byval dataTypeName as VARIANT ptr) as HRESULT
	put_dataType as function(byval This as IXMLDOMNotation ptr, byval dataTypeName as BSTR) as HRESULT
	get_xml as function(byval This as IXMLDOMNotation ptr, byval xmlString as BSTR ptr) as HRESULT
	transformNode as function(byval This as IXMLDOMNotation ptr, byval stylesheet as IXMLDOMNode ptr, byval xmlString as BSTR ptr) as HRESULT
	selectNodes as function(byval This as IXMLDOMNotation ptr, byval queryString as BSTR, byval resultList as IXMLDOMNodeList ptr ptr) as HRESULT
	selectSingleNode as function(byval This as IXMLDOMNotation ptr, byval queryString as BSTR, byval resultNode as IXMLDOMNode ptr ptr) as HRESULT
	get_parsed as function(byval This as IXMLDOMNotation ptr, byval isParsed as VARIANT_BOOL ptr) as HRESULT
	get_namespaceURI as function(byval This as IXMLDOMNotation ptr, byval namespaceURI as BSTR ptr) as HRESULT
	get_prefix as function(byval This as IXMLDOMNotation ptr, byval prefixString as BSTR ptr) as HRESULT
	get_baseName as function(byval This as IXMLDOMNotation ptr, byval nameString as BSTR ptr) as HRESULT
	transformNodeToObject as function(byval This as IXMLDOMNotation ptr, byval stylesheet as IXMLDOMNode ptr, byval outputObject as VARIANT) as HRESULT
	get_publicId as function(byval This as IXMLDOMNotation ptr, byval publicID as VARIANT ptr) as HRESULT
	get_systemId as function(byval This as IXMLDOMNotation ptr, byval systemID as VARIANT ptr) as HRESULT
end type

type IXMLDOMNotation_
	lpVtbl as IXMLDOMNotationVtbl ptr
end type

#define IXMLDOMNotation_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IXMLDOMNotation_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IXMLDOMNotation_Release(This) (This)->lpVtbl->Release(This)
#define IXMLDOMNotation_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define IXMLDOMNotation_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define IXMLDOMNotation_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define IXMLDOMNotation_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define IXMLDOMNotation_get_nodeName(This, name) (This)->lpVtbl->get_nodeName(This, name)
#define IXMLDOMNotation_get_nodeValue(This, value) (This)->lpVtbl->get_nodeValue(This, value)
#define IXMLDOMNotation_put_nodeValue(This, value) (This)->lpVtbl->put_nodeValue(This, value)
#define IXMLDOMNotation_get_nodeType(This, type) (This)->lpVtbl->get_nodeType(This, type)
#define IXMLDOMNotation_get_parentNode(This, parent) (This)->lpVtbl->get_parentNode(This, parent)
#define IXMLDOMNotation_get_childNodes(This, childList) (This)->lpVtbl->get_childNodes(This, childList)
#define IXMLDOMNotation_get_firstChild(This, firstChild) (This)->lpVtbl->get_firstChild(This, firstChild)
#define IXMLDOMNotation_get_lastChild(This, lastChild) (This)->lpVtbl->get_lastChild(This, lastChild)
#define IXMLDOMNotation_get_previousSibling(This, previousSibling) (This)->lpVtbl->get_previousSibling(This, previousSibling)
#define IXMLDOMNotation_get_nextSibling(This, nextSibling) (This)->lpVtbl->get_nextSibling(This, nextSibling)
#define IXMLDOMNotation_get_attributes(This, attributeMap) (This)->lpVtbl->get_attributes(This, attributeMap)
#define IXMLDOMNotation_insertBefore(This, newChild, refChild, outNewChild) (This)->lpVtbl->insertBefore(This, newChild, refChild, outNewChild)
#define IXMLDOMNotation_replaceChild(This, newChild, oldChild, outOldChild) (This)->lpVtbl->replaceChild(This, newChild, oldChild, outOldChild)
#define IXMLDOMNotation_removeChild(This, childNode, oldChild) (This)->lpVtbl->removeChild(This, childNode, oldChild)
#define IXMLDOMNotation_appendChild(This, newChild, outNewChild) (This)->lpVtbl->appendChild(This, newChild, outNewChild)
#define IXMLDOMNotation_hasChildNodes(This, hasChild) (This)->lpVtbl->hasChildNodes(This, hasChild)
#define IXMLDOMNotation_get_ownerDocument(This, DOMDocument) (This)->lpVtbl->get_ownerDocument(This, DOMDocument)
#define IXMLDOMNotation_cloneNode(This, deep, cloneRoot) (This)->lpVtbl->cloneNode(This, deep, cloneRoot)
#define IXMLDOMNotation_get_nodeTypeString(This, nodeType) (This)->lpVtbl->get_nodeTypeString(This, nodeType)
#define IXMLDOMNotation_get_text(This, text) (This)->lpVtbl->get_text(This, text)
#define IXMLDOMNotation_put_text(This, text) (This)->lpVtbl->put_text(This, text)
#define IXMLDOMNotation_get_specified(This, isSpecified) (This)->lpVtbl->get_specified(This, isSpecified)
#define IXMLDOMNotation_get_definition(This, definitionNode) (This)->lpVtbl->get_definition(This, definitionNode)
#define IXMLDOMNotation_get_nodeTypedValue(This, typedValue) (This)->lpVtbl->get_nodeTypedValue(This, typedValue)
#define IXMLDOMNotation_put_nodeTypedValue(This, typedValue) (This)->lpVtbl->put_nodeTypedValue(This, typedValue)
#define IXMLDOMNotation_get_dataType(This, dataTypeName) (This)->lpVtbl->get_dataType(This, dataTypeName)
#define IXMLDOMNotation_put_dataType(This, dataTypeName) (This)->lpVtbl->put_dataType(This, dataTypeName)
#define IXMLDOMNotation_get_xml(This, xmlString) (This)->lpVtbl->get_xml(This, xmlString)
#define IXMLDOMNotation_transformNode(This, stylesheet, xmlString) (This)->lpVtbl->transformNode(This, stylesheet, xmlString)
#define IXMLDOMNotation_selectNodes(This, queryString, resultList) (This)->lpVtbl->selectNodes(This, queryString, resultList)
#define IXMLDOMNotation_selectSingleNode(This, queryString, resultNode) (This)->lpVtbl->selectSingleNode(This, queryString, resultNode)
#define IXMLDOMNotation_get_parsed(This, isParsed) (This)->lpVtbl->get_parsed(This, isParsed)
#define IXMLDOMNotation_get_namespaceURI(This, namespaceURI) (This)->lpVtbl->get_namespaceURI(This, namespaceURI)
#define IXMLDOMNotation_get_prefix(This, prefixString) (This)->lpVtbl->get_prefix(This, prefixString)
#define IXMLDOMNotation_get_baseName(This, nameString) (This)->lpVtbl->get_baseName(This, nameString)
#define IXMLDOMNotation_transformNodeToObject(This, stylesheet, outputObject) (This)->lpVtbl->transformNodeToObject(This, stylesheet, outputObject)
#define IXMLDOMNotation_get_publicId(This, publicID) (This)->lpVtbl->get_publicId(This, publicID)
#define IXMLDOMNotation_get_systemId(This, systemID) (This)->lpVtbl->get_systemId(This, systemID)

declare function IXMLDOMNotation_get_publicId_Proxy(byval This as IXMLDOMNotation ptr, byval publicID as VARIANT ptr) as HRESULT
declare sub IXMLDOMNotation_get_publicId_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMNotation_get_systemId_Proxy(byval This as IXMLDOMNotation ptr, byval systemID as VARIANT ptr) as HRESULT
declare sub IXMLDOMNotation_get_systemId_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IXMLDOMEntity_INTERFACE_DEFINED__
extern IID_IXMLDOMEntity as const IID
type IXMLDOMEntity as IXMLDOMEntity_

type IXMLDOMEntityVtbl
	QueryInterface as function(byval This as IXMLDOMEntity ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IXMLDOMEntity ptr) as ULONG
	Release as function(byval This as IXMLDOMEntity ptr) as ULONG
	GetTypeInfoCount as function(byval This as IXMLDOMEntity ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IXMLDOMEntity ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IXMLDOMEntity ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IXMLDOMEntity ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	get_nodeName as function(byval This as IXMLDOMEntity ptr, byval name as BSTR ptr) as HRESULT
	get_nodeValue as function(byval This as IXMLDOMEntity ptr, byval value as VARIANT ptr) as HRESULT
	put_nodeValue as function(byval This as IXMLDOMEntity ptr, byval value as VARIANT) as HRESULT
	get_nodeType as function(byval This as IXMLDOMEntity ptr, byval type as DOMNodeType ptr) as HRESULT
	get_parentNode as function(byval This as IXMLDOMEntity ptr, byval parent as IXMLDOMNode ptr ptr) as HRESULT
	get_childNodes as function(byval This as IXMLDOMEntity ptr, byval childList as IXMLDOMNodeList ptr ptr) as HRESULT
	get_firstChild as function(byval This as IXMLDOMEntity ptr, byval firstChild as IXMLDOMNode ptr ptr) as HRESULT
	get_lastChild as function(byval This as IXMLDOMEntity ptr, byval lastChild as IXMLDOMNode ptr ptr) as HRESULT
	get_previousSibling as function(byval This as IXMLDOMEntity ptr, byval previousSibling as IXMLDOMNode ptr ptr) as HRESULT
	get_nextSibling as function(byval This as IXMLDOMEntity ptr, byval nextSibling as IXMLDOMNode ptr ptr) as HRESULT
	get_attributes as function(byval This as IXMLDOMEntity ptr, byval attributeMap as IXMLDOMNamedNodeMap ptr ptr) as HRESULT
	insertBefore as function(byval This as IXMLDOMEntity ptr, byval newChild as IXMLDOMNode ptr, byval refChild as VARIANT, byval outNewChild as IXMLDOMNode ptr ptr) as HRESULT
	replaceChild as function(byval This as IXMLDOMEntity ptr, byval newChild as IXMLDOMNode ptr, byval oldChild as IXMLDOMNode ptr, byval outOldChild as IXMLDOMNode ptr ptr) as HRESULT
	removeChild as function(byval This as IXMLDOMEntity ptr, byval childNode as IXMLDOMNode ptr, byval oldChild as IXMLDOMNode ptr ptr) as HRESULT
	appendChild as function(byval This as IXMLDOMEntity ptr, byval newChild as IXMLDOMNode ptr, byval outNewChild as IXMLDOMNode ptr ptr) as HRESULT
	hasChildNodes as function(byval This as IXMLDOMEntity ptr, byval hasChild as VARIANT_BOOL ptr) as HRESULT
	get_ownerDocument as function(byval This as IXMLDOMEntity ptr, byval DOMDocument as IXMLDOMDocument ptr ptr) as HRESULT
	cloneNode as function(byval This as IXMLDOMEntity ptr, byval deep as VARIANT_BOOL, byval cloneRoot as IXMLDOMNode ptr ptr) as HRESULT
	get_nodeTypeString as function(byval This as IXMLDOMEntity ptr, byval nodeType as BSTR ptr) as HRESULT
	get_text as function(byval This as IXMLDOMEntity ptr, byval text as BSTR ptr) as HRESULT
	put_text as function(byval This as IXMLDOMEntity ptr, byval text as BSTR) as HRESULT
	get_specified as function(byval This as IXMLDOMEntity ptr, byval isSpecified as VARIANT_BOOL ptr) as HRESULT
	get_definition as function(byval This as IXMLDOMEntity ptr, byval definitionNode as IXMLDOMNode ptr ptr) as HRESULT
	get_nodeTypedValue as function(byval This as IXMLDOMEntity ptr, byval typedValue as VARIANT ptr) as HRESULT
	put_nodeTypedValue as function(byval This as IXMLDOMEntity ptr, byval typedValue as VARIANT) as HRESULT
	get_dataType as function(byval This as IXMLDOMEntity ptr, byval dataTypeName as VARIANT ptr) as HRESULT
	put_dataType as function(byval This as IXMLDOMEntity ptr, byval dataTypeName as BSTR) as HRESULT
	get_xml as function(byval This as IXMLDOMEntity ptr, byval xmlString as BSTR ptr) as HRESULT
	transformNode as function(byval This as IXMLDOMEntity ptr, byval stylesheet as IXMLDOMNode ptr, byval xmlString as BSTR ptr) as HRESULT
	selectNodes as function(byval This as IXMLDOMEntity ptr, byval queryString as BSTR, byval resultList as IXMLDOMNodeList ptr ptr) as HRESULT
	selectSingleNode as function(byval This as IXMLDOMEntity ptr, byval queryString as BSTR, byval resultNode as IXMLDOMNode ptr ptr) as HRESULT
	get_parsed as function(byval This as IXMLDOMEntity ptr, byval isParsed as VARIANT_BOOL ptr) as HRESULT
	get_namespaceURI as function(byval This as IXMLDOMEntity ptr, byval namespaceURI as BSTR ptr) as HRESULT
	get_prefix as function(byval This as IXMLDOMEntity ptr, byval prefixString as BSTR ptr) as HRESULT
	get_baseName as function(byval This as IXMLDOMEntity ptr, byval nameString as BSTR ptr) as HRESULT
	transformNodeToObject as function(byval This as IXMLDOMEntity ptr, byval stylesheet as IXMLDOMNode ptr, byval outputObject as VARIANT) as HRESULT
	get_publicId as function(byval This as IXMLDOMEntity ptr, byval publicID as VARIANT ptr) as HRESULT
	get_systemId as function(byval This as IXMLDOMEntity ptr, byval systemID as VARIANT ptr) as HRESULT
	get_notationName as function(byval This as IXMLDOMEntity ptr, byval name as BSTR ptr) as HRESULT
end type

type IXMLDOMEntity_
	lpVtbl as IXMLDOMEntityVtbl ptr
end type

#define IXMLDOMEntity_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IXMLDOMEntity_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IXMLDOMEntity_Release(This) (This)->lpVtbl->Release(This)
#define IXMLDOMEntity_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define IXMLDOMEntity_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define IXMLDOMEntity_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define IXMLDOMEntity_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define IXMLDOMEntity_get_nodeName(This, name) (This)->lpVtbl->get_nodeName(This, name)
#define IXMLDOMEntity_get_nodeValue(This, value) (This)->lpVtbl->get_nodeValue(This, value)
#define IXMLDOMEntity_put_nodeValue(This, value) (This)->lpVtbl->put_nodeValue(This, value)
#define IXMLDOMEntity_get_nodeType(This, type) (This)->lpVtbl->get_nodeType(This, type)
#define IXMLDOMEntity_get_parentNode(This, parent) (This)->lpVtbl->get_parentNode(This, parent)
#define IXMLDOMEntity_get_childNodes(This, childList) (This)->lpVtbl->get_childNodes(This, childList)
#define IXMLDOMEntity_get_firstChild(This, firstChild) (This)->lpVtbl->get_firstChild(This, firstChild)
#define IXMLDOMEntity_get_lastChild(This, lastChild) (This)->lpVtbl->get_lastChild(This, lastChild)
#define IXMLDOMEntity_get_previousSibling(This, previousSibling) (This)->lpVtbl->get_previousSibling(This, previousSibling)
#define IXMLDOMEntity_get_nextSibling(This, nextSibling) (This)->lpVtbl->get_nextSibling(This, nextSibling)
#define IXMLDOMEntity_get_attributes(This, attributeMap) (This)->lpVtbl->get_attributes(This, attributeMap)
#define IXMLDOMEntity_insertBefore(This, newChild, refChild, outNewChild) (This)->lpVtbl->insertBefore(This, newChild, refChild, outNewChild)
#define IXMLDOMEntity_replaceChild(This, newChild, oldChild, outOldChild) (This)->lpVtbl->replaceChild(This, newChild, oldChild, outOldChild)
#define IXMLDOMEntity_removeChild(This, childNode, oldChild) (This)->lpVtbl->removeChild(This, childNode, oldChild)
#define IXMLDOMEntity_appendChild(This, newChild, outNewChild) (This)->lpVtbl->appendChild(This, newChild, outNewChild)
#define IXMLDOMEntity_hasChildNodes(This, hasChild) (This)->lpVtbl->hasChildNodes(This, hasChild)
#define IXMLDOMEntity_get_ownerDocument(This, DOMDocument) (This)->lpVtbl->get_ownerDocument(This, DOMDocument)
#define IXMLDOMEntity_cloneNode(This, deep, cloneRoot) (This)->lpVtbl->cloneNode(This, deep, cloneRoot)
#define IXMLDOMEntity_get_nodeTypeString(This, nodeType) (This)->lpVtbl->get_nodeTypeString(This, nodeType)
#define IXMLDOMEntity_get_text(This, text) (This)->lpVtbl->get_text(This, text)
#define IXMLDOMEntity_put_text(This, text) (This)->lpVtbl->put_text(This, text)
#define IXMLDOMEntity_get_specified(This, isSpecified) (This)->lpVtbl->get_specified(This, isSpecified)
#define IXMLDOMEntity_get_definition(This, definitionNode) (This)->lpVtbl->get_definition(This, definitionNode)
#define IXMLDOMEntity_get_nodeTypedValue(This, typedValue) (This)->lpVtbl->get_nodeTypedValue(This, typedValue)
#define IXMLDOMEntity_put_nodeTypedValue(This, typedValue) (This)->lpVtbl->put_nodeTypedValue(This, typedValue)
#define IXMLDOMEntity_get_dataType(This, dataTypeName) (This)->lpVtbl->get_dataType(This, dataTypeName)
#define IXMLDOMEntity_put_dataType(This, dataTypeName) (This)->lpVtbl->put_dataType(This, dataTypeName)
#define IXMLDOMEntity_get_xml(This, xmlString) (This)->lpVtbl->get_xml(This, xmlString)
#define IXMLDOMEntity_transformNode(This, stylesheet, xmlString) (This)->lpVtbl->transformNode(This, stylesheet, xmlString)
#define IXMLDOMEntity_selectNodes(This, queryString, resultList) (This)->lpVtbl->selectNodes(This, queryString, resultList)
#define IXMLDOMEntity_selectSingleNode(This, queryString, resultNode) (This)->lpVtbl->selectSingleNode(This, queryString, resultNode)
#define IXMLDOMEntity_get_parsed(This, isParsed) (This)->lpVtbl->get_parsed(This, isParsed)
#define IXMLDOMEntity_get_namespaceURI(This, namespaceURI) (This)->lpVtbl->get_namespaceURI(This, namespaceURI)
#define IXMLDOMEntity_get_prefix(This, prefixString) (This)->lpVtbl->get_prefix(This, prefixString)
#define IXMLDOMEntity_get_baseName(This, nameString) (This)->lpVtbl->get_baseName(This, nameString)
#define IXMLDOMEntity_transformNodeToObject(This, stylesheet, outputObject) (This)->lpVtbl->transformNodeToObject(This, stylesheet, outputObject)
#define IXMLDOMEntity_get_publicId(This, publicID) (This)->lpVtbl->get_publicId(This, publicID)
#define IXMLDOMEntity_get_systemId(This, systemID) (This)->lpVtbl->get_systemId(This, systemID)
#define IXMLDOMEntity_get_notationName(This, name) (This)->lpVtbl->get_notationName(This, name)

declare function IXMLDOMEntity_get_publicId_Proxy(byval This as IXMLDOMEntity ptr, byval publicID as VARIANT ptr) as HRESULT
declare sub IXMLDOMEntity_get_publicId_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMEntity_get_systemId_Proxy(byval This as IXMLDOMEntity ptr, byval systemID as VARIANT ptr) as HRESULT
declare sub IXMLDOMEntity_get_systemId_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMEntity_get_notationName_Proxy(byval This as IXMLDOMEntity ptr, byval name as BSTR ptr) as HRESULT
declare sub IXMLDOMEntity_get_notationName_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IXMLDOMEntityReference_INTERFACE_DEFINED__
extern IID_IXMLDOMEntityReference as const IID

type IXMLDOMEntityReferenceVtbl
	QueryInterface as function(byval This as IXMLDOMEntityReference ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IXMLDOMEntityReference ptr) as ULONG
	Release as function(byval This as IXMLDOMEntityReference ptr) as ULONG
	GetTypeInfoCount as function(byval This as IXMLDOMEntityReference ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IXMLDOMEntityReference ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IXMLDOMEntityReference ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IXMLDOMEntityReference ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	get_nodeName as function(byval This as IXMLDOMEntityReference ptr, byval name as BSTR ptr) as HRESULT
	get_nodeValue as function(byval This as IXMLDOMEntityReference ptr, byval value as VARIANT ptr) as HRESULT
	put_nodeValue as function(byval This as IXMLDOMEntityReference ptr, byval value as VARIANT) as HRESULT
	get_nodeType as function(byval This as IXMLDOMEntityReference ptr, byval type as DOMNodeType ptr) as HRESULT
	get_parentNode as function(byval This as IXMLDOMEntityReference ptr, byval parent as IXMLDOMNode ptr ptr) as HRESULT
	get_childNodes as function(byval This as IXMLDOMEntityReference ptr, byval childList as IXMLDOMNodeList ptr ptr) as HRESULT
	get_firstChild as function(byval This as IXMLDOMEntityReference ptr, byval firstChild as IXMLDOMNode ptr ptr) as HRESULT
	get_lastChild as function(byval This as IXMLDOMEntityReference ptr, byval lastChild as IXMLDOMNode ptr ptr) as HRESULT
	get_previousSibling as function(byval This as IXMLDOMEntityReference ptr, byval previousSibling as IXMLDOMNode ptr ptr) as HRESULT
	get_nextSibling as function(byval This as IXMLDOMEntityReference ptr, byval nextSibling as IXMLDOMNode ptr ptr) as HRESULT
	get_attributes as function(byval This as IXMLDOMEntityReference ptr, byval attributeMap as IXMLDOMNamedNodeMap ptr ptr) as HRESULT
	insertBefore as function(byval This as IXMLDOMEntityReference ptr, byval newChild as IXMLDOMNode ptr, byval refChild as VARIANT, byval outNewChild as IXMLDOMNode ptr ptr) as HRESULT
	replaceChild as function(byval This as IXMLDOMEntityReference ptr, byval newChild as IXMLDOMNode ptr, byval oldChild as IXMLDOMNode ptr, byval outOldChild as IXMLDOMNode ptr ptr) as HRESULT
	removeChild as function(byval This as IXMLDOMEntityReference ptr, byval childNode as IXMLDOMNode ptr, byval oldChild as IXMLDOMNode ptr ptr) as HRESULT
	appendChild as function(byval This as IXMLDOMEntityReference ptr, byval newChild as IXMLDOMNode ptr, byval outNewChild as IXMLDOMNode ptr ptr) as HRESULT
	hasChildNodes as function(byval This as IXMLDOMEntityReference ptr, byval hasChild as VARIANT_BOOL ptr) as HRESULT
	get_ownerDocument as function(byval This as IXMLDOMEntityReference ptr, byval DOMDocument as IXMLDOMDocument ptr ptr) as HRESULT
	cloneNode as function(byval This as IXMLDOMEntityReference ptr, byval deep as VARIANT_BOOL, byval cloneRoot as IXMLDOMNode ptr ptr) as HRESULT
	get_nodeTypeString as function(byval This as IXMLDOMEntityReference ptr, byval nodeType as BSTR ptr) as HRESULT
	get_text as function(byval This as IXMLDOMEntityReference ptr, byval text as BSTR ptr) as HRESULT
	put_text as function(byval This as IXMLDOMEntityReference ptr, byval text as BSTR) as HRESULT
	get_specified as function(byval This as IXMLDOMEntityReference ptr, byval isSpecified as VARIANT_BOOL ptr) as HRESULT
	get_definition as function(byval This as IXMLDOMEntityReference ptr, byval definitionNode as IXMLDOMNode ptr ptr) as HRESULT
	get_nodeTypedValue as function(byval This as IXMLDOMEntityReference ptr, byval typedValue as VARIANT ptr) as HRESULT
	put_nodeTypedValue as function(byval This as IXMLDOMEntityReference ptr, byval typedValue as VARIANT) as HRESULT
	get_dataType as function(byval This as IXMLDOMEntityReference ptr, byval dataTypeName as VARIANT ptr) as HRESULT
	put_dataType as function(byval This as IXMLDOMEntityReference ptr, byval dataTypeName as BSTR) as HRESULT
	get_xml as function(byval This as IXMLDOMEntityReference ptr, byval xmlString as BSTR ptr) as HRESULT
	transformNode as function(byval This as IXMLDOMEntityReference ptr, byval stylesheet as IXMLDOMNode ptr, byval xmlString as BSTR ptr) as HRESULT
	selectNodes as function(byval This as IXMLDOMEntityReference ptr, byval queryString as BSTR, byval resultList as IXMLDOMNodeList ptr ptr) as HRESULT
	selectSingleNode as function(byval This as IXMLDOMEntityReference ptr, byval queryString as BSTR, byval resultNode as IXMLDOMNode ptr ptr) as HRESULT
	get_parsed as function(byval This as IXMLDOMEntityReference ptr, byval isParsed as VARIANT_BOOL ptr) as HRESULT
	get_namespaceURI as function(byval This as IXMLDOMEntityReference ptr, byval namespaceURI as BSTR ptr) as HRESULT
	get_prefix as function(byval This as IXMLDOMEntityReference ptr, byval prefixString as BSTR ptr) as HRESULT
	get_baseName as function(byval This as IXMLDOMEntityReference ptr, byval nameString as BSTR ptr) as HRESULT
	transformNodeToObject as function(byval This as IXMLDOMEntityReference ptr, byval stylesheet as IXMLDOMNode ptr, byval outputObject as VARIANT) as HRESULT
end type

type IXMLDOMEntityReference_
	lpVtbl as IXMLDOMEntityReferenceVtbl ptr
end type

#define IXMLDOMEntityReference_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IXMLDOMEntityReference_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IXMLDOMEntityReference_Release(This) (This)->lpVtbl->Release(This)
#define IXMLDOMEntityReference_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define IXMLDOMEntityReference_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define IXMLDOMEntityReference_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define IXMLDOMEntityReference_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define IXMLDOMEntityReference_get_nodeName(This, name) (This)->lpVtbl->get_nodeName(This, name)
#define IXMLDOMEntityReference_get_nodeValue(This, value) (This)->lpVtbl->get_nodeValue(This, value)
#define IXMLDOMEntityReference_put_nodeValue(This, value) (This)->lpVtbl->put_nodeValue(This, value)
#define IXMLDOMEntityReference_get_nodeType(This, type) (This)->lpVtbl->get_nodeType(This, type)
#define IXMLDOMEntityReference_get_parentNode(This, parent) (This)->lpVtbl->get_parentNode(This, parent)
#define IXMLDOMEntityReference_get_childNodes(This, childList) (This)->lpVtbl->get_childNodes(This, childList)
#define IXMLDOMEntityReference_get_firstChild(This, firstChild) (This)->lpVtbl->get_firstChild(This, firstChild)
#define IXMLDOMEntityReference_get_lastChild(This, lastChild) (This)->lpVtbl->get_lastChild(This, lastChild)
#define IXMLDOMEntityReference_get_previousSibling(This, previousSibling) (This)->lpVtbl->get_previousSibling(This, previousSibling)
#define IXMLDOMEntityReference_get_nextSibling(This, nextSibling) (This)->lpVtbl->get_nextSibling(This, nextSibling)
#define IXMLDOMEntityReference_get_attributes(This, attributeMap) (This)->lpVtbl->get_attributes(This, attributeMap)
#define IXMLDOMEntityReference_insertBefore(This, newChild, refChild, outNewChild) (This)->lpVtbl->insertBefore(This, newChild, refChild, outNewChild)
#define IXMLDOMEntityReference_replaceChild(This, newChild, oldChild, outOldChild) (This)->lpVtbl->replaceChild(This, newChild, oldChild, outOldChild)
#define IXMLDOMEntityReference_removeChild(This, childNode, oldChild) (This)->lpVtbl->removeChild(This, childNode, oldChild)
#define IXMLDOMEntityReference_appendChild(This, newChild, outNewChild) (This)->lpVtbl->appendChild(This, newChild, outNewChild)
#define IXMLDOMEntityReference_hasChildNodes(This, hasChild) (This)->lpVtbl->hasChildNodes(This, hasChild)
#define IXMLDOMEntityReference_get_ownerDocument(This, DOMDocument) (This)->lpVtbl->get_ownerDocument(This, DOMDocument)
#define IXMLDOMEntityReference_cloneNode(This, deep, cloneRoot) (This)->lpVtbl->cloneNode(This, deep, cloneRoot)
#define IXMLDOMEntityReference_get_nodeTypeString(This, nodeType) (This)->lpVtbl->get_nodeTypeString(This, nodeType)
#define IXMLDOMEntityReference_get_text(This, text) (This)->lpVtbl->get_text(This, text)
#define IXMLDOMEntityReference_put_text(This, text) (This)->lpVtbl->put_text(This, text)
#define IXMLDOMEntityReference_get_specified(This, isSpecified) (This)->lpVtbl->get_specified(This, isSpecified)
#define IXMLDOMEntityReference_get_definition(This, definitionNode) (This)->lpVtbl->get_definition(This, definitionNode)
#define IXMLDOMEntityReference_get_nodeTypedValue(This, typedValue) (This)->lpVtbl->get_nodeTypedValue(This, typedValue)
#define IXMLDOMEntityReference_put_nodeTypedValue(This, typedValue) (This)->lpVtbl->put_nodeTypedValue(This, typedValue)
#define IXMLDOMEntityReference_get_dataType(This, dataTypeName) (This)->lpVtbl->get_dataType(This, dataTypeName)
#define IXMLDOMEntityReference_put_dataType(This, dataTypeName) (This)->lpVtbl->put_dataType(This, dataTypeName)
#define IXMLDOMEntityReference_get_xml(This, xmlString) (This)->lpVtbl->get_xml(This, xmlString)
#define IXMLDOMEntityReference_transformNode(This, stylesheet, xmlString) (This)->lpVtbl->transformNode(This, stylesheet, xmlString)
#define IXMLDOMEntityReference_selectNodes(This, queryString, resultList) (This)->lpVtbl->selectNodes(This, queryString, resultList)
#define IXMLDOMEntityReference_selectSingleNode(This, queryString, resultNode) (This)->lpVtbl->selectSingleNode(This, queryString, resultNode)
#define IXMLDOMEntityReference_get_parsed(This, isParsed) (This)->lpVtbl->get_parsed(This, isParsed)
#define IXMLDOMEntityReference_get_namespaceURI(This, namespaceURI) (This)->lpVtbl->get_namespaceURI(This, namespaceURI)
#define IXMLDOMEntityReference_get_prefix(This, prefixString) (This)->lpVtbl->get_prefix(This, prefixString)
#define IXMLDOMEntityReference_get_baseName(This, nameString) (This)->lpVtbl->get_baseName(This, nameString)
#define IXMLDOMEntityReference_transformNodeToObject(This, stylesheet, outputObject) (This)->lpVtbl->transformNodeToObject(This, stylesheet, outputObject)
#define __IXMLDOMParseError_INTERFACE_DEFINED__
extern IID_IXMLDOMParseError as const IID

type IXMLDOMParseErrorVtbl
	QueryInterface as function(byval This as IXMLDOMParseError ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IXMLDOMParseError ptr) as ULONG
	Release as function(byval This as IXMLDOMParseError ptr) as ULONG
	GetTypeInfoCount as function(byval This as IXMLDOMParseError ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IXMLDOMParseError ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IXMLDOMParseError ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IXMLDOMParseError ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	get_errorCode as function(byval This as IXMLDOMParseError ptr, byval errorCode as LONG ptr) as HRESULT
	get_url as function(byval This as IXMLDOMParseError ptr, byval urlString as BSTR ptr) as HRESULT
	get_reason as function(byval This as IXMLDOMParseError ptr, byval reasonString as BSTR ptr) as HRESULT
	get_srcText as function(byval This as IXMLDOMParseError ptr, byval sourceString as BSTR ptr) as HRESULT
	get_line as function(byval This as IXMLDOMParseError ptr, byval lineNumber as LONG ptr) as HRESULT
	get_linepos as function(byval This as IXMLDOMParseError ptr, byval linePosition as LONG ptr) as HRESULT
	get_filepos as function(byval This as IXMLDOMParseError ptr, byval filePosition as LONG ptr) as HRESULT
end type

type IXMLDOMParseError_
	lpVtbl as IXMLDOMParseErrorVtbl ptr
end type

#define IXMLDOMParseError_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IXMLDOMParseError_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IXMLDOMParseError_Release(This) (This)->lpVtbl->Release(This)
#define IXMLDOMParseError_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define IXMLDOMParseError_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define IXMLDOMParseError_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define IXMLDOMParseError_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define IXMLDOMParseError_get_errorCode(This, errorCode) (This)->lpVtbl->get_errorCode(This, errorCode)
#define IXMLDOMParseError_get_url(This, urlString) (This)->lpVtbl->get_url(This, urlString)
#define IXMLDOMParseError_get_reason(This, reasonString) (This)->lpVtbl->get_reason(This, reasonString)
#define IXMLDOMParseError_get_srcText(This, sourceString) (This)->lpVtbl->get_srcText(This, sourceString)
#define IXMLDOMParseError_get_line(This, lineNumber) (This)->lpVtbl->get_line(This, lineNumber)
#define IXMLDOMParseError_get_linepos(This, linePosition) (This)->lpVtbl->get_linepos(This, linePosition)
#define IXMLDOMParseError_get_filepos(This, filePosition) (This)->lpVtbl->get_filepos(This, filePosition)

declare function IXMLDOMParseError_get_errorCode_Proxy(byval This as IXMLDOMParseError ptr, byval errorCode as LONG ptr) as HRESULT
declare sub IXMLDOMParseError_get_errorCode_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMParseError_get_url_Proxy(byval This as IXMLDOMParseError ptr, byval urlString as BSTR ptr) as HRESULT
declare sub IXMLDOMParseError_get_url_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMParseError_get_reason_Proxy(byval This as IXMLDOMParseError ptr, byval reasonString as BSTR ptr) as HRESULT
declare sub IXMLDOMParseError_get_reason_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMParseError_get_srcText_Proxy(byval This as IXMLDOMParseError ptr, byval sourceString as BSTR ptr) as HRESULT
declare sub IXMLDOMParseError_get_srcText_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMParseError_get_line_Proxy(byval This as IXMLDOMParseError ptr, byval lineNumber as LONG ptr) as HRESULT
declare sub IXMLDOMParseError_get_line_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMParseError_get_linepos_Proxy(byval This as IXMLDOMParseError ptr, byval linePosition as LONG ptr) as HRESULT
declare sub IXMLDOMParseError_get_linepos_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMParseError_get_filepos_Proxy(byval This as IXMLDOMParseError ptr, byval filePosition as LONG ptr) as HRESULT
declare sub IXMLDOMParseError_get_filepos_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IXTLRuntime_INTERFACE_DEFINED__
extern IID_IXTLRuntime as const IID
type IXTLRuntime as IXTLRuntime_

type IXTLRuntimeVtbl
	QueryInterface as function(byval This as IXTLRuntime ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IXTLRuntime ptr) as ULONG
	Release as function(byval This as IXTLRuntime ptr) as ULONG
	GetTypeInfoCount as function(byval This as IXTLRuntime ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IXTLRuntime ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IXTLRuntime ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IXTLRuntime ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	get_nodeName as function(byval This as IXTLRuntime ptr, byval name as BSTR ptr) as HRESULT
	get_nodeValue as function(byval This as IXTLRuntime ptr, byval value as VARIANT ptr) as HRESULT
	put_nodeValue as function(byval This as IXTLRuntime ptr, byval value as VARIANT) as HRESULT
	get_nodeType as function(byval This as IXTLRuntime ptr, byval type as DOMNodeType ptr) as HRESULT
	get_parentNode as function(byval This as IXTLRuntime ptr, byval parent as IXMLDOMNode ptr ptr) as HRESULT
	get_childNodes as function(byval This as IXTLRuntime ptr, byval childList as IXMLDOMNodeList ptr ptr) as HRESULT
	get_firstChild as function(byval This as IXTLRuntime ptr, byval firstChild as IXMLDOMNode ptr ptr) as HRESULT
	get_lastChild as function(byval This as IXTLRuntime ptr, byval lastChild as IXMLDOMNode ptr ptr) as HRESULT
	get_previousSibling as function(byval This as IXTLRuntime ptr, byval previousSibling as IXMLDOMNode ptr ptr) as HRESULT
	get_nextSibling as function(byval This as IXTLRuntime ptr, byval nextSibling as IXMLDOMNode ptr ptr) as HRESULT
	get_attributes as function(byval This as IXTLRuntime ptr, byval attributeMap as IXMLDOMNamedNodeMap ptr ptr) as HRESULT
	insertBefore as function(byval This as IXTLRuntime ptr, byval newChild as IXMLDOMNode ptr, byval refChild as VARIANT, byval outNewChild as IXMLDOMNode ptr ptr) as HRESULT
	replaceChild as function(byval This as IXTLRuntime ptr, byval newChild as IXMLDOMNode ptr, byval oldChild as IXMLDOMNode ptr, byval outOldChild as IXMLDOMNode ptr ptr) as HRESULT
	removeChild as function(byval This as IXTLRuntime ptr, byval childNode as IXMLDOMNode ptr, byval oldChild as IXMLDOMNode ptr ptr) as HRESULT
	appendChild as function(byval This as IXTLRuntime ptr, byval newChild as IXMLDOMNode ptr, byval outNewChild as IXMLDOMNode ptr ptr) as HRESULT
	hasChildNodes as function(byval This as IXTLRuntime ptr, byval hasChild as VARIANT_BOOL ptr) as HRESULT
	get_ownerDocument as function(byval This as IXTLRuntime ptr, byval DOMDocument as IXMLDOMDocument ptr ptr) as HRESULT
	cloneNode as function(byval This as IXTLRuntime ptr, byval deep as VARIANT_BOOL, byval cloneRoot as IXMLDOMNode ptr ptr) as HRESULT
	get_nodeTypeString as function(byval This as IXTLRuntime ptr, byval nodeType as BSTR ptr) as HRESULT
	get_text as function(byval This as IXTLRuntime ptr, byval text as BSTR ptr) as HRESULT
	put_text as function(byval This as IXTLRuntime ptr, byval text as BSTR) as HRESULT
	get_specified as function(byval This as IXTLRuntime ptr, byval isSpecified as VARIANT_BOOL ptr) as HRESULT
	get_definition as function(byval This as IXTLRuntime ptr, byval definitionNode as IXMLDOMNode ptr ptr) as HRESULT
	get_nodeTypedValue as function(byval This as IXTLRuntime ptr, byval typedValue as VARIANT ptr) as HRESULT
	put_nodeTypedValue as function(byval This as IXTLRuntime ptr, byval typedValue as VARIANT) as HRESULT
	get_dataType as function(byval This as IXTLRuntime ptr, byval dataTypeName as VARIANT ptr) as HRESULT
	put_dataType as function(byval This as IXTLRuntime ptr, byval dataTypeName as BSTR) as HRESULT
	get_xml as function(byval This as IXTLRuntime ptr, byval xmlString as BSTR ptr) as HRESULT
	transformNode as function(byval This as IXTLRuntime ptr, byval stylesheet as IXMLDOMNode ptr, byval xmlString as BSTR ptr) as HRESULT
	selectNodes as function(byval This as IXTLRuntime ptr, byval queryString as BSTR, byval resultList as IXMLDOMNodeList ptr ptr) as HRESULT
	selectSingleNode as function(byval This as IXTLRuntime ptr, byval queryString as BSTR, byval resultNode as IXMLDOMNode ptr ptr) as HRESULT
	get_parsed as function(byval This as IXTLRuntime ptr, byval isParsed as VARIANT_BOOL ptr) as HRESULT
	get_namespaceURI as function(byval This as IXTLRuntime ptr, byval namespaceURI as BSTR ptr) as HRESULT
	get_prefix as function(byval This as IXTLRuntime ptr, byval prefixString as BSTR ptr) as HRESULT
	get_baseName as function(byval This as IXTLRuntime ptr, byval nameString as BSTR ptr) as HRESULT
	transformNodeToObject as function(byval This as IXTLRuntime ptr, byval stylesheet as IXMLDOMNode ptr, byval outputObject as VARIANT) as HRESULT
	uniqueID as function(byval This as IXTLRuntime ptr, byval pNode as IXMLDOMNode ptr, byval pID as LONG ptr) as HRESULT
	depth as function(byval This as IXTLRuntime ptr, byval pNode as IXMLDOMNode ptr, byval pDepth as LONG ptr) as HRESULT
	childNumber as function(byval This as IXTLRuntime ptr, byval pNode as IXMLDOMNode ptr, byval pNumber as LONG ptr) as HRESULT
	ancestorChildNumber as function(byval This as IXTLRuntime ptr, byval bstrNodeName as BSTR, byval pNode as IXMLDOMNode ptr, byval pNumber as LONG ptr) as HRESULT
	absoluteChildNumber as function(byval This as IXTLRuntime ptr, byval pNode as IXMLDOMNode ptr, byval pNumber as LONG ptr) as HRESULT
	formatIndex as function(byval This as IXTLRuntime ptr, byval lIndex as LONG, byval bstrFormat as BSTR, byval pbstrFormattedString as BSTR ptr) as HRESULT
	formatNumber as function(byval This as IXTLRuntime ptr, byval dblNumber as double, byval bstrFormat as BSTR, byval pbstrFormattedString as BSTR ptr) as HRESULT
	formatDate as function(byval This as IXTLRuntime ptr, byval varDate as VARIANT, byval bstrFormat as BSTR, byval varDestLocale as VARIANT, byval pbstrFormattedString as BSTR ptr) as HRESULT
	formatTime as function(byval This as IXTLRuntime ptr, byval varTime as VARIANT, byval bstrFormat as BSTR, byval varDestLocale as VARIANT, byval pbstrFormattedString as BSTR ptr) as HRESULT
end type

type IXTLRuntime_
	lpVtbl as IXTLRuntimeVtbl ptr
end type

#define IXTLRuntime_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IXTLRuntime_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IXTLRuntime_Release(This) (This)->lpVtbl->Release(This)
#define IXTLRuntime_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define IXTLRuntime_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define IXTLRuntime_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define IXTLRuntime_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define IXTLRuntime_get_nodeName(This, name) (This)->lpVtbl->get_nodeName(This, name)
#define IXTLRuntime_get_nodeValue(This, value) (This)->lpVtbl->get_nodeValue(This, value)
#define IXTLRuntime_put_nodeValue(This, value) (This)->lpVtbl->put_nodeValue(This, value)
#define IXTLRuntime_get_nodeType(This, type) (This)->lpVtbl->get_nodeType(This, type)
#define IXTLRuntime_get_parentNode(This, parent) (This)->lpVtbl->get_parentNode(This, parent)
#define IXTLRuntime_get_childNodes(This, childList) (This)->lpVtbl->get_childNodes(This, childList)
#define IXTLRuntime_get_firstChild(This, firstChild) (This)->lpVtbl->get_firstChild(This, firstChild)
#define IXTLRuntime_get_lastChild(This, lastChild) (This)->lpVtbl->get_lastChild(This, lastChild)
#define IXTLRuntime_get_previousSibling(This, previousSibling) (This)->lpVtbl->get_previousSibling(This, previousSibling)
#define IXTLRuntime_get_nextSibling(This, nextSibling) (This)->lpVtbl->get_nextSibling(This, nextSibling)
#define IXTLRuntime_get_attributes(This, attributeMap) (This)->lpVtbl->get_attributes(This, attributeMap)
#define IXTLRuntime_insertBefore(This, newChild, refChild, outNewChild) (This)->lpVtbl->insertBefore(This, newChild, refChild, outNewChild)
#define IXTLRuntime_replaceChild(This, newChild, oldChild, outOldChild) (This)->lpVtbl->replaceChild(This, newChild, oldChild, outOldChild)
#define IXTLRuntime_removeChild(This, childNode, oldChild) (This)->lpVtbl->removeChild(This, childNode, oldChild)
#define IXTLRuntime_appendChild(This, newChild, outNewChild) (This)->lpVtbl->appendChild(This, newChild, outNewChild)
#define IXTLRuntime_hasChildNodes(This, hasChild) (This)->lpVtbl->hasChildNodes(This, hasChild)
#define IXTLRuntime_get_ownerDocument(This, DOMDocument) (This)->lpVtbl->get_ownerDocument(This, DOMDocument)
#define IXTLRuntime_cloneNode(This, deep, cloneRoot) (This)->lpVtbl->cloneNode(This, deep, cloneRoot)
#define IXTLRuntime_get_nodeTypeString(This, nodeType) (This)->lpVtbl->get_nodeTypeString(This, nodeType)
#define IXTLRuntime_get_text(This, text) (This)->lpVtbl->get_text(This, text)
#define IXTLRuntime_put_text(This, text) (This)->lpVtbl->put_text(This, text)
#define IXTLRuntime_get_specified(This, isSpecified) (This)->lpVtbl->get_specified(This, isSpecified)
#define IXTLRuntime_get_definition(This, definitionNode) (This)->lpVtbl->get_definition(This, definitionNode)
#define IXTLRuntime_get_nodeTypedValue(This, typedValue) (This)->lpVtbl->get_nodeTypedValue(This, typedValue)
#define IXTLRuntime_put_nodeTypedValue(This, typedValue) (This)->lpVtbl->put_nodeTypedValue(This, typedValue)
#define IXTLRuntime_get_dataType(This, dataTypeName) (This)->lpVtbl->get_dataType(This, dataTypeName)
#define IXTLRuntime_put_dataType(This, dataTypeName) (This)->lpVtbl->put_dataType(This, dataTypeName)
#define IXTLRuntime_get_xml(This, xmlString) (This)->lpVtbl->get_xml(This, xmlString)
#define IXTLRuntime_transformNode(This, stylesheet, xmlString) (This)->lpVtbl->transformNode(This, stylesheet, xmlString)
#define IXTLRuntime_selectNodes(This, queryString, resultList) (This)->lpVtbl->selectNodes(This, queryString, resultList)
#define IXTLRuntime_selectSingleNode(This, queryString, resultNode) (This)->lpVtbl->selectSingleNode(This, queryString, resultNode)
#define IXTLRuntime_get_parsed(This, isParsed) (This)->lpVtbl->get_parsed(This, isParsed)
#define IXTLRuntime_get_namespaceURI(This, namespaceURI) (This)->lpVtbl->get_namespaceURI(This, namespaceURI)
#define IXTLRuntime_get_prefix(This, prefixString) (This)->lpVtbl->get_prefix(This, prefixString)
#define IXTLRuntime_get_baseName(This, nameString) (This)->lpVtbl->get_baseName(This, nameString)
#define IXTLRuntime_transformNodeToObject(This, stylesheet, outputObject) (This)->lpVtbl->transformNodeToObject(This, stylesheet, outputObject)
#define IXTLRuntime_uniqueID(This, pNode, pID) (This)->lpVtbl->uniqueID(This, pNode, pID)
#define IXTLRuntime_depth(This, pNode, pDepth) (This)->lpVtbl->depth(This, pNode, pDepth)
#define IXTLRuntime_childNumber(This, pNode, pNumber) (This)->lpVtbl->childNumber(This, pNode, pNumber)
#define IXTLRuntime_ancestorChildNumber(This, bstrNodeName, pNode, pNumber) (This)->lpVtbl->ancestorChildNumber(This, bstrNodeName, pNode, pNumber)
#define IXTLRuntime_absoluteChildNumber(This, pNode, pNumber) (This)->lpVtbl->absoluteChildNumber(This, pNode, pNumber)
#define IXTLRuntime_formatIndex(This, lIndex, bstrFormat, pbstrFormattedString) (This)->lpVtbl->formatIndex(This, lIndex, bstrFormat, pbstrFormattedString)
#define IXTLRuntime_formatNumber(This, dblNumber, bstrFormat, pbstrFormattedString) (This)->lpVtbl->formatNumber(This, dblNumber, bstrFormat, pbstrFormattedString)
#define IXTLRuntime_formatDate(This, varDate, bstrFormat, varDestLocale, pbstrFormattedString) (This)->lpVtbl->formatDate(This, varDate, bstrFormat, varDestLocale, pbstrFormattedString)
#define IXTLRuntime_formatTime(This, varTime, bstrFormat, varDestLocale, pbstrFormattedString) (This)->lpVtbl->formatTime(This, varTime, bstrFormat, varDestLocale, pbstrFormattedString)

declare function IXTLRuntime_uniqueID_Proxy(byval This as IXTLRuntime ptr, byval pNode as IXMLDOMNode ptr, byval pID as LONG ptr) as HRESULT
declare sub IXTLRuntime_uniqueID_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXTLRuntime_depth_Proxy(byval This as IXTLRuntime ptr, byval pNode as IXMLDOMNode ptr, byval pDepth as LONG ptr) as HRESULT
declare sub IXTLRuntime_depth_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXTLRuntime_childNumber_Proxy(byval This as IXTLRuntime ptr, byval pNode as IXMLDOMNode ptr, byval pNumber as LONG ptr) as HRESULT
declare sub IXTLRuntime_childNumber_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXTLRuntime_ancestorChildNumber_Proxy(byval This as IXTLRuntime ptr, byval bstrNodeName as BSTR, byval pNode as IXMLDOMNode ptr, byval pNumber as LONG ptr) as HRESULT
declare sub IXTLRuntime_ancestorChildNumber_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXTLRuntime_absoluteChildNumber_Proxy(byval This as IXTLRuntime ptr, byval pNode as IXMLDOMNode ptr, byval pNumber as LONG ptr) as HRESULT
declare sub IXTLRuntime_absoluteChildNumber_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXTLRuntime_formatIndex_Proxy(byval This as IXTLRuntime ptr, byval lIndex as LONG, byval bstrFormat as BSTR, byval pbstrFormattedString as BSTR ptr) as HRESULT
declare sub IXTLRuntime_formatIndex_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXTLRuntime_formatNumber_Proxy(byval This as IXTLRuntime ptr, byval dblNumber as double, byval bstrFormat as BSTR, byval pbstrFormattedString as BSTR ptr) as HRESULT
declare sub IXTLRuntime_formatNumber_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXTLRuntime_formatDate_Proxy(byval This as IXTLRuntime ptr, byval varDate as VARIANT, byval bstrFormat as BSTR, byval varDestLocale as VARIANT, byval pbstrFormattedString as BSTR ptr) as HRESULT
declare sub IXTLRuntime_formatDate_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXTLRuntime_formatTime_Proxy(byval This as IXTLRuntime ptr, byval varTime as VARIANT, byval bstrFormat as BSTR, byval varDestLocale as VARIANT, byval pbstrFormattedString as BSTR ptr) as HRESULT
declare sub IXTLRuntime_formatTime_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __XMLDOMDocumentEvents_DISPINTERFACE_DEFINED__
extern DIID_XMLDOMDocumentEvents as const IID
type XMLDOMDocumentEvents as XMLDOMDocumentEvents_

type XMLDOMDocumentEventsVtbl
	QueryInterface as function(byval This as XMLDOMDocumentEvents ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as XMLDOMDocumentEvents ptr) as ULONG
	Release as function(byval This as XMLDOMDocumentEvents ptr) as ULONG
	GetTypeInfoCount as function(byval This as XMLDOMDocumentEvents ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as XMLDOMDocumentEvents ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as XMLDOMDocumentEvents ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as XMLDOMDocumentEvents ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
end type

type XMLDOMDocumentEvents_
	lpVtbl as XMLDOMDocumentEventsVtbl ptr
end type

#define XMLDOMDocumentEvents_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define XMLDOMDocumentEvents_AddRef(This) (This)->lpVtbl->AddRef(This)
#define XMLDOMDocumentEvents_Release(This) (This)->lpVtbl->Release(This)
#define XMLDOMDocumentEvents_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define XMLDOMDocumentEvents_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define XMLDOMDocumentEvents_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define XMLDOMDocumentEvents_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
extern CLSID_DOMDocument as const CLSID
extern CLSID_DOMFreeThreadedDocument as const CLSID
#define __IXMLHttpRequest_INTERFACE_DEFINED__
extern IID_IXMLHttpRequest as const IID
type IXMLHttpRequest as IXMLHttpRequest_

type IXMLHttpRequestVtbl
	QueryInterface as function(byval This as IXMLHttpRequest ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IXMLHttpRequest ptr) as ULONG
	Release as function(byval This as IXMLHttpRequest ptr) as ULONG
	GetTypeInfoCount as function(byval This as IXMLHttpRequest ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IXMLHttpRequest ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IXMLHttpRequest ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IXMLHttpRequest ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	open as function(byval This as IXMLHttpRequest ptr, byval bstrMethod as BSTR, byval bstrUrl as BSTR, byval varAsync as VARIANT, byval bstrUser as VARIANT, byval bstrPassword as VARIANT) as HRESULT
	setRequestHeader as function(byval This as IXMLHttpRequest ptr, byval bstrHeader as BSTR, byval bstrValue as BSTR) as HRESULT
	getResponseHeader as function(byval This as IXMLHttpRequest ptr, byval bstrHeader as BSTR, byval pbstrValue as BSTR ptr) as HRESULT
	getAllResponseHeaders as function(byval This as IXMLHttpRequest ptr, byval pbstrHeaders as BSTR ptr) as HRESULT
	send as function(byval This as IXMLHttpRequest ptr, byval varBody as VARIANT) as HRESULT
	abort as function(byval This as IXMLHttpRequest ptr) as HRESULT
	get_status as function(byval This as IXMLHttpRequest ptr, byval plStatus as LONG ptr) as HRESULT
	get_statusText as function(byval This as IXMLHttpRequest ptr, byval pbstrStatus as BSTR ptr) as HRESULT
	get_responseXML as function(byval This as IXMLHttpRequest ptr, byval ppBody as IDispatch ptr ptr) as HRESULT
	get_responseText as function(byval This as IXMLHttpRequest ptr, byval pbstrBody as BSTR ptr) as HRESULT
	get_responseBody as function(byval This as IXMLHttpRequest ptr, byval pvarBody as VARIANT ptr) as HRESULT
	get_responseStream as function(byval This as IXMLHttpRequest ptr, byval pvarBody as VARIANT ptr) as HRESULT
	get_readyState as function(byval This as IXMLHttpRequest ptr, byval plState as LONG ptr) as HRESULT
	put_onreadystatechange as function(byval This as IXMLHttpRequest ptr, byval pReadyStateSink as IDispatch ptr) as HRESULT
end type

type IXMLHttpRequest_
	lpVtbl as IXMLHttpRequestVtbl ptr
end type

#define IXMLHttpRequest_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IXMLHttpRequest_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IXMLHttpRequest_Release(This) (This)->lpVtbl->Release(This)
#define IXMLHttpRequest_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define IXMLHttpRequest_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define IXMLHttpRequest_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define IXMLHttpRequest_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define IXMLHttpRequest_open(This, bstrMethod, bstrUrl, varAsync, bstrUser, bstrPassword) (This)->lpVtbl->open(This, bstrMethod, bstrUrl, varAsync, bstrUser, bstrPassword)
#define IXMLHttpRequest_setRequestHeader(This, bstrHeader, bstrValue) (This)->lpVtbl->setRequestHeader(This, bstrHeader, bstrValue)
#define IXMLHttpRequest_getResponseHeader(This, bstrHeader, pbstrValue) (This)->lpVtbl->getResponseHeader(This, bstrHeader, pbstrValue)
#define IXMLHttpRequest_getAllResponseHeaders(This, pbstrHeaders) (This)->lpVtbl->getAllResponseHeaders(This, pbstrHeaders)
#define IXMLHttpRequest_send(This, varBody) (This)->lpVtbl->send(This, varBody)
#define IXMLHttpRequest_abort(This) (This)->lpVtbl->abort(This)
#define IXMLHttpRequest_get_status(This, plStatus) (This)->lpVtbl->get_status(This, plStatus)
#define IXMLHttpRequest_get_statusText(This, pbstrStatus) (This)->lpVtbl->get_statusText(This, pbstrStatus)
#define IXMLHttpRequest_get_responseXML(This, ppBody) (This)->lpVtbl->get_responseXML(This, ppBody)
#define IXMLHttpRequest_get_responseText(This, pbstrBody) (This)->lpVtbl->get_responseText(This, pbstrBody)
#define IXMLHttpRequest_get_responseBody(This, pvarBody) (This)->lpVtbl->get_responseBody(This, pvarBody)
#define IXMLHttpRequest_get_responseStream(This, pvarBody) (This)->lpVtbl->get_responseStream(This, pvarBody)
#define IXMLHttpRequest_get_readyState(This, plState) (This)->lpVtbl->get_readyState(This, plState)
#define IXMLHttpRequest_put_onreadystatechange(This, pReadyStateSink) (This)->lpVtbl->put_onreadystatechange(This, pReadyStateSink)

declare function IXMLHttpRequest_open_Proxy(byval This as IXMLHttpRequest ptr, byval bstrMethod as BSTR, byval bstrUrl as BSTR, byval varAsync as VARIANT, byval bstrUser as VARIANT, byval bstrPassword as VARIANT) as HRESULT
declare sub IXMLHttpRequest_open_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLHttpRequest_setRequestHeader_Proxy(byval This as IXMLHttpRequest ptr, byval bstrHeader as BSTR, byval bstrValue as BSTR) as HRESULT
declare sub IXMLHttpRequest_setRequestHeader_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLHttpRequest_getResponseHeader_Proxy(byval This as IXMLHttpRequest ptr, byval bstrHeader as BSTR, byval pbstrValue as BSTR ptr) as HRESULT
declare sub IXMLHttpRequest_getResponseHeader_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLHttpRequest_getAllResponseHeaders_Proxy(byval This as IXMLHttpRequest ptr, byval pbstrHeaders as BSTR ptr) as HRESULT
declare sub IXMLHttpRequest_getAllResponseHeaders_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLHttpRequest_send_Proxy(byval This as IXMLHttpRequest ptr, byval varBody as VARIANT) as HRESULT
declare sub IXMLHttpRequest_send_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLHttpRequest_abort_Proxy(byval This as IXMLHttpRequest ptr) as HRESULT
declare sub IXMLHttpRequest_abort_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLHttpRequest_get_status_Proxy(byval This as IXMLHttpRequest ptr, byval plStatus as LONG ptr) as HRESULT
declare sub IXMLHttpRequest_get_status_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLHttpRequest_get_statusText_Proxy(byval This as IXMLHttpRequest ptr, byval pbstrStatus as BSTR ptr) as HRESULT
declare sub IXMLHttpRequest_get_statusText_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLHttpRequest_get_responseXML_Proxy(byval This as IXMLHttpRequest ptr, byval ppBody as IDispatch ptr ptr) as HRESULT
declare sub IXMLHttpRequest_get_responseXML_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLHttpRequest_get_responseText_Proxy(byval This as IXMLHttpRequest ptr, byval pbstrBody as BSTR ptr) as HRESULT
declare sub IXMLHttpRequest_get_responseText_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLHttpRequest_get_responseBody_Proxy(byval This as IXMLHttpRequest ptr, byval pvarBody as VARIANT ptr) as HRESULT
declare sub IXMLHttpRequest_get_responseBody_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLHttpRequest_get_responseStream_Proxy(byval This as IXMLHttpRequest ptr, byval pvarBody as VARIANT ptr) as HRESULT
declare sub IXMLHttpRequest_get_responseStream_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLHttpRequest_get_readyState_Proxy(byval This as IXMLHttpRequest ptr, byval plState as LONG ptr) as HRESULT
declare sub IXMLHttpRequest_get_readyState_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLHttpRequest_put_onreadystatechange_Proxy(byval This as IXMLHttpRequest ptr, byval pReadyStateSink as IDispatch ptr) as HRESULT
declare sub IXMLHttpRequest_put_onreadystatechange_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
extern CLSID_XMLHTTPRequest as const CLSID
#define __IXMLDSOControl_INTERFACE_DEFINED__
extern IID_IXMLDSOControl as const IID
type IXMLDSOControl as IXMLDSOControl_

type IXMLDSOControlVtbl
	QueryInterface as function(byval This as IXMLDSOControl ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IXMLDSOControl ptr) as ULONG
	Release as function(byval This as IXMLDSOControl ptr) as ULONG
	GetTypeInfoCount as function(byval This as IXMLDSOControl ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IXMLDSOControl ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IXMLDSOControl ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IXMLDSOControl ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	get_XMLDocument as function(byval This as IXMLDSOControl ptr, byval ppDoc as IXMLDOMDocument ptr ptr) as HRESULT
	put_XMLDocument as function(byval This as IXMLDSOControl ptr, byval ppDoc as IXMLDOMDocument ptr) as HRESULT
	get_JavaDSOCompatible as function(byval This as IXMLDSOControl ptr, byval fJavaDSOCompatible as WINBOOL ptr) as HRESULT
	put_JavaDSOCompatible as function(byval This as IXMLDSOControl ptr, byval fJavaDSOCompatible as WINBOOL) as HRESULT
	get_readyState as function(byval This as IXMLDSOControl ptr, byval state as LONG ptr) as HRESULT
end type

type IXMLDSOControl_
	lpVtbl as IXMLDSOControlVtbl ptr
end type

#define IXMLDSOControl_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IXMLDSOControl_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IXMLDSOControl_Release(This) (This)->lpVtbl->Release(This)
#define IXMLDSOControl_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define IXMLDSOControl_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define IXMLDSOControl_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define IXMLDSOControl_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define IXMLDSOControl_get_XMLDocument(This, ppDoc) (This)->lpVtbl->get_XMLDocument(This, ppDoc)
#define IXMLDSOControl_put_XMLDocument(This, ppDoc) (This)->lpVtbl->put_XMLDocument(This, ppDoc)
#define IXMLDSOControl_get_JavaDSOCompatible(This, fJavaDSOCompatible) (This)->lpVtbl->get_JavaDSOCompatible(This, fJavaDSOCompatible)
#define IXMLDSOControl_put_JavaDSOCompatible(This, fJavaDSOCompatible) (This)->lpVtbl->put_JavaDSOCompatible(This, fJavaDSOCompatible)
#define IXMLDSOControl_get_readyState(This, state) (This)->lpVtbl->get_readyState(This, state)

declare function IXMLDSOControl_get_XMLDocument_Proxy(byval This as IXMLDSOControl ptr, byval ppDoc as IXMLDOMDocument ptr ptr) as HRESULT
declare sub IXMLDSOControl_get_XMLDocument_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDSOControl_put_XMLDocument_Proxy(byval This as IXMLDSOControl ptr, byval ppDoc as IXMLDOMDocument ptr) as HRESULT
declare sub IXMLDSOControl_put_XMLDocument_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDSOControl_get_JavaDSOCompatible_Proxy(byval This as IXMLDSOControl ptr, byval fJavaDSOCompatible as WINBOOL ptr) as HRESULT
declare sub IXMLDSOControl_get_JavaDSOCompatible_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDSOControl_put_JavaDSOCompatible_Proxy(byval This as IXMLDSOControl ptr, byval fJavaDSOCompatible as WINBOOL) as HRESULT
declare sub IXMLDSOControl_put_JavaDSOCompatible_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDSOControl_get_readyState_Proxy(byval This as IXMLDSOControl ptr, byval state as LONG ptr) as HRESULT
declare sub IXMLDSOControl_get_readyState_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
extern CLSID_XMLDSOControl as const CLSID
#define __IXMLElementCollection_INTERFACE_DEFINED__
extern IID_IXMLElementCollection as const IID
type IXMLElementCollection as IXMLElementCollection_

type IXMLElementCollectionVtbl
	QueryInterface as function(byval This as IXMLElementCollection ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IXMLElementCollection ptr) as ULONG
	Release as function(byval This as IXMLElementCollection ptr) as ULONG
	GetTypeInfoCount as function(byval This as IXMLElementCollection ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IXMLElementCollection ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IXMLElementCollection ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IXMLElementCollection ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	put_length as function(byval This as IXMLElementCollection ptr, byval v as LONG) as HRESULT
	get_length as function(byval This as IXMLElementCollection ptr, byval p as LONG ptr) as HRESULT
	get__newEnum as function(byval This as IXMLElementCollection ptr, byval ppUnk as IUnknown ptr ptr) as HRESULT
	item as function(byval This as IXMLElementCollection ptr, byval var1 as VARIANT, byval var2 as VARIANT, byval ppDisp as IDispatch ptr ptr) as HRESULT
end type

type IXMLElementCollection_
	lpVtbl as IXMLElementCollectionVtbl ptr
end type

#define IXMLElementCollection_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IXMLElementCollection_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IXMLElementCollection_Release(This) (This)->lpVtbl->Release(This)
#define IXMLElementCollection_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define IXMLElementCollection_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define IXMLElementCollection_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define IXMLElementCollection_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define IXMLElementCollection_put_length(This, v) (This)->lpVtbl->put_length(This, v)
#define IXMLElementCollection_get_length(This, p) (This)->lpVtbl->get_length(This, p)
#define IXMLElementCollection_get__newEnum(This, ppUnk) (This)->lpVtbl->get__newEnum(This, ppUnk)
#define IXMLElementCollection_item(This, var1, var2, ppDisp) (This)->lpVtbl->item(This, var1, var2, ppDisp)

declare function IXMLElementCollection_put_length_Proxy(byval This as IXMLElementCollection ptr, byval v as LONG) as HRESULT
declare sub IXMLElementCollection_put_length_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLElementCollection_get_length_Proxy(byval This as IXMLElementCollection ptr, byval p as LONG ptr) as HRESULT
declare sub IXMLElementCollection_get_length_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLElementCollection_get__newEnum_Proxy(byval This as IXMLElementCollection ptr, byval ppUnk as IUnknown ptr ptr) as HRESULT
declare sub IXMLElementCollection_get__newEnum_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLElementCollection_item_Proxy(byval This as IXMLElementCollection ptr, byval var1 as VARIANT, byval var2 as VARIANT, byval ppDisp as IDispatch ptr ptr) as HRESULT
declare sub IXMLElementCollection_item_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IXMLDocument_INTERFACE_DEFINED__
extern IID_IXMLDocument as const IID
type IXMLDocument as IXMLDocument_
type IXMLElement as IXMLElement_

type IXMLDocumentVtbl
	QueryInterface as function(byval This as IXMLDocument ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IXMLDocument ptr) as ULONG
	Release as function(byval This as IXMLDocument ptr) as ULONG
	GetTypeInfoCount as function(byval This as IXMLDocument ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IXMLDocument ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IXMLDocument ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IXMLDocument ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	get_root as function(byval This as IXMLDocument ptr, byval p as IXMLElement ptr ptr) as HRESULT
	get_fileSize as function(byval This as IXMLDocument ptr, byval p as BSTR ptr) as HRESULT
	get_fileModifiedDate as function(byval This as IXMLDocument ptr, byval p as BSTR ptr) as HRESULT
	get_fileUpdatedDate as function(byval This as IXMLDocument ptr, byval p as BSTR ptr) as HRESULT
	get_URL as function(byval This as IXMLDocument ptr, byval p as BSTR ptr) as HRESULT
	put_URL as function(byval This as IXMLDocument ptr, byval p as BSTR) as HRESULT
	get_mimeType as function(byval This as IXMLDocument ptr, byval p as BSTR ptr) as HRESULT
	get_readyState as function(byval This as IXMLDocument ptr, byval pl as LONG ptr) as HRESULT
	get_charset as function(byval This as IXMLDocument ptr, byval p as BSTR ptr) as HRESULT
	put_charset as function(byval This as IXMLDocument ptr, byval p as BSTR) as HRESULT
	get_version as function(byval This as IXMLDocument ptr, byval p as BSTR ptr) as HRESULT
	get_doctype as function(byval This as IXMLDocument ptr, byval p as BSTR ptr) as HRESULT
	get_dtdURL as function(byval This as IXMLDocument ptr, byval p as BSTR ptr) as HRESULT
	createElement as function(byval This as IXMLDocument ptr, byval vType as VARIANT, byval var1 as VARIANT, byval ppElem as IXMLElement ptr ptr) as HRESULT
end type

type IXMLDocument_
	lpVtbl as IXMLDocumentVtbl ptr
end type

#define IXMLDocument_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IXMLDocument_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IXMLDocument_Release(This) (This)->lpVtbl->Release(This)
#define IXMLDocument_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define IXMLDocument_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define IXMLDocument_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define IXMLDocument_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define IXMLDocument_get_root(This, p) (This)->lpVtbl->get_root(This, p)
#define IXMLDocument_get_fileSize(This, p) (This)->lpVtbl->get_fileSize(This, p)
#define IXMLDocument_get_fileModifiedDate(This, p) (This)->lpVtbl->get_fileModifiedDate(This, p)
#define IXMLDocument_get_fileUpdatedDate(This, p) (This)->lpVtbl->get_fileUpdatedDate(This, p)
#define IXMLDocument_get_URL(This, p) (This)->lpVtbl->get_URL(This, p)
#define IXMLDocument_put_URL(This, p) (This)->lpVtbl->put_URL(This, p)
#define IXMLDocument_get_mimeType(This, p) (This)->lpVtbl->get_mimeType(This, p)
#define IXMLDocument_get_readyState(This, pl) (This)->lpVtbl->get_readyState(This, pl)
#define IXMLDocument_get_charset(This, p) (This)->lpVtbl->get_charset(This, p)
#define IXMLDocument_put_charset(This, p) (This)->lpVtbl->put_charset(This, p)
#define IXMLDocument_get_version(This, p) (This)->lpVtbl->get_version(This, p)
#define IXMLDocument_get_doctype(This, p) (This)->lpVtbl->get_doctype(This, p)
#define IXMLDocument_get_dtdURL(This, p) (This)->lpVtbl->get_dtdURL(This, p)
#define IXMLDocument_createElement(This, vType, var1, ppElem) (This)->lpVtbl->createElement(This, vType, var1, ppElem)

declare function IXMLDocument_get_root_Proxy(byval This as IXMLDocument ptr, byval p as IXMLElement ptr ptr) as HRESULT
declare sub IXMLDocument_get_root_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDocument_get_fileSize_Proxy(byval This as IXMLDocument ptr, byval p as BSTR ptr) as HRESULT
declare sub IXMLDocument_get_fileSize_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDocument_get_fileModifiedDate_Proxy(byval This as IXMLDocument ptr, byval p as BSTR ptr) as HRESULT
declare sub IXMLDocument_get_fileModifiedDate_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDocument_get_fileUpdatedDate_Proxy(byval This as IXMLDocument ptr, byval p as BSTR ptr) as HRESULT
declare sub IXMLDocument_get_fileUpdatedDate_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDocument_get_URL_Proxy(byval This as IXMLDocument ptr, byval p as BSTR ptr) as HRESULT
declare sub IXMLDocument_get_URL_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDocument_put_URL_Proxy(byval This as IXMLDocument ptr, byval p as BSTR) as HRESULT
declare sub IXMLDocument_put_URL_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDocument_get_mimeType_Proxy(byval This as IXMLDocument ptr, byval p as BSTR ptr) as HRESULT
declare sub IXMLDocument_get_mimeType_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDocument_get_readyState_Proxy(byval This as IXMLDocument ptr, byval pl as LONG ptr) as HRESULT
declare sub IXMLDocument_get_readyState_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDocument_get_charset_Proxy(byval This as IXMLDocument ptr, byval p as BSTR ptr) as HRESULT
declare sub IXMLDocument_get_charset_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDocument_put_charset_Proxy(byval This as IXMLDocument ptr, byval p as BSTR) as HRESULT
declare sub IXMLDocument_put_charset_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDocument_get_version_Proxy(byval This as IXMLDocument ptr, byval p as BSTR ptr) as HRESULT
declare sub IXMLDocument_get_version_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDocument_get_doctype_Proxy(byval This as IXMLDocument ptr, byval p as BSTR ptr) as HRESULT
declare sub IXMLDocument_get_doctype_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDocument_get_dtdURL_Proxy(byval This as IXMLDocument ptr, byval p as BSTR ptr) as HRESULT
declare sub IXMLDocument_get_dtdURL_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDocument_createElement_Proxy(byval This as IXMLDocument ptr, byval vType as VARIANT, byval var1 as VARIANT, byval ppElem as IXMLElement ptr ptr) as HRESULT
declare sub IXMLDocument_createElement_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IXMLDocument2_INTERFACE_DEFINED__
extern IID_IXMLDocument2 as const IID
type IXMLDocument2 as IXMLDocument2_
type IXMLElement2 as IXMLElement2_

type IXMLDocument2Vtbl
	QueryInterface as function(byval This as IXMLDocument2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IXMLDocument2 ptr) as ULONG
	Release as function(byval This as IXMLDocument2 ptr) as ULONG
	GetTypeInfoCount as function(byval This as IXMLDocument2 ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IXMLDocument2 ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IXMLDocument2 ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IXMLDocument2 ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	get_root as function(byval This as IXMLDocument2 ptr, byval p as IXMLElement2 ptr ptr) as HRESULT
	get_fileSize as function(byval This as IXMLDocument2 ptr, byval p as BSTR ptr) as HRESULT
	get_fileModifiedDate as function(byval This as IXMLDocument2 ptr, byval p as BSTR ptr) as HRESULT
	get_fileUpdatedDate as function(byval This as IXMLDocument2 ptr, byval p as BSTR ptr) as HRESULT
	get_URL as function(byval This as IXMLDocument2 ptr, byval p as BSTR ptr) as HRESULT
	put_URL as function(byval This as IXMLDocument2 ptr, byval p as BSTR) as HRESULT
	get_mimeType as function(byval This as IXMLDocument2 ptr, byval p as BSTR ptr) as HRESULT
	get_readyState as function(byval This as IXMLDocument2 ptr, byval pl as LONG ptr) as HRESULT
	get_charset as function(byval This as IXMLDocument2 ptr, byval p as BSTR ptr) as HRESULT
	put_charset as function(byval This as IXMLDocument2 ptr, byval p as BSTR) as HRESULT
	get_version as function(byval This as IXMLDocument2 ptr, byval p as BSTR ptr) as HRESULT
	get_doctype as function(byval This as IXMLDocument2 ptr, byval p as BSTR ptr) as HRESULT
	get_dtdURL as function(byval This as IXMLDocument2 ptr, byval p as BSTR ptr) as HRESULT
	createElement as function(byval This as IXMLDocument2 ptr, byval vType as VARIANT, byval var1 as VARIANT, byval ppElem as IXMLElement2 ptr ptr) as HRESULT
	get_async as function(byval This as IXMLDocument2 ptr, byval pf as VARIANT_BOOL ptr) as HRESULT
	put_async as function(byval This as IXMLDocument2 ptr, byval f as VARIANT_BOOL) as HRESULT
end type

type IXMLDocument2_
	lpVtbl as IXMLDocument2Vtbl ptr
end type

#define IXMLDocument2_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IXMLDocument2_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IXMLDocument2_Release(This) (This)->lpVtbl->Release(This)
#define IXMLDocument2_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define IXMLDocument2_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define IXMLDocument2_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define IXMLDocument2_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define IXMLDocument2_get_root(This, p) (This)->lpVtbl->get_root(This, p)
#define IXMLDocument2_get_fileSize(This, p) (This)->lpVtbl->get_fileSize(This, p)
#define IXMLDocument2_get_fileModifiedDate(This, p) (This)->lpVtbl->get_fileModifiedDate(This, p)
#define IXMLDocument2_get_fileUpdatedDate(This, p) (This)->lpVtbl->get_fileUpdatedDate(This, p)
#define IXMLDocument2_get_URL(This, p) (This)->lpVtbl->get_URL(This, p)
#define IXMLDocument2_put_URL(This, p) (This)->lpVtbl->put_URL(This, p)
#define IXMLDocument2_get_mimeType(This, p) (This)->lpVtbl->get_mimeType(This, p)
#define IXMLDocument2_get_readyState(This, pl) (This)->lpVtbl->get_readyState(This, pl)
#define IXMLDocument2_get_charset(This, p) (This)->lpVtbl->get_charset(This, p)
#define IXMLDocument2_put_charset(This, p) (This)->lpVtbl->put_charset(This, p)
#define IXMLDocument2_get_version(This, p) (This)->lpVtbl->get_version(This, p)
#define IXMLDocument2_get_doctype(This, p) (This)->lpVtbl->get_doctype(This, p)
#define IXMLDocument2_get_dtdURL(This, p) (This)->lpVtbl->get_dtdURL(This, p)
#define IXMLDocument2_createElement(This, vType, var1, ppElem) (This)->lpVtbl->createElement(This, vType, var1, ppElem)
#define IXMLDocument2_get_async(This, pf) (This)->lpVtbl->get_async(This, pf)
#define IXMLDocument2_put_async(This, f) (This)->lpVtbl->put_async(This, f)

declare function IXMLDocument2_get_root_Proxy(byval This as IXMLDocument2 ptr, byval p as IXMLElement2 ptr ptr) as HRESULT
declare sub IXMLDocument2_get_root_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDocument2_get_fileSize_Proxy(byval This as IXMLDocument2 ptr, byval p as BSTR ptr) as HRESULT
declare sub IXMLDocument2_get_fileSize_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDocument2_get_fileModifiedDate_Proxy(byval This as IXMLDocument2 ptr, byval p as BSTR ptr) as HRESULT
declare sub IXMLDocument2_get_fileModifiedDate_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDocument2_get_fileUpdatedDate_Proxy(byval This as IXMLDocument2 ptr, byval p as BSTR ptr) as HRESULT
declare sub IXMLDocument2_get_fileUpdatedDate_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDocument2_get_URL_Proxy(byval This as IXMLDocument2 ptr, byval p as BSTR ptr) as HRESULT
declare sub IXMLDocument2_get_URL_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDocument2_put_URL_Proxy(byval This as IXMLDocument2 ptr, byval p as BSTR) as HRESULT
declare sub IXMLDocument2_put_URL_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDocument2_get_mimeType_Proxy(byval This as IXMLDocument2 ptr, byval p as BSTR ptr) as HRESULT
declare sub IXMLDocument2_get_mimeType_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDocument2_get_readyState_Proxy(byval This as IXMLDocument2 ptr, byval pl as LONG ptr) as HRESULT
declare sub IXMLDocument2_get_readyState_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDocument2_get_charset_Proxy(byval This as IXMLDocument2 ptr, byval p as BSTR ptr) as HRESULT
declare sub IXMLDocument2_get_charset_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDocument2_put_charset_Proxy(byval This as IXMLDocument2 ptr, byval p as BSTR) as HRESULT
declare sub IXMLDocument2_put_charset_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDocument2_get_version_Proxy(byval This as IXMLDocument2 ptr, byval p as BSTR ptr) as HRESULT
declare sub IXMLDocument2_get_version_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDocument2_get_doctype_Proxy(byval This as IXMLDocument2 ptr, byval p as BSTR ptr) as HRESULT
declare sub IXMLDocument2_get_doctype_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDocument2_get_dtdURL_Proxy(byval This as IXMLDocument2 ptr, byval p as BSTR ptr) as HRESULT
declare sub IXMLDocument2_get_dtdURL_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDocument2_createElement_Proxy(byval This as IXMLDocument2 ptr, byval vType as VARIANT, byval var1 as VARIANT, byval ppElem as IXMLElement2 ptr ptr) as HRESULT
declare sub IXMLDocument2_createElement_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDocument2_get_async_Proxy(byval This as IXMLDocument2 ptr, byval pf as VARIANT_BOOL ptr) as HRESULT
declare sub IXMLDocument2_get_async_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDocument2_put_async_Proxy(byval This as IXMLDocument2 ptr, byval f as VARIANT_BOOL) as HRESULT
declare sub IXMLDocument2_put_async_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IXMLElement_INTERFACE_DEFINED__
extern IID_IXMLElement as const IID

type IXMLElementVtbl
	QueryInterface as function(byval This as IXMLElement ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IXMLElement ptr) as ULONG
	Release as function(byval This as IXMLElement ptr) as ULONG
	GetTypeInfoCount as function(byval This as IXMLElement ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IXMLElement ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IXMLElement ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IXMLElement ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	get_tagName as function(byval This as IXMLElement ptr, byval p as BSTR ptr) as HRESULT
	put_tagName as function(byval This as IXMLElement ptr, byval p as BSTR) as HRESULT
	get_parent as function(byval This as IXMLElement ptr, byval ppParent as IXMLElement ptr ptr) as HRESULT
	setAttribute as function(byval This as IXMLElement ptr, byval strPropertyName as BSTR, byval PropertyValue as VARIANT) as HRESULT
	getAttribute as function(byval This as IXMLElement ptr, byval strPropertyName as BSTR, byval PropertyValue as VARIANT ptr) as HRESULT
	removeAttribute as function(byval This as IXMLElement ptr, byval strPropertyName as BSTR) as HRESULT
	get_children as function(byval This as IXMLElement ptr, byval pp as IXMLElementCollection ptr ptr) as HRESULT
	get_type as function(byval This as IXMLElement ptr, byval plType as LONG ptr) as HRESULT
	get_text as function(byval This as IXMLElement ptr, byval p as BSTR ptr) as HRESULT
	put_text as function(byval This as IXMLElement ptr, byval p as BSTR) as HRESULT
	addChild as function(byval This as IXMLElement ptr, byval pChildElem as IXMLElement ptr, byval lIndex as LONG, byval lReserved as LONG) as HRESULT
	removeChild as function(byval This as IXMLElement ptr, byval pChildElem as IXMLElement ptr) as HRESULT
end type

type IXMLElement_
	lpVtbl as IXMLElementVtbl ptr
end type

#define IXMLElement_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IXMLElement_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IXMLElement_Release(This) (This)->lpVtbl->Release(This)
#define IXMLElement_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define IXMLElement_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define IXMLElement_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define IXMLElement_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define IXMLElement_get_tagName(This, p) (This)->lpVtbl->get_tagName(This, p)
#define IXMLElement_put_tagName(This, p) (This)->lpVtbl->put_tagName(This, p)
#define IXMLElement_get_parent(This, ppParent) (This)->lpVtbl->get_parent(This, ppParent)
#define IXMLElement_setAttribute(This, strPropertyName, PropertyValue) (This)->lpVtbl->setAttribute(This, strPropertyName, PropertyValue)
#define IXMLElement_getAttribute(This, strPropertyName, PropertyValue) (This)->lpVtbl->getAttribute(This, strPropertyName, PropertyValue)
#define IXMLElement_removeAttribute(This, strPropertyName) (This)->lpVtbl->removeAttribute(This, strPropertyName)
#define IXMLElement_get_children(This, pp) (This)->lpVtbl->get_children(This, pp)
#define IXMLElement_get_type(This, plType) (This)->lpVtbl->get_type(This, plType)
#define IXMLElement_get_text(This, p) (This)->lpVtbl->get_text(This, p)
#define IXMLElement_put_text(This, p) (This)->lpVtbl->put_text(This, p)
#define IXMLElement_addChild(This, pChildElem, lIndex, lReserved) (This)->lpVtbl->addChild(This, pChildElem, lIndex, lReserved)
#define IXMLElement_removeChild(This, pChildElem) (This)->lpVtbl->removeChild(This, pChildElem)

declare function IXMLElement_get_tagName_Proxy(byval This as IXMLElement ptr, byval p as BSTR ptr) as HRESULT
declare sub IXMLElement_get_tagName_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLElement_put_tagName_Proxy(byval This as IXMLElement ptr, byval p as BSTR) as HRESULT
declare sub IXMLElement_put_tagName_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLElement_get_parent_Proxy(byval This as IXMLElement ptr, byval ppParent as IXMLElement ptr ptr) as HRESULT
declare sub IXMLElement_get_parent_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLElement_setAttribute_Proxy(byval This as IXMLElement ptr, byval strPropertyName as BSTR, byval PropertyValue as VARIANT) as HRESULT
declare sub IXMLElement_setAttribute_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLElement_getAttribute_Proxy(byval This as IXMLElement ptr, byval strPropertyName as BSTR, byval PropertyValue as VARIANT ptr) as HRESULT
declare sub IXMLElement_getAttribute_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLElement_removeAttribute_Proxy(byval This as IXMLElement ptr, byval strPropertyName as BSTR) as HRESULT
declare sub IXMLElement_removeAttribute_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLElement_get_children_Proxy(byval This as IXMLElement ptr, byval pp as IXMLElementCollection ptr ptr) as HRESULT
declare sub IXMLElement_get_children_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLElement_get_type_Proxy(byval This as IXMLElement ptr, byval plType as LONG ptr) as HRESULT
declare sub IXMLElement_get_type_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLElement_get_text_Proxy(byval This as IXMLElement ptr, byval p as BSTR ptr) as HRESULT
declare sub IXMLElement_get_text_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLElement_put_text_Proxy(byval This as IXMLElement ptr, byval p as BSTR) as HRESULT
declare sub IXMLElement_put_text_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLElement_addChild_Proxy(byval This as IXMLElement ptr, byval pChildElem as IXMLElement ptr, byval lIndex as LONG, byval lReserved as LONG) as HRESULT
declare sub IXMLElement_addChild_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLElement_removeChild_Proxy(byval This as IXMLElement ptr, byval pChildElem as IXMLElement ptr) as HRESULT
declare sub IXMLElement_removeChild_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IXMLElement2_INTERFACE_DEFINED__
extern IID_IXMLElement2 as const IID

type IXMLElement2Vtbl
	QueryInterface as function(byval This as IXMLElement2 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IXMLElement2 ptr) as ULONG
	Release as function(byval This as IXMLElement2 ptr) as ULONG
	GetTypeInfoCount as function(byval This as IXMLElement2 ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IXMLElement2 ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IXMLElement2 ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IXMLElement2 ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	get_tagName as function(byval This as IXMLElement2 ptr, byval p as BSTR ptr) as HRESULT
	put_tagName as function(byval This as IXMLElement2 ptr, byval p as BSTR) as HRESULT
	get_parent as function(byval This as IXMLElement2 ptr, byval ppParent as IXMLElement2 ptr ptr) as HRESULT
	setAttribute as function(byval This as IXMLElement2 ptr, byval strPropertyName as BSTR, byval PropertyValue as VARIANT) as HRESULT
	getAttribute as function(byval This as IXMLElement2 ptr, byval strPropertyName as BSTR, byval PropertyValue as VARIANT ptr) as HRESULT
	removeAttribute as function(byval This as IXMLElement2 ptr, byval strPropertyName as BSTR) as HRESULT
	get_children as function(byval This as IXMLElement2 ptr, byval pp as IXMLElementCollection ptr ptr) as HRESULT
	get_type as function(byval This as IXMLElement2 ptr, byval plType as LONG ptr) as HRESULT
	get_text as function(byval This as IXMLElement2 ptr, byval p as BSTR ptr) as HRESULT
	put_text as function(byval This as IXMLElement2 ptr, byval p as BSTR) as HRESULT
	addChild as function(byval This as IXMLElement2 ptr, byval pChildElem as IXMLElement2 ptr, byval lIndex as LONG, byval lReserved as LONG) as HRESULT
	removeChild as function(byval This as IXMLElement2 ptr, byval pChildElem as IXMLElement2 ptr) as HRESULT
	get_attributes as function(byval This as IXMLElement2 ptr, byval pp as IXMLElementCollection ptr ptr) as HRESULT
end type

type IXMLElement2_
	lpVtbl as IXMLElement2Vtbl ptr
end type

#define IXMLElement2_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IXMLElement2_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IXMLElement2_Release(This) (This)->lpVtbl->Release(This)
#define IXMLElement2_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define IXMLElement2_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define IXMLElement2_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define IXMLElement2_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define IXMLElement2_get_tagName(This, p) (This)->lpVtbl->get_tagName(This, p)
#define IXMLElement2_put_tagName(This, p) (This)->lpVtbl->put_tagName(This, p)
#define IXMLElement2_get_parent(This, ppParent) (This)->lpVtbl->get_parent(This, ppParent)
#define IXMLElement2_setAttribute(This, strPropertyName, PropertyValue) (This)->lpVtbl->setAttribute(This, strPropertyName, PropertyValue)
#define IXMLElement2_getAttribute(This, strPropertyName, PropertyValue) (This)->lpVtbl->getAttribute(This, strPropertyName, PropertyValue)
#define IXMLElement2_removeAttribute(This, strPropertyName) (This)->lpVtbl->removeAttribute(This, strPropertyName)
#define IXMLElement2_get_children(This, pp) (This)->lpVtbl->get_children(This, pp)
#define IXMLElement2_get_type(This, plType) (This)->lpVtbl->get_type(This, plType)
#define IXMLElement2_get_text(This, p) (This)->lpVtbl->get_text(This, p)
#define IXMLElement2_put_text(This, p) (This)->lpVtbl->put_text(This, p)
#define IXMLElement2_addChild(This, pChildElem, lIndex, lReserved) (This)->lpVtbl->addChild(This, pChildElem, lIndex, lReserved)
#define IXMLElement2_removeChild(This, pChildElem) (This)->lpVtbl->removeChild(This, pChildElem)
#define IXMLElement2_get_attributes(This, pp) (This)->lpVtbl->get_attributes(This, pp)

declare function IXMLElement2_get_tagName_Proxy(byval This as IXMLElement2 ptr, byval p as BSTR ptr) as HRESULT
declare sub IXMLElement2_get_tagName_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLElement2_put_tagName_Proxy(byval This as IXMLElement2 ptr, byval p as BSTR) as HRESULT
declare sub IXMLElement2_put_tagName_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLElement2_get_parent_Proxy(byval This as IXMLElement2 ptr, byval ppParent as IXMLElement2 ptr ptr) as HRESULT
declare sub IXMLElement2_get_parent_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLElement2_setAttribute_Proxy(byval This as IXMLElement2 ptr, byval strPropertyName as BSTR, byval PropertyValue as VARIANT) as HRESULT
declare sub IXMLElement2_setAttribute_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLElement2_getAttribute_Proxy(byval This as IXMLElement2 ptr, byval strPropertyName as BSTR, byval PropertyValue as VARIANT ptr) as HRESULT
declare sub IXMLElement2_getAttribute_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLElement2_removeAttribute_Proxy(byval This as IXMLElement2 ptr, byval strPropertyName as BSTR) as HRESULT
declare sub IXMLElement2_removeAttribute_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLElement2_get_children_Proxy(byval This as IXMLElement2 ptr, byval pp as IXMLElementCollection ptr ptr) as HRESULT
declare sub IXMLElement2_get_children_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLElement2_get_type_Proxy(byval This as IXMLElement2 ptr, byval plType as LONG ptr) as HRESULT
declare sub IXMLElement2_get_type_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLElement2_get_text_Proxy(byval This as IXMLElement2 ptr, byval p as BSTR ptr) as HRESULT
declare sub IXMLElement2_get_text_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLElement2_put_text_Proxy(byval This as IXMLElement2 ptr, byval p as BSTR) as HRESULT
declare sub IXMLElement2_put_text_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLElement2_addChild_Proxy(byval This as IXMLElement2 ptr, byval pChildElem as IXMLElement2 ptr, byval lIndex as LONG, byval lReserved as LONG) as HRESULT
declare sub IXMLElement2_addChild_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLElement2_removeChild_Proxy(byval This as IXMLElement2 ptr, byval pChildElem as IXMLElement2 ptr) as HRESULT
declare sub IXMLElement2_removeChild_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLElement2_get_attributes_Proxy(byval This as IXMLElement2 ptr, byval pp as IXMLElementCollection ptr ptr) as HRESULT
declare sub IXMLElement2_get_attributes_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IXMLAttribute_INTERFACE_DEFINED__
extern IID_IXMLAttribute as const IID
type IXMLAttribute as IXMLAttribute_

type IXMLAttributeVtbl
	QueryInterface as function(byval This as IXMLAttribute ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IXMLAttribute ptr) as ULONG
	Release as function(byval This as IXMLAttribute ptr) as ULONG
	GetTypeInfoCount as function(byval This as IXMLAttribute ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IXMLAttribute ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IXMLAttribute ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IXMLAttribute ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	get_name as function(byval This as IXMLAttribute ptr, byval n as BSTR ptr) as HRESULT
	get_value as function(byval This as IXMLAttribute ptr, byval v as BSTR ptr) as HRESULT
end type

type IXMLAttribute_
	lpVtbl as IXMLAttributeVtbl ptr
end type

#define IXMLAttribute_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IXMLAttribute_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IXMLAttribute_Release(This) (This)->lpVtbl->Release(This)
#define IXMLAttribute_GetTypeInfoCount(This, pctinfo) (This)->lpVtbl->GetTypeInfoCount(This, pctinfo)
#define IXMLAttribute_GetTypeInfo(This, iTInfo, lcid, ppTInfo) (This)->lpVtbl->GetTypeInfo(This, iTInfo, lcid, ppTInfo)
#define IXMLAttribute_GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId) (This)->lpVtbl->GetIDsOfNames(This, riid, rgszNames, cNames, lcid, rgDispId)
#define IXMLAttribute_Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr) (This)->lpVtbl->Invoke(This, dispIdMember, riid, lcid, wFlags, pDispParams, pVarResult, pExcepInfo, puArgErr)
#define IXMLAttribute_get_name(This, n) (This)->lpVtbl->get_name(This, n)
#define IXMLAttribute_get_value(This, v) (This)->lpVtbl->get_value(This, v)

declare function IXMLAttribute_get_name_Proxy(byval This as IXMLAttribute ptr, byval n as BSTR ptr) as HRESULT
declare sub IXMLAttribute_get_name_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLAttribute_get_value_Proxy(byval This as IXMLAttribute ptr, byval v as BSTR ptr) as HRESULT
declare sub IXMLAttribute_get_value_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
#define __IXMLError_INTERFACE_DEFINED__
extern IID_IXMLError as const IID
type IXMLError as IXMLError_

type IXMLErrorVtbl
	QueryInterface as function(byval This as IXMLError ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IXMLError ptr) as ULONG
	Release as function(byval This as IXMLError ptr) as ULONG
	GetErrorInfo as function(byval This as IXMLError ptr, byval pErrorReturn as XML_ERROR ptr) as HRESULT
end type

type IXMLError_
	lpVtbl as IXMLErrorVtbl ptr
end type

#define IXMLError_QueryInterface(This, riid, ppvObject) (This)->lpVtbl->QueryInterface(This, riid, ppvObject)
#define IXMLError_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IXMLError_Release(This) (This)->lpVtbl->Release(This)
#define IXMLError_GetErrorInfo(This, pErrorReturn) (This)->lpVtbl->GetErrorInfo(This, pErrorReturn)
declare function IXMLError_GetErrorInfo_Proxy(byval This as IXMLError ptr, byval pErrorReturn as XML_ERROR ptr) as HRESULT
declare sub IXMLError_GetErrorInfo_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
extern CLSID_XMLDocument as const CLSID

end extern
