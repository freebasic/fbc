''
''
'' threads -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __threads_bi__
#define __threads_bi__

#include once "libxml/xmlversion.bi"

type xmlMutex as _xmlMutex
type xmlMutexPtr as xmlMutex ptr
type xmlRMutex as _xmlRMutex
type xmlRMutexPtr as xmlRMutex ptr

#include once "libxml/globals.bi"

declare function xmlNewMutex cdecl alias "xmlNewMutex" () as xmlMutexPtr
declare sub xmlMutexLock cdecl alias "xmlMutexLock" (byval tok as xmlMutexPtr)
declare sub xmlMutexUnlock cdecl alias "xmlMutexUnlock" (byval tok as xmlMutexPtr)
declare sub xmlFreeMutex cdecl alias "xmlFreeMutex" (byval tok as xmlMutexPtr)
declare function xmlNewRMutex cdecl alias "xmlNewRMutex" () as xmlRMutexPtr
declare sub xmlRMutexLock cdecl alias "xmlRMutexLock" (byval tok as xmlRMutexPtr)
declare sub xmlRMutexUnlock cdecl alias "xmlRMutexUnlock" (byval tok as xmlRMutexPtr)
declare sub xmlFreeRMutex cdecl alias "xmlFreeRMutex" (byval tok as xmlRMutexPtr)
declare sub xmlInitThreads cdecl alias "xmlInitThreads" ()
declare sub xmlLockLibrary cdecl alias "xmlLockLibrary" ()
declare sub xmlUnlockLibrary cdecl alias "xmlUnlockLibrary" ()
declare function xmlGetThreadId cdecl alias "xmlGetThreadId" () as integer
declare function xmlIsMainThread cdecl alias "xmlIsMainThread" () as integer
declare sub xmlCleanupThreads cdecl alias "xmlCleanupThreads" ()
declare function xmlGetGlobalState cdecl alias "xmlGetGlobalState" () as xmlGlobalStatePtr

#endif
