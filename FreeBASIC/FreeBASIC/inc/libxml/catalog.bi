''
''
'' catalog -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __xml_catalog_bi__
#define __xml_catalog_bi__

#include once "xmlversion.bi"
#include once "xmlstring.bi"
#include once "tree.bi"

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

extern "c"
declare function xmlNewCatalog (byval sgml as integer) as xmlCatalogPtr
declare function xmlLoadACatalog (byval filename as zstring ptr) as xmlCatalogPtr
declare function xmlLoadSGMLSuperCatalog (byval filename as zstring ptr) as xmlCatalogPtr
declare function xmlConvertSGMLCatalog (byval catal as xmlCatalogPtr) as integer
declare function xmlACatalogAdd (byval catal as xmlCatalogPtr, byval type as zstring ptr, byval orig as zstring ptr, byval replace as zstring ptr) as integer
declare function xmlACatalogRemove (byval catal as xmlCatalogPtr, byval value as zstring ptr) as integer
declare function xmlACatalogResolve (byval catal as xmlCatalogPtr, byval pubID as zstring ptr, byval sysID as zstring ptr) as zstring ptr
declare function xmlACatalogResolveSystem (byval catal as xmlCatalogPtr, byval sysID as zstring ptr) as zstring ptr
declare function xmlACatalogResolvePublic (byval catal as xmlCatalogPtr, byval pubID as zstring ptr) as zstring ptr
declare function xmlACatalogResolveURI (byval catal as xmlCatalogPtr, byval URI as zstring ptr) as zstring ptr
declare sub xmlACatalogDump (byval catal as xmlCatalogPtr, byval out as FILE ptr)
declare sub xmlFreeCatalog (byval catal as xmlCatalogPtr)
declare function xmlCatalogIsEmpty (byval catal as xmlCatalogPtr) as integer
declare sub xmlInitializeCatalog ()
declare function xmlLoadCatalog (byval filename as zstring ptr) as integer
declare sub xmlLoadCatalogs (byval paths as zstring ptr)
declare sub xmlCatalogCleanup ()
declare sub xmlCatalogDump (byval out as FILE ptr)
declare function xmlCatalogResolve (byval pubID as zstring ptr, byval sysID as zstring ptr) as zstring ptr
declare function xmlCatalogResolveSystem (byval sysID as zstring ptr) as zstring ptr
declare function xmlCatalogResolvePublic (byval pubID as zstring ptr) as zstring ptr
declare function xmlCatalogResolveURI (byval URI as zstring ptr) as zstring ptr
declare function xmlCatalogAdd (byval type as zstring ptr, byval orig as zstring ptr, byval replace as zstring ptr) as integer
declare function xmlCatalogRemove (byval value as zstring ptr) as integer
declare function xmlParseCatalogFile (byval filename as zstring ptr) as xmlDocPtr
declare function xmlCatalogConvert () as integer
declare sub xmlCatalogFreeLocal (byval catalogs as any ptr)
declare function xmlCatalogAddLocal (byval catalogs as any ptr, byval URL as zstring ptr) as any ptr
declare function xmlCatalogLocalResolve (byval catalogs as any ptr, byval pubID as zstring ptr, byval sysID as zstring ptr) as zstring ptr
declare function xmlCatalogLocalResolveURI (byval catalogs as any ptr, byval URI as zstring ptr) as zstring ptr
declare function xmlCatalogSetDebug (byval level as integer) as integer
declare function xmlCatalogSetDefaultPrefer (byval prefer as xmlCatalogPrefer) as xmlCatalogPrefer
declare sub xmlCatalogSetDefaults (byval allow as xmlCatalogAllow)
declare function xmlCatalogGetDefaults () as xmlCatalogAllow
declare function xmlCatalogGetSystem (byval sysID as zstring ptr) as zstring ptr
declare function xmlCatalogGetPublic (byval pubID as zstring ptr) as zstring ptr
end extern

#endif
