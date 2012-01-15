''
''
'' xsltInternals -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __xslt_xsltInternals_bi__
#define __xslt_xsltInternals_bi__

#include once "xsltexports.bi"
#include once "numbersInternals.bi"
#include once "xslt.bi"
#include once "libxml/tree.bi"
#include once "libxml/hash.bi"
#include once "libxml/xpath.bi"
#include once "libxml/xmlerror.bi"
#include once "libxml/dict.bi"

#define XSLT_MAX_SORT 15
#define XSLT_PAT_NO_PRIORITY -12345789

type xsltStylesheet as _xsltStylesheet
type xsltStylesheetPtr as xsltStylesheet ptr

type xsltRuntimeExtra as _xsltRuntimeExtra
type xsltRuntimeExtraPtr as xsltRuntimeExtra ptr

union _xsltRuntimeExtra_val
	ptr as any ptr
	ival as integer
end union

type _xsltRuntimeExtra
	info as any ptr
	deallocate as xmlFreeFunc
	val as _xsltRuntimeExtra_val
end type

type xsltTemplate as _xsltTemplate
type xsltTemplatePtr as xsltTemplate ptr

type _xsltTemplate
	next as _xsltTemplate ptr
	style as xsltStylesheet ptr
	match as zstring ptr
	priority as single
	name as zstring ptr
	nameURI as zstring ptr
	mode as zstring ptr
	modeURI as zstring ptr
	content as xmlNodePtr
	elem as xmlNodePtr
	inheritedNsNr as integer
	inheritedNs as xmlNsPtr ptr
	nbCalls as integer
	time as uinteger
end type

type xsltDecimalFormat as _xsltDecimalFormat
type xsltDecimalFormatPtr as xsltDecimalFormat ptr

type _xsltDecimalFormat
	next as _xsltDecimalFormat ptr
	name as zstring ptr
	digit as zstring ptr
	patternSeparator as zstring ptr
	minusSign as zstring ptr
	infinity as zstring ptr
	noNumber as zstring ptr
	decimalPoint as zstring ptr
	grouping as zstring ptr
	percent as zstring ptr
	permille as zstring ptr
	zeroDigit as zstring ptr
end type

type xsltDocument as _xsltDocument
type xsltDocumentPtr as xsltDocument ptr

type _xsltDocument
	next as _xsltDocument ptr
	main as integer
	doc as xmlDocPtr
	keys as any ptr
	includes as _xsltDocument ptr
	preproc as integer
end type

type xsltTransformContext as _xsltTransformContext
type xsltTransformContextPtr as xsltTransformContext ptr
type xsltElemPreComp as _xsltElemPreComp
type xsltElemPreCompPtr as xsltElemPreComp ptr
type xsltTransformFunction as sub cdecl(byval as xsltTransformContextPtr, byval as xmlNodePtr, byval as xmlNodePtr, byval as xsltElemPreCompPtr)
type xsltSortFunc as sub cdecl(byval as xsltTransformContextPtr, byval as xmlNodePtr ptr, byval as integer)

enum xsltStyleType
	XSLT_FUNC_COPY = 1
	XSLT_FUNC_SORT
	XSLT_FUNC_TEXT
	XSLT_FUNC_ELEMENT
	XSLT_FUNC_ATTRIBUTE
	XSLT_FUNC_COMMENT
	XSLT_FUNC_PI
	XSLT_FUNC_COPYOF
	XSLT_FUNC_VALUEOF
	XSLT_FUNC_NUMBER
	XSLT_FUNC_APPLYIMPORTS
	XSLT_FUNC_CALLTEMPLATE
	XSLT_FUNC_APPLYTEMPLATES
	XSLT_FUNC_CHOOSE
	XSLT_FUNC_IF
	XSLT_FUNC_FOREACH
	XSLT_FUNC_DOCUMENT
	XSLT_FUNC_WITHPARAM
	XSLT_FUNC_PARAM
	XSLT_FUNC_VARIABLE
	XSLT_FUNC_WHEN
	XSLT_FUNC_EXTENSION
end enum

type xsltElemPreCompDeallocator as sub cdecl(byval as xsltElemPreCompPtr)

type _xsltElemPreComp
	next as xsltElemPreCompPtr
	type as xsltStyleType
	func as xsltTransformFunction
	inst as xmlNodePtr
	free as xsltElemPreCompDeallocator
end type

type xsltStylePreComp as _xsltStylePreComp
type xsltStylePreCompPtr as xsltStylePreComp ptr

type _xsltStylePreComp
	next as xsltElemPreCompPtr
	type as xsltStyleType
	func as xsltTransformFunction
	inst as xmlNodePtr
	stype as zstring ptr
	has_stype as integer
	number as integer
	order as zstring ptr
	has_order as integer
	descending as integer
	lang as zstring ptr
	has_lang as integer
	case_order as zstring ptr
	lower_first as integer
	use as zstring ptr
	has_use as integer
	noescape as integer
	name as zstring ptr
	has_name as integer
	ns as zstring ptr
	has_ns as integer
	mode as zstring ptr
	modeURI as zstring ptr
	test as zstring ptr
	templ as xsltTemplatePtr
	select as zstring ptr
	ver11 as integer
	filename as zstring ptr
	has_filename as integer
	numdata as xsltNumberData
	comp as xmlXPathCompExprPtr
	nsList as xmlNsPtr ptr
	nsNr as integer
end type

type xsltStackElem as _xsltStackElem
type xsltStackElemPtr as xsltStackElem ptr

type _xsltStackElem
	next as _xsltStackElem ptr
	comp as xsltStylePreCompPtr
	computed as integer
	name as zstring ptr
	nameURI as zstring ptr
	select as zstring ptr
	tree as xmlNodePtr
	value as xmlXPathObjectPtr
end type

type _xsltStylesheet
	parent as _xsltStylesheet ptr
	next as _xsltStylesheet ptr
	imports as _xsltStylesheet ptr
	docList as xsltDocumentPtr
	doc as xmlDocPtr
	stripSpaces as xmlHashTablePtr
	stripAll as integer
	cdataSection as xmlHashTablePtr
	variables as xsltStackElemPtr
	templates as xsltTemplatePtr
	templatesHash as any ptr
	rootMatch as any ptr
	keyMatch as any ptr
	elemMatch as any ptr
	attrMatch as any ptr
	parentMatch as any ptr
	textMatch as any ptr
	piMatch as any ptr
	commentMatch as any ptr
	nsAliases as xmlHashTablePtr
	attributeSets as xmlHashTablePtr
	nsHash as xmlHashTablePtr
	nsDefs as any ptr
	keys as any ptr
	method as zstring ptr
	methodURI as zstring ptr
	version as zstring ptr
	encoding as zstring ptr
	omitXmlDeclaration as integer
	decimalFormat as xsltDecimalFormatPtr
	standalone as integer
	doctypePublic as zstring ptr
	doctypeSystem as zstring ptr
	indent as integer
	mediaType as zstring ptr
	preComps as xsltElemPreCompPtr
	warnings as integer
	errors as integer
	exclPrefix as zstring ptr
	exclPrefixTab as zstring ptr ptr
	exclPrefixNr as integer
	exclPrefixMax as integer
	_private as any ptr
	extInfos as xmlHashTablePtr
	extrasNr as integer
	includes as xsltDocumentPtr
	dict as xmlDictPtr
	attVTs as any ptr
	defaultAlias as zstring ptr
	nopreproc as integer
	internalized as integer
end type

enum xsltOutputType
	XSLT_OUTPUT_XML = 0
	XSLT_OUTPUT_HTML
	XSLT_OUTPUT_TEXT
end enum


enum xsltTransformState
	XSLT_STATE_OK = 0
	XSLT_STATE_ERROR
	XSLT_STATE_STOPPED
end enum


type _xsltTransformContext
	style as xsltStylesheetPtr
	type as xsltOutputType
	templ as xsltTemplatePtr
	templNr as integer
	templMax as integer
	templTab as xsltTemplatePtr ptr
	vars as xsltStackElemPtr
	varsNr as integer
	varsMax as integer
	varsTab as xsltStackElemPtr ptr
	varsBase as integer
	extFunctions as xmlHashTablePtr
	extElements as xmlHashTablePtr
	extInfos as xmlHashTablePtr
	mode as zstring ptr
	modeURI as zstring ptr
	docList as xsltDocumentPtr
	document as xsltDocumentPtr
	node as xmlNodePtr
	nodeList as xmlNodeSetPtr
	output as xmlDocPtr
	insert as xmlNodePtr
	xpathCtxt as xmlXPathContextPtr
	state as xsltTransformState
	globalVars as xmlHashTablePtr
	inst as xmlNodePtr
	xinclude as integer
	outputFile as zstring ptr
	profile as integer
	prof as integer
	profNr as integer
	profMax as integer
	profTab as integer ptr
	_private as any ptr
	extrasNr as integer
	extrasMax as integer
	extras as xsltRuntimeExtraPtr
	styleList as xsltDocumentPtr
	sec as any ptr
	error as xmlGenericErrorFunc
	errctx as any ptr
	sortfunc as xsltSortFunc
	tmpRVT as xmlDocPtr
	persistRVT as xmlDocPtr
	ctxtflags as integer
	lasttext as zstring ptr
	lasttsize as uinteger
	lasttuse as uinteger
	debugStatus as integer
	traceCode as uinteger ptr
	parserOptions as integer
	dict as xmlDictPtr
	tmpDoc as xmlDocPtr
	internalized as integer
end type

extern "c"
declare function xsltNewStylesheet () as xsltStylesheetPtr
declare function xsltParseStylesheetFile (byval filename as zstring ptr) as xsltStylesheetPtr
declare sub xsltFreeStylesheet (byval sheet as xsltStylesheetPtr)
declare function xsltIsBlank (byval str as zstring ptr) as integer
declare sub xsltFreeStackElemList (byval elem as xsltStackElemPtr)
declare function xsltDecimalFormatGetByName (byval sheet as xsltStylesheetPtr, byval name as zstring ptr) as xsltDecimalFormatPtr
declare function xsltParseStylesheetProcess (byval ret as xsltStylesheetPtr, byval doc as xmlDocPtr) as xsltStylesheetPtr
declare sub xsltParseStylesheetOutput (byval style as xsltStylesheetPtr, byval cur as xmlNodePtr)
declare function xsltParseStylesheetDoc (byval doc as xmlDocPtr) as xsltStylesheetPtr
declare function xsltParseStylesheetImportedDoc (byval doc as xmlDocPtr, byval style as xsltStylesheetPtr) as xsltStylesheetPtr
declare function xsltLoadStylesheetPI (byval doc as xmlDocPtr) as xsltStylesheetPtr
declare sub xsltNumberFormat (byval ctxt as xsltTransformContextPtr, byval data as xsltNumberDataPtr, byval node as xmlNodePtr)
declare function xsltFormatNumberConversion (byval self as xsltDecimalFormatPtr, byval format as zstring ptr, byval number as double, byval result as zstring ptr) as xmlXPathError
declare sub xsltParseTemplateContent (byval style as xsltStylesheetPtr, byval templ as xmlNodePtr)
declare function xsltAllocateExtra (byval style as xsltStylesheetPtr) as integer
declare function xsltAllocateExtraCtxt (byval ctxt as xsltTransformContextPtr) as integer
declare function xsltCreateRVT (byval ctxt as xsltTransformContextPtr) as xmlDocPtr
declare function xsltRegisterTmpRVT (byval ctxt as xsltTransformContextPtr, byval RVT as xmlDocPtr) as integer
declare function xsltRegisterPersistRVT (byval ctxt as xsltTransformContextPtr, byval RVT as xmlDocPtr) as integer
declare sub xsltFreeRVTs (byval ctxt as xsltTransformContextPtr)
declare sub xsltCompileAttr (byval style as xsltStylesheetPtr, byval attr as xmlAttrPtr)
declare function xsltEvalAVT (byval ctxt as xsltTransformContextPtr, byval avt as any ptr, byval node as xmlNodePtr) as zstring ptr
declare sub xsltFreeAVTList (byval avt as any ptr)
end extern

#endif
