'' FreeBASIC binding for libxml2-2.9.2
''
'' based on the C header files:
''    Copyright (C) 1998-2012 Daniel Veillard.  All Rights Reserved.
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
''   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
''   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
''   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
''   THE SOFTWARE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/stdio.bi"
#include once "libxml/xmlversion.bi"
#include once "libxml/xmlstring.bi"
#include once "libxml/tree.bi"

extern "C"

#define __XML_CATALOG_H__
#define XML_CATALOGS_NAMESPACE cptr(const xmlChar ptr, @"urn:oasis:names:tc:entity:xmlns:xml:catalog")
#define XML_CATALOG_PI cptr(const xmlChar ptr, @"oasis-xml-catalog")

type xmlCatalogPrefer as long
enum
	XML_CATA_PREFER_NONE = 0
	XML_CATA_PREFER_PUBLIC = 1
	XML_CATA_PREFER_SYSTEM
end enum

type xmlCatalogAllow as long
enum
	XML_CATA_ALLOW_NONE = 0
	XML_CATA_ALLOW_GLOBAL = 1
	XML_CATA_ALLOW_DOCUMENT = 2
	XML_CATA_ALLOW_ALL = 3
end enum

type xmlCatalog as _xmlCatalog
type xmlCatalogPtr as xmlCatalog ptr
declare function xmlNewCatalog(byval sgml as long) as xmlCatalogPtr
declare function xmlLoadACatalog(byval filename as const zstring ptr) as xmlCatalogPtr
declare function xmlLoadSGMLSuperCatalog(byval filename as const zstring ptr) as xmlCatalogPtr
declare function xmlConvertSGMLCatalog(byval catal as xmlCatalogPtr) as long
declare function xmlACatalogAdd(byval catal as xmlCatalogPtr, byval type as const xmlChar ptr, byval orig as const xmlChar ptr, byval replace as const xmlChar ptr) as long
declare function xmlACatalogRemove(byval catal as xmlCatalogPtr, byval value as const xmlChar ptr) as long
declare function xmlACatalogResolve(byval catal as xmlCatalogPtr, byval pubID as const xmlChar ptr, byval sysID as const xmlChar ptr) as xmlChar ptr
declare function xmlACatalogResolveSystem(byval catal as xmlCatalogPtr, byval sysID as const xmlChar ptr) as xmlChar ptr
declare function xmlACatalogResolvePublic(byval catal as xmlCatalogPtr, byval pubID as const xmlChar ptr) as xmlChar ptr
declare function xmlACatalogResolveURI(byval catal as xmlCatalogPtr, byval URI as const xmlChar ptr) as xmlChar ptr
declare sub xmlACatalogDump(byval catal as xmlCatalogPtr, byval out as FILE ptr)
declare sub xmlFreeCatalog(byval catal as xmlCatalogPtr)
declare function xmlCatalogIsEmpty(byval catal as xmlCatalogPtr) as long
declare sub xmlInitializeCatalog()
declare function xmlLoadCatalog(byval filename as const zstring ptr) as long
declare sub xmlLoadCatalogs(byval paths as const zstring ptr)
declare sub xmlCatalogCleanup()
declare sub xmlCatalogDump(byval out as FILE ptr)
declare function xmlCatalogResolve(byval pubID as const xmlChar ptr, byval sysID as const xmlChar ptr) as xmlChar ptr
declare function xmlCatalogResolveSystem(byval sysID as const xmlChar ptr) as xmlChar ptr
declare function xmlCatalogResolvePublic(byval pubID as const xmlChar ptr) as xmlChar ptr
declare function xmlCatalogResolveURI(byval URI as const xmlChar ptr) as xmlChar ptr
declare function xmlCatalogAdd(byval type as const xmlChar ptr, byval orig as const xmlChar ptr, byval replace as const xmlChar ptr) as long
declare function xmlCatalogRemove(byval value as const xmlChar ptr) as long
declare function xmlParseCatalogFile(byval filename as const zstring ptr) as xmlDocPtr
declare function xmlCatalogConvert() as long
declare sub xmlCatalogFreeLocal(byval catalogs as any ptr)
declare function xmlCatalogAddLocal(byval catalogs as any ptr, byval URL as const xmlChar ptr) as any ptr
declare function xmlCatalogLocalResolve(byval catalogs as any ptr, byval pubID as const xmlChar ptr, byval sysID as const xmlChar ptr) as xmlChar ptr
declare function xmlCatalogLocalResolveURI(byval catalogs as any ptr, byval URI as const xmlChar ptr) as xmlChar ptr
declare function xmlCatalogSetDebug(byval level as long) as long
declare function xmlCatalogSetDefaultPrefer(byval prefer as xmlCatalogPrefer) as xmlCatalogPrefer
declare sub xmlCatalogSetDefaults(byval allow as xmlCatalogAllow)
declare function xmlCatalogGetDefaults() as xmlCatalogAllow
declare function xmlCatalogGetSystem(byval sysID as const xmlChar ptr) as const xmlChar ptr
declare function xmlCatalogGetPublic(byval pubID as const xmlChar ptr) as const xmlChar ptr

end extern
