''
''
'' uri -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __xml_uri_bi__
#define __xml_uri_bi__

#include once "libxml/xmlversion.bi"
#include once "libxml/tree.bi"

type xmlURI as _xmlURI
type xmlURIPtr as xmlURI ptr

type _xmlURI
	scheme as byte ptr
	opaque as byte ptr
	authority as byte ptr
	server as byte ptr
	user as byte ptr
	port as integer
	path as byte ptr
	query as byte ptr
	fragment as byte ptr
	cleanup as integer
end type

declare function xmlCreateURI cdecl alias "xmlCreateURI" () as xmlURIPtr
declare function xmlBuildURI cdecl alias "xmlBuildURI" (byval URI as zstring ptr, byval base as zstring ptr) as zstring ptr
declare function xmlBuildRelativeURI cdecl alias "xmlBuildRelativeURI" (byval URI as zstring ptr, byval base as zstring ptr) as zstring ptr
declare function xmlParseURI cdecl alias "xmlParseURI" (byval str as zstring ptr) as xmlURIPtr
declare function xmlParseURIReference cdecl alias "xmlParseURIReference" (byval uri as xmlURIPtr, byval str as zstring ptr) as integer
declare function xmlSaveUri cdecl alias "xmlSaveUri" (byval uri as xmlURIPtr) as zstring ptr
declare sub xmlPrintURI cdecl alias "xmlPrintURI" (byval stream as FILE ptr, byval uri as xmlURIPtr)
declare function xmlURIEscapeStr cdecl alias "xmlURIEscapeStr" (byval str as zstring ptr, byval list as zstring ptr) as zstring ptr
declare function xmlURIUnescapeString cdecl alias "xmlURIUnescapeString" (byval str as zstring ptr, byval len as integer, byval target as zstring ptr) as byte ptr
declare function xmlNormalizeURIPath cdecl alias "xmlNormalizeURIPath" (byval path as zstring ptr) as integer
declare function xmlURIEscape cdecl alias "xmlURIEscape" (byval str as zstring ptr) as zstring ptr
declare sub xmlFreeURI cdecl alias "xmlFreeURI" (byval uri as xmlURIPtr)
declare function xmlCanonicPath cdecl alias "xmlCanonicPath" (byval path as zstring ptr) as zstring ptr

#endif
