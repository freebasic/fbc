''
''
'' jstypes -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __jstypes_bi__
#define __jstypes_bi__

#include once "crt/stddef.bi"
#include once "spidermonkey/jscpucfg.bi"

type JSUint8 as ubyte
type JSInt8 as byte
type JSUint16 as ushort
type JSInt16 as short
type JSUint32 as uinteger
type JSInt32 as integer
type JSInt64 as longint
type JSUint64 as ulongint
type JSIntn as integer
type JSUintn as uinteger
type JSFloat64 as double
type JSSize as size_t
type JSPtrdiff as ptrdiff_t
type JSUptrdiff as uinteger
type JSBool as JSIntn
type JSPackedBool as JSUint8
type JSWord as integer
type JSUword as uinteger

#include once "spidermonkey/jsotypes.bi"

#endif
