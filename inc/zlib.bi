'' FreeBASIC binding for zlib-1.2.8
''
'' based on the C header files:
''   zlib.h -- interface of the 'zlib' general purpose compression library
''   version 1.2.8, April 28th, 2013
''
''   Copyright (C) 1995-2013 Jean-loup Gailly and Mark Adler
''
''   This software is provided 'as-is', without any express or implied
''   warranty.  In no event will the authors be held liable for any damages
''   arising from the use of this software.
''
''   Permission is granted to anyone to use this software for any purpose,
''   including commercial applications, and to alter it and redistribute it
''   freely, subject to the following restrictions:
''
''   1. The origin of this software must not be misrepresented; you must not
''      claim that you wrote the original software. If you use this software
''      in a product, an acknowledgment in the product documentation would be
''      appreciated but is not required.
''   2. Altered source versions must be plainly marked as such, and must not be
''      misrepresented as being the original software.
''   3. This notice may not be removed or altered from any source distribution.
''
''   Jean-loup Gailly        Mark Adler
''   jloup@gzip.org          madler@alumni.caltech.edu
''
''
''   The data format used by the zlib library is described by RFCs (Request for
''   Comments) 1950 to 1952 in the files http://tools.ietf.org/html/rfc1950
''   (zlib format), rfc1951 (deflate format) and rfc1952 (gzip format).
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "z"

#include once "crt/long.bi"
#include once "crt/stdarg.bi"

'' The following symbols have been renamed:
''     typedef Byte => Byte_
''     typedef uLong => uLong_
''     #define zlib_version => zlib_version_

extern "C"

#define ZLIB_H
#define ZCONF_H
type Byte_ as ubyte
type uInt as ulong
type uLong_ as culong
type Bytef as Byte_
type charf as zstring
type intf as long
type uIntf as uInt
type uLongf as uLong_
type voidpc as const any ptr
type voidpf as any ptr
type voidp as any ptr
type z_crc_t as culong

#ifndef SEEK_SET
const SEEK_SET = 0
#endif
#ifndef SEEK_CUR
const SEEK_CUR = 1
#endif
#ifndef SEEK_END
const SEEK_END = 2
#endif
type z_off_t as clong
type z_off64_t as z_off_t
#define ZLIB_VERSION "1.2.8"
const ZLIB_VERNUM = &h1280
const ZLIB_VER_MAJOR = 1
const ZLIB_VER_MINOR = 2
const ZLIB_VER_REVISION = 8
const ZLIB_VER_SUBREVISION = 0

type alloc_func as function(byval opaque as voidpf, byval items as uInt, byval size as uInt) as voidpf
type free_func as sub(byval opaque as voidpf, byval address as voidpf)
type internal_state as internal_state_

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
	opaque as voidpf
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
const Z_NO_FLUSH = 0
const Z_PARTIAL_FLUSH = 1
const Z_SYNC_FLUSH = 2
const Z_FULL_FLUSH = 3
const Z_FINISH = 4
const Z_BLOCK = 5
const Z_TREES = 6
const Z_OK = 0
const Z_STREAM_END = 1
const Z_NEED_DICT = 2
const Z_ERRNO = -1
const Z_STREAM_ERROR = -2
const Z_DATA_ERROR = -3
const Z_MEM_ERROR = -4
const Z_BUF_ERROR = -5
const Z_VERSION_ERROR = -6
const Z_NO_COMPRESSION = 0
const Z_BEST_SPEED = 1
const Z_BEST_COMPRESSION = 9
const Z_DEFAULT_COMPRESSION = -1
const Z_FILTERED = 1
const Z_HUFFMAN_ONLY = 2
const Z_RLE = 3
const Z_FIXED = 4
const Z_DEFAULT_STRATEGY = 0
const Z_BINARY = 0
const Z_TEXT = 1
const Z_ASCII = Z_TEXT
const Z_UNKNOWN = 2
const Z_DEFLATED = 8
const Z_NULL = 0
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
declare function inflateBack(byval strm as z_streamp, byval in as in_func, byval in_desc as any ptr, byval out as out_func, byval out_desc as any ptr) as long
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
declare function gzread(byval file as gzFile, byval buf as voidp, byval len as ulong) as long
declare function gzwrite(byval file as gzFile, byval buf as voidpc, byval len as ulong) as long
declare function gzprintf(byval file as gzFile, byval format as const zstring ptr, ...) as long
declare function gzputs(byval file as gzFile, byval s as const zstring ptr) as long
declare function gzgets(byval file as gzFile, byval buf as zstring ptr, byval len as long) as zstring ptr
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
declare function adler32(byval adler as uLong_, byval buf as const Bytef ptr, byval len as uInt) as uLong_
declare function crc32(byval crc as uLong_, byval buf as const Bytef ptr, byval len as uInt) as uLong_
declare function deflateInit_(byval strm as z_streamp, byval level as long, byval version as const zstring ptr, byval stream_size as long) as long
declare function inflateInit_(byval strm as z_streamp, byval version as const zstring ptr, byval stream_size as long) as long
declare function deflateInit2_(byval strm as z_streamp, byval level as long, byval method as long, byval windowBits as long, byval memLevel as long, byval strategy as long, byval version as const zstring ptr, byval stream_size as long) as long
declare function inflateInit2_(byval strm as z_streamp, byval windowBits as long, byval version as const zstring ptr, byval stream_size as long) as long
declare function inflateBackInit_(byval strm as z_streamp, byval windowBits as long, byval window as ubyte ptr, byval version as const zstring ptr, byval stream_size as long) as long

#define deflateInit(strm, level) deflateInit_((strm), (level), ZLIB_VERSION, clng(sizeof(z_stream)))
#define inflateInit(strm) inflateInit_((strm), ZLIB_VERSION, clng(sizeof(z_stream)))
#define deflateInit2(strm, level, method, windowBits, memLevel, strategy) deflateInit2_((strm), (level), (method), (windowBits), (memLevel), (strategy), ZLIB_VERSION, clng(sizeof(z_stream)))
#define inflateInit2(strm, windowBits) inflateInit2_((strm), (windowBits), ZLIB_VERSION, clng(sizeof(z_stream)))
#define inflateBackInit(strm, windowBits, window) inflateBackInit_((strm), (windowBits), (window), ZLIB_VERSION, clng(sizeof(z_stream)))

type gzFile_s
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
