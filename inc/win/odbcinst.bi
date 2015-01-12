#pragma once

#include once "sql.bi"

#ifdef UNICODE
	'' The following symbols have been renamed:
	''     #define SQLInstallODBC => SQLInstallODBC_
	''     #define SQLCreateDataSource => SQLCreateDataSource_
	''     #define SQLGetTranslator => SQLGetTranslator_
	''     #define SQLInstallDriver => SQLInstallDriver_
	''     #define SQLInstallDriverManager => SQLInstallDriverManager_
	''     #define SQLGetInstalledDrivers => SQLGetInstalledDrivers_
	''     #define SQLGetAvailableDrivers => SQLGetAvailableDrivers_
	''     #define SQLConfigDataSource => SQLConfigDataSource_
	''     #define SQLWriteDSNToIni => SQLWriteDSNToIni_
	''     #define SQLRemoveDSNFromIni => SQLRemoveDSNFromIni_
	''     #define SQLValidDSN => SQLValidDSN_
	''     #define SQLWritePrivateProfileString => SQLWritePrivateProfileString_
	''     #define SQLGetPrivateProfileString => SQLGetPrivateProfileString_
	''     #define SQLInstallTranslator => SQLInstallTranslator_
	''     #define SQLRemoveTranslator => SQLRemoveTranslator_
	''     #define SQLRemoveDriver => SQLRemoveDriver_
	''     #define SQLConfigDriver => SQLConfigDriver_
	''     #define SQLInstallerError => SQLInstallerError_
	''     #define SQLPostInstallerError => SQLPostInstallerError_
	''     #define SQLReadFileDSN => SQLReadFileDSN_
	''     #define SQLWriteFileDSN => SQLWriteFileDSN_
	''     #define SQLInstallDriverEx => SQLInstallDriverEx_
	''     #define SQLInstallTranslatorEx => SQLInstallTranslatorEx_
#endif

extern "Windows"

#define __ODBCINST_H
#define ODBC_ADD_DSN 1
#define ODBC_CONFIG_DSN 2
#define ODBC_REMOVE_DSN 3
#define ODBC_ADD_SYS_DSN 4
#define ODBC_CONFIG_SYS_DSN 5
#define ODBC_REMOVE_SYS_DSN 6
#define ODBC_REMOVE_DEFAULT_DSN 7
#define ODBC_INSTALL_INQUIRY 1
#define ODBC_INSTALL_COMPLETE 2
#define ODBC_INSTALL_DRIVER 1
#define ODBC_REMOVE_DRIVER 2
#define ODBC_CONFIG_DRIVER 3
#define ODBC_CONFIG_DRIVER_MAX 100
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

declare function SQLInstallODBC(byval hwndParent as HWND, byval lpszInfFile as LPCSTR, byval lpszSrcPath as LPCSTR, byval lpszDrivers as LPCSTR) as WINBOOL
declare function SQLManageDataSources(byval hwndParent as HWND) as WINBOOL
declare function SQLCreateDataSource(byval hwndParent as HWND, byval lpszDSN as LPCSTR) as WINBOOL
declare function SQLGetTranslator(byval hwnd as HWND, byval lpszName as LPSTR, byval cbNameMax as WORD, byval pcbNameOut as WORD ptr, byval lpszPath as LPSTR, byval cbPathMax as WORD, byval pcbPathOut as WORD ptr, byval pvOption as DWORD ptr) as WINBOOL
declare function SQLInstallDriver(byval lpszInfFile as LPCSTR, byval lpszDriver as LPCSTR, byval lpszPath as LPSTR, byval cbPathMax as WORD, byval pcbPathOut as WORD ptr) as WINBOOL
declare function SQLInstallDriverManager(byval lpszPath as LPSTR, byval cbPathMax as WORD, byval pcbPathOut as WORD ptr) as WINBOOL
declare function SQLGetInstalledDrivers(byval lpszBuf as LPSTR, byval cbBufMax as WORD, byval pcbBufOut as WORD ptr) as WINBOOL
declare function SQLGetAvailableDrivers(byval lpszInfFile as LPCSTR, byval lpszBuf as LPSTR, byval cbBufMax as WORD, byval pcbBufOut as WORD ptr) as WINBOOL
declare function SQLConfigDataSource(byval hwndParent as HWND, byval fRequest as WORD, byval lpszDriver as LPCSTR, byval lpszAttributes as LPCSTR) as WINBOOL
declare function SQLRemoveDefaultDataSource() as WINBOOL
declare function SQLWriteDSNToIni(byval lpszDSN as LPCSTR, byval lpszDriver as LPCSTR) as WINBOOL
declare function SQLRemoveDSNFromIni(byval lpszDSN as LPCSTR) as WINBOOL
declare function SQLValidDSN(byval lpszDSN as LPCSTR) as WINBOOL
declare function SQLWritePrivateProfileString(byval lpszSection as LPCSTR, byval lpszEntry as LPCSTR, byval lpszString as LPCSTR, byval lpszFilename as LPCSTR) as WINBOOL
declare function SQLGetPrivateProfileString(byval lpszSection as LPCSTR, byval lpszEntry as LPCSTR, byval lpszDefault as LPCSTR, byval lpszRetBuffer as LPSTR, byval cbRetBuffer as long, byval lpszFilename as LPCSTR) as long
declare function SQLRemoveDriverManager(byval lpdwUsageCount as LPDWORD) as WINBOOL
declare function SQLInstallTranslator(byval lpszInfFile as LPCSTR, byval lpszTranslator as LPCSTR, byval lpszPathIn as LPCSTR, byval lpszPathOut as LPSTR, byval cbPathOutMax as WORD, byval pcbPathOut as WORD ptr, byval fRequest as WORD, byval lpdwUsageCount as LPDWORD) as WINBOOL
declare function SQLRemoveTranslator(byval lpszTranslator as LPCSTR, byval lpdwUsageCount as LPDWORD) as WINBOOL
declare function SQLRemoveDriver(byval lpszDriver as LPCSTR, byval fRemoveDSN as WINBOOL, byval lpdwUsageCount as LPDWORD) as WINBOOL
declare function SQLConfigDriver(byval hwndParent as HWND, byval fRequest as WORD, byval lpszDriver as LPCSTR, byval lpszArgs as LPCSTR, byval lpszMsg as LPSTR, byval cbMsgMax as WORD, byval pcbMsgOut as WORD ptr) as WINBOOL
declare function SQLInstallerError(byval iError as WORD, byval pfErrorCode as DWORD ptr, byval lpszErrorMsg as LPSTR, byval cbErrorMsgMax as WORD, byval pcbErrorMsg as WORD ptr) as SQLRETURN
declare function SQLPostInstallerError(byval dwErrorCode as DWORD, byval lpszErrMsg as LPCSTR) as SQLRETURN
declare function SQLWriteFileDSN(byval lpszFileName as LPCSTR, byval lpszAppName as LPCSTR, byval lpszKeyName as LPCSTR, byval lpszString as LPCSTR) as WINBOOL
declare function SQLReadFileDSN(byval lpszFileName as LPCSTR, byval lpszAppName as LPCSTR, byval lpszKeyName as LPCSTR, byval lpszString as LPSTR, byval cbString as WORD, byval pcbString as WORD ptr) as WINBOOL
declare function SQLInstallDriverEx(byval lpszDriver as LPCSTR, byval lpszPathIn as LPCSTR, byval lpszPathOut as LPSTR, byval cbPathOutMax as WORD, byval pcbPathOut as WORD ptr, byval fRequest as WORD, byval lpdwUsageCount as LPDWORD) as WINBOOL
declare function SQLInstallTranslatorEx(byval lpszTranslator as LPCSTR, byval lpszPathIn as LPCSTR, byval lpszPathOut as LPSTR, byval cbPathOutMax as WORD, byval pcbPathOut as WORD ptr, byval fRequest as WORD, byval lpdwUsageCount as LPDWORD) as WINBOOL
declare function SQLGetConfigMode(byval pwConfigMode as UWORD ptr) as WINBOOL
declare function SQLSetConfigMode(byval wConfigMode as UWORD) as WINBOOL
declare function ConfigDSN(byval hwndParent as HWND, byval fRequest as WORD, byval lpszDriver as LPCSTR, byval lpszAttributes as LPCSTR) as WINBOOL
declare function ConfigTranslator(byval hwndParent as HWND, byval pvOption as DWORD ptr) as WINBOOL
declare function ConfigDriver(byval hwndParent as HWND, byval fRequest as WORD, byval lpszDriver as LPCSTR, byval lpszArgs as LPCSTR, byval lpszMsg as LPSTR, byval cbMsgMax as WORD, byval pcbMsgOut as WORD ptr) as WINBOOL
declare function SQLInstallODBCW(byval hwndParent as HWND, byval lpszInfFile as LPCWSTR, byval lpszSrcPath as LPCWSTR, byval lpszDrivers as LPCWSTR) as WINBOOL
declare function SQLCreateDataSourceW(byval hwndParent as HWND, byval lpszDSN as LPCWSTR) as WINBOOL
declare function SQLGetTranslatorW(byval hwnd as HWND, byval lpszName as LPWSTR, byval cbNameMax as WORD, byval pcbNameOut as WORD ptr, byval lpszPath as LPWSTR, byval cbPathMax as WORD, byval pcbPathOut as WORD ptr, byval pvOption as DWORD ptr) as WINBOOL
declare function SQLInstallDriverW(byval lpszInfFile as LPCWSTR, byval lpszDriver as LPCWSTR, byval lpszPath as LPWSTR, byval cbPathMax as WORD, byval pcbPathOut as WORD ptr) as WINBOOL
declare function SQLInstallDriverManagerW(byval lpszPath as LPWSTR, byval cbPathMax as WORD, byval pcbPathOut as WORD ptr) as WINBOOL
declare function SQLGetInstalledDriversW(byval lpszBuf as LPWSTR, byval cbBufMax as WORD, byval pcbBufOut as WORD ptr) as WINBOOL
declare function SQLGetAvailableDriversW(byval lpszInfFile as LPCWSTR, byval lpszBuf as LPWSTR, byval cbBufMax as WORD, byval pcbBufOut as WORD ptr) as WINBOOL
declare function SQLConfigDataSourceW(byval hwndParent as HWND, byval fRequest as WORD, byval lpszDriver as LPCWSTR, byval lpszAttributes as LPCWSTR) as WINBOOL
declare function SQLWriteDSNToIniW(byval lpszDSN as LPCWSTR, byval lpszDriver as LPCWSTR) as WINBOOL
declare function SQLRemoveDSNFromIniW(byval lpszDSN as LPCWSTR) as WINBOOL
declare function SQLValidDSNW(byval lpszDSN as LPCWSTR) as WINBOOL
declare function SQLWritePrivateProfileStringW(byval lpszSection as LPCWSTR, byval lpszEntry as LPCWSTR, byval lpszString as LPCWSTR, byval lpszFilename as LPCWSTR) as WINBOOL
declare function SQLGetPrivateProfileStringW(byval lpszSection as LPCWSTR, byval lpszEntry as LPCWSTR, byval lpszDefault as LPCWSTR, byval lpszRetBuffer as LPWSTR, byval cbRetBuffer as long, byval lpszFilename as LPCWSTR) as long
declare function SQLInstallTranslatorW(byval lpszInfFile as LPCWSTR, byval lpszTranslator as LPCWSTR, byval lpszPathIn as LPCWSTR, byval lpszPathOut as LPWSTR, byval cbPathOutMax as WORD, byval pcbPathOut as WORD ptr, byval fRequest as WORD, byval lpdwUsageCount as LPDWORD) as WINBOOL
declare function SQLRemoveTranslatorW(byval lpszTranslator as LPCWSTR, byval lpdwUsageCount as LPDWORD) as WINBOOL
declare function SQLRemoveDriverW(byval lpszDriver as LPCWSTR, byval fRemoveDSN as WINBOOL, byval lpdwUsageCount as LPDWORD) as WINBOOL
declare function SQLConfigDriverW(byval hwndParent as HWND, byval fRequest as WORD, byval lpszDriver as LPCWSTR, byval lpszArgs as LPCWSTR, byval lpszMsg as LPWSTR, byval cbMsgMax as WORD, byval pcbMsgOut as WORD ptr) as WINBOOL
declare function SQLInstallerErrorW(byval iError as WORD, byval pfErrorCode as DWORD ptr, byval lpszErrorMsg as LPWSTR, byval cbErrorMsgMax as WORD, byval pcbErrorMsg as WORD ptr) as SQLRETURN
declare function SQLPostInstallerErrorW(byval dwErrorCode as DWORD, byval lpszErrorMsg as LPCWSTR) as SQLRETURN
declare function SQLWriteFileDSNW(byval lpszFileName as LPCWSTR, byval lpszAppName as LPCWSTR, byval lpszKeyName as LPCWSTR, byval lpszString as LPCWSTR) as WINBOOL
declare function SQLReadFileDSNW(byval lpszFileName as LPCWSTR, byval lpszAppName as LPCWSTR, byval lpszKeyName as LPCWSTR, byval lpszString as LPWSTR, byval cbString as WORD, byval pcbString as WORD ptr) as WINBOOL
declare function SQLInstallDriverExW(byval lpszDriver as LPCWSTR, byval lpszPathIn as LPCWSTR, byval lpszPathOut as LPWSTR, byval cbPathOutMax as WORD, byval pcbPathOut as WORD ptr, byval fRequest as WORD, byval lpdwUsageCount as LPDWORD) as WINBOOL
declare function SQLInstallTranslatorExW(byval lpszTranslator as LPCWSTR, byval lpszPathIn as LPCWSTR, byval lpszPathOut as LPWSTR, byval cbPathOutMax as WORD, byval pcbPathOut as WORD ptr, byval fRequest as WORD, byval lpdwUsageCount as LPDWORD) as WINBOOL
declare function ConfigDSNW(byval hwndParent as HWND, byval fRequest as WORD, byval lpszDriver as LPCWSTR, byval lpszAttributes as LPCWSTR) as WINBOOL
declare function ConfigDriverW(byval hwndParent as HWND, byval fRequest as WORD, byval lpszDriver as LPCWSTR, byval lpszArgs as LPCWSTR, byval lpszMsg as LPWSTR, byval cbMsgMax as WORD, byval pcbMsgOut as WORD ptr) as WINBOOL

#ifdef UNICODE
	#define SQLInstallODBC_ SQLInstallODBCW
	#define SQLCreateDataSource_ SQLCreateDataSourceW
	#define SQLGetTranslator_ SQLGetTranslatorW
	#define SQLInstallDriver_ SQLInstallDriverW
	#define SQLInstallDriverManager_ SQLInstallDriverManagerW
	#define SQLGetInstalledDrivers_ SQLGetInstalledDriversW
	#define SQLGetAvailableDrivers_ SQLGetAvailableDriversW
	#define SQLConfigDataSource_ SQLConfigDataSourceW
	#define SQLWriteDSNToIni_ SQLWriteDSNToIniW
	#define SQLRemoveDSNFromIni_ SQLRemoveDSNFromIniW
	#define SQLValidDSN_ SQLValidDSNW
	#define SQLWritePrivateProfileString_ SQLWritePrivateProfileStringW
	#define SQLGetPrivateProfileString_ SQLGetPrivateProfileStringW
	#define SQLInstallTranslator_ SQLInstallTranslatorW
	#define SQLRemoveTranslator_ SQLRemoveTranslatorW
	#define SQLRemoveDriver_ SQLRemoveDriverW
	#define SQLConfigDriver_ SQLConfigDriverW
	#define SQLInstallerError_ SQLInstallerErrorW
	#define SQLPostInstallerError_ SQLPostInstallerErrorW
	#define SQLReadFileDSN_ SQLReadFileDSNW
	#define SQLWriteFileDSN_ SQLWriteFileDSNW
	#define SQLInstallDriverEx_ SQLInstallDriverExW
	#define SQLInstallTranslatorEx_ SQLInstallTranslatorExW
#endif

end extern
