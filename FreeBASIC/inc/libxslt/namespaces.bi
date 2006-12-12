''
''
'' namespaces -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __xslt_namespaces_bi__
#define __xslt_namespaces_bi__

#include once "xsltexports.bi"
#include once "libxml/tree.bi"

extern "c"
declare sub xsltNamespaceAlias (byval style as xsltStylesheetPtr, byval node as xmlNodePtr)
declare function xsltGetNamespace (byval ctxt as xsltTransformContextPtr, byval cur as xmlNodePtr, byval ns as xmlNsPtr, byval out as xmlNodePtr) as xmlNsPtr
declare function xsltGetPlainNamespace (byval ctxt as xsltTransformContextPtr, byval cur as xmlNodePtr, byval ns as xmlNsPtr, byval out as xmlNodePtr) as xmlNsPtr
declare function xsltGetSpecialNamespace (byval ctxt as xsltTransformContextPtr, byval cur as xmlNodePtr, byval URI as zstring ptr, byval prefix as zstring ptr, byval out as xmlNodePtr) as xmlNsPtr
declare function xsltCopyNamespace (byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval cur as xmlNsPtr) as xmlNsPtr
declare function xsltCopyNamespaceList (byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval cur as xmlNsPtr) as xmlNsPtr
declare sub xsltFreeNamespaceAliasHashes (byval style as xsltStylesheetPtr)
end extern

#endif
