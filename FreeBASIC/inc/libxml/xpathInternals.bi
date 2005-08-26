''
''
'' xpathInternals -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __xpathInternals_bi__
#define __xpathInternals_bi__

#include once "libxml/xmlversion.bi"
#include once "libxml/xpath.bi"

declare function xmlXPathPopBoolean cdecl alias "xmlXPathPopBoolean" (byval ctxt as xmlXPathParserContextPtr) as integer
declare function xmlXPathPopNumber cdecl alias "xmlXPathPopNumber" (byval ctxt as xmlXPathParserContextPtr) as double
declare function xmlXPathPopString cdecl alias "xmlXPathPopString" (byval ctxt as xmlXPathParserContextPtr) as zstring ptr
declare function xmlXPathPopNodeSet cdecl alias "xmlXPathPopNodeSet" (byval ctxt as xmlXPathParserContextPtr) as xmlNodeSetPtr
declare function xmlXPathPopExternal cdecl alias "xmlXPathPopExternal" (byval ctxt as xmlXPathParserContextPtr) as any ptr
declare sub xmlXPathRegisterVariableLookup cdecl alias "xmlXPathRegisterVariableLookup" (byval ctxt as xmlXPathContextPtr, byval f as xmlXPathVariableLookupFunc, byval data as any ptr)
declare sub xmlXPathRegisterFuncLookup cdecl alias "xmlXPathRegisterFuncLookup" (byval ctxt as xmlXPathContextPtr, byval f as xmlXPathFuncLookupFunc, byval funcCtxt as any ptr)
declare sub xmlXPatherror cdecl alias "xmlXPatherror" (byval ctxt as xmlXPathParserContextPtr, byval file as zstring ptr, byval line as integer, byval no as integer)
declare sub xmlXPathErr cdecl alias "xmlXPathErr" (byval ctxt as xmlXPathParserContextPtr, byval error as integer)
declare sub xmlXPathDebugDumpObject cdecl alias "xmlXPathDebugDumpObject" (byval output as FILE ptr, byval cur as xmlXPathObjectPtr, byval depth as integer)
declare sub xmlXPathDebugDumpCompExpr cdecl alias "xmlXPathDebugDumpCompExpr" (byval output as FILE ptr, byval comp as xmlXPathCompExprPtr, byval depth as integer)
declare function xmlXPathNodeSetContains cdecl alias "xmlXPathNodeSetContains" (byval cur as xmlNodeSetPtr, byval val as xmlNodePtr) as integer
declare function xmlXPathDifference cdecl alias "xmlXPathDifference" (byval nodes1 as xmlNodeSetPtr, byval nodes2 as xmlNodeSetPtr) as xmlNodeSetPtr
declare function xmlXPathIntersection cdecl alias "xmlXPathIntersection" (byval nodes1 as xmlNodeSetPtr, byval nodes2 as xmlNodeSetPtr) as xmlNodeSetPtr
declare function xmlXPathDistinctSorted cdecl alias "xmlXPathDistinctSorted" (byval nodes as xmlNodeSetPtr) as xmlNodeSetPtr
declare function xmlXPathDistinct cdecl alias "xmlXPathDistinct" (byval nodes as xmlNodeSetPtr) as xmlNodeSetPtr
declare function xmlXPathHasSameNodes cdecl alias "xmlXPathHasSameNodes" (byval nodes1 as xmlNodeSetPtr, byval nodes2 as xmlNodeSetPtr) as integer
declare function xmlXPathNodeLeadingSorted cdecl alias "xmlXPathNodeLeadingSorted" (byval nodes as xmlNodeSetPtr, byval node as xmlNodePtr) as xmlNodeSetPtr
declare function xmlXPathLeadingSorted cdecl alias "xmlXPathLeadingSorted" (byval nodes1 as xmlNodeSetPtr, byval nodes2 as xmlNodeSetPtr) as xmlNodeSetPtr
declare function xmlXPathNodeLeading cdecl alias "xmlXPathNodeLeading" (byval nodes as xmlNodeSetPtr, byval node as xmlNodePtr) as xmlNodeSetPtr
declare function xmlXPathLeading cdecl alias "xmlXPathLeading" (byval nodes1 as xmlNodeSetPtr, byval nodes2 as xmlNodeSetPtr) as xmlNodeSetPtr
declare function xmlXPathNodeTrailingSorted cdecl alias "xmlXPathNodeTrailingSorted" (byval nodes as xmlNodeSetPtr, byval node as xmlNodePtr) as xmlNodeSetPtr
declare function xmlXPathTrailingSorted cdecl alias "xmlXPathTrailingSorted" (byval nodes1 as xmlNodeSetPtr, byval nodes2 as xmlNodeSetPtr) as xmlNodeSetPtr
declare function xmlXPathNodeTrailing cdecl alias "xmlXPathNodeTrailing" (byval nodes as xmlNodeSetPtr, byval node as xmlNodePtr) as xmlNodeSetPtr
declare function xmlXPathTrailing cdecl alias "xmlXPathTrailing" (byval nodes1 as xmlNodeSetPtr, byval nodes2 as xmlNodeSetPtr) as xmlNodeSetPtr
declare function xmlXPathRegisterNs cdecl alias "xmlXPathRegisterNs" (byval ctxt as xmlXPathContextPtr, byval prefix as zstring ptr, byval ns_uri as zstring ptr) as integer
declare function xmlXPathNsLookup cdecl alias "xmlXPathNsLookup" (byval ctxt as xmlXPathContextPtr, byval prefix as zstring ptr) as zstring ptr
declare sub xmlXPathRegisteredNsCleanup cdecl alias "xmlXPathRegisteredNsCleanup" (byval ctxt as xmlXPathContextPtr)
declare function xmlXPathRegisterFunc cdecl alias "xmlXPathRegisterFunc" (byval ctxt as xmlXPathContextPtr, byval name as zstring ptr, byval f as xmlXPathFunction) as integer
declare function xmlXPathRegisterFuncNS cdecl alias "xmlXPathRegisterFuncNS" (byval ctxt as xmlXPathContextPtr, byval name as zstring ptr, byval ns_uri as zstring ptr, byval f as xmlXPathFunction) as integer
declare function xmlXPathRegisterVariable cdecl alias "xmlXPathRegisterVariable" (byval ctxt as xmlXPathContextPtr, byval name as zstring ptr, byval value as xmlXPathObjectPtr) as integer
declare function xmlXPathRegisterVariableNS cdecl alias "xmlXPathRegisterVariableNS" (byval ctxt as xmlXPathContextPtr, byval name as zstring ptr, byval ns_uri as zstring ptr, byval value as xmlXPathObjectPtr) as integer
declare function xmlXPathFunctionLookup cdecl alias "xmlXPathFunctionLookup" (byval ctxt as xmlXPathContextPtr, byval name as zstring ptr) as xmlXPathFunction
declare function xmlXPathFunctionLookupNS cdecl alias "xmlXPathFunctionLookupNS" (byval ctxt as xmlXPathContextPtr, byval name as zstring ptr, byval ns_uri as zstring ptr) as xmlXPathFunction
declare sub xmlXPathRegisteredFuncsCleanup cdecl alias "xmlXPathRegisteredFuncsCleanup" (byval ctxt as xmlXPathContextPtr)
declare function xmlXPathVariableLookup cdecl alias "xmlXPathVariableLookup" (byval ctxt as xmlXPathContextPtr, byval name as zstring ptr) as xmlXPathObjectPtr
declare function xmlXPathVariableLookupNS cdecl alias "xmlXPathVariableLookupNS" (byval ctxt as xmlXPathContextPtr, byval name as zstring ptr, byval ns_uri as zstring ptr) as xmlXPathObjectPtr
declare sub xmlXPathRegisteredVariablesCleanup cdecl alias "xmlXPathRegisteredVariablesCleanup" (byval ctxt as xmlXPathContextPtr)
declare function xmlXPathNewParserContext cdecl alias "xmlXPathNewParserContext" (byval str as zstring ptr, byval ctxt as xmlXPathContextPtr) as xmlXPathParserContextPtr
declare sub xmlXPathFreeParserContext cdecl alias "xmlXPathFreeParserContext" (byval ctxt as xmlXPathParserContextPtr)
declare function valuePop cdecl alias "valuePop" (byval ctxt as xmlXPathParserContextPtr) as xmlXPathObjectPtr
declare function valuePush cdecl alias "valuePush" (byval ctxt as xmlXPathParserContextPtr, byval value as xmlXPathObjectPtr) as integer
declare function xmlXPathNewString cdecl alias "xmlXPathNewString" (byval val as zstring ptr) as xmlXPathObjectPtr
declare function xmlXPathNewCString cdecl alias "xmlXPathNewCString" (byval val as zstring ptr) as xmlXPathObjectPtr
declare function xmlXPathWrapString cdecl alias "xmlXPathWrapString" (byval val as zstring ptr) as xmlXPathObjectPtr
declare function xmlXPathWrapCString cdecl alias "xmlXPathWrapCString" (byval val as zstring ptr) as xmlXPathObjectPtr
declare function xmlXPathNewFloat cdecl alias "xmlXPathNewFloat" (byval val as double) as xmlXPathObjectPtr
declare function xmlXPathNewBoolean cdecl alias "xmlXPathNewBoolean" (byval val as integer) as xmlXPathObjectPtr
declare function xmlXPathNewNodeSet cdecl alias "xmlXPathNewNodeSet" (byval val as xmlNodePtr) as xmlXPathObjectPtr
declare function xmlXPathNewValueTree cdecl alias "xmlXPathNewValueTree" (byval val as xmlNodePtr) as xmlXPathObjectPtr
declare sub xmlXPathNodeSetAdd cdecl alias "xmlXPathNodeSetAdd" (byval cur as xmlNodeSetPtr, byval val as xmlNodePtr)
declare sub xmlXPathNodeSetAddUnique cdecl alias "xmlXPathNodeSetAddUnique" (byval cur as xmlNodeSetPtr, byval val as xmlNodePtr)
declare sub xmlXPathNodeSetAddNs cdecl alias "xmlXPathNodeSetAddNs" (byval cur as xmlNodeSetPtr, byval node as xmlNodePtr, byval ns as xmlNsPtr)
declare sub xmlXPathNodeSetSort cdecl alias "xmlXPathNodeSetSort" (byval set as xmlNodeSetPtr)
declare sub xmlXPathRoot cdecl alias "xmlXPathRoot" (byval ctxt as xmlXPathParserContextPtr)
declare sub xmlXPathEvalExpr cdecl alias "xmlXPathEvalExpr" (byval ctxt as xmlXPathParserContextPtr)
declare function xmlXPathParseName cdecl alias "xmlXPathParseName" (byval ctxt as xmlXPathParserContextPtr) as zstring ptr
declare function xmlXPathParseNCName cdecl alias "xmlXPathParseNCName" (byval ctxt as xmlXPathParserContextPtr) as zstring ptr
declare function xmlXPathStringEvalNumber cdecl alias "xmlXPathStringEvalNumber" (byval str as zstring ptr) as double
declare function xmlXPathEvaluatePredicateResult cdecl alias "xmlXPathEvaluatePredicateResult" (byval ctxt as xmlXPathParserContextPtr, byval res as xmlXPathObjectPtr) as integer
declare sub xmlXPathRegisterAllFunctions cdecl alias "xmlXPathRegisterAllFunctions" (byval ctxt as xmlXPathContextPtr)
declare function xmlXPathNodeSetMerge cdecl alias "xmlXPathNodeSetMerge" (byval val1 as xmlNodeSetPtr, byval val2 as xmlNodeSetPtr) as xmlNodeSetPtr
declare sub xmlXPathNodeSetDel cdecl alias "xmlXPathNodeSetDel" (byval cur as xmlNodeSetPtr, byval val as xmlNodePtr)
declare sub xmlXPathNodeSetRemove cdecl alias "xmlXPathNodeSetRemove" (byval cur as xmlNodeSetPtr, byval val as integer)
declare function xmlXPathNewNodeSetList cdecl alias "xmlXPathNewNodeSetList" (byval val as xmlNodeSetPtr) as xmlXPathObjectPtr
declare function xmlXPathWrapNodeSet cdecl alias "xmlXPathWrapNodeSet" (byval val as xmlNodeSetPtr) as xmlXPathObjectPtr
declare function xmlXPathWrapExternal cdecl alias "xmlXPathWrapExternal" (byval val as any ptr) as xmlXPathObjectPtr
declare function xmlXPathEqualValues cdecl alias "xmlXPathEqualValues" (byval ctxt as xmlXPathParserContextPtr) as integer
declare function xmlXPathNotEqualValues cdecl alias "xmlXPathNotEqualValues" (byval ctxt as xmlXPathParserContextPtr) as integer
declare function xmlXPathCompareValues cdecl alias "xmlXPathCompareValues" (byval ctxt as xmlXPathParserContextPtr, byval inf as integer, byval strict as integer) as integer
declare sub xmlXPathValueFlipSign cdecl alias "xmlXPathValueFlipSign" (byval ctxt as xmlXPathParserContextPtr)
declare sub xmlXPathAddValues cdecl alias "xmlXPathAddValues" (byval ctxt as xmlXPathParserContextPtr)
declare sub xmlXPathSubValues cdecl alias "xmlXPathSubValues" (byval ctxt as xmlXPathParserContextPtr)
declare sub xmlXPathMultValues cdecl alias "xmlXPathMultValues" (byval ctxt as xmlXPathParserContextPtr)
declare sub xmlXPathDivValues cdecl alias "xmlXPathDivValues" (byval ctxt as xmlXPathParserContextPtr)
declare sub xmlXPathModValues cdecl alias "xmlXPathModValues" (byval ctxt as xmlXPathParserContextPtr)
declare function xmlXPathIsNodeType cdecl alias "xmlXPathIsNodeType" (byval name as zstring ptr) as integer
declare function xmlXPathNextSelf cdecl alias "xmlXPathNextSelf" (byval ctxt as xmlXPathParserContextPtr, byval cur as xmlNodePtr) as xmlNodePtr
declare function xmlXPathNextChild cdecl alias "xmlXPathNextChild" (byval ctxt as xmlXPathParserContextPtr, byval cur as xmlNodePtr) as xmlNodePtr
declare function xmlXPathNextDescendant cdecl alias "xmlXPathNextDescendant" (byval ctxt as xmlXPathParserContextPtr, byval cur as xmlNodePtr) as xmlNodePtr
declare function xmlXPathNextDescendantOrSelf cdecl alias "xmlXPathNextDescendantOrSelf" (byval ctxt as xmlXPathParserContextPtr, byval cur as xmlNodePtr) as xmlNodePtr
declare function xmlXPathNextParent cdecl alias "xmlXPathNextParent" (byval ctxt as xmlXPathParserContextPtr, byval cur as xmlNodePtr) as xmlNodePtr
declare function xmlXPathNextAncestorOrSelf cdecl alias "xmlXPathNextAncestorOrSelf" (byval ctxt as xmlXPathParserContextPtr, byval cur as xmlNodePtr) as xmlNodePtr
declare function xmlXPathNextFollowingSibling cdecl alias "xmlXPathNextFollowingSibling" (byval ctxt as xmlXPathParserContextPtr, byval cur as xmlNodePtr) as xmlNodePtr
declare function xmlXPathNextFollowing cdecl alias "xmlXPathNextFollowing" (byval ctxt as xmlXPathParserContextPtr, byval cur as xmlNodePtr) as xmlNodePtr
declare function xmlXPathNextNamespace cdecl alias "xmlXPathNextNamespace" (byval ctxt as xmlXPathParserContextPtr, byval cur as xmlNodePtr) as xmlNodePtr
declare function xmlXPathNextAttribute cdecl alias "xmlXPathNextAttribute" (byval ctxt as xmlXPathParserContextPtr, byval cur as xmlNodePtr) as xmlNodePtr
declare function xmlXPathNextPreceding cdecl alias "xmlXPathNextPreceding" (byval ctxt as xmlXPathParserContextPtr, byval cur as xmlNodePtr) as xmlNodePtr
declare function xmlXPathNextAncestor cdecl alias "xmlXPathNextAncestor" (byval ctxt as xmlXPathParserContextPtr, byval cur as xmlNodePtr) as xmlNodePtr
declare function xmlXPathNextPrecedingSibling cdecl alias "xmlXPathNextPrecedingSibling" (byval ctxt as xmlXPathParserContextPtr, byval cur as xmlNodePtr) as xmlNodePtr
declare sub xmlXPathLastFunction cdecl alias "xmlXPathLastFunction" (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xmlXPathPositionFunction cdecl alias "xmlXPathPositionFunction" (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xmlXPathCountFunction cdecl alias "xmlXPathCountFunction" (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xmlXPathIdFunction cdecl alias "xmlXPathIdFunction" (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xmlXPathLocalNameFunction cdecl alias "xmlXPathLocalNameFunction" (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xmlXPathNamespaceURIFunction cdecl alias "xmlXPathNamespaceURIFunction" (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xmlXPathStringFunction cdecl alias "xmlXPathStringFunction" (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xmlXPathStringLengthFunction cdecl alias "xmlXPathStringLengthFunction" (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xmlXPathConcatFunction cdecl alias "xmlXPathConcatFunction" (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xmlXPathContainsFunction cdecl alias "xmlXPathContainsFunction" (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xmlXPathStartsWithFunction cdecl alias "xmlXPathStartsWithFunction" (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xmlXPathSubstringFunction cdecl alias "xmlXPathSubstringFunction" (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xmlXPathSubstringBeforeFunction cdecl alias "xmlXPathSubstringBeforeFunction" (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xmlXPathSubstringAfterFunction cdecl alias "xmlXPathSubstringAfterFunction" (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xmlXPathNormalizeFunction cdecl alias "xmlXPathNormalizeFunction" (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xmlXPathTranslateFunction cdecl alias "xmlXPathTranslateFunction" (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xmlXPathNotFunction cdecl alias "xmlXPathNotFunction" (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xmlXPathTrueFunction cdecl alias "xmlXPathTrueFunction" (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xmlXPathFalseFunction cdecl alias "xmlXPathFalseFunction" (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xmlXPathLangFunction cdecl alias "xmlXPathLangFunction" (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xmlXPathNumberFunction cdecl alias "xmlXPathNumberFunction" (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xmlXPathSumFunction cdecl alias "xmlXPathSumFunction" (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xmlXPathFloorFunction cdecl alias "xmlXPathFloorFunction" (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xmlXPathCeilingFunction cdecl alias "xmlXPathCeilingFunction" (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xmlXPathRoundFunction cdecl alias "xmlXPathRoundFunction" (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xmlXPathBooleanFunction cdecl alias "xmlXPathBooleanFunction" (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xmlXPathNodeSetFreeNs cdecl alias "xmlXPathNodeSetFreeNs" (byval ns as xmlNsPtr)

#endif
