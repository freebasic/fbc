''
''
'' namespaces -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __namespaces_bi__
#define __namespaces_bi__

#include once "libxslt/xsltexports.bi"
#include once "libxml/tree.bi"

declare sub xsltNamespaceAlias cdecl alias "xsltNamespaceAlias" (byval style as xsltStylesheetPtr, byval node as xmlNodePtr)
declare function xsltGetNamespace cdecl alias "xsltGetNamespace" (byval ctxt as xsltTransformContextPtr, byval cur as xmlNodePtr, byval ns as xmlNsPtr, byval out as xmlNodePtr) as xmlNsPtr
declare function xsltGetPlainNamespace cdecl alias "xsltGetPlainNamespace" (byval ctxt as xsltTransformContextPtr, byval cur as xmlNodePtr, byval ns as xmlNsPtr, byval out as xmlNodePtr) as xmlNsPtr
declare function xsltGetSpecialNamespace cdecl alias "xsltGetSpecialNamespace" (byval ctxt as xsltTransformContextPtr, byval cur as xmlNodePtr, byval URI as zstring ptr, byval prefix as zstring ptr, byval out as xmlNodePtr) as xmlNsPtr
declare function xsltCopyNamespace cdecl alias "xsltCopyNamespace" (byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval cur as xmlNsPtr) as xmlNsPtr
declare function xsltCopyNamespaceList cdecl alias "xsltCopyNamespaceList" (byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval cur as xmlNsPtr) as xmlNsPtr
declare sub xsltFreeNamespaceAliasHashes cdecl alias "xsltFreeNamespaceAliasHashes" (byval style as xsltStylesheetPtr)

#endif
