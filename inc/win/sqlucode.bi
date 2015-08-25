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

#include once "sqlext.bi"

extern "Windows"

#define __SQLUCODE
const SQL_WCHAR = -8
const SQL_UNICODE = SQL_WCHAR
const SQL_UNICODE_CHAR = SQL_WCHAR
const SQL_WVARCHAR = -9
const SQL_UNICODE_VARCHAR = SQL_WVARCHAR
const SQL_WLONGVARCHAR = -10
const SQL_UNICODE_LONGVARCHAR = SQL_WLONGVARCHAR
const SQL_C_WCHAR = SQL_WCHAR

#ifdef UNICODE
	const SQL_C_TCHAR = SQL_C_WCHAR
#else
	const SQL_C_TCHAR = SQL_C_CHAR
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

declare function SQLConnectA(byval hdbc as SQLHDBC, byval szDSN as zstring ptr, byval cbDSN as SQLSMALLINT, byval szUID as zstring ptr, byval cbUID as SQLSMALLINT, byval szAuthStr as zstring ptr, byval cbAuthStr as SQLSMALLINT) as SQLRETURN
declare function SQLDescribeColA(byval hstmt as SQLHSTMT, byval icol as SQLUSMALLINT, byval szColName as zstring ptr, byval cbColNameMax as SQLSMALLINT, byval pcbColName as SQLSMALLINT ptr, byval pfSqlType as SQLSMALLINT ptr, byval pcbColDef as SQLUINTEGER ptr, byval pibScale as SQLSMALLINT ptr, byval pfNullable as SQLSMALLINT ptr) as SQLRETURN
declare function SQLErrorA(byval henv as SQLHENV, byval hdbc as SQLHDBC, byval hstmt as SQLHSTMT, byval szSqlState as zstring ptr, byval pfNativeError as SQLINTEGER ptr, byval szErrorMsg as zstring ptr, byval cbErrorMsgMax as SQLSMALLINT, byval pcbErrorMsg as SQLSMALLINT ptr) as SQLRETURN
declare function SQLExecDirectA(byval hstmt as SQLHSTMT, byval szSqlStr as zstring ptr, byval cbSqlStr as SQLINTEGER) as SQLRETURN
declare function SQLGetConnectAttrA(byval hdbc as SQLHDBC, byval fAttribute as SQLINTEGER, byval rgbValue as SQLPOINTER, byval cbValueMax as SQLINTEGER, byval pcbValue as SQLINTEGER ptr) as SQLRETURN
declare function SQLGetCursorNameA(byval hstmt as SQLHSTMT, byval szCursor as zstring ptr, byval cbCursorMax as SQLSMALLINT, byval pcbCursor as SQLSMALLINT ptr) as SQLRETURN
declare function SQLGetDescFieldA(byval hdesc as SQLHDESC, byval iRecord as SQLSMALLINT, byval iField as SQLSMALLINT, byval rgbValue as SQLPOINTER, byval cbValueMax as SQLINTEGER, byval pcbValue as SQLINTEGER ptr) as SQLRETURN
declare function SQLGetDescRecA(byval hdesc as SQLHDESC, byval iRecord as SQLSMALLINT, byval szName as zstring ptr, byval cbNameMax as SQLSMALLINT, byval pcbName as SQLSMALLINT ptr, byval pfType as SQLSMALLINT ptr, byval pfSubType as SQLSMALLINT ptr, byval pLength as SQLINTEGER ptr, byval pPrecision as SQLSMALLINT ptr, byval pScale as SQLSMALLINT ptr, byval pNullable as SQLSMALLINT ptr) as SQLRETURN
declare function SQLGetDiagFieldA(byval fHandleType as SQLSMALLINT, byval handle as SQLHANDLE, byval iRecord as SQLSMALLINT, byval fDiagField as SQLSMALLINT, byval rgbDiagInfo as SQLPOINTER, byval cbDiagInfoMax as SQLSMALLINT, byval pcbDiagInfo as SQLSMALLINT ptr) as SQLRETURN
declare function SQLGetDiagRecA(byval fHandleType as SQLSMALLINT, byval handle as SQLHANDLE, byval iRecord as SQLSMALLINT, byval szSqlState as zstring ptr, byval pfNativeError as SQLINTEGER ptr, byval szErrorMsg as zstring ptr, byval cbErrorMsgMax as SQLSMALLINT, byval pcbErrorMsg as SQLSMALLINT ptr) as SQLRETURN
declare function SQLGetStmtAttrA(byval hstmt as SQLHSTMT, byval fAttribute as SQLINTEGER, byval rgbValue as SQLPOINTER, byval cbValueMax as SQLINTEGER, byval pcbValue as SQLINTEGER ptr) as SQLRETURN
declare function SQLGetTypeInfoA(byval StatementHandle as SQLHSTMT, byval DataTyoe as SQLSMALLINT) as SQLRETURN
declare function SQLPrepareA(byval hstmt as SQLHSTMT, byval szSqlStr as zstring ptr, byval cbSqlStr as SQLINTEGER) as SQLRETURN
declare function SQLSetConnectAttrA(byval hdbc as SQLHDBC, byval fAttribute as SQLINTEGER, byval rgbValue as SQLPOINTER, byval cbValue as SQLINTEGER) as SQLRETURN
declare function SQLSetCursorNameA(byval hstmt as SQLHSTMT, byval szCursor as zstring ptr, byval cbCursor as SQLSMALLINT) as SQLRETURN
declare function SQLColumnsA(byval hstmt as SQLHSTMT, byval szCatalogName as zstring ptr, byval cbCatalogName as SQLSMALLINT, byval szSchemaName as zstring ptr, byval cbSchemaName as SQLSMALLINT, byval szTableName as zstring ptr, byval cbTableName as SQLSMALLINT, byval szColumnName as zstring ptr, byval cbColumnName as SQLSMALLINT) as SQLRETURN
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

declare function SQLSpecialColumnsA(byval hstmt as SQLHSTMT, byval fColType as SQLUSMALLINT, byval szCatalogName as zstring ptr, byval cbCatalogName as SQLSMALLINT, byval szSchemaName as zstring ptr, byval cbSchemaName as SQLSMALLINT, byval szTableName as zstring ptr, byval cbTableName as SQLSMALLINT, byval fScope as SQLUSMALLINT, byval fNullable as SQLUSMALLINT) as SQLRETURN
declare function SQLStatisticsA(byval hstmt as SQLHSTMT, byval szCatalogName as zstring ptr, byval cbCatalogName as SQLSMALLINT, byval szSchemaName as zstring ptr, byval cbSchemaName as SQLSMALLINT, byval szTableName as zstring ptr, byval cbTableName as SQLSMALLINT, byval fUnique as SQLUSMALLINT, byval fAccuracy as SQLUSMALLINT) as SQLRETURN
declare function SQLTablesA(byval hstmt as SQLHSTMT, byval szCatalogName as zstring ptr, byval cbCatalogName as SQLSMALLINT, byval szSchemaName as zstring ptr, byval cbSchemaName as SQLSMALLINT, byval szTableName as zstring ptr, byval cbTableName as SQLSMALLINT, byval szTableType as zstring ptr, byval cbTableType as SQLSMALLINT) as SQLRETURN
declare function SQLDataSourcesA(byval henv as SQLHENV, byval fDirection as SQLUSMALLINT, byval szDSN as zstring ptr, byval cbDSNMax as SQLSMALLINT, byval pcbDSN as SQLSMALLINT ptr, byval szDescription as zstring ptr, byval cbDescriptionMax as SQLSMALLINT, byval pcbDescription as SQLSMALLINT ptr) as SQLRETURN
declare function SQLDriverConnectA(byval hdbc as SQLHDBC, byval hwnd as SQLHWND, byval szConnStrIn as zstring ptr, byval cbConnStrIn as SQLSMALLINT, byval szConnStrOut as zstring ptr, byval cbConnStrOutMax as SQLSMALLINT, byval pcbConnStrOut as SQLSMALLINT ptr, byval fDriverCompletion as SQLUSMALLINT) as SQLRETURN
declare function SQLBrowseConnectA(byval hdbc as SQLHDBC, byval szConnStrIn as zstring ptr, byval cbConnStrIn as SQLSMALLINT, byval szConnStrOut as zstring ptr, byval cbConnStrOutMax as SQLSMALLINT, byval pcbConnStrOut as SQLSMALLINT ptr) as SQLRETURN
declare function SQLColumnPrivilegesA(byval hstmt as SQLHSTMT, byval szCatalogName as zstring ptr, byval cbCatalogName as SQLSMALLINT, byval szSchemaName as zstring ptr, byval cbSchemaName as SQLSMALLINT, byval szTableName as zstring ptr, byval cbTableName as SQLSMALLINT, byval szColumnName as zstring ptr, byval cbColumnName as SQLSMALLINT) as SQLRETURN
declare function SQLDescribeParamA(byval hstmt as SQLHSTMT, byval ipar as SQLUSMALLINT, byval pfSqlType as SQLSMALLINT ptr, byval pcbParamDef as SQLUINTEGER ptr, byval pibScale as SQLSMALLINT ptr, byval pfNullable as SQLSMALLINT ptr) as SQLRETURN
declare function SQLForeignKeysA(byval hstmt as SQLHSTMT, byval szPkCatalogName as zstring ptr, byval cbPkCatalogName as SQLSMALLINT, byval szPkSchemaName as zstring ptr, byval cbPkSchemaName as SQLSMALLINT, byval szPkTableName as zstring ptr, byval cbPkTableName as SQLSMALLINT, byval szFkCatalogName as zstring ptr, byval cbFkCatalogName as SQLSMALLINT, byval szFkSchemaName as zstring ptr, byval cbFkSchemaName as SQLSMALLINT, byval szFkTableName as zstring ptr, byval cbFkTableName as SQLSMALLINT) as SQLRETURN
declare function SQLNativeSqlA(byval hdbc as SQLHDBC, byval szSqlStrIn as zstring ptr, byval cbSqlStrIn as SQLINTEGER, byval szSqlStr as zstring ptr, byval cbSqlStrMax as SQLINTEGER, byval pcbSqlStr as SQLINTEGER ptr) as SQLRETURN
declare function SQLPrimaryKeysA(byval hstmt as SQLHSTMT, byval szCatalogName as zstring ptr, byval cbCatalogName as SQLSMALLINT, byval szSchemaName as zstring ptr, byval cbSchemaName as SQLSMALLINT, byval szTableName as zstring ptr, byval cbTableName as SQLSMALLINT) as SQLRETURN
declare function SQLProcedureColumnsA(byval hstmt as SQLHSTMT, byval szCatalogName as zstring ptr, byval cbCatalogName as SQLSMALLINT, byval szSchemaName as zstring ptr, byval cbSchemaName as SQLSMALLINT, byval szProcName as zstring ptr, byval cbProcName as SQLSMALLINT, byval szColumnName as zstring ptr, byval cbColumnName as SQLSMALLINT) as SQLRETURN
declare function SQLProceduresA(byval hstmt as SQLHSTMT, byval szCatalogName as zstring ptr, byval cbCatalogName as SQLSMALLINT, byval szSchemaName as zstring ptr, byval cbSchemaName as SQLSMALLINT, byval szProcName as zstring ptr, byval cbProcName as SQLSMALLINT) as SQLRETURN
declare function SQLTablePrivilegesA(byval hstmt as SQLHSTMT, byval szCatalogName as zstring ptr, byval cbCatalogName as SQLSMALLINT, byval szSchemaName as zstring ptr, byval cbSchemaName as SQLSMALLINT, byval szTableName as zstring ptr, byval cbTableName as SQLSMALLINT) as SQLRETURN
declare function SQLDriversA(byval henv as SQLHENV, byval fDirection as SQLUSMALLINT, byval szDriverDesc as zstring ptr, byval cbDriverDescMax as SQLSMALLINT, byval pcbDriverDesc as SQLSMALLINT ptr, byval szDriverAttributes as zstring ptr, byval cbDrvrAttrMax as SQLSMALLINT, byval pcbDrvrAttr as SQLSMALLINT ptr) as SQLRETURN

#if (not defined(__FB_64BIT__)) and defined(UNICODE)
	declare function SQLColAttribute alias "SQLColAttributeW"(byval hstmt as SQLHSTMT, byval iCol as SQLUSMALLINT, byval iField as SQLUSMALLINT, byval pCharAttr as SQLPOINTER, byval cbCharAttrMax as SQLSMALLINT, byval pcbCharAttr as SQLSMALLINT ptr, byval pNumAttr as SQLPOINTER) as SQLRETURN
	declare function SQLColAttributes alias "SQLColAttributesW"(byval hstmt as SQLHSTMT, byval icol as SQLUSMALLINT, byval fDescType as SQLUSMALLINT, byval rgbDesc as SQLPOINTER, byval cbDescMax as SQLSMALLINT, byval pcbDesc as SQLSMALLINT ptr, byval pfDesc as SQLINTEGER ptr) as SQLRETURN
#elseif defined(__FB_64BIT__) and defined(UNICODE)
	declare function SQLColAttribute alias "SQLColAttributeW"(byval hstmt as SQLHSTMT, byval iCol as SQLUSMALLINT, byval iField as SQLUSMALLINT, byval pCharAttr as SQLPOINTER, byval cbCharAttrMax as SQLSMALLINT, byval pcbCharAttr as SQLSMALLINT ptr, byval pNumAttr as SQLLEN ptr) as SQLRETURN
	declare function SQLColAttributes alias "SQLColAttributesW"(byval hstmt as SQLHSTMT, byval icol as SQLUSMALLINT, byval fDescType as SQLUSMALLINT, byval rgbDesc as SQLPOINTER, byval cbDescMax as SQLSMALLINT, byval pcbDesc as SQLSMALLINT ptr, byval pfDesc as SQLLEN ptr) as SQLRETURN
#endif

#ifdef UNICODE
	declare function SQLConnect alias "SQLConnectW"(byval hdbc as SQLHDBC, byval szDSN as wstring ptr, byval cbDSN as SQLSMALLINT, byval szUID as wstring ptr, byval cbUID as SQLSMALLINT, byval szAuthStr as wstring ptr, byval cbAuthStr as SQLSMALLINT) as SQLRETURN
#endif

#if (not defined(__FB_64BIT__)) and defined(UNICODE)
	declare function SQLDescribeCol alias "SQLDescribeColW"(byval hstmt as SQLHSTMT, byval icol as SQLUSMALLINT, byval szColName as wstring ptr, byval cbColNameMax as SQLSMALLINT, byval pcbColName as SQLSMALLINT ptr, byval pfSqlType as SQLSMALLINT ptr, byval pcbColDef as SQLUINTEGER ptr, byval pibScale as SQLSMALLINT ptr, byval pfNullable as SQLSMALLINT ptr) as SQLRETURN
#elseif defined(__FB_64BIT__) and defined(UNICODE)
	declare function SQLDescribeCol alias "SQLDescribeColW"(byval hstmt as SQLHSTMT, byval icol as SQLUSMALLINT, byval szColName as wstring ptr, byval cbColNameMax as SQLSMALLINT, byval pcbColName as SQLSMALLINT ptr, byval pfSqlType as SQLSMALLINT ptr, byval pcbColDef as SQLULEN ptr, byval pibScale as SQLSMALLINT ptr, byval pfNullable as SQLSMALLINT ptr) as SQLRETURN
#endif

#ifdef UNICODE
	declare function SQLError alias "SQLErrorW"(byval henv as SQLHENV, byval hdbc as SQLHDBC, byval hstmt as SQLHSTMT, byval szSqlState as wstring ptr, byval pfNativeError as SQLINTEGER ptr, byval szErrorMsg as wstring ptr, byval cbErrorMsgMax as SQLSMALLINT, byval pcbErrorMsg as SQLSMALLINT ptr) as SQLRETURN
	declare function SQLExecDirect alias "SQLExecDirectW"(byval hstmt as SQLHSTMT, byval szSqlStr as wstring ptr, byval cbSqlStr as SQLINTEGER) as SQLRETURN
	declare function SQLGetConnectAttr alias "SQLGetConnectAttrW"(byval hdbc as SQLHDBC, byval fAttribute as SQLINTEGER, byval rgbValue as SQLPOINTER, byval cbValueMax as SQLINTEGER, byval pcbValue as SQLINTEGER ptr) as SQLRETURN
	declare function SQLGetCursorName alias "SQLGetCursorNameW"(byval hstmt as SQLHSTMT, byval szCursor as wstring ptr, byval cbCursorMax as SQLSMALLINT, byval pcbCursor as SQLSMALLINT ptr) as SQLRETURN
	declare function SQLGetDescField alias "SQLGetDescFieldW"(byval hdesc as SQLHDESC, byval iRecord as SQLSMALLINT, byval iField as SQLSMALLINT, byval rgbValue as SQLPOINTER, byval cbValueMax as SQLINTEGER, byval pcbValue as SQLINTEGER ptr) as SQLRETURN
#endif

#if (not defined(__FB_64BIT__)) and defined(UNICODE)
	declare function SQLGetDescRec alias "SQLGetDescRecW"(byval hdesc as SQLHDESC, byval iRecord as SQLSMALLINT, byval szName as wstring ptr, byval cbNameMax as SQLSMALLINT, byval pcbName as SQLSMALLINT ptr, byval pfType as SQLSMALLINT ptr, byval pfSubType as SQLSMALLINT ptr, byval pLength as SQLINTEGER ptr, byval pPrecision as SQLSMALLINT ptr, byval pScale as SQLSMALLINT ptr, byval pNullable as SQLSMALLINT ptr) as SQLRETURN
#elseif defined(__FB_64BIT__) and defined(UNICODE)
	declare function SQLGetDescRec alias "SQLGetDescRecW"(byval hdesc as SQLHDESC, byval iRecord as SQLSMALLINT, byval szName as wstring ptr, byval cbNameMax as SQLSMALLINT, byval pcbName as SQLSMALLINT ptr, byval pfType as SQLSMALLINT ptr, byval pfSubType as SQLSMALLINT ptr, byval pLength as SQLLEN ptr, byval pPrecision as SQLSMALLINT ptr, byval pScale as SQLSMALLINT ptr, byval pNullable as SQLSMALLINT ptr) as SQLRETURN
#endif

#ifdef UNICODE
	declare function SQLGetDiagField alias "SQLGetDiagFieldW"(byval fHandleType as SQLSMALLINT, byval handle as SQLHANDLE, byval iRecord as SQLSMALLINT, byval fDiagField as SQLSMALLINT, byval rgbDiagInfo as SQLPOINTER, byval cbDiagInfoMax as SQLSMALLINT, byval pcbDiagInfo as SQLSMALLINT ptr) as SQLRETURN
	declare function SQLGetDiagRec alias "SQLGetDiagRecW"(byval fHandleType as SQLSMALLINT, byval handle as SQLHANDLE, byval iRecord as SQLSMALLINT, byval szSqlState as wstring ptr, byval pfNativeError as SQLINTEGER ptr, byval szErrorMsg as wstring ptr, byval cbErrorMsgMax as SQLSMALLINT, byval pcbErrorMsg as SQLSMALLINT ptr) as SQLRETURN
	declare function SQLPrepare alias "SQLPrepareW"(byval hstmt as SQLHSTMT, byval szSqlStr as wstring ptr, byval cbSqlStr as SQLINTEGER) as SQLRETURN
	declare function SQLSetConnectAttr alias "SQLSetConnectAttrW"(byval hdbc as SQLHDBC, byval fAttribute as SQLINTEGER, byval rgbValue as SQLPOINTER, byval cbValue as SQLINTEGER) as SQLRETURN
	declare function SQLSetCursorName alias "SQLSetCursorNameW"(byval hstmt as SQLHSTMT, byval szCursor as wstring ptr, byval cbCursor as SQLSMALLINT) as SQLRETURN
	declare function SQLSetDescField alias "SQLSetDescFieldW"(byval DescriptorHandle as SQLHDESC, byval RecNumber as SQLSMALLINT, byval FieldIdentifier as SQLSMALLINT, byval Value as SQLPOINTER, byval BufferLength as SQLINTEGER) as SQLRETURN
	declare function SQLSetStmtAttr alias "SQLSetStmtAttrW"(byval hstmt as SQLHSTMT, byval fAttribute as SQLINTEGER, byval rgbValue as SQLPOINTER, byval cbValueMax as SQLINTEGER) as SQLRETURN
	declare function SQLGetStmtAttr alias "SQLGetStmtAttrW"(byval hstmt as SQLHSTMT, byval fAttribute as SQLINTEGER, byval rgbValue as SQLPOINTER, byval cbValueMax as SQLINTEGER, byval pcbValue as SQLINTEGER ptr) as SQLRETURN
	declare function SQLColumns alias "SQLColumnsW"(byval hstmt as SQLHSTMT, byval szCatalogName as wstring ptr, byval cbCatalogName as SQLSMALLINT, byval szSchemaName as wstring ptr, byval cbSchemaName as SQLSMALLINT, byval szTableName as wstring ptr, byval cbTableName as SQLSMALLINT, byval szColumnName as wstring ptr, byval cbColumnName as SQLSMALLINT) as SQLRETURN
	declare function SQLGetConnectOption alias "SQLGetConnectOptionW"(byval hdbc as SQLHDBC, byval fOption as SQLUSMALLINT, byval pvParam as SQLPOINTER) as SQLRETURN
	declare function SQLGetInfo alias "SQLGetInfoW"(byval hdbc as SQLHDBC, byval fInfoType as SQLUSMALLINT, byval rgbInfoValue as SQLPOINTER, byval cbInfoValueMax as SQLSMALLINT, byval pcbInfoValue as SQLSMALLINT ptr) as SQLRETURN
	declare function SQLGetTypeInfo alias "SQLGetTypeInfoW"(byval StatementHandle as SQLHSTMT, byval DataType as SQLSMALLINT) as SQLRETURN
#endif

#if (not defined(__FB_64BIT__)) and defined(UNICODE)
	declare function SQLSetConnectOption alias "SQLSetConnectOptionW"(byval hdbc as SQLHDBC, byval fOption as SQLUSMALLINT, byval vParam as SQLUINTEGER) as SQLRETURN
#elseif defined(__FB_64BIT__) and defined(UNICODE)
	declare function SQLSetConnectOption alias "SQLSetConnectOptionW"(byval hdbc as SQLHDBC, byval fOption as SQLUSMALLINT, byval vParam as SQLULEN) as SQLRETURN
#endif

#ifdef UNICODE
	declare function SQLSpecialColumns alias "SQLSpecialColumnsW"(byval hstmt as SQLHSTMT, byval fColType as SQLUSMALLINT, byval szCatalogName as wstring ptr, byval cbCatalogName as SQLSMALLINT, byval szSchemaName as wstring ptr, byval cbSchemaName as SQLSMALLINT, byval szTableName as wstring ptr, byval cbTableName as SQLSMALLINT, byval fScope as SQLUSMALLINT, byval fNullable as SQLUSMALLINT) as SQLRETURN
	declare function SQLStatistics alias "SQLStatisticsW"(byval hstmt as SQLHSTMT, byval szCatalogName as wstring ptr, byval cbCatalogName as SQLSMALLINT, byval szSchemaName as wstring ptr, byval cbSchemaName as SQLSMALLINT, byval szTableName as wstring ptr, byval cbTableName as SQLSMALLINT, byval fUnique as SQLUSMALLINT, byval fAccuracy as SQLUSMALLINT) as SQLRETURN
	declare function SQLTables alias "SQLTablesW"(byval hstmt as SQLHSTMT, byval szCatalogName as wstring ptr, byval cbCatalogName as SQLSMALLINT, byval szSchemaName as wstring ptr, byval cbSchemaName as SQLSMALLINT, byval szTableName as wstring ptr, byval cbTableName as SQLSMALLINT, byval szTableType as wstring ptr, byval cbTableType as SQLSMALLINT) as SQLRETURN
	declare function SQLDataSources alias "SQLDataSourcesW"(byval henv as SQLHENV, byval fDirection as SQLUSMALLINT, byval szDSN as wstring ptr, byval cbDSNMax as SQLSMALLINT, byval pcbDSN as SQLSMALLINT ptr, byval szDescription as wstring ptr, byval cbDescriptionMax as SQLSMALLINT, byval pcbDescription as SQLSMALLINT ptr) as SQLRETURN
	declare function SQLDriverConnect alias "SQLDriverConnectW"(byval hdbc as SQLHDBC, byval hwnd as SQLHWND, byval szConnStrIn as wstring ptr, byval cbConnStrIn as SQLSMALLINT, byval szConnStrOut as wstring ptr, byval cbConnStrOutMax as SQLSMALLINT, byval pcbConnStrOut as SQLSMALLINT ptr, byval fDriverCompletion as SQLUSMALLINT) as SQLRETURN
	declare function SQLBrowseConnect alias "SQLBrowseConnectW"(byval hdbc as SQLHDBC, byval szConnStrIn as wstring ptr, byval cbConnStrIn as SQLSMALLINT, byval szConnStrOut as wstring ptr, byval cbConnStrOutMax as SQLSMALLINT, byval pcbConnStrOut as SQLSMALLINT ptr) as SQLRETURN
	declare function SQLColumnPrivileges alias "SQLColumnPrivilegesW"(byval hstmt as SQLHSTMT, byval szCatalogName as wstring ptr, byval cbCatalogName as SQLSMALLINT, byval szSchemaName as wstring ptr, byval cbSchemaName as SQLSMALLINT, byval szTableName as wstring ptr, byval cbTableName as SQLSMALLINT, byval szColumnName as wstring ptr, byval cbColumnName as SQLSMALLINT) as SQLRETURN
	declare function SQLForeignKeys alias "SQLForeignKeysW"(byval hstmt as SQLHSTMT, byval szPkCatalogName as wstring ptr, byval cbPkCatalogName as SQLSMALLINT, byval szPkSchemaName as wstring ptr, byval cbPkSchemaName as SQLSMALLINT, byval szPkTableName as wstring ptr, byval cbPkTableName as SQLSMALLINT, byval szFkCatalogName as wstring ptr, byval cbFkCatalogName as SQLSMALLINT, byval szFkSchemaName as wstring ptr, byval cbFkSchemaName as SQLSMALLINT, byval szFkTableName as wstring ptr, byval cbFkTableName as SQLSMALLINT) as SQLRETURN
	declare function SQLNativeSql alias "SQLNativeSqlW"(byval hdbc as SQLHDBC, byval szSqlStrIn as wstring ptr, byval cbSqlStrIn as SQLINTEGER, byval szSqlStr as wstring ptr, byval cbSqlStrMax as SQLINTEGER, byval pcbSqlStr as SQLINTEGER ptr) as SQLRETURN
	declare function SQLPrimaryKeys alias "SQLPrimaryKeysW"(byval hstmt as SQLHSTMT, byval szCatalogName as wstring ptr, byval cbCatalogName as SQLSMALLINT, byval szSchemaName as wstring ptr, byval cbSchemaName as SQLSMALLINT, byval szTableName as wstring ptr, byval cbTableName as SQLSMALLINT) as SQLRETURN
	declare function SQLProcedureColumns alias "SQLProcedureColumnsW"(byval hstmt as SQLHSTMT, byval szCatalogName as wstring ptr, byval cbCatalogName as SQLSMALLINT, byval szSchemaName as wstring ptr, byval cbSchemaName as SQLSMALLINT, byval szProcName as wstring ptr, byval cbProcName as SQLSMALLINT, byval szColumnName as wstring ptr, byval cbColumnName as SQLSMALLINT) as SQLRETURN
	declare function SQLProcedures alias "SQLProceduresW"(byval hstmt as SQLHSTMT, byval szCatalogName as wstring ptr, byval cbCatalogName as SQLSMALLINT, byval szSchemaName as wstring ptr, byval cbSchemaName as SQLSMALLINT, byval szProcName as wstring ptr, byval cbProcName as SQLSMALLINT) as SQLRETURN
	declare function SQLTablePrivileges alias "SQLTablePrivilegesW"(byval hstmt as SQLHSTMT, byval szCatalogName as wstring ptr, byval cbCatalogName as SQLSMALLINT, byval szSchemaName as wstring ptr, byval cbSchemaName as SQLSMALLINT, byval szTableName as wstring ptr, byval cbTableName as SQLSMALLINT) as SQLRETURN
	declare function SQLDrivers alias "SQLDriversW"(byval henv as SQLHENV, byval fDirection as SQLUSMALLINT, byval szDriverDesc as wstring ptr, byval cbDriverDescMax as SQLSMALLINT, byval pcbDriverDesc as SQLSMALLINT ptr, byval szDriverAttributes as wstring ptr, byval cbDrvrAttrMax as SQLSMALLINT, byval pcbDrvrAttr as SQLSMALLINT ptr) as SQLRETURN
#endif

end extern
