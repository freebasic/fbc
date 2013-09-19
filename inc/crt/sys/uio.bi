''
''
'' sys\uio -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __crt_sys_uio_bi__
#define __crt_sys_uio_bi__

#include once "crt/sys/types.bi"

'' begin include: bits/uio.bi
#define UIO_MAXIOV 1024

type iovec
	iov_base as any ptr
	iov_len as size_t
end type
'' end include: bits/uio.bi

extern "C"

declare function readv (byval __fd as long, byval __iovec as iovec ptr, byval __count as long) as ssize_t
declare function writev (byval __fd as long, byval __iovec as iovec ptr, byval __count as long) as ssize_t

end extern

#endif
