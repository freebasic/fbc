''
''
'' SAX -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __xml_SAX_bi__
#define __xml_SAX_bi__

#include once "xmlversion.bi"
#include once "parser.bi"
#include once "xlink.bi"

extern "c"
declare function getPublicId (byval ctx as any ptr) as zstring ptr
declare function getSystemId (byval ctx as any ptr) as zstring ptr
declare sub setDocumentLocator (byval ctx as any ptr, byval loc as xmlSAXLocatorPtr)
declare function getLineNumber (byval ctx as any ptr) as integer
declare function getColumnNumber (byval ctx as any ptr) as integer
declare function isStandalone (byval ctx as any ptr) as integer
declare function hasInternalSubset (byval ctx as any ptr) as integer
declare function hasExternalSubset (byval ctx as any ptr) as integer
declare sub internalSubset (byval ctx as any ptr, byval name as zstring ptr, byval ExternalID as zstring ptr, byval SystemID as zstring ptr)
declare sub externalSubset (byval ctx as any ptr, byval name as zstring ptr, byval ExternalID as zstring ptr, byval SystemID as zstring ptr)
declare function getEntity (byval ctx as any ptr, byval name as zstring ptr) as xmlEntityPtr
declare function getParameterEntity (byval ctx as any ptr, byval name as zstring ptr) as xmlEntityPtr
declare function resolveEntity (byval ctx as any ptr, byval publicId as zstring ptr, byval systemId as zstring ptr) as xmlParserInputPtr
declare sub entityDecl (byval ctx as any ptr, byval name as zstring ptr, byval type as integer, byval publicId as zstring ptr, byval systemId as zstring ptr, byval content as zstring ptr)
declare sub attributeDecl (byval ctx as any ptr, byval elem as zstring ptr, byval fullname as zstring ptr, byval type as integer, byval def as integer, byval defaultValue as zstring ptr, byval tree as xmlEnumerationPtr)
declare sub elementDecl (byval ctx as any ptr, byval name as zstring ptr, byval type as integer, byval content as xmlElementContentPtr)
declare sub notationDecl (byval ctx as any ptr, byval name as zstring ptr, byval publicId as zstring ptr, byval systemId as zstring ptr)
declare sub unparsedEntityDecl (byval ctx as any ptr, byval name as zstring ptr, byval publicId as zstring ptr, byval systemId as zstring ptr, byval notationName as zstring ptr)
declare sub startDocument (byval ctx as any ptr)
declare sub endDocument (byval ctx as any ptr)
declare sub attribute (byval ctx as any ptr, byval fullname as zstring ptr, byval value as zstring ptr)
declare sub startElement (byval ctx as any ptr, byval fullname as zstring ptr, byval atts as zstring ptr ptr)
declare sub endElement (byval ctx as any ptr, byval name as zstring ptr)
declare sub reference (byval ctx as any ptr, byval name as zstring ptr)
declare sub characters (byval ctx as any ptr, byval ch as zstring ptr, byval len as integer)
declare sub ignorableWhitespace (byval ctx as any ptr, byval ch as zstring ptr, byval len as integer)
declare sub processingInstruction (byval ctx as any ptr, byval target as zstring ptr, byval data as zstring ptr)
declare sub globalNamespace (byval ctx as any ptr, byval href as zstring ptr, byval prefix as zstring ptr)
declare sub setNamespace (byval ctx as any ptr, byval name as zstring ptr)
declare function getNamespace (byval ctx as any ptr) as xmlNsPtr
declare function checkNamespace (byval ctx as any ptr, byval nameSpace as zstring ptr) as integer
declare sub namespaceDecl (byval ctx as any ptr, byval href as zstring ptr, byval prefix as zstring ptr)
declare sub comment (byval ctx as any ptr, byval value as zstring ptr)
declare sub cdataBlock (byval ctx as any ptr, byval value as zstring ptr, byval len as integer)
declare sub initxmlDefaultSAXHandler (byval hdlr as xmlSAXHandlerV1 ptr, byval warning as integer)
declare sub inithtmlDefaultSAXHandler (byval hdlr as xmlSAXHandlerV1 ptr)
declare sub initdocbDefaultSAXHandler (byval hdlr as xmlSAXHandlerV1 ptr)
end extern

#endif
