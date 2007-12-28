''
''
'' odbcinst -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_odbcinst_bi__
#define __win_odbcinst_bi__

#include once "win/sql.bi"

#ifndef ODBCVER
#define ODBCVER &h0351
#endif

#define ODBC_ADD_DSN 1
#define ODBC_CONFIG_DSN 2
#define ODBC_REMOVE_DSN 3
#define ODBC_ADD_SYS_DSN 4
#define ODBC_CONFIG_SYS_DSN 5
#define ODBC_REMOVE_SYS_DSN 6
#define ODBC_INSTALL_INQUIRY 1
#define ODBC_INSTALL_COMPLETE 2
#define ODBC_INSTALL_DRIVER 1
#define ODBC_REMOVE_DRIVER 2
#define ODBC_CONFIG_DRIVER 3
#define ODBC_CONFIG_DRIVER_MAX 100
#define ODBC_REMOVE_DEFAULT_DSN 7
#define ODBC_BOTH_DSN 0
#define ODBC_USER_DSN 1
#define ODBC_SYSTEM_DSN 2
#define ODBC_ERROR_GENERAL_ERR 1
#define ODBC_ERROR_INVALID_BUFF_LEN 2
#define ODBC_ERROR_INVALID_HWND 3
#define ODBC_ERROR_INVALID_STR 4
#define ODBC_ERROR_INVALID_REQUEST_TYPE 5
#define ODBC_ERROR_COMPONENT_NOT_FOUND 6
#define ODBC_ERROR_INVALID_NAME 7
#define ODBC_ERROR_INVALID_KEYWORD_VALUE 8
#define ODBC_ERROR_INVALID_DSN 9
#define ODBC_ERROR_INVALID_INF 10
#define ODBC_ERROR_REQUEST_FAILED 11
#define ODBC_ERROR_INVALID_PATH 12
#define ODBC_ERROR_LOAD_LIB_FAILED 13
#define ODBC_ERROR_INVALID_PARAM_SEQUENCE 14
#define ODBC_ERROR_INVALID_LOG_FILE 15
#define ODBC_ERROR_USER_CANCELED 16
#define ODBC_ERROR_USAGE_UPDATE_FAILED 17
#define ODBC_ERROR_CREATE_DSN_FAILED 18
#define ODBC_ERROR_WRITING_SYSINFO_FAILED 19
#define ODBC_ERROR_REMOVE_DSN_FAILED 20
#define ODBC_ERROR_OUT_OF_MEM 21
#define ODBC_ERROR_OUTPUT_STRING_TRUNCATED 22

#ifdef UNICODE
declare function ConfigDSN alias "ConfigDSNW" (byval as HWND, byval as WORD, byval as LPCWSTR, byval as LPCWSTR) as BOOL
declare function SQLConfigDataSource alias "SQLConfigDataSourceW" (byval as HWND, byval as WORD, byval as LPCWSTR, byval as LPCWSTR) as BOOL
declare function SQLCreateDataSource alias "SQLCreateDataSourceW" (byval as HWND, byval as LPCWSTR) as BOOL
declare function SQLGetAvailableDrivers alias "SQLGetAvailableDriversW" (byval as LPCWSTR, byval as LPWSTR, byval as WORD, byval as WORD ptr) as BOOL
declare function SQLGetInstalledDrivers alias "SQLGetInstalledDriversW" (byval as LPWSTR, byval as WORD, byval as WORD ptr) as BOOL
declare function SQLGetPrivateProfileString alias "SQLGetPrivateProfileStringW" (byval as LPCWSTR, byval as LPCWSTR, byval as LPCWSTR, byval as LPWSTR, byval as integer, byval as LPCWSTR) as integer
declare function SQLGetTranslator alias "SQLGetTranslatorW" (byval as HWND, byval as LPWSTR, byval as WORD, byval as WORD ptr, byval as LPWSTR, byval as WORD, byval as WORD ptr, byval as DWORD ptr) as BOOL
declare function SQLInstallDriverManager alias "SQLInstallDriverManagerW" (byval as LPWSTR, byval as WORD, byval as WORD ptr) as BOOL
declare function SQLInstallDriver alias "SQLInstallDriverW" (byval as LPCWSTR, byval as LPCWSTR, byval as LPWSTR, byval as WORD, byval as WORD ptr) as BOOL
declare function SQLInstallODBC alias "SQLInstallODBCW" (byval as HWND, byval as LPCWSTR, byval as LPCWSTR, byval as LPCWSTR) as BOOL
declare function SQLRemoveDSNFromIni alias "SQLRemoveDSNFromIniW" (byval as LPCWSTR) as BOOL
declare function SQLValidDSN alias "SQLValidDSNW" (byval as LPCWSTR) as BOOL
declare function SQLWriteDSNToIni alias "SQLWriteDSNToIniW" (byval as LPCWSTR, byval as LPCWSTR) as BOOL
declare function SQLWritePrivateProfileString alias "SQLWritePrivateProfileStringW" (byval as LPCWSTR, byval as LPCWSTR, byval as LPCWSTR, byval as LPCWSTR) as BOOL
declare function ConfigDriver alias "ConfigDriverW" (byval as HWND, byval as WORD, byval as LPCWSTR, byval as LPCWSTR, byval as LPWSTR, byval as WORD, byval as WORD ptr) as BOOL
declare function SQLConfigDriver alias "SQLConfigDriverW" (byval as HWND, byval as WORD, byval as LPCWSTR, byval as LPCWSTR, byval as LPWSTR, byval as WORD, byval as WORD ptr) as BOOL
declare function SQLInstallTranslator alias "SQLInstallTranslatorW" (byval as LPCWSTR, byval as LPCWSTR, byval as LPCWSTR, byval as LPWSTR, byval as WORD, byval as WORD ptr, byval as WORD, byval as LPDWORD) as BOOL
declare function SQLRemoveDriver alias "SQLRemoveDriverW" (byval as LPCWSTR, byval as BOOL, byval as LPDWORD) as BOOL
declare function SQLRemoveTranslator alias "SQLRemoveTranslatorW" (byval as LPCWSTR, byval as LPDWORD) as BOOL
declare function SQLInstallDriverEx alias "SQLInstallDriverExW" (byval as LPCWSTR, byval as LPCWSTR, byval as LPWSTR, byval as WORD, byval as WORD ptr, byval as WORD, byval as LPDWORD) as BOOL
declare function SQLInstallerError alias "SQLInstallerErrorW" (byval as WORD, byval as DWORD ptr, byval as LPWSTR, byval as WORD, byval as WORD ptr) as SQLRETURN
declare function SQLInstallTranslatorEx alias "SQLInstallTranslatorExW" (byval as LPCWSTR, byval as LPCWSTR, byval as LPWSTR, byval as WORD, byval as WORD ptr, byval as WORD, byval as LPDWORD) as BOOL
declare function SQLPostInstallerError alias "SQLPostInstallerErrorW" (byval as DWORD, byval as LPCWSTR) as SQLRETURN
declare function SQLReadFileDSN alias "SQLReadFileDSNW" (byval as LPCWSTR, byval as LPCWSTR, byval as LPCWSTR, byval as LPWSTR, byval as WORD, byval as WORD ptr) as BOOL
declare function SQLWriteFileDSN alias "SQLWriteFileDSNW" (byval as LPCWSTR, byval as LPCWSTR, byval as LPCWSTR, byval as LPCWSTR) as BOOL

#else ''UNICODE
declare function ConfigDSN alias "ConfigDSN" (byval as HWND, byval as WORD, byval as LPCSTR, byval as LPCSTR) as BOOL
declare function ConfigTranslator alias "ConfigTranslator" (byval as HWND, byval as DWORD ptr) as BOOL
declare function SQLConfigDataSource alias "SQLConfigDataSource" (byval as HWND, byval as WORD, byval as LPCSTR, byval as LPCSTR) as BOOL
declare function SQLCreateDataSource alias "SQLCreateDataSource" (byval as HWND, byval as LPCSTR) as BOOL
declare function SQLGetAvailableDrivers alias "SQLGetAvailableDrivers" (byval as LPCSTR, byval as LPSTR, byval as WORD, byval as WORD ptr) as BOOL
declare function SQLGetInstalledDrivers alias "SQLGetInstalledDrivers" (byval as LPSTR, byval as WORD, byval as WORD ptr) as BOOL
declare function SQLGetPrivateProfileString alias "SQLGetPrivateProfileString" (byval as LPCSTR, byval as LPCSTR, byval as LPCSTR, byval as LPSTR, byval as integer, byval as LPCSTR) as integer
declare function SQLGetTranslator alias "SQLGetTranslator" (byval as HWND, byval as LPSTR, byval as WORD, byval as WORD ptr, byval as LPSTR, byval as WORD, byval as WORD ptr, byval as DWORD ptr) as BOOL
declare function SQLInstallDriver alias "SQLInstallDriver" (byval as LPCSTR, byval as LPCSTR, byval as LPSTR, byval as WORD, byval as WORD ptr) as BOOL
declare function SQLInstallDriverManager alias "SQLInstallDriverManager" (byval as LPSTR, byval as WORD, byval as WORD ptr) as BOOL
declare function SQLInstallODBC alias "SQLInstallODBC" (byval as HWND, byval as LPCSTR, byval as LPCSTR, byval as LPCSTR) as BOOL
declare function SQLManageDataSources alias "SQLManageDataSources" (byval as HWND) as BOOL
declare function SQLRemoveDefaultDataSource alias "SQLRemoveDefaultDataSource" () as BOOL
declare function SQLRemoveDSNFromIni alias "SQLRemoveDSNFromIni" (byval as LPCSTR) as BOOL
declare function SQLValidDSN alias "SQLValidDSN" (byval as LPCSTR) as BOOL
declare function SQLWriteDSNToIni alias "SQLWriteDSNToIni" (byval as LPCSTR, byval as LPCSTR) as BOOL
declare function SQLWritePrivateProfileString alias "SQLWritePrivateProfileString" (byval as LPCSTR, byval as LPCSTR, byval as LPCSTR, byval as LPCSTR) as BOOL
declare function ConfigDriver alias "ConfigDriver" (byval as HWND, byval as WORD, byval as LPCSTR, byval as LPCSTR, byval as LPSTR, byval as WORD, byval as WORD ptr) as BOOL
declare function SQLConfigDriver alias "SQLConfigDriver" (byval as HWND, byval as WORD, byval as LPCSTR, byval as LPCSTR, byval as LPSTR, byval as WORD, byval as WORD ptr) as BOOL
declare function SQLInstallTranslator alias "SQLInstallTranslator" (byval as LPCSTR, byval as LPCSTR, byval as LPCSTR, byval as LPSTR, byval as WORD, byval as WORD ptr, byval as WORD, byval as LPDWORD) as BOOL
declare function SQLRemoveDriver alias "SQLRemoveDriver" (byval as LPCSTR, byval as BOOL, byval as LPDWORD) as BOOL
declare function SQLRemoveDriverManager alias "SQLRemoveDriverManager" (byval as LPDWORD) as BOOL
declare function SQLRemoveTranslator alias "SQLRemoveTranslator" (byval as LPCSTR, byval as LPDWORD) as BOOL
declare function SQLGetConfigMode alias "SQLGetConfigMode" (byval as UWORD ptr) as BOOL
declare function SQLInstallDriverEx alias "SQLInstallDriverEx" (byval as LPCSTR, byval as LPCSTR, byval as LPSTR, byval as WORD, byval as WORD ptr, byval as WORD, byval as LPDWORD) as BOOL
declare function SQLInstallerError alias "SQLInstallerError" (byval as WORD, byval as DWORD ptr, byval as LPSTR, byval as WORD, byval as WORD ptr) as SQLRETURN
declare function SQLInstallTranslatorEx alias "SQLInstallTranslatorEx" (byval as LPCSTR, byval as LPCSTR, byval as LPSTR, byval as WORD, byval as WORD ptr, byval as WORD, byval as LPDWORD) as BOOL
declare function SQLPostInstallerError alias "SQLPostInstallerError" (byval as DWORD, byval as LPCSTR) as SQLRETURN
declare function SQLReadFileDSN alias "SQLReadFileDSN" (byval as LPCSTR, byval as LPCSTR, byval as LPCSTR, byval as LPSTR, byval as WORD, byval as WORD ptr) as BOOL
declare function SQLSetConfigMode alias "SQLSetConfigMode" (byval as UWORD) as BOOL
declare function SQLWriteFileDSN alias "SQLWriteFileDSN" (byval as LPCSTR, byval as LPCSTR, byval as LPCSTR, byval as LPCSTR) as BOOL
#endif ''UNICODE

#endif
