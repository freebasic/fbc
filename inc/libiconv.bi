#pragma once

#include once "crt/stddef.bi"
#include once "crt/errno.bi"
#include once "crt/wchar.bi"

'' The following symbols have been renamed:
''     constant _LIBICONV_VERSION => _LIBICONV_VERSION_

extern "C"

#define _LIBICONV_H
const _LIBICONV_VERSION_ = &h010E

#ifdef __FB_WIN32__
	extern import _libiconv_version as long
#else
	extern _libiconv_version as long
#endif

#define iconv_t libiconv_t
type libiconv_t as any ptr
#define iconv_open libiconv_open
declare function libiconv_open(byval tocode as const zstring ptr, byval fromcode as const zstring ptr) as libiconv_t
#define iconv libiconv
declare function libiconv(byval cd as libiconv_t, byval inbuf as const zstring ptr ptr, byval inbytesleft as uinteger ptr, byval outbuf as zstring ptr ptr, byval outbytesleft as uinteger ptr) as uinteger
#define iconv_close libiconv_close
declare function libiconv_close(byval cd as libiconv_t) as long

type iconv_allocation_t
	dummy1(0 to 27) as any ptr
	dummy2 as mbstate_t
end type

#define iconv_open_into libiconv_open_into
declare function libiconv_open_into(byval tocode as const zstring ptr, byval fromcode as const zstring ptr, byval resultp as iconv_allocation_t ptr) as long
#define iconvctl libiconvctl
declare function libiconvctl(byval cd as libiconv_t, byval request as long, byval argument as any ptr) as long
type iconv_unicode_char_hook as sub(byval uc as ulong, byval data as any ptr)
type iconv_wide_char_hook as sub(byval wc as wchar_t, byval data as any ptr)

type iconv_hooks
	uc_hook as iconv_unicode_char_hook
	wc_hook as iconv_wide_char_hook
	data as any ptr
end type

type iconv_unicode_mb_to_uc_fallback as sub(byval inbuf as const zstring ptr, byval inbufsize as uinteger, byval write_replacement as sub(byval buf as const ulong ptr, byval buflen as uinteger, byval callback_arg as any ptr), byval callback_arg as any ptr, byval data as any ptr)
type iconv_unicode_uc_to_mb_fallback as sub(byval code as ulong, byval write_replacement as sub(byval buf as const zstring ptr, byval buflen as uinteger, byval callback_arg as any ptr), byval callback_arg as any ptr, byval data as any ptr)
type iconv_wchar_mb_to_wc_fallback as sub(byval inbuf as const zstring ptr, byval inbufsize as uinteger, byval write_replacement as sub(byval buf as const wstring ptr, byval buflen as uinteger, byval callback_arg as any ptr), byval callback_arg as any ptr, byval data as any ptr)
type iconv_wchar_wc_to_mb_fallback as sub(byval code as wchar_t, byval write_replacement as sub(byval buf as const zstring ptr, byval buflen as uinteger, byval callback_arg as any ptr), byval callback_arg as any ptr, byval data as any ptr)

type iconv_fallbacks
	mb_to_uc_fallback as iconv_unicode_mb_to_uc_fallback
	uc_to_mb_fallback as iconv_unicode_uc_to_mb_fallback
	mb_to_wc_fallback as iconv_wchar_mb_to_wc_fallback
	wc_to_mb_fallback as iconv_wchar_wc_to_mb_fallback
	data as any ptr
end type

const ICONV_TRIVIALP = 0
const ICONV_GET_TRANSLITERATE = 1
const ICONV_SET_TRANSLITERATE = 2
const ICONV_GET_DISCARD_ILSEQ = 3
const ICONV_SET_DISCARD_ILSEQ = 4
const ICONV_SET_HOOKS = 5
const ICONV_SET_FALLBACKS = 6
#define iconvlist libiconvlist

declare sub libiconvlist(byval do_one as function(byval namescount as ulong, byval names as const zstring const ptr ptr, byval data as any ptr) as long, byval data as any ptr)
declare function iconv_canonicalize(byval name as const zstring ptr) as const zstring ptr
declare sub libiconv_set_relocation_prefix(byval orig_prefix as const zstring ptr, byval curr_prefix as const zstring ptr)

end extern
