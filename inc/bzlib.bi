'' FreeBASIC binding for bzip2-1.0.8
''
'' based on the C header files:
''   This program, "bzip2", the associated library "libbzip2", and all
''   documentation, are copyright (C) 1996-2019 Julian R Seward.  All
''   rights reserved.
''
''   Redistribution and use in source and binary forms, with or without
''   modification, are permitted provided that the following conditions
''   are met:
''
''   1. Redistributions of source code must retain the above copyright
''      notice, this list of conditions and the following disclaimer.
''
''   2. The origin of this software must not be misrepresented; you must 
''      not claim that you wrote the original software.  If you use this 
''      software in a product, an acknowledgment in the product 
''      documentation would be appreciated but is not required.
''
''   3. Altered source versions must be plainly marked as such, and must
''      not be misrepresented as being the original software.
''
''   4. The name of the author may not be used to endorse or promote 
''      products derived from this software without specific prior written 
''      permission.
''
''   THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS
''   OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
''   WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
''   ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
''   DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
''   DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
''   GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
''   INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
''   WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
''   NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
''   SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
''
''   Julian Seward, jseward@acm.org
''   bzip2/libbzip2 version 1.0.8 of 13 July 2019
''
'' translated to FreeBASIC by:
''   Copyright © 2021 FreeBASIC development team

#pragma once

#inclib "bz2"

#include once "crt/stdio.bi"

'' The following symbols have been renamed:
''     procedure BZ2_bzread => BZ2_bzread_
''     procedure BZ2_bzwrite => BZ2_bzwrite_

#ifdef __FB_WIN32__
	extern "Windows"
#else
	extern "C"
#endif

#define _BZLIB_H
const BZ_RUN = 0
const BZ_FLUSH = 1
const BZ_FINISH = 2
const BZ_OK = 0
const BZ_RUN_OK = 1
const BZ_FLUSH_OK = 2
const BZ_FINISH_OK = 3
const BZ_STREAM_END = 4
const BZ_SEQUENCE_ERROR = -1
const BZ_PARAM_ERROR = -2
const BZ_MEM_ERROR = -3
const BZ_DATA_ERROR = -4
const BZ_DATA_ERROR_MAGIC = -5
const BZ_IO_ERROR = -6
const BZ_UNEXPECTED_EOF = -7
const BZ_OUTBUFF_FULL = -8
const BZ_CONFIG_ERROR = -9

type bz_stream
	next_in as zstring ptr
	avail_in as ulong
	total_in_lo32 as ulong
	total_in_hi32 as ulong
	next_out as zstring ptr
	avail_out as ulong
	total_out_lo32 as ulong
	total_out_hi32 as ulong
	state as any ptr
	bzalloc as function cdecl(byval as any ptr, byval as long, byval as long) as any ptr
	bzfree as sub cdecl(byval as any ptr, byval as any ptr)
	opaque as any ptr
end type

declare function BZ2_bzCompressInit(byval strm as bz_stream ptr, byval blockSize100k as long, byval verbosity as long, byval workFactor as long) as long
declare function BZ2_bzCompress(byval strm as bz_stream ptr, byval action as long) as long
declare function BZ2_bzCompressEnd(byval strm as bz_stream ptr) as long
declare function BZ2_bzDecompressInit(byval strm as bz_stream ptr, byval verbosity as long, byval small as long) as long
declare function BZ2_bzDecompress(byval strm as bz_stream ptr) as long
declare function BZ2_bzDecompressEnd(byval strm as bz_stream ptr) as long
const BZ_MAX_UNUSED = 5000
type BZFILE as any
declare function BZ2_bzReadOpen(byval bzerror as long ptr, byval f as FILE ptr, byval verbosity as long, byval small as long, byval unused as any ptr, byval nUnused as long) as BZFILE ptr
declare sub BZ2_bzReadClose(byval bzerror as long ptr, byval b as BZFILE ptr)
declare sub BZ2_bzReadGetUnused(byval bzerror as long ptr, byval b as BZFILE ptr, byval unused as any ptr ptr, byval nUnused as long ptr)
declare function BZ2_bzRead(byval bzerror as long ptr, byval b as BZFILE ptr, byval buf as any ptr, byval len as long) as long
declare function BZ2_bzWriteOpen(byval bzerror as long ptr, byval f as FILE ptr, byval blockSize100k as long, byval verbosity as long, byval workFactor as long) as BZFILE ptr
declare sub BZ2_bzWrite(byval bzerror as long ptr, byval b as BZFILE ptr, byval buf as any ptr, byval len as long)
declare sub BZ2_bzWriteClose(byval bzerror as long ptr, byval b as BZFILE ptr, byval abandon as long, byval nbytes_in as ulong ptr, byval nbytes_out as ulong ptr)
declare sub BZ2_bzWriteClose64(byval bzerror as long ptr, byval b as BZFILE ptr, byval abandon as long, byval nbytes_in_lo32 as ulong ptr, byval nbytes_in_hi32 as ulong ptr, byval nbytes_out_lo32 as ulong ptr, byval nbytes_out_hi32 as ulong ptr)
declare function BZ2_bzBuffToBuffCompress(byval dest as zstring ptr, byval destLen as ulong ptr, byval source as zstring ptr, byval sourceLen as ulong, byval blockSize100k as long, byval verbosity as long, byval workFactor as long) as long
declare function BZ2_bzBuffToBuffDecompress(byval dest as zstring ptr, byval destLen as ulong ptr, byval source as zstring ptr, byval sourceLen as ulong, byval small as long, byval verbosity as long) as long
declare function BZ2_bzlibVersion() as const zstring ptr
declare function BZ2_bzopen(byval path as const zstring ptr, byval mode as const zstring ptr) as BZFILE ptr
declare function BZ2_bzdopen(byval fd as long, byval mode as const zstring ptr) as BZFILE ptr
declare function BZ2_bzread_ alias "BZ2_bzread"(byval b as BZFILE ptr, byval buf as any ptr, byval len as long) as long
declare function BZ2_bzwrite_ alias "BZ2_bzwrite"(byval b as BZFILE ptr, byval buf as any ptr, byval len as long) as long
declare function BZ2_bzflush(byval b as BZFILE ptr) as long
declare sub BZ2_bzclose(byval b as BZFILE ptr)
declare function BZ2_bzerror(byval b as BZFILE ptr, byval errnum as long ptr) as const zstring ptr

end extern
