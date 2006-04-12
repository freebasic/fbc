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

#include once "libxslt/xsltInternals.bi"
#include once "libxslt/xsltexports.bi"

type xsltCompMatch as _xsltCompMatch
type xsltCompMatchPtr as xsltCompMatch ptr

declare function xsltCompilePattern cdecl alias "xsltCompilePattern" (byval pattern as zstring ptr, byval doc as xmlDocPtr, byval node as xmlNodePtr, byval style as xsltStylesheetPtr, byval runtime as xsltTransformContextPtr) as xsltCompMatchPtr
declare sub xsltFreeCompMatchList cdecl alias "xsltFreeCompMatchList" (byval comp as xsltCompMatchPtr)
declare function xsltTestCompMatchList cdecl alias "xsltTestCompMatchList" (byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval comp as xsltCompMatchPtr) as integer
declare sub xsltNormalizeCompSteps cdecl alias "xsltNormalizeCompSteps" (byval payload as any ptr, byval data as any ptr, byval name as zstring ptr)
declare function xsltAddTemplate cdecl alias "xsltAddTemplate" (byval style as xsltStylesheetPtr, byval cur as xsltTemplatePtr, byval mode as zstring ptr, byval modeURI as zstring ptr) as integer
declare function xsltGetTemplate cdecl alias "xsltGetTemplate" (byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval style as xsltStylesheetPtr) as xsltTemplatePtr
declare sub xsltFreeTemplateHashes cdecl alias "xsltFreeTemplateHashes" (byval style as xsltStylesheetPtr)
declare sub xsltCleanupTemplates cdecl alias "xsltCleanupTemplates" (byval style as xsltStylesheetPtr)

#endif
