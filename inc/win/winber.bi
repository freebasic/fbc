#pragma once

#inclib "wldap32"

#include once "winapifamily.bi"

extern "C"

#define _WINBER_DEFINED_
#define LBER_ERROR __MSABI_LONG(&hffffffff)
#define LBER_DEFAULT __MSABI_LONG(&hffffffff)

type ber_tag_t as ulong
type ber_int_t as long
type ber_uint_t as ulong
type ber_len_t as ulong
type ber_slen_t as long
type BerElement as BerElement_
type BERVAL as BERVAL_

declare function ber_init(byval pBerVal as BERVAL ptr) as BerElement ptr
declare sub ber_free(byval pBerElement as BerElement ptr, byval fbuf as INT_)
declare sub ber_bvfree(byval pBerVal as BERVAL ptr)
type PBERVAL as PBERVAL_
declare sub ber_bvecfree(byval pBerVal as PBERVAL ptr)
declare function ber_bvdup(byval pBerVal as BERVAL ptr) as BERVAL ptr
declare function ber_alloc_t(byval options as INT_) as BerElement ptr
declare function ber_skip_tag(byval pBerElement as BerElement ptr, byval pLen as ULONG ptr) as ULONG
declare function ber_peek_tag(byval pBerElement as BerElement ptr, byval pLen as ULONG ptr) as ULONG
declare function ber_first_element(byval pBerElement as BerElement ptr, byval pLen as ULONG ptr, byval ppOpaque as zstring ptr ptr) as ULONG
declare function ber_next_element(byval pBerElement as BerElement ptr, byval pLen as ULONG ptr, byval opaque as zstring ptr) as ULONG
declare function ber_flatten(byval pBerElement as BerElement ptr, byval pBerVal as PBERVAL ptr) as INT_
declare function ber_printf(byval pBerElement as BerElement ptr, byval fmt as PSTR, ...) as INT_
declare function ber_scanf(byval pBerElement as BerElement ptr, byval fmt as PSTR, ...) as ULONG

end extern
