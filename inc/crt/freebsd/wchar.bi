#pragma once

#include once "crt/stdio.bi"
#include once "crt/stdarg.bi"
#include once "crt/stddef.bi"
#include once "crt/long.bi"
#include once "crt/stdint.bi"
#include once "crt/limits.bi"

extern "C"

type mbstate_t as __mbstate_t

#ifndef wchar_t
type wchar_t as __wchar_t
#endif

#ifndef wint_t
type wint_t as __wint_t
#endif

#ifndef WEOF
const WEOF = cast(wint_t, -1)
#endif

end extern
