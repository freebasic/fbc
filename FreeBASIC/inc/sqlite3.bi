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

declare function sqlite3_libversion cdecl alias "sqlite3_libversion" () as zstring ptr
''''''' declare function sqlite3_libversion_number cdecl alias "sqlite3_libversion_number" () as integer

type sqlite3 as any
type sqlite_int64 as longint
type sqlite_uint64 as ulongint

declare function sqlite3_close cdecl alias "sqlite3_close" (byval as sqlite3 ptr) as integer

type sqlite3_callback as function cdecl (byval userdata as any ptr, byval argc as integer, byval argv as zstring ptr ptr, byval colname as zstring ptr ptr) as integer

declare function sqlite3_exec cdecl alias "sqlite3_exec" (byval as sqlite3 ptr, byval sql as string, byval as sqlite3_callback, byval as any ptr, byval errmsg as byte ptr ptr) as integer

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

declare function sqlite3_last_insert_rowid cdecl alias "sqlite3_last_insert_rowid" (byval as sqlite3 ptr) as sqlite_int64
declare function sqlite3_changes cdecl alias "sqlite3_changes" (byval as sqlite3 ptr) as integer
declare function sqlite3_total_changes cdecl alias "sqlite3_total_changes" (byval as sqlite3 ptr) as integer
declare sub sqlite3_interrupt cdecl alias "sqlite3_interrupt" (byval as sqlite3 ptr)
declare function sqlite3_complete cdecl alias "sqlite3_complete" (byval sql as string) as integer
declare function sqlite3_complete16 cdecl alias "sqlite3_complete16" (byval sql as any ptr) as integer
declare function sqlite3_busy_handler cdecl alias "sqlite3_busy_handler" (byval as sqlite3 ptr, byval as function(byval as any ptr, byval as integer) as integer, byval as any ptr) as integer
declare function sqlite3_busy_timeout cdecl alias "sqlite3_busy_timeout" (byval as sqlite3 ptr, byval ms as integer) as integer
declare function sqlite3_get_table cdecl alias "sqlite3_get_table" (byval as sqlite3 ptr, byval sql as string, byval resultp as byte ptr ptr ptr, byval nrow as integer ptr, byval ncolumn as integer ptr, byval errmsg as byte ptr ptr) as integer
declare sub sqlite3_free_table cdecl alias "sqlite3_free_table" (byval result as byte ptr ptr)
declare function sqlite3_mprintf cdecl alias "sqlite3_mprintf" (byval as string, ...) as zstring ptr
''''''' declare function sqlite3_vmprintf cdecl alias "sqlite3_vmprintf" (byval as string, byval as va_list) as zstring ptr
declare sub sqlite3_free cdecl alias "sqlite3_free" (byval z as string)
declare function sqlite3_snprintf cdecl alias "sqlite3_snprintf" (byval as integer, byval as string, byval as string, ...) as zstring ptr
declare function sqlite3_set_authorizer cdecl alias "sqlite3_set_authorizer" (byval as sqlite3 ptr, byval xAuth as function(byval as any ptr, byval as integer, byval as string, byval as string, byval as string, byval as string) as integer, byval pUserData as any ptr) as integer

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

declare function sqlite3_trace cdecl alias "sqlite3_trace" (byval as sqlite3 ptr, byval xTrace as sub(byval as any ptr, byval as string), byval as any ptr) as any ptr
declare sub sqlite3_progress_handler cdecl alias "sqlite3_progress_handler" (byval as sqlite3 ptr, byval as integer, byval as function(byval as any ptr) as integer, byval as any ptr)
declare function sqlite3_commit_hook cdecl alias "sqlite3_commit_hook" (byval as sqlite3 ptr, byval as function(byval as any ptr) as integer, byval as any ptr) as any ptr
declare function sqlite3_open cdecl alias "sqlite3_open" (byval filename as string, byval ppDb as sqlite3 ptr ptr) as integer
declare function sqlite3_open16 cdecl alias "sqlite3_open16" (byval filename as any ptr, byval ppDb as sqlite3 ptr ptr) as integer
declare function sqlite3_errcode cdecl alias "sqlite3_errcode" (byval db as sqlite3 ptr) as integer
declare function sqlite3_errmsg cdecl alias "sqlite3_errmsg" (byval as sqlite3 ptr) as zstring ptr
declare function sqlite3_errmsg16 cdecl alias "sqlite3_errmsg16" (byval as sqlite3 ptr) as any ptr

type sqlite3_stmt as any

declare function sqlite3_prepare cdecl alias "sqlite3_prepare" (byval db as sqlite3 ptr, byval zSql as string, byval nBytes as integer, byval ppStmt as sqlite3_stmt ptr ptr, byval pzTail as byte ptr ptr) as integer
declare function sqlite3_prepare16 cdecl alias "sqlite3_prepare16" (byval db as sqlite3 ptr, byval zSql as any ptr, byval nBytes as integer, byval ppStmt as sqlite3_stmt ptr ptr, byval pzTail as any ptr ptr) as integer

type sqlite3_context as any
type sqlite3_value as any

declare function sqlite3_bind_blob cdecl alias "sqlite3_bind_blob" (byval as sqlite3_stmt ptr, byval as integer, byval as any ptr, byval n as integer, byval as sub(byval as any ptr)) as integer
declare function sqlite3_bind_double cdecl alias "sqlite3_bind_double" (byval as sqlite3_stmt ptr, byval as integer, byval as double) as integer
declare function sqlite3_bind_int cdecl alias "sqlite3_bind_int" (byval as sqlite3_stmt ptr, byval as integer, byval as integer) as integer
declare function sqlite3_bind_int64 cdecl alias "sqlite3_bind_int64" (byval as sqlite3_stmt ptr, byval as integer, byval as sqlite_int64) as integer
declare function sqlite3_bind_null cdecl alias "sqlite3_bind_null" (byval as sqlite3_stmt ptr, byval as integer) as integer
declare function sqlite3_bind_text cdecl alias "sqlite3_bind_text" (byval as sqlite3_stmt ptr, byval as integer, byval as string, byval n as integer, byval as sub(byval as any ptr)) as integer
declare function sqlite3_bind_text16 cdecl alias "sqlite3_bind_text16" (byval as sqlite3_stmt ptr, byval as integer, byval as any ptr, byval as integer, byval as sub(byval as any ptr)) as integer
declare function sqlite3_bind_value cdecl alias "sqlite3_bind_value" (byval as sqlite3_stmt ptr, byval as integer, byval as sqlite3_value ptr) as integer
declare function sqlite3_bind_parameter_count cdecl alias "sqlite3_bind_parameter_count" (byval as sqlite3_stmt ptr) as integer
declare function sqlite3_bind_parameter_name cdecl alias "sqlite3_bind_parameter_name" (byval as sqlite3_stmt ptr, byval as integer) as zstring ptr
declare function sqlite3_bind_parameter_index cdecl alias "sqlite3_bind_parameter_index" (byval as sqlite3_stmt ptr, byval zName as string) as integer
declare function sqlite3_clear_bindings cdecl alias "sqlite3_clear_bindings" (byval as sqlite3_stmt ptr) as integer
declare function sqlite3_column_count cdecl alias "sqlite3_column_count" (byval pStmt as sqlite3_stmt ptr) as integer
declare function sqlite3_column_name cdecl alias "sqlite3_column_name" (byval as sqlite3_stmt ptr, byval as integer) as zstring ptr
declare function sqlite3_column_name16 cdecl alias "sqlite3_column_name16" (byval as sqlite3_stmt ptr, byval as integer) as any ptr
declare function sqlite3_column_decltype cdecl alias "sqlite3_column_decltype" (byval as sqlite3_stmt ptr, byval i as integer) as zstring ptr
declare function sqlite3_column_decltype16 cdecl alias "sqlite3_column_decltype16" (byval as sqlite3_stmt ptr, byval as integer) as any ptr
declare function sqlite3_step cdecl alias "sqlite3_step" (byval as sqlite3_stmt ptr) as integer
declare function sqlite3_data_count cdecl alias "sqlite3_data_count" (byval pStmt as sqlite3_stmt ptr) as integer

#define SQLITE_INTEGER 1
#define SQLITE_FLOAT 2
#define SQLITE_BLOB 4
#define SQLITE_NULL 5
#define SQLITE_TEXT 3
#define SQLITE3_TEXT 3

declare function sqlite3_column_blob cdecl alias "sqlite3_column_blob" (byval as sqlite3_stmt ptr, byval iCol as integer) as any ptr
declare function sqlite3_column_bytes cdecl alias "sqlite3_column_bytes" (byval as sqlite3_stmt ptr, byval iCol as integer) as integer
declare function sqlite3_column_bytes16 cdecl alias "sqlite3_column_bytes16" (byval as sqlite3_stmt ptr, byval iCol as integer) as integer
declare function sqlite3_column_double cdecl alias "sqlite3_column_double" (byval as sqlite3_stmt ptr, byval iCol as integer) as double
declare function sqlite3_column_int cdecl alias "sqlite3_column_int" (byval as sqlite3_stmt ptr, byval iCol as integer) as integer
declare function sqlite3_column_int64 cdecl alias "sqlite3_column_int64" (byval as sqlite3_stmt ptr, byval iCol as integer) as sqlite_int64
declare function sqlite3_column_text cdecl alias "sqlite3_column_text" (byval as sqlite3_stmt ptr, byval iCol as integer) as ubyte ptr
declare function sqlite3_column_text16 cdecl alias "sqlite3_column_text16" (byval as sqlite3_stmt ptr, byval iCol as integer) as any ptr
declare function sqlite3_column_type cdecl alias "sqlite3_column_type" (byval as sqlite3_stmt ptr, byval iCol as integer) as integer
declare function sqlite3_finalize cdecl alias "sqlite3_finalize" (byval pStmt as sqlite3_stmt ptr) as integer
declare function sqlite3_reset cdecl alias "sqlite3_reset" (byval pStmt as sqlite3_stmt ptr) as integer
declare function sqlite3_create_function cdecl alias "sqlite3_create_function" (byval as sqlite3 ptr, byval zFunctionName as string, byval nArg as integer, byval eTextRep as integer, byval as any ptr, byval xFunc as sub(byval as sqlite3_context ptr, byval as integer, byval as sqlite3_value ptr ptr), byval xStep as sub(byval as sqlite3_context ptr, byval as integer, byval as sqlite3_value ptr ptr), byval xFinal as sub(byval as sqlite3_context ptr)) as integer
declare function sqlite3_create_function16 cdecl alias "sqlite3_create_function16" (byval as sqlite3 ptr, byval zFunctionName as any ptr, byval nArg as integer, byval eTextRep as integer, byval as any ptr, byval xFunc as sub(byval as sqlite3_context ptr, byval as integer, byval as sqlite3_value ptr ptr), byval xStep as sub(byval as sqlite3_context ptr, byval as integer, byval as sqlite3_value ptr ptr), byval xFinal as sub(byval as sqlite3_context ptr)) as integer
declare function sqlite3_aggregate_count cdecl alias "sqlite3_aggregate_count" (byval as sqlite3_context ptr) as integer
declare function sqlite3_value_blob cdecl alias "sqlite3_value_blob" (byval as sqlite3_value ptr) as any ptr
declare function sqlite3_value_bytes cdecl alias "sqlite3_value_bytes" (byval as sqlite3_value ptr) as integer
declare function sqlite3_value_bytes16 cdecl alias "sqlite3_value_bytes16" (byval as sqlite3_value ptr) as integer
declare function sqlite3_value_double cdecl alias "sqlite3_value_double" (byval as sqlite3_value ptr) as double
declare function sqlite3_value_int cdecl alias "sqlite3_value_int" (byval as sqlite3_value ptr) as integer
declare function sqlite3_value_int64 cdecl alias "sqlite3_value_int64" (byval as sqlite3_value ptr) as sqlite_int64
declare function sqlite3_value_text cdecl alias "sqlite3_value_text" (byval as sqlite3_value ptr) as ubyte ptr
declare function sqlite3_value_text16 cdecl alias "sqlite3_value_text16" (byval as sqlite3_value ptr) as any ptr
declare function sqlite3_value_text16le cdecl alias "sqlite3_value_text16le" (byval as sqlite3_value ptr) as any ptr
declare function sqlite3_value_text16be cdecl alias "sqlite3_value_text16be" (byval as sqlite3_value ptr) as any ptr
declare function sqlite3_value_type cdecl alias "sqlite3_value_type" (byval as sqlite3_value ptr) as integer
declare function sqlite3_aggregate_context cdecl alias "sqlite3_aggregate_context" (byval as sqlite3_context ptr, byval nBytes as integer) as any ptr
declare function sqlite3_user_data cdecl alias "sqlite3_user_data" (byval as sqlite3_context ptr) as any ptr
declare function sqlite3_get_auxdata cdecl alias "sqlite3_get_auxdata" (byval as sqlite3_context ptr, byval as integer) as any ptr
declare sub sqlite3_set_auxdata cdecl alias "sqlite3_set_auxdata" (byval as sqlite3_context ptr, byval as integer, byval as any ptr, byval as sub(byval as any ptr))
declare sub sqlite3_result_blob cdecl alias "sqlite3_result_blob" (byval as sqlite3_context ptr, byval as any ptr, byval as integer, byval as sub(byval as any ptr))
declare sub sqlite3_result_double cdecl alias "sqlite3_result_double" (byval as sqlite3_context ptr, byval as double)
declare sub sqlite3_result_error cdecl alias "sqlite3_result_error" (byval as sqlite3_context ptr, byval as string, byval as integer)
declare sub sqlite3_result_error16 cdecl alias "sqlite3_result_error16" (byval as sqlite3_context ptr, byval as any ptr, byval as integer)
declare sub sqlite3_result_int cdecl alias "sqlite3_result_int" (byval as sqlite3_context ptr, byval as integer)
declare sub sqlite3_result_int64 cdecl alias "sqlite3_result_int64" (byval as sqlite3_context ptr, byval as sqlite_int64)
declare sub sqlite3_result_null cdecl alias "sqlite3_result_null" (byval as sqlite3_context ptr)
declare sub sqlite3_result_text cdecl alias "sqlite3_result_text" (byval as sqlite3_context ptr, byval as string, byval as integer, byval as sub(byval as any ptr))
declare sub sqlite3_result_text16 cdecl alias "sqlite3_result_text16" (byval as sqlite3_context ptr, byval as any ptr, byval as integer, byval as sub(byval as any ptr))
declare sub sqlite3_result_text16le cdecl alias "sqlite3_result_text16le" (byval as sqlite3_context ptr, byval as any ptr, byval as integer, byval as sub(byval as any ptr))
declare sub sqlite3_result_text16be cdecl alias "sqlite3_result_text16be" (byval as sqlite3_context ptr, byval as any ptr, byval as integer, byval as sub(byval as any ptr))
declare sub sqlite3_result_value cdecl alias "sqlite3_result_value" (byval as sqlite3_context ptr, byval as sqlite3_value ptr)

#define SQLITE_UTF8 1
#define SQLITE_UTF16LE 2
#define SQLITE_UTF16BE 3
#define SQLITE_UTF16 4
#define SQLITE_ANY 5

declare function sqlite3_create_collation cdecl alias "sqlite3_create_collation" (byval as sqlite3 ptr, byval zName as string, byval eTextRep as integer, byval as any ptr, byval xCompare as function(byval as any ptr, byval as integer, byval as any ptr, byval as integer, byval as any ptr) as integer) as integer
declare function sqlite3_create_collation16 cdecl alias "sqlite3_create_collation16" (byval as sqlite3 ptr, byval zName as string, byval eTextRep as integer, byval as any ptr, byval xCompare as function(byval as any ptr, byval as integer, byval as any ptr, byval as integer, byval as any ptr) as integer) as integer
declare function sqlite3_collation_needed cdecl alias "sqlite3_collation_needed" (byval as sqlite3 ptr, byval as any ptr, byval as sub(byval as any ptr, byval as sqlite3 ptr, byval as integer, byval as string)) as integer
declare function sqlite3_collation_needed16 cdecl alias "sqlite3_collation_needed16" (byval as sqlite3 ptr, byval as any ptr, byval as sub(byval as any ptr, byval as sqlite3 ptr, byval as integer, byval as any ptr)) as integer
declare function sqlite3_key cdecl alias "sqlite3_key" (byval db as sqlite3 ptr, byval pKey as any ptr, byval nKey as integer) as integer
declare function sqlite3_rekey cdecl alias "sqlite3_rekey" (byval db as sqlite3 ptr, byval pKey as any ptr, byval nKey as integer) as integer
declare function sqlite3_sleep cdecl alias "sqlite3_sleep" (byval as integer) as integer
declare function sqlite3_expired cdecl alias "sqlite3_expired" (byval as sqlite3_stmt ptr) as integer

#endif
