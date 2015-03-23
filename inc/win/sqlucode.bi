#pragma once

#include once "sqlext.bi"

extern "Windows"

#define __SQLUCODE
const SQL_WCHAR = -8
const SQL_WVARCHAR = -9
const SQL_WLONGVARCHAR = -10
#define SQL_C_WCHAR SQL_WCHAR

#ifdef UNICODE
	#define SQL_C_TCHAR SQL_C_WCHAR
#else
	#define SQL_C_TCHAR SQL_C_CHAR
#endif

const SQL_SQLSTATE_SIZEW = 10

#ifdef __FB_64BIT__
	declare function SQLColAttributeW(byval hstmt as SQLHSTMT, byval iCol as SQLUSMALLINT, byval iField as SQLUSMALLINT, byval pCharAttr as SQLPOINTER, byval cbCharAttrMax as SQLSMALLINT, byval pcbCharAttr as SQLSMALLINT ptr, byval pNumAttr as SQLLEN ptr) as SQLRETURN
	declare function SQLColAttributesW(byval hstmt as SQLHSTMT, byval icol as SQLUSMALLINT, byval fDescType as SQLUSMALLINT, byval rgbDesc as SQLPOINTER, byval cbDescMax as SQLSMALLINT, byval pcbDesc as SQLSMALLINT ptr, byval pfDesc as SQLLEN ptr) as SQLRETURN
#else
	declare function SQLColAttributeW(byval hstmt as SQLHSTMT, byval iCol as SQLUSMALLINT, byval iField as SQLUSMALLINT, byval pCharAttr as SQLPOINTER, byval cbCharAttrMax as SQLSMALLINT, byval pcbCharAttr as SQLSMALLINT ptr, byval pNumAttr as SQLPOINTER) as SQLRETURN
	declare function SQLColAttributesW(byval hstmt as SQLHSTMT, byval icol as SQLUSMALLINT, byval fDescType as SQLUSMALLINT, byval rgbDesc as SQLPOINTER, byval cbDescMax as SQLSMALLINT, byval pcbDesc as SQLSMALLINT ptr, byval pfDesc as SQLINTEGER ptr) as SQLRETURN
#endif

declare function SQLConnectW(byval hdbc as SQLHDBC, byval szDSN as wstring ptr, byval cbDSN as SQLSMALLINT, byval szUID as wstring ptr, byval cbUID as SQLSMALLINT, byval szAuthStr as wstring ptr, byval cbAuthStr as SQLSMALLINT) as SQLRETURN

#ifdef __FB_64BIT__
	declare function SQLDescribeColW(byval hstmt as SQLHSTMT, byval icol as SQLUSMALLINT, byval szColName as wstring ptr, byval cbColNameMax as SQLSMALLINT, byval pcbColName as SQLSMALLINT ptr, byval pfSqlType as SQLSMALLINT ptr, byval pcbColDef as SQLULEN ptr, byval pibScale as SQLSMALLINT ptr, byval pfNullable as SQLSMALLINT ptr) as SQLRETURN
#else
	declare function SQLDescribeColW(byval hstmt as SQLHSTMT, byval icol as SQLUSMALLINT, byval szColName as wstring ptr, byval cbColNameMax as SQLSMALLINT, byval pcbColName as SQLSMALLINT ptr, byval pfSqlType as SQLSMALLINT ptr, byval pcbColDef as SQLUINTEGER ptr, byval pibScale as SQLSMALLINT ptr, byval pfNullable as SQLSMALLINT ptr) as SQLRETURN
#endif

declare function SQLErrorW(byval henv as SQLHENV, byval hdbc as SQLHDBC, byval hstmt as SQLHSTMT, byval szSqlState as wstring ptr, byval pfNativeError as SQLINTEGER ptr, byval szErrorMsg as wstring ptr, byval cbErrorMsgMax as SQLSMALLINT, byval pcbErrorMsg as SQLSMALLINT ptr) as SQLRETURN
declare function SQLExecDirectW(byval hstmt as SQLHSTMT, byval szSqlStr as wstring ptr, byval cbSqlStr as SQLINTEGER) as SQLRETURN
declare function SQLGetConnectAttrW(byval hdbc as SQLHDBC, byval fAttribute as SQLINTEGER, byval rgbValue as SQLPOINTER, byval cbValueMax as SQLINTEGER, byval pcbValue as SQLINTEGER ptr) as SQLRETURN
declare function SQLGetCursorNameW(byval hstmt as SQLHSTMT, byval szCursor as wstring ptr, byval cbCursorMax as SQLSMALLINT, byval pcbCursor as SQLSMALLINT ptr) as SQLRETURN
declare function SQLSetDescFieldW(byval DescriptorHandle as SQLHDESC, byval RecNumber as SQLSMALLINT, byval FieldIdentifier as SQLSMALLINT, byval Value as SQLPOINTER, byval BufferLength as SQLINTEGER) as SQLRETURN
declare function SQLGetDescFieldW(byval hdesc as SQLHDESC, byval iRecord as SQLSMALLINT, byval iField as SQLSMALLINT, byval rgbValue as SQLPOINTER, byval cbValueMax as SQLINTEGER, byval pcbValue as SQLINTEGER ptr) as SQLRETURN

#ifdef __FB_64BIT__
	declare function SQLGetDescRecW(byval hdesc as SQLHDESC, byval iRecord as SQLSMALLINT, byval szName as wstring ptr, byval cbNameMax as SQLSMALLINT, byval pcbName as SQLSMALLINT ptr, byval pfType as SQLSMALLINT ptr, byval pfSubType as SQLSMALLINT ptr, byval pLength as SQLLEN ptr, byval pPrecision as SQLSMALLINT ptr, byval pScale as SQLSMALLINT ptr, byval pNullable as SQLSMALLINT ptr) as SQLRETURN
#else
	declare function SQLGetDescRecW(byval hdesc as SQLHDESC, byval iRecord as SQLSMALLINT, byval szName as wstring ptr, byval cbNameMax as SQLSMALLINT, byval pcbName as SQLSMALLINT ptr, byval pfType as SQLSMALLINT ptr, byval pfSubType as SQLSMALLINT ptr, byval pLength as SQLINTEGER ptr, byval pPrecision as SQLSMALLINT ptr, byval pScale as SQLSMALLINT ptr, byval pNullable as SQLSMALLINT ptr) as SQLRETURN
#endif

declare function SQLGetDiagFieldW(byval fHandleType as SQLSMALLINT, byval handle as SQLHANDLE, byval iRecord as SQLSMALLINT, byval fDiagField as SQLSMALLINT, byval rgbDiagInfo as SQLPOINTER, byval cbDiagInfoMax as SQLSMALLINT, byval pcbDiagInfo as SQLSMALLINT ptr) as SQLRETURN
declare function SQLGetDiagRecW(byval fHandleType as SQLSMALLINT, byval handle as SQLHANDLE, byval iRecord as SQLSMALLINT, byval szSqlState as wstring ptr, byval pfNativeError as SQLINTEGER ptr, byval szErrorMsg as wstring ptr, byval cbErrorMsgMax as SQLSMALLINT, byval pcbErrorMsg as SQLSMALLINT ptr) as SQLRETURN
declare function SQLPrepareW(byval hstmt as SQLHSTMT, byval szSqlStr as wstring ptr, byval cbSqlStr as SQLINTEGER) as SQLRETURN
declare function SQLSetConnectAttrW(byval hdbc as SQLHDBC, byval fAttribute as SQLINTEGER, byval rgbValue as SQLPOINTER, byval cbValue as SQLINTEGER) as SQLRETURN
declare function SQLSetCursorNameW(byval hstmt as SQLHSTMT, byval szCursor as wstring ptr, byval cbCursor as SQLSMALLINT) as SQLRETURN
declare function SQLColumnsW(byval hstmt as SQLHSTMT, byval szCatalogName as wstring ptr, byval cbCatalogName as SQLSMALLINT, byval szSchemaName as wstring ptr, byval cbSchemaName as SQLSMALLINT, byval szTableName as wstring ptr, byval cbTableName as SQLSMALLINT, byval szColumnName as wstring ptr, byval cbColumnName as SQLSMALLINT) as SQLRETURN
declare function SQLGetConnectOptionW(byval hdbc as SQLHDBC, byval fOption as SQLUSMALLINT, byval pvParam as SQLPOINTER) as SQLRETURN
declare function SQLGetInfoW(byval hdbc as SQLHDBC, byval fInfoType as SQLUSMALLINT, byval rgbInfoValue as SQLPOINTER, byval cbInfoValueMax as SQLSMALLINT, byval pcbInfoValue as SQLSMALLINT ptr) as SQLRETURN
declare function SQLGetTypeInfoW(byval StatementHandle as SQLHSTMT, byval DataType as SQLSMALLINT) as SQLRETURN

#ifdef __FB_64BIT__
	declare function SQLSetConnectOptionW(byval hdbc as SQLHDBC, byval fOption as SQLUSMALLINT, byval vParam as SQLULEN) as SQLRETURN
#else
	declare function SQLSetConnectOptionW(byval hdbc as SQLHDBC, byval fOption as SQLUSMALLINT, byval vParam as SQLUINTEGER) as SQLRETURN
#endif

declare function SQLSpecialColumnsW(byval hstmt as SQLHSTMT, byval fColType as SQLUSMALLINT, byval szCatalogName as wstring ptr, byval cbCatalogName as SQLSMALLINT, byval szSchemaName as wstring ptr, byval cbSchemaName as SQLSMALLINT, byval szTableName as wstring ptr, byval cbTableName as SQLSMALLINT, byval fScope as SQLUSMALLINT, byval fNullable as SQLUSMALLINT) as SQLRETURN
declare function SQLStatisticsW(byval hstmt as SQLHSTMT, byval szCatalogName as wstring ptr, byval cbCatalogName as SQLSMALLINT, byval szSchemaName as wstring ptr, byval cbSchemaName as SQLSMALLINT, byval szTableName as wstring ptr, byval cbTableName as SQLSMALLINT, byval fUnique as SQLUSMALLINT, byval fAccuracy as SQLUSMALLINT) as SQLRETURN
declare function SQLTablesW(byval hstmt as SQLHSTMT, byval szCatalogName as wstring ptr, byval cbCatalogName as SQLSMALLINT, byval szSchemaName as wstring ptr, byval cbSchemaName as SQLSMALLINT, byval szTableName as wstring ptr, byval cbTableName as SQLSMALLINT, byval szTableType as wstring ptr, byval cbTableType as SQLSMALLINT) as SQLRETURN
declare function SQLDataSourcesW(byval henv as SQLHENV, byval fDirection as SQLUSMALLINT, byval szDSN as wstring ptr, byval cbDSNMax as SQLSMALLINT, byval pcbDSN as SQLSMALLINT ptr, byval szDescription as wstring ptr, byval cbDescriptionMax as SQLSMALLINT, byval pcbDescription as SQLSMALLINT ptr) as SQLRETURN
declare function SQLDriverConnectW(byval hdbc as SQLHDBC, byval hwnd as SQLHWND, byval szConnStrIn as wstring ptr, byval cbConnStrIn as SQLSMALLINT, byval szConnStrOut as wstring ptr, byval cbConnStrOutMax as SQLSMALLINT, byval pcbConnStrOut as SQLSMALLINT ptr, byval fDriverCompletion as SQLUSMALLINT) as SQLRETURN
declare function SQLBrowseConnectW(byval hdbc as SQLHDBC, byval szConnStrIn as wstring ptr, byval cbConnStrIn as SQLSMALLINT, byval szConnStrOut as wstring ptr, byval cbConnStrOutMax as SQLSMALLINT, byval pcbConnStrOut as SQLSMALLINT ptr) as SQLRETURN
declare function SQLColumnPrivilegesW(byval hstmt as SQLHSTMT, byval szCatalogName as wstring ptr, byval cbCatalogName as SQLSMALLINT, byval szSchemaName as wstring ptr, byval cbSchemaName as SQLSMALLINT, byval szTableName as wstring ptr, byval cbTableName as SQLSMALLINT, byval szColumnName as wstring ptr, byval cbColumnName as SQLSMALLINT) as SQLRETURN
declare function SQLGetStmtAttrW(byval hstmt as SQLHSTMT, byval fAttribute as SQLINTEGER, byval rgbValue as SQLPOINTER, byval cbValueMax as SQLINTEGER, byval pcbValue as SQLINTEGER ptr) as SQLRETURN
declare function SQLSetStmtAttrW(byval hstmt as SQLHSTMT, byval fAttribute as SQLINTEGER, byval rgbValue as SQLPOINTER, byval cbValueMax as SQLINTEGER) as SQLRETURN
declare function SQLForeignKeysW(byval hstmt as SQLHSTMT, byval szPkCatalogName as wstring ptr, byval cbPkCatalogName as SQLSMALLINT, byval szPkSchemaName as wstring ptr, byval cbPkSchemaName as SQLSMALLINT, byval szPkTableName as wstring ptr, byval cbPkTableName as SQLSMALLINT, byval szFkCatalogName as wstring ptr, byval cbFkCatalogName as SQLSMALLINT, byval szFkSchemaName as wstring ptr, byval cbFkSchemaName as SQLSMALLINT, byval szFkTableName as wstring ptr, byval cbFkTableName as SQLSMALLINT) as SQLRETURN
declare function SQLNativeSqlW(byval hdbc as SQLHDBC, byval szSqlStrIn as wstring ptr, byval cbSqlStrIn as SQLINTEGER, byval szSqlStr as wstring ptr, byval cbSqlStrMax as SQLINTEGER, byval pcbSqlStr as SQLINTEGER ptr) as SQLRETURN
declare function SQLPrimaryKeysW(byval hstmt as SQLHSTMT, byval szCatalogName as wstring ptr, byval cbCatalogName as SQLSMALLINT, byval szSchemaName as wstring ptr, byval cbSchemaName as SQLSMALLINT, byval szTableName as wstring ptr, byval cbTableName as SQLSMALLINT) as SQLRETURN
declare function SQLProcedureColumnsW(byval hstmt as SQLHSTMT, byval szCatalogName as wstring ptr, byval cbCatalogName as SQLSMALLINT, byval szSchemaName as wstring ptr, byval cbSchemaName as SQLSMALLINT, byval szProcName as wstring ptr, byval cbProcName as SQLSMALLINT, byval szColumnName as wstring ptr, byval cbColumnName as SQLSMALLINT) as SQLRETURN
declare function SQLProceduresW(byval hstmt as SQLHSTMT, byval szCatalogName as wstring ptr, byval cbCatalogName as SQLSMALLINT, byval szSchemaName as wstring ptr, byval cbSchemaName as SQLSMALLINT, byval szProcName as wstring ptr, byval cbProcName as SQLSMALLINT) as SQLRETURN
declare function SQLTablePrivilegesW(byval hstmt as SQLHSTMT, byval szCatalogName as wstring ptr, byval cbCatalogName as SQLSMALLINT, byval szSchemaName as wstring ptr, byval cbSchemaName as SQLSMALLINT, byval szTableName as wstring ptr, byval cbTableName as SQLSMALLINT) as SQLRETURN
declare function SQLDriversW(byval henv as SQLHENV, byval fDirection as SQLUSMALLINT, byval szDriverDesc as wstring ptr, byval cbDriverDescMax as SQLSMALLINT, byval pcbDriverDesc as SQLSMALLINT ptr, byval szDriverAttributes as wstring ptr, byval cbDrvrAttrMax as SQLSMALLINT, byval pcbDrvrAttr as SQLSMALLINT ptr) as SQLRETURN

#ifdef __FB_64BIT__
	declare function SQLColAttributeA(byval hstmt as SQLHSTMT, byval iCol as SQLSMALLINT, byval iField as SQLSMALLINT, byval pCharAttr as SQLPOINTER, byval cbCharAttrMax as SQLSMALLINT, byval pcbCharAttr as SQLSMALLINT ptr, byval pNumAttr as SQLLEN ptr) as SQLRETURN
	declare function SQLColAttributesA(byval hstmt as SQLHSTMT, byval icol as SQLUSMALLINT, byval fDescType as SQLUSMALLINT, byval rgbDesc as SQLPOINTER, byval cbDescMax as SQLSMALLINT, byval pcbDesc as SQLSMALLINT ptr, byval pfDesc as SQLLEN ptr) as SQLRETURN
#else
	declare function SQLColAttributeA(byval hstmt as SQLHSTMT, byval iCol as SQLSMALLINT, byval iField as SQLSMALLINT, byval pCharAttr as SQLPOINTER, byval cbCharAttrMax as SQLSMALLINT, byval pcbCharAttr as SQLSMALLINT ptr, byval pNumAttr as SQLPOINTER) as SQLRETURN
	declare function SQLColAttributesA(byval hstmt as SQLHSTMT, byval icol as SQLUSMALLINT, byval fDescType as SQLUSMALLINT, byval rgbDesc as SQLPOINTER, byval cbDescMax as SQLSMALLINT, byval pcbDesc as SQLSMALLINT ptr, byval pfDesc as SQLINTEGER ptr) as SQLRETURN
#endif

declare function SQLConnectA(byval hdbc as SQLHDBC, byval szDSN as SQLCHAR ptr, byval cbDSN as SQLSMALLINT, byval szUID as SQLCHAR ptr, byval cbUID as SQLSMALLINT, byval szAuthStr as SQLCHAR ptr, byval cbAuthStr as SQLSMALLINT) as SQLRETURN
declare function SQLDescribeColA(byval hstmt as SQLHSTMT, byval icol as SQLUSMALLINT, byval szColName as SQLCHAR ptr, byval cbColNameMax as SQLSMALLINT, byval pcbColName as SQLSMALLINT ptr, byval pfSqlType as SQLSMALLINT ptr, byval pcbColDef as SQLUINTEGER ptr, byval pibScale as SQLSMALLINT ptr, byval pfNullable as SQLSMALLINT ptr) as SQLRETURN
declare function SQLErrorA(byval henv as SQLHENV, byval hdbc as SQLHDBC, byval hstmt as SQLHSTMT, byval szSqlState as SQLCHAR ptr, byval pfNativeError as SQLINTEGER ptr, byval szErrorMsg as SQLCHAR ptr, byval cbErrorMsgMax as SQLSMALLINT, byval pcbErrorMsg as SQLSMALLINT ptr) as SQLRETURN
declare function SQLExecDirectA(byval hstmt as SQLHSTMT, byval szSqlStr as SQLCHAR ptr, byval cbSqlStr as SQLINTEGER) as SQLRETURN
declare function SQLGetConnectAttrA(byval hdbc as SQLHDBC, byval fAttribute as SQLINTEGER, byval rgbValue as SQLPOINTER, byval cbValueMax as SQLINTEGER, byval pcbValue as SQLINTEGER ptr) as SQLRETURN
declare function SQLGetCursorNameA(byval hstmt as SQLHSTMT, byval szCursor as SQLCHAR ptr, byval cbCursorMax as SQLSMALLINT, byval pcbCursor as SQLSMALLINT ptr) as SQLRETURN
declare function SQLGetDescFieldA(byval hdesc as SQLHDESC, byval iRecord as SQLSMALLINT, byval iField as SQLSMALLINT, byval rgbValue as SQLPOINTER, byval cbValueMax as SQLINTEGER, byval pcbValue as SQLINTEGER ptr) as SQLRETURN
declare function SQLGetDescRecA(byval hdesc as SQLHDESC, byval iRecord as SQLSMALLINT, byval szName as SQLCHAR ptr, byval cbNameMax as SQLSMALLINT, byval pcbName as SQLSMALLINT ptr, byval pfType as SQLSMALLINT ptr, byval pfSubType as SQLSMALLINT ptr, byval pLength as SQLINTEGER ptr, byval pPrecision as SQLSMALLINT ptr, byval pScale as SQLSMALLINT ptr, byval pNullable as SQLSMALLINT ptr) as SQLRETURN
declare function SQLGetDiagFieldA(byval fHandleType as SQLSMALLINT, byval handle as SQLHANDLE, byval iRecord as SQLSMALLINT, byval fDiagField as SQLSMALLINT, byval rgbDiagInfo as SQLPOINTER, byval cbDiagInfoMax as SQLSMALLINT, byval pcbDiagInfo as SQLSMALLINT ptr) as SQLRETURN
declare function SQLGetDiagRecA(byval fHandleType as SQLSMALLINT, byval handle as SQLHANDLE, byval iRecord as SQLSMALLINT, byval szSqlState as SQLCHAR ptr, byval pfNativeError as SQLINTEGER ptr, byval szErrorMsg as SQLCHAR ptr, byval cbErrorMsgMax as SQLSMALLINT, byval pcbErrorMsg as SQLSMALLINT ptr) as SQLRETURN
declare function SQLGetStmtAttrA(byval hstmt as SQLHSTMT, byval fAttribute as SQLINTEGER, byval rgbValue as SQLPOINTER, byval cbValueMax as SQLINTEGER, byval pcbValue as SQLINTEGER ptr) as SQLRETURN
declare function SQLGetTypeInfoA(byval StatementHandle as SQLHSTMT, byval DataTyoe as SQLSMALLINT) as SQLRETURN
declare function SQLPrepareA(byval hstmt as SQLHSTMT, byval szSqlStr as SQLCHAR ptr, byval cbSqlStr as SQLINTEGER) as SQLRETURN
declare function SQLSetConnectAttrA(byval hdbc as SQLHDBC, byval fAttribute as SQLINTEGER, byval rgbValue as SQLPOINTER, byval cbValue as SQLINTEGER) as SQLRETURN
declare function SQLSetCursorNameA(byval hstmt as SQLHSTMT, byval szCursor as SQLCHAR ptr, byval cbCursor as SQLSMALLINT) as SQLRETURN
declare function SQLColumnsA(byval hstmt as SQLHSTMT, byval szCatalogName as SQLCHAR ptr, byval cbCatalogName as SQLSMALLINT, byval szSchemaName as SQLCHAR ptr, byval cbSchemaName as SQLSMALLINT, byval szTableName as SQLCHAR ptr, byval cbTableName as SQLSMALLINT, byval szColumnName as SQLCHAR ptr, byval cbColumnName as SQLSMALLINT) as SQLRETURN
declare function SQLGetConnectOptionA(byval hdbc as SQLHDBC, byval fOption as SQLUSMALLINT, byval pvParam as SQLPOINTER) as SQLRETURN
declare function SQLGetInfoA(byval hdbc as SQLHDBC, byval fInfoType as SQLUSMALLINT, byval rgbInfoValue as SQLPOINTER, byval cbInfoValueMax as SQLSMALLINT, byval pcbInfoValue as SQLSMALLINT ptr) as SQLRETURN
declare function SQLGetStmtOptionA(byval hstmt as SQLHSTMT, byval fOption as SQLUSMALLINT, byval pvParam as SQLPOINTER) as SQLRETURN

#ifdef __FB_64BIT__
	declare function SQLSetConnectOptionA(byval hdbc as SQLHDBC, byval fOption as SQLUSMALLINT, byval vParam as SQLULEN) as SQLRETURN
	declare function SQLSetStmtOptionA(byval hstmt as SQLHSTMT, byval fOption as SQLUSMALLINT, byval vParam as SQLULEN) as SQLRETURN
#else
	declare function SQLSetConnectOptionA(byval hdbc as SQLHDBC, byval fOption as SQLUSMALLINT, byval vParam as SQLUINTEGER) as SQLRETURN
	declare function SQLSetStmtOptionA(byval hstmt as SQLHSTMT, byval fOption as SQLUSMALLINT, byval vParam as SQLUINTEGER) as SQLRETURN
#endif

declare function SQLSpecialColumnsA(byval hstmt as SQLHSTMT, byval fColType as SQLUSMALLINT, byval szCatalogName as SQLCHAR ptr, byval cbCatalogName as SQLSMALLINT, byval szSchemaName as SQLCHAR ptr, byval cbSchemaName as SQLSMALLINT, byval szTableName as SQLCHAR ptr, byval cbTableName as SQLSMALLINT, byval fScope as SQLUSMALLINT, byval fNullable as SQLUSMALLINT) as SQLRETURN
declare function SQLStatisticsA(byval hstmt as SQLHSTMT, byval szCatalogName as SQLCHAR ptr, byval cbCatalogName as SQLSMALLINT, byval szSchemaName as SQLCHAR ptr, byval cbSchemaName as SQLSMALLINT, byval szTableName as SQLCHAR ptr, byval cbTableName as SQLSMALLINT, byval fUnique as SQLUSMALLINT, byval fAccuracy as SQLUSMALLINT) as SQLRETURN
declare function SQLTablesA(byval hstmt as SQLHSTMT, byval szCatalogName as SQLCHAR ptr, byval cbCatalogName as SQLSMALLINT, byval szSchemaName as SQLCHAR ptr, byval cbSchemaName as SQLSMALLINT, byval szTableName as SQLCHAR ptr, byval cbTableName as SQLSMALLINT, byval szTableType as SQLCHAR ptr, byval cbTableType as SQLSMALLINT) as SQLRETURN
declare function SQLDataSourcesA(byval henv as SQLHENV, byval fDirection as SQLUSMALLINT, byval szDSN as SQLCHAR ptr, byval cbDSNMax as SQLSMALLINT, byval pcbDSN as SQLSMALLINT ptr, byval szDescription as SQLCHAR ptr, byval cbDescriptionMax as SQLSMALLINT, byval pcbDescription as SQLSMALLINT ptr) as SQLRETURN
declare function SQLDriverConnectA(byval hdbc as SQLHDBC, byval hwnd as SQLHWND, byval szConnStrIn as SQLCHAR ptr, byval cbConnStrIn as SQLSMALLINT, byval szConnStrOut as SQLCHAR ptr, byval cbConnStrOutMax as SQLSMALLINT, byval pcbConnStrOut as SQLSMALLINT ptr, byval fDriverCompletion as SQLUSMALLINT) as SQLRETURN
declare function SQLBrowseConnectA(byval hdbc as SQLHDBC, byval szConnStrIn as SQLCHAR ptr, byval cbConnStrIn as SQLSMALLINT, byval szConnStrOut as SQLCHAR ptr, byval cbConnStrOutMax as SQLSMALLINT, byval pcbConnStrOut as SQLSMALLINT ptr) as SQLRETURN
declare function SQLColumnPrivilegesA(byval hstmt as SQLHSTMT, byval szCatalogName as SQLCHAR ptr, byval cbCatalogName as SQLSMALLINT, byval szSchemaName as SQLCHAR ptr, byval cbSchemaName as SQLSMALLINT, byval szTableName as SQLCHAR ptr, byval cbTableName as SQLSMALLINT, byval szColumnName as SQLCHAR ptr, byval cbColumnName as SQLSMALLINT) as SQLRETURN
declare function SQLDescribeParamA(byval hstmt as SQLHSTMT, byval ipar as SQLUSMALLINT, byval pfSqlType as SQLSMALLINT ptr, byval pcbParamDef as SQLUINTEGER ptr, byval pibScale as SQLSMALLINT ptr, byval pfNullable as SQLSMALLINT ptr) as SQLRETURN
declare function SQLForeignKeysA(byval hstmt as SQLHSTMT, byval szPkCatalogName as SQLCHAR ptr, byval cbPkCatalogName as SQLSMALLINT, byval szPkSchemaName as SQLCHAR ptr, byval cbPkSchemaName as SQLSMALLINT, byval szPkTableName as SQLCHAR ptr, byval cbPkTableName as SQLSMALLINT, byval szFkCatalogName as SQLCHAR ptr, byval cbFkCatalogName as SQLSMALLINT, byval szFkSchemaName as SQLCHAR ptr, byval cbFkSchemaName as SQLSMALLINT, byval szFkTableName as SQLCHAR ptr, byval cbFkTableName as SQLSMALLINT) as SQLRETURN
declare function SQLNativeSqlA(byval hdbc as SQLHDBC, byval szSqlStrIn as SQLCHAR ptr, byval cbSqlStrIn as SQLINTEGER, byval szSqlStr as SQLCHAR ptr, byval cbSqlStrMax as SQLINTEGER, byval pcbSqlStr as SQLINTEGER ptr) as SQLRETURN
declare function SQLPrimaryKeysA(byval hstmt as SQLHSTMT, byval szCatalogName as SQLCHAR ptr, byval cbCatalogName as SQLSMALLINT, byval szSchemaName as SQLCHAR ptr, byval cbSchemaName as SQLSMALLINT, byval szTableName as SQLCHAR ptr, byval cbTableName as SQLSMALLINT) as SQLRETURN
declare function SQLProcedureColumnsA(byval hstmt as SQLHSTMT, byval szCatalogName as SQLCHAR ptr, byval cbCatalogName as SQLSMALLINT, byval szSchemaName as SQLCHAR ptr, byval cbSchemaName as SQLSMALLINT, byval szProcName as SQLCHAR ptr, byval cbProcName as SQLSMALLINT, byval szColumnName as SQLCHAR ptr, byval cbColumnName as SQLSMALLINT) as SQLRETURN
declare function SQLProceduresA(byval hstmt as SQLHSTMT, byval szCatalogName as SQLCHAR ptr, byval cbCatalogName as SQLSMALLINT, byval szSchemaName as SQLCHAR ptr, byval cbSchemaName as SQLSMALLINT, byval szProcName as SQLCHAR ptr, byval cbProcName as SQLSMALLINT) as SQLRETURN
declare function SQLTablePrivilegesA(byval hstmt as SQLHSTMT, byval szCatalogName as SQLCHAR ptr, byval cbCatalogName as SQLSMALLINT, byval szSchemaName as SQLCHAR ptr, byval cbSchemaName as SQLSMALLINT, byval szTableName as SQLCHAR ptr, byval cbTableName as SQLSMALLINT) as SQLRETURN
declare function SQLDriversA(byval henv as SQLHENV, byval fDirection as SQLUSMALLINT, byval szDriverDesc as SQLCHAR ptr, byval cbDriverDescMax as SQLSMALLINT, byval pcbDriverDesc as SQLSMALLINT ptr, byval szDriverAttributes as SQLCHAR ptr, byval cbDrvrAttrMax as SQLSMALLINT, byval pcbDrvrAttr as SQLSMALLINT ptr) as SQLRETURN

#ifdef UNICODE
	#define SQLColAttribute SQLColAttributeW
	#define SQLColAttributes SQLColAttributesW
	#define SQLConnect SQLConnectW
	#define SQLDescribeCol SQLDescribeColW
	#define SQLError SQLErrorW
	#define SQLExecDirect SQLExecDirectW
	#define SQLGetConnectAttr SQLGetConnectAttrW
	#define SQLGetCursorName SQLGetCursorNameW
	#define SQLGetDescField SQLGetDescFieldW
	#define SQLGetDescRec SQLGetDescRecW
	#define SQLGetDiagField SQLGetDiagFieldW
	#define SQLGetDiagRec SQLGetDiagRecW
	#define SQLPrepare SQLPrepareW
	#define SQLSetConnectAttr SQLSetConnectAttrW
	#define SQLSetCursorName SQLSetCursorNameW
	#define SQLSetDescField SQLSetDescFieldW
	#define SQLSetStmtAttr SQLSetStmtAttrW
	#define SQLGetStmtAttr SQLGetStmtAttrW
	#define SQLColumns SQLColumnsW
	#define SQLGetConnectOption SQLGetConnectOptionW
	#define SQLGetInfo SQLGetInfoW
	#define SQLGetTypeInfo SQLGetTypeInfoW
	#define SQLSetConnectOption SQLSetConnectOptionW
	#define SQLSpecialColumns SQLSpecialColumnsW
	#define SQLStatistics SQLStatisticsW
	#define SQLTables SQLTablesW
	#define SQLDataSources SQLDataSourcesW
	#define SQLDriverConnect SQLDriverConnectW
	#define SQLBrowseConnect SQLBrowseConnectW
	#define SQLColumnPrivileges SQLColumnPrivilegesW
	#define SQLForeignKeys SQLForeignKeysW
	#define SQLNativeSql SQLNativeSqlW
	#define SQLPrimaryKeys SQLPrimaryKeysW
	#define SQLProcedureColumns SQLProcedureColumnsW
	#define SQLProcedures SQLProceduresW
	#define SQLTablePrivileges SQLTablePrivilegesW
	#define SQLDrivers SQLDriversW
#endif

end extern
