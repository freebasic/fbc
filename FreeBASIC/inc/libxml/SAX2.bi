''
''
'' SAX2 -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __SAX2_bi__
#define __SAX2_bi__

#include once "libxml/xmlversion.bi"
#include once "libxml/parser.bi"
#include once "libxml/xlink.bi"

declare function xmlSAX2GetPublicId cdecl alias "xmlSAX2GetPublicId" (byval ctx as any ptr) as xmlChar ptr
declare function xmlSAX2GetSystemId cdecl alias "xmlSAX2GetSystemId" (byval ctx as any ptr) as xmlChar ptr
declare sub xmlSAX2SetDocumentLocator cdecl alias "xmlSAX2SetDocumentLocator" (byval ctx as any ptr, byval loc as xmlSAXLocatorPtr)
declare function xmlSAX2GetLineNumber cdecl alias "xmlSAX2GetLineNumber" (byval ctx as any ptr) as integer
declare function xmlSAX2GetColumnNumber cdecl alias "xmlSAX2GetColumnNumber" (byval ctx as any ptr) as integer
declare function xmlSAX2IsStandalone cdecl alias "xmlSAX2IsStandalone" (byval ctx as any ptr) as integer
declare function xmlSAX2HasInternalSubset cdecl alias "xmlSAX2HasInternalSubset" (byval ctx as any ptr) as integer
declare function xmlSAX2HasExternalSubset cdecl alias "xmlSAX2HasExternalSubset" (byval ctx as any ptr) as integer
declare sub xmlSAX2InternalSubset cdecl alias "xmlSAX2InternalSubset" (byval ctx as any ptr, byval name as xmlChar ptr, byval ExternalID as xmlChar ptr, byval SystemID as xmlChar ptr)
declare sub xmlSAX2ExternalSubset cdecl alias "xmlSAX2ExternalSubset" (byval ctx as any ptr, byval name as xmlChar ptr, byval ExternalID as xmlChar ptr, byval SystemID as xmlChar ptr)
declare function xmlSAX2GetEntity cdecl alias "xmlSAX2GetEntity" (byval ctx as any ptr, byval name as xmlChar ptr) as xmlEntityPtr
declare function xmlSAX2GetParameterEntity cdecl alias "xmlSAX2GetParameterEntity" (byval ctx as any ptr, byval name as xmlChar ptr) as xmlEntityPtr
declare function xmlSAX2ResolveEntity cdecl alias "xmlSAX2ResolveEntity" (byval ctx as any ptr, byval publicId as xmlChar ptr, byval systemId as xmlChar ptr) as xmlParserInputPtr
declare sub xmlSAX2EntityDecl cdecl alias "xmlSAX2EntityDecl" (byval ctx as any ptr, byval name as xmlChar ptr, byval type as integer, byval publicId as xmlChar ptr, byval systemId as xmlChar ptr, byval content as xmlChar ptr)
declare sub xmlSAX2AttributeDecl cdecl alias "xmlSAX2AttributeDecl" (byval ctx as any ptr, byval elem as xmlChar ptr, byval fullname as xmlChar ptr, byval type as integer, byval def as integer, byval defaultValue as xmlChar ptr, byval tree as xmlEnumerationPtr)
declare sub xmlSAX2ElementDecl cdecl alias "xmlSAX2ElementDecl" (byval ctx as any ptr, byval name as xmlChar ptr, byval type as integer, byval content as xmlElementContentPtr)
declare sub xmlSAX2NotationDecl cdecl alias "xmlSAX2NotationDecl" (byval ctx as any ptr, byval name as xmlChar ptr, byval publicId as xmlChar ptr, byval systemId as xmlChar ptr)
declare sub xmlSAX2UnparsedEntityDecl cdecl alias "xmlSAX2UnparsedEntityDecl" (byval ctx as any ptr, byval name as xmlChar ptr, byval publicId as xmlChar ptr, byval systemId as xmlChar ptr, byval notationName as xmlChar ptr)
declare sub xmlSAX2StartDocument cdecl alias "xmlSAX2StartDocument" (byval ctx as any ptr)
declare sub xmlSAX2EndDocument cdecl alias "xmlSAX2EndDocument" (byval ctx as any ptr)
declare sub xmlSAX2StartElement cdecl alias "xmlSAX2StartElement" (byval ctx as any ptr, byval fullname as xmlChar ptr, byval atts as xmlChar ptr ptr)
declare sub xmlSAX2EndElement cdecl alias "xmlSAX2EndElement" (byval ctx as any ptr, byval name as xmlChar ptr)
declare sub xmlSAX2StartElementNs cdecl alias "xmlSAX2StartElementNs" (byval ctx as any ptr, byval localname as xmlChar ptr, byval prefix as xmlChar ptr, byval URI as xmlChar ptr, byval nb_namespaces as integer, byval namespaces as xmlChar ptr ptr, byval nb_attributes as integer, byval nb_defaulted as integer, byval attributes as xmlChar ptr ptr)
declare sub xmlSAX2EndElementNs cdecl alias "xmlSAX2EndElementNs" (byval ctx as any ptr, byval localname as xmlChar ptr, byval prefix as xmlChar ptr, byval URI as xmlChar ptr)
declare sub xmlSAX2Reference cdecl alias "xmlSAX2Reference" (byval ctx as any ptr, byval name as xmlChar ptr)
declare sub xmlSAX2Characters cdecl alias "xmlSAX2Characters" (byval ctx as any ptr, byval ch as xmlChar ptr, byval len as integer)
declare sub xmlSAX2IgnorableWhitespace cdecl alias "xmlSAX2IgnorableWhitespace" (byval ctx as any ptr, byval ch as xmlChar ptr, byval len as integer)
declare sub xmlSAX2ProcessingInstruction cdecl alias "xmlSAX2ProcessingInstruction" (byval ctx as any ptr, byval target as xmlChar ptr, byval data as xmlChar ptr)
declare sub xmlSAX2Comment cdecl alias "xmlSAX2Comment" (byval ctx as any ptr, byval value as xmlChar ptr)
declare sub xmlSAX2CDataBlock cdecl alias "xmlSAX2CDataBlock" (byval ctx as any ptr, byval value as xmlChar ptr, byval len as integer)
declare function xmlSAXDefaultVersion cdecl alias "xmlSAXDefaultVersion" (byval version as integer) as integer
declare function xmlSAXVersion cdecl alias "xmlSAXVersion" (byval hdlr as xmlSAXHandler ptr, byval version as integer) as integer
declare sub xmlSAX2InitDefaultSAXHandler cdecl alias "xmlSAX2InitDefaultSAXHandler" (byval hdlr as xmlSAXHandler ptr, byval warning as integer)
declare sub xmlSAX2InitHtmlDefaultSAXHandler cdecl alias "xmlSAX2InitHtmlDefaultSAXHandler" (byval hdlr as xmlSAXHandler ptr)
declare sub htmlDefaultSAXHandlerInit cdecl alias "htmlDefaultSAXHandlerInit" ()
declare sub xmlSAX2InitDocbDefaultSAXHandler cdecl alias "xmlSAX2InitDocbDefaultSAXHandler" (byval hdlr as xmlSAXHandler ptr)
declare sub docbDefaultSAXHandlerInit cdecl alias "docbDefaultSAXHandlerInit" ()
declare sub xmlDefaultSAXHandlerInit cdecl alias "xmlDefaultSAXHandlerInit" ()

#endif
