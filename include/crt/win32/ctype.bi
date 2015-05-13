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

extern "c"
declare function iswalnum (byval as wint_t) as integer
declare function iswalpha (byval as wint_t) as integer
declare function iswascii (byval as wint_t) as integer
declare function iswcntrl (byval as wint_t) as integer
declare function iswctype (byval as wint_t, byval as wctype_t) as integer
declare function is_wctype (byval as wint_t, byval as wctype_t) as integer
declare function iswdigit (byval as wint_t) as integer
declare function iswgraph (byval as wint_t) as integer
declare function iswlower (byval as wint_t) as integer
declare function iswprint (byval as wint_t) as integer
declare function iswpunct (byval as wint_t) as integer
declare function iswspace (byval as wint_t) as integer
declare function iswupper (byval as wint_t) as integer
declare function iswxdigit (byval as wint_t) as integer
declare function towlower (byval as wchar_t) as wchar_t
declare function towupper (byval as wchar_t) as wchar_t
declare function isleadbyte (byval as integer) as integer
declare function _isctype (byval as integer, byval as integer) as integer
declare function _tolower (byval as integer) as integer
declare function _toupper (byval as integer) as integer
declare function __isascii (byval as integer) as integer
declare function __toascii (byval as integer) as integer
declare function __iscsymf (byval as integer) as integer
declare function __iscsym (byval as integer) as integer
end extern

extern import _ctype alias "_ctype" as ushort ptr ptr
extern import _pctype alias "_pctype" as ushort ptr ptr


#endif