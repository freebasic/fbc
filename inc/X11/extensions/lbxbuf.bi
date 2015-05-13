#pragma once

#include once "X11/Xfuncproto.bi"

extern "C"

#define _BUFFER_H_
const INBUFFER_SIZE = 1 shl 13
const OUTBUFFER_SIZE = 1 shl 12
type ZlibBufferPtr as _zlibbuffer ptr

declare function InitZlibBuffer(byval b as ZlibBufferPtr, byval size as long) as long
declare sub FreeZlibBuffer(byval b as ZlibBufferPtr)
declare function ReserveOutBuf(byval outbuf as ZlibBufferPtr, byval outlen as long) as zstring ptr

end extern
