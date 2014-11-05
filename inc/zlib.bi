#pragma once
#inclib "z"

#include once "crt/long.bi"
#include once "crt/stdarg.bi"

'' The following symbols have been renamed:
''     inside struct z_stream_s:
''         field opaque => opaque_
''     typedef Byte => Byte_
''     typedef uLong => uLong_
''     #define zlib_version => zlib_version_

extern "C"

type internal_state as internal_state_
type gzFile_s as gzFile_s_

#define ZLIB_H
#define ZCONF_H

type Byte_ as ubyte
type uInt as ulong
type uLong_ as culong
type Bytef as Byte_
type charf as byte
type intf as long
type uIntf as uInt
type uLongf as uLong_
type voidpc as const any ptr
type voidpf as any ptr
type voidp as any ptr
type z_crc_t as culong

#define SEEK_SET 0
#define SEEK_CUR 1
#define SEEK_END 2
#define z_off_t clong
#define z_off64_t z_off_t
#define ZLIB_VERSION "1.2.8"
#define ZLIB_VERNUM &h1280
#define ZLIB_VER_MAJOR 1
#define ZLIB_VER_MINOR 2
#define ZLIB_VER_REVISION 8
#define ZLIB_VER_SUBREVISION 0

type alloc_func as function(byval opaque_ as voidpf, byval items as uInt, byval size as uInt) as voidpf
type free_func as sub(byval opaque_ as voidpf, byval address as voidpf)

type z_stream_s
	next_in as Bytef ptr
	avail_in as uInt
	total_in as uLong_
	next_out as Bytef ptr
	avail_out as uInt
	total_out as uLong_
	msg as zstring ptr
	state as internal_state ptr
	zalloc as alloc_func
	zfree as free_func
	opaque_ as voidpf
	data_type as long
	adler as uLong_
	reserved as uLong_
end type

type z_stream as z_stream_s
type z_streamp as z_stream ptr

type gz_header_s
	text as long
	time as uLong_
	xflags as long
	os as long
	extra as Bytef ptr
	extra_len as uInt
	extra_max as uInt
	name as Bytef ptr
	name_max as uInt
	comment as Bytef ptr
	comm_max as uInt
	hcrc as long
	done as long
end type

type gz_header as gz_header_s
type gz_headerp as gz_header ptr

#define Z_NO_FLUSH 0
#define Z_PARTIAL_FLUSH 1
#define Z_SYNC_FLUSH 2
#define Z_FULL_FLUSH 3
#define Z_FINISH 4
#define Z_BLOCK 5
#define Z_TREES 6
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
#define Z_FIXED 4
#define Z_DEFAULT_STRATEGY 0
#define Z_BINARY 0
#define Z_TEXT 1
#define Z_ASCII Z_TEXT
#define Z_UNKNOWN 2
#define Z_DEFLATED 8
#define Z_NULL 0
#define zlib_version_ zlibVersion()

declare function zlibVersion() as const zstring ptr
declare function deflate(byval strm as z_streamp, byval flush as long) as long
declare function deflateEnd(byval strm as z_streamp) as long
declare function inflate(byval strm as z_streamp, byval flush as long) as long
declare function inflateEnd(byval strm as z_streamp) as long
declare function deflateSetDictionary(byval strm as z_streamp, byval dictionary as const Bytef ptr, byval dictLength as uInt) as long
declare function deflateCopy(byval dest as z_streamp, byval source as z_streamp) as long
declare function deflateReset(byval strm as z_streamp) as long
declare function deflateParams(byval strm as z_streamp, byval level as long, byval strategy as long) as long
declare function deflateTune(byval strm as z_streamp, byval good_length as long, byval max_lazy as long, byval nice_length as long, byval max_chain as long) as long
declare function deflateBound(byval strm as z_streamp, byval sourceLen as uLong_) as uLong_
declare function deflatePending(byval strm as z_streamp, byval pending as ulong ptr, byval bits as long ptr) as long
declare function deflatePrime(byval strm as z_streamp, byval bits as long, byval value as long) as long
declare function deflateSetHeader(byval strm as z_streamp, byval head as gz_headerp) as long
declare function inflateSetDictionary(byval strm as z_streamp, byval dictionary as const Bytef ptr, byval dictLength as uInt) as long
declare function inflateGetDictionary(byval strm as z_streamp, byval dictionary as Bytef ptr, byval dictLength as uInt ptr) as long
declare function inflateSync(byval strm as z_streamp) as long
declare function inflateCopy(byval dest as z_streamp, byval source as z_streamp) as long
declare function inflateReset(byval strm as z_streamp) as long
declare function inflateReset2(byval strm as z_streamp, byval windowBits as long) as long
declare function inflatePrime(byval strm as z_streamp, byval bits as long, byval value as long) as long
declare function inflateMark(byval strm as z_streamp) as clong
declare function inflateGetHeader(byval strm as z_streamp, byval head as gz_headerp) as long

type in_func as function(byval as any ptr, byval as ubyte ptr ptr) as ulong
type out_func as function(byval as any ptr, byval as ubyte ptr, byval as ulong) as long

declare function inflateBack(byval strm as z_streamp, byval in as in_func, byval in_desc as any ptr, byval out_ as out_func, byval out_desc as any ptr) as long
declare function inflateBackEnd(byval strm as z_streamp) as long
declare function zlibCompileFlags() as uLong_
declare function compress(byval dest as Bytef ptr, byval destLen as uLongf ptr, byval source as const Bytef ptr, byval sourceLen as uLong_) as long
declare function compress2(byval dest as Bytef ptr, byval destLen as uLongf ptr, byval source as const Bytef ptr, byval sourceLen as uLong_, byval level as long) as long
declare function compressBound(byval sourceLen as uLong_) as uLong_
declare function uncompress(byval dest as Bytef ptr, byval destLen as uLongf ptr, byval source as const Bytef ptr, byval sourceLen as uLong_) as long

type gzFile as gzFile_s ptr

declare function gzdopen(byval fd as long, byval mode as const zstring ptr) as gzFile
declare function gzbuffer(byval file as gzFile, byval size as ulong) as long
declare function gzsetparams(byval file as gzFile, byval level as long, byval strategy as long) as long
declare function gzread(byval file as gzFile, byval buf as voidp, byval len_ as ulong) as long
declare function gzwrite(byval file as gzFile, byval buf as voidpc, byval len_ as ulong) as long
declare function gzprintf(byval file as gzFile, byval format as const zstring ptr, ...) as long
declare function gzputs(byval file as gzFile, byval s as const zstring ptr) as long
declare function gzgets(byval file as gzFile, byval buf as zstring ptr, byval len_ as long) as zstring ptr
declare function gzputc(byval file as gzFile, byval c as long) as long
declare function gzgetc(byval file as gzFile) as long
declare function gzungetc(byval c as long, byval file as gzFile) as long
declare function gzflush(byval file as gzFile, byval flush as long) as long
declare function gzrewind(byval file as gzFile) as long
declare function gzeof(byval file as gzFile) as long
declare function gzdirect(byval file as gzFile) as long
declare function gzclose(byval file as gzFile) as long
declare function gzclose_r(byval file as gzFile) as long
declare function gzclose_w(byval file as gzFile) as long
declare function gzerror(byval file as gzFile, byval errnum as long ptr) as const zstring ptr
declare sub gzclearerr(byval file as gzFile)
declare function adler32(byval adler as uLong_, byval buf as const Bytef ptr, byval len_ as uInt) as uLong_
declare function crc32(byval crc as uLong_, byval buf as const Bytef ptr, byval len_ as uInt) as uLong_
declare function deflateInit_(byval strm as z_streamp, byval level as long, byval version as const zstring ptr, byval stream_size as long) as long
declare function inflateInit_(byval strm as z_streamp, byval version as const zstring ptr, byval stream_size as long) as long
declare function deflateInit2_(byval strm as z_streamp, byval level as long, byval method as long, byval windowBits as long, byval memLevel as long, byval strategy as long, byval version as const zstring ptr, byval stream_size as long) as long
declare function inflateInit2_(byval strm as z_streamp, byval windowBits as long, byval version as const zstring ptr, byval stream_size as long) as long
declare function inflateBackInit_(byval strm as z_streamp, byval windowBits as long, byval window_ as ubyte ptr, byval version as const zstring ptr, byval stream_size as long) as long

#define deflateInit(strm, level) deflateInit_((strm), (level), ZLIB_VERSION, clng(sizeof(z_stream)))
#define inflateInit(strm) inflateInit_((strm), ZLIB_VERSION, clng(sizeof(z_stream)))
#define deflateInit2(strm, level, method, windowBits, memLevel, strategy) deflateInit2_((strm), (level), (method), (windowBits), (memLevel), (strategy), ZLIB_VERSION, clng(sizeof(z_stream)))
#define inflateInit2(strm, windowBits) inflateInit2_((strm), (windowBits), ZLIB_VERSION, clng(sizeof(z_stream)))
#define inflateBackInit(strm, windowBits, window) inflateBackInit_((strm), (windowBits), (window), ZLIB_VERSION, clng(sizeof(z_stream)))

type gzFile_s_
	have as ulong
	next as ubyte ptr
	pos as clong
end type

declare function gzgetc_(byval file as gzFile) as long
declare function gzopen(byval as const zstring ptr, byval as const zstring ptr) as gzFile
declare function gzseek(byval as gzFile, byval as clong, byval as long) as clong
declare function gztell(byval as gzFile) as clong
declare function gzoffset(byval as gzFile) as clong
declare function adler32_combine(byval as uLong_, byval as uLong_, byval as clong) as uLong_
declare function crc32_combine(byval as uLong_, byval as uLong_, byval as clong) as uLong_

type internal_state_
	dummy as long
end type

declare function zError(byval as long) as const zstring ptr
declare function inflateSyncPoint(byval as z_streamp) as long
declare function get_crc_table() as const z_crc_t ptr
declare function inflateUndermine(byval as z_streamp, byval as long) as long
declare function inflateResetKeep(byval as z_streamp) as long
declare function deflateResetKeep(byval as z_streamp) as long

#ifdef __FB_WIN32__
	declare function gzopen_w(byval path as const wstring ptr, byval mode as const zstring ptr) as gzFile
#endif

declare function gzvprintf(byval file as gzFile, byval format as const zstring ptr, byval va as va_list) as long

end extern
