''
''
'' keys -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __xslt_keys_bi__
#define __xslt_keys_bi__

#include once "xsltexports.bi"
#include once "xsltInternals.bi"
#include once "libxml/xpath.bi"

#define NODE_IS_KEYED (1 shr 15)

extern "c"
declare function xsltAddKey (byval style as xsltStylesheetPtr, byval name as zstring ptr, byval nameURI as zstring ptr, byval match as zstring ptr, byval use as zstring ptr, byval inst as xmlNodePtr) as integer
declare function xsltGetKey (byval ctxt as xsltTransformContextPtr, byval name as zstring ptr, byval nameURI as zstring ptr, byval value as zstring ptr) as xmlNodeSetPtr
declare sub xsltInitCtxtKeys (byval ctxt as xsltTransformContextPtr, byval doc as xsltDocumentPtr)
declare sub xsltFreeKeys (byval style as xsltStylesheetPtr)
declare sub xsltFreeDocumentKeys (byval doc as xsltDocumentPtr)
end extern

#endif
