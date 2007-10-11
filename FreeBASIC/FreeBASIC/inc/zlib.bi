''
''
'' zlib -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __zlib_bi__
#define __zlib_bi__

#inclib "z"

'' zconf.bi
#define MAX_MEM_LEVEL 9
#define MAX_WBITS 15

type uInt as uinteger
type Bytef as Byte
type charf as byte
type intf as integer
type uIntf as uInt
type uLongf as uLong
type voidpc as any ptr
type voidpf as any ptr
type voidp as any ptr

#ifndef SEEK_SET
#define SEEK_SET 0
#define SEEK_CUR 1
#define SEEK_END 2
#endif


#define ZLIB_VERSION "1.2.2"
#define ZLIB_VERNUM &h1220

type alloc_func as function cdecl(byval as voidpf, byval as uInt, byval as uInt) as voidpf
type free_func as sub cdecl(byval as voidpf, byval as voidpf)

type internal_state
	dummy as integer
end type

type z_stream_s
	next_in as Bytef ptr
	avail_in as uInt
	total_in as uLong
	next_out as Bytef ptr
	avail_out as uInt
	total_out as uLong
	msg as byte ptr
	state as internal_state ptr
	zalloc as alloc_func
	zfree as free_func
	opaque_ as voidpf
	data_type as integer
	adler as uLong
	reserved as uLong
end type

type z_stream as z_stream_s
type z_streamp as z_stream ptr

#define Z_NO_FLUSH 0
#define Z_PARTIAL_FLUSH 1
#define Z_SYNC_FLUSH 2
#define Z_FULL_FLUSH 3
#define Z_FINISH 4
#define Z_BLOCK 5
#define Z_OK 0
#define Z_STREAM_END 1
#define Z_NEED_DICT 2
#define Z_ERRNO (-1)
#define Z_STREAM_ERROR (-2)
#define Z_DATA_ERROR (-3)
#define Z_MEM_ERROR (-4)
#define Z_BUF_ERROR (-5)
#define Z_VERSION_ERROR (-6)
#define Z_NO_COMPRESSION 0
#define Z_BEST_SPEED 1
#define Z_BEST_COMPRESSION 9
#define Z_DEFAULT_COMPRESSION (-1)
#define Z_FILTERED 1
#define Z_HUFFMAN_ONLY 2
#define Z_RLE 3
#define Z_DEFAULT_STRATEGY 0
#define Z_BINARY 0
#define Z_ASCII 1
#define Z_UNKNOWN 2
#define Z_DEFLATED 8
#define Z_NULL 0

type in_func as function cdecl(byval as any ptr, byval as ubyte ptr ptr) as uinteger
type out_func as function cdecl(byval as any ptr, byval as ubyte ptr, byval as uinteger) as integer

type gzFile as voidp

extern "c"
declare function zlibVersion () as zstring ptr
declare function deflate (byval strm as z_streamp, byval flush as integer) as integer
declare function deflateEnd (byval strm as z_streamp) as integer
declare function inflate (byval strm as z_streamp, byval flush as integer) as integer
declare function inflateEnd (byval strm as z_streamp) as integer
declare function deflateSetDictionary (byval strm as z_streamp, byval dictionary as Bytef ptr, byval dictLength as uInt) as integer
declare function deflateCopy (byval dest as z_streamp, byval source as z_streamp) as integer
declare function deflateReset (byval strm as z_streamp) as integer
declare function deflateParams (byval strm as z_streamp, byval level as integer, byval strategy as integer) as integer
declare function deflateBound (byval strm as z_streamp, byval sourceLen as uLong) as uLong
declare function deflatePrime (byval strm as z_streamp, byval bits as integer, byval value as integer) as integer
declare function inflateSetDictionary (byval strm as z_streamp, byval dictionary as Bytef ptr, byval dictLength as uInt) as integer
declare function inflateSync (byval strm as z_streamp) as integer
declare function inflateCopy (byval dest as z_streamp, byval source as z_streamp) as integer
declare function inflateReset (byval strm as z_streamp) as integer
declare function inflateBack (byval strm as z_stream ptr, byval in as in_func, byval in_desc as any ptr, byval out as out_func, byval out_desc as any ptr) as integer
declare function inflateBackEnd (byval strm as z_stream ptr) as integer
declare function zlibCompileFlags () as uLong
declare function compress (byval dest as Bytef ptr, byval destLen as uLongf ptr, byval source as Bytef ptr, byval sourceLen as uLong) as integer
declare function compress2 (byval dest as Bytef ptr, byval destLen as uLongf ptr, byval source as Bytef ptr, byval sourceLen as uLong, byval level as integer) as integer
declare function compressBound (byval sourceLen as uLong) as uLong
declare function uncompress (byval dest as Bytef ptr, byval destLen as uLongf ptr, byval source as Bytef ptr, byval sourceLen as uLong) as integer
declare function gzopen (byval path as zstring ptr, byval mode as zstring ptr) as gzFile
declare function gzdopen (byval fd as integer, byval mode as zstring ptr) as gzFile
declare function gzsetparams (byval file as gzFile, byval level as integer, byval strategy as integer) as integer
declare function gzread (byval file as gzFile, byval buf as voidp, byval len as uinteger) as integer
declare function gzwrite (byval file as gzFile, byval buf as voidpc, byval len as uinteger) as integer
declare function gzprintf (byval file as gzFile, byval format as zstring ptr, ...) as integer
declare function gzputs (byval file as gzFile, byval s as zstring ptr) as integer
declare function gzgets (byval file as gzFile, byval buf as zstring ptr, byval len as integer) as zstring ptr
declare function gzputc (byval file as gzFile, byval c as integer) as integer
declare function gzgetc (byval file as gzFile) as integer
declare function gzungetc (byval c as integer, byval file as gzFile) as integer
declare function gzflush (byval file as gzFile, byval flush as integer) as integer
declare function gzseek (byval file as gzFile, byval offset as integer, byval whence as integer) as integer
declare function gzrewind (byval file as gzFile) as integer
declare function gztell (byval file as gzFile) as integer
declare function gzeof (byval file as gzFile) as integer
declare function gzclose (byval file as gzFile) as integer
declare function gzerror (byval file as gzFile, byval errnum as integer ptr) as zstring ptr
declare sub gzclearerr (byval file as gzFile)
declare function adler32 (byval adler as uLong, byval buf as Bytef ptr, byval len as uInt) as uLong
declare function crc32 (byval crc as uLong, byval buf as Bytef ptr, byval len as uInt) as uLong
declare function deflateInit_ (byval strm as z_streamp, byval level as integer, byval version as zstring ptr, byval stream_size as integer) as integer
declare function inflateInit_ (byval strm as z_streamp, byval version as zstring ptr, byval stream_size as integer) as integer
declare function deflateInit2_ (byval strm as z_streamp, byval level as integer, byval method as integer, byval windowBits as integer, byval memLevel as integer, byval strategy as integer, byval version as zstring ptr, byval stream_size as integer) as integer
declare function inflateInit2_ (byval strm as z_streamp, byval windowBits as integer, byval version as zstring ptr, byval stream_size as integer) as integer
declare function inflateBackInit_ (byval strm as z_stream ptr, byval windowBits as integer, byval window as ubyte ptr, byval version as zstring ptr, byval stream_size as integer) as integer
declare function zError (byval as integer) as zstring ptr
declare function inflateSyncPoint (byval z as z_streamp) as integer
declare function get_crc_table () as uLongf ptr
end extern

#define deflateInit(strm, level) deflateInit_((strm), (level), ZLIB_VERSION, sizeof(z_stream))
#define inflateInit(strm) inflateInit_((strm), ZLIB_VERSION, sizeof(z_stream))
#define deflateInit2(strm, level, method, windowBits, memLevel, strategy) deflateInit2_((strm),(level),(method),(windowBits),(memLevel),(strategy), ZLIB_VERSION, sizeof(z_stream))
#define inflateInit2(strm, windowBits) inflateInit2_((strm), (windowBits), ZLIB_VERSION, sizeof(z_stream))
#define inflateBackInit(strm, windowBits, window) inflateBackInit_((strm), (windowBits), (window), ZLIB_VERSION, sizeof(z_stream))

#endif
