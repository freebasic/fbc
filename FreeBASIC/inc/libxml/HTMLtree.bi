''
''
'' HTMLtree -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __HTMLtree_bi__
#define __HTMLtree_bi__

#include once "libxml/xmlversion.bi"
#include once "libxml/parser.bi"
#include once "libxml/HTMLparser.bi"

declare function htmlNewDoc cdecl alias "htmlNewDoc" (byval URI as xmlChar ptr, byval ExternalID as xmlChar ptr) as htmlDocPtr
declare function htmlNewDocNoDtD cdecl alias "htmlNewDocNoDtD" (byval URI as xmlChar ptr, byval ExternalID as xmlChar ptr) as htmlDocPtr
declare function htmlGetMetaEncoding cdecl alias "htmlGetMetaEncoding" (byval doc as htmlDocPtr) as xmlChar ptr
declare function htmlSetMetaEncoding cdecl alias "htmlSetMetaEncoding" (byval doc as htmlDocPtr, byval encoding as xmlChar ptr) as integer
declare sub htmlDocDumpMemory cdecl alias "htmlDocDumpMemory" (byval cur as xmlDocPtr, byval mem as xmlChar ptr ptr, byval size as integer ptr)
declare function htmlDocDump cdecl alias "htmlDocDump" (byval f as FILE ptr, byval cur as xmlDocPtr) as integer
declare function htmlSaveFile cdecl alias "htmlSaveFile" (byval filename as string, byval cur as xmlDocPtr) as integer
declare function htmlNodeDump cdecl alias "htmlNodeDump" (byval buf as xmlBufferPtr, byval doc as xmlDocPtr, byval cur as xmlNodePtr) as integer
declare sub htmlNodeDumpFile cdecl alias "htmlNodeDumpFile" (byval out as FILE ptr, byval doc as xmlDocPtr, byval cur as xmlNodePtr)
declare function htmlNodeDumpFileFormat cdecl alias "htmlNodeDumpFileFormat" (byval out as FILE ptr, byval doc as xmlDocPtr, byval cur as xmlNodePtr, byval encoding as string, byval format as integer) as integer
declare function htmlSaveFileEnc cdecl alias "htmlSaveFileEnc" (byval filename as string, byval cur as xmlDocPtr, byval encoding as string) as integer
declare function htmlSaveFileFormat cdecl alias "htmlSaveFileFormat" (byval filename as string, byval cur as xmlDocPtr, byval encoding as string, byval format as integer) as integer
declare sub htmlNodeDumpFormatOutput cdecl alias "htmlNodeDumpFormatOutput" (byval buf as xmlOutputBufferPtr, byval doc as xmlDocPtr, byval cur as xmlNodePtr, byval encoding as string, byval format as integer)
declare sub htmlDocContentDumpOutput cdecl alias "htmlDocContentDumpOutput" (byval buf as xmlOutputBufferPtr, byval cur as xmlDocPtr, byval encoding as string)
declare sub htmlDocContentDumpFormatOutput cdecl alias "htmlDocContentDumpFormatOutput" (byval buf as xmlOutputBufferPtr, byval cur as xmlDocPtr, byval encoding as string, byval format as integer)
declare sub htmlNodeDumpOutput cdecl alias "htmlNodeDumpOutput" (byval buf as xmlOutputBufferPtr, byval doc as xmlDocPtr, byval cur as xmlNodePtr, byval encoding as string)
declare function htmlIsBooleanAttr cdecl alias "htmlIsBooleanAttr" (byval name as xmlChar ptr) as integer

#endif
