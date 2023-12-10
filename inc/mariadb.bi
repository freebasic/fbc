'' FreeBASIC binding for mariadb-connector-c-3.3.1
''
'' based on the C header files:
''   Copyright (C) 2000 MySQL AB & MySQL Finland AB & TCX DataKonsult AB
''                 2012 by MontyProgram AB
''
''   This library is free software; you can redistribute it and/or
''   modify it under the terms of the GNU Library General Public
''   License as published by the Free Software Foundation; either
''   version 2 of the License, or (at your option) any later version.
''
''   This library is distributed in the hope that it will be useful,
''   but WITHOUT ANY WARRANTY; without even the implied warranty of
''   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
''   Library General Public License for more details.
''
''   You should have received a copy of the GNU Library General Public
''   License along with this library; if not, write to the Free
''   Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
''   MA 02111-1301, USA 
''
'' translated to FreeBASIC by:
''   FreeBASIC development team

#pragma once

#inclib "mariadb"

#ifdef __FB_WIN32__
	#inclib "kernel32"
#endif

#include once "crt/long.bi"
#include once "crt/stdarg.bi"
#include once "crt/sys/types.bi"
#include once "crt/ctype.bi"

'' The following symbols have been renamed:
''     #define CHARSET_DIR => CHARSET_DIR_
''     variable mysql_port => mysql_port_

#ifdef __FB_UNIX__
	extern "C"
#else
	extern "Windows"
#endif

#define _mysql_h
#define LIBMARIADB
#define MYSQL_CLIENT
type my_bool as zstring
type my_ulonglong as ulongint
#define my_socket_defined

#ifdef __FB_UNIX__
	type my_socket as long
#elseif defined(__FB_WIN32__) and (not defined(__FB_64BIT__))
	type my_socket as ulong
#else
	type my_socket as ulongint
#endif

#define _mysql_com_h
const NAME_CHAR_LEN = 64
const NAME_LEN = 256
const HOSTNAME_LENGTH = 255
const SYSTEM_MB_MAX_CHAR_LENGTH = 4
const USERNAME_CHAR_LENGTH = 128
const USERNAME_LENGTH = USERNAME_CHAR_LENGTH * SYSTEM_MB_MAX_CHAR_LENGTH
const SERVER_VERSION_LENGTH = 60
const SQLSTATE_LENGTH = 5
const SCRAMBLE_LENGTH = 20
const SCRAMBLE_LENGTH_323 = 8
#define LOCAL_HOST "localhost"
#define LOCAL_HOST_NAMEDPIPE "."

#ifdef __FB_WIN32__
	#define MARIADB_NAMEDPIPE "MySQL"
	#define MYSQL_SERVICENAME "MySql"
#endif

#define MYSQL_AUTODETECT_CHARSET_NAME "auto"
const BINCMP_FLAG = 131072

type mysql_enum_shutdown_level as long
enum
	SHUTDOWN_DEFAULT = 0
	KILL_QUERY = 254
	KILL_CONNECTION = 255
end enum

type enum_server_command as long
enum
	COM_SLEEP = 0
	COM_QUIT
	COM_INIT_DB
	COM_QUERY
	COM_FIELD_LIST
	COM_CREATE_DB
	COM_DROP_DB
	COM_REFRESH
	COM_SHUTDOWN
	COM_STATISTICS
	COM_PROCESS_INFO
	COM_CONNECT
	COM_PROCESS_KILL
	COM_DEBUG
	COM_PING
	COM_TIME = 15
	COM_DELAYED_INSERT
	COM_CHANGE_USER
	COM_BINLOG_DUMP
	COM_TABLE_DUMP
	COM_CONNECT_OUT = 20
	COM_REGISTER_SLAVE
	COM_STMT_PREPARE = 22
	COM_STMT_EXECUTE = 23
	COM_STMT_SEND_LONG_DATA = 24
	COM_STMT_CLOSE = 25
	COM_STMT_RESET = 26
	COM_SET_OPTION = 27
	COM_STMT_FETCH = 28
	COM_DAEMON = 29
	COM_UNSUPPORTED = 30
	COM_RESET_CONNECTION = 31
	COM_STMT_BULK_EXECUTE = 250
	COM_RESERVED_1 = 254
	COM_END
end enum

const NOT_NULL_FLAG = 1
const PRI_KEY_FLAG = 2
const UNIQUE_KEY_FLAG = 4
const MULTIPLE_KEY_FLAG = 8
const BLOB_FLAG = 16
const UNSIGNED_FLAG = 32
const ZEROFILL_FLAG = 64
const BINARY_FLAG = 128
const ENUM_FLAG = 256
const AUTO_INCREMENT_FLAG = 512
const TIMESTAMP_FLAG = 1024
const SET_FLAG = 2048
const NO_DEFAULT_VALUE_FLAG = 4096
const ON_UPDATE_NOW_FLAG = 8192
const NUM_FLAG = 32768
const PART_KEY_FLAG = 16384
const GROUP_FLAG = 32768
const UNIQUE_FLAG = 65536
const REFRESH_GRANT = 1
const REFRESH_LOG = 2
const REFRESH_TABLES = 4
const REFRESH_HOSTS = 8
const REFRESH_STATUS = 16
const REFRESH_THREADS = 32
const REFRESH_SLAVE = 64
const REFRESH_MASTER = 128
const REFRESH_READ_LOCK = 16384
const REFRESH_FAST = 32768
const CLIENT_MYSQL = 1
const CLIENT_FOUND_ROWS = 2
const CLIENT_LONG_FLAG = 4
const CLIENT_CONNECT_WITH_DB = 8
const CLIENT_NO_SCHEMA = 16
const CLIENT_COMPRESS = 32
const CLIENT_ODBC = 64
const CLIENT_LOCAL_FILES = 128
const CLIENT_IGNORE_SPACE = 256
const CLIENT_INTERACTIVE = 1024
const CLIENT_SSL = 2048
const CLIENT_IGNORE_SIGPIPE = 4096
const CLIENT_TRANSACTIONS = 8192
const CLIENT_PROTOCOL_41 = 512
const CLIENT_RESERVED = 16384
const CLIENT_SECURE_CONNECTION = 32768
const CLIENT_MULTI_STATEMENTS = cast(culong, 1) shl 16
const CLIENT_MULTI_RESULTS = cast(culong, 1) shl 17
const CLIENT_PS_MULTI_RESULTS = cast(culong, 1) shl 18
const CLIENT_PLUGIN_AUTH = cast(culong, 1) shl 19
const CLIENT_CONNECT_ATTRS = cast(culong, 1) shl 20
const CLIENT_PLUGIN_AUTH_LENENC_CLIENT_DATA = cast(culong, 1) shl 21
const CLIENT_CAN_HANDLE_EXPIRED_PASSWORDS = cast(culong, 1) shl 22
const CLIENT_SESSION_TRACKING = cast(culong, 1) shl 23
const CLIENT_ZSTD_COMPRESSION = cast(culong, 1) shl 26
const CLIENT_PROGRESS = cast(culong, 1) shl 29
const CLIENT_PROGRESS_OBSOLETE = CLIENT_PROGRESS
const CLIENT_SSL_VERIFY_SERVER_CERT = cast(culong, 1) shl 30
const CLIENT_REMEMBER_OPTIONS = cast(culong, 1) shl 31
const MARIADB_CLIENT_FLAGS = &hFFFFFFFF00000000ull
const MARIADB_CLIENT_PROGRESS = 1ull shl 32
const MARIADB_CLIENT_RESERVED_1 = 1ull shl 33
const MARIADB_CLIENT_STMT_BULK_OPERATIONS = 1ull shl 34
const MARIADB_CLIENT_EXTENDED_METADATA = 1ull shl 35
const MARIADB_CLIENT_CACHE_METADATA = 1ull shl 36
#define IS_MARIADB_EXTENDED_SERVER(mysql) ((mysql->server_capabilities and CLIENT_MYSQL) = 0)
const MARIADB_CLIENT_SUPPORTED_FLAGS = ((MARIADB_CLIENT_PROGRESS or MARIADB_CLIENT_STMT_BULK_OPERATIONS) or MARIADB_CLIENT_EXTENDED_METADATA) or MARIADB_CLIENT_CACHE_METADATA
const CLIENT_SUPPORTED_FLAGS = ((((((((((((((((((((((CLIENT_MYSQL or CLIENT_FOUND_ROWS) or CLIENT_LONG_FLAG) or CLIENT_CONNECT_WITH_DB) or CLIENT_NO_SCHEMA) or CLIENT_COMPRESS) or CLIENT_ODBC) or CLIENT_LOCAL_FILES) or CLIENT_IGNORE_SPACE) or CLIENT_INTERACTIVE) or CLIENT_SSL) or CLIENT_IGNORE_SIGPIPE) or CLIENT_TRANSACTIONS) or CLIENT_PROTOCOL_41) or CLIENT_RESERVED) or CLIENT_SECURE_CONNECTION) or CLIENT_MULTI_STATEMENTS) or CLIENT_MULTI_RESULTS) or CLIENT_PROGRESS) or CLIENT_SSL_VERIFY_SERVER_CERT) or CLIENT_REMEMBER_OPTIONS) or CLIENT_PLUGIN_AUTH) or CLIENT_SESSION_TRACKING) or CLIENT_CONNECT_ATTRS
const CLIENT_CAPABILITIES = (((((((((CLIENT_MYSQL or CLIENT_LONG_FLAG) or CLIENT_TRANSACTIONS) or CLIENT_SECURE_CONNECTION) or CLIENT_MULTI_RESULTS) or CLIENT_PS_MULTI_RESULTS) or CLIENT_PROTOCOL_41) or CLIENT_PLUGIN_AUTH) or CLIENT_PLUGIN_AUTH_LENENC_CLIENT_DATA) or CLIENT_SESSION_TRACKING) or CLIENT_CONNECT_ATTRS
const CLIENT_DEFAULT_FLAGS = (CLIENT_SUPPORTED_FLAGS and (not CLIENT_COMPRESS)) and (not CLIENT_SSL)
const SERVER_STATUS_IN_TRANS = 1
const SERVER_STATUS_AUTOCOMMIT = 2
const SERVER_MORE_RESULTS_EXIST = 8
const SERVER_QUERY_NO_GOOD_INDEX_USED = 16
const SERVER_QUERY_NO_INDEX_USED = 32
const SERVER_STATUS_CURSOR_EXISTS = 64
const SERVER_STATUS_LAST_ROW_SENT = 128
const SERVER_STATUS_DB_DROPPED = 256
const SERVER_STATUS_NO_BACKSLASH_ESCAPES = 512
const SERVER_STATUS_METADATA_CHANGED = 1024
const SERVER_QUERY_WAS_SLOW = 2048
const SERVER_PS_OUT_PARAMS = 4096
const SERVER_STATUS_IN_TRANS_READONLY = 8192
const SERVER_SESSION_STATE_CHANGED = 16384
const SERVER_STATUS_ANSI_QUOTES = 32768
const MYSQL_ERRMSG_SIZE = 512
const NET_READ_TIMEOUT = 30
const NET_WRITE_TIMEOUT = 60
const NET_WAIT_TIMEOUT = (8 * 60) * 60
const LIST_PROCESS_HOST_LEN = 64
#define MYSQL50_TABLE_NAME_PREFIX "#mysql50#"
#define MYSQL50_TABLE_NAME_PREFIX_LENGTH (sizeof(MYSQL50_TABLE_NAME_PREFIX) - 1)
#define SAFE_NAME_LEN (NAME_LEN + MYSQL50_TABLE_NAME_PREFIX_LENGTH)
type MARIADB_PVIO as st_ma_pvio
const MAX_CHAR_WIDTH = 255
const MAX_BLOB_WIDTH = 8192
const MAX_TINYINT_WIDTH = 3
const MAX_SMALLINT_WIDTH = 5
const MAX_MEDIUMINT_WIDTH = 8
const MAX_INT_WIDTH = 10
const MAX_BIGINT_WIDTH = 20
type st_mariadb_net_extension as st_mariadb_net_extension_

type st_net
	pvio as MARIADB_PVIO ptr
	buff as ubyte ptr
	buff_end as ubyte ptr
	write_pos as ubyte ptr
	read_pos as ubyte ptr

	#ifdef __FB_UNIX__
		fd as my_socket
	#elseif defined(__FB_WIN32__) and (not defined(__FB_64BIT__))
		fd as ulong
	#else
		fd as ulongint
	#endif

	remain_in_buf as culong
	length as culong
	buf_length as culong
	where_b as culong
	max_packet as culong
	max_packet_size as culong
	pkt_nr as ulong
	compress_pkt_nr as ulong
	write_timeout as ulong
	read_timeout as ulong
	retry_count as ulong
	fcntl as long
	return_status as ulong ptr
	reading_or_writing as ubyte
	save_char as byte
	unused_1 as byte
	unused_2 as byte
	compress as byte
	unused_3 as byte
	unused_4 as any ptr
	last_errno as ulong
	error as ubyte
	unused_5 as byte
	unused_6 as byte
	last_error as zstring * 512
	sqlstate as zstring * 5 + 1
	extension as st_mariadb_net_extension ptr
end type

type NET as st_net
const packet_error = culng(-1)

type enum_mysql_set_option as long
enum
	MYSQL_OPTION_MULTI_STATEMENTS_ON
	MYSQL_OPTION_MULTI_STATEMENTS_OFF
end enum

type enum_session_state_type as long
enum
	SESSION_TRACK_SYSTEM_VARIABLES = 0
	SESSION_TRACK_SCHEMA
	SESSION_TRACK_STATE_CHANGE
	SESSION_TRACK_GTIDS
	SESSION_TRACK_TRANSACTION_CHARACTERISTICS
	SESSION_TRACK_TRANSACTION_STATE
end enum

const SESSION_TRACK_BEGIN = 0
const SESSION_TRACK_END = SESSION_TRACK_TRANSACTION_STATE
const SESSION_TRACK_TYPES = SESSION_TRACK_END + 1
const SESSION_TRACK_TRANSACTION_TYPE = SESSION_TRACK_TRANSACTION_STATE

type enum_field_types as long
enum
	MYSQL_TYPE_DECIMAL
	MYSQL_TYPE_TINY
	MYSQL_TYPE_SHORT
	MYSQL_TYPE_LONG
	MYSQL_TYPE_FLOAT
	MYSQL_TYPE_DOUBLE
	MYSQL_TYPE_NULL
	MYSQL_TYPE_TIMESTAMP
	MYSQL_TYPE_LONGLONG
	MYSQL_TYPE_INT24
	MYSQL_TYPE_DATE
	MYSQL_TYPE_TIME
	MYSQL_TYPE_DATETIME
	MYSQL_TYPE_YEAR
	MYSQL_TYPE_NEWDATE
	MYSQL_TYPE_VARCHAR
	MYSQL_TYPE_BIT
	MYSQL_TYPE_TIMESTAMP2
	MYSQL_TYPE_DATETIME2
	MYSQL_TYPE_TIME2
	MYSQL_TYPE_JSON = 245
	MYSQL_TYPE_NEWDECIMAL = 246
	MYSQL_TYPE_ENUM = 247
	MYSQL_TYPE_SET = 248
	MYSQL_TYPE_TINY_BLOB = 249
	MYSQL_TYPE_MEDIUM_BLOB = 250
	MYSQL_TYPE_LONG_BLOB = 251
	MYSQL_TYPE_BLOB = 252
	MYSQL_TYPE_VAR_STRING = 253
	MYSQL_TYPE_STRING = 254
	MYSQL_TYPE_GEOMETRY = 255
	MAX_NO_FIELD_TYPES
end enum

const FIELD_TYPE_DECIMAL = MYSQL_TYPE_DECIMAL
const FIELD_TYPE_NEWDECIMAL = MYSQL_TYPE_NEWDECIMAL
const FIELD_TYPE_TINY = MYSQL_TYPE_TINY
const FIELD_TYPE_CHAR = FIELD_TYPE_TINY
const FIELD_TYPE_SHORT = MYSQL_TYPE_SHORT
const FIELD_TYPE_LONG = MYSQL_TYPE_LONG
const FIELD_TYPE_FLOAT = MYSQL_TYPE_FLOAT
const FIELD_TYPE_DOUBLE = MYSQL_TYPE_DOUBLE
const FIELD_TYPE_NULL = MYSQL_TYPE_NULL
const FIELD_TYPE_TIMESTAMP = MYSQL_TYPE_TIMESTAMP
const FIELD_TYPE_LONGLONG = MYSQL_TYPE_LONGLONG
const FIELD_TYPE_INT24 = MYSQL_TYPE_INT24
const FIELD_TYPE_DATE = MYSQL_TYPE_DATE
const FIELD_TYPE_TIME = MYSQL_TYPE_TIME
const FIELD_TYPE_DATETIME = MYSQL_TYPE_DATETIME
const FIELD_TYPE_YEAR = MYSQL_TYPE_YEAR
const FIELD_TYPE_NEWDATE = MYSQL_TYPE_NEWDATE
const FIELD_TYPE_ENUM = MYSQL_TYPE_ENUM
const FIELD_TYPE_INTERVAL = FIELD_TYPE_ENUM
const FIELD_TYPE_SET = MYSQL_TYPE_SET
const FIELD_TYPE_TINY_BLOB = MYSQL_TYPE_TINY_BLOB
const FIELD_TYPE_MEDIUM_BLOB = MYSQL_TYPE_MEDIUM_BLOB
const FIELD_TYPE_LONG_BLOB = MYSQL_TYPE_LONG_BLOB
const FIELD_TYPE_BLOB = MYSQL_TYPE_BLOB
const FIELD_TYPE_VAR_STRING = MYSQL_TYPE_VAR_STRING
const FIELD_TYPE_STRING = MYSQL_TYPE_STRING
const FIELD_TYPE_GEOMETRY = MYSQL_TYPE_GEOMETRY
const FIELD_TYPE_BIT = MYSQL_TYPE_BIT
extern max_allowed_packet as culong
extern net_buffer_length as culong
#define net_new_transaction(net) scope : (net)->pkt_nr = 0 : end scope

declare function ma_net_init cdecl(byval net as NET ptr, byval pvio as MARIADB_PVIO ptr) as long
declare sub ma_net_end cdecl(byval net as NET ptr)
declare sub ma_net_clear cdecl(byval net as NET ptr)
declare function ma_net_flush cdecl(byval net as NET ptr) as long
declare function ma_net_write cdecl(byval net as NET ptr, byval packet as const ubyte ptr, byval len as uinteger) as long
declare function ma_net_write_command cdecl(byval net as NET ptr, byval command as ubyte, byval packet as const zstring ptr, byval len as uinteger, byval disable_flush as byte) as long
declare function ma_net_real_write cdecl(byval net as NET ptr, byval packet as const zstring ptr, byval len as uinteger) as long
declare function ma_net_read cdecl(byval net as NET ptr) as culong

type rand_struct
	seed1 as culong
	seed2 as culong
	max_value as culong
	max_value_dbl as double
end type

type Item_result as long
enum
	STRING_RESULT
	REAL_RESULT
	INT_RESULT
	ROW_RESULT
	DECIMAL_RESULT
end enum

type st_udf_args
	arg_count as ulong
	arg_type as Item_result ptr
	args as zstring ptr ptr
	lengths as culong ptr
	maybe_null as zstring ptr
end type

type UDF_ARGS as st_udf_args

type st_udf_init
	maybe_null as byte
	decimals as ulong
	max_length as ulong
	ptr as zstring ptr
	const_item as byte
end type

type UDF_INIT as st_udf_init
const MARIADB_CONNECTION_UNIXSOCKET = 0
const MARIADB_CONNECTION_TCP = 1
const MARIADB_CONNECTION_NAMEDPIPE = 2
const MARIADB_CONNECTION_SHAREDMEM = 3
const NET_HEADER_SIZE = 4
const COMP_HEADER_SIZE = 3
#define native_password_plugin_name "mysql_native_password"
#define old_password_plugin_name "mysql_old_password"

declare function ma_scramble_323 cdecl(byval to as zstring ptr, byval message as const zstring ptr, byval password as const zstring ptr) as zstring ptr
declare sub ma_scramble_41 cdecl(byval buffer as const ubyte ptr, byval scramble as const zstring ptr, byval password as const zstring ptr)
declare sub ma_hash_password cdecl(byval result as culong ptr, byval password as const zstring ptr, byval len as uinteger)
declare sub ma_make_scrambled_password cdecl(byval to as zstring ptr, byval password as const zstring ptr)
declare sub mariadb_load_defaults cdecl(byval conf_file as const zstring ptr, byval groups as const zstring ptr ptr, byval argc as long ptr, byval argv as zstring ptr ptr ptr)
declare function ma_thread_init cdecl() as byte
declare sub ma_thread_end cdecl()

const NULL_LENGTH = cast(culong, not 0)
#define _mariadb_version_h_
const PROTOCOL_VERSION = 10
#define MARIADB_CLIENT_VERSION_STR "10.6.8"
#define MARIADB_BASE_VERSION "mariadb-10.6"
const MARIADB_VERSION_ID = 100608
const MARIADB_PORT = 3306
#define MARIADB_UNIX_ADDR "/tmp/mysql.sock"
#define MYSQL_UNIX_ADDR MARIADB_UNIX_ADDR
const MYSQL_PORT = MARIADB_PORT
#define MYSQL_CONFIG_NAME "my"
const MYSQL_VERSION_ID = 100608
#define MYSQL_SERVER_VERSION "10.6.8-MariaDB"
#define MARIADB_PACKAGE_VERSION "3.3.1"
const MARIADB_PACKAGE_VERSION_ID = 30301
#define MARIADB_SYSTEM_TYPE "Linux"
#define MARIADB_MACHINE_TYPE "x86_64"
#define MARIADB_PLUGINDIR "/usr/local/lib/mariadb/plugin"
#define MYSQL_CHARSET ""
#define CC_SOURCE_REVISION "5e94e7c27ffad7e76665b1333a67975316b9c3c2"
#define _list_h_

type st_list
	prev as st_list ptr
	next as st_list ptr
	data as any ptr
end type

type LIST as st_list
type list_walk_action as function cdecl(byval as any ptr, byval as any ptr) as long
declare function list_add cdecl(byval root as LIST ptr, byval element as LIST ptr) as LIST ptr
declare function list_delete cdecl(byval root as LIST ptr, byval element as LIST ptr) as LIST ptr
declare function list_cons cdecl(byval data as any ptr, byval root as LIST ptr) as LIST ptr
declare function list_reverse cdecl(byval root as LIST ptr) as LIST ptr
declare sub list_free cdecl(byval root as LIST ptr, byval free_data as ulong)
declare function list_length cdecl(byval list as LIST ptr) as ulong
declare function list_walk cdecl(byval list as LIST ptr, byval action as list_walk_action, byval argument as zstring ptr) as long

#define list_rest(a) (a)->next
#define list_push(a, b) scope : (a) = list_cons((b), (a)) : end scope
#macro list_pop(A)
	scope
		dim old as LIST ptr = (A)
		(A) = list_delete(old, old)
		ma_free(cptr(zstring ptr, old), MYF(MY_FAE))
	end scope
#endmacro
#define _mariadb_ctype_h
#define CHARSET_DIR_ "charsets/"
const MY_CS_NAME_SIZE = 32
#define MADB_DEFAULT_CHARSET_NAME "latin1"
#define MADB_DEFAULT_COLLATION_NAME "latin1_swedish_ci"
#define MADB_AUTODETECT_CHARSET_NAME "auto"

type ma_charset_info_st
	nr as ulong
	state as ulong
	csname as const zstring ptr
	name as const zstring ptr
	dir as const zstring ptr
	codepage as ulong
	encoding as const zstring ptr
	char_minlen as ulong
	char_maxlen as ulong
	mb_charlen as function cdecl(byval c as ulong) as ulong
	mb_valid as function cdecl(byval start as const zstring ptr, byval end as const zstring ptr) as ulong
end type

type MARIADB_CHARSET_INFO as ma_charset_info_st
extern mariadb_compiled_charsets as const MARIADB_CHARSET_INFO ptr
extern ma_default_charset_info as MARIADB_CHARSET_INFO ptr
extern ma_charset_bin as MARIADB_CHARSET_INFO ptr
extern ma_charset_latin1 as MARIADB_CHARSET_INFO ptr
extern ma_charset_utf8_general_ci as MARIADB_CHARSET_INFO ptr
extern ma_charset_utf16le_general_ci as MARIADB_CHARSET_INFO ptr

declare function find_compiled_charset cdecl(byval cs_number as ulong) as MARIADB_CHARSET_INFO ptr
declare function find_compiled_charset_by_name cdecl(byval name as const zstring ptr) as MARIADB_CHARSET_INFO ptr
declare function mysql_cset_escape_quotes cdecl(byval cset as const MARIADB_CHARSET_INFO ptr, byval newstr as zstring ptr, byval escapestr as const zstring ptr, byval escapestr_len as uinteger) as uinteger
declare function mysql_cset_escape_slashes cdecl(byval cset as const MARIADB_CHARSET_INFO ptr, byval newstr as zstring ptr, byval escapestr as const zstring ptr, byval escapestr_len as uinteger) as uinteger
declare function madb_get_os_character_set cdecl() as const zstring ptr

#ifdef __FB_WIN32__
	declare function madb_get_windows_cp cdecl(byval charset as const zstring ptr) as long
#endif

type st_ma_const_string
	str as const zstring ptr
	length as uinteger
end type

type MARIADB_CONST_STRING as st_ma_const_string
#define ST_MA_USED_MEM_DEFINED

type st_ma_used_mem
	next as st_ma_used_mem ptr
	left as uinteger
	size as uinteger
end type

type MA_USED_MEM as st_ma_used_mem

type st_ma_mem_root
	free as MA_USED_MEM ptr
	used as MA_USED_MEM ptr
	pre_alloc as MA_USED_MEM ptr
	min_malloc as uinteger
	block_size as uinteger
	block_num as ulong
	first_block_usage as ulong
	error_handler as sub cdecl()
end type

type MA_MEM_ROOT as st_ma_mem_root
extern mysql_port_ alias "mysql_port" as ulong
extern mysql_unix_port as zstring ptr
extern mariadb_deinitialize_ssl as ulong

#define IS_PRI_KEY(n) ((n) and PRI_KEY_FLAG)
#define IS_NOT_NULL(n) ((n) and NOT_NULL_FLAG)
#define IS_BLOB(n) ((n) and BLOB_FLAG)
#define IS_NUM(t) (((((t) <= MYSQL_TYPE_INT24) andalso ((t) <> MYSQL_TYPE_TIMESTAMP)) orelse ((t) = MYSQL_TYPE_YEAR)) orelse ((t) = MYSQL_TYPE_NEWDECIMAL))
#define IS_NUM_FIELD(f) ((f)->flags and NUM_FLAG)
#define INTERNAL_NUM_FIELD(f) ((((((f)->type <= MYSQL_TYPE_INT24) andalso ((((f)->type <> MYSQL_TYPE_TIMESTAMP) orelse ((f)->length = 14)) orelse ((f)->length = 8))) orelse ((f)->type = MYSQL_TYPE_YEAR)) orelse ((f)->type = MYSQL_TYPE_NEWDECIMAL)) orelse ((f)->type = MYSQL_TYPE_DECIMAL))

type st_mysql_field
	name as zstring ptr
	org_name as zstring ptr
	table as zstring ptr
	org_table as zstring ptr
	db as zstring ptr
	catalog as zstring ptr
	def as zstring ptr
	length as culong
	max_length as culong
	name_length as ulong
	org_name_length as ulong
	table_length as ulong
	org_table_length as ulong
	db_length as ulong
	catalog_length as ulong
	def_length as ulong
	flags as ulong
	decimals as ulong
	charsetnr as ulong
	as enum_field_types type
	extension as any ptr
end type

type MYSQL_FIELD as st_mysql_field
type MYSQL_ROW as zstring ptr ptr
type MYSQL_FIELD_OFFSET as ulong
#macro SET_CLIENT_ERROR(a, b, c, d)
	scope
		(a)->net.last_errno = (b)
		strncpy((a)->net.sqlstate, (c), SQLSTATE_LENGTH)
		(a)->net.sqlstate[SQLSTATE_LENGTH] = 0
		strncpy((a)->net.last_error, iif((d), (d), ER((b))), MYSQL_ERRMSG_SIZE - 1)
		(a)->net.last_error[(MYSQL_ERRMSG_SIZE - 1)] = 0
	end scope
#endmacro
#define set_mariadb_error(A, B, C) SET_CLIENT_ERROR((A), (B), (C), 0)
extern SQLSTATE_UNKNOWN as const zstring ptr
extern unknown_sqlstate alias "SQLSTATE_UNKNOWN" as const zstring ptr
#macro CLEAR_CLIENT_ERROR(a)
	scope
		(a)->net.last_errno = 0
		strcpy((a)->net.sqlstate, "00000")
		(a)->net.last_error[0] = asc(!"\0")
		if (a)->net.extension then
			(a)->net.extension->extended_errno = 0
		end if
	end scope
#endmacro
const MYSQL_COUNT_ERROR = not culngint(0)

type st_mysql_rows
	next as st_mysql_rows ptr
	data as MYSQL_ROW
	length as culong
end type

type MYSQL_ROWS as st_mysql_rows
type MYSQL_ROW_OFFSET as MYSQL_ROWS ptr

type st_mysql_data
	data as MYSQL_ROWS ptr
	embedded_info as any ptr
	alloc as MA_MEM_ROOT
	rows as ulongint
	fields as ulong
	extension as any ptr
end type

type MYSQL_DATA as st_mysql_data

type mysql_option as long
enum
	MYSQL_OPT_CONNECT_TIMEOUT
	MYSQL_OPT_COMPRESS
	MYSQL_OPT_NAMED_PIPE
	MYSQL_INIT_COMMAND
	MYSQL_READ_DEFAULT_FILE
	MYSQL_READ_DEFAULT_GROUP
	MYSQL_SET_CHARSET_DIR
	MYSQL_SET_CHARSET_NAME
	MYSQL_OPT_LOCAL_INFILE
	MYSQL_OPT_PROTOCOL
	MYSQL_SHARED_MEMORY_BASE_NAME
	MYSQL_OPT_READ_TIMEOUT
	MYSQL_OPT_WRITE_TIMEOUT
	MYSQL_OPT_USE_RESULT
	MYSQL_OPT_USE_REMOTE_CONNECTION
	MYSQL_OPT_USE_EMBEDDED_CONNECTION
	MYSQL_OPT_GUESS_CONNECTION
	MYSQL_SET_CLIENT_IP
	MYSQL_SECURE_AUTH
	MYSQL_REPORT_DATA_TRUNCATION
	MYSQL_OPT_RECONNECT
	MYSQL_OPT_SSL_VERIFY_SERVER_CERT
	MYSQL_PLUGIN_DIR
	MYSQL_DEFAULT_AUTH
	MYSQL_OPT_BIND
	MYSQL_OPT_SSL_KEY
	MYSQL_OPT_SSL_CERT
	MYSQL_OPT_SSL_CA
	MYSQL_OPT_SSL_CAPATH
	MYSQL_OPT_SSL_CIPHER
	MYSQL_OPT_SSL_CRL
	MYSQL_OPT_SSL_CRLPATH
	MYSQL_OPT_CONNECT_ATTR_RESET
	MYSQL_OPT_CONNECT_ATTR_ADD
	MYSQL_OPT_CONNECT_ATTR_DELETE
	MYSQL_SERVER_PUBLIC_KEY
	MYSQL_ENABLE_CLEARTEXT_PLUGIN
	MYSQL_OPT_CAN_HANDLE_EXPIRED_PASSWORDS
	MYSQL_OPT_SSL_ENFORCE
	MYSQL_OPT_MAX_ALLOWED_PACKET
	MYSQL_OPT_NET_BUFFER_LENGTH
	MYSQL_OPT_TLS_VERSION
	MYSQL_PROGRESS_CALLBACK = 5999
	MYSQL_OPT_NONBLOCK
	MYSQL_DATABASE_DRIVER = 7000
	MARIADB_OPT_SSL_FP
	MARIADB_OPT_SSL_FP_LIST
	MARIADB_OPT_TLS_PASSPHRASE
	MARIADB_OPT_TLS_CIPHER_STRENGTH
	MARIADB_OPT_TLS_VERSION
	MARIADB_OPT_TLS_PEER_FP
	MARIADB_OPT_TLS_PEER_FP_LIST
	MARIADB_OPT_CONNECTION_READ_ONLY
	MYSQL_OPT_CONNECT_ATTRS
	MARIADB_OPT_USERDATA
	MARIADB_OPT_CONNECTION_HANDLER
	MARIADB_OPT_PORT
	MARIADB_OPT_UNIXSOCKET
	MARIADB_OPT_PASSWORD
	MARIADB_OPT_HOST
	MARIADB_OPT_USER
	MARIADB_OPT_SCHEMA
	MARIADB_OPT_DEBUG
	MARIADB_OPT_FOUND_ROWS
	MARIADB_OPT_MULTI_RESULTS
	MARIADB_OPT_MULTI_STATEMENTS
	MARIADB_OPT_INTERACTIVE
	MARIADB_OPT_PROXY_HEADER
	MARIADB_OPT_IO_WAIT
	MARIADB_OPT_SKIP_READ_RESPONSE
	MARIADB_OPT_RESTRICTED_AUTH
end enum

type mariadb_value as long
enum
	MARIADB_CHARSET_ID
	MARIADB_CHARSET_NAME
	MARIADB_CLIENT_ERRORS
	MARIADB_CLIENT_VERSION
	MARIADB_CLIENT_VERSION_ID
	MARIADB_CONNECTION_ASYNC_TIMEOUT
	MARIADB_CONNECTION_ASYNC_TIMEOUT_MS
	MARIADB_CONNECTION_MARIADB_CHARSET_INFO
	MARIADB_CONNECTION_ERROR
	MARIADB_CONNECTION_ERROR_ID
	MARIADB_CONNECTION_HOST
	MARIADB_CONNECTION_INFO
	MARIADB_CONNECTION_PORT
	MARIADB_CONNECTION_PROTOCOL_VERSION_ID
	MARIADB_CONNECTION_PVIO_TYPE
	MARIADB_CONNECTION_SCHEMA
	MARIADB_CONNECTION_SERVER_TYPE
	MARIADB_CONNECTION_SERVER_VERSION
	MARIADB_CONNECTION_SERVER_VERSION_ID
	MARIADB_CONNECTION_SOCKET
	MARIADB_CONNECTION_SQLSTATE
	MARIADB_CONNECTION_SSL_CIPHER
	MARIADB_TLS_LIBRARY
	MARIADB_CONNECTION_TLS_VERSION
	MARIADB_CONNECTION_TLS_VERSION_ID
	MARIADB_CONNECTION_TYPE
	MARIADB_CONNECTION_UNIX_SOCKET
	MARIADB_CONNECTION_USER
	MARIADB_MAX_ALLOWED_PACKET
	MARIADB_NET_BUFFER_LENGTH
	MARIADB_CONNECTION_SERVER_STATUS
	MARIADB_CONNECTION_SERVER_CAPABILITIES
	MARIADB_CONNECTION_EXTENDED_SERVER_CAPABILITIES
	MARIADB_CONNECTION_CLIENT_CAPABILITIES
	MARIADB_CONNECTION_BYTES_READ
	MARIADB_CONNECTION_BYTES_SENT
end enum

type mysql_status as long
enum
	MYSQL_STATUS_READY
	MYSQL_STATUS_GET_RESULT
	MYSQL_STATUS_USE_RESULT
	MYSQL_STATUS_QUERY_SENT
	MYSQL_STATUS_SENDING_LOAD_DATA
	MYSQL_STATUS_FETCHING_DATA
	MYSQL_STATUS_NEXT_RESULT_PENDING
	MYSQL_STATUS_QUIT_SENT
	MYSQL_STATUS_STMT_RESULT
end enum

type mysql_protocol_type as long
enum
	MYSQL_PROTOCOL_DEFAULT
	MYSQL_PROTOCOL_TCP
	MYSQL_PROTOCOL_SOCKET
	MYSQL_PROTOCOL_PIPE
	MYSQL_PROTOCOL_MEMORY
end enum

type st_dynamic_array as st_dynamic_array_
type st_mysql_options_extension as st_mysql_options_extension_

type st_mysql_options
	connect_timeout as ulong
	read_timeout as ulong
	write_timeout as ulong
	port as ulong
	protocol as ulong
	client_flag as culong
	host as zstring ptr
	user as zstring ptr
	password as zstring ptr
	unix_socket as zstring ptr
	db as zstring ptr
	init_command as st_dynamic_array ptr
	my_cnf_file as zstring ptr
	my_cnf_group as zstring ptr
	charset_dir as zstring ptr
	charset_name as zstring ptr
	ssl_key as zstring ptr
	ssl_cert as zstring ptr
	ssl_ca as zstring ptr
	ssl_capath as zstring ptr
	ssl_cipher as zstring ptr
	shared_memory_base_name as zstring ptr
	max_allowed_packet as culong
	use_ssl as byte
	compress as byte
	named_pipe as byte
	reconnect as byte
	unused_1 as byte
	unused_2 as byte
	unused_3 as byte
	methods_to_use as mysql_option
	bind_address as zstring ptr
	secure_auth as byte
	report_data_truncation as byte
	local_infile_init as function cdecl(byval as any ptr ptr, byval as const zstring ptr, byval as any ptr) as long
	local_infile_read as function cdecl(byval as any ptr, byval as zstring ptr, byval as ulong) as long
	local_infile_end as sub cdecl(byval as any ptr)
	local_infile_error as function cdecl(byval as any ptr, byval as zstring ptr, byval as ulong) as long
	local_infile_userdata as any ptr
	extension as st_mysql_options_extension ptr
end type

type st_mariadb_methods as st_mariadb_methods_
type st_mariadb_extension as st_mariadb_extension_

type st_mysql
	net as NET
	unused_0 as any ptr
	host as zstring ptr
	user as zstring ptr
	passwd as zstring ptr
	unix_socket as zstring ptr
	server_version as zstring ptr
	host_info as zstring ptr
	info as zstring ptr
	db as zstring ptr
	charset as const ma_charset_info_st ptr
	fields as MYSQL_FIELD ptr
	field_alloc as MA_MEM_ROOT
	affected_rows as ulongint
	insert_id as ulongint
	extra_info as ulongint
	thread_id as culong
	packet_length as culong
	port as ulong
	client_flag as culong
	server_capabilities as culong
	protocol_version as ulong
	field_count as ulong
	server_status as ulong
	server_language as ulong
	warning_count as ulong
	options as st_mysql_options
	status as mysql_status
	free_me as byte
	unused_1 as byte
	scramble_buff as zstring * 20 + 1
	unused_2 as byte
	unused_3 as any ptr
	unused_4 as any ptr
	unused_5 as any ptr
	unused_6 as any ptr
	stmts as LIST ptr
	methods as const st_mariadb_methods ptr
	thd as any ptr
	unbuffered_fetch_owner as my_bool ptr
	info_buffer as zstring ptr
	extension as st_mariadb_extension ptr
end type

type MYSQL as st_mysql

type st_mysql_res
	row_count as ulongint
	field_count as ulong
	current_field as ulong
	fields as MYSQL_FIELD ptr
	data as MYSQL_DATA ptr
	data_cursor as MYSQL_ROWS ptr
	field_alloc as MA_MEM_ROOT
	row as MYSQL_ROW
	current_row as MYSQL_ROW
	lengths as culong ptr
	handle as MYSQL ptr
	eof as byte
	is_ps as byte
end type

type MYSQL_RES as st_mysql_res

type MYSQL_PARAMETERS
	p_max_allowed_packet as culong ptr
	p_net_buffer_length as culong ptr
	extension as any ptr
end type

type mariadb_field_attr_t as long
enum
	MARIADB_FIELD_ATTR_DATA_TYPE_NAME = 0
	MARIADB_FIELD_ATTR_FORMAT_NAME = 1
end enum

const MARIADB_FIELD_ATTR_LAST = MARIADB_FIELD_ATTR_FORMAT_NAME
declare function mariadb_field_attr(byval attr as MARIADB_CONST_STRING ptr, byval field as const MYSQL_FIELD ptr, byval type as mariadb_field_attr_t) as long

type enum_mysql_timestamp_type as long
enum
	MYSQL_TIMESTAMP_NONE = -2
	MYSQL_TIMESTAMP_ERROR = -1
	MYSQL_TIMESTAMP_DATE = 0
	MYSQL_TIMESTAMP_DATETIME = 1
	MYSQL_TIMESTAMP_TIME = 2
end enum

type st_mysql_time
	year as ulong
	month as ulong
	day as ulong
	hour as ulong
	minute as ulong
	second as ulong
	second_part as culong
	neg as byte
	time_type as enum_mysql_timestamp_type
end type

type MYSQL_TIME as st_mysql_time
const AUTO_SEC_PART_DIGITS = 39
const SEC_PART_DIGITS = 6
const MARIADB_INVALID_SOCKET = -1
const MYSQL_WAIT_READ = 1
const MYSQL_WAIT_WRITE = 2
const MYSQL_WAIT_EXCEPT = 4
const MYSQL_WAIT_TIMEOUT = 8

type character_set
	number as ulong
	state as ulong
	csname as const zstring ptr
	name as const zstring ptr
	comment as const zstring ptr
	dir as const zstring ptr
	mbminlen as ulong
	mbmaxlen as ulong
end type

type MY_CHARSET_INFO as character_set
const LOCAL_INFILE_ERROR_LEN = 512
const MYSQL_NO_DATA = 100
const MYSQL_DATA_TRUNCATED = 101
const MYSQL_DEFAULT_PREFETCH_ROWS = cast(culong, 1)
const MADB_BIND_DUMMY = 1
#define MARIADB_STMT_BULK_SUPPORTED(stmt) ((stmt)->mysql andalso ((((stmt)->mysql->server_capabilities and CLIENT_MYSQL) = 0) andalso ((stmt)->mysql->extension->mariadb_server_capabilities and (MARIADB_CLIENT_STMT_BULK_OPERATIONS shr 32))))
#macro SET_CLIENT_STMT_ERROR(a, b, c, d)
	scope
		(a)->last_errno = (b)
		strncpy((a)->sqlstate, (c), SQLSTATE_LENGTH)
		(a)->sqlstate[SQLSTATE_LENGTH] = 0
		strncpy((a)->last_error, iif((d), (d), ER((b))), MYSQL_ERRMSG_SIZE)
		(a)->last_error[(MYSQL_ERRMSG_SIZE - 1)] = 0
	end scope
#endmacro
#macro CLEAR_CLIENT_STMT_ERROR(a)
	scope
		(a)->last_errno = 0
		strcpy((a)->sqlstate, "00000")
		(a)->last_error[0] = 0
	end scope
#endmacro
const MYSQL_PS_SKIP_RESULT_W_LEN = -1
const MYSQL_PS_SKIP_RESULT_STR = -2
const STMT_ID_LENGTH = 4
type MYSQL_STMT as st_mysql_stmt
type mysql_stmt_use_or_store_func as function cdecl(byval as MYSQL_STMT ptr) as MYSQL_RES ptr

type enum_stmt_attr_type as long
enum
	STMT_ATTR_UPDATE_MAX_LENGTH
	STMT_ATTR_CURSOR_TYPE
	STMT_ATTR_PREFETCH_ROWS
	STMT_ATTR_PREBIND_PARAMS = 200
	STMT_ATTR_ARRAY_SIZE
	STMT_ATTR_ROW_SIZE
	STMT_ATTR_STATE
	STMT_ATTR_CB_USER_DATA
	STMT_ATTR_CB_PARAM
	STMT_ATTR_CB_RESULT
end enum

type enum_cursor_type as long
enum
	CURSOR_TYPE_NO_CURSOR = 0
	CURSOR_TYPE_READ_ONLY = 1
	CURSOR_TYPE_FOR_UPDATE = 2
	CURSOR_TYPE_SCROLLABLE = 4
end enum

type enum_indicator_type as long
enum
	STMT_INDICATOR_NTS = -1
	STMT_INDICATOR_NONE = 0
	STMT_INDICATOR_NULL = 1
	STMT_INDICATOR_DEFAULT = 2
	STMT_INDICATOR_IGNORE = 3
	STMT_INDICATOR_IGNORE_ROW = 4
end enum

const STMT_BULK_FLAG_CLIENT_SEND_TYPES = 128
const STMT_BULK_FLAG_INSERT_ID_REQUEST = 64

type mysql_stmt_state as long
enum
	MYSQL_STMT_INITTED = 0
	MYSQL_STMT_PREPARED
	MYSQL_STMT_EXECUTED
	MYSQL_STMT_WAITING_USE_OR_STORE
	MYSQL_STMT_USE_OR_STORE_CALLED
	MYSQL_STMT_USER_FETCHING
	MYSQL_STMT_FETCH_DONE
end enum

type enum_mysqlnd_stmt_state as mysql_stmt_state

union st_mysql_bind_u
	row_ptr as ubyte ptr
	indicator as zstring ptr
end union

type st_mysql_bind
	length as culong ptr
	is_null as my_bool ptr
	buffer as any ptr
	error as my_bool ptr
	u as st_mysql_bind_u
	store_param_func as sub cdecl(byval net as NET ptr, byval param as st_mysql_bind ptr)
	fetch_result as sub cdecl(byval as st_mysql_bind ptr, byval as MYSQL_FIELD ptr, byval row as ubyte ptr ptr)
	skip_result as sub cdecl(byval as st_mysql_bind ptr, byval as MYSQL_FIELD ptr, byval row as ubyte ptr ptr)
	buffer_length as culong
	offset as culong
	length_value as culong
	flags as ulong
	pack_length as ulong
	buffer_type as enum_field_types
	error_value as byte
	is_unsigned as byte
	long_data_used as byte
	is_null_value as byte
	extension as any ptr
end type

type MYSQL_BIND as st_mysql_bind

type st_mysqlnd_upsert_result
	warning_count as ulong
	server_status as ulong
	affected_rows as ulongint
	last_insert_id as ulongint
end type

type mysql_upsert_status as st_mysqlnd_upsert_result

type st_mysql_cmd_buffer
	buffer as ubyte ptr
	length as uinteger
end type

type MYSQL_CMD_BUFFER as st_mysql_cmd_buffer

type st_mysql_error_info
	error_no as ulong
	error as zstring * 512 + 1
	sqlstate as zstring * 5 + 1
end type

type mysql_error_info as st_mysql_error_info
type mysql_stmt_fetch_row_func as function cdecl(byval stmt as MYSQL_STMT ptr, byval row as ubyte ptr ptr) as long
type ps_result_callback as sub cdecl(byval data as any ptr, byval column as ulong, byval row as ubyte ptr ptr)
type ps_param_callback as function cdecl(byval data as any ptr, byval bind as MYSQL_BIND ptr, byval row_nr as ulong) as my_bool ptr

type st_mysql_stmt
	mem_root as MA_MEM_ROOT
	mysql as MYSQL ptr
	stmt_id as culong
	flags as culong
	state as enum_mysqlnd_stmt_state
	fields as MYSQL_FIELD ptr
	field_count as ulong
	param_count as ulong
	send_types_to_server as ubyte
	params as MYSQL_BIND ptr
	bind as MYSQL_BIND ptr
	result as MYSQL_DATA
	result_cursor as MYSQL_ROWS ptr
	bind_result_done as byte
	bind_param_done as byte
	upsert_status as mysql_upsert_status
	last_errno as ulong
	last_error as zstring * 512 + 1
	sqlstate as zstring * 5 + 1
	update_max_length as byte
	prefetch_rows as culong
	list as LIST
	cursor_exists as byte
	extension as any ptr
	fetch_row_func as mysql_stmt_fetch_row_func
	execute_count as ulong
	default_rset_handler as mysql_stmt_use_or_store_func
	request_buffer as ubyte ptr
	array_size as ulong
	row_size as uinteger
	prebind_params as ulong
	user_data as any ptr
	result_callback as ps_result_callback
	param_callback as ps_param_callback
	request_length as uinteger
end type

type ps_field_fetch_func as sub cdecl(byval r_param as MYSQL_BIND ptr, byval field as const MYSQL_FIELD ptr, byval row as ubyte ptr ptr)

type st_mysql_perm_bind
	func as ps_field_fetch_func
	pack_len as long
	max_len as culong
end type

type MYSQL_PS_CONVERSION as st_mysql_perm_bind
extern mysql_ps_fetch_functions(0 to (MYSQL_TYPE_GEOMETRY + 1) - 1) as MYSQL_PS_CONVERSION
declare function ma_net_safe_read cdecl(byval mysql as MYSQL ptr) as culong
declare sub mysql_init_ps_subsystem cdecl()
declare function net_field_length cdecl(byval packet as ubyte ptr ptr) as culong
declare function ma_simple_command cdecl(byval mysql as MYSQL ptr, byval command as enum_server_command, byval arg as const zstring ptr, byval length as uinteger, byval skipp_check as byte, byval opt_arg as any ptr) as long
declare function mysql_stmt_init(byval mysql as MYSQL ptr) as MYSQL_STMT ptr
declare function mysql_stmt_prepare(byval stmt as MYSQL_STMT ptr, byval query as const zstring ptr, byval length as culong) as long
declare function mysql_stmt_execute(byval stmt as MYSQL_STMT ptr) as long
declare function mysql_stmt_fetch(byval stmt as MYSQL_STMT ptr) as long
declare function mysql_stmt_fetch_column(byval stmt as MYSQL_STMT ptr, byval bind_arg as MYSQL_BIND ptr, byval column as ulong, byval offset as culong) as long
declare function mysql_stmt_store_result(byval stmt as MYSQL_STMT ptr) as long
declare function mysql_stmt_param_count(byval stmt as MYSQL_STMT ptr) as culong
declare function mysql_stmt_attr_set(byval stmt as MYSQL_STMT ptr, byval attr_type as enum_stmt_attr_type, byval attr as const any ptr) as byte
declare function mysql_stmt_attr_get(byval stmt as MYSQL_STMT ptr, byval attr_type as enum_stmt_attr_type, byval attr as any ptr) as byte
declare function mysql_stmt_bind_param(byval stmt as MYSQL_STMT ptr, byval bnd as MYSQL_BIND ptr) as byte
declare function mysql_stmt_bind_result(byval stmt as MYSQL_STMT ptr, byval bnd as MYSQL_BIND ptr) as byte
declare function mysql_stmt_close(byval stmt as MYSQL_STMT ptr) as byte
declare function mysql_stmt_reset(byval stmt as MYSQL_STMT ptr) as byte
declare function mysql_stmt_free_result(byval stmt as MYSQL_STMT ptr) as byte
declare function mysql_stmt_send_long_data(byval stmt as MYSQL_STMT ptr, byval param_number as ulong, byval data as const zstring ptr, byval length as culong) as byte
declare function mysql_stmt_result_metadata(byval stmt as MYSQL_STMT ptr) as MYSQL_RES ptr
declare function mysql_stmt_param_metadata(byval stmt as MYSQL_STMT ptr) as MYSQL_RES ptr
declare function mysql_stmt_errno(byval stmt as MYSQL_STMT ptr) as ulong
declare function mysql_stmt_error(byval stmt as MYSQL_STMT ptr) as const zstring ptr
declare function mysql_stmt_sqlstate(byval stmt as MYSQL_STMT ptr) as const zstring ptr
declare function mysql_stmt_row_seek(byval stmt as MYSQL_STMT ptr, byval offset as MYSQL_ROW_OFFSET) as MYSQL_ROW_OFFSET
declare function mysql_stmt_row_tell(byval stmt as MYSQL_STMT ptr) as MYSQL_ROW_OFFSET
declare sub mysql_stmt_data_seek(byval stmt as MYSQL_STMT ptr, byval offset as ulongint)
declare function mysql_stmt_num_rows(byval stmt as MYSQL_STMT ptr) as ulongint
declare function mysql_stmt_affected_rows(byval stmt as MYSQL_STMT ptr) as ulongint
declare function mysql_stmt_insert_id(byval stmt as MYSQL_STMT ptr) as ulongint
declare function mysql_stmt_field_count(byval stmt as MYSQL_STMT ptr) as ulong
declare function mysql_stmt_next_result(byval stmt as MYSQL_STMT ptr) as long
declare function mysql_stmt_more_results(byval stmt as MYSQL_STMT ptr) as byte
declare function mariadb_stmt_execute_direct(byval stmt as MYSQL_STMT ptr, byval stmt_str as const zstring ptr, byval length as uinteger) as long
declare function mariadb_stmt_fetch_fields(byval stmt as MYSQL_STMT ptr) as MYSQL_FIELD ptr

type st_mysql_client_plugin
	as long type
	interface_version as ulong
	name as const zstring ptr
	author as const zstring ptr
	desc as const zstring ptr
	version(0 to 2) as ulong
	license as const zstring ptr
	mysql_api as any ptr
	init as function cdecl(byval as zstring ptr, byval as uinteger, byval as long, byval as va_list) as long
	deinit as function cdecl() as long
	options as function cdecl(byval option as const zstring ptr, byval as const any ptr) as long
end type

declare function mysql_load_plugin cdecl(byval mysql as st_mysql ptr, byval name as const zstring ptr, byval type as long, byval argc as long, ...) as st_mysql_client_plugin ptr
declare function mysql_load_plugin_v(byval mysql as st_mysql ptr, byval name as const zstring ptr, byval type as long, byval argc as long, byval args as va_list) as st_mysql_client_plugin ptr
declare function mysql_client_find_plugin(byval mysql as st_mysql ptr, byval name as const zstring ptr, byval type as long) as st_mysql_client_plugin ptr
declare function mysql_client_register_plugin(byval mysql as st_mysql ptr, byval plugin as st_mysql_client_plugin ptr) as st_mysql_client_plugin ptr
declare sub mysql_set_local_infile_handler(byval mysql as MYSQL ptr, byval local_infile_init as function cdecl(byval as any ptr ptr, byval as const zstring ptr, byval as any ptr) as long, byval local_infile_read as function cdecl(byval as any ptr, byval as zstring ptr, byval as ulong) as long, byval local_infile_end as sub cdecl(byval as any ptr), byval local_infile_error as function cdecl(byval as any ptr, byval as zstring ptr, byval as ulong) as long, byval as any ptr)
declare sub mysql_set_local_infile_default cdecl(byval mysql as MYSQL ptr)
declare sub my_set_error cdecl(byval mysql as MYSQL ptr, byval error_nr as ulong, byval sqlstate as const zstring ptr, byval format as const zstring ptr, ...)
declare function mysql_num_rows(byval res as MYSQL_RES ptr) as my_ulonglong
declare function mysql_num_fields(byval res as MYSQL_RES ptr) as ulong
declare function mysql_eof(byval res as MYSQL_RES ptr) as byte
declare function mysql_fetch_field_direct(byval res as MYSQL_RES ptr, byval fieldnr as ulong) as MYSQL_FIELD ptr
declare function mysql_fetch_fields(byval res as MYSQL_RES ptr) as MYSQL_FIELD ptr
declare function mysql_row_tell(byval res as MYSQL_RES ptr) as MYSQL_ROWS ptr
declare function mysql_field_tell(byval res as MYSQL_RES ptr) as ulong
declare function mysql_field_count(byval mysql as MYSQL ptr) as ulong
declare function mysql_more_results(byval mysql as MYSQL ptr) as byte
declare function mysql_next_result(byval mysql as MYSQL ptr) as long
declare function mysql_affected_rows(byval mysql as MYSQL ptr) as my_ulonglong
declare function mysql_autocommit(byval mysql as MYSQL ptr, byval mode as byte) as byte
declare function mysql_commit(byval mysql as MYSQL ptr) as byte
declare function mysql_rollback(byval mysql as MYSQL ptr) as byte
declare function mysql_insert_id(byval mysql as MYSQL ptr) as my_ulonglong
declare function mysql_errno(byval mysql as MYSQL ptr) as ulong
declare function mysql_error(byval mysql as MYSQL ptr) as const zstring ptr
declare function mysql_info(byval mysql as MYSQL ptr) as const zstring ptr
declare function mysql_thread_id(byval mysql as MYSQL ptr) as culong
declare function mysql_character_set_name(byval mysql as MYSQL ptr) as const zstring ptr
declare sub mysql_get_character_set_info(byval mysql as MYSQL ptr, byval cs as MY_CHARSET_INFO ptr)
declare function mysql_set_character_set(byval mysql as MYSQL ptr, byval csname as const zstring ptr) as long
declare function mariadb_get_infov cdecl(byval mysql as MYSQL ptr, byval value as mariadb_value, byval arg as any ptr, ...) as byte
declare function mariadb_get_info(byval mysql as MYSQL ptr, byval value as mariadb_value, byval arg as any ptr) as byte
declare function mysql_init(byval mysql as MYSQL ptr) as MYSQL ptr
declare function mysql_ssl_set(byval mysql as MYSQL ptr, byval key as const zstring ptr, byval cert as const zstring ptr, byval ca as const zstring ptr, byval capath as const zstring ptr, byval cipher as const zstring ptr) as long
declare function mysql_get_ssl_cipher(byval mysql as MYSQL ptr) as const zstring ptr
declare function mysql_change_user(byval mysql as MYSQL ptr, byval user as const zstring ptr, byval passwd as const zstring ptr, byval db as const zstring ptr) as byte
declare function mysql_real_connect(byval mysql as MYSQL ptr, byval host as const zstring ptr, byval user as const zstring ptr, byval passwd as const zstring ptr, byval db as const zstring ptr, byval port as ulong, byval unix_socket as const zstring ptr, byval clientflag as culong) as MYSQL ptr
declare sub mysql_close(byval sock as MYSQL ptr)
declare function mysql_select_db(byval mysql as MYSQL ptr, byval db as const zstring ptr) as long
declare function mysql_query(byval mysql as MYSQL ptr, byval q as const zstring ptr) as long
declare function mysql_send_query(byval mysql as MYSQL ptr, byval q as const zstring ptr, byval length as culong) as long
declare function mysql_read_query_result(byval mysql as MYSQL ptr) as byte
declare function mysql_real_query(byval mysql as MYSQL ptr, byval q as const zstring ptr, byval length as culong) as long
declare function mysql_shutdown(byval mysql as MYSQL ptr, byval shutdown_level as mysql_enum_shutdown_level) as long
declare function mysql_dump_debug_info(byval mysql as MYSQL ptr) as long
declare function mysql_refresh(byval mysql as MYSQL ptr, byval refresh_options as ulong) as long
declare function mysql_kill(byval mysql as MYSQL ptr, byval pid as culong) as long
declare function mysql_ping(byval mysql as MYSQL ptr) as long
declare function mysql_stat(byval mysql as MYSQL ptr) as zstring ptr
declare function mysql_get_server_info(byval mysql as MYSQL ptr) as zstring ptr
declare function mysql_get_server_version(byval mysql as MYSQL ptr) as culong
declare function mysql_get_host_info(byval mysql as MYSQL ptr) as zstring ptr
declare function mysql_get_proto_info(byval mysql as MYSQL ptr) as ulong
declare function mysql_list_dbs(byval mysql as MYSQL ptr, byval wild as const zstring ptr) as MYSQL_RES ptr
declare function mysql_list_tables(byval mysql as MYSQL ptr, byval wild as const zstring ptr) as MYSQL_RES ptr
declare function mysql_list_fields(byval mysql as MYSQL ptr, byval table as const zstring ptr, byval wild as const zstring ptr) as MYSQL_RES ptr
declare function mysql_list_processes(byval mysql as MYSQL ptr) as MYSQL_RES ptr
declare function mysql_store_result(byval mysql as MYSQL ptr) as MYSQL_RES ptr
declare function mysql_use_result(byval mysql as MYSQL ptr) as MYSQL_RES ptr
declare function mysql_options(byval mysql as MYSQL ptr, byval option as mysql_option, byval arg as const any ptr) as long
declare function mysql_options4(byval mysql as MYSQL ptr, byval option as mysql_option, byval arg1 as const any ptr, byval arg2 as const any ptr) as long
declare sub mysql_free_result(byval result as MYSQL_RES ptr)
declare sub mysql_data_seek(byval result as MYSQL_RES ptr, byval offset as ulongint)
declare function mysql_row_seek(byval result as MYSQL_RES ptr, byval as MYSQL_ROW_OFFSET) as MYSQL_ROW_OFFSET
declare function mysql_field_seek(byval result as MYSQL_RES ptr, byval offset as MYSQL_FIELD_OFFSET) as MYSQL_FIELD_OFFSET
declare function mysql_fetch_row(byval result as MYSQL_RES ptr) as MYSQL_ROW
declare function mysql_fetch_lengths(byval result as MYSQL_RES ptr) as culong ptr
declare function mysql_fetch_field(byval result as MYSQL_RES ptr) as MYSQL_FIELD ptr
declare function mysql_escape_string(byval to as zstring ptr, byval from as const zstring ptr, byval from_length as culong) as culong
declare function mysql_real_escape_string(byval mysql as MYSQL ptr, byval to as zstring ptr, byval from as const zstring ptr, byval length as culong) as culong
declare function mysql_thread_safe() as ulong
declare function mysql_warning_count(byval mysql as MYSQL ptr) as ulong
declare function mysql_sqlstate(byval mysql as MYSQL ptr) as const zstring ptr
declare function mysql_server_init(byval argc as long, byval argv as zstring ptr ptr, byval groups as zstring ptr ptr) as long
declare sub mysql_server_end()
declare sub mysql_thread_end()
declare function mysql_thread_init() as byte
declare function mysql_set_server_option(byval mysql as MYSQL ptr, byval option as enum_mysql_set_option) as long
declare function mysql_get_client_info() as const zstring ptr
declare function mysql_get_client_version() as culong
declare function mariadb_connection(byval mysql as MYSQL ptr) as byte
declare function mysql_get_server_name(byval mysql as MYSQL ptr) as const zstring ptr
declare function mariadb_get_charset_by_name(byval csname as const zstring ptr) as MARIADB_CHARSET_INFO ptr
declare function mariadb_get_charset_by_nr(byval csnr as ulong) as MARIADB_CHARSET_INFO ptr
declare function mariadb_convert_string(byval from as const zstring ptr, byval from_len as uinteger ptr, byval from_cs as MARIADB_CHARSET_INFO ptr, byval to as zstring ptr, byval to_len as uinteger ptr, byval to_cs as MARIADB_CHARSET_INFO ptr, byval errorcode as long ptr) as uinteger
declare function mysql_optionsv cdecl(byval mysql as MYSQL ptr, byval option as mysql_option, ...) as long
declare function mysql_get_optionv cdecl(byval mysql as MYSQL ptr, byval option as mysql_option, byval arg as any ptr, ...) as long
declare function mysql_get_option(byval mysql as MYSQL ptr, byval option as mysql_option, byval arg as any ptr) as long
declare function mysql_hex_string(byval to as zstring ptr, byval from as const zstring ptr, byval len as culong) as culong

#ifdef __FB_UNIX__
	declare function mysql_get_socket(byval mysql as MYSQL ptr) as my_socket
#elseif defined(__FB_WIN32__) and (not defined(__FB_64BIT__))
	declare function mysql_get_socket(byval mysql as MYSQL ptr) as ulong
#else
	declare function mysql_get_socket(byval mysql as MYSQL ptr) as ulongint
#endif

declare function mysql_get_timeout_value(byval mysql as const MYSQL ptr) as ulong
declare function mysql_get_timeout_value_ms(byval mysql as const MYSQL ptr) as ulong
declare function mariadb_reconnect(byval mysql as MYSQL ptr) as byte
declare function mariadb_cancel(byval mysql as MYSQL ptr) as long
declare sub mysql_debug(byval debug as const zstring ptr)
declare function mysql_net_read_packet(byval mysql as MYSQL ptr) as culong
declare function mysql_net_field_length(byval packet as ubyte ptr ptr) as culong
declare function mysql_embedded() as byte
declare function mysql_get_parameters() as MYSQL_PARAMETERS ptr
declare function mysql_close_start(byval sock as MYSQL ptr) as long
declare function mysql_close_cont(byval sock as MYSQL ptr, byval status as long) as long
declare function mysql_commit_start(byval ret as my_bool ptr, byval mysql as MYSQL ptr) as long
declare function mysql_commit_cont(byval ret as my_bool ptr, byval mysql as MYSQL ptr, byval status as long) as long
declare function mysql_dump_debug_info_cont(byval ret as long ptr, byval mysql as MYSQL ptr, byval ready_status as long) as long
declare function mysql_dump_debug_info_start(byval ret as long ptr, byval mysql as MYSQL ptr) as long
declare function mysql_rollback_start(byval ret as my_bool ptr, byval mysql as MYSQL ptr) as long
declare function mysql_rollback_cont(byval ret as my_bool ptr, byval mysql as MYSQL ptr, byval status as long) as long
declare function mysql_autocommit_start(byval ret as my_bool ptr, byval mysql as MYSQL ptr, byval auto_mode as byte) as long
declare function mysql_list_fields_cont(byval ret as MYSQL_RES ptr ptr, byval mysql as MYSQL ptr, byval ready_status as long) as long
declare function mysql_list_fields_start(byval ret as MYSQL_RES ptr ptr, byval mysql as MYSQL ptr, byval table as const zstring ptr, byval wild as const zstring ptr) as long
declare function mysql_autocommit_cont(byval ret as my_bool ptr, byval mysql as MYSQL ptr, byval status as long) as long
declare function mysql_next_result_start(byval ret as long ptr, byval mysql as MYSQL ptr) as long
declare function mysql_next_result_cont(byval ret as long ptr, byval mysql as MYSQL ptr, byval status as long) as long
declare function mysql_select_db_start(byval ret as long ptr, byval mysql as MYSQL ptr, byval db as const zstring ptr) as long
declare function mysql_select_db_cont(byval ret as long ptr, byval mysql as MYSQL ptr, byval ready_status as long) as long
declare function mysql_stmt_warning_count(byval stmt as MYSQL_STMT ptr) as long
declare function mysql_stmt_next_result_start(byval ret as long ptr, byval stmt as MYSQL_STMT ptr) as long
declare function mysql_stmt_next_result_cont(byval ret as long ptr, byval stmt as MYSQL_STMT ptr, byval status as long) as long
declare function mysql_set_character_set_start(byval ret as long ptr, byval mysql as MYSQL ptr, byval csname as const zstring ptr) as long
declare function mysql_set_character_set_cont(byval ret as long ptr, byval mysql as MYSQL ptr, byval status as long) as long
declare function mysql_change_user_start(byval ret as my_bool ptr, byval mysql as MYSQL ptr, byval user as const zstring ptr, byval passwd as const zstring ptr, byval db as const zstring ptr) as long
declare function mysql_change_user_cont(byval ret as my_bool ptr, byval mysql as MYSQL ptr, byval status as long) as long
declare function mysql_real_connect_start(byval ret as MYSQL ptr ptr, byval mysql as MYSQL ptr, byval host as const zstring ptr, byval user as const zstring ptr, byval passwd as const zstring ptr, byval db as const zstring ptr, byval port as ulong, byval unix_socket as const zstring ptr, byval clientflag as culong) as long
declare function mysql_real_connect_cont(byval ret as MYSQL ptr ptr, byval mysql as MYSQL ptr, byval status as long) as long
declare function mysql_query_start(byval ret as long ptr, byval mysql as MYSQL ptr, byval q as const zstring ptr) as long
declare function mysql_query_cont(byval ret as long ptr, byval mysql as MYSQL ptr, byval status as long) as long
declare function mysql_send_query_start(byval ret as long ptr, byval mysql as MYSQL ptr, byval q as const zstring ptr, byval length as culong) as long
declare function mysql_send_query_cont(byval ret as long ptr, byval mysql as MYSQL ptr, byval status as long) as long
declare function mysql_real_query_start(byval ret as long ptr, byval mysql as MYSQL ptr, byval q as const zstring ptr, byval length as culong) as long
declare function mysql_real_query_cont(byval ret as long ptr, byval mysql as MYSQL ptr, byval status as long) as long
declare function mysql_store_result_start(byval ret as MYSQL_RES ptr ptr, byval mysql as MYSQL ptr) as long
declare function mysql_store_result_cont(byval ret as MYSQL_RES ptr ptr, byval mysql as MYSQL ptr, byval status as long) as long
declare function mysql_shutdown_start(byval ret as long ptr, byval mysql as MYSQL ptr, byval shutdown_level as mysql_enum_shutdown_level) as long
declare function mysql_shutdown_cont(byval ret as long ptr, byval mysql as MYSQL ptr, byval status as long) as long
declare function mysql_refresh_start(byval ret as long ptr, byval mysql as MYSQL ptr, byval refresh_options as ulong) as long
declare function mysql_refresh_cont(byval ret as long ptr, byval mysql as MYSQL ptr, byval status as long) as long
declare function mysql_kill_start(byval ret as long ptr, byval mysql as MYSQL ptr, byval pid as culong) as long
declare function mysql_kill_cont(byval ret as long ptr, byval mysql as MYSQL ptr, byval status as long) as long
declare function mysql_set_server_option_start(byval ret as long ptr, byval mysql as MYSQL ptr, byval option as enum_mysql_set_option) as long
declare function mysql_set_server_option_cont(byval ret as long ptr, byval mysql as MYSQL ptr, byval status as long) as long
declare function mysql_ping_start(byval ret as long ptr, byval mysql as MYSQL ptr) as long
declare function mysql_ping_cont(byval ret as long ptr, byval mysql as MYSQL ptr, byval status as long) as long
declare function mysql_stat_start(byval ret as const zstring ptr ptr, byval mysql as MYSQL ptr) as long
declare function mysql_stat_cont(byval ret as const zstring ptr ptr, byval mysql as MYSQL ptr, byval status as long) as long
declare function mysql_free_result_start(byval result as MYSQL_RES ptr) as long
declare function mysql_free_result_cont(byval result as MYSQL_RES ptr, byval status as long) as long
declare function mysql_fetch_row_start(byval ret as MYSQL_ROW ptr, byval result as MYSQL_RES ptr) as long
declare function mysql_fetch_row_cont(byval ret as MYSQL_ROW ptr, byval result as MYSQL_RES ptr, byval status as long) as long
declare function mysql_read_query_result_start(byval ret as my_bool ptr, byval mysql as MYSQL ptr) as long
declare function mysql_read_query_result_cont(byval ret as my_bool ptr, byval mysql as MYSQL ptr, byval status as long) as long
declare function mysql_reset_connection_start(byval ret as long ptr, byval mysql as MYSQL ptr) as long
declare function mysql_reset_connection_cont(byval ret as long ptr, byval mysql as MYSQL ptr, byval status as long) as long
declare function mysql_session_track_get_next(byval mysql as MYSQL ptr, byval type as enum_session_state_type, byval data as const zstring ptr ptr, byval length as uinteger ptr) as long
declare function mysql_session_track_get_first(byval mysql as MYSQL ptr, byval type as enum_session_state_type, byval data as const zstring ptr ptr, byval length as uinteger ptr) as long
declare function mysql_stmt_prepare_start(byval ret as long ptr, byval stmt as MYSQL_STMT ptr, byval query as const zstring ptr, byval length as culong) as long
declare function mysql_stmt_prepare_cont(byval ret as long ptr, byval stmt as MYSQL_STMT ptr, byval status as long) as long
declare function mysql_stmt_execute_start(byval ret as long ptr, byval stmt as MYSQL_STMT ptr) as long
declare function mysql_stmt_execute_cont(byval ret as long ptr, byval stmt as MYSQL_STMT ptr, byval status as long) as long
declare function mysql_stmt_fetch_start(byval ret as long ptr, byval stmt as MYSQL_STMT ptr) as long
declare function mysql_stmt_fetch_cont(byval ret as long ptr, byval stmt as MYSQL_STMT ptr, byval status as long) as long
declare function mysql_stmt_store_result_start(byval ret as long ptr, byval stmt as MYSQL_STMT ptr) as long
declare function mysql_stmt_store_result_cont(byval ret as long ptr, byval stmt as MYSQL_STMT ptr, byval status as long) as long
declare function mysql_stmt_close_start(byval ret as my_bool ptr, byval stmt as MYSQL_STMT ptr) as long
declare function mysql_stmt_close_cont(byval ret as my_bool ptr, byval stmt as MYSQL_STMT ptr, byval status as long) as long
declare function mysql_stmt_reset_start(byval ret as my_bool ptr, byval stmt as MYSQL_STMT ptr) as long
declare function mysql_stmt_reset_cont(byval ret as my_bool ptr, byval stmt as MYSQL_STMT ptr, byval status as long) as long
declare function mysql_stmt_free_result_start(byval ret as my_bool ptr, byval stmt as MYSQL_STMT ptr) as long
declare function mysql_stmt_free_result_cont(byval ret as my_bool ptr, byval stmt as MYSQL_STMT ptr, byval status as long) as long
declare function mysql_stmt_send_long_data_start(byval ret as my_bool ptr, byval stmt as MYSQL_STMT ptr, byval param_number as ulong, byval data as const zstring ptr, byval len as culong) as long
declare function mysql_stmt_send_long_data_cont(byval ret as my_bool ptr, byval stmt as MYSQL_STMT ptr, byval status as long) as long
declare function mysql_reset_connection(byval mysql as MYSQL ptr) as long

type st_mariadb_api
	mysql_num_rows as function(byval res as MYSQL_RES ptr) as ulongint
	mysql_num_fields as function(byval res as MYSQL_RES ptr) as ulong
	mysql_eof as function(byval res as MYSQL_RES ptr) as byte
	mysql_fetch_field_direct as function(byval res as MYSQL_RES ptr, byval fieldnr as ulong) as MYSQL_FIELD ptr
	mysql_fetch_fields as function(byval res as MYSQL_RES ptr) as MYSQL_FIELD ptr
	mysql_row_tell as function(byval res as MYSQL_RES ptr) as MYSQL_ROWS ptr
	mysql_field_tell as function(byval res as MYSQL_RES ptr) as ulong
	mysql_field_count as function(byval mysql as MYSQL ptr) as ulong
	mysql_more_results as function(byval mysql as MYSQL ptr) as byte
	mysql_next_result as function(byval mysql as MYSQL ptr) as long
	mysql_affected_rows as function(byval mysql as MYSQL ptr) as ulongint
	mysql_autocommit as function(byval mysql as MYSQL ptr, byval mode as byte) as byte
	mysql_commit as function(byval mysql as MYSQL ptr) as byte
	mysql_rollback as function(byval mysql as MYSQL ptr) as byte
	mysql_insert_id as function(byval mysql as MYSQL ptr) as ulongint
	mysql_errno as function(byval mysql as MYSQL ptr) as ulong
	mysql_error as function(byval mysql as MYSQL ptr) as const zstring ptr
	mysql_info as function(byval mysql as MYSQL ptr) as const zstring ptr
	mysql_thread_id as function(byval mysql as MYSQL ptr) as culong
	mysql_character_set_name as function(byval mysql as MYSQL ptr) as const zstring ptr
	mysql_get_character_set_info as sub(byval mysql as MYSQL ptr, byval cs as MY_CHARSET_INFO ptr)
	mysql_set_character_set as function(byval mysql as MYSQL ptr, byval csname as const zstring ptr) as long
	mariadb_get_infov as function cdecl(byval mysql as MYSQL ptr, byval value as mariadb_value, byval arg as any ptr, ...) as byte
	mariadb_get_info as function(byval mysql as MYSQL ptr, byval value as mariadb_value, byval arg as any ptr) as byte
	mysql_init as function(byval mysql as MYSQL ptr) as MYSQL ptr
	mysql_ssl_set as function(byval mysql as MYSQL ptr, byval key as const zstring ptr, byval cert as const zstring ptr, byval ca as const zstring ptr, byval capath as const zstring ptr, byval cipher as const zstring ptr) as long
	mysql_get_ssl_cipher as function(byval mysql as MYSQL ptr) as const zstring ptr
	mysql_change_user as function(byval mysql as MYSQL ptr, byval user as const zstring ptr, byval passwd as const zstring ptr, byval db as const zstring ptr) as byte
	mysql_real_connect as function(byval mysql as MYSQL ptr, byval host as const zstring ptr, byval user as const zstring ptr, byval passwd as const zstring ptr, byval db as const zstring ptr, byval port as ulong, byval unix_socket as const zstring ptr, byval clientflag as culong) as MYSQL ptr
	mysql_close as sub(byval sock as MYSQL ptr)
	mysql_select_db as function(byval mysql as MYSQL ptr, byval db as const zstring ptr) as long
	mysql_query as function(byval mysql as MYSQL ptr, byval q as const zstring ptr) as long
	mysql_send_query as function(byval mysql as MYSQL ptr, byval q as const zstring ptr, byval length as culong) as long
	mysql_read_query_result as function(byval mysql as MYSQL ptr) as byte
	mysql_real_query as function(byval mysql as MYSQL ptr, byval q as const zstring ptr, byval length as culong) as long
	mysql_shutdown as function(byval mysql as MYSQL ptr, byval shutdown_level as mysql_enum_shutdown_level) as long
	mysql_dump_debug_info as function(byval mysql as MYSQL ptr) as long
	mysql_refresh as function(byval mysql as MYSQL ptr, byval refresh_options as ulong) as long
	mysql_kill as function(byval mysql as MYSQL ptr, byval pid as culong) as long
	mysql_ping as function(byval mysql as MYSQL ptr) as long
	mysql_stat as function(byval mysql as MYSQL ptr) as zstring ptr
	mysql_get_server_info as function(byval mysql as MYSQL ptr) as zstring ptr
	mysql_get_server_version as function(byval mysql as MYSQL ptr) as culong
	mysql_get_host_info as function(byval mysql as MYSQL ptr) as zstring ptr
	mysql_get_proto_info as function(byval mysql as MYSQL ptr) as ulong
	mysql_list_dbs as function(byval mysql as MYSQL ptr, byval wild as const zstring ptr) as MYSQL_RES ptr
	mysql_list_tables as function(byval mysql as MYSQL ptr, byval wild as const zstring ptr) as MYSQL_RES ptr
	mysql_list_fields as function(byval mysql as MYSQL ptr, byval table as const zstring ptr, byval wild as const zstring ptr) as MYSQL_RES ptr
	mysql_list_processes as function(byval mysql as MYSQL ptr) as MYSQL_RES ptr
	mysql_store_result as function(byval mysql as MYSQL ptr) as MYSQL_RES ptr
	mysql_use_result as function(byval mysql as MYSQL ptr) as MYSQL_RES ptr
	mysql_options as function(byval mysql as MYSQL ptr, byval option as mysql_option, byval arg as const any ptr) as long
	mysql_free_result as sub(byval result as MYSQL_RES ptr)
	mysql_data_seek as sub(byval result as MYSQL_RES ptr, byval offset as ulongint)
	mysql_row_seek as function(byval result as MYSQL_RES ptr, byval as MYSQL_ROW_OFFSET) as MYSQL_ROW_OFFSET
	mysql_field_seek as function(byval result as MYSQL_RES ptr, byval offset as MYSQL_FIELD_OFFSET) as MYSQL_FIELD_OFFSET
	mysql_fetch_row as function(byval result as MYSQL_RES ptr) as MYSQL_ROW
	mysql_fetch_lengths as function(byval result as MYSQL_RES ptr) as culong ptr
	mysql_fetch_field as function(byval result as MYSQL_RES ptr) as MYSQL_FIELD ptr
	mysql_escape_string as function(byval to as zstring ptr, byval from as const zstring ptr, byval from_length as culong) as culong
	mysql_real_escape_string as function(byval mysql as MYSQL ptr, byval to as zstring ptr, byval from as const zstring ptr, byval length as culong) as culong
	mysql_thread_safe as function() as ulong
	mysql_warning_count as function(byval mysql as MYSQL ptr) as ulong
	mysql_sqlstate as function(byval mysql as MYSQL ptr) as const zstring ptr
	mysql_server_init as function(byval argc as long, byval argv as zstring ptr ptr, byval groups as zstring ptr ptr) as long
	mysql_server_end as sub()
	mysql_thread_end as sub()
	mysql_thread_init as function() as byte
	mysql_set_server_option as function(byval mysql as MYSQL ptr, byval option as enum_mysql_set_option) as long
	mysql_get_client_info as function() as const zstring ptr
	mysql_get_client_version as function() as culong
	mariadb_connection as function(byval mysql as MYSQL ptr) as byte
	mysql_get_server_name as function(byval mysql as MYSQL ptr) as const zstring ptr
	mariadb_get_charset_by_name as function(byval csname as const zstring ptr) as MARIADB_CHARSET_INFO ptr
	mariadb_get_charset_by_nr as function(byval csnr as ulong) as MARIADB_CHARSET_INFO ptr
	mariadb_convert_string as function(byval from as const zstring ptr, byval from_len as uinteger ptr, byval from_cs as MARIADB_CHARSET_INFO ptr, byval to as zstring ptr, byval to_len as uinteger ptr, byval to_cs as MARIADB_CHARSET_INFO ptr, byval errorcode as long ptr) as uinteger
	mysql_optionsv as function cdecl(byval mysql as MYSQL ptr, byval option as mysql_option, ...) as long
	mysql_get_optionv as function cdecl(byval mysql as MYSQL ptr, byval option as mysql_option, byval arg as any ptr, ...) as long
	mysql_get_option as function(byval mysql as MYSQL ptr, byval option as mysql_option, byval arg as any ptr) as long
	mysql_hex_string as function(byval to as zstring ptr, byval from as const zstring ptr, byval len as culong) as culong

	#ifdef __FB_UNIX__
		mysql_get_socket as function(byval mysql as MYSQL ptr) as my_socket
	#elseif defined(__FB_WIN32__) and (not defined(__FB_64BIT__))
		mysql_get_socket as function(byval mysql as MYSQL ptr) as ulong
	#else
		mysql_get_socket as function(byval mysql as MYSQL ptr) as ulongint
	#endif

	mysql_get_timeout_value as function(byval mysql as const MYSQL ptr) as ulong
	mysql_get_timeout_value_ms as function(byval mysql as const MYSQL ptr) as ulong
	mariadb_reconnect as function(byval mysql as MYSQL ptr) as byte
	mysql_stmt_init as function(byval mysql as MYSQL ptr) as MYSQL_STMT ptr
	mysql_stmt_prepare as function(byval stmt as MYSQL_STMT ptr, byval query as const zstring ptr, byval length as culong) as long
	mysql_stmt_execute as function(byval stmt as MYSQL_STMT ptr) as long
	mysql_stmt_fetch as function(byval stmt as MYSQL_STMT ptr) as long
	mysql_stmt_fetch_column as function(byval stmt as MYSQL_STMT ptr, byval bind_arg as MYSQL_BIND ptr, byval column as ulong, byval offset as culong) as long
	mysql_stmt_store_result as function(byval stmt as MYSQL_STMT ptr) as long
	mysql_stmt_param_count as function(byval stmt as MYSQL_STMT ptr) as culong
	mysql_stmt_attr_set as function(byval stmt as MYSQL_STMT ptr, byval attr_type as enum_stmt_attr_type, byval attr as const any ptr) as byte
	mysql_stmt_attr_get as function(byval stmt as MYSQL_STMT ptr, byval attr_type as enum_stmt_attr_type, byval attr as any ptr) as byte
	mysql_stmt_bind_param as function(byval stmt as MYSQL_STMT ptr, byval bnd as MYSQL_BIND ptr) as byte
	mysql_stmt_bind_result as function(byval stmt as MYSQL_STMT ptr, byval bnd as MYSQL_BIND ptr) as byte
	mysql_stmt_close as function(byval stmt as MYSQL_STMT ptr) as byte
	mysql_stmt_reset as function(byval stmt as MYSQL_STMT ptr) as byte
	mysql_stmt_free_result as function(byval stmt as MYSQL_STMT ptr) as byte
	mysql_stmt_send_long_data as function(byval stmt as MYSQL_STMT ptr, byval param_number as ulong, byval data as const zstring ptr, byval length as culong) as byte
	mysql_stmt_result_metadata as function(byval stmt as MYSQL_STMT ptr) as MYSQL_RES ptr
	mysql_stmt_param_metadata as function(byval stmt as MYSQL_STMT ptr) as MYSQL_RES ptr
	mysql_stmt_errno as function(byval stmt as MYSQL_STMT ptr) as ulong
	mysql_stmt_error as function(byval stmt as MYSQL_STMT ptr) as const zstring ptr
	mysql_stmt_sqlstate as function(byval stmt as MYSQL_STMT ptr) as const zstring ptr
	mysql_stmt_row_seek as function(byval stmt as MYSQL_STMT ptr, byval offset as MYSQL_ROW_OFFSET) as MYSQL_ROW_OFFSET
	mysql_stmt_row_tell as function(byval stmt as MYSQL_STMT ptr) as MYSQL_ROW_OFFSET
	mysql_stmt_data_seek as sub(byval stmt as MYSQL_STMT ptr, byval offset as ulongint)
	mysql_stmt_num_rows as function(byval stmt as MYSQL_STMT ptr) as ulongint
	mysql_stmt_affected_rows as function(byval stmt as MYSQL_STMT ptr) as ulongint
	mysql_stmt_insert_id as function(byval stmt as MYSQL_STMT ptr) as ulongint
	mysql_stmt_field_count as function(byval stmt as MYSQL_STMT ptr) as ulong
	mysql_stmt_next_result as function(byval stmt as MYSQL_STMT ptr) as long
	mysql_stmt_more_results as function(byval stmt as MYSQL_STMT ptr) as byte
	mariadb_stmt_execute_direct as function(byval stmt as MYSQL_STMT ptr, byval stmtstr as const zstring ptr, byval length as uinteger) as long
	mysql_reset_connection as function(byval mysql as MYSQL ptr) as long
end type

type st_mariadb_methods_
	db_connect as function cdecl(byval mysql as MYSQL ptr, byval host as const zstring ptr, byval user as const zstring ptr, byval passwd as const zstring ptr, byval db as const zstring ptr, byval port as ulong, byval unix_socket as const zstring ptr, byval clientflag as culong) as MYSQL ptr
	db_close as sub cdecl(byval mysql as MYSQL ptr)
	db_command as function cdecl(byval mysql as MYSQL ptr, byval command as enum_server_command, byval arg as const zstring ptr, byval length as uinteger, byval skipp_check as byte, byval opt_arg as any ptr) as long
	db_skip_result as sub cdecl(byval mysql as MYSQL ptr)
	db_read_query_result as function cdecl(byval mysql as MYSQL ptr) as long
	db_read_rows as function cdecl(byval mysql as MYSQL ptr, byval fields as MYSQL_FIELD ptr, byval field_count as ulong) as MYSQL_DATA ptr
	db_read_one_row as function cdecl(byval mysql as MYSQL ptr, byval fields as ulong, byval row as MYSQL_ROW, byval lengths as culong ptr) as long
	db_supported_buffer_type as function cdecl(byval type as enum_field_types) as byte
	db_read_prepare_response as function cdecl(byval stmt as MYSQL_STMT ptr) as byte
	db_read_stmt_result as function cdecl(byval mysql as MYSQL ptr) as long
	db_stmt_get_result_metadata as function cdecl(byval stmt as MYSQL_STMT ptr) as byte
	db_stmt_get_param_metadata as function cdecl(byval stmt as MYSQL_STMT ptr) as byte
	db_stmt_read_all_rows as function cdecl(byval stmt as MYSQL_STMT ptr) as long
	db_stmt_fetch as function cdecl(byval stmt as MYSQL_STMT ptr, byval row as ubyte ptr ptr) as long
	db_stmt_fetch_to_bind as function cdecl(byval stmt as MYSQL_STMT ptr, byval row as ubyte ptr) as long
	db_stmt_flush_unbuffered as sub cdecl(byval stmt as MYSQL_STMT ptr)
	set_error as sub cdecl(byval mysql as MYSQL ptr, byval error_nr as ulong, byval sqlstate as const zstring ptr, byval format as const zstring ptr, ...)
	invalidate_stmts as sub cdecl(byval mysql as MYSQL ptr, byval function_name as const zstring ptr)
	api as st_mariadb_api ptr
	db_read_execute_response as function cdecl(byval stmt as MYSQL_STMT ptr) as long
	db_execute_generate_request as function cdecl(byval stmt as MYSQL_STMT ptr, byval request_len as uinteger ptr, byval internal as byte) as ubyte ptr
end type

#define mysql_reload(mysql) mysql_refresh((mysql), REFRESH_GRANT)
declare function mysql_library_init alias "mysql_server_init"(byval argc as long, byval argv as zstring ptr ptr, byval groups as zstring ptr ptr) as long
declare sub mysql_library_end alias "mysql_server_end"()
#define mariadb_connect(hdl, conn_str) mysql_real_connect((hdl), (conn_str), NULL, NULL, NULL, 0, NULL, 0)
#define HAVE_MYSQL_REAL_CONNECT

end extern
