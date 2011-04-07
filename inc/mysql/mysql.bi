''
''
'' mysql -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __mysql_bi__
#define __mysql_bi__

#ifdef __FB_WIN32__
# inclib "mySQL"
#else
# inclib "mysqlclient"
#endif

type my_bool as byte
type gptr as byte ptr
type my_socket as integer
type charset_info_st as any

#include once "mysql/mysql_com.bi"
#include once "mysql/mysql_version.bi"

#define CLIENT_NET_READ_TIMEOUT 365*24*3600
#define CLIENT_NET_WRITE_TIMEOUT 365*24*3600

type st_mysql_field
	name as zstring ptr
	table as zstring ptr
	org_table as zstring ptr
	db as zstring ptr
	def as zstring ptr
	length as uinteger
	max_length as uinteger
	flags as uinteger
	decimals as uinteger
	type as enum_field_types
end type

type MYSQL_FIELD as st_mysql_field
type MYSQL_ROW as zstring ptr ptr
type MYSQL_FIELD_OFFSET as uinteger
type my_ulonglong as ulongint

#define MYSQL_COUNT_ERROR ( not 0)

type st_mysql_rows
	next as st_mysql_rows ptr
	data as MYSQL_ROW
end type

type MYSQL_ROWS as st_mysql_rows
type MYSQL_ROW_OFFSET as MYSQL_ROWS ptr

#include once "mysql/my_alloc.bi"

type st_mysql_data
	rows as my_ulonglong
	fields as uinteger
	data as MYSQL_ROWS ptr
	alloc as MEM_ROOT
end type

type MYSQL_DATA as st_mysql_data

type st_mysql_options
	connect_timeout as uinteger
	client_flag as uinteger
	port as uinteger
	host as zstring ptr
	init_command as zstring ptr
	user as zstring ptr
	password as zstring ptr
	unix_socket as byte ptr
	db as zstring ptr
	my_cnf_file as zstring ptr
	my_cnf_group as zstring ptr
	charset_dir as zstring ptr
	charset_name as zstring ptr
	ssl_key as zstring ptr
	ssl_cert as zstring ptr
	ssl_ca as zstring ptr
	ssl_capath as zstring ptr
	ssl_cipher as zstring ptr
	max_allowed_packet as uinteger
	use_ssl as my_bool
	compress as my_bool
	named_pipe as my_bool
	rpl_probe as my_bool
	rpl_parse as my_bool
	no_master_reads as my_bool
end type

enum mysql_option
	MYSQL_OPT_CONNECT_TIMEOUT
	MYSQL_OPT_COMPRESS
	MYSQL_OPT_NAMED_PIPE
	MYSQL_INIT_COMMAND
	MYSQL_READ_DEFAULT_FILE
	MYSQL_READ_DEFAULT_GROUP
	MYSQL_SET_CHARSET_DIR
	MYSQL_SET_CHARSET_NAME
	MYSQL_OPT_LOCAL_INFILE
end enum

enum mysql_status
	MYSQL_STATUS_READY
	MYSQL_STATUS_GET_RESULT
	MYSQL_STATUS_USE_RESULT
end enum

enum mysql_rpl_type
	MYSQL_RPL_MASTER
	MYSQL_RPL_SLAVE
	MYSQL_RPL_ADMIN
end enum

type st_mysql
	net as NET
	connector_fd as gptr
	host as zstring ptr
	user as zstring ptr
	passwd as zstring ptr
	unix_socket as byte ptr
	server_version as zstring ptr
	host_info as zstring ptr
	info as zstring ptr
	db as zstring ptr
	charset as charset_info_st ptr
	fields as MYSQL_FIELD ptr
	field_alloc as MEM_ROOT
	affected_rows as my_ulonglong
	insert_id as my_ulonglong
	extra_info as my_ulonglong
	thread_id as uinteger
	packet_length as uinteger
	port as uinteger
	client_flag as uinteger
	server_capabilities as uinteger
	protocol_version_ as uinteger
	field_count as uinteger
	server_status as uinteger
	server_language as uinteger
	options as st_mysql_options
	status as mysql_status
	free_me as my_bool
	reconnect as my_bool
	scramble_buff as string * 9-1
	rpl_pivot as my_bool
	master as st_mysql ptr
	next_slave as st_mysql ptr
	last_used_slave as st_mysql ptr
	last_used_con as st_mysql ptr
end type

type MYSQL as st_mysql

type st_mysql_res
	row_count as my_ulonglong
	fields as MYSQL_FIELD ptr
	data as MYSQL_DATA ptr
	data_cursor as MYSQL_ROWS ptr
	lengths as uinteger ptr
	handle as MYSQL ptr
	field_alloc as MEM_ROOT
	field_count as uinteger
	current_field as uinteger
	row as MYSQL_ROW
	current_row as MYSQL_ROW
	eof as my_bool
end type

type MYSQL_RES as st_mysql_res

#define MAX_MYSQL_MANAGER_ERR 256
#define MAX_MYSQL_MANAGER_MSG 256
#define MANAGER_OK 200
#define MANAGER_INFO 250
#define MANAGER_ACCESS 401
#define MANAGER_CLIENT_ERR 450
#define MANAGER_INTERNAL_ERR 500

type st_mysql_manager
	net as NET
	host as zstring ptr
	user as zstring ptr
	passwd as zstring ptr
	port as uinteger
	free_me as my_bool
	eof as my_bool
	cmd_status as integer
	last_errno as integer
	net_buf as byte ptr
	net_buf_pos as byte ptr
	net_data_end as byte ptr
	net_buf_size as integer
	last_error as string * 256-1
end type

type MYSQL_MANAGER as st_mysql_manager

declare function mysql_server_init alias "mysql_server_init" (byval argc as integer, byval argv as byte ptr ptr, byval groups as byte ptr ptr) as integer
declare sub mysql_server_end alias "mysql_server_end" ()
declare function mysql_thread_init alias "mysql_thread_init" () as my_bool
declare sub mysql_thread_end alias "mysql_thread_end" ()
declare function mysql_num_rows alias "mysql_num_rows" (byval res as MYSQL_RES ptr) as my_ulonglong
declare function mysql_num_fields alias "mysql_num_fields" (byval res as MYSQL_RES ptr) as uinteger
declare function mysql_eof alias "mysql_eof" (byval res as MYSQL_RES ptr) as my_bool
declare function mysql_fetch_field_direct alias "mysql_fetch_field_direct" (byval res as MYSQL_RES ptr, byval fieldnr as uinteger) as MYSQL_FIELD ptr
declare function mysql_fetch_fields alias "mysql_fetch_fields" (byval res as MYSQL_RES ptr) as MYSQL_FIELD ptr
declare function mysql_row_tell alias "mysql_row_tell" (byval res as MYSQL_RES ptr) as MYSQL_ROW_OFFSET
declare function mysql_field_tell alias "mysql_field_tell" (byval res as MYSQL_RES ptr) as MYSQL_FIELD_OFFSET
declare function mysql_field_count alias "mysql_field_count" (byval mysql as MYSQL ptr) as uinteger
declare function mysql_affected_rows alias "mysql_affected_rows" (byval mysql as MYSQL ptr) as my_ulonglong
declare function mysql_insert_id alias "mysql_insert_id" (byval mysql as MYSQL ptr) as my_ulonglong
declare function mysql_errno alias "mysql_errno" (byval mysql as MYSQL ptr) as uinteger
declare function mysql_error alias "mysql_error" (byval mysql as MYSQL ptr) as zstring ptr
declare function mysql_info alias "mysql_info" (byval mysql as MYSQL ptr) as zstring ptr
declare function mysql_thread_id alias "mysql_thread_id" (byval mysql as MYSQL ptr) as uinteger
declare function mysql_character_set_name alias "mysql_character_set_name" (byval mysql as MYSQL ptr) as zstring ptr
declare function mysql_init alias "mysql_init" (byval mysql as MYSQL ptr) as MYSQL ptr
declare function mysql_ssl_set alias "mysql_ssl_set" (byval mysql as MYSQL ptr, byval key as zstring ptr, byval cert as zstring ptr, byval ca as zstring ptr, byval capath as zstring ptr, byval cipher as zstring ptr) as integer
declare function mysql_change_user alias "mysql_change_user" (byval mysql as MYSQL ptr, byval user as zstring ptr, byval passwd as zstring ptr, byval db as zstring ptr) as my_bool
declare function mysql_real_connect alias "mysql_real_connect" (byval mysql as MYSQL ptr, byval host as zstring ptr, byval user as zstring ptr, byval passwd as zstring ptr, byval db as zstring ptr, byval port as uinteger, byval unix_socket as zstring ptr, byval clientflag as uinteger) as MYSQL ptr
declare sub mysql_close alias "mysql_close" (byval sock as MYSQL ptr)
declare function mysql_select_db alias "mysql_select_db" (byval mysql as MYSQL ptr, byval db as zstring ptr) as integer
declare function mysql_query alias "mysql_query" (byval mysql as MYSQL ptr, byval q as zstring ptr) as integer
declare function mysql_send_query alias "mysql_send_query" (byval mysql as MYSQL ptr, byval q as zstring ptr, byval length as uinteger) as integer
declare function mysql_read_query_result alias "mysql_read_query_result" (byval mysql as MYSQL ptr) as integer
declare function mysql_real_query alias "mysql_real_query" (byval mysql as MYSQL ptr, byval q as zstring ptr, byval length as uinteger) as integer
declare function mysql_master_query alias "mysql_master_query" (byval mysql as MYSQL ptr, byval q as zstring ptr, byval length as uinteger) as integer
declare function mysql_master_send_query alias "mysql_master_send_query" (byval mysql as MYSQL ptr, byval q as zstring ptr, byval length as uinteger) as integer
declare function mysql_slave_query alias "mysql_slave_query" (byval mysql as MYSQL ptr, byval q as zstring ptr, byval length as uinteger) as integer
declare function mysql_slave_send_query alias "mysql_slave_send_query" (byval mysql as MYSQL ptr, byval q as zstring ptr, byval length as uinteger) as integer
declare sub mysql_enable_rpl_parse alias "mysql_enable_rpl_parse" (byval mysql as MYSQL ptr)
declare sub mysql_disable_rpl_parse alias "mysql_disable_rpl_parse" (byval mysql as MYSQL ptr)
declare function mysql_rpl_parse_enabled alias "mysql_rpl_parse_enabled" (byval mysql as MYSQL ptr) as integer
declare sub mysql_enable_reads_from_master alias "mysql_enable_reads_from_master" (byval mysql as MYSQL ptr)
declare sub mysql_disable_reads_from_master alias "mysql_disable_reads_from_master" (byval mysql as MYSQL ptr)
declare function mysql_reads_from_master_enabled alias "mysql_reads_from_master_enabled" (byval mysql as MYSQL ptr) as integer
declare function mysql_rpl_query_type alias "mysql_rpl_query_type" (byval q as zstring ptr, byval len as integer) as mysql_rpl_type
declare function mysql_rpl_probe alias "mysql_rpl_probe" (byval mysql as MYSQL ptr) as integer
declare function mysql_set_master alias "mysql_set_master" (byval mysql as MYSQL ptr, byval host as zstring ptr, byval port as uinteger, byval user as zstring ptr, byval passwd as zstring ptr) as integer
declare function mysql_add_slave alias "mysql_add_slave" (byval mysql as MYSQL ptr, byval host as zstring ptr, byval port as uinteger, byval user as zstring ptr, byval passwd as zstring ptr) as integer
declare function mysql_shutdown alias "mysql_shutdown" (byval mysql as MYSQL ptr) as integer
declare function mysql_dump_debug_info alias "mysql_dump_debug_info" (byval mysql as MYSQL ptr) as integer
declare function mysql_refresh alias "mysql_refresh" (byval mysql as MYSQL ptr, byval refresh_options as uinteger) as integer
declare function mysql_kill alias "mysql_kill" (byval mysql as MYSQL ptr, byval pid as uinteger) as integer
declare function mysql_ping alias "mysql_ping" (byval mysql as MYSQL ptr) as integer
declare function mysql_stat alias "mysql_stat" (byval mysql as MYSQL ptr) as zstring ptr
declare function mysql_get_server_info alias "mysql_get_server_info" (byval mysql as MYSQL ptr) as zstring ptr
declare function mysql_get_client_info alias "mysql_get_client_info" () as zstring ptr
declare function mysql_get_client_version alias "mysql_get_client_version" () as uinteger
declare function mysql_get_host_info alias "mysql_get_host_info" (byval mysql as MYSQL ptr) as zstring ptr
declare function mysql_get_proto_info alias "mysql_get_proto_info" (byval mysql as MYSQL ptr) as uinteger
declare function mysql_list_dbs alias "mysql_list_dbs" (byval mysql as MYSQL ptr, byval wild as zstring ptr) as MYSQL_RES ptr
declare function mysql_list_tables alias "mysql_list_tables" (byval mysql as MYSQL ptr, byval wild as zstring ptr) as MYSQL_RES ptr
declare function mysql_list_fields alias "mysql_list_fields" (byval mysql as MYSQL ptr, byval table as zstring ptr, byval wild as zstring ptr) as MYSQL_RES ptr
declare function mysql_list_processes alias "mysql_list_processes" (byval mysql as MYSQL ptr) as MYSQL_RES ptr
declare function mysql_store_result alias "mysql_store_result" (byval mysql as MYSQL ptr) as MYSQL_RES ptr
declare function mysql_use_result alias "mysql_use_result" (byval mysql as MYSQL ptr) as MYSQL_RES ptr
declare function mysql_options alias "mysql_options" (byval mysql as MYSQL ptr, byval option as mysql_option, byval arg as zstring ptr) as integer
declare sub mysql_free_result alias "mysql_free_result" (byval result as MYSQL_RES ptr)
declare sub mysql_data_seek alias "mysql_data_seek" (byval result as MYSQL_RES ptr, byval offset as my_ulonglong)
declare function mysql_row_seek alias "mysql_row_seek" (byval result as MYSQL_RES ptr, byval offset as MYSQL_ROW_OFFSET) as MYSQL_ROW_OFFSET
declare function mysql_field_seek alias "mysql_field_seek" (byval result as MYSQL_RES ptr, byval offset as MYSQL_FIELD_OFFSET) as MYSQL_FIELD_OFFSET
declare function mysql_fetch_row alias "mysql_fetch_row" (byval result as MYSQL_RES ptr) as MYSQL_ROW
declare function mysql_fetch_lengths alias "mysql_fetch_lengths" (byval result as MYSQL_RES ptr) as uinteger ptr
declare function mysql_fetch_field alias "mysql_fetch_field" (byval result as MYSQL_RES ptr) as MYSQL_FIELD ptr
declare function mysql_escape_string alias "mysql_escape_string" (byval to as zstring ptr, byval from as zstring ptr, byval from_length as uinteger) as uinteger
declare function mysql_real_escape_string alias "mysql_real_escape_string" (byval mysql as MYSQL ptr, byval to as zstring ptr, byval from as zstring ptr, byval length as uinteger) as uinteger
declare sub mysql_debug alias "mysql_debug" (byval debug as zstring ptr)
declare function mysql_odbc_escape_string alias "mysql_odbc_escape_string" (byval mysql as MYSQL ptr, byval to as zstring ptr, byval to_length as uinteger, byval from as zstring ptr, byval from_length as uinteger, byval param as any ptr, byval extend_buffer as function(byval as any ptr, byval as zstring ptr, byval as uinteger ptr) as byte) as zstring ptr
declare sub myodbc_remove_escape alias "myodbc_remove_escape" (byval mysql as MYSQL ptr, byval name as zstring ptr)
declare function mysql_thread_safe alias "mysql_thread_safe" () as uinteger
declare function mysql_manager_init alias "mysql_manager_init" (byval con as MYSQL_MANAGER ptr) as MYSQL_MANAGER ptr
declare function mysql_manager_connect alias "mysql_manager_connect" (byval con as MYSQL_MANAGER ptr, byval host as zstring ptr, byval user as zstring ptr, byval passwd as zstring ptr, byval port as uinteger) as MYSQL_MANAGER ptr
declare sub mysql_manager_close alias "mysql_manager_close" (byval con as MYSQL_MANAGER ptr)
declare function mysql_manager_command alias "mysql_manager_command" (byval con as MYSQL_MANAGER ptr, byval cmd as zstring ptr, byval cmd_len as integer) as integer
declare function mysql_manager_fetch_line alias "mysql_manager_fetch_line" (byval con as MYSQL_MANAGER ptr, byval res_buf as zstring ptr, byval res_buf_size as integer) as integer
declare function simple_command alias "simple_command" (byval mysql as MYSQL ptr, byval command as enum_server_command, byval arg as zstring ptr, byval length as uinteger, byval skipp_check as my_bool) as integer
declare function net_safe_read alias "net_safe_read" (byval mysql as MYSQL ptr) as uinteger
declare function mysql_once_init alias "mysql_once_init" () as integer

#endif
