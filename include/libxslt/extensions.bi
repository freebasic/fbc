''
''
'' extensions -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __xslt_extensions_bi__
#define __xslt_extensions_bi__

#include once "xsltexports.bi"
#include once "xsltInternals.bi"
#include once "libxml/xpath.bi"

type xsltStyleExtInitFunction as sub cdecl(byval as xsltStylesheetPtr, byval as zstring ptr)
type xsltStyleExtShutdownFunction as sub cdecl(byval as xsltStylesheetPtr, byval as zstring ptr, byval as any ptr)
type xsltExtInitFunction as sub cdecl(byval as xsltTransformContextPtr, byval as zstring ptr)
type xsltExtShutdownFunction as sub cdecl(byval as xsltTransformContextPtr, byval as zstring ptr, byval as any ptr)
type xsltPreComputeFunction as function cdecl(byval as xsltStylesheetPtr, byval as xmlNodePtr, byval as xsltTransformFunction) as xsltElemPreCompPtr
type xsltTopLevelFunction as sub cdecl(byval as xsltStylesheetPtr, byval as xmlNodePtr)

extern "c"
declare function xsltRegisterExtModule (byval URI as zstring ptr, byval initFunc as xsltExtInitFunction, byval shutdownFunc as xsltExtShutdownFunction) as integer
declare function xsltRegisterExtModuleFull (byval URI as zstring ptr, byval initFunc as xsltExtInitFunction, byval shutdownFunc as xsltExtShutdownFunction, byval styleInitFunc as xsltStyleExtInitFunction, byval styleShutdownFunc as xsltStyleExtShutdownFunction) as integer
declare function xsltUnregisterExtModule (byval URI as zstring ptr) as integer
declare function xsltGetExtData (byval ctxt as xsltTransformContextPtr, byval URI as zstring ptr) as any ptr
declare function xsltStyleGetExtData (byval style as xsltStylesheetPtr, byval URI as zstring ptr) as any ptr
declare sub xsltShutdownCtxtExts (byval ctxt as xsltTransformContextPtr)
declare sub xsltShutdownExts (byval style as xsltStylesheetPtr)
declare function xsltXPathGetTransformContext (byval ctxt as xmlXPathParserContextPtr) as xsltTransformContextPtr
declare function xsltRegisterExtModuleFunction (byval name as zstring ptr, byval URI as zstring ptr, byval function as xmlXPathFunction) as integer
declare function xsltExtFunctionLookup (byval ctxt as xsltTransformContextPtr, byval name as zstring ptr, byval URI as zstring ptr) as xmlXPathFunction
declare function xsltExtModuleFunctionLookup (byval name as zstring ptr, byval URI as zstring ptr) as xmlXPathFunction
declare function xsltUnregisterExtModuleFunction (byval name as zstring ptr, byval URI as zstring ptr) as integer
declare function xsltNewElemPreComp (byval style as xsltStylesheetPtr, byval inst as xmlNodePtr, byval function as xsltTransformFunction) as xsltElemPreCompPtr
declare sub xsltInitElemPreComp (byval comp as xsltElemPreCompPtr, byval style as xsltStylesheetPtr, byval inst as xmlNodePtr, byval function as xsltTransformFunction, byval freeFunc as xsltElemPreCompDeallocator)
declare function xsltRegisterExtModuleElement (byval name as zstring ptr, byval URI as zstring ptr, byval precomp as xsltPreComputeFunction, byval transform as xsltTransformFunction) as integer
declare function xsltExtElementLookup (byval ctxt as xsltTransformContextPtr, byval name as zstring ptr, byval URI as zstring ptr) as xsltTransformFunction
declare function xsltExtModuleElementLookup (byval name as zstring ptr, byval URI as zstring ptr) as xsltTransformFunction
declare function xsltExtModuleElementPreComputeLookup (byval name as zstring ptr, byval URI as zstring ptr) as xsltPreComputeFunction
declare function xsltUnregisterExtModuleElement (byval name as zstring ptr, byval URI as zstring ptr) as integer
declare function xsltRegisterExtModuleTopLevel (byval name as zstring ptr, byval URI as zstring ptr, byval function as xsltTopLevelFunction) as integer
declare function xsltExtModuleTopLevelLookup (byval name as zstring ptr, byval URI as zstring ptr) as xsltTopLevelFunction
declare function xsltUnregisterExtModuleTopLevel (byval name as zstring ptr, byval URI as zstring ptr) as integer
declare function xsltRegisterExtFunction (byval ctxt as xsltTransformContextPtr, byval name as zstring ptr, byval URI as zstring ptr, byval function as xmlXPathFunction) as integer
declare function xsltRegisterExtElement (byval ctxt as xsltTransformContextPtr, byval name as zstring ptr, byval URI as zstring ptr, byval function as xsltTransformFunction) as integer
declare function xsltRegisterExtPrefix (byval style as xsltStylesheetPtr, byval prefix as zstring ptr, byval URI as zstring ptr) as integer
declare function xsltCheckExtPrefix (byval style as xsltStylesheetPtr, byval prefix as zstring ptr) as integer
declare function xsltInitCtxtExts (byval ctxt as xsltTransformContextPtr) as integer
declare sub xsltFreeCtxtExts (byval ctxt as xsltTransformContextPtr)
declare sub xsltFreeExts (byval style as xsltStylesheetPtr)
declare function xsltPreComputeExtModuleElement (byval style as xsltStylesheetPtr, byval inst as xmlNodePtr) as xsltElemPreCompPtr
declare function xsltGetExtInfo (byval style as xsltStylesheetPtr, byval URI as zstring ptr) as xmlHashTablePtr
declare sub xsltRegisterTestModule ()
declare sub xsltDebugDumpExtensions (byval output as FILE ptr)
end extern

#endif
