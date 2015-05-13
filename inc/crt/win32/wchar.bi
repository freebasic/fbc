''
''
'' wchar -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __crt_win32_wchar_bi__
#define __crt_win32_wchar_bi__

#include once "crt/win32/ctype.bi"
#include once "crt/long.bi"
#include once "crt/stdint.bi"

#ifndef WEOF
#define	WEOF cast(wchar_t,&hFFFF)
#endif

type mbstate_t as long
type _Wint_t as wchar_t

#ifndef _fsize_t
type _fsize_t as culong
#endif

type _wfinddata_t
	attrib as ulong
	time_create as time_t
	time_access as time_t
	time_write as time_t
	size as _fsize_t
	name(0 to (260)-1) as wchar_t
end type

type _wfinddatai64_t
	attrib as ulong
	time_create as time_t
	time_access as time_t
	time_write as time_t
	size as longint
	name(0 to (260)-1) as wchar_t
end type

#ifndef stat
type _stat
	st_dev as _dev_t
	st_ino as _ino_t
	st_mode as _mode_t
	st_nlink as short
	st_uid as short
	st_gid as short
	st_rdev as _dev_t
	st_size as _off_t
	st_atime as time_t
	st_mtime as time_t
	st_ctime as time_t
end type

type stat as _stat

type _stati64
	st_dev as _dev_t
	st_ino as _ino_t
	st_mode as ushort
	st_nlink as short
	st_uid as short
	st_gid as short
	st_rdev as _dev_t
	st_size as longint
	st_atime as time_t
	st_mtime as time_t
	st_ctime as time_t
end type
#endif

extern "c"
declare function _waccess (byval as wchar_t ptr, byval as long) as long
declare function _wchmod (byval as wchar_t ptr, byval as long) as long
declare function _wcreat (byval as wchar_t ptr, byval as long) as long
declare function _wfindfirst (byval as wchar_t ptr, byval as _wfinddata_t ptr) as intptr_t
declare function _wfindnext (byval as intptr_t, byval as _wfinddata_t ptr) as long
declare function _wunlink (byval as wchar_t ptr) as long
declare function _wopen (byval as wchar_t ptr, byval as long, ...) as long
declare function _wsopen (byval as wchar_t ptr, byval as long, byval as long, ...) as long
declare function _wmktemp (byval as wchar_t ptr) as wchar_t ptr
declare function _wfindfirsti64 (byval as wchar_t ptr, byval as _wfinddatai64_t ptr) as intptr_t
declare function _wfindnexti64 (byval as intptr_t, byval as _wfinddatai64_t ptr) as long
declare function _wgetcwd (byval as wchar_t ptr, byval as long) as wchar_t ptr
declare function _wgetdcwd (byval as long, byval as wchar_t ptr, byval as long) as wchar_t ptr
declare function _wchdir (byval as wchar_t ptr) as long
declare function _wmkdir (byval as wchar_t ptr) as long
declare function _wrmdir (byval as wchar_t ptr) as long
declare function _wstat (byval as wchar_t ptr, byval as _stat ptr) as long
declare function _wstati64 (byval as wchar_t ptr, byval as _stati64 ptr) as long
declare function _wasctime (byval as tm ptr) as wchar_t ptr
declare function _wctime (byval as time_t ptr) as wchar_t ptr
declare function _wstrdate (byval as wchar_t ptr) as wchar_t ptr
declare function _wstrtime (byval as wchar_t ptr) as wchar_t ptr
declare function _wsetlocale (byval as long, byval as wchar_t ptr) as wchar_t ptr
end extern

#endif
