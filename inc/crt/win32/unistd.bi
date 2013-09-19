''
''
'' unistd -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __crt_win32_unistd_bi__
#define __crt_win32_unistd_bi__

#include "crt/io.bi"
#include "crt/process.bi"

#include "crt/getopt.bi"

#ifndef	SEEK_SET
#define SEEK_SET 0
#endif

#ifndef	SEEK_CUR
#define SEEK_CUR 1
#endif

#ifndef SEEK_END
#define SEEK_END 2
#endif

extern "c"

declare function ftruncate (byval as long, byval as off_t) as long

end extern

#endif
