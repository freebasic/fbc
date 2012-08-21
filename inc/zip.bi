#ifndef _HAD_ZIP_BI
#define _HAD_ZIP_BI

/'
  This is an FB translation of:

  zip.h -- exported declarations.
  Copyright (C) 1999-2011 Dieter Baron and Thomas Klausner

  This file is part of libzip, a library to manipulate ZIP archives.
  The authors can be contacted at <libzip@nih.at>

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions
  are met:
  1. Redistributions of source code must retain the above copyright
     notice, this list of conditions and the following disclaimer.
  2. Redistributions in binary form must reproduce the above copyright
     notice, this list of conditions and the following disclaimer in
     the documentation and/or other materials provided with the
     distribution.
  3. The names of the authors may not be used to endorse or promote
     products derived from this software without specific prior
     written permission.

  THIS SOFTWARE IS PROVIDED BY THE AUTHORS ``AS IS'' AND ANY EXPRESS
  OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
  ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY
  DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
  DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
  GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
  IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
  OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
  IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
'/

#inclib "zip"

'' At least when using a static libzip, zlib needs to be linked in too.
#inclib "z"

extern "c"

'' <zipconf.bi>
#define LIBZIP_VERSION "0.10.1"
#define LIBZIP_VERSION_MAJOR 0
#define LIBZIP_VERSION_MINOR 10
#define LIBZIP_VERSION_MICRO 0

#include "crt/stdint.bi"

type zip_int8_t as int8_t
#define ZIP_INT8_MIN INT8_MIN
#define ZIP_INT8_MAX INT8_MAX

type zip_uint8_t as uint8_t
#define ZIP_UINT8_MAX UINT8_MAX

type zip_int16_t as int16_t
#define ZIP_INT16_MIN INT16_MIN
#define ZIP_INT16_MAX INT16_MAX

type zip_uint16_t as uint16_t
#define ZIP_UINT16_MAX UINT16_MAX

type zip_int32_t as int32_t
#define ZIP_INT32_MIN INT32_MIN
#define ZIP_INT32_MAX INT32_MAX

type zip_uint32_t as uint32_t
#define ZIP_UINT32_MAX UINT32_MAX

type zip_int64_t as int64_t
#define ZIP_INT64_MIN INT64_MIN
#define ZIP_INT64_MAX INT64_MAX

type zip_uint64_t as uint64_t
#define ZIP_UINT64_MAX UINT64_MAX
'' </zipconf.bi>

'' flags for zip_open

#define ZIP_CREATE           1
#define ZIP_EXCL             2
#define ZIP_CHECKCONS        4


'' flags for zip_name_locate, zip_fopen, zip_stat, ...

#define ZIP_FL_NOCASE      1 '' ignore case on name lookup
#define ZIP_FL_NODIR       2 '' ignore directory component
#define ZIP_FL_COMPRESSED  4 '' read compressed data
#define ZIP_FL_UNCHANGED   8 '' use original data, ignoring changes
#define ZIP_FL_RECOMPRESS 16 '' force recompression of data
#define ZIP_FL_ENCRYPTED  32 '' read encrypted data (implies ZIP_FL_COMPRESSED)


'' archive global flags flags

#define ZIP_AFL_TORRENT     1 '' torrent zipped
#define ZIP_AFL_RDONLY      2 '' read only -- cannot be cleared


'' flags for compression and encryption sources

#define ZIP_CODEC_ENCODE    1 '' compress/encrypt


'' libzip error codes

#define ZIP_ER_OK             0  '' N No error
#define ZIP_ER_MULTIDISK      1  '' N Multi-disk zip archives not supported
#define ZIP_ER_RENAME         2  '' S Renaming temporary file failed
#define ZIP_ER_CLOSE          3  '' S Closing zip archive failed
#define ZIP_ER_SEEK           4  '' S Seek error
#define ZIP_ER_READ           5  '' S Read error
#define ZIP_ER_WRITE          6  '' S Write error
#define ZIP_ER_CRC            7  '' N CRC error
#define ZIP_ER_ZIPCLOSED      8  '' N Containing zip archive was closed
#define ZIP_ER_NOENT          9  '' N No such file
#define ZIP_ER_EXISTS        10  '' N File already exists
#define ZIP_ER_OPEN          11  '' S Can't open file
#define ZIP_ER_TMPOPEN       12  '' S Failure to create temporary file
#define ZIP_ER_ZLIB          13  '' Z Zlib error
#define ZIP_ER_MEMORY        14  '' N Malloc failure
#define ZIP_ER_CHANGED       15  '' N Entry has been changed
#define ZIP_ER_COMPNOTSUPP   16  '' N Compression method not supported
#define ZIP_ER_EOF           17  '' N Premature EOF
#define ZIP_ER_INVAL         18  '' N Invalid argument
#define ZIP_ER_NOZIP         19  '' N Not a zip archive
#define ZIP_ER_INTERNAL      20  '' N Internal error
#define ZIP_ER_INCONS        21  '' N Zip archive inconsistent
#define ZIP_ER_REMOVE        22  '' S Can't remove file
#define ZIP_ER_DELETED       23  '' N Entry has been deleted
#define ZIP_ER_ENCRNOTSUPP   24  '' N Encryption method not supported
#define ZIP_ER_RDONLY        25  '' N Read-only archive
#define ZIP_ER_NOPASSWD      26  '' N No password provided
#define ZIP_ER_WRONGPASSWD   27  '' N Wrong password provided


'' type of system error value

#define ZIP_ET_NONE       0 '' sys_err unused
#define ZIP_ET_SYS        1 '' sys_err is errno
#define ZIP_ET_ZLIB       2 '' sys_err is zlib error code


'' compression methods

#define ZIP_CM_DEFAULT        -1  '' better of deflate or store
#define ZIP_CM_STORE           0  '' stored (uncompressed)
#define ZIP_CM_SHRINK          1  '' shrunk
#define ZIP_CM_REDUCE_1        2  '' reduced with factor 1
#define ZIP_CM_REDUCE_2        3  '' reduced with factor 2
#define ZIP_CM_REDUCE_3        4  '' reduced with factor 3
#define ZIP_CM_REDUCE_4        5  '' reduced with factor 4
#define ZIP_CM_IMPLODE         6  '' imploded
'' 7 - Reserved for Tokenizing compression algorithm
#define ZIP_CM_DEFLATE         8  '' deflated
#define ZIP_CM_DEFLATE64       9  '' deflate64
#define ZIP_CM_PKWARE_IMPLODE 10  '' PKWARE imploding
'' 11 - Reserved by PKWARE
#define ZIP_CM_BZIP2          12  '' compressed using BZIP2 algorithm
'' 13 - Reserved by PKWARE
#define ZIP_CM_LZMA           14  '' LZMA (EFS)
'' 15-17 - Reserved by PKWARE
#define ZIP_CM_TERSE          18  '' compressed using IBM TERSE (new)
#define ZIP_CM_LZ77           19  '' IBM LZ77 z Architecture (PFS)
#define ZIP_CM_WAVPACK        97  '' WavPack compressed data
#define ZIP_CM_PPMD           98  '' PPMd version I, Rev 1


'' encryption methods

#define ZIP_EM_NONE            0 '' not encrypted
#define ZIP_EM_TRAD_PKWARE     1 '' traditional PKWARE encryption
#if 0 '' Strong Encryption Header not parsed yet
#define ZIP_EM_DES        &h6601 '' strong encryption: DES
#define ZIP_EM_RC2_OLD    &h6602 '' strong encryption: RC2, version < 5.2
#define ZIP_EM_3DES_168   &h6603
#define ZIP_EM_3DES_112   &h6609
#define ZIP_EM_AES_128    &h660e
#define ZIP_EM_AES_192    &h660f
#define ZIP_EM_AES_256    &h6610
#define ZIP_EM_RC2        &h6702 '' strong encryption: RC2, version >= 5.2
#define ZIP_EM_RC4        &h6801
#endif
#define ZIP_EM_UNKNOWN    &hffff '' unknown algorithm

enum zip_source_cmd
    ZIP_SOURCE_OPEN  '' prepare for reading
    ZIP_SOURCE_READ  '' read data
    ZIP_SOURCE_CLOSE '' reading is done
    ZIP_SOURCE_STAT  '' get meta information
    ZIP_SOURCE_ERROR '' get error information
    '' TODO: name conflict with zip_source_free()
    ZIP_SOURCE_FREE_ '' cleanup and free resources
end enum

#define ZIP_SOURCE_ERR_LOWER    -2

#define ZIP_STAT_NAME           &h0001
'' TODO: name conflict with zip_stat_index()
#define ZIP_STAT_INDEX_         &h0002
#define ZIP_STAT_SIZE           &h0004
#define ZIP_STAT_COMP_SIZE      &h0008
#define ZIP_STAT_MTIME          &h0010
#define ZIP_STAT_CRC            &h0020
#define ZIP_STAT_COMP_METHOD        &h0040
#define ZIP_STAT_ENCRYPTION_METHOD  &h0080
#define ZIP_STAT_FLAGS          &h0100

type zip_stat
    as zip_uint64_t valid             '' which fields have valid values
    as const zstring ptr name         '' name of the file
    as zip_uint64_t index             '' index within archive
    as zip_uint64_t size              '' size of file (uncompressed)
    as zip_uint64_t comp_size         '' size of file (compressed)
    as time_t mtime                   '' modification time
    as zip_uint32_t crc               '' crc of file data
    as zip_uint16_t comp_method       '' compression method used
    as zip_uint16_t encryption_method '' encryption method used
    as zip_uint32_t flags             '' reserved for future use
end type

type zip as any
type zip_file as any
type zip_source as any

type zip_source_callback as function _
    ( _
        byval as any ptr, _
        byval as any ptr, _
        byval as zip_uint64_t, _
        byval as zip_source_cmd _
    ) as zip_int64_t

declare function zip_add(byval as zip ptr, byval as const zstring ptr, byval as zip_source ptr) as zip_int64_t
declare function zip_add_dir(byval as zip ptr, byval as const zstring ptr) as zip_int64_t
declare function zip_close(byval as zip ptr) as integer
declare function zip_delete(byval as zip ptr, byval as zip_uint64_t) as integer
declare sub zip_error_clear(byval as zip ptr)
declare sub zip_error_get(byval as zip ptr, byval as integer ptr, byval as integer ptr)
declare function zip_error_get_sys_type(byval as integer) as integer
declare function zip_error_to_str(byval as zstring ptr, byval as zip_uint64_t, byval as integer, byval as integer) as integer
declare function zip_fclose(byval as zip_file ptr) as integer
declare function zip_fdopen(byval as integer, byval as integer, byval as integer ptr) as zip ptr
declare sub zip_file_error_clear(byval as zip_file ptr)
declare sub zip_file_error_get(byval as zip_file ptr, byval as integer ptr, byval as integer ptr)
declare function zip_file_strerror(byval as zip_file ptr) as const zstring ptr
declare function zip_fopen(byval as zip ptr, byval as const zstring ptr, byval as integer) as zip_file ptr
declare function zip_fopen_encrypted(byval as zip ptr, byval as const zstring ptr, byval as integer, byval as const zstring ptr) as zip_file ptr
declare function zip_fopen_index(byval as zip ptr, byval as zip_uint64_t, byval as integer) as zip_file ptr
declare function zip_fopen_index_encrypted(byval as zip ptr, byval as zip_uint64_t, byval as integer, byval as const zstring ptr) as zip_file ptr
declare function zip_fread(byval as zip_file ptr, byval as any ptr, byval as zip_uint64_t) as zip_int64_t
declare function zip_get_archive_comment(byval as zip ptr, byval as integer ptr, byval as integer) as const zstring ptr
declare function zip_get_archive_flag(byval as zip ptr, byval as integer, byval as integer) as integer
declare function zip_get_file_comment(byval as zip ptr, byval as zip_uint64_t, byval as integer ptr, byval as integer) as const zstring ptr
declare function zip_get_file_extra(byval as zip ptr, byval as zip_uint64_t, byval as integer ptr, byval as integer) as const zstring ptr
declare function zip_get_name(byval as zip ptr, byval as zip_uint64_t, byval as integer) as const zstring ptr
declare function zip_get_num_entries(byval as zip ptr, byval as integer) as zip_uint64_t
declare function zip_get_num_files(byval as zip ptr) as integer '' deprecated, use zip_get_num_entries instead
declare function zip_name_locate(byval as zip ptr, byval as const zstring ptr, byval as integer) as integer
declare function zip_open(byval as const zstring ptr, byval as integer, byval as integer ptr) as zip ptr
declare function zip_rename(byval as zip ptr, byval as zip_uint64_t, byval as const zstring ptr) as integer
declare function zip_replace(byval as zip ptr, byval as zip_uint64_t, byval as zip_source ptr) as integer
declare function zip_set_archive_comment(byval as zip ptr, byval as const zstring ptr, byval as integer) as integer
declare function zip_set_archive_flag(byval as zip ptr, byval as integer, byval as integer) as integer
declare function zip_set_default_password(byval as zip ptr, byval as const zstring ptr) as integer
declare function zip_set_file_comment(byval as zip ptr, byval as zip_uint64_t, byval as const zstring ptr, byval as integer) as integer
declare function zip_set_file_extra(byval as zip ptr, byval as zip_uint64_t, byval as const zstring ptr, byval as integer) as integer
declare function zip_source_buffer(byval as zip ptr, byval as const any ptr, byval as zip_uint64_t, byval as integer) as zip_source ptr
declare function zip_source_file(byval as zip ptr, byval as const zstring ptr, byval as zip_uint64_t, byval as zip_int64_t) as zip_source ptr
declare function zip_source_filep(byval as zip ptr, byval as FILE ptr, byval as zip_uint64_t, byval as zip_int64_t) as zip_source ptr
declare sub zip_source_free(byval as zip_source ptr)
declare function zip_source_function(byval as zip ptr, byval as zip_source_callback, byval as any ptr) as zip_source ptr
declare function zip_source_zip(byval as zip ptr, byval as zip ptr, byval as zip_uint64_t, byval as integer, byval as zip_uint64_t, byval as zip_int64_t) as zip_source ptr
declare function zip_stat(byval as zip ptr, byval as const zstring ptr, byval as integer, byval as zip_stat ptr) as integer
declare function zip_stat_index(byval as zip ptr, byval as zip_uint64_t, byval as integer, byval as zip_stat ptr) as integer
declare sub zip_stat_init(byval as zip_stat ptr)
declare function zip_strerror(byval as zip ptr) as const zstring ptr
declare function zip_unchange(byval as zip ptr, byval as zip_uint64_t) as integer
declare function zip_unchange_all(byval as zip ptr) as integer
declare function zip_unchange_archive(byval as zip ptr) as integer

end extern

#endif
