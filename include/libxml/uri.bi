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

#include once "xmlversion.bi"
#include once "tree.bi"

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

extern "c"
declare function xmlCreateURI () as xmlURIPtr
declare function xmlBuildURI (byval URI as zstring ptr, byval base as zstring ptr) as zstring ptr
declare function xmlBuildRelativeURI (byval URI as zstring ptr, byval base as zstring ptr) as zstring ptr
declare function xmlParseURI (byval str as zstring ptr) as xmlURIPtr
declare function xmlParseURIReference (byval uri as xmlURIPtr, byval str as zstring ptr) as integer
declare function xmlSaveUri (byval uri as xmlURIPtr) as zstring ptr
declare sub xmlPrintURI (byval stream as FILE ptr, byval uri as xmlURIPtr)
declare function xmlURIEscapeStr (byval str as zstring ptr, byval list as zstring ptr) as zstring ptr
declare function xmlURIUnescapeString (byval str as zstring ptr, byval len as integer, byval target as zstring ptr) as byte ptr
declare function xmlNormalizeURIPath (byval path as zstring ptr) as integer
declare function xmlURIEscape (byval str as zstring ptr) as zstring ptr
declare sub xmlFreeURI (byval uri as xmlURIPtr)
declare function xmlCanonicPath (byval path as zstring ptr) as zstring ptr
end extern

#endif
