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

#include once "crt/long.bi"
#include once "libxml/xmlversion.bi"
#include once "libxml/xmlerror.bi"
#include once "libxml/tree.bi"
#include once "libxml/hash.bi"

extern "C"

#define __XML_XPATH_H__
type xmlXPathContext as _xmlXPathContext
type xmlXPathContextPtr as xmlXPathContext ptr
type xmlXPathParserContext as _xmlXPathParserContext
type xmlXPathParserContextPtr as xmlXPathParserContext ptr

type xmlXPathError as long
enum
	XPATH_EXPRESSION_OK = 0
	XPATH_NUMBER_ERROR
	XPATH_UNFINISHED_LITERAL_ERROR
	XPATH_START_LITERAL_ERROR
	XPATH_VARIABLE_REF_ERROR
	XPATH_UNDEF_VARIABLE_ERROR
	XPATH_INVALID_PREDICATE_ERROR
	XPATH_EXPR_ERROR
	XPATH_UNCLOSED_ERROR
	XPATH_UNKNOWN_FUNC_ERROR
	XPATH_INVALID_OPERAND
	XPATH_INVALID_TYPE
	XPATH_INVALID_ARITY
	XPATH_INVALID_CTXT_SIZE
	XPATH_INVALID_CTXT_POSITION
	XPATH_MEMORY_ERROR
	XPTR_SYNTAX_ERROR
	XPTR_RESOURCE_ERROR
	XPTR_SUB_RESOURCE_ERROR
	XPATH_UNDEF_PREFIX_ERROR
	XPATH_ENCODING_ERROR
	XPATH_INVALID_CHAR_ERROR
	XPATH_INVALID_CTXT
	XPATH_STACK_ERROR
	XPATH_FORBID_VARIABLE_ERROR
end enum

type xmlNodeSet as _xmlNodeSet
type xmlNodeSetPtr as xmlNodeSet ptr

type _xmlNodeSet
	nodeNr as long
	nodeMax as long
	nodeTab as xmlNodePtr ptr
end type

type xmlXPathObjectType as long
enum
	XPATH_UNDEFINED = 0
	XPATH_NODESET = 1
	XPATH_BOOLEAN = 2
	XPATH_NUMBER = 3
	XPATH_STRING = 4
	XPATH_POINT = 5
	XPATH_RANGE = 6
	XPATH_LOCATIONSET = 7
	XPATH_USERS = 8
	XPATH_XSLT_TREE = 9
end enum

type xmlXPathObject as _xmlXPathObject
type xmlXPathObjectPtr as xmlXPathObject ptr

type _xmlXPathObject
	as xmlXPathObjectType type
	nodesetval as xmlNodeSetPtr
	boolval as long
	floatval as double
	stringval as xmlChar ptr
	user as any ptr
	index as long
	user2 as any ptr
	index2 as long
end type

type xmlXPathConvertFunc as function(byval obj as xmlXPathObjectPtr, byval type as long) as long
type xmlXPathType as _xmlXPathType
type xmlXPathTypePtr as xmlXPathType ptr

type _xmlXPathType
	name as const xmlChar ptr
	func as xmlXPathConvertFunc
end type

type xmlXPathVariable as _xmlXPathVariable
type xmlXPathVariablePtr as xmlXPathVariable ptr

type _xmlXPathVariable
	name as const xmlChar ptr
	value as xmlXPathObjectPtr
end type

type xmlXPathEvalFunc as sub(byval ctxt as xmlXPathParserContextPtr, byval nargs as long)
type xmlXPathFunct as _xmlXPathFunct
type xmlXPathFuncPtr as xmlXPathFunct ptr

type _xmlXPathFunct
	name as const xmlChar ptr
	func as xmlXPathEvalFunc
end type

type xmlXPathAxisFunc as function(byval ctxt as xmlXPathParserContextPtr, byval cur as xmlXPathObjectPtr) as xmlXPathObjectPtr
type xmlXPathAxis as _xmlXPathAxis
type xmlXPathAxisPtr as xmlXPathAxis ptr

type _xmlXPathAxis
	name as const xmlChar ptr
	func as xmlXPathAxisFunc
end type

type xmlXPathFunction as sub(byval ctxt as xmlXPathParserContextPtr, byval nargs as long)
type xmlXPathVariableLookupFunc as function(byval ctxt as any ptr, byval name as const xmlChar ptr, byval ns_uri as const xmlChar ptr) as xmlXPathObjectPtr
type xmlXPathFuncLookupFunc as function(byval ctxt as any ptr, byval name as const xmlChar ptr, byval ns_uri as const xmlChar ptr) as xmlXPathFunction
const XML_XPATH_CHECKNS = 1 shl 0
const XML_XPATH_NOVAR = 1 shl 1

type _xmlXPathContext
	doc as xmlDocPtr
	node as xmlNodePtr
	nb_variables_unused as long
	max_variables_unused as long
	varHash as xmlHashTablePtr
	nb_types as long
	max_types as long
	types as xmlXPathTypePtr
	nb_funcs_unused as long
	max_funcs_unused as long
	funcHash as xmlHashTablePtr
	nb_axis as long
	max_axis as long
	axis as xmlXPathAxisPtr
	namespaces as xmlNsPtr ptr
	nsNr as long
	user as any ptr
	contextSize as long
	proximityPosition as long
	xptr as long
	here as xmlNodePtr
	origin as xmlNodePtr
	nsHash as xmlHashTablePtr
	varLookupFunc as xmlXPathVariableLookupFunc
	varLookupData as any ptr
	extra as any ptr
	function as const xmlChar ptr
	functionURI as const xmlChar ptr
	funcLookupFunc as xmlXPathFuncLookupFunc
	funcLookupData as any ptr
	tmpNsList as xmlNsPtr ptr
	tmpNsNr as long
	userData as any ptr
	error as xmlStructuredErrorFunc
	lastError as xmlError
	debugNode as xmlNodePtr
	dict as xmlDictPtr
	flags as long
	cache as any ptr
end type

type xmlXPathCompExpr as _xmlXPathCompExpr
type xmlXPathCompExprPtr as xmlXPathCompExpr ptr

type _xmlXPathParserContext
	cur as const xmlChar ptr
	base as const xmlChar ptr
	error as long
	context as xmlXPathContextPtr
	value as xmlXPathObjectPtr
	valueNr as long
	valueMax as long
	valueTab as xmlXPathObjectPtr ptr
	comp as xmlXPathCompExprPtr
	xptr as long
	ancestor as xmlNodePtr
	valueFrame as long
end type

#if defined(__FB_WIN32__) and (not defined(LIBXML_STATIC))
	extern import xmlXPathNAN as double
	extern import xmlXPathPINF as double
	extern import xmlXPathNINF as double
#else
	extern xmlXPathNAN as double
	extern xmlXPathPINF as double
	extern xmlXPathNINF as double
#endif

#define xmlXPathNodeSetGetLength(ns) iif((ns), (ns)->nodeNr, 0)
#define xmlXPathNodeSetItem(ns, index) iif((((ns) <> NULL) andalso ((index) >= 0)) andalso ((index) < (ns)->nodeNr), (ns)->nodeTab[(index)], NULL)
#define xmlXPathNodeSetIsEmpty(ns) ((((ns) = NULL) orelse ((ns)->nodeNr = 0)) orelse ((ns)->nodeTab = NULL))

declare sub xmlXPathFreeObject(byval obj as xmlXPathObjectPtr)
declare function xmlXPathNodeSetCreate(byval val as xmlNodePtr) as xmlNodeSetPtr
declare sub xmlXPathFreeNodeSetList(byval obj as xmlXPathObjectPtr)
declare sub xmlXPathFreeNodeSet(byval obj as xmlNodeSetPtr)
declare function xmlXPathObjectCopy(byval val as xmlXPathObjectPtr) as xmlXPathObjectPtr
declare function xmlXPathCmpNodes(byval node1 as xmlNodePtr, byval node2 as xmlNodePtr) as long
declare function xmlXPathCastNumberToBoolean(byval val as double) as long
declare function xmlXPathCastStringToBoolean(byval val as const xmlChar ptr) as long
declare function xmlXPathCastNodeSetToBoolean(byval ns as xmlNodeSetPtr) as long
declare function xmlXPathCastToBoolean(byval val as xmlXPathObjectPtr) as long
declare function xmlXPathCastBooleanToNumber(byval val as long) as double
declare function xmlXPathCastStringToNumber(byval val as const xmlChar ptr) as double
declare function xmlXPathCastNodeToNumber(byval node as xmlNodePtr) as double
declare function xmlXPathCastNodeSetToNumber(byval ns as xmlNodeSetPtr) as double
declare function xmlXPathCastToNumber(byval val as xmlXPathObjectPtr) as double
declare function xmlXPathCastBooleanToString(byval val as long) as xmlChar ptr
declare function xmlXPathCastNumberToString(byval val as double) as xmlChar ptr
declare function xmlXPathCastNodeToString(byval node as xmlNodePtr) as xmlChar ptr
declare function xmlXPathCastNodeSetToString(byval ns as xmlNodeSetPtr) as xmlChar ptr
declare function xmlXPathCastToString(byval val as xmlXPathObjectPtr) as xmlChar ptr
declare function xmlXPathConvertBoolean(byval val as xmlXPathObjectPtr) as xmlXPathObjectPtr
declare function xmlXPathConvertNumber(byval val as xmlXPathObjectPtr) as xmlXPathObjectPtr
declare function xmlXPathConvertString(byval val as xmlXPathObjectPtr) as xmlXPathObjectPtr
declare function xmlXPathNewContext(byval doc as xmlDocPtr) as xmlXPathContextPtr
declare sub xmlXPathFreeContext(byval ctxt as xmlXPathContextPtr)
declare function xmlXPathContextSetCache(byval ctxt as xmlXPathContextPtr, byval active as long, byval value as long, byval options as long) as long
declare function xmlXPathOrderDocElems(byval doc as xmlDocPtr) as clong
declare function xmlXPathSetContextNode(byval node as xmlNodePtr, byval ctx as xmlXPathContextPtr) as long
declare function xmlXPathNodeEval(byval node as xmlNodePtr, byval str as const xmlChar ptr, byval ctx as xmlXPathContextPtr) as xmlXPathObjectPtr
declare function xmlXPathEval(byval str as const xmlChar ptr, byval ctx as xmlXPathContextPtr) as xmlXPathObjectPtr
declare function xmlXPathEvalExpression(byval str as const xmlChar ptr, byval ctxt as xmlXPathContextPtr) as xmlXPathObjectPtr
declare function xmlXPathEvalPredicate(byval ctxt as xmlXPathContextPtr, byval res as xmlXPathObjectPtr) as long
declare function xmlXPathCompile(byval str as const xmlChar ptr) as xmlXPathCompExprPtr
declare function xmlXPathCtxtCompile(byval ctxt as xmlXPathContextPtr, byval str as const xmlChar ptr) as xmlXPathCompExprPtr
declare function xmlXPathCompiledEval(byval comp as xmlXPathCompExprPtr, byval ctx as xmlXPathContextPtr) as xmlXPathObjectPtr
declare function xmlXPathCompiledEvalToBoolean(byval comp as xmlXPathCompExprPtr, byval ctxt as xmlXPathContextPtr) as long
declare sub xmlXPathFreeCompExpr(byval comp as xmlXPathCompExprPtr)
declare sub xmlXPathInit()
declare function xmlXPathIsNaN(byval val as double) as long
declare function xmlXPathIsInf(byval val as double) as long

end extern
