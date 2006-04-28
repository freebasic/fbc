''
''
'' types -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __crt_sys_types_bi__
#define __crt_sys_types_bi__

#include once "crt/stddef.bi"

type time_t as integer

#ifdef __FB_WIN32__
type _off_t as integer
type _dev_t as uinteger
type _ino_t as short
type _pid_t as integer
type _mode_t as ushort
type _sigset_t as integer
type _ssize_t as integer
#else
'' !!!WRITEME!!!
#endif

#endif
