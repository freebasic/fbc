''
''
'' SAX2 -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __xml_SAX2_bi__
#define __xml_SAX2_bi__

#include once "xmlversion.bi"
#include once "parser.bi"
#include once "xlink.bi"

extern "c"
declare function xmlSAX2GetPublicId (byval ctx as any ptr) as zstring ptr
declare function xmlSAX2GetSystemId (byval ctx as any ptr) as zstring ptr
declare sub xmlSAX2SetDocumentLocator (byval ctx as any ptr, byval loc as xmlSAXLocatorPtr)
declare function xmlSAX2GetLineNumber (byval ctx as any ptr) as integer
declare function xmlSAX2GetColumnNumber (byval ctx as any ptr) as integer
declare function xmlSAX2IsStandalone (byval ctx as any ptr) as integer
declare function xmlSAX2HasInternalSubset (byval ctx as any ptr) as integer
declare function xmlSAX2HasExternalSubset (byval ctx as any ptr) as integer
declare sub xmlSAX2InternalSubset (byval ctx as any ptr, byval name as zstring ptr, byval ExternalID as zstring ptr, byval SystemID as zstring ptr)
declare sub xmlSAX2ExternalSubset (byval ctx as any ptr, byval name as zstring ptr, byval ExternalID as zstring ptr, byval SystemID as zstring ptr)
declare function xmlSAX2GetEntity (byval ctx as any ptr, byval name as zstring ptr) as xmlEntityPtr
declare function xmlSAX2GetParameterEntity (byval ctx as any ptr, byval name as zstring ptr) as xmlEntityPtr
declare function xmlSAX2ResolveEntity (byval ctx as any ptr, byval publicId as zstring ptr, byval systemId as zstring ptr) as xmlParserInputPtr
declare sub xmlSAX2EntityDecl (byval ctx as any ptr, byval name as zstring ptr, byval type as integer, byval publicId as zstring ptr, byval systemId as zstring ptr, byval content as zstring ptr)
declare sub xmlSAX2AttributeDecl (byval ctx as any ptr, byval elem as zstring ptr, byval fullname as zstring ptr, byval type as integer, byval def as integer, byval defaultValue as zstring ptr, byval tree as xmlEnumerationPtr)
declare sub xmlSAX2ElementDecl (byval ctx as any ptr, byval name as zstring ptr, byval type as integer, byval content as xmlElementContentPtr)
declare sub xmlSAX2NotationDecl (byval ctx as any ptr, byval name as zstring ptr, byval publicId as zstring ptr, byval systemId as zstring ptr)
declare sub xmlSAX2UnparsedEntityDecl (byval ctx as any ptr, byval name as zstring ptr, byval publicId as zstring ptr, byval systemId as zstring ptr, byval notationName as zstring ptr)
declare sub xmlSAX2StartDocument (byval ctx as any ptr)
declare sub xmlSAX2EndDocument (byval ctx as any ptr)
declare sub xmlSAX2StartElement (byval ctx as any ptr, byval fullname as zstring ptr, byval atts as zstring ptr ptr)
declare sub xmlSAX2EndElement (byval ctx as any ptr, byval name as zstring ptr)
declare sub xmlSAX2StartElementNs (byval ctx as any ptr, byval localname as zstring ptr, byval prefix as zstring ptr, byval URI as zstring ptr, byval nb_namespaces as integer, byval namespaces as zstring ptr ptr, byval nb_attributes as integer, byval nb_defaulted as integer, byval attributes as zstring ptr ptr)
declare sub xmlSAX2EndElementNs (byval ctx as any ptr, byval localname as zstring ptr, byval prefix as zstring ptr, byval URI as zstring ptr)
declare sub xmlSAX2Reference (byval ctx as any ptr, byval name as zstring ptr)
declare sub xmlSAX2Characters (byval ctx as any ptr, byval ch as zstring ptr, byval len as integer)
declare sub xmlSAX2IgnorableWhitespace (byval ctx as any ptr, byval ch as zstring ptr, byval len as integer)
declare sub xmlSAX2ProcessingInstruction (byval ctx as any ptr, byval target as zstring ptr, byval data as zstring ptr)
declare sub xmlSAX2Comment (byval ctx as any ptr, byval value as zstring ptr)
declare sub xmlSAX2CDataBlock (byval ctx as any ptr, byval value as zstring ptr, byval len as integer)
declare function xmlSAXDefaultVersion (byval version as integer) as integer
declare function xmlSAXVersion (byval hdlr as xmlSAXHandler ptr, byval version as integer) as integer
declare sub xmlSAX2InitDefaultSAXHandler (byval hdlr as xmlSAXHandler ptr, byval warning as integer)
declare sub xmlSAX2InitHtmlDefaultSAXHandler (byval hdlr as xmlSAXHandler ptr)
declare sub htmlDefaultSAXHandlerInit ()
declare sub xmlSAX2InitDocbDefaultSAXHandler (byval hdlr as xmlSAXHandler ptr)
declare sub docbDefaultSAXHandlerInit ()
declare sub xmlDefaultSAXHandlerInit ()
end extern

#endif
