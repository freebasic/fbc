''
''
'' stdlib -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __crt_win32_stdlib_bi__
#define __crt_win32_stdlib_bi__

#include once "crt/long.bi"

#define RAND_MAX &h7FFF
#define EXIT_SUCCESS 0
#define EXIT_FAILURE 1
#ifndef MAX_PATH
#define MAX_PATH (260)
#endif
#define _MAX_PATH (260)
#define _MAX_DRIVE (3)
#define _MAX_DIR 256
#define _MAX_FNAME 256
#define _MAX_EXT 256

extern "c"
extern import _argc alias "_argc" as long
extern import _argv alias "_argv" as byte ptr ptr
extern import __mbcur_max alias "__mbcur_max" as long ptr
extern import __sys_nerr alias "_sys_nerr" as long ptr
extern import sys_errlist alias "sys_errlist" as byte ptr ptr ptr
extern import _fmode alias "_fmode" as long ptr

type _onexit_t as function() as long

declare function __p___argc () as long ptr
declare function __p___argv () as byte ptr ptr ptr
declare function __p___wargv () as wchar_t ptr ptr ptr
declare function __doserrno () as culong ptr
#define	_doserrno (*__doserrno)
declare function __p__environ () as byte ptr ptr ptr
declare function __p__wenviron () as wchar_t ptr ptr ptr
#ifndef __FB_64BIT__
declare function __p__osver () as uinteger ptr
declare function __p__winver () as uinteger ptr
declare function __p__winmajor () as uinteger ptr
declare function __p__winminor () as uinteger ptr
#endif
declare function __p__pgmptr () as byte ptr ptr
declare function __p__wpgmptr () as wchar_t ptr ptr
declare function _wtoi (byval as wchar_t ptr) as long
declare function _wtol (byval as wchar_t ptr) as clong
declare sub _beep (byval as ulong, byval as ulong)
declare sub _seterrormode (byval as long)
declare sub _sleep (byval as culong)
declare sub _exit (byval as long)
declare function _onexit (byval as _onexit_t) as _onexit_t
declare function _putenv (byval as zstring ptr) as long
declare sub _searchenv (byval as zstring ptr, byval as zstring ptr, byval as zstring ptr)
declare function _ecvt (byval as double, byval as long, byval as long ptr, byval as long ptr) as zstring ptr
declare function _fcvt (byval as double, byval as long, byval as long ptr, byval as long ptr) as zstring ptr
declare function _gcvt (byval as double, byval as long, byval as zstring ptr) as zstring ptr
declare sub _makepath (byval as zstring ptr, byval as zstring ptr, byval as zstring ptr, byval as zstring ptr, byval as zstring ptr)
declare sub _splitpath (byval as zstring ptr, byval as zstring ptr, byval as zstring ptr, byval as zstring ptr, byval as zstring ptr)
declare function _fullpath (byval as zstring ptr, byval as zstring ptr, byval as size_t) as zstring ptr
declare function _itoa (byval as long, byval as zstring ptr, byval as long) as zstring ptr
declare function _ltoa (byval as clong, byval as zstring ptr, byval as long) as zstring ptr
declare function _ultoa (byval as culong, byval as zstring ptr, byval as long) as zstring ptr
declare function _itow (byval as long, byval as wchar_t ptr, byval as long) as wchar_t ptr
declare function _ltow (byval as clong, byval as wchar_t ptr, byval as long) as wchar_t ptr
declare function _ultow (byval as culong, byval as wchar_t ptr, byval as long) as wchar_t ptr
declare function _atoi64 (byval as zstring ptr) as longint
declare function _i64toa (byval as longint, byval as zstring ptr, byval as long) as zstring ptr
declare function _ui64toa (byval as ulongint, byval as zstring ptr, byval as long) as zstring ptr
declare function _wtoi64 (byval as wchar_t ptr) as longint
declare function _i64tow (byval as longint, byval as wchar_t ptr, byval as long) as wchar_t ptr
declare function _ui64tow (byval as ulongint, byval as wchar_t ptr, byval as long) as wchar_t ptr
declare function _wgetenv (byval as wchar_t ptr) as wchar_t ptr
declare function _wputenv (byval as wchar_t ptr) as long
declare sub _wsearchenv (byval as wchar_t ptr, byval as wchar_t ptr, byval as wchar_t ptr)
declare sub _wmakepath (byval as wchar_t ptr, byval as wchar_t ptr, byval as wchar_t ptr, byval as wchar_t ptr, byval as wchar_t ptr)
declare sub _wsplitpath (byval as wchar_t ptr, byval as wchar_t ptr, byval as wchar_t ptr, byval as wchar_t ptr, byval as wchar_t ptr)
declare function _wfullpath (byval as wchar_t ptr, byval as wchar_t ptr, byval as size_t) as wchar_t ptr
declare function _rotl (byval as ulong, byval as long) as ulong
declare function _rotr (byval as ulong, byval as long) as ulong
declare function _lrotl (byval as uinteger, byval as long) as uinteger
declare function _lrotr (byval as uinteger, byval as long) as uinteger
end extern

#endif
