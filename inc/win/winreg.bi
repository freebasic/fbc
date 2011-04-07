''
''
'' winreg -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_winreg_bi__
#define __win_winreg_bi__

#inclib "advapi32"

#define HKEY_CLASSES_ROOT cast(HKEY, &h80000000)
#define HKEY_CURRENT_USER cast(HKEY, &h80000001)
#define HKEY_LOCAL_MACHINE cast(HKEY, &h80000002)
#define HKEY_USERS cast(HKEY, &h80000003)
#define HKEY_PERFORMANCE_DATA cast(HKEY, &h80000004)
#define HKEY_CURRENT_CONFIG	cast(HKEY, &h80000005)
#define HKEY_DYN_DATA cast(HKEY, &h80000006)
#define REG_OPTION_VOLATILE 1
#define REG_OPTION_NON_VOLATILE 0
#define REG_CREATED_NEW_KEY 1
#define REG_OPENED_EXISTING_KEY 2
#define REG_NONE 0
#define REG_SZ 1
#define REG_EXPAND_SZ 2
#define REG_BINARY 3
#define REG_DWORD_LITTLE_ENDIAN 4
#define REG_DWORD 4
#define REG_DWORD_BIG_ENDIAN 5
#define REG_LINK 6
#define REG_MULTI_SZ 7
#define REG_RESOURCE_LIST 8
#define REG_FULL_RESOURCE_DESCRIPTOR 9
#define REG_RESOURCE_REQUIREMENTS_LIST 10
#define REG_QWORD_LITTLE_ENDIAN 11
#define REG_QWORD 11
#define REG_NOTIFY_CHANGE_NAME 1
#define REG_NOTIFY_CHANGE_ATTRIBUTES 2
#define REG_NOTIFY_CHANGE_LAST_SET 4
#define REG_NOTIFY_CHANGE_SECURITY 8

type REGSAM as ACCESS_MASK

type value_entA
	ve_valuename as LPSTR
	ve_valuelen as DWORD
	ve_valueptr as DWORD
	ve_type as DWORD
end type

type VALENTA as value_entA
type PVALENTA as value_entA ptr

type value_entW
	ve_valuename as LPWSTR
	ve_valuelen as DWORD
	ve_valueptr as DWORD
	ve_type as DWORD
end type

type VALENTW as value_entW
type PVALENTW as value_entW ptr

declare function RegCloseKey alias "RegCloseKey" (byval as HKEY) as LONG
declare function RegFlushKey alias "RegFlushKey" (byval as HKEY) as LONG
declare function RegGetKeySecurity alias "RegGetKeySecurity" (byval as HKEY, byval as SECURITY_INFORMATION, byval as PSECURITY_DESCRIPTOR, byval as PDWORD) as LONG
declare function RegNotifyChangeKeyValue alias "RegNotifyChangeKeyValue" (byval as HKEY, byval as BOOL, byval as DWORD, byval as HANDLE, byval as BOOL) as LONG
declare function RegSetKeySecurity alias "RegSetKeySecurity" (byval as HKEY, byval as SECURITY_INFORMATION, byval as PSECURITY_DESCRIPTOR) as LONG

#ifdef UNICODE
type VALENT as VALENTW
type PVALENT as VALENTW ptr

declare function AbortSystemShutdown alias "AbortSystemShutdownW" (byval as LPCWSTR) as BOOL
declare function InitiateSystemShutdown alias "InitiateSystemShutdownW" (byval as LPWSTR, byval as LPWSTR, byval as DWORD, byval as BOOL, byval as BOOL) as BOOL
declare function RegConnectRegistry alias "RegConnectRegistryW" (byval as LPCWSTR, byval as HKEY, byval as PHKEY) as LONG
declare function RegCreateKeyEx alias "RegCreateKeyExW" (byval as HKEY, byval as LPCWSTR, byval as DWORD, byval as LPWSTR, byval as DWORD, byval as REGSAM, byval as LPSECURITY_ATTRIBUTES, byval as PHKEY, byval as PDWORD) as LONG
declare function RegCreateKey alias "RegCreateKeyW" (byval as HKEY, byval as LPCWSTR, byval as PHKEY) as LONG
declare function RegDeleteKey alias "RegDeleteKeyW" (byval as HKEY, byval as LPCWSTR) as LONG
declare function RegDeleteValue alias "RegDeleteValueW" (byval as HKEY, byval as LPCWSTR) as LONG
declare function RegEnumKey alias "RegEnumKeyW" (byval as HKEY, byval as DWORD, byval as LPWSTR, byval as DWORD) as LONG
declare function RegEnumKeyEx alias "RegEnumKeyExW" (byval as HKEY, byval as DWORD, byval as LPWSTR, byval as PDWORD, byval as PDWORD, byval as LPWSTR, byval as PDWORD, byval as PFILETIME) as LONG
declare function RegEnumValue alias "RegEnumValueW" (byval as HKEY, byval as DWORD, byval as LPWSTR, byval as PDWORD, byval as PDWORD, byval as PDWORD, byval as LPBYTE, byval as PDWORD) as LONG
declare function RegLoadKey alias "RegLoadKeyW" (byval as HKEY, byval as LPCWSTR, byval as LPCWSTR) as LONG
declare function RegOpenKeyEx alias "RegOpenKeyExW" (byval as HKEY, byval as LPCWSTR, byval as DWORD, byval as REGSAM, byval as PHKEY) as LONG
declare function RegOpenKey alias "RegOpenKeyW" (byval as HKEY, byval as LPCWSTR, byval as PHKEY) as LONG
declare function RegQueryInfoKey alias "RegQueryInfoKeyW" (byval as HKEY, byval as LPWSTR, byval as PDWORD, byval as PDWORD, byval as PDWORD, byval as PDWORD, byval as PDWORD, byval as PDWORD, byval as PDWORD, byval as PDWORD, byval as PDWORD, byval as PFILETIME) as LONG
declare function RegQueryMultipleValues alias "RegQueryMultipleValuesW" (byval as HKEY, byval as PVALENTW, byval as DWORD, byval as LPWSTR, byval as LPDWORD) as LONG
declare function RegQueryValueEx alias "RegQueryValueExW" (byval as HKEY, byval as LPCWSTR, byval as LPDWORD, byval as LPDWORD, byval as LPBYTE, byval as LPDWORD) as LONG
declare function RegQueryValue alias "RegQueryValueW" (byval as HKEY, byval as LPCWSTR, byval as LPWSTR, byval as PLONG) as LONG
declare function RegReplaceKey alias "RegReplaceKeyW" (byval as HKEY, byval as LPCWSTR, byval as LPCWSTR, byval as LPCWSTR) as LONG
declare function RegRestoreKey alias "RegRestoreKeyW" (byval as HKEY, byval as LPCWSTR, byval as DWORD) as LONG
declare function RegSaveKey alias "RegSaveKeyW" (byval as HKEY, byval as LPCWSTR, byval as LPSECURITY_ATTRIBUTES) as LONG
declare function RegSetValueEx alias "RegSetValueExW" (byval as HKEY, byval as LPCWSTR, byval as DWORD, byval as DWORD, byval as UBYTE ptr, byval as DWORD) as LONG
declare function RegSetValue alias "RegSetValueW" (byval as HKEY, byval as LPCWSTR, byval as DWORD, byval as LPCWSTR, byval as DWORD) as LONG
declare function RegUnLoadKey alias "RegUnLoadKeyW" (byval as HKEY, byval as LPCWSTR) as LONG

#else ''UNICODE
type VALENT as VALENTA
type PVALENT as VALENTA ptr

declare function AbortSystemShutdown alias "AbortSystemShutdownA" (byval as LPCSTR) as BOOL
declare function InitiateSystemShutdown alias "InitiateSystemShutdownA" (byval as LPSTR, byval as LPSTR, byval as DWORD, byval as BOOL, byval as BOOL) as BOOL
declare function RegConnectRegistry alias "RegConnectRegistryA" (byval as LPCSTR, byval as HKEY, byval as PHKEY) as LONG
declare function RegCreateKey alias "RegCreateKeyA" (byval as HKEY, byval as LPCSTR, byval as PHKEY) as LONG
declare function RegCreateKeyEx alias "RegCreateKeyExA" (byval as HKEY, byval as LPCSTR, byval as DWORD, byval as LPSTR, byval as DWORD, byval as REGSAM, byval as LPSECURITY_ATTRIBUTES, byval as PHKEY, byval as PDWORD) as LONG
declare function RegDeleteKey alias "RegDeleteKeyA" (byval as HKEY, byval as LPCSTR) as LONG
declare function RegDeleteValue alias "RegDeleteValueA" (byval as HKEY, byval as LPCSTR) as LONG
declare function RegEnumKey alias "RegEnumKeyA" (byval as HKEY, byval as DWORD, byval as LPSTR, byval as DWORD) as LONG
declare function RegEnumKeyEx alias "RegEnumKeyExA" (byval as HKEY, byval as DWORD, byval as LPSTR, byval as PDWORD, byval as PDWORD, byval as LPSTR, byval as PDWORD, byval as PFILETIME) as LONG
declare function RegEnumValue alias "RegEnumValueA" (byval as HKEY, byval as DWORD, byval as LPSTR, byval as PDWORD, byval as PDWORD, byval as PDWORD, byval as LPBYTE, byval as PDWORD) as LONG
declare function RegLoadKey alias "RegLoadKeyA" (byval as HKEY, byval as LPCSTR, byval as LPCSTR) as LONG
declare function RegOpenKey alias "RegOpenKeyA" (byval as HKEY, byval as LPCSTR, byval as PHKEY) as LONG
declare function RegOpenKeyEx alias "RegOpenKeyExA" (byval as HKEY, byval as LPCSTR, byval as DWORD, byval as REGSAM, byval as PHKEY) as LONG
declare function RegQueryInfoKey alias "RegQueryInfoKeyA" (byval as HKEY, byval as LPSTR, byval as PDWORD, byval as PDWORD, byval as PDWORD, byval as PDWORD, byval as PDWORD, byval as PDWORD, byval as PDWORD, byval as PDWORD, byval as PDWORD, byval as PFILETIME) as LONG
declare function RegQueryMultipleValues alias "RegQueryMultipleValuesA" (byval as HKEY, byval as PVALENTA, byval as DWORD, byval as LPSTR, byval as LPDWORD) as LONG
declare function RegQueryValue alias "RegQueryValueA" (byval as HKEY, byval as LPCSTR, byval as LPSTR, byval as PLONG) as LONG
declare function RegQueryValueEx alias "RegQueryValueExA" (byval as HKEY, byval as LPCSTR, byval as LPDWORD, byval as LPDWORD, byval as LPBYTE, byval as LPDWORD) as LONG
declare function RegReplaceKey alias "RegReplaceKeyA" (byval as HKEY, byval as LPCSTR, byval as LPCSTR, byval as LPCSTR) as LONG
declare function RegRestoreKey alias "RegRestoreKeyA" (byval as HKEY, byval as LPCSTR, byval as DWORD) as LONG
declare function RegSaveKey alias "RegSaveKeyA" (byval as HKEY, byval as LPCSTR, byval as LPSECURITY_ATTRIBUTES) as LONG
declare function RegSetValue alias "RegSetValueA" (byval as HKEY, byval as LPCSTR, byval as DWORD, byval as LPCSTR, byval as DWORD) as LONG
declare function RegSetValueEx alias "RegSetValueExA" (byval as HKEY, byval as LPCSTR, byval as DWORD, byval as DWORD, byval as UBYTE ptr, byval as DWORD) as LONG
declare function RegUnLoadKey alias "RegUnLoadKeyA" (byval as HKEY, byval as LPCSTR) as LONG

#endif ''UNICODE

#endif
