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

#inclib "advapi32"

#include once "_mingw_unicode.bi"
#include once "reason.bi"

extern "Windows"

#define _WINREG_
const RRF_RT_REG_NONE = &h00000001
const RRF_RT_REG_SZ = &h00000002
const RRF_RT_REG_EXPAND_SZ = &h00000004
const RRF_RT_REG_BINARY = &h00000008
const RRF_RT_REG_DWORD = &h00000010
const RRF_RT_REG_MULTI_SZ = &h00000020
const RRF_RT_REG_QWORD = &h00000040
const RRF_RT_DWORD = RRF_RT_REG_BINARY or RRF_RT_REG_DWORD
const RRF_RT_QWORD = RRF_RT_REG_BINARY or RRF_RT_REG_QWORD
const RRF_RT_ANY = &h0000ffff
const RRF_NOEXPAND = &h10000000
const RRF_ZEROONFAILURE = &h20000000
type REGSAM as ACCESS_MASK
type LSTATUS as LONG
#define HKEY_CLASSES_ROOT cast(HKEY, cast(ULONG_PTR, cast(LONG, &h80000000)))
#define HKEY_CURRENT_USER cast(HKEY, cast(ULONG_PTR, cast(LONG, &h80000001)))
#define HKEY_LOCAL_MACHINE cast(HKEY, cast(ULONG_PTR, cast(LONG, &h80000002)))
#define HKEY_USERS cast(HKEY, cast(ULONG_PTR, cast(LONG, &h80000003)))
#define HKEY_PERFORMANCE_DATA cast(HKEY, cast(ULONG_PTR, cast(LONG, &h80000004)))
#define HKEY_PERFORMANCE_TEXT cast(HKEY, cast(ULONG_PTR, cast(LONG, &h80000050)))
#define HKEY_PERFORMANCE_NLSTEXT cast(HKEY, cast(ULONG_PTR, cast(LONG, &h80000060)))
#define HKEY_CURRENT_CONFIG cast(HKEY, cast(ULONG_PTR, cast(LONG, &h80000005)))
#define HKEY_DYN_DATA cast(HKEY, cast(ULONG_PTR, cast(LONG, &h80000006)))
const REG_SECURE_CONNECTION = 1
#define _PROVIDER_STRUCTS_DEFINED
const PROVIDER_KEEPS_VALUE_LENGTH = &h1

type val_context
	valuelen as long
	value_context as LPVOID
	val_buff_ptr as LPVOID
end type

type PVALCONTEXT as val_context ptr

type PVALUEA
	pv_valuename as LPSTR
	pv_valuelen as long
	pv_value_context as LPVOID
	pv_type as DWORD
end type

type PPVALUEA as PVALUEA ptr

type PVALUEW
	pv_valuename as LPWSTR
	pv_valuelen as long
	pv_value_context as LPVOID
	pv_type as DWORD
end type

type PPVALUEW as PVALUEW ptr

#ifdef UNICODE
	type PVALUE as PVALUEW
	type PPVALUE as PPVALUEW
#else
	type PVALUE as PVALUEA
	type PPVALUE as PPVALUEA
#endif

type PQUERYHANDLER as function cdecl(byval keycontext as LPVOID, byval val_list as PVALCONTEXT, byval num_vals as DWORD, byval outputbuffer as LPVOID, byval total_outlen as DWORD ptr, byval input_blen as DWORD) as DWORD

type provider_info
	pi_R0_1val as PQUERYHANDLER
	pi_R0_allvals as PQUERYHANDLER
	pi_R3_1val as PQUERYHANDLER
	pi_R3_allvals as PQUERYHANDLER
	pi_flags as DWORD
	pi_key_context as LPVOID
end type

type REG_PROVIDER as provider_info
type PPROVIDER as provider_info ptr

type value_entA
	ve_valuename as LPSTR
	ve_valuelen as DWORD
	ve_valueptr as DWORD_PTR
	ve_type as DWORD
end type

type VALENTA as value_entA
type PVALENTA as value_entA ptr

type value_entW
	ve_valuename as LPWSTR
	ve_valuelen as DWORD
	ve_valueptr as DWORD_PTR
	ve_type as DWORD
end type

type VALENTW as value_entW
type PVALENTW as value_entW ptr

#ifdef UNICODE
	type VALENT as VALENTW
	type PVALENT as PVALENTW
#else
	type VALENT as VALENTA
	type PVALENT as PVALENTA
#endif

#define WIN31_CLASS NULL
declare function RegCloseKey(byval hKey as HKEY) as LONG
declare function RegOverridePredefKey(byval hKey as HKEY, byval hNewHKey as HKEY) as LONG
declare function RegOpenUserClassesRoot(byval hToken as HANDLE, byval dwOptions as DWORD, byval samDesired as REGSAM, byval phkResult as PHKEY) as LONG
declare function RegOpenCurrentUser(byval samDesired as REGSAM, byval phkResult as PHKEY) as LONG
declare function RegDisablePredefinedCache() as LONG
declare function RegConnectRegistryA(byval lpMachineName as LPCSTR, byval hKey as HKEY, byval phkResult as PHKEY) as LONG

#ifndef UNICODE
	declare function RegConnectRegistry alias "RegConnectRegistryA"(byval lpMachineName as LPCSTR, byval hKey as HKEY, byval phkResult as PHKEY) as LONG
#endif

declare function RegConnectRegistryW(byval lpMachineName as LPCWSTR, byval hKey as HKEY, byval phkResult as PHKEY) as LONG

#ifdef UNICODE
	declare function RegConnectRegistry alias "RegConnectRegistryW"(byval lpMachineName as LPCWSTR, byval hKey as HKEY, byval phkResult as PHKEY) as LONG
#endif

declare function RegConnectRegistryExA(byval lpMachineName as LPCSTR, byval hKey as HKEY, byval Flags as ULONG, byval phkResult as PHKEY) as LONG

#ifndef UNICODE
	declare function RegConnectRegistryEx alias "RegConnectRegistryExA"(byval lpMachineName as LPCSTR, byval hKey as HKEY, byval Flags as ULONG, byval phkResult as PHKEY) as LONG
#endif

declare function RegConnectRegistryExW(byval lpMachineName as LPCWSTR, byval hKey as HKEY, byval Flags as ULONG, byval phkResult as PHKEY) as LONG

#ifdef UNICODE
	declare function RegConnectRegistryEx alias "RegConnectRegistryExW"(byval lpMachineName as LPCWSTR, byval hKey as HKEY, byval Flags as ULONG, byval phkResult as PHKEY) as LONG
#endif

declare function RegCreateKeyA(byval hKey as HKEY, byval lpSubKey as LPCSTR, byval phkResult as PHKEY) as LONG

#ifndef UNICODE
	declare function RegCreateKey alias "RegCreateKeyA"(byval hKey as HKEY, byval lpSubKey as LPCSTR, byval phkResult as PHKEY) as LONG
#endif

declare function RegCreateKeyW(byval hKey as HKEY, byval lpSubKey as LPCWSTR, byval phkResult as PHKEY) as LONG

#ifdef UNICODE
	declare function RegCreateKey alias "RegCreateKeyW"(byval hKey as HKEY, byval lpSubKey as LPCWSTR, byval phkResult as PHKEY) as LONG
#endif

declare function RegCreateKeyExA(byval hKey as HKEY, byval lpSubKey as LPCSTR, byval Reserved as DWORD, byval lpClass as LPSTR, byval dwOptions as DWORD, byval samDesired as REGSAM, byval lpSecurityAttributes as LPSECURITY_ATTRIBUTES, byval phkResult as PHKEY, byval lpdwDisposition as LPDWORD) as LONG

#ifndef UNICODE
	declare function RegCreateKeyEx alias "RegCreateKeyExA"(byval hKey as HKEY, byval lpSubKey as LPCSTR, byval Reserved as DWORD, byval lpClass as LPSTR, byval dwOptions as DWORD, byval samDesired as REGSAM, byval lpSecurityAttributes as LPSECURITY_ATTRIBUTES, byval phkResult as PHKEY, byval lpdwDisposition as LPDWORD) as LONG
#endif

declare function RegCreateKeyExW(byval hKey as HKEY, byval lpSubKey as LPCWSTR, byval Reserved as DWORD, byval lpClass as LPWSTR, byval dwOptions as DWORD, byval samDesired as REGSAM, byval lpSecurityAttributes as LPSECURITY_ATTRIBUTES, byval phkResult as PHKEY, byval lpdwDisposition as LPDWORD) as LONG

#ifdef UNICODE
	declare function RegCreateKeyEx alias "RegCreateKeyExW"(byval hKey as HKEY, byval lpSubKey as LPCWSTR, byval Reserved as DWORD, byval lpClass as LPWSTR, byval dwOptions as DWORD, byval samDesired as REGSAM, byval lpSecurityAttributes as LPSECURITY_ATTRIBUTES, byval phkResult as PHKEY, byval lpdwDisposition as LPDWORD) as LONG
#endif

declare function RegDeleteKeyA(byval hKey as HKEY, byval lpSubKey as LPCSTR) as LONG

#ifndef UNICODE
	declare function RegDeleteKey alias "RegDeleteKeyA"(byval hKey as HKEY, byval lpSubKey as LPCSTR) as LONG
#endif

declare function RegDeleteKeyW(byval hKey as HKEY, byval lpSubKey as LPCWSTR) as LONG

#ifdef UNICODE
	declare function RegDeleteKey alias "RegDeleteKeyW"(byval hKey as HKEY, byval lpSubKey as LPCWSTR) as LONG
#endif

declare function RegDeleteKeyExA(byval hKey as HKEY, byval lpSubKey as LPCSTR, byval samDesired as REGSAM, byval Reserved as DWORD) as LONG

#ifndef UNICODE
	declare function RegDeleteKeyEx alias "RegDeleteKeyExA"(byval hKey as HKEY, byval lpSubKey as LPCSTR, byval samDesired as REGSAM, byval Reserved as DWORD) as LONG
#endif

declare function RegDeleteKeyExW(byval hKey as HKEY, byval lpSubKey as LPCWSTR, byval samDesired as REGSAM, byval Reserved as DWORD) as LONG

#ifdef UNICODE
	declare function RegDeleteKeyEx alias "RegDeleteKeyExW"(byval hKey as HKEY, byval lpSubKey as LPCWSTR, byval samDesired as REGSAM, byval Reserved as DWORD) as LONG
#endif

declare function RegDisableReflectionKey(byval hBase as HKEY) as LONG
declare function RegEnableReflectionKey(byval hBase as HKEY) as LONG
declare function RegQueryReflectionKey(byval hBase as HKEY, byval bIsReflectionDisabled as WINBOOL ptr) as LONG
declare function RegDeleteValueA(byval hKey as HKEY, byval lpValueName as LPCSTR) as LONG

#ifndef UNICODE
	declare function RegDeleteValue alias "RegDeleteValueA"(byval hKey as HKEY, byval lpValueName as LPCSTR) as LONG
#endif

declare function RegDeleteValueW(byval hKey as HKEY, byval lpValueName as LPCWSTR) as LONG

#ifdef UNICODE
	declare function RegDeleteValue alias "RegDeleteValueW"(byval hKey as HKEY, byval lpValueName as LPCWSTR) as LONG
#endif

declare function RegEnumKeyA(byval hKey as HKEY, byval dwIndex as DWORD, byval lpName as LPSTR, byval cchName as DWORD) as LONG

#ifndef UNICODE
	declare function RegEnumKey alias "RegEnumKeyA"(byval hKey as HKEY, byval dwIndex as DWORD, byval lpName as LPSTR, byval cchName as DWORD) as LONG
#endif

declare function RegEnumKeyW(byval hKey as HKEY, byval dwIndex as DWORD, byval lpName as LPWSTR, byval cchName as DWORD) as LONG

#ifdef UNICODE
	declare function RegEnumKey alias "RegEnumKeyW"(byval hKey as HKEY, byval dwIndex as DWORD, byval lpName as LPWSTR, byval cchName as DWORD) as LONG
#endif

declare function RegEnumKeyExA(byval hKey as HKEY, byval dwIndex as DWORD, byval lpName as LPSTR, byval lpcchName as LPDWORD, byval lpReserved as LPDWORD, byval lpClass as LPSTR, byval lpcchClass as LPDWORD, byval lpftLastWriteTime as PFILETIME) as LONG

#ifndef UNICODE
	declare function RegEnumKeyEx alias "RegEnumKeyExA"(byval hKey as HKEY, byval dwIndex as DWORD, byval lpName as LPSTR, byval lpcchName as LPDWORD, byval lpReserved as LPDWORD, byval lpClass as LPSTR, byval lpcchClass as LPDWORD, byval lpftLastWriteTime as PFILETIME) as LONG
#endif

declare function RegEnumKeyExW(byval hKey as HKEY, byval dwIndex as DWORD, byval lpName as LPWSTR, byval lpcchName as LPDWORD, byval lpReserved as LPDWORD, byval lpClass as LPWSTR, byval lpcchClass as LPDWORD, byval lpftLastWriteTime as PFILETIME) as LONG

#ifdef UNICODE
	declare function RegEnumKeyEx alias "RegEnumKeyExW"(byval hKey as HKEY, byval dwIndex as DWORD, byval lpName as LPWSTR, byval lpcchName as LPDWORD, byval lpReserved as LPDWORD, byval lpClass as LPWSTR, byval lpcchClass as LPDWORD, byval lpftLastWriteTime as PFILETIME) as LONG
#endif

declare function RegEnumValueA(byval hKey as HKEY, byval dwIndex as DWORD, byval lpValueName as LPSTR, byval lpcchValueName as LPDWORD, byval lpReserved as LPDWORD, byval lpType as LPDWORD, byval lpData as LPBYTE, byval lpcbData as LPDWORD) as LONG

#ifndef UNICODE
	declare function RegEnumValue alias "RegEnumValueA"(byval hKey as HKEY, byval dwIndex as DWORD, byval lpValueName as LPSTR, byval lpcchValueName as LPDWORD, byval lpReserved as LPDWORD, byval lpType as LPDWORD, byval lpData as LPBYTE, byval lpcbData as LPDWORD) as LONG
#endif

declare function RegEnumValueW(byval hKey as HKEY, byval dwIndex as DWORD, byval lpValueName as LPWSTR, byval lpcchValueName as LPDWORD, byval lpReserved as LPDWORD, byval lpType as LPDWORD, byval lpData as LPBYTE, byval lpcbData as LPDWORD) as LONG

#ifdef UNICODE
	declare function RegEnumValue alias "RegEnumValueW"(byval hKey as HKEY, byval dwIndex as DWORD, byval lpValueName as LPWSTR, byval lpcchValueName as LPDWORD, byval lpReserved as LPDWORD, byval lpType as LPDWORD, byval lpData as LPBYTE, byval lpcbData as LPDWORD) as LONG
#endif

declare function RegFlushKey(byval hKey as HKEY) as LONG
declare function RegGetKeySecurity(byval hKey as HKEY, byval SecurityInformation as SECURITY_INFORMATION, byval pSecurityDescriptor as PSECURITY_DESCRIPTOR, byval lpcbSecurityDescriptor as LPDWORD) as LONG
declare function RegLoadKeyA(byval hKey as HKEY, byval lpSubKey as LPCSTR, byval lpFile as LPCSTR) as LONG

#ifndef UNICODE
	declare function RegLoadKey alias "RegLoadKeyA"(byval hKey as HKEY, byval lpSubKey as LPCSTR, byval lpFile as LPCSTR) as LONG
#endif

declare function RegLoadKeyW(byval hKey as HKEY, byval lpSubKey as LPCWSTR, byval lpFile as LPCWSTR) as LONG

#ifdef UNICODE
	declare function RegLoadKey alias "RegLoadKeyW"(byval hKey as HKEY, byval lpSubKey as LPCWSTR, byval lpFile as LPCWSTR) as LONG
#endif

declare function RegNotifyChangeKeyValue(byval hKey as HKEY, byval bWatchSubtree as WINBOOL, byval dwNotifyFilter as DWORD, byval hEvent as HANDLE, byval fAsynchronous as WINBOOL) as LONG
declare function RegOpenKeyA(byval hKey as HKEY, byval lpSubKey as LPCSTR, byval phkResult as PHKEY) as LONG

#ifndef UNICODE
	declare function RegOpenKey alias "RegOpenKeyA"(byval hKey as HKEY, byval lpSubKey as LPCSTR, byval phkResult as PHKEY) as LONG
#endif

declare function RegOpenKeyW(byval hKey as HKEY, byval lpSubKey as LPCWSTR, byval phkResult as PHKEY) as LONG

#ifdef UNICODE
	declare function RegOpenKey alias "RegOpenKeyW"(byval hKey as HKEY, byval lpSubKey as LPCWSTR, byval phkResult as PHKEY) as LONG
#endif

declare function RegOpenKeyExA(byval hKey as HKEY, byval lpSubKey as LPCSTR, byval ulOptions as DWORD, byval samDesired as REGSAM, byval phkResult as PHKEY) as LONG

#ifndef UNICODE
	declare function RegOpenKeyEx alias "RegOpenKeyExA"(byval hKey as HKEY, byval lpSubKey as LPCSTR, byval ulOptions as DWORD, byval samDesired as REGSAM, byval phkResult as PHKEY) as LONG
#endif

declare function RegOpenKeyExW(byval hKey as HKEY, byval lpSubKey as LPCWSTR, byval ulOptions as DWORD, byval samDesired as REGSAM, byval phkResult as PHKEY) as LONG

#ifdef UNICODE
	declare function RegOpenKeyEx alias "RegOpenKeyExW"(byval hKey as HKEY, byval lpSubKey as LPCWSTR, byval ulOptions as DWORD, byval samDesired as REGSAM, byval phkResult as PHKEY) as LONG
#endif

declare function RegQueryInfoKeyA(byval hKey as HKEY, byval lpClass as LPSTR, byval lpcchClass as LPDWORD, byval lpReserved as LPDWORD, byval lpcSubKeys as LPDWORD, byval lpcbMaxSubKeyLen as LPDWORD, byval lpcbMaxClassLen as LPDWORD, byval lpcValues as LPDWORD, byval lpcbMaxValueNameLen as LPDWORD, byval lpcbMaxValueLen as LPDWORD, byval lpcbSecurityDescriptor as LPDWORD, byval lpftLastWriteTime as PFILETIME) as LONG

#ifndef UNICODE
	declare function RegQueryInfoKey alias "RegQueryInfoKeyA"(byval hKey as HKEY, byval lpClass as LPSTR, byval lpcchClass as LPDWORD, byval lpReserved as LPDWORD, byval lpcSubKeys as LPDWORD, byval lpcbMaxSubKeyLen as LPDWORD, byval lpcbMaxClassLen as LPDWORD, byval lpcValues as LPDWORD, byval lpcbMaxValueNameLen as LPDWORD, byval lpcbMaxValueLen as LPDWORD, byval lpcbSecurityDescriptor as LPDWORD, byval lpftLastWriteTime as PFILETIME) as LONG
#endif

declare function RegQueryInfoKeyW(byval hKey as HKEY, byval lpClass as LPWSTR, byval lpcchClass as LPDWORD, byval lpReserved as LPDWORD, byval lpcSubKeys as LPDWORD, byval lpcbMaxSubKeyLen as LPDWORD, byval lpcbMaxClassLen as LPDWORD, byval lpcValues as LPDWORD, byval lpcbMaxValueNameLen as LPDWORD, byval lpcbMaxValueLen as LPDWORD, byval lpcbSecurityDescriptor as LPDWORD, byval lpftLastWriteTime as PFILETIME) as LONG

#ifdef UNICODE
	declare function RegQueryInfoKey alias "RegQueryInfoKeyW"(byval hKey as HKEY, byval lpClass as LPWSTR, byval lpcchClass as LPDWORD, byval lpReserved as LPDWORD, byval lpcSubKeys as LPDWORD, byval lpcbMaxSubKeyLen as LPDWORD, byval lpcbMaxClassLen as LPDWORD, byval lpcValues as LPDWORD, byval lpcbMaxValueNameLen as LPDWORD, byval lpcbMaxValueLen as LPDWORD, byval lpcbSecurityDescriptor as LPDWORD, byval lpftLastWriteTime as PFILETIME) as LONG
#endif

declare function RegQueryValueA(byval hKey as HKEY, byval lpSubKey as LPCSTR, byval lpData as LPSTR, byval lpcbData as PLONG) as LONG

#ifndef UNICODE
	declare function RegQueryValue alias "RegQueryValueA"(byval hKey as HKEY, byval lpSubKey as LPCSTR, byval lpData as LPSTR, byval lpcbData as PLONG) as LONG
#endif

declare function RegQueryValueW(byval hKey as HKEY, byval lpSubKey as LPCWSTR, byval lpData as LPWSTR, byval lpcbData as PLONG) as LONG

#ifdef UNICODE
	declare function RegQueryValue alias "RegQueryValueW"(byval hKey as HKEY, byval lpSubKey as LPCWSTR, byval lpData as LPWSTR, byval lpcbData as PLONG) as LONG
#endif

declare function RegQueryMultipleValuesA(byval hKey as HKEY, byval val_list as PVALENTA, byval num_vals as DWORD, byval lpValueBuf as LPSTR, byval ldwTotsize as LPDWORD) as LONG

#ifndef UNICODE
	declare function RegQueryMultipleValues alias "RegQueryMultipleValuesA"(byval hKey as HKEY, byval val_list as PVALENTA, byval num_vals as DWORD, byval lpValueBuf as LPSTR, byval ldwTotsize as LPDWORD) as LONG
#endif

declare function RegQueryMultipleValuesW(byval hKey as HKEY, byval val_list as PVALENTW, byval num_vals as DWORD, byval lpValueBuf as LPWSTR, byval ldwTotsize as LPDWORD) as LONG

#ifdef UNICODE
	declare function RegQueryMultipleValues alias "RegQueryMultipleValuesW"(byval hKey as HKEY, byval val_list as PVALENTW, byval num_vals as DWORD, byval lpValueBuf as LPWSTR, byval ldwTotsize as LPDWORD) as LONG
#endif

declare function RegQueryValueExA(byval hKey as HKEY, byval lpValueName as LPCSTR, byval lpReserved as LPDWORD, byval lpType as LPDWORD, byval lpData as LPBYTE, byval lpcbData as LPDWORD) as LONG

#ifndef UNICODE
	declare function RegQueryValueEx alias "RegQueryValueExA"(byval hKey as HKEY, byval lpValueName as LPCSTR, byval lpReserved as LPDWORD, byval lpType as LPDWORD, byval lpData as LPBYTE, byval lpcbData as LPDWORD) as LONG
#endif

declare function RegQueryValueExW(byval hKey as HKEY, byval lpValueName as LPCWSTR, byval lpReserved as LPDWORD, byval lpType as LPDWORD, byval lpData as LPBYTE, byval lpcbData as LPDWORD) as LONG

#ifdef UNICODE
	declare function RegQueryValueEx alias "RegQueryValueExW"(byval hKey as HKEY, byval lpValueName as LPCWSTR, byval lpReserved as LPDWORD, byval lpType as LPDWORD, byval lpData as LPBYTE, byval lpcbData as LPDWORD) as LONG
#endif

declare function RegReplaceKeyA(byval hKey as HKEY, byval lpSubKey as LPCSTR, byval lpNewFile as LPCSTR, byval lpOldFile as LPCSTR) as LONG

#ifndef UNICODE
	declare function RegReplaceKey alias "RegReplaceKeyA"(byval hKey as HKEY, byval lpSubKey as LPCSTR, byval lpNewFile as LPCSTR, byval lpOldFile as LPCSTR) as LONG
#endif

declare function RegReplaceKeyW(byval hKey as HKEY, byval lpSubKey as LPCWSTR, byval lpNewFile as LPCWSTR, byval lpOldFile as LPCWSTR) as LONG

#ifdef UNICODE
	declare function RegReplaceKey alias "RegReplaceKeyW"(byval hKey as HKEY, byval lpSubKey as LPCWSTR, byval lpNewFile as LPCWSTR, byval lpOldFile as LPCWSTR) as LONG
#endif

declare function RegRestoreKeyA(byval hKey as HKEY, byval lpFile as LPCSTR, byval dwFlags as DWORD) as LONG

#ifndef UNICODE
	declare function RegRestoreKey alias "RegRestoreKeyA"(byval hKey as HKEY, byval lpFile as LPCSTR, byval dwFlags as DWORD) as LONG
#endif

declare function RegRestoreKeyW(byval hKey as HKEY, byval lpFile as LPCWSTR, byval dwFlags as DWORD) as LONG

#ifdef UNICODE
	declare function RegRestoreKey alias "RegRestoreKeyW"(byval hKey as HKEY, byval lpFile as LPCWSTR, byval dwFlags as DWORD) as LONG
#endif

declare function RegSaveKeyA(byval hKey as HKEY, byval lpFile as LPCSTR, byval lpSecurityAttributes as LPSECURITY_ATTRIBUTES) as LONG

#ifndef UNICODE
	declare function RegSaveKey alias "RegSaveKeyA"(byval hKey as HKEY, byval lpFile as LPCSTR, byval lpSecurityAttributes as LPSECURITY_ATTRIBUTES) as LONG
#endif

declare function RegSaveKeyW(byval hKey as HKEY, byval lpFile as LPCWSTR, byval lpSecurityAttributes as LPSECURITY_ATTRIBUTES) as LONG

#ifdef UNICODE
	declare function RegSaveKey alias "RegSaveKeyW"(byval hKey as HKEY, byval lpFile as LPCWSTR, byval lpSecurityAttributes as LPSECURITY_ATTRIBUTES) as LONG
#endif

declare function RegSetKeySecurity(byval hKey as HKEY, byval SecurityInformation as SECURITY_INFORMATION, byval pSecurityDescriptor as PSECURITY_DESCRIPTOR) as LONG
declare function RegSetValueA(byval hKey as HKEY, byval lpSubKey as LPCSTR, byval dwType as DWORD, byval lpData as LPCSTR, byval cbData as DWORD) as LONG

#ifndef UNICODE
	declare function RegSetValue alias "RegSetValueA"(byval hKey as HKEY, byval lpSubKey as LPCSTR, byval dwType as DWORD, byval lpData as LPCSTR, byval cbData as DWORD) as LONG
#endif

declare function RegSetValueW(byval hKey as HKEY, byval lpSubKey as LPCWSTR, byval dwType as DWORD, byval lpData as LPCWSTR, byval cbData as DWORD) as LONG

#ifdef UNICODE
	declare function RegSetValue alias "RegSetValueW"(byval hKey as HKEY, byval lpSubKey as LPCWSTR, byval dwType as DWORD, byval lpData as LPCWSTR, byval cbData as DWORD) as LONG
#endif

declare function RegSetValueExA(byval hKey as HKEY, byval lpValueName as LPCSTR, byval Reserved as DWORD, byval dwType as DWORD, byval lpData as const UBYTE ptr, byval cbData as DWORD) as LONG

#ifndef UNICODE
	declare function RegSetValueEx alias "RegSetValueExA"(byval hKey as HKEY, byval lpValueName as LPCSTR, byval Reserved as DWORD, byval dwType as DWORD, byval lpData as const UBYTE ptr, byval cbData as DWORD) as LONG
#endif

declare function RegSetValueExW(byval hKey as HKEY, byval lpValueName as LPCWSTR, byval Reserved as DWORD, byval dwType as DWORD, byval lpData as const UBYTE ptr, byval cbData as DWORD) as LONG

#ifdef UNICODE
	declare function RegSetValueEx alias "RegSetValueExW"(byval hKey as HKEY, byval lpValueName as LPCWSTR, byval Reserved as DWORD, byval dwType as DWORD, byval lpData as const UBYTE ptr, byval cbData as DWORD) as LONG
#endif

declare function RegUnLoadKeyA(byval hKey as HKEY, byval lpSubKey as LPCSTR) as LONG

#ifndef UNICODE
	declare function RegUnLoadKey alias "RegUnLoadKeyA"(byval hKey as HKEY, byval lpSubKey as LPCSTR) as LONG
#endif

declare function RegUnLoadKeyW(byval hKey as HKEY, byval lpSubKey as LPCWSTR) as LONG

#ifdef UNICODE
	declare function RegUnLoadKey alias "RegUnLoadKeyW"(byval hKey as HKEY, byval lpSubKey as LPCWSTR) as LONG
#endif

declare function RegGetValueA(byval hkey as HKEY, byval lpSubKey as LPCSTR, byval lpValue as LPCSTR, byval dwFlags as DWORD, byval pdwType as LPDWORD, byval pvData as PVOID, byval pcbData as LPDWORD) as LONG

#ifndef UNICODE
	declare function RegGetValue alias "RegGetValueA"(byval hkey as HKEY, byval lpSubKey as LPCSTR, byval lpValue as LPCSTR, byval dwFlags as DWORD, byval pdwType as LPDWORD, byval pvData as PVOID, byval pcbData as LPDWORD) as LONG
#endif

declare function RegGetValueW(byval hkey as HKEY, byval lpSubKey as LPCWSTR, byval lpValue as LPCWSTR, byval dwFlags as DWORD, byval pdwType as LPDWORD, byval pvData as PVOID, byval pcbData as LPDWORD) as LONG

#ifdef UNICODE
	declare function RegGetValue alias "RegGetValueW"(byval hkey as HKEY, byval lpSubKey as LPCWSTR, byval lpValue as LPCWSTR, byval dwFlags as DWORD, byval pdwType as LPDWORD, byval pvData as PVOID, byval pcbData as LPDWORD) as LONG
#endif

declare function InitiateSystemShutdownA(byval lpMachineName as LPSTR, byval lpMessage as LPSTR, byval dwTimeout as DWORD, byval bForceAppsClosed as WINBOOL, byval bRebootAfterShutdown as WINBOOL) as WINBOOL

#ifndef UNICODE
	declare function InitiateSystemShutdown alias "InitiateSystemShutdownA"(byval lpMachineName as LPSTR, byval lpMessage as LPSTR, byval dwTimeout as DWORD, byval bForceAppsClosed as WINBOOL, byval bRebootAfterShutdown as WINBOOL) as WINBOOL
#endif

declare function InitiateSystemShutdownW(byval lpMachineName as LPWSTR, byval lpMessage as LPWSTR, byval dwTimeout as DWORD, byval bForceAppsClosed as WINBOOL, byval bRebootAfterShutdown as WINBOOL) as WINBOOL

#ifdef UNICODE
	declare function InitiateSystemShutdown alias "InitiateSystemShutdownW"(byval lpMachineName as LPWSTR, byval lpMessage as LPWSTR, byval dwTimeout as DWORD, byval bForceAppsClosed as WINBOOL, byval bRebootAfterShutdown as WINBOOL) as WINBOOL
#endif

declare function AbortSystemShutdownA(byval lpMachineName as LPSTR) as WINBOOL

#ifndef UNICODE
	declare function AbortSystemShutdown alias "AbortSystemShutdownA"(byval lpMachineName as LPSTR) as WINBOOL
#endif

declare function AbortSystemShutdownW(byval lpMachineName as LPWSTR) as WINBOOL

#ifdef UNICODE
	declare function AbortSystemShutdown alias "AbortSystemShutdownW"(byval lpMachineName as LPWSTR) as WINBOOL
#endif

const REASON_SWINSTALL = SHTDN_REASON_MAJOR_SOFTWARE or SHTDN_REASON_MINOR_INSTALLATION
const REASON_HWINSTALL = SHTDN_REASON_MAJOR_HARDWARE or SHTDN_REASON_MINOR_INSTALLATION
const REASON_SERVICEHANG = SHTDN_REASON_MAJOR_SOFTWARE or SHTDN_REASON_MINOR_HUNG
const REASON_UNSTABLE = SHTDN_REASON_MAJOR_SYSTEM or SHTDN_REASON_MINOR_UNSTABLE
const REASON_SWHWRECONF = SHTDN_REASON_MAJOR_SOFTWARE or SHTDN_REASON_MINOR_RECONFIG
const REASON_OTHER = SHTDN_REASON_MAJOR_OTHER or SHTDN_REASON_MINOR_OTHER
const REASON_UNKNOWN = SHTDN_REASON_UNKNOWN
const REASON_LEGACY_API = SHTDN_REASON_LEGACY_API
const REASON_PLANNED_FLAG = SHTDN_REASON_FLAG_PLANNED
const MAX_SHUTDOWN_TIMEOUT = (((10 * 365) * 24) * 60) * 60
declare function InitiateSystemShutdownExA(byval lpMachineName as LPSTR, byval lpMessage as LPSTR, byval dwTimeout as DWORD, byval bForceAppsClosed as WINBOOL, byval bRebootAfterShutdown as WINBOOL, byval dwReason as DWORD) as WINBOOL

#ifndef UNICODE
	declare function InitiateSystemShutdownEx alias "InitiateSystemShutdownExA"(byval lpMachineName as LPSTR, byval lpMessage as LPSTR, byval dwTimeout as DWORD, byval bForceAppsClosed as WINBOOL, byval bRebootAfterShutdown as WINBOOL, byval dwReason as DWORD) as WINBOOL
#endif

declare function InitiateSystemShutdownExW(byval lpMachineName as LPWSTR, byval lpMessage as LPWSTR, byval dwTimeout as DWORD, byval bForceAppsClosed as WINBOOL, byval bRebootAfterShutdown as WINBOOL, byval dwReason as DWORD) as WINBOOL

#ifdef UNICODE
	declare function InitiateSystemShutdownEx alias "InitiateSystemShutdownExW"(byval lpMachineName as LPWSTR, byval lpMessage as LPWSTR, byval dwTimeout as DWORD, byval bForceAppsClosed as WINBOOL, byval bRebootAfterShutdown as WINBOOL, byval dwReason as DWORD) as WINBOOL
#endif

declare function RegSaveKeyExA(byval hKey as HKEY, byval lpFile as LPCSTR, byval lpSecurityAttributes as LPSECURITY_ATTRIBUTES, byval Flags as DWORD) as LONG

#ifndef UNICODE
	declare function RegSaveKeyEx alias "RegSaveKeyExA"(byval hKey as HKEY, byval lpFile as LPCSTR, byval lpSecurityAttributes as LPSECURITY_ATTRIBUTES, byval Flags as DWORD) as LONG
#endif

declare function RegSaveKeyExW(byval hKey as HKEY, byval lpFile as LPCWSTR, byval lpSecurityAttributes as LPSECURITY_ATTRIBUTES, byval Flags as DWORD) as LONG

#ifdef UNICODE
	declare function RegSaveKeyEx alias "RegSaveKeyExW"(byval hKey as HKEY, byval lpFile as LPCWSTR, byval lpSecurityAttributes as LPSECURITY_ATTRIBUTES, byval Flags as DWORD) as LONG
#endif

declare function Wow64Win32ApiEntry(byval dwFuncNumber as DWORD, byval dwFlag as DWORD, byval dwRes as DWORD) as LONG

#if _WIN32_WINNT >= &h0600
	declare function RegCopyTreeA(byval hKeySrc as HKEY, byval lpSubKey as LPCSTR, byval hKeyDest as HKEY) as LONG
#endif

#if (not defined(UNICODE)) and (_WIN32_WINNT >= &h0600)
	declare function RegCopyTree alias "RegCopyTreeA"(byval hKeySrc as HKEY, byval lpSubKey as LPCSTR, byval hKeyDest as HKEY) as LONG
#endif

#if _WIN32_WINNT >= &h0600
	declare function RegCopyTreeW(byval hKeySrc as HKEY, byval lpSubKey as LPCWSTR, byval hKeyDest as HKEY) as LONG
#endif

#if defined(UNICODE) and (_WIN32_WINNT >= &h0600)
	declare function RegCopyTree alias "RegCopyTreeW"(byval hKeySrc as HKEY, byval lpSubKey as LPCWSTR, byval hKeyDest as HKEY) as LONG
#endif

#if _WIN32_WINNT >= &h0600
	declare function RegCreateKeyTransactedA(byval hKey as HKEY, byval lpSubKey as LPCSTR, byval Reserved as DWORD, byval lpClass as LPSTR, byval dwOptions as DWORD, byval samDesired as REGSAM, byval lpSecurityAttributes as const LPSECURITY_ATTRIBUTES, byval phkResult as PHKEY, byval lpdwDisposition as LPDWORD, byval hTransaction as HANDLE, byval pExtendedParemeter as PVOID) as LONG
#endif

#if (not defined(UNICODE)) and (_WIN32_WINNT >= &h0600)
	declare function RegCreateKeyTransacted alias "RegCreateKeyTransactedA"(byval hKey as HKEY, byval lpSubKey as LPCSTR, byval Reserved as DWORD, byval lpClass as LPSTR, byval dwOptions as DWORD, byval samDesired as REGSAM, byval lpSecurityAttributes as const LPSECURITY_ATTRIBUTES, byval phkResult as PHKEY, byval lpdwDisposition as LPDWORD, byval hTransaction as HANDLE, byval pExtendedParemeter as PVOID) as LONG
#endif

#if _WIN32_WINNT >= &h0600
	declare function RegCreateKeyTransactedW(byval hKey as HKEY, byval lpSubKey as LPCWSTR, byval Reserved as DWORD, byval lpClass as LPWSTR, byval dwOptions as DWORD, byval samDesired as REGSAM, byval lpSecurityAttributes as const LPSECURITY_ATTRIBUTES, byval phkResult as PHKEY, byval lpdwDisposition as LPDWORD, byval hTransaction as HANDLE, byval pExtendedParemeter as PVOID) as LONG
#endif

#if defined(UNICODE) and (_WIN32_WINNT >= &h0600)
	declare function RegCreateKeyTransacted alias "RegCreateKeyTransactedW"(byval hKey as HKEY, byval lpSubKey as LPCWSTR, byval Reserved as DWORD, byval lpClass as LPWSTR, byval dwOptions as DWORD, byval samDesired as REGSAM, byval lpSecurityAttributes as const LPSECURITY_ATTRIBUTES, byval phkResult as PHKEY, byval lpdwDisposition as LPDWORD, byval hTransaction as HANDLE, byval pExtendedParemeter as PVOID) as LONG
#endif

#if _WIN32_WINNT >= &h0600
	declare function RegDeleteKeyTransactedA(byval hKey as HKEY, byval lpSubKey as LPCSTR, byval samDesired as REGSAM, byval Reserved as DWORD, byval hTransaction as HANDLE, byval pExtendedParameter as PVOID) as LONG
#endif

#if (not defined(UNICODE)) and (_WIN32_WINNT >= &h0600)
	declare function RegDeleteKeyTransacted alias "RegDeleteKeyTransactedA"(byval hKey as HKEY, byval lpSubKey as LPCSTR, byval samDesired as REGSAM, byval Reserved as DWORD, byval hTransaction as HANDLE, byval pExtendedParameter as PVOID) as LONG
#endif

#if _WIN32_WINNT >= &h0600
	declare function RegDeleteKeyTransactedW(byval hKey as HKEY, byval lpSubKey as LPCWSTR, byval samDesired as REGSAM, byval Reserved as DWORD, byval hTransaction as HANDLE, byval pExtendedParameter as PVOID) as LONG
#endif

#if defined(UNICODE) and (_WIN32_WINNT >= &h0600)
	declare function RegDeleteKeyTransacted alias "RegDeleteKeyTransactedW"(byval hKey as HKEY, byval lpSubKey as LPCWSTR, byval samDesired as REGSAM, byval Reserved as DWORD, byval hTransaction as HANDLE, byval pExtendedParameter as PVOID) as LONG
#endif

#if _WIN32_WINNT >= &h0600
	declare function RegDeleteKeyValueA(byval hKey as HKEY, byval lpSubKey as LPCSTR, byval lpValueName as LPCSTR) as LONG
#endif

#if (not defined(UNICODE)) and (_WIN32_WINNT >= &h0600)
	declare function RegDeleteKeyValue alias "RegDeleteKeyValueA"(byval hKey as HKEY, byval lpSubKey as LPCSTR, byval lpValueName as LPCSTR) as LONG
#endif

#if _WIN32_WINNT >= &h0600
	declare function RegDeleteKeyValueW(byval hKey as HKEY, byval lpSubKey as LPCWSTR, byval lpValueName as LPCWSTR) as LONG
#endif

#if defined(UNICODE) and (_WIN32_WINNT >= &h0600)
	declare function RegDeleteKeyValue alias "RegDeleteKeyValueW"(byval hKey as HKEY, byval lpSubKey as LPCWSTR, byval lpValueName as LPCWSTR) as LONG
#endif

#if _WIN32_WINNT >= &h0600
	declare function RegDeleteTreeA(byval hKey as HKEY, byval lpSubKey as LPCSTR) as LONG
#endif

#if (not defined(UNICODE)) and (_WIN32_WINNT >= &h0600)
	declare function RegDeleteTree alias "RegDeleteTreeA"(byval hKey as HKEY, byval lpSubKey as LPCSTR) as LONG
#endif

#if _WIN32_WINNT >= &h0600
	declare function RegDeleteTreeW(byval hKey as HKEY, byval lpSubKey as LPCWSTR) as LONG
#endif

#if defined(UNICODE) and (_WIN32_WINNT >= &h0600)
	declare function RegDeleteTree alias "RegDeleteTreeW"(byval hKey as HKEY, byval lpSubKey as LPCWSTR) as LONG
#endif

#if _WIN32_WINNT >= &h0600
	declare function RegDisablePredefinedCacheEx() as LONG
	declare function RegLoadAppKeyA(byval lpFile as LPCSTR, byval phkResult as PHKEY, byval samDesired as REGSAM, byval dwOptions as DWORD, byval Reserved as DWORD) as LONG
	declare function RegLoadAppKeyW(byval lpFile as LPCWSTR, byval phkResult as PHKEY, byval samDesired as REGSAM, byval dwOptions as DWORD, byval Reserved as DWORD) as LONG
#endif

#if defined(UNICODE) and (_WIN32_WINNT >= &h0600)
	declare function RegLoadAppKey alias "RegLoadAppKeyW"(byval lpFile as LPCWSTR, byval phkResult as PHKEY, byval samDesired as REGSAM, byval dwOptions as DWORD, byval Reserved as DWORD) as LONG
#elseif (not defined(UNICODE)) and (_WIN32_WINNT >= &h0600)
	declare function RegLoadAppKey alias "RegLoadAppKeyA"(byval lpFile as LPCSTR, byval phkResult as PHKEY, byval samDesired as REGSAM, byval dwOptions as DWORD, byval Reserved as DWORD) as LONG
#endif

#if _WIN32_WINNT >= &h0600
	declare function RegLoadMUIStringA(byval hKey as HKEY, byval pszValue as LPCSTR, byval pszOutBuf as LPSTR, byval cbOutBuf as DWORD, byval pcbData as LPDWORD, byval Flags as DWORD, byval pszDirectory as LPCSTR) as LONG
	declare function RegLoadMUIStringW(byval hKey as HKEY, byval pszValue as LPCWSTR, byval pszOutBuf as LPWSTR, byval cbOutBuf as DWORD, byval pcbData as LPDWORD, byval Flags as DWORD, byval pszDirectory as LPCWSTR) as LONG
#endif

#if defined(UNICODE) and (_WIN32_WINNT >= &h0600)
	declare function RegLoadMUIString alias "RegLoadMUIStringW"(byval hKey as HKEY, byval pszValue as LPCWSTR, byval pszOutBuf as LPWSTR, byval cbOutBuf as DWORD, byval pcbData as LPDWORD, byval Flags as DWORD, byval pszDirectory as LPCWSTR) as LONG
#elseif (not defined(UNICODE)) and (_WIN32_WINNT >= &h0600)
	declare function RegLoadMUIString alias "RegLoadMUIStringA"(byval hKey as HKEY, byval pszValue as LPCSTR, byval pszOutBuf as LPSTR, byval cbOutBuf as DWORD, byval pcbData as LPDWORD, byval Flags as DWORD, byval pszDirectory as LPCSTR) as LONG
#endif

#if _WIN32_WINNT >= &h0600
	declare function RegOpenKeyTransactedA(byval hKey as HKEY, byval lpSubKey as LPCSTR, byval ulOptions as DWORD, byval samDesired as REGSAM, byval phkResult as PHKEY, byval hTransaction as HANDLE, byval pExtendedParameter as PVOID) as LONG
	declare function RegOpenKeyTransactedW(byval hKey as HKEY, byval lpSubKey as LPCWSTR, byval ulOptions as DWORD, byval samDesired as REGSAM, byval phkResult as PHKEY, byval hTransaction as HANDLE, byval pExtendedParameter as PVOID) as LONG
#endif

#if defined(UNICODE) and (_WIN32_WINNT >= &h0600)
	declare function RegOpenKeyTransacted alias "RegOpenKeyTransactedW"(byval hKey as HKEY, byval lpSubKey as LPCWSTR, byval ulOptions as DWORD, byval samDesired as REGSAM, byval phkResult as PHKEY, byval hTransaction as HANDLE, byval pExtendedParameter as PVOID) as LONG
#elseif (not defined(UNICODE)) and (_WIN32_WINNT >= &h0600)
	declare function RegOpenKeyTransacted alias "RegOpenKeyTransactedA"(byval hKey as HKEY, byval lpSubKey as LPCSTR, byval ulOptions as DWORD, byval samDesired as REGSAM, byval phkResult as PHKEY, byval hTransaction as HANDLE, byval pExtendedParameter as PVOID) as LONG
#endif

#if _WIN32_WINNT >= &h0600
	declare function RegSetKeyValueA(byval hKey as HKEY, byval lpSubKey as LPCSTR, byval lpValueName as LPCSTR, byval dwType as DWORD, byval lpData as LPCVOID, byval cbData as DWORD) as LONG
	declare function RegSetKeyValueW(byval hKey as HKEY, byval lpSubKey as LPCSTR, byval lpValueName as LPCSTR, byval dwType as DWORD, byval lpData as LPCVOID, byval cbData as DWORD) as LONG
#endif

#if defined(UNICODE) and (_WIN32_WINNT >= &h0600)
	declare function RegSetKeyValue alias "RegSetKeyValueW"(byval hKey as HKEY, byval lpSubKey as LPCSTR, byval lpValueName as LPCSTR, byval dwType as DWORD, byval lpData as LPCVOID, byval cbData as DWORD) as LONG
#elseif (not defined(UNICODE)) and (_WIN32_WINNT >= &h0600)
	declare function RegSetKeyValue alias "RegSetKeyValueA"(byval hKey as HKEY, byval lpSubKey as LPCSTR, byval lpValueName as LPCSTR, byval dwType as DWORD, byval lpData as LPCVOID, byval cbData as DWORD) as LONG
#endif

#if _WIN32_WINNT >= &h0600
	const SHUTDOWN_FORCE_OTHERS = &h00000001
	const SHUTDOWN_FORCE_SELF = &h00000002
	const SHUTDOWN_RESTART = &h00000004
	const SHUTDOWN_POWEROFF = &h00000008
	const SHUTDOWN_NOREBOOT = &h00000010
	const SHUTDOWN_GRACE_OVERRIDE = &h00000020
	const SHUTDOWN_INSTALL_UPDATES = &h00000040
	const SHUTDOWN_RESTARTAPPS = &h00000080
	const SHUTDOWN_HYBRID = &h00000200
	declare function InitiateShutdownA(byval lpMachineName as LPSTR, byval lpMessage as LPSTR, byval dwGracePeriod as DWORD, byval dwShutdownFlags as DWORD, byval dwReason as DWORD) as DWORD
	declare function InitiateShutdownW(byval lpMachineName as LPWSTR, byval lpMessage as LPWSTR, byval dwGracePeriod as DWORD, byval dwShutdownFlags as DWORD, byval dwReason as DWORD) as DWORD
#endif

#if defined(UNICODE) and (_WIN32_WINNT >= &h0600)
	declare function InitiateShutdown alias "InitiateShutdownW"(byval lpMachineName as LPWSTR, byval lpMessage as LPWSTR, byval dwGracePeriod as DWORD, byval dwShutdownFlags as DWORD, byval dwReason as DWORD) as DWORD
#elseif (not defined(UNICODE)) and (_WIN32_WINNT >= &h0600)
	declare function InitiateShutdown alias "InitiateShutdownA"(byval lpMachineName as LPSTR, byval lpMessage as LPSTR, byval dwGracePeriod as DWORD, byval dwShutdownFlags as DWORD, byval dwReason as DWORD) as DWORD
#endif

end extern
