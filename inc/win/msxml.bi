#pragma once

#include once "rpc.bi"
#include once "rpcndr.bi"
#include once "windows.bi"
#include once "ole2.bi"
#include once "unknwn.bi"
#include once "objidl.bi"
#include once "oaidl.bi"

extern "Windows"

type IXMLDOMImplementation as IXMLDOMImplementation_
type IXMLDOMNode as IXMLDOMNode_
type IXMLDOMDocumentFragment as IXMLDOMDocumentFragment_
type IXMLDOMDocument as IXMLDOMDocument_
type IXMLDOMNodeList as IXMLDOMNodeList_
type IXMLDOMNamedNodeMap as IXMLDOMNamedNodeMap_
type IXMLDOMCharacterData as IXMLDOMCharacterData_
type IXMLDOMAttribute as IXMLDOMAttribute_
type IXMLDOMElement as IXMLDOMElement_
type IXMLDOMText as IXMLDOMText_
type IXMLDOMComment as IXMLDOMComment_
type IXMLDOMProcessingInstruction as IXMLDOMProcessingInstruction_
type IXMLDOMCDATASection as IXMLDOMCDATASection_
type IXMLDOMDocumentType as IXMLDOMDocumentType_
type IXMLDOMNotation as IXMLDOMNotation_
type IXMLDOMEntity as IXMLDOMEntity_
type IXMLDOMEntityReference as IXMLDOMEntityReference_
type IXMLDOMParseError as IXMLDOMParseError_
type IXTLRuntime as IXTLRuntime_
type XMLDOMDocumentEvents as XMLDOMDocumentEvents_
type IXMLHttpRequest as IXMLHttpRequest_
type IXMLDSOControl as IXMLDSOControl_
type IXMLElementCollection as IXMLElementCollection_
type IXMLDocument as IXMLDocument_
type IXMLDocument2 as IXMLDocument2_
type IXMLElement as IXMLElement_
type IXMLElement2 as IXMLElement2_
type IXMLAttribute as IXMLAttribute_
type IXMLError as IXMLError_

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

declare function IXMLDOMImplementation_hasFeature_Proxy(byval This as IXMLDOMImplementation ptr, byval feature as BSTR, byval version as BSTR, byval hasFeature as VARIANT_BOOL ptr) as HRESULT
declare sub IXMLDOMImplementation_hasFeature_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

#define __IXMLDOMNode_INTERFACE_DEFINED__

extern IID_IXMLDOMNode as const IID

type IXMLDOMNodeVtbl
	QueryInterface as function(byval This as IXMLDOMNode ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IXMLDOMNode ptr) as ULONG
	Release as function(byval This as IXMLDOMNode ptr) as ULONG
	GetTypeInfoCount as function(byval This as IXMLDOMNode ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IXMLDOMNode ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IXMLDOMNode ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IXMLDOMNode ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	get_nodeName as function(byval This as IXMLDOMNode ptr, byval name_ as BSTR ptr) as HRESULT
	get_nodeValue as function(byval This as IXMLDOMNode ptr, byval value as VARIANT ptr) as HRESULT
	put_nodeValue as function(byval This as IXMLDOMNode ptr, byval value as VARIANT) as HRESULT
	get_nodeType as function(byval This as IXMLDOMNode ptr, byval type_ as DOMNodeType ptr) as HRESULT
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
	get_text as function(byval This as IXMLDOMNode ptr, byval text_ as BSTR ptr) as HRESULT
	put_text as function(byval This as IXMLDOMNode ptr, byval text_ as BSTR) as HRESULT
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

declare function IXMLDOMNode_get_nodeName_Proxy(byval This as IXMLDOMNode ptr, byval name_ as BSTR ptr) as HRESULT
declare sub IXMLDOMNode_get_nodeName_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMNode_get_nodeValue_Proxy(byval This as IXMLDOMNode ptr, byval value as VARIANT ptr) as HRESULT
declare sub IXMLDOMNode_get_nodeValue_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMNode_put_nodeValue_Proxy(byval This as IXMLDOMNode ptr, byval value as VARIANT) as HRESULT
declare sub IXMLDOMNode_put_nodeValue_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMNode_get_nodeType_Proxy(byval This as IXMLDOMNode ptr, byval type_ as DOMNodeType ptr) as HRESULT
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
declare function IXMLDOMNode_get_text_Proxy(byval This as IXMLDOMNode ptr, byval text_ as BSTR ptr) as HRESULT
declare sub IXMLDOMNode_get_text_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMNode_put_text_Proxy(byval This as IXMLDOMNode ptr, byval text_ as BSTR) as HRESULT
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

type IXMLDOMDocumentFragmentVtbl
	QueryInterface as function(byval This as IXMLDOMDocumentFragment ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IXMLDOMDocumentFragment ptr) as ULONG
	Release as function(byval This as IXMLDOMDocumentFragment ptr) as ULONG
	GetTypeInfoCount as function(byval This as IXMLDOMDocumentFragment ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IXMLDOMDocumentFragment ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IXMLDOMDocumentFragment ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IXMLDOMDocumentFragment ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	get_nodeName as function(byval This as IXMLDOMDocumentFragment ptr, byval name_ as BSTR ptr) as HRESULT
	get_nodeValue as function(byval This as IXMLDOMDocumentFragment ptr, byval value as VARIANT ptr) as HRESULT
	put_nodeValue as function(byval This as IXMLDOMDocumentFragment ptr, byval value as VARIANT) as HRESULT
	get_nodeType as function(byval This as IXMLDOMDocumentFragment ptr, byval type_ as DOMNodeType ptr) as HRESULT
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
	get_text as function(byval This as IXMLDOMDocumentFragment ptr, byval text_ as BSTR ptr) as HRESULT
	put_text as function(byval This as IXMLDOMDocumentFragment ptr, byval text_ as BSTR) as HRESULT
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

#define __IXMLDOMDocument_INTERFACE_DEFINED__

extern IID_IXMLDOMDocument as const IID

type IXMLDOMDocumentVtbl
	QueryInterface as function(byval This as IXMLDOMDocument ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IXMLDOMDocument ptr) as ULONG
	Release as function(byval This as IXMLDOMDocument ptr) as ULONG
	GetTypeInfoCount as function(byval This as IXMLDOMDocument ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IXMLDOMDocument ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IXMLDOMDocument ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IXMLDOMDocument ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	get_nodeName as function(byval This as IXMLDOMDocument ptr, byval name_ as BSTR ptr) as HRESULT
	get_nodeValue as function(byval This as IXMLDOMDocument ptr, byval value as VARIANT ptr) as HRESULT
	put_nodeValue as function(byval This as IXMLDOMDocument ptr, byval value as VARIANT) as HRESULT
	get_nodeType as function(byval This as IXMLDOMDocument ptr, byval type_ as DOMNodeType ptr) as HRESULT
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
	get_text as function(byval This as IXMLDOMDocument ptr, byval text_ as BSTR ptr) as HRESULT
	put_text as function(byval This as IXMLDOMDocument ptr, byval text_ as BSTR) as HRESULT
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
	createTextNode as function(byval This as IXMLDOMDocument ptr, byval data_ as BSTR, byval text_ as IXMLDOMText ptr ptr) as HRESULT
	createComment as function(byval This as IXMLDOMDocument ptr, byval data_ as BSTR, byval comment as IXMLDOMComment ptr ptr) as HRESULT
	createCDATASection as function(byval This as IXMLDOMDocument ptr, byval data_ as BSTR, byval cdata as IXMLDOMCDATASection ptr ptr) as HRESULT
	createProcessingInstruction as function(byval This as IXMLDOMDocument ptr, byval target as BSTR, byval data_ as BSTR, byval pi as IXMLDOMProcessingInstruction ptr ptr) as HRESULT
	createAttribute as function(byval This as IXMLDOMDocument ptr, byval name_ as BSTR, byval attribute as IXMLDOMAttribute ptr ptr) as HRESULT
	createEntityReference as function(byval This as IXMLDOMDocument ptr, byval name_ as BSTR, byval entityRef as IXMLDOMEntityReference ptr ptr) as HRESULT
	getElementsByTagName as function(byval This as IXMLDOMDocument ptr, byval tagName as BSTR, byval resultList as IXMLDOMNodeList ptr ptr) as HRESULT
	createNode as function(byval This as IXMLDOMDocument ptr, byval Type_ as VARIANT, byval name_ as BSTR, byval namespaceURI as BSTR, byval node as IXMLDOMNode ptr ptr) as HRESULT
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
declare function IXMLDOMDocument_createTextNode_Proxy(byval This as IXMLDOMDocument ptr, byval data_ as BSTR, byval text_ as IXMLDOMText ptr ptr) as HRESULT
declare sub IXMLDOMDocument_createTextNode_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMDocument_createComment_Proxy(byval This as IXMLDOMDocument ptr, byval data_ as BSTR, byval comment as IXMLDOMComment ptr ptr) as HRESULT
declare sub IXMLDOMDocument_createComment_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMDocument_createCDATASection_Proxy(byval This as IXMLDOMDocument ptr, byval data_ as BSTR, byval cdata as IXMLDOMCDATASection ptr ptr) as HRESULT
declare sub IXMLDOMDocument_createCDATASection_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMDocument_createProcessingInstruction_Proxy(byval This as IXMLDOMDocument ptr, byval target as BSTR, byval data_ as BSTR, byval pi as IXMLDOMProcessingInstruction ptr ptr) as HRESULT
declare sub IXMLDOMDocument_createProcessingInstruction_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMDocument_createAttribute_Proxy(byval This as IXMLDOMDocument ptr, byval name_ as BSTR, byval attribute as IXMLDOMAttribute ptr ptr) as HRESULT
declare sub IXMLDOMDocument_createAttribute_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMDocument_createEntityReference_Proxy(byval This as IXMLDOMDocument ptr, byval name_ as BSTR, byval entityRef as IXMLDOMEntityReference ptr ptr) as HRESULT
declare sub IXMLDOMDocument_createEntityReference_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMDocument_getElementsByTagName_Proxy(byval This as IXMLDOMDocument ptr, byval tagName as BSTR, byval resultList as IXMLDOMNodeList ptr ptr) as HRESULT
declare sub IXMLDOMDocument_getElementsByTagName_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMDocument_createNode_Proxy(byval This as IXMLDOMDocument ptr, byval Type_ as VARIANT, byval name_ as BSTR, byval namespaceURI as BSTR, byval node as IXMLDOMNode ptr ptr) as HRESULT
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
	getNamedItem as function(byval This as IXMLDOMNamedNodeMap ptr, byval name_ as BSTR, byval namedItem as IXMLDOMNode ptr ptr) as HRESULT
	setNamedItem as function(byval This as IXMLDOMNamedNodeMap ptr, byval newItem as IXMLDOMNode ptr, byval nameItem as IXMLDOMNode ptr ptr) as HRESULT
	removeNamedItem as function(byval This as IXMLDOMNamedNodeMap ptr, byval name_ as BSTR, byval namedItem as IXMLDOMNode ptr ptr) as HRESULT
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

declare function IXMLDOMNamedNodeMap_getNamedItem_Proxy(byval This as IXMLDOMNamedNodeMap ptr, byval name_ as BSTR, byval namedItem as IXMLDOMNode ptr ptr) as HRESULT
declare sub IXMLDOMNamedNodeMap_getNamedItem_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMNamedNodeMap_setNamedItem_Proxy(byval This as IXMLDOMNamedNodeMap ptr, byval newItem as IXMLDOMNode ptr, byval nameItem as IXMLDOMNode ptr ptr) as HRESULT
declare sub IXMLDOMNamedNodeMap_setNamedItem_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMNamedNodeMap_removeNamedItem_Proxy(byval This as IXMLDOMNamedNodeMap ptr, byval name_ as BSTR, byval namedItem as IXMLDOMNode ptr ptr) as HRESULT
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

type IXMLDOMCharacterDataVtbl
	QueryInterface as function(byval This as IXMLDOMCharacterData ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IXMLDOMCharacterData ptr) as ULONG
	Release as function(byval This as IXMLDOMCharacterData ptr) as ULONG
	GetTypeInfoCount as function(byval This as IXMLDOMCharacterData ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IXMLDOMCharacterData ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IXMLDOMCharacterData ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IXMLDOMCharacterData ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	get_nodeName as function(byval This as IXMLDOMCharacterData ptr, byval name_ as BSTR ptr) as HRESULT
	get_nodeValue as function(byval This as IXMLDOMCharacterData ptr, byval value as VARIANT ptr) as HRESULT
	put_nodeValue as function(byval This as IXMLDOMCharacterData ptr, byval value as VARIANT) as HRESULT
	get_nodeType as function(byval This as IXMLDOMCharacterData ptr, byval type_ as DOMNodeType ptr) as HRESULT
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
	get_text as function(byval This as IXMLDOMCharacterData ptr, byval text_ as BSTR ptr) as HRESULT
	put_text as function(byval This as IXMLDOMCharacterData ptr, byval text_ as BSTR) as HRESULT
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
	get_data as function(byval This as IXMLDOMCharacterData ptr, byval data_ as BSTR ptr) as HRESULT
	put_data as function(byval This as IXMLDOMCharacterData ptr, byval data_ as BSTR) as HRESULT
	get_length as function(byval This as IXMLDOMCharacterData ptr, byval dataLength as LONG ptr) as HRESULT
	substringData as function(byval This as IXMLDOMCharacterData ptr, byval offset as LONG, byval count as LONG, byval data_ as BSTR ptr) as HRESULT
	appendData as function(byval This as IXMLDOMCharacterData ptr, byval data_ as BSTR) as HRESULT
	insertData as function(byval This as IXMLDOMCharacterData ptr, byval offset as LONG, byval data_ as BSTR) as HRESULT
	deleteData as function(byval This as IXMLDOMCharacterData ptr, byval offset as LONG, byval count as LONG) as HRESULT
	replaceData as function(byval This as IXMLDOMCharacterData ptr, byval offset as LONG, byval count as LONG, byval data_ as BSTR) as HRESULT
end type

type IXMLDOMCharacterData_
	lpVtbl as IXMLDOMCharacterDataVtbl ptr
end type

declare function IXMLDOMCharacterData_get_data_Proxy(byval This as IXMLDOMCharacterData ptr, byval data_ as BSTR ptr) as HRESULT
declare sub IXMLDOMCharacterData_get_data_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMCharacterData_put_data_Proxy(byval This as IXMLDOMCharacterData ptr, byval data_ as BSTR) as HRESULT
declare sub IXMLDOMCharacterData_put_data_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMCharacterData_get_length_Proxy(byval This as IXMLDOMCharacterData ptr, byval dataLength as LONG ptr) as HRESULT
declare sub IXMLDOMCharacterData_get_length_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMCharacterData_substringData_Proxy(byval This as IXMLDOMCharacterData ptr, byval offset as LONG, byval count as LONG, byval data_ as BSTR ptr) as HRESULT
declare sub IXMLDOMCharacterData_substringData_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMCharacterData_appendData_Proxy(byval This as IXMLDOMCharacterData ptr, byval data_ as BSTR) as HRESULT
declare sub IXMLDOMCharacterData_appendData_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMCharacterData_insertData_Proxy(byval This as IXMLDOMCharacterData ptr, byval offset as LONG, byval data_ as BSTR) as HRESULT
declare sub IXMLDOMCharacterData_insertData_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMCharacterData_deleteData_Proxy(byval This as IXMLDOMCharacterData ptr, byval offset as LONG, byval count as LONG) as HRESULT
declare sub IXMLDOMCharacterData_deleteData_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMCharacterData_replaceData_Proxy(byval This as IXMLDOMCharacterData ptr, byval offset as LONG, byval count as LONG, byval data_ as BSTR) as HRESULT
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
	get_nodeName as function(byval This as IXMLDOMAttribute ptr, byval name_ as BSTR ptr) as HRESULT
	get_nodeValue as function(byval This as IXMLDOMAttribute ptr, byval value as VARIANT ptr) as HRESULT
	put_nodeValue as function(byval This as IXMLDOMAttribute ptr, byval value as VARIANT) as HRESULT
	get_nodeType as function(byval This as IXMLDOMAttribute ptr, byval type_ as DOMNodeType ptr) as HRESULT
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
	get_text as function(byval This as IXMLDOMAttribute ptr, byval text_ as BSTR ptr) as HRESULT
	put_text as function(byval This as IXMLDOMAttribute ptr, byval text_ as BSTR) as HRESULT
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
	get_nodeName as function(byval This as IXMLDOMElement ptr, byval name_ as BSTR ptr) as HRESULT
	get_nodeValue as function(byval This as IXMLDOMElement ptr, byval value as VARIANT ptr) as HRESULT
	put_nodeValue as function(byval This as IXMLDOMElement ptr, byval value as VARIANT) as HRESULT
	get_nodeType as function(byval This as IXMLDOMElement ptr, byval type_ as DOMNodeType ptr) as HRESULT
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
	get_text as function(byval This as IXMLDOMElement ptr, byval text_ as BSTR ptr) as HRESULT
	put_text as function(byval This as IXMLDOMElement ptr, byval text_ as BSTR) as HRESULT
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
	getAttribute as function(byval This as IXMLDOMElement ptr, byval name_ as BSTR, byval value as VARIANT ptr) as HRESULT
	setAttribute as function(byval This as IXMLDOMElement ptr, byval name_ as BSTR, byval value as VARIANT) as HRESULT
	removeAttribute as function(byval This as IXMLDOMElement ptr, byval name_ as BSTR) as HRESULT
	getAttributeNode as function(byval This as IXMLDOMElement ptr, byval name_ as BSTR, byval attributeNode as IXMLDOMAttribute ptr ptr) as HRESULT
	setAttributeNode as function(byval This as IXMLDOMElement ptr, byval DOMAttribute as IXMLDOMAttribute ptr, byval attributeNode as IXMLDOMAttribute ptr ptr) as HRESULT
	removeAttributeNode as function(byval This as IXMLDOMElement ptr, byval DOMAttribute as IXMLDOMAttribute ptr, byval attributeNode as IXMLDOMAttribute ptr ptr) as HRESULT
	getElementsByTagName as function(byval This as IXMLDOMElement ptr, byval tagName as BSTR, byval resultList as IXMLDOMNodeList ptr ptr) as HRESULT
	normalize as function(byval This as IXMLDOMElement ptr) as HRESULT
end type

type IXMLDOMElement_
	lpVtbl as IXMLDOMElementVtbl ptr
end type

declare function IXMLDOMElement_get_tagName_Proxy(byval This as IXMLDOMElement ptr, byval tagName as BSTR ptr) as HRESULT
declare sub IXMLDOMElement_get_tagName_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMElement_getAttribute_Proxy(byval This as IXMLDOMElement ptr, byval name_ as BSTR, byval value as VARIANT ptr) as HRESULT
declare sub IXMLDOMElement_getAttribute_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMElement_setAttribute_Proxy(byval This as IXMLDOMElement ptr, byval name_ as BSTR, byval value as VARIANT) as HRESULT
declare sub IXMLDOMElement_setAttribute_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMElement_removeAttribute_Proxy(byval This as IXMLDOMElement ptr, byval name_ as BSTR) as HRESULT
declare sub IXMLDOMElement_removeAttribute_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMElement_getAttributeNode_Proxy(byval This as IXMLDOMElement ptr, byval name_ as BSTR, byval attributeNode as IXMLDOMAttribute ptr ptr) as HRESULT
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
	get_nodeName as function(byval This as IXMLDOMText ptr, byval name_ as BSTR ptr) as HRESULT
	get_nodeValue as function(byval This as IXMLDOMText ptr, byval value as VARIANT ptr) as HRESULT
	put_nodeValue as function(byval This as IXMLDOMText ptr, byval value as VARIANT) as HRESULT
	get_nodeType as function(byval This as IXMLDOMText ptr, byval type_ as DOMNodeType ptr) as HRESULT
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
	get_text as function(byval This as IXMLDOMText ptr, byval text_ as BSTR ptr) as HRESULT
	put_text as function(byval This as IXMLDOMText ptr, byval text_ as BSTR) as HRESULT
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
	get_data as function(byval This as IXMLDOMText ptr, byval data_ as BSTR ptr) as HRESULT
	put_data as function(byval This as IXMLDOMText ptr, byval data_ as BSTR) as HRESULT
	get_length as function(byval This as IXMLDOMText ptr, byval dataLength as LONG ptr) as HRESULT
	substringData as function(byval This as IXMLDOMText ptr, byval offset as LONG, byval count as LONG, byval data_ as BSTR ptr) as HRESULT
	appendData as function(byval This as IXMLDOMText ptr, byval data_ as BSTR) as HRESULT
	insertData as function(byval This as IXMLDOMText ptr, byval offset as LONG, byval data_ as BSTR) as HRESULT
	deleteData as function(byval This as IXMLDOMText ptr, byval offset as LONG, byval count as LONG) as HRESULT
	replaceData as function(byval This as IXMLDOMText ptr, byval offset as LONG, byval count as LONG, byval data_ as BSTR) as HRESULT
	splitText as function(byval This as IXMLDOMText ptr, byval offset as LONG, byval rightHandTextNode as IXMLDOMText ptr ptr) as HRESULT
end type

type IXMLDOMText_
	lpVtbl as IXMLDOMTextVtbl ptr
end type

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
	get_nodeName as function(byval This as IXMLDOMComment ptr, byval name_ as BSTR ptr) as HRESULT
	get_nodeValue as function(byval This as IXMLDOMComment ptr, byval value as VARIANT ptr) as HRESULT
	put_nodeValue as function(byval This as IXMLDOMComment ptr, byval value as VARIANT) as HRESULT
	get_nodeType as function(byval This as IXMLDOMComment ptr, byval type_ as DOMNodeType ptr) as HRESULT
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
	get_text as function(byval This as IXMLDOMComment ptr, byval text_ as BSTR ptr) as HRESULT
	put_text as function(byval This as IXMLDOMComment ptr, byval text_ as BSTR) as HRESULT
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
	get_data as function(byval This as IXMLDOMComment ptr, byval data_ as BSTR ptr) as HRESULT
	put_data as function(byval This as IXMLDOMComment ptr, byval data_ as BSTR) as HRESULT
	get_length as function(byval This as IXMLDOMComment ptr, byval dataLength as LONG ptr) as HRESULT
	substringData as function(byval This as IXMLDOMComment ptr, byval offset as LONG, byval count as LONG, byval data_ as BSTR ptr) as HRESULT
	appendData as function(byval This as IXMLDOMComment ptr, byval data_ as BSTR) as HRESULT
	insertData as function(byval This as IXMLDOMComment ptr, byval offset as LONG, byval data_ as BSTR) as HRESULT
	deleteData as function(byval This as IXMLDOMComment ptr, byval offset as LONG, byval count as LONG) as HRESULT
	replaceData as function(byval This as IXMLDOMComment ptr, byval offset as LONG, byval count as LONG, byval data_ as BSTR) as HRESULT
end type

type IXMLDOMComment_
	lpVtbl as IXMLDOMCommentVtbl ptr
end type

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
	get_nodeName as function(byval This as IXMLDOMProcessingInstruction ptr, byval name_ as BSTR ptr) as HRESULT
	get_nodeValue as function(byval This as IXMLDOMProcessingInstruction ptr, byval value as VARIANT ptr) as HRESULT
	put_nodeValue as function(byval This as IXMLDOMProcessingInstruction ptr, byval value as VARIANT) as HRESULT
	get_nodeType as function(byval This as IXMLDOMProcessingInstruction ptr, byval type_ as DOMNodeType ptr) as HRESULT
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
	get_text as function(byval This as IXMLDOMProcessingInstruction ptr, byval text_ as BSTR ptr) as HRESULT
	put_text as function(byval This as IXMLDOMProcessingInstruction ptr, byval text_ as BSTR) as HRESULT
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
	get_target as function(byval This as IXMLDOMProcessingInstruction ptr, byval name_ as BSTR ptr) as HRESULT
	get_data as function(byval This as IXMLDOMProcessingInstruction ptr, byval value as BSTR ptr) as HRESULT
	put_data as function(byval This as IXMLDOMProcessingInstruction ptr, byval value as BSTR) as HRESULT
end type

type IXMLDOMProcessingInstruction_
	lpVtbl as IXMLDOMProcessingInstructionVtbl ptr
end type

declare function IXMLDOMProcessingInstruction_get_target_Proxy(byval This as IXMLDOMProcessingInstruction ptr, byval name_ as BSTR ptr) as HRESULT
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
	get_nodeName as function(byval This as IXMLDOMCDATASection ptr, byval name_ as BSTR ptr) as HRESULT
	get_nodeValue as function(byval This as IXMLDOMCDATASection ptr, byval value as VARIANT ptr) as HRESULT
	put_nodeValue as function(byval This as IXMLDOMCDATASection ptr, byval value as VARIANT) as HRESULT
	get_nodeType as function(byval This as IXMLDOMCDATASection ptr, byval type_ as DOMNodeType ptr) as HRESULT
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
	get_text as function(byval This as IXMLDOMCDATASection ptr, byval text_ as BSTR ptr) as HRESULT
	put_text as function(byval This as IXMLDOMCDATASection ptr, byval text_ as BSTR) as HRESULT
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
	get_data as function(byval This as IXMLDOMCDATASection ptr, byval data_ as BSTR ptr) as HRESULT
	put_data as function(byval This as IXMLDOMCDATASection ptr, byval data_ as BSTR) as HRESULT
	get_length as function(byval This as IXMLDOMCDATASection ptr, byval dataLength as LONG ptr) as HRESULT
	substringData as function(byval This as IXMLDOMCDATASection ptr, byval offset as LONG, byval count as LONG, byval data_ as BSTR ptr) as HRESULT
	appendData as function(byval This as IXMLDOMCDATASection ptr, byval data_ as BSTR) as HRESULT
	insertData as function(byval This as IXMLDOMCDATASection ptr, byval offset as LONG, byval data_ as BSTR) as HRESULT
	deleteData as function(byval This as IXMLDOMCDATASection ptr, byval offset as LONG, byval count as LONG) as HRESULT
	replaceData as function(byval This as IXMLDOMCDATASection ptr, byval offset as LONG, byval count as LONG, byval data_ as BSTR) as HRESULT
	splitText as function(byval This as IXMLDOMCDATASection ptr, byval offset as LONG, byval rightHandTextNode as IXMLDOMText ptr ptr) as HRESULT
end type

type IXMLDOMCDATASection_
	lpVtbl as IXMLDOMCDATASectionVtbl ptr
end type

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
	get_nodeName as function(byval This as IXMLDOMDocumentType ptr, byval name_ as BSTR ptr) as HRESULT
	get_nodeValue as function(byval This as IXMLDOMDocumentType ptr, byval value as VARIANT ptr) as HRESULT
	put_nodeValue as function(byval This as IXMLDOMDocumentType ptr, byval value as VARIANT) as HRESULT
	get_nodeType as function(byval This as IXMLDOMDocumentType ptr, byval type_ as DOMNodeType ptr) as HRESULT
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
	get_text as function(byval This as IXMLDOMDocumentType ptr, byval text_ as BSTR ptr) as HRESULT
	put_text as function(byval This as IXMLDOMDocumentType ptr, byval text_ as BSTR) as HRESULT
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

declare function IXMLDOMDocumentType_get_name_Proxy(byval This as IXMLDOMDocumentType ptr, byval rootName as BSTR ptr) as HRESULT
declare sub IXMLDOMDocumentType_get_name_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMDocumentType_get_entities_Proxy(byval This as IXMLDOMDocumentType ptr, byval entityMap as IXMLDOMNamedNodeMap ptr ptr) as HRESULT
declare sub IXMLDOMDocumentType_get_entities_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMDocumentType_get_notations_Proxy(byval This as IXMLDOMDocumentType ptr, byval notationMap as IXMLDOMNamedNodeMap ptr ptr) as HRESULT
declare sub IXMLDOMDocumentType_get_notations_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

#define __IXMLDOMNotation_INTERFACE_DEFINED__

extern IID_IXMLDOMNotation as const IID

type IXMLDOMNotationVtbl
	QueryInterface as function(byval This as IXMLDOMNotation ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IXMLDOMNotation ptr) as ULONG
	Release as function(byval This as IXMLDOMNotation ptr) as ULONG
	GetTypeInfoCount as function(byval This as IXMLDOMNotation ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IXMLDOMNotation ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IXMLDOMNotation ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IXMLDOMNotation ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	get_nodeName as function(byval This as IXMLDOMNotation ptr, byval name_ as BSTR ptr) as HRESULT
	get_nodeValue as function(byval This as IXMLDOMNotation ptr, byval value as VARIANT ptr) as HRESULT
	put_nodeValue as function(byval This as IXMLDOMNotation ptr, byval value as VARIANT) as HRESULT
	get_nodeType as function(byval This as IXMLDOMNotation ptr, byval type_ as DOMNodeType ptr) as HRESULT
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
	get_text as function(byval This as IXMLDOMNotation ptr, byval text_ as BSTR ptr) as HRESULT
	put_text as function(byval This as IXMLDOMNotation ptr, byval text_ as BSTR) as HRESULT
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

declare function IXMLDOMNotation_get_publicId_Proxy(byval This as IXMLDOMNotation ptr, byval publicID as VARIANT ptr) as HRESULT
declare sub IXMLDOMNotation_get_publicId_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMNotation_get_systemId_Proxy(byval This as IXMLDOMNotation ptr, byval systemID as VARIANT ptr) as HRESULT
declare sub IXMLDOMNotation_get_systemId_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

#define __IXMLDOMEntity_INTERFACE_DEFINED__

extern IID_IXMLDOMEntity as const IID

type IXMLDOMEntityVtbl
	QueryInterface as function(byval This as IXMLDOMEntity ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IXMLDOMEntity ptr) as ULONG
	Release as function(byval This as IXMLDOMEntity ptr) as ULONG
	GetTypeInfoCount as function(byval This as IXMLDOMEntity ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IXMLDOMEntity ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IXMLDOMEntity ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IXMLDOMEntity ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	get_nodeName as function(byval This as IXMLDOMEntity ptr, byval name_ as BSTR ptr) as HRESULT
	get_nodeValue as function(byval This as IXMLDOMEntity ptr, byval value as VARIANT ptr) as HRESULT
	put_nodeValue as function(byval This as IXMLDOMEntity ptr, byval value as VARIANT) as HRESULT
	get_nodeType as function(byval This as IXMLDOMEntity ptr, byval type_ as DOMNodeType ptr) as HRESULT
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
	get_text as function(byval This as IXMLDOMEntity ptr, byval text_ as BSTR ptr) as HRESULT
	put_text as function(byval This as IXMLDOMEntity ptr, byval text_ as BSTR) as HRESULT
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
	get_notationName as function(byval This as IXMLDOMEntity ptr, byval name_ as BSTR ptr) as HRESULT
end type

type IXMLDOMEntity_
	lpVtbl as IXMLDOMEntityVtbl ptr
end type

declare function IXMLDOMEntity_get_publicId_Proxy(byval This as IXMLDOMEntity ptr, byval publicID as VARIANT ptr) as HRESULT
declare sub IXMLDOMEntity_get_publicId_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMEntity_get_systemId_Proxy(byval This as IXMLDOMEntity ptr, byval systemID as VARIANT ptr) as HRESULT
declare sub IXMLDOMEntity_get_systemId_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLDOMEntity_get_notationName_Proxy(byval This as IXMLDOMEntity ptr, byval name_ as BSTR ptr) as HRESULT
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
	get_nodeName as function(byval This as IXMLDOMEntityReference ptr, byval name_ as BSTR ptr) as HRESULT
	get_nodeValue as function(byval This as IXMLDOMEntityReference ptr, byval value as VARIANT ptr) as HRESULT
	put_nodeValue as function(byval This as IXMLDOMEntityReference ptr, byval value as VARIANT) as HRESULT
	get_nodeType as function(byval This as IXMLDOMEntityReference ptr, byval type_ as DOMNodeType ptr) as HRESULT
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
	get_text as function(byval This as IXMLDOMEntityReference ptr, byval text_ as BSTR ptr) as HRESULT
	put_text as function(byval This as IXMLDOMEntityReference ptr, byval text_ as BSTR) as HRESULT
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

type IXTLRuntimeVtbl
	QueryInterface as function(byval This as IXTLRuntime ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IXTLRuntime ptr) as ULONG
	Release as function(byval This as IXTLRuntime ptr) as ULONG
	GetTypeInfoCount as function(byval This as IXTLRuntime ptr, byval pctinfo as UINT ptr) as HRESULT
	GetTypeInfo as function(byval This as IXTLRuntime ptr, byval iTInfo as UINT, byval lcid as LCID, byval ppTInfo as ITypeInfo ptr ptr) as HRESULT
	GetIDsOfNames as function(byval This as IXTLRuntime ptr, byval riid as const IID const ptr, byval rgszNames as LPOLESTR ptr, byval cNames as UINT, byval lcid as LCID, byval rgDispId as DISPID ptr) as HRESULT
	Invoke as function(byval This as IXTLRuntime ptr, byval dispIdMember as DISPID, byval riid as const IID const ptr, byval lcid as LCID, byval wFlags as WORD, byval pDispParams as DISPPARAMS ptr, byval pVarResult as VARIANT ptr, byval pExcepInfo as EXCEPINFO ptr, byval puArgErr as UINT ptr) as HRESULT
	get_nodeName as function(byval This as IXTLRuntime ptr, byval name_ as BSTR ptr) as HRESULT
	get_nodeValue as function(byval This as IXTLRuntime ptr, byval value as VARIANT ptr) as HRESULT
	put_nodeValue as function(byval This as IXTLRuntime ptr, byval value as VARIANT) as HRESULT
	get_nodeType as function(byval This as IXTLRuntime ptr, byval type_ as DOMNodeType ptr) as HRESULT
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
	get_text as function(byval This as IXTLRuntime ptr, byval text_ as BSTR ptr) as HRESULT
	put_text as function(byval This as IXTLRuntime ptr, byval text_ as BSTR) as HRESULT
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

extern CLSID_DOMDocument as const CLSID
extern CLSID_DOMFreeThreadedDocument as const CLSID

#define __IXMLHttpRequest_INTERFACE_DEFINED__

extern IID_IXMLHttpRequest as const IID

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

declare function IXMLAttribute_get_name_Proxy(byval This as IXMLAttribute ptr, byval n as BSTR ptr) as HRESULT
declare sub IXMLAttribute_get_name_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)
declare function IXMLAttribute_get_value_Proxy(byval This as IXMLAttribute ptr, byval v as BSTR ptr) as HRESULT
declare sub IXMLAttribute_get_value_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

#define __IXMLError_INTERFACE_DEFINED__

extern IID_IXMLError as const IID

type IXMLErrorVtbl
	QueryInterface as function(byval This as IXMLError ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IXMLError ptr) as ULONG
	Release as function(byval This as IXMLError ptr) as ULONG
	GetErrorInfo as function(byval This as IXMLError ptr, byval pErrorReturn as XML_ERROR ptr) as HRESULT
end type

type IXMLError_
	lpVtbl as IXMLErrorVtbl ptr
end type

declare function IXMLError_GetErrorInfo_Proxy(byval This as IXMLError ptr, byval pErrorReturn as XML_ERROR ptr) as HRESULT
declare sub IXMLError_GetErrorInfo_Stub(byval This as IRpcStubBuffer ptr, byval _pRpcChannelBuffer as IRpcChannelBuffer ptr, byval _pRpcMessage as PRPC_MESSAGE, byval _pdwStubPhase as DWORD ptr)

extern CLSID_XMLDocument as const CLSID

end extern
