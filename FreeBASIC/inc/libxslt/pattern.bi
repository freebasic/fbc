''
''
'' pattern -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __xslt_pattern_bi__
#define __xslt_pattern_bi__

#include once "xsltInternals.bi"
#include once "xsltexports.bi"

type xsltCompMatch as _xsltCompMatch
type xsltCompMatchPtr as xsltCompMatch ptr

extern "c"
declare function xsltCompilePattern (byval pattern as zstring ptr, byval doc as xmlDocPtr, byval node as xmlNodePtr, byval style as xsltStylesheetPtr, byval runtime as xsltTransformContextPtr) as xsltCompMatchPtr
declare sub xsltFreeCompMatchList (byval comp as xsltCompMatchPtr)
declare function xsltTestCompMatchList (byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval comp as xsltCompMatchPtr) as integer
declare sub xsltNormalizeCompSteps (byval payload as any ptr, byval data as any ptr, byval name as zstring ptr)
declare function xsltAddTemplate (byval style as xsltStylesheetPtr, byval cur as xsltTemplatePtr, byval mode as zstring ptr, byval modeURI as zstring ptr) as integer
declare function xsltGetTemplate (byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval style as xsltStylesheetPtr) as xsltTemplatePtr
declare sub xsltFreeTemplateHashes (byval style as xsltStylesheetPtr)
declare sub xsltCleanupTemplates (byval style as xsltStylesheetPtr)
end extern

#endif
