''
''
'' sql -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __sql_bi__
#define __sql_bi__

#inclib "odbc32"

#include once "win/winbase.bi"
#include once "win/sqltypes.bi"

#ifndef ODBCVER
#define ODBCVER &h0351
#endif

#define SQL_NULL_DATA (-1)
#define SQL_DATA_AT_EXEC (-2)
#define SQL_SUCCESS 0
#define SQL_SUCCESS_WITH_INFO 1
#define SQL_NO_DATA 100
#define SQL_ERROR (-1)
#define SQL_INVALID_HANDLE (-2)
#define SQL_STILL_EXECUTING 2
#define SQL_NEED_DATA 99

#define SQL_SUCCEEDED(rc) (((rc) AND (NOT 1)) =0)

#define SQL_NTS (-3)
#define SQL_NTSL (-3L)
#define SQL_MAX_MESSAGE_LENGTH 512
#define SQL_DATE_LEN 10
#define SQL_TIME_LEN 8
#define SQL_TIMESTAMP_LEN 19
#define SQL_HANDLE_ENV 1
#define SQL_HANDLE_DBC 2
#define SQL_HANDLE_STMT 3
#define SQL_HANDLE_DESC 4
#define SQL_ATTR_OUTPUT_NTS 10001
#define SQL_ATTR_AUTO_IPD 10001
#define SQL_ATTR_METADATA_ID 10014
#define SQL_ATTR_APP_ROW_DESC 10010
#define SQL_ATTR_APP_PARAM_DESC 10011
#define SQL_ATTR_IMP_ROW_DESC 10012
#define SQL_ATTR_IMP_PARAM_DESC 10013
#define SQL_ATTR_CURSOR_SCROLLABLE (-1)
#define SQL_ATTR_CURSOR_SENSITIVITY (-2)
#define SQL_NONSCROLLABLE 0
#define SQL_SCROLLABLE 1
#define SQL_DESC_COUNT 1001
#define SQL_DESC_TYPE 1002
#define SQL_DESC_LENGTH 1003
#define SQL_DESC_OCTET_LENGTH_PTR 1004
#define SQL_DESC_PRECISION 1005
#define SQL_DESC_SCALE 1006
#define SQL_DESC_DATETIME_INTERVAL_CODE 1007
#define SQL_DESC_NULLABLE 1008
#define SQL_DESC_INDICATOR_PTR 1009
#define SQL_DESC_DATA_PTR 1010
#define SQL_DESC_NAME 1011
#define SQL_DESC_UNNAMED 1012
#define SQL_DESC_OCTET_LENGTH 1013
#define SQL_DESC_ALLOC_TYPE 1099
#define SQL_DIAG_RETURNCODE 1
#define SQL_DIAG_NUMBER 2
#define SQL_DIAG_ROW_COUNT 3
#define SQL_DIAG_SQLSTATE 4
#define SQL_DIAG_NATIVE 5
#define SQL_DIAG_MESSAGE_TEXT 6
#define SQL_DIAG_DYNAMIC_FUNCTION 7
#define SQL_DIAG_CLASS_ORIGIN 8
#define SQL_DIAG_SUBCLASS_ORIGIN 9
#define SQL_DIAG_CONNECTION_NAME 10
#define SQL_DIAG_SERVER_NAME 11
#define SQL_DIAG_DYNAMIC_FUNCTION_CODE 12
#define SQL_DIAG_ALTER_DOMAIN 3
#define SQL_DIAG_ALTER_TABLE 4
#define SQL_DIAG_CALL 7
#define SQL_DIAG_CREATE_ASSERTION 6
#define SQL_DIAG_CREATE_CHARACTER_SET 8
#define SQL_DIAG_CREATE_COLLATION 10
#define SQL_DIAG_CREATE_DOMAIN 23
#define SQL_DIAG_CREATE_INDEX (-1)
#define SQL_DIAG_CREATE_SCHEMA 64
#define SQL_DIAG_CREATE_TABLE 77
#define SQL_DIAG_CREATE_TRANSLATION 79
#define SQL_DIAG_CREATE_VIEW 84
#define SQL_DIAG_DELETE_WHERE 19
#define SQL_DIAG_DROP_ASSERTION 24
#define SQL_DIAG_DROP_CHARACTER_SET 25
#define SQL_DIAG_DROP_COLLATION 26
#define SQL_DIAG_DROP_DOMAIN 27
#define SQL_DIAG_DROP_INDEX (-2)
#define SQL_DIAG_DROP_SCHEMA 31
#define SQL_DIAG_DROP_TABLE 32
#define SQL_DIAG_DROP_TRANSLATION 33
#define SQL_DIAG_DROP_VIEW 36
#define SQL_DIAG_DYNAMIC_DELETE_CURSOR 38
#define SQL_DIAG_DYNAMIC_UPDATE_CURSOR 81
#define SQL_DIAG_GRANT 48
#define SQL_DIAG_INSERT 50
#define SQL_DIAG_REVOKE 59
#define SQL_DIAG_SELECT_CURSOR 85
#define SQL_DIAG_UNKNOWN_STATEMENT 0
#define SQL_DIAG_UPDATE_WHERE 82
#define SQL_UNKNOWN_TYPE 0
#define SQL_CHAR 1
#define SQL_NUMERIC 2
#define SQL_DECIMAL 3
#define SQL_INTEGER 4
#define SQL_SMALLINT 5
#define SQL_FLOAT 6
#define SQL_REAL 7
#define SQL_DOUBLE 8
#define SQL_DATETIME 9
#define SQL_VARCHAR 12
#define SQL_TYPE_DATE 91
#define SQL_TYPE_TIME 92
#define SQL_TYPE_TIMESTAMP 93
#define SQL_UNSPECIFIED 0
#define SQL_INSENSITIVE 1
#define SQL_SENSITIVE 2
#define SQL_ALL_TYPES 0
#define SQL_DEFAULT 99
#define SQL_ARD_TYPE (-99)
#define SQL_CODE_DATE 1
#define SQL_CODE_TIME 2
#define SQL_CODE_TIMESTAMP 3
#define SQL_FALSE 0
#define SQL_TRUE 1
#define SQL_NO_NULLS 0
#define SQL_NULLABLE 1
#define SQL_NULLABLE_UNKNOWN 2
#define SQL_PRED_NONE 0
#define SQL_PRED_CHAR 1
#define SQL_PRED_BASIC 2
#define SQL_NAMED 0
#define SQL_UNNAMED 1
#define SQL_DESC_ALLOC_AUTO 1
#define SQL_DESC_ALLOC_USER 2
#define SQL_CLOSE 0
#define SQL_DROP 1
#define SQL_UNBIND 2
#define SQL_RESET_PARAMS 3
#define SQL_FETCH_NEXT 1
#define SQL_FETCH_FIRST 2
#define SQL_FETCH_LAST 3
#define SQL_FETCH_PRIOR 4
#define SQL_FETCH_ABSOLUTE 5
#define SQL_FETCH_RELATIVE 6
#define SQL_COMMIT 0
#define SQL_ROLLBACK 1
#define SQL_NULL_HENV 0
#define SQL_NULL_HDBC 0
#define SQL_NULL_HSTMT 0
#define SQL_NULL_HDESC 0
#define SQL_NULL_HANDLE 0L
#define SQL_SCOPE_CURROW 0
#define SQL_SCOPE_TRANSACTION 1
#define SQL_SCOPE_SESSION 2
#define SQL_PC_UNKNOWN 0
#define SQL_PC_NON_PSEUDO 1
#define SQL_PC_PSEUDO 2
#define SQL_ROW_IDENTIFIER 1
#define SQL_INDEX_UNIQUE 0
#define SQL_INDEX_ALL 1
#define SQL_INDEX_CLUSTERED 1
#define SQL_INDEX_HASHED 2
#define SQL_INDEX_OTHER 3
#define SQL_API_SQLALLOCCONNECT 1
#define SQL_API_SQLALLOCENV 2
#define SQL_API_SQLALLOCHANDLE 1001
#define SQL_API_SQLALLOCSTMT 3
#define SQL_API_SQLBINDCOL 4
#define SQL_API_SQLBINDPARAM 1002
#define SQL_API_SQLCANCEL 5
#define SQL_API_SQLCLOSECURSOR 1003
#define SQL_API_SQLCOLATTRIBUTE 6
#define SQL_API_SQLCOLUMNS 40
#define SQL_API_SQLCONNECT 7
#define SQL_API_SQLCOPYDESC 1004
#define SQL_API_SQLDATASOURCES 57
#define SQL_API_SQLDESCRIBECOL 8
#define SQL_API_SQLDISCONNECT 9
#define SQL_API_SQLENDTRAN 1005
#define SQL_API_SQLERROR 10
#define SQL_API_SQLEXECDIRECT 11
#define SQL_API_SQLEXECUTE 12
#define SQL_API_SQLFETCH 13
#define SQL_API_SQLFETCHSCROLL 1021
#define SQL_API_SQLFREECONNECT 14
#define SQL_API_SQLFREEENV 15
#define SQL_API_SQLFREEHANDLE 1006
#define SQL_API_SQLFREESTMT 16
#define SQL_API_SQLGETCONNECTATTR 1007
#define SQL_API_SQLGETCONNECTOPTION 42
#define SQL_API_SQLGETCURSORNAME 17
#define SQL_API_SQLGETDATA 43
#define SQL_API_SQLGETDESCFIELD 1008
#define SQL_API_SQLGETDESCREC 1009
#define SQL_API_SQLGETDIAGFIELD 1010
#define SQL_API_SQLGETDIAGREC 1011
#define SQL_API_SQLGETENVATTR 1012
#define SQL_API_SQLGETFUNCTIONS 44
#define SQL_API_SQLGETINFO 45
#define SQL_API_SQLGETSTMTATTR 1014
#define SQL_API_SQLGETSTMTOPTION 46
#define SQL_API_SQLGETTYPEINFO 47
#define SQL_API_SQLNUMRESULTCOLS 18
#define SQL_API_SQLPARAMDATA 48
#define SQL_API_SQLPREPARE 19
#define SQL_API_SQLPUTDATA 49
#define SQL_API_SQLROWCOUNT 20
#define SQL_API_SQLSETCONNECTATTR 1016
#define SQL_API_SQLSETCONNECTOPTION 50
#define SQL_API_SQLSETCURSORNAME 21
#define SQL_API_SQLSETDESCFIELD 1017
#define SQL_API_SQLSETDESCREC 1018
#define SQL_API_SQLSETENVATTR 1019
#define SQL_API_SQLSETPARAM 22
#define SQL_API_SQLSETSTMTATTR 1020
#define SQL_API_SQLSETSTMTOPTION 51
#define SQL_API_SQLSPECIALCOLUMNS 52
#define SQL_API_SQLSTATISTICS 53
#define SQL_API_SQLTABLES 54
#define SQL_API_SQLTRANSACT 23
#define SQL_MAX_DRIVER_CONNECTIONS 0
#define SQL_MAXIMUM_DRIVER_CONNECTIONS 0
#define SQL_MAX_CONCURRENT_ACTIVITIES 1
#define SQL_MAXIMUM_CONCURRENT_ACTIVITIES 1
#define SQL_DATA_SOURCE_NAME 2
#define SQL_FETCH_DIRECTION 8
#define SQL_SERVER_NAME 13
#define SQL_SEARCH_PATTERN_ESCAPE 14
#define SQL_DBMS_NAME 17
#define SQL_DBMS_VER 18
#define SQL_ACCESSIBLE_TABLES 19
#define SQL_ACCESSIBLE_PROCEDURES 20
#define SQL_CURSOR_COMMIT_BEHAVIOR 23
#define SQL_DATA_SOURCE_READ_ONLY 25
#define SQL_DEFAULT_TXN_ISOLATION 26
#define SQL_IDENTIFIER_CASE 28
#define SQL_IDENTIFIER_QUOTE_CHAR 29
#define SQL_MAX_COLUMN_NAME_LEN 30
#define SQL_MAXIMUM_COLUMN_NAME_LENGTH 30
#define SQL_MAX_CURSOR_NAME_LEN 31
#define SQL_MAXIMUM_CURSOR_NAME_LENGTH 31
#define SQL_MAX_SCHEMA_NAME_LEN 32
#define SQL_MAXIMUM_SCHEMA_NAME_LENGTH 32
#define SQL_MAX_CATALOG_NAME_LEN 34
#define SQL_MAXIMUM_CATALOG_NAME_LENGTH 34
#define SQL_MAX_TABLE_NAME_LEN 35
#define SQL_SCROLL_CONCURRENCY 43
#define SQL_TXN_CAPABLE 46
#define SQL_TRANSACTION_CAPABLE 46
#define SQL_USER_NAME 47
#define SQL_TXN_ISOLATION_OPTION 72
#define SQL_TRANSACTION_ISOLATION_OPTION 72
#define SQL_INTEGRITY 73
#define SQL_GETDATA_EXTENSIONS 81
#define SQL_NULL_COLLATION 85
#define SQL_ALTER_TABLE 86
#define SQL_ORDER_BY_COLUMNS_IN_SELECT 90
#define SQL_SPECIAL_CHARACTERS 94
#define SQL_MAX_COLUMNS_IN_GROUP_BY 97
#define SQL_MAXIMUM_COLUMNS_IN_GROUP_BY 97
#define SQL_MAX_COLUMNS_IN_INDEX 98
#define SQL_MAXIMUM_COLUMNS_IN_INDEX 98
#define SQL_MAX_COLUMNS_IN_ORDER_BY 99
#define SQL_MAXIMUM_COLUMNS_IN_ORDER_BY 99
#define SQL_MAX_COLUMNS_IN_SELECT 100
#define SQL_MAXIMUM_COLUMNS_IN_SELECT 100
#define SQL_MAX_COLUMNS_IN_TABLE 101
#define SQL_MAX_INDEX_SIZE 102
#define SQL_MAXIMUM_INDEX_SIZE 102
#define SQL_MAX_ROW_SIZE 104
#define SQL_MAXIMUM_ROW_SIZE 104
#define SQL_MAX_STATEMENT_LEN 105
#define SQL_MAXIMUM_STATEMENT_LENGTH 105
#define SQL_MAX_TABLES_IN_SELECT 106
#define SQL_MAXIMUM_TABLES_IN_SELECT 106
#define SQL_MAX_USER_NAME_LEN 107
#define SQL_MAXIMUM_USER_NAME_LENGTH 107
#define SQL_OJ_CAPABILITIES 115
#define SQL_OUTER_JOIN_CAPABILITIES 115
#define SQL_XOPEN_CLI_YEAR 10000
#define SQL_CURSOR_SENSITIVITY 10001
#define SQL_DESCRIBE_PARAMETER 10002
#define SQL_CATALOG_NAME 10003
#define SQL_COLLATION_SEQ 10004
#define SQL_MAX_IDENTIFIER_LEN 10005
#define SQL_MAXIMUM_IDENTIFIER_LENGTH 10005
#define SQL_AT_ADD_COLUMN &h00000001L
#define SQL_AT_DROP_COLUMN &h00000002L
#define SQL_AT_ADD_CONSTRAINT &h00000008L
#define SQL_AM_NONE 0
#define SQL_AM_CONNECTION 1
#define SQL_AM_STATEMENT 2
#define SQL_CB_DELETE 0
#define SQL_CB_CLOSE 1
#define SQL_CB_PRESERVE 2
#define SQL_FD_FETCH_NEXT &h00000001L
#define SQL_FD_FETCH_FIRST &h00000002L
#define SQL_FD_FETCH_LAST &h00000004L
#define SQL_FD_FETCH_PRIOR &h00000008L
#define SQL_FD_FETCH_ABSOLUTE &h00000010L
#define SQL_FD_FETCH_RELATIVE &h00000020L
#define SQL_GD_ANY_COLUMN &h00000001L
#define SQL_GD_ANY_ORDER &h00000002L
#define SQL_IC_UPPER 1
#define SQL_IC_LOWER 2
#define SQL_IC_SENSITIVE 3
#define SQL_IC_MIXED 4
#define SQL_OJ_LEFT &h00000001L
#define SQL_OJ_RIGHT &h00000002L
#define SQL_OJ_FULL &h00000004L
#define SQL_OJ_NESTED &h00000008L
#define SQL_OJ_NOT_ORDERED &h00000010L
#define SQL_OJ_INNER &h00000020L
#define SQL_OJ_ALL_COMPARISON_OPS &h00000040L
#define SQL_SCCO_READ_ONLY &h00000001L
#define SQL_SCCO_LOCK &h00000002L
#define SQL_SCCO_OPT_ROWVER &h00000004L
#define SQL_SCCO_OPT_VALUES &h00000008L
#define SQL_TC_NONE 0
#define SQL_TC_DML 1
#define SQL_TC_ALL 2
#define SQL_TC_DDL_COMMIT 3
#define SQL_TC_DDL_IGNORE 4
#define SQL_TXN_READ_UNCOMMITTED &h00000001L
#define SQL_TRANSACTION_READ_UNCOMMITTED &h00000001L
#define SQL_TXN_READ_COMMITTED &h00000002L
#define SQL_TRANSACTION_READ_COMMITTED &h00000002L
#define SQL_TXN_REPEATABLE_READ &h00000004L
#define SQL_TRANSACTION_REPEATABLE_READ &h00000004L
#define SQL_TXN_SERIALIZABLE &h00000008L
#define SQL_TRANSACTION_SERIALIZABLE &h00000008L
#define SQL_NC_HIGH 0
#define SQL_NC_LOW 1

declare function SQLAllocConnect alias "SQLAllocConnect" (byval EnvironmentHandle as SQLHENV, byval ConnectionHandle as SQLHDBC ptr) as SQLRETURN
declare function SQLAllocEnv alias "SQLAllocEnv" (byval EnvironmentHandle as SQLHENV ptr) as SQLRETURN
declare function SQLAllocHandle alias "SQLAllocHandle" (byval HandleType as SQLSMALLINT, byval InputHandle as SQLHANDLE, byval OutputHandle as SQLHANDLE ptr) as SQLRETURN
declare function SQLAllocStmt alias "SQLAllocStmt" (byval ConnectionHandle as SQLHDBC, byval StatementHandle as SQLHSTMT ptr) as SQLRETURN
declare function SQLBindCol alias "SQLBindCol" (byval StatementHandle as SQLHSTMT, byval ColumnNumber as SQLUSMALLINT, byval TargetType as SQLSMALLINT, byval TargetValue as SQLPOINTER, byval BufferLength as SQLINTEGER, byval StrLen_or_Ind as SQLINTEGER ptr) as SQLRETURN
declare function SQLBindParam alias "SQLBindParam" (byval StatementHandle as SQLHSTMT, byval ParameterNumber as SQLUSMALLINT, byval ValueType as SQLSMALLINT, byval ParameterType as SQLSMALLINT, byval LengthPrecision as SQLUINTEGER, byval ParameterScale as SQLSMALLINT, byval ParameterValue as SQLPOINTER, byval StrLen_or_Ind as SQLINTEGER ptr) as SQLRETURN
declare function SQLCancel alias "SQLCancel" (byval StatementHandle as SQLHSTMT) as SQLRETURN
declare function SQLCloseCursor alias "SQLCloseCursor" (byval StatementHandle as SQLHSTMT) as SQLRETURN
declare function SQLColAttribute alias "SQLColAttribute" (byval StatementHandle as SQLHSTMT, byval ColumnNumber as SQLUSMALLINT, byval FieldIdentifier as SQLUSMALLINT, byval CharacterAttribute as SQLPOINTER, byval BufferLength as SQLSMALLINT, byval StringLength as SQLSMALLINT ptr, byval NumericAttribute as SQLPOINTER) as SQLRETURN
declare function SQLColumns alias "SQLColumns" (byval StatementHandle as SQLHSTMT, byval CatalogName as string, byval NameLength1 as SQLSMALLINT, byval SchemaName as string, byval NameLength2 as SQLSMALLINT, byval TableName as string, byval NameLength3 as SQLSMALLINT, byval ColumnName as string, byval NameLength4 as SQLSMALLINT) as SQLRETURN
declare function SQLConnect alias "SQLConnect" (byval ConnectionHandle as SQLHDBC, byval ServerName as string, byval NameLength1 as SQLSMALLINT, byval UserName as string, byval NameLength2 as SQLSMALLINT, byval Authentication as string, byval NameLength3 as SQLSMALLINT) as SQLRETURN
declare function SQLCopyDesc alias "SQLCopyDesc" (byval SourceDescHandle as SQLHDESC, byval TargetDescHandle as SQLHDESC) as SQLRETURN
declare function SQLDataSources alias "SQLDataSources" (byval EnvironmentHandle as SQLHENV, byval Direction as SQLUSMALLINT, byval ServerName as string, byval BufferLength1 as SQLSMALLINT, byval NameLength1 as SQLSMALLINT ptr, byval Description as string, byval BufferLength2 as SQLSMALLINT, byval NameLength2 as SQLSMALLINT ptr) as SQLRETURN
declare function SQLDescribeCol alias "SQLDescribeCol" (byval StatementHandle as SQLHSTMT, byval ColumnNumber as SQLUSMALLINT, byval ColumnName as string, byval BufferLength as SQLSMALLINT, byval NameLength as SQLSMALLINT ptr, byval DataType as SQLSMALLINT ptr, byval ColumnSize as SQLUINTEGER ptr, byval DecimalDigits as SQLSMALLINT ptr, byval Nullable as SQLSMALLINT ptr) as SQLRETURN
declare function SQLDisconnect alias "SQLDisconnect" (byval ConnectionHandle as SQLHDBC) as SQLRETURN
declare function SQLEndTran alias "SQLEndTran" (byval HandleType as SQLSMALLINT, byval Handle as SQLHANDLE, byval CompletionType as SQLSMALLINT) as SQLRETURN
declare function SQLError alias "SQLError" (byval EnvironmentHandle as SQLHENV, byval ConnectionHandle as SQLHDBC, byval StatementHandle as SQLHSTMT, byval Sqlstate as string, byval NativeError as SQLINTEGER ptr, byval MessageText as string, byval BufferLength as SQLSMALLINT, byval TextLength as SQLSMALLINT ptr) as SQLRETURN
declare function SQLExecDirect alias "SQLExecDirect" (byval StatementHandle as SQLHSTMT, byval StatementText as string, byval TextLength as SQLINTEGER) as SQLRETURN
declare function SQLExecute alias "SQLExecute" (byval StatementHandle as SQLHSTMT) as SQLRETURN
declare function SQLFetch alias "SQLFetch" (byval StatementHandle as SQLHSTMT) as SQLRETURN
declare function SQLFetchScroll alias "SQLFetchScroll" (byval StatementHandle as SQLHSTMT, byval FetchOrientation as SQLSMALLINT, byval FetchOffset as SQLINTEGER) as SQLRETURN
declare function SQLFreeConnect alias "SQLFreeConnect" (byval ConnectionHandle as SQLHDBC) as SQLRETURN
declare function SQLFreeEnv alias "SQLFreeEnv" (byval EnvironmentHandle as SQLHENV) as SQLRETURN
declare function SQLFreeHandle alias "SQLFreeHandle" (byval HandleType as SQLSMALLINT, byval Handle as SQLHANDLE) as SQLRETURN
declare function SQLFreeStmt alias "SQLFreeStmt" (byval StatementHandle as SQLHSTMT, byval Option as SQLUSMALLINT) as SQLRETURN
declare function SQLGetConnectAttr alias "SQLGetConnectAttr" (byval ConnectionHandle as SQLHDBC, byval Attribute as SQLINTEGER, byval Value as SQLPOINTER, byval BufferLength as SQLINTEGER, byval StringLength as SQLINTEGER ptr) as SQLRETURN
declare function SQLGetConnectOption alias "SQLGetConnectOption" (byval ConnectionHandle as SQLHDBC, byval Option as SQLUSMALLINT, byval Value as SQLPOINTER) as SQLRETURN
declare function SQLGetCursorName alias "SQLGetCursorName" (byval StatementHandle as SQLHSTMT, byval CursorName as string, byval BufferLength as SQLSMALLINT, byval NameLength as SQLSMALLINT ptr) as SQLRETURN
declare function SQLGetData alias "SQLGetData" (byval StatementHandle as SQLHSTMT, byval ColumnNumber as SQLUSMALLINT, byval TargetType as SQLSMALLINT, byval TargetValue as SQLPOINTER, byval BufferLength as SQLINTEGER, byval StrLen_or_Ind as SQLINTEGER ptr) as SQLRETURN
declare function SQLGetDescField alias "SQLGetDescField" (byval DescriptorHandle as SQLHDESC, byval RecNumber as SQLSMALLINT, byval FieldIdentifier as SQLSMALLINT, byval Value as SQLPOINTER, byval BufferLength as SQLINTEGER, byval StringLength as SQLINTEGER ptr) as SQLRETURN
declare function SQLGetDescRec alias "SQLGetDescRec" (byval DescriptorHandle as SQLHDESC, byval RecNumber as SQLSMALLINT, byval Name as string, byval BufferLength as SQLSMALLINT, byval StringLength as SQLSMALLINT ptr, byval Type as SQLSMALLINT ptr, byval SubType as SQLSMALLINT ptr, byval Length as SQLINTEGER ptr, byval Precision as SQLSMALLINT ptr, byval Scale as SQLSMALLINT ptr, byval Nullable as SQLSMALLINT ptr) as SQLRETURN
declare function SQLGetDiagField alias "SQLGetDiagField" (byval HandleType as SQLSMALLINT, byval Handle as SQLHANDLE, byval RecNumber as SQLSMALLINT, byval DiagIdentifier as SQLSMALLINT, byval DiagInfo as SQLPOINTER, byval BufferLength as SQLSMALLINT, byval StringLength as SQLSMALLINT ptr) as SQLRETURN
declare function SQLGetDiagRec alias "SQLGetDiagRec" (byval HandleType as SQLSMALLINT, byval Handle as SQLHANDLE, byval RecNumber as SQLSMALLINT, byval Sqlstate as string, byval NativeError as SQLINTEGER ptr, byval MessageText as string, byval BufferLength as SQLSMALLINT, byval TextLength as SQLSMALLINT ptr) as SQLRETURN
declare function SQLGetEnvAttr alias "SQLGetEnvAttr" (byval EnvironmentHandle as SQLHENV, byval Attribute as SQLINTEGER, byval Value as SQLPOINTER, byval BufferLength as SQLINTEGER, byval StringLength as SQLINTEGER ptr) as SQLRETURN
declare function SQLGetFunctions alias "SQLGetFunctions" (byval ConnectionHandle as SQLHDBC, byval FunctionId as SQLUSMALLINT, byval Supported as SQLUSMALLINT ptr) as SQLRETURN
declare function SQLGetInfo alias "SQLGetInfo" (byval ConnectionHandle as SQLHDBC, byval InfoType as SQLUSMALLINT, byval InfoValue as SQLPOINTER, byval BufferLength as SQLSMALLINT, byval StringLength as SQLSMALLINT ptr) as SQLRETURN
declare function SQLGetStmtAttr alias "SQLGetStmtAttr" (byval StatementHandle as SQLHSTMT, byval Attribute as SQLINTEGER, byval Value as SQLPOINTER, byval BufferLength as SQLINTEGER, byval StringLength as SQLINTEGER ptr) as SQLRETURN
declare function SQLGetStmtOption alias "SQLGetStmtOption" (byval StatementHandle as SQLHSTMT, byval Option as SQLUSMALLINT, byval Value as SQLPOINTER) as SQLRETURN
declare function SQLGetTypeInfo alias "SQLGetTypeInfo" (byval StatementHandle as SQLHSTMT, byval DataType as SQLSMALLINT) as SQLRETURN
declare function SQLNumResultCols alias "SQLNumResultCols" (byval StatementHandle as SQLHSTMT, byval ColumnCount as SQLSMALLINT ptr) as SQLRETURN
declare function SQLParamData alias "SQLParamData" (byval StatementHandle as SQLHSTMT, byval Value as SQLPOINTER ptr) as SQLRETURN
declare function SQLPrepare alias "SQLPrepare" (byval StatementHandle as SQLHSTMT, byval StatementText as string, byval TextLength as SQLINTEGER) as SQLRETURN
declare function SQLPutData alias "SQLPutData" (byval StatementHandle as SQLHSTMT, byval Data as SQLPOINTER, byval StrLen_or_Ind as SQLINTEGER) as SQLRETURN
declare function SQLRowCount alias "SQLRowCount" (byval StatementHandle as SQLHSTMT, byval RowCount as SQLINTEGER ptr) as SQLRETURN
declare function SQLSetConnectAttr alias "SQLSetConnectAttr" (byval ConnectionHandle as SQLHDBC, byval Attribute as SQLINTEGER, byval Value as SQLPOINTER, byval StringLength as SQLINTEGER) as SQLRETURN
declare function SQLSetConnectOption alias "SQLSetConnectOption" (byval ConnectionHandle as SQLHDBC, byval Option as SQLUSMALLINT, byval Value as SQLUINTEGER) as SQLRETURN
declare function SQLSetCursorName alias "SQLSetCursorName" (byval StatementHandle as SQLHSTMT, byval CursorName as string, byval NameLength as SQLSMALLINT) as SQLRETURN
declare function SQLSetDescField alias "SQLSetDescField" (byval DescriptorHandle as SQLHDESC, byval RecNumber as SQLSMALLINT, byval FieldIdentifier as SQLSMALLINT, byval Value as SQLPOINTER, byval BufferLength as SQLINTEGER) as SQLRETURN
declare function SQLSetDescRec alias "SQLSetDescRec" (byval DescriptorHandle as SQLHDESC, byval RecNumber as SQLSMALLINT, byval Type as SQLSMALLINT, byval SubType as SQLSMALLINT, byval Length as SQLINTEGER, byval Precision as SQLSMALLINT, byval Scale as SQLSMALLINT, byval Data as SQLPOINTER, byval StringLength as SQLINTEGER ptr, byval Indicator as SQLINTEGER ptr) as SQLRETURN
declare function SQLSetEnvAttr alias "SQLSetEnvAttr" (byval EnvironmentHandle as SQLHENV, byval Attribute as SQLINTEGER, byval Value as SQLPOINTER, byval StringLength as SQLINTEGER) as SQLRETURN
declare function SQLSetParam alias "SQLSetParam" (byval StatementHandle as SQLHSTMT, byval ParameterNumber as SQLUSMALLINT, byval ValueType as SQLSMALLINT, byval ParameterType as SQLSMALLINT, byval LengthPrecision as SQLUINTEGER, byval ParameterScale as SQLSMALLINT, byval ParameterValue as SQLPOINTER, byval StrLen_or_Ind as SQLINTEGER ptr) as SQLRETURN
declare function SQLSetStmtAttr alias "SQLSetStmtAttr" (byval StatementHandle as SQLHSTMT, byval Attribute as SQLINTEGER, byval Value as SQLPOINTER, byval StringLength as SQLINTEGER) as SQLRETURN
declare function SQLSetStmtOption alias "SQLSetStmtOption" (byval StatementHandle as SQLHSTMT, byval Option as SQLUSMALLINT, byval Value as SQLUINTEGER) as SQLRETURN
declare function SQLSpecialColumns alias "SQLSpecialColumns" (byval StatementHandle as SQLHSTMT, byval IdentifierType as SQLUSMALLINT, byval CatalogName as string, byval NameLength1 as SQLSMALLINT, byval SchemaName as string, byval NameLength2 as SQLSMALLINT, byval TableName as string, byval NameLength3 as SQLSMALLINT, byval Scope as SQLUSMALLINT, byval Nullable as SQLUSMALLINT) as SQLRETURN
declare function SQLStatistics alias "SQLStatistics" (byval StatementHandle as SQLHSTMT, byval CatalogName as string, byval NameLength1 as SQLSMALLINT, byval SchemaName as string, byval NameLength2 as SQLSMALLINT, byval TableName as string, byval NameLength3 as SQLSMALLINT, byval Unique as SQLUSMALLINT, byval Reserved as SQLUSMALLINT) as SQLRETURN
declare function SQLTables alias "SQLTables" (byval StatementHandle as SQLHSTMT, byval CatalogName as string, byval NameLength1 as SQLSMALLINT, byval SchemaName as string, byval NameLength2 as SQLSMALLINT, byval TableName as string, byval NameLength3 as SQLSMALLINT, byval TableType as string, byval NameLength4 as SQLSMALLINT) as SQLRETURN
declare function SQLTransact alias "SQLTransact" (byval EnvironmentHandle as SQLHENV, byval ConnectionHandle as SQLHDBC, byval CompletionType as SQLUSMALLINT) as SQLRETURN

#endif
