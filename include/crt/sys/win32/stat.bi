''
''
'' sys\stat -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __crt_sys_win32_stat_bi__
#define __crt_sys_win32_stat_bi__

#define _S_IFIFO &h1000
#define _S_IFCHR &h2000
#define _S_IFBLK &h3000
#define _S_IFDIR &h4000
#define _S_IFREG &h8000
#define _S_IFMT &hF000
#define _S_IEXEC &h0040
#define _S_IWRITE &h0080
#define _S_IREAD &h0100
#define _S_IRWXU (&h0100 or &h0080 or &h0040)
#define _S_IXUSR &h0040
#define _S_IWUSR &h0080
#define _S_IRUSR &h0100

#define	_S_ISDIR(m) (((m) and _S_IFMT) = _S_IFDIR)
#define	_S_ISFIFO(m) (((m) and _S_IFMT) = _S_IFIFO)
#define	_S_ISCHR(m) (((m) and _S_IFMT) = _S_IFCHR)
#define	_S_ISBLK(m) (((m) and _S_IFMT) = _S_IFBLK)
#define	_S_ISREG(m) (((m) and _S_IFMT) = _S_IFREG)

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

#ifndef stat
type stat as _stat
#endif

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

declare function _fstat cdecl alias "_fstat" (byval as integer, byval as _stat ptr) as integer
declare function _chmod cdecl alias "_chmod" (byval as zstring ptr, byval as integer) as integer
declare function _stat cdecl alias "_stat" (byval as zstring ptr, byval as _stat ptr) as integer

declare function _fstati64 cdecl alias "_fstati64" (byval as integer, byval as _stati64 ptr) as integer
declare function _stati64 cdecl alias "_stati64" (byval as zstring ptr, byval as _stati64 ptr) as integer
declare function _wstat cdecl alias "_wstat" (byval as wchar_t ptr, byval as _stat ptr) as integer
declare function _wstati64 cdecl alias "_wstati64" (byval as wchar_t ptr, byval as _stati64 ptr) as integer

#endif
