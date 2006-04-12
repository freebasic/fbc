''
''
'' xmlsave -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __xml_xmlsave_bi__
#define __xml_xmlsave_bi__

#include once "libxml/xmlversion.bi"
#include once "libxml/tree.bi"
#include once "libxml/encoding.bi"
#include once "libxml/xmlIO.bi"

enum xmlSaveOption
	XML_SAVE_FORMAT = 1 shl 0
end enum

type xmlSaveCtxt as _xmlSaveCtxt
type xmlSaveCtxtPtr as xmlSaveCtxt ptr

declare function xmlSaveToFd cdecl alias "xmlSaveToFd" (byval fd as integer, byval encoding as zstring ptr, byval options as integer) as xmlSaveCtxtPtr
declare function xmlSaveToFilename cdecl alias "xmlSaveToFilename" (byval filename as zstring ptr, byval encoding as zstring ptr, byval options as integer) as xmlSaveCtxtPtr
declare function xmlSaveToIO cdecl alias "xmlSaveToIO" (byval iowrite as xmlOutputWriteCallback, byval ioclose as xmlOutputCloseCallback, byval ioctx as any ptr, byval encoding as zstring ptr, byval options as integer) as xmlSaveCtxtPtr
declare function xmlSaveDoc cdecl alias "xmlSaveDoc" (byval ctxt as xmlSaveCtxtPtr, byval doc as xmlDocPtr) as integer
declare function xmlSaveTree cdecl alias "xmlSaveTree" (byval ctxt as xmlSaveCtxtPtr, byval node as xmlNodePtr) as integer
declare function xmlSaveFlush cdecl alias "xmlSaveFlush" (byval ctxt as xmlSaveCtxtPtr) as integer
declare function xmlSaveClose cdecl alias "xmlSaveClose" (byval ctxt as xmlSaveCtxtPtr) as integer
declare function xmlSaveSetEscape cdecl alias "xmlSaveSetEscape" (byval ctxt as xmlSaveCtxtPtr, byval escape as xmlCharEncodingOutputFunc) as integer
declare function xmlSaveSetAttrEscape cdecl alias "xmlSaveSetAttrEscape" (byval ctxt as xmlSaveCtxtPtr, byval escape as xmlCharEncodingOutputFunc) as integer

#endif
