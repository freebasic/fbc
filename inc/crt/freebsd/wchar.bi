'' FreeBASIC binding for FreeBSD 11.0 system headers
''
'' Most of the contents of wchar.h are defined in our crt/stdio.bi and crt/wchar.bi
''
'' Copyright © 2017 FreeBASIC development team

#pragma once

#include once "crt/stdio.bi"
#include once "crt/stdarg.bi"
#include once "crt/stddef.bi"
#include once "crt/long.bi"
#include once "crt/stdint.bi"

'#include once "sys/_null.bi"
'#include once "sys/_types.bi"

extern "C"

type mbstate_t as __mbstate_t
'type wchar_t as ___wchar_t
'type wint_t as __wint_t

'const WCHAR_MIN = __WCHAR_MIN
'const WCHAR_MAX = __WCHAR_MAX
const WEOF = cast(wint_t, -1)

declare function wmemcpy(byval as wstring ptr, byval as const wstring ptr, byval as uinteger) as wstring ptr

end extern
