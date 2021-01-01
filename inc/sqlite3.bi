'' FreeBASIC binding for SQLite 3.34.0
''
'' based on the C header files:
''   * 2001-09-15
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
''   * presents to client programs.  If a C-function, structure, datatype,
''   * or constant definition does not appear in this file, then it is
''   * not a published API of SQLite, is subject to change without
''   * notice, and should not be referenced by programs that use SQLite.
''   *
''   * Some of the definitions that are in this file are marked as
''   * "experimental".  Experimental interfaces are normally new
''   * features recently added to SQLite.  We do not anticipate changes
''   * to experimental interfaces but reserve the right to make minor changes
''   * if experience from use "in the wild" suggest such changes are prudent.
''   *
''   * The official C-language API documentation for SQLite is derived
''   * from comments in this file.  This file is the authoritative source
''   * on how SQLite interfaces are supposed to operate.
''   *
''   * The name of this file under configuration management is "sqlite.h.in".
''   * The makefile makes some minor changes to this file (such as inserting
''   * the version number) and changes its name to "sqlite3.h" as
''   * part of the build process.
''
'' translated to FreeBASIC by:
''   Copyright © 2020 FreeBASIC development team

#pragma once

#inclib "sqlite3"

#include once "crt/long.bi"
#include once "crt/stdarg.bi"

extern "C"

#define SQLITE3_H
#define SQLITE_VERSION "3.34.0"
const SQLITE_VERSION_NUMBER = 3034000
#define SQLITE_SOURCE_ID "2020-12-01 16:14:00 a26b6597e3ae272231b96f9982c3bcc17ddec2f2b6eb4df06a224b91089fed5b"
extern __sqlite3_version alias "sqlite3_version" as const byte
#define sqlite3_version (*cptr(const zstring ptr, @__sqlite3_version))

declare function sqlite3_libversion() as const zstring ptr
declare function sqlite3_sourceid() as const zstring ptr
declare function sqlite3_libversion_number() as long
declare function sqlite3_compileoption_used(byval zOptName as const zstring ptr) as long
declare function sqlite3_compileoption_get(byval N as long) as const zstring ptr
declare function sqlite3_threadsafe() as long

type sqlite_int64 as longint
type sqlite_uint64 as ulongint
type sqlite3_int64 as sqlite_int64
type sqlite3_uint64 as sqlite_uint64
type sqlite3 as sqlite3_
declare function sqlite3_close(byval as sqlite3 ptr) as long
declare function sqlite3_close_v2(byval as sqlite3 ptr) as long
type sqlite3_callback as function(byval as any ptr, byval as long, byval as zstring ptr ptr, byval as zstring ptr ptr) as long
declare function sqlite3_exec(byval as sqlite3 ptr, byval sql as const zstring ptr, byval callback as function(byval as any ptr, byval as long, byval as zstring ptr ptr, byval as zstring ptr ptr) as long, byval as any ptr, byval errmsg as zstring ptr ptr) as long

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
const SQLITE_NOTICE = 27
const SQLITE_WARNING = 28
const SQLITE_ROW = 100
const SQLITE_DONE = 101
const SQLITE_ERROR_MISSING_COLLSEQ = SQLITE_ERROR or (1 shl 8)
const SQLITE_ERROR_RETRY = SQLITE_ERROR or (2 shl 8)
const SQLITE_ERROR_SNAPSHOT = SQLITE_ERROR or (3 shl 8)
const SQLITE_IOERR_READ = SQLITE_IOERR or (1 shl 8)
const SQLITE_IOERR_SHORT_READ = SQLITE_IOERR or (2 shl 8)
const SQLITE_IOERR_WRITE = SQLITE_IOERR or (3 shl 8)
const SQLITE_IOERR_FSYNC = SQLITE_IOERR or (4 shl 8)
const SQLITE_IOERR_DIR_FSYNC = SQLITE_IOERR or (5 shl 8)
const SQLITE_IOERR_TRUNCATE = SQLITE_IOERR or (6 shl 8)
const SQLITE_IOERR_FSTAT = SQLITE_IOERR or (7 shl 8)
const SQLITE_IOERR_UNLOCK = SQLITE_IOERR or (8 shl 8)
const SQLITE_IOERR_RDLOCK = SQLITE_IOERR or (9 shl 8)
const SQLITE_IOERR_DELETE = SQLITE_IOERR or (10 shl 8)
const SQLITE_IOERR_BLOCKED = SQLITE_IOERR or (11 shl 8)
const SQLITE_IOERR_NOMEM = SQLITE_IOERR or (12 shl 8)
const SQLITE_IOERR_ACCESS = SQLITE_IOERR or (13 shl 8)
const SQLITE_IOERR_CHECKRESERVEDLOCK = SQLITE_IOERR or (14 shl 8)
const SQLITE_IOERR_LOCK = SQLITE_IOERR or (15 shl 8)
const SQLITE_IOERR_CLOSE = SQLITE_IOERR or (16 shl 8)
const SQLITE_IOERR_DIR_CLOSE = SQLITE_IOERR or (17 shl 8)
const SQLITE_IOERR_SHMOPEN = SQLITE_IOERR or (18 shl 8)
const SQLITE_IOERR_SHMSIZE = SQLITE_IOERR or (19 shl 8)
const SQLITE_IOERR_SHMLOCK = SQLITE_IOERR or (20 shl 8)
const SQLITE_IOERR_SHMMAP = SQLITE_IOERR or (21 shl 8)
const SQLITE_IOERR_SEEK = SQLITE_IOERR or (22 shl 8)
const SQLITE_IOERR_DELETE_NOENT = SQLITE_IOERR or (23 shl 8)
const SQLITE_IOERR_MMAP = SQLITE_IOERR or (24 shl 8)
const SQLITE_IOERR_GETTEMPPATH = SQLITE_IOERR or (25 shl 8)
const SQLITE_IOERR_CONVPATH = SQLITE_IOERR or (26 shl 8)
const SQLITE_IOERR_VNODE = SQLITE_IOERR or (27 shl 8)
const SQLITE_IOERR_AUTH = SQLITE_IOERR or (28 shl 8)
const SQLITE_IOERR_BEGIN_ATOMIC = SQLITE_IOERR or (29 shl 8)
const SQLITE_IOERR_COMMIT_ATOMIC = SQLITE_IOERR or (30 shl 8)
const SQLITE_IOERR_ROLLBACK_ATOMIC = SQLITE_IOERR or (31 shl 8)
const SQLITE_IOERR_DATA = SQLITE_IOERR or (32 shl 8)
const SQLITE_IOERR_CORRUPTFS = SQLITE_IOERR or (33 shl 8)
const SQLITE_LOCKED_SHAREDCACHE = SQLITE_LOCKED or (1 shl 8)
const SQLITE_LOCKED_VTAB = SQLITE_LOCKED or (2 shl 8)
const SQLITE_BUSY_RECOVERY = SQLITE_BUSY or (1 shl 8)
const SQLITE_BUSY_SNAPSHOT = SQLITE_BUSY or (2 shl 8)
const SQLITE_BUSY_TIMEOUT = SQLITE_BUSY or (3 shl 8)
const SQLITE_CANTOPEN_NOTEMPDIR = SQLITE_CANTOPEN or (1 shl 8)
const SQLITE_CANTOPEN_ISDIR = SQLITE_CANTOPEN or (2 shl 8)
const SQLITE_CANTOPEN_FULLPATH = SQLITE_CANTOPEN or (3 shl 8)
const SQLITE_CANTOPEN_CONVPATH = SQLITE_CANTOPEN or (4 shl 8)
const SQLITE_CANTOPEN_DIRTYWAL = SQLITE_CANTOPEN or (5 shl 8)
const SQLITE_CANTOPEN_SYMLINK = SQLITE_CANTOPEN or (6 shl 8)
const SQLITE_CORRUPT_VTAB = SQLITE_CORRUPT or (1 shl 8)
const SQLITE_CORRUPT_SEQUENCE = SQLITE_CORRUPT or (2 shl 8)
const SQLITE_CORRUPT_INDEX = SQLITE_CORRUPT or (3 shl 8)
const SQLITE_READONLY_RECOVERY = SQLITE_READONLY or (1 shl 8)
const SQLITE_READONLY_CANTLOCK = SQLITE_READONLY or (2 shl 8)
const SQLITE_READONLY_ROLLBACK = SQLITE_READONLY or (3 shl 8)
const SQLITE_READONLY_DBMOVED = SQLITE_READONLY or (4 shl 8)
const SQLITE_READONLY_CANTINIT = SQLITE_READONLY or (5 shl 8)
const SQLITE_READONLY_DIRECTORY = SQLITE_READONLY or (6 shl 8)
const SQLITE_ABORT_ROLLBACK = SQLITE_ABORT or (2 shl 8)
const SQLITE_CONSTRAINT_CHECK = SQLITE_CONSTRAINT or (1 shl 8)
const SQLITE_CONSTRAINT_COMMITHOOK = SQLITE_CONSTRAINT or (2 shl 8)
const SQLITE_CONSTRAINT_FOREIGNKEY = SQLITE_CONSTRAINT or (3 shl 8)
const SQLITE_CONSTRAINT_FUNCTION = SQLITE_CONSTRAINT or (4 shl 8)
const SQLITE_CONSTRAINT_NOTNULL = SQLITE_CONSTRAINT or (5 shl 8)
const SQLITE_CONSTRAINT_PRIMARYKEY = SQLITE_CONSTRAINT or (6 shl 8)
const SQLITE_CONSTRAINT_TRIGGER = SQLITE_CONSTRAINT or (7 shl 8)
const SQLITE_CONSTRAINT_UNIQUE = SQLITE_CONSTRAINT or (8 shl 8)
const SQLITE_CONSTRAINT_VTAB = SQLITE_CONSTRAINT or (9 shl 8)
const SQLITE_CONSTRAINT_ROWID = SQLITE_CONSTRAINT or (10 shl 8)
const SQLITE_CONSTRAINT_PINNED = SQLITE_CONSTRAINT or (11 shl 8)
const SQLITE_NOTICE_RECOVER_WAL = SQLITE_NOTICE or (1 shl 8)
const SQLITE_NOTICE_RECOVER_ROLLBACK = SQLITE_NOTICE or (2 shl 8)
const SQLITE_WARNING_AUTOINDEX = SQLITE_WARNING or (1 shl 8)
const SQLITE_AUTH_USER = SQLITE_AUTH or (1 shl 8)
const SQLITE_OK_LOAD_PERMANENTLY = SQLITE_OK or (1 shl 8)
const SQLITE_OK_SYMLINK = SQLITE_OK or (2 shl 8)
const SQLITE_OPEN_READONLY = &h00000001
const SQLITE_OPEN_READWRITE = &h00000002
const SQLITE_OPEN_CREATE = &h00000004
const SQLITE_OPEN_DELETEONCLOSE = &h00000008
const SQLITE_OPEN_EXCLUSIVE = &h00000010
const SQLITE_OPEN_AUTOPROXY = &h00000020
const SQLITE_OPEN_URI = &h00000040
const SQLITE_OPEN_MEMORY = &h00000080
const SQLITE_OPEN_MAIN_DB = &h00000100
const SQLITE_OPEN_TEMP_DB = &h00000200
const SQLITE_OPEN_TRANSIENT_DB = &h00000400
const SQLITE_OPEN_MAIN_JOURNAL = &h00000800
const SQLITE_OPEN_TEMP_JOURNAL = &h00001000
const SQLITE_OPEN_SUBJOURNAL = &h00002000
const SQLITE_OPEN_SUPER_JOURNAL = &h00004000
const SQLITE_OPEN_NOMUTEX = &h00008000
const SQLITE_OPEN_FULLMUTEX = &h00010000
const SQLITE_OPEN_SHAREDCACHE = &h00020000
const SQLITE_OPEN_PRIVATECACHE = &h00040000
const SQLITE_OPEN_WAL = &h00080000
const SQLITE_OPEN_NOFOLLOW = &h01000000
const SQLITE_OPEN_MASTER_JOURNAL = &h00004000
const SQLITE_IOCAP_ATOMIC = &h00000001
const SQLITE_IOCAP_ATOMIC512 = &h00000002
const SQLITE_IOCAP_ATOMIC1K = &h00000004
const SQLITE_IOCAP_ATOMIC2K = &h00000008
const SQLITE_IOCAP_ATOMIC4K = &h00000010
const SQLITE_IOCAP_ATOMIC8K = &h00000020
const SQLITE_IOCAP_ATOMIC16K = &h00000040
const SQLITE_IOCAP_ATOMIC32K = &h00000080
const SQLITE_IOCAP_ATOMIC64K = &h00000100
const SQLITE_IOCAP_SAFE_APPEND = &h00000200
const SQLITE_IOCAP_SEQUENTIAL = &h00000400
const SQLITE_IOCAP_UNDELETABLE_WHEN_OPEN = &h00000800
const SQLITE_IOCAP_POWERSAFE_OVERWRITE = &h00001000
const SQLITE_IOCAP_IMMUTABLE = &h00002000
const SQLITE_IOCAP_BATCH_ATOMIC = &h00004000
const SQLITE_LOCK_NONE = 0
const SQLITE_LOCK_SHARED = 1
const SQLITE_LOCK_RESERVED = 2
const SQLITE_LOCK_PENDING = 3
const SQLITE_LOCK_EXCLUSIVE = 4
const SQLITE_SYNC_NORMAL = &h00002
const SQLITE_SYNC_FULL = &h00003
const SQLITE_SYNC_DATAONLY = &h00010
type sqlite3_io_methods as sqlite3_io_methods_

type sqlite3_file
	pMethods as const sqlite3_io_methods ptr
end type

type sqlite3_io_methods_
	iVersion as long
	xClose as function(byval as sqlite3_file ptr) as long
	xRead as function(byval as sqlite3_file ptr, byval as any ptr, byval iAmt as long, byval iOfst as sqlite3_int64) as long
	xWrite as function(byval as sqlite3_file ptr, byval as const any ptr, byval iAmt as long, byval iOfst as sqlite3_int64) as long
	xTruncate as function(byval as sqlite3_file ptr, byval size as sqlite3_int64) as long
	xSync as function(byval as sqlite3_file ptr, byval flags as long) as long
	xFileSize as function(byval as sqlite3_file ptr, byval pSize as sqlite3_int64 ptr) as long
	xLock as function(byval as sqlite3_file ptr, byval as long) as long
	xUnlock as function(byval as sqlite3_file ptr, byval as long) as long
	xCheckReservedLock as function(byval as sqlite3_file ptr, byval pResOut as long ptr) as long
	xFileControl as function(byval as sqlite3_file ptr, byval op as long, byval pArg as any ptr) as long
	xSectorSize as function(byval as sqlite3_file ptr) as long
	xDeviceCharacteristics as function(byval as sqlite3_file ptr) as long
	xShmMap as function(byval as sqlite3_file ptr, byval iPg as long, byval pgsz as long, byval as long, byval as any ptr ptr) as long
	xShmLock as function(byval as sqlite3_file ptr, byval offset as long, byval n as long, byval flags as long) as long
	xShmBarrier as sub(byval as sqlite3_file ptr)
	xShmUnmap as function(byval as sqlite3_file ptr, byval deleteFlag as long) as long
	xFetch as function(byval as sqlite3_file ptr, byval iOfst as sqlite3_int64, byval iAmt as long, byval pp as any ptr ptr) as long
	xUnfetch as function(byval as sqlite3_file ptr, byval iOfst as sqlite3_int64, byval p as any ptr) as long
end type

const SQLITE_FCNTL_LOCKSTATE = 1
const SQLITE_FCNTL_GET_LOCKPROXYFILE = 2
const SQLITE_FCNTL_SET_LOCKPROXYFILE = 3
const SQLITE_FCNTL_LAST_ERRNO = 4
const SQLITE_FCNTL_SIZE_HINT = 5
const SQLITE_FCNTL_CHUNK_SIZE = 6
const SQLITE_FCNTL_FILE_POINTER = 7
const SQLITE_FCNTL_SYNC_OMITTED = 8
const SQLITE_FCNTL_WIN32_AV_RETRY = 9
const SQLITE_FCNTL_PERSIST_WAL = 10
const SQLITE_FCNTL_OVERWRITE = 11
const SQLITE_FCNTL_VFSNAME = 12
const SQLITE_FCNTL_POWERSAFE_OVERWRITE = 13
const SQLITE_FCNTL_PRAGMA = 14
const SQLITE_FCNTL_BUSYHANDLER = 15
const SQLITE_FCNTL_TEMPFILENAME = 16
const SQLITE_FCNTL_MMAP_SIZE = 18
const SQLITE_FCNTL_TRACE = 19
const SQLITE_FCNTL_HAS_MOVED = 20
const SQLITE_FCNTL_SYNC = 21
const SQLITE_FCNTL_COMMIT_PHASETWO = 22
const SQLITE_FCNTL_WIN32_SET_HANDLE = 23
const SQLITE_FCNTL_WAL_BLOCK = 24
const SQLITE_FCNTL_ZIPVFS = 25
const SQLITE_FCNTL_RBU = 26
const SQLITE_FCNTL_VFS_POINTER = 27
const SQLITE_FCNTL_JOURNAL_POINTER = 28
const SQLITE_FCNTL_WIN32_GET_HANDLE = 29
const SQLITE_FCNTL_PDB = 30
const SQLITE_FCNTL_BEGIN_ATOMIC_WRITE = 31
const SQLITE_FCNTL_COMMIT_ATOMIC_WRITE = 32
const SQLITE_FCNTL_ROLLBACK_ATOMIC_WRITE = 33
const SQLITE_FCNTL_LOCK_TIMEOUT = 34
const SQLITE_FCNTL_DATA_VERSION = 35
const SQLITE_FCNTL_SIZE_LIMIT = 36
const SQLITE_FCNTL_CKPT_DONE = 37
const SQLITE_FCNTL_RESERVE_BYTES = 38
const SQLITE_FCNTL_CKPT_START = 39
const SQLITE_GET_LOCKPROXYFILE = SQLITE_FCNTL_GET_LOCKPROXYFILE
const SQLITE_SET_LOCKPROXYFILE = SQLITE_FCNTL_SET_LOCKPROXYFILE
const SQLITE_LAST_ERRNO = SQLITE_FCNTL_LAST_ERRNO
type sqlite3_syscall_ptr as sub()

type sqlite3_vfs
	iVersion as long
	szOsFile as long
	mxPathname as long
	pNext as sqlite3_vfs ptr
	zName as const zstring ptr
	pAppData as any ptr
	xOpen as function(byval as sqlite3_vfs ptr, byval zName as const zstring ptr, byval as sqlite3_file ptr, byval flags as long, byval pOutFlags as long ptr) as long
	xDelete as function(byval as sqlite3_vfs ptr, byval zName as const zstring ptr, byval syncDir as long) as long
	xAccess as function(byval as sqlite3_vfs ptr, byval zName as const zstring ptr, byval flags as long, byval pResOut as long ptr) as long
	xFullPathname as function(byval as sqlite3_vfs ptr, byval zName as const zstring ptr, byval nOut as long, byval zOut as zstring ptr) as long
	xDlOpen as function(byval as sqlite3_vfs ptr, byval zFilename as const zstring ptr) as any ptr
	xDlError as sub(byval as sqlite3_vfs ptr, byval nByte as long, byval zErrMsg as zstring ptr)
	xDlSym as function(byval as sqlite3_vfs ptr, byval as any ptr, byval zSymbol as const zstring ptr) as sub()
	xDlClose as sub(byval as sqlite3_vfs ptr, byval as any ptr)
	xRandomness as function(byval as sqlite3_vfs ptr, byval nByte as long, byval zOut as zstring ptr) as long
	xSleep as function(byval as sqlite3_vfs ptr, byval microseconds as long) as long
	xCurrentTime as function(byval as sqlite3_vfs ptr, byval as double ptr) as long
	xGetLastError as function(byval as sqlite3_vfs ptr, byval as long, byval as zstring ptr) as long
	xCurrentTimeInt64 as function(byval as sqlite3_vfs ptr, byval as sqlite3_int64 ptr) as long
	xSetSystemCall as function(byval as sqlite3_vfs ptr, byval zName as const zstring ptr, byval as sqlite3_syscall_ptr) as long
	xGetSystemCall as function(byval as sqlite3_vfs ptr, byval zName as const zstring ptr) as sqlite3_syscall_ptr
	xNextSystemCall as function(byval as sqlite3_vfs ptr, byval zName as const zstring ptr) as const zstring ptr
end type

const SQLITE_ACCESS_EXISTS = 0
const SQLITE_ACCESS_READWRITE = 1
const SQLITE_ACCESS_READ = 2
const SQLITE_SHM_UNLOCK = 1
const SQLITE_SHM_LOCK = 2
const SQLITE_SHM_SHARED = 4
const SQLITE_SHM_EXCLUSIVE = 8
const SQLITE_SHM_NLOCK = 8

declare function sqlite3_initialize() as long
declare function sqlite3_shutdown() as long
declare function sqlite3_os_init() as long
declare function sqlite3_os_end() as long
declare function sqlite3_config(byval as long, ...) as long
declare function sqlite3_db_config(byval as sqlite3 ptr, byval op as long, ...) as long

type sqlite3_mem_methods
	xMalloc as function(byval as long) as any ptr
	xFree as sub(byval as any ptr)
	xRealloc as function(byval as any ptr, byval as long) as any ptr
	xSize as function(byval as any ptr) as long
	xRoundup as function(byval as long) as long
	xInit as function(byval as any ptr) as long
	xShutdown as sub(byval as any ptr)
	pAppData as any ptr
end type

const SQLITE_CONFIG_SINGLETHREAD = 1
const SQLITE_CONFIG_MULTITHREAD = 2
const SQLITE_CONFIG_SERIALIZED = 3
const SQLITE_CONFIG_MALLOC = 4
const SQLITE_CONFIG_GETMALLOC = 5
const SQLITE_CONFIG_SCRATCH = 6
const SQLITE_CONFIG_PAGECACHE = 7
const SQLITE_CONFIG_HEAP = 8
const SQLITE_CONFIG_MEMSTATUS = 9
const SQLITE_CONFIG_MUTEX = 10
const SQLITE_CONFIG_GETMUTEX = 11
const SQLITE_CONFIG_LOOKASIDE = 13
const SQLITE_CONFIG_PCACHE = 14
const SQLITE_CONFIG_GETPCACHE = 15
const SQLITE_CONFIG_LOG = 16
const SQLITE_CONFIG_URI = 17
const SQLITE_CONFIG_PCACHE2 = 18
const SQLITE_CONFIG_GETPCACHE2 = 19
const SQLITE_CONFIG_COVERING_INDEX_SCAN = 20
const SQLITE_CONFIG_SQLLOG = 21
const SQLITE_CONFIG_MMAP_SIZE = 22
const SQLITE_CONFIG_WIN32_HEAPSIZE = 23
const SQLITE_CONFIG_PCACHE_HDRSZ = 24
const SQLITE_CONFIG_PMASZ = 25
const SQLITE_CONFIG_STMTJRNL_SPILL = 26
const SQLITE_CONFIG_SMALL_MALLOC = 27
const SQLITE_CONFIG_SORTERREF_SIZE = 28
const SQLITE_CONFIG_MEMDB_MAXSIZE = 29
const SQLITE_DBCONFIG_MAINDBNAME = 1000
const SQLITE_DBCONFIG_LOOKASIDE = 1001
const SQLITE_DBCONFIG_ENABLE_FKEY = 1002
const SQLITE_DBCONFIG_ENABLE_TRIGGER = 1003
const SQLITE_DBCONFIG_ENABLE_FTS3_TOKENIZER = 1004
const SQLITE_DBCONFIG_ENABLE_LOAD_EXTENSION = 1005
const SQLITE_DBCONFIG_NO_CKPT_ON_CLOSE = 1006
const SQLITE_DBCONFIG_ENABLE_QPSG = 1007
const SQLITE_DBCONFIG_TRIGGER_EQP = 1008
const SQLITE_DBCONFIG_RESET_DATABASE = 1009
const SQLITE_DBCONFIG_DEFENSIVE = 1010
const SQLITE_DBCONFIG_WRITABLE_SCHEMA = 1011
const SQLITE_DBCONFIG_LEGACY_ALTER_TABLE = 1012
const SQLITE_DBCONFIG_DQS_DML = 1013
const SQLITE_DBCONFIG_DQS_DDL = 1014
const SQLITE_DBCONFIG_ENABLE_VIEW = 1015
const SQLITE_DBCONFIG_LEGACY_FILE_FORMAT = 1016
const SQLITE_DBCONFIG_TRUSTED_SCHEMA = 1017
const SQLITE_DBCONFIG_MAX = 1017

declare function sqlite3_extended_result_codes(byval as sqlite3 ptr, byval onoff as long) as long
declare function sqlite3_last_insert_rowid(byval as sqlite3 ptr) as sqlite3_int64
declare sub sqlite3_set_last_insert_rowid(byval as sqlite3 ptr, byval as sqlite3_int64)
declare function sqlite3_changes(byval as sqlite3 ptr) as long
declare function sqlite3_total_changes(byval as sqlite3 ptr) as long
declare sub sqlite3_interrupt(byval as sqlite3 ptr)
declare function sqlite3_complete(byval sql as const zstring ptr) as long
declare function sqlite3_complete16(byval sql as const any ptr) as long
declare function sqlite3_busy_handler(byval as sqlite3 ptr, byval as function(byval as any ptr, byval as long) as long, byval as any ptr) as long
declare function sqlite3_busy_timeout(byval as sqlite3 ptr, byval ms as long) as long
declare function sqlite3_get_table(byval db as sqlite3 ptr, byval zSql as const zstring ptr, byval pazResult as zstring ptr ptr ptr, byval pnRow as long ptr, byval pnColumn as long ptr, byval pzErrmsg as zstring ptr ptr) as long
declare sub sqlite3_free_table(byval result as zstring ptr ptr)
declare function sqlite3_mprintf(byval as const zstring ptr, ...) as zstring ptr
declare function sqlite3_vmprintf(byval as const zstring ptr, byval as va_list) as zstring ptr
declare function sqlite3_snprintf(byval as long, byval as zstring ptr, byval as const zstring ptr, ...) as zstring ptr
declare function sqlite3_vsnprintf(byval as long, byval as zstring ptr, byval as const zstring ptr, byval as va_list) as zstring ptr
declare function sqlite3_malloc(byval as long) as any ptr
declare function sqlite3_malloc64(byval as sqlite3_uint64) as any ptr
declare function sqlite3_realloc(byval as any ptr, byval as long) as any ptr
declare function sqlite3_realloc64(byval as any ptr, byval as sqlite3_uint64) as any ptr
declare sub sqlite3_free(byval as any ptr)
declare function sqlite3_msize(byval as any ptr) as sqlite3_uint64
declare function sqlite3_memory_used() as sqlite3_int64
declare function sqlite3_memory_highwater(byval resetFlag as long) as sqlite3_int64
declare sub sqlite3_randomness(byval N as long, byval P as any ptr)
declare function sqlite3_set_authorizer(byval as sqlite3 ptr, byval xAuth as function(byval as any ptr, byval as long, byval as const zstring ptr, byval as const zstring ptr, byval as const zstring ptr, byval as const zstring ptr) as long, byval pUserData as any ptr) as long

const SQLITE_DENY = 1
const SQLITE_IGNORE = 2
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
const SQLITE_ALTER_TABLE = 26
const SQLITE_REINDEX = 27
const SQLITE_ANALYZE = 28
const SQLITE_CREATE_VTABLE = 29
const SQLITE_DROP_VTABLE = 30
const SQLITE_FUNCTION = 31
const SQLITE_SAVEPOINT = 32
const SQLITE_COPY = 0
const SQLITE_RECURSIVE = 33
declare function sqlite3_trace(byval as sqlite3 ptr, byval xTrace as sub(byval as any ptr, byval as const zstring ptr), byval as any ptr) as any ptr
declare function sqlite3_profile(byval as sqlite3 ptr, byval xProfile as sub(byval as any ptr, byval as const zstring ptr, byval as sqlite3_uint64), byval as any ptr) as any ptr
const SQLITE_TRACE_STMT = &h01
const SQLITE_TRACE_PROFILE = &h02
const SQLITE_TRACE_ROW = &h04
const SQLITE_TRACE_CLOSE = &h08

declare function sqlite3_trace_v2(byval as sqlite3 ptr, byval uMask as ulong, byval xCallback as function(byval as ulong, byval as any ptr, byval as any ptr, byval as any ptr) as long, byval pCtx as any ptr) as long
declare sub sqlite3_progress_handler(byval as sqlite3 ptr, byval as long, byval as function(byval as any ptr) as long, byval as any ptr)
declare function sqlite3_open(byval filename as const zstring ptr, byval ppDb as sqlite3 ptr ptr) as long
declare function sqlite3_open16(byval filename as const any ptr, byval ppDb as sqlite3 ptr ptr) as long
declare function sqlite3_open_v2(byval filename as const zstring ptr, byval ppDb as sqlite3 ptr ptr, byval flags as long, byval zVfs as const zstring ptr) as long
declare function sqlite3_uri_parameter(byval zFilename as const zstring ptr, byval zParam as const zstring ptr) as const zstring ptr
declare function sqlite3_uri_boolean(byval zFile as const zstring ptr, byval zParam as const zstring ptr, byval bDefault as long) as long
declare function sqlite3_uri_int64(byval as const zstring ptr, byval as const zstring ptr, byval as sqlite3_int64) as sqlite3_int64
declare function sqlite3_uri_key(byval zFilename as const zstring ptr, byval N as long) as const zstring ptr
declare function sqlite3_filename_database(byval as const zstring ptr) as const zstring ptr
declare function sqlite3_filename_journal(byval as const zstring ptr) as const zstring ptr
declare function sqlite3_filename_wal(byval as const zstring ptr) as const zstring ptr
declare function sqlite3_database_file_object(byval as const zstring ptr) as sqlite3_file ptr
declare function sqlite3_create_filename(byval zDatabase as const zstring ptr, byval zJournal as const zstring ptr, byval zWal as const zstring ptr, byval nParam as long, byval azParam as const zstring ptr ptr) as zstring ptr
declare sub sqlite3_free_filename(byval as zstring ptr)
declare function sqlite3_errcode(byval db as sqlite3 ptr) as long
declare function sqlite3_extended_errcode(byval db as sqlite3 ptr) as long
declare function sqlite3_errmsg(byval as sqlite3 ptr) as const zstring ptr
declare function sqlite3_errmsg16(byval as sqlite3 ptr) as const any ptr
declare function sqlite3_errstr(byval as long) as const zstring ptr
declare function sqlite3_limit(byval as sqlite3 ptr, byval id as long, byval newVal as long) as long

const SQLITE_LIMIT_LENGTH = 0
const SQLITE_LIMIT_SQL_LENGTH = 1
const SQLITE_LIMIT_COLUMN = 2
const SQLITE_LIMIT_EXPR_DEPTH = 3
const SQLITE_LIMIT_COMPOUND_SELECT = 4
const SQLITE_LIMIT_VDBE_OP = 5
const SQLITE_LIMIT_FUNCTION_ARG = 6
const SQLITE_LIMIT_ATTACHED = 7
const SQLITE_LIMIT_LIKE_PATTERN_LENGTH = 8
const SQLITE_LIMIT_VARIABLE_NUMBER = 9
const SQLITE_LIMIT_TRIGGER_DEPTH = 10
const SQLITE_LIMIT_WORKER_THREADS = 11
const SQLITE_PREPARE_PERSISTENT = &h01
const SQLITE_PREPARE_NORMALIZE = &h02
const SQLITE_PREPARE_NO_VTAB = &h04
type sqlite3_stmt as sqlite3_stmt_

declare function sqlite3_prepare(byval db as sqlite3 ptr, byval zSql as const zstring ptr, byval nByte as long, byval ppStmt as sqlite3_stmt ptr ptr, byval pzTail as const zstring ptr ptr) as long
declare function sqlite3_prepare_v2(byval db as sqlite3 ptr, byval zSql as const zstring ptr, byval nByte as long, byval ppStmt as sqlite3_stmt ptr ptr, byval pzTail as const zstring ptr ptr) as long
declare function sqlite3_prepare_v3(byval db as sqlite3 ptr, byval zSql as const zstring ptr, byval nByte as long, byval prepFlags as ulong, byval ppStmt as sqlite3_stmt ptr ptr, byval pzTail as const zstring ptr ptr) as long
declare function sqlite3_prepare16(byval db as sqlite3 ptr, byval zSql as const any ptr, byval nByte as long, byval ppStmt as sqlite3_stmt ptr ptr, byval pzTail as const any ptr ptr) as long
declare function sqlite3_prepare16_v2(byval db as sqlite3 ptr, byval zSql as const any ptr, byval nByte as long, byval ppStmt as sqlite3_stmt ptr ptr, byval pzTail as const any ptr ptr) as long
declare function sqlite3_prepare16_v3(byval db as sqlite3 ptr, byval zSql as const any ptr, byval nByte as long, byval prepFlags as ulong, byval ppStmt as sqlite3_stmt ptr ptr, byval pzTail as const any ptr ptr) as long
declare function sqlite3_sql(byval pStmt as sqlite3_stmt ptr) as const zstring ptr
declare function sqlite3_expanded_sql(byval pStmt as sqlite3_stmt ptr) as zstring ptr
declare function sqlite3_normalized_sql(byval pStmt as sqlite3_stmt ptr) as const zstring ptr
declare function sqlite3_stmt_readonly(byval pStmt as sqlite3_stmt ptr) as long
declare function sqlite3_stmt_isexplain(byval pStmt as sqlite3_stmt ptr) as long
declare function sqlite3_stmt_busy(byval as sqlite3_stmt ptr) as long
declare function sqlite3_bind_blob(byval as sqlite3_stmt ptr, byval as long, byval as const any ptr, byval n as long, byval as sub(byval as any ptr)) as long
declare function sqlite3_bind_blob64(byval as sqlite3_stmt ptr, byval as long, byval as const any ptr, byval as sqlite3_uint64, byval as sub(byval as any ptr)) as long
declare function sqlite3_bind_double(byval as sqlite3_stmt ptr, byval as long, byval as double) as long
declare function sqlite3_bind_int(byval as sqlite3_stmt ptr, byval as long, byval as long) as long
declare function sqlite3_bind_int64(byval as sqlite3_stmt ptr, byval as long, byval as sqlite3_int64) as long
declare function sqlite3_bind_null(byval as sqlite3_stmt ptr, byval as long) as long
declare function sqlite3_bind_text(byval as sqlite3_stmt ptr, byval as long, byval as const zstring ptr, byval as long, byval as sub(byval as any ptr)) as long
declare function sqlite3_bind_text16(byval as sqlite3_stmt ptr, byval as long, byval as const any ptr, byval as long, byval as sub(byval as any ptr)) as long
declare function sqlite3_bind_text64(byval as sqlite3_stmt ptr, byval as long, byval as const zstring ptr, byval as sqlite3_uint64, byval as sub(byval as any ptr), byval encoding as ubyte) as long
type sqlite3_value as sqlite3_value_
declare function sqlite3_bind_value(byval as sqlite3_stmt ptr, byval as long, byval as const sqlite3_value ptr) as long
declare function sqlite3_bind_pointer(byval as sqlite3_stmt ptr, byval as long, byval as any ptr, byval as const zstring ptr, byval as sub(byval as any ptr)) as long
declare function sqlite3_bind_zeroblob(byval as sqlite3_stmt ptr, byval as long, byval n as long) as long
declare function sqlite3_bind_zeroblob64(byval as sqlite3_stmt ptr, byval as long, byval as sqlite3_uint64) as long
declare function sqlite3_bind_parameter_count(byval as sqlite3_stmt ptr) as long
declare function sqlite3_bind_parameter_name(byval as sqlite3_stmt ptr, byval as long) as const zstring ptr
declare function sqlite3_bind_parameter_index(byval as sqlite3_stmt ptr, byval zName as const zstring ptr) as long
declare function sqlite3_clear_bindings(byval as sqlite3_stmt ptr) as long
declare function sqlite3_column_count(byval pStmt as sqlite3_stmt ptr) as long
declare function sqlite3_column_name(byval as sqlite3_stmt ptr, byval N as long) as const zstring ptr
declare function sqlite3_column_name16(byval as sqlite3_stmt ptr, byval N as long) as const any ptr
declare function sqlite3_column_database_name(byval as sqlite3_stmt ptr, byval as long) as const zstring ptr
declare function sqlite3_column_database_name16(byval as sqlite3_stmt ptr, byval as long) as const any ptr
declare function sqlite3_column_table_name(byval as sqlite3_stmt ptr, byval as long) as const zstring ptr
declare function sqlite3_column_table_name16(byval as sqlite3_stmt ptr, byval as long) as const any ptr
declare function sqlite3_column_origin_name(byval as sqlite3_stmt ptr, byval as long) as const zstring ptr
declare function sqlite3_column_origin_name16(byval as sqlite3_stmt ptr, byval as long) as const any ptr
declare function sqlite3_column_decltype(byval as sqlite3_stmt ptr, byval as long) as const zstring ptr
declare function sqlite3_column_decltype16(byval as sqlite3_stmt ptr, byval as long) as const any ptr
declare function sqlite3_step(byval as sqlite3_stmt ptr) as long
declare function sqlite3_data_count(byval pStmt as sqlite3_stmt ptr) as long

const SQLITE_INTEGER = 1
const SQLITE_FLOAT = 2
const SQLITE_BLOB = 4
const SQLITE_NULL = 5
const SQLITE_TEXT = 3
const SQLITE3_TEXT = 3

declare function sqlite3_column_blob(byval as sqlite3_stmt ptr, byval iCol as long) as const any ptr
declare function sqlite3_column_double(byval as sqlite3_stmt ptr, byval iCol as long) as double
declare function sqlite3_column_int(byval as sqlite3_stmt ptr, byval iCol as long) as long
declare function sqlite3_column_int64(byval as sqlite3_stmt ptr, byval iCol as long) as sqlite3_int64
declare function sqlite3_column_text(byval as sqlite3_stmt ptr, byval iCol as long) as const ubyte ptr
declare function sqlite3_column_text16(byval as sqlite3_stmt ptr, byval iCol as long) as const any ptr
declare function sqlite3_column_value(byval as sqlite3_stmt ptr, byval iCol as long) as sqlite3_value ptr
declare function sqlite3_column_bytes(byval as sqlite3_stmt ptr, byval iCol as long) as long
declare function sqlite3_column_bytes16(byval as sqlite3_stmt ptr, byval iCol as long) as long
declare function sqlite3_column_type(byval as sqlite3_stmt ptr, byval iCol as long) as long
declare function sqlite3_finalize(byval pStmt as sqlite3_stmt ptr) as long
declare function sqlite3_reset(byval pStmt as sqlite3_stmt ptr) as long
type sqlite3_context as sqlite3_context_
declare function sqlite3_create_function(byval db as sqlite3 ptr, byval zFunctionName as const zstring ptr, byval nArg as long, byval eTextRep as long, byval pApp as any ptr, byval xFunc as sub(byval as sqlite3_context ptr, byval as long, byval as sqlite3_value ptr ptr), byval xStep as sub(byval as sqlite3_context ptr, byval as long, byval as sqlite3_value ptr ptr), byval xFinal as sub(byval as sqlite3_context ptr)) as long
declare function sqlite3_create_function16(byval db as sqlite3 ptr, byval zFunctionName as const any ptr, byval nArg as long, byval eTextRep as long, byval pApp as any ptr, byval xFunc as sub(byval as sqlite3_context ptr, byval as long, byval as sqlite3_value ptr ptr), byval xStep as sub(byval as sqlite3_context ptr, byval as long, byval as sqlite3_value ptr ptr), byval xFinal as sub(byval as sqlite3_context ptr)) as long
declare function sqlite3_create_function_v2(byval db as sqlite3 ptr, byval zFunctionName as const zstring ptr, byval nArg as long, byval eTextRep as long, byval pApp as any ptr, byval xFunc as sub(byval as sqlite3_context ptr, byval as long, byval as sqlite3_value ptr ptr), byval xStep as sub(byval as sqlite3_context ptr, byval as long, byval as sqlite3_value ptr ptr), byval xFinal as sub(byval as sqlite3_context ptr), byval xDestroy as sub(byval as any ptr)) as long
declare function sqlite3_create_window_function(byval db as sqlite3 ptr, byval zFunctionName as const zstring ptr, byval nArg as long, byval eTextRep as long, byval pApp as any ptr, byval xStep as sub(byval as sqlite3_context ptr, byval as long, byval as sqlite3_value ptr ptr), byval xFinal as sub(byval as sqlite3_context ptr), byval xValue as sub(byval as sqlite3_context ptr), byval xInverse as sub(byval as sqlite3_context ptr, byval as long, byval as sqlite3_value ptr ptr), byval xDestroy as sub(byval as any ptr)) as long

const SQLITE_UTF8 = 1
const SQLITE_UTF16LE = 2
const SQLITE_UTF16BE = 3
const SQLITE_UTF16 = 4
const SQLITE_ANY = 5
const SQLITE_UTF16_ALIGNED = 8
const SQLITE_DETERMINISTIC = &h000000800
const SQLITE_DIRECTONLY = &h000080000
const SQLITE_SUBTYPE = &h000100000
const SQLITE_INNOCUOUS = &h000200000

declare function sqlite3_aggregate_count(byval as sqlite3_context ptr) as long
declare function sqlite3_expired(byval as sqlite3_stmt ptr) as long
declare function sqlite3_transfer_bindings(byval as sqlite3_stmt ptr, byval as sqlite3_stmt ptr) as long
declare function sqlite3_global_recover() as long
declare sub sqlite3_thread_cleanup()
declare function sqlite3_memory_alarm(byval as sub(byval as any ptr, byval as sqlite3_int64, byval as long), byval as any ptr, byval as sqlite3_int64) as long
declare function sqlite3_value_blob(byval as sqlite3_value ptr) as const any ptr
declare function sqlite3_value_double(byval as sqlite3_value ptr) as double
declare function sqlite3_value_int(byval as sqlite3_value ptr) as long
declare function sqlite3_value_int64(byval as sqlite3_value ptr) as sqlite3_int64
declare function sqlite3_value_pointer(byval as sqlite3_value ptr, byval as const zstring ptr) as any ptr
declare function sqlite3_value_text(byval as sqlite3_value ptr) as const ubyte ptr
declare function sqlite3_value_text16(byval as sqlite3_value ptr) as const any ptr
declare function sqlite3_value_text16le(byval as sqlite3_value ptr) as const any ptr
declare function sqlite3_value_text16be(byval as sqlite3_value ptr) as const any ptr
declare function sqlite3_value_bytes(byval as sqlite3_value ptr) as long
declare function sqlite3_value_bytes16(byval as sqlite3_value ptr) as long
declare function sqlite3_value_type(byval as sqlite3_value ptr) as long
declare function sqlite3_value_numeric_type(byval as sqlite3_value ptr) as long
declare function sqlite3_value_nochange(byval as sqlite3_value ptr) as long
declare function sqlite3_value_frombind(byval as sqlite3_value ptr) as long
declare function sqlite3_value_subtype(byval as sqlite3_value ptr) as ulong
declare function sqlite3_value_dup(byval as const sqlite3_value ptr) as sqlite3_value ptr
declare sub sqlite3_value_free(byval as sqlite3_value ptr)
declare function sqlite3_aggregate_context(byval as sqlite3_context ptr, byval nBytes as long) as any ptr
declare function sqlite3_user_data(byval as sqlite3_context ptr) as any ptr
declare function sqlite3_context_db_handle(byval as sqlite3_context ptr) as sqlite3 ptr
declare function sqlite3_get_auxdata(byval as sqlite3_context ptr, byval N as long) as any ptr
declare sub sqlite3_set_auxdata(byval as sqlite3_context ptr, byval N as long, byval as any ptr, byval as sub(byval as any ptr))
type sqlite3_destructor_type as sub(byval as any ptr)
const SQLITE_STATIC = cast(sqlite3_destructor_type, 0)
const SQLITE_TRANSIENT = cast(sqlite3_destructor_type, -1)
declare sub sqlite3_result_blob(byval as sqlite3_context ptr, byval as const any ptr, byval as long, byval as sub(byval as any ptr))
declare sub sqlite3_result_blob64(byval as sqlite3_context ptr, byval as const any ptr, byval as sqlite3_uint64, byval as sub(byval as any ptr))
declare sub sqlite3_result_double(byval as sqlite3_context ptr, byval as double)
declare sub sqlite3_result_error(byval as sqlite3_context ptr, byval as const zstring ptr, byval as long)
declare sub sqlite3_result_error16(byval as sqlite3_context ptr, byval as const any ptr, byval as long)
declare sub sqlite3_result_error_toobig(byval as sqlite3_context ptr)
declare sub sqlite3_result_error_nomem(byval as sqlite3_context ptr)
declare sub sqlite3_result_error_code(byval as sqlite3_context ptr, byval as long)
declare sub sqlite3_result_int(byval as sqlite3_context ptr, byval as long)
declare sub sqlite3_result_int64(byval as sqlite3_context ptr, byval as sqlite3_int64)
declare sub sqlite3_result_null(byval as sqlite3_context ptr)
declare sub sqlite3_result_text(byval as sqlite3_context ptr, byval as const zstring ptr, byval as long, byval as sub(byval as any ptr))
declare sub sqlite3_result_text64(byval as sqlite3_context ptr, byval as const zstring ptr, byval as sqlite3_uint64, byval as sub(byval as any ptr), byval encoding as ubyte)
declare sub sqlite3_result_text16(byval as sqlite3_context ptr, byval as const any ptr, byval as long, byval as sub(byval as any ptr))
declare sub sqlite3_result_text16le(byval as sqlite3_context ptr, byval as const any ptr, byval as long, byval as sub(byval as any ptr))
declare sub sqlite3_result_text16be(byval as sqlite3_context ptr, byval as const any ptr, byval as long, byval as sub(byval as any ptr))
declare sub sqlite3_result_value(byval as sqlite3_context ptr, byval as sqlite3_value ptr)
declare sub sqlite3_result_pointer(byval as sqlite3_context ptr, byval as any ptr, byval as const zstring ptr, byval as sub(byval as any ptr))
declare sub sqlite3_result_zeroblob(byval as sqlite3_context ptr, byval n as long)
declare function sqlite3_result_zeroblob64(byval as sqlite3_context ptr, byval n as sqlite3_uint64) as long
declare sub sqlite3_result_subtype(byval as sqlite3_context ptr, byval as ulong)
declare function sqlite3_create_collation(byval as sqlite3 ptr, byval zName as const zstring ptr, byval eTextRep as long, byval pArg as any ptr, byval xCompare as function(byval as any ptr, byval as long, byval as const any ptr, byval as long, byval as const any ptr) as long) as long
declare function sqlite3_create_collation_v2(byval as sqlite3 ptr, byval zName as const zstring ptr, byval eTextRep as long, byval pArg as any ptr, byval xCompare as function(byval as any ptr, byval as long, byval as const any ptr, byval as long, byval as const any ptr) as long, byval xDestroy as sub(byval as any ptr)) as long
declare function sqlite3_create_collation16(byval as sqlite3 ptr, byval zName as const any ptr, byval eTextRep as long, byval pArg as any ptr, byval xCompare as function(byval as any ptr, byval as long, byval as const any ptr, byval as long, byval as const any ptr) as long) as long
declare function sqlite3_collation_needed(byval as sqlite3 ptr, byval as any ptr, byval as sub(byval as any ptr, byval as sqlite3 ptr, byval eTextRep as long, byval as const zstring ptr)) as long
declare function sqlite3_collation_needed16(byval as sqlite3 ptr, byval as any ptr, byval as sub(byval as any ptr, byval as sqlite3 ptr, byval eTextRep as long, byval as const any ptr)) as long
declare function sqlite3_sleep(byval as long) as long
extern sqlite3_temp_directory as zstring ptr
extern sqlite3_data_directory as zstring ptr
declare function sqlite3_win32_set_directory(byval type as culong, byval zValue as any ptr) as long
declare function sqlite3_win32_set_directory8(byval type as culong, byval zValue as const zstring ptr) as long
declare function sqlite3_win32_set_directory16(byval type as culong, byval zValue as const any ptr) as long
const SQLITE_WIN32_DATA_DIRECTORY_TYPE = 1
const SQLITE_WIN32_TEMP_DIRECTORY_TYPE = 2
declare function sqlite3_get_autocommit(byval as sqlite3 ptr) as long
declare function sqlite3_db_handle(byval as sqlite3_stmt ptr) as sqlite3 ptr
declare function sqlite3_db_filename(byval db as sqlite3 ptr, byval zDbName as const zstring ptr) as const zstring ptr
declare function sqlite3_db_readonly(byval db as sqlite3 ptr, byval zDbName as const zstring ptr) as long
declare function sqlite3_txn_state(byval as sqlite3 ptr, byval zSchema as const zstring ptr) as long

const SQLITE_TXN_NONE = 0
const SQLITE_TXN_READ = 1
const SQLITE_TXN_WRITE = 2

declare function sqlite3_next_stmt(byval pDb as sqlite3 ptr, byval pStmt as sqlite3_stmt ptr) as sqlite3_stmt ptr
declare function sqlite3_commit_hook(byval as sqlite3 ptr, byval as function(byval as any ptr) as long, byval as any ptr) as any ptr
declare function sqlite3_rollback_hook(byval as sqlite3 ptr, byval as sub(byval as any ptr), byval as any ptr) as any ptr
declare function sqlite3_update_hook(byval as sqlite3 ptr, byval as sub(byval as any ptr, byval as long, byval as const zstring ptr, byval as const zstring ptr, byval as sqlite3_int64), byval as any ptr) as any ptr
declare function sqlite3_enable_shared_cache(byval as long) as long
declare function sqlite3_release_memory(byval as long) as long
declare function sqlite3_db_release_memory(byval as sqlite3 ptr) as long
declare function sqlite3_soft_heap_limit64(byval N as sqlite3_int64) as sqlite3_int64
declare function sqlite3_hard_heap_limit64(byval N as sqlite3_int64) as sqlite3_int64
declare sub sqlite3_soft_heap_limit(byval N as long)
declare function sqlite3_table_column_metadata(byval db as sqlite3 ptr, byval zDbName as const zstring ptr, byval zTableName as const zstring ptr, byval zColumnName as const zstring ptr, byval pzDataType as const zstring ptr ptr, byval pzCollSeq as const zstring ptr ptr, byval pNotNull as long ptr, byval pPrimaryKey as long ptr, byval pAutoinc as long ptr) as long
declare function sqlite3_load_extension(byval db as sqlite3 ptr, byval zFile as const zstring ptr, byval zProc as const zstring ptr, byval pzErrMsg as zstring ptr ptr) as long
declare function sqlite3_enable_load_extension(byval db as sqlite3 ptr, byval onoff as long) as long
declare function sqlite3_auto_extension(byval xEntryPoint as sub()) as long
declare function sqlite3_cancel_auto_extension(byval xEntryPoint as sub()) as long
declare sub sqlite3_reset_auto_extension()

type sqlite3_vtab as sqlite3_vtab_
type sqlite3_index_info as sqlite3_index_info_
type sqlite3_vtab_cursor as sqlite3_vtab_cursor_

type sqlite3_module
	iVersion as long
	xCreate as function(byval as sqlite3 ptr, byval pAux as any ptr, byval argc as long, byval argv as const zstring const ptr ptr, byval ppVTab as sqlite3_vtab ptr ptr, byval as zstring ptr ptr) as long
	xConnect as function(byval as sqlite3 ptr, byval pAux as any ptr, byval argc as long, byval argv as const zstring const ptr ptr, byval ppVTab as sqlite3_vtab ptr ptr, byval as zstring ptr ptr) as long
	xBestIndex as function(byval pVTab as sqlite3_vtab ptr, byval as sqlite3_index_info ptr) as long
	xDisconnect as function(byval pVTab as sqlite3_vtab ptr) as long
	xDestroy as function(byval pVTab as sqlite3_vtab ptr) as long
	xOpen as function(byval pVTab as sqlite3_vtab ptr, byval ppCursor as sqlite3_vtab_cursor ptr ptr) as long
	xClose as function(byval as sqlite3_vtab_cursor ptr) as long
	xFilter as function(byval as sqlite3_vtab_cursor ptr, byval idxNum as long, byval idxStr as const zstring ptr, byval argc as long, byval argv as sqlite3_value ptr ptr) as long
	xNext as function(byval as sqlite3_vtab_cursor ptr) as long
	xEof as function(byval as sqlite3_vtab_cursor ptr) as long
	xColumn as function(byval as sqlite3_vtab_cursor ptr, byval as sqlite3_context ptr, byval as long) as long
	xRowid as function(byval as sqlite3_vtab_cursor ptr, byval pRowid as sqlite3_int64 ptr) as long
	xUpdate as function(byval as sqlite3_vtab ptr, byval as long, byval as sqlite3_value ptr ptr, byval as sqlite3_int64 ptr) as long
	xBegin as function(byval pVTab as sqlite3_vtab ptr) as long
	xSync as function(byval pVTab as sqlite3_vtab ptr) as long
	xCommit as function(byval pVTab as sqlite3_vtab ptr) as long
	xRollback as function(byval pVTab as sqlite3_vtab ptr) as long
	xFindFunction as function(byval pVtab as sqlite3_vtab ptr, byval nArg as long, byval zName as const zstring ptr, byval pxFunc as typeof(sub(byval as sqlite3_context ptr, byval as long, byval as sqlite3_value ptr ptr)) ptr, byval ppArg as any ptr ptr) as long
	xRename as function(byval pVtab as sqlite3_vtab ptr, byval zNew as const zstring ptr) as long
	xSavepoint as function(byval pVTab as sqlite3_vtab ptr, byval as long) as long
	xRelease as function(byval pVTab as sqlite3_vtab ptr, byval as long) as long
	xRollbackTo as function(byval pVTab as sqlite3_vtab ptr, byval as long) as long
	xShadowName as function(byval as const zstring ptr) as long
end type

type sqlite3_index_constraint
	iColumn as long
	op as ubyte
	usable as ubyte
	iTermOffset as long
end type

type sqlite3_index_orderby
	iColumn as long
	desc as ubyte
end type

type sqlite3_index_constraint_usage
	argvIndex as long
	omit as ubyte
end type

type sqlite3_index_info_
	nConstraint as long
	aConstraint as sqlite3_index_constraint ptr
	nOrderBy as long
	aOrderBy as sqlite3_index_orderby ptr
	aConstraintUsage as sqlite3_index_constraint_usage ptr
	idxNum as long
	idxStr as zstring ptr
	needToFreeIdxStr as long
	orderByConsumed as long
	estimatedCost as double
	estimatedRows as sqlite3_int64
	idxFlags as long
	colUsed as sqlite3_uint64
end type

const SQLITE_INDEX_SCAN_UNIQUE = 1
const SQLITE_INDEX_CONSTRAINT_EQ = 2
const SQLITE_INDEX_CONSTRAINT_GT = 4
const SQLITE_INDEX_CONSTRAINT_LE = 8
const SQLITE_INDEX_CONSTRAINT_LT = 16
const SQLITE_INDEX_CONSTRAINT_GE = 32
const SQLITE_INDEX_CONSTRAINT_MATCH = 64
const SQLITE_INDEX_CONSTRAINT_LIKE = 65
const SQLITE_INDEX_CONSTRAINT_GLOB = 66
const SQLITE_INDEX_CONSTRAINT_REGEXP = 67
const SQLITE_INDEX_CONSTRAINT_NE = 68
const SQLITE_INDEX_CONSTRAINT_ISNOT = 69
const SQLITE_INDEX_CONSTRAINT_ISNOTNULL = 70
const SQLITE_INDEX_CONSTRAINT_ISNULL = 71
const SQLITE_INDEX_CONSTRAINT_IS = 72
const SQLITE_INDEX_CONSTRAINT_FUNCTION = 150

declare function sqlite3_create_module(byval db as sqlite3 ptr, byval zName as const zstring ptr, byval p as const sqlite3_module ptr, byval pClientData as any ptr) as long
declare function sqlite3_create_module_v2(byval db as sqlite3 ptr, byval zName as const zstring ptr, byval p as const sqlite3_module ptr, byval pClientData as any ptr, byval xDestroy as sub(byval as any ptr)) as long
declare function sqlite3_drop_modules(byval db as sqlite3 ptr, byval azKeep as const zstring ptr ptr) as long

type sqlite3_vtab_
	pModule as const sqlite3_module ptr
	nRef as long
	zErrMsg as zstring ptr
end type

type sqlite3_vtab_cursor_
	pVtab as sqlite3_vtab ptr
end type

declare function sqlite3_declare_vtab(byval as sqlite3 ptr, byval zSQL as const zstring ptr) as long
declare function sqlite3_overload_function(byval as sqlite3 ptr, byval zFuncName as const zstring ptr, byval nArg as long) as long
type sqlite3_blob as sqlite3_blob_
declare function sqlite3_blob_open(byval as sqlite3 ptr, byval zDb as const zstring ptr, byval zTable as const zstring ptr, byval zColumn as const zstring ptr, byval iRow as sqlite3_int64, byval flags as long, byval ppBlob as sqlite3_blob ptr ptr) as long
declare function sqlite3_blob_reopen(byval as sqlite3_blob ptr, byval as sqlite3_int64) as long
declare function sqlite3_blob_close(byval as sqlite3_blob ptr) as long
declare function sqlite3_blob_bytes(byval as sqlite3_blob ptr) as long
declare function sqlite3_blob_read(byval as sqlite3_blob ptr, byval Z as any ptr, byval N as long, byval iOffset as long) as long
declare function sqlite3_blob_write(byval as sqlite3_blob ptr, byval z as const any ptr, byval n as long, byval iOffset as long) as long
declare function sqlite3_vfs_find(byval zVfsName as const zstring ptr) as sqlite3_vfs ptr
declare function sqlite3_vfs_register(byval as sqlite3_vfs ptr, byval makeDflt as long) as long
declare function sqlite3_vfs_unregister(byval as sqlite3_vfs ptr) as long
type sqlite3_mutex as sqlite3_mutex_
declare function sqlite3_mutex_alloc(byval as long) as sqlite3_mutex ptr
declare sub sqlite3_mutex_free(byval as sqlite3_mutex ptr)
declare sub sqlite3_mutex_enter(byval as sqlite3_mutex ptr)
declare function sqlite3_mutex_try(byval as sqlite3_mutex ptr) as long
declare sub sqlite3_mutex_leave(byval as sqlite3_mutex ptr)

type sqlite3_mutex_methods
	xMutexInit as function() as long
	xMutexEnd as function() as long
	xMutexAlloc as function(byval as long) as sqlite3_mutex ptr
	xMutexFree as sub(byval as sqlite3_mutex ptr)
	xMutexEnter as sub(byval as sqlite3_mutex ptr)
	xMutexTry as function(byval as sqlite3_mutex ptr) as long
	xMutexLeave as sub(byval as sqlite3_mutex ptr)
	xMutexHeld as function(byval as sqlite3_mutex ptr) as long
	xMutexNotheld as function(byval as sqlite3_mutex ptr) as long
end type

declare function sqlite3_mutex_held(byval as sqlite3_mutex ptr) as long
declare function sqlite3_mutex_notheld(byval as sqlite3_mutex ptr) as long
const SQLITE_MUTEX_FAST = 0
const SQLITE_MUTEX_RECURSIVE = 1
const SQLITE_MUTEX_STATIC_MAIN = 2
const SQLITE_MUTEX_STATIC_MEM = 3
const SQLITE_MUTEX_STATIC_MEM2 = 4
const SQLITE_MUTEX_STATIC_OPEN = 4
const SQLITE_MUTEX_STATIC_PRNG = 5
const SQLITE_MUTEX_STATIC_LRU = 6
const SQLITE_MUTEX_STATIC_LRU2 = 7
const SQLITE_MUTEX_STATIC_PMEM = 7
const SQLITE_MUTEX_STATIC_APP1 = 8
const SQLITE_MUTEX_STATIC_APP2 = 9
const SQLITE_MUTEX_STATIC_APP3 = 10
const SQLITE_MUTEX_STATIC_VFS1 = 11
const SQLITE_MUTEX_STATIC_VFS2 = 12
const SQLITE_MUTEX_STATIC_VFS3 = 13
const SQLITE_MUTEX_STATIC_MASTER = 2

declare function sqlite3_db_mutex(byval as sqlite3 ptr) as sqlite3_mutex ptr
declare function sqlite3_file_control(byval as sqlite3 ptr, byval zDbName as const zstring ptr, byval op as long, byval as any ptr) as long
declare function sqlite3_test_control(byval op as long, ...) as long

const SQLITE_TESTCTRL_FIRST = 5
const SQLITE_TESTCTRL_PRNG_SAVE = 5
const SQLITE_TESTCTRL_PRNG_RESTORE = 6
const SQLITE_TESTCTRL_PRNG_RESET = 7
const SQLITE_TESTCTRL_BITVEC_TEST = 8
const SQLITE_TESTCTRL_FAULT_INSTALL = 9
const SQLITE_TESTCTRL_BENIGN_MALLOC_HOOKS = 10
const SQLITE_TESTCTRL_PENDING_BYTE = 11
const SQLITE_TESTCTRL_ASSERT = 12
const SQLITE_TESTCTRL_ALWAYS = 13
const SQLITE_TESTCTRL_RESERVE = 14
const SQLITE_TESTCTRL_OPTIMIZATIONS = 15
const SQLITE_TESTCTRL_ISKEYWORD = 16
const SQLITE_TESTCTRL_SCRATCHMALLOC = 17
const SQLITE_TESTCTRL_INTERNAL_FUNCTIONS = 17
const SQLITE_TESTCTRL_LOCALTIME_FAULT = 18
const SQLITE_TESTCTRL_EXPLAIN_STMT = 19
const SQLITE_TESTCTRL_ONCE_RESET_THRESHOLD = 19
const SQLITE_TESTCTRL_NEVER_CORRUPT = 20
const SQLITE_TESTCTRL_VDBE_COVERAGE = 21
const SQLITE_TESTCTRL_BYTEORDER = 22
const SQLITE_TESTCTRL_ISINIT = 23
const SQLITE_TESTCTRL_SORTER_MMAP = 24
const SQLITE_TESTCTRL_IMPOSTER = 25
const SQLITE_TESTCTRL_PARSER_COVERAGE = 26
const SQLITE_TESTCTRL_RESULT_INTREAL = 27
const SQLITE_TESTCTRL_PRNG_SEED = 28
const SQLITE_TESTCTRL_EXTRA_SCHEMA_CHECKS = 29
const SQLITE_TESTCTRL_SEEK_COUNT = 30
const SQLITE_TESTCTRL_LAST = 30

declare function sqlite3_keyword_count() as long
declare function sqlite3_keyword_name(byval as long, byval as const zstring ptr ptr, byval as long ptr) as long
declare function sqlite3_keyword_check(byval as const zstring ptr, byval as long) as long
type sqlite3_str as sqlite3_str_
declare function sqlite3_str_new(byval as sqlite3 ptr) as sqlite3_str ptr
declare function sqlite3_str_finish(byval as sqlite3_str ptr) as zstring ptr
declare sub sqlite3_str_appendf(byval as sqlite3_str ptr, byval zFormat as const zstring ptr, ...)
declare sub sqlite3_str_vappendf(byval as sqlite3_str ptr, byval zFormat as const zstring ptr, byval as va_list)
declare sub sqlite3_str_append(byval as sqlite3_str ptr, byval zIn as const zstring ptr, byval N as long)
declare sub sqlite3_str_appendall(byval as sqlite3_str ptr, byval zIn as const zstring ptr)
declare sub sqlite3_str_appendchar(byval as sqlite3_str ptr, byval N as long, byval C as byte)
declare sub sqlite3_str_reset(byval as sqlite3_str ptr)
declare function sqlite3_str_errcode(byval as sqlite3_str ptr) as long
declare function sqlite3_str_length(byval as sqlite3_str ptr) as long
declare function sqlite3_str_value(byval as sqlite3_str ptr) as zstring ptr
declare function sqlite3_status(byval op as long, byval pCurrent as long ptr, byval pHighwater as long ptr, byval resetFlag as long) as long
declare function sqlite3_status64(byval op as long, byval pCurrent as sqlite3_int64 ptr, byval pHighwater as sqlite3_int64 ptr, byval resetFlag as long) as long

const SQLITE_STATUS_MEMORY_USED = 0
const SQLITE_STATUS_PAGECACHE_USED = 1
const SQLITE_STATUS_PAGECACHE_OVERFLOW = 2
const SQLITE_STATUS_SCRATCH_USED = 3
const SQLITE_STATUS_SCRATCH_OVERFLOW = 4
const SQLITE_STATUS_MALLOC_SIZE = 5
const SQLITE_STATUS_PARSER_STACK = 6
const SQLITE_STATUS_PAGECACHE_SIZE = 7
const SQLITE_STATUS_SCRATCH_SIZE = 8
const SQLITE_STATUS_MALLOC_COUNT = 9
declare function sqlite3_db_status(byval as sqlite3 ptr, byval op as long, byval pCur as long ptr, byval pHiwtr as long ptr, byval resetFlg as long) as long
const SQLITE_DBSTATUS_LOOKASIDE_USED = 0
const SQLITE_DBSTATUS_CACHE_USED = 1
const SQLITE_DBSTATUS_SCHEMA_USED = 2
const SQLITE_DBSTATUS_STMT_USED = 3
const SQLITE_DBSTATUS_LOOKASIDE_HIT = 4
const SQLITE_DBSTATUS_LOOKASIDE_MISS_SIZE = 5
const SQLITE_DBSTATUS_LOOKASIDE_MISS_FULL = 6
const SQLITE_DBSTATUS_CACHE_HIT = 7
const SQLITE_DBSTATUS_CACHE_MISS = 8
const SQLITE_DBSTATUS_CACHE_WRITE = 9
const SQLITE_DBSTATUS_DEFERRED_FKS = 10
const SQLITE_DBSTATUS_CACHE_USED_SHARED = 11
const SQLITE_DBSTATUS_CACHE_SPILL = 12
const SQLITE_DBSTATUS_MAX = 12
declare function sqlite3_stmt_status(byval as sqlite3_stmt ptr, byval op as long, byval resetFlg as long) as long
const SQLITE_STMTSTATUS_FULLSCAN_STEP = 1
const SQLITE_STMTSTATUS_SORT = 2
const SQLITE_STMTSTATUS_AUTOINDEX = 3
const SQLITE_STMTSTATUS_VM_STEP = 4
const SQLITE_STMTSTATUS_REPREPARE = 5
const SQLITE_STMTSTATUS_RUN = 6
const SQLITE_STMTSTATUS_MEMUSED = 99

type sqlite3_pcache_page
	pBuf as any ptr
	pExtra as any ptr
end type

type sqlite3_pcache as sqlite3_pcache_

type sqlite3_pcache_methods2
	iVersion as long
	pArg as any ptr
	xInit as function(byval as any ptr) as long
	xShutdown as sub(byval as any ptr)
	xCreate as function(byval szPage as long, byval szExtra as long, byval bPurgeable as long) as sqlite3_pcache ptr
	xCachesize as sub(byval as sqlite3_pcache ptr, byval nCachesize as long)
	xPagecount as function(byval as sqlite3_pcache ptr) as long
	xFetch as function(byval as sqlite3_pcache ptr, byval key as ulong, byval createFlag as long) as sqlite3_pcache_page ptr
	xUnpin as sub(byval as sqlite3_pcache ptr, byval as sqlite3_pcache_page ptr, byval discard as long)
	xRekey as sub(byval as sqlite3_pcache ptr, byval as sqlite3_pcache_page ptr, byval oldKey as ulong, byval newKey as ulong)
	xTruncate as sub(byval as sqlite3_pcache ptr, byval iLimit as ulong)
	xDestroy as sub(byval as sqlite3_pcache ptr)
	xShrink as sub(byval as sqlite3_pcache ptr)
end type

type sqlite3_pcache_methods
	pArg as any ptr
	xInit as function(byval as any ptr) as long
	xShutdown as sub(byval as any ptr)
	xCreate as function(byval szPage as long, byval bPurgeable as long) as sqlite3_pcache ptr
	xCachesize as sub(byval as sqlite3_pcache ptr, byval nCachesize as long)
	xPagecount as function(byval as sqlite3_pcache ptr) as long
	xFetch as function(byval as sqlite3_pcache ptr, byval key as ulong, byval createFlag as long) as any ptr
	xUnpin as sub(byval as sqlite3_pcache ptr, byval as any ptr, byval discard as long)
	xRekey as sub(byval as sqlite3_pcache ptr, byval as any ptr, byval oldKey as ulong, byval newKey as ulong)
	xTruncate as sub(byval as sqlite3_pcache ptr, byval iLimit as ulong)
	xDestroy as sub(byval as sqlite3_pcache ptr)
end type

type sqlite3_backup as sqlite3_backup_
declare function sqlite3_backup_init(byval pDest as sqlite3 ptr, byval zDestName as const zstring ptr, byval pSource as sqlite3 ptr, byval zSourceName as const zstring ptr) as sqlite3_backup ptr
declare function sqlite3_backup_step(byval p as sqlite3_backup ptr, byval nPage as long) as long
declare function sqlite3_backup_finish(byval p as sqlite3_backup ptr) as long
declare function sqlite3_backup_remaining(byval p as sqlite3_backup ptr) as long
declare function sqlite3_backup_pagecount(byval p as sqlite3_backup ptr) as long
declare function sqlite3_unlock_notify(byval pBlocked as sqlite3 ptr, byval xNotify as sub(byval apArg as any ptr ptr, byval nArg as long), byval pNotifyArg as any ptr) as long
declare function sqlite3_stricmp(byval as const zstring ptr, byval as const zstring ptr) as long
declare function sqlite3_strnicmp(byval as const zstring ptr, byval as const zstring ptr, byval as long) as long
declare function sqlite3_strglob(byval zGlob as const zstring ptr, byval zStr as const zstring ptr) as long
declare function sqlite3_strlike(byval zGlob as const zstring ptr, byval zStr as const zstring ptr, byval cEsc as ulong) as long
declare sub sqlite3_log(byval iErrCode as long, byval zFormat as const zstring ptr, ...)
declare function sqlite3_wal_hook(byval as sqlite3 ptr, byval as function(byval as any ptr, byval as sqlite3 ptr, byval as const zstring ptr, byval as long) as long, byval as any ptr) as any ptr
declare function sqlite3_wal_autocheckpoint(byval db as sqlite3 ptr, byval N as long) as long
declare function sqlite3_wal_checkpoint(byval db as sqlite3 ptr, byval zDb as const zstring ptr) as long
declare function sqlite3_wal_checkpoint_v2(byval db as sqlite3 ptr, byval zDb as const zstring ptr, byval eMode as long, byval pnLog as long ptr, byval pnCkpt as long ptr) as long

const SQLITE_CHECKPOINT_PASSIVE = 0
const SQLITE_CHECKPOINT_FULL = 1
const SQLITE_CHECKPOINT_RESTART = 2
const SQLITE_CHECKPOINT_TRUNCATE = 3
declare function sqlite3_vtab_config(byval as sqlite3 ptr, byval op as long, ...) as long
const SQLITE_VTAB_CONSTRAINT_SUPPORT = 1
const SQLITE_VTAB_INNOCUOUS = 2
const SQLITE_VTAB_DIRECTONLY = 3

declare function sqlite3_vtab_on_conflict(byval as sqlite3 ptr) as long
declare function sqlite3_vtab_nochange(byval as sqlite3_context ptr) as long
declare function sqlite3_vtab_collation(byval as sqlite3_index_info ptr, byval as long) as const zstring ptr

const SQLITE_ROLLBACK = 1
const SQLITE_FAIL = 3
const SQLITE_REPLACE = 5
const SQLITE_SCANSTAT_NLOOP = 0
const SQLITE_SCANSTAT_NVISIT = 1
const SQLITE_SCANSTAT_EST = 2
const SQLITE_SCANSTAT_NAME = 3
const SQLITE_SCANSTAT_EXPLAIN = 4
const SQLITE_SCANSTAT_SELECTID = 5

declare function sqlite3_stmt_scanstatus(byval pStmt as sqlite3_stmt ptr, byval idx as long, byval iScanStatusOp as long, byval pOut as any ptr) as long
declare sub sqlite3_stmt_scanstatus_reset(byval as sqlite3_stmt ptr)
declare function sqlite3_db_cacheflush(byval as sqlite3 ptr) as long
declare function sqlite3_system_errno(byval as sqlite3 ptr) as long

type sqlite3_snapshot
	hidden(0 to 47) as ubyte
end type

declare function sqlite3_snapshot_get(byval db as sqlite3 ptr, byval zSchema as const zstring ptr, byval ppSnapshot as sqlite3_snapshot ptr ptr) as long
declare function sqlite3_snapshot_open(byval db as sqlite3 ptr, byval zSchema as const zstring ptr, byval pSnapshot as sqlite3_snapshot ptr) as long
declare sub sqlite3_snapshot_free(byval as sqlite3_snapshot ptr)
declare function sqlite3_snapshot_cmp(byval p1 as sqlite3_snapshot ptr, byval p2 as sqlite3_snapshot ptr) as long
declare function sqlite3_snapshot_recover(byval db as sqlite3 ptr, byval zDb as const zstring ptr) as long
declare function sqlite3_serialize(byval db as sqlite3 ptr, byval zSchema as const zstring ptr, byval piSize as sqlite3_int64 ptr, byval mFlags as ulong) as ubyte ptr
const SQLITE_SERIALIZE_NOCOPY = &h001
declare function sqlite3_deserialize(byval db as sqlite3 ptr, byval zSchema as const zstring ptr, byval pData as ubyte ptr, byval szDb as sqlite3_int64, byval szBuf as sqlite3_int64, byval mFlags as ulong) as long

const SQLITE_DESERIALIZE_FREEONCLOSE = 1
const SQLITE_DESERIALIZE_RESIZEABLE = 2
const SQLITE_DESERIALIZE_READONLY = 4
#define _SQLITE3RTREE_H_
type sqlite3_rtree_dbl as double
type sqlite3_rtree_geometry as sqlite3_rtree_geometry_
declare function sqlite3_rtree_geometry_callback(byval db as sqlite3 ptr, byval zGeom as const zstring ptr, byval xGeom as function(byval as sqlite3_rtree_geometry ptr, byval as long, byval as sqlite3_rtree_dbl ptr, byval as long ptr) as long, byval pContext as any ptr) as long

type sqlite3_rtree_geometry_
	pContext as any ptr
	nParam as long
	aParam as sqlite3_rtree_dbl ptr
	pUser as any ptr
	xDelUser as sub(byval as any ptr)
end type

type sqlite3_rtree_query_info as sqlite3_rtree_query_info_
declare function sqlite3_rtree_query_callback(byval db as sqlite3 ptr, byval zQueryFunc as const zstring ptr, byval xQueryFunc as function(byval as sqlite3_rtree_query_info ptr) as long, byval pContext as any ptr, byval xDestructor as sub(byval as any ptr)) as long

type sqlite3_rtree_query_info_
	pContext as any ptr
	nParam as long
	aParam as sqlite3_rtree_dbl ptr
	pUser as any ptr
	xDelUser as sub(byval as any ptr)
	aCoord as sqlite3_rtree_dbl ptr
	anQueue as ulong ptr
	nCoord as long
	iLevel as long
	mxLevel as long
	iRowid as sqlite3_int64
	rParentScore as sqlite3_rtree_dbl
	eParentWithin as long
	eWithin as long
	rScore as sqlite3_rtree_dbl
	apSqlParam as sqlite3_value ptr ptr
end type

const NOT_WITHIN = 0
const PARTLY_WITHIN = 1
const FULLY_WITHIN = 2
#define _FTS5_H

type Fts5ExtensionApi as Fts5ExtensionApi_
type Fts5Context as Fts5Context_
type fts5_extension_function as sub(byval pApi as const Fts5ExtensionApi ptr, byval pFts as Fts5Context ptr, byval pCtx as sqlite3_context ptr, byval nVal as long, byval apVal as sqlite3_value ptr ptr)

type Fts5PhraseIter
	a as const ubyte ptr
	b as const ubyte ptr
end type

type Fts5ExtensionApi_
	iVersion as long
	xUserData as function(byval as Fts5Context ptr) as any ptr
	xColumnCount as function(byval as Fts5Context ptr) as long
	xRowCount as function(byval as Fts5Context ptr, byval pnRow as sqlite3_int64 ptr) as long
	xColumnTotalSize as function(byval as Fts5Context ptr, byval iCol as long, byval pnToken as sqlite3_int64 ptr) as long
	xTokenize as function(byval as Fts5Context ptr, byval pText as const zstring ptr, byval nText as long, byval pCtx as any ptr, byval xToken as function(byval as any ptr, byval as long, byval as const zstring ptr, byval as long, byval as long, byval as long) as long) as long
	xPhraseCount as function(byval as Fts5Context ptr) as long
	xPhraseSize as function(byval as Fts5Context ptr, byval iPhrase as long) as long
	xInstCount as function(byval as Fts5Context ptr, byval pnInst as long ptr) as long
	xInst as function(byval as Fts5Context ptr, byval iIdx as long, byval piPhrase as long ptr, byval piCol as long ptr, byval piOff as long ptr) as long
	xRowid as function(byval as Fts5Context ptr) as sqlite3_int64
	xColumnText as function(byval as Fts5Context ptr, byval iCol as long, byval pz as const zstring ptr ptr, byval pn as long ptr) as long
	xColumnSize as function(byval as Fts5Context ptr, byval iCol as long, byval pnToken as long ptr) as long
	xQueryPhrase as function(byval as Fts5Context ptr, byval iPhrase as long, byval pUserData as any ptr, byval as function(byval as const Fts5ExtensionApi ptr, byval as Fts5Context ptr, byval as any ptr) as long) as long
	xSetAuxdata as function(byval as Fts5Context ptr, byval pAux as any ptr, byval xDelete as sub(byval as any ptr)) as long
	xGetAuxdata as function(byval as Fts5Context ptr, byval bClear as long) as any ptr
	xPhraseFirst as function(byval as Fts5Context ptr, byval iPhrase as long, byval as Fts5PhraseIter ptr, byval as long ptr, byval as long ptr) as long
	xPhraseNext as sub(byval as Fts5Context ptr, byval as Fts5PhraseIter ptr, byval piCol as long ptr, byval piOff as long ptr)
	xPhraseFirstColumn as function(byval as Fts5Context ptr, byval iPhrase as long, byval as Fts5PhraseIter ptr, byval as long ptr) as long
	xPhraseNextColumn as sub(byval as Fts5Context ptr, byval as Fts5PhraseIter ptr, byval piCol as long ptr)
end type

type Fts5Tokenizer as Fts5Tokenizer_

type fts5_tokenizer
	xCreate as function(byval as any ptr, byval azArg as const zstring ptr ptr, byval nArg as long, byval ppOut as Fts5Tokenizer ptr ptr) as long
	xDelete as sub(byval as Fts5Tokenizer ptr)
	xTokenize as function(byval as Fts5Tokenizer ptr, byval pCtx as any ptr, byval flags as long, byval pText as const zstring ptr, byval nText as long, byval xToken as function(byval pCtx as any ptr, byval tflags as long, byval pToken as const zstring ptr, byval nToken as long, byval iStart as long, byval iEnd as long) as long) as long
end type

const FTS5_TOKENIZE_QUERY = &h0001
const FTS5_TOKENIZE_PREFIX = &h0002
const FTS5_TOKENIZE_DOCUMENT = &h0004
const FTS5_TOKENIZE_AUX = &h0008
const FTS5_TOKEN_COLOCATED = &h0001

type fts5_api
	iVersion as long
	xCreateTokenizer as function(byval pApi as fts5_api ptr, byval zName as const zstring ptr, byval pContext as any ptr, byval pTokenizer as fts5_tokenizer ptr, byval xDestroy as sub(byval as any ptr)) as long
	xFindTokenizer as function(byval pApi as fts5_api ptr, byval zName as const zstring ptr, byval ppContext as any ptr ptr, byval pTokenizer as fts5_tokenizer ptr) as long
	xCreateFunction as function(byval pApi as fts5_api ptr, byval zName as const zstring ptr, byval pContext as any ptr, byval xFunction as fts5_extension_function, byval xDestroy as sub(byval as any ptr)) as long
end type

end extern
