''
''
'' xmlschemas -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __xml_xmlschemas_bi__
#define __xml_xmlschemas_bi__

#include once "xmlversion.bi"
#include once "tree.bi"

enum xmlSchemaValidError
	XML_SCHEMAS_ERR_OK = 0
	XML_SCHEMAS_ERR_NOROOT = 1
	XML_SCHEMAS_ERR_UNDECLAREDELEM
	XML_SCHEMAS_ERR_NOTTOPLEVEL
	XML_SCHEMAS_ERR_MISSING
	XML_SCHEMAS_ERR_WRONGELEM
	XML_SCHEMAS_ERR_NOTYPE
	XML_SCHEMAS_ERR_NOROLLBACK
	XML_SCHEMAS_ERR_ISABSTRACT
	XML_SCHEMAS_ERR_NOTEMPTY
	XML_SCHEMAS_ERR_ELEMCONT
	XML_SCHEMAS_ERR_HAVEDEFAULT
	XML_SCHEMAS_ERR_NOTNILLABLE
	XML_SCHEMAS_ERR_EXTRACONTENT
	XML_SCHEMAS_ERR_INVALIDATTR
	XML_SCHEMAS_ERR_INVALIDELEM
	XML_SCHEMAS_ERR_NOTDETERMINIST
	XML_SCHEMAS_ERR_CONSTRUCT
	XML_SCHEMAS_ERR_INTERNAL
	XML_SCHEMAS_ERR_NOTSIMPLE
	XML_SCHEMAS_ERR_ATTRUNKNOWN
	XML_SCHEMAS_ERR_ATTRINVALID
	XML_SCHEMAS_ERR_VALUE
	XML_SCHEMAS_ERR_FACET
	XML_SCHEMAS_ERR_
	XML_SCHEMAS_ERR_XXX
end enum


enum xmlSchemaValidOption
	XML_SCHEMA_VAL_VC_I_CREATE = 1 shl 0
end enum

type xmlSchema as _xmlSchema
type xmlSchemaPtr as xmlSchema ptr
type xmlSchemaValidityErrorFunc as any ptr
type xmlSchemaValidityWarningFunc as any ptr
type xmlSchemaParserCtxt as _xmlSchemaParserCtxt
type xmlSchemaParserCtxtPtr as xmlSchemaParserCtxt ptr
type xmlSchemaValidCtxt as _xmlSchemaValidCtxt
type xmlSchemaValidCtxtPtr as xmlSchemaValidCtxt ptr

extern "c"
declare function xmlSchemaNewParserCtxt (byval URL as zstring ptr) as xmlSchemaParserCtxtPtr
declare function xmlSchemaNewMemParserCtxt (byval buffer as zstring ptr, byval size as integer) as xmlSchemaParserCtxtPtr
declare function xmlSchemaNewDocParserCtxt (byval doc as xmlDocPtr) as xmlSchemaParserCtxtPtr
declare sub xmlSchemaFreeParserCtxt (byval ctxt as xmlSchemaParserCtxtPtr)
declare sub xmlSchemaSetParserErrors (byval ctxt as xmlSchemaParserCtxtPtr, byval err as xmlSchemaValidityErrorFunc, byval warn as xmlSchemaValidityWarningFunc, byval ctx as any ptr)
declare function xmlSchemaGetParserErrors (byval ctxt as xmlSchemaParserCtxtPtr, byval err as xmlSchemaValidityErrorFunc ptr, byval warn as xmlSchemaValidityWarningFunc ptr, byval ctx as any ptr ptr) as integer
declare function xmlSchemaParse (byval ctxt as xmlSchemaParserCtxtPtr) as xmlSchemaPtr
declare sub xmlSchemaFree (byval schema as xmlSchemaPtr)
declare sub xmlSchemaDump (byval output as FILE ptr, byval schema as xmlSchemaPtr)
declare sub xmlSchemaSetValidErrors (byval ctxt as xmlSchemaValidCtxtPtr, byval err as xmlSchemaValidityErrorFunc, byval warn as xmlSchemaValidityWarningFunc, byval ctx as any ptr)
declare function xmlSchemaGetValidErrors (byval ctxt as xmlSchemaValidCtxtPtr, byval err as xmlSchemaValidityErrorFunc ptr, byval warn as xmlSchemaValidityWarningFunc ptr, byval ctx as any ptr ptr) as integer
declare function xmlSchemaSetValidOptions (byval ctxt as xmlSchemaValidCtxtPtr, byval options as integer) as integer
declare function xmlSchemaValidCtxtGetOptions (byval ctxt as xmlSchemaValidCtxtPtr) as integer
declare function xmlSchemaNewValidCtxt (byval schema as xmlSchemaPtr) as xmlSchemaValidCtxtPtr
declare sub xmlSchemaFreeValidCtxt (byval ctxt as xmlSchemaValidCtxtPtr)
declare function xmlSchemaValidateDoc (byval ctxt as xmlSchemaValidCtxtPtr, byval instance as xmlDocPtr) as integer
declare function xmlSchemaValidateOneElement (byval ctxt as xmlSchemaValidCtxtPtr, byval elem as xmlNodePtr) as integer
declare function xmlSchemaValidateStream (byval ctxt as xmlSchemaValidCtxtPtr, byval input as xmlParserInputBufferPtr, byval enc as xmlCharEncoding, byval sax as xmlSAXHandlerPtr, byval user_data as any ptr) as integer
end extern

#endif
