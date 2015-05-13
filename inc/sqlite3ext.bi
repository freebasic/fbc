' This is file sqlite3ext.bi.
' (FreeBasic binding for extended SQLite3, version 3.6.23.1)
'
' translated with help of h_2_bi.bas by
' Thomas[ dot ]Freiherr[ at ]gmx[ dot ]net.
'
' Licence:
'
' This library binding is free software; you can redistribute it
' and/or modify it under the terms of the GNU Lesser General Public
' License as published by the Free Software Foundation; either
' version 2 of the License, or (at your option) ANY later version.
'
' This binding is distributed in the hope that it will be useful,
' but WITHOUT ANY WARRANTY; without even the implied warranty of
' MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
' Lesser General Public License for more details, refer to:
' http://www.gnu.org/licenses/lgpl.html
'
' Normal users do not need this file. Do not include until you know why
' you'll need it.
'
'
' Original license text:
'
'/*
'** 2006 June 7
'**
'** The author disclaims copyright to this source code.  In place of
'** a legal notice, here is a blessing:
'**
'**    May you do good and not evil.
'**    May you find forgiveness for yourself and forgive others.
'**    May you share freely, never taking more than you give.
'**
'*************************************************************************
'** This header file defines the SQLite interface for use by
'** shared libraries that want to be imported as extensions into
'** an SQLite instance.  Shared libraries that intend to be loaded
'** as extensions by SQLite should #include this file instead of
'** sqlite3.h.
'*/

#IFNDEF _SQLITE3EXT_H_
#DEFINE _SQLITE3EXT_H_

#INCLUDE ONCE "sqlite3.bi"
#DEFINE SQLITE_CORE

EXTERN "C"

TYPE sqlite3_api_routines AS _sqlite3_api_routines

TYPE _sqlite3_api_routines
  aggregate_context AS FUNCTION CDECL(BYVAL AS sqlite3_context PTR, BYVAL AS INTEGER) AS ANY PTR
  aggregate_count AS FUNCTION CDECL(BYVAL AS sqlite3_context PTR) AS INTEGER
  bind_blob AS FUNCTION CDECL(BYVAL AS sqlite3_stmt PTR, BYVAL AS INTEGER, BYVAL AS CONST ANY PTR, BYVAL AS INTEGER, BYVAL AS SUB CDECL(BYVAL AS ANY PTR)) AS INTEGER
  bind_double AS FUNCTION CDECL(BYVAL AS sqlite3_stmt PTR, BYVAL AS INTEGER, BYVAL AS DOUBLE) AS INTEGER
  bind_int AS FUNCTION CDECL(BYVAL AS sqlite3_stmt PTR, BYVAL AS INTEGER, BYVAL AS INTEGER) AS INTEGER
  bind_int64 AS FUNCTION CDECL(BYVAL AS sqlite3_stmt PTR, BYVAL AS INTEGER, BYVAL AS sqlite_int64) AS INTEGER
  bind_null AS FUNCTION CDECL(BYVAL AS sqlite3_stmt PTR, BYVAL AS INTEGER) AS INTEGER
  bind_parameter_count AS FUNCTION CDECL(BYVAL AS sqlite3_stmt PTR) AS INTEGER
  bind_parameter_index AS FUNCTION CDECL(BYVAL AS sqlite3_stmt PTR, BYVAL AS CONST ZSTRING PTR) AS INTEGER
  bind_parameter_name AS FUNCTION CDECL(BYVAL AS sqlite3_stmt PTR, BYVAL AS INTEGER) AS CONST ZSTRING PTR
  bind_text AS FUNCTION CDECL(BYVAL AS sqlite3_stmt PTR, BYVAL AS INTEGER, BYVAL AS CONST ZSTRING PTR, BYVAL AS INTEGER, BYVAL AS SUB CDECL(BYVAL AS ANY PTR)) AS INTEGER
  bind_text16 AS FUNCTION CDECL(BYVAL AS sqlite3_stmt PTR, BYVAL AS INTEGER, BYVAL AS CONST ANY PTR, BYVAL AS INTEGER, BYVAL AS SUB CDECL(BYVAL AS ANY PTR)) AS INTEGER
  bind_value AS FUNCTION CDECL(BYVAL AS sqlite3_stmt PTR, BYVAL AS INTEGER, BYVAL AS CONST sqlite3_value PTR) AS INTEGER
  busy_handler AS FUNCTION CDECL(BYVAL AS sqlite3 PTR, BYVAL AS FUNCTION CDECL(BYVAL AS ANY PTR, BYVAL AS INTEGER) AS INTEGER, BYVAL AS ANY PTR) AS INTEGER
  busy_timeout AS FUNCTION CDECL(BYVAL AS sqlite3 PTR, BYVAL AS INTEGER) AS INTEGER
  changes AS FUNCTION CDECL(BYVAL AS sqlite3 PTR) AS INTEGER
  close AS FUNCTION CDECL(BYVAL AS sqlite3 PTR) AS INTEGER
  collation_needed AS FUNCTION CDECL(BYVAL AS sqlite3 PTR, BYVAL AS ANY PTR, BYVAL AS SUB CDECL(BYVAL AS ANY PTR, BYVAL AS sqlite3 PTR, BYVAL AS INTEGER, BYVAL AS CONST ZSTRING PTR)) AS INTEGER
  collation_needed16 AS FUNCTION CDECL(BYVAL AS sqlite3 PTR, BYVAL AS ANY PTR, BYVAL AS SUB CDECL(BYVAL AS ANY PTR, BYVAL AS sqlite3 PTR, BYVAL AS INTEGER, BYVAL AS CONST ANY PTR)) AS INTEGER
  column_blob AS FUNCTION CDECL(BYVAL AS sqlite3_stmt PTR, BYVAL AS INTEGER) AS CONST ANY PTR
  column_bytes AS FUNCTION CDECL(BYVAL AS sqlite3_stmt PTR, BYVAL AS INTEGER) AS INTEGER
  column_bytes16 AS FUNCTION CDECL(BYVAL AS sqlite3_stmt PTR, BYVAL AS INTEGER) AS INTEGER
  column_count AS FUNCTION CDECL(BYVAL AS sqlite3_stmt PTR) AS INTEGER
  column_database_name AS FUNCTION CDECL(BYVAL AS sqlite3_stmt PTR, BYVAL AS INTEGER) AS CONST ZSTRING PTR
  column_database_name16 AS FUNCTION CDECL(BYVAL AS sqlite3_stmt PTR, BYVAL AS INTEGER) AS CONST ANY PTR
  column_decltype AS FUNCTION CDECL(BYVAL AS sqlite3_stmt PTR, BYVAL AS INTEGER) AS CONST ZSTRING PTR
  column_decltype16 AS FUNCTION CDECL(BYVAL AS sqlite3_stmt PTR, BYVAL AS INTEGER) AS CONST ANY PTR
  column_double AS FUNCTION CDECL(BYVAL AS sqlite3_stmt PTR, BYVAL AS INTEGER) AS DOUBLE
  column_int AS FUNCTION CDECL(BYVAL AS sqlite3_stmt PTR, BYVAL AS INTEGER) AS INTEGER
  column_int64 AS FUNCTION CDECL(BYVAL AS sqlite3_stmt PTR, BYVAL AS INTEGER) AS sqlite_int64
  column_name AS FUNCTION CDECL(BYVAL AS sqlite3_stmt PTR, BYVAL AS INTEGER) AS CONST ZSTRING PTR
  column_name16 AS FUNCTION CDECL(BYVAL AS sqlite3_stmt PTR, BYVAL AS INTEGER) AS CONST ANY PTR
  column_origin_name AS FUNCTION CDECL(BYVAL AS sqlite3_stmt PTR, BYVAL AS INTEGER) AS CONST ZSTRING PTR
  column_origin_name16 AS FUNCTION CDECL(BYVAL AS sqlite3_stmt PTR, BYVAL AS INTEGER) AS CONST ANY PTR
  column_table_name AS FUNCTION CDECL(BYVAL AS sqlite3_stmt PTR, BYVAL AS INTEGER) AS CONST ZSTRING PTR
  column_table_name16 AS FUNCTION CDECL(BYVAL AS sqlite3_stmt PTR, BYVAL AS INTEGER) AS CONST ANY PTR
  column_text AS FUNCTION CDECL(BYVAL AS sqlite3_stmt PTR, BYVAL AS INTEGER) AS CONST UBYTE PTR
  column_text16 AS FUNCTION CDECL(BYVAL AS sqlite3_stmt PTR, BYVAL AS INTEGER) AS CONST ANY PTR
  column_type AS FUNCTION CDECL(BYVAL AS sqlite3_stmt PTR, BYVAL AS INTEGER) AS INTEGER
  column_value AS FUNCTION CDECL(BYVAL AS sqlite3_stmt PTR, BYVAL AS INTEGER) AS sqlite3_value PTR
  commit_hook AS FUNCTION CDECL(BYVAL AS sqlite3 PTR, BYVAL AS FUNCTION CDECL(BYVAL AS ANY PTR) AS INTEGER, BYVAL AS ANY PTR) AS ANY PTR
  complete AS FUNCTION CDECL(BYVAL AS CONST ZSTRING PTR) AS INTEGER
  complete16 AS FUNCTION CDECL(BYVAL AS CONST ANY PTR) AS INTEGER
  create_collation AS FUNCTION CDECL(BYVAL AS sqlite3 PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS INTEGER, BYVAL AS ANY PTR, BYVAL AS FUNCTION CDECL(BYVAL AS ANY PTR, BYVAL AS INTEGER, BYVAL AS CONST ANY PTR, BYVAL AS INTEGER, BYVAL AS CONST ANY PTR) AS INTEGER) AS INTEGER
  create_collation16 AS FUNCTION CDECL(BYVAL AS sqlite3 PTR, BYVAL AS CONST ANY PTR, BYVAL AS INTEGER, BYVAL AS ANY PTR, BYVAL AS FUNCTION CDECL(BYVAL AS ANY PTR, BYVAL AS INTEGER, BYVAL AS CONST ANY PTR, BYVAL AS INTEGER, BYVAL AS CONST ANY PTR) AS INTEGER) AS INTEGER
  create_function AS FUNCTION CDECL(BYVAL AS sqlite3 PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS ANY PTR, BYVAL AS SUB CDECL(BYVAL AS sqlite3_context PTR, BYVAL AS INTEGER, BYVAL AS sqlite3_value PTR PTR), BYVAL AS SUB CDECL(BYVAL AS sqlite3_context PTR, BYVAL AS INTEGER, BYVAL AS sqlite3_value PTR PTR), BYVAL AS SUB CDECL(BYVAL AS sqlite3_context PTR)) AS INTEGER
  create_function16 AS FUNCTION CDECL(BYVAL AS sqlite3 PTR, BYVAL AS CONST ANY PTR, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS ANY PTR, BYVAL AS SUB CDECL(BYVAL AS sqlite3_context PTR, BYVAL AS INTEGER, BYVAL AS sqlite3_value PTR PTR), BYVAL AS SUB CDECL(BYVAL AS sqlite3_context PTR, BYVAL AS INTEGER, BYVAL AS sqlite3_value PTR PTR), BYVAL AS SUB CDECL(BYVAL AS sqlite3_context PTR)) AS INTEGER
  create_module AS FUNCTION CDECL(BYVAL AS sqlite3 PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS CONST sqlite3_module PTR, BYVAL AS ANY PTR) AS INTEGER
  data_count AS FUNCTION CDECL(BYVAL AS sqlite3_stmt PTR) AS INTEGER
  db_handle AS FUNCTION CDECL(BYVAL AS sqlite3_stmt PTR) AS sqlite3 PTR
  declare_vtab AS FUNCTION CDECL(BYVAL AS sqlite3 PTR, BYVAL AS CONST ZSTRING PTR) AS INTEGER
  enable_shared_cache AS FUNCTION CDECL(BYVAL AS INTEGER) AS INTEGER
  errcode AS FUNCTION CDECL(BYVAL AS sqlite3 PTR) AS INTEGER
  errmsg AS FUNCTION CDECL(BYVAL AS sqlite3 PTR) AS CONST ZSTRING PTR
  errmsg16 AS FUNCTION CDECL(BYVAL AS sqlite3 PTR) AS CONST ANY PTR
  exec AS FUNCTION CDECL(BYVAL AS sqlite3 PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS sqlite3_callback, BYVAL AS ANY PTR, BYVAL AS ZSTRING PTR PTR) AS INTEGER
  expired AS FUNCTION CDECL(BYVAL AS sqlite3_stmt PTR) AS INTEGER
  finalize AS FUNCTION CDECL(BYVAL AS sqlite3_stmt PTR) AS INTEGER
  free AS SUB CDECL(BYVAL AS ANY PTR)
  free_table AS SUB CDECL(BYVAL AS ZSTRING PTR PTR)
  get_autocommit AS FUNCTION CDECL(BYVAL AS sqlite3 PTR) AS INTEGER
  get_auxdata AS FUNCTION CDECL(BYVAL AS sqlite3_context PTR, BYVAL AS INTEGER) AS ANY PTR
  get_table AS FUNCTION CDECL(BYVAL AS sqlite3 PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS ZSTRING PTR PTR PTR, BYVAL AS INTEGER PTR, BYVAL AS INTEGER PTR, BYVAL AS ZSTRING PTR PTR) AS INTEGER
  global_recover AS FUNCTION CDECL() AS INTEGER
  interruptx AS SUB CDECL(BYVAL AS sqlite3 PTR)
  last_insert_rowid AS FUNCTION CDECL(BYVAL AS sqlite3 PTR) AS sqlite_int64
  libversion AS FUNCTION CDECL() AS CONST ZSTRING PTR
  libversion_number AS FUNCTION CDECL() AS INTEGER
  malloc AS FUNCTION CDECL(BYVAL AS INTEGER) AS ANY PTR
  mprintf AS FUNCTION CDECL(BYVAL AS CONST ZSTRING PTR, ...) AS ZSTRING PTR
  open AS FUNCTION CDECL(BYVAL AS CONST ZSTRING PTR, BYVAL AS sqlite3 PTR PTR) AS INTEGER
  open16 AS FUNCTION CDECL(BYVAL AS CONST ANY PTR, BYVAL AS sqlite3 PTR PTR) AS INTEGER
  prepare AS FUNCTION CDECL(BYVAL AS sqlite3 PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS INTEGER, BYVAL AS sqlite3_stmt PTR PTR, BYVAL AS CONST ZSTRING PTR PTR) AS INTEGER
  prepare16 AS FUNCTION CDECL(BYVAL AS sqlite3 PTR, BYVAL AS CONST ANY PTR, BYVAL AS INTEGER, BYVAL AS sqlite3_stmt PTR PTR, BYVAL AS CONST ANY PTR PTR) AS INTEGER
  profile AS FUNCTION CDECL(BYVAL AS sqlite3 PTR, BYVAL AS SUB CDECL(BYVAL AS ANY PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS sqlite_uint64), BYVAL AS ANY PTR) AS ANY PTR
  progress_handler AS SUB CDECL(BYVAL AS sqlite3 PTR, BYVAL AS INTEGER, BYVAL AS FUNCTION CDECL(BYVAL AS ANY PTR) AS INTEGER, BYVAL AS ANY PTR)
  realloc AS FUNCTION CDECL(BYVAL AS ANY PTR, BYVAL AS INTEGER) AS ANY PTR
  reset AS FUNCTION CDECL(BYVAL AS sqlite3_stmt PTR) AS INTEGER
  result_blob AS SUB CDECL(BYVAL AS sqlite3_context PTR, BYVAL AS CONST ANY PTR, BYVAL AS INTEGER, BYVAL AS SUB CDECL(BYVAL AS ANY PTR))
  result_double AS SUB CDECL(BYVAL AS sqlite3_context PTR, BYVAL AS DOUBLE)
  result_error AS SUB CDECL(BYVAL AS sqlite3_context PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS INTEGER)
  result_error16 AS SUB CDECL(BYVAL AS sqlite3_context PTR, BYVAL AS CONST ANY PTR, BYVAL AS INTEGER)
  result_int AS SUB CDECL(BYVAL AS sqlite3_context PTR, BYVAL AS INTEGER)
  result_int64 AS SUB CDECL(BYVAL AS sqlite3_context PTR, BYVAL AS sqlite_int64)
  result_null AS SUB CDECL(BYVAL AS sqlite3_context PTR)
  result_text AS SUB CDECL(BYVAL AS sqlite3_context PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS INTEGER, BYVAL AS SUB CDECL(BYVAL AS ANY PTR))
  result_text16 AS SUB CDECL(BYVAL AS sqlite3_context PTR, BYVAL AS CONST ANY PTR, BYVAL AS INTEGER, BYVAL AS SUB CDECL(BYVAL AS ANY PTR))
  result_text16be AS SUB CDECL(BYVAL AS sqlite3_context PTR, BYVAL AS CONST ANY PTR, BYVAL AS INTEGER, BYVAL AS SUB CDECL(BYVAL AS ANY PTR))
  result_text16le AS SUB CDECL(BYVAL AS sqlite3_context PTR, BYVAL AS CONST ANY PTR, BYVAL AS INTEGER, BYVAL AS SUB CDECL(BYVAL AS ANY PTR))
  result_value AS SUB CDECL(BYVAL AS sqlite3_context PTR, BYVAL AS sqlite3_value PTR)
  rollback_hook AS FUNCTION CDECL(BYVAL AS sqlite3 PTR, BYVAL AS SUB CDECL(BYVAL AS ANY PTR), BYVAL AS ANY PTR) AS ANY PTR
  set_authorizer AS FUNCTION CDECL(BYVAL AS sqlite3 PTR, BYVAL AS FUNCTION CDECL(BYVAL AS ANY PTR, BYVAL AS INTEGER, BYVAL AS CONST ZSTRING PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS CONST ZSTRING PTR) AS INTEGER, BYVAL AS ANY PTR) AS INTEGER
  set_auxdata AS SUB CDECL(BYVAL AS sqlite3_context PTR, BYVAL AS INTEGER, BYVAL AS ANY PTR, BYVAL AS SUB CDECL(BYVAL AS ANY PTR))
  snprintf AS FUNCTION CDECL(BYVAL AS INTEGER, BYVAL AS ZSTRING PTR, BYVAL AS CONST ZSTRING PTR, ...) AS ZSTRING PTR
  step AS FUNCTION CDECL(BYVAL AS sqlite3_stmt PTR) AS INTEGER
  table_column_metadata AS FUNCTION CDECL(BYVAL AS sqlite3 PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS ZSTRING CONST PTR PTR, BYVAL AS ZSTRING CONST PTR PTR, BYVAL AS INTEGER PTR, BYVAL AS INTEGER PTR, BYVAL AS INTEGER PTR) AS INTEGER
  thread_cleanup AS SUB CDECL()
  total_changes AS FUNCTION CDECL(BYVAL AS sqlite3 PTR) AS INTEGER
  trace AS FUNCTION CDECL(BYVAL AS sqlite3 PTR, BYVAL AS SUB CDECL(BYVAL AS ANY PTR, BYVAL AS CONST ZSTRING PTR), BYVAL AS ANY PTR) AS ANY PTR
  transfer_bindings AS FUNCTION CDECL(BYVAL AS sqlite3_stmt PTR, BYVAL AS sqlite3_stmt PTR) AS INTEGER
  update_hook AS FUNCTION CDECL(BYVAL AS sqlite3 PTR, BYVAL AS SUB CDECL(BYVAL AS ANY PTR, BYVAL AS INTEGER, BYVAL AS ZSTRING CONST PTR, BYVAL AS ZSTRING CONST PTR, BYVAL AS sqlite_int64), BYVAL AS ANY PTR) AS ANY PTR
  user_data AS FUNCTION CDECL(BYVAL AS sqlite3_context PTR) AS ANY PTR
  value_blob AS FUNCTION CDECL(BYVAL AS sqlite3_value PTR) AS CONST ANY PTR
  value_bytes AS FUNCTION CDECL(BYVAL AS sqlite3_value PTR) AS INTEGER
  value_bytes16 AS FUNCTION CDECL(BYVAL AS sqlite3_value PTR) AS INTEGER
  value_double AS FUNCTION CDECL(BYVAL AS sqlite3_value PTR) AS DOUBLE
  value_int AS FUNCTION CDECL(BYVAL AS sqlite3_value PTR) AS INTEGER
  value_int64 AS FUNCTION CDECL(BYVAL AS sqlite3_value PTR) AS sqlite_int64
  value_numeric_type AS FUNCTION CDECL(BYVAL AS sqlite3_value PTR) AS INTEGER
  value_text AS FUNCTION CDECL(BYVAL AS sqlite3_value PTR) AS CONST UBYTE PTR
  value_text16 AS FUNCTION CDECL(BYVAL AS sqlite3_value PTR) AS CONST ANY PTR
  value_text16be AS FUNCTION CDECL(BYVAL AS sqlite3_value PTR) AS CONST ANY PTR
  value_text16le AS FUNCTION CDECL(BYVAL AS sqlite3_value PTR) AS CONST ANY PTR
  value_type AS FUNCTION CDECL(BYVAL AS sqlite3_value PTR) AS INTEGER
  vmprintf AS FUNCTION CDECL(BYVAL AS CONST ZSTRING PTR, BYVAL AS va_list) AS ZSTRING PTR
  overload_function AS FUNCTION CDECL(BYVAL AS sqlite3 PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS INTEGER) AS INTEGER
  prepare_v2 AS FUNCTION CDECL(BYVAL AS sqlite3 PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS INTEGER, BYVAL AS sqlite3_stmt PTR PTR, BYVAL AS CONST ZSTRING PTR PTR) AS INTEGER
  prepare16_v2 AS FUNCTION CDECL(BYVAL AS sqlite3 PTR, BYVAL AS CONST ANY PTR, BYVAL AS INTEGER, BYVAL AS sqlite3_stmt PTR PTR, BYVAL AS CONST ANY PTR PTR) AS INTEGER
  clear_bindings AS FUNCTION CDECL(BYVAL AS sqlite3_stmt PTR) AS INTEGER
  create_module_v2 AS FUNCTION CDECL(BYVAL AS sqlite3 PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS CONST sqlite3_module PTR, BYVAL AS ANY PTR, BYVAL AS SUB CDECL(BYVAL AS ANY PTR)) AS INTEGER
  bind_zeroblob AS FUNCTION CDECL(BYVAL AS sqlite3_stmt PTR, BYVAL AS INTEGER, BYVAL AS INTEGER) AS INTEGER
  blob_bytes AS FUNCTION CDECL(BYVAL AS sqlite3_blob PTR) AS INTEGER
  blob_close AS FUNCTION CDECL(BYVAL AS sqlite3_blob PTR) AS INTEGER
  blob_open AS FUNCTION CDECL(BYVAL AS sqlite3 PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS sqlite3_int64, BYVAL AS INTEGER, BYVAL AS sqlite3_blob PTR PTR) AS INTEGER
  blob_read AS FUNCTION CDECL(BYVAL AS sqlite3_blob PTR, BYVAL AS ANY PTR, BYVAL AS INTEGER, BYVAL AS INTEGER) AS INTEGER
  blob_write AS FUNCTION CDECL(BYVAL AS sqlite3_blob PTR, BYVAL AS CONST ANY PTR, BYVAL AS INTEGER, BYVAL AS INTEGER) AS INTEGER
  create_collation_v2 AS FUNCTION CDECL(BYVAL AS sqlite3 PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS INTEGER, BYVAL AS ANY PTR, BYVAL AS FUNCTION CDECL(BYVAL AS ANY PTR, BYVAL AS INTEGER, BYVAL AS CONST ANY PTR, BYVAL AS INTEGER, BYVAL AS CONST ANY PTR) AS INTEGER, BYVAL AS SUB CDECL(BYVAL AS ANY PTR)) AS INTEGER
  file_control AS FUNCTION CDECL(BYVAL AS sqlite3 PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS INTEGER, BYVAL AS ANY PTR) AS INTEGER
  memory_highwater AS FUNCTION CDECL(BYVAL AS INTEGER) AS sqlite3_int64
  memory_used AS FUNCTION CDECL() AS sqlite3_int64
  mutex_alloc AS FUNCTION CDECL(BYVAL AS INTEGER) AS sqlite3_mutex PTR
  mutex_enter AS SUB CDECL(BYVAL AS sqlite3_mutex PTR)
  mutex_free AS SUB CDECL(BYVAL AS sqlite3_mutex PTR)
  mutex_leave AS SUB CDECL(BYVAL AS sqlite3_mutex PTR)
  mutex_try AS FUNCTION CDECL(BYVAL AS sqlite3_mutex PTR) AS INTEGER
  open_v2 AS FUNCTION CDECL(BYVAL AS CONST ZSTRING PTR, BYVAL AS sqlite3 PTR PTR, BYVAL AS INTEGER, BYVAL AS CONST ZSTRING PTR) AS INTEGER
  release_memory AS FUNCTION CDECL(BYVAL AS INTEGER) AS INTEGER
  result_error_nomem AS SUB CDECL(BYVAL AS sqlite3_context PTR)
  result_error_toobig AS SUB CDECL(BYVAL AS sqlite3_context PTR)
  sleep AS FUNCTION CDECL(BYVAL AS INTEGER) AS INTEGER
  soft_heap_limit AS SUB CDECL(BYVAL AS INTEGER)
  vfs_find AS FUNCTION CDECL(BYVAL AS CONST ZSTRING PTR) AS sqlite3_vfs PTR
  vfs_register AS FUNCTION CDECL(BYVAL AS sqlite3_vfs PTR, BYVAL AS INTEGER) AS INTEGER
  vfs_unregister AS FUNCTION CDECL(BYVAL AS sqlite3_vfs PTR) AS INTEGER
  xthreadsafe AS FUNCTION CDECL() AS INTEGER
  result_zeroblob AS SUB CDECL(BYVAL AS sqlite3_context PTR, BYVAL AS INTEGER)
  result_error_code AS SUB CDECL(BYVAL AS sqlite3_context PTR, BYVAL AS INTEGER)
  test_control AS FUNCTION CDECL(BYVAL AS INTEGER, ...) AS INTEGER
  randomness AS SUB CDECL(BYVAL AS INTEGER, BYVAL AS ANY PTR)
  context_db_handle AS FUNCTION CDECL(BYVAL AS sqlite3_context PTR) AS sqlite3 PTR
  extended_result_codes AS FUNCTION CDECL(BYVAL AS sqlite3 PTR, BYVAL AS INTEGER) AS INTEGER
  limit AS FUNCTION CDECL(BYVAL AS sqlite3 PTR, BYVAL AS INTEGER, BYVAL AS INTEGER) AS INTEGER
  next_stmt AS FUNCTION CDECL(BYVAL AS sqlite3 PTR, BYVAL AS sqlite3_stmt PTR) AS sqlite3_stmt PTR
  sql AS FUNCTION CDECL(BYVAL AS sqlite3_stmt PTR) AS CONST ZSTRING PTR
  status AS FUNCTION CDECL(BYVAL AS INTEGER, BYVAL AS INTEGER PTR, BYVAL AS INTEGER PTR, BYVAL AS INTEGER) AS INTEGER
END TYPE

#IFNDEF SQLITE_CORE
#DEFINE sqlite3_aggregate_context      sqlite3_api->aggregate_context
#IFNDEF SQLITE_OMIT_DEPRECATED
# DEFINE sqlite3_aggregate_count        sqlite3_api->aggregate_count
#ENDIF ' SQLITE_OMIT_DEPRECATED
#DEFINE sqlite3_bind_blob              sqlite3_api->bind_blob
#DEFINE sqlite3_bind_double            sqlite3_api->bind_double
#DEFINE sqlite3_bind_int               sqlite3_api->bind_int
#DEFINE sqlite3_bind_int64             sqlite3_api->bind_int64
#DEFINE sqlite3_bind_null              sqlite3_api->bind_null
#DEFINE sqlite3_bind_parameter_count   sqlite3_api->bind_parameter_count
#DEFINE sqlite3_bind_parameter_index   sqlite3_api->bind_parameter_index
#DEFINE sqlite3_bind_parameter_name    sqlite3_api->bind_parameter_name
#DEFINE sqlite3_bind_text              sqlite3_api->bind_text
#DEFINE sqlite3_bind_text16            sqlite3_api->bind_text16
#DEFINE sqlite3_bind_value             sqlite3_api->bind_value
#DEFINE sqlite3_busy_handler           sqlite3_api->busy_handler
#DEFINE sqlite3_busy_timeout           sqlite3_api->busy_timeout
#DEFINE sqlite3_changes                sqlite3_api->changes
#DEFINE sqlite3_close                  sqlite3_api->close
#DEFINE sqlite3_collation_needed       sqlite3_api->collation_needed
#DEFINE sqlite3_collation_needed16     sqlite3_api->collation_needed16
#DEFINE sqlite3_column_blob            sqlite3_api->column_blob
#DEFINE sqlite3_column_bytes           sqlite3_api->column_bytes
#DEFINE sqlite3_column_bytes16         sqlite3_api->column_bytes16
#DEFINE sqlite3_column_count           sqlite3_api->column_count
#DEFINE sqlite3_column_database_name   sqlite3_api->column_database_name
#DEFINE sqlite3_column_database_name16 sqlite3_api->column_database_name16
#DEFINE sqlite3_column_decltype        sqlite3_api->column_decltype
#DEFINE sqlite3_column_decltype16      sqlite3_api->column_decltype16
#DEFINE sqlite3_column_double          sqlite3_api->column_double
#DEFINE sqlite3_column_int             sqlite3_api->column_int
#DEFINE sqlite3_column_int64           sqlite3_api->column_int64
#DEFINE sqlite3_column_name            sqlite3_api->column_name
#DEFINE sqlite3_column_name16          sqlite3_api->column_name16
#DEFINE sqlite3_column_origin_name     sqlite3_api->column_origin_name
#DEFINE sqlite3_column_origin_name16   sqlite3_api->column_origin_name16
#DEFINE sqlite3_column_table_name      sqlite3_api->column_table_name
#DEFINE sqlite3_column_table_name16    sqlite3_api->column_table_name16
#DEFINE sqlite3_column_text            sqlite3_api->column_text
#DEFINE sqlite3_column_text16          sqlite3_api->column_text16
#DEFINE sqlite3_column_type            sqlite3_api->column_type
#DEFINE sqlite3_column_value           sqlite3_api->column_value
#DEFINE sqlite3_commit_hook            sqlite3_api->commit_hook
#DEFINE sqlite3_complete               sqlite3_api->complete
#DEFINE sqlite3_complete16             sqlite3_api->complete16
#DEFINE sqlite3_create_collation       sqlite3_api->create_collation
#DEFINE sqlite3_create_collation16     sqlite3_api->create_collation16
#DEFINE sqlite3_create_function        sqlite3_api->create_function
#DEFINE sqlite3_create_function16      sqlite3_api->create_function16
#DEFINE sqlite3_create_module          sqlite3_api->create_module
#DEFINE sqlite3_create_module_v2       sqlite3_api->create_module_v2
#DEFINE sqlite3_data_count             sqlite3_api->data_count
#DEFINE sqlite3_db_handle              sqlite3_api->db_handle
#DEFINE sqlite3_declare_vtab           sqlite3_api->declare_vtab
#DEFINE sqlite3_enable_shared_cache    sqlite3_api->enable_shared_cache
#DEFINE sqlite3_errcode                sqlite3_api->errcode
#DEFINE sqlite3_errmsg                 sqlite3_api->errmsg
#DEFINE sqlite3_errmsg16               sqlite3_api->errmsg16
#DEFINE sqlite3_exec                   sqlite3_api->exec
#IFNDEF SQLITE_OMIT_DEPRECATED
# DEFINE sqlite3_expired                sqlite3_api->expired
#ENDIF ' SQLITE_OMIT_DEPRECATED
#DEFINE sqlite3_finalize               sqlite3_api->finalize
#DEFINE sqlite3_free                   sqlite3_api->free
#DEFINE sqlite3_free_table             sqlite3_api->free_table
#DEFINE sqlite3_get_autocommit         sqlite3_api->get_autocommit
#DEFINE sqlite3_get_auxdata            sqlite3_api->get_auxdata
#DEFINE sqlite3_get_table              sqlite3_api->get_table
#IFNDEF SQLITE_OMIT_DEPRECATED
# DEFINE sqlite3_global_recover         sqlite3_api->global_recover
#ENDIF ' SQLITE_OMIT_DEPRECATED
#DEFINE sqlite3_interrupt              sqlite3_api->interruptx
#DEFINE sqlite3_last_insert_rowid      sqlite3_api->last_insert_rowid
#DEFINE sqlite3_libversion             sqlite3_api->libversion
#DEFINE sqlite3_libversion_number      sqlite3_api->libversion_number
#DEFINE sqlite3_malloc                 sqlite3_api->malloc
#DEFINE sqlite3_mprintf                sqlite3_api->mprintf
#DEFINE sqlite3_open                   sqlite3_api->open
#DEFINE sqlite3_open16                 sqlite3_api->open16
#DEFINE sqlite3_prepare                sqlite3_api->prepare
#DEFINE sqlite3_prepare16              sqlite3_api->prepare16
#DEFINE sqlite3_prepare_v2             sqlite3_api->prepare_v2
#DEFINE sqlite3_prepare16_v2           sqlite3_api->prepare16_v2
#DEFINE sqlite3_profile                sqlite3_api->profile
#DEFINE sqlite3_progress_handler       sqlite3_api->progress_handler
#DEFINE sqlite3_realloc                sqlite3_api->realloc
#DEFINE sqlite3_reset                  sqlite3_api->reset
#DEFINE sqlite3_result_blob            sqlite3_api->result_blob
#DEFINE sqlite3_result_double          sqlite3_api->result_double
#DEFINE sqlite3_result_error           sqlite3_api->result_error
#DEFINE sqlite3_result_error16         sqlite3_api->result_error16
#DEFINE sqlite3_result_int             sqlite3_api->result_int
#DEFINE sqlite3_result_int64           sqlite3_api->result_int64
#DEFINE sqlite3_result_null            sqlite3_api->result_null
#DEFINE sqlite3_result_text            sqlite3_api->result_text
#DEFINE sqlite3_result_text16          sqlite3_api->result_text16
#DEFINE sqlite3_result_text16be        sqlite3_api->result_text16be
#DEFINE sqlite3_result_text16le        sqlite3_api->result_text16le
#DEFINE sqlite3_result_value           sqlite3_api->result_value
#DEFINE sqlite3_rollback_hook          sqlite3_api->rollback_hook
#DEFINE sqlite3_set_authorizer         sqlite3_api->set_authorizer
#DEFINE sqlite3_set_auxdata            sqlite3_api->set_auxdata
#DEFINE sqlite3_snprintf               sqlite3_api->snprintf
#DEFINE sqlite3_step                   sqlite3_api->step
#DEFINE sqlite3_table_column_metadata  sqlite3_api->table_column_metadata
#DEFINE sqlite3_thread_cleanup         sqlite3_api->thread_cleanup
#DEFINE sqlite3_total_changes          sqlite3_api->total_changes
#DEFINE sqlite3_trace                  sqlite3_api->trace
#IFNDEF SQLITE_OMIT_DEPRECATED
# DEFINE sqlite3_transfer_bindings      sqlite3_api->transfer_bindings
#ENDIF ' SQLITE_OMIT_DEPRECATED
#DEFINE sqlite3_update_hook            sqlite3_api->update_hook
#DEFINE sqlite3_user_data              sqlite3_api->user_data
#DEFINE sqlite3_value_blob             sqlite3_api->value_blob
#DEFINE sqlite3_value_bytes            sqlite3_api->value_bytes
#DEFINE sqlite3_value_bytes16          sqlite3_api->value_bytes16
#DEFINE sqlite3_value_double           sqlite3_api->value_double
#DEFINE sqlite3_value_int              sqlite3_api->value_int
#DEFINE sqlite3_value_int64            sqlite3_api->value_int64
#DEFINE sqlite3_value_numeric_type     sqlite3_api->value_numeric_type
#DEFINE sqlite3_value_text             sqlite3_api->value_text
#DEFINE sqlite3_value_text16           sqlite3_api->value_text16
#DEFINE sqlite3_value_text16be         sqlite3_api->value_text16be
#DEFINE sqlite3_value_text16le         sqlite3_api->value_text16le
#DEFINE sqlite3_value_type             sqlite3_api->value_type
#DEFINE sqlite3_vmprintf               sqlite3_api->vmprintf
#DEFINE sqlite3_overload_function      sqlite3_api->overload_function
#DEFINE sqlite3_prepare_v2             sqlite3_api->prepare_v2
#DEFINE sqlite3_prepare16_v2           sqlite3_api->prepare16_v2
#DEFINE sqlite3_clear_bindings         sqlite3_api->clear_bindings
#DEFINE sqlite3_bind_zeroblob          sqlite3_api->bind_zeroblob
#DEFINE sqlite3_blob_bytes             sqlite3_api->blob_bytes
#DEFINE sqlite3_blob_close             sqlite3_api->blob_close
#DEFINE sqlite3_blob_open              sqlite3_api->blob_open
#DEFINE sqlite3_blob_read              sqlite3_api->blob_read
#DEFINE sqlite3_blob_write             sqlite3_api->blob_write
#DEFINE sqlite3_create_collation_v2    sqlite3_api->create_collation_v2
#DEFINE sqlite3_file_control           sqlite3_api->file_control
#DEFINE sqlite3_memory_highwater       sqlite3_api->memory_highwater
#DEFINE sqlite3_memory_used            sqlite3_api->memory_used
#DEFINE sqlite3_mutex_alloc            sqlite3_api->mutex_alloc
#DEFINE sqlite3_mutex_enter            sqlite3_api->mutex_enter
#DEFINE sqlite3_mutex_free             sqlite3_api->mutex_free
#DEFINE sqlite3_mutex_leave            sqlite3_api->mutex_leave
#DEFINE sqlite3_mutex_try              sqlite3_api->mutex_try
#DEFINE sqlite3_open_v2                sqlite3_api->open_v2
#DEFINE sqlite3_release_memory         sqlite3_api->release_memory
#DEFINE sqlite3_result_error_nomem     sqlite3_api->result_error_nomem
#DEFINE sqlite3_result_error_toobig    sqlite3_api->result_error_toobig
#DEFINE sqlite3_sleep                  sqlite3_api->sleep
#DEFINE sqlite3_soft_heap_limit        sqlite3_api->soft_heap_limit
#DEFINE sqlite3_vfs_find               sqlite3_api->vfs_find
#DEFINE sqlite3_vfs_register           sqlite3_api->vfs_register
#DEFINE sqlite3_vfs_unregister         sqlite3_api->vfs_unregister
#DEFINE sqlite3_threadsafe             sqlite3_api->xthreadsafe
#DEFINE sqlite3_result_zeroblob        sqlite3_api->result_zeroblob
#DEFINE sqlite3_result_error_code      sqlite3_api->result_error_code
#DEFINE sqlite3_test_control           sqlite3_api->test_control
#DEFINE sqlite3_randomness             sqlite3_api->randomness
#DEFINE sqlite3_context_db_handle      sqlite3_api->context_db_handle
#DEFINE sqlite3_extended_result_codes  sqlite3_api->extended_result_codes
#DEFINE sqlite3_limit                  sqlite3_api->limit
#DEFINE sqlite3_next_stmt              sqlite3_api->next_stmt
#DEFINE sqlite3_sql                    sqlite3_api->sql
#DEFINE sqlite3_status                 sqlite3_api->status
#ENDIF ' SQLITE_CORE

#DEFINE SQLITE_EXTENSION_INIT1     DIM sqlite3_api = 0 AS CONST sqlite3_api_routines PTR
#DEFINE SQLITE_EXTENSION_INIT2(v)  DIM sqlite3_api = v AS sqlite3_api_routines PTR

#ENDIF ' _SQLITE3EXT_H_

END EXTERN
