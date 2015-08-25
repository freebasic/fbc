'' FreeBASIC binding for libzip-1.0.1
''
'' based on the C header files:
''   zip.h -- exported declarations.
''   Copyright (C) 1999-2015 Dieter Baron and Thomas Klausner
''
''   This file is part of libzip, a library to manipulate ZIP archives.
''   The authors can be contacted at <libzip@nih.at>
''
''   Redistribution and use in source and binary forms, with or without
''   modification, are permitted provided that the following conditions
''   are met:
''   1. Redistributions of source code must retain the above copyright
''      notice, this list of conditions and the following disclaimer.
''   2. Redistributions in binary form must reproduce the above copyright
''      notice, this list of conditions and the following disclaimer in
''      the documentation and/or other materials provided with the
''      distribution.
''   3. The names of the authors may not be used to endorse or promote
''      products derived from this software without specific prior
''      written permission.
''
''   THIS SOFTWARE IS PROVIDED BY THE AUTHORS ``AS IS'' AND ANY EXPRESS
''   OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
''   WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
''   ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY
''   DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
''   DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
''   GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
''   INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
''   IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
''   OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
''   IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "zip"
#inclib "z"

#include once "crt/stdio.bi"
#include once "crt/time.bi"
#include once "crt/stdint.bi"

'' The following symbols have been renamed:
''     constant ZIP_SOURCE_OPEN => ZIP_SOURCE_OPEN_
''     constant ZIP_SOURCE_READ => ZIP_SOURCE_READ_
''     constant ZIP_SOURCE_CLOSE => ZIP_SOURCE_CLOSE_
''     constant ZIP_SOURCE_STAT => ZIP_SOURCE_STAT_
''     constant ZIP_SOURCE_ERROR => ZIP_SOURCE_ERROR_
''     constant ZIP_SOURCE_FREE => ZIP_SOURCE_FREE_
''     constant ZIP_SOURCE_SEEK => ZIP_SOURCE_SEEK_
''     constant ZIP_SOURCE_TELL => ZIP_SOURCE_TELL_
''     constant ZIP_SOURCE_BEGIN_WRITE => ZIP_SOURCE_BEGIN_WRITE_
''     constant ZIP_SOURCE_COMMIT_WRITE => ZIP_SOURCE_COMMIT_WRITE_
''     constant ZIP_SOURCE_ROLLBACK_WRITE => ZIP_SOURCE_ROLLBACK_WRITE_
''     constant ZIP_SOURCE_WRITE => ZIP_SOURCE_WRITE_
''     constant ZIP_SOURCE_SEEK_WRITE => ZIP_SOURCE_SEEK_WRITE_
''     constant ZIP_SOURCE_TELL_WRITE => ZIP_SOURCE_TELL_WRITE_
''     constant ZIP_STAT_INDEX => ZIP_STAT_INDEX_

extern "C"

#define LIBZIP_VERSION "1.0.1"
const LIBZIP_VERSION_MAJOR = 1
const LIBZIP_VERSION_MINOR = 0
const LIBZIP_VERSION_MICRO = 1
type zip_int8_t as byte
#define ZIP_INT8_MIN INT8_MIN
#define ZIP_INT8_MAX INT8_MAX
type zip_uint8_t as ubyte
#define ZIP_UINT8_MAX UINT8_MAX
type zip_int16_t as short
#define ZIP_INT16_MIN INT16_MIN
#define ZIP_INT16_MAX INT16_MAX
type zip_uint16_t as ushort
#define ZIP_UINT16_MAX UINT16_MAX
type zip_int32_t as long
#define ZIP_INT32_MIN INT32_MIN
#define ZIP_INT32_MAX INT32_MAX
type zip_uint32_t as ulong
#define ZIP_UINT32_MAX UINT32_MAX
type zip_int64_t as longint
#define ZIP_INT64_MIN INT64_MIN
#define ZIP_INT64_MAX INT64_MAX
type zip_uint64_t as ulongint
#define ZIP_UINT64_MAX UINT64_MAX
const ZIP_CREATE = 1
const ZIP_EXCL = 2
const ZIP_CHECKCONS = 4
const ZIP_TRUNCATE = 8
const ZIP_RDONLY = 16
const ZIP_FL_NOCASE = 1u
const ZIP_FL_NODIR = 2u
const ZIP_FL_COMPRESSED = 4u
const ZIP_FL_UNCHANGED = 8u
const ZIP_FL_RECOMPRESS = 16u
const ZIP_FL_ENCRYPTED = 32u
const ZIP_FL_ENC_GUESS = 0u
const ZIP_FL_ENC_RAW = 64u
const ZIP_FL_ENC_STRICT = 128u
const ZIP_FL_LOCAL = 256u
const ZIP_FL_CENTRAL = 512u
const ZIP_FL_ENC_UTF_8 = 2048u
const ZIP_FL_ENC_CP437 = 4096u
const ZIP_FL_OVERWRITE = 8192u
const ZIP_AFL_RDONLY = 2u
#define ZIP_EXTRA_FIELD_ALL ZIP_UINT16_MAX
#define ZIP_EXTRA_FIELD_NEW ZIP_UINT16_MAX
const ZIP_ER_OK = 0
const ZIP_ER_MULTIDISK = 1
const ZIP_ER_RENAME = 2
const ZIP_ER_CLOSE = 3
const ZIP_ER_SEEK = 4
const ZIP_ER_READ = 5
const ZIP_ER_WRITE = 6
const ZIP_ER_CRC = 7
const ZIP_ER_ZIPCLOSED = 8
const ZIP_ER_NOENT = 9
const ZIP_ER_EXISTS = 10
const ZIP_ER_OPEN = 11
const ZIP_ER_TMPOPEN = 12
const ZIP_ER_ZLIB = 13
const ZIP_ER_MEMORY = 14
const ZIP_ER_CHANGED = 15
const ZIP_ER_COMPNOTSUPP = 16
const ZIP_ER_EOF = 17
const ZIP_ER_INVAL = 18
const ZIP_ER_NOZIP = 19
const ZIP_ER_INTERNAL = 20
const ZIP_ER_INCONS = 21
const ZIP_ER_REMOVE = 22
const ZIP_ER_DELETED = 23
const ZIP_ER_ENCRNOTSUPP = 24
const ZIP_ER_RDONLY = 25
const ZIP_ER_NOPASSWD = 26
const ZIP_ER_WRONGPASSWD = 27
const ZIP_ER_OPNOTSUPP = 28
const ZIP_ER_INUSE = 29
const ZIP_ER_TELL = 30
const ZIP_ET_NONE = 0
const ZIP_ET_SYS = 1
const ZIP_ET_ZLIB = 2
const ZIP_CM_DEFAULT = -1
const ZIP_CM_STORE = 0
const ZIP_CM_SHRINK = 1
const ZIP_CM_REDUCE_1 = 2
const ZIP_CM_REDUCE_2 = 3
const ZIP_CM_REDUCE_3 = 4
const ZIP_CM_REDUCE_4 = 5
const ZIP_CM_IMPLODE = 6
const ZIP_CM_DEFLATE = 8
const ZIP_CM_DEFLATE64 = 9
const ZIP_CM_PKWARE_IMPLODE = 10
const ZIP_CM_BZIP2 = 12
const ZIP_CM_LZMA = 14
const ZIP_CM_TERSE = 18
const ZIP_CM_LZ77 = 19
const ZIP_CM_WAVPACK = 97
const ZIP_CM_PPMD = 98
const ZIP_EM_NONE = 0
const ZIP_EM_TRAD_PKWARE = 1
const ZIP_EM_UNKNOWN = &hffff
const ZIP_OPSYS_DOS = &h00u
const ZIP_OPSYS_AMIGA = &h01u
const ZIP_OPSYS_OPENVMS = &h02u
const ZIP_OPSYS_UNIX = &h03u
const ZIP_OPSYS_VM_CMS = &h04u
const ZIP_OPSYS_ATARI_ST = &h05u
const ZIP_OPSYS_OS_2 = &h06u
const ZIP_OPSYS_MACINTOSH = &h07u
const ZIP_OPSYS_Z_SYSTEM = &h08u
const ZIP_OPSYS_CPM = &h09u
const ZIP_OPSYS_WINDOWS_NTFS = &h0au
const ZIP_OPSYS_MVS = &h0bu
const ZIP_OPSYS_VSE = &h0cu
const ZIP_OPSYS_ACORN_RISC = &h0du
const ZIP_OPSYS_VFAT = &h0eu
const ZIP_OPSYS_ALTERNATE_MVS = &h0fu
const ZIP_OPSYS_BEOS = &h10u
const ZIP_OPSYS_TANDEM = &h11u
const ZIP_OPSYS_OS_400 = &h12u
const ZIP_OPSYS_OS_X = &h13u
const ZIP_OPSYS_DEFAULT = ZIP_OPSYS_UNIX

type zip_source_cmd as long
enum
	ZIP_SOURCE_OPEN_
	ZIP_SOURCE_READ_
	ZIP_SOURCE_CLOSE_
	ZIP_SOURCE_STAT_
	ZIP_SOURCE_ERROR_
	ZIP_SOURCE_FREE_
	ZIP_SOURCE_SEEK_
	ZIP_SOURCE_TELL_
	ZIP_SOURCE_BEGIN_WRITE_
	ZIP_SOURCE_COMMIT_WRITE_
	ZIP_SOURCE_ROLLBACK_WRITE_
	ZIP_SOURCE_WRITE_
	ZIP_SOURCE_SEEK_WRITE_
	ZIP_SOURCE_TELL_WRITE_
	ZIP_SOURCE_SUPPORTS
	ZIP_SOURCE_REMOVE
end enum

type zip_source_cmd_t as zip_source_cmd
#define ZIP_SOURCE_MAKE_COMMAND_BITMASK(cmd) (1 shl (cmd))
#define ZIP_SOURCE_SUPPORTS_READABLE (((((ZIP_SOURCE_MAKE_COMMAND_BITMASK(ZIP_SOURCE_OPEN_) or ZIP_SOURCE_MAKE_COMMAND_BITMASK(ZIP_SOURCE_READ_)) or ZIP_SOURCE_MAKE_COMMAND_BITMASK(ZIP_SOURCE_CLOSE_)) or ZIP_SOURCE_MAKE_COMMAND_BITMASK(ZIP_SOURCE_STAT_)) or ZIP_SOURCE_MAKE_COMMAND_BITMASK(ZIP_SOURCE_ERROR_)) or ZIP_SOURCE_MAKE_COMMAND_BITMASK(ZIP_SOURCE_FREE_))
#define ZIP_SOURCE_SUPPORTS_SEEKABLE (((ZIP_SOURCE_SUPPORTS_READABLE or ZIP_SOURCE_MAKE_COMMAND_BITMASK(ZIP_SOURCE_SEEK_)) or ZIP_SOURCE_MAKE_COMMAND_BITMASK(ZIP_SOURCE_TELL_)) or ZIP_SOURCE_MAKE_COMMAND_BITMASK(ZIP_SOURCE_SUPPORTS))
#define ZIP_SOURCE_SUPPORTS_WRITABLE (((((((ZIP_SOURCE_SUPPORTS_SEEKABLE or ZIP_SOURCE_MAKE_COMMAND_BITMASK(ZIP_SOURCE_BEGIN_WRITE_)) or ZIP_SOURCE_MAKE_COMMAND_BITMASK(ZIP_SOURCE_COMMIT_WRITE_)) or ZIP_SOURCE_MAKE_COMMAND_BITMASK(ZIP_SOURCE_ROLLBACK_WRITE_)) or ZIP_SOURCE_MAKE_COMMAND_BITMASK(ZIP_SOURCE_WRITE_)) or ZIP_SOURCE_MAKE_COMMAND_BITMASK(ZIP_SOURCE_SEEK_WRITE_)) or ZIP_SOURCE_MAKE_COMMAND_BITMASK(ZIP_SOURCE_TELL_WRITE_)) or ZIP_SOURCE_MAKE_COMMAND_BITMASK(ZIP_SOURCE_REMOVE))

type zip_source_args_seek
	offset as zip_int64_t
	whence as long
end type

type zip_source_args_seek_t as zip_source_args_seek
'' TODO: #define ZIP_SOURCE_GET_ARGS(type, data, len, error) ((len) < sizeof(type) ? zip_error_set((error), ZIP_ER_INVAL, 0), (type *)NULL : (type *)(data))

type zip_error
	zip_err as long
	sys_err as long
	str as zstring ptr
end type

const ZIP_STAT_NAME = &h0001u
const ZIP_STAT_INDEX_ = &h0002u
const ZIP_STAT_SIZE = &h0004u
const ZIP_STAT_COMP_SIZE = &h0008u
const ZIP_STAT_MTIME = &h0010u
const ZIP_STAT_CRC = &h0020u
const ZIP_STAT_COMP_METHOD = &h0040u
const ZIP_STAT_ENCRYPTION_METHOD = &h0080u
const ZIP_STAT_FLAGS = &h0100u

type zip_stat
	valid as zip_uint64_t
	name as const zstring ptr
	index as zip_uint64_t
	size as zip_uint64_t
	comp_size as zip_uint64_t
	mtime as time_t
	crc as zip_uint32_t
	comp_method as zip_uint16_t
	encryption_method as zip_uint16_t
	flags as zip_uint32_t
end type

type zip_t as zip
type zip_error_t as zip_error
type zip_file_t as zip_file
type zip_source_t as zip_source
type zip_stat_t as zip_stat
type zip_flags_t as zip_uint32_t
type zip_source_callback as function(byval as any ptr, byval as any ptr, byval as zip_uint64_t, byval as zip_source_cmd_t) as zip_int64_t

declare function zip_add(byval as zip_t ptr, byval as const zstring ptr, byval as zip_source_t ptr) as zip_int64_t
declare function zip_add_dir(byval as zip_t ptr, byval as const zstring ptr) as zip_int64_t
declare function zip_get_file_comment(byval as zip_t ptr, byval as zip_uint64_t, byval as long ptr, byval as long) as const zstring ptr
declare function zip_get_num_files(byval as zip_t ptr) as long
declare function zip_rename(byval as zip_t ptr, byval as zip_uint64_t, byval as const zstring ptr) as long
declare function zip_replace(byval as zip_t ptr, byval as zip_uint64_t, byval as zip_source_t ptr) as long
declare function zip_set_file_comment(byval as zip_t ptr, byval as zip_uint64_t, byval as const zstring ptr, byval as long) as long
declare function zip_error_get_sys_type(byval as long) as long
declare sub zip_error_get(byval as zip_t ptr, byval as long ptr, byval as long ptr)
declare function zip_error_to_str(byval as zstring ptr, byval as zip_uint64_t, byval as long, byval as long) as long
declare sub zip_file_error_get(byval as zip_file_t ptr, byval as long ptr, byval as long ptr)
declare function zip_archive_set_tempdir(byval as zip_t ptr, byval as const zstring ptr) as long
declare function zip_close(byval as zip_t ptr) as long
declare function zip_delete(byval as zip_t ptr, byval as zip_uint64_t) as long
declare function zip_dir_add(byval as zip_t ptr, byval as const zstring ptr, byval as zip_flags_t) as zip_int64_t
declare sub zip_discard(byval as zip_t ptr)
declare function zip_get_error(byval as zip_t ptr) as zip_error_t ptr
declare sub zip_error_clear(byval as zip_t ptr)
declare function zip_error_code_zip(byval as const zip_error_t ptr) as long
declare function zip_error_code_system(byval as const zip_error_t ptr) as long
declare sub zip_error_fini(byval as zip_error_t ptr)
declare sub zip_error_init(byval as zip_error_t ptr)
declare sub zip_error_init_with_code(byval as zip_error_t ptr, byval as long)
declare sub zip_error_set(byval as zip_error_t ptr, byval as long, byval as long)
declare function zip_error_strerror(byval as zip_error_t ptr) as const zstring ptr
declare function zip_error_system_type(byval as const zip_error_t ptr) as long
declare function zip_error_to_data(byval as const zip_error_t ptr, byval as any ptr, byval as zip_uint64_t) as zip_int64_t
declare function zip_fclose(byval as zip_file_t ptr) as long
declare function zip_fdopen(byval as long, byval as long, byval as long ptr) as zip_t ptr
declare function zip_file_add(byval as zip_t ptr, byval as const zstring ptr, byval as zip_source_t ptr, byval as zip_flags_t) as zip_int64_t
declare sub zip_file_error_clear(byval as zip_file_t ptr)
declare function zip_file_extra_field_delete(byval as zip_t ptr, byval as zip_uint64_t, byval as zip_uint16_t, byval as zip_flags_t) as long
declare function zip_file_extra_field_delete_by_id(byval as zip_t ptr, byval as zip_uint64_t, byval as zip_uint16_t, byval as zip_uint16_t, byval as zip_flags_t) as long
declare function zip_file_extra_field_set(byval as zip_t ptr, byval as zip_uint64_t, byval as zip_uint16_t, byval as zip_uint16_t, byval as const zip_uint8_t ptr, byval as zip_uint16_t, byval as zip_flags_t) as long
declare function zip_file_extra_fields_count(byval as zip_t ptr, byval as zip_uint64_t, byval as zip_flags_t) as zip_int16_t
declare function zip_file_extra_fields_count_by_id(byval as zip_t ptr, byval as zip_uint64_t, byval as zip_uint16_t, byval as zip_flags_t) as zip_int16_t
declare function zip_file_extra_field_get(byval as zip_t ptr, byval as zip_uint64_t, byval as zip_uint16_t, byval as zip_uint16_t ptr, byval as zip_uint16_t ptr, byval as zip_flags_t) as const zip_uint8_t ptr
declare function zip_file_extra_field_get_by_id(byval as zip_t ptr, byval as zip_uint64_t, byval as zip_uint16_t, byval as zip_uint16_t, byval as zip_uint16_t ptr, byval as zip_flags_t) as const zip_uint8_t ptr
declare function zip_file_get_comment(byval as zip_t ptr, byval as zip_uint64_t, byval as zip_uint32_t ptr, byval as zip_flags_t) as const zstring ptr
declare function zip_file_get_error(byval as zip_file_t ptr) as zip_error_t ptr
declare function zip_file_get_external_attributes(byval as zip_t ptr, byval as zip_uint64_t, byval as zip_flags_t, byval as zip_uint8_t ptr, byval as zip_uint32_t ptr) as long
declare function zip_file_rename(byval as zip_t ptr, byval as zip_uint64_t, byval as const zstring ptr, byval as zip_flags_t) as long
declare function zip_file_replace(byval as zip_t ptr, byval as zip_uint64_t, byval as zip_source_t ptr, byval as zip_flags_t) as long
declare function zip_file_set_comment(byval as zip_t ptr, byval as zip_uint64_t, byval as const zstring ptr, byval as zip_uint16_t, byval as zip_flags_t) as long
declare function zip_file_set_external_attributes(byval as zip_t ptr, byval as zip_uint64_t, byval as zip_flags_t, byval as zip_uint8_t, byval as zip_uint32_t) as long
declare function zip_file_set_mtime(byval as zip_t ptr, byval as zip_uint64_t, byval as time_t, byval as zip_flags_t) as long
declare function zip_file_strerror(byval as zip_file_t ptr) as const zstring ptr
declare function zip_fopen(byval as zip_t ptr, byval as const zstring ptr, byval as zip_flags_t) as zip_file_t ptr
declare function zip_fopen_encrypted(byval as zip_t ptr, byval as const zstring ptr, byval as zip_flags_t, byval as const zstring ptr) as zip_file_t ptr
declare function zip_fopen_index(byval as zip_t ptr, byval as zip_uint64_t, byval as zip_flags_t) as zip_file_t ptr
declare function zip_fopen_index_encrypted(byval as zip_t ptr, byval as zip_uint64_t, byval as zip_flags_t, byval as const zstring ptr) as zip_file_t ptr
declare function zip_fread(byval as zip_file_t ptr, byval as any ptr, byval as zip_uint64_t) as zip_int64_t
declare function zip_get_archive_comment(byval as zip_t ptr, byval as long ptr, byval as zip_flags_t) as const zstring ptr
declare function zip_get_archive_flag(byval as zip_t ptr, byval as zip_flags_t, byval as zip_flags_t) as long
declare function zip_get_name(byval as zip_t ptr, byval as zip_uint64_t, byval as zip_flags_t) as const zstring ptr
declare function zip_get_num_entries(byval as zip_t ptr, byval as zip_flags_t) as zip_int64_t
declare function zip_name_locate(byval as zip_t ptr, byval as const zstring ptr, byval as zip_flags_t) as zip_int64_t
declare function zip_open(byval as const zstring ptr, byval as long, byval as long ptr) as zip_t ptr
declare function zip_open_from_source(byval as zip_source_t ptr, byval as long, byval as zip_error_t ptr) as zip_t ptr
declare function zip_set_archive_comment(byval as zip_t ptr, byval as const zstring ptr, byval as zip_uint16_t) as long
declare function zip_set_archive_flag(byval as zip_t ptr, byval as zip_flags_t, byval as long) as long
declare function zip_set_default_password(byval as zip_t ptr, byval as const zstring ptr) as long
declare function zip_set_file_compression(byval as zip_t ptr, byval as zip_uint64_t, byval as zip_int32_t, byval as zip_uint32_t) as long
declare function zip_source_begin_write(byval as zip_source_t ptr) as long
declare function zip_source_buffer(byval as zip_t ptr, byval as const any ptr, byval as zip_uint64_t, byval as long) as zip_source_t ptr
declare function zip_source_buffer_create(byval as const any ptr, byval as zip_uint64_t, byval as long, byval as zip_error_t ptr) as zip_source_t ptr
declare function zip_source_close(byval as zip_source_t ptr) as long
declare function zip_source_commit_write(byval as zip_source_t ptr) as long
declare function zip_source_error(byval src as zip_source_t ptr) as zip_error_t ptr
declare function zip_source_file(byval as zip_t ptr, byval as const zstring ptr, byval as zip_uint64_t, byval as zip_int64_t) as zip_source_t ptr
declare function zip_source_file_create(byval as const zstring ptr, byval as zip_uint64_t, byval as zip_int64_t, byval as zip_error_t ptr) as zip_source_t ptr
declare function zip_source_filep(byval as zip_t ptr, byval as FILE ptr, byval as zip_uint64_t, byval as zip_int64_t) as zip_source_t ptr
declare function zip_source_filep_create(byval as FILE ptr, byval as zip_uint64_t, byval as zip_int64_t, byval as zip_error_t ptr) as zip_source_t ptr
declare sub zip_source_free(byval as zip_source_t ptr)
declare function zip_source_function(byval as zip_t ptr, byval as zip_source_callback, byval as any ptr) as zip_source_t ptr
declare function zip_source_function_create(byval as zip_source_callback, byval as any ptr, byval as zip_error_t ptr) as zip_source_t ptr
declare function zip_source_is_deleted(byval as zip_source_t ptr) as long
declare sub zip_source_keep(byval as zip_source_t ptr)
declare function zip_source_make_command_bitmap(byval as zip_source_cmd_t, ...) as zip_int64_t
declare function zip_source_open(byval as zip_source_t ptr) as long
declare function zip_source_read(byval as zip_source_t ptr, byval as any ptr, byval as zip_uint64_t) as zip_int64_t
declare sub zip_source_rollback_write(byval as zip_source_t ptr)
declare function zip_source_seek(byval as zip_source_t ptr, byval as zip_int64_t, byval as long) as long
declare function zip_source_seek_compute_offset(byval as zip_uint64_t, byval as zip_uint64_t, byval as any ptr, byval as zip_uint64_t, byval as zip_error_t ptr) as zip_int64_t
declare function zip_source_seek_write(byval as zip_source_t ptr, byval as zip_int64_t, byval as long) as long
declare function zip_source_stat(byval as zip_source_t ptr, byval as zip_stat_t ptr) as long
declare function zip_source_tell(byval as zip_source_t ptr) as zip_int64_t
declare function zip_source_tell_write(byval as zip_source_t ptr) as zip_int64_t

#ifdef __FB_WIN32__
	declare function zip_source_win32a(byval as zip_t ptr, byval as const zstring ptr, byval as zip_uint64_t, byval as zip_int64_t) as zip_source_t ptr
	declare function zip_source_win32a_create(byval as const zstring ptr, byval as zip_uint64_t, byval as zip_int64_t, byval as zip_error_t ptr) as zip_source_t ptr
	declare function zip_source_win32handle(byval as zip_t ptr, byval as any ptr, byval as zip_uint64_t, byval as zip_int64_t) as zip_source_t ptr
	declare function zip_source_win32handle_create(byval as any ptr, byval as zip_uint64_t, byval as zip_int64_t, byval as zip_error_t ptr) as zip_source_t ptr
	declare function zip_source_win32w(byval as zip_t ptr, byval as const wstring ptr, byval as zip_uint64_t, byval as zip_int64_t) as zip_source_t ptr
	declare function zip_source_win32w_create(byval as const wstring ptr, byval as zip_uint64_t, byval as zip_int64_t, byval as zip_error_t ptr) as zip_source_t ptr
#endif

declare function zip_source_write(byval as zip_source_t ptr, byval as const any ptr, byval as zip_uint64_t) as zip_int64_t
declare function zip_source_zip(byval as zip_t ptr, byval as zip_t ptr, byval as zip_uint64_t, byval as zip_flags_t, byval as zip_uint64_t, byval as zip_int64_t) as zip_source_t ptr
declare function zip_stat(byval as zip_t ptr, byval as const zstring ptr, byval as zip_flags_t, byval as zip_stat_t ptr) as long
declare function zip_stat_index(byval as zip_t ptr, byval as zip_uint64_t, byval as zip_flags_t, byval as zip_stat_t ptr) as long
declare sub zip_stat_init(byval as zip_stat_t ptr)
declare function zip_strerror(byval as zip_t ptr) as const zstring ptr
declare function zip_unchange(byval as zip_t ptr, byval as zip_uint64_t) as long
declare function zip_unchange_all(byval as zip_t ptr) as long
declare function zip_unchange_archive(byval as zip_t ptr) as long

end extern
