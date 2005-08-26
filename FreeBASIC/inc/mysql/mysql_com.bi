''
''
'' mysql_com -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __mysql_com_bi__
#define __mysql_com_bi__

#define NAME_LEN 64
#define HOSTNAME_LENGTH 60
#define USERNAME_LENGTH 16
#define SERVER_VERSION_LENGTH 60
#define LOCAL_HOST "localhost"
#define LOCAL_HOST_NAMEDPIPE "."

enum enum_server_command
	COM_SLEEP
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
	COM_TIME
	COM_DELAYED_INSERT
	COM_CHANGE_USER
	COM_BINLOG_DUMP
	COM_TABLE_DUMP
	COM_CONNECT_OUT
	COM_REGISTER_SLAVE
	COM_END
end enum

#define NOT_NULL_FLAG 1
#define PRI_KEY_FLAG 2
#define UNIQUE_KEY_FLAG 4
#define MULTIPLE_KEY_FLAG 8
#define BLOB_FLAG 16
#define UNSIGNED_FLAG 32
#define ZEROFILL_FLAG 64
#define BINARY_FLAG 128
#define ENUM_FLAG 256
#define AUTO_INCREMENT_FLAG 512
#define TIMESTAMP_FLAG 1024
#define SET_FLAG 2048
#define NUM_FLAG 32768
#define PART_KEY_FLAG 16384
#define GROUP_FLAG 32768
#define UNIQUE_FLAG 65536
#define REFRESH_GRANT 1
#define REFRESH_LOG 2
#define REFRESH_TABLES 4
#define REFRESH_HOSTS 8
#define REFRESH_STATUS 16
#define REFRESH_THREADS 32
#define REFRESH_SLAVE 64
#define REFRESH_MASTER 128
#define REFRESH_READ_LOCK 16384
#define REFRESH_FAST 32768
#define REFRESH_QUERY_CACHE 65536
#define REFRESH_QUERY_CACHE_FREE &h20000L
#define REFRESH_DES_KEY_FILE &h40000L
#define REFRESH_USER_RESOURCES &h80000L
#define CLIENT_LONG_PASSWORD 1
#define CLIENT_FOUND_ROWS 2
#define CLIENT_LONG_FLAG 4
#define CLIENT_CONNECT_WITH_DB 8
#define CLIENT_NO_SCHEMA 16
#define CLIENT_COMPRESS 32
#define CLIENT_ODBC 64
#define CLIENT_LOCAL_FILES 128
#define CLIENT_IGNORE_SPACE 256
#define CLIENT_INTERACTIVE 1024
#define CLIENT_SSL 2048
#define CLIENT_IGNORE_SIGPIPE 4096
#define CLIENT_TRANSACTIONS 8192
#define SERVER_STATUS_IN_TRANS 1
#define SERVER_STATUS_AUTOCOMMIT 2
#define MYSQL_ERRMSG_SIZE 200
#define NET_READ_TIMEOUT 30
#define NET_WRITE_TIMEOUT 60
#define NET_WAIT_TIMEOUT 8*60*60

type st_vio as any
type Vio as st_vio

#define MAX_CHAR_WIDTH 255
#define MAX_BLOB_WIDTH 8192

type st_net
	vio as Vio ptr
	buff as ubyte ptr
	buff_end as ubyte ptr
	write_pos as ubyte ptr
	read_pos as ubyte ptr
	fd as my_socket
	max_packet as uinteger
	max_packet_size as uinteger
	last_errno as uinteger
	pkt_nr as uinteger
	compress_pkt_nr as uinteger
	write_timeout as uinteger
	read_timeout as uinteger
	retry_count as uinteger
	fcntl as integer
	last_error as string * 200-1
	error as ubyte
	return_errno as my_bool
	compress as my_bool
	remain_in_buf as uinteger
	length as uinteger
	buf_length as uinteger
	where_b as uinteger
	return_status as uinteger ptr
	reading_or_writing as ubyte
	save_char as byte
	no_send_ok as my_bool
	query_cache_query as gptr
end type

type NET as st_net

#define packet_error ( not 0)

enum enum_field_types
	FIELD_TYPE_DECIMAL
	FIELD_TYPE_TINY
	FIELD_TYPE_SHORT
	FIELD_TYPE_LONG
	FIELD_TYPE_FLOAT
	FIELD_TYPE_DOUBLE
	FIELD_TYPE_NULL
	FIELD_TYPE_TIMESTAMP
	FIELD_TYPE_LONGLONG
	FIELD_TYPE_INT24
	FIELD_TYPE_DATE
	FIELD_TYPE_TIME
	FIELD_TYPE_DATETIME
	FIELD_TYPE_YEAR
	FIELD_TYPE_NEWDATE
	FIELD_TYPE_ENUM = 247
	FIELD_TYPE_SET = 248
	FIELD_TYPE_TINY_BLOB = 249
	FIELD_TYPE_MEDIUM_BLOB = 250
	FIELD_TYPE_LONG_BLOB = 251
	FIELD_TYPE_BLOB = 252
	FIELD_TYPE_VAR_STRING = 253
	FIELD_TYPE_STRING = 254
	FIELD_TYPE_GEOMETRY = 255
end enum

declare function my_net_init alias "my_net_init" (byval net as NET ptr, byval vio as Vio ptr) as integer
declare sub my_net_local_init alias "my_net_local_init" (byval net as NET ptr)
declare sub net_end alias "net_end" (byval net as NET ptr)
declare sub net_clear alias "net_clear" (byval net as NET ptr)
declare function net_flush alias "net_flush" (byval net as NET ptr) as integer
declare function my_net_write alias "my_net_write" (byval net as NET ptr, byval packet as zstring ptr, byval len as uinteger) as integer
declare function net_write_command alias "net_write_command" (byval net as NET ptr, byval command as ubyte, byval packet as zstring ptr, byval len as uinteger) as integer
declare function net_real_write alias "net_real_write" (byval net as NET ptr, byval packet as zstring ptr, byval len as uinteger) as integer
declare function my_net_read alias "my_net_read" (byval net as NET ptr) as uinteger
#ifndef sockaddr
type sockaddr as any
#endif
declare function my_connect alias "my_connect" (byval s as my_socket, byval name as sockaddr ptr, byval namelen as uinteger, byval timeout as uinteger) as integer

type rand_struct
	seed1 as uinteger
	seed2 as uinteger
	max_value as uinteger
	max_value_dbl as double
end type

enum Item_result
	STRING_RESULT
	REAL_RESULT
	INT_RESULT
end enum

type st_udf_args
	arg_count as uinteger
	arg_type as Item_result ptr
	args as byte ptr ptr
	lengths as uinteger ptr
	maybe_null as byte ptr
end type

type UDF_ARGS as st_udf_args

type st_udf_init
	maybe_null as my_bool
	decimals as uinteger
	max_length as uinteger
	ptr as byte ptr
	const_item as my_bool
end type

type UDF_INIT as st_udf_init

#define NET_HEADER_SIZE 4
#define COMP_HEADER_SIZE 3

declare sub randominit alias "randominit" (byval as rand_struct ptr, byval seed1 as uinteger, byval seed2 as uinteger)
declare function my_rnd alias "my_rnd" (byval as rand_struct ptr) as double
declare sub make_scrambled_password alias "make_scrambled_password" (byval to as zstring ptr, byval password as zstring ptr)
declare sub get_salt_from_password alias "get_salt_from_password" (byval res as uinteger ptr, byval password as zstring ptr)
declare sub make_password_from_salt alias "make_password_from_salt" (byval to as zstring ptr, byval hash_res as uinteger ptr)
declare function scramble alias "scramble" (byval to as zstring ptr, byval message as zstring ptr, byval password as zstring ptr, byval old_ver as my_bool) as zstring ptr
declare function check_scramble alias "check_scramble" (byval as zstring ptr, byval message as zstring ptr, byval salt as uinteger ptr, byval old_ver as my_bool) as my_bool
declare function get_tty_password alias "get_tty_password" (byval opt_message as zstring ptr) as zstring ptr
declare sub hash_password alias "hash_password" (byval result as uinteger ptr, byval password as zstring ptr)
declare function my_init alias "my_init" () as my_bool
declare function load_defaults alias "load_defaults" (byval conf_file as zstring ptr, byval groups as byte ptr ptr, byval argc as integer ptr, byval argv as byte ptr ptr ptr) as integer
declare function my_thread_init alias "my_thread_init" () as my_bool
declare sub my_thread_end alias "my_thread_end" ()

#define NULL_LENGTH ( not 0)

#endif
