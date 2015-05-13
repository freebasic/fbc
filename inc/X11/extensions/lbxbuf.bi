''
''
'' lbxbuf -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __lbxbuf_bi__
#define __lbxbuf_bi__

#define INBUFFER_SIZE (1 shl 13)
#define OUTBUFFER_SIZE (1 shl 12)
#define TRUE 1
#define FALSE 0

type ZlibBufferPtr as _zlibbuffer ptr

declare sub FreeZlibBuffer cdecl alias "FreeZlibBuffer" (byval b as ZlibBufferPtr)
declare function ReserveOutBuf cdecl alias "ReserveOutBuf" (byval outbuf as ZlibBufferPtr, byval outlen as integer) as zstring ptr

#endif
