#pragma once

#include once "_mingw_unicode.bi"

#define _INC_PROFINFO

type _PROFILEINFOA
	dwSize as DWORD
	dwFlags as DWORD
	lpUserName as LPSTR
	lpProfilePath as LPSTR
	lpDefaultPath as LPSTR
	lpServerName as LPSTR
	lpPolicyPath as LPSTR
	hProfile as HANDLE
end type

type PROFILEINFOA as _PROFILEINFOA
type LPPROFILEINFOA as _PROFILEINFOA ptr

type _PROFILEINFOW
	dwSize as DWORD
	dwFlags as DWORD
	lpUserName as LPWSTR
	lpProfilePath as LPWSTR
	lpDefaultPath as LPWSTR
	lpServerName as LPWSTR
	lpPolicyPath as LPWSTR
	hProfile as HANDLE
end type

type PROFILEINFOW as _PROFILEINFOW
type LPPROFILEINFOW as _PROFILEINFOW ptr

#ifdef UNICODE
	type PROFILEINFO as PROFILEINFOW
	type LPPROFILEINFO as LPPROFILEINFOW
#else
	type PROFILEINFO as PROFILEINFOA
	type LPPROFILEINFO as LPPROFILEINFOA
#endif

#define MIDL_STRING
