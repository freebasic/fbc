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

#include once "crt/stdarg.bi"

#define SQLITE_VERSION "3.7.8"
#define SQLITE_VERSION_NUMBER 3007008
#define SQLITE_SOURCE_ID "2011-09-19 14:49:19 3e0da808d2f5b4d12046e05980ca04578f581177"

extern "c"

declare function sqlite3_libversion () as zstring ptr
declare function sqlite3_sourceid () as zstring ptr
declare function sqlite3_libversion_number () as integer
declare function sqlite3_compileoption_used (byval zOptName as zstring ptr) as integer
declare function sqlite3_compileoption_get (byval N as integer) as zstring ptr
declare function sqlite3_threadsafe () as integer

type sqlite3 as any
type sqlite_int64 as longint
type sqlite_uint64 as ulongint
type sqlite3_int64 as sqlite_int64
type sqlite3_uint64 as sqlite_uint64

declare function sqlite3_close (byval as sqlite3 ptr) as integer

type sqlite3_callback as function cdecl(byval as any ptr, byval as integer, byval as zstring ptr ptr, byval as zstring ptr ptr) as integer

declare function sqlite3_exec (byval as sqlite3 ptr, byval sql as zstring ptr, byval callback as sqlite3_callback, byval as any ptr, byval errmsg as zstring ptr ptr) as integer

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
#define SQLITE_IOERR_READ (10 or (1 shl 8))
#define SQLITE_IOERR_SHORT_READ (10 or (2 shl 8))
#define SQLITE_IOERR_WRITE (10 or (3 shl 8))
#define SQLITE_IOERR_FSYNC (10 or (4 shl 8))
#define SQLITE_IOERR_DIR_FSYNC (10 or (5 shl 8))
#define SQLITE_IOERR_TRUNCATE (10 or (6 shl 8))
#define SQLITE_IOERR_FSTAT (10 or (7 shl 8))
#define SQLITE_IOERR_UNLOCK (10 or (8 shl 8))
#define SQLITE_IOERR_RDLOCK (10 or (9 shl 8))
#define SQLITE_IOERR_DELETE (10 or (10 shl 8))
#define SQLITE_IOERR_BLOCKED (10 or (11 shl 8))
#define SQLITE_IOERR_NOMEM (10 or (12 shl 8))
#define SQLITE_IOERR_ACCESS (10 or (13 shl 8))
#define SQLITE_IOERR_CHECKRESERVEDLOCK (10 or (14 shl 8))
#define SQLITE_IOERR_LOCK (10 or (15 shl 8))
#define SQLITE_IOERR_CLOSE (10 or (16 shl 8))
#define SQLITE_IOERR_DIR_CLOSE (10 or (17 shl 8))
#define SQLITE_IOERR_SHMOPEN (10 or (18 shl 8))
#define SQLITE_IOERR_SHMSIZE (10 or (19 shl 8))
#define SQLITE_IOERR_SHMLOCK (10 or (20 shl 8))
#define SQLITE_IOERR_SHMMAP (10 or (21 shl 8))
#define SQLITE_IOERR_SEEK (10 or (22 shl 8))
#define SQLITE_LOCKED_SHAREDCACHE (6 or (1 shl 8))
#define SQLITE_BUSY_RECOVERY (5 or (1 shl 8))
#define SQLITE_CANTOPEN_NOTEMPDIR (14 or (1 shl 8))
#define SQLITE_CORRUPT_VTAB (11 or (1 shl 8))
#define SQLITE_READONLY_RECOVERY (8 or (1 shl 8))
#define SQLITE_READONLY_CANTLOCK (8 or (2 shl 8))
#define SQLITE_OPEN_READONLY &h00000001
#define SQLITE_OPEN_READWRITE &h00000002
#define SQLITE_OPEN_CREATE &h00000004
#define SQLITE_OPEN_DELETEONCLOSE &h00000008
#define SQLITE_OPEN_EXCLUSIVE &h00000010
#define SQLITE_OPEN_AUTOPROXY &h00000020
#define SQLITE_OPEN_URI &h00000040
#define SQLITE_OPEN_MAIN_DB &h00000100
#define SQLITE_OPEN_TEMP_DB &h00000200
#define SQLITE_OPEN_TRANSIENT_DB &h00000400
#define SQLITE_OPEN_MAIN_JOURNAL &h00000800
#define SQLITE_OPEN_TEMP_JOURNAL &h00001000
#define SQLITE_OPEN_SUBJOURNAL &h00002000
#define SQLITE_OPEN_MASTER_JOURNAL &h00004000
#define SQLITE_OPEN_NOMUTEX &h00008000
#define SQLITE_OPEN_FULLMUTEX &h00010000
#define SQLITE_OPEN_SHAREDCACHE &h00020000
#define SQLITE_OPEN_PRIVATECACHE &h00040000
#define SQLITE_OPEN_WAL &h00080000
#define SQLITE_IOCAP_ATOMIC &h00000001
#define SQLITE_IOCAP_ATOMIC512 &h00000002
#define SQLITE_IOCAP_ATOMIC1K &h00000004
#define SQLITE_IOCAP_ATOMIC2K &h00000008
#define SQLITE_IOCAP_ATOMIC4K &h00000010
#define SQLITE_IOCAP_ATOMIC8K &h00000020
#define SQLITE_IOCAP_ATOMIC16K &h00000040
#define SQLITE_IOCAP_ATOMIC32K &h00000080
#define SQLITE_IOCAP_ATOMIC64K &h00000100
#define SQLITE_IOCAP_SAFE_APPEND &h00000200
#define SQLITE_IOCAP_SEQUENTIAL &h00000400
#define SQLITE_IOCAP_UNDELETABLE_WHEN_OPEN &h00000800
#define SQLITE_LOCK_NONE 0
#define SQLITE_LOCK_SHARED 1
#define SQLITE_LOCK_RESERVED 2
#define SQLITE_LOCK_PENDING 3
#define SQLITE_LOCK_EXCLUSIVE 4
#define SQLITE_SYNC_NORMAL &h00002
#define SQLITE_SYNC_FULL &h00003
#define SQLITE_SYNC_DATAONLY &h00010

type sqlite3_io_methods as sqlite3_io_methods_

type sqlite3_file
    pMethods as sqlite3_io_methods ptr
end type

type sqlite3_io_methods_
    iVersion as integer
    xClose as function cdecl(byval as sqlite3_file ptr) as integer
    xRead as function cdecl(byval as sqlite3_file ptr, byval as any ptr, byval as integer, byval as sqlite3_int64) as integer
    xWrite as function cdecl(byval as sqlite3_file ptr, byval as any ptr, byval as integer, byval as sqlite3_int64) as integer
    xTruncate as function cdecl(byval as sqlite3_file ptr, byval as sqlite3_int64) as integer
    xSync as function cdecl(byval as sqlite3_file ptr, byval as integer) as integer
    xFileSize as function cdecl(byval as sqlite3_file ptr, byval as sqlite3_int64 ptr) as integer
    xLock as function cdecl(byval as sqlite3_file ptr, byval as integer) as integer
    xUnlock as function cdecl(byval as sqlite3_file ptr, byval as integer) as integer
    xCheckReservedLock as function cdecl(byval as sqlite3_file ptr, byval as integer ptr) as integer
    xFileControl as function cdecl(byval as sqlite3_file ptr, byval as integer, byval as any ptr) as integer
    xSectorSize as function cdecl(byval as sqlite3_file ptr) as integer
    xDeviceCharacteristics as function cdecl(byval as sqlite3_file ptr) as integer
    xShmMap as function cdecl(byval as sqlite3_file ptr, byval as integer, byval as integer, byval as integer, byval as any ptr ptr) as integer
    xShmLock as function cdecl(byval as sqlite3_file ptr, byval as integer, byval as integer, byval as integer) as integer
    xShmBarrier as sub cdecl(byval as sqlite3_file ptr)
    xShmUnmap as function cdecl(byval as sqlite3_file ptr, byval as integer) as integer
end type

#define SQLITE_FCNTL_LOCKSTATE 1
#define SQLITE_GET_LOCKPROXYFILE 2
#define SQLITE_SET_LOCKPROXYFILE 3
#define SQLITE_LAST_ERRNO 4
#define SQLITE_FCNTL_SIZE_HINT 5
#define SQLITE_FCNTL_CHUNK_SIZE 6
#define SQLITE_FCNTL_FILE_POINTER 7
#define SQLITE_FCNTL_SYNC_OMITTED 8
#define SQLITE_FCNTL_WIN32_AV_RETRY 9
#define SQLITE_FCNTL_PERSIST_WAL 10

type sqlite3_mutex as any
type sqlite3_syscall_ptr as sub cdecl()

type sqlite3_vfs
    iVersion as integer
    szOsFile as integer
    mxPathname as integer
    pNext as sqlite3_vfs ptr
    zName as zstring ptr
    pAppData as any ptr
    xOpen as function cdecl(byval as sqlite3_vfs ptr, byval as zstring ptr, byval as sqlite3_file ptr, byval as integer, byval as integer ptr) as integer
    xDelete as function cdecl(byval as sqlite3_vfs ptr, byval as zstring ptr, byval as integer) as integer
    xAccess as function cdecl(byval as sqlite3_vfs ptr, byval as zstring ptr, byval as integer, byval as integer ptr) as integer
    xFullPathname as function cdecl(byval as sqlite3_vfs ptr, byval as zstring ptr, byval as integer, byval as zstring ptr) as integer
    xDlOpen as sub cdecl(byval as sqlite3_vfs ptr, byval as zstring ptr)
    xDlError as sub cdecl(byval as sqlite3_vfs ptr, byval as integer, byval as zstring ptr)
    xDlSym as sub cdecl(byval as sqlite3_vfs ptr, byval as any ptr, byval as zstring ptr)
    xDlClose as sub cdecl(byval as sqlite3_vfs ptr, byval as any ptr)
    xRandomness as function cdecl(byval as sqlite3_vfs ptr, byval as integer, byval as zstring ptr) as integer
    xSleep as function cdecl(byval as sqlite3_vfs ptr, byval as integer) as integer
    xCurrentTime as function cdecl(byval as sqlite3_vfs ptr, byval as double ptr) as integer
    xGetLastError as function cdecl(byval as sqlite3_vfs ptr, byval as integer, byval as zstring ptr) as integer
    xCurrentTimeInt64 as function cdecl(byval as sqlite3_vfs ptr, byval as sqlite3_int64 ptr) as integer
    xSetSystemCall as function cdecl(byval as sqlite3_vfs ptr, byval as zstring ptr, byval as sqlite3_syscall_ptr) as integer
    xGetSystemCall as function cdecl(byval as sqlite3_vfs ptr, byval as zstring ptr) as sqlite3_syscall_ptr
    xNextSystemCall as function cdecl(byval as sqlite3_vfs ptr, byval as zstring ptr) as zstring ptr
end type

#define SQLITE_ACCESS_EXISTS 0
#define SQLITE_ACCESS_READWRITE 1
#define SQLITE_ACCESS_READ 2
#define SQLITE_SHM_UNLOCK 1
#define SQLITE_SHM_LOCK 2
#define SQLITE_SHM_SHARED 4
#define SQLITE_SHM_EXCLUSIVE 8
#define SQLITE_SHM_NLOCK 8

declare function sqlite3_initialize () as integer
declare function sqlite3_shutdown () as integer
declare function sqlite3_os_init () as integer
declare function sqlite3_os_end () as integer
declare function sqlite3_config (byval as integer, ...) as integer
declare function sqlite3_db_config (byval as sqlite3 ptr, byval op as integer, ...) as integer

type sqlite3_mem_methods
    xMalloc as sub cdecl(byval as integer)
    xFree as sub cdecl(byval as any ptr)
    xRealloc as sub cdecl(byval as any ptr, byval as integer)
    xSize as function cdecl(byval as any ptr) as integer
    xRoundup as function cdecl(byval as integer) as integer
    xInit as function cdecl(byval as any ptr) as integer
    xShutdown as sub cdecl(byval as any ptr)
    pAppData as any ptr
end type

#define SQLITE_CONFIG_SINGLETHREAD 1
#define SQLITE_CONFIG_MULTITHREAD 2
#define SQLITE_CONFIG_SERIALIZED 3
#define SQLITE_CONFIG_MALLOC 4
#define SQLITE_CONFIG_GETMALLOC 5
#define SQLITE_CONFIG_SCRATCH 6
#define SQLITE_CONFIG_PAGECACHE 7
#define SQLITE_CONFIG_HEAP 8
#define SQLITE_CONFIG_MEMSTATUS 9
#define SQLITE_CONFIG_MUTEX 10
#define SQLITE_CONFIG_GETMUTEX 11
#define SQLITE_CONFIG_LOOKASIDE 13
#define SQLITE_CONFIG_PCACHE 14
#define SQLITE_CONFIG_GETPCACHE 15
#define SQLITE_CONFIG_LOG 16
#define SQLITE_CONFIG_URI 17
#define SQLITE_DBCONFIG_LOOKASIDE 1001
#define SQLITE_DBCONFIG_ENABLE_FKEY 1002
#define SQLITE_DBCONFIG_ENABLE_TRIGGER 1003

declare function sqlite3_extended_result_codes (byval as sqlite3 ptr, byval onoff as integer) as integer
declare function sqlite3_last_insert_rowid (byval as sqlite3 ptr) as sqlite3_int64
declare function sqlite3_changes (byval as sqlite3 ptr) as integer
declare function sqlite3_total_changes (byval as sqlite3 ptr) as integer
declare sub sqlite3_interrupt (byval as sqlite3 ptr)
declare function sqlite3_complete (byval sql as zstring ptr) as integer
declare function sqlite3_complete16 (byval sql as any ptr) as integer
declare function sqlite3_busy_handler (byval as sqlite3 ptr, byval as function cdecl(byval as any ptr, byval as integer) as integer, byval as any ptr) as integer
declare function sqlite3_busy_timeout (byval as sqlite3 ptr, byval ms as integer) as integer
declare function sqlite3_get_table (byval db as sqlite3 ptr, byval zSql as zstring ptr, byval pazResult as zstring ptr ptr ptr, byval pnRow as integer ptr, byval pnColumn as integer ptr, byval pzErrmsg as zstring ptr ptr) as integer
declare sub sqlite3_free_table (byval result as zstring ptr ptr)
declare function sqlite3_mprintf (byval as zstring ptr, ...) as zstring ptr
declare function sqlite3_vmprintf (byval as zstring ptr, byval as va_list) as zstring ptr
declare function sqlite3_snprintf (byval as integer, byval as zstring ptr, byval as zstring ptr, ...) as zstring ptr
declare function sqlite3_vsnprintf (byval as integer, byval as zstring ptr, byval as zstring ptr, byval as va_list) as zstring ptr
declare function sqlite3_malloc (byval as integer) as any ptr
declare function sqlite3_realloc (byval as any ptr, byval as integer) as any ptr
declare sub sqlite3_free (byval as any ptr)
declare function sqlite3_memory_used () as sqlite3_int64
declare function sqlite3_memory_highwater (byval resetFlag as integer) as sqlite3_int64
declare sub sqlite3_randomness (byval N as integer, byval P as any ptr)
declare function sqlite3_set_authorizer (byval as sqlite3 ptr, byval xAuth as function cdecl(byval as any ptr, byval as integer, byval as zstring ptr, byval as zstring ptr, byval as zstring ptr, byval as zstring ptr) as integer, byval pUserData as any ptr) as integer

#define SQLITE_DENY 1
#define SQLITE_IGNORE 2
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
#define SQLITE_ANALYZE 28
#define SQLITE_CREATE_VTABLE 29
#define SQLITE_DROP_VTABLE 30
#define SQLITE_FUNCTION 31
#define SQLITE_SAVEPOINT 32
#define SQLITE_COPY 0

declare function sqlite3_trace (byval as sqlite3 ptr, byval xTrace as sub cdecl(byval as any ptr, byval as zstring ptr), byval as any ptr) as any ptr
declare function sqlite3_profile (byval as sqlite3 ptr, byval xProfile as sub cdecl(byval as any ptr, byval as zstring ptr, byval as sqlite3_uint64), byval as any ptr) as any ptr
declare sub sqlite3_progress_handler (byval as sqlite3 ptr, byval as integer, byval as function cdecl(byval as any ptr) as integer, byval as any ptr)
declare function sqlite3_open (byval filename as zstring ptr, byval ppDb as sqlite3 ptr ptr) as integer
declare function sqlite3_open16 (byval filename as any ptr, byval ppDb as sqlite3 ptr ptr) as integer
declare function sqlite3_open_v2 (byval filename as zstring ptr, byval ppDb as sqlite3 ptr ptr, byval flags as integer, byval zVfs as zstring ptr) as integer
declare function sqlite3_uri_parameter (byval zFilename as zstring ptr, byval zParam as zstring ptr) as zstring ptr
declare function sqlite3_errcode (byval db as sqlite3 ptr) as integer
declare function sqlite3_extended_errcode (byval db as sqlite3 ptr) as integer
declare function sqlite3_errmsg (byval as sqlite3 ptr) as zstring ptr
declare function sqlite3_errmsg16 (byval as sqlite3 ptr) as any ptr

type sqlite3_stmt as any

declare function sqlite3_limit (byval as sqlite3 ptr, byval id as integer, byval newVal as integer) as integer

#define SQLITE_LIMIT_LENGTH 0
#define SQLITE_LIMIT_SQL_LENGTH 1
#define SQLITE_LIMIT_COLUMN 2
#define SQLITE_LIMIT_EXPR_DEPTH 3
#define SQLITE_LIMIT_COMPOUND_SELECT 4
#define SQLITE_LIMIT_VDBE_OP 5
#define SQLITE_LIMIT_FUNCTION_ARG 6
#define SQLITE_LIMIT_ATTACHED 7
#define SQLITE_LIMIT_LIKE_PATTERN_LENGTH 8
#define SQLITE_LIMIT_VARIABLE_NUMBER 9
#define SQLITE_LIMIT_TRIGGER_DEPTH 10

declare function sqlite3_prepare (byval db as sqlite3 ptr, byval zSql as zstring ptr, byval nByte as integer, byval ppStmt as sqlite3_stmt ptr ptr, byval pzTail as zstring ptr ptr) as integer
declare function sqlite3_prepare_v2 (byval db as sqlite3 ptr, byval zSql as zstring ptr, byval nByte as integer, byval ppStmt as sqlite3_stmt ptr ptr, byval pzTail as zstring ptr ptr) as integer
declare function sqlite3_prepare16 (byval db as sqlite3 ptr, byval zSql as any ptr, byval nByte as integer, byval ppStmt as sqlite3_stmt ptr ptr, byval pzTail as any ptr ptr) as integer
declare function sqlite3_prepare16_v2 (byval db as sqlite3 ptr, byval zSql as any ptr, byval nByte as integer, byval ppStmt as sqlite3_stmt ptr ptr, byval pzTail as any ptr ptr) as integer
declare function sqlite3_sql (byval pStmt as sqlite3_stmt ptr) as zstring ptr
declare function sqlite3_stmt_readonly (byval pStmt as sqlite3_stmt ptr) as integer

type sqlite3_value as any
type sqlite3_context as any

declare function sqlite3_bind_blob (byval as sqlite3_stmt ptr, byval as integer, byval as any ptr, byval n as integer, byval as sub cdecl(byval as any ptr)) as integer
declare function sqlite3_bind_double (byval as sqlite3_stmt ptr, byval as integer, byval as double) as integer
declare function sqlite3_bind_int (byval as sqlite3_stmt ptr, byval as integer, byval as integer) as integer
declare function sqlite3_bind_int64 (byval as sqlite3_stmt ptr, byval as integer, byval as sqlite3_int64) as integer
declare function sqlite3_bind_null (byval as sqlite3_stmt ptr, byval as integer) as integer
declare function sqlite3_bind_text (byval as sqlite3_stmt ptr, byval as integer, byval as zstring ptr, byval n as integer, byval as sub cdecl(byval as any ptr)) as integer
declare function sqlite3_bind_text16 (byval as sqlite3_stmt ptr, byval as integer, byval as any ptr, byval as integer, byval as sub cdecl(byval as any ptr)) as integer
declare function sqlite3_bind_value (byval as sqlite3_stmt ptr, byval as integer, byval as sqlite3_value ptr) as integer
declare function sqlite3_bind_zeroblob (byval as sqlite3_stmt ptr, byval as integer, byval n as integer) as integer
declare function sqlite3_bind_parameter_count (byval as sqlite3_stmt ptr) as integer
declare function sqlite3_bind_parameter_name (byval as sqlite3_stmt ptr, byval as integer) as zstring ptr
declare function sqlite3_bind_parameter_index (byval as sqlite3_stmt ptr, byval zName as zstring ptr) as integer
declare function sqlite3_clear_bindings (byval as sqlite3_stmt ptr) as integer
declare function sqlite3_column_count (byval pStmt as sqlite3_stmt ptr) as integer
declare function sqlite3_column_name (byval as sqlite3_stmt ptr, byval N as integer) as zstring ptr
declare function sqlite3_column_name16 (byval as sqlite3_stmt ptr, byval N as integer) as any ptr
declare function sqlite3_column_database_name (byval as sqlite3_stmt ptr, byval as integer) as zstring ptr
declare function sqlite3_column_database_name16 (byval as sqlite3_stmt ptr, byval as integer) as any ptr
declare function sqlite3_column_table_name (byval as sqlite3_stmt ptr, byval as integer) as zstring ptr
declare function sqlite3_column_table_name16 (byval as sqlite3_stmt ptr, byval as integer) as any ptr
declare function sqlite3_column_origin_name (byval as sqlite3_stmt ptr, byval as integer) as zstring ptr
declare function sqlite3_column_origin_name16 (byval as sqlite3_stmt ptr, byval as integer) as any ptr
declare function sqlite3_column_decltype (byval as sqlite3_stmt ptr, byval as integer) as zstring ptr
declare function sqlite3_column_decltype16 (byval as sqlite3_stmt ptr, byval as integer) as any ptr
declare function sqlite3_step (byval as sqlite3_stmt ptr) as integer
declare function sqlite3_data_count (byval pStmt as sqlite3_stmt ptr) as integer

#define SQLITE_INTEGER 1
#define SQLITE_FLOAT 2
#define SQLITE_BLOB 4
#define SQLITE_NULL 5
#define SQLITE_TEXT 3
#define SQLITE3_TEXT 3

declare function sqlite3_column_blob (byval as sqlite3_stmt ptr, byval iCol as integer) as any ptr
declare function sqlite3_column_bytes (byval as sqlite3_stmt ptr, byval iCol as integer) as integer
declare function sqlite3_column_bytes16 (byval as sqlite3_stmt ptr, byval iCol as integer) as integer
declare function sqlite3_column_double (byval as sqlite3_stmt ptr, byval iCol as integer) as double
declare function sqlite3_column_int (byval as sqlite3_stmt ptr, byval iCol as integer) as integer
declare function sqlite3_column_int64 (byval as sqlite3_stmt ptr, byval iCol as integer) as sqlite3_int64
declare function sqlite3_column_text (byval as sqlite3_stmt ptr, byval iCol as integer) as zstring ptr
declare function sqlite3_column_text16 (byval as sqlite3_stmt ptr, byval iCol as integer) as any ptr
declare function sqlite3_column_type (byval as sqlite3_stmt ptr, byval iCol as integer) as integer
declare function sqlite3_column_value (byval as sqlite3_stmt ptr, byval iCol as integer) as sqlite3_value ptr
declare function sqlite3_finalize (byval pStmt as sqlite3_stmt ptr) as integer
declare function sqlite3_reset (byval pStmt as sqlite3_stmt ptr) as integer
declare function sqlite3_create_function (byval db as sqlite3 ptr, byval zFunctionName as zstring ptr, byval nArg as integer, byval eTextRep as integer, byval pApp as any ptr, byval xFunc as sub cdecl(byval as sqlite3_context ptr, byval as integer, byval as sqlite3_value ptr ptr), byval xStep as sub cdecl(byval as sqlite3_context ptr, byval as integer, byval as sqlite3_value ptr ptr), byval xFinal as sub cdecl(byval as sqlite3_context ptr)) as integer
declare function sqlite3_create_function16 (byval db as sqlite3 ptr, byval zFunctionName as any ptr, byval nArg as integer, byval eTextRep as integer, byval pApp as any ptr, byval xFunc as sub cdecl(byval as sqlite3_context ptr, byval as integer, byval as sqlite3_value ptr ptr), byval xStep as sub cdecl(byval as sqlite3_context ptr, byval as integer, byval as sqlite3_value ptr ptr), byval xFinal as sub cdecl(byval as sqlite3_context ptr)) as integer
declare function sqlite3_create_function_v2 (byval db as sqlite3 ptr, byval zFunctionName as zstring ptr, byval nArg as integer, byval eTextRep as integer, byval pApp as any ptr, byval xFunc as sub cdecl(byval as sqlite3_context ptr, byval as integer, byval as sqlite3_value ptr ptr), byval xStep as sub cdecl(byval as sqlite3_context ptr, byval as integer, byval as sqlite3_value ptr ptr), byval xFinal as sub cdecl(byval as sqlite3_context ptr), byval xDestroy as sub cdecl(byval as any ptr)) as integer

#define SQLITE_UTF8 1
#define SQLITE_UTF16LE 2
#define SQLITE_UTF16BE 3
#define SQLITE_UTF16 4
#define SQLITE_ANY 5
#define SQLITE_UTF16_ALIGNED 8

declare function sqlite3_aggregate_count (byval as sqlite3_context ptr) as integer
declare function sqlite3_expired (byval as sqlite3_stmt ptr) as integer
declare function sqlite3_transfer_bindings (byval as sqlite3_stmt ptr, byval as sqlite3_stmt ptr) as integer
declare function sqlite3_global_recover () as integer
declare sub sqlite3_thread_cleanup ()
declare function sqlite3_memory_alarm (byval as sub cdecl(byval as any ptr, byval as sqlite3_int64, byval as integer), byval as any ptr, byval as sqlite3_int64) as integer
declare function sqlite3_value_blob (byval as sqlite3_value ptr) as any ptr
declare function sqlite3_value_bytes (byval as sqlite3_value ptr) as integer
declare function sqlite3_value_bytes16 (byval as sqlite3_value ptr) as integer
declare function sqlite3_value_double (byval as sqlite3_value ptr) as double
declare function sqlite3_value_int (byval as sqlite3_value ptr) as integer
declare function sqlite3_value_int64 (byval as sqlite3_value ptr) as sqlite3_int64
declare function sqlite3_value_text (byval as sqlite3_value ptr) as zstring ptr
declare function sqlite3_value_text16 (byval as sqlite3_value ptr) as any ptr
declare function sqlite3_value_text16le (byval as sqlite3_value ptr) as any ptr
declare function sqlite3_value_text16be (byval as sqlite3_value ptr) as any ptr
declare function sqlite3_value_type (byval as sqlite3_value ptr) as integer
declare function sqlite3_value_numeric_type (byval as sqlite3_value ptr) as integer
declare function sqlite3_aggregate_context (byval as sqlite3_context ptr, byval nBytes as integer) as any ptr
declare function sqlite3_user_data (byval as sqlite3_context ptr) as any ptr
declare function sqlite3_context_db_handle (byval as sqlite3_context ptr) as sqlite3 ptr
declare function sqlite3_get_auxdata (byval as sqlite3_context ptr, byval N as integer) as any ptr
declare sub sqlite3_set_auxdata (byval as sqlite3_context ptr, byval N as integer, byval as any ptr, byval as sub cdecl(byval as any ptr))

type sqlite3_destructor_type as sub cdecl(byval as any ptr)
#define SQLITE_STATIC      cast(sqlite3_destructor_type, 0)
#define SQLITE_TRANSIENT   cast(sqlite3_destructor_type, -1)

declare sub sqlite3_result_blob (byval as sqlite3_context ptr, byval as any ptr, byval as integer, byval as sub cdecl(byval as any ptr))
declare sub sqlite3_result_double (byval as sqlite3_context ptr, byval as double)
declare sub sqlite3_result_error (byval as sqlite3_context ptr, byval as zstring ptr, byval as integer)
declare sub sqlite3_result_error16 (byval as sqlite3_context ptr, byval as any ptr, byval as integer)
declare sub sqlite3_result_error_toobig (byval as sqlite3_context ptr)
declare sub sqlite3_result_error_nomem (byval as sqlite3_context ptr)
declare sub sqlite3_result_error_code (byval as sqlite3_context ptr, byval as integer)
declare sub sqlite3_result_int (byval as sqlite3_context ptr, byval as integer)
declare sub sqlite3_result_int64 (byval as sqlite3_context ptr, byval as sqlite3_int64)
declare sub sqlite3_result_null (byval as sqlite3_context ptr)
declare sub sqlite3_result_text (byval as sqlite3_context ptr, byval as zstring ptr, byval as integer, byval as sub cdecl(byval as any ptr))
declare sub sqlite3_result_text16 (byval as sqlite3_context ptr, byval as any ptr, byval as integer, byval as sub cdecl(byval as any ptr))
declare sub sqlite3_result_text16le (byval as sqlite3_context ptr, byval as any ptr, byval as integer, byval as sub cdecl(byval as any ptr))
declare sub sqlite3_result_text16be (byval as sqlite3_context ptr, byval as any ptr, byval as integer, byval as sub cdecl(byval as any ptr))
declare sub sqlite3_result_value (byval as sqlite3_context ptr, byval as sqlite3_value ptr)
declare sub sqlite3_result_zeroblob (byval as sqlite3_context ptr, byval n as integer)
declare function sqlite3_create_collation (byval as sqlite3 ptr, byval zName as zstring ptr, byval eTextRep as integer, byval pArg as any ptr, byval xCompare as function cdecl(byval as any ptr, byval as integer, byval as any ptr, byval as integer, byval as any ptr) as integer) as integer
declare function sqlite3_create_collation_v2 (byval as sqlite3 ptr, byval zName as zstring ptr, byval eTextRep as integer, byval pArg as any ptr, byval xCompare as function cdecl(byval as any ptr, byval as integer, byval as any ptr, byval as integer, byval as any ptr) as integer, byval xDestroy as sub cdecl(byval as any ptr)) as integer
declare function sqlite3_create_collation16 (byval as sqlite3 ptr, byval zName as any ptr, byval eTextRep as integer, byval pArg as any ptr, byval xCompare as function cdecl(byval as any ptr, byval as integer, byval as any ptr, byval as integer, byval as any ptr) as integer) as integer
declare function sqlite3_collation_needed (byval as sqlite3 ptr, byval as any ptr, byval as sub cdecl(byval as any ptr, byval as sqlite3 ptr, byval as integer, byval as zstring ptr)) as integer
declare function sqlite3_collation_needed16 (byval as sqlite3 ptr, byval as any ptr, byval as sub cdecl(byval as any ptr, byval as sqlite3 ptr, byval as integer, byval as any ptr)) as integer
declare function sqlite3_sleep (byval as integer) as integer
extern sqlite3_temp_directory alias "sqlite3_temp_directory" as zstring ptr
declare function sqlite3_get_autocommit (byval as sqlite3 ptr) as integer
declare function sqlite3_db_handle (byval as sqlite3_stmt ptr) as sqlite3 ptr
declare function sqlite3_next_stmt (byval pDb as sqlite3 ptr, byval pStmt as sqlite3_stmt ptr) as sqlite3_stmt ptr
declare function sqlite3_commit_hook (byval as sqlite3 ptr, byval as function cdecl(byval as any ptr) as integer, byval as any ptr) as any ptr
declare function sqlite3_rollback_hook (byval as sqlite3 ptr, byval as sub cdecl(byval as any ptr), byval as any ptr) as any ptr
declare function sqlite3_update_hook (byval as sqlite3 ptr, byval as sub cdecl(byval as any ptr, byval as integer, byval as zstring ptr, byval as zstring ptr, byval as sqlite3_int64), byval as any ptr) as any ptr
declare function sqlite3_enable_shared_cache (byval as integer) as integer
declare function sqlite3_release_memory (byval as integer) as integer
declare function sqlite3_soft_heap_limit64 (byval N as sqlite3_int64) as sqlite3_int64
declare sub sqlite3_soft_heap_limit (byval N as integer)
declare function sqlite3_table_column_metadata (byval db as sqlite3 ptr, byval zDbName as zstring ptr, byval zTableName as zstring ptr, byval zColumnName as zstring ptr, byval pzDataType as zstring ptr ptr, byval pzCollSeq as zstring ptr ptr, byval pNotNull as integer ptr, byval pPrimaryKey as integer ptr, byval pAutoinc as integer ptr) as integer
declare function sqlite3_load_extension (byval db as sqlite3 ptr, byval zFile as zstring ptr, byval zProc as zstring ptr, byval pzErrMsg as zstring ptr ptr) as integer
declare function sqlite3_enable_load_extension (byval db as sqlite3 ptr, byval onoff as integer) as integer
declare function sqlite3_auto_extension (byval xEntryPoint as sub cdecl()) as integer
declare sub sqlite3_reset_auto_extension ()

type sqlite3_vtab as sqlite3_vtab_
type sqlite3_index_info as sqlite3_index_info_
type sqlite3_vtab_cursor as sqlite3_vtab_cursor_

type sqlite3_module
    iVersion as integer
    xCreate as function cdecl(byval as sqlite3 ptr, byval as any ptr, byval as integer, byval as zstring ptr ptr, byval as sqlite3_vtab ptr ptr, byval as zstring ptr ptr) as integer
    xConnect as function cdecl(byval as sqlite3 ptr, byval as any ptr, byval as integer, byval as zstring ptr ptr, byval as sqlite3_vtab ptr ptr, byval as zstring ptr ptr) as integer
    xBestIndex as function cdecl(byval as sqlite3_vtab ptr, byval as sqlite3_index_info ptr) as integer
    xDisconnect as function cdecl(byval as sqlite3_vtab ptr) as integer
    xDestroy as function cdecl(byval as sqlite3_vtab ptr) as integer
    xOpen as function cdecl(byval as sqlite3_vtab ptr, byval as sqlite3_vtab_cursor ptr ptr) as integer
    xClose as function cdecl(byval as sqlite3_vtab_cursor ptr) as integer
    xFilter as function cdecl(byval as sqlite3_vtab_cursor ptr, byval as integer, byval as zstring ptr, byval as integer, byval as sqlite3_value ptr ptr) as integer
    xNext as function cdecl(byval as sqlite3_vtab_cursor ptr) as integer
    xEof as function cdecl(byval as sqlite3_vtab_cursor ptr) as integer
    xColumn as function cdecl(byval as sqlite3_vtab_cursor ptr, byval as sqlite3_context ptr, byval as integer) as integer
    xRowid as function cdecl(byval as sqlite3_vtab_cursor ptr, byval as sqlite3_int64 ptr) as integer
    xUpdate as function cdecl(byval as sqlite3_vtab ptr, byval as integer, byval as sqlite3_value ptr ptr, byval as sqlite3_int64 ptr) as integer
    xBegin as function cdecl(byval as sqlite3_vtab ptr) as integer
    xSync as function cdecl(byval as sqlite3_vtab ptr) as integer
    xCommit as function cdecl(byval as sqlite3_vtab ptr) as integer
    xRollback as function cdecl(byval as sqlite3_vtab ptr) as integer
    xFindFunction as function cdecl(byval as sqlite3_vtab ptr, byval as integer, byval as zstring ptr, byval as sub cdecl(byval as sqlite3_context ptr, byval as integer, byval as sqlite3_value ptr ptr), byval as any ptr ptr) as integer
    xRename as function cdecl(byval as sqlite3_vtab ptr, byval as zstring ptr) as integer
    xSavepoint as function cdecl(byval as sqlite3_vtab ptr, byval as integer) as integer
    xRelease as function cdecl(byval as sqlite3_vtab ptr, byval as integer) as integer
    xRollbackTo as function cdecl(byval as sqlite3_vtab ptr, byval as integer) as integer
end type

type sqlite3_index_info_aConstraintUsage
    argvIndex as integer
    omit as ubyte
end type

type sqlite3_index_info_aOrderBy
    iColumn as integer
    desc as ubyte
end type

type sqlite3_index_info_aConstraint
    iColumn as integer
    op as ubyte
    usable as ubyte
    iTermOffset as integer
end type

type sqlite3_index_info_
    nConstraint as integer
    nOrderBy as integer
    idxNum as integer
    idxStr as zstring ptr
    needToFreeIdxStr as integer
    orderByConsumed as integer
    estimatedCost as double
    aConstraintUsage as sqlite3_index_info_aConstraintUsage ptr
    aOrderBy as sqlite3_index_info_aOrderBy ptr
    aConstraint as sqlite3_index_info_aConstraint ptr
end type

#define SQLITE_INDEX_CONSTRAINT_EQ 2
#define SQLITE_INDEX_CONSTRAINT_GT 4
#define SQLITE_INDEX_CONSTRAINT_LE 8
#define SQLITE_INDEX_CONSTRAINT_LT 16
#define SQLITE_INDEX_CONSTRAINT_GE 32
#define SQLITE_INDEX_CONSTRAINT_MATCH 64

declare function sqlite3_create_module (byval db as sqlite3 ptr, byval zName as zstring ptr, byval p as sqlite3_module ptr, byval pClientData as any ptr) as integer
declare function sqlite3_create_module_v2 (byval db as sqlite3 ptr, byval zName as zstring ptr, byval p as sqlite3_module ptr, byval pClientData as any ptr, byval xDestroy as sub cdecl(byval as any ptr)) as integer

type sqlite3_vtab_
    pModule as sqlite3_module ptr
    nRef as integer
    zErrMsg as zstring ptr
end type

type sqlite3_vtab_cursor_
    pVtab as sqlite3_vtab ptr
end type

declare function sqlite3_declare_vtab (byval as sqlite3 ptr, byval zSQL as zstring ptr) as integer
declare function sqlite3_overload_function (byval as sqlite3 ptr, byval zFuncName as zstring ptr, byval nArg as integer) as integer

type sqlite3_blob as any

declare function sqlite3_blob_open (byval as sqlite3 ptr, byval zDb as zstring ptr, byval zTable as zstring ptr, byval zColumn as zstring ptr, byval iRow as sqlite3_int64, byval flags as integer, byval ppBlob as sqlite3_blob ptr ptr) as integer
declare function sqlite3_blob_reopen (byval as sqlite3_blob ptr, byval as sqlite3_int64) as integer
declare function sqlite3_blob_close (byval as sqlite3_blob ptr) as integer
declare function sqlite3_blob_bytes (byval as sqlite3_blob ptr) as integer
declare function sqlite3_blob_read (byval as sqlite3_blob ptr, byval Z as any ptr, byval N as integer, byval iOffset as integer) as integer
declare function sqlite3_blob_write (byval as sqlite3_blob ptr, byval z as any ptr, byval n as integer, byval iOffset as integer) as integer
declare function sqlite3_vfs_find (byval zVfsName as zstring ptr) as sqlite3_vfs ptr
declare function sqlite3_vfs_register (byval as sqlite3_vfs ptr, byval makeDflt as integer) as integer
declare function sqlite3_vfs_unregister (byval as sqlite3_vfs ptr) as integer
declare function sqlite3_mutex_alloc (byval as integer) as sqlite3_mutex ptr
declare sub sqlite3_mutex_free (byval as sqlite3_mutex ptr)
declare sub sqlite3_mutex_enter (byval as sqlite3_mutex ptr)
declare function sqlite3_mutex_try (byval as sqlite3_mutex ptr) as integer
declare sub sqlite3_mutex_leave (byval as sqlite3_mutex ptr)

type sqlite3_mutex_methods
    xMutexInit as function cdecl() as integer
    xMutexEnd as function cdecl() as integer
    xMutexAlloc as function cdecl(byval as integer) as sqlite3_mutex ptr
    xMutexFree as sub cdecl(byval as sqlite3_mutex ptr)
    xMutexEnter as sub cdecl(byval as sqlite3_mutex ptr)
    xMutexTry as function cdecl(byval as sqlite3_mutex ptr) as integer
    xMutexLeave as sub cdecl(byval as sqlite3_mutex ptr)
    xMutexHeld as function cdecl(byval as sqlite3_mutex ptr) as integer
    xMutexNotheld as function cdecl(byval as sqlite3_mutex ptr) as integer
end type

declare function sqlite3_mutex_held (byval as sqlite3_mutex ptr) as integer
declare function sqlite3_mutex_notheld (byval as sqlite3_mutex ptr) as integer

#define SQLITE_MUTEX_FAST 0
#define SQLITE_MUTEX_RECURSIVE 1
#define SQLITE_MUTEX_STATIC_MASTER 2
#define SQLITE_MUTEX_STATIC_MEM 3
#define SQLITE_MUTEX_STATIC_MEM2 4
#define SQLITE_MUTEX_STATIC_OPEN 4
#define SQLITE_MUTEX_STATIC_PRNG 5
#define SQLITE_MUTEX_STATIC_LRU 6
#define SQLITE_MUTEX_STATIC_LRU2 7
#define SQLITE_MUTEX_STATIC_PMEM 7

declare function sqlite3_db_mutex (byval as sqlite3 ptr) as sqlite3_mutex ptr
declare function sqlite3_file_control (byval as sqlite3 ptr, byval zDbName as zstring ptr, byval op as integer, byval as any ptr) as integer
declare function sqlite3_test_control (byval op as integer, ...) as integer

#define SQLITE_TESTCTRL_FIRST 5
#define SQLITE_TESTCTRL_PRNG_SAVE 5
#define SQLITE_TESTCTRL_PRNG_RESTORE 6
#define SQLITE_TESTCTRL_PRNG_RESET 7
#define SQLITE_TESTCTRL_BITVEC_TEST 8
#define SQLITE_TESTCTRL_FAULT_INSTALL 9
#define SQLITE_TESTCTRL_BENIGN_MALLOC_HOOKS 10
#define SQLITE_TESTCTRL_PENDING_BYTE 11
#define SQLITE_TESTCTRL_ASSERT 12
#define SQLITE_TESTCTRL_ALWAYS 13
#define SQLITE_TESTCTRL_RESERVE 14
#define SQLITE_TESTCTRL_OPTIMIZATIONS 15
#define SQLITE_TESTCTRL_ISKEYWORD 16
#define SQLITE_TESTCTRL_PGHDRSZ 17
#define SQLITE_TESTCTRL_SCRATCHMALLOC 18
#define SQLITE_TESTCTRL_LOCALTIME_FAULT 19
#define SQLITE_TESTCTRL_LAST 19

declare function sqlite3_status (byval op as integer, byval pCurrent as integer ptr, byval pHighwater as integer ptr, byval resetFlag as integer) as integer

#define SQLITE_STATUS_MEMORY_USED 0
#define SQLITE_STATUS_PAGECACHE_USED 1
#define SQLITE_STATUS_PAGECACHE_OVERFLOW 2
#define SQLITE_STATUS_SCRATCH_USED 3
#define SQLITE_STATUS_SCRATCH_OVERFLOW 4
#define SQLITE_STATUS_MALLOC_SIZE 5
#define SQLITE_STATUS_PARSER_STACK 6
#define SQLITE_STATUS_PAGECACHE_SIZE 7
#define SQLITE_STATUS_SCRATCH_SIZE 8
#define SQLITE_STATUS_MALLOC_COUNT 9

declare function sqlite3_db_status (byval as sqlite3 ptr, byval op as integer, byval pCur as integer ptr, byval pHiwtr as integer ptr, byval resetFlg as integer) as integer

#define SQLITE_DBSTATUS_LOOKASIDE_USED 0
#define SQLITE_DBSTATUS_CACHE_USED 1
#define SQLITE_DBSTATUS_SCHEMA_USED 2
#define SQLITE_DBSTATUS_STMT_USED 3
#define SQLITE_DBSTATUS_LOOKASIDE_HIT 4
#define SQLITE_DBSTATUS_LOOKASIDE_MISS_SIZE 5
#define SQLITE_DBSTATUS_LOOKASIDE_MISS_FULL 6
#define SQLITE_DBSTATUS_MAX 6

declare function sqlite3_stmt_status (byval as sqlite3_stmt ptr, byval op as integer, byval resetFlg as integer) as integer

#define SQLITE_STMTSTATUS_FULLSCAN_STEP 1
#define SQLITE_STMTSTATUS_SORT 2
#define SQLITE_STMTSTATUS_AUTOINDEX 3

type sqlite3_pcache as any

type sqlite3_pcache_methods
    pArg as any ptr
    xInit as function cdecl(byval as any ptr) as integer
    xShutdown as sub cdecl(byval as any ptr)
    xCreate as function cdecl(byval as integer, byval as integer) as sqlite3_pcache ptr
    xCachesize as sub cdecl(byval as sqlite3_pcache ptr, byval as integer)
    xPagecount as function cdecl(byval as sqlite3_pcache ptr) as integer
    xFetch as sub cdecl(byval as sqlite3_pcache ptr, byval as uinteger, byval as integer)
    xUnpin as sub cdecl(byval as sqlite3_pcache ptr, byval as any ptr, byval as integer)
    xRekey as sub cdecl(byval as sqlite3_pcache ptr, byval as any ptr, byval as uinteger, byval as uinteger)
    xTruncate as sub cdecl(byval as sqlite3_pcache ptr, byval as uinteger)
    xDestroy as sub cdecl(byval as sqlite3_pcache ptr)
end type

type sqlite3_backup as any

declare function sqlite3_backup_init (byval pDest as sqlite3 ptr, byval zDestName as zstring ptr, byval pSource as sqlite3 ptr, byval zSourceName as zstring ptr) as sqlite3_backup ptr
declare function sqlite3_backup_step (byval p as sqlite3_backup ptr, byval nPage as integer) as integer
declare function sqlite3_backup_finish (byval p as sqlite3_backup ptr) as integer
declare function sqlite3_backup_remaining (byval p as sqlite3_backup ptr) as integer
declare function sqlite3_backup_pagecount (byval p as sqlite3_backup ptr) as integer
declare function sqlite3_unlock_notify (byval pBlocked as sqlite3 ptr, byval xNotify as sub cdecl(byval as any ptr ptr, byval as integer), byval pNotifyArg as any ptr) as integer
declare function sqlite3_strnicmp (byval as zstring ptr, byval as zstring ptr, byval as integer) as integer
declare sub sqlite3_log (byval iErrCode as integer, byval zFormat as zstring ptr, ...)
declare function sqlite3_wal_hook (byval as sqlite3 ptr, byval as function cdecl(byval as any ptr, byval as sqlite3 ptr, byval as zstring ptr, byval as integer) as integer, byval as any ptr) as any ptr
declare function sqlite3_wal_autocheckpoint (byval db as sqlite3 ptr, byval N as integer) as integer
declare function sqlite3_wal_checkpoint (byval db as sqlite3 ptr, byval zDb as zstring ptr) as integer
declare function sqlite3_wal_checkpoint_v2 (byval db as sqlite3 ptr, byval zDb as zstring ptr, byval eMode as integer, byval pnLog as integer ptr, byval pnCkpt as integer ptr) as integer

#define SQLITE_CHECKPOINT_PASSIVE 0
#define SQLITE_CHECKPOINT_FULL 1
#define SQLITE_CHECKPOINT_RESTART 2

declare function sqlite3_vtab_config (byval as sqlite3 ptr, byval op as integer, ...) as integer

#define SQLITE_VTAB_CONSTRAINT_SUPPORT 1

declare function sqlite3_vtab_on_conflict (byval as sqlite3 ptr) as integer

#define SQLITE_ROLLBACK 1
#define SQLITE_FAIL 3
#define SQLITE_REPLACE 5

type sqlite3_rtree_geometry as sqlite3_rtree_geometry_

declare function sqlite3_rtree_geometry_callback (byval db as sqlite3 ptr, byval zGeom as zstring ptr, byval xGeom as function cdecl(byval as sqlite3_rtree_geometry ptr, byval as integer, byval as double ptr, byval as integer ptr) as integer, byval pContext as any ptr) as integer

type sqlite3_rtree_geometry_
    pContext as any ptr
    nParam as integer
    aParam as double ptr
    pUser as any ptr
    xDelUser as sub cdecl(byval as any ptr)
end type

end extern
#endif
