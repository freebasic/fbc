'' FreeBASIC binding for gdbm-1.11
''
'' based on the C header files:
''    gdbm.h  -  The include file for dbm users.  -*- c -*- 
''     This file is part of GDBM, the GNU data base manager, by Philip A. Nelson.
''       Copyright (C) 1990, 1991, 1993, 2011 Free Software Foundation, Inc.
''
''       GDBM is free software; you can redistribute it and/or modify
''       it under the terms of the GNU General Public License as published by
''       the Free Software Foundation; either version 2, or (at your option)
''       any later version.
''
''       GDBM is distributed in the hope that it will be useful,
''       but WITHOUT ANY WARRANTY; without even the implied warranty of
''       MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
''       GNU General Public License for more details.
''
''       You should have received a copy of the GNU General Public License
''       along with GDBM. If not, see <http://www.gnu.org/licenses/>.  
''
''       You may contact the author by:
''          e-mail:  phil@cs.wwu.edu
''         us-mail:  Philip A. Nelson
''                   Computer Science Department
''                   Western Washington University
''                   Bellingham, WA 98226
''          
''   ************************************************************************
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "gdbm"

#include once "crt/long.bi"
#include once "crt/stdio.bi"

'' The following symbols have been renamed:
''     procedure gdbm_sync => gdbm_sync_

extern "C"

#define _GDBM_H_
const GDBM_READER = 0
const GDBM_WRITER = 1
const GDBM_WRCREAT = 2
const GDBM_NEWDB = 3
const GDBM_OPENMASK = 7
const GDBM_FAST = &h010
const GDBM_SYNC = &h020
const GDBM_NOLOCK = &h040
const GDBM_NOMMAP = &h080
const GDBM_CLOEXEC = &h100
const GDBM_INSERT = 0
const GDBM_REPLACE = 1
const GDBM_SETCACHESIZE = 1
const GDBM_FASTMODE = 2
const GDBM_SETSYNCMODE = 3
const GDBM_SETCENTFREE = 4
const GDBM_SETCOALESCEBLKS = 5
const GDBM_SETMAXMAPSIZE = 6
const GDBM_SETMMAP = 7
const GDBM_CACHESIZE = GDBM_SETCACHESIZE
const GDBM_SYNCMODE = GDBM_SETSYNCMODE
const GDBM_CENTFREE = GDBM_SETCENTFREE
const GDBM_COALESCEBLKS = GDBM_SETCOALESCEBLKS
const GDBM_GETFLAGS = 8
const GDBM_GETMMAP = 9
const GDBM_GETCACHESIZE = 10
const GDBM_GETSYNCMODE = 11
const GDBM_GETCENTFREE = 12
const GDBM_GETCOALESCEBLKS = 13
const GDBM_GETMAXMAPSIZE = 14
const GDBM_GETDBNAME = 15
type gdbm_count_t as ulongint

type datum
	dptr as zstring ptr
	dsize as long
end type

type GDBM_FILE as gdbm_file_info ptr
extern gdbm_version as const zstring ptr
const GDBM_VERSION_MAJOR = 1
const GDBM_VERSION_MINOR = 11
const GDBM_VERSION_PATCH = 0
extern gdbm_version_number(0 to 2) as const long

declare function gdbm_open(byval as const zstring ptr, byval as long, byval as long, byval as long, byval as sub(byval as const zstring ptr)) as GDBM_FILE
declare sub gdbm_close(byval as GDBM_FILE)
declare function gdbm_store(byval as GDBM_FILE, byval as datum, byval as datum, byval as long) as long
declare function gdbm_fetch(byval as GDBM_FILE, byval as datum) as datum
declare function gdbm_delete(byval as GDBM_FILE, byval as datum) as long
declare function gdbm_firstkey(byval as GDBM_FILE) as datum
declare function gdbm_nextkey(byval as GDBM_FILE, byval as datum) as datum
declare function gdbm_reorganize(byval as GDBM_FILE) as long
declare sub gdbm_sync_ alias "gdbm_sync"(byval as GDBM_FILE)
declare function gdbm_exists(byval as GDBM_FILE, byval as datum) as long
declare function gdbm_setopt(byval as GDBM_FILE, byval as long, byval as any ptr, byval as long) as long
declare function gdbm_fdesc(byval as GDBM_FILE) as long
declare function gdbm_export(byval as GDBM_FILE, byval as const zstring ptr, byval as long, byval as long) as long
declare function gdbm_export_to_file(byval dbf as GDBM_FILE, byval fp as FILE ptr) as long
declare function gdbm_import(byval as GDBM_FILE, byval as const zstring ptr, byval as long) as long
declare function gdbm_import_from_file(byval dbf as GDBM_FILE, byval fp as FILE ptr, byval flag as long) as long
declare function gdbm_count(byval dbf as GDBM_FILE, byval pcount as gdbm_count_t ptr) as long

const GDBM_DUMP_FMT_BINARY = 0
const GDBM_DUMP_FMT_ASCII = 1
const GDBM_META_MASK_MODE = &h01
const GDBM_META_MASK_OWNER = &h02

declare function gdbm_dump(byval as GDBM_FILE, byval as const zstring ptr, byval fmt as long, byval open_flags as long, byval mode as long) as long
declare function gdbm_dump_to_file(byval as GDBM_FILE, byval as FILE ptr, byval fmt as long) as long
declare function gdbm_load(byval as GDBM_FILE ptr, byval as const zstring ptr, byval replace as long, byval meta_flags as long, byval line as culong ptr) as long
declare function gdbm_load_from_file(byval as GDBM_FILE ptr, byval as FILE ptr, byval replace as long, byval meta_flags as long, byval line as culong ptr) as long

const GDBM_NO_ERROR = 0
const GDBM_MALLOC_ERROR = 1
const GDBM_BLOCK_SIZE_ERROR = 2
const GDBM_FILE_OPEN_ERROR = 3
const GDBM_FILE_WRITE_ERROR = 4
const GDBM_FILE_SEEK_ERROR = 5
const GDBM_FILE_READ_ERROR = 6
const GDBM_BAD_MAGIC_NUMBER = 7
const GDBM_EMPTY_DATABASE = 8
const GDBM_CANT_BE_READER = 9
const GDBM_CANT_BE_WRITER = 10
const GDBM_READER_CANT_DELETE = 11
const GDBM_READER_CANT_STORE = 12
const GDBM_READER_CANT_REORGANIZE = 13
const GDBM_UNKNOWN_UPDATE = 14
const GDBM_ITEM_NOT_FOUND = 15
const GDBM_REORGANIZE_FAILED = 16
const GDBM_CANNOT_REPLACE = 17
const GDBM_ILLEGAL_DATA = 18
const GDBM_OPT_ALREADY_SET = 19
const GDBM_OPT_ILLEGAL = 20
const GDBM_BYTE_SWAPPED = 21
const GDBM_BAD_FILE_OFFSET = 22
const GDBM_BAD_OPEN_FLAGS = 23
const GDBM_FILE_STAT_ERROR = 24
const GDBM_FILE_EOF = 25
const GDBM_NO_DBNAME = 26
const GDBM_ERR_FILE_OWNER = 27
const GDBM_ERR_FILE_MODE = 28
const _GDBM_MIN_ERRNO = 0
const _GDBM_MAX_ERRNO = GDBM_ERR_FILE_MODE
type gdbm_error as long
extern gdbm_errno as gdbm_error
extern gdbm_errlist(0 to _GDBM_MAX_ERRNO+1 - 1) as const zstring const ptr
declare function gdbm_strerror(byval as gdbm_error) as const zstring ptr
declare function gdbm_version_cmp(byval a as const long ptr, byval b as const long ptr) as long

end extern
