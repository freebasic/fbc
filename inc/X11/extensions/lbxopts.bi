'' FreeBASIC binding for liblbxutil-1.1.0

#pragma once

#include once "crt/sys/types.bi"
#ifdef __FB_LINUX__
	#include once "crt/sys/uio.bi"
#endif
#include once "X11/Xdefs.bi"
#ifdef __FB_WIN32__
	#include once "X11/Xw32defs.bi"
#endif

extern "C"

#define _LBX_OPTS_H_
const LBX_OPT_DELTA_PROXY = 0
const LBX_OPT_DELTA_SERVER = 1
const LBX_OPT_STREAM_COMP = 2
const LBX_OPT_BITMAP_COMP = 3
const LBX_OPT_PIXMAP_COMP = 4
const LBX_OPT_MSG_COMP = 5
const LBX_OPT_USE_TAGS = 6
const LBX_OPT_CMAP_ALL = 7
const LBX_OPT_EXTENSION = 255
const LBX_OPT_SMALLLEN_SIZE = 1
const LBX_OPT_BIGLEN_SIZE = 3
const LBX_OPT_BIGLEN_MIN = 256
#macro LBX_OPT_DECODE_LEN(p, len, size)
	if (p)[0] then
		(len) = (p)[0]
		(size) = LBX_OPT_SMALLLEN_SIZE
	else
		(len) = ((LBX_OPT_BIGLEN_MIN + (p)[1]) shl 8) or (p)[2]
		(size) = LBX_OPT_BIGLEN_SIZE
	end if
#endmacro
#define LBX_OPT_SMALLHDR_LEN (1 + LBX_OPT_SMALLLEN_SIZE)
#define LBX_OPT_BIGHDR_LEN (1 + LBX_OPT_BIGLEN_SIZE)
const LBX_OPT_DELTA_REQLEN = 6
const LBX_OPT_DELTA_REPLYLEN = 2
const LBX_OPT_DELTA_NCACHE_DFLT = 16
const LBX_OPT_DELTA_MSGLEN_MIN = 32
const LBX_OPT_DELTA_MSGLEN_DFLT = 64

type LbxStreamCompHandle as any ptr

type _LbxStreamOpts
	streamCompInit as function(byval fd as long, byval arg as pointer_) as LbxStreamCompHandle
	streamCompArg as pointer_
	streamCompStuffInput as function(byval fd as long, byval buf as ubyte ptr, byval buflen as long) as long
	streamCompInputAvail as function(byval fd as long) as long
	streamCompFlush as function(byval fd as long) as long
	streamCompRead as function(byval fd as long, byval buf as ubyte ptr, byval buflen as long) as long
	streamCompWriteV as function(byval fd as long, byval iov as iovec ptr, byval iovcnt as long) as long
	streamCompOn as sub(byval fd as long)
	streamCompOff as sub(byval fd as long)
	streamCompFreeHandle as sub(byval handle as LbxStreamCompHandle)
end type

type LbxStreamOpts as _LbxStreamOpts

end extern
