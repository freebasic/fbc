'' FreeBASIC binding for libxslt-1.1.28
''
'' based on the C header files:
''    Copyright (C) 2001-2002 Daniel Veillard.  All Rights Reserved.
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
''   DANIEL VEILLARD BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
''   IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CON-
''   NECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
''
''   Except as contained in this notice, the name of Daniel Veillard shall not
''   be used in advertising or otherwise to promote the sale, use or other deal-
''   ings in this Software without prior written authorization from him.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/long.bi"
#include once "libxml/tree.bi"
#include once "libxml/hash.bi"
#include once "libxml/xpath.bi"
#include once "libxml/xmlerror.bi"
#include once "libxml/dict.bi"
#include once "libxml/xmlstring.bi"
#include once "libxslt/xslt.bi"
#include once "xsltexports.bi"
#include once "xsltlocale.bi"
#include once "numbersInternals.bi"

extern "C"

#define __XML_XSLT_INTERNALS_H__
#define XSLT_IS_TEXT_NODE(n) ((n <> NULL) andalso (((n)->type = XML_TEXT_NODE) orelse ((n)->type = XML_CDATA_SECTION_NODE)))
#define XSLT_MARK_RES_TREE_FRAG(n) scope : (n)->name = cptr(zstring ptr, xmlStrdup(" fake node libxslt")) : end scope
#define XSLT_IS_RES_TREE_FRAG(n) ((((n <> NULL) andalso ((n)->type = XML_DOCUMENT_NODE)) andalso ((n)->name <> NULL)) andalso ((n)->name[0] = asc(" ")))
#define XSLT_REFACTORED_KEYCOMP
#define XSLT_FAST_IF
#define XSLT_REFACTORED_VARS
const XSLT_MAX_SORT = 15
const XSLT_PAT_NO_PRIORITY = -12345789
type xsltRuntimeExtra as _xsltRuntimeExtra
type xsltRuntimeExtraPtr as xsltRuntimeExtra ptr

union _xsltRuntimeExtra_val
	ptr as any ptr
	ival as long
end union

type _xsltRuntimeExtra
	info as any ptr
	deallocate as xmlFreeFunc
	val as _xsltRuntimeExtra_val
end type

#define XSLT_RUNTIME_EXTRA_LST(ctxt, nr) (ctxt)->extras[(nr)].info
#define XSLT_RUNTIME_EXTRA_FREE(ctxt, nr) (ctxt)->extras[(nr)].deallocate
#define XSLT_RUNTIME_EXTRA(ctxt, nr, typ) (ctxt)->extras[(nr)].val.typ

type xsltTemplate as _xsltTemplate
type xsltTemplatePtr as xsltTemplate ptr
type _xsltStylesheet as _xsltStylesheet_

type _xsltTemplate
	next as _xsltTemplate ptr
	style as _xsltStylesheet ptr
	match as xmlChar ptr
	priority as single
	name as const xmlChar ptr
	nameURI as const xmlChar ptr
	mode as const xmlChar ptr
	modeURI as const xmlChar ptr
	content as xmlNodePtr
	elem as xmlNodePtr
	inheritedNsNr as long
	inheritedNs as xmlNsPtr ptr
	nbCalls as long
	time as culong
	params as any ptr
	templNr as long
	templMax as long
	templCalledTab as xsltTemplatePtr ptr
	templCountTab as long ptr
end type

type xsltDecimalFormat as _xsltDecimalFormat
type xsltDecimalFormatPtr as xsltDecimalFormat ptr

type _xsltDecimalFormat
	next as _xsltDecimalFormat ptr
	name as xmlChar ptr
	digit as xmlChar ptr
	patternSeparator as xmlChar ptr
	minusSign as xmlChar ptr
	infinity as xmlChar ptr
	noNumber as xmlChar ptr
	decimalPoint as xmlChar ptr
	grouping as xmlChar ptr
	percent as xmlChar ptr
	permille as xmlChar ptr
	zeroDigit as xmlChar ptr
end type

type xsltDocument as _xsltDocument
type xsltDocumentPtr as xsltDocument ptr

type _xsltDocument
	next as _xsltDocument ptr
	main as long
	doc as xmlDocPtr
	keys as any ptr
	includes as _xsltDocument ptr
	preproc as long
	nbKeysComputed as long
end type

type xsltKeyDef as _xsltKeyDef
type xsltKeyDefPtr as xsltKeyDef ptr

type _xsltKeyDef
	next as _xsltKeyDef ptr
	inst as xmlNodePtr
	name as xmlChar ptr
	nameURI as xmlChar ptr
	match as xmlChar ptr
	use as xmlChar ptr
	comp as xmlXPathCompExprPtr
	usecomp as xmlXPathCompExprPtr
	nsList as xmlNsPtr ptr
	nsNr as long
end type

type xsltKeyTable as _xsltKeyTable
type xsltKeyTablePtr as xsltKeyTable ptr

type _xsltKeyTable
	next as _xsltKeyTable ptr
	name as xmlChar ptr
	nameURI as xmlChar ptr
	keys as xmlHashTablePtr
end type

type xsltStylesheet as _xsltStylesheet
type xsltStylesheetPtr as xsltStylesheet ptr
type xsltTransformContext as _xsltTransformContext
type xsltTransformContextPtr as xsltTransformContext ptr
type xsltElemPreComp as _xsltElemPreComp
type xsltElemPreCompPtr as xsltElemPreComp ptr
type xsltTransformFunction as sub(byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval inst as xmlNodePtr, byval comp as xsltElemPreCompPtr)
type xsltSortFunc as sub(byval ctxt as xsltTransformContextPtr, byval sorts as xmlNodePtr ptr, byval nbsorts as long)

type xsltStyleType as long
enum
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

type xsltElemPreCompDeallocator as sub(byval comp as xsltElemPreCompPtr)

type _xsltElemPreComp
	next as xsltElemPreCompPtr
	as xsltStyleType type
	func as xsltTransformFunction
	inst as xmlNodePtr
	free as xsltElemPreCompDeallocator
end type

type xsltStylePreComp as _xsltStylePreComp
type xsltStylePreCompPtr as xsltStylePreComp ptr

type _xsltStylePreComp
	next as xsltElemPreCompPtr
	as xsltStyleType type
	func as xsltTransformFunction
	inst as xmlNodePtr
	stype as const xmlChar ptr
	has_stype as long
	number as long
	order as const xmlChar ptr
	has_order as long
	descending as long
	lang as const xmlChar ptr
	has_lang as long
	locale as xsltLocale
	case_order as const xmlChar ptr
	lower_first as long
	use as const xmlChar ptr
	has_use as long
	noescape as long
	name as const xmlChar ptr
	has_name as long
	ns as const xmlChar ptr
	has_ns as long
	mode as const xmlChar ptr
	modeURI as const xmlChar ptr
	test as const xmlChar ptr
	templ as xsltTemplatePtr
	select as const xmlChar ptr
	ver11 as long
	filename as const xmlChar ptr
	has_filename as long
	numdata as xsltNumberData
	comp as xmlXPathCompExprPtr
	nsList as xmlNsPtr ptr
	nsNr as long
end type

type xsltStackElem as _xsltStackElem
type xsltStackElemPtr as xsltStackElem ptr

type _xsltStackElem
	next as _xsltStackElem ptr
	comp as xsltStylePreCompPtr
	computed as long
	name as const xmlChar ptr
	nameURI as const xmlChar ptr
	select as const xmlChar ptr
	tree as xmlNodePtr
	value as xmlXPathObjectPtr
	fragment as xmlDocPtr
	level as long
	context as xsltTransformContextPtr
	flags as long
end type

type _xsltStylesheet_
	parent as _xsltStylesheet ptr
	next as _xsltStylesheet ptr
	imports as _xsltStylesheet ptr
	docList as xsltDocumentPtr
	doc as xmlDocPtr
	stripSpaces as xmlHashTablePtr
	stripAll as long
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
	method as xmlChar ptr
	methodURI as xmlChar ptr
	version as xmlChar ptr
	encoding as xmlChar ptr
	omitXmlDeclaration as long
	decimalFormat as xsltDecimalFormatPtr
	standalone as long
	doctypePublic as xmlChar ptr
	doctypeSystem as xmlChar ptr
	indent as long
	mediaType as xmlChar ptr
	preComps as xsltElemPreCompPtr
	warnings as long
	errors as long
	exclPrefix as xmlChar ptr
	exclPrefixTab as xmlChar ptr ptr
	exclPrefixNr as long
	exclPrefixMax as long
	_private as any ptr
	extInfos as xmlHashTablePtr
	extrasNr as long
	includes as xsltDocumentPtr
	dict as xmlDictPtr
	attVTs as any ptr
	defaultAlias as const xmlChar ptr
	nopreproc as long
	internalized as long
	literal_result as long
	principal as xsltStylesheetPtr
	forwards_compatible as long
end type

type xsltTransformCache as _xsltTransformCache
type xsltTransformCachePtr as xsltTransformCache ptr

type _xsltTransformCache
	RVT as xmlDocPtr
	nbRVT as long
	stackItems as xsltStackElemPtr
	nbStackItems as long
end type

type xsltOutputType as long
enum
	XSLT_OUTPUT_XML = 0
	XSLT_OUTPUT_HTML
	XSLT_OUTPUT_TEXT
end enum

type xsltTransformState as long
enum
	XSLT_STATE_OK = 0
	XSLT_STATE_ERROR
	XSLT_STATE_STOPPED
end enum

type _xsltTransformContext
	style as xsltStylesheetPtr
	as xsltOutputType type
	templ as xsltTemplatePtr
	templNr as long
	templMax as long
	templTab as xsltTemplatePtr ptr
	vars as xsltStackElemPtr
	varsNr as long
	varsMax as long
	varsTab as xsltStackElemPtr ptr
	varsBase as long
	extFunctions as xmlHashTablePtr
	extElements as xmlHashTablePtr
	extInfos as xmlHashTablePtr
	mode as const xmlChar ptr
	modeURI as const xmlChar ptr
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
	xinclude as long
	outputFile as const zstring ptr
	profile as long
	prof as clong
	profNr as long
	profMax as long
	profTab as clong ptr
	_private as any ptr
	extrasNr as long
	extrasMax as long
	extras as xsltRuntimeExtraPtr
	styleList as xsltDocumentPtr
	sec as any ptr
	error as xmlGenericErrorFunc
	errctx as any ptr
	sortfunc as xsltSortFunc
	tmpRVT as xmlDocPtr
	persistRVT as xmlDocPtr
	ctxtflags as long
	lasttext as const xmlChar ptr
	lasttsize as ulong
	lasttuse as ulong
	debugStatus as long
	traceCode as culong ptr
	parserOptions as long
	dict as xmlDictPtr
	tmpDoc as xmlDocPtr
	internalized as long
	nbKeys as long
	hasTemplKeyPatterns as long
	currentTemplateRule as xsltTemplatePtr
	initialContextNode as xmlNodePtr
	initialContextDoc as xmlDocPtr
	cache as xsltTransformCachePtr
	contextVariable as any ptr
	localRVT as xmlDocPtr
	localRVTBase as xmlDocPtr
	keyInitLevel as long
	funcLevel as long
	maxTemplateDepth as long
	maxTemplateVars as long
end type

#macro CHECK_STOPPED
	if ctxt->state = XSLT_STATE_STOPPED then
		return
	end if
#endmacro
#macro CHECK_STOPPEDE
	if ctxt->state = XSLT_STATE_STOPPED then
		goto error
	end if
#endmacro
#macro CHECK_STOPPED0
	if ctxt->state = XSLT_STATE_STOPPED then
		return 0
	end if
#endmacro

declare function xsltNewStylesheet() as xsltStylesheetPtr
declare function xsltParseStylesheetFile(byval filename as const xmlChar ptr) as xsltStylesheetPtr
declare sub xsltFreeStylesheet(byval style as xsltStylesheetPtr)
declare function xsltIsBlank(byval str as xmlChar ptr) as long
declare sub xsltFreeStackElemList(byval elem as xsltStackElemPtr)
declare function xsltDecimalFormatGetByName(byval style as xsltStylesheetPtr, byval name as xmlChar ptr) as xsltDecimalFormatPtr
declare function xsltParseStylesheetProcess(byval ret as xsltStylesheetPtr, byval doc as xmlDocPtr) as xsltStylesheetPtr
declare sub xsltParseStylesheetOutput(byval style as xsltStylesheetPtr, byval cur as xmlNodePtr)
declare function xsltParseStylesheetDoc(byval doc as xmlDocPtr) as xsltStylesheetPtr
declare function xsltParseStylesheetImportedDoc(byval doc as xmlDocPtr, byval style as xsltStylesheetPtr) as xsltStylesheetPtr
declare function xsltLoadStylesheetPI(byval doc as xmlDocPtr) as xsltStylesheetPtr
declare sub xsltNumberFormat(byval ctxt as xsltTransformContextPtr, byval data as xsltNumberDataPtr, byval node as xmlNodePtr)
declare function xsltFormatNumberConversion(byval self as xsltDecimalFormatPtr, byval format as xmlChar ptr, byval number as double, byval result as xmlChar ptr ptr) as xmlXPathError
declare sub xsltParseTemplateContent(byval style as xsltStylesheetPtr, byval templ as xmlNodePtr)
declare function xsltAllocateExtra(byval style as xsltStylesheetPtr) as long
declare function xsltAllocateExtraCtxt(byval ctxt as xsltTransformContextPtr) as long
declare function xsltCreateRVT(byval ctxt as xsltTransformContextPtr) as xmlDocPtr
declare function xsltRegisterTmpRVT(byval ctxt as xsltTransformContextPtr, byval RVT as xmlDocPtr) as long
declare function xsltRegisterLocalRVT(byval ctxt as xsltTransformContextPtr, byval RVT as xmlDocPtr) as long
declare function xsltRegisterPersistRVT(byval ctxt as xsltTransformContextPtr, byval RVT as xmlDocPtr) as long
declare function xsltExtensionInstructionResultRegister(byval ctxt as xsltTransformContextPtr, byval obj as xmlXPathObjectPtr) as long
declare function xsltExtensionInstructionResultFinalize(byval ctxt as xsltTransformContextPtr) as long
declare sub xsltFreeRVTs(byval ctxt as xsltTransformContextPtr)
declare sub xsltReleaseRVT(byval ctxt as xsltTransformContextPtr, byval RVT as xmlDocPtr)
declare sub xsltCompileAttr(byval style as xsltStylesheetPtr, byval attr as xmlAttrPtr)
declare function xsltEvalAVT(byval ctxt as xsltTransformContextPtr, byval avt as any ptr, byval node as xmlNodePtr) as xmlChar ptr
declare sub xsltFreeAVTList(byval avt as any ptr)
declare sub xsltUninit()
declare function xsltInitCtxtKey(byval ctxt as xsltTransformContextPtr, byval doc as xsltDocumentPtr, byval keyd as xsltKeyDefPtr) as long
declare function xsltInitAllDocKeys(byval ctxt as xsltTransformContextPtr) as long

end extern
