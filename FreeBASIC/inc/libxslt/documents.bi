''
''
'' documents -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __documents_bi__
#define __documents_bi__

#include once "libxslt/xsltexports.bi"
#include once "libxslt/xsltInternals.bi"
#include once "libxml/tree.bi"

declare function xsltNewDocument cdecl alias "xsltNewDocument" (byval ctxt as xsltTransformContextPtr, byval doc as xmlDocPtr) as xsltDocumentPtr
declare function xsltLoadDocument cdecl alias "xsltLoadDocument" (byval ctxt as xsltTransformContextPtr, byval URI as zstring ptr) as xsltDocumentPtr
declare function xsltFindDocument cdecl alias "xsltFindDocument" (byval ctxt as xsltTransformContextPtr, byval doc as xmlDocPtr) as xsltDocumentPtr
declare sub xsltFreeDocuments cdecl alias "xsltFreeDocuments" (byval ctxt as xsltTransformContextPtr)
declare function xsltLoadStyleDocument cdecl alias "xsltLoadStyleDocument" (byval style as xsltStylesheetPtr, byval URI as zstring ptr) as xsltDocumentPtr
declare function xsltNewStyleDocument cdecl alias "xsltNewStyleDocument" (byval style as xsltStylesheetPtr, byval doc as xmlDocPtr) as xsltDocumentPtr
declare sub xsltFreeStyleDocuments cdecl alias "xsltFreeStyleDocuments" (byval style as xsltStylesheetPtr)

enum xsltLoadType
	XSLT_LOAD_START = 0
	XSLT_LOAD_STYLESHEET = 1
	XSLT_LOAD_DOCUMENT = 2
end enum

type xsltDocLoaderFunc as function cdecl(byval as zstring ptr, byval as xmlDictPtr, byval as integer, byval as any ptr, byval as xsltLoadType) as xmlDocPtr

declare sub xsltSetLoaderFunc cdecl alias "xsltSetLoaderFunc" (byval f as xsltDocLoaderFunc)

#endif
