''
''
'' userenv -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_userenv_bi__
#define __win_userenv_bi__

#inclib "userenv"

#define PI_NOUI (1)
#define PI_APPLYPOLICY (2)

#ifndef UNICODE
type PROFILEINFOA
	dwSize as DWORD
	dwFlags as DWORD
	lpUserName as LPSTR
	lpProfilePath as LPSTR
	lpDefaultPath as LPSTR
	lpServerName as LPSTR
	lpPolicyPath as LPSTR
	hProfile as HANDLE
end type

type LPPROFILEINFOA as PROFILEINFOA ptr

#else
type PROFILEINFOW
	dwSize as DWORD
	dwFlags as DWORD
	lpUserName as LPWSTR
	lpProfilePath as LPWSTR
	lpDefaultPath as LPWSTR
	lpServerName as LPWSTR
	lpPolicyPath as LPWSTR
	hProfile as HANDLE
end type

type LPPROFILEINFOW as PROFILEINFOW ptr
#endif

declare function UnloadUserProfile alias "UnloadUserProfile" (byval as HANDLE, byval as HANDLE) as BOOL
declare function CreateEnvironmentBlock alias "CreateEnvironmentBlock" (byval as LPVOID ptr, byval as HANDLE, byval as BOOL) as BOOL
declare function DestroyEnvironmentBlock alias "DestroyEnvironmentBlock" (byval as LPVOID) as BOOL

#ifdef UNICODE
declare function GetUserProfileDirectory alias "GetUserProfileDirectoryW" (byval as HANDLE, byval as LPWSTR, byval as LPDWORD) as BOOL
declare function GetProfilesDirectory alias "GetProfilesDirectoryW" (byval as LPWSTR, byval as LPDWORD) as BOOL
declare function LoadUserProfile alias "LoadUserProfileW" (byval as HANDLE, byval as LPPROFILEINFOW) as BOOL

type PROFILEINFO as PROFILEINFOW
type LPPROFILEINFO as LPPROFILEINFOW

#else
declare function LoadUserProfile alias "LoadUserProfileA" (byval as HANDLE, byval as LPPROFILEINFOA) as BOOL
declare function GetProfilesDirectory alias "GetProfilesDirectoryA" (byval as LPSTR, byval as LPDWORD) as BOOL
declare function GetUserProfileDirectory alias "GetUserProfileDirectoryA" (byval as HANDLE, byval as LPSTR, byval as LPDWORD) as BOOL

type PROFILEINFO as PROFILEINFOA
type LPPROFILEINFO as LPPROFILEINFOA
#endif

#endif
