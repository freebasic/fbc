''
''
'' preproc -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __xslt_preproc_bi__
#define __xslt_preproc_bi__

#include once "xsltexports.bi"
#include once "xsltInternals.bi"

extern "c"
declare function xsltDocumentComp (byval style as xsltStylesheetPtr, byval inst as xmlNodePtr, byval function as xsltTransformFunction) as xsltElemPreCompPtr
declare sub xsltStylePreCompute (byval style as xsltStylesheetPtr, byval inst as xmlNodePtr)
declare sub xsltFreeStylePreComps (byval style as xsltStylesheetPtr)
end extern

#endif
