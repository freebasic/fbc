''
''
'' sqlite3 -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __sqlite3_bi__
#define __sqlite3_bi__

#inclib "sqlite3"

#define SQLITE_VERSION "3.1.3"
#define SQLITE_VERSION_NUMBER 3001003

type sqlite3 as any
type sqlite_int64 as longint
type sqlite_uint64 as ulongint

#ifdef __FB_WIN32__
type sqlite_wchar as wstring
#else
type sqlite_wchar as ushort
#endif

type sqlite3_callback as function cdecl (byval userdata as any ptr, byval argc as integer, byval argv as zstring ptr ptr, byval colname as zstring ptr ptr) as integer

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
#define SQLITE_ALTER_TABLE 26
#define SQLITE_REINDEX 27
#define SQLITE_DENY 1
#define SQLITE_IGNORE 2

type sqlite3_stmt as any

type sqlite3_context as any
type sqlite3_value as any

#define SQLITE_INTEGER 1
#define SQLITE_FLOAT 2
#define SQLITE_BLOB 4
#define SQLITE_NULL 5
#define SQLITE_TEXT 3
#define SQLITE3_TEXT 3

#define SQLITE_STATIC cast(sub cdecl(byval as any ptr),0)
#define SQLITE_TRANSIENT cast(sub cdecl(byval as any ptr),-1)

#define SQLITE_UTF8 1
#define SQLITE_UTF16LE 2
#define SQLITE_UTF16BE 3
#define SQLITE_UTF16 4
#define SQLITE_ANY 5

extern "c"
declare function sqlite3_libversion () as zstring ptr
declare function sqlite3_libversion_number () as integer
declare function sqlite3_close (byval as sqlite3 ptr) as integer
declare function sqlite3_exec (byval as sqlite3 ptr, byval sql as zstring ptr, byval as sqlite3_callback, byval as any ptr, byval errmsg as zstring ptr ptr) as integer
declare function sqlite3_last_insert_rowid (byval as sqlite3 ptr) as sqlite_int64
declare function sqlite3_changes (byval as sqlite3 ptr) as integer
declare function sqlite3_total_changes (byval as sqlite3 ptr) as integer
declare sub sqlite3_interrupt (byval as sqlite3 ptr)
declare function sqlite3_complete (byval sql as zstring ptr) as integer
declare function sqlite3_complete16 (byval sql as sqlite_wchar ptr) as integer
declare function sqlite3_busy_handler (byval as sqlite3 ptr, byval as function cdecl(byval as any ptr, byval as integer) as integer, byval as any ptr) as integer
declare function sqlite3_busy_timeout (byval as sqlite3 ptr, byval ms as integer) as integer
declare function sqlite3_get_table (byval as sqlite3 ptr, byval sql as zstring ptr, byval resultp as zstring ptr ptr ptr, byval nrow as integer ptr, byval ncolumn as integer ptr, byval errmsg as zstring ptr ptr) as integer
declare sub sqlite3_free_table (byval result as zstring ptr ptr)
declare function sqlite3_mprintf (byval as zstring ptr, ...) as zstring ptr
declare function sqlite3_vmprintf (byval as zstring ptr, byval as any ptr) as zstring ptr
declare sub sqlite3_free (byval z as zstring ptr)
declare function sqlite3_snprintf (byval as integer, byval as zstring ptr, byval as zstring ptr, ...) as zstring ptr
declare function sqlite3_set_authorizer (byval as sqlite3 ptr, byval xAuth as function cdecl(byval as any ptr, byval as integer, byval as zstring ptr, byval as zstring ptr, byval as zstring ptr, byval as zstring ptr) as integer, byval pUserData as any ptr) as integer
declare function sqlite3_trace (byval as sqlite3 ptr, byval xTrace as sub cdecl(byval as any ptr, byval as zstring ptr), byval as any ptr) as any ptr
declare sub sqlite3_progress_handler (byval as sqlite3 ptr, byval as integer, byval as function cdecl(byval as any ptr) as integer, byval as any ptr)
declare function sqlite3_commit_hook (byval as sqlite3 ptr, byval as function cdecl(byval as any ptr) as integer, byval as any ptr) as any ptr
declare function sqlite3_open (byval filename as zstring ptr, byval ppDb as sqlite3 ptr ptr) as integer
declare function sqlite3_open16 (byval filename as sqlite_wchar ptr, byval ppDb as sqlite3 ptr ptr) as integer
declare function sqlite3_errcode (byval db as sqlite3 ptr) as integer
declare function sqlite3_errmsg (byval as sqlite3 ptr) as zstring ptr
declare function sqlite3_errmsg16 (byval as sqlite3 ptr) as sqlite_wchar ptr
declare function sqlite3_prepare (byval db as sqlite3 ptr, byval zSql as zstring ptr, byval nBytes as integer, byval ppStmt as sqlite3_stmt ptr ptr, byval pzTail as zstring ptr ptr) as integer
declare function sqlite3_prepare16 (byval db as sqlite3 ptr, byval zSql as sqlite_wchar ptr, byval nBytes as integer, byval ppStmt as sqlite3_stmt ptr ptr, byval pzTail as sqlite_wchar ptr ptr) as integer
declare function sqlite3_bind_blob (byval as sqlite3_stmt ptr, byval as integer, byval as any ptr, byval n as integer, byval as sub cdecl(byval as any ptr)) as integer
declare function sqlite3_bind_double (byval as sqlite3_stmt ptr, byval as integer, byval as double) as integer
declare function sqlite3_bind_int (byval as sqlite3_stmt ptr, byval as integer, byval as integer) as integer
declare function sqlite3_bind_int64 (byval as sqlite3_stmt ptr, byval as integer, byval as sqlite_int64) as integer
declare function sqlite3_bind_null (byval as sqlite3_stmt ptr, byval as integer) as integer
declare function sqlite3_bind_text (byval as sqlite3_stmt ptr, byval as integer, byval as zstring ptr, byval n as integer, byval as sub cdecl(byval as any ptr)) as integer
declare function sqlite3_bind_text16 (byval as sqlite3_stmt ptr, byval as integer, byval as sqlite_wchar ptr, byval as integer, byval as sub cdecl(byval as any ptr)) as integer
declare function sqlite3_bind_value (byval as sqlite3_stmt ptr, byval as integer, byval as sqlite3_value ptr) as integer
declare function sqlite3_bind_parameter_count (byval as sqlite3_stmt ptr) as integer
declare function sqlite3_bind_parameter_name (byval as sqlite3_stmt ptr, byval as integer) as zstring ptr
declare function sqlite3_bind_parameter_index (byval as sqlite3_stmt ptr, byval zName as zstring ptr) as integer
declare function sqlite3_clear_bindings (byval as sqlite3_stmt ptr) as integer
declare function sqlite3_column_count (byval pStmt as sqlite3_stmt ptr) as integer
declare function sqlite3_column_name (byval as sqlite3_stmt ptr, byval as integer) as zstring ptr
declare function sqlite3_column_name16 (byval as sqlite3_stmt ptr, byval as integer) as sqlite_wchar ptr
declare function sqlite3_column_decltype (byval as sqlite3_stmt ptr, byval as integer) as zstring ptr
declare function sqlite3_column_decltype16 (byval as sqlite3_stmt ptr, byval as integer) as sqlite_wchar ptr
declare function sqlite3_step (byval as sqlite3_stmt ptr) as integer
declare function sqlite3_data_count (byval pStmt as sqlite3_stmt ptr) as integer
declare function sqlite3_column_blob (byval as sqlite3_stmt ptr, byval iCol as integer) as any ptr
declare function sqlite3_column_bytes (byval as sqlite3_stmt ptr, byval iCol as integer) as integer
declare function sqlite3_column_bytes16 (byval as sqlite3_stmt ptr, byval iCol as integer) as integer
declare function sqlite3_column_double (byval as sqlite3_stmt ptr, byval iCol as integer) as double
declare function sqlite3_column_int (byval as sqlite3_stmt ptr, byval iCol as integer) as integer
declare function sqlite3_column_int64 (byval as sqlite3_stmt ptr, byval iCol as integer) as sqlite_int64
declare function sqlite3_column_text (byval as sqlite3_stmt ptr, byval iCol as integer) as zstring ptr
declare function sqlite3_column_text16 (byval as sqlite3_stmt ptr, byval iCol as integer) as sqlite_wchar ptr
declare function sqlite3_column_type (byval as sqlite3_stmt ptr, byval iCol as integer) as integer
declare function sqlite3_finalize (byval pStmt as sqlite3_stmt ptr) as integer
declare function sqlite3_reset (byval pStmt as sqlite3_stmt ptr) as integer
declare function sqlite3_create_function (byval as sqlite3 ptr, byval zFunctionName as zstring ptr, byval nArg as integer, byval eTextRep as integer, byval as any ptr, byval xFunc as sub cdecl(byval as sqlite3_context ptr, byval as integer, byval as sqlite3_value ptr ptr), byval xStep as sub cdecl(byval as sqlite3_context ptr, byval as integer, byval as sqlite3_value ptr ptr), byval xFinal as sub cdecl(byval as sqlite3_context ptr)) as integer
declare function sqlite3_create_function16 (byval as sqlite3 ptr, byval zFunctionName as sqlite_wchar ptr, byval nArg as integer, byval eTextRep as integer, byval as any ptr, byval xFunc as sub cdecl(byval as sqlite3_context ptr, byval as integer, byval as sqlite3_value ptr ptr), byval xStep as sub cdecl(byval as sqlite3_context ptr, byval as integer, byval as sqlite3_value ptr ptr), byval xFinal as sub cdecl(byval as sqlite3_context ptr)) as integer
declare function sqlite3_aggregate_count (byval as sqlite3_context ptr) as integer
declare function sqlite3_value_blob (byval as sqlite3_value ptr) as any ptr
declare function sqlite3_value_bytes (byval as sqlite3_value ptr) as integer
declare function sqlite3_value_bytes16 (byval as sqlite3_value ptr) as integer
declare function sqlite3_value_double (byval as sqlite3_value ptr) as double
declare function sqlite3_value_int (byval as sqlite3_value ptr) as integer
declare function sqlite3_value_int64 (byval as sqlite3_value ptr) as sqlite_int64
declare function sqlite3_value_text (byval as sqlite3_value ptr) as zstring ptr
declare function sqlite3_value_text16 (byval as sqlite3_value ptr) as sqlite_wchar ptr
declare function sqlite3_value_text16le (byval as sqlite3_value ptr) as sqlite_wchar ptr
declare function sqlite3_value_text16be (byval as sqlite3_value ptr) as sqlite_wchar ptr
declare function sqlite3_value_type (byval as sqlite3_value ptr) as integer
declare function sqlite3_aggregate_context (byval as sqlite3_context ptr, byval nBytes as integer) as any ptr
declare function sqlite3_user_data (byval as sqlite3_context ptr) as any ptr
declare function sqlite3_get_auxdata (byval as sqlite3_context ptr, byval as integer) as any ptr
declare sub sqlite3_set_auxdata (byval as sqlite3_context ptr, byval as integer, byval as any ptr, byval as sub cdecl(byval as any ptr))
declare sub sqlite3_result_blob (byval as sqlite3_context ptr, byval as any ptr, byval as integer, byval as sub cdecl(byval as any ptr))
declare sub sqlite3_result_double (byval as sqlite3_context ptr, byval as double)
declare sub sqlite3_result_error (byval as sqlite3_context ptr, byval as zstring ptr, byval as integer)
declare sub sqlite3_result_error16 (byval as sqlite3_context ptr, byval as sqlite_wchar ptr, byval as integer)
declare sub sqlite3_result_int (byval as sqlite3_context ptr, byval as integer)
declare sub sqlite3_result_int64 (byval as sqlite3_context ptr, byval as sqlite_int64)
declare sub sqlite3_result_null (byval as sqlite3_context ptr)
declare sub sqlite3_result_text (byval as sqlite3_context ptr, byval as zstring ptr, byval as integer, byval as sub cdecl(byval as any ptr))
declare sub sqlite3_result_text16 (byval as sqlite3_context ptr, byval as sqlite_wchar ptr, byval as integer, byval as sub cdecl(byval as any ptr))
declare sub sqlite3_result_text16le (byval as sqlite3_context ptr, byval as sqlite_wchar ptr, byval as integer, byval as sub cdecl(byval as any ptr))
declare sub sqlite3_result_text16be (byval as sqlite3_context ptr, byval as sqlite_wchar ptr, byval as integer, byval as sub cdecl(byval as any ptr))
declare sub sqlite3_result_value (byval as sqlite3_context ptr, byval as sqlite3_value ptr)
declare function sqlite3_create_collation (byval as sqlite3 ptr, byval zName as zstring ptr, byval eTextRep as integer, byval as any ptr, byval xCompare as function cdecl(byval as any ptr, byval as integer, byval as any ptr, byval as integer, byval as any ptr) as integer) as integer
declare function sqlite3_create_collation16 (byval as sqlite3 ptr, byval zName as sqlite_wchar ptr, byval eTextRep as integer, byval as any ptr, byval xCompare as function cdecl(byval as any ptr, byval as integer, byval as any ptr, byval as integer, byval as any ptr) as integer) as integer
declare function sqlite3_collation_needed (byval as sqlite3 ptr, byval as any ptr, byval as sub cdecl(byval as any ptr, byval as sqlite3 ptr, byval as integer, byval as zstring ptr)) as integer
declare function sqlite3_collation_needed16 (byval as sqlite3 ptr, byval as any ptr, byval as sub cdecl(byval as any ptr, byval as sqlite3 ptr, byval as integer, byval as sqlite_wchar ptr)) as integer
declare function sqlite3_key (byval db as sqlite3 ptr, byval pKey as any ptr, byval nKey as integer) as integer
declare function sqlite3_rekey (byval db as sqlite3 ptr, byval pKey as any ptr, byval nKey as integer) as integer
declare function sqlite3_sleep (byval as integer) as integer
declare function sqlite3_expired (byval as sqlite3_stmt ptr) as integer
end extern

#endif
