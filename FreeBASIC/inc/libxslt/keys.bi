''
''
'' keys -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __keys_bi__
#define __keys_bi__

#include once "libxslt/xsltexports.bi"
#include once "libxslt/xsltInternals.bi"
#include once "libxml/xpath.bi"

#define NODE_IS_KEYED (1 shr 15)

declare function xsltAddKey cdecl alias "xsltAddKey" (byval style as xsltStylesheetPtr, byval name as string, byval nameURI as string, byval match as string, byval use as string, byval inst as xmlNodePtr) as integer
declare function xsltGetKey cdecl alias "xsltGetKey" (byval ctxt as xsltTransformContextPtr, byval name as string, byval nameURI as string, byval value as string) as xmlNodeSetPtr
declare sub xsltInitCtxtKeys cdecl alias "xsltInitCtxtKeys" (byval ctxt as xsltTransformContextPtr, byval doc as xsltDocumentPtr)
declare sub xsltFreeKeys cdecl alias "xsltFreeKeys" (byval style as xsltStylesheetPtr)
declare sub xsltFreeDocumentKeys cdecl alias "xsltFreeDocumentKeys" (byval doc as xsltDocumentPtr)

#endif
