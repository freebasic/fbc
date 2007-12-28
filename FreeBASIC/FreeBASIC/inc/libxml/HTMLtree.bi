''
''
'' HTMLtree -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __xml_HTMLtree_bi__
#define __xml_HTMLtree_bi__

#include once "xmlversion.bi"
#include once "parser.bi"
#include once "HTMLparser.bi"

extern "c"
declare function htmlNewDoc (byval URI as zstring ptr, byval ExternalID as zstring ptr) as htmlDocPtr
declare function htmlNewDocNoDtD (byval URI as zstring ptr, byval ExternalID as zstring ptr) as htmlDocPtr
declare function htmlGetMetaEncoding (byval doc as htmlDocPtr) as zstring ptr
declare function htmlSetMetaEncoding (byval doc as htmlDocPtr, byval encoding as zstring ptr) as integer
declare sub htmlDocDumpMemory (byval cur as xmlDocPtr, byval mem as zstring ptr ptr, byval size as integer ptr)
declare function htmlDocDump (byval f as FILE ptr, byval cur as xmlDocPtr) as integer
declare function htmlSaveFile (byval filename as zstring ptr, byval cur as xmlDocPtr) as integer
declare function htmlNodeDump (byval buf as xmlBufferPtr, byval doc as xmlDocPtr, byval cur as xmlNodePtr) as integer
declare sub htmlNodeDumpFile (byval out as FILE ptr, byval doc as xmlDocPtr, byval cur as xmlNodePtr)
declare function htmlNodeDumpFileFormat (byval out as FILE ptr, byval doc as xmlDocPtr, byval cur as xmlNodePtr, byval encoding as zstring ptr, byval format as integer) as integer
declare function htmlSaveFileEnc (byval filename as zstring ptr, byval cur as xmlDocPtr, byval encoding as zstring ptr) as integer
declare function htmlSaveFileFormat (byval filename as zstring ptr, byval cur as xmlDocPtr, byval encoding as zstring ptr, byval format as integer) as integer
declare sub htmlNodeDumpFormatOutput (byval buf as xmlOutputBufferPtr, byval doc as xmlDocPtr, byval cur as xmlNodePtr, byval encoding as zstring ptr, byval format as integer)
declare sub htmlDocContentDumpOutput (byval buf as xmlOutputBufferPtr, byval cur as xmlDocPtr, byval encoding as zstring ptr)
declare sub htmlDocContentDumpFormatOutput (byval buf as xmlOutputBufferPtr, byval cur as xmlDocPtr, byval encoding as zstring ptr, byval format as integer)
declare sub htmlNodeDumpOutput (byval buf as xmlOutputBufferPtr, byval doc as xmlDocPtr, byval cur as xmlNodePtr, byval encoding as zstring ptr)
declare function htmlIsBooleanAttr (byval name as zstring ptr) as integer
end extern

#endif
