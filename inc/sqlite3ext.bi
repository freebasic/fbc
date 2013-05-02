' This is file sqlite3ext.bi
' FreeBasic header for SQLITE3 version 3.7.13.
'
' Translated with help of h_2_bi.bas
' (C) 2011-2012 by Thomas{ dot ]Freiherr[ at ]gmx[ dot }net
' License LGPLv2
'
' This header is free software: you can redistribute
' it and/or modify it under the terms of the GNU General Public
' License as published by the Free Software Foundation, either
' version 3 of the License, or (at your option) any later
' version. For details please refer to: http://gplv3.fsf.org/
'
' This header is distributed in the hope that it will be
' useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
' MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

' Original Licence test:
'
'/*
'** 2001 September 15
'**
'** The author disclaims copyright to this source code.  In place of
'** a legal notice, here is a blessing:
'**
'**    May you do good and not evil.
'**    May you find forgiveness for yourself and forgive others.
'**    May you share freely, never taking more than you give.
'**
'*************************************************************************
'** This header file defines the interface that the SQLite library
'** presents to client programs.  If a C-function, structure, datatype,
'** or constant definition does not appear in this file, then it is
'** not a published API of SQLite, is subject to change without
'** notice, and should not be referenced by programs that use SQLite.
'**
'** Some of the definitions that are in this file are marked as
'** "experimental".  Experimental interfaces are normally new
'** features recently added to SQLite.  We do not anticipate changes
'** to experimental interfaces but reserve the right to make minor changes
'** if experience from use "in the wild" suggest such changes are prudent.
'**
'** The official C-language API documentation for SQLite is derived
'** from comments in this file.  This file is the authoritative source
'** on how SQLite interfaces are suppose to operate.
'**
'** The name of this file under configuration management is "sqlite.h.in".
'** The makefile makes some minor changes to this file (such as inserting
'** the version number) and changes its name to "sqlite3.h" as
'** part of the build process.
'*/

#INCLUDE ONCE "crt/stdarg.bi"
#DEFINE SQLITE_INT64_TYPE LONGINT
#DEFINE UNSINN UINTEGER

#IFDEF __FB_WIN32__
#PRAGMA push(msbitfields)
#ENDIF

#INCLIB "sqlite3"

EXTERN "C" ' (h_2_bi -P_oCD option)

#IFNDEF _SQLITE3EXT_H_
#DEFINE _SQLITE3EXT_H_
#INCLUDE ONCE "sqlite3.bi"

TYPE sqlite3_api_routines AS sqlite3_api_routines_

TYPE sqlite3_api_routines_
  aggregate_context AS FUNCTION(BYVAL AS sqlite3_context PTR, BYVAL AS INTEGER) AS ANY PTR
  aggregate_count AS FUNCTION(BYVAL AS sqlite3_context PTR) AS INTEGER
  bind_blob AS FUNCTION(BYVAL AS sqlite3_stmt PTR, BYVAL AS INTEGER, BYVAL AS CONST ANY PTR, BYVAL AS INTEGER, BYVAL AS SUB(BYVAL AS ANY PTR)) AS INTEGER
  bind_double AS FUNCTION(BYVAL AS sqlite3_stmt PTR, BYVAL AS INTEGER, BYVAL AS DOUBLE) AS INTEGER
  bind_int AS FUNCTION(BYVAL AS sqlite3_stmt PTR, BYVAL AS INTEGER, BYVAL AS INTEGER) AS INTEGER
  bind_int64 AS FUNCTION(BYVAL AS sqlite3_stmt PTR, BYVAL AS INTEGER, BYVAL AS sqlite_int64) AS INTEGER
  bind_null AS FUNCTION(BYVAL AS sqlite3_stmt PTR, BYVAL AS INTEGER) AS INTEGER
  bind_parameter_count AS FUNCTION(BYVAL AS sqlite3_stmt PTR) AS INTEGER
  bind_parameter_index AS FUNCTION(BYVAL AS sqlite3_stmt PTR, BYVAL AS CONST ZSTRING PTR) AS INTEGER
  bind_parameter_name AS FUNCTION(BYVAL AS sqlite3_stmt PTR, BYVAL AS INTEGER) AS CONST ZSTRING PTR
  bind_text AS FUNCTION(BYVAL AS sqlite3_stmt PTR, BYVAL AS INTEGER, BYVAL AS CONST ZSTRING PTR, BYVAL AS INTEGER, BYVAL AS SUB(BYVAL AS ANY PTR)) AS INTEGER
  bind_text16 AS FUNCTION(BYVAL AS sqlite3_stmt PTR, BYVAL AS INTEGER, BYVAL AS CONST ANY PTR, BYVAL AS INTEGER, BYVAL AS SUB(BYVAL AS ANY PTR)) AS INTEGER
  bind_value AS FUNCTION(BYVAL AS sqlite3_stmt PTR, BYVAL AS INTEGER, BYVAL AS CONST sqlite3_value PTR) AS INTEGER
  busy_handler AS FUNCTION(BYVAL AS sqlite3 PTR, BYVAL AS FUNCTION(BYVAL AS ANY PTR, BYVAL AS INTEGER) AS INTEGER, BYVAL AS ANY PTR) AS INTEGER
  busy_timeout AS FUNCTION(BYVAL AS sqlite3 PTR, BYVAL AS INTEGER) AS INTEGER
  changes AS FUNCTION(BYVAL AS sqlite3 PTR) AS INTEGER
  close_ AS FUNCTION(BYVAL AS sqlite3 PTR) AS INTEGER
  collation_needed AS FUNCTION(BYVAL AS sqlite3 PTR, BYVAL AS ANY PTR, BYVAL AS SUB(BYVAL AS ANY PTR, BYVAL AS sqlite3 PTR, BYVAL AS INTEGER, BYVAL AS CONST ZSTRING PTR)) AS INTEGER
  collation_needed16 AS FUNCTION(BYVAL AS sqlite3 PTR, BYVAL AS ANY PTR, BYVAL AS SUB(BYVAL AS ANY PTR, BYVAL AS sqlite3 PTR, BYVAL AS INTEGER, BYVAL AS CONST ANY PTR)) AS INTEGER
  column_blob AS FUNCTION(BYVAL AS sqlite3_stmt PTR, BYVAL AS INTEGER) AS CONST ANY PTR
  column_bytes AS FUNCTION(BYVAL AS sqlite3_stmt PTR, BYVAL AS INTEGER) AS INTEGER
  column_bytes16 AS FUNCTION(BYVAL AS sqlite3_stmt PTR, BYVAL AS INTEGER) AS INTEGER
  column_count AS FUNCTION(BYVAL AS sqlite3_stmt PTR) AS INTEGER
  column_database_name AS FUNCTION(BYVAL AS sqlite3_stmt PTR, BYVAL AS INTEGER) AS CONST ZSTRING PTR
  column_database_name16 AS FUNCTION(BYVAL AS sqlite3_stmt PTR, BYVAL AS INTEGER) AS CONST ANY PTR
  column_decltype AS FUNCTION(BYVAL AS sqlite3_stmt PTR, BYVAL AS INTEGER) AS CONST ZSTRING PTR
  column_decltype16 AS FUNCTION(BYVAL AS sqlite3_stmt PTR, BYVAL AS INTEGER) AS CONST ANY PTR
  column_double AS FUNCTION(BYVAL AS sqlite3_stmt PTR, BYVAL AS INTEGER) AS DOUBLE
  column_int AS FUNCTION(BYVAL AS sqlite3_stmt PTR, BYVAL AS INTEGER) AS INTEGER
  column_int64 AS FUNCTION(BYVAL AS sqlite3_stmt PTR, BYVAL AS INTEGER) AS sqlite_int64
  column_name AS FUNCTION(BYVAL AS sqlite3_stmt PTR, BYVAL AS INTEGER) AS CONST ZSTRING PTR
  column_name16 AS FUNCTION(BYVAL AS sqlite3_stmt PTR, BYVAL AS INTEGER) AS CONST ANY PTR
  column_origin_name AS FUNCTION(BYVAL AS sqlite3_stmt PTR, BYVAL AS INTEGER) AS CONST ZSTRING PTR
  column_origin_name16 AS FUNCTION(BYVAL AS sqlite3_stmt PTR, BYVAL AS INTEGER) AS CONST ANY PTR
  column_table_name AS FUNCTION(BYVAL AS sqlite3_stmt PTR, BYVAL AS INTEGER) AS CONST ZSTRING PTR
  column_table_name16 AS FUNCTION(BYVAL AS sqlite3_stmt PTR, BYVAL AS INTEGER) AS CONST ANY PTR
  column_text AS FUNCTION(BYVAL AS sqlite3_stmt PTR, BYVAL AS INTEGER) AS CONST UBYTE PTR
  column_text16 AS FUNCTION(BYVAL AS sqlite3_stmt PTR, BYVAL AS INTEGER) AS CONST ANY PTR
  column_type AS FUNCTION(BYVAL AS sqlite3_stmt PTR, BYVAL AS INTEGER) AS INTEGER
  column_value AS FUNCTION(BYVAL AS sqlite3_stmt PTR, BYVAL AS INTEGER) AS sqlite3_value PTR
  commit_hook AS FUNCTION(BYVAL AS sqlite3 PTR, BYVAL AS FUNCTION(BYVAL AS ANY PTR) AS INTEGER, BYVAL AS ANY PTR) AS ANY PTR
  complete AS FUNCTION(BYVAL AS CONST ZSTRING PTR) AS INTEGER
  complete16 AS FUNCTION(BYVAL AS CONST ANY PTR) AS INTEGER
  create_collation AS FUNCTION(BYVAL AS sqlite3 PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS INTEGER, BYVAL AS ANY PTR, BYVAL AS FUNCTION(BYVAL AS ANY PTR, BYVAL AS INTEGER, BYVAL AS CONST ANY PTR, BYVAL AS INTEGER, BYVAL AS CONST ANY PTR) AS INTEGER) AS INTEGER
  create_collation16 AS FUNCTION(BYVAL AS sqlite3 PTR, BYVAL AS CONST ANY PTR, BYVAL AS INTEGER, BYVAL AS ANY PTR, BYVAL AS FUNCTION(BYVAL AS ANY PTR, BYVAL AS INTEGER, BYVAL AS CONST ANY PTR, BYVAL AS INTEGER, BYVAL AS CONST ANY PTR) AS INTEGER) AS INTEGER
  create_function AS FUNCTION(BYVAL AS sqlite3 PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS ANY PTR, BYVAL AS SUB(BYVAL AS sqlite3_context PTR, BYVAL AS INTEGER, BYVAL AS sqlite3_value PTR PTR), BYVAL AS SUB(BYVAL AS sqlite3_context PTR, BYVAL AS INTEGER, BYVAL AS sqlite3_value PTR PTR), BYVAL AS SUB(BYVAL AS sqlite3_context PTR)) AS INTEGER
  create_function16 AS FUNCTION(BYVAL AS sqlite3 PTR, BYVAL AS CONST ANY PTR, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS ANY PTR, BYVAL AS SUB(BYVAL AS sqlite3_context PTR, BYVAL AS INTEGER, BYVAL AS sqlite3_value PTR PTR), BYVAL AS SUB(BYVAL AS sqlite3_context PTR, BYVAL AS INTEGER, BYVAL AS sqlite3_value PTR PTR), BYVAL AS SUB(BYVAL AS sqlite3_context PTR)) AS INTEGER
  create_module AS FUNCTION(BYVAL AS sqlite3 PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS CONST sqlite3_module PTR, BYVAL AS ANY PTR) AS INTEGER
  data_count AS FUNCTION(BYVAL AS sqlite3_stmt PTR) AS INTEGER
  db_handle AS FUNCTION(BYVAL AS sqlite3_stmt PTR) AS sqlite3 PTR
  declare_vtab AS FUNCTION(BYVAL AS sqlite3 PTR, BYVAL AS CONST ZSTRING PTR) AS INTEGER
  enable_shared_cache AS FUNCTION(BYVAL AS INTEGER) AS INTEGER
  errcode AS FUNCTION(BYVAL AS sqlite3 PTR) AS INTEGER
  errmsg AS FUNCTION(BYVAL AS sqlite3 PTR) AS CONST ZSTRING PTR
  errmsg16 AS FUNCTION(BYVAL AS sqlite3 PTR) AS CONST ANY PTR
  exec_ AS FUNCTION(BYVAL AS sqlite3 PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS sqlite3_callback, BYVAL AS ANY PTR, BYVAL AS ZSTRING PTR PTR) AS INTEGER
  expired AS FUNCTION(BYVAL AS sqlite3_stmt PTR) AS INTEGER
  finalize AS FUNCTION(BYVAL AS sqlite3_stmt PTR) AS INTEGER
  free AS SUB(BYVAL AS ANY PTR)
  free_table AS SUB(BYVAL AS ZSTRING PTR PTR)
  get_autocommit AS FUNCTION(BYVAL AS sqlite3 PTR) AS INTEGER
  get_auxdata AS FUNCTION(BYVAL AS sqlite3_context PTR, BYVAL AS INTEGER) AS ANY PTR
  get_table AS FUNCTION(BYVAL AS sqlite3 PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS ZSTRING PTR PTR PTR, BYVAL AS INTEGER PTR, BYVAL AS INTEGER PTR, BYVAL AS ZSTRING PTR PTR) AS INTEGER
  global_recover AS FUNCTION() AS INTEGER
  interruptx AS SUB(BYVAL AS sqlite3 PTR)
  last_insert_rowid AS FUNCTION(BYVAL AS sqlite3 PTR) AS sqlite_int64
  libversion AS FUNCTION() AS CONST ZSTRING PTR
  libversion_number AS FUNCTION() AS INTEGER
  malloc AS FUNCTION(BYVAL AS INTEGER) AS ANY PTR
  mprintf AS FUNCTION(BYVAL AS CONST ZSTRING PTR, ...) AS ZSTRING PTR
  open_ AS FUNCTION(BYVAL AS CONST ZSTRING PTR, BYVAL AS sqlite3 PTR PTR) AS INTEGER
  open16 AS FUNCTION(BYVAL AS CONST ANY PTR, BYVAL AS sqlite3 PTR PTR) AS INTEGER
  prepare AS FUNCTION(BYVAL AS sqlite3 PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS INTEGER, BYVAL AS sqlite3_stmt PTR PTR, BYVAL AS CONST ZSTRING PTR PTR) AS INTEGER
  prepare16 AS FUNCTION(BYVAL AS sqlite3 PTR, BYVAL AS CONST ANY PTR, BYVAL AS INTEGER, BYVAL AS sqlite3_stmt PTR PTR, BYVAL AS CONST ANY PTR PTR) AS INTEGER
  profile AS FUNCTION(BYVAL AS sqlite3 PTR, BYVAL AS SUB(BYVAL AS ANY PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS sqlite_uint64), BYVAL AS ANY PTR) AS ANY PTR
  progress_handler AS SUB(BYVAL AS sqlite3 PTR, BYVAL AS INTEGER, BYVAL AS FUNCTION(BYVAL AS ANY PTR) AS INTEGER, BYVAL AS ANY PTR)
  realloc AS FUNCTION(BYVAL AS ANY PTR, BYVAL AS INTEGER) AS ANY PTR
  reset_ AS FUNCTION(BYVAL AS sqlite3_stmt PTR) AS INTEGER
  result_blob AS SUB(BYVAL AS sqlite3_context PTR, BYVAL AS CONST ANY PTR, BYVAL AS INTEGER, BYVAL AS SUB(BYVAL AS ANY PTR))
  result_double AS SUB(BYVAL AS sqlite3_context PTR, BYVAL AS DOUBLE)
  result_error AS SUB(BYVAL AS sqlite3_context PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS INTEGER)
  result_error16 AS SUB(BYVAL AS sqlite3_context PTR, BYVAL AS CONST ANY PTR, BYVAL AS INTEGER)
  result_int AS SUB(BYVAL AS sqlite3_context PTR, BYVAL AS INTEGER)
  result_int64 AS SUB(BYVAL AS sqlite3_context PTR, BYVAL AS sqlite_int64)
  result_null AS SUB(BYVAL AS sqlite3_context PTR)
  result_text AS SUB(BYVAL AS sqlite3_context PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS INTEGER, BYVAL AS SUB(BYVAL AS ANY PTR))
  result_text16 AS SUB(BYVAL AS sqlite3_context PTR, BYVAL AS CONST ANY PTR, BYVAL AS INTEGER, BYVAL AS SUB(BYVAL AS ANY PTR))
  result_text16be AS SUB(BYVAL AS sqlite3_context PTR, BYVAL AS CONST ANY PTR, BYVAL AS INTEGER, BYVAL AS SUB(BYVAL AS ANY PTR))
  result_text16le AS SUB(BYVAL AS sqlite3_context PTR, BYVAL AS CONST ANY PTR, BYVAL AS INTEGER, BYVAL AS SUB(BYVAL AS ANY PTR))
  result_value AS SUB(BYVAL AS sqlite3_context PTR, BYVAL AS sqlite3_value PTR)
  rollback_hook AS FUNCTION(BYVAL AS sqlite3 PTR, BYVAL AS SUB(BYVAL AS ANY PTR), BYVAL AS ANY PTR) AS ANY PTR
  set_authorizer AS FUNCTION(BYVAL AS sqlite3 PTR, BYVAL AS FUNCTION(BYVAL AS ANY PTR, BYVAL AS INTEGER, BYVAL AS CONST ZSTRING PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS CONST ZSTRING PTR) AS INTEGER, BYVAL AS ANY PTR) AS INTEGER
  set_auxdata AS SUB(BYVAL AS sqlite3_context PTR, BYVAL AS INTEGER, BYVAL AS ANY PTR, BYVAL AS SUB(BYVAL AS ANY PTR))
  snprintf AS FUNCTION(BYVAL AS INTEGER, BYVAL AS ZSTRING PTR, BYVAL AS CONST ZSTRING PTR, ...) AS ZSTRING PTR
  step_ AS FUNCTION(BYVAL AS sqlite3_stmt PTR) AS INTEGER
  table_column_metadata AS FUNCTION(BYVAL AS sqlite3 PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS ZSTRING CONST PTR PTR, BYVAL AS ZSTRING CONST PTR PTR, BYVAL AS INTEGER PTR, BYVAL AS INTEGER PTR, BYVAL AS INTEGER PTR) AS INTEGER
  thread_cleanup AS SUB()
  total_changes AS FUNCTION(BYVAL AS sqlite3 PTR) AS INTEGER
  trace AS FUNCTION(BYVAL AS sqlite3 PTR, BYVAL AS SUB(BYVAL AS ANY PTR, BYVAL AS CONST ZSTRING PTR), BYVAL AS ANY PTR) AS ANY PTR
  transfer_bindings AS FUNCTION(BYVAL AS sqlite3_stmt PTR, BYVAL AS sqlite3_stmt PTR) AS INTEGER
  update_hook AS FUNCTION(BYVAL AS sqlite3 PTR, BYVAL AS SUB(BYVAL AS ANY PTR, BYVAL AS INTEGER, BYVAL AS ZSTRING CONST PTR, BYVAL AS ZSTRING CONST PTR, BYVAL AS sqlite_int64), BYVAL AS ANY PTR) AS ANY PTR
  user_data AS FUNCTION(BYVAL AS sqlite3_context PTR) AS ANY PTR
  value_blob AS FUNCTION(BYVAL AS sqlite3_value PTR) AS CONST ANY PTR
  value_bytes AS FUNCTION(BYVAL AS sqlite3_value PTR) AS INTEGER
  value_bytes16 AS FUNCTION(BYVAL AS sqlite3_value PTR) AS INTEGER
  value_double AS FUNCTION(BYVAL AS sqlite3_value PTR) AS DOUBLE
  value_int AS FUNCTION(BYVAL AS sqlite3_value PTR) AS INTEGER
  value_int64 AS FUNCTION(BYVAL AS sqlite3_value PTR) AS sqlite_int64
  value_numeric_type AS FUNCTION(BYVAL AS sqlite3_value PTR) AS INTEGER
  value_text AS FUNCTION(BYVAL AS sqlite3_value PTR) AS CONST UBYTE PTR
  value_text16 AS FUNCTION(BYVAL AS sqlite3_value PTR) AS CONST ANY PTR
  value_text16be AS FUNCTION(BYVAL AS sqlite3_value PTR) AS CONST ANY PTR
  value_text16le AS FUNCTION(BYVAL AS sqlite3_value PTR) AS CONST ANY PTR
  value_type AS FUNCTION(BYVAL AS sqlite3_value PTR) AS INTEGER
  vmprintf AS FUNCTION(BYVAL AS CONST ZSTRING PTR, BYVAL AS va_list) AS ZSTRING PTR
  overload_function AS FUNCTION(BYVAL AS sqlite3 PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS INTEGER) AS INTEGER
  prepare_v2 AS FUNCTION(BYVAL AS sqlite3 PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS INTEGER, BYVAL AS sqlite3_stmt PTR PTR, BYVAL AS CONST ZSTRING PTR PTR) AS INTEGER
  prepare16_v2 AS FUNCTION(BYVAL AS sqlite3 PTR, BYVAL AS CONST ANY PTR, BYVAL AS INTEGER, BYVAL AS sqlite3_stmt PTR PTR, BYVAL AS CONST ANY PTR PTR) AS INTEGER
  clear_bindings AS FUNCTION(BYVAL AS sqlite3_stmt PTR) AS INTEGER
  create_module_v2 AS FUNCTION(BYVAL AS sqlite3 PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS CONST sqlite3_module PTR, BYVAL AS ANY PTR, BYVAL AS SUB(BYVAL AS ANY PTR)) AS INTEGER
  bind_zeroblob AS FUNCTION(BYVAL AS sqlite3_stmt PTR, BYVAL AS INTEGER, BYVAL AS INTEGER) AS INTEGER
  blob_bytes AS FUNCTION(BYVAL AS sqlite3_blob PTR) AS INTEGER
  blob_close AS FUNCTION(BYVAL AS sqlite3_blob PTR) AS INTEGER
  blob_open AS FUNCTION(BYVAL AS sqlite3 PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS sqlite3_int64, BYVAL AS INTEGER, BYVAL AS sqlite3_blob PTR PTR) AS INTEGER
  blob_read AS FUNCTION(BYVAL AS sqlite3_blob PTR, BYVAL AS ANY PTR, BYVAL AS INTEGER, BYVAL AS INTEGER) AS INTEGER
  blob_write AS FUNCTION(BYVAL AS sqlite3_blob PTR, BYVAL AS CONST ANY PTR, BYVAL AS INTEGER, BYVAL AS INTEGER) AS INTEGER
  create_collation_v2 AS FUNCTION(BYVAL AS sqlite3 PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS INTEGER, BYVAL AS ANY PTR, BYVAL AS FUNCTION(BYVAL AS ANY PTR, BYVAL AS INTEGER, BYVAL AS CONST ANY PTR, BYVAL AS INTEGER, BYVAL AS CONST ANY PTR) AS INTEGER, BYVAL AS SUB(BYVAL AS ANY PTR)) AS INTEGER
  file_control AS FUNCTION(BYVAL AS sqlite3 PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS INTEGER, BYVAL AS ANY PTR) AS INTEGER
  memory_highwater AS FUNCTION(BYVAL AS INTEGER) AS sqlite3_int64
  memory_used AS FUNCTION() AS sqlite3_int64
  mutex_alloc AS FUNCTION(BYVAL AS INTEGER) AS sqlite3_mutex PTR
  mutex_enter AS SUB(BYVAL AS sqlite3_mutex PTR)
  mutex_free AS SUB(BYVAL AS sqlite3_mutex PTR)
  mutex_leave AS SUB(BYVAL AS sqlite3_mutex PTR)
  mutex_try AS FUNCTION(BYVAL AS sqlite3_mutex PTR) AS INTEGER
  open_v2 AS FUNCTION(BYVAL AS CONST ZSTRING PTR, BYVAL AS sqlite3 PTR PTR, BYVAL AS INTEGER, BYVAL AS CONST ZSTRING PTR) AS INTEGER
  release_memory AS FUNCTION(BYVAL AS INTEGER) AS INTEGER
  result_error_nomem AS SUB(BYVAL AS sqlite3_context PTR)
  result_error_toobig AS SUB(BYVAL AS sqlite3_context PTR)
  sleep_ AS FUNCTION(BYVAL AS INTEGER) AS INTEGER
  soft_heap_limit AS SUB(BYVAL AS INTEGER)
  vfs_find AS FUNCTION(BYVAL AS CONST ZSTRING PTR) AS sqlite3_vfs PTR
  vfs_register AS FUNCTION(BYVAL AS sqlite3_vfs PTR, BYVAL AS INTEGER) AS INTEGER
  vfs_unregister AS FUNCTION(BYVAL AS sqlite3_vfs PTR) AS INTEGER
  xthreadsafe AS FUNCTION() AS INTEGER
  result_zeroblob AS SUB(BYVAL AS sqlite3_context PTR, BYVAL AS INTEGER)
  result_error_code AS SUB(BYVAL AS sqlite3_context PTR, BYVAL AS INTEGER)
  test_control AS FUNCTION(BYVAL AS INTEGER, ...) AS INTEGER
  randomness AS SUB(BYVAL AS INTEGER, BYVAL AS ANY PTR)
  context_db_handle AS FUNCTION(BYVAL AS sqlite3_context PTR) AS sqlite3 PTR
  extended_result_codes AS FUNCTION(BYVAL AS sqlite3 PTR, BYVAL AS INTEGER) AS INTEGER
  limit AS FUNCTION(BYVAL AS sqlite3 PTR, BYVAL AS INTEGER, BYVAL AS INTEGER) AS INTEGER
  next_stmt AS FUNCTION(BYVAL AS sqlite3 PTR, BYVAL AS sqlite3_stmt PTR) AS sqlite3_stmt PTR
  sql AS FUNCTION(BYVAL AS sqlite3_stmt PTR) AS CONST ZSTRING PTR
  status AS FUNCTION(BYVAL AS INTEGER, BYVAL AS INTEGER PTR, BYVAL AS INTEGER PTR, BYVAL AS INTEGER) AS INTEGER
  backup_finish AS FUNCTION(BYVAL AS sqlite3_backup PTR) AS INTEGER
  backup_init AS FUNCTION(BYVAL AS sqlite3 PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS sqlite3 PTR, BYVAL AS CONST ZSTRING PTR) AS sqlite3_backup PTR
  backup_pagecount AS FUNCTION(BYVAL AS sqlite3_backup PTR) AS INTEGER
  backup_remaining AS FUNCTION(BYVAL AS sqlite3_backup PTR) AS INTEGER
  backup_step AS FUNCTION(BYVAL AS sqlite3_backup PTR, BYVAL AS INTEGER) AS INTEGER
  compileoption_get AS FUNCTION(BYVAL AS INTEGER) AS CONST ZSTRING PTR
  compileoption_used AS FUNCTION(BYVAL AS CONST ZSTRING PTR) AS INTEGER
  create_function_v2 AS FUNCTION(BYVAL AS sqlite3 PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS ANY PTR, BYVAL AS SUB(BYVAL AS sqlite3_context PTR, BYVAL AS INTEGER, BYVAL AS sqlite3_value PTR PTR), BYVAL AS SUB(BYVAL AS sqlite3_context PTR, BYVAL AS INTEGER, BYVAL AS sqlite3_value PTR PTR), BYVAL AS SUB(BYVAL AS sqlite3_context PTR), BYVAL AS SUB(BYVAL AS ANY PTR)) AS INTEGER
  db_config AS FUNCTION(BYVAL AS sqlite3 PTR, BYVAL AS INTEGER, ...) AS INTEGER
  db_mutex AS FUNCTION(BYVAL AS sqlite3 PTR) AS sqlite3_mutex PTR
  db_status AS FUNCTION(BYVAL AS sqlite3 PTR, BYVAL AS INTEGER, BYVAL AS INTEGER PTR, BYVAL AS INTEGER PTR, BYVAL AS INTEGER) AS INTEGER
  extended_errcode AS FUNCTION(BYVAL AS sqlite3 PTR) AS INTEGER
  log_ AS SUB(BYVAL AS INTEGER, BYVAL AS CONST ZSTRING PTR, ...)
  soft_heap_limit64 AS FUNCTION(BYVAL AS sqlite3_int64) AS sqlite3_int64
  sourceid AS FUNCTION() AS CONST ZSTRING PTR
  stmt_status AS FUNCTION(BYVAL AS sqlite3_stmt PTR, BYVAL AS INTEGER, BYVAL AS INTEGER) AS INTEGER
  strnicmp AS FUNCTION(BYVAL AS CONST ZSTRING PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS INTEGER) AS INTEGER
  unlock_notify AS FUNCTION(BYVAL AS sqlite3 PTR, BYVAL AS SUB(BYVAL AS ANY PTR PTR, BYVAL AS INTEGER), BYVAL AS ANY PTR) AS INTEGER
  wal_autocheckpoint AS FUNCTION(BYVAL AS sqlite3 PTR, BYVAL AS INTEGER) AS INTEGER
  wal_checkpoint AS FUNCTION(BYVAL AS sqlite3 PTR, BYVAL AS CONST ZSTRING PTR) AS INTEGER
  wal_hook AS FUNCTION(BYVAL AS sqlite3 PTR, BYVAL AS FUNCTION(BYVAL AS ANY PTR, BYVAL AS sqlite3 PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS INTEGER) AS INTEGER, BYVAL AS ANY PTR) AS ANY PTR
  blob_reopen AS FUNCTION(BYVAL AS sqlite3_blob PTR, BYVAL AS sqlite3_int64) AS INTEGER
  vtab_config AS FUNCTION(BYVAL AS sqlite3 PTR, BYVAL AS INTEGER, ...) AS INTEGER
  vtab_on_conflict AS FUNCTION(BYVAL AS sqlite3 PTR) AS INTEGER
END TYPE

#IFNDEF SQLITE_CORE
#UNDEF sqlite3_aggregate_context
#DEFINE sqlite3_aggregate_context sqlite3_api->aggregate_context

#IFNDEF SQLITE_OMIT_DEPRECATED
#UNDEF sqlite3_aggregate_count
#DEFINE sqlite3_aggregate_count sqlite3_api->aggregate_count
#ENDIF ' SQLITE_OMIT_DEPRECATED

#UNDEF sqlite3_bind_blob
#DEFINE sqlite3_bind_blob sqlite3_api->bind_blob
#UNDEF sqlite3_bind_double
#DEFINE sqlite3_bind_double sqlite3_api->bind_double
#UNDEF sqlite3_bind_int
#DEFINE sqlite3_bind_int sqlite3_api->bind_int
#UNDEF sqlite3_bind_int64
#DEFINE sqlite3_bind_int64 sqlite3_api->bind_int64
#UNDEF sqlite3_bind_null
#DEFINE sqlite3_bind_null sqlite3_api->bind_null
#UNDEF sqlite3_bind_parameter_count
#DEFINE sqlite3_bind_parameter_count sqlite3_api->bind_parameter_count
#UNDEF sqlite3_bind_parameter_index
#DEFINE sqlite3_bind_parameter_index sqlite3_api->bind_parameter_index
#UNDEF sqlite3_bind_parameter_name
#DEFINE sqlite3_bind_parameter_name sqlite3_api->bind_parameter_name
#UNDEF sqlite3_bind_text
#DEFINE sqlite3_bind_text sqlite3_api->bind_text
#UNDEF sqlite3_bind_text16
#DEFINE sqlite3_bind_text16 sqlite3_api->bind_text16
#UNDEF sqlite3_bind_value
#DEFINE sqlite3_bind_value sqlite3_api->bind_value
#UNDEF sqlite3_busy_handler
#DEFINE sqlite3_busy_handler sqlite3_api->busy_handler
#UNDEF sqlite3_busy_timeout
#DEFINE sqlite3_busy_timeout sqlite3_api->busy_timeout
#UNDEF sqlite3_changes
#DEFINE sqlite3_changes sqlite3_api->changes
#UNDEF sqlite3_close
#DEFINE sqlite3_close sqlite3_api->close
#UNDEF sqlite3_collation_needed
#DEFINE sqlite3_collation_needed sqlite3_api->collation_needed
#UNDEF sqlite3_collation_needed16
#DEFINE sqlite3_collation_needed16 sqlite3_api->collation_needed16
#UNDEF sqlite3_column_blob
#DEFINE sqlite3_column_blob sqlite3_api->column_blob
#UNDEF sqlite3_column_bytes
#DEFINE sqlite3_column_bytes sqlite3_api->column_bytes
#UNDEF sqlite3_column_bytes16
#DEFINE sqlite3_column_bytes16 sqlite3_api->column_bytes16
#UNDEF sqlite3_column_count
#DEFINE sqlite3_column_count sqlite3_api->column_count
#UNDEF sqlite3_column_database_name
#DEFINE sqlite3_column_database_name sqlite3_api->column_database_name
#UNDEF sqlite3_column_database_name16
#DEFINE sqlite3_column_database_name16 sqlite3_api->column_database_name16
#UNDEF sqlite3_column_decltype
#DEFINE sqlite3_column_decltype sqlite3_api->column_decltype
#UNDEF sqlite3_column_decltype16
#DEFINE sqlite3_column_decltype16 sqlite3_api->column_decltype16
#UNDEF sqlite3_column_double
#DEFINE sqlite3_column_double sqlite3_api->column_double
#UNDEF sqlite3_column_int
#DEFINE sqlite3_column_int sqlite3_api->column_int
#UNDEF sqlite3_column_int64
#DEFINE sqlite3_column_int64 sqlite3_api->column_int64
#UNDEF sqlite3_column_name
#DEFINE sqlite3_column_name sqlite3_api->column_name
#UNDEF sqlite3_column_name16
#DEFINE sqlite3_column_name16 sqlite3_api->column_name16
#UNDEF sqlite3_column_origin_name
#DEFINE sqlite3_column_origin_name sqlite3_api->column_origin_name
#UNDEF sqlite3_column_origin_name16
#DEFINE sqlite3_column_origin_name16 sqlite3_api->column_origin_name16
#UNDEF sqlite3_column_table_name
#DEFINE sqlite3_column_table_name sqlite3_api->column_table_name
#UNDEF sqlite3_column_table_name16
#DEFINE sqlite3_column_table_name16 sqlite3_api->column_table_name16
#UNDEF sqlite3_column_text
#DEFINE sqlite3_column_text sqlite3_api->column_text
#UNDEF sqlite3_column_text16
#DEFINE sqlite3_column_text16 sqlite3_api->column_text16
#UNDEF sqlite3_column_type
#DEFINE sqlite3_column_type sqlite3_api->column_type
#UNDEF sqlite3_column_value
#DEFINE sqlite3_column_value sqlite3_api->column_value
#UNDEF sqlite3_commit_hook
#DEFINE sqlite3_commit_hook sqlite3_api->commit_hook
#UNDEF sqlite3_complete
#DEFINE sqlite3_complete sqlite3_api->complete
#UNDEF sqlite3_complete16
#DEFINE sqlite3_complete16 sqlite3_api->complete16
#UNDEF sqlite3_create_collation
#DEFINE sqlite3_create_collation sqlite3_api->create_collation
#UNDEF sqlite3_create_collation16
#DEFINE sqlite3_create_collation16 sqlite3_api->create_collation16
#UNDEF sqlite3_create_function
#DEFINE sqlite3_create_function sqlite3_api->create_function
#UNDEF sqlite3_create_function16
#DEFINE sqlite3_create_function16 sqlite3_api->create_function16
#UNDEF sqlite3_create_module
#DEFINE sqlite3_create_module sqlite3_api->create_module
#UNDEF sqlite3_create_module_v2
#DEFINE sqlite3_create_module_v2 sqlite3_api->create_module_v2
#UNDEF sqlite3_data_count
#DEFINE sqlite3_data_count sqlite3_api->data_count
#UNDEF sqlite3_db_handle
#DEFINE sqlite3_db_handle sqlite3_api->db_handle
#UNDEF sqlite3_declare_vtab
#DEFINE sqlite3_declare_vtab sqlite3_api->declare_vtab
#UNDEF sqlite3_enable_shared_cache
#DEFINE sqlite3_enable_shared_cache sqlite3_api->enable_shared_cache
#UNDEF sqlite3_errcode
#DEFINE sqlite3_errcode sqlite3_api->errcode
#UNDEF sqlite3_errmsg
#DEFINE sqlite3_errmsg sqlite3_api->errmsg
#UNDEF sqlite3_errmsg16
#DEFINE sqlite3_errmsg16 sqlite3_api->errmsg16
#UNDEF sqlite3_exec
#DEFINE sqlite3_exec sqlite3_api->exec

#IFNDEF SQLITE_OMIT_DEPRECATED
#UNDEF sqlite3_expired
#DEFINE sqlite3_expired sqlite3_api->expired
#ENDIF ' SQLITE_OMIT_DEPRECATED

#UNDEF sqlite3_finalize
#DEFINE sqlite3_finalize sqlite3_api->finalize
#UNDEF sqlite3_free
#DEFINE sqlite3_free sqlite3_api->free
#UNDEF sqlite3_free_table
#DEFINE sqlite3_free_table sqlite3_api->free_table
#UNDEF sqlite3_get_autocommit
#DEFINE sqlite3_get_autocommit sqlite3_api->get_autocommit
#UNDEF sqlite3_get_auxdata
#DEFINE sqlite3_get_auxdata sqlite3_api->get_auxdata
#UNDEF sqlite3_get_table
#DEFINE sqlite3_get_table sqlite3_api->get_table

#IFNDEF SQLITE_OMIT_DEPRECATED
#UNDEF sqlite3_global_recover
#DEFINE sqlite3_global_recover sqlite3_api->global_recover
#ENDIF ' SQLITE_OMIT_DEPRECATED

#UNDEF sqlite3_interrupt
#DEFINE sqlite3_interrupt sqlite3_api->interruptx
#UNDEF sqlite3_last_insert_rowid
#DEFINE sqlite3_last_insert_rowid sqlite3_api->last_insert_rowid
#UNDEF sqlite3_libversion
#DEFINE sqlite3_libversion sqlite3_api->libversion
#UNDEF sqlite3_libversion_number
#DEFINE sqlite3_libversion_number sqlite3_api->libversion_number
#UNDEF sqlite3_malloc
#DEFINE sqlite3_malloc sqlite3_api->malloc
#UNDEF sqlite3_mprintf
#DEFINE sqlite3_mprintf sqlite3_api->mprintf
#UNDEF sqlite3_open
#DEFINE sqlite3_open sqlite3_api->open
#UNDEF sqlite3_open16
#DEFINE sqlite3_open16 sqlite3_api->open16
#UNDEF sqlite3_prepare
#DEFINE sqlite3_prepare sqlite3_api->prepare
#UNDEF sqlite3_prepare16
#DEFINE sqlite3_prepare16 sqlite3_api->prepare16
#UNDEF sqlite3_prepare_v2
#DEFINE sqlite3_prepare_v2 sqlite3_api->prepare_v2
#UNDEF sqlite3_prepare16_v2
#DEFINE sqlite3_prepare16_v2 sqlite3_api->prepare16_v2
#UNDEF sqlite3_profile
#DEFINE sqlite3_profile sqlite3_api->profile
#UNDEF sqlite3_progress_handler
#DEFINE sqlite3_progress_handler sqlite3_api->progress_handler
#UNDEF sqlite3_realloc
#DEFINE sqlite3_realloc sqlite3_api->realloc
#UNDEF sqlite3_reset
#DEFINE sqlite3_reset sqlite3_api->reset
#UNDEF sqlite3_result_blob
#DEFINE sqlite3_result_blob sqlite3_api->result_blob
#UNDEF sqlite3_result_double
#DEFINE sqlite3_result_double sqlite3_api->result_double
#UNDEF sqlite3_result_error
#DEFINE sqlite3_result_error sqlite3_api->result_error
#UNDEF sqlite3_result_error16
#DEFINE sqlite3_result_error16 sqlite3_api->result_error16
#UNDEF sqlite3_result_int
#DEFINE sqlite3_result_int sqlite3_api->result_int
#UNDEF sqlite3_result_int64
#DEFINE sqlite3_result_int64 sqlite3_api->result_int64
#UNDEF sqlite3_result_null
#DEFINE sqlite3_result_null sqlite3_api->result_null
#UNDEF sqlite3_result_text
#DEFINE sqlite3_result_text sqlite3_api->result_text
#UNDEF sqlite3_result_text16
#DEFINE sqlite3_result_text16 sqlite3_api->result_text16
#UNDEF sqlite3_result_text16be
#DEFINE sqlite3_result_text16be sqlite3_api->result_text16be
#UNDEF sqlite3_result_text16le
#DEFINE sqlite3_result_text16le sqlite3_api->result_text16le
#UNDEF sqlite3_result_value
#DEFINE sqlite3_result_value sqlite3_api->result_value
#UNDEF sqlite3_rollback_hook
#DEFINE sqlite3_rollback_hook sqlite3_api->rollback_hook
#UNDEF sqlite3_set_authorizer
#DEFINE sqlite3_set_authorizer sqlite3_api->set_authorizer
#UNDEF sqlite3_set_auxdata
#DEFINE sqlite3_set_auxdata sqlite3_api->set_auxdata
#UNDEF sqlite3_snprintf
#DEFINE sqlite3_snprintf sqlite3_api->snprintf
#UNDEF sqlite3_step
#DEFINE sqlite3_step sqlite3_api->step
#UNDEF sqlite3_table_column_metadata
#DEFINE sqlite3_table_column_metadata sqlite3_api->table_column_metadata
#UNDEF sqlite3_thread_cleanup
#DEFINE sqlite3_thread_cleanup sqlite3_api->thread_cleanup
#UNDEF sqlite3_total_changes
#DEFINE sqlite3_total_changes sqlite3_api->total_changes
#UNDEF sqlite3_trace
#DEFINE sqlite3_trace sqlite3_api->trace

#IFNDEF SQLITE_OMIT_DEPRECATED
#UNDEF sqlite3_transfer_bindings
#DEFINE sqlite3_transfer_bindings sqlite3_api->transfer_bindings
#ENDIF ' SQLITE_OMIT_DEPRECATED

#UNDEF sqlite3_update_hook
#DEFINE sqlite3_update_hook sqlite3_api->update_hook
#UNDEF sqlite3_user_data
#DEFINE sqlite3_user_data sqlite3_api->user_data
#UNDEF sqlite3_value_blob
#DEFINE sqlite3_value_blob sqlite3_api->value_blob
#UNDEF sqlite3_value_bytes
#DEFINE sqlite3_value_bytes sqlite3_api->value_bytes
#UNDEF sqlite3_value_bytes16
#DEFINE sqlite3_value_bytes16 sqlite3_api->value_bytes16
#UNDEF sqlite3_value_double
#DEFINE sqlite3_value_double sqlite3_api->value_double
#UNDEF sqlite3_value_int
#DEFINE sqlite3_value_int sqlite3_api->value_int
#UNDEF sqlite3_value_int64
#DEFINE sqlite3_value_int64 sqlite3_api->value_int64
#UNDEF sqlite3_value_numeric_type
#DEFINE sqlite3_value_numeric_type sqlite3_api->value_numeric_type
#UNDEF sqlite3_value_text
#DEFINE sqlite3_value_text sqlite3_api->value_text
#UNDEF sqlite3_value_text16
#DEFINE sqlite3_value_text16 sqlite3_api->value_text16
#UNDEF sqlite3_value_text16be
#DEFINE sqlite3_value_text16be sqlite3_api->value_text16be
#UNDEF sqlite3_value_text16le
#DEFINE sqlite3_value_text16le sqlite3_api->value_text16le
#UNDEF sqlite3_value_type
#DEFINE sqlite3_value_type sqlite3_api->value_type
#UNDEF sqlite3_vmprintf
#DEFINE sqlite3_vmprintf sqlite3_api->vmprintf
#UNDEF sqlite3_overload_function
#DEFINE sqlite3_overload_function sqlite3_api->overload_function
#UNDEF sqlite3_prepare_v2
#DEFINE sqlite3_prepare_v2 sqlite3_api->prepare_v2
#UNDEF sqlite3_prepare16_v2
#DEFINE sqlite3_prepare16_v2 sqlite3_api->prepare16_v2
#UNDEF sqlite3_clear_bindings
#DEFINE sqlite3_clear_bindings sqlite3_api->clear_bindings
#UNDEF sqlite3_bind_zeroblob
#DEFINE sqlite3_bind_zeroblob sqlite3_api->bind_zeroblob
#UNDEF sqlite3_blob_bytes
#DEFINE sqlite3_blob_bytes sqlite3_api->blob_bytes
#UNDEF sqlite3_blob_close
#DEFINE sqlite3_blob_close sqlite3_api->blob_close
#UNDEF sqlite3_blob_open
#DEFINE sqlite3_blob_open sqlite3_api->blob_open
#UNDEF sqlite3_blob_read
#DEFINE sqlite3_blob_read sqlite3_api->blob_read
#UNDEF sqlite3_blob_write
#DEFINE sqlite3_blob_write sqlite3_api->blob_write
#UNDEF sqlite3_create_collation_v2
#DEFINE sqlite3_create_collation_v2 sqlite3_api->create_collation_v2
#UNDEF sqlite3_file_control
#DEFINE sqlite3_file_control sqlite3_api->file_control
#UNDEF sqlite3_memory_highwater
#DEFINE sqlite3_memory_highwater sqlite3_api->memory_highwater
#UNDEF sqlite3_memory_used
#DEFINE sqlite3_memory_used sqlite3_api->memory_used
#UNDEF sqlite3_mutex_alloc
#DEFINE sqlite3_mutex_alloc sqlite3_api->mutex_alloc
#UNDEF sqlite3_mutex_enter
#DEFINE sqlite3_mutex_enter sqlite3_api->mutex_enter
#UNDEF sqlite3_mutex_free
#DEFINE sqlite3_mutex_free sqlite3_api->mutex_free
#UNDEF sqlite3_mutex_leave
#DEFINE sqlite3_mutex_leave sqlite3_api->mutex_leave
#UNDEF sqlite3_mutex_try
#DEFINE sqlite3_mutex_try sqlite3_api->mutex_try
#UNDEF sqlite3_open_v2
#DEFINE sqlite3_open_v2 sqlite3_api->open_v2
#UNDEF sqlite3_release_memory
#DEFINE sqlite3_release_memory sqlite3_api->release_memory
#UNDEF sqlite3_result_error_nomem
#DEFINE sqlite3_result_error_nomem sqlite3_api->result_error_nomem
#UNDEF sqlite3_result_error_toobig
#DEFINE sqlite3_result_error_toobig sqlite3_api->result_error_toobig
#UNDEF sqlite3_sleep
#DEFINE sqlite3_sleep sqlite3_api->sleep
#UNDEF sqlite3_soft_heap_limit
#DEFINE sqlite3_soft_heap_limit sqlite3_api->soft_heap_limit
#UNDEF sqlite3_vfs_find
#DEFINE sqlite3_vfs_find sqlite3_api->vfs_find
#UNDEF sqlite3_vfs_register
#DEFINE sqlite3_vfs_register sqlite3_api->vfs_register
#UNDEF sqlite3_vfs_unregister
#DEFINE sqlite3_vfs_unregister sqlite3_api->vfs_unregister
#UNDEF sqlite3_threadsafe
#DEFINE sqlite3_threadsafe sqlite3_api->xthreadsafe
#UNDEF sqlite3_result_zeroblob
#DEFINE sqlite3_result_zeroblob sqlite3_api->result_zeroblob
#UNDEF sqlite3_result_error_code
#DEFINE sqlite3_result_error_code sqlite3_api->result_error_code
#UNDEF sqlite3_test_control
#DEFINE sqlite3_test_control sqlite3_api->test_control
#UNDEF sqlite3_randomness
#DEFINE sqlite3_randomness sqlite3_api->randomness
#UNDEF sqlite3_context_db_handle
#DEFINE sqlite3_context_db_handle sqlite3_api->context_db_handle
#UNDEF sqlite3_extended_result_codes
#DEFINE sqlite3_extended_result_codes sqlite3_api->extended_result_codes
#UNDEF sqlite3_limit
#DEFINE sqlite3_limit sqlite3_api->limit
#UNDEF sqlite3_next_stmt
#DEFINE sqlite3_next_stmt sqlite3_api->next_stmt
#UNDEF sqlite3_sql
#DEFINE sqlite3_sql sqlite3_api->sql
#UNDEF sqlite3_status
#DEFINE sqlite3_status sqlite3_api->status
#UNDEF sqlite3_backup_finish
#DEFINE sqlite3_backup_finish sqlite3_api->backup_finish
#UNDEF sqlite3_backup_init
#DEFINE sqlite3_backup_init sqlite3_api->backup_init
#UNDEF sqlite3_backup_pagecount
#DEFINE sqlite3_backup_pagecount sqlite3_api->backup_pagecount
#UNDEF sqlite3_backup_remaining
#DEFINE sqlite3_backup_remaining sqlite3_api->backup_remaining
#UNDEF sqlite3_backup_step
#DEFINE sqlite3_backup_step sqlite3_api->backup_step
#UNDEF sqlite3_compileoption_get
#DEFINE sqlite3_compileoption_get sqlite3_api->compileoption_get
#UNDEF sqlite3_compileoption_used
#DEFINE sqlite3_compileoption_used sqlite3_api->compileoption_used
#UNDEF sqlite3_create_function_v2
#DEFINE sqlite3_create_function_v2 sqlite3_api->create_function_v2
#UNDEF sqlite3_db_config
#DEFINE sqlite3_db_config sqlite3_api->db_config
#UNDEF sqlite3_db_mutex
#DEFINE sqlite3_db_mutex sqlite3_api->db_mutex
#UNDEF sqlite3_db_status
#DEFINE sqlite3_db_status sqlite3_api->db_status
#UNDEF sqlite3_extended_errcode
#DEFINE sqlite3_extended_errcode sqlite3_api->extended_errcode
#UNDEF sqlite3_log
#DEFINE sqlite3_log sqlite3_api->log
#UNDEF sqlite3_soft_heap_limit64
#DEFINE sqlite3_soft_heap_limit64 sqlite3_api->soft_heap_limit64
#UNDEF sqlite3_sourceid
#DEFINE sqlite3_sourceid sqlite3_api->sourceid
#UNDEF sqlite3_stmt_status
#DEFINE sqlite3_stmt_status sqlite3_api->stmt_status
#UNDEF sqlite3_strnicmp
#DEFINE sqlite3_strnicmp sqlite3_api->strnicmp
#UNDEF sqlite3_unlock_notify
#DEFINE sqlite3_unlock_notify sqlite3_api->unlock_notify
#UNDEF sqlite3_wal_autocheckpoint
#DEFINE sqlite3_wal_autocheckpoint sqlite3_api->wal_autocheckpoint
#UNDEF sqlite3_wal_checkpoint
#DEFINE sqlite3_wal_checkpoint sqlite3_api->wal_checkpoint
#UNDEF sqlite3_wal_hook
#DEFINE sqlite3_wal_hook sqlite3_api->wal_hook
#UNDEF sqlite3_blob_reopen
#DEFINE sqlite3_blob_reopen sqlite3_api->blob_reopen
#UNDEF sqlite3_vtab_config
#DEFINE sqlite3_vtab_config sqlite3_api->vtab_config
#UNDEF sqlite3_vtab_on_conflict
#DEFINE sqlite3_vtab_on_conflict sqlite3_api->vtab_on_conflict
#ENDIF ' SQLITE_CORE

#DEFINE SQLITE_EXTENSION_INIT1     DIM AS CONST sqlite3_api_routines PTR sqlite3_api = 0
#DEFINE SQLITE_EXTENSION_INIT2(v)  DIM AS sqlite3_api_routines PTR sqlite3_api = v
#ENDIF ' _SQLITE3EXT_H_

END EXTERN ' (h_2_bi -P_oCD option)

#IFDEF __FB_WIN32__
#PRAGMA pop(msbitfields)
#ENDIF

' Translated at 12-09-01 21:30:21, by h_2_bi (version 0.2.2.1,
' released under GPLv3 by Thomas[ dot ]Freiherr{ at }gmx[ dot ]net)

'   Protocol: sqlite3ext.bi
' Parameters: SQLITE-3.7.13_EXT
'                                  Process time [s]: 0.1245841073105112
'                                  Bytes translated: 28649
'                                      Maximum deep: 1
'                                SUB/FUNCTION names: 0
'                                mangled TYPE names: 1
' sqlite3_api_routines
'                                        files done: 2
' sqlite-amalgamation-3071300/sqlite3ext.h
' sqlite-amalgamation-3071300/sqlite3.h
'                                      files missed: 0
'                                       __FOLDERS__: 1
' sqlite-amalgamation-3071300/
'                                        __MACROS__: 0
'                                       __HEADERS__: 0
'                                         __TYPES__: 0
'                                     __POST_REPS__: 0
