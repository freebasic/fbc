'' FreeBASIC binding for SQLite 3.34.0
''
'' based on the C header files:
''   * 2006 June 7
''   *
''   * The author disclaims copyright to this source code.  In place of
''   * a legal notice, here is a blessing:
''   *
''   *    May you do good and not evil.
''   *    May you find forgiveness for yourself and forgive others.
''   *    May you share freely, never taking more than you give.
''   *
''   ************************************************************************
''   * This header file defines the SQLite interface for use by
''   * shared libraries that want to be imported as extensions into
''   * an SQLite instance.  Shared libraries that intend to be loaded
''   * as extensions by SQLite should #include this file instead of 
''   * sqlite3.h.
''
'' translated to FreeBASIC by:
''   Copyright © 2020 FreeBASIC development team

#pragma once

#include once "sqlite3.bi"

extern "C"

#define SQLITE3EXT_H

type sqlite3_api_routines
	aggregate_context as function(byval as sqlite3_context ptr, byval nBytes as long) as any ptr
	aggregate_count as function(byval as sqlite3_context ptr) as long
	bind_blob as function(byval as sqlite3_stmt ptr, byval as long, byval as const any ptr, byval n as long, byval as sub(byval as any ptr)) as long
	bind_double as function(byval as sqlite3_stmt ptr, byval as long, byval as double) as long
	bind_int as function(byval as sqlite3_stmt ptr, byval as long, byval as long) as long
	bind_int64 as function(byval as sqlite3_stmt ptr, byval as long, byval as sqlite_int64) as long
	bind_null as function(byval as sqlite3_stmt ptr, byval as long) as long
	bind_parameter_count as function(byval as sqlite3_stmt ptr) as long
	bind_parameter_index as function(byval as sqlite3_stmt ptr, byval zName as const zstring ptr) as long
	bind_parameter_name as function(byval as sqlite3_stmt ptr, byval as long) as const zstring ptr
	bind_text as function(byval as sqlite3_stmt ptr, byval as long, byval as const zstring ptr, byval n as long, byval as sub(byval as any ptr)) as long
	bind_text16 as function(byval as sqlite3_stmt ptr, byval as long, byval as const any ptr, byval as long, byval as sub(byval as any ptr)) as long
	bind_value as function(byval as sqlite3_stmt ptr, byval as long, byval as const sqlite3_value ptr) as long
	busy_handler as function(byval as sqlite3 ptr, byval as function(byval as any ptr, byval as long) as long, byval as any ptr) as long
	busy_timeout as function(byval as sqlite3 ptr, byval ms as long) as long
	changes as function(byval as sqlite3 ptr) as long
	close as function(byval as sqlite3 ptr) as long
	collation_needed as function(byval as sqlite3 ptr, byval as any ptr, byval as sub(byval as any ptr, byval as sqlite3 ptr, byval eTextRep as long, byval as const zstring ptr)) as long
	collation_needed16 as function(byval as sqlite3 ptr, byval as any ptr, byval as sub(byval as any ptr, byval as sqlite3 ptr, byval eTextRep as long, byval as const any ptr)) as long
	column_blob as function(byval as sqlite3_stmt ptr, byval iCol as long) as const any ptr
	column_bytes as function(byval as sqlite3_stmt ptr, byval iCol as long) as long
	column_bytes16 as function(byval as sqlite3_stmt ptr, byval iCol as long) as long
	column_count as function(byval pStmt as sqlite3_stmt ptr) as long
	column_database_name as function(byval as sqlite3_stmt ptr, byval as long) as const zstring ptr
	column_database_name16 as function(byval as sqlite3_stmt ptr, byval as long) as const any ptr
	column_decltype as function(byval as sqlite3_stmt ptr, byval i as long) as const zstring ptr
	column_decltype16 as function(byval as sqlite3_stmt ptr, byval as long) as const any ptr
	column_double as function(byval as sqlite3_stmt ptr, byval iCol as long) as double
	column_int as function(byval as sqlite3_stmt ptr, byval iCol as long) as long
	column_int64 as function(byval as sqlite3_stmt ptr, byval iCol as long) as sqlite_int64
	column_name as function(byval as sqlite3_stmt ptr, byval as long) as const zstring ptr
	column_name16 as function(byval as sqlite3_stmt ptr, byval as long) as const any ptr
	column_origin_name as function(byval as sqlite3_stmt ptr, byval as long) as const zstring ptr
	column_origin_name16 as function(byval as sqlite3_stmt ptr, byval as long) as const any ptr
	column_table_name as function(byval as sqlite3_stmt ptr, byval as long) as const zstring ptr
	column_table_name16 as function(byval as sqlite3_stmt ptr, byval as long) as const any ptr
	column_text as function(byval as sqlite3_stmt ptr, byval iCol as long) as const ubyte ptr
	column_text16 as function(byval as sqlite3_stmt ptr, byval iCol as long) as const any ptr
	column_type as function(byval as sqlite3_stmt ptr, byval iCol as long) as long
	column_value as function(byval as sqlite3_stmt ptr, byval iCol as long) as sqlite3_value ptr
	commit_hook as function(byval as sqlite3 ptr, byval as function(byval as any ptr) as long, byval as any ptr) as any ptr
	complete as function(byval sql as const zstring ptr) as long
	complete16 as function(byval sql as const any ptr) as long
	create_collation as function(byval as sqlite3 ptr, byval as const zstring ptr, byval as long, byval as any ptr, byval as function(byval as any ptr, byval as long, byval as const any ptr, byval as long, byval as const any ptr) as long) as long
	create_collation16 as function(byval as sqlite3 ptr, byval as const any ptr, byval as long, byval as any ptr, byval as function(byval as any ptr, byval as long, byval as const any ptr, byval as long, byval as const any ptr) as long) as long
	create_function as function(byval as sqlite3 ptr, byval as const zstring ptr, byval as long, byval as long, byval as any ptr, byval xFunc as sub(byval as sqlite3_context ptr, byval as long, byval as sqlite3_value ptr ptr), byval xStep as sub(byval as sqlite3_context ptr, byval as long, byval as sqlite3_value ptr ptr), byval xFinal as sub(byval as sqlite3_context ptr)) as long
	create_function16 as function(byval as sqlite3 ptr, byval as const any ptr, byval as long, byval as long, byval as any ptr, byval xFunc as sub(byval as sqlite3_context ptr, byval as long, byval as sqlite3_value ptr ptr), byval xStep as sub(byval as sqlite3_context ptr, byval as long, byval as sqlite3_value ptr ptr), byval xFinal as sub(byval as sqlite3_context ptr)) as long
	create_module as function(byval as sqlite3 ptr, byval as const zstring ptr, byval as const sqlite3_module ptr, byval as any ptr) as long
	data_count as function(byval pStmt as sqlite3_stmt ptr) as long
	db_handle as function(byval as sqlite3_stmt ptr) as sqlite3 ptr
	declare_vtab as function(byval as sqlite3 ptr, byval as const zstring ptr) as long
	enable_shared_cache as function(byval as long) as long
	errcode as function(byval db as sqlite3 ptr) as long
	errmsg as function(byval as sqlite3 ptr) as const zstring ptr
	errmsg16 as function(byval as sqlite3 ptr) as const any ptr
	exec as function(byval as sqlite3 ptr, byval as const zstring ptr, byval as sqlite3_callback, byval as any ptr, byval as zstring ptr ptr) as long
	expired as function(byval as sqlite3_stmt ptr) as long
	finalize as function(byval pStmt as sqlite3_stmt ptr) as long
	free as sub(byval as any ptr)
	free_table as sub(byval result as zstring ptr ptr)
	get_autocommit as function(byval as sqlite3 ptr) as long
	get_auxdata as function(byval as sqlite3_context ptr, byval as long) as any ptr
	get_table as function(byval as sqlite3 ptr, byval as const zstring ptr, byval as zstring ptr ptr ptr, byval as long ptr, byval as long ptr, byval as zstring ptr ptr) as long
	global_recover as function() as long
	interruptx as sub(byval as sqlite3 ptr)
	last_insert_rowid as function(byval as sqlite3 ptr) as sqlite_int64
	libversion as function() as const zstring ptr
	libversion_number as function() as long
	malloc as function(byval as long) as any ptr
	mprintf as function(byval as const zstring ptr, ...) as zstring ptr
	open as function(byval as const zstring ptr, byval as sqlite3 ptr ptr) as long
	open16 as function(byval as const any ptr, byval as sqlite3 ptr ptr) as long
	prepare as function(byval as sqlite3 ptr, byval as const zstring ptr, byval as long, byval as sqlite3_stmt ptr ptr, byval as const zstring ptr ptr) as long
	prepare16 as function(byval as sqlite3 ptr, byval as const any ptr, byval as long, byval as sqlite3_stmt ptr ptr, byval as const any ptr ptr) as long
	profile as function(byval as sqlite3 ptr, byval as sub(byval as any ptr, byval as const zstring ptr, byval as sqlite_uint64), byval as any ptr) as any ptr
	progress_handler as sub(byval as sqlite3 ptr, byval as long, byval as function(byval as any ptr) as long, byval as any ptr)
	realloc as function(byval as any ptr, byval as long) as any ptr
	reset as function(byval pStmt as sqlite3_stmt ptr) as long
	result_blob as sub(byval as sqlite3_context ptr, byval as const any ptr, byval as long, byval as sub(byval as any ptr))
	result_double as sub(byval as sqlite3_context ptr, byval as double)
	result_error as sub(byval as sqlite3_context ptr, byval as const zstring ptr, byval as long)
	result_error16 as sub(byval as sqlite3_context ptr, byval as const any ptr, byval as long)
	result_int as sub(byval as sqlite3_context ptr, byval as long)
	result_int64 as sub(byval as sqlite3_context ptr, byval as sqlite_int64)
	result_null as sub(byval as sqlite3_context ptr)
	result_text as sub(byval as sqlite3_context ptr, byval as const zstring ptr, byval as long, byval as sub(byval as any ptr))
	result_text16 as sub(byval as sqlite3_context ptr, byval as const any ptr, byval as long, byval as sub(byval as any ptr))
	result_text16be as sub(byval as sqlite3_context ptr, byval as const any ptr, byval as long, byval as sub(byval as any ptr))
	result_text16le as sub(byval as sqlite3_context ptr, byval as const any ptr, byval as long, byval as sub(byval as any ptr))
	result_value as sub(byval as sqlite3_context ptr, byval as sqlite3_value ptr)
	rollback_hook as function(byval as sqlite3 ptr, byval as sub(byval as any ptr), byval as any ptr) as any ptr
	set_authorizer as function(byval as sqlite3 ptr, byval as function(byval as any ptr, byval as long, byval as const zstring ptr, byval as const zstring ptr, byval as const zstring ptr, byval as const zstring ptr) as long, byval as any ptr) as long
	set_auxdata as sub(byval as sqlite3_context ptr, byval as long, byval as any ptr, byval as sub(byval as any ptr))
	xsnprintf as function(byval as long, byval as zstring ptr, byval as const zstring ptr, ...) as zstring ptr
	step as function(byval as sqlite3_stmt ptr) as long
	table_column_metadata as function(byval as sqlite3 ptr, byval as const zstring ptr, byval as const zstring ptr, byval as const zstring ptr, byval as const zstring ptr ptr, byval as const zstring ptr ptr, byval as long ptr, byval as long ptr, byval as long ptr) as long
	thread_cleanup as sub()
	total_changes as function(byval as sqlite3 ptr) as long
	trace as function(byval as sqlite3 ptr, byval xTrace as sub(byval as any ptr, byval as const zstring ptr), byval as any ptr) as any ptr
	transfer_bindings as function(byval as sqlite3_stmt ptr, byval as sqlite3_stmt ptr) as long
	update_hook as function(byval as sqlite3 ptr, byval as sub(byval as any ptr, byval as long, byval as const zstring ptr, byval as const zstring ptr, byval as sqlite_int64), byval as any ptr) as any ptr
	user_data as function(byval as sqlite3_context ptr) as any ptr
	value_blob as function(byval as sqlite3_value ptr) as const any ptr
	value_bytes as function(byval as sqlite3_value ptr) as long
	value_bytes16 as function(byval as sqlite3_value ptr) as long
	value_double as function(byval as sqlite3_value ptr) as double
	value_int as function(byval as sqlite3_value ptr) as long
	value_int64 as function(byval as sqlite3_value ptr) as sqlite_int64
	value_numeric_type as function(byval as sqlite3_value ptr) as long
	value_text as function(byval as sqlite3_value ptr) as const ubyte ptr
	value_text16 as function(byval as sqlite3_value ptr) as const any ptr
	value_text16be as function(byval as sqlite3_value ptr) as const any ptr
	value_text16le as function(byval as sqlite3_value ptr) as const any ptr
	value_type as function(byval as sqlite3_value ptr) as long
	vmprintf as function(byval as const zstring ptr, byval as va_list) as zstring ptr
	overload_function as function(byval as sqlite3 ptr, byval zFuncName as const zstring ptr, byval nArg as long) as long
	prepare_v2 as function(byval as sqlite3 ptr, byval as const zstring ptr, byval as long, byval as sqlite3_stmt ptr ptr, byval as const zstring ptr ptr) as long
	prepare16_v2 as function(byval as sqlite3 ptr, byval as const any ptr, byval as long, byval as sqlite3_stmt ptr ptr, byval as const any ptr ptr) as long
	clear_bindings as function(byval as sqlite3_stmt ptr) as long
	create_module_v2 as function(byval as sqlite3 ptr, byval as const zstring ptr, byval as const sqlite3_module ptr, byval as any ptr, byval xDestroy as sub(byval as any ptr)) as long
	bind_zeroblob as function(byval as sqlite3_stmt ptr, byval as long, byval as long) as long
	blob_bytes as function(byval as sqlite3_blob ptr) as long
	blob_close as function(byval as sqlite3_blob ptr) as long
	blob_open as function(byval as sqlite3 ptr, byval as const zstring ptr, byval as const zstring ptr, byval as const zstring ptr, byval as sqlite3_int64, byval as long, byval as sqlite3_blob ptr ptr) as long
	blob_read as function(byval as sqlite3_blob ptr, byval as any ptr, byval as long, byval as long) as long
	blob_write as function(byval as sqlite3_blob ptr, byval as const any ptr, byval as long, byval as long) as long
	create_collation_v2 as function(byval as sqlite3 ptr, byval as const zstring ptr, byval as long, byval as any ptr, byval as function(byval as any ptr, byval as long, byval as const any ptr, byval as long, byval as const any ptr) as long, byval as sub(byval as any ptr)) as long
	file_control as function(byval as sqlite3 ptr, byval as const zstring ptr, byval as long, byval as any ptr) as long
	memory_highwater as function(byval as long) as sqlite3_int64
	memory_used as function() as sqlite3_int64
	mutex_alloc as function(byval as long) as sqlite3_mutex ptr
	mutex_enter as sub(byval as sqlite3_mutex ptr)
	mutex_free as sub(byval as sqlite3_mutex ptr)
	mutex_leave as sub(byval as sqlite3_mutex ptr)
	mutex_try as function(byval as sqlite3_mutex ptr) as long
	open_v2 as function(byval as const zstring ptr, byval as sqlite3 ptr ptr, byval as long, byval as const zstring ptr) as long
	release_memory as function(byval as long) as long
	result_error_nomem as sub(byval as sqlite3_context ptr)
	result_error_toobig as sub(byval as sqlite3_context ptr)
	sleep as function(byval as long) as long
	soft_heap_limit as sub(byval as long)
	vfs_find as function(byval as const zstring ptr) as sqlite3_vfs ptr
	vfs_register as function(byval as sqlite3_vfs ptr, byval as long) as long
	vfs_unregister as function(byval as sqlite3_vfs ptr) as long
	xthreadsafe as function() as long
	result_zeroblob as sub(byval as sqlite3_context ptr, byval as long)
	result_error_code as sub(byval as sqlite3_context ptr, byval as long)
	test_control as function(byval as long, ...) as long
	randomness as sub(byval as long, byval as any ptr)
	context_db_handle as function(byval as sqlite3_context ptr) as sqlite3 ptr
	extended_result_codes as function(byval as sqlite3 ptr, byval as long) as long
	limit as function(byval as sqlite3 ptr, byval as long, byval as long) as long
	next_stmt as function(byval as sqlite3 ptr, byval as sqlite3_stmt ptr) as sqlite3_stmt ptr
	sql as function(byval as sqlite3_stmt ptr) as const zstring ptr
	status as function(byval as long, byval as long ptr, byval as long ptr, byval as long) as long
	backup_finish as function(byval as sqlite3_backup ptr) as long
	backup_init as function(byval as sqlite3 ptr, byval as const zstring ptr, byval as sqlite3 ptr, byval as const zstring ptr) as sqlite3_backup ptr
	backup_pagecount as function(byval as sqlite3_backup ptr) as long
	backup_remaining as function(byval as sqlite3_backup ptr) as long
	backup_step as function(byval as sqlite3_backup ptr, byval as long) as long
	compileoption_get as function(byval as long) as const zstring ptr
	compileoption_used as function(byval as const zstring ptr) as long
	create_function_v2 as function(byval as sqlite3 ptr, byval as const zstring ptr, byval as long, byval as long, byval as any ptr, byval xFunc as sub(byval as sqlite3_context ptr, byval as long, byval as sqlite3_value ptr ptr), byval xStep as sub(byval as sqlite3_context ptr, byval as long, byval as sqlite3_value ptr ptr), byval xFinal as sub(byval as sqlite3_context ptr), byval xDestroy as sub(byval as any ptr)) as long
	db_config as function(byval as sqlite3 ptr, byval as long, ...) as long
	db_mutex as function(byval as sqlite3 ptr) as sqlite3_mutex ptr
	db_status as function(byval as sqlite3 ptr, byval as long, byval as long ptr, byval as long ptr, byval as long) as long
	extended_errcode as function(byval as sqlite3 ptr) as long
	log as sub(byval as long, byval as const zstring ptr, ...)
	soft_heap_limit64 as function(byval as sqlite3_int64) as sqlite3_int64
	sourceid as function() as const zstring ptr
	stmt_status as function(byval as sqlite3_stmt ptr, byval as long, byval as long) as long
	strnicmp as function(byval as const zstring ptr, byval as const zstring ptr, byval as long) as long
	unlock_notify as function(byval as sqlite3 ptr, byval as sub(byval as any ptr ptr, byval as long), byval as any ptr) as long
	wal_autocheckpoint as function(byval as sqlite3 ptr, byval as long) as long
	wal_checkpoint as function(byval as sqlite3 ptr, byval as const zstring ptr) as long
	wal_hook as function(byval as sqlite3 ptr, byval as function(byval as any ptr, byval as sqlite3 ptr, byval as const zstring ptr, byval as long) as long, byval as any ptr) as any ptr
	blob_reopen as function(byval as sqlite3_blob ptr, byval as sqlite3_int64) as long
	vtab_config as function(byval as sqlite3 ptr, byval op as long, ...) as long
	vtab_on_conflict as function(byval as sqlite3 ptr) as long
	close_v2 as function(byval as sqlite3 ptr) as long
	db_filename as function(byval as sqlite3 ptr, byval as const zstring ptr) as const zstring ptr
	db_readonly as function(byval as sqlite3 ptr, byval as const zstring ptr) as long
	db_release_memory as function(byval as sqlite3 ptr) as long
	errstr as function(byval as long) as const zstring ptr
	stmt_busy as function(byval as sqlite3_stmt ptr) as long
	stmt_readonly as function(byval as sqlite3_stmt ptr) as long
	stricmp as function(byval as const zstring ptr, byval as const zstring ptr) as long
	uri_boolean as function(byval as const zstring ptr, byval as const zstring ptr, byval as long) as long
	uri_int64 as function(byval as const zstring ptr, byval as const zstring ptr, byval as sqlite3_int64) as sqlite3_int64
	uri_parameter as function(byval as const zstring ptr, byval as const zstring ptr) as const zstring ptr
	xvsnprintf as function(byval as long, byval as zstring ptr, byval as const zstring ptr, byval as va_list) as zstring ptr
	wal_checkpoint_v2 as function(byval as sqlite3 ptr, byval as const zstring ptr, byval as long, byval as long ptr, byval as long ptr) as long
	auto_extension as function(byval as sub()) as long
	bind_blob64 as function(byval as sqlite3_stmt ptr, byval as long, byval as const any ptr, byval as sqlite3_uint64, byval as sub(byval as any ptr)) as long
	bind_text64 as function(byval as sqlite3_stmt ptr, byval as long, byval as const zstring ptr, byval as sqlite3_uint64, byval as sub(byval as any ptr), byval as ubyte) as long
	cancel_auto_extension as function(byval as sub()) as long
	load_extension as function(byval as sqlite3 ptr, byval as const zstring ptr, byval as const zstring ptr, byval as zstring ptr ptr) as long
	malloc64 as function(byval as sqlite3_uint64) as any ptr
	msize as function(byval as any ptr) as sqlite3_uint64
	realloc64 as function(byval as any ptr, byval as sqlite3_uint64) as any ptr
	reset_auto_extension as sub()
	result_blob64 as sub(byval as sqlite3_context ptr, byval as const any ptr, byval as sqlite3_uint64, byval as sub(byval as any ptr))
	result_text64 as sub(byval as sqlite3_context ptr, byval as const zstring ptr, byval as sqlite3_uint64, byval as sub(byval as any ptr), byval as ubyte)
	strglob as function(byval as const zstring ptr, byval as const zstring ptr) as long
	value_dup as function(byval as const sqlite3_value ptr) as sqlite3_value ptr
	value_free as sub(byval as sqlite3_value ptr)
	result_zeroblob64 as function(byval as sqlite3_context ptr, byval as sqlite3_uint64) as long
	bind_zeroblob64 as function(byval as sqlite3_stmt ptr, byval as long, byval as sqlite3_uint64) as long
	value_subtype as function(byval as sqlite3_value ptr) as ulong
	result_subtype as sub(byval as sqlite3_context ptr, byval as ulong)
	status64 as function(byval as long, byval as sqlite3_int64 ptr, byval as sqlite3_int64 ptr, byval as long) as long
	strlike as function(byval as const zstring ptr, byval as const zstring ptr, byval as ulong) as long
	db_cacheflush as function(byval as sqlite3 ptr) as long
	system_errno as function(byval as sqlite3 ptr) as long
	trace_v2 as function(byval as sqlite3 ptr, byval as ulong, byval as function(byval as ulong, byval as any ptr, byval as any ptr, byval as any ptr) as long, byval as any ptr) as long
	expanded_sql as function(byval as sqlite3_stmt ptr) as zstring ptr
	set_last_insert_rowid as sub(byval as sqlite3 ptr, byval as sqlite3_int64)
	prepare_v3 as function(byval as sqlite3 ptr, byval as const zstring ptr, byval as long, byval as ulong, byval as sqlite3_stmt ptr ptr, byval as const zstring ptr ptr) as long
	prepare16_v3 as function(byval as sqlite3 ptr, byval as const any ptr, byval as long, byval as ulong, byval as sqlite3_stmt ptr ptr, byval as const any ptr ptr) as long
	bind_pointer as function(byval as sqlite3_stmt ptr, byval as long, byval as any ptr, byval as const zstring ptr, byval as sub(byval as any ptr)) as long
	result_pointer as sub(byval as sqlite3_context ptr, byval as any ptr, byval as const zstring ptr, byval as sub(byval as any ptr))
	value_pointer as function(byval as sqlite3_value ptr, byval as const zstring ptr) as any ptr
	vtab_nochange as function(byval as sqlite3_context ptr) as long
	value_nochange as function(byval as sqlite3_value ptr) as long
	vtab_collation as function(byval as sqlite3_index_info ptr, byval as long) as const zstring ptr
	keyword_count as function() as long
	keyword_name as function(byval as long, byval as const zstring ptr ptr, byval as long ptr) as long
	keyword_check as function(byval as const zstring ptr, byval as long) as long
	str_new as function(byval as sqlite3 ptr) as sqlite3_str ptr
	str_finish as function(byval as sqlite3_str ptr) as zstring ptr
	str_appendf as sub(byval as sqlite3_str ptr, byval zFormat as const zstring ptr, ...)
	str_vappendf as sub(byval as sqlite3_str ptr, byval zFormat as const zstring ptr, byval as va_list)
	str_append as sub(byval as sqlite3_str ptr, byval zIn as const zstring ptr, byval N as long)
	str_appendall as sub(byval as sqlite3_str ptr, byval zIn as const zstring ptr)
	str_appendchar as sub(byval as sqlite3_str ptr, byval N as long, byval C as byte)
	str_reset as sub(byval as sqlite3_str ptr)
	str_errcode as function(byval as sqlite3_str ptr) as long
	str_length as function(byval as sqlite3_str ptr) as long
	str_value as function(byval as sqlite3_str ptr) as zstring ptr
	create_window_function as function(byval as sqlite3 ptr, byval as const zstring ptr, byval as long, byval as long, byval as any ptr, byval xStep as sub(byval as sqlite3_context ptr, byval as long, byval as sqlite3_value ptr ptr), byval xFinal as sub(byval as sqlite3_context ptr), byval xValue as sub(byval as sqlite3_context ptr), byval xInv as sub(byval as sqlite3_context ptr, byval as long, byval as sqlite3_value ptr ptr), byval xDestroy as sub(byval as any ptr)) as long
	normalized_sql as function(byval as sqlite3_stmt ptr) as const zstring ptr
	stmt_isexplain as function(byval as sqlite3_stmt ptr) as long
	value_frombind as function(byval as sqlite3_value ptr) as long
	drop_modules as function(byval as sqlite3 ptr, byval as const zstring ptr ptr) as long
	hard_heap_limit64 as function(byval as sqlite3_int64) as sqlite3_int64
	uri_key as function(byval as const zstring ptr, byval as long) as const zstring ptr
	filename_database as function(byval as const zstring ptr) as const zstring ptr
	filename_journal as function(byval as const zstring ptr) as const zstring ptr
	filename_wal as function(byval as const zstring ptr) as const zstring ptr
	create_filename as function(byval as const zstring ptr, byval as const zstring ptr, byval as const zstring ptr, byval as long, byval as const zstring ptr ptr) as zstring ptr
	free_filename as sub(byval as zstring ptr)
	database_file_object as function(byval as const zstring ptr) as sqlite3_file ptr
	txn_state as function(byval as sqlite3 ptr, byval as const zstring ptr) as long
end type

type sqlite3_loadext_entry as function(byval db as sqlite3 ptr, byval pzErrMsg as zstring ptr ptr, byval pThunk as const sqlite3_api_routines ptr) as long
#undef sqlite3_aggregate_context
#define sqlite3_aggregate_context sqlite3_api->aggregate_context
#undef sqlite3_aggregate_count
#define sqlite3_aggregate_count sqlite3_api->aggregate_count
#undef sqlite3_bind_blob
#define sqlite3_bind_blob sqlite3_api->bind_blob
#undef sqlite3_bind_double
#define sqlite3_bind_double sqlite3_api->bind_double
#undef sqlite3_bind_int
#define sqlite3_bind_int sqlite3_api->bind_int
#undef sqlite3_bind_int64
#define sqlite3_bind_int64 sqlite3_api->bind_int64
#undef sqlite3_bind_null
#define sqlite3_bind_null sqlite3_api->bind_null
#undef sqlite3_bind_parameter_count
#define sqlite3_bind_parameter_count sqlite3_api->bind_parameter_count
#undef sqlite3_bind_parameter_index
#define sqlite3_bind_parameter_index sqlite3_api->bind_parameter_index
#undef sqlite3_bind_parameter_name
#define sqlite3_bind_parameter_name sqlite3_api->bind_parameter_name
#undef sqlite3_bind_text
#define sqlite3_bind_text sqlite3_api->bind_text
#undef sqlite3_bind_text16
#define sqlite3_bind_text16 sqlite3_api->bind_text16
#undef sqlite3_bind_value
#define sqlite3_bind_value sqlite3_api->bind_value
#undef sqlite3_busy_handler
#define sqlite3_busy_handler sqlite3_api->busy_handler
#undef sqlite3_busy_timeout
#define sqlite3_busy_timeout sqlite3_api->busy_timeout
#undef sqlite3_changes
#define sqlite3_changes sqlite3_api->changes
#undef sqlite3_close
#define sqlite3_close sqlite3_api->close
#undef sqlite3_collation_needed
#define sqlite3_collation_needed sqlite3_api->collation_needed
#undef sqlite3_collation_needed16
#define sqlite3_collation_needed16 sqlite3_api->collation_needed16
#undef sqlite3_column_blob
#define sqlite3_column_blob sqlite3_api->column_blob
#undef sqlite3_column_bytes
#define sqlite3_column_bytes sqlite3_api->column_bytes
#undef sqlite3_column_bytes16
#define sqlite3_column_bytes16 sqlite3_api->column_bytes16
#undef sqlite3_column_count
#define sqlite3_column_count sqlite3_api->column_count
#undef sqlite3_column_database_name
#define sqlite3_column_database_name sqlite3_api->column_database_name
#undef sqlite3_column_database_name16
#define sqlite3_column_database_name16 sqlite3_api->column_database_name16
#undef sqlite3_column_decltype
#define sqlite3_column_decltype sqlite3_api->column_decltype
#undef sqlite3_column_decltype16
#define sqlite3_column_decltype16 sqlite3_api->column_decltype16
#undef sqlite3_column_double
#define sqlite3_column_double sqlite3_api->column_double
#undef sqlite3_column_int
#define sqlite3_column_int sqlite3_api->column_int
#undef sqlite3_column_int64
#define sqlite3_column_int64 sqlite3_api->column_int64
#undef sqlite3_column_name
#define sqlite3_column_name sqlite3_api->column_name
#undef sqlite3_column_name16
#define sqlite3_column_name16 sqlite3_api->column_name16
#undef sqlite3_column_origin_name
#define sqlite3_column_origin_name sqlite3_api->column_origin_name
#undef sqlite3_column_origin_name16
#define sqlite3_column_origin_name16 sqlite3_api->column_origin_name16
#undef sqlite3_column_table_name
#define sqlite3_column_table_name sqlite3_api->column_table_name
#undef sqlite3_column_table_name16
#define sqlite3_column_table_name16 sqlite3_api->column_table_name16
#undef sqlite3_column_text
#define sqlite3_column_text sqlite3_api->column_text
#undef sqlite3_column_text16
#define sqlite3_column_text16 sqlite3_api->column_text16
#undef sqlite3_column_type
#define sqlite3_column_type sqlite3_api->column_type
#undef sqlite3_column_value
#define sqlite3_column_value sqlite3_api->column_value
#undef sqlite3_commit_hook
#define sqlite3_commit_hook sqlite3_api->commit_hook
#undef sqlite3_complete
#define sqlite3_complete sqlite3_api->complete
#undef sqlite3_complete16
#define sqlite3_complete16 sqlite3_api->complete16
#undef sqlite3_create_collation
#define sqlite3_create_collation sqlite3_api->create_collation
#undef sqlite3_create_collation16
#define sqlite3_create_collation16 sqlite3_api->create_collation16
#undef sqlite3_create_function
#define sqlite3_create_function sqlite3_api->create_function
#undef sqlite3_create_function16
#define sqlite3_create_function16 sqlite3_api->create_function16
#undef sqlite3_create_module
#define sqlite3_create_module sqlite3_api->create_module
#undef sqlite3_create_module_v2
#define sqlite3_create_module_v2 sqlite3_api->create_module_v2
#undef sqlite3_data_count
#define sqlite3_data_count sqlite3_api->data_count
#undef sqlite3_db_handle
#define sqlite3_db_handle sqlite3_api->db_handle
#undef sqlite3_declare_vtab
#define sqlite3_declare_vtab sqlite3_api->declare_vtab
#undef sqlite3_enable_shared_cache
#define sqlite3_enable_shared_cache sqlite3_api->enable_shared_cache
#undef sqlite3_errcode
#define sqlite3_errcode sqlite3_api->errcode
#undef sqlite3_errmsg
#define sqlite3_errmsg sqlite3_api->errmsg
#undef sqlite3_errmsg16
#define sqlite3_errmsg16 sqlite3_api->errmsg16
#undef sqlite3_exec
#define sqlite3_exec sqlite3_api->exec
#undef sqlite3_expired
#define sqlite3_expired sqlite3_api->expired
#undef sqlite3_finalize
#define sqlite3_finalize sqlite3_api->finalize
#undef sqlite3_free
#define sqlite3_free sqlite3_api->free
#undef sqlite3_free_table
#define sqlite3_free_table sqlite3_api->free_table
#undef sqlite3_get_autocommit
#define sqlite3_get_autocommit sqlite3_api->get_autocommit
#undef sqlite3_get_auxdata
#define sqlite3_get_auxdata sqlite3_api->get_auxdata
#undef sqlite3_get_table
#define sqlite3_get_table sqlite3_api->get_table
#undef sqlite3_global_recover
#define sqlite3_global_recover sqlite3_api->global_recover
#undef sqlite3_interrupt
#define sqlite3_interrupt sqlite3_api->interruptx
#undef sqlite3_last_insert_rowid
#define sqlite3_last_insert_rowid sqlite3_api->last_insert_rowid
#undef sqlite3_libversion
#define sqlite3_libversion sqlite3_api->libversion
#undef sqlite3_libversion_number
#define sqlite3_libversion_number sqlite3_api->libversion_number
#undef sqlite3_malloc
#define sqlite3_malloc sqlite3_api->malloc
#undef sqlite3_mprintf
#define sqlite3_mprintf sqlite3_api->mprintf
#undef sqlite3_open
#define sqlite3_open sqlite3_api->open
#undef sqlite3_open16
#define sqlite3_open16 sqlite3_api->open16
#undef sqlite3_prepare
#define sqlite3_prepare sqlite3_api->prepare
#undef sqlite3_prepare16
#define sqlite3_prepare16 sqlite3_api->prepare16
#undef sqlite3_prepare_v2
#define sqlite3_prepare_v2 sqlite3_api->prepare_v2
#undef sqlite3_prepare16_v2
#define sqlite3_prepare16_v2 sqlite3_api->prepare16_v2
#undef sqlite3_profile
#define sqlite3_profile sqlite3_api->profile
#undef sqlite3_progress_handler
#define sqlite3_progress_handler sqlite3_api->progress_handler
#undef sqlite3_realloc
#define sqlite3_realloc sqlite3_api->realloc
#undef sqlite3_reset
#define sqlite3_reset sqlite3_api->reset
#undef sqlite3_result_blob
#define sqlite3_result_blob sqlite3_api->result_blob
#undef sqlite3_result_double
#define sqlite3_result_double sqlite3_api->result_double
#undef sqlite3_result_error
#define sqlite3_result_error sqlite3_api->result_error
#undef sqlite3_result_error16
#define sqlite3_result_error16 sqlite3_api->result_error16
#undef sqlite3_result_int
#define sqlite3_result_int sqlite3_api->result_int
#undef sqlite3_result_int64
#define sqlite3_result_int64 sqlite3_api->result_int64
#undef sqlite3_result_null
#define sqlite3_result_null sqlite3_api->result_null
#undef sqlite3_result_text
#define sqlite3_result_text sqlite3_api->result_text
#undef sqlite3_result_text16
#define sqlite3_result_text16 sqlite3_api->result_text16
#undef sqlite3_result_text16be
#define sqlite3_result_text16be sqlite3_api->result_text16be
#undef sqlite3_result_text16le
#define sqlite3_result_text16le sqlite3_api->result_text16le
#undef sqlite3_result_value
#define sqlite3_result_value sqlite3_api->result_value
#undef sqlite3_rollback_hook
#define sqlite3_rollback_hook sqlite3_api->rollback_hook
#undef sqlite3_set_authorizer
#define sqlite3_set_authorizer sqlite3_api->set_authorizer
#undef sqlite3_set_auxdata
#define sqlite3_set_auxdata sqlite3_api->set_auxdata
#undef sqlite3_snprintf
#define sqlite3_snprintf sqlite3_api->xsnprintf
#undef sqlite3_step
#define sqlite3_step sqlite3_api->step
#undef sqlite3_table_column_metadata
#define sqlite3_table_column_metadata sqlite3_api->table_column_metadata
#undef sqlite3_thread_cleanup
#define sqlite3_thread_cleanup sqlite3_api->thread_cleanup
#undef sqlite3_total_changes
#define sqlite3_total_changes sqlite3_api->total_changes
#undef sqlite3_trace
#define sqlite3_trace sqlite3_api->trace
#undef sqlite3_transfer_bindings
#define sqlite3_transfer_bindings sqlite3_api->transfer_bindings
#undef sqlite3_update_hook
#define sqlite3_update_hook sqlite3_api->update_hook
#undef sqlite3_user_data
#define sqlite3_user_data sqlite3_api->user_data
#undef sqlite3_value_blob
#define sqlite3_value_blob sqlite3_api->value_blob
#undef sqlite3_value_bytes
#define sqlite3_value_bytes sqlite3_api->value_bytes
#undef sqlite3_value_bytes16
#define sqlite3_value_bytes16 sqlite3_api->value_bytes16
#undef sqlite3_value_double
#define sqlite3_value_double sqlite3_api->value_double
#undef sqlite3_value_int
#define sqlite3_value_int sqlite3_api->value_int
#undef sqlite3_value_int64
#define sqlite3_value_int64 sqlite3_api->value_int64
#undef sqlite3_value_numeric_type
#define sqlite3_value_numeric_type sqlite3_api->value_numeric_type
#undef sqlite3_value_text
#define sqlite3_value_text sqlite3_api->value_text
#undef sqlite3_value_text16
#define sqlite3_value_text16 sqlite3_api->value_text16
#undef sqlite3_value_text16be
#define sqlite3_value_text16be sqlite3_api->value_text16be
#undef sqlite3_value_text16le
#define sqlite3_value_text16le sqlite3_api->value_text16le
#undef sqlite3_value_type
#define sqlite3_value_type sqlite3_api->value_type
#undef sqlite3_vmprintf
#define sqlite3_vmprintf sqlite3_api->vmprintf
#undef sqlite3_vsnprintf
#define sqlite3_vsnprintf sqlite3_api->xvsnprintf
#undef sqlite3_overload_function
#define sqlite3_overload_function sqlite3_api->overload_function
#undef sqlite3_prepare_v2
#define sqlite3_prepare_v2 sqlite3_api->prepare_v2
#undef sqlite3_prepare16_v2
#define sqlite3_prepare16_v2 sqlite3_api->prepare16_v2
#undef sqlite3_clear_bindings
#define sqlite3_clear_bindings sqlite3_api->clear_bindings
#undef sqlite3_bind_zeroblob
#define sqlite3_bind_zeroblob sqlite3_api->bind_zeroblob
#undef sqlite3_blob_bytes
#define sqlite3_blob_bytes sqlite3_api->blob_bytes
#undef sqlite3_blob_close
#define sqlite3_blob_close sqlite3_api->blob_close
#undef sqlite3_blob_open
#define sqlite3_blob_open sqlite3_api->blob_open
#undef sqlite3_blob_read
#define sqlite3_blob_read sqlite3_api->blob_read
#undef sqlite3_blob_write
#define sqlite3_blob_write sqlite3_api->blob_write
#undef sqlite3_create_collation_v2
#define sqlite3_create_collation_v2 sqlite3_api->create_collation_v2
#undef sqlite3_file_control
#define sqlite3_file_control sqlite3_api->file_control
#undef sqlite3_memory_highwater
#define sqlite3_memory_highwater sqlite3_api->memory_highwater
#undef sqlite3_memory_used
#define sqlite3_memory_used sqlite3_api->memory_used
#undef sqlite3_mutex_alloc
#define sqlite3_mutex_alloc sqlite3_api->mutex_alloc
#undef sqlite3_mutex_enter
#define sqlite3_mutex_enter sqlite3_api->mutex_enter
#undef sqlite3_mutex_free
#define sqlite3_mutex_free sqlite3_api->mutex_free
#undef sqlite3_mutex_leave
#define sqlite3_mutex_leave sqlite3_api->mutex_leave
#undef sqlite3_mutex_try
#define sqlite3_mutex_try sqlite3_api->mutex_try
#undef sqlite3_open_v2
#define sqlite3_open_v2 sqlite3_api->open_v2
#undef sqlite3_release_memory
#define sqlite3_release_memory sqlite3_api->release_memory
#undef sqlite3_result_error_nomem
#define sqlite3_result_error_nomem sqlite3_api->result_error_nomem
#undef sqlite3_result_error_toobig
#define sqlite3_result_error_toobig sqlite3_api->result_error_toobig
#undef sqlite3_sleep
#define sqlite3_sleep sqlite3_api->sleep
#undef sqlite3_soft_heap_limit
#define sqlite3_soft_heap_limit sqlite3_api->soft_heap_limit
#undef sqlite3_vfs_find
#define sqlite3_vfs_find sqlite3_api->vfs_find
#undef sqlite3_vfs_register
#define sqlite3_vfs_register sqlite3_api->vfs_register
#undef sqlite3_vfs_unregister
#define sqlite3_vfs_unregister sqlite3_api->vfs_unregister
#undef sqlite3_threadsafe
#define sqlite3_threadsafe sqlite3_api->xthreadsafe
#undef sqlite3_result_zeroblob
#define sqlite3_result_zeroblob sqlite3_api->result_zeroblob
#undef sqlite3_result_error_code
#define sqlite3_result_error_code sqlite3_api->result_error_code
#undef sqlite3_test_control
#define sqlite3_test_control sqlite3_api->test_control
#undef sqlite3_randomness
#define sqlite3_randomness sqlite3_api->randomness
#undef sqlite3_context_db_handle
#define sqlite3_context_db_handle sqlite3_api->context_db_handle
#undef sqlite3_extended_result_codes
#define sqlite3_extended_result_codes sqlite3_api->extended_result_codes
#undef sqlite3_limit
#define sqlite3_limit sqlite3_api->limit
#undef sqlite3_next_stmt
#define sqlite3_next_stmt sqlite3_api->next_stmt
#undef sqlite3_sql
#define sqlite3_sql sqlite3_api->sql
#undef sqlite3_status
#define sqlite3_status sqlite3_api->status
#undef sqlite3_backup_finish
#define sqlite3_backup_finish sqlite3_api->backup_finish
#undef sqlite3_backup_init
#define sqlite3_backup_init sqlite3_api->backup_init
#undef sqlite3_backup_pagecount
#define sqlite3_backup_pagecount sqlite3_api->backup_pagecount
#undef sqlite3_backup_remaining
#define sqlite3_backup_remaining sqlite3_api->backup_remaining
#undef sqlite3_backup_step
#define sqlite3_backup_step sqlite3_api->backup_step
#undef sqlite3_compileoption_get
#define sqlite3_compileoption_get sqlite3_api->compileoption_get
#undef sqlite3_compileoption_used
#define sqlite3_compileoption_used sqlite3_api->compileoption_used
#undef sqlite3_create_function_v2
#define sqlite3_create_function_v2 sqlite3_api->create_function_v2
#undef sqlite3_db_config
#define sqlite3_db_config sqlite3_api->db_config
#undef sqlite3_db_mutex
#define sqlite3_db_mutex sqlite3_api->db_mutex
#undef sqlite3_db_status
#define sqlite3_db_status sqlite3_api->db_status
#undef sqlite3_extended_errcode
#define sqlite3_extended_errcode sqlite3_api->extended_errcode
#undef sqlite3_log
#define sqlite3_log sqlite3_api->log
#undef sqlite3_soft_heap_limit64
#define sqlite3_soft_heap_limit64 sqlite3_api->soft_heap_limit64
#undef sqlite3_sourceid
#define sqlite3_sourceid sqlite3_api->sourceid
#undef sqlite3_stmt_status
#define sqlite3_stmt_status sqlite3_api->stmt_status
#undef sqlite3_strnicmp
#define sqlite3_strnicmp sqlite3_api->strnicmp
#undef sqlite3_unlock_notify
#define sqlite3_unlock_notify sqlite3_api->unlock_notify
#undef sqlite3_wal_autocheckpoint
#define sqlite3_wal_autocheckpoint sqlite3_api->wal_autocheckpoint
#undef sqlite3_wal_checkpoint
#define sqlite3_wal_checkpoint sqlite3_api->wal_checkpoint
#undef sqlite3_wal_hook
#define sqlite3_wal_hook sqlite3_api->wal_hook
#undef sqlite3_blob_reopen
#define sqlite3_blob_reopen sqlite3_api->blob_reopen
#undef sqlite3_vtab_config
#define sqlite3_vtab_config sqlite3_api->vtab_config
#undef sqlite3_vtab_on_conflict
#define sqlite3_vtab_on_conflict sqlite3_api->vtab_on_conflict
#undef sqlite3_close_v2
#define sqlite3_close_v2 sqlite3_api->close_v2
#undef sqlite3_db_filename
#define sqlite3_db_filename sqlite3_api->db_filename
#undef sqlite3_db_readonly
#define sqlite3_db_readonly sqlite3_api->db_readonly
#undef sqlite3_db_release_memory
#define sqlite3_db_release_memory sqlite3_api->db_release_memory
#undef sqlite3_errstr
#define sqlite3_errstr sqlite3_api->errstr
#undef sqlite3_stmt_busy
#define sqlite3_stmt_busy sqlite3_api->stmt_busy
#undef sqlite3_stmt_readonly
#define sqlite3_stmt_readonly sqlite3_api->stmt_readonly
#undef sqlite3_stricmp
#define sqlite3_stricmp sqlite3_api->stricmp
#undef sqlite3_uri_boolean
#define sqlite3_uri_boolean sqlite3_api->uri_boolean
#undef sqlite3_uri_int64
#define sqlite3_uri_int64 sqlite3_api->uri_int64
#undef sqlite3_uri_parameter
#define sqlite3_uri_parameter sqlite3_api->uri_parameter
#undef sqlite3_uri_vsnprintf
#define sqlite3_uri_vsnprintf sqlite3_api->xvsnprintf
#undef sqlite3_wal_checkpoint_v2
#define sqlite3_wal_checkpoint_v2 sqlite3_api->wal_checkpoint_v2
#undef sqlite3_auto_extension
#define sqlite3_auto_extension sqlite3_api->auto_extension
#undef sqlite3_bind_blob64
#define sqlite3_bind_blob64 sqlite3_api->bind_blob64
#undef sqlite3_bind_text64
#define sqlite3_bind_text64 sqlite3_api->bind_text64
#undef sqlite3_cancel_auto_extension
#define sqlite3_cancel_auto_extension sqlite3_api->cancel_auto_extension
#undef sqlite3_load_extension
#define sqlite3_load_extension sqlite3_api->load_extension
#undef sqlite3_malloc64
#define sqlite3_malloc64 sqlite3_api->malloc64
#undef sqlite3_msize
#define sqlite3_msize sqlite3_api->msize
#undef sqlite3_realloc64
#define sqlite3_realloc64 sqlite3_api->realloc64
#undef sqlite3_reset_auto_extension
#define sqlite3_reset_auto_extension sqlite3_api->reset_auto_extension
#undef sqlite3_result_blob64
#define sqlite3_result_blob64 sqlite3_api->result_blob64
#undef sqlite3_result_text64
#define sqlite3_result_text64 sqlite3_api->result_text64
#undef sqlite3_strglob
#define sqlite3_strglob sqlite3_api->strglob
#undef sqlite3_value_dup
#define sqlite3_value_dup sqlite3_api->value_dup
#undef sqlite3_value_free
#define sqlite3_value_free sqlite3_api->value_free
#undef sqlite3_result_zeroblob64
#define sqlite3_result_zeroblob64 sqlite3_api->result_zeroblob64
#undef sqlite3_bind_zeroblob64
#define sqlite3_bind_zeroblob64 sqlite3_api->bind_zeroblob64
#undef sqlite3_value_subtype
#define sqlite3_value_subtype sqlite3_api->value_subtype
#undef sqlite3_result_subtype
#define sqlite3_result_subtype sqlite3_api->result_subtype
#undef sqlite3_status64
#define sqlite3_status64 sqlite3_api->status64
#undef sqlite3_strlike
#define sqlite3_strlike sqlite3_api->strlike
#undef sqlite3_db_cacheflush
#define sqlite3_db_cacheflush sqlite3_api->db_cacheflush
#undef sqlite3_system_errno
#define sqlite3_system_errno sqlite3_api->system_errno
#undef sqlite3_trace_v2
#define sqlite3_trace_v2 sqlite3_api->trace_v2
#undef sqlite3_expanded_sql
#define sqlite3_expanded_sql sqlite3_api->expanded_sql
#undef sqlite3_set_last_insert_rowid
#define sqlite3_set_last_insert_rowid sqlite3_api->set_last_insert_rowid
#undef sqlite3_prepare_v3
#define sqlite3_prepare_v3 sqlite3_api->prepare_v3
#undef sqlite3_prepare16_v3
#define sqlite3_prepare16_v3 sqlite3_api->prepare16_v3
#undef sqlite3_bind_pointer
#define sqlite3_bind_pointer sqlite3_api->bind_pointer
#undef sqlite3_result_pointer
#define sqlite3_result_pointer sqlite3_api->result_pointer
#undef sqlite3_value_pointer
#define sqlite3_value_pointer sqlite3_api->value_pointer
#undef sqlite3_vtab_nochange
#define sqlite3_vtab_nochange sqlite3_api->vtab_nochange
#undef sqlite3_value_nochange
#define sqlite3_value_nochange sqlite3_api->value_nochange
#undef sqlite3_vtab_collation
#define sqlite3_vtab_collation sqlite3_api->vtab_collation
#undef sqlite3_keyword_count
#define sqlite3_keyword_count sqlite3_api->keyword_count
#undef sqlite3_keyword_name
#define sqlite3_keyword_name sqlite3_api->keyword_name
#undef sqlite3_keyword_check
#define sqlite3_keyword_check sqlite3_api->keyword_check
#undef sqlite3_str_new
#define sqlite3_str_new sqlite3_api->str_new
#undef sqlite3_str_finish
#define sqlite3_str_finish sqlite3_api->str_finish
#undef sqlite3_str_appendf
#define sqlite3_str_appendf sqlite3_api->str_appendf
#undef sqlite3_str_vappendf
#define sqlite3_str_vappendf sqlite3_api->str_vappendf
#undef sqlite3_str_append
#define sqlite3_str_append sqlite3_api->str_append
#undef sqlite3_str_appendall
#define sqlite3_str_appendall sqlite3_api->str_appendall
#undef sqlite3_str_appendchar
#define sqlite3_str_appendchar sqlite3_api->str_appendchar
#undef sqlite3_str_reset
#define sqlite3_str_reset sqlite3_api->str_reset
#undef sqlite3_str_errcode
#define sqlite3_str_errcode sqlite3_api->str_errcode
#undef sqlite3_str_length
#define sqlite3_str_length sqlite3_api->str_length
#undef sqlite3_str_value
#define sqlite3_str_value sqlite3_api->str_value
#undef sqlite3_create_window_function
#define sqlite3_create_window_function sqlite3_api->create_window_function
#undef sqlite3_normalized_sql
#define sqlite3_normalized_sql sqlite3_api->normalized_sql
#undef sqlite3_stmt_isexplain
#define sqlite3_stmt_isexplain sqlite3_api->stmt_isexplain
#undef sqlite3_value_frombind
#define sqlite3_value_frombind sqlite3_api->value_frombind
#undef sqlite3_drop_modules
#define sqlite3_drop_modules sqlite3_api->drop_modules
#undef sqlite3_hard_heap_limit64
#define sqlite3_hard_heap_limit64 sqlite3_api->hard_heap_limit64
#undef sqlite3_uri_key
#define sqlite3_uri_key sqlite3_api->uri_key
#undef sqlite3_filename_database
#define sqlite3_filename_database sqlite3_api->filename_database
#undef sqlite3_filename_journal
#define sqlite3_filename_journal sqlite3_api->filename_journal
#undef sqlite3_filename_wal
#define sqlite3_filename_wal sqlite3_api->filename_wal
#undef sqlite3_create_filename
#define sqlite3_create_filename sqlite3_api->create_filename
#undef sqlite3_free_filename
#define sqlite3_free_filename sqlite3_api->free_filename
#undef sqlite3_database_file_object
#define sqlite3_database_file_object sqlite3_api->database_file_object
#undef sqlite3_txn_state
#define sqlite3_txn_state sqlite3_api->txn_state
#define SQLITE_EXTENSION_INIT1 dim shared as const sqlite3_api_routines ptr sqlite3_api = 0
#define SQLITE_EXTENSION_INIT2(v) sqlite3_api = v
#define SQLITE_EXTENSION_INIT3 extern as const sqlite3_api_routines ptr sqlite3_api

end extern
