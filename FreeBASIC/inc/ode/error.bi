''
''
'' error -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __error_bi__
#define __error_bi__

#include once "ode/config.bi"

type dMessageFunction as any

declare sub dSetErrorHandler cdecl alias "dSetErrorHandler" (byval fn as dMessageFunction ptr)
declare sub dSetDebugHandler cdecl alias "dSetDebugHandler" (byval fn as dMessageFunction ptr)
declare sub dSetMessageHandler cdecl alias "dSetMessageHandler" (byval fn as dMessageFunction ptr)
declare function dGetErrorHandler cdecl alias "dGetErrorHandler" () as dMessageFunction ptr
declare function dGetDebugHandler cdecl alias "dGetDebugHandler" () as dMessageFunction ptr
declare function dGetMessageHandler cdecl alias "dGetMessageHandler" () as dMessageFunction ptr
declare sub dError cdecl alias "dError" (byval num as integer, byval msg as string, ...)
declare sub dDebug cdecl alias "dDebug" (byval num as integer, byval msg as string, ...)
declare sub dMessage cdecl alias "dMessage" (byval num as integer, byval msg as string, ...)

#endif
