''
''
'' xinclude -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __xml_xinclude_bi__
#define __xml_xinclude_bi__

#include once "xmlversion.bi"
#include once "tree.bi"

#define XINCLUDE_NS "http://www.w3.org/2003/XInclude"
#define XINCLUDE_OLD_NS "http://www.w3.org/2001/XInclude"
#define XINCLUDE_NODE "include"
#define XINCLUDE_FALLBACK "fallback"
#define XINCLUDE_HREF "href"
#define XINCLUDE_PARSE "parse"
#define XINCLUDE_PARSE_XML "xml"
#define XINCLUDE_PARSE_TEXT "text"
#define XINCLUDE_PARSE_ENCODING "encoding"
#define XINCLUDE_PARSE_XPOINTER "xpointer"

type xmlXIncludeCtxt as _xmlXIncludeCtxt
type xmlXIncludeCtxtPtr as xmlXIncludeCtxt ptr

extern "c"
declare function xmlXIncludeProcess (byval doc as xmlDocPtr) as integer
declare function xmlXIncludeProcessFlags (byval doc as xmlDocPtr, byval flags as integer) as integer
declare function xmlXIncludeProcessTree (byval tree as xmlNodePtr) as integer
declare function xmlXIncludeProcessTreeFlags (byval tree as xmlNodePtr, byval flags as integer) as integer
declare function xmlXIncludeNewContext (byval doc as xmlDocPtr) as xmlXIncludeCtxtPtr
declare function xmlXIncludeSetFlags (byval ctxt as xmlXIncludeCtxtPtr, byval flags as integer) as integer
declare sub xmlXIncludeFreeContext (byval ctxt as xmlXIncludeCtxtPtr)
declare function xmlXIncludeProcessNode (byval ctxt as xmlXIncludeCtxtPtr, byval tree as xmlNodePtr) as integer
end extern

#endif
