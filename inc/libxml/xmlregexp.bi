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

extern "C"

#define __XML_REGEXP_H__
type xmlRegexp as _xmlRegexp
type xmlRegexpPtr as xmlRegexp ptr
type xmlRegExecCtxt as _xmlRegExecCtxt
type xmlRegExecCtxtPtr as xmlRegExecCtxt ptr

end extern

#include once "libxml/tree.bi"
#include once "libxml/dict.bi"

extern "C"

declare function xmlRegexpCompile(byval regexp as const xmlChar ptr) as xmlRegexpPtr
declare sub xmlRegFreeRegexp(byval regexp as xmlRegexpPtr)
declare function xmlRegexpExec(byval comp as xmlRegexpPtr, byval value as const xmlChar ptr) as long
declare sub xmlRegexpPrint(byval output as FILE ptr, byval regexp as xmlRegexpPtr)
declare function xmlRegexpIsDeterminist(byval comp as xmlRegexpPtr) as long
type xmlRegExecCallbacks as sub(byval exec as xmlRegExecCtxtPtr, byval token as const xmlChar ptr, byval transdata as any ptr, byval inputdata as any ptr)
declare function xmlRegNewExecCtxt(byval comp as xmlRegexpPtr, byval callback as xmlRegExecCallbacks, byval data as any ptr) as xmlRegExecCtxtPtr
declare sub xmlRegFreeExecCtxt(byval exec as xmlRegExecCtxtPtr)
declare function xmlRegExecPushString(byval exec as xmlRegExecCtxtPtr, byval value as const xmlChar ptr, byval data as any ptr) as long
declare function xmlRegExecPushString2(byval exec as xmlRegExecCtxtPtr, byval value as const xmlChar ptr, byval value2 as const xmlChar ptr, byval data as any ptr) as long
declare function xmlRegExecNextValues(byval exec as xmlRegExecCtxtPtr, byval nbval as long ptr, byval nbneg as long ptr, byval values as xmlChar ptr ptr, byval terminal as long ptr) as long
declare function xmlRegExecErrInfo(byval exec as xmlRegExecCtxtPtr, byval string as const xmlChar ptr ptr, byval nbval as long ptr, byval nbneg as long ptr, byval values as xmlChar ptr ptr, byval terminal as long ptr) as long
type xmlExpCtxt as _xmlExpCtxt
type xmlExpCtxtPtr as xmlExpCtxt ptr
declare sub xmlExpFreeCtxt(byval ctxt as xmlExpCtxtPtr)
declare function xmlExpNewCtxt(byval maxNodes as long, byval dict as xmlDictPtr) as xmlExpCtxtPtr
declare function xmlExpCtxtNbNodes(byval ctxt as xmlExpCtxtPtr) as long
declare function xmlExpCtxtNbCons(byval ctxt as xmlExpCtxtPtr) as long
type xmlExpNode as _xmlExpNode
type xmlExpNodePtr as xmlExpNode ptr

type xmlExpNodeType as long
enum
	XML_EXP_EMPTY = 0
	XML_EXP_FORBID = 1
	XML_EXP_ATOM = 2
	XML_EXP_SEQ = 3
	XML_EXP_OR = 4
	XML_EXP_COUNT = 5
end enum

#if defined(__FB_WIN32__) and (not defined(LIBXML_STATIC))
	extern import forbiddenExp as xmlExpNodePtr
	extern import emptyExp as xmlExpNodePtr
#else
	extern forbiddenExp as xmlExpNodePtr
	extern emptyExp as xmlExpNodePtr
#endif

declare sub xmlExpFree(byval ctxt as xmlExpCtxtPtr, byval expr as xmlExpNodePtr)
declare sub xmlExpRef(byval expr as xmlExpNodePtr)
declare function xmlExpParse(byval ctxt as xmlExpCtxtPtr, byval expr as const zstring ptr) as xmlExpNodePtr
declare function xmlExpNewAtom(byval ctxt as xmlExpCtxtPtr, byval name as const xmlChar ptr, byval len as long) as xmlExpNodePtr
declare function xmlExpNewOr(byval ctxt as xmlExpCtxtPtr, byval left as xmlExpNodePtr, byval right as xmlExpNodePtr) as xmlExpNodePtr
declare function xmlExpNewSeq(byval ctxt as xmlExpCtxtPtr, byval left as xmlExpNodePtr, byval right as xmlExpNodePtr) as xmlExpNodePtr
declare function xmlExpNewRange(byval ctxt as xmlExpCtxtPtr, byval subset as xmlExpNodePtr, byval min as long, byval max as long) as xmlExpNodePtr
declare function xmlExpIsNillable(byval expr as xmlExpNodePtr) as long
declare function xmlExpMaxToken(byval expr as xmlExpNodePtr) as long
declare function xmlExpGetLanguage(byval ctxt as xmlExpCtxtPtr, byval expr as xmlExpNodePtr, byval langList as const xmlChar ptr ptr, byval len as long) as long
declare function xmlExpGetStart(byval ctxt as xmlExpCtxtPtr, byval expr as xmlExpNodePtr, byval tokList as const xmlChar ptr ptr, byval len as long) as long
declare function xmlExpStringDerive(byval ctxt as xmlExpCtxtPtr, byval expr as xmlExpNodePtr, byval str as const xmlChar ptr, byval len as long) as xmlExpNodePtr
declare function xmlExpExpDerive(byval ctxt as xmlExpCtxtPtr, byval expr as xmlExpNodePtr, byval sub as xmlExpNodePtr) as xmlExpNodePtr
declare function xmlExpSubsume(byval ctxt as xmlExpCtxtPtr, byval expr as xmlExpNodePtr, byval sub as xmlExpNodePtr) as long
declare sub xmlExpDump(byval buf as xmlBufferPtr, byval expr as xmlExpNodePtr)

end extern
