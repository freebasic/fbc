''
''
'' sqlucode -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_sqlucode_bi__
#define __win_sqlucode_bi__

#include once "win/sqlext.bi"

#define SQL_WCHAR (-8)
#define SQL_WVARCHAR (-9)
#define SQL_WLONGVARCHAR (-10)
#define SQL_C_WCHAR (-8)
#define SQL_SQLSTATE_SIZEW 10

#ifdef UNICODE
#define SQL_C_TCHAR SQL_C_WCHAR

declare function SQLBrowseConnectW alias "SQLBrowseConnectW" (byval as SQLHDBC, byval as SQLWCHAR ptr, byval as SQLSMALLINT, byval as SQLWCHAR ptr, byval as SQLSMALLINT, byval as SQLSMALLINT ptr) as SQLRETURN
declare function SQLColAttributeW alias "SQLColAttributeW" (byval as SQLHSTMT, byval as SQLUSMALLINT, byval as SQLUSMALLINT, byval as SQLPOINTER, byval as SQLSMALLINT, byval as SQLSMALLINT ptr, byval as SQLPOINTER) as SQLRETURN
declare function SQLColAttributesW alias "SQLColAttributesW" (byval as SQLHSTMT, byval as SQLUSMALLINT, byval as SQLUSMALLINT, byval as SQLPOINTER, byval as SQLSMALLINT, byval as SQLSMALLINT ptr, byval as SQLINTEGER ptr) as SQLRETURN
declare function SQLColumnPrivilegesW alias "SQLColumnPrivilegesW" (byval as SQLHSTMT, byval as SQLWCHAR ptr, byval as SQLSMALLINT, byval as SQLWCHAR ptr, byval as SQLSMALLINT, byval as SQLWCHAR ptr, byval as SQLSMALLINT, byval as SQLWCHAR ptr, byval as SQLSMALLINT) as SQLRETURN
declare function SQLColumnsW alias "SQLColumnsW" (byval as SQLHSTMT, byval as SQLWCHAR ptr, byval as SQLSMALLINT, byval as SQLWCHAR ptr, byval as SQLSMALLINT, byval as SQLWCHAR ptr, byval as SQLSMALLINT, byval as SQLWCHAR ptr, byval as SQLSMALLINT) as SQLRETURN
declare function SQLConnectW alias "SQLConnectW" (byval as SQLHDBC, byval as SQLWCHAR ptr, byval as SQLSMALLINT, byval as SQLWCHAR ptr, byval as SQLSMALLINT, byval as SQLWCHAR ptr, byval as SQLSMALLINT) as SQLRETURN
declare function SQLDataSourcesW alias "SQLDataSourcesW" (byval as SQLHENV, byval as SQLUSMALLINT, byval as SQLWCHAR ptr, byval as SQLSMALLINT, byval as SQLSMALLINT ptr, byval as SQLWCHAR ptr, byval as SQLSMALLINT, byval as SQLSMALLINT ptr) as SQLRETURN
declare function SQLDescribeColW alias "SQLDescribeColW" (byval as SQLHSTMT, byval as SQLUSMALLINT, byval as SQLWCHAR ptr, byval as SQLSMALLINT, byval as SQLSMALLINT ptr, byval as SQLSMALLINT ptr, byval as SQLUINTEGER ptr, byval as SQLSMALLINT ptr, byval as SQLSMALLINT ptr) as SQLRETURN
declare function SQLDriverConnectW alias "SQLDriverConnectW" (byval as SQLHDBC, byval as SQLHWND, byval as SQLWCHAR ptr, byval as SQLSMALLINT, byval as SQLWCHAR ptr, byval as SQLSMALLINT, byval as SQLSMALLINT ptr, byval as SQLUSMALLINT) as SQLRETURN
declare function SQLDriversW alias "SQLDriversW" (byval as SQLHENV, byval as SQLUSMALLINT, byval as SQLWCHAR ptr, byval as SQLSMALLINT, byval as SQLSMALLINT ptr, byval as SQLWCHAR ptr, byval as SQLSMALLINT, byval as SQLSMALLINT ptr) as SQLRETURN
declare function SQLErrorW alias "SQLErrorW" (byval as SQLHENV, byval as SQLHDBC, byval as SQLHSTMT, byval as SQLWCHAR ptr, byval as SQLINTEGER ptr, byval as SQLWCHAR ptr, byval as SQLSMALLINT, byval as SQLSMALLINT ptr) as SQLRETURN
declare function SQLExecDirectW alias "SQLExecDirectW" (byval as SQLHSTMT, byval as SQLWCHAR ptr, byval as SQLINTEGER) as SQLRETURN
declare function SQLForeignKeysW alias "SQLForeignKeysW" (byval as SQLHSTMT, byval as SQLWCHAR ptr, byval as SQLSMALLINT, byval as SQLWCHAR ptr, byval as SQLSMALLINT, byval as SQLWCHAR ptr, byval as SQLSMALLINT, byval as SQLWCHAR ptr, byval as SQLSMALLINT, byval as SQLWCHAR ptr, byval as SQLSMALLINT, byval as SQLWCHAR ptr, byval as SQLSMALLINT) as SQLRETURN
declare function SQLGetConnectAttrW alias "SQLGetConnectAttrW" (byval as SQLHDBC, byval as SQLINTEGER, byval as SQLPOINTER, byval as SQLINTEGER, byval as SQLINTEGER ptr) as SQLRETURN
declare function SQLGetConnectOptionW alias "SQLGetConnectOptionW" (byval as SQLHDBC, byval as SQLUSMALLINT, byval as SQLPOINTER) as SQLRETURN
declare function SQLGetCursorNameW alias "SQLGetCursorNameW" (byval as SQLHSTMT, byval as SQLWCHAR ptr, byval as SQLSMALLINT, byval as SQLSMALLINT ptr) as SQLRETURN
declare function SQLGetInfoW alias "SQLGetInfoW" (byval as SQLHDBC, byval as SQLUSMALLINT, byval as SQLPOINTER, byval as SQLSMALLINT, byval as SQLSMALLINT ptr) as SQLRETURN
declare function SQLGetStmtAttrW alias "SQLGetStmtAttrW" (byval as SQLHSTMT, byval as SQLINTEGER, byval as SQLPOINTER, byval as SQLINTEGER, byval as SQLINTEGER ptr) as SQLRETURN
declare function SQLGetTypeInfoW alias "SQLGetTypeInfoW" (byval as SQLHSTMT, byval as SQLSMALLINT) as SQLRETURN
declare function SQLNativeSqlW alias "SQLNativeSqlW" (byval as SQLHDBC, byval as SQLWCHAR ptr, byval as SQLINTEGER, byval as SQLWCHAR ptr, byval as SQLINTEGER, byval as SQLINTEGER ptr) as SQLRETURN
declare function SQLPrepareW alias "SQLPrepareW" (byval as SQLHSTMT, byval as SQLWCHAR ptr, byval as SQLINTEGER) as SQLRETURN
declare function SQLPrimaryKeysW alias "SQLPrimaryKeysW" (byval as SQLHSTMT, byval as SQLWCHAR ptr, byval as SQLSMALLINT, byval as SQLWCHAR ptr, byval as SQLSMALLINT, byval as SQLWCHAR ptr, byval as SQLSMALLINT) as SQLRETURN
declare function SQLProcedureColumnsW alias "SQLProcedureColumnsW" (byval as SQLHSTMT, byval as SQLWCHAR ptr, byval as SQLSMALLINT, byval as SQLWCHAR ptr, byval as SQLSMALLINT, byval as SQLWCHAR ptr, byval as SQLSMALLINT, byval as SQLWCHAR ptr, byval as SQLSMALLINT) as SQLRETURN
declare function SQLProceduresW alias "SQLProceduresW" (byval as SQLHSTMT, byval as SQLWCHAR ptr, byval as SQLSMALLINT, byval as SQLWCHAR ptr, byval as SQLSMALLINT, byval as SQLWCHAR ptr, byval as SQLSMALLINT) as SQLRETURN
declare function SQLSetConnectAttrW alias "SQLSetConnectAttrW" (byval as SQLHDBC, byval as SQLINTEGER, byval as SQLPOINTER, byval as SQLINTEGER) as SQLRETURN
declare function SQLSetConnectOptionW alias "SQLSetConnectOptionW" (byval as SQLHDBC, byval as SQLUSMALLINT, byval as SQLUINTEGER) as SQLRETURN
declare function SQLSetCursorNameW alias "SQLSetCursorNameW" (byval as SQLHSTMT, byval as SQLWCHAR ptr, byval as SQLSMALLINT) as SQLRETURN
declare function SQLSetStmtAttrW alias "SQLSetStmtAttrW" (byval as SQLHSTMT, byval as SQLINTEGER, byval as SQLPOINTER, byval as SQLINTEGER) as SQLRETURN
declare function SQLSpecialColumnsW alias "SQLSpecialColumnsW" (byval as SQLHSTMT, byval as SQLUSMALLINT, byval as SQLWCHAR ptr, byval as SQLSMALLINT, byval as SQLWCHAR ptr, byval as SQLSMALLINT, byval as SQLWCHAR ptr, byval as SQLSMALLINT, byval as SQLUSMALLINT, byval as SQLUSMALLINT) as SQLRETURN
declare function SQLStatisticsW alias "SQLStatisticsW" (byval as SQLHSTMT, byval as SQLWCHAR ptr, byval as SQLSMALLINT, byval as SQLWCHAR ptr, byval as SQLSMALLINT, byval as SQLWCHAR ptr, byval as SQLSMALLINT, byval as SQLUSMALLINT, byval as SQLUSMALLINT) as SQLRETURN
declare function SQLTablePrivilegesW alias "SQLTablePrivilegesW" (byval as SQLHSTMT, byval as SQLWCHAR ptr, byval as SQLSMALLINT, byval as SQLWCHAR ptr, byval as SQLSMALLINT, byval as SQLWCHAR ptr, byval as SQLSMALLINT) as SQLRETURN
declare function SQLTablesW alias "SQLTablesW" (byval as SQLHSTMT, byval as SQLWCHAR ptr, byval as SQLSMALLINT, byval as SQLWCHAR ptr, byval as SQLSMALLINT, byval as SQLWCHAR ptr, byval as SQLSMALLINT, byval as SQLWCHAR ptr, byval as SQLSMALLINT) as SQLRETURN
declare function SQLSetDescFieldW alias "SQLSetDescFieldW" (byval as SQLHDESC, byval as SQLSMALLINT, byval as SQLSMALLINT, byval as SQLPOINTER, byval as SQLINTEGER, byval as SQLINTEGER ptr) as SQLRETURN
declare function SQLGetDescRecW alias "SQLGetDescRecW" (byval as SQLHDESC, byval as SQLSMALLINT, byval as SQLWCHAR ptr, byval as SQLSMALLINT, byval as SQLSMALLINT ptr, byval as SQLSMALLINT ptr, byval as SQLSMALLINT ptr, byval as SQLINTEGER ptr, byval as SQLSMALLINT ptr, byval as SQLSMALLINT ptr, byval as SQLSMALLINT ptr) as SQLRETURN
declare function SQLGetDiagFieldW alias "SQLGetDiagFieldW" (byval as SQLSMALLINT, byval as SQLHANDLE, byval as SQLSMALLINT, byval as SQLSMALLINT, byval as SQLPOINTER, byval as SQLSMALLINT, byval as SQLSMALLINT ptr) as SQLRETURN
declare function SQLGetDiagRecW alias "SQLGetDiagRecW" (byval as SQLSMALLINT, byval as SQLHANDLE, byval as SQLSMALLINT, byval as SQLWCHAR ptr, byval as SQLINTEGER ptr, byval as SQLWCHAR ptr, byval as SQLSMALLINT, byval as SQLSMALLINT ptr) as SQLRETURN

#else
#define SQL_C_TCHAR SQL_C_CHAR

declare function SQLBrowseConnectA alias "SQLBrowseConnectA" (byval as SQLHDBC, byval as SQLCHAR ptr, byval as SQLSMALLINT, byval as SQLCHAR ptr, byval as SQLSMALLINT, byval as SQLSMALLINT ptr) as SQLRETURN
declare function SQLColAttributeA alias "SQLColAttributeA" (byval as SQLHSTMT, byval as SQLSMALLINT, byval as SQLSMALLINT, byval as SQLPOINTER, byval as SQLSMALLINT, byval as SQLSMALLINT ptr, byval as SQLPOINTER) as SQLRETURN
declare function SQLColAttributesA alias "SQLColAttributesA" (byval as SQLHSTMT, byval as SQLUSMALLINT, byval as SQLUSMALLINT, byval as SQLPOINTER, byval as SQLSMALLINT, byval as SQLSMALLINT ptr, byval as SQLINTEGER ptr) as SQLRETURN
declare function SQLColumnPrivilegesA alias "SQLColumnPrivilegesA" (byval as SQLHSTMT, byval as SQLCHAR ptr, byval as SQLSMALLINT, byval as SQLCHAR ptr, byval as SQLSMALLINT, byval as SQLCHAR ptr, byval as SQLSMALLINT, byval as SQLCHAR ptr, byval as SQLSMALLINT) as SQLRETURN
declare function SQLColumnsA alias "SQLColumnsA" (byval as SQLHSTMT, byval as SQLCHAR ptr, byval as SQLSMALLINT, byval as SQLCHAR ptr, byval as SQLSMALLINT, byval as SQLCHAR ptr, byval as SQLSMALLINT, byval as SQLCHAR ptr, byval as SQLSMALLINT) as SQLRETURN
declare function SQLConnectA alias "SQLConnectA" (byval as SQLHDBC, byval as SQLCHAR ptr, byval as SQLSMALLINT, byval as SQLCHAR ptr, byval as SQLSMALLINT, byval as SQLCHAR ptr, byval as SQLSMALLINT) as SQLRETURN
declare function SQLDataSourcesA alias "SQLDataSourcesA" (byval as SQLHENV, byval as SQLUSMALLINT, byval as SQLCHAR ptr, byval as SQLSMALLINT, byval as SQLSMALLINT ptr, byval as SQLCHAR ptr, byval as SQLSMALLINT, byval as SQLSMALLINT ptr) as SQLRETURN
declare function SQLDescribeColA alias "SQLDescribeColA" (byval as SQLHSTMT, byval as SQLUSMALLINT, byval as SQLCHAR ptr, byval as SQLSMALLINT, byval as SQLSMALLINT ptr, byval as SQLSMALLINT ptr, byval as SQLUINTEGER ptr, byval as SQLSMALLINT ptr, byval as SQLSMALLINT ptr) as SQLRETURN
declare function SQLDriverConnectA alias "SQLDriverConnectA" (byval as SQLHDBC, byval as SQLHWND, byval as SQLCHAR ptr, byval as SQLSMALLINT, byval as SQLCHAR ptr, byval as SQLSMALLINT, byval as SQLSMALLINT ptr, byval as SQLUSMALLINT) as SQLRETURN
declare function SQLDriversA alias "SQLDriversA" (byval as SQLHENV, byval as SQLUSMALLINT, byval as SQLCHAR ptr, byval as SQLSMALLINT, byval as SQLSMALLINT ptr, byval as SQLCHAR ptr, byval as SQLSMALLINT, byval as SQLSMALLINT ptr) as SQLRETURN
declare function SQLErrorA alias "SQLErrorA" (byval as SQLHENV, byval as SQLHDBC, byval as SQLHSTMT, byval as SQLCHAR ptr, byval as SQLINTEGER ptr, byval as SQLCHAR ptr, byval as SQLSMALLINT, byval as SQLSMALLINT ptr) as SQLRETURN
declare function SQLExecDirectA alias "SQLExecDirectA" (byval as SQLHSTMT, byval as SQLCHAR ptr, byval as SQLINTEGER) as SQLRETURN
declare function SQLForeignKeysA alias "SQLForeignKeysA" (byval as SQLHSTMT, byval as SQLCHAR ptr, byval as SQLSMALLINT, byval as SQLCHAR ptr, byval as SQLSMALLINT, byval as SQLCHAR ptr, byval as SQLSMALLINT, byval as SQLCHAR ptr, byval as SQLSMALLINT, byval as SQLCHAR ptr, byval as SQLSMALLINT, byval as SQLCHAR ptr, byval as SQLSMALLINT) as SQLRETURN
declare function SQLGetConnectAttrA alias "SQLGetConnectAttrA" (byval as SQLHDBC, byval as SQLINTEGER, byval as SQLPOINTER, byval as SQLINTEGER, byval as SQLINTEGER ptr) as SQLRETURN
declare function SQLGetConnectOptionA alias "SQLGetConnectOptionA" (byval as SQLHDBC, byval as SQLUSMALLINT, byval as SQLPOINTER) as SQLRETURN
declare function SQLGetCursorNameA alias "SQLGetCursorNameA" (byval as SQLHSTMT, byval as SQLCHAR ptr, byval as SQLSMALLINT, byval as SQLSMALLINT ptr) as SQLRETURN
declare function SQLGetInfoA alias "SQLGetInfoA" (byval as SQLHDBC, byval as SQLUSMALLINT, byval as SQLPOINTER, byval as SQLSMALLINT, byval as SQLSMALLINT ptr) as SQLRETURN
declare function SQLGetStmtAttrA alias "SQLGetStmtAttrA" (byval as SQLHSTMT, byval as SQLINTEGER, byval as SQLPOINTER, byval as SQLINTEGER, byval as SQLINTEGER ptr) as SQLRETURN
declare function SQLGetTypeInfoA alias "SQLGetTypeInfoA" (byval as SQLHSTMT, byval as SQLSMALLINT) as SQLRETURN
declare function SQLNativeSqlA alias "SQLNativeSqlA" (byval as SQLHDBC, byval as SQLCHAR ptr, byval as SQLINTEGER, byval as SQLCHAR ptr, byval as SQLINTEGER, byval as SQLINTEGER ptr) as SQLRETURN
declare function SQLPrepareA alias "SQLPrepareA" (byval as SQLHSTMT, byval as SQLCHAR ptr, byval as SQLINTEGER) as SQLRETURN
declare function SQLPrimaryKeysA alias "SQLPrimaryKeysA" (byval as SQLHSTMT, byval as SQLCHAR ptr, byval as SQLSMALLINT, byval as SQLCHAR ptr, byval as SQLSMALLINT, byval as SQLCHAR ptr, byval as SQLSMALLINT) as SQLRETURN
declare function SQLProcedureColumnsA alias "SQLProcedureColumnsA" (byval as SQLHSTMT, byval as SQLCHAR ptr, byval as SQLSMALLINT, byval as SQLCHAR ptr, byval as SQLSMALLINT, byval as SQLCHAR ptr, byval as SQLSMALLINT, byval as SQLCHAR ptr, byval as SQLSMALLINT) as SQLRETURN
declare function SQLProceduresA alias "SQLProceduresA" (byval as SQLHSTMT, byval as SQLCHAR ptr, byval as SQLSMALLINT, byval as SQLCHAR ptr, byval as SQLSMALLINT, byval as SQLCHAR ptr, byval as SQLSMALLINT) as SQLRETURN
declare function SQLSetConnectAttrA alias "SQLSetConnectAttrA" (byval as SQLHDBC, byval as SQLINTEGER, byval as SQLPOINTER, byval as SQLINTEGER) as SQLRETURN
declare function SQLSetConnectOptionA alias "SQLSetConnectOptionA" (byval as SQLHDBC, byval as SQLUSMALLINT, byval as SQLUINTEGER) as SQLRETURN
declare function SQLSetCursorNameA alias "SQLSetCursorNameA" (byval as SQLHSTMT, byval as SQLCHAR ptr, byval as SQLSMALLINT) as SQLRETURN
declare function SQLSetStmtAttrA alias "SQLSetStmtAttrA" (byval as SQLHSTMT, byval as SQLINTEGER, byval as SQLPOINTER, byval as SQLINTEGER) as SQLRETURN
declare function SQLSpecialColumnsA alias "SQLSpecialColumnsA" (byval as SQLHSTMT, byval as SQLUSMALLINT, byval as SQLCHAR ptr, byval as SQLSMALLINT, byval as SQLCHAR ptr, byval as SQLSMALLINT, byval as SQLCHAR ptr, byval as SQLSMALLINT, byval as SQLUSMALLINT, byval as SQLUSMALLINT) as SQLRETURN
declare function SQLStatisticsA alias "SQLStatisticsA" (byval as SQLHSTMT, byval as SQLCHAR ptr, byval as SQLSMALLINT, byval as SQLCHAR ptr, byval as SQLSMALLINT, byval as SQLCHAR ptr, byval as SQLSMALLINT, byval as SQLUSMALLINT, byval as SQLUSMALLINT) as SQLRETURN
declare function SQLTablePrivilegesA alias "SQLTablePrivilegesA" (byval as SQLHSTMT, byval as SQLCHAR ptr, byval as SQLSMALLINT, byval as SQLCHAR ptr, byval as SQLSMALLINT, byval as SQLCHAR ptr, byval as SQLSMALLINT) as SQLRETURN
declare function SQLTablesA alias "SQLTablesA" (byval as SQLHSTMT, byval as SQLCHAR ptr, byval as SQLSMALLINT, byval as SQLCHAR ptr, byval as SQLSMALLINT, byval as SQLCHAR ptr, byval as SQLSMALLINT, byval as SQLCHAR ptr, byval as SQLSMALLINT) as SQLRETURN
declare function SQLGetDescFieldA alias "SQLGetDescFieldA" (byval as SQLHDESC, byval as SQLSMALLINT, byval as SQLSMALLINT, byval as SQLPOINTER, byval as SQLINTEGER, byval as SQLINTEGER ptr) as SQLRETURN
declare function SQLGetDescRecA alias "SQLGetDescRecA" (byval as SQLHDESC, byval as SQLSMALLINT, byval as SQLCHAR ptr, byval as SQLSMALLINT, byval as SQLSMALLINT ptr, byval as SQLSMALLINT ptr, byval as SQLSMALLINT ptr, byval as SQLINTEGER ptr, byval as SQLSMALLINT ptr, byval as SQLSMALLINT ptr, byval as SQLSMALLINT ptr) as SQLRETURN
declare function SQLGetDiagFieldA alias "SQLGetDiagFieldA" (byval as SQLSMALLINT, byval as SQLHANDLE, byval as SQLSMALLINT, byval as SQLSMALLINT, byval as SQLPOINTER, byval as SQLSMALLINT, byval as SQLSMALLINT ptr) as SQLRETURN
declare function SQLGetDiagRecA alias "SQLGetDiagRecA" (byval as SQLSMALLINT, byval as SQLHANDLE, byval as SQLSMALLINT, byval as SQLCHAR ptr, byval as SQLINTEGER ptr, byval as SQLCHAR ptr, byval as SQLSMALLINT, byval as SQLSMALLINT ptr) as SQLRETURN

#endif 

#ifdef UNICODE
#undef SQLBrowseConnect
#undef SQLColAttribute
#undef SQLColAttributes
#undef SQLColumnPrivileges
#undef SQLColumns
#undef SQLConnect
#undef SQLDataSources
#undef SQLDescribeCol
#undef SQLDriverConnect
#undef SQLDrivers
#undef SQLError
#undef SQLExecDirect
#undef SQLForeignKeys
#undef SQLGetConnectAttr
#undef SQLGetConnectOption
#undef SQLGetCursorName
#undef SQLGetDescField
#undef SQLGetDescRec
#undef SQLGetDiagField
#undef SQLGetDiagRec
#undef SQLGetInfo
#undef SQLGetStmtAttr
#undef SQLGetTypeInfo
#undef SQLNativeSql
#undef SQLPrepare
#undef SQLPrimaryKeys
#undef SQLProcedureColumns
#undef SQLProcedures
#undef SQLSetConnectAttr
#undef SQLSetConnectOption
#undef SQLSetCursorName
#undef SQLSetDescField
#undef SQLSetStmtAttr
#undef SQLSpecialColumns
#undef SQLStatistics
#undef SQLTablePrivileges
#undef SQLTables

#define SQLBrowseConnect SQLBrowseConnectW
#define SQLColAttribute SQLColAttributeW
#define SQLColAttributes SQLColAttributesW
#define SQLColumnPrivileges SQLColumnPrivilegesW
#define SQLColumns SQLColumnsW
#define SQLConnect SQLConnectW
#define SQLDataSources SQLDataSourcesW
#define SQLDescribeCol SQLDescribeColW
#define SQLDriverConnect SQLDriverConnectW
#define SQLDrivers SQLDriversW
#define SQLError SQLErrorW
#define SQLExecDirect SQLExecDirectW
#define SQLForeignKeys SQLForeignKeysW
#define SQLGetConnectAttr SQLGetConnectAttrW
#define SQLGetConnectOption SQLGetConnectOptionW
#define SQLGetCursorName SQLGetCursorNameW
#define SQLGetDescField SQLGetDescFieldW
#define SQLGetDescRec SQLGetDescRecW
#define SQLGetDiagField SQLGetDiagFieldW
#define SQLGetDiagRec SQLGetDiagRecW
#define SQLGetInfo SQLGetInfoW
#define SQLGetStmtAttr SQLGetStmtAttrW
#define SQLGetTypeInfo SQLGetTypeInfoW
#define SQLNativeSql SQLNativeSqlW
#define SQLPrepare SQLPrepareW
#define SQLPrimaryKeys SQLPrimaryKeysW
#define SQLProcedureColumns SQLProcedureColumnsW
#define SQLProcedures SQLProceduresW
#define SQLSetConnectAttr SQLSetConnectAttrW
#define SQLSetConnectOption SQLSetConnectOptionW
#define SQLSetCursorName SQLSetCursorNameW
#define SQLSetDescField SQLSetDescFieldW
#define SQLSetStmtAttr SQLSetStmtAttrW
#define SQLSpecialColumns SQLSpecialColumnsW
#define SQLStatistics SQLStatisticsW
#define SQLTablePrivileges SQLTablePrivilegesW
#define SQLTables SQLTablesW
#endif ''UNICODE

#endif
