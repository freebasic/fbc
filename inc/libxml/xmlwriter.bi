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

#include once "libxml/xmlversion.bi"
#include once "crt/stdarg.bi"
#include once "libxml/xmlIO.bi"
#include once "libxml/list.bi"
#include once "libxml/xmlstring.bi"

extern "C"

#define __XML_XMLWRITER_H__
type xmlTextWriter as _xmlTextWriter
type xmlTextWriterPtr as xmlTextWriter ptr
declare function xmlNewTextWriter(byval out as xmlOutputBufferPtr) as xmlTextWriterPtr
declare function xmlNewTextWriterFilename(byval uri as const zstring ptr, byval compression as long) as xmlTextWriterPtr
declare function xmlNewTextWriterMemory(byval buf as xmlBufferPtr, byval compression as long) as xmlTextWriterPtr
declare function xmlNewTextWriterPushParser(byval ctxt as xmlParserCtxtPtr, byval compression as long) as xmlTextWriterPtr
declare function xmlNewTextWriterDoc(byval doc as xmlDocPtr ptr, byval compression as long) as xmlTextWriterPtr
declare function xmlNewTextWriterTree(byval doc as xmlDocPtr, byval node as xmlNodePtr, byval compression as long) as xmlTextWriterPtr
declare sub xmlFreeTextWriter(byval writer as xmlTextWriterPtr)
declare function xmlTextWriterStartDocument(byval writer as xmlTextWriterPtr, byval version as const zstring ptr, byval encoding as const zstring ptr, byval standalone as const zstring ptr) as long
declare function xmlTextWriterEndDocument(byval writer as xmlTextWriterPtr) as long
declare function xmlTextWriterStartComment(byval writer as xmlTextWriterPtr) as long
declare function xmlTextWriterEndComment(byval writer as xmlTextWriterPtr) as long
declare function xmlTextWriterWriteFormatComment(byval writer as xmlTextWriterPtr, byval format as const zstring ptr, ...) as long
declare function xmlTextWriterWriteVFormatComment(byval writer as xmlTextWriterPtr, byval format as const zstring ptr, byval argptr as va_list) as long
declare function xmlTextWriterWriteComment(byval writer as xmlTextWriterPtr, byval content as const xmlChar ptr) as long
declare function xmlTextWriterStartElement(byval writer as xmlTextWriterPtr, byval name as const xmlChar ptr) as long
declare function xmlTextWriterStartElementNS(byval writer as xmlTextWriterPtr, byval prefix as const xmlChar ptr, byval name as const xmlChar ptr, byval namespaceURI as const xmlChar ptr) as long
declare function xmlTextWriterEndElement(byval writer as xmlTextWriterPtr) as long
declare function xmlTextWriterFullEndElement(byval writer as xmlTextWriterPtr) as long
declare function xmlTextWriterWriteFormatElement(byval writer as xmlTextWriterPtr, byval name as const xmlChar ptr, byval format as const zstring ptr, ...) as long
declare function xmlTextWriterWriteVFormatElement(byval writer as xmlTextWriterPtr, byval name as const xmlChar ptr, byval format as const zstring ptr, byval argptr as va_list) as long
declare function xmlTextWriterWriteElement(byval writer as xmlTextWriterPtr, byval name as const xmlChar ptr, byval content as const xmlChar ptr) as long
declare function xmlTextWriterWriteFormatElementNS(byval writer as xmlTextWriterPtr, byval prefix as const xmlChar ptr, byval name as const xmlChar ptr, byval namespaceURI as const xmlChar ptr, byval format as const zstring ptr, ...) as long
declare function xmlTextWriterWriteVFormatElementNS(byval writer as xmlTextWriterPtr, byval prefix as const xmlChar ptr, byval name as const xmlChar ptr, byval namespaceURI as const xmlChar ptr, byval format as const zstring ptr, byval argptr as va_list) as long
declare function xmlTextWriterWriteElementNS(byval writer as xmlTextWriterPtr, byval prefix as const xmlChar ptr, byval name as const xmlChar ptr, byval namespaceURI as const xmlChar ptr, byval content as const xmlChar ptr) as long
declare function xmlTextWriterWriteFormatRaw(byval writer as xmlTextWriterPtr, byval format as const zstring ptr, ...) as long
declare function xmlTextWriterWriteVFormatRaw(byval writer as xmlTextWriterPtr, byval format as const zstring ptr, byval argptr as va_list) as long
declare function xmlTextWriterWriteRawLen(byval writer as xmlTextWriterPtr, byval content as const xmlChar ptr, byval len as long) as long
declare function xmlTextWriterWriteRaw(byval writer as xmlTextWriterPtr, byval content as const xmlChar ptr) as long
declare function xmlTextWriterWriteFormatString(byval writer as xmlTextWriterPtr, byval format as const zstring ptr, ...) as long
declare function xmlTextWriterWriteVFormatString(byval writer as xmlTextWriterPtr, byval format as const zstring ptr, byval argptr as va_list) as long
declare function xmlTextWriterWriteString(byval writer as xmlTextWriterPtr, byval content as const xmlChar ptr) as long
declare function xmlTextWriterWriteBase64(byval writer as xmlTextWriterPtr, byval data as const zstring ptr, byval start as long, byval len as long) as long
declare function xmlTextWriterWriteBinHex(byval writer as xmlTextWriterPtr, byval data as const zstring ptr, byval start as long, byval len as long) as long
declare function xmlTextWriterStartAttribute(byval writer as xmlTextWriterPtr, byval name as const xmlChar ptr) as long
declare function xmlTextWriterStartAttributeNS(byval writer as xmlTextWriterPtr, byval prefix as const xmlChar ptr, byval name as const xmlChar ptr, byval namespaceURI as const xmlChar ptr) as long
declare function xmlTextWriterEndAttribute(byval writer as xmlTextWriterPtr) as long
declare function xmlTextWriterWriteFormatAttribute(byval writer as xmlTextWriterPtr, byval name as const xmlChar ptr, byval format as const zstring ptr, ...) as long
declare function xmlTextWriterWriteVFormatAttribute(byval writer as xmlTextWriterPtr, byval name as const xmlChar ptr, byval format as const zstring ptr, byval argptr as va_list) as long
declare function xmlTextWriterWriteAttribute(byval writer as xmlTextWriterPtr, byval name as const xmlChar ptr, byval content as const xmlChar ptr) as long
declare function xmlTextWriterWriteFormatAttributeNS(byval writer as xmlTextWriterPtr, byval prefix as const xmlChar ptr, byval name as const xmlChar ptr, byval namespaceURI as const xmlChar ptr, byval format as const zstring ptr, ...) as long
declare function xmlTextWriterWriteVFormatAttributeNS(byval writer as xmlTextWriterPtr, byval prefix as const xmlChar ptr, byval name as const xmlChar ptr, byval namespaceURI as const xmlChar ptr, byval format as const zstring ptr, byval argptr as va_list) as long
declare function xmlTextWriterWriteAttributeNS(byval writer as xmlTextWriterPtr, byval prefix as const xmlChar ptr, byval name as const xmlChar ptr, byval namespaceURI as const xmlChar ptr, byval content as const xmlChar ptr) as long
declare function xmlTextWriterStartPI(byval writer as xmlTextWriterPtr, byval target as const xmlChar ptr) as long
declare function xmlTextWriterEndPI(byval writer as xmlTextWriterPtr) as long
declare function xmlTextWriterWriteFormatPI(byval writer as xmlTextWriterPtr, byval target as const xmlChar ptr, byval format as const zstring ptr, ...) as long
declare function xmlTextWriterWriteVFormatPI(byval writer as xmlTextWriterPtr, byval target as const xmlChar ptr, byval format as const zstring ptr, byval argptr as va_list) as long
declare function xmlTextWriterWritePI(byval writer as xmlTextWriterPtr, byval target as const xmlChar ptr, byval content as const xmlChar ptr) as long
declare function xmlTextWriterWriteProcessingInstruction alias "xmlTextWriterWritePI"(byval writer as xmlTextWriterPtr, byval target as const xmlChar ptr, byval content as const xmlChar ptr) as long
declare function xmlTextWriterStartCDATA(byval writer as xmlTextWriterPtr) as long
declare function xmlTextWriterEndCDATA(byval writer as xmlTextWriterPtr) as long
declare function xmlTextWriterWriteFormatCDATA(byval writer as xmlTextWriterPtr, byval format as const zstring ptr, ...) as long
declare function xmlTextWriterWriteVFormatCDATA(byval writer as xmlTextWriterPtr, byval format as const zstring ptr, byval argptr as va_list) as long
declare function xmlTextWriterWriteCDATA(byval writer as xmlTextWriterPtr, byval content as const xmlChar ptr) as long
declare function xmlTextWriterStartDTD(byval writer as xmlTextWriterPtr, byval name as const xmlChar ptr, byval pubid as const xmlChar ptr, byval sysid as const xmlChar ptr) as long
declare function xmlTextWriterEndDTD(byval writer as xmlTextWriterPtr) as long
declare function xmlTextWriterWriteFormatDTD(byval writer as xmlTextWriterPtr, byval name as const xmlChar ptr, byval pubid as const xmlChar ptr, byval sysid as const xmlChar ptr, byval format as const zstring ptr, ...) as long
declare function xmlTextWriterWriteVFormatDTD(byval writer as xmlTextWriterPtr, byval name as const xmlChar ptr, byval pubid as const xmlChar ptr, byval sysid as const xmlChar ptr, byval format as const zstring ptr, byval argptr as va_list) as long
declare function xmlTextWriterWriteDTD(byval writer as xmlTextWriterPtr, byval name as const xmlChar ptr, byval pubid as const xmlChar ptr, byval sysid as const xmlChar ptr, byval subset as const xmlChar ptr) as long
declare function xmlTextWriterWriteDocType alias "xmlTextWriterWriteDTD"(byval writer as xmlTextWriterPtr, byval name as const xmlChar ptr, byval pubid as const xmlChar ptr, byval sysid as const xmlChar ptr, byval subset as const xmlChar ptr) as long
declare function xmlTextWriterStartDTDElement(byval writer as xmlTextWriterPtr, byval name as const xmlChar ptr) as long
declare function xmlTextWriterEndDTDElement(byval writer as xmlTextWriterPtr) as long
declare function xmlTextWriterWriteFormatDTDElement(byval writer as xmlTextWriterPtr, byval name as const xmlChar ptr, byval format as const zstring ptr, ...) as long
declare function xmlTextWriterWriteVFormatDTDElement(byval writer as xmlTextWriterPtr, byval name as const xmlChar ptr, byval format as const zstring ptr, byval argptr as va_list) as long
declare function xmlTextWriterWriteDTDElement(byval writer as xmlTextWriterPtr, byval name as const xmlChar ptr, byval content as const xmlChar ptr) as long
declare function xmlTextWriterStartDTDAttlist(byval writer as xmlTextWriterPtr, byval name as const xmlChar ptr) as long
declare function xmlTextWriterEndDTDAttlist(byval writer as xmlTextWriterPtr) as long
declare function xmlTextWriterWriteFormatDTDAttlist(byval writer as xmlTextWriterPtr, byval name as const xmlChar ptr, byval format as const zstring ptr, ...) as long
declare function xmlTextWriterWriteVFormatDTDAttlist(byval writer as xmlTextWriterPtr, byval name as const xmlChar ptr, byval format as const zstring ptr, byval argptr as va_list) as long
declare function xmlTextWriterWriteDTDAttlist(byval writer as xmlTextWriterPtr, byval name as const xmlChar ptr, byval content as const xmlChar ptr) as long
declare function xmlTextWriterStartDTDEntity(byval writer as xmlTextWriterPtr, byval pe as long, byval name as const xmlChar ptr) as long
declare function xmlTextWriterEndDTDEntity(byval writer as xmlTextWriterPtr) as long
declare function xmlTextWriterWriteFormatDTDInternalEntity(byval writer as xmlTextWriterPtr, byval pe as long, byval name as const xmlChar ptr, byval format as const zstring ptr, ...) as long
declare function xmlTextWriterWriteVFormatDTDInternalEntity(byval writer as xmlTextWriterPtr, byval pe as long, byval name as const xmlChar ptr, byval format as const zstring ptr, byval argptr as va_list) as long
declare function xmlTextWriterWriteDTDInternalEntity(byval writer as xmlTextWriterPtr, byval pe as long, byval name as const xmlChar ptr, byval content as const xmlChar ptr) as long
declare function xmlTextWriterWriteDTDExternalEntity(byval writer as xmlTextWriterPtr, byval pe as long, byval name as const xmlChar ptr, byval pubid as const xmlChar ptr, byval sysid as const xmlChar ptr, byval ndataid as const xmlChar ptr) as long
declare function xmlTextWriterWriteDTDExternalEntityContents(byval writer as xmlTextWriterPtr, byval pubid as const xmlChar ptr, byval sysid as const xmlChar ptr, byval ndataid as const xmlChar ptr) as long
declare function xmlTextWriterWriteDTDEntity(byval writer as xmlTextWriterPtr, byval pe as long, byval name as const xmlChar ptr, byval pubid as const xmlChar ptr, byval sysid as const xmlChar ptr, byval ndataid as const xmlChar ptr, byval content as const xmlChar ptr) as long
declare function xmlTextWriterWriteDTDNotation(byval writer as xmlTextWriterPtr, byval name as const xmlChar ptr, byval pubid as const xmlChar ptr, byval sysid as const xmlChar ptr) as long
declare function xmlTextWriterSetIndent(byval writer as xmlTextWriterPtr, byval indent as long) as long
declare function xmlTextWriterSetIndentString(byval writer as xmlTextWriterPtr, byval str as const xmlChar ptr) as long
declare function xmlTextWriterSetQuoteChar(byval writer as xmlTextWriterPtr, byval quotechar as xmlChar) as long
declare function xmlTextWriterFlush(byval writer as xmlTextWriterPtr) as long

end extern
