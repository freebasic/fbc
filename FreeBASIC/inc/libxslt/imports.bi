''
''
'' imports -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __imports_bi__
#define __imports_bi__

#include once "libxslt/xsltexports.bi"
#include once "libxslt/xsltInternals.bi"
#include once "libxml/tree.bi"

declare function xsltParseStylesheetImport cdecl alias "xsltParseStylesheetImport" (byval style as xsltStylesheetPtr, byval cur as xmlNodePtr) as integer
declare function xsltParseStylesheetInclude cdecl alias "xsltParseStylesheetInclude" (byval style as xsltStylesheetPtr, byval cur as xmlNodePtr) as integer
declare function xsltNextImport cdecl alias "xsltNextImport" (byval style as xsltStylesheetPtr) as xsltStylesheetPtr
declare function xsltNeedElemSpaceHandling cdecl alias "xsltNeedElemSpaceHandling" (byval ctxt as xsltTransformContextPtr) as integer
declare function xsltFindElemSpaceHandling cdecl alias "xsltFindElemSpaceHandling" (byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr) as integer
declare function xsltFindTemplate cdecl alias "xsltFindTemplate" (byval ctxt as xsltTransformContextPtr, byval name as zstring ptr, byval nameURI as zstring ptr) as xsltTemplatePtr

#endif
