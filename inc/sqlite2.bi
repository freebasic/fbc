'' FreeBASIC binding for SQLite 2.8.17
''
'' based on the C header files:
''   * 2001 September 15
''   *
''   * The author disclaims copyright to this source code.  In place of
''   * a legal notice, here is a blessing:
''   *
''   *    May you do good and not evil.
''   *    May you find forgiveness for yourself and forgive others.
''   *    May you share freely, never taking more than you give.
''   *
''   ************************************************************************
''   * This header file defines the interface that the SQLite library
''   * presents to client programs.
''   *
''   * @(#) $Id: sqlite.h.in,v 1.60.2.1 2004/10/06 15:52:36 drh Exp $
''
'' translated to FreeBASIC by:
''   Copyright © 2020 FreeBASIC development team

#pragma once

#inclib "sqlite"

#include once "crt/stdarg.bi"

'' The following symbols have been renamed:
''     #define sqlite_version => sqlite_version_
''     procedure sqlite_interrupt => sqlite_interrupt_

extern "C"

#define _SQLITE_H_
#define SQLITE_VERSION "2.8.17"
extern __sqlite_version_ alias "sqlite_version" as const byte
#define sqlite_version_ (*cptr(const zstring ptr, @__sqlite_version_))
const SQLITE_ISO8859 = 1
extern __sqlite_encoding alias "sqlite_encoding" as const byte
#define sqlite_encoding (*cptr(const zstring ptr, @__sqlite_encoding))
type sqlite as sqlite_
declare function sqlite_open(byval filename as const zstring ptr, byval mode as long, byval errmsg as zstring ptr ptr) as sqlite ptr
declare sub sqlite_close(byval as sqlite ptr)
type sqlite_callback as function(byval as any ptr, byval as long, byval as zstring ptr ptr, byval as zstring ptr ptr) as long
declare function sqlite_exec(byval as sqlite ptr, byval sql as const zstring ptr, byval as sqlite_callback, byval as any ptr, byval errmsg as zstring ptr ptr) as long
const SQLITE_OK = 0
const SQLITE_ERROR = 1
const SQLITE_INTERNAL = 2
const SQLITE_PERM = 3
const SQLITE_ABORT = 4
const SQLITE_BUSY = 5
const SQLITE_LOCKED = 6
const SQLITE_NOMEM = 7
const SQLITE_READONLY = 8
const SQLITE_INTERRUPT = 9
const SQLITE_IOERR = 10
const SQLITE_CORRUPT = 11
const SQLITE_NOTFOUND = 12
const SQLITE_FULL = 13
const SQLITE_CANTOPEN = 14
const SQLITE_PROTOCOL = 15
const SQLITE_EMPTY = 16
const SQLITE_SCHEMA = 17
const SQLITE_TOOBIG = 18
const SQLITE_CONSTRAINT = 19
const SQLITE_MISMATCH = 20
const SQLITE_MISUSE = 21
const SQLITE_NOLFS = 22
const SQLITE_AUTH = 23
const SQLITE_FORMAT = 24
const SQLITE_RANGE = 25
const SQLITE_NOTADB = 26
const SQLITE_ROW = 100
const SQLITE_DONE = 101

declare function sqlite_last_insert_rowid(byval as sqlite ptr) as long
declare function sqlite_changes(byval as sqlite ptr) as long
declare function sqlite_last_statement_changes(byval as sqlite ptr) as long
declare function sqlite_error_string(byval as long) as const zstring ptr
declare function sqliteErrStr alias "sqlite_error_string"(byval as long) as const zstring ptr
declare sub sqlite_interrupt_ alias "sqlite_interrupt"(byval as sqlite ptr)
declare function sqlite_complete(byval sql as const zstring ptr) as long
declare sub sqlite_busy_handler(byval as sqlite ptr, byval as function(byval as any ptr, byval as const zstring ptr, byval as long) as long, byval as any ptr)
declare sub sqlite_busy_timeout(byval as sqlite ptr, byval ms as long)
declare function sqlite_get_table(byval as sqlite ptr, byval sql as const zstring ptr, byval resultp as zstring ptr ptr ptr, byval nrow as long ptr, byval ncolumn as long ptr, byval errmsg as zstring ptr ptr) as long
declare sub sqlite_free_table(byval result as zstring ptr ptr)
declare function sqlite_exec_printf(byval as sqlite ptr, byval sqlFormat as const zstring ptr, byval as sqlite_callback, byval as any ptr, byval errmsg as zstring ptr ptr, ...) as long
declare function sqlite_exec_vprintf(byval as sqlite ptr, byval sqlFormat as const zstring ptr, byval as sqlite_callback, byval as any ptr, byval errmsg as zstring ptr ptr, byval ap as va_list) as long
declare function sqlite_get_table_printf(byval as sqlite ptr, byval sqlFormat as const zstring ptr, byval resultp as zstring ptr ptr ptr, byval nrow as long ptr, byval ncolumn as long ptr, byval errmsg as zstring ptr ptr, ...) as long
declare function sqlite_get_table_vprintf(byval as sqlite ptr, byval sqlFormat as const zstring ptr, byval resultp as zstring ptr ptr ptr, byval nrow as long ptr, byval ncolumn as long ptr, byval errmsg as zstring ptr ptr, byval ap as va_list) as long
declare function sqlite_mprintf(byval as const zstring ptr, ...) as zstring ptr
declare function sqlite_vmprintf(byval as const zstring ptr, byval as va_list) as zstring ptr
declare sub sqlite_freemem(byval p as any ptr)
declare function sqlite_libversion() as const zstring ptr
declare function sqlite_libencoding() as const zstring ptr
type sqlite_func as sqlite_func_
declare function sqlite_create_function(byval as sqlite ptr, byval zName as const zstring ptr, byval nArg as long, byval xFunc as sub(byval as sqlite_func ptr, byval as long, byval as const zstring ptr ptr), byval pUserData as any ptr) as long
declare function sqlite_create_aggregate(byval as sqlite ptr, byval zName as const zstring ptr, byval nArg as long, byval xStep as sub(byval as sqlite_func ptr, byval as long, byval as const zstring ptr ptr), byval xFinalize as sub(byval as sqlite_func ptr), byval pUserData as any ptr) as long
declare function sqlite_function_type(byval db as sqlite ptr, byval zName as const zstring ptr, byval datatype as long) as long

const SQLITE_NUMERIC = -1
const SQLITE_ARGS = -3
const SQLITE_TEXT = -2
const SQLITE2_TEXT = -2

declare function sqlite_set_result_string(byval as sqlite_func ptr, byval as const zstring ptr, byval as long) as zstring ptr
declare sub sqlite_set_result_int(byval as sqlite_func ptr, byval as long)
declare sub sqlite_set_result_double(byval as sqlite_func ptr, byval as double)
declare sub sqlite_set_result_error(byval as sqlite_func ptr, byval as const zstring ptr, byval as long)
declare function sqlite_user_data(byval as sqlite_func ptr) as any ptr
declare function sqlite_aggregate_context(byval as sqlite_func ptr, byval nBytes as long) as any ptr
declare function sqlite_aggregate_count(byval as sqlite_func ptr) as long
declare function sqlite_set_authorizer(byval as sqlite ptr, byval xAuth as function(byval as any ptr, byval as long, byval as const zstring ptr, byval as const zstring ptr, byval as const zstring ptr, byval as const zstring ptr) as long, byval pUserData as any ptr) as long

const SQLITE_COPY = 0
const SQLITE_CREATE_INDEX = 1
const SQLITE_CREATE_TABLE = 2
const SQLITE_CREATE_TEMP_INDEX = 3
const SQLITE_CREATE_TEMP_TABLE = 4
const SQLITE_CREATE_TEMP_TRIGGER = 5
const SQLITE_CREATE_TEMP_VIEW = 6
const SQLITE_CREATE_TRIGGER = 7
const SQLITE_CREATE_VIEW = 8
const SQLITE_DELETE = 9
const SQLITE_DROP_INDEX = 10
const SQLITE_DROP_TABLE = 11
const SQLITE_DROP_TEMP_INDEX = 12
const SQLITE_DROP_TEMP_TABLE = 13
const SQLITE_DROP_TEMP_TRIGGER = 14
const SQLITE_DROP_TEMP_VIEW = 15
const SQLITE_DROP_TRIGGER = 16
const SQLITE_DROP_VIEW = 17
const SQLITE_INSERT = 18
const SQLITE_PRAGMA = 19
const SQLITE_READ = 20
const SQLITE_SELECT = 21
const SQLITE_TRANSACTION = 22
const SQLITE_UPDATE = 23
const SQLITE_ATTACH = 24
const SQLITE_DETACH = 25
const SQLITE_DENY = 1
const SQLITE_IGNORE = 2
declare function sqlite_trace(byval as sqlite ptr, byval xTrace as sub(byval as any ptr, byval as const zstring ptr), byval as any ptr) as any ptr
type sqlite_vm as sqlite_vm_

declare function sqlite_compile(byval db as sqlite ptr, byval zSql as const zstring ptr, byval pzTail as const zstring ptr ptr, byval ppVm as sqlite_vm ptr ptr, byval pzErrmsg as zstring ptr ptr) as long
declare function sqlite_step(byval pVm as sqlite_vm ptr, byval pN as long ptr, byval pazValue as const zstring ptr ptr ptr, byval pazColName as const zstring ptr ptr ptr) as long
declare function sqlite_finalize(byval as sqlite_vm ptr, byval pzErrMsg as zstring ptr ptr) as long
declare function sqlite_reset(byval as sqlite_vm ptr, byval pzErrMsg as zstring ptr ptr) as long
declare function sqlite_bind(byval as sqlite_vm ptr, byval idx as long, byval value as const zstring ptr, byval len as long, byval copy as long) as long
declare sub sqlite_progress_handler(byval as sqlite ptr, byval as long, byval as function(byval as any ptr) as long, byval as any ptr)
declare function sqlite_commit_hook(byval as sqlite ptr, byval as function(byval as any ptr) as long, byval as any ptr) as any ptr
declare function sqlite_open_encrypted(byval zFilename as const zstring ptr, byval pKey as const any ptr, byval nKey as long, byval pErrcode as long ptr, byval pzErrmsg as zstring ptr ptr) as sqlite ptr
declare function sqlite_rekey(byval db as sqlite ptr, byval pKey as const any ptr, byval nKey as long) as long
declare function sqlite_encode_binary(byval in as const ubyte ptr, byval n as long, byval out as ubyte ptr) as long
declare function sqlite_decode_binary(byval in as const ubyte ptr, byval out as ubyte ptr) as long

end extern
