''
''
'' sqlite2 -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __sqlite2_bi__
#define __sqlite2_bi__

#inclib "sqlite"

#define SQLITE_VERSION "2.8.17"

#define SQLITE_ISO8859 1

extern import sqlite_version_ alias "sqlite_version" as zstring ptr
extern import sqlite_encoding alias "sqlite_encoding" as zstring ptr

type sqlite as any

type sqlite_callback as function cdecl(byval as any ptr, byval as integer, byval as zstring ptr ptr, byval as zstring ptr ptr) as integer

#define SQLITE_OK 0
#define SQLITE_ERROR 1
#define SQLITE_INTERNAL 2
#define SQLITE_PERM 3
#define SQLITE_ABORT 4
#define SQLITE_BUSY 5
#define SQLITE_LOCKED 6
#define SQLITE_NOMEM 7
#define SQLITE_READONLY 8
#define SQLITE_INTERRUPT 9
#define SQLITE_IOERR 10
#define SQLITE_CORRUPT 11
#define SQLITE_NOTFOUND 12
#define SQLITE_FULL 13
#define SQLITE_CANTOPEN 14
#define SQLITE_PROTOCOL 15
#define SQLITE_EMPTY 16
#define SQLITE_SCHEMA 17
#define SQLITE_TOOBIG 18
#define SQLITE_CONSTRAINT 19
#define SQLITE_MISMATCH 20
#define SQLITE_MISUSE 21
#define SQLITE_NOLFS 22
#define SQLITE_AUTH 23
#define SQLITE_FORMAT 24
#define SQLITE_RANGE 25
#define SQLITE_NOTADB 26
#define SQLITE_ROW 100
#define SQLITE_DONE 101

type sqlite_func as any

#define SQLITE_NUMERIC (-1)
#define SQLITE_ARGS (-3)
#define SQLITE_TEXT (-2)
#define SQLITE2_TEXT (-2)

#define SQLITE_COPY 0
#define SQLITE_CREATE_INDEX 1
#define SQLITE_CREATE_TABLE 2
#define SQLITE_CREATE_TEMP_INDEX 3
#define SQLITE_CREATE_TEMP_TABLE 4
#define SQLITE_CREATE_TEMP_TRIGGER 5
#define SQLITE_CREATE_TEMP_VIEW 6
#define SQLITE_CREATE_TRIGGER 7
#define SQLITE_CREATE_VIEW 8
#define SQLITE_DELETE 9
#define SQLITE_DROP_INDEX 10
#define SQLITE_DROP_TABLE 11
#define SQLITE_DROP_TEMP_INDEX 12
#define SQLITE_DROP_TEMP_TABLE 13
#define SQLITE_DROP_TEMP_TRIGGER 14
#define SQLITE_DROP_TEMP_VIEW 15
#define SQLITE_DROP_TRIGGER 16
#define SQLITE_DROP_VIEW 17
#define SQLITE_INSERT 18
#define SQLITE_PRAGMA 19
#define SQLITE_READ 20
#define SQLITE_SELECT 21
#define SQLITE_TRANSACTION 22
#define SQLITE_UPDATE 23
#define SQLITE_ATTACH 24
#define SQLITE_DETACH 25
#define SQLITE_DENY 1
#define SQLITE_IGNORE 2

type sqlite_vm as any

extern "c"
declare function sqlite_open (byval filename as zstring ptr, byval mode as integer, byval errmsg as zstring ptr ptr) as sqlite ptr
declare sub sqlite_close (byval as sqlite ptr)
declare function sqlite_exec (byval as sqlite ptr, byval sql as zstring ptr, byval as sqlite_callback, byval as any ptr, byval errmsg as zstring ptr ptr) as integer
declare function sqlite_last_insert_rowid (byval as sqlite ptr) as integer
declare function sqlite_changes (byval as sqlite ptr) as integer
declare function sqlite_last_statement_changes (byval as sqlite ptr) as integer
declare function sqlite_error_string (byval as integer) as zstring ptr
declare sub sqlite_interrupt_ (byval as sqlite ptr)
declare function sqlite_complete (byval sql as zstring ptr) as integer
declare sub sqlite_busy_handler (byval as sqlite ptr, byval as function cdecl(byval as any ptr, byval as zstring ptr, byval as integer) as integer, byval as any ptr)
declare sub sqlite_busy_timeout (byval as sqlite ptr, byval ms as integer)
declare function sqlite_get_table (byval as sqlite ptr, byval sql as zstring ptr, byval resultp as zstring ptr ptr ptr, byval nrow as integer ptr, byval ncolumn as integer ptr, byval errmsg as zstring ptr ptr) as integer
declare sub sqlite_free_table (byval result as zstring ptr ptr)
declare function sqlite_exec_printf (byval as sqlite ptr, byval sqlFormat as zstring ptr, byval as sqlite_callback, byval as any ptr, byval errmsg as zstring ptr ptr, ...) as integer
declare function sqlite_exec_vprintf (byval as sqlite ptr, byval sqlFormat as zstring ptr, byval as sqlite_callback, byval as any ptr, byval errmsg as zstring ptr, byval ap as any ptr) as integer
declare function sqlite_get_table_printf (byval as sqlite ptr, byval sqlFormat as zstring ptr, byval resultp as zstring ptr ptr ptr, byval nrow as integer ptr, byval ncolumn as integer ptr, byval errmsg as zstring ptr ptr, ...) as integer
declare function sqlite_get_table_vprintf (byval as sqlite ptr, byval sqlFormat as zstring ptr, byval resultp as zstring ptr ptr ptr, byval nrow as integer ptr, byval ncolumn as integer ptr, byval errmsg as zstring ptr ptr, byval ap as any ptr) as integer
declare function sqlite_mprintf (byval as zstring ptr, ...) as zstring ptr
declare function sqlite_vmprintf (byval as zstring ptr, byval as any ptr) as zstring ptr
declare sub sqlite_freemem (byval p as any ptr)
declare function sqlite_libversion () as zstring ptr
declare function sqlite_libencoding () as zstring ptr
declare function sqlite_create_function (byval as sqlite ptr, byval zName as zstring ptr, byval nArg as integer, byval xFunc as sub cdecl(byval as sqlite_func ptr, byval as integer, byval as zstring ptr ptr), byval pUserData as any ptr) as integer
declare function sqlite_create_aggregate (byval as sqlite ptr, byval zName as zstring ptr, byval nArg as integer, byval xStep as sub cdecl(byval as sqlite_func ptr, byval as integer, byval as zstring ptr ptr), byval xFinalize as sub cdecl(byval as sqlite_func ptr), byval pUserData as any ptr) as integer
declare function sqlite_function_type (byval db as sqlite ptr, byval zName as zstring ptr, byval datatype as integer) as integer
declare function sqlite_set_result_string (byval as sqlite_func ptr, byval as zstring ptr, byval as integer) as zstring ptr
declare sub sqlite_set_result_int (byval as sqlite_func ptr, byval as integer)
declare sub sqlite_set_result_double (byval as sqlite_func ptr, byval as double)
declare sub sqlite_set_result_error (byval as sqlite_func ptr, byval as zstring ptr, byval as integer)
declare function sqlite_user_data (byval as sqlite_func ptr) as any ptr
declare function sqlite_aggregate_context (byval as sqlite_func ptr, byval nBytes as integer) as any ptr
declare function sqlite_aggregate_count (byval as sqlite_func ptr) as integer
declare function sqlite_set_authorizer (byval as sqlite ptr, byval xAuth as function cdecl(byval as any ptr, byval as integer, byval as zstring ptr, byval as zstring ptr, byval as zstring ptr, byval as zstring ptr) as integer, byval pUserData as any ptr) as integer
declare function sqlite_trace (byval as sqlite ptr, byval xTrace as sub cdecl(byval as any ptr, byval as zstring ptr), byval as any ptr) as any ptr
declare function sqlite_compile (byval db as sqlite ptr, byval zSql as zstring ptr, byval pzTail as zstring ptr ptr, byval ppVm as sqlite_vm ptr ptr, byval pzErrmsg as zstring ptr ptr) as integer
declare function sqlite_step (byval pVm as sqlite_vm ptr, byval pN as integer ptr, byval pazValue as zstring ptr ptr ptr, byval pazColName as zstring ptr ptr ptr) as integer
declare function sqlite_finalize (byval as sqlite_vm ptr, byval pzErrMsg as zstring ptr ptr) as integer
declare function sqlite_reset (byval as sqlite_vm ptr, byval pzErrMsg as zstring ptr ptr) as integer
declare function sqlite_bind (byval as sqlite_vm ptr, byval idx as integer, byval value as zstring ptr, byval len as integer, byval copy as integer) as integer
declare sub sqlite_progress_handler (byval as sqlite ptr, byval as integer, byval as function cdecl(byval as any ptr) as integer, byval as any ptr)
declare function sqlite_commit_hook (byval as sqlite ptr, byval as function cdecl(byval as any ptr) as integer, byval as any ptr) as any ptr
declare function sqlite_open_encrypted (byval zFilename as zstring ptr, byval pKey as any ptr, byval nKey as integer, byval pErrcode as integer ptr, byval pzErrmsg as zstring ptr ptr) as sqlite ptr
declare function sqlite_rekey (byval db as sqlite ptr, byval pKey as any ptr, byval nKey as integer) as integer
declare function sqlite_encode_binary (byval in as ubyte ptr, byval n as integer, byval out as ubyte ptr) as integer
declare function sqlite_decode_binary (byval in as ubyte ptr, byval out as ubyte ptr) as integer
end extern

#endif
