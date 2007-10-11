''
''
'' xpathInternals -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __xml_xpathInternals_bi__
#define __xml_xpathInternals_bi__

#include once "xmlversion.bi"
#include once "xpath.bi"

extern "c"
declare function xmlXPathPopBoolean (byval ctxt as xmlXPathParserContextPtr) as integer
declare function xmlXPathPopNumber (byval ctxt as xmlXPathParserContextPtr) as double
declare function xmlXPathPopString (byval ctxt as xmlXPathParserContextPtr) as zstring ptr
declare function xmlXPathPopNodeSet (byval ctxt as xmlXPathParserContextPtr) as xmlNodeSetPtr
declare function xmlXPathPopExternal (byval ctxt as xmlXPathParserContextPtr) as any ptr
declare sub xmlXPathRegisterVariableLookup (byval ctxt as xmlXPathContextPtr, byval f as xmlXPathVariableLookupFunc, byval data as any ptr)
declare sub xmlXPathRegisterFuncLookup (byval ctxt as xmlXPathContextPtr, byval f as xmlXPathFuncLookupFunc, byval funcCtxt as any ptr)
declare sub xmlXPatherror (byval ctxt as xmlXPathParserContextPtr, byval file as zstring ptr, byval line as integer, byval no as integer)
declare sub xmlXPathErr (byval ctxt as xmlXPathParserContextPtr, byval error as integer)
declare sub xmlXPathDebugDumpObject (byval output as FILE ptr, byval cur as xmlXPathObjectPtr, byval depth as integer)
declare sub xmlXPathDebugDumpCompExpr (byval output as FILE ptr, byval comp as xmlXPathCompExprPtr, byval depth as integer)
declare function xmlXPathNodeSetContains (byval cur as xmlNodeSetPtr, byval val as xmlNodePtr) as integer
declare function xmlXPathDifference (byval nodes1 as xmlNodeSetPtr, byval nodes2 as xmlNodeSetPtr) as xmlNodeSetPtr
declare function xmlXPathIntersection (byval nodes1 as xmlNodeSetPtr, byval nodes2 as xmlNodeSetPtr) as xmlNodeSetPtr
declare function xmlXPathDistinctSorted (byval nodes as xmlNodeSetPtr) as xmlNodeSetPtr
declare function xmlXPathDistinct (byval nodes as xmlNodeSetPtr) as xmlNodeSetPtr
declare function xmlXPathHasSameNodes (byval nodes1 as xmlNodeSetPtr, byval nodes2 as xmlNodeSetPtr) as integer
declare function xmlXPathNodeLeadingSorted (byval nodes as xmlNodeSetPtr, byval node as xmlNodePtr) as xmlNodeSetPtr
declare function xmlXPathLeadingSorted (byval nodes1 as xmlNodeSetPtr, byval nodes2 as xmlNodeSetPtr) as xmlNodeSetPtr
declare function xmlXPathNodeLeading (byval nodes as xmlNodeSetPtr, byval node as xmlNodePtr) as xmlNodeSetPtr
declare function xmlXPathLeading (byval nodes1 as xmlNodeSetPtr, byval nodes2 as xmlNodeSetPtr) as xmlNodeSetPtr
declare function xmlXPathNodeTrailingSorted (byval nodes as xmlNodeSetPtr, byval node as xmlNodePtr) as xmlNodeSetPtr
declare function xmlXPathTrailingSorted (byval nodes1 as xmlNodeSetPtr, byval nodes2 as xmlNodeSetPtr) as xmlNodeSetPtr
declare function xmlXPathNodeTrailing (byval nodes as xmlNodeSetPtr, byval node as xmlNodePtr) as xmlNodeSetPtr
declare function xmlXPathTrailing (byval nodes1 as xmlNodeSetPtr, byval nodes2 as xmlNodeSetPtr) as xmlNodeSetPtr
declare function xmlXPathRegisterNs (byval ctxt as xmlXPathContextPtr, byval prefix as zstring ptr, byval ns_uri as zstring ptr) as integer
declare function xmlXPathNsLookup (byval ctxt as xmlXPathContextPtr, byval prefix as zstring ptr) as zstring ptr
declare sub xmlXPathRegisteredNsCleanup (byval ctxt as xmlXPathContextPtr)
declare function xmlXPathRegisterFunc (byval ctxt as xmlXPathContextPtr, byval name as zstring ptr, byval f as xmlXPathFunction) as integer
declare function xmlXPathRegisterFuncNS (byval ctxt as xmlXPathContextPtr, byval name as zstring ptr, byval ns_uri as zstring ptr, byval f as xmlXPathFunction) as integer
declare function xmlXPathRegisterVariable (byval ctxt as xmlXPathContextPtr, byval name as zstring ptr, byval value as xmlXPathObjectPtr) as integer
declare function xmlXPathRegisterVariableNS (byval ctxt as xmlXPathContextPtr, byval name as zstring ptr, byval ns_uri as zstring ptr, byval value as xmlXPathObjectPtr) as integer
declare function xmlXPathFunctionLookup (byval ctxt as xmlXPathContextPtr, byval name as zstring ptr) as xmlXPathFunction
declare function xmlXPathFunctionLookupNS (byval ctxt as xmlXPathContextPtr, byval name as zstring ptr, byval ns_uri as zstring ptr) as xmlXPathFunction
declare sub xmlXPathRegisteredFuncsCleanup (byval ctxt as xmlXPathContextPtr)
declare function xmlXPathVariableLookup (byval ctxt as xmlXPathContextPtr, byval name as zstring ptr) as xmlXPathObjectPtr
declare function xmlXPathVariableLookupNS (byval ctxt as xmlXPathContextPtr, byval name as zstring ptr, byval ns_uri as zstring ptr) as xmlXPathObjectPtr
declare sub xmlXPathRegisteredVariablesCleanup (byval ctxt as xmlXPathContextPtr)
declare function xmlXPathNewParserContext (byval str as zstring ptr, byval ctxt as xmlXPathContextPtr) as xmlXPathParserContextPtr
declare sub xmlXPathFreeParserContext (byval ctxt as xmlXPathParserContextPtr)
declare function valuePop (byval ctxt as xmlXPathParserContextPtr) as xmlXPathObjectPtr
declare function valuePush (byval ctxt as xmlXPathParserContextPtr, byval value as xmlXPathObjectPtr) as integer
declare function xmlXPathNewString (byval val as zstring ptr) as xmlXPathObjectPtr
declare function xmlXPathNewCString (byval val as zstring ptr) as xmlXPathObjectPtr
declare function xmlXPathWrapString (byval val as zstring ptr) as xmlXPathObjectPtr
declare function xmlXPathWrapCString (byval val as zstring ptr) as xmlXPathObjectPtr
declare function xmlXPathNewFloat (byval val as double) as xmlXPathObjectPtr
declare function xmlXPathNewBoolean (byval val as integer) as xmlXPathObjectPtr
declare function xmlXPathNewNodeSet (byval val as xmlNodePtr) as xmlXPathObjectPtr
declare function xmlXPathNewValueTree (byval val as xmlNodePtr) as xmlXPathObjectPtr
declare sub xmlXPathNodeSetAdd (byval cur as xmlNodeSetPtr, byval val as xmlNodePtr)
declare sub xmlXPathNodeSetAddUnique (byval cur as xmlNodeSetPtr, byval val as xmlNodePtr)
declare sub xmlXPathNodeSetAddNs (byval cur as xmlNodeSetPtr, byval node as xmlNodePtr, byval ns as xmlNsPtr)
declare sub xmlXPathNodeSetSort (byval set as xmlNodeSetPtr)
declare sub xmlXPathRoot (byval ctxt as xmlXPathParserContextPtr)
declare sub xmlXPathEvalExpr (byval ctxt as xmlXPathParserContextPtr)
declare function xmlXPathParseName (byval ctxt as xmlXPathParserContextPtr) as zstring ptr
declare function xmlXPathParseNCName (byval ctxt as xmlXPathParserContextPtr) as zstring ptr
declare function xmlXPathStringEvalNumber (byval str as zstring ptr) as double
declare function xmlXPathEvaluatePredicateResult (byval ctxt as xmlXPathParserContextPtr, byval res as xmlXPathObjectPtr) as integer
declare sub xmlXPathRegisterAllFunctions (byval ctxt as xmlXPathContextPtr)
declare function xmlXPathNodeSetMerge (byval val1 as xmlNodeSetPtr, byval val2 as xmlNodeSetPtr) as xmlNodeSetPtr
declare sub xmlXPathNodeSetDel (byval cur as xmlNodeSetPtr, byval val as xmlNodePtr)
declare sub xmlXPathNodeSetRemove (byval cur as xmlNodeSetPtr, byval val as integer)
declare function xmlXPathNewNodeSetList (byval val as xmlNodeSetPtr) as xmlXPathObjectPtr
declare function xmlXPathWrapNodeSet (byval val as xmlNodeSetPtr) as xmlXPathObjectPtr
declare function xmlXPathWrapExternal (byval val as any ptr) as xmlXPathObjectPtr
declare function xmlXPathEqualValues (byval ctxt as xmlXPathParserContextPtr) as integer
declare function xmlXPathNotEqualValues (byval ctxt as xmlXPathParserContextPtr) as integer
declare function xmlXPathCompareValues (byval ctxt as xmlXPathParserContextPtr, byval inf as integer, byval strict as integer) as integer
declare sub xmlXPathValueFlipSign (byval ctxt as xmlXPathParserContextPtr)
declare sub xmlXPathAddValues (byval ctxt as xmlXPathParserContextPtr)
declare sub xmlXPathSubValues (byval ctxt as xmlXPathParserContextPtr)
declare sub xmlXPathMultValues (byval ctxt as xmlXPathParserContextPtr)
declare sub xmlXPathDivValues (byval ctxt as xmlXPathParserContextPtr)
declare sub xmlXPathModValues (byval ctxt as xmlXPathParserContextPtr)
declare function xmlXPathIsNodeType (byval name as zstring ptr) as integer
declare function xmlXPathNextSelf (byval ctxt as xmlXPathParserContextPtr, byval cur as xmlNodePtr) as xmlNodePtr
declare function xmlXPathNextChild (byval ctxt as xmlXPathParserContextPtr, byval cur as xmlNodePtr) as xmlNodePtr
declare function xmlXPathNextDescendant (byval ctxt as xmlXPathParserContextPtr, byval cur as xmlNodePtr) as xmlNodePtr
declare function xmlXPathNextDescendantOrSelf (byval ctxt as xmlXPathParserContextPtr, byval cur as xmlNodePtr) as xmlNodePtr
declare function xmlXPathNextParent (byval ctxt as xmlXPathParserContextPtr, byval cur as xmlNodePtr) as xmlNodePtr
declare function xmlXPathNextAncestorOrSelf (byval ctxt as xmlXPathParserContextPtr, byval cur as xmlNodePtr) as xmlNodePtr
declare function xmlXPathNextFollowingSibling (byval ctxt as xmlXPathParserContextPtr, byval cur as xmlNodePtr) as xmlNodePtr
declare function xmlXPathNextFollowing (byval ctxt as xmlXPathParserContextPtr, byval cur as xmlNodePtr) as xmlNodePtr
declare function xmlXPathNextNamespace (byval ctxt as xmlXPathParserContextPtr, byval cur as xmlNodePtr) as xmlNodePtr
declare function xmlXPathNextAttribute (byval ctxt as xmlXPathParserContextPtr, byval cur as xmlNodePtr) as xmlNodePtr
declare function xmlXPathNextPreceding (byval ctxt as xmlXPathParserContextPtr, byval cur as xmlNodePtr) as xmlNodePtr
declare function xmlXPathNextAncestor (byval ctxt as xmlXPathParserContextPtr, byval cur as xmlNodePtr) as xmlNodePtr
declare function xmlXPathNextPrecedingSibling (byval ctxt as xmlXPathParserContextPtr, byval cur as xmlNodePtr) as xmlNodePtr
declare sub xmlXPathLastFunction (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xmlXPathPositionFunction (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xmlXPathCountFunction (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xmlXPathIdFunction (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xmlXPathLocalNameFunction (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xmlXPathNamespaceURIFunction (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xmlXPathStringFunction (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xmlXPathStringLengthFunction (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xmlXPathConcatFunction (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xmlXPathContainsFunction (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xmlXPathStartsWithFunction (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xmlXPathSubstringFunction (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xmlXPathSubstringBeforeFunction (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xmlXPathSubstringAfterFunction (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xmlXPathNormalizeFunction (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xmlXPathTranslateFunction (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xmlXPathNotFunction (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xmlXPathTrueFunction (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xmlXPathFalseFunction (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xmlXPathLangFunction (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xmlXPathNumberFunction (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xmlXPathSumFunction (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xmlXPathFloorFunction (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xmlXPathCeilingFunction (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xmlXPathRoundFunction (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xmlXPathBooleanFunction (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xmlXPathNodeSetFreeNs (byval ns as xmlNsPtr)
end extern

#endif
