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
#include once "libxml/tree.bi"

extern "C"

#define __XML_XLINK_H__
type xlinkHRef as xmlChar ptr
type xlinkRole as xmlChar ptr
type xlinkTitle as xmlChar ptr

type xlinkType as long
enum
	XLINK_TYPE_NONE = 0
	XLINK_TYPE_SIMPLE
	XLINK_TYPE_EXTENDED
	XLINK_TYPE_EXTENDED_SET
end enum

type xlinkShow as long
enum
	XLINK_SHOW_NONE = 0
	XLINK_SHOW_NEW
	XLINK_SHOW_EMBED
	XLINK_SHOW_REPLACE
end enum

type xlinkActuate as long
enum
	XLINK_ACTUATE_NONE = 0
	XLINK_ACTUATE_AUTO
	XLINK_ACTUATE_ONREQUEST
end enum

type xlinkNodeDetectFunc as sub(byval ctx as any ptr, byval node as xmlNodePtr)
type xlinkSimpleLinkFunk as sub(byval ctx as any ptr, byval node as xmlNodePtr, byval href as const xlinkHRef, byval role as const xlinkRole, byval title as const xlinkTitle)
type xlinkExtendedLinkFunk as sub(byval ctx as any ptr, byval node as xmlNodePtr, byval nbLocators as long, byval hrefs as const xlinkHRef ptr, byval roles as const xlinkRole ptr, byval nbArcs as long, byval from as const xlinkRole ptr, byval to as const xlinkRole ptr, byval show as xlinkShow ptr, byval actuate as xlinkActuate ptr, byval nbTitles as long, byval titles as const xlinkTitle ptr, byval langs as const xmlChar ptr ptr)
type xlinkExtendedLinkSetFunk as sub(byval ctx as any ptr, byval node as xmlNodePtr, byval nbLocators as long, byval hrefs as const xlinkHRef ptr, byval roles as const xlinkRole ptr, byval nbTitles as long, byval titles as const xlinkTitle ptr, byval langs as const xmlChar ptr ptr)
type xlinkHandler as _xlinkHandler
type xlinkHandlerPtr as xlinkHandler ptr

type _xlinkHandler
	simple as xlinkSimpleLinkFunk
	extended as xlinkExtendedLinkFunk
	set as xlinkExtendedLinkSetFunk
end type

declare function xlinkGetDefaultDetect() as xlinkNodeDetectFunc
declare sub xlinkSetDefaultDetect(byval func as xlinkNodeDetectFunc)
declare function xlinkGetDefaultHandler() as xlinkHandlerPtr
declare sub xlinkSetDefaultHandler(byval handler as xlinkHandlerPtr)
declare function xlinkIsLink(byval doc as xmlDocPtr, byval node as xmlNodePtr) as xlinkType

end extern
