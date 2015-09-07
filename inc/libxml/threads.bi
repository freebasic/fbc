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
#include once "libxml/globals.bi"

extern "C"

#define __XML_THREADS_H__
type xmlMutex as _xmlMutex
type xmlMutexPtr as xmlMutex ptr
type xmlRMutex as _xmlRMutex
type xmlRMutexPtr as xmlRMutex ptr

declare function xmlNewMutex() as xmlMutexPtr
declare sub xmlMutexLock(byval tok as xmlMutexPtr)
declare sub xmlMutexUnlock(byval tok as xmlMutexPtr)
declare sub xmlFreeMutex(byval tok as xmlMutexPtr)
declare function xmlNewRMutex() as xmlRMutexPtr
declare sub xmlRMutexLock(byval tok as xmlRMutexPtr)
declare sub xmlRMutexUnlock(byval tok as xmlRMutexPtr)
declare sub xmlFreeRMutex(byval tok as xmlRMutexPtr)
declare sub xmlInitThreads()
declare sub xmlLockLibrary()
declare sub xmlUnlockLibrary()
declare function xmlGetThreadId() as long
declare function xmlIsMainThread() as long
declare sub xmlCleanupThreads()
declare function xmlGetGlobalState() as xmlGlobalStatePtr

end extern
