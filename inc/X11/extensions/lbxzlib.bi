'' FreeBASIC binding for liblbxutil-1.1.0
''
'' based on the C header files:
''   Copyright 1993 Network Computing Devices
''
''   Permission to use, copy, modify, distribute, and sell this software and its
''   documentation for any purpose is hereby granted without fee, provided that
''   the above copyright notice appear in all copies and that both that
''   copyright notice and this permission notice appear in supporting
''   documentation, and that the name of NCD. not be used in advertising or
''   publicity pertaining to distribution of the software without specific,
''   written prior permission.  NCD. makes no representations about the
''   suitability of this software for any purpose.  It is provided "as is"
''   without express or implied warranty.
''
''   NCD. DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING ALL
''   IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO EVENT SHALL NCD.
''   BE LIABLE FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
''   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
''   OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
''   CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
''
''   Author:  Dale Tonogai, Network Computing Devices
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

extern "C"

#define _ZLIB_H_
#define ZLIB_STRCOMP_OPT "XC-ZLIB"
const ZLIB_STRCOMP_OPT_LEN = 7
const ZLIB_PACKET_HDRLEN = 2
const ZLIB_MAX_DATALEN = &hfff
const ZLIB_MAX_PLAIN = 270
const ZLIB_MAX_OUTLEN = ZLIB_MAX_PLAIN shl 1
const ZLIB_COMPRESS_FLAG = &h80
const ZLIB_DATALEN_MASK = &h0f
#macro ZLIB_PUT_PKTHDR(p, len, compflag)
	scope
		(p)[0] = culng(culng(culng(len) shr 8) or iif((compflag), ZLIB_COMPRESS_FLAG, 0))
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
