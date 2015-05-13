''
''
'' types -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __crt_sys_win32_types_bi__
#define __crt_sys_win32_types_bi__

type time_t as integer
type _off_t as long
type _dev_t as ulong
type _ino_t as ushort
type _pid_t as integer
type _mode_t as ushort
type _sigset_t as integer
type _ssize_t as integer
type off32_t as long
type off64_t as longint

#ifdef _FILE_OFFSET_BITS
	#if _FILE_OFFSET_BITS = 64
		type off_t as off64_t
	#else
		type off_t as off32_t
	#endif
#else
	type off_t as long
#endif

#endif
