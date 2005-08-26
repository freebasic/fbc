''
''
'' extensions -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __extensions_bi__
#define __extensions_bi__

#include once "libxslt/xsltexports.bi"
#include once "libxslt/xsltInternals.bi"
#include once "libxml/xpath.bi"

type xsltStyleExtInitFunction as sub cdecl(byval as xsltStylesheetPtr, byval as zstring ptr)
type xsltStyleExtShutdownFunction as sub cdecl(byval as xsltStylesheetPtr, byval as zstring ptr, byval as any ptr)
type xsltExtInitFunction as sub cdecl(byval as xsltTransformContextPtr, byval as zstring ptr)
type xsltExtShutdownFunction as sub cdecl(byval as xsltTransformContextPtr, byval as zstring ptr, byval as any ptr)

declare function xsltRegisterExtModule cdecl alias "xsltRegisterExtModule" (byval URI as zstring ptr, byval initFunc as xsltExtInitFunction, byval shutdownFunc as xsltExtShutdownFunction) as integer
declare function xsltRegisterExtModuleFull cdecl alias "xsltRegisterExtModuleFull" (byval URI as zstring ptr, byval initFunc as xsltExtInitFunction, byval shutdownFunc as xsltExtShutdownFunction, byval styleInitFunc as xsltStyleExtInitFunction, byval styleShutdownFunc as xsltStyleExtShutdownFunction) as integer
declare function xsltUnregisterExtModule cdecl alias "xsltUnregisterExtModule" (byval URI as zstring ptr) as integer
declare function xsltGetExtData cdecl alias "xsltGetExtData" (byval ctxt as xsltTransformContextPtr, byval URI as zstring ptr) as any ptr
declare function xsltStyleGetExtData cdecl alias "xsltStyleGetExtData" (byval style as xsltStylesheetPtr, byval URI as zstring ptr) as any ptr
declare sub xsltShutdownCtxtExts cdecl alias "xsltShutdownCtxtExts" (byval ctxt as xsltTransformContextPtr)
declare sub xsltShutdownExts cdecl alias "xsltShutdownExts" (byval style as xsltStylesheetPtr)
declare function xsltXPathGetTransformContext cdecl alias "xsltXPathGetTransformContext" (byval ctxt as xmlXPathParserContextPtr) as xsltTransformContextPtr
declare function xsltRegisterExtModuleFunction cdecl alias "xsltRegisterExtModuleFunction" (byval name as zstring ptr, byval URI as zstring ptr, byval function as xmlXPathFunction) as integer
declare function xsltExtFunctionLookup cdecl alias "xsltExtFunctionLookup" (byval ctxt as xsltTransformContextPtr, byval name as zstring ptr, byval URI as zstring ptr) as xmlXPathFunction
declare function xsltExtModuleFunctionLookup cdecl alias "xsltExtModuleFunctionLookup" (byval name as zstring ptr, byval URI as zstring ptr) as xmlXPathFunction
declare function xsltUnregisterExtModuleFunction cdecl alias "xsltUnregisterExtModuleFunction" (byval name as zstring ptr, byval URI as zstring ptr) as integer

type xsltPreComputeFunction as function cdecl(byval as xsltStylesheetPtr, byval as xmlNodePtr, byval as xsltTransformFunction) as xsltElemPreCompPtr

declare function xsltNewElemPreComp cdecl alias "xsltNewElemPreComp" (byval style as xsltStylesheetPtr, byval inst as xmlNodePtr, byval function as xsltTransformFunction) as xsltElemPreCompPtr
declare sub xsltInitElemPreComp cdecl alias "xsltInitElemPreComp" (byval comp as xsltElemPreCompPtr, byval style as xsltStylesheetPtr, byval inst as xmlNodePtr, byval function as xsltTransformFunction, byval freeFunc as xsltElemPreCompDeallocator)
declare function xsltRegisterExtModuleElement cdecl alias "xsltRegisterExtModuleElement" (byval name as zstring ptr, byval URI as zstring ptr, byval precomp as xsltPreComputeFunction, byval transform as xsltTransformFunction) as integer
declare function xsltExtElementLookup cdecl alias "xsltExtElementLookup" (byval ctxt as xsltTransformContextPtr, byval name as zstring ptr, byval URI as zstring ptr) as xsltTransformFunction
declare function xsltExtModuleElementLookup cdecl alias "xsltExtModuleElementLookup" (byval name as zstring ptr, byval URI as zstring ptr) as xsltTransformFunction
declare function xsltExtModuleElementPreComputeLookup cdecl alias "xsltExtModuleElementPreComputeLookup" (byval name as zstring ptr, byval URI as zstring ptr) as xsltPreComputeFunction
declare function xsltUnregisterExtModuleElement cdecl alias "xsltUnregisterExtModuleElement" (byval name as zstring ptr, byval URI as zstring ptr) as integer

type xsltTopLevelFunction as sub cdecl(byval as xsltStylesheetPtr, byval as xmlNodePtr)

declare function xsltRegisterExtModuleTopLevel cdecl alias "xsltRegisterExtModuleTopLevel" (byval name as zstring ptr, byval URI as zstring ptr, byval function as xsltTopLevelFunction) as integer
declare function xsltExtModuleTopLevelLookup cdecl alias "xsltExtModuleTopLevelLookup" (byval name as zstring ptr, byval URI as zstring ptr) as xsltTopLevelFunction
declare function xsltUnregisterExtModuleTopLevel cdecl alias "xsltUnregisterExtModuleTopLevel" (byval name as zstring ptr, byval URI as zstring ptr) as integer
declare function xsltRegisterExtFunction cdecl alias "xsltRegisterExtFunction" (byval ctxt as xsltTransformContextPtr, byval name as zstring ptr, byval URI as zstring ptr, byval function as xmlXPathFunction) as integer
declare function xsltRegisterExtElement cdecl alias "xsltRegisterExtElement" (byval ctxt as xsltTransformContextPtr, byval name as zstring ptr, byval URI as zstring ptr, byval function as xsltTransformFunction) as integer
declare function xsltRegisterExtPrefix cdecl alias "xsltRegisterExtPrefix" (byval style as xsltStylesheetPtr, byval prefix as zstring ptr, byval URI as zstring ptr) as integer
declare function xsltCheckExtPrefix cdecl alias "xsltCheckExtPrefix" (byval style as xsltStylesheetPtr, byval prefix as zstring ptr) as integer
declare function xsltInitCtxtExts cdecl alias "xsltInitCtxtExts" (byval ctxt as xsltTransformContextPtr) as integer
declare sub xsltFreeCtxtExts cdecl alias "xsltFreeCtxtExts" (byval ctxt as xsltTransformContextPtr)
declare sub xsltFreeExts cdecl alias "xsltFreeExts" (byval style as xsltStylesheetPtr)
declare function xsltPreComputeExtModuleElement cdecl alias "xsltPreComputeExtModuleElement" (byval style as xsltStylesheetPtr, byval inst as xmlNodePtr) as xsltElemPreCompPtr
declare function xsltGetExtInfo cdecl alias "xsltGetExtInfo" (byval style as xsltStylesheetPtr, byval URI as zstring ptr) as xmlHashTablePtr
declare sub xsltRegisterTestModule cdecl alias "xsltRegisterTestModule" ()
declare sub xsltDebugDumpExtensions cdecl alias "xsltDebugDumpExtensions" (byval output as FILE ptr)

#endif
