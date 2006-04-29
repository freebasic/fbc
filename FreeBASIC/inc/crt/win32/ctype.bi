''
''
'' ctype -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __crt_win32_ctype_bi__
#define __crt_win32_ctype_bi__

#define _UPPER &h0001
#define _LOWER &h0002
#define _DIGIT &h0004
#define _SPACE &h0008
#define _PUNCT &h0010
#define _CONTROL &h0020
#define _BLANK &h0040
#define _HEX &h0080
#define _LEADBYTE &h8000
#define _ALPHA &h0103

type wctype_t as wchar_t

declare function iswalnum cdecl alias "iswalnum" (byval as wint_t) as integer
declare function iswalpha cdecl alias "iswalpha" (byval as wint_t) as integer
declare function iswascii cdecl alias "iswascii" (byval as wint_t) as integer
declare function iswcntrl cdecl alias "iswcntrl" (byval as wint_t) as integer
declare function iswctype cdecl alias "iswctype" (byval as wint_t, byval as wctype_t) as integer
declare function is_wctype cdecl alias "is_wctype" (byval as wint_t, byval as wctype_t) as integer
declare function iswdigit cdecl alias "iswdigit" (byval as wint_t) as integer
declare function iswgraph cdecl alias "iswgraph" (byval as wint_t) as integer
declare function iswlower cdecl alias "iswlower" (byval as wint_t) as integer
declare function iswprint cdecl alias "iswprint" (byval as wint_t) as integer
declare function iswpunct cdecl alias "iswpunct" (byval as wint_t) as integer
declare function iswspace cdecl alias "iswspace" (byval as wint_t) as integer
declare function iswupper cdecl alias "iswupper" (byval as wint_t) as integer
declare function iswxdigit cdecl alias "iswxdigit" (byval as wint_t) as integer
declare function towlower cdecl alias "towlower" (byval as wchar_t) as wchar_t
declare function towupper cdecl alias "towupper" (byval as wchar_t) as wchar_t
declare function isleadbyte cdecl alias "isleadbyte" (byval as integer) as integer

extern import _ctype alias "_ctype" as ushort ptr ptr
extern import _pctype alias "_pctype" as ushort ptr ptr

declare function _isctype cdecl alias "_isctype" (byval as integer, byval as integer) as integer
declare function _tolower cdecl alias "_tolower" (byval as integer) as integer
declare function _toupper cdecl alias "_toupper" (byval as integer) as integer
declare function __isascii cdecl alias "__isascii" (byval as integer) as integer
declare function __toascii cdecl alias "__toascii" (byval as integer) as integer
declare function __iscsymf cdecl alias "__iscsymf" (byval as integer) as integer
declare function __iscsym cdecl alias "__iscsym" (byval as integer) as integer

#endif