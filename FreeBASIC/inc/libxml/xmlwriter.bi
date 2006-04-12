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

#include once "libxml/xmlversion.bi"
#include once "libxml/xmlIO.bi"
#include once "libxml/list.bi"
#include once "libxml/xmlstring.bi"

type xmlTextWriter as _xmlTextWriter
type xmlTextWriterPtr as xmlTextWriter ptr

declare function xmlNewTextWriter cdecl alias "xmlNewTextWriter" (byval out as xmlOutputBufferPtr) as xmlTextWriterPtr
declare function xmlNewTextWriterFilename cdecl alias "xmlNewTextWriterFilename" (byval uri as zstring ptr, byval compression as integer) as xmlTextWriterPtr
declare function xmlNewTextWriterMemory cdecl alias "xmlNewTextWriterMemory" (byval buf as xmlBufferPtr, byval compression as integer) as xmlTextWriterPtr
declare function xmlNewTextWriterPushParser cdecl alias "xmlNewTextWriterPushParser" (byval ctxt as xmlParserCtxtPtr, byval compression as integer) as xmlTextWriterPtr
declare function xmlNewTextWriterDoc cdecl alias "xmlNewTextWriterDoc" (byval doc as xmlDocPtr ptr, byval compression as integer) as xmlTextWriterPtr
declare function xmlNewTextWriterTree cdecl alias "xmlNewTextWriterTree" (byval doc as xmlDocPtr, byval node as xmlNodePtr, byval compression as integer) as xmlTextWriterPtr
declare sub xmlFreeTextWriter cdecl alias "xmlFreeTextWriter" (byval writer as xmlTextWriterPtr)
declare function xmlTextWriterStartDocument cdecl alias "xmlTextWriterStartDocument" (byval writer as xmlTextWriterPtr, byval version as zstring ptr, byval encoding as zstring ptr, byval standalone as zstring ptr) as integer
declare function xmlTextWriterEndDocument cdecl alias "xmlTextWriterEndDocument" (byval writer as xmlTextWriterPtr) as integer
declare function xmlTextWriterStartComment cdecl alias "xmlTextWriterStartComment" (byval writer as xmlTextWriterPtr) as integer
declare function xmlTextWriterEndComment cdecl alias "xmlTextWriterEndComment" (byval writer as xmlTextWriterPtr) as integer
declare function xmlTextWriterWriteFormatComment cdecl alias "xmlTextWriterWriteFormatComment" (byval writer as xmlTextWriterPtr, byval format as zstring ptr, ...) as integer
''''''' declare function xmlTextWriterWriteVFormatComment cdecl alias "xmlTextWriterWriteVFormatComment" (byval writer as xmlTextWriterPtr, byval format as zstring ptr, byval argptr as va_list) as integer
declare function xmlTextWriterWriteComment cdecl alias "xmlTextWriterWriteComment" (byval writer as xmlTextWriterPtr, byval content as zstring ptr) as integer
declare function xmlTextWriterStartElement cdecl alias "xmlTextWriterStartElement" (byval writer as xmlTextWriterPtr, byval name as zstring ptr) as integer
declare function xmlTextWriterStartElementNS cdecl alias "xmlTextWriterStartElementNS" (byval writer as xmlTextWriterPtr, byval prefix as zstring ptr, byval name as zstring ptr, byval namespaceURI as zstring ptr) as integer
declare function xmlTextWriterEndElement cdecl alias "xmlTextWriterEndElement" (byval writer as xmlTextWriterPtr) as integer
declare function xmlTextWriterFullEndElement cdecl alias "xmlTextWriterFullEndElement" (byval writer as xmlTextWriterPtr) as integer
declare function xmlTextWriterWriteFormatElement cdecl alias "xmlTextWriterWriteFormatElement" (byval writer as xmlTextWriterPtr, byval name as zstring ptr, byval format as zstring ptr, ...) as integer
''''''' declare function xmlTextWriterWriteVFormatElement cdecl alias "xmlTextWriterWriteVFormatElement" (byval writer as xmlTextWriterPtr, byval name as zstring ptr, byval format as zstring ptr, byval argptr as va_list) as integer
declare function xmlTextWriterWriteElement cdecl alias "xmlTextWriterWriteElement" (byval writer as xmlTextWriterPtr, byval name as zstring ptr, byval content as zstring ptr) as integer
declare function xmlTextWriterWriteFormatElementNS cdecl alias "xmlTextWriterWriteFormatElementNS" (byval writer as xmlTextWriterPtr, byval prefix as zstring ptr, byval name as zstring ptr, byval namespaceURI as zstring ptr, byval format as zstring ptr, ...) as integer
''''''' declare function xmlTextWriterWriteVFormatElementNS cdecl alias "xmlTextWriterWriteVFormatElementNS" (byval writer as xmlTextWriterPtr, byval prefix as zstring ptr, byval name as zstring ptr, byval namespaceURI as zstring ptr, byval format as zstring ptr, byval argptr as va_list) as integer
declare function xmlTextWriterWriteElementNS cdecl alias "xmlTextWriterWriteElementNS" (byval writer as xmlTextWriterPtr, byval prefix as zstring ptr, byval name as zstring ptr, byval namespaceURI as zstring ptr, byval content as zstring ptr) as integer
declare function xmlTextWriterWriteFormatRaw cdecl alias "xmlTextWriterWriteFormatRaw" (byval writer as xmlTextWriterPtr, byval format as zstring ptr, ...) as integer
''''''' declare function xmlTextWriterWriteVFormatRaw cdecl alias "xmlTextWriterWriteVFormatRaw" (byval writer as xmlTextWriterPtr, byval format as zstring ptr, byval argptr as va_list) as integer
declare function xmlTextWriterWriteRawLen cdecl alias "xmlTextWriterWriteRawLen" (byval writer as xmlTextWriterPtr, byval content as zstring ptr, byval len as integer) as integer
declare function xmlTextWriterWriteRaw cdecl alias "xmlTextWriterWriteRaw" (byval writer as xmlTextWriterPtr, byval content as zstring ptr) as integer
declare function xmlTextWriterWriteFormatString cdecl alias "xmlTextWriterWriteFormatString" (byval writer as xmlTextWriterPtr, byval format as zstring ptr, ...) as integer
''''''' declare function xmlTextWriterWriteVFormatString cdecl alias "xmlTextWriterWriteVFormatString" (byval writer as xmlTextWriterPtr, byval format as zstring ptr, byval argptr as va_list) as integer
declare function xmlTextWriterWriteString cdecl alias "xmlTextWriterWriteString" (byval writer as xmlTextWriterPtr, byval content as zstring ptr) as integer
declare function xmlTextWriterWriteBase64 cdecl alias "xmlTextWriterWriteBase64" (byval writer as xmlTextWriterPtr, byval data as zstring ptr, byval start as integer, byval len as integer) as integer
declare function xmlTextWriterWriteBinHex cdecl alias "xmlTextWriterWriteBinHex" (byval writer as xmlTextWriterPtr, byval data as zstring ptr, byval start as integer, byval len as integer) as integer
declare function xmlTextWriterStartAttribute cdecl alias "xmlTextWriterStartAttribute" (byval writer as xmlTextWriterPtr, byval name as zstring ptr) as integer
declare function xmlTextWriterStartAttributeNS cdecl alias "xmlTextWriterStartAttributeNS" (byval writer as xmlTextWriterPtr, byval prefix as zstring ptr, byval name as zstring ptr, byval namespaceURI as zstring ptr) as integer
declare function xmlTextWriterEndAttribute cdecl alias "xmlTextWriterEndAttribute" (byval writer as xmlTextWriterPtr) as integer
declare function xmlTextWriterWriteFormatAttribute cdecl alias "xmlTextWriterWriteFormatAttribute" (byval writer as xmlTextWriterPtr, byval name as zstring ptr, byval format as zstring ptr, ...) as integer
''''''' declare function xmlTextWriterWriteVFormatAttribute cdecl alias "xmlTextWriterWriteVFormatAttribute" (byval writer as xmlTextWriterPtr, byval name as zstring ptr, byval format as zstring ptr, byval argptr as va_list) as integer
declare function xmlTextWriterWriteAttribute cdecl alias "xmlTextWriterWriteAttribute" (byval writer as xmlTextWriterPtr, byval name as zstring ptr, byval content as zstring ptr) as integer
declare function xmlTextWriterWriteFormatAttributeNS cdecl alias "xmlTextWriterWriteFormatAttributeNS" (byval writer as xmlTextWriterPtr, byval prefix as zstring ptr, byval name as zstring ptr, byval namespaceURI as zstring ptr, byval format as zstring ptr, ...) as integer
''''''' declare function xmlTextWriterWriteVFormatAttributeNS cdecl alias "xmlTextWriterWriteVFormatAttributeNS" (byval writer as xmlTextWriterPtr, byval prefix as zstring ptr, byval name as zstring ptr, byval namespaceURI as zstring ptr, byval format as zstring ptr, byval argptr as va_list) as integer
declare function xmlTextWriterWriteAttributeNS cdecl alias "xmlTextWriterWriteAttributeNS" (byval writer as xmlTextWriterPtr, byval prefix as zstring ptr, byval name as zstring ptr, byval namespaceURI as zstring ptr, byval content as zstring ptr) as integer
declare function xmlTextWriterStartPI cdecl alias "xmlTextWriterStartPI" (byval writer as xmlTextWriterPtr, byval target as zstring ptr) as integer
declare function xmlTextWriterEndPI cdecl alias "xmlTextWriterEndPI" (byval writer as xmlTextWriterPtr) as integer
declare function xmlTextWriterWriteFormatPI cdecl alias "xmlTextWriterWriteFormatPI" (byval writer as xmlTextWriterPtr, byval target as zstring ptr, byval format as zstring ptr, ...) as integer
''''''' declare function xmlTextWriterWriteVFormatPI cdecl alias "xmlTextWriterWriteVFormatPI" (byval writer as xmlTextWriterPtr, byval target as zstring ptr, byval format as zstring ptr, byval argptr as va_list) as integer
declare function xmlTextWriterWritePI cdecl alias "xmlTextWriterWritePI" (byval writer as xmlTextWriterPtr, byval target as zstring ptr, byval content as zstring ptr) as integer
declare function xmlTextWriterStartCDATA cdecl alias "xmlTextWriterStartCDATA" (byval writer as xmlTextWriterPtr) as integer
declare function xmlTextWriterEndCDATA cdecl alias "xmlTextWriterEndCDATA" (byval writer as xmlTextWriterPtr) as integer
declare function xmlTextWriterWriteFormatCDATA cdecl alias "xmlTextWriterWriteFormatCDATA" (byval writer as xmlTextWriterPtr, byval format as zstring ptr, ...) as integer
''''''' declare function xmlTextWriterWriteVFormatCDATA cdecl alias "xmlTextWriterWriteVFormatCDATA" (byval writer as xmlTextWriterPtr, byval format as zstring ptr, byval argptr as va_list) as integer
declare function xmlTextWriterWriteCDATA cdecl alias "xmlTextWriterWriteCDATA" (byval writer as xmlTextWriterPtr, byval content as zstring ptr) as integer
declare function xmlTextWriterStartDTD cdecl alias "xmlTextWriterStartDTD" (byval writer as xmlTextWriterPtr, byval name as zstring ptr, byval pubid as zstring ptr, byval sysid as zstring ptr) as integer
declare function xmlTextWriterEndDTD cdecl alias "xmlTextWriterEndDTD" (byval writer as xmlTextWriterPtr) as integer
declare function xmlTextWriterWriteFormatDTD cdecl alias "xmlTextWriterWriteFormatDTD" (byval writer as xmlTextWriterPtr, byval name as zstring ptr, byval pubid as zstring ptr, byval sysid as zstring ptr, byval format as zstring ptr, ...) as integer
''''''' declare function xmlTextWriterWriteVFormatDTD cdecl alias "xmlTextWriterWriteVFormatDTD" (byval writer as xmlTextWriterPtr, byval name as zstring ptr, byval pubid as zstring ptr, byval sysid as zstring ptr, byval format as zstring ptr, byval argptr as va_list) as integer
declare function xmlTextWriterWriteDTD cdecl alias "xmlTextWriterWriteDTD" (byval writer as xmlTextWriterPtr, byval name as zstring ptr, byval pubid as zstring ptr, byval sysid as zstring ptr, byval subset as zstring ptr) as integer
declare function xmlTextWriterStartDTDElement cdecl alias "xmlTextWriterStartDTDElement" (byval writer as xmlTextWriterPtr, byval name as zstring ptr) as integer
declare function xmlTextWriterEndDTDElement cdecl alias "xmlTextWriterEndDTDElement" (byval writer as xmlTextWriterPtr) as integer
declare function xmlTextWriterWriteFormatDTDElement cdecl alias "xmlTextWriterWriteFormatDTDElement" (byval writer as xmlTextWriterPtr, byval name as zstring ptr, byval format as zstring ptr, ...) as integer
''''''' declare function xmlTextWriterWriteVFormatDTDElement cdecl alias "xmlTextWriterWriteVFormatDTDElement" (byval writer as xmlTextWriterPtr, byval name as zstring ptr, byval format as zstring ptr, byval argptr as va_list) as integer
declare function xmlTextWriterWriteDTDElement cdecl alias "xmlTextWriterWriteDTDElement" (byval writer as xmlTextWriterPtr, byval name as zstring ptr, byval content as zstring ptr) as integer
declare function xmlTextWriterStartDTDAttlist cdecl alias "xmlTextWriterStartDTDAttlist" (byval writer as xmlTextWriterPtr, byval name as zstring ptr) as integer
declare function xmlTextWriterEndDTDAttlist cdecl alias "xmlTextWriterEndDTDAttlist" (byval writer as xmlTextWriterPtr) as integer
declare function xmlTextWriterWriteFormatDTDAttlist cdecl alias "xmlTextWriterWriteFormatDTDAttlist" (byval writer as xmlTextWriterPtr, byval name as zstring ptr, byval format as zstring ptr, ...) as integer
''''''' declare function xmlTextWriterWriteVFormatDTDAttlist cdecl alias "xmlTextWriterWriteVFormatDTDAttlist" (byval writer as xmlTextWriterPtr, byval name as zstring ptr, byval format as zstring ptr, byval argptr as va_list) as integer
declare function xmlTextWriterWriteDTDAttlist cdecl alias "xmlTextWriterWriteDTDAttlist" (byval writer as xmlTextWriterPtr, byval name as zstring ptr, byval content as zstring ptr) as integer
declare function xmlTextWriterStartDTDEntity cdecl alias "xmlTextWriterStartDTDEntity" (byval writer as xmlTextWriterPtr, byval pe as integer, byval name as zstring ptr) as integer
declare function xmlTextWriterEndDTDEntity cdecl alias "xmlTextWriterEndDTDEntity" (byval writer as xmlTextWriterPtr) as integer
declare function xmlTextWriterWriteFormatDTDInternalEntity cdecl alias "xmlTextWriterWriteFormatDTDInternalEntity" (byval writer as xmlTextWriterPtr, byval pe as integer, byval name as zstring ptr, byval format as zstring ptr, ...) as integer
''''''' declare function xmlTextWriterWriteVFormatDTDInternalEntity cdecl alias "xmlTextWriterWriteVFormatDTDInternalEntity" (byval writer as xmlTextWriterPtr, byval pe as integer, byval name as zstring ptr, byval format as zstring ptr, byval argptr as va_list) as integer
declare function xmlTextWriterWriteDTDInternalEntity cdecl alias "xmlTextWriterWriteDTDInternalEntity" (byval writer as xmlTextWriterPtr, byval pe as integer, byval name as zstring ptr, byval content as zstring ptr) as integer
declare function xmlTextWriterWriteDTDExternalEntity cdecl alias "xmlTextWriterWriteDTDExternalEntity" (byval writer as xmlTextWriterPtr, byval pe as integer, byval name as zstring ptr, byval pubid as zstring ptr, byval sysid as zstring ptr, byval ndataid as zstring ptr) as integer
declare function xmlTextWriterWriteDTDExternalEntityContents cdecl alias "xmlTextWriterWriteDTDExternalEntityContents" (byval writer as xmlTextWriterPtr, byval pubid as zstring ptr, byval sysid as zstring ptr, byval ndataid as zstring ptr) as integer
declare function xmlTextWriterWriteDTDEntity cdecl alias "xmlTextWriterWriteDTDEntity" (byval writer as xmlTextWriterPtr, byval pe as integer, byval name as zstring ptr, byval pubid as zstring ptr, byval sysid as zstring ptr, byval ndataid as zstring ptr, byval content as zstring ptr) as integer
declare function xmlTextWriterWriteDTDNotation cdecl alias "xmlTextWriterWriteDTDNotation" (byval writer as xmlTextWriterPtr, byval name as zstring ptr, byval pubid as zstring ptr, byval sysid as zstring ptr) as integer
declare function xmlTextWriterSetIndent cdecl alias "xmlTextWriterSetIndent" (byval writer as xmlTextWriterPtr, byval indent as integer) as integer
declare function xmlTextWriterSetIndentString cdecl alias "xmlTextWriterSetIndentString" (byval writer as xmlTextWriterPtr, byval str as zstring ptr) as integer
declare function xmlTextWriterFlush cdecl alias "xmlTextWriterFlush" (byval writer as xmlTextWriterPtr) as integer

#endif
