#ifndef __CRT_BI__
#define __CRT_BI__

#ifdef __FB_WIN32__
# inclib "msvcrt"
#endif

#include once "crt/string.bi"
#include once "crt/math.bi"
#include once "crt/time.bi"
#include once "crt/wchar.bi"
#include once "crt/ctype.bi"
#include once "crt/stdlib.bi"
#include once "crt/stdio.bi"
#include once "crt/fcntl.bi"
#include once "crt/errno.bi"

#if defined(__FB_WIN32__) or defined(__FB_DOS__)
# include once "crt/dir.bi"
#endif

#endif ' __CRT_BI__
