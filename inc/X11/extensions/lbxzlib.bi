''
''
'' lbxzlib -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __lbxzlib_bi__
#define __lbxzlib_bi__

#define ZLIB_STRCOMP_OPT "XC-ZLIB"
#define ZLIB_STRCOMP_OPT_LEN 7
#define ZLIB_PACKET_HDRLEN 2
#define ZLIB_MAX_DATALEN &hfff
#define ZLIB_MAX_PLAIN 270
#define ZLIB_MAX_OUTLEN (270 shl 1)
#define ZLIB_COMPRESS_FLAG &h80
#define ZLIB_DATALEN_MASK &h0f

declare function ZlibInit cdecl alias "ZlibInit" (byval fd as integer, byval level as integer) as any ptr
declare sub ZlibFree cdecl alias "ZlibFree" (byval comp as ZlibInfo ptr)
declare function ZlibFlush cdecl alias "ZlibFlush" (byval fd as integer) as integer
declare function ZlibStuffInput cdecl alias "ZlibStuffInput" (byval fd as integer, byval buffer as ubyte ptr, byval buflen as integer) as integer
declare sub ZlibCompressOn cdecl alias "ZlibCompressOn" (byval fd as integer)
declare sub ZlibCompressOff cdecl alias "ZlibCompressOff" (byval fd as integer)
declare function ZlibWrite cdecl alias "ZlibWrite" (byval fd as integer, byval buffer as ubyte ptr, byval buflen as integer) as integer
declare function ZlibWriteV cdecl alias "ZlibWriteV" (byval fd as integer, byval iov as iovec ptr, byval iovcnt as integer) as integer
declare function ZlibRead cdecl alias "ZlibRead" (byval fd as integer, byval buffer as ubyte ptr, byval buflen as integer) as integer
declare function ZlibInputAvail cdecl alias "ZlibInputAvail" (byval fd as integer) as integer

#endif
