'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   DISCLAIMER
''   This file has no copyright assigned and is placed in the Public Domain.
''   This file is part of the mingw-w64 runtime package.
''
''   The mingw-w64 runtime package and its code is distributed in the hope that it 
''   will be useful but WITHOUT ANY WARRANTY.  ALL WARRANTIES, EXPRESSED OR 
''   IMPLIED ARE HEREBY DISCLAIMED.  This includes but is not limited to 
''   warranties of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "odbc32"

#include once "sqltypes.bi"

extern "Windows"

#define __SQL
const ODBCVER = &h0351
const SQL_NULL_DATA = -1
const SQL_DATA_AT_EXEC = -2
const SQL_SUCCESS = 0
const SQL_SUCCESS_WITH_INFO = 1
const SQL_NO_DATA = 100
const SQL_ERROR = -1
const SQL_INVALID_HANDLE = -2
const SQL_STILL_EXECUTING = 2
const SQL_NEED_DATA = 99
#define SQL_SUCCEEDED(rc) (((rc) and (not 1)) = 0)
const SQL_NTS = -3
const SQL_NTSL = -3
const SQL_MAX_MESSAGE_LENGTH = 512
const SQL_DATE_LEN = 10
const SQL_TIME_LEN = 8
const SQL_TIMESTAMP_LEN = 19
const SQL_HANDLE_ENV = 1
const SQL_HANDLE_DBC = 2
const SQL_HANDLE_STMT = 3
const SQL_HANDLE_DESC = 4
const SQL_ATTR_OUTPUT_NTS = 10001
const SQL_ATTR_AUTO_IPD = 10001
const SQL_ATTR_METADATA_ID = 10014
const SQL_ATTR_APP_ROW_DESC = 10010
const SQL_ATTR_APP_PARAM_DESC = 10011
const SQL_ATTR_IMP_ROW_DESC = 10012
const SQL_ATTR_IMP_PARAM_DESC = 10013
const SQL_ATTR_CURSOR_SCROLLABLE = -1
const SQL_ATTR_CURSOR_SENSITIVITY = -2
const SQL_NONSCROLLABLE = 0
const SQL_SCROLLABLE = 1
const SQL_DESC_COUNT = 1001
const SQL_DESC_TYPE = 1002
const SQL_DESC_LENGTH = 1003
const SQL_DESC_OCTET_LENGTH_PTR = 1004
const SQL_DESC_PRECISION = 1005
const SQL_DESC_SCALE = 1006
const SQL_DESC_DATETIME_INTERVAL_CODE = 1007
const SQL_DESC_NULLABLE = 1008
const SQL_DESC_INDICATOR_PTR = 1009
const SQL_DESC_DATA_PTR = 1010
const SQL_DESC_NAME = 1011
const SQL_DESC_UNNAMED = 1012
const SQL_DESC_OCTET_LENGTH = 1013
const SQL_DESC_ALLOC_TYPE = 1099
const SQL_DIAG_RETURNCODE = 1
const SQL_DIAG_NUMBER = 2
const SQL_DIAG_ROW_COUNT = 3
const SQL_DIAG_SQLSTATE = 4
const SQL_DIAG_NATIVE = 5
const SQL_DIAG_MESSAGE_TEXT = 6
const SQL_DIAG_DYNAMIC_FUNCTION = 7
const SQL_DIAG_CLASS_ORIGIN = 8
const SQL_DIAG_SUBCLASS_ORIGIN = 9
const SQL_DIAG_CONNECTION_NAME = 10
const SQL_DIAG_SERVER_NAME = 11
const SQL_DIAG_DYNAMIC_FUNCTION_CODE = 12
const SQL_DIAG_ALTER_DOMAIN = 3
const SQL_DIAG_ALTER_TABLE = 4
const SQL_DIAG_CALL = 7
const SQL_DIAG_CREATE_ASSERTION = 6
const SQL_DIAG_CREATE_CHARACTER_SET = 8
const SQL_DIAG_CREATE_COLLATION = 10
const SQL_DIAG_CREATE_DOMAIN = 23
const SQL_DIAG_CREATE_INDEX = -1
const SQL_DIAG_CREATE_SCHEMA = 64
const SQL_DIAG_CREATE_TABLE = 77
const SQL_DIAG_CREATE_TRANSLATION = 79
const SQL_DIAG_CREATE_VIEW = 84
const SQL_DIAG_DELETE_WHERE = 19
const SQL_DIAG_DROP_ASSERTION = 24
const SQL_DIAG_DROP_CHARACTER_SET = 25
const SQL_DIAG_DROP_COLLATION = 26
const SQL_DIAG_DROP_DOMAIN = 27
const SQL_DIAG_DROP_INDEX = -2
const SQL_DIAG_DROP_SCHEMA = 31
const SQL_DIAG_DROP_TABLE = 32
const SQL_DIAG_DROP_TRANSLATION = 33
const SQL_DIAG_DROP_VIEW = 36
const SQL_DIAG_DYNAMIC_DELETE_CURSOR = 38
const SQL_DIAG_DYNAMIC_UPDATE_CURSOR = 81
const SQL_DIAG_GRANT = 48
const SQL_DIAG_INSERT = 50
const SQL_DIAG_REVOKE = 59
const SQL_DIAG_SELECT_CURSOR = 85
const SQL_DIAG_UNKNOWN_STATEMENT = 0
const SQL_DIAG_UPDATE_WHERE = 82
const SQL_UNKNOWN_TYPE = 0
const SQL_CHAR = 1
const SQL_NUMERIC = 2
const SQL_DECIMAL = 3
const SQL_INTEGER = 4
const SQL_SMALLINT = 5
const SQL_FLOAT = 6
const SQL_REAL = 7
const SQL_DOUBLE = 8
const SQL_DATETIME = 9
const SQL_VARCHAR = 12
const SQL_TYPE_DATE = 91
const SQL_TYPE_TIME = 92
const SQL_TYPE_TIMESTAMP = 93
const SQL_UNSPECIFIED = 0
const SQL_INSENSITIVE = 1
const SQL_SENSITIVE = 2
const SQL_ALL_TYPES = 0
const SQL_DEFAULT = 99
const SQL_ARD_TYPE = -99
const SQL_CODE_DATE = 1
const SQL_CODE_TIME = 2
const SQL_CODE_TIMESTAMP = 3
const SQL_FALSE = 0
const SQL_TRUE = 1
const SQL_NO_NULLS = 0
const SQL_NULLABLE = 1
const SQL_NULLABLE_UNKNOWN = 2
const SQL_PRED_NONE = 0
const SQL_PRED_CHAR = 1
const SQL_PRED_BASIC = 2
const SQL_NAMED = 0
const SQL_UNNAMED = 1
const SQL_DESC_ALLOC_AUTO = 1
const SQL_DESC_ALLOC_USER = 2
const SQL_CLOSE = 0
const SQL_DROP = 1
const SQL_UNBIND = 2
const SQL_RESET_PARAMS = 3
const SQL_FETCH_NEXT = 1
const SQL_FETCH_FIRST = 2
const SQL_FETCH_LAST = 3
const SQL_FETCH_PRIOR = 4
const SQL_FETCH_ABSOLUTE = 5
const SQL_FETCH_RELATIVE = 6
const SQL_COMMIT = 0
const SQL_ROLLBACK = 1
const SQL_NULL_HENV = 0
const SQL_NULL_HDBC = 0
const SQL_NULL_HSTMT = 0
const SQL_NULL_HDESC = 0
const SQL_NULL_HANDLE = 0
const SQL_SCOPE_CURROW = 0
const SQL_SCOPE_TRANSACTION = 1
const SQL_SCOPE_SESSION = 2
const SQL_PC_UNKNOWN = 0
const SQL_PC_NON_PSEUDO = 1
const SQL_PC_PSEUDO = 2
const SQL_ROW_IDENTIFIER = 1
const SQL_INDEX_UNIQUE = 0
const SQL_INDEX_ALL = 1
const SQL_INDEX_CLUSTERED = 1
const SQL_INDEX_HASHED = 2
const SQL_INDEX_OTHER = 3
const SQL_API_SQLALLOCCONNECT = 1
const SQL_API_SQLALLOCENV = 2
const SQL_API_SQLALLOCHANDLE = 1001
const SQL_API_SQLALLOCSTMT = 3
const SQL_API_SQLBINDCOL = 4
const SQL_API_SQLBINDPARAM = 1002
const SQL_API_SQLCANCEL = 5
const SQL_API_SQLCLOSECURSOR = 1003
const SQL_API_SQLCOLATTRIBUTE = 6
const SQL_API_SQLCOLUMNS = 40
const SQL_API_SQLCONNECT = 7
const SQL_API_SQLCOPYDESC = 1004
const SQL_API_SQLDATASOURCES = 57
const SQL_API_SQLDESCRIBECOL = 8
const SQL_API_SQLDISCONNECT = 9
const SQL_API_SQLENDTRAN = 1005
const SQL_API_SQLERROR = 10
const SQL_API_SQLEXECDIRECT = 11
const SQL_API_SQLEXECUTE = 12
const SQL_API_SQLFETCH = 13
const SQL_API_SQLFETCHSCROLL = 1021
const SQL_API_SQLFREECONNECT = 14
const SQL_API_SQLFREEENV = 15
const SQL_API_SQLFREEHANDLE = 1006
const SQL_API_SQLFREESTMT = 16
const SQL_API_SQLGETCONNECTATTR = 1007
const SQL_API_SQLGETCONNECTOPTION = 42
const SQL_API_SQLGETCURSORNAME = 17
const SQL_API_SQLGETDATA = 43
const SQL_API_SQLGETDESCFIELD = 1008
const SQL_API_SQLGETDESCREC = 1009
const SQL_API_SQLGETDIAGFIELD = 1010
const SQL_API_SQLGETDIAGREC = 1011
const SQL_API_SQLGETENVATTR = 1012
const SQL_API_SQLGETFUNCTIONS = 44
const SQL_API_SQLGETINFO = 45
const SQL_API_SQLGETSTMTATTR = 1014
const SQL_API_SQLGETSTMTOPTION = 46
const SQL_API_SQLGETTYPEINFO = 47
const SQL_API_SQLNUMRESULTCOLS = 18
const SQL_API_SQLPARAMDATA = 48
const SQL_API_SQLPREPARE = 19
const SQL_API_SQLPUTDATA = 49
const SQL_API_SQLROWCOUNT = 20
const SQL_API_SQLSETCONNECTATTR = 1016
const SQL_API_SQLSETCONNECTOPTION = 50
const SQL_API_SQLSETCURSORNAME = 21
const SQL_API_SQLSETDESCFIELD = 1017
const SQL_API_SQLSETDESCREC = 1018
const SQL_API_SQLSETENVATTR = 1019
const SQL_API_SQLSETPARAM = 22
const SQL_API_SQLSETSTMTATTR = 1020
const SQL_API_SQLSETSTMTOPTION = 51
const SQL_API_SQLSPECIALCOLUMNS = 52
const SQL_API_SQLSTATISTICS = 53
const SQL_API_SQLTABLES = 54
const SQL_API_SQLTRANSACT = 23
const SQL_MAX_DRIVER_CONNECTIONS = 0
const SQL_MAXIMUM_DRIVER_CONNECTIONS = SQL_MAX_DRIVER_CONNECTIONS
const SQL_MAX_CONCURRENT_ACTIVITIES = 1
const SQL_MAXIMUM_CONCURRENT_ACTIVITIES = SQL_MAX_CONCURRENT_ACTIVITIES
const SQL_DATA_SOURCE_NAME = 2
const SQL_FETCH_DIRECTION = 8
const SQL_SERVER_NAME = 13
const SQL_SEARCH_PATTERN_ESCAPE = 14
const SQL_DBMS_NAME = 17
const SQL_DBMS_VER = 18
const SQL_ACCESSIBLE_TABLES = 19
const SQL_ACCESSIBLE_PROCEDURES = 20
const SQL_CURSOR_COMMIT_BEHAVIOR = 23
const SQL_DATA_SOURCE_READ_ONLY = 25
const SQL_DEFAULT_TXN_ISOLATION = 26
const SQL_IDENTIFIER_CASE = 28
const SQL_IDENTIFIER_QUOTE_CHAR = 29
const SQL_MAX_COLUMN_NAME_LEN = 30
const SQL_MAXIMUM_COLUMN_NAME_LENGTH = SQL_MAX_COLUMN_NAME_LEN
const SQL_MAX_CURSOR_NAME_LEN = 31
const SQL_MAXIMUM_CURSOR_NAME_LENGTH = SQL_MAX_CURSOR_NAME_LEN
const SQL_MAX_SCHEMA_NAME_LEN = 32
const SQL_MAXIMUM_SCHEMA_NAME_LENGTH = SQL_MAX_SCHEMA_NAME_LEN
const SQL_MAX_CATALOG_NAME_LEN = 34
const SQL_MAXIMUM_CATALOG_NAME_LENGTH = SQL_MAX_CATALOG_NAME_LEN
const SQL_MAX_TABLE_NAME_LEN = 35
const SQL_SCROLL_CONCURRENCY = 43
const SQL_TXN_CAPABLE = 46
const SQL_TRANSACTION_CAPABLE = SQL_TXN_CAPABLE
const SQL_USER_NAME = 47
const SQL_TXN_ISOLATION_OPTION = 72
const SQL_TRANSACTION_ISOLATION_OPTION = SQL_TXN_ISOLATION_OPTION
const SQL_INTEGRITY = 73
const SQL_GETDATA_EXTENSIONS = 81
const SQL_NULL_COLLATION = 85
const SQL_ALTER_TABLE = 86
const SQL_ORDER_BY_COLUMNS_IN_SELECT = 90
const SQL_SPECIAL_CHARACTERS = 94
const SQL_MAX_COLUMNS_IN_GROUP_BY = 97
const SQL_MAXIMUM_COLUMNS_IN_GROUP_BY = SQL_MAX_COLUMNS_IN_GROUP_BY
const SQL_MAX_COLUMNS_IN_INDEX = 98
const SQL_MAXIMUM_COLUMNS_IN_INDEX = SQL_MAX_COLUMNS_IN_INDEX
const SQL_MAX_COLUMNS_IN_ORDER_BY = 99
const SQL_MAXIMUM_COLUMNS_IN_ORDER_BY = SQL_MAX_COLUMNS_IN_ORDER_BY
const SQL_MAX_COLUMNS_IN_SELECT = 100
const SQL_MAXIMUM_COLUMNS_IN_SELECT = SQL_MAX_COLUMNS_IN_SELECT
const SQL_MAX_COLUMNS_IN_TABLE = 101
const SQL_MAX_INDEX_SIZE = 102
const SQL_MAXIMUM_INDEX_SIZE = SQL_MAX_INDEX_SIZE
const SQL_MAX_ROW_SIZE = 104
const SQL_MAXIMUM_ROW_SIZE = SQL_MAX_ROW_SIZE
const SQL_MAX_STATEMENT_LEN = 105
const SQL_MAXIMUM_STATEMENT_LENGTH = SQL_MAX_STATEMENT_LEN
const SQL_MAX_TABLES_IN_SELECT = 106
const SQL_MAXIMUM_TABLES_IN_SELECT = SQL_MAX_TABLES_IN_SELECT
const SQL_MAX_USER_NAME_LEN = 107
const SQL_MAXIMUM_USER_NAME_LENGTH = SQL_MAX_USER_NAME_LEN
const SQL_OJ_CAPABILITIES = 115
const SQL_OUTER_JOIN_CAPABILITIES = SQL_OJ_CAPABILITIES
const SQL_XOPEN_CLI_YEAR = 10000
const SQL_CURSOR_SENSITIVITY = 10001
const SQL_DESCRIBE_PARAMETER = 10002
const SQL_CATALOG_NAME = 10003
const SQL_COLLATION_SEQ = 10004
const SQL_MAX_IDENTIFIER_LEN = 10005
const SQL_MAXIMUM_IDENTIFIER_LENGTH = SQL_MAX_IDENTIFIER_LEN
const SQL_AT_ADD_COLUMN = &h00000001
const SQL_AT_DROP_COLUMN = &h00000002
const SQL_AT_ADD_CONSTRAINT = &h00000008
const SQL_AM_NONE = 0
const SQL_AM_CONNECTION = 1
const SQL_AM_STATEMENT = 2
const SQL_CB_DELETE = 0
const SQL_CB_CLOSE = 1
const SQL_CB_PRESERVE = 2
const SQL_FD_FETCH_NEXT = &h00000001
const SQL_FD_FETCH_FIRST = &h00000002
const SQL_FD_FETCH_LAST = &h00000004
const SQL_FD_FETCH_PRIOR = &h00000008
const SQL_FD_FETCH_ABSOLUTE = &h00000010
const SQL_FD_FETCH_RELATIVE = &h00000020
const SQL_GD_ANY_COLUMN = &h00000001
const SQL_GD_ANY_ORDER = &h00000002
const SQL_IC_UPPER = 1
const SQL_IC_LOWER = 2
const SQL_IC_SENSITIVE = 3
const SQL_IC_MIXED = 4
const SQL_OJ_LEFT = &h00000001
const SQL_OJ_RIGHT = &h00000002
const SQL_OJ_FULL = &h00000004
const SQL_OJ_NESTED = &h00000008
const SQL_OJ_NOT_ORDERED = &h00000010
const SQL_OJ_INNER = &h00000020
const SQL_OJ_ALL_COMPARISON_OPS = &h00000040
const SQL_SCCO_READ_ONLY = &h00000001
const SQL_SCCO_LOCK = &h00000002
const SQL_SCCO_OPT_ROWVER = &h00000004
const SQL_SCCO_OPT_VALUES = &h00000008
const SQL_TC_NONE = 0
const SQL_TC_DML = 1
const SQL_TC_ALL = 2
const SQL_TC_DDL_COMMIT = 3
const SQL_TC_DDL_IGNORE = 4
const SQL_TXN_READ_UNCOMMITTED = &h00000001
const SQL_TRANSACTION_READ_UNCOMMITTED = SQL_TXN_READ_UNCOMMITTED
const SQL_TXN_READ_COMMITTED = &h00000002
const SQL_TRANSACTION_READ_COMMITTED = SQL_TXN_READ_COMMITTED
const SQL_TXN_REPEATABLE_READ = &h00000004
const SQL_TRANSACTION_REPEATABLE_READ = SQL_TXN_REPEATABLE_READ
const SQL_TXN_SERIALIZABLE = &h00000008
const SQL_TRANSACTION_SERIALIZABLE = SQL_TXN_SERIALIZABLE
const SQL_NC_HIGH = 0
const SQL_NC_LOW = 1

declare function SQLAllocConnect(byval EnvironmentHandle as SQLHENV, byval ConnectionHandle as SQLHDBC ptr) as SQLRETURN
declare function SQLAllocEnv(byval EnvironmentHandle as SQLHENV ptr) as SQLRETURN
declare function SQLAllocHandle(byval HandleType as SQLSMALLINT, byval InputHandle as SQLHANDLE, byval OutputHandle as SQLHANDLE ptr) as SQLRETURN
declare function SQLAllocStmt(byval ConnectionHandle as SQLHDBC, byval StatementHandle as SQLHSTMT ptr) as SQLRETURN

#ifdef __FB_64BIT__
	declare function SQLBindCol(byval StatementHandle as SQLHSTMT, byval ColumnNumber as SQLUSMALLINT, byval TargetType as SQLSMALLINT, byval TargetValue as SQLPOINTER, byval BufferLength as SQLLEN, byval StrLen_or_Ind as SQLLEN ptr) as SQLRETURN
	declare function SQLBindParam(byval StatementHandle as SQLHSTMT, byval ParameterNumber as SQLUSMALLINT, byval ValueType as SQLSMALLINT, byval ParameterType as SQLSMALLINT, byval LengthPrecision as SQLULEN, byval ParameterScale as SQLSMALLINT, byval ParameterValue as SQLPOINTER, byval StrLen_or_Ind as SQLLEN ptr) as SQLRETURN
#else
	declare function SQLBindCol(byval StatementHandle as SQLHSTMT, byval ColumnNumber as SQLUSMALLINT, byval TargetType as SQLSMALLINT, byval TargetValue as SQLPOINTER, byval BufferLength as SQLINTEGER, byval StrLen_or_Ind as SQLINTEGER ptr) as SQLRETURN
	declare function SQLBindParam(byval StatementHandle as SQLHSTMT, byval ParameterNumber as SQLUSMALLINT, byval ValueType as SQLSMALLINT, byval ParameterType as SQLSMALLINT, byval LengthPrecision as SQLUINTEGER, byval ParameterScale as SQLSMALLINT, byval ParameterValue as SQLPOINTER, byval StrLen_or_Ind as SQLINTEGER ptr) as SQLRETURN
#endif

declare function SQLCancel(byval StatementHandle as SQLHSTMT) as SQLRETURN
declare function SQLCloseCursor(byval StatementHandle as SQLHSTMT) as SQLRETURN

#ifndef UNICODE
#ifdef __FB_64BIT__
	declare function SQLColAttribute(byval StatementHandle as SQLHSTMT, byval ColumnNumber as SQLUSMALLINT, byval FieldIdentifier as SQLUSMALLINT, byval CharacterAttribute as SQLPOINTER, byval BufferLength as SQLSMALLINT, byval StringLength as SQLSMALLINT ptr, byval NumericAttribute as SQLLEN ptr) as SQLRETURN
#else
	declare function SQLColAttribute(byval StatementHandle as SQLHSTMT, byval ColumnNumber as SQLUSMALLINT, byval FieldIdentifier as SQLUSMALLINT, byval CharacterAttribute as SQLPOINTER, byval BufferLength as SQLSMALLINT, byval StringLength as SQLSMALLINT ptr, byval NumericAttribute as SQLPOINTER) as SQLRETURN
#endif
#endif

#ifndef UNICODE
declare function SQLColumns(byval StatementHandle as SQLHSTMT, byval CatalogName as SQLCHAR ptr, byval NameLength1 as SQLSMALLINT, byval SchemaName as SQLCHAR ptr, byval NameLength2 as SQLSMALLINT, byval TableName as SQLCHAR ptr, byval NameLength3 as SQLSMALLINT, byval ColumnName as SQLCHAR ptr, byval NameLength4 as SQLSMALLINT) as SQLRETURN
declare function SQLConnect(byval ConnectionHandle as SQLHDBC, byval ServerName as SQLCHAR ptr, byval NameLength1 as SQLSMALLINT, byval UserName as SQLCHAR ptr, byval NameLength2 as SQLSMALLINT, byval Authentication as SQLCHAR ptr, byval NameLength3 as SQLSMALLINT) as SQLRETURN
#endif
declare function SQLCopyDesc(byval SourceDescHandle as SQLHDESC, byval TargetDescHandle as SQLHDESC) as SQLRETURN
#ifndef UNICODE
declare function SQLDataSources(byval EnvironmentHandle as SQLHENV, byval Direction as SQLUSMALLINT, byval ServerName as SQLCHAR ptr, byval BufferLength1 as SQLSMALLINT, byval NameLength1 as SQLSMALLINT ptr, byval Description as SQLCHAR ptr, byval BufferLength2 as SQLSMALLINT, byval NameLength2 as SQLSMALLINT ptr) as SQLRETURN
#endif

#ifndef UNICODE
#ifdef __FB_64BIT__
	declare function SQLDescribeCol(byval StatementHandle as SQLHSTMT, byval ColumnNumber as SQLUSMALLINT, byval ColumnName as SQLCHAR ptr, byval BufferLength as SQLSMALLINT, byval NameLength as SQLSMALLINT ptr, byval DataType as SQLSMALLINT ptr, byval ColumnSize as SQLULEN ptr, byval DecimalDigits as SQLSMALLINT ptr, byval Nullable as SQLSMALLINT ptr) as SQLRETURN
#else
	declare function SQLDescribeCol(byval StatementHandle as SQLHSTMT, byval ColumnNumber as SQLUSMALLINT, byval ColumnName as SQLCHAR ptr, byval BufferLength as SQLSMALLINT, byval NameLength as SQLSMALLINT ptr, byval DataType as SQLSMALLINT ptr, byval ColumnSize as SQLUINTEGER ptr, byval DecimalDigits as SQLSMALLINT ptr, byval Nullable as SQLSMALLINT ptr) as SQLRETURN
#endif
#endif

declare function SQLDisconnect(byval ConnectionHandle as SQLHDBC) as SQLRETURN
declare function SQLEndTran(byval HandleType as SQLSMALLINT, byval Handle as SQLHANDLE, byval CompletionType as SQLSMALLINT) as SQLRETURN
#ifndef UNICODE
declare function SQLError(byval EnvironmentHandle as SQLHENV, byval ConnectionHandle as SQLHDBC, byval StatementHandle as SQLHSTMT, byval Sqlstate as SQLCHAR ptr, byval NativeError as SQLINTEGER ptr, byval MessageText as SQLCHAR ptr, byval BufferLength as SQLSMALLINT, byval TextLength as SQLSMALLINT ptr) as SQLRETURN
declare function SQLExecDirect(byval StatementHandle as SQLHSTMT, byval StatementText as SQLCHAR ptr, byval TextLength as SQLINTEGER) as SQLRETURN
#endif
declare function SQLExecute(byval StatementHandle as SQLHSTMT) as SQLRETURN
declare function SQLFetch(byval StatementHandle as SQLHSTMT) as SQLRETURN

#ifdef __FB_64BIT__
	declare function SQLFetchScroll(byval StatementHandle as SQLHSTMT, byval FetchOrientation as SQLSMALLINT, byval FetchOffset as SQLLEN) as SQLRETURN
#else
	declare function SQLFetchScroll(byval StatementHandle as SQLHSTMT, byval FetchOrientation as SQLSMALLINT, byval FetchOffset as SQLINTEGER) as SQLRETURN
#endif

declare function SQLFreeConnect(byval ConnectionHandle as SQLHDBC) as SQLRETURN
declare function SQLFreeEnv(byval EnvironmentHandle as SQLHENV) as SQLRETURN
declare function SQLFreeHandle(byval HandleType as SQLSMALLINT, byval Handle as SQLHANDLE) as SQLRETURN
declare function SQLFreeStmt(byval StatementHandle as SQLHSTMT, byval Option as SQLUSMALLINT) as SQLRETURN
#ifndef UNICODE
declare function SQLGetConnectAttr(byval ConnectionHandle as SQLHDBC, byval Attribute as SQLINTEGER, byval Value as SQLPOINTER, byval BufferLength as SQLINTEGER, byval StringLength as SQLINTEGER ptr) as SQLRETURN
declare function SQLGetConnectOption(byval ConnectionHandle as SQLHDBC, byval Option as SQLUSMALLINT, byval Value as SQLPOINTER) as SQLRETURN
declare function SQLGetCursorName(byval StatementHandle as SQLHSTMT, byval CursorName as SQLCHAR ptr, byval BufferLength as SQLSMALLINT, byval NameLength as SQLSMALLINT ptr) as SQLRETURN
#endif

#ifdef __FB_64BIT__
	declare function SQLGetData(byval StatementHandle as SQLHSTMT, byval ColumnNumber as SQLUSMALLINT, byval TargetType as SQLSMALLINT, byval TargetValue as SQLPOINTER, byval BufferLength as SQLLEN, byval StrLen_or_Ind as SQLLEN ptr) as SQLRETURN
#else
	declare function SQLGetData(byval StatementHandle as SQLHSTMT, byval ColumnNumber as SQLUSMALLINT, byval TargetType as SQLSMALLINT, byval TargetValue as SQLPOINTER, byval BufferLength as SQLINTEGER, byval StrLen_or_Ind as SQLINTEGER ptr) as SQLRETURN
#endif

#ifndef UNICODE
declare function SQLGetDescField(byval DescriptorHandle as SQLHDESC, byval RecNumber as SQLSMALLINT, byval FieldIdentifier as SQLSMALLINT, byval Value as SQLPOINTER, byval BufferLength as SQLINTEGER, byval StringLength as SQLINTEGER ptr) as SQLRETURN
#endif

#ifndef UNICODE
#ifdef __FB_64BIT__
	declare function SQLGetDescRec(byval DescriptorHandle as SQLHDESC, byval RecNumber as SQLSMALLINT, byval Name as SQLCHAR ptr, byval BufferLength as SQLSMALLINT, byval StringLength as SQLSMALLINT ptr, byval Type as SQLSMALLINT ptr, byval SubType as SQLSMALLINT ptr, byval Length as SQLLEN ptr, byval Precision as SQLSMALLINT ptr, byval Scale as SQLSMALLINT ptr, byval Nullable as SQLSMALLINT ptr) as SQLRETURN
#else
	declare function SQLGetDescRec(byval DescriptorHandle as SQLHDESC, byval RecNumber as SQLSMALLINT, byval Name as SQLCHAR ptr, byval BufferLength as SQLSMALLINT, byval StringLength as SQLSMALLINT ptr, byval Type as SQLSMALLINT ptr, byval SubType as SQLSMALLINT ptr, byval Length as SQLINTEGER ptr, byval Precision as SQLSMALLINT ptr, byval Scale as SQLSMALLINT ptr, byval Nullable as SQLSMALLINT ptr) as SQLRETURN
#endif
#endif

#ifndef UNICODE
declare function SQLGetDiagField(byval HandleType as SQLSMALLINT, byval Handle as SQLHANDLE, byval RecNumber as SQLSMALLINT, byval DiagIdentifier as SQLSMALLINT, byval DiagInfo as SQLPOINTER, byval BufferLength as SQLSMALLINT, byval StringLength as SQLSMALLINT ptr) as SQLRETURN
declare function SQLGetDiagRec(byval HandleType as SQLSMALLINT, byval Handle as SQLHANDLE, byval RecNumber as SQLSMALLINT, byval Sqlstate as SQLCHAR ptr, byval NativeError as SQLINTEGER ptr, byval MessageText as SQLCHAR ptr, byval BufferLength as SQLSMALLINT, byval TextLength as SQLSMALLINT ptr) as SQLRETURN
#endif
declare function SQLGetEnvAttr(byval EnvironmentHandle as SQLHENV, byval Attribute as SQLINTEGER, byval Value as SQLPOINTER, byval BufferLength as SQLINTEGER, byval StringLength as SQLINTEGER ptr) as SQLRETURN
declare function SQLGetFunctions(byval ConnectionHandle as SQLHDBC, byval FunctionId as SQLUSMALLINT, byval Supported as SQLUSMALLINT ptr) as SQLRETURN
#ifndef UNICODE
declare function SQLGetInfo(byval ConnectionHandle as SQLHDBC, byval InfoType as SQLUSMALLINT, byval InfoValue as SQLPOINTER, byval BufferLength as SQLSMALLINT, byval StringLength as SQLSMALLINT ptr) as SQLRETURN
declare function SQLGetStmtAttr(byval StatementHandle as SQLHSTMT, byval Attribute as SQLINTEGER, byval Value as SQLPOINTER, byval BufferLength as SQLINTEGER, byval StringLength as SQLINTEGER ptr) as SQLRETURN
#endif
declare function SQLGetStmtOption(byval StatementHandle as SQLHSTMT, byval Option as SQLUSMALLINT, byval Value as SQLPOINTER) as SQLRETURN
#ifndef UNICODE
declare function SQLGetTypeInfo(byval StatementHandle as SQLHSTMT, byval DataType as SQLSMALLINT) as SQLRETURN
#endif
declare function SQLNumResultCols(byval StatementHandle as SQLHSTMT, byval ColumnCount as SQLSMALLINT ptr) as SQLRETURN
declare function SQLParamData(byval StatementHandle as SQLHSTMT, byval Value as SQLPOINTER ptr) as SQLRETURN
#ifndef UNICODE
declare function SQLPrepare(byval StatementHandle as SQLHSTMT, byval StatementText as SQLCHAR ptr, byval TextLength as SQLINTEGER) as SQLRETURN
#endif

#ifdef __FB_64BIT__
	declare function SQLPutData(byval StatementHandle as SQLHSTMT, byval Data as SQLPOINTER, byval StrLen_or_Ind as SQLLEN) as SQLRETURN
	declare function SQLRowCount(byval StatementHandle as SQLHSTMT, byval RowCount as SQLLEN ptr) as SQLRETURN
#else
	declare function SQLPutData(byval StatementHandle as SQLHSTMT, byval Data as SQLPOINTER, byval StrLen_or_Ind as SQLINTEGER) as SQLRETURN
	declare function SQLRowCount(byval StatementHandle as SQLHSTMT, byval RowCount as SQLINTEGER ptr) as SQLRETURN
#endif

#ifndef UNICODE
declare function SQLSetConnectAttr(byval ConnectionHandle as SQLHDBC, byval Attribute as SQLINTEGER, byval Value as SQLPOINTER, byval StringLength as SQLINTEGER) as SQLRETURN
#ifdef __FB_64BIT__
	declare function SQLSetConnectOption(byval ConnectionHandle as SQLHDBC, byval Option as SQLUSMALLINT, byval Value as SQLULEN) as SQLRETURN
#else
	declare function SQLSetConnectOption(byval ConnectionHandle as SQLHDBC, byval Option as SQLUSMALLINT, byval Value as SQLUINTEGER) as SQLRETURN
#endif
declare function SQLSetCursorName(byval StatementHandle as SQLHSTMT, byval CursorName as SQLCHAR ptr, byval NameLength as SQLSMALLINT) as SQLRETURN
declare function SQLSetDescField(byval DescriptorHandle as SQLHDESC, byval RecNumber as SQLSMALLINT, byval FieldIdentifier as SQLSMALLINT, byval Value as SQLPOINTER, byval BufferLength as SQLINTEGER) as SQLRETURN
#endif

#ifdef __FB_64BIT__
	declare function SQLSetDescRec(byval DescriptorHandle as SQLHDESC, byval RecNumber as SQLSMALLINT, byval Type as SQLSMALLINT, byval SubType as SQLSMALLINT, byval Length as SQLLEN, byval Precision as SQLSMALLINT, byval Scale as SQLSMALLINT, byval Data as SQLPOINTER, byval StringLength as SQLLEN ptr, byval Indicator as SQLLEN ptr) as SQLRETURN
#else
	declare function SQLSetDescRec(byval DescriptorHandle as SQLHDESC, byval RecNumber as SQLSMALLINT, byval Type as SQLSMALLINT, byval SubType as SQLSMALLINT, byval Length as SQLINTEGER, byval Precision as SQLSMALLINT, byval Scale as SQLSMALLINT, byval Data as SQLPOINTER, byval StringLength as SQLINTEGER ptr, byval Indicator as SQLINTEGER ptr) as SQLRETURN
#endif

declare function SQLSetEnvAttr(byval EnvironmentHandle as SQLHENV, byval Attribute as SQLINTEGER, byval Value as SQLPOINTER, byval StringLength as SQLINTEGER) as SQLRETURN

#ifdef __FB_64BIT__
	declare function SQLSetParam(byval StatementHandle as SQLHSTMT, byval ParameterNumber as SQLUSMALLINT, byval ValueType as SQLSMALLINT, byval ParameterType as SQLSMALLINT, byval LengthPrecision as SQLULEN, byval ParameterScale as SQLSMALLINT, byval ParameterValue as SQLPOINTER, byval StrLen_or_Ind as SQLLEN ptr) as SQLRETURN
#else
	declare function SQLSetParam(byval StatementHandle as SQLHSTMT, byval ParameterNumber as SQLUSMALLINT, byval ValueType as SQLSMALLINT, byval ParameterType as SQLSMALLINT, byval LengthPrecision as SQLUINTEGER, byval ParameterScale as SQLSMALLINT, byval ParameterValue as SQLPOINTER, byval StrLen_or_Ind as SQLINTEGER ptr) as SQLRETURN
#endif

#ifndef UNICODE
declare function SQLSetStmtAttr(byval StatementHandle as SQLHSTMT, byval Attribute as SQLINTEGER, byval Value as SQLPOINTER, byval StringLength as SQLINTEGER) as SQLRETURN
#endif

#ifdef __FB_64BIT__
	declare function SQLSetStmtOption(byval StatementHandle as SQLHSTMT, byval Option as SQLUSMALLINT, byval Value as SQLULEN) as SQLRETURN
#else
	declare function SQLSetStmtOption(byval StatementHandle as SQLHSTMT, byval Option as SQLUSMALLINT, byval Value as SQLUINTEGER) as SQLRETURN
#endif

#ifndef UNICODE
declare function SQLSpecialColumns(byval StatementHandle as SQLHSTMT, byval IdentifierType as SQLUSMALLINT, byval CatalogName as SQLCHAR ptr, byval NameLength1 as SQLSMALLINT, byval SchemaName as SQLCHAR ptr, byval NameLength2 as SQLSMALLINT, byval TableName as SQLCHAR ptr, byval NameLength3 as SQLSMALLINT, byval Scope as SQLUSMALLINT, byval Nullable as SQLUSMALLINT) as SQLRETURN
declare function SQLStatistics(byval StatementHandle as SQLHSTMT, byval CatalogName as SQLCHAR ptr, byval NameLength1 as SQLSMALLINT, byval SchemaName as SQLCHAR ptr, byval NameLength2 as SQLSMALLINT, byval TableName as SQLCHAR ptr, byval NameLength3 as SQLSMALLINT, byval Unique as SQLUSMALLINT, byval Reserved as SQLUSMALLINT) as SQLRETURN
declare function SQLTables(byval StatementHandle as SQLHSTMT, byval CatalogName as SQLCHAR ptr, byval NameLength1 as SQLSMALLINT, byval SchemaName as SQLCHAR ptr, byval NameLength2 as SQLSMALLINT, byval TableName as SQLCHAR ptr, byval NameLength3 as SQLSMALLINT, byval TableType as SQLCHAR ptr, byval NameLength4 as SQLSMALLINT) as SQLRETURN
#endif
declare function SQLTransact(byval EnvironmentHandle as SQLHENV, byval ConnectionHandle as SQLHDBC, byval CompletionType as SQLUSMALLINT) as SQLRETURN

end extern
