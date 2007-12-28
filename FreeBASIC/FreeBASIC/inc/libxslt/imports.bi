''
''
'' imports -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __xslt_imports_bi__
#define __xslt_imports_bi__

#include once "xsltexports.bi"
#include once "xsltInternals.bi"
#include once "libxml/tree.bi"

extern "c"
declare function xsltParseStylesheetImport (byval style as xsltStylesheetPtr, byval cur as xmlNodePtr) as integer
declare function xsltParseStylesheetInclude (byval style as xsltStylesheetPtr, byval cur as xmlNodePtr) as integer
declare function xsltNextImport (byval style as xsltStylesheetPtr) as xsltStylesheetPtr
declare function xsltNeedElemSpaceHandling (byval ctxt as xsltTransformContextPtr) as integer
declare function xsltFindElemSpaceHandling (byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr) as integer
declare function xsltFindTemplate (byval ctxt as xsltTransformContextPtr, byval name as zstring ptr, byval nameURI as zstring ptr) as xsltTemplatePtr
end extern

#endif
