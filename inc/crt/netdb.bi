''
''
'' netdb -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __crt_netdb_bi__
#define __crt_netdb_bi__

#if defined(__FB_LINUX__)
#include once "crt/linux/netdb.bi"
#elseif defined(__FB_FREEBSD__)
#include once "crt/freebsd/netdb.bi"
'' Note: some of the functions in linux/netdb.bi, like rcmd(), are actually in
'' unistd.h on FreeBSD (and hence are in freebsd/unistd.bi)
#else
#error Unsupported platform
#endif


#endif
