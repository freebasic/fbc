''
''
'' xpath -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __xpath_bi__
#define __xpath_bi__

#include once "libxml/xmlversion.bi"
#include once "libxml/xmlerror.bi"
#include once "libxml/tree.bi"
#include once "libxml/hash.bi"

type xmlXPathContext as _xmlXPathContext
type xmlXPathContextPtr as xmlXPathContext ptr
type xmlXPathParserContext as _xmlXPathParserContext
type xmlXPathParserContextPtr as xmlXPathParserContext ptr

enum xmlXPathError
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
end enum

type xmlNodeSet as _xmlNodeSet
type xmlNodeSetPtr as xmlNodeSet ptr

type _xmlNodeSet
	nodeNr as integer
	nodeMax as integer
	nodeTab as xmlNodePtr ptr
end type

enum xmlXPathObjectType
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
	type as xmlXPathObjectType
	nodesetval as xmlNodeSetPtr
	boolval as integer
	floatval as double
	stringval as zstring ptr
	user as any ptr
	index as integer
	user2 as any ptr
	index2 as integer
end type

type xmlXPathConvertFunc as integer ptr
type xmlXPathType as _xmlXPathType
type xmlXPathTypePtr as xmlXPathType ptr

type _xmlXPathType
	name as zstring ptr
	func as xmlXPathConvertFunc
end type

type xmlXPathVariable as _xmlXPathVariable
type xmlXPathVariablePtr as xmlXPathVariable ptr

type _xmlXPathVariable
	name as zstring ptr
	value as xmlXPathObjectPtr
end type

type xmlXPathEvalFunc as any ptr
type xmlXPathFunct as _xmlXPathFunct
type xmlXPathFuncPtr as xmlXPathFunct ptr

type _xmlXPathFunct
	name as zstring ptr
	func as xmlXPathEvalFunc
end type

type xmlXPathAxisFunc as xmlXPathObjectPtr ptr
type xmlXPathAxis as _xmlXPathAxis
type xmlXPathAxisPtr as xmlXPathAxis ptr

type _xmlXPathAxis
	name as zstring ptr
	func as xmlXPathAxisFunc
end type

type xmlXPathFunction as any ptr
type xmlXPathVariableLookupFunc as xmlXPathObjectPtr ptr
type xmlXPathFuncLookupFunc as xmlXPathFunction ptr

type _xmlXPathContext
	doc as xmlDocPtr
	node as xmlNodePtr
	nb_variables_unused as integer
	max_variables_unused as integer
	varHash as xmlHashTablePtr
	nb_types as integer
	max_types as integer
	types as xmlXPathTypePtr
	nb_funcs_unused as integer
	max_funcs_unused as integer
	funcHash as xmlHashTablePtr
	nb_axis as integer
	max_axis as integer
	axis as xmlXPathAxisPtr
	namespaces as xmlNsPtr ptr
	nsNr as integer
	user as any ptr
	contextSize as integer
	proximityPosition as integer
	xptr as integer
	here as xmlNodePtr
	origin as xmlNodePtr
	nsHash as xmlHashTablePtr
	varLookupFunc as xmlXPathVariableLookupFunc
	varLookupData as any ptr
	extra as any ptr
	function as zstring ptr
	functionURI as zstring ptr
	funcLookupFunc as xmlXPathFuncLookupFunc
	funcLookupData as any ptr
	tmpNsList as xmlNsPtr ptr
	tmpNsNr as integer
	userData as any ptr
	error as xmlStructuredErrorFunc
	lastError as xmlError
	debugNode as xmlNodePtr
	dict as xmlDictPtr
end type

type xmlXPathCompExpr as _xmlXPathCompExpr
type xmlXPathCompExprPtr as xmlXPathCompExpr ptr

type _xmlXPathParserContext
	cur as zstring ptr
	base as zstring ptr
	error as integer
	context as xmlXPathContextPtr
	value as xmlXPathObjectPtr
	valueNr as integer
	valueMax as integer
	valueTab as xmlXPathObjectPtr ptr
	comp as xmlXPathCompExprPtr
	xptr as integer
	ancestor as xmlNodePtr
end type

declare sub xmlXPathFreeObject cdecl alias "xmlXPathFreeObject" (byval obj as xmlXPathObjectPtr)
declare function xmlXPathNodeSetCreate cdecl alias "xmlXPathNodeSetCreate" (byval val as xmlNodePtr) as xmlNodeSetPtr
declare sub xmlXPathFreeNodeSetList cdecl alias "xmlXPathFreeNodeSetList" (byval obj as xmlXPathObjectPtr)
declare sub xmlXPathFreeNodeSet cdecl alias "xmlXPathFreeNodeSet" (byval obj as xmlNodeSetPtr)
declare function xmlXPathObjectCopy cdecl alias "xmlXPathObjectCopy" (byval val as xmlXPathObjectPtr) as xmlXPathObjectPtr
declare function xmlXPathCmpNodes cdecl alias "xmlXPathCmpNodes" (byval node1 as xmlNodePtr, byval node2 as xmlNodePtr) as integer
declare function xmlXPathCastNumberToBoolean cdecl alias "xmlXPathCastNumberToBoolean" (byval val as double) as integer
declare function xmlXPathCastStringToBoolean cdecl alias "xmlXPathCastStringToBoolean" (byval val as string) as integer
declare function xmlXPathCastNodeSetToBoolean cdecl alias "xmlXPathCastNodeSetToBoolean" (byval ns as xmlNodeSetPtr) as integer
declare function xmlXPathCastToBoolean cdecl alias "xmlXPathCastToBoolean" (byval val as xmlXPathObjectPtr) as integer
declare function xmlXPathCastBooleanToNumber cdecl alias "xmlXPathCastBooleanToNumber" (byval val as integer) as double
declare function xmlXPathCastStringToNumber cdecl alias "xmlXPathCastStringToNumber" (byval val as string) as double
declare function xmlXPathCastNodeToNumber cdecl alias "xmlXPathCastNodeToNumber" (byval node as xmlNodePtr) as double
declare function xmlXPathCastNodeSetToNumber cdecl alias "xmlXPathCastNodeSetToNumber" (byval ns as xmlNodeSetPtr) as double
declare function xmlXPathCastToNumber cdecl alias "xmlXPathCastToNumber" (byval val as xmlXPathObjectPtr) as double
declare function xmlXPathCastBooleanToString cdecl alias "xmlXPathCastBooleanToString" (byval val as integer) as zstring ptr
declare function xmlXPathCastNumberToString cdecl alias "xmlXPathCastNumberToString" (byval val as double) as zstring ptr
declare function xmlXPathCastNodeToString cdecl alias "xmlXPathCastNodeToString" (byval node as xmlNodePtr) as zstring ptr
declare function xmlXPathCastNodeSetToString cdecl alias "xmlXPathCastNodeSetToString" (byval ns as xmlNodeSetPtr) as zstring ptr
declare function xmlXPathCastToString cdecl alias "xmlXPathCastToString" (byval val as xmlXPathObjectPtr) as zstring ptr
declare function xmlXPathConvertBoolean cdecl alias "xmlXPathConvertBoolean" (byval val as xmlXPathObjectPtr) as xmlXPathObjectPtr
declare function xmlXPathConvertNumber cdecl alias "xmlXPathConvertNumber" (byval val as xmlXPathObjectPtr) as xmlXPathObjectPtr
declare function xmlXPathConvertString cdecl alias "xmlXPathConvertString" (byval val as xmlXPathObjectPtr) as xmlXPathObjectPtr
declare function xmlXPathNewContext cdecl alias "xmlXPathNewContext" (byval doc as xmlDocPtr) as xmlXPathContextPtr
declare sub xmlXPathFreeContext cdecl alias "xmlXPathFreeContext" (byval ctxt as xmlXPathContextPtr)
declare function xmlXPathOrderDocElems cdecl alias "xmlXPathOrderDocElems" (byval doc as xmlDocPtr) as integer
declare function xmlXPathEval cdecl alias "xmlXPathEval" (byval str as string, byval ctx as xmlXPathContextPtr) as xmlXPathObjectPtr
declare function xmlXPathEvalExpression cdecl alias "xmlXPathEvalExpression" (byval str as string, byval ctxt as xmlXPathContextPtr) as xmlXPathObjectPtr
declare function xmlXPathEvalPredicate cdecl alias "xmlXPathEvalPredicate" (byval ctxt as xmlXPathContextPtr, byval res as xmlXPathObjectPtr) as integer
declare function xmlXPathCompile cdecl alias "xmlXPathCompile" (byval str as string) as xmlXPathCompExprPtr
declare function xmlXPathCtxtCompile cdecl alias "xmlXPathCtxtCompile" (byval ctxt as xmlXPathContextPtr, byval str as string) as xmlXPathCompExprPtr
declare function xmlXPathCompiledEval cdecl alias "xmlXPathCompiledEval" (byval comp as xmlXPathCompExprPtr, byval ctx as xmlXPathContextPtr) as xmlXPathObjectPtr
declare sub xmlXPathFreeCompExpr cdecl alias "xmlXPathFreeCompExpr" (byval comp as xmlXPathCompExprPtr)
declare sub xmlXPathInit cdecl alias "xmlXPathInit" ()
declare function xmlXPathIsNaN cdecl alias "xmlXPathIsNaN" (byval val as double) as integer
declare function xmlXPathIsInf cdecl alias "xmlXPathIsInf" (byval val as double) as integer

#endif
