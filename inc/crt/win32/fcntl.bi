''
''
'' fcntl -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __crt_win32_fcntl_bi__
#define __crt_win32_fcntl_bi__

#include once "crt/io.bi"

#define _O_RDONLY 0
#define _O_WRONLY 1
#define _O_RDWR 2
#define _O_ACCMODE (0 or 1 or 2)
#define _O_APPEND &h0008
#define _O_RANDOM &h0010
#define _O_SEQUENTIAL &h0020
#define _O_TEMPORARY &h0040
#define _O_NOINHERIT &h0080
#define _O_CREAT &h0100
#define _O_TRUNC &h0200
#define _O_EXCL &h0400
#define _O_SHORT_LIVED &h1000
#define _O_TEXT &h4000
#define _O_BINARY &h8000
#define _O_RAW &h8000

#define	O_RDONLY _O_RDONLY
#define O_WRONLY _O_WRONLY
#define O_RDWR _O_RDWR
#define O_ACCMODE _O_ACCMODE
#define	O_APPEND _O_APPEND
#define	O_CREAT _O_CREAT
#define	O_TRUNC _O_TRUNC
#define	O_EXCL _O_EXCL
#define	O_TEXT _O_TEXT
#define	O_BINARY _O_BINARY
#define	O_TEMPORARY _O_TEMPORARY
#define O_NOINHERIT _O_NOINHERIT
#define O_SEQUENTIAL _O_SEQUENTIAL
#define	O_RANDOM _O_RANDOM

#endif
