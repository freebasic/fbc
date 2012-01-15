''
''
'' threads -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __xml_threads_bi__
#define __xml_threads_bi__

#include once "xmlversion.bi"

type xmlMutex as _xmlMutex
type xmlMutexPtr as xmlMutex ptr
type xmlRMutex as _xmlRMutex
type xmlRMutexPtr as xmlRMutex ptr

#include once "globals.bi"

extern "c"
declare function xmlNewMutex () as xmlMutexPtr
declare sub xmlMutexLock (byval tok as xmlMutexPtr)
declare sub xmlMutexUnlock (byval tok as xmlMutexPtr)
declare sub xmlFreeMutex (byval tok as xmlMutexPtr)
declare function xmlNewRMutex () as xmlRMutexPtr
declare sub xmlRMutexLock (byval tok as xmlRMutexPtr)
declare sub xmlRMutexUnlock (byval tok as xmlRMutexPtr)
declare sub xmlFreeRMutex (byval tok as xmlRMutexPtr)
declare sub xmlInitThreads ()
declare sub xmlLockLibrary ()
declare sub xmlUnlockLibrary ()
declare function xmlGetThreadId () as integer
declare function xmlIsMainThread () as integer
declare sub xmlCleanupThreads ()
declare function xmlGetGlobalState () as xmlGlobalStatePtr
end extern

#endif
