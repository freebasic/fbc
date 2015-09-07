'' FreeBASIC binding for libxml2-2.9.2
''
'' based on the C header files:
''    Copyright (C) 1998-2012 Daniel Veillard.  All Rights Reserved.
''
''   Permission is hereby granted, free of charge, to any person obtaining a copy
''   of this software and associated documentation files (the "Software"), to deal
''   in the Software without restriction, including without limitation the rights
''   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
''   copies of the Software, and to permit persons to whom the Software is fur-
''   nished to do so, subject to the following conditions:
''
''   The above copyright notice and this permission notice shall be included in
''   all copies or substantial portions of the Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
''   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FIT-
''   NESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
''   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
''   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
''   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
''   THE SOFTWARE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "libxml/xmlversion.bi"
#include once "libxml/xpath.bi"

extern "C"

#define __XML_XPATH_INTERNALS_H__
#macro xmlXPathSetError(ctxt, err)
	scope
		xmlXPatherror((ctxt), __FILE__, __LINE__, (err))
		if (ctxt) <> NULL then
			(ctxt)->error = (err)
		end if
	end scope
#endmacro
#define xmlXPathSetArityError(ctxt) xmlXPathSetError((ctxt), XPATH_INVALID_ARITY)
#define xmlXPathSetTypeError(ctxt) xmlXPathSetError((ctxt), XPATH_INVALID_TYPE)
#define xmlXPathGetError(ctxt) (ctxt)->error
#define xmlXPathCheckError(ctxt) ((ctxt)->error <> XPATH_EXPRESSION_OK)
#define xmlXPathGetDocument(ctxt) (ctxt)->context->doc
#define xmlXPathGetContextNode(ctxt) (ctxt)->context->node

declare function xmlXPathPopBoolean(byval ctxt as xmlXPathParserContextPtr) as long
declare function xmlXPathPopNumber(byval ctxt as xmlXPathParserContextPtr) as double
declare function xmlXPathPopString(byval ctxt as xmlXPathParserContextPtr) as xmlChar ptr
declare function xmlXPathPopNodeSet(byval ctxt as xmlXPathParserContextPtr) as xmlNodeSetPtr
declare function xmlXPathPopExternal(byval ctxt as xmlXPathParserContextPtr) as any ptr

#define xmlXPathReturnBoolean(ctxt, val) valuePush((ctxt), xmlXPathNewBoolean(val))
#define xmlXPathReturnTrue(ctxt) xmlXPathReturnBoolean((ctxt), 1)
#define xmlXPathReturnFalse(ctxt) xmlXPathReturnBoolean((ctxt), 0)
#define xmlXPathReturnNumber(ctxt, val) valuePush((ctxt), xmlXPathNewFloat(val))
#define xmlXPathReturnString(ctxt, str) valuePush((ctxt), xmlXPathWrapString(str))
#define xmlXPathReturnEmptyString(ctxt) valuePush((ctxt), xmlXPathNewCString(""))
#define xmlXPathReturnNodeSet(ctxt, ns) valuePush((ctxt), xmlXPathWrapNodeSet(ns))
#define xmlXPathReturnEmptyNodeSet(ctxt) valuePush((ctxt), xmlXPathNewNodeSet(NULL))
#define xmlXPathReturnExternal(ctxt, val) valuePush((ctxt), xmlXPathWrapExternal(val))
#define xmlXPathStackIsNodeSet(ctxt) (((ctxt)->value <> NULL) andalso (((ctxt)->value->type = XPATH_NODESET) orelse ((ctxt)->value->type = XPATH_XSLT_TREE)))
#define xmlXPathStackIsExternal(ctxt) ((ctxt->value <> NULL) andalso (ctxt->value->type = XPATH_USERS))
#macro xmlXPathEmptyNodeSet(ns)
	while (ns)->nodeNr > 0
		(ns)->nodeTab[(ns)->nodeNr] = NULL
		(ns)->nodeNr -= 1
	wend
#endmacro
#macro CHECK_ERROR
	if ctxt->error <> XPATH_EXPRESSION_OK then
		return
	end if
#endmacro
#macro CHECK_ERROR0
	if ctxt->error <> XPATH_EXPRESSION_OK then
		return 0
	end if
#endmacro
#macro XP_ERROR(X)
	scope
		xmlXPathErr(ctxt, X)
		return
	end scope
#endmacro
#macro XP_ERROR0(X)
	scope
		xmlXPathErr(ctxt, X)
		return 0
	end scope
#endmacro
#macro CHECK_TYPE(typeval)
	if (ctxt->value = NULL) orelse (ctxt->value->type <> typeval) then
		XP_ERROR(XPATH_INVALID_TYPE)
	end if
#endmacro
#macro CHECK_TYPE0(typeval)
	if (ctxt->value = NULL) orelse (ctxt->value->type <> typeval) then
		XP_ERROR0(XPATH_INVALID_TYPE)
	end if
#endmacro
#macro CHECK_ARITY(x)
	scope
		if ctxt = NULL then
			return
		end if
		if nargs <> (x) then
			XP_ERROR(XPATH_INVALID_ARITY)
		end if
		if ctxt->valueNr < (ctxt->valueFrame + (x)) then
			XP_ERROR(XPATH_STACK_ERROR)
		end if
	end scope
#endmacro
#macro CAST_TO_STRING
	if (ctxt->value <> NULL) andalso (ctxt->value->type <> XPATH_STRING) then
		xmlXPathStringFunction(ctxt, 1)
	end if
#endmacro
#macro CAST_TO_NUMBER
	if (ctxt->value <> NULL) andalso (ctxt->value->type <> XPATH_NUMBER) then
		xmlXPathNumberFunction(ctxt, 1)
	end if
#endmacro
#macro CAST_TO_BOOLEAN
	if (ctxt->value <> NULL) andalso (ctxt->value->type <> XPATH_BOOLEAN) then
		xmlXPathBooleanFunction(ctxt, 1)
	end if
#endmacro

declare sub xmlXPathRegisterVariableLookup(byval ctxt as xmlXPathContextPtr, byval f as xmlXPathVariableLookupFunc, byval data as any ptr)
declare sub xmlXPathRegisterFuncLookup(byval ctxt as xmlXPathContextPtr, byval f as xmlXPathFuncLookupFunc, byval funcCtxt as any ptr)
declare sub xmlXPatherror(byval ctxt as xmlXPathParserContextPtr, byval file as const zstring ptr, byval line as long, byval no as long)
declare sub xmlXPathErr(byval ctxt as xmlXPathParserContextPtr, byval error as long)
declare sub xmlXPathDebugDumpObject(byval output as FILE ptr, byval cur as xmlXPathObjectPtr, byval depth as long)
declare sub xmlXPathDebugDumpCompExpr(byval output as FILE ptr, byval comp as xmlXPathCompExprPtr, byval depth as long)
declare function xmlXPathNodeSetContains(byval cur as xmlNodeSetPtr, byval val as xmlNodePtr) as long
declare function xmlXPathDifference(byval nodes1 as xmlNodeSetPtr, byval nodes2 as xmlNodeSetPtr) as xmlNodeSetPtr
declare function xmlXPathIntersection(byval nodes1 as xmlNodeSetPtr, byval nodes2 as xmlNodeSetPtr) as xmlNodeSetPtr
declare function xmlXPathDistinctSorted(byval nodes as xmlNodeSetPtr) as xmlNodeSetPtr
declare function xmlXPathDistinct(byval nodes as xmlNodeSetPtr) as xmlNodeSetPtr
declare function xmlXPathHasSameNodes(byval nodes1 as xmlNodeSetPtr, byval nodes2 as xmlNodeSetPtr) as long
declare function xmlXPathNodeLeadingSorted(byval nodes as xmlNodeSetPtr, byval node as xmlNodePtr) as xmlNodeSetPtr
declare function xmlXPathLeadingSorted(byval nodes1 as xmlNodeSetPtr, byval nodes2 as xmlNodeSetPtr) as xmlNodeSetPtr
declare function xmlXPathNodeLeading(byval nodes as xmlNodeSetPtr, byval node as xmlNodePtr) as xmlNodeSetPtr
declare function xmlXPathLeading(byval nodes1 as xmlNodeSetPtr, byval nodes2 as xmlNodeSetPtr) as xmlNodeSetPtr
declare function xmlXPathNodeTrailingSorted(byval nodes as xmlNodeSetPtr, byval node as xmlNodePtr) as xmlNodeSetPtr
declare function xmlXPathTrailingSorted(byval nodes1 as xmlNodeSetPtr, byval nodes2 as xmlNodeSetPtr) as xmlNodeSetPtr
declare function xmlXPathNodeTrailing(byval nodes as xmlNodeSetPtr, byval node as xmlNodePtr) as xmlNodeSetPtr
declare function xmlXPathTrailing(byval nodes1 as xmlNodeSetPtr, byval nodes2 as xmlNodeSetPtr) as xmlNodeSetPtr
declare function xmlXPathRegisterNs(byval ctxt as xmlXPathContextPtr, byval prefix as const xmlChar ptr, byval ns_uri as const xmlChar ptr) as long
declare function xmlXPathNsLookup(byval ctxt as xmlXPathContextPtr, byval prefix as const xmlChar ptr) as const xmlChar ptr
declare sub xmlXPathRegisteredNsCleanup(byval ctxt as xmlXPathContextPtr)
declare function xmlXPathRegisterFunc(byval ctxt as xmlXPathContextPtr, byval name as const xmlChar ptr, byval f as xmlXPathFunction) as long
declare function xmlXPathRegisterFuncNS(byval ctxt as xmlXPathContextPtr, byval name as const xmlChar ptr, byval ns_uri as const xmlChar ptr, byval f as xmlXPathFunction) as long
declare function xmlXPathRegisterVariable(byval ctxt as xmlXPathContextPtr, byval name as const xmlChar ptr, byval value as xmlXPathObjectPtr) as long
declare function xmlXPathRegisterVariableNS(byval ctxt as xmlXPathContextPtr, byval name as const xmlChar ptr, byval ns_uri as const xmlChar ptr, byval value as xmlXPathObjectPtr) as long
declare function xmlXPathFunctionLookup(byval ctxt as xmlXPathContextPtr, byval name as const xmlChar ptr) as xmlXPathFunction
declare function xmlXPathFunctionLookupNS(byval ctxt as xmlXPathContextPtr, byval name as const xmlChar ptr, byval ns_uri as const xmlChar ptr) as xmlXPathFunction
declare sub xmlXPathRegisteredFuncsCleanup(byval ctxt as xmlXPathContextPtr)
declare function xmlXPathVariableLookup(byval ctxt as xmlXPathContextPtr, byval name as const xmlChar ptr) as xmlXPathObjectPtr
declare function xmlXPathVariableLookupNS(byval ctxt as xmlXPathContextPtr, byval name as const xmlChar ptr, byval ns_uri as const xmlChar ptr) as xmlXPathObjectPtr
declare sub xmlXPathRegisteredVariablesCleanup(byval ctxt as xmlXPathContextPtr)
declare function xmlXPathNewParserContext(byval str as const xmlChar ptr, byval ctxt as xmlXPathContextPtr) as xmlXPathParserContextPtr
declare sub xmlXPathFreeParserContext(byval ctxt as xmlXPathParserContextPtr)
declare function valuePop(byval ctxt as xmlXPathParserContextPtr) as xmlXPathObjectPtr
declare function valuePush(byval ctxt as xmlXPathParserContextPtr, byval value as xmlXPathObjectPtr) as long
declare function xmlXPathNewString(byval val as const xmlChar ptr) as xmlXPathObjectPtr
declare function xmlXPathNewCString(byval val as const zstring ptr) as xmlXPathObjectPtr
declare function xmlXPathWrapString(byval val as xmlChar ptr) as xmlXPathObjectPtr
declare function xmlXPathWrapCString(byval val as zstring ptr) as xmlXPathObjectPtr
declare function xmlXPathNewFloat(byval val as double) as xmlXPathObjectPtr
declare function xmlXPathNewBoolean(byval val as long) as xmlXPathObjectPtr
declare function xmlXPathNewNodeSet(byval val as xmlNodePtr) as xmlXPathObjectPtr
declare function xmlXPathNewValueTree(byval val as xmlNodePtr) as xmlXPathObjectPtr
declare function xmlXPathNodeSetAdd(byval cur as xmlNodeSetPtr, byval val as xmlNodePtr) as long
declare function xmlXPathNodeSetAddUnique(byval cur as xmlNodeSetPtr, byval val as xmlNodePtr) as long
declare function xmlXPathNodeSetAddNs(byval cur as xmlNodeSetPtr, byval node as xmlNodePtr, byval ns as xmlNsPtr) as long
declare sub xmlXPathNodeSetSort(byval set as xmlNodeSetPtr)
declare sub xmlXPathRoot(byval ctxt as xmlXPathParserContextPtr)
declare sub xmlXPathEvalExpr(byval ctxt as xmlXPathParserContextPtr)
declare function xmlXPathParseName(byval ctxt as xmlXPathParserContextPtr) as xmlChar ptr
declare function xmlXPathParseNCName(byval ctxt as xmlXPathParserContextPtr) as xmlChar ptr
declare function xmlXPathStringEvalNumber(byval str as const xmlChar ptr) as double
declare function xmlXPathEvaluatePredicateResult(byval ctxt as xmlXPathParserContextPtr, byval res as xmlXPathObjectPtr) as long
declare sub xmlXPathRegisterAllFunctions(byval ctxt as xmlXPathContextPtr)
declare function xmlXPathNodeSetMerge(byval val1 as xmlNodeSetPtr, byval val2 as xmlNodeSetPtr) as xmlNodeSetPtr
declare sub xmlXPathNodeSetDel(byval cur as xmlNodeSetPtr, byval val as xmlNodePtr)
declare sub xmlXPathNodeSetRemove(byval cur as xmlNodeSetPtr, byval val as long)
declare function xmlXPathNewNodeSetList(byval val as xmlNodeSetPtr) as xmlXPathObjectPtr
declare function xmlXPathWrapNodeSet(byval val as xmlNodeSetPtr) as xmlXPathObjectPtr
declare function xmlXPathWrapExternal(byval val as any ptr) as xmlXPathObjectPtr
declare function xmlXPathEqualValues(byval ctxt as xmlXPathParserContextPtr) as long
declare function xmlXPathNotEqualValues(byval ctxt as xmlXPathParserContextPtr) as long
declare function xmlXPathCompareValues(byval ctxt as xmlXPathParserContextPtr, byval inf as long, byval strict as long) as long
declare sub xmlXPathValueFlipSign(byval ctxt as xmlXPathParserContextPtr)
declare sub xmlXPathAddValues(byval ctxt as xmlXPathParserContextPtr)
declare sub xmlXPathSubValues(byval ctxt as xmlXPathParserContextPtr)
declare sub xmlXPathMultValues(byval ctxt as xmlXPathParserContextPtr)
declare sub xmlXPathDivValues(byval ctxt as xmlXPathParserContextPtr)
declare sub xmlXPathModValues(byval ctxt as xmlXPathParserContextPtr)
declare function xmlXPathIsNodeType(byval name as const xmlChar ptr) as long
declare function xmlXPathNextSelf(byval ctxt as xmlXPathParserContextPtr, byval cur as xmlNodePtr) as xmlNodePtr
declare function xmlXPathNextChild(byval ctxt as xmlXPathParserContextPtr, byval cur as xmlNodePtr) as xmlNodePtr
declare function xmlXPathNextDescendant(byval ctxt as xmlXPathParserContextPtr, byval cur as xmlNodePtr) as xmlNodePtr
declare function xmlXPathNextDescendantOrSelf(byval ctxt as xmlXPathParserContextPtr, byval cur as xmlNodePtr) as xmlNodePtr
declare function xmlXPathNextParent(byval ctxt as xmlXPathParserContextPtr, byval cur as xmlNodePtr) as xmlNodePtr
declare function xmlXPathNextAncestorOrSelf(byval ctxt as xmlXPathParserContextPtr, byval cur as xmlNodePtr) as xmlNodePtr
declare function xmlXPathNextFollowingSibling(byval ctxt as xmlXPathParserContextPtr, byval cur as xmlNodePtr) as xmlNodePtr
declare function xmlXPathNextFollowing(byval ctxt as xmlXPathParserContextPtr, byval cur as xmlNodePtr) as xmlNodePtr
declare function xmlXPathNextNamespace(byval ctxt as xmlXPathParserContextPtr, byval cur as xmlNodePtr) as xmlNodePtr
declare function xmlXPathNextAttribute(byval ctxt as xmlXPathParserContextPtr, byval cur as xmlNodePtr) as xmlNodePtr
declare function xmlXPathNextPreceding(byval ctxt as xmlXPathParserContextPtr, byval cur as xmlNodePtr) as xmlNodePtr
declare function xmlXPathNextAncestor(byval ctxt as xmlXPathParserContextPtr, byval cur as xmlNodePtr) as xmlNodePtr
declare function xmlXPathNextPrecedingSibling(byval ctxt as xmlXPathParserContextPtr, byval cur as xmlNodePtr) as xmlNodePtr
declare sub xmlXPathLastFunction(byval ctxt as xmlXPathParserContextPtr, byval nargs as long)
declare sub xmlXPathPositionFunction(byval ctxt as xmlXPathParserContextPtr, byval nargs as long)
declare sub xmlXPathCountFunction(byval ctxt as xmlXPathParserContextPtr, byval nargs as long)
declare sub xmlXPathIdFunction(byval ctxt as xmlXPathParserContextPtr, byval nargs as long)
declare sub xmlXPathLocalNameFunction(byval ctxt as xmlXPathParserContextPtr, byval nargs as long)
declare sub xmlXPathNamespaceURIFunction(byval ctxt as xmlXPathParserContextPtr, byval nargs as long)
declare sub xmlXPathStringFunction(byval ctxt as xmlXPathParserContextPtr, byval nargs as long)
declare sub xmlXPathStringLengthFunction(byval ctxt as xmlXPathParserContextPtr, byval nargs as long)
declare sub xmlXPathConcatFunction(byval ctxt as xmlXPathParserContextPtr, byval nargs as long)
declare sub xmlXPathContainsFunction(byval ctxt as xmlXPathParserContextPtr, byval nargs as long)
declare sub xmlXPathStartsWithFunction(byval ctxt as xmlXPathParserContextPtr, byval nargs as long)
declare sub xmlXPathSubstringFunction(byval ctxt as xmlXPathParserContextPtr, byval nargs as long)
declare sub xmlXPathSubstringBeforeFunction(byval ctxt as xmlXPathParserContextPtr, byval nargs as long)
declare sub xmlXPathSubstringAfterFunction(byval ctxt as xmlXPathParserContextPtr, byval nargs as long)
declare sub xmlXPathNormalizeFunction(byval ctxt as xmlXPathParserContextPtr, byval nargs as long)
declare sub xmlXPathTranslateFunction(byval ctxt as xmlXPathParserContextPtr, byval nargs as long)
declare sub xmlXPathNotFunction(byval ctxt as xmlXPathParserContextPtr, byval nargs as long)
declare sub xmlXPathTrueFunction(byval ctxt as xmlXPathParserContextPtr, byval nargs as long)
declare sub xmlXPathFalseFunction(byval ctxt as xmlXPathParserContextPtr, byval nargs as long)
declare sub xmlXPathLangFunction(byval ctxt as xmlXPathParserContextPtr, byval nargs as long)
declare sub xmlXPathNumberFunction(byval ctxt as xmlXPathParserContextPtr, byval nargs as long)
declare sub xmlXPathSumFunction(byval ctxt as xmlXPathParserContextPtr, byval nargs as long)
declare sub xmlXPathFloorFunction(byval ctxt as xmlXPathParserContextPtr, byval nargs as long)
declare sub xmlXPathCeilingFunction(byval ctxt as xmlXPathParserContextPtr, byval nargs as long)
declare sub xmlXPathRoundFunction(byval ctxt as xmlXPathParserContextPtr, byval nargs as long)
declare sub xmlXPathBooleanFunction(byval ctxt as xmlXPathParserContextPtr, byval nargs as long)
declare sub xmlXPathNodeSetFreeNs(byval ns as xmlNsPtr)

end extern
