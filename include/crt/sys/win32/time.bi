''
''
'' sys\time -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __crt_sys_win32_time_bi__
#define __crt_sys_win32_time_bi__

#ifndef timeval
type timeval
	tv_sec as long
	tv_usec as long
end type
#endif

#endif
