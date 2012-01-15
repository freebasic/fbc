/'-------------------------------------------------------------*/
/*--- Public header file for the library.                   ---*/
/*---                                              bzlib.bi ---*/
/*-------------------------------------------------------------*/

/* ------------------------------------------------------------------
   This file is part of bzip2/libbzip2, a program and library for
   lossless, block-sorting data compression.

   bzip2/libbzip2 version 1.0.6 of 6 September 2010
   Copyright (C) 1996-2010 Julian Seward <jseward@bzip.org>

   Please read the WARNING, DISCLAIMER and PATENTS sections in the 
   README file.

   This program is released under the terms of the license contained
   in the file LICENSE.
   ------------------------------------------------------------------ '/


#ifndef _BZLIB_BI
#define _BZLIB_BI

#inclib "bz2"

extern "C"

#define BZ_RUN               0
#define BZ_FLUSH             1
#define BZ_FINISH            2

#define BZ_OK                0
#define BZ_RUN_OK            1
#define BZ_FLUSH_OK          2
#define BZ_FINISH_OK         3
#define BZ_STREAM_END        4
#define BZ_SEQUENCE_ERROR    (-1)
#define BZ_PARAM_ERROR       (-2)
#define BZ_MEM_ERROR         (-3)
#define BZ_DATA_ERROR        (-4)
#define BZ_DATA_ERROR_MAGIC  (-5)
#define BZ_IO_ERROR          (-6)
#define BZ_UNEXPECTED_EOF    (-7)
#define BZ_OUTBUFF_FULL      (-8)
#define BZ_CONFIG_ERROR      (-9)

type bz_stream
      as ubyte ptr next_in
      as uinteger avail_in, total_in_lo32, total_in_hi32

      as ubyte ptr next_out
      as uinteger avail_out, total_out_lo32, total_out_hi32

      as any ptr state

	  bzalloc as function cdecl( byval as any ptr, byval as integer, byval as integer ) as any ptr
      bzfree as sub cdecl( byval as any ptr, byval as any ptr )
	  
      as any ptr opaque
end type

#ifndef BZ_NO_STDIO
	#include once "crt/stdio.bi"
#endif

'/*-- Core (low-level) library functions --*/

declare function BZ2_bzCompressInit( _
      byval strm as bz_stream ptr, _
      byval blockSize100k as integer, _ 
      byval verbosity as integer, _
      byval workFactor as integer _
   ) as integer

declare function BZ2_bzCompress( _
      byval strm as bz_stream ptr, _ 
      byval action as integer _ 
   ) as integer

declare function BZ2_bzCompressEnd( _
      byval strm as bz_stream ptr _
   ) as integer

declare function BZ2_bzDecompressInit( _
      byval strm as bz_stream ptr, _ 
      byval verbosity as integer, _
      byval small as integer _
   ) as integer

declare function BZ2_bzDecompress( _
      byval strm as bz_stream ptr _
   ) as integer

declare function BZ2_bzDecompressEnd( _
      byval strm as bz_stream ptr _
   ) as integer



'/*-- High(er) level library functions --*/

#ifndef BZ_NO_STDIO
#define BZ_MAX_UNUSED 5000

type BZFILE as any

declare function BZ2_bzReadOpen( _
      byval bzerror as integer ptr, _
      byval f as FILE ptr, _
      byval verbosity as integer, _
      byval small as integer, _
      byval unused as any ptr, _
      byval nUnused as integer _
   ) as BZFILE ptr

declare sub BZ2_bzReadClose( _
      byval bzerror as integer ptr, _  
      byval b as bzfile ptr _ 
   )

declare sub BZ2_bzReadGetUnused( _
      byval bzerror as integer ptr, _   
      byval b as bzfile ptr, _ 
      byval unused as any ptr ptr, _ 
      byval nUnused as integer ptr _
   )

declare function BZ2_bzRead( _
      byval bzerror as integer ptr, _
      byval b as bzfile ptr, _ 
      byval buf as any ptr, _
      byval len_ as integer _ 
   ) as integer

declare function BZ2_bzWriteOpen( _
      byval bzerror as integer ptr, _       
      byval f as file ptr, _
      byval blockSize100k as integer, _ 
      byval verbosity as integer, _
      byval workFactor as integer _
   ) as bzfile ptr

declare sub BZ2_bzWrite( _
      byval bzerror as integer ptr, _
      byval b as bzfile ptr, _ 
      byval buf as any ptr, _
      byval len_ as integer _
   )

declare sub BZ2_bzWriteClose( _
      byval bzerror as integer ptr, _ 
      byval b as bzfile ptr, _
      byval abandon as integer, _
      byval nbytes_in as uinteger ptr, _
      byval nbytes_out as uinteger ptr _
   )

declare sub BZ2_bzWriteClose64( _
      byval bzerror as integer ptr,    
      byval b as bzfile ptr, _ 
      byval abandon as integer, _ 
      byval nbytes_in_lo32 as uinteger ptr, _
      byval nbytes_in_hi32 as uinteger ptr _
	  byval nbytes_out_lo32 as uinteger ptr, _
      byval nbytes_out_hi32 as uinteger ptr _
   )
#endif


'/*-- Utility functions --*/

declare function BZ2_bzBuffToBuffCompress( 
      byval dest as ubyte ptr, _
      byval destLen as uinteger ptr, _
      byval source as ubyte ptr, _
      byval sourceLen as uinteger, _
      byval blockSize100k as integer, _ 
      byval verbosity as integer, _
      byval workFactor as integer _
   ) as integer

declare function BZ2_bzBuffToBuffDecompress( 
      byval dest as ubyte ptr, _
      byval destLen as uinteger ptr, _
      byval source as ubyte ptr, _
      byval sourceLen as uinteger, _
      byval small as integer, _
      byval verbosity as integer _
   ) as integer


/'--
   Code contributed by Yoshioka Tsuneo (tsuneo@rr.iij4u.or.jp)
   to support better zlib compatibility.
   This code is not _officially_ part of libbzip2 (yet)
   I haven't tested it, documented it, or considered the
   threading-safeness of it.
   If this code breaks, please contact both Yoshioka and me.
--'/

declare function BZ2_bzlibVersion( ) as const zstring ptr

#ifndef BZ_NO_STDIO
declare function BZ2_bzopen( _
      byval path as const zstring ptr, _
      byval mode as const zstring ptr _
   ) as bzfile ptr

declare function BZ2_bzdopen( _
      byval fd as integer, _
      byval mode as const zstring ptr _
   ) as bzfile ptr
         
declare function BZ2_bzread( _
      byval  b as bzfile ptr, _
      byval buf as any ptr, _
      byval len_ as integer _
   ) as integer

declare function BZ2_bzwrite( _
      byval  b as bzfile ptr, _ 
      byval buf as any ptr, _
      byval len_ as integer _
   ) as integer

declare function BZ2_bzflush( _
      byval  b as bzfile ptr _
   ) as integer

declare sub BZ2_bzclose( _
      byval  b as bzfile ptr _
   )

declare function BZ2_bzerror( _
      byval  b as bzfile ptr, _ 
      byval errnum as integer ptr _
   ) as const zstring ptr
#endif

end extern

#endif

/'-------------------------------------------------------------*/
/*--- end                                           bzlib.h ---*/
/*-------------------------------------------------------------'/
