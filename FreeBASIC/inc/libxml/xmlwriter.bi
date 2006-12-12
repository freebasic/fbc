''
''
'' xmlwriter -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __xml_xmlwriter_bi__
#define __xml_xmlwriter_bi__

#include once "xmlversion.bi"
#include once "xmlIO.bi"
#include once "list.bi"
#include once "xmlstring.bi"

type xmlTextWriter as _xmlTextWriter
type xmlTextWriterPtr as xmlTextWriter ptr

extern "c"
declare function xmlNewTextWriter (byval out as xmlOutputBufferPtr) as xmlTextWriterPtr
declare function xmlNewTextWriterFilename (byval uri as zstring ptr, byval compression as integer) as xmlTextWriterPtr
declare function xmlNewTextWriterMemory (byval buf as xmlBufferPtr, byval compression as integer) as xmlTextWriterPtr
declare function xmlNewTextWriterPushParser (byval ctxt as xmlParserCtxtPtr, byval compression as integer) as xmlTextWriterPtr
declare function xmlNewTextWriterDoc (byval doc as xmlDocPtr ptr, byval compression as integer) as xmlTextWriterPtr
declare function xmlNewTextWriterTree (byval doc as xmlDocPtr, byval node as xmlNodePtr, byval compression as integer) as xmlTextWriterPtr
declare sub xmlFreeTextWriter (byval writer as xmlTextWriterPtr)
declare function xmlTextWriterStartDocument (byval writer as xmlTextWriterPtr, byval version as zstring ptr, byval encoding as zstring ptr, byval standalone as zstring ptr) as integer
declare function xmlTextWriterEndDocument (byval writer as xmlTextWriterPtr) as integer
declare function xmlTextWriterStartComment (byval writer as xmlTextWriterPtr) as integer
declare function xmlTextWriterEndComment (byval writer as xmlTextWriterPtr) as integer
declare function xmlTextWriterWriteFormatComment (byval writer as xmlTextWriterPtr, byval format as zstring ptr, ...) as integer
''''''' declare function xmlTextWriterWriteVFormatComment (byval writer as xmlTextWriterPtr, byval format as zstring ptr, byval argptr as va_list) as integer
declare function xmlTextWriterWriteComment (byval writer as xmlTextWriterPtr, byval content as zstring ptr) as integer
declare function xmlTextWriterStartElement (byval writer as xmlTextWriterPtr, byval name as zstring ptr) as integer
declare function xmlTextWriterStartElementNS (byval writer as xmlTextWriterPtr, byval prefix as zstring ptr, byval name as zstring ptr, byval namespaceURI as zstring ptr) as integer
declare function xmlTextWriterEndElement (byval writer as xmlTextWriterPtr) as integer
declare function xmlTextWriterFullEndElement (byval writer as xmlTextWriterPtr) as integer
declare function xmlTextWriterWriteFormatElement (byval writer as xmlTextWriterPtr, byval name as zstring ptr, byval format as zstring ptr, ...) as integer
''''''' declare function xmlTextWriterWriteVFormatElement (byval writer as xmlTextWriterPtr, byval name as zstring ptr, byval format as zstring ptr, byval argptr as va_list) as integer
declare function xmlTextWriterWriteElement (byval writer as xmlTextWriterPtr, byval name as zstring ptr, byval content as zstring ptr) as integer
declare function xmlTextWriterWriteFormatElementNS (byval writer as xmlTextWriterPtr, byval prefix as zstring ptr, byval name as zstring ptr, byval namespaceURI as zstring ptr, byval format as zstring ptr, ...) as integer
''''''' declare function xmlTextWriterWriteVFormatElementNS (byval writer as xmlTextWriterPtr, byval prefix as zstring ptr, byval name as zstring ptr, byval namespaceURI as zstring ptr, byval format as zstring ptr, byval argptr as va_list) as integer
declare function xmlTextWriterWriteElementNS (byval writer as xmlTextWriterPtr, byval prefix as zstring ptr, byval name as zstring ptr, byval namespaceURI as zstring ptr, byval content as zstring ptr) as integer
declare function xmlTextWriterWriteFormatRaw (byval writer as xmlTextWriterPtr, byval format as zstring ptr, ...) as integer
''''''' declare function xmlTextWriterWriteVFormatRaw (byval writer as xmlTextWriterPtr, byval format as zstring ptr, byval argptr as va_list) as integer
declare function xmlTextWriterWriteRawLen (byval writer as xmlTextWriterPtr, byval content as zstring ptr, byval len as integer) as integer
declare function xmlTextWriterWriteRaw (byval writer as xmlTextWriterPtr, byval content as zstring ptr) as integer
declare function xmlTextWriterWriteFormatString (byval writer as xmlTextWriterPtr, byval format as zstring ptr, ...) as integer
''''''' declare function xmlTextWriterWriteVFormatString (byval writer as xmlTextWriterPtr, byval format as zstring ptr, byval argptr as va_list) as integer
declare function xmlTextWriterWriteString (byval writer as xmlTextWriterPtr, byval content as zstring ptr) as integer
declare function xmlTextWriterWriteBase64 (byval writer as xmlTextWriterPtr, byval data as zstring ptr, byval start as integer, byval len as integer) as integer
declare function xmlTextWriterWriteBinHex (byval writer as xmlTextWriterPtr, byval data as zstring ptr, byval start as integer, byval len as integer) as integer
declare function xmlTextWriterStartAttribute (byval writer as xmlTextWriterPtr, byval name as zstring ptr) as integer
declare function xmlTextWriterStartAttributeNS (byval writer as xmlTextWriterPtr, byval prefix as zstring ptr, byval name as zstring ptr, byval namespaceURI as zstring ptr) as integer
declare function xmlTextWriterEndAttribute (byval writer as xmlTextWriterPtr) as integer
declare function xmlTextWriterWriteFormatAttribute (byval writer as xmlTextWriterPtr, byval name as zstring ptr, byval format as zstring ptr, ...) as integer
''''''' declare function xmlTextWriterWriteVFormatAttribute (byval writer as xmlTextWriterPtr, byval name as zstring ptr, byval format as zstring ptr, byval argptr as va_list) as integer
declare function xmlTextWriterWriteAttribute (byval writer as xmlTextWriterPtr, byval name as zstring ptr, byval content as zstring ptr) as integer
declare function xmlTextWriterWriteFormatAttributeNS (byval writer as xmlTextWriterPtr, byval prefix as zstring ptr, byval name as zstring ptr, byval namespaceURI as zstring ptr, byval format as zstring ptr, ...) as integer
''''''' declare function xmlTextWriterWriteVFormatAttributeNS (byval writer as xmlTextWriterPtr, byval prefix as zstring ptr, byval name as zstring ptr, byval namespaceURI as zstring ptr, byval format as zstring ptr, byval argptr as va_list) as integer
declare function xmlTextWriterWriteAttributeNS (byval writer as xmlTextWriterPtr, byval prefix as zstring ptr, byval name as zstring ptr, byval namespaceURI as zstring ptr, byval content as zstring ptr) as integer
declare function xmlTextWriterStartPI (byval writer as xmlTextWriterPtr, byval target as zstring ptr) as integer
declare function xmlTextWriterEndPI (byval writer as xmlTextWriterPtr) as integer
declare function xmlTextWriterWriteFormatPI (byval writer as xmlTextWriterPtr, byval target as zstring ptr, byval format as zstring ptr, ...) as integer
''''''' declare function xmlTextWriterWriteVFormatPI (byval writer as xmlTextWriterPtr, byval target as zstring ptr, byval format as zstring ptr, byval argptr as va_list) as integer
declare function xmlTextWriterWritePI (byval writer as xmlTextWriterPtr, byval target as zstring ptr, byval content as zstring ptr) as integer
declare function xmlTextWriterStartCDATA (byval writer as xmlTextWriterPtr) as integer
declare function xmlTextWriterEndCDATA (byval writer as xmlTextWriterPtr) as integer
declare function xmlTextWriterWriteFormatCDATA (byval writer as xmlTextWriterPtr, byval format as zstring ptr, ...) as integer
''''''' declare function xmlTextWriterWriteVFormatCDATA (byval writer as xmlTextWriterPtr, byval format as zstring ptr, byval argptr as va_list) as integer
declare function xmlTextWriterWriteCDATA (byval writer as xmlTextWriterPtr, byval content as zstring ptr) as integer
declare function xmlTextWriterStartDTD (byval writer as xmlTextWriterPtr, byval name as zstring ptr, byval pubid as zstring ptr, byval sysid as zstring ptr) as integer
declare function xmlTextWriterEndDTD (byval writer as xmlTextWriterPtr) as integer
declare function xmlTextWriterWriteFormatDTD (byval writer as xmlTextWriterPtr, byval name as zstring ptr, byval pubid as zstring ptr, byval sysid as zstring ptr, byval format as zstring ptr, ...) as integer
''''''' declare function xmlTextWriterWriteVFormatDTD (byval writer as xmlTextWriterPtr, byval name as zstring ptr, byval pubid as zstring ptr, byval sysid as zstring ptr, byval format as zstring ptr, byval argptr as va_list) as integer
declare function xmlTextWriterWriteDTD (byval writer as xmlTextWriterPtr, byval name as zstring ptr, byval pubid as zstring ptr, byval sysid as zstring ptr, byval subset as zstring ptr) as integer
declare function xmlTextWriterStartDTDElement (byval writer as xmlTextWriterPtr, byval name as zstring ptr) as integer
declare function xmlTextWriterEndDTDElement (byval writer as xmlTextWriterPtr) as integer
declare function xmlTextWriterWriteFormatDTDElement (byval writer as xmlTextWriterPtr, byval name as zstring ptr, byval format as zstring ptr, ...) as integer
''''''' declare function xmlTextWriterWriteVFormatDTDElement (byval writer as xmlTextWriterPtr, byval name as zstring ptr, byval format as zstring ptr, byval argptr as va_list) as integer
declare function xmlTextWriterWriteDTDElement (byval writer as xmlTextWriterPtr, byval name as zstring ptr, byval content as zstring ptr) as integer
declare function xmlTextWriterStartDTDAttlist (byval writer as xmlTextWriterPtr, byval name as zstring ptr) as integer
declare function xmlTextWriterEndDTDAttlist (byval writer as xmlTextWriterPtr) as integer
declare function xmlTextWriterWriteFormatDTDAttlist (byval writer as xmlTextWriterPtr, byval name as zstring ptr, byval format as zstring ptr, ...) as integer
''''''' declare function xmlTextWriterWriteVFormatDTDAttlist (byval writer as xmlTextWriterPtr, byval name as zstring ptr, byval format as zstring ptr, byval argptr as va_list) as integer
declare function xmlTextWriterWriteDTDAttlist (byval writer as xmlTextWriterPtr, byval name as zstring ptr, byval content as zstring ptr) as integer
declare function xmlTextWriterStartDTDEntity (byval writer as xmlTextWriterPtr, byval pe as integer, byval name as zstring ptr) as integer
declare function xmlTextWriterEndDTDEntity (byval writer as xmlTextWriterPtr) as integer
declare function xmlTextWriterWriteFormatDTDInternalEntity (byval writer as xmlTextWriterPtr, byval pe as integer, byval name as zstring ptr, byval format as zstring ptr, ...) as integer
''''''' declare function xmlTextWriterWriteVFormatDTDInternalEntity (byval writer as xmlTextWriterPtr, byval pe as integer, byval name as zstring ptr, byval format as zstring ptr, byval argptr as va_list) as integer
declare function xmlTextWriterWriteDTDInternalEntity (byval writer as xmlTextWriterPtr, byval pe as integer, byval name as zstring ptr, byval content as zstring ptr) as integer
declare function xmlTextWriterWriteDTDExternalEntity (byval writer as xmlTextWriterPtr, byval pe as integer, byval name as zstring ptr, byval pubid as zstring ptr, byval sysid as zstring ptr, byval ndataid as zstring ptr) as integer
declare function xmlTextWriterWriteDTDExternalEntityContents (byval writer as xmlTextWriterPtr, byval pubid as zstring ptr, byval sysid as zstring ptr, byval ndataid as zstring ptr) as integer
declare function xmlTextWriterWriteDTDEntity (byval writer as xmlTextWriterPtr, byval pe as integer, byval name as zstring ptr, byval pubid as zstring ptr, byval sysid as zstring ptr, byval ndataid as zstring ptr, byval content as zstring ptr) as integer
declare function xmlTextWriterWriteDTDNotation (byval writer as xmlTextWriterPtr, byval name as zstring ptr, byval pubid as zstring ptr, byval sysid as zstring ptr) as integer
declare function xmlTextWriterSetIndent (byval writer as xmlTextWriterPtr, byval indent as integer) as integer
declare function xmlTextWriterSetIndentString (byval writer as xmlTextWriterPtr, byval str as zstring ptr) as integer
declare function xmlTextWriterFlush (byval writer as xmlTextWriterPtr) as integer
end extern

#endif
