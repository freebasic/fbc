''
''
'' documents -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __xslt_documents_bi__
#define __xslt_documents_bi__

#include once "xsltexports.bi"
#include once "xsltInternals.bi"
#include once "libxml/tree.bi"

enum xsltLoadType
	XSLT_LOAD_START = 0
	XSLT_LOAD_STYLESHEET = 1
	XSLT_LOAD_DOCUMENT = 2
end enum

type xsltDocLoaderFunc as function cdecl(byval as zstring ptr, byval as xmlDictPtr, byval as integer, byval as any ptr, byval as xsltLoadType) as xmlDocPtr

extern "c"
declare function xsltNewDocument (byval ctxt as xsltTransformContextPtr, byval doc as xmlDocPtr) as xsltDocumentPtr
declare function xsltLoadDocument (byval ctxt as xsltTransformContextPtr, byval URI as zstring ptr) as xsltDocumentPtr
declare function xsltFindDocument (byval ctxt as xsltTransformContextPtr, byval doc as xmlDocPtr) as xsltDocumentPtr
declare sub xsltFreeDocuments (byval ctxt as xsltTransformContextPtr)
declare function xsltLoadStyleDocument (byval style as xsltStylesheetPtr, byval URI as zstring ptr) as xsltDocumentPtr
declare function xsltNewStyleDocument (byval style as xsltStylesheetPtr, byval doc as xmlDocPtr) as xsltDocumentPtr
declare sub xsltFreeStyleDocuments (byval style as xsltStylesheetPtr)
declare sub xsltSetLoaderFunc (byval f as xsltDocLoaderFunc)
end extern

#endif
