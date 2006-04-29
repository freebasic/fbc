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

extern import _argc alias "_argc" as integer
extern import _argv alias "_argv" as byte ptr ptr

declare function __p___argc cdecl alias "__p___argc" () as integer ptr
declare function __p___argv cdecl alias "__p___argv" () as byte ptr ptr ptr
declare function __p___wargv cdecl alias "__p___wargv" () as wchar_t ptr ptr ptr
extern import __mbcur_max alias "__mbcur_max" as integer ptr
declare function __doserrno cdecl alias "__doserrno" () as integer ptr
#define	_doserrno (*__doserrno)
declare function __p__environ cdecl alias "__p__environ" () as byte ptr ptr ptr
declare function __p__wenviron cdecl alias "__p__wenviron" () as wchar_t ptr ptr ptr
extern import __sys_nerr alias "_sys_nerr" as integer ptr
extern import sys_errlist alias "sys_errlist" as byte ptr ptr ptr
declare function __p__osver cdecl alias "__p__osver" () as uinteger ptr
declare function __p__winver cdecl alias "__p__winver" () as uinteger ptr
declare function __p__winmajor cdecl alias "__p__winmajor" () as uinteger ptr
declare function __p__winminor cdecl alias "__p__winminor" () as uinteger ptr
declare function __p__pgmptr cdecl alias "__p__pgmptr" () as byte ptr ptr
declare function __p__wpgmptr cdecl alias "__p__wpgmptr" () as wchar_t ptr ptr
extern import _fmode alias "_fmode" as integer ptr
declare function _wtoi cdecl alias "_wtoi" (byval as wchar_t ptr) as integer
declare function _wtol cdecl alias "_wtol" (byval as wchar_t ptr) as integer
declare sub _beep cdecl alias "_beep" (byval as uinteger, byval as uinteger)
declare sub _seterrormode cdecl alias "_seterrormode" (byval as integer)
declare sub _sleep cdecl alias "_sleep" (byval as uinteger)
declare sub _exit cdecl alias "_exit" (byval as integer)

type _onexit_t as function cdecl() as integer

declare function _onexit cdecl alias "_onexit" (byval as _onexit_t) as _onexit_t
declare function _putenv cdecl alias "_putenv" (byval as zstring ptr) as integer
declare sub _searchenv cdecl alias "_searchenv" (byval as zstring ptr, byval as zstring ptr, byval as zstring ptr)
declare function _ecvt cdecl alias "_ecvt" (byval as double, byval as integer, byval as integer ptr, byval as integer ptr) as zstring ptr
declare function _fcvt cdecl alias "_fcvt" (byval as double, byval as integer, byval as integer ptr, byval as integer ptr) as zstring ptr
declare function _gcvt cdecl alias "_gcvt" (byval as double, byval as integer, byval as zstring ptr) as zstring ptr
declare sub _makepath cdecl alias "_makepath" (byval as zstring ptr, byval as zstring ptr, byval as zstring ptr, byval as zstring ptr, byval as zstring ptr)
declare sub _splitpath cdecl alias "_splitpath" (byval as zstring ptr, byval as zstring ptr, byval as zstring ptr, byval as zstring ptr, byval as zstring ptr)
declare function _fullpath cdecl alias "_fullpath" (byval as zstring ptr, byval as zstring ptr, byval as size_t) as zstring ptr
declare function _itoa cdecl alias "_itoa" (byval as integer, byval as zstring ptr, byval as integer) as zstring ptr
declare function _ltoa cdecl alias "_ltoa" (byval as integer, byval as zstring ptr, byval as integer) as zstring ptr
declare function _ultoa cdecl alias "_ultoa" (byval as uinteger, byval as zstring ptr, byval as integer) as zstring ptr
declare function _itow cdecl alias "_itow" (byval as integer, byval as wchar_t ptr, byval as integer) as wchar_t ptr
declare function _ltow cdecl alias "_ltow" (byval as integer, byval as wchar_t ptr, byval as integer) as wchar_t ptr
declare function _ultow cdecl alias "_ultow" (byval as uinteger, byval as wchar_t ptr, byval as integer) as wchar_t ptr
declare function _atoi64 cdecl alias "_atoi64" (byval as zstring ptr) as longint
declare function _i64toa cdecl alias "_i64toa" (byval as longint, byval as zstring ptr, byval as integer) as zstring ptr
declare function _ui64toa cdecl alias "_ui64toa" (byval as ulongint, byval as zstring ptr, byval as integer) as zstring ptr
declare function _wtoi64 cdecl alias "_wtoi64" (byval as wchar_t ptr) as longint
declare function _i64tow cdecl alias "_i64tow" (byval as longint, byval as wchar_t ptr, byval as integer) as wchar_t ptr
declare function _ui64tow cdecl alias "_ui64tow" (byval as ulongint, byval as wchar_t ptr, byval as integer) as wchar_t ptr
declare function _wgetenv cdecl alias "_wgetenv" (byval as wchar_t ptr) as wchar_t ptr
declare function _wputenv cdecl alias "_wputenv" (byval as wchar_t ptr) as integer
declare sub _wsearchenv cdecl alias "_wsearchenv" (byval as wchar_t ptr, byval as wchar_t ptr, byval as wchar_t ptr)
declare sub _wmakepath cdecl alias "_wmakepath" (byval as wchar_t ptr, byval as wchar_t ptr, byval as wchar_t ptr, byval as wchar_t ptr, byval as wchar_t ptr)
declare sub _wsplitpath cdecl alias "_wsplitpath" (byval as wchar_t ptr, byval as wchar_t ptr, byval as wchar_t ptr, byval as wchar_t ptr, byval as wchar_t ptr)
declare function _wfullpath cdecl alias "_wfullpath" (byval as wchar_t ptr, byval as wchar_t ptr, byval as size_t) as wchar_t ptr
declare function _rotl cdecl alias "_rotl" (byval as uinteger, byval as integer) as uinteger
declare function _rotr cdecl alias "_rotr" (byval as uinteger, byval as integer) as uinteger
declare function _lrotl cdecl alias "_lrotl" (byval as uinteger, byval as integer) as uinteger
declare function _lrotr cdecl alias "_lrotr" (byval as uinteger, byval as integer) as uinteger

#endif