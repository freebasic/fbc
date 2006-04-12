''
''
'' relaxng -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#define __xml_relaxng_bi__
#define __xml_relaxng_bi__

#include once "libxml/xmlversion.bi"
#include once "libxml/hash.bi"
#include once "libxml/xmlstring.bi"

type xmlRelaxNG as _xmlRelaxNG
type xmlRelaxNGPtr as xmlRelaxNG ptr
type xmlRelaxNGValidityErrorFunc as any ptr
type xmlRelaxNGValidityWarningFunc as any ptr
type xmlRelaxNGParserCtxt as _xmlRelaxNGParserCtxt
type xmlRelaxNGParserCtxtPtr as xmlRelaxNGParserCtxt ptr
type xmlRelaxNGValidCtxt as _xmlRelaxNGValidCtxt
type xmlRelaxNGValidCtxtPtr as xmlRelaxNGValidCtxt ptr

enum xmlRelaxNGValidErr
	XML_RELAXNG_OK = 0
	XML_RELAXNG_ERR_MEMORY
	XML_RELAXNG_ERR_TYPE
	XML_RELAXNG_ERR_TYPEVAL
	XML_RELAXNG_ERR_DUPID
	XML_RELAXNG_ERR_TYPECMP
	XML_RELAXNG_ERR_NOSTATE
	XML_RELAXNG_ERR_NODEFINE
	XML_RELAXNG_ERR_LISTEXTRA
	XML_RELAXNG_ERR_LISTEMPTY
	XML_RELAXNG_ERR_INTERNODATA
	XML_RELAXNG_ERR_INTERSEQ
	XML_RELAXNG_ERR_INTEREXTRA
	XML_RELAXNG_ERR_ELEMNAME
	XML_RELAXNG_ERR_ATTRNAME
	XML_RELAXNG_ERR_ELEMNONS
	XML_RELAXNG_ERR_ATTRNONS
	XML_RELAXNG_ERR_ELEMWRONGNS
	XML_RELAXNG_ERR_ATTRWRONGNS
	XML_RELAXNG_ERR_ELEMEXTRANS
	XML_RELAXNG_ERR_ATTREXTRANS
	XML_RELAXNG_ERR_ELEMNOTEMPTY
	XML_RELAXNG_ERR_NOELEM
	XML_RELAXNG_ERR_NOTELEM
	XML_RELAXNG_ERR_ATTRVALID
	XML_RELAXNG_ERR_CONTENTVALID
	XML_RELAXNG_ERR_EXTRACONTENT
	XML_RELAXNG_ERR_INVALIDATTR
	XML_RELAXNG_ERR_DATAELEM
	XML_RELAXNG_ERR_VALELEM
	XML_RELAXNG_ERR_LISTELEM
	XML_RELAXNG_ERR_DATATYPE
	XML_RELAXNG_ERR_VALUE
	XML_RELAXNG_ERR_LIST
	XML_RELAXNG_ERR_NOGRAMMAR
	XML_RELAXNG_ERR_EXTRADATA
	XML_RELAXNG_ERR_LACKDATA
	XML_RELAXNG_ERR_INTERNAL
	XML_RELAXNG_ERR_ELEMWRONG
	XML_RELAXNG_ERR_TEXTWRONG
end enum


enum xmlRelaxNGParserFlag
	XML_RELAXNGP_NONE = 0
	XML_RELAXNGP_FREE_DOC = 1
	XML_RELAXNGP_CRNG = 2
end enum


declare function xmlRelaxNGInitTypes cdecl alias "xmlRelaxNGInitTypes" () as integer
declare sub xmlRelaxNGCleanupTypes cdecl alias "xmlRelaxNGCleanupTypes" ()
declare function xmlRelaxNGNewParserCtxt cdecl alias "xmlRelaxNGNewParserCtxt" (byval URL as zstring ptr) as xmlRelaxNGParserCtxtPtr
declare function xmlRelaxNGNewMemParserCtxt cdecl alias "xmlRelaxNGNewMemParserCtxt" (byval buffer as zstring ptr, byval size as integer) as xmlRelaxNGParserCtxtPtr
declare function xmlRelaxNGNewDocParserCtxt cdecl alias "xmlRelaxNGNewDocParserCtxt" (byval doc as xmlDocPtr) as xmlRelaxNGParserCtxtPtr
declare function xmlRelaxParserSetFlag cdecl alias "xmlRelaxParserSetFlag" (byval ctxt as xmlRelaxNGParserCtxtPtr, byval flag as integer) as integer
declare sub xmlRelaxNGFreeParserCtxt cdecl alias "xmlRelaxNGFreeParserCtxt" (byval ctxt as xmlRelaxNGParserCtxtPtr)
declare sub xmlRelaxNGSetParserErrors cdecl alias "xmlRelaxNGSetParserErrors" (byval ctxt as xmlRelaxNGParserCtxtPtr, byval err as xmlRelaxNGValidityErrorFunc, byval warn as xmlRelaxNGValidityWarningFunc, byval ctx as any ptr)
declare function xmlRelaxNGGetParserErrors cdecl alias "xmlRelaxNGGetParserErrors" (byval ctxt as xmlRelaxNGParserCtxtPtr, byval err as xmlRelaxNGValidityErrorFunc ptr, byval warn as xmlRelaxNGValidityWarningFunc ptr, byval ctx as any ptr ptr) as integer
declare function xmlRelaxNGParse cdecl alias "xmlRelaxNGParse" (byval ctxt as xmlRelaxNGParserCtxtPtr) as xmlRelaxNGPtr
declare sub xmlRelaxNGFree cdecl alias "xmlRelaxNGFree" (byval schema as xmlRelaxNGPtr)
declare sub xmlRelaxNGDump cdecl alias "xmlRelaxNGDump" (byval output as FILE ptr, byval schema as xmlRelaxNGPtr)
declare sub xmlRelaxNGDumpTree cdecl alias "xmlRelaxNGDumpTree" (byval output as FILE ptr, byval schema as xmlRelaxNGPtr)
declare sub xmlRelaxNGSetValidErrors cdecl alias "xmlRelaxNGSetValidErrors" (byval ctxt as xmlRelaxNGValidCtxtPtr, byval err as xmlRelaxNGValidityErrorFunc, byval warn as xmlRelaxNGValidityWarningFunc, byval ctx as any ptr)
declare function xmlRelaxNGGetValidErrors cdecl alias "xmlRelaxNGGetValidErrors" (byval ctxt as xmlRelaxNGValidCtxtPtr, byval err as xmlRelaxNGValidityErrorFunc ptr, byval warn as xmlRelaxNGValidityWarningFunc ptr, byval ctx as any ptr ptr) as integer
declare function xmlRelaxNGNewValidCtxt cdecl alias "xmlRelaxNGNewValidCtxt" (byval schema as xmlRelaxNGPtr) as xmlRelaxNGValidCtxtPtr
declare sub xmlRelaxNGFreeValidCtxt cdecl alias "xmlRelaxNGFreeValidCtxt" (byval ctxt as xmlRelaxNGValidCtxtPtr)
declare function xmlRelaxNGValidateDoc cdecl alias "xmlRelaxNGValidateDoc" (byval ctxt as xmlRelaxNGValidCtxtPtr, byval doc as xmlDocPtr) as integer
declare function xmlRelaxNGValidatePushElement cdecl alias "xmlRelaxNGValidatePushElement" (byval ctxt as xmlRelaxNGValidCtxtPtr, byval doc as xmlDocPtr, byval elem as xmlNodePtr) as integer
declare function xmlRelaxNGValidatePushCData cdecl alias "xmlRelaxNGValidatePushCData" (byval ctxt as xmlRelaxNGValidCtxtPtr, byval data as zstring ptr, byval len as integer) as integer
declare function xmlRelaxNGValidatePopElement cdecl alias "xmlRelaxNGValidatePopElement" (byval ctxt as xmlRelaxNGValidCtxtPtr, byval doc as xmlDocPtr, byval elem as xmlNodePtr) as integer
declare function xmlRelaxNGValidateFullElement cdecl alias "xmlRelaxNGValidateFullElement" (byval ctxt as xmlRelaxNGValidCtxtPtr, byval doc as xmlDocPtr, byval elem as xmlNodePtr) as integer

#endif
