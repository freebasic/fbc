''
''
'' winber -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_winber_bi__
#define __win_winber_bi__

#inclib "wldap32"

type BerElement as berelement
type ber_len_t as ULONG

type BERVAL
	bv_len as ber_len_t
	bv_val as zstring ptr
end type

type BerValue as BERVAL
type LDAP_BERVAL as BERVAL
type PLDAP_BERVAL as BERVAL ptr
type PBERVAL as BERVAL ptr

type ber_tag_t as ULONG
type ber_int_t as INT_
type ber_uint_t as UINT
type ber_slen_t as INT_

#define LBER_USE_DER &h01

declare function ber_init alias "ber_init" (byval as BerValue ptr) as BerElement ptr
declare function ber_printf cdecl alias "ber_printf" (byval as BerElement ptr, byval as zstring ptr, ...) as integer
declare function ber_flatten alias "ber_flatten" (byval as BerElement ptr, byval as BerValue ptr ptr) as integer
declare function ber_scanf cdecl alias "ber_scanf" (byval as BerElement ptr, byval as zstring ptr, ...) as ber_tag_t
declare function ber_peek_tag alias "ber_peek_tag" (byval as BerElement ptr, byval as ber_len_t ptr) as ber_tag_t
declare function ber_skip_tag alias "ber_skip_tag" (byval as BerElement ptr, byval as ber_len_t ptr) as ber_tag_t
declare function ber_first_element alias "ber_first_element" (byval as BerElement ptr, byval as ber_len_t ptr, byval as byte ptr ptr) as ber_tag_t
declare function ber_next_element alias "ber_next_element" (byval as BerElement ptr, byval as ber_len_t ptr, byval as zstring ptr) as ber_tag_t
declare sub ber_bvfree alias "ber_bvfree" (byval as BerValue ptr)
declare sub ber_bvecfree alias "ber_bvecfree" (byval as BerValue ptr ptr)
declare sub ber_free alias "ber_free" (byval as BerElement ptr, byval as integer)
declare function ber_bvdup alias "ber_bvdup" (byval as BerValue ptr) as BerValue ptr
declare function ber_alloc_t alias "ber_alloc_t" (byval as integer) as BerElement ptr

#endif
