''
''
'' mshtml -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_mshtml_bi__
#define __win_mshtml_bi__

#inclib "uuid"

type LPHTMLELEMENTCOLLECTION as IHTMLElementCollection ptr
type LPHTMLELEMENT as IHTMLElement ptr
type LPHTMLSELECTIONOBJECT as IHTMLSelectionObject ptr
type LPHTMLFRAMESCOLLECTION as IHTMLFramesCollection ptr
type LPHTMLLOCATION as IHTMLLocation ptr
type LPHTMLWINDOW2 as IHTMLWindow2 ptr
type LPHTMLSTYLESHEETSCOLLECTION as IHTMLStyleSheetsCollection ptr
type LPHTMLSTYLESHEET as IHTMLStyleSheet ptr
type LPHTMLSTYLE as IHTMLStyle ptr
type LPHTMLFILTERSCOLLECTION as IHTMLFiltersCollection ptr
type LPHTMLLINKELEMENT as IHTMLLinkElement ptr
type LPHTMLIMGELEMENT as IHTMLImgElement ptr
type LPHTMLIMAGEELEMENTFACTORY as IHTMLImageElementFactory ptr
type LPHTMLEVENTOBJ as IHTMLEventObj ptr
type LPHTMLSCREEN as IHTMLScreen ptr
type LPHTMLOPTIONELEMENTFACTORY as IHTMLOptionElementFactory ptr
type LPOMHISTORY as IOmHistory ptr
type LPOMNAVIGATOR as IOmNavigator ptr
extern IID_IHTMLLinkElement alias "IID_IHTMLLinkElement" as IID

type IHTMLLinkElementVtbl_ as IHTMLLinkElementVtbl

type IHTMLLinkElement
	lpVtbl as IHTMLLinkElementVtbl_ ptr
end type

type IHTMLLinkElementVtbl
	QueryInterface as function(byval as IHTMLLinkElement ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IHTMLLinkElement ptr) as ULONG
	Release as function(byval as IHTMLLinkElement ptr) as ULONG
	GetTypeInfoCount as function(byval as IHTMLLinkElement ptr, byval as UINT ptr) as HRESULT
	GetTypeInfo as function(byval as IHTMLLinkElement ptr, byval as UINT, byval as LCID, byval as LPTYPEINFO ptr) as HRESULT
	GetIDsOfNames as function(byval as IHTMLLinkElement ptr, byval as IID ptr, byval as LPOLESTR ptr, byval as UINT, byval as LCID, byval as DISPID ptr) as HRESULT
	Invoke as function(byval as IHTMLLinkElement ptr, byval as DISPID, byval as IID ptr, byval as LCID, byval as WORD, byval as DISPPARAMS ptr, byval as VARIANT_ ptr, byval as EXCEPINFO ptr, byval as UINT ptr) as HRESULT
	put_href as function(byval as IHTMLLinkElement ptr, byval as BSTR) as HRESULT
	get_href as function(byval as IHTMLLinkElement ptr, byval as BSTR ptr) as HRESULT
	put_rel as function(byval as IHTMLLinkElement ptr, byval as BSTR) as HRESULT
	get_rel as function(byval as IHTMLLinkElement ptr, byval as BSTR ptr) as HRESULT
	put_rev as function(byval as IHTMLLinkElement ptr, byval as BSTR) as HRESULT
	get_rev as function(byval as IHTMLLinkElement ptr, byval as BSTR ptr) as HRESULT
	put_type as function(byval as IHTMLLinkElement ptr, byval as BSTR) as HRESULT
	get_type as function(byval as IHTMLLinkElement ptr, byval as BSTR ptr) as HRESULT
	get_readyState as function(byval as IHTMLLinkElement ptr, byval as BSTR ptr) as HRESULT
	put_onreadystatechange as function(byval as IHTMLLinkElement ptr, byval as VARIANT_) as HRESULT
	get_onreadystatechange as function(byval as IHTMLLinkElement ptr, byval as VARIANT_ ptr) as HRESULT
	put_onload as function(byval as IHTMLLinkElement ptr, byval as VARIANT_) as HRESULT
	get_onload as function(byval as IHTMLLinkElement ptr, byval as VARIANT_ ptr) as HRESULT
	put_onerror as function(byval as IHTMLLinkElement ptr, byval as VARIANT_) as HRESULT
	get_onerror as function(byval as IHTMLLinkElement ptr, byval as VARIANT_ ptr) as HRESULT
	get_styleSheet as function(byval as IHTMLLinkElement ptr, byval as LPHTMLSTYLESHEET ptr) as HRESULT
	put_disabled as function(byval as IHTMLLinkElement ptr, byval as VARIANT_BOOL) as HRESULT
	get_disabled as function(byval as IHTMLLinkElement ptr, byval as VARIANT_BOOL ptr) as HRESULT
	put_media as function(byval as IHTMLLinkElement ptr, byval as BSTR) as HRESULT
	get_media as function(byval as IHTMLLinkElement ptr, byval as BSTR ptr) as HRESULT
end type
extern IID_IHTMLImgElement alias "IID_IHTMLImgElement" as IID

type IHTMLImgElementVtbl_ as IHTMLImgElementVtbl

type IHTMLImgElement
	lpVtbl as IHTMLImgElementVtbl_ ptr
end type

type IHTMLImgElementVtbl
	QueryInterface as function(byval as IHTMLImgElement ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IHTMLImgElement ptr) as ULONG
	Release as function(byval as IHTMLImgElement ptr) as ULONG
	GetTypeInfoCount as function(byval as IHTMLImgElement ptr, byval as UINT ptr) as HRESULT
	GetTypeInfo as function(byval as IHTMLImgElement ptr, byval as UINT, byval as LCID, byval as LPTYPEINFO ptr) as HRESULT
	GetIDsOfNames as function(byval as IHTMLImgElement ptr, byval as IID ptr, byval as LPOLESTR ptr, byval as UINT, byval as LCID, byval as DISPID ptr) as HRESULT
	Invoke as function(byval as IHTMLImgElement ptr, byval as DISPID, byval as IID ptr, byval as LCID, byval as WORD, byval as DISPPARAMS ptr, byval as VARIANT_ ptr, byval as EXCEPINFO ptr, byval as UINT ptr) as HRESULT
	put_isMap as function(byval as IHTMLImgElement ptr, byval as VARIANT_BOOL) as HRESULT
	get_isMap as function(byval as IHTMLImgElement ptr, byval as VARIANT_BOOL ptr) as HRESULT
	put_useMap as function(byval as IHTMLImgElement ptr, byval as BSTR) as HRESULT
	get_useMap as function(byval as IHTMLImgElement ptr, byval as BSTR ptr) as HRESULT
	get_mimeType as function(byval as IHTMLImgElement ptr, byval as BSTR ptr) as HRESULT
	get_fileSize as function(byval as IHTMLImgElement ptr, byval as BSTR ptr) as HRESULT
	get_fileCreatedDate as function(byval as IHTMLImgElement ptr, byval as BSTR ptr) as HRESULT
	get_fileModifiedDate as function(byval as IHTMLImgElement ptr, byval as BSTR ptr) as HRESULT
	get_fileUpdatedDate as function(byval as IHTMLImgElement ptr, byval as BSTR ptr) as HRESULT
	get_protocol as function(byval as IHTMLImgElement ptr, byval as BSTR ptr) as HRESULT
	get_href as function(byval as IHTMLImgElement ptr, byval as BSTR ptr) as HRESULT
	get_nameProp as function(byval as IHTMLImgElement ptr, byval as BSTR ptr) as HRESULT
	put_border as function(byval as IHTMLImgElement ptr, byval as VARIANT_) as HRESULT
	get_border as function(byval as IHTMLImgElement ptr, byval as VARIANT_ ptr) as HRESULT
	put_vspace as function(byval as IHTMLImgElement ptr, byval as integer) as HRESULT
	get_vspace as function(byval as IHTMLImgElement ptr, byval as integer ptr) as HRESULT
	put_hspace as function(byval as IHTMLImgElement ptr, byval as integer) as HRESULT
	get_hspace as function(byval as IHTMLImgElement ptr, byval as integer ptr) as HRESULT
	put_alt as function(byval as IHTMLImgElement ptr, byval as BSTR) as HRESULT
	get_alt as function(byval as IHTMLImgElement ptr, byval as BSTR ptr) as HRESULT
	put_src as function(byval as IHTMLImgElement ptr, byval as BSTR) as HRESULT
	get_src as function(byval as IHTMLImgElement ptr, byval as BSTR ptr) as HRESULT
	put_lowsrc as function(byval as IHTMLImgElement ptr, byval as BSTR) as HRESULT
	get_lowsrc as function(byval as IHTMLImgElement ptr, byval as BSTR ptr) as HRESULT
	put_vrml as function(byval as IHTMLImgElement ptr, byval as BSTR) as HRESULT
	get_vrml as function(byval as IHTMLImgElement ptr, byval as BSTR ptr) as HRESULT
	put_dynsrc as function(byval as IHTMLImgElement ptr, byval as BSTR) as HRESULT
	get_dynsrc as function(byval as IHTMLImgElement ptr, byval as BSTR ptr) as HRESULT
	get_readyState as function(byval as IHTMLImgElement ptr, byval as BSTR ptr) as HRESULT
	get_complete as function(byval as IHTMLImgElement ptr, byval as VARIANT_BOOL ptr) as HRESULT
	put_loop as function(byval as IHTMLImgElement ptr, byval as VARIANT_) as HRESULT
	get_loop as function(byval as IHTMLImgElement ptr, byval as VARIANT_ ptr) as HRESULT
	put_align as function(byval as IHTMLImgElement ptr, byval as BSTR) as HRESULT
	get_align as function(byval as IHTMLImgElement ptr, byval as BSTR ptr) as HRESULT
	put_onload as function(byval as IHTMLImgElement ptr, byval as VARIANT_) as HRESULT
	get_onload as function(byval as IHTMLImgElement ptr, byval as VARIANT_ ptr) as HRESULT
	put_onerror as function(byval as IHTMLImgElement ptr, byval as VARIANT_) as HRESULT
	get_onerror as function(byval as IHTMLImgElement ptr, byval as VARIANT_ ptr) as HRESULT
	put_onabort as function(byval as IHTMLImgElement ptr, byval as VARIANT_) as HRESULT
	get_onabort as function(byval as IHTMLImgElement ptr, byval as VARIANT_ ptr) as HRESULT
	put_name as function(byval as IHTMLImgElement ptr, byval as BSTR) as HRESULT
	get_name as function(byval as IHTMLImgElement ptr, byval as BSTR ptr) as HRESULT
	put_width as function(byval as IHTMLImgElement ptr, byval as integer) as HRESULT
	get_width as function(byval as IHTMLImgElement ptr, byval as integer ptr) as HRESULT
	put_height as function(byval as IHTMLImgElement ptr, byval as integer) as HRESULT
	get_height as function(byval as IHTMLImgElement ptr, byval as integer ptr) as HRESULT
	put_start as function(byval as IHTMLImgElement ptr, byval as BSTR) as HRESULT
	get_start as function(byval as IHTMLImgElement ptr, byval as BSTR ptr) as HRESULT
end type
extern IID_IHTMLElementCollection alias "IID_IHTMLElementCollection" as IID

type IHTMLElementCollectionVtbl_ as IHTMLElementCollectionVtbl

type IHTMLElementCollection
	lpVtbl as IHTMLElementCollectionVtbl_ ptr
end type

type IHTMLElementCollectionVtbl
	QueryInterface as function(byval as IHTMLElementCollection ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IHTMLElementCollection ptr) as ULONG
	Release as function(byval as IHTMLElementCollection ptr) as ULONG
	GetTypeInfoCount as function(byval as IHTMLElementCollection ptr, byval as UINT ptr) as HRESULT
	GetTypeInfo as function(byval as IHTMLElementCollection ptr, byval as UINT, byval as LCID, byval as LPTYPEINFO ptr) as HRESULT
	GetIDsOfNames as function(byval as IHTMLElementCollection ptr, byval as IID ptr, byval as LPOLESTR ptr, byval as UINT, byval as LCID, byval as DISPID ptr) as HRESULT
	Invoke as function(byval as IHTMLElementCollection ptr, byval as DISPID, byval as IID ptr, byval as LCID, byval as WORD, byval as DISPPARAMS ptr, byval as VARIANT_ ptr, byval as EXCEPINFO ptr, byval as UINT ptr) as HRESULT
	toString as function(byval as IHTMLElementCollection ptr, byval as BSTR ptr) as HRESULT
	put_length as function(byval as IHTMLElementCollection ptr, byval as integer) as HRESULT
	get_length as function(byval as IHTMLElementCollection ptr, byval as integer ptr) as HRESULT
	get__newEnum as function(byval as IHTMLElementCollection ptr, byval as IUnknown ptr ptr) as HRESULT
	item as function(byval as IHTMLElementCollection ptr, byval as VARIANT_, byval as VARIANT_, byval as IDispatch ptr ptr) as HRESULT
	tags as function(byval as IHTMLElementCollection ptr, byval as VARIANT_, byval as IDispatch ptr ptr) as HRESULT
end type
extern IID_IHTMLDocument alias "IID_IHTMLDocument" as IID

type IHTMLDocumentVtbl_ as IHTMLDocumentVtbl

type IHTMLDocument
	lpVtbl as IHTMLDocumentVtbl_ ptr
end type

type IHTMLDocumentVtbl
	QueryInterface as function(byval as IHTMLDocument ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IHTMLDocument ptr) as ULONG
	Release as function(byval as IHTMLDocument ptr) as ULONG
	GetTypeInfoCount as function(byval as IHTMLDocument ptr, byval as UINT ptr) as HRESULT
	GetTypeInfo as function(byval as IHTMLDocument ptr, byval as UINT, byval as LCID, byval as LPTYPEINFO ptr) as HRESULT
	GetIDsOfNames as function(byval as IHTMLDocument ptr, byval as IID ptr, byval as LPOLESTR ptr, byval as UINT, byval as LCID, byval as DISPID ptr) as HRESULT
	Invoke as function(byval as IHTMLDocument ptr, byval as DISPID, byval as IID ptr, byval as LCID, byval as WORD, byval as DISPPARAMS ptr, byval as VARIANT_ ptr, byval as EXCEPINFO ptr, byval as UINT ptr) as HRESULT
	get_Script as function(byval as IHTMLDocument ptr, byval as IDispatch ptr ptr) as HRESULT
end type
extern IID_IHTMLDocument2 alias "IID_IHTMLDocument2" as IID

type IHTMLDocument2Vtbl_ as IHTMLDocument2Vtbl

type IHTMLDocument2
	lpVtbl as IHTMLDocument2Vtbl_ ptr
end type

type IHTMLDocument2Vtbl
	QueryInterface as function(byval as IHTMLDocument2 ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IHTMLDocument2 ptr) as ULONG
	Release as function(byval as IHTMLDocument2 ptr) as ULONG
	GetTypeInfoCount as function(byval as IHTMLDocument2 ptr, byval as UINT ptr) as HRESULT
	GetTypeInfo as function(byval as IHTMLDocument2 ptr, byval as UINT, byval as LCID, byval as LPTYPEINFO ptr) as HRESULT
	GetIDsOfNames as function(byval as IHTMLDocument2 ptr, byval as IID ptr, byval as LPOLESTR ptr, byval as UINT, byval as LCID, byval as DISPID ptr) as HRESULT
	Invoke as function(byval as IHTMLDocument2 ptr, byval as DISPID, byval as IID ptr, byval as LCID, byval as WORD, byval as DISPPARAMS ptr, byval as VARIANT_ ptr, byval as EXCEPINFO ptr, byval as UINT ptr) as HRESULT
	get_Script as function(byval as IHTMLDocument2 ptr, byval as IDispatch ptr ptr) as HRESULT
	get_all as function(byval as IHTMLDocument2 ptr, byval as LPHTMLELEMENTCOLLECTION ptr) as HRESULT
	get_body as function(byval as IHTMLDocument2 ptr, byval as LPHTMLELEMENT ptr) as HRESULT
	get_activeElement as function(byval as IHTMLDocument2 ptr, byval as LPHTMLELEMENT ptr) as HRESULT
	get_images as function(byval as IHTMLDocument2 ptr, byval as LPHTMLELEMENTCOLLECTION ptr) as HRESULT
	get_applets as function(byval as IHTMLDocument2 ptr, byval as LPHTMLELEMENTCOLLECTION ptr) as HRESULT
	get_links as function(byval as IHTMLDocument2 ptr, byval as LPHTMLELEMENTCOLLECTION ptr) as HRESULT
	get_forms as function(byval as IHTMLDocument2 ptr, byval as LPHTMLELEMENTCOLLECTION ptr) as HRESULT
	get_anchors as function(byval as IHTMLDocument2 ptr, byval as LPHTMLELEMENTCOLLECTION ptr) as HRESULT
	put_title as function(byval as IHTMLDocument2 ptr, byval as BSTR) as HRESULT
	get_title as function(byval as IHTMLDocument2 ptr, byval as BSTR ptr) as HRESULT
	get_scripts as function(byval as IHTMLDocument2 ptr, byval as LPHTMLELEMENTCOLLECTION ptr) as HRESULT
	put_designMode as function(byval as IHTMLDocument2 ptr, byval as BSTR) as HRESULT
	get_designMode as function(byval as IHTMLDocument2 ptr, byval as BSTR ptr) as HRESULT
	get_selection as function(byval as IHTMLDocument2 ptr, byval as LPHTMLSELECTIONOBJECT ptr) as HRESULT
	get_readyState as function(byval as IHTMLDocument2 ptr, byval as BSTR ptr) as HRESULT
	get_frames as function(byval as IHTMLDocument2 ptr, byval as LPHTMLFRAMESCOLLECTION ptr) as HRESULT
	get_embeds as function(byval as IHTMLDocument2 ptr, byval as LPHTMLELEMENTCOLLECTION ptr) as HRESULT
	get_plugins as function(byval as IHTMLDocument2 ptr, byval as LPHTMLELEMENTCOLLECTION ptr) as HRESULT
	put_alinkColor as function(byval as IHTMLDocument2 ptr, byval as VARIANT_) as HRESULT
	get_alinkColor as function(byval as IHTMLDocument2 ptr, byval as VARIANT_ ptr) as HRESULT
	put_bgColor as function(byval as IHTMLDocument2 ptr, byval as VARIANT_) as HRESULT
	get_bgColor as function(byval as IHTMLDocument2 ptr, byval as VARIANT_ ptr) as HRESULT
	put_fgColor as function(byval as IHTMLDocument2 ptr, byval as VARIANT_) as HRESULT
	get_fgColor as function(byval as IHTMLDocument2 ptr, byval as VARIANT_ ptr) as HRESULT
	put_linkColor as function(byval as IHTMLDocument2 ptr, byval as VARIANT_) as HRESULT
	get_linkColor as function(byval as IHTMLDocument2 ptr, byval as VARIANT_ ptr) as HRESULT
	put_vlinkColor as function(byval as IHTMLDocument2 ptr, byval as VARIANT_) as HRESULT
	get_vlinkColor as function(byval as IHTMLDocument2 ptr, byval as VARIANT_ ptr) as HRESULT
	get_referrer as function(byval as IHTMLDocument2 ptr, byval as BSTR ptr) as HRESULT
	get_location as function(byval as IHTMLDocument2 ptr, byval as LPHTMLLOCATION ptr) as HRESULT
	get_lastModified as function(byval as IHTMLDocument2 ptr, byval as BSTR ptr) as HRESULT
	put_url as function(byval as IHTMLDocument2 ptr, byval as BSTR) as HRESULT
	get_url as function(byval as IHTMLDocument2 ptr, byval as BSTR ptr) as HRESULT
	put_domain as function(byval as IHTMLDocument2 ptr, byval as BSTR) as HRESULT
	get_domain as function(byval as IHTMLDocument2 ptr, byval as BSTR ptr) as HRESULT
	put_cookie as function(byval as IHTMLDocument2 ptr, byval as BSTR) as HRESULT
	get_cookie as function(byval as IHTMLDocument2 ptr, byval as BSTR ptr) as HRESULT
	put_expands as function(byval as IHTMLDocument2 ptr, byval as VARIANT_BOOL) as HRESULT
	get_expands as function(byval as IHTMLDocument2 ptr, byval as VARIANT_BOOL ptr) as HRESULT
	put_charset as function(byval as IHTMLDocument2 ptr, byval as BSTR) as HRESULT
	get_charset as function(byval as IHTMLDocument2 ptr, byval as BSTR ptr) as HRESULT
	put_defaultCharset as function(byval as IHTMLDocument2 ptr, byval as BSTR) as HRESULT
	get_defaultCharset as function(byval as IHTMLDocument2 ptr, byval as BSTR ptr) as HRESULT
	get_mimeType as function(byval as IHTMLDocument2 ptr, byval as BSTR ptr) as HRESULT
	get_fileSize as function(byval as IHTMLDocument2 ptr, byval as BSTR ptr) as HRESULT
	get_fileCreatedDate as function(byval as IHTMLDocument2 ptr, byval as BSTR ptr) as HRESULT
	get_fileModifiedDate as function(byval as IHTMLDocument2 ptr, byval as BSTR ptr) as HRESULT
	get_fileUpdatedDate as function(byval as IHTMLDocument2 ptr, byval as BSTR ptr) as HRESULT
	get_security as function(byval as IHTMLDocument2 ptr, byval as BSTR ptr) as HRESULT
	get_protocol as function(byval as IHTMLDocument2 ptr, byval as BSTR ptr) as HRESULT
	get_nameProp as function(byval as IHTMLDocument2 ptr, byval as BSTR ptr) as HRESULT
	write as function(byval as IHTMLDocument2 ptr, byval as SAFEARRAY ptr) as HRESULT
	writeln as function(byval as IHTMLDocument2 ptr, byval as SAFEARRAY ptr) as HRESULT
	open as function(byval as IHTMLDocument2 ptr, byval as BSTR, byval as VARIANT_, byval as VARIANT_, byval as VARIANT_, byval as IDispatch ptr ptr) as HRESULT
	close as function(byval as IHTMLDocument2 ptr) as HRESULT
	clear as function(byval as IHTMLDocument2 ptr) as HRESULT
	queryCommandSupported as function(byval as IHTMLDocument2 ptr, byval as BSTR, byval as VARIANT_BOOL ptr) as HRESULT
	queryCommandEnabled as function(byval as IHTMLDocument2 ptr, byval as BSTR, byval as VARIANT_BOOL ptr) as HRESULT
	queryCommandState as function(byval as IHTMLDocument2 ptr, byval as BSTR, byval as VARIANT_BOOL ptr) as HRESULT
	queryCommandIndeterm as function(byval as IHTMLDocument2 ptr, byval as BSTR, byval as VARIANT_BOOL ptr) as HRESULT
	queryCommandText as function(byval as IHTMLDocument2 ptr, byval as BSTR, byval as BSTR ptr) as HRESULT
	queryCommandValue as function(byval as IHTMLDocument2 ptr, byval as BSTR, byval as VARIANT_ ptr) as HRESULT
	execCommand as function(byval as IHTMLDocument2 ptr, byval as BSTR, byval as VARIANT_BOOL, byval as VARIANT_, byval as VARIANT_BOOL ptr) as HRESULT
	execCommandShowHelp as function(byval as IHTMLDocument2 ptr, byval as BSTR, byval as VARIANT_BOOL ptr) as HRESULT
	createElement as function(byval as IHTMLDocument2 ptr, byval as BSTR, byval as LPHTMLELEMENT ptr) as HRESULT
	put_onhelp as function(byval as IHTMLDocument2 ptr, byval as VARIANT_) as HRESULT
	get_onhelp as function(byval as IHTMLDocument2 ptr, byval as VARIANT_ ptr) as HRESULT
	put_onclick as function(byval as IHTMLDocument2 ptr, byval as VARIANT_) as HRESULT
	get_onclick as function(byval as IHTMLDocument2 ptr, byval as VARIANT_ ptr) as HRESULT
	put_ondblclick as function(byval as IHTMLDocument2 ptr, byval as VARIANT_) as HRESULT
	get_ondblclick as function(byval as IHTMLDocument2 ptr, byval as VARIANT_ ptr) as HRESULT
	put_onkeyup as function(byval as IHTMLDocument2 ptr, byval as VARIANT_) as HRESULT
	get_onkeyup as function(byval as IHTMLDocument2 ptr, byval as VARIANT_ ptr) as HRESULT
	put_onkeydown as function(byval as IHTMLDocument2 ptr, byval as VARIANT_) as HRESULT
	get_onkeydown as function(byval as IHTMLDocument2 ptr, byval as VARIANT_ ptr) as HRESULT
	put_onkeypress as function(byval as IHTMLDocument2 ptr, byval as VARIANT_) as HRESULT
	get_onkeypress as function(byval as IHTMLDocument2 ptr, byval as VARIANT_ ptr) as HRESULT
	put_onmouseup as function(byval as IHTMLDocument2 ptr, byval as VARIANT_) as HRESULT
	get_onmouseup as function(byval as IHTMLDocument2 ptr, byval as VARIANT_ ptr) as HRESULT
	put_onmousedown as function(byval as IHTMLDocument2 ptr, byval as VARIANT_) as HRESULT
	get_onmousedown as function(byval as IHTMLDocument2 ptr, byval as VARIANT_ ptr) as HRESULT
	put_onmousemove as function(byval as IHTMLDocument2 ptr, byval as VARIANT_) as HRESULT
	get_onmousemove as function(byval as IHTMLDocument2 ptr, byval as VARIANT_ ptr) as HRESULT
	put_onmouseout as function(byval as IHTMLDocument2 ptr, byval as VARIANT_) as HRESULT
	get_onmouseout as function(byval as IHTMLDocument2 ptr, byval as VARIANT_ ptr) as HRESULT
	put_onmouseover as function(byval as IHTMLDocument2 ptr, byval as VARIANT_) as HRESULT
	get_onmouseover as function(byval as IHTMLDocument2 ptr, byval as VARIANT_ ptr) as HRESULT
	put_onreadystatechange as function(byval as IHTMLDocument2 ptr, byval as VARIANT_) as HRESULT
	get_onreadystatechange as function(byval as IHTMLDocument2 ptr, byval as VARIANT_ ptr) as HRESULT
	put_onafterupdate as function(byval as IHTMLDocument2 ptr, byval as VARIANT_) as HRESULT
	get_onafterupdate as function(byval as IHTMLDocument2 ptr, byval as VARIANT_ ptr) as HRESULT
	put_onrowexit as function(byval as IHTMLDocument2 ptr, byval as VARIANT_) as HRESULT
	get_onrowexit as function(byval as IHTMLDocument2 ptr, byval as VARIANT_ ptr) as HRESULT
	put_onrowenter as function(byval as IHTMLDocument2 ptr, byval as VARIANT_) as HRESULT
	get_onrowenter as function(byval as IHTMLDocument2 ptr, byval as VARIANT_ ptr) as HRESULT
	put_ondragstart as function(byval as IHTMLDocument2 ptr, byval as VARIANT_) as HRESULT
	get_ondragstart as function(byval as IHTMLDocument2 ptr, byval as VARIANT_ ptr) as HRESULT
	put_onselectstart as function(byval as IHTMLDocument2 ptr, byval as VARIANT_) as HRESULT
	get_onselectstart as function(byval as IHTMLDocument2 ptr, byval as VARIANT_ ptr) as HRESULT
	elementFromPoint as function(byval as IHTMLDocument2 ptr, byval as integer, byval as integer, byval as LPHTMLELEMENT ptr) as HRESULT
	get_parentWindow as function(byval as IHTMLDocument2 ptr, byval as LPHTMLWINDOW2 ptr) as HRESULT
	get_styleSheets as function(byval as IHTMLDocument2 ptr, byval as LPHTMLSTYLESHEETSCOLLECTION ptr) as HRESULT
	put_onbeforeupdate as function(byval as IHTMLDocument2 ptr, byval as VARIANT_) as HRESULT
	get_onbeforeupdate as function(byval as IHTMLDocument2 ptr, byval as VARIANT_ ptr) as HRESULT
	put_onerrorupdate as function(byval as IHTMLDocument2 ptr, byval as VARIANT_) as HRESULT
	get_onerrorupdate as function(byval as IHTMLDocument2 ptr, byval as VARIANT_ ptr) as HRESULT
	toString as function(byval as IHTMLDocument2 ptr, byval as BSTR ptr) as HRESULT
	createStyleSheet as function(byval as IHTMLDocument2 ptr, byval as BSTR, byval as integer, byval as LPHTMLSTYLESHEET ptr) as HRESULT
end type
extern IID_IHTMLSelectionObject alias "IID_IHTMLSelectionObject" as IID

type IHTMLSelectionObjectVtbl_ as IHTMLSelectionObjectVtbl

type IHTMLSelectionObject
	lpVtbl as IHTMLSelectionObjectVtbl_ ptr
end type

type IHTMLSelectionObjectVtbl
	QueryInterface as function(byval as IHTMLSelectionObject ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IHTMLSelectionObject ptr) as ULONG
	Release as function(byval as IHTMLSelectionObject ptr) as ULONG
	GetTypeInfoCount as function(byval as IHTMLSelectionObject ptr, byval as UINT ptr) as HRESULT
	GetTypeInfo as function(byval as IHTMLSelectionObject ptr, byval as UINT, byval as LCID, byval as LPTYPEINFO ptr) as HRESULT
	GetIDsOfNames as function(byval as IHTMLSelectionObject ptr, byval as IID ptr, byval as LPOLESTR ptr, byval as UINT, byval as LCID, byval as DISPID ptr) as HRESULT
	Invoke as function(byval as IHTMLSelectionObject ptr, byval as DISPID, byval as IID ptr, byval as LCID, byval as WORD, byval as DISPPARAMS ptr, byval as VARIANT_ ptr, byval as EXCEPINFO ptr, byval as UINT ptr) as HRESULT
	createRange as function(byval as IHTMLSelectionObject ptr, byval as IDispatch ptr ptr) as HRESULT
	empty as function(byval as IHTMLSelectionObject ptr) as HRESULT
	clear as function(byval as IHTMLSelectionObject ptr) as HRESULT
	get_type as function(byval as IHTMLSelectionObject ptr, byval as BSTR ptr) as HRESULT
end type
extern IID_IHTMLTxtRange alias "IID_IHTMLTxtRange" as IID

type IHTMLTxtRangeVtbl_ as IHTMLTxtRangeVtbl

type IHTMLTxtRange
	lpVtbl as IHTMLTxtRangeVtbl_ ptr
end type

type IHTMLTxtRangeVtbl
	QueryInterface as function(byval as IHTMLTxtRange ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IHTMLTxtRange ptr) as ULONG
	Release as function(byval as IHTMLTxtRange ptr) as ULONG
	GetTypeInfoCount as function(byval as IHTMLTxtRange ptr, byval as UINT ptr) as HRESULT
	GetTypeInfo as function(byval as IHTMLTxtRange ptr, byval as UINT, byval as LCID, byval as LPTYPEINFO ptr) as HRESULT
	GetIDsOfNames as function(byval as IHTMLTxtRange ptr, byval as IID ptr, byval as LPOLESTR ptr, byval as UINT, byval as LCID, byval as DISPID ptr) as HRESULT
	Invoke as function(byval as IHTMLTxtRange ptr, byval as DISPID, byval as IID ptr, byval as LCID, byval as WORD, byval as DISPPARAMS ptr, byval as VARIANT_ ptr, byval as EXCEPINFO ptr, byval as UINT ptr) as HRESULT
	get_htmlText as function(byval as IHTMLTxtRange ptr, byval as BSTR ptr) as HRESULT
	put_text as function(byval as IHTMLTxtRange ptr, byval as BSTR) as HRESULT
	get_text as function(byval as IHTMLTxtRange ptr, byval as BSTR ptr) as HRESULT
	parentElement as function(byval as IHTMLTxtRange ptr, byval as LPHTMLELEMENT ptr) as HRESULT
	duplicate_ as function(byval as IHTMLTxtRange ptr, byval as IHTMLTxtRange ptr ptr) as HRESULT
	inRange as function(byval as IHTMLTxtRange ptr, byval as IHTMLTxtRange ptr, byval as VARIANT_BOOL ptr) as HRESULT
	isEqual as function(byval as IHTMLTxtRange ptr, byval as IHTMLTxtRange ptr, byval as VARIANT_BOOL ptr) as HRESULT
	scrollIntoView as function(byval as IHTMLTxtRange ptr, byval as VARIANT_BOOL) as HRESULT
	collapse as function(byval as IHTMLTxtRange ptr, byval as VARIANT_BOOL) as HRESULT
	expand as function(byval as IHTMLTxtRange ptr, byval as BSTR, byval as VARIANT_BOOL ptr) as HRESULT
	move as function(byval as IHTMLTxtRange ptr, byval as BSTR, byval as integer, byval as integer ptr) as HRESULT
	moveStart as function(byval as IHTMLTxtRange ptr, byval as BSTR, byval as integer, byval as integer ptr) as HRESULT
	moveEnd as function(byval as IHTMLTxtRange ptr, byval as BSTR, byval as integer, byval as integer ptr) as HRESULT
	select as function(byval as IHTMLTxtRange ptr) as HRESULT
	pasteHTML as function(byval as IHTMLTxtRange ptr, byval as BSTR) as HRESULT
	moveToElementText as function(byval as IHTMLTxtRange ptr, byval as LPHTMLELEMENT) as HRESULT
	setEndPoint as function(byval as IHTMLTxtRange ptr, byval as BSTR, byval as IHTMLTxtRange ptr) as HRESULT
	compareEndPoints as function(byval as IHTMLTxtRange ptr, byval as BSTR, byval as IHTMLTxtRange ptr, byval as integer ptr) as HRESULT
	findText as function(byval as IHTMLTxtRange ptr, byval as BSTR, byval as integer, byval as integer, byval as VARIANT_BOOL ptr) as HRESULT
	moveToPoint as function(byval as IHTMLTxtRange ptr, byval as integer, byval as integer) as HRESULT
	getBookmark as function(byval as IHTMLTxtRange ptr, byval as BSTR ptr) as HRESULT
	moveToBookbark as function(byval as IHTMLTxtRange ptr, byval as BSTR, byval as VARIANT_BOOL ptr) as HRESULT
	queryCommandSupported as function(byval as IHTMLTxtRange ptr, byval as BSTR, byval as VARIANT_BOOL ptr) as HRESULT
	queryCommandEnabled as function(byval as IHTMLTxtRange ptr, byval as BSTR, byval as VARIANT_BOOL ptr) as HRESULT
	queryCommandState as function(byval as IHTMLTxtRange ptr, byval as BSTR, byval as VARIANT_BOOL ptr) as HRESULT
	queryCommandIndeterm as function(byval as IHTMLTxtRange ptr, byval as BSTR, byval as VARIANT_BOOL ptr) as HRESULT
	queryCommandText as function(byval as IHTMLTxtRange ptr, byval as BSTR, byval as BSTR ptr) as HRESULT
	queryCommandValue as function(byval as IHTMLTxtRange ptr, byval as BSTR, byval as VARIANT_ ptr) as HRESULT
	execCommand as function(byval as IHTMLTxtRange ptr, byval as BSTR, byval as VARIANT_BOOL, byval as VARIANT_, byval as VARIANT_BOOL ptr) as HRESULT
	execCommandShowHelp as function(byval as IHTMLTxtRange ptr, byval as BSTR, byval as VARIANT_BOOL ptr) as HRESULT
end type
extern IID_IHTMLElement alias "IID_IHTMLElement" as IID

type IHTMLElementVtbl_ as IHTMLElementVtbl

type IHTMLElement
	lpVtbl as IHTMLElementVtbl_ ptr
end type

type IHTMLElementVtbl
	QueryInterface as function(byval as IHTMLElement ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IHTMLElement ptr) as ULONG
	Release as function(byval as IHTMLElement ptr) as ULONG
	GetTypeInfoCount as function(byval as IHTMLElement ptr, byval as UINT ptr) as HRESULT
	GetTypeInfo as function(byval as IHTMLElement ptr, byval as UINT, byval as LCID, byval as LPTYPEINFO ptr) as HRESULT
	GetIDsOfNames as function(byval as IHTMLElement ptr, byval as IID ptr, byval as LPOLESTR ptr, byval as UINT, byval as LCID, byval as DISPID ptr) as HRESULT
	Invoke as function(byval as IHTMLElement ptr, byval as DISPID, byval as IID ptr, byval as LCID, byval as WORD, byval as DISPPARAMS ptr, byval as VARIANT_ ptr, byval as EXCEPINFO ptr, byval as UINT ptr) as HRESULT
	setAttribute as function(byval as IHTMLElement ptr, byval as BSTR, byval as VARIANT_, byval as integer) as HRESULT
	getAttribute as function(byval as IHTMLElement ptr, byval as BSTR, byval as integer, byval as VARIANT_ ptr) as HRESULT
	removeAttribute as function(byval as IHTMLElement ptr, byval as BSTR, byval as integer, byval as VARIANT_BOOL ptr) as HRESULT
	put_className as function(byval as IHTMLElement ptr, byval as BSTR) as HRESULT
	get_className as function(byval as IHTMLElement ptr, byval as BSTR ptr) as HRESULT
	put_id as function(byval as IHTMLElement ptr, byval as BSTR) as HRESULT
	get_id as function(byval as IHTMLElement ptr, byval as BSTR ptr) as HRESULT
	get_tagName as function(byval as IHTMLElement ptr, byval as BSTR ptr) as HRESULT
	get_parentElement as function(byval as IHTMLElement ptr, byval as LPHTMLELEMENT ptr) as HRESULT
	get_style as function(byval as IHTMLElement ptr, byval as LPHTMLSTYLE ptr) as HRESULT
	put_onhelp as function(byval as IHTMLElement ptr, byval as VARIANT_) as HRESULT
	get_onhelp as function(byval as IHTMLElement ptr, byval as VARIANT_ ptr) as HRESULT
	put_onclick as function(byval as IHTMLElement ptr, byval as VARIANT_) as HRESULT
	get_onclick as function(byval as IHTMLElement ptr, byval as VARIANT_ ptr) as HRESULT
	put_ondblclick as function(byval as IHTMLElement ptr, byval as VARIANT_) as HRESULT
	get_ondblclick as function(byval as IHTMLElement ptr, byval as VARIANT_ ptr) as HRESULT
	put_onkeydown as function(byval as IHTMLElement ptr, byval as VARIANT_) as HRESULT
	get_onkeydown as function(byval as IHTMLElement ptr, byval as VARIANT_ ptr) as HRESULT
	put_onkeyup as function(byval as IHTMLElement ptr, byval as VARIANT_) as HRESULT
	get_onkeyup as function(byval as IHTMLElement ptr, byval as VARIANT_ ptr) as HRESULT
	put_onkeypress as function(byval as IHTMLElement ptr, byval as VARIANT_) as HRESULT
	get_onkeypress as function(byval as IHTMLElement ptr, byval as VARIANT_ ptr) as HRESULT
	put_onmouseout as function(byval as IHTMLElement ptr, byval as VARIANT_) as HRESULT
	get_onmouseout as function(byval as IHTMLElement ptr, byval as VARIANT_ ptr) as HRESULT
	put_onmouseover as function(byval as IHTMLElement ptr, byval as VARIANT_) as HRESULT
	get_onmouseover as function(byval as IHTMLElement ptr, byval as VARIANT_ ptr) as HRESULT
	put_onmousemove as function(byval as IHTMLElement ptr, byval as VARIANT_) as HRESULT
	get_onmousemove as function(byval as IHTMLElement ptr, byval as VARIANT_ ptr) as HRESULT
	put_onmousedown as function(byval as IHTMLElement ptr, byval as VARIANT_) as HRESULT
	get_onmousedown as function(byval as IHTMLElement ptr, byval as VARIANT_ ptr) as HRESULT
	put_onmouseup as function(byval as IHTMLElement ptr, byval as VARIANT_) as HRESULT
	get_onmouseup as function(byval as IHTMLElement ptr, byval as VARIANT_ ptr) as HRESULT
	get_document as function(byval as IHTMLElement ptr, byval as IDispatch ptr ptr) as HRESULT
	put_title as function(byval as IHTMLElement ptr, byval as BSTR) as HRESULT
	get_title as function(byval as IHTMLElement ptr, byval as BSTR ptr) as HRESULT
	put_language as function(byval as IHTMLElement ptr, byval as BSTR) as HRESULT
	get_language as function(byval as IHTMLElement ptr, byval as BSTR ptr) as HRESULT
	put_onselectstart as function(byval as IHTMLElement ptr, byval as VARIANT_) as HRESULT
	get_onselectstart as function(byval as IHTMLElement ptr, byval as VARIANT_ ptr) as HRESULT
	scrollIntoView as function(byval as IHTMLElement ptr, byval as VARIANT_) as HRESULT
	contains as function(byval as IHTMLElement ptr, byval as LPHTMLELEMENT, byval as VARIANT_BOOL ptr) as HRESULT
	get_source3Index as function(byval as IHTMLElement ptr, byval as integer ptr) as HRESULT
	get_recordNumber as function(byval as IHTMLElement ptr, byval as VARIANT_ ptr) as HRESULT
	put_lang as function(byval as IHTMLElement ptr, byval as BSTR) as HRESULT
	get_lang as function(byval as IHTMLElement ptr, byval as BSTR ptr) as HRESULT
	get_offsetLeft as function(byval as IHTMLElement ptr, byval as integer ptr) as HRESULT
	get_offsetTop as function(byval as IHTMLElement ptr, byval as integer ptr) as HRESULT
	get_offsetWidth as function(byval as IHTMLElement ptr, byval as integer ptr) as HRESULT
	get_offsetHeight as function(byval as IHTMLElement ptr, byval as integer ptr) as HRESULT
	get_offsetParent as function(byval as IHTMLElement ptr, byval as LPHTMLELEMENT ptr) as HRESULT
	put_innerHTML as function(byval as IHTMLElement ptr, byval as BSTR) as HRESULT
	get_innerHTML as function(byval as IHTMLElement ptr, byval as BSTR ptr) as HRESULT
	put_innerText as function(byval as IHTMLElement ptr, byval as BSTR) as HRESULT
	get_innerText as function(byval as IHTMLElement ptr, byval as BSTR ptr) as HRESULT
	put_outerHTML as function(byval as IHTMLElement ptr, byval as BSTR) as HRESULT
	get_outerHTML as function(byval as IHTMLElement ptr, byval as BSTR ptr) as HRESULT
	put_outerText as function(byval as IHTMLElement ptr, byval as BSTR) as HRESULT
	get_outerText as function(byval as IHTMLElement ptr, byval as BSTR ptr) as HRESULT
	insertAdjacentHTML as function(byval as IHTMLElement ptr, byval as BSTR, byval as BSTR) as HRESULT
	insertAdjacentText as function(byval as IHTMLElement ptr, byval as BSTR, byval as BSTR) as HRESULT
	get_parentTextEdit as function(byval as IHTMLElement ptr, byval as LPHTMLELEMENT ptr) as HRESULT
	isTextEdit as function(byval as IHTMLElement ptr, byval as VARIANT_BOOL ptr) as HRESULT
	click as function(byval as IHTMLElement ptr) as HRESULT
	get_filters as function(byval as IHTMLElement ptr, byval as LPHTMLFILTERSCOLLECTION ptr) as HRESULT
	put_ondragstart as function(byval as IHTMLElement ptr, byval as VARIANT_) as HRESULT
	get_ondragstart as function(byval as IHTMLElement ptr, byval as VARIANT_ ptr) as HRESULT
	toString as function(byval as IHTMLElement ptr, byval as BSTR ptr) as HRESULT
	put_onbeforeupdate as function(byval as IHTMLElement ptr, byval as VARIANT_) as HRESULT
	get_onbeforeupdate as function(byval as IHTMLElement ptr, byval as VARIANT_ ptr) as HRESULT
	put_onafterupdate as function(byval as IHTMLElement ptr, byval as VARIANT_) as HRESULT
	get_onafterupdate as function(byval as IHTMLElement ptr, byval as VARIANT_ ptr) as HRESULT
	put_onerrorupdate as function(byval as IHTMLElement ptr, byval as VARIANT_) as HRESULT
	get_onerrorupdate as function(byval as IHTMLElement ptr, byval as VARIANT_ ptr) as HRESULT
	put_onrowexit as function(byval as IHTMLElement ptr, byval as VARIANT_) as HRESULT
	get_onrowexit as function(byval as IHTMLElement ptr, byval as VARIANT_ ptr) as HRESULT
	put_onrowenter as function(byval as IHTMLElement ptr, byval as VARIANT_) as HRESULT
	get_onrowenter as function(byval as IHTMLElement ptr, byval as VARIANT_ ptr) as HRESULT
	put_ondatasetchanged as function(byval as IHTMLElement ptr, byval as VARIANT_) as HRESULT
	get_ondatasetchanged as function(byval as IHTMLElement ptr, byval as VARIANT_ ptr) as HRESULT
	put_ondataavailable as function(byval as IHTMLElement ptr, byval as VARIANT_) as HRESULT
	get_ondataavailable as function(byval as IHTMLElement ptr, byval as VARIANT_ ptr) as HRESULT
	put_ondatasetcomplete as function(byval as IHTMLElement ptr, byval as VARIANT_) as HRESULT
	get_ondatasetcomplete as function(byval as IHTMLElement ptr, byval as VARIANT_ ptr) as HRESULT
	put_onfilterchange as function(byval as IHTMLElement ptr, byval as VARIANT_) as HRESULT
	get_onfilterchange as function(byval as IHTMLElement ptr, byval as VARIANT_ ptr) as HRESULT
	get_children as function(byval as IHTMLElement ptr, byval as IDispatch ptr ptr) as HRESULT
	get_all as function(byval as IHTMLElement ptr, byval as IDispatch ptr ptr) as HRESULT
end type
extern IID_IHTMLFramesCollection2 alias "IID_IHTMLFramesCollection2" as IID

type IHTMLFramesCollection2Vtbl_ as IHTMLFramesCollection2Vtbl

type IHTMLFramesCollection2
	lpVtbl as IHTMLFramesCollection2Vtbl_ ptr
end type

type IHTMLFramesCollection2Vtbl
	QueryInterface as function(byval as IHTMLFramesCollection2 ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IHTMLFramesCollection2 ptr) as ULONG
	Release as function(byval as IHTMLFramesCollection2 ptr) as ULONG
	GetTypeInfoCount as function(byval as IHTMLFramesCollection2 ptr, byval as UINT ptr) as HRESULT
	GetTypeInfo as function(byval as IHTMLFramesCollection2 ptr, byval as UINT, byval as LCID, byval as LPTYPEINFO ptr) as HRESULT
	GetIDsOfNames as function(byval as IHTMLFramesCollection2 ptr, byval as IID ptr, byval as LPOLESTR ptr, byval as UINT, byval as LCID, byval as DISPID ptr) as HRESULT
	Invoke as function(byval as IHTMLFramesCollection2 ptr, byval as DISPID, byval as IID ptr, byval as LCID, byval as WORD, byval as DISPPARAMS ptr, byval as VARIANT_ ptr, byval as EXCEPINFO ptr, byval as UINT ptr) as HRESULT
	item as function(byval as IHTMLFramesCollection2 ptr, byval as VARIANT_ ptr, byval as VARIANT_ ptr) as HRESULT
	get_length as function(byval as IHTMLFramesCollection2 ptr, byval as integer ptr) as HRESULT
end type
extern IID_IHTMLWindow2 alias "IID_IHTMLWindow2" as IID

type IHTMLWindow2Vtbl_ as IHTMLWindow2Vtbl

type IHTMLWindow2
	lpVtbl as IHTMLWindow2Vtbl_ ptr
end type

type IHTMLWindow2Vtbl
	QueryInterface as function(byval as IHTMLWindow2 ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IHTMLWindow2 ptr) as ULONG
	Release as function(byval as IHTMLWindow2 ptr) as ULONG
	GetTypeInfoCount as function(byval as IHTMLWindow2 ptr, byval as UINT ptr) as HRESULT
	GetTypeInfo as function(byval as IHTMLWindow2 ptr, byval as UINT, byval as LCID, byval as LPTYPEINFO ptr) as HRESULT
	GetIDsOfNames as function(byval as IHTMLWindow2 ptr, byval as IID ptr, byval as LPOLESTR ptr, byval as UINT, byval as LCID, byval as DISPID ptr) as HRESULT
	Invoke as function(byval as IHTMLWindow2 ptr, byval as DISPID, byval as IID ptr, byval as LCID, byval as WORD, byval as DISPPARAMS ptr, byval as VARIANT_ ptr, byval as EXCEPINFO ptr, byval as UINT ptr) as HRESULT
	item as function(byval as IHTMLWindow2 ptr, byval as VARIANT_ ptr, byval as VARIANT_ ptr) as HRESULT
	get_length as function(byval as IHTMLWindow2 ptr, byval as integer ptr) as HRESULT
	get_frames as function(byval as IHTMLWindow2 ptr, byval as IHTMLFramesCollection2 ptr ptr) as HRESULT
	put_defaultStatus as function(byval as IHTMLWindow2 ptr, byval as BSTR) as HRESULT
	get_defaultStatus as function(byval as IHTMLWindow2 ptr, byval as BSTR ptr) as HRESULT
	put_status as function(byval as IHTMLWindow2 ptr, byval as BSTR) as HRESULT
	get_status as function(byval as IHTMLWindow2 ptr, byval as BSTR ptr) as HRESULT
	setTimeout as function(byval as IHTMLWindow2 ptr, byval as BSTR, byval as integer, byval as VARIANT_ ptr, byval as integer ptr) as HRESULT
	clearTimeout as function(byval as IHTMLWindow2 ptr, byval as integer) as HRESULT
	alert as function(byval as IHTMLWindow2 ptr, byval as BSTR) as HRESULT
	confirm as function(byval as IHTMLWindow2 ptr, byval as BSTR, byval as VARIANT_BOOL ptr) as HRESULT
	prompt as function(byval as IHTMLWindow2 ptr, byval as BSTR, byval as BSTR, byval as VARIANT_ ptr) as HRESULT
	get_Image as function(byval as IHTMLWindow2 ptr, byval as LPHTMLIMAGEELEMENTFACTORY ptr) as HRESULT
	get_location as function(byval as IHTMLWindow2 ptr, byval as LPHTMLLOCATION ptr) as HRESULT
	get_history as function(byval as IHTMLWindow2 ptr, byval as LPOMHISTORY ptr) as HRESULT
	close as function(byval as IHTMLWindow2 ptr) as HRESULT
	put_opener as function(byval as IHTMLWindow2 ptr, byval as VARIANT_) as HRESULT
	get_opener as function(byval as IHTMLWindow2 ptr, byval as VARIANT_ ptr) as HRESULT
	get_navigator as function(byval as IHTMLWindow2 ptr, byval as LPOMNAVIGATOR ptr) as HRESULT
	put_name as function(byval as IHTMLWindow2 ptr, byval as BSTR) as HRESULT
	get_name as function(byval as IHTMLWindow2 ptr, byval as BSTR ptr) as HRESULT
	get_parent as function(byval as IHTMLWindow2 ptr, byval as LPHTMLWINDOW2 ptr) as HRESULT
	open as function(byval as IHTMLWindow2 ptr, byval as BSTR, byval as BSTR, byval as BSTR, byval as VARIANT_BOOL, byval as LPHTMLWINDOW2 ptr) as HRESULT
	get_self as function(byval as IHTMLWindow2 ptr, byval as LPHTMLWINDOW2 ptr) as HRESULT
	get_top as function(byval as IHTMLWindow2 ptr, byval as LPHTMLWINDOW2 ptr) as HRESULT
	get_window as function(byval as IHTMLWindow2 ptr, byval as LPHTMLWINDOW2 ptr) as HRESULT
	navigate as function(byval as IHTMLWindow2 ptr, byval as BSTR) as HRESULT
	put_onfocus as function(byval as IHTMLWindow2 ptr, byval as VARIANT_) as HRESULT
	get_onfocus as function(byval as IHTMLWindow2 ptr, byval as VARIANT_ ptr) as HRESULT
	put_onblur as function(byval as IHTMLWindow2 ptr, byval as VARIANT_) as HRESULT
	get_onblur as function(byval as IHTMLWindow2 ptr, byval as VARIANT_ ptr) as HRESULT
	put_onload as function(byval as IHTMLWindow2 ptr, byval as VARIANT_) as HRESULT
	get_onload as function(byval as IHTMLWindow2 ptr, byval as VARIANT_ ptr) as HRESULT
	put_onbeforeunload as function(byval as IHTMLWindow2 ptr, byval as VARIANT_) as HRESULT
	get_onbeforeunload as function(byval as IHTMLWindow2 ptr, byval as VARIANT_ ptr) as HRESULT
	put_onunload as function(byval as IHTMLWindow2 ptr, byval as VARIANT_) as HRESULT
	get_onunload as function(byval as IHTMLWindow2 ptr, byval as VARIANT_ ptr) as HRESULT
	put_onhelp as function(byval as IHTMLWindow2 ptr, byval as VARIANT_) as HRESULT
	get_onhelp as function(byval as IHTMLWindow2 ptr, byval as VARIANT_ ptr) as HRESULT
	put_onerror as function(byval as IHTMLWindow2 ptr, byval as VARIANT_) as HRESULT
	get_onerror as function(byval as IHTMLWindow2 ptr, byval as VARIANT_ ptr) as HRESULT
	put_onresize as function(byval as IHTMLWindow2 ptr, byval as VARIANT_) as HRESULT
	get_onresize as function(byval as IHTMLWindow2 ptr, byval as VARIANT_ ptr) as HRESULT
	put_onscroll as function(byval as IHTMLWindow2 ptr, byval as VARIANT_) as HRESULT
	get_onscroll as function(byval as IHTMLWindow2 ptr, byval as VARIANT_ ptr) as HRESULT
	get_document as function(byval as IHTMLWindow2 ptr, byval as IHTMLDocument2 ptr ptr) as HRESULT
	get_event as function(byval as IHTMLWindow2 ptr, byval as LPHTMLEVENTOBJ ptr) as HRESULT
	get__newEnum as function(byval as IHTMLWindow2 ptr, byval as IUnknown ptr ptr) as HRESULT
	showModalDialog as function(byval as IHTMLWindow2 ptr, byval as BSTR, byval as VARIANT_ ptr, byval as VARIANT_ ptr, byval as VARIANT_ ptr) as HRESULT
	showHelp as function(byval as IHTMLWindow2 ptr, byval as BSTR, byval as VARIANT_, byval as BSTR) as HRESULT
	get_screen as function(byval as IHTMLWindow2 ptr, byval as LPHTMLSCREEN ptr) as HRESULT
	get_Option as function(byval as IHTMLWindow2 ptr, byval as LPHTMLOPTIONELEMENTFACTORY ptr) as HRESULT
	focus as function(byval as IHTMLWindow2 ptr) as HRESULT
	get_closed as function(byval as IHTMLWindow2 ptr, byval as VARIANT_BOOL ptr) as HRESULT
	blur as function(byval as IHTMLWindow2 ptr) as HRESULT
	scroll as function(byval as IHTMLWindow2 ptr, byval as integer, byval as integer) as HRESULT
	get_clientInformation as function(byval as IHTMLWindow2 ptr, byval as LPOMNAVIGATOR ptr) as HRESULT
	setInterval as function(byval as IHTMLWindow2 ptr, byval as BSTR, byval as integer, byval as VARIANT_ ptr, byval as integer ptr) as HRESULT
	clearInterval as function(byval as IHTMLWindow2 ptr, byval as integer) as HRESULT
	put_offscreenBuffering as function(byval as IHTMLWindow2 ptr, byval as VARIANT_) as HRESULT
	get_offscreenBuffering as function(byval as IHTMLWindow2 ptr, byval as VARIANT_ ptr) as HRESULT
	execScript as function(byval as IHTMLWindow2 ptr, byval as BSTR, byval as BSTR, byval as VARIANT_ ptr) as HRESULT
	toString as function(byval as IHTMLWindow2 ptr, byval as BSTR ptr) as HRESULT
	scrollBy as function(byval as IHTMLWindow2 ptr, byval as integer, byval as integer) as HRESULT
	scrollTo as function(byval as IHTMLWindow2 ptr, byval as integer, byval as integer) as HRESULT
	moveTo as function(byval as IHTMLWindow2 ptr, byval as integer, byval as integer) as HRESULT
	moveBy as function(byval as IHTMLWindow2 ptr, byval as integer, byval as integer) as HRESULT
	resizeTo as function(byval as IHTMLWindow2 ptr, byval as integer, byval as integer) as HRESULT
	resizeBy as function(byval as IHTMLWindow2 ptr, byval as integer, byval as integer) as HRESULT
	get_external as function(byval as IHTMLWindow2 ptr, byval as IDispatch ptr ptr) as HRESULT
end type
extern IID_IHTMLFrameBase alias "IID_IHTMLFrameBase" as IID

type IHTMLFrameBaseVtbl_ as IHTMLFrameBaseVtbl

type IHTMLFrameBase
	lpVtbl as IHTMLFrameBaseVtbl_ ptr
end type

type IHTMLFrameBaseVtbl
	QueryInterface as function(byval as IHTMLFrameBase ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IHTMLFrameBase ptr) as ULONG
	Release as function(byval as IHTMLFrameBase ptr) as ULONG
	GetTypeInfoCount as function(byval as IHTMLFrameBase ptr, byval as UINT ptr) as HRESULT
	GetTypeInfo as function(byval as IHTMLFrameBase ptr, byval as UINT, byval as LCID, byval as LPTYPEINFO ptr) as HRESULT
	GetIDsOfNames as function(byval as IHTMLFrameBase ptr, byval as IID ptr, byval as LPOLESTR ptr, byval as UINT, byval as LCID, byval as DISPID ptr) as HRESULT
	Invoke as function(byval as IHTMLFrameBase ptr, byval as DISPID, byval as IID ptr, byval as LCID, byval as WORD, byval as DISPPARAMS ptr, byval as VARIANT_ ptr, byval as EXCEPINFO ptr, byval as UINT ptr) as HRESULT
	put_src as function(byval as IHTMLFrameBase ptr, byval as BSTR) as HRESULT
	get_src as function(byval as IHTMLFrameBase ptr, byval as BSTR ptr) as HRESULT
	put_name as function(byval as IHTMLFrameBase ptr, byval as BSTR) as HRESULT
	get_name as function(byval as IHTMLFrameBase ptr, byval as BSTR ptr) as HRESULT
	put_border as function(byval as IHTMLFrameBase ptr, byval as VARIANT_) as HRESULT
	get_border as function(byval as IHTMLFrameBase ptr, byval as VARIANT_ ptr) as HRESULT
	put_frameBorder as function(byval as IHTMLFrameBase ptr, byval as BSTR) as HRESULT
	get_frameBorder as function(byval as IHTMLFrameBase ptr, byval as BSTR ptr) as HRESULT
	put_frameSpacing as function(byval as IHTMLFrameBase ptr, byval as VARIANT_) as HRESULT
	get_frameSpacing as function(byval as IHTMLFrameBase ptr, byval as VARIANT_ ptr) as HRESULT
	put_marginWidth as function(byval as IHTMLFrameBase ptr, byval as VARIANT_) as HRESULT
	get_marginWidth as function(byval as IHTMLFrameBase ptr, byval as VARIANT_ ptr) as HRESULT
	put_marginHeight as function(byval as IHTMLFrameBase ptr, byval as VARIANT_) as HRESULT
	get_marginHeight as function(byval as IHTMLFrameBase ptr, byval as VARIANT_ ptr) as HRESULT
	put_noResize as function(byval as IHTMLFrameBase ptr, byval as VARIANT_BOOL) as HRESULT
	get_noResize as function(byval as IHTMLFrameBase ptr, byval as VARIANT_BOOL ptr) as HRESULT
	put_scrolling as function(byval as IHTMLFrameBase ptr, byval as BSTR) as HRESULT
	get_scrolling as function(byval as IHTMLFrameBase ptr, byval as BSTR ptr) as HRESULT
end type
extern IID_IHTMLFrameBase2 alias "IID_IHTMLFrameBase2" as IID

type IHTMLFrameBase2Vtbl_ as IHTMLFrameBase2Vtbl

type IHTMLFrameBase2
	lpVtbl as IHTMLFrameBase2Vtbl_ ptr
end type

type IHTMLFrameBase2Vtbl
	QueryInterface as function(byval as IHTMLFrameBase2 ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IHTMLFrameBase2 ptr) as ULONG
	Release as function(byval as IHTMLFrameBase2 ptr) as ULONG
	GetTypeInfoCount as function(byval as IHTMLFrameBase2 ptr, byval as UINT ptr) as HRESULT
	GetTypeInfo as function(byval as IHTMLFrameBase2 ptr, byval as UINT, byval as LCID, byval as LPTYPEINFO ptr) as HRESULT
	GetIDsOfNames as function(byval as IHTMLFrameBase2 ptr, byval as IID ptr, byval as LPOLESTR ptr, byval as UINT, byval as LCID, byval as DISPID ptr) as HRESULT
	Invoke as function(byval as IHTMLFrameBase2 ptr, byval as DISPID, byval as IID ptr, byval as LCID, byval as WORD, byval as DISPPARAMS ptr, byval as VARIANT_ ptr, byval as EXCEPINFO ptr, byval as UINT ptr) as HRESULT
	get_contentWindow as function(byval as IHTMLFrameBase2 ptr, byval as IHTMLWindow2 ptr ptr) as HRESULT
	put_onload as function(byval as IHTMLFrameBase2 ptr, byval as VARIANT_) as HRESULT
	get_onload as function(byval as IHTMLFrameBase2 ptr, byval as VARIANT_ ptr) as HRESULT
	put_onreadystatechange as function(byval as IHTMLFrameBase2 ptr, byval as VARIANT_) as HRESULT
	get_onreadystatechange as function(byval as IHTMLFrameBase2 ptr, byval as VARIANT_ ptr) as HRESULT
	get_readyState as function(byval as IHTMLFrameBase2 ptr, byval as BSTR ptr) as HRESULT
	put_allowTransparency as function(byval as IHTMLFrameBase2 ptr, byval as VARIANT_BOOL) as HRESULT
	get_allowTransparency as function(byval as IHTMLFrameBase2 ptr, byval as VARIANT_BOOL ptr) as HRESULT
end type
extern IID_IHTMLFrameBase3 alias "IID_IHTMLFrameBase3" as IID

type IHTMLFrameBase3Vtbl_ as IHTMLFrameBase3Vtbl

type IHTMLFrameBase3
	lpVtbl as IHTMLFrameBase3Vtbl_ ptr
end type

type IHTMLFrameBase3Vtbl
	QueryInterface as function(byval as IHTMLFrameBase3 ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IHTMLFrameBase3 ptr) as ULONG
	Release as function(byval as IHTMLFrameBase3 ptr) as ULONG
	GetTypeInfoCount as function(byval as IHTMLFrameBase3 ptr, byval as UINT ptr) as HRESULT
	GetTypeInfo as function(byval as IHTMLFrameBase3 ptr, byval as UINT, byval as LCID, byval as LPTYPEINFO ptr) as HRESULT
	GetIDsOfNames as function(byval as IHTMLFrameBase3 ptr, byval as IID ptr, byval as LPOLESTR ptr, byval as UINT, byval as LCID, byval as DISPID ptr) as HRESULT
	Invoke as function(byval as IHTMLFrameBase3 ptr, byval as DISPID, byval as IID ptr, byval as LCID, byval as WORD, byval as DISPPARAMS ptr, byval as VARIANT_ ptr, byval as EXCEPINFO ptr, byval as UINT ptr) as HRESULT
	put_longDesc as function(byval as IHTMLFrameBase3 ptr, byval as BSTR) as HRESULT
	get_longDesc as function(byval as IHTMLFrameBase3 ptr, byval as BSTR ptr) as HRESULT
end type
extern IID_IHTMLBodyElement alias "IID_IHTMLBodyElement" as IID

type IHTMLBodyElementVtbl_ as IHTMLBodyElementVtbl

type IHTMLBodyElement
	lpVtbl as IHTMLBodyElementVtbl_ ptr
end type

type IHTMLBodyElementVtbl
	QueryInterface as function(byval as IHTMLBodyElement ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IHTMLBodyElement ptr) as ULONG
	Release as function(byval as IHTMLBodyElement ptr) as ULONG
	GetTypeInfoCount as function(byval as IHTMLBodyElement ptr, byval as UINT ptr) as HRESULT
	GetTypeInfo as function(byval as IHTMLBodyElement ptr, byval as UINT, byval as LCID, byval as LPTYPEINFO ptr) as HRESULT
	GetIDsOfNames as function(byval as IHTMLBodyElement ptr, byval as IID ptr, byval as LPOLESTR ptr, byval as UINT, byval as LCID, byval as DISPID ptr) as HRESULT
	Invoke as function(byval as IHTMLBodyElement ptr, byval as DISPID, byval as IID ptr, byval as LCID, byval as WORD, byval as DISPPARAMS ptr, byval as VARIANT_ ptr, byval as EXCEPINFO ptr, byval as UINT ptr) as HRESULT
	put_background as function(byval as IHTMLBodyElement ptr, byval as BSTR) as HRESULT
	get_background as function(byval as IHTMLBodyElement ptr, byval as BSTR ptr) as HRESULT
	put_bgProperties as function(byval as IHTMLBodyElement ptr, byval as BSTR) as HRESULT
	get_bgProperties as function(byval as IHTMLBodyElement ptr, byval as BSTR ptr) as HRESULT
	put_leftMargin as function(byval as IHTMLBodyElement ptr, byval as VARIANT_) as HRESULT
	get_leftMargin as function(byval as IHTMLBodyElement ptr, byval as VARIANT_ ptr) as HRESULT
	put_topMargin as function(byval as IHTMLBodyElement ptr, byval as VARIANT_) as HRESULT
	get_topMargin as function(byval as IHTMLBodyElement ptr, byval as VARIANT_ ptr) as HRESULT
	put_rightMargin as function(byval as IHTMLBodyElement ptr, byval as VARIANT_) as HRESULT
	get_rightMargin as function(byval as IHTMLBodyElement ptr, byval as VARIANT_ ptr) as HRESULT
	put_bottomMargin as function(byval as IHTMLBodyElement ptr, byval as VARIANT_) as HRESULT
	get_bottomMargin as function(byval as IHTMLBodyElement ptr, byval as VARIANT_ ptr) as HRESULT
	put_noWrap as function(byval as IHTMLBodyElement ptr, byval as VARIANT_BOOL) as HRESULT
	get_noWrap as function(byval as IHTMLBodyElement ptr, byval as VARIANT_BOOL ptr) as HRESULT
	put_bgColor as function(byval as IHTMLBodyElement ptr, byval as VARIANT_) as HRESULT
	get_bgColor as function(byval as IHTMLBodyElement ptr, byval as VARIANT_ ptr) as HRESULT
	put_text as function(byval as IHTMLBodyElement ptr, byval as VARIANT_) as HRESULT
	get_text as function(byval as IHTMLBodyElement ptr, byval as VARIANT_ ptr) as HRESULT
	put_link as function(byval as IHTMLBodyElement ptr, byval as VARIANT_) as HRESULT
	get_link as function(byval as IHTMLBodyElement ptr, byval as VARIANT_ ptr) as HRESULT
	put_vLink as function(byval as IHTMLBodyElement ptr, byval as VARIANT_) as HRESULT
	get_vLink as function(byval as IHTMLBodyElement ptr, byval as VARIANT_ ptr) as HRESULT
	put_aLink as function(byval as IHTMLBodyElement ptr, byval as VARIANT_) as HRESULT
	get_aLink as function(byval as IHTMLBodyElement ptr, byval as VARIANT_ ptr) as HRESULT
	put_onload as function(byval as IHTMLBodyElement ptr, byval as VARIANT_) as HRESULT
	get_onload as function(byval as IHTMLBodyElement ptr, byval as VARIANT_ ptr) as HRESULT
	put_onunload as function(byval as IHTMLBodyElement ptr, byval as VARIANT_) as HRESULT
	get_onunload as function(byval as IHTMLBodyElement ptr, byval as VARIANT_ ptr) as HRESULT
	put_scroll as function(byval as IHTMLBodyElement ptr, byval as BSTR) as HRESULT
	get_scroll as function(byval as IHTMLBodyElement ptr, byval as BSTR ptr) as HRESULT
	put_onselect as function(byval as IHTMLBodyElement ptr, byval as VARIANT_) as HRESULT
	get_onselect as function(byval as IHTMLBodyElement ptr, byval as VARIANT_ ptr) as HRESULT
	put_onbeforeunload as function(byval as IHTMLBodyElement ptr, byval as VARIANT_) as HRESULT
	get_onbeforeunload as function(byval as IHTMLBodyElement ptr, byval as VARIANT_ ptr) as HRESULT
	createTextRange as function(byval as IHTMLBodyElement ptr, byval as IHTMLTxtRange ptr ptr) as HRESULT
end type
extern IID_IHTMLBodyElement2 alias "IID_IHTMLBodyElement2" as IID

type IHTMLBodyElement2Vtbl_ as IHTMLBodyElement2Vtbl

type IHTMLBodyElement2
	lpVtbl as IHTMLBodyElement2Vtbl_ ptr
end type

type IHTMLBodyElement2Vtbl
	QueryInterface as function(byval as IHTMLBodyElement2 ptr, byval as IID ptr, byval as PVOID ptr) as HRESULT
	AddRef as function(byval as IHTMLBodyElement2 ptr) as ULONG
	Release as function(byval as IHTMLBodyElement2 ptr) as ULONG
	GetTypeInfoCount as function(byval as IHTMLBodyElement2 ptr, byval as UINT ptr) as HRESULT
	GetTypeInfo as function(byval as IHTMLBodyElement2 ptr, byval as UINT, byval as LCID, byval as LPTYPEINFO ptr) as HRESULT
	GetIDsOfNames as function(byval as IHTMLBodyElement2 ptr, byval as IID ptr, byval as LPOLESTR ptr, byval as UINT, byval as LCID, byval as DISPID ptr) as HRESULT
	Invoke as function(byval as IHTMLBodyElement2 ptr, byval as DISPID, byval as IID ptr, byval as LCID, byval as WORD, byval as DISPPARAMS ptr, byval as VARIANT_ ptr, byval as EXCEPINFO ptr, byval as UINT ptr) as HRESULT
	put_onbeforeprint as function(byval as IHTMLBodyElement2 ptr, byval as VARIANT_) as HRESULT
	get_onbeforeprint as function(byval as IHTMLBodyElement2 ptr, byval as VARIANT_ ptr) as HRESULT
	put_onafterprint as function(byval as IHTMLBodyElement2 ptr, byval as VARIANT_) as HRESULT
	get_onafterprint as function(byval as IHTMLBodyElement2 ptr, byval as VARIANT_ ptr) as HRESULT
end type

#endif
