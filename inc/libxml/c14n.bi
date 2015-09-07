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
#include once "libxml/xpath.bi"

extern "C"

#define __XML_C14N_H__

type xmlC14NMode as long
enum
	XML_C14N_1_0 = 0
	XML_C14N_EXCLUSIVE_1_0 = 1
	XML_C14N_1_1 = 2
end enum

declare function xmlC14NDocSaveTo(byval doc as xmlDocPtr, byval nodes as xmlNodeSetPtr, byval mode as long, byval inclusive_ns_prefixes as xmlChar ptr ptr, byval with_comments as long, byval buf as xmlOutputBufferPtr) as long
declare function xmlC14NDocDumpMemory(byval doc as xmlDocPtr, byval nodes as xmlNodeSetPtr, byval mode as long, byval inclusive_ns_prefixes as xmlChar ptr ptr, byval with_comments as long, byval doc_txt_ptr as xmlChar ptr ptr) as long
declare function xmlC14NDocSave(byval doc as xmlDocPtr, byval nodes as xmlNodeSetPtr, byval mode as long, byval inclusive_ns_prefixes as xmlChar ptr ptr, byval with_comments as long, byval filename as const zstring ptr, byval compression as long) as long
type xmlC14NIsVisibleCallback as function(byval user_data as any ptr, byval node as xmlNodePtr, byval parent as xmlNodePtr) as long
declare function xmlC14NExecute(byval doc as xmlDocPtr, byval is_visible_callback as xmlC14NIsVisibleCallback, byval user_data as any ptr, byval mode as long, byval inclusive_ns_prefixes as xmlChar ptr ptr, byval with_comments as long, byval buf as xmlOutputBufferPtr) as long

end extern
