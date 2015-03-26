#pragma once

extern "C"

#define _ZLIB_H_
#define ZLIB_STRCOMP_OPT "XC-ZLIB"
const ZLIB_STRCOMP_OPT_LEN = 7
const ZLIB_PACKET_HDRLEN = 2
const ZLIB_MAX_DATALEN = &hfff
const ZLIB_MAX_PLAIN = 270
#define ZLIB_MAX_OUTLEN (ZLIB_MAX_PLAIN shl 1)
const ZLIB_COMPRESS_FLAG = &h80
const ZLIB_DATALEN_MASK = &h0f
#macro ZLIB_PUT_PKTHDR(p, len, compflag)
	scope
		(p)[0] = (culng(len) shr 8) or iif(compflag, ZLIB_COMPRESS_FLAG, 0)
		(p)[1] = (len) and &hff
	end scope
#endmacro
#define ZLIB_GET_DATALEN(p) culng(culng(culng((p)[0] and ZLIB_DATALEN_MASK) shl 8) or culng((p)[1]))
#define ZLIB_COMPRESSED(p) ((p)[0] and ZLIB_COMPRESS_FLAG)
declare function ZlibInit(byval fd as long, byval level as long) as any ptr
type ZlibInfo as ZlibInfo_

declare sub ZlibFree(byval comp as ZlibInfo ptr)
declare function ZlibFlush(byval fd as long) as long
declare function ZlibStuffInput(byval fd as long, byval buffer as ubyte ptr, byval buflen as long) as long
declare sub ZlibCompressOn(byval fd as long)
declare sub ZlibCompressOff(byval fd as long)
declare function ZlibWrite(byval fd as long, byval buffer as ubyte ptr, byval buflen as long) as long
declare function ZlibWriteV(byval fd as long, byval iov as iovec ptr, byval iovcnt as long) as long
declare function ZlibRead(byval fd as long, byval buffer as ubyte ptr, byval buflen as long) as long
declare function ZlibInputAvail(byval fd as long) as long

end extern
