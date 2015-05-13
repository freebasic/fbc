''
''
'' lbxopts -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __lbxopts_bi__
#define __lbxopts_bi__

#define LBX_OPT_DELTA_PROXY 0
#define LBX_OPT_DELTA_SERVER 1
#define LBX_OPT_STREAM_COMP 2
#define LBX_OPT_BITMAP_COMP 3
#define LBX_OPT_PIXMAP_COMP 4
#define LBX_OPT_MSG_COMP 5
#define LBX_OPT_USE_TAGS 6
#define LBX_OPT_CMAP_ALL 7
#define LBX_OPT_EXTENSION 255
#define LBX_OPT_SMALLLEN_SIZE 1
#define LBX_OPT_BIGLEN_SIZE 3
#define LBX_OPT_BIGLEN_MIN 256
#define LBX_OPT_SMALLHDR_LEN (1+1)
#define LBX_OPT_BIGHDR_LEN (1+3)
#define LBX_OPT_DELTA_REQLEN 6
#define LBX_OPT_DELTA_REPLYLEN 2
#define LBX_OPT_DELTA_NCACHE_DFLT 16
#define LBX_OPT_DELTA_MSGLEN_MIN 32
#define LBX_OPT_DELTA_MSGLEN_DFLT 64

type LbxStreamCompHandle as any ptr

type _LbxStreamOpts
	streamCompInit as function cdecl(byval as integer, byval as pointer) as LbxStreamCompHandle
	streamCompArg as pointer
	streamCompStuffInput as function cdecl(byval as integer, byval as ubyte ptr, byval as integer) as integer
	streamCompInputAvail as function cdecl(byval as integer) as integer
	streamCompFlush as function cdecl(byval as integer) as integer
	streamCompRead as function cdecl(byval as integer, byval as ubyte ptr, byval as integer) as integer
	streamCompWriteV as function cdecl(byval as integer, byval as iovec ptr, byval as integer) as integer
	streamCompOn as sub cdecl(byval as integer)
	streamCompOff as sub cdecl(byval as integer)
	streamCompFreeHandle as sub cdecl(byval as LbxStreamCompHandle)
end type

type LbxStreamOpts as _LbxStreamOpts

#endif
