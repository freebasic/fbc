''
''
'' catalog -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __catalog_bi__
#define __catalog_bi__

#include once "libxml/xmlversion.bi"
#include once "libxml/xmlstring.bi"
#include once "libxml/tree.bi"

#define XML_CATALOGS_NAMESPACE "urn:oasis:names:tc:entity:xmlns:xml:catalog"
#define XML_CATALOG_PI "oasis-xml-catalog"

enum xmlCatalogPrefer
	XML_CATA_PREFER_NONE = 0
	XML_CATA_PREFER_PUBLIC = 1
	XML_CATA_PREFER_SYSTEM
end enum


enum xmlCatalogAllow
	XML_CATA_ALLOW_NONE = 0
	XML_CATA_ALLOW_GLOBAL = 1
	XML_CATA_ALLOW_DOCUMENT = 2
	XML_CATA_ALLOW_ALL = 3
end enum

type xmlCatalog as _xmlCatalog
type xmlCatalogPtr as xmlCatalog ptr

declare function xmlNewCatalog cdecl alias "xmlNewCatalog" (byval sgml as integer) as xmlCatalogPtr
declare function xmlLoadACatalog cdecl alias "xmlLoadACatalog" (byval filename as zstring ptr) as xmlCatalogPtr
declare function xmlLoadSGMLSuperCatalog cdecl alias "xmlLoadSGMLSuperCatalog" (byval filename as zstring ptr) as xmlCatalogPtr
declare function xmlConvertSGMLCatalog cdecl alias "xmlConvertSGMLCatalog" (byval catal as xmlCatalogPtr) as integer
declare function xmlACatalogAdd cdecl alias "xmlACatalogAdd" (byval catal as xmlCatalogPtr, byval type as zstring ptr, byval orig as zstring ptr, byval replace as zstring ptr) as integer
declare function xmlACatalogRemove cdecl alias "xmlACatalogRemove" (byval catal as xmlCatalogPtr, byval value as zstring ptr) as integer
declare function xmlACatalogResolve cdecl alias "xmlACatalogResolve" (byval catal as xmlCatalogPtr, byval pubID as zstring ptr, byval sysID as zstring ptr) as zstring ptr
declare function xmlACatalogResolveSystem cdecl alias "xmlACatalogResolveSystem" (byval catal as xmlCatalogPtr, byval sysID as zstring ptr) as zstring ptr
declare function xmlACatalogResolvePublic cdecl alias "xmlACatalogResolvePublic" (byval catal as xmlCatalogPtr, byval pubID as zstring ptr) as zstring ptr
declare function xmlACatalogResolveURI cdecl alias "xmlACatalogResolveURI" (byval catal as xmlCatalogPtr, byval URI as zstring ptr) as zstring ptr
declare sub xmlACatalogDump cdecl alias "xmlACatalogDump" (byval catal as xmlCatalogPtr, byval out as FILE ptr)
declare sub xmlFreeCatalog cdecl alias "xmlFreeCatalog" (byval catal as xmlCatalogPtr)
declare function xmlCatalogIsEmpty cdecl alias "xmlCatalogIsEmpty" (byval catal as xmlCatalogPtr) as integer
declare sub xmlInitializeCatalog cdecl alias "xmlInitializeCatalog" ()
declare function xmlLoadCatalog cdecl alias "xmlLoadCatalog" (byval filename as zstring ptr) as integer
declare sub xmlLoadCatalogs cdecl alias "xmlLoadCatalogs" (byval paths as zstring ptr)
declare sub xmlCatalogCleanup cdecl alias "xmlCatalogCleanup" ()
declare sub xmlCatalogDump cdecl alias "xmlCatalogDump" (byval out as FILE ptr)
declare function xmlCatalogResolve cdecl alias "xmlCatalogResolve" (byval pubID as zstring ptr, byval sysID as zstring ptr) as zstring ptr
declare function xmlCatalogResolveSystem cdecl alias "xmlCatalogResolveSystem" (byval sysID as zstring ptr) as zstring ptr
declare function xmlCatalogResolvePublic cdecl alias "xmlCatalogResolvePublic" (byval pubID as zstring ptr) as zstring ptr
declare function xmlCatalogResolveURI cdecl alias "xmlCatalogResolveURI" (byval URI as zstring ptr) as zstring ptr
declare function xmlCatalogAdd cdecl alias "xmlCatalogAdd" (byval type as zstring ptr, byval orig as zstring ptr, byval replace as zstring ptr) as integer
declare function xmlCatalogRemove cdecl alias "xmlCatalogRemove" (byval value as zstring ptr) as integer
declare function xmlParseCatalogFile cdecl alias "xmlParseCatalogFile" (byval filename as zstring ptr) as xmlDocPtr
declare function xmlCatalogConvert cdecl alias "xmlCatalogConvert" () as integer
declare sub xmlCatalogFreeLocal cdecl alias "xmlCatalogFreeLocal" (byval catalogs as any ptr)
declare function xmlCatalogAddLocal cdecl alias "xmlCatalogAddLocal" (byval catalogs as any ptr, byval URL as zstring ptr) as any ptr
declare function xmlCatalogLocalResolve cdecl alias "xmlCatalogLocalResolve" (byval catalogs as any ptr, byval pubID as zstring ptr, byval sysID as zstring ptr) as zstring ptr
declare function xmlCatalogLocalResolveURI cdecl alias "xmlCatalogLocalResolveURI" (byval catalogs as any ptr, byval URI as zstring ptr) as zstring ptr
declare function xmlCatalogSetDebug cdecl alias "xmlCatalogSetDebug" (byval level as integer) as integer
declare function xmlCatalogSetDefaultPrefer cdecl alias "xmlCatalogSetDefaultPrefer" (byval prefer as xmlCatalogPrefer) as xmlCatalogPrefer
declare sub xmlCatalogSetDefaults cdecl alias "xmlCatalogSetDefaults" (byval allow as xmlCatalogAllow)
declare function xmlCatalogGetDefaults cdecl alias "xmlCatalogGetDefaults" () as xmlCatalogAllow
declare function xmlCatalogGetSystem cdecl alias "xmlCatalogGetSystem" (byval sysID as zstring ptr) as zstring ptr
declare function xmlCatalogGetPublic cdecl alias "xmlCatalogGetPublic" (byval pubID as zstring ptr) as zstring ptr

#endif
