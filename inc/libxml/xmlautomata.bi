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
#include once "libxml/xmlregexp.bi"

extern "C"

#define __XML_AUTOMATA_H__
type xmlAutomata as _xmlAutomata
type xmlAutomataPtr as xmlAutomata ptr
type xmlAutomataState as _xmlAutomataState
type xmlAutomataStatePtr as xmlAutomataState ptr

declare function xmlNewAutomata() as xmlAutomataPtr
declare sub xmlFreeAutomata(byval am as xmlAutomataPtr)
declare function xmlAutomataGetInitState(byval am as xmlAutomataPtr) as xmlAutomataStatePtr
declare function xmlAutomataSetFinalState(byval am as xmlAutomataPtr, byval state as xmlAutomataStatePtr) as long
declare function xmlAutomataNewState(byval am as xmlAutomataPtr) as xmlAutomataStatePtr
declare function xmlAutomataNewTransition(byval am as xmlAutomataPtr, byval from as xmlAutomataStatePtr, byval to as xmlAutomataStatePtr, byval token as const xmlChar ptr, byval data as any ptr) as xmlAutomataStatePtr
declare function xmlAutomataNewTransition2(byval am as xmlAutomataPtr, byval from as xmlAutomataStatePtr, byval to as xmlAutomataStatePtr, byval token as const xmlChar ptr, byval token2 as const xmlChar ptr, byval data as any ptr) as xmlAutomataStatePtr
declare function xmlAutomataNewNegTrans(byval am as xmlAutomataPtr, byval from as xmlAutomataStatePtr, byval to as xmlAutomataStatePtr, byval token as const xmlChar ptr, byval token2 as const xmlChar ptr, byval data as any ptr) as xmlAutomataStatePtr
declare function xmlAutomataNewCountTrans(byval am as xmlAutomataPtr, byval from as xmlAutomataStatePtr, byval to as xmlAutomataStatePtr, byval token as const xmlChar ptr, byval min as long, byval max as long, byval data as any ptr) as xmlAutomataStatePtr
declare function xmlAutomataNewCountTrans2(byval am as xmlAutomataPtr, byval from as xmlAutomataStatePtr, byval to as xmlAutomataStatePtr, byval token as const xmlChar ptr, byval token2 as const xmlChar ptr, byval min as long, byval max as long, byval data as any ptr) as xmlAutomataStatePtr
declare function xmlAutomataNewOnceTrans(byval am as xmlAutomataPtr, byval from as xmlAutomataStatePtr, byval to as xmlAutomataStatePtr, byval token as const xmlChar ptr, byval min as long, byval max as long, byval data as any ptr) as xmlAutomataStatePtr
declare function xmlAutomataNewOnceTrans2(byval am as xmlAutomataPtr, byval from as xmlAutomataStatePtr, byval to as xmlAutomataStatePtr, byval token as const xmlChar ptr, byval token2 as const xmlChar ptr, byval min as long, byval max as long, byval data as any ptr) as xmlAutomataStatePtr
declare function xmlAutomataNewAllTrans(byval am as xmlAutomataPtr, byval from as xmlAutomataStatePtr, byval to as xmlAutomataStatePtr, byval lax as long) as xmlAutomataStatePtr
declare function xmlAutomataNewEpsilon(byval am as xmlAutomataPtr, byval from as xmlAutomataStatePtr, byval to as xmlAutomataStatePtr) as xmlAutomataStatePtr
declare function xmlAutomataNewCountedTrans(byval am as xmlAutomataPtr, byval from as xmlAutomataStatePtr, byval to as xmlAutomataStatePtr, byval counter as long) as xmlAutomataStatePtr
declare function xmlAutomataNewCounterTrans(byval am as xmlAutomataPtr, byval from as xmlAutomataStatePtr, byval to as xmlAutomataStatePtr, byval counter as long) as xmlAutomataStatePtr
declare function xmlAutomataNewCounter(byval am as xmlAutomataPtr, byval min as long, byval max as long) as long
declare function xmlAutomataCompile(byval am as xmlAutomataPtr) as xmlRegexpPtr
declare function xmlAutomataIsDeterminist(byval am as xmlAutomataPtr) as long

end extern
