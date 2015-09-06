'' FreeBASIC binding for gmp-6.0.0
''
'' based on the C header files:
''    Definitions for GNU multiple precision functions.   -*- mode: c -*-
''
''   Copyright 1991, 1993-1997, 1999-2014 Free Software Foundation, Inc.
''
''   This file is part of the GNU MP Library.
''
''   The GNU MP Library is free software; you can redistribute it and/or modify
''   it under the terms of either:
''
''     * the GNU Lesser General Public License as published by the Free
''       Software Foundation; either version 3 of the License, or (at your
''       option) any later version.
''
''   or
''
''     * the GNU General Public License as published by the Free Software
''       Foundation; either version 2 of the License, or (at your option) any
''       later version.
''
''   or both in parallel, as here.
''
''   The GNU MP Library is distributed in the hope that it will be useful, but
''   WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
''   or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
''   for more details.
''
''   You should have received copies of the GNU General Public License and the
''   GNU Lesser General Public License along with the GNU MP Library.  If not,
''   see https://www.gnu.org/licenses/.  
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "gmp"

#include once "crt/long.bi"
#include once "crt/stddef.bi"
#include once "crt/stdio.bi"

'' The following symbols have been renamed:
''     #define MPZ_ROINIT_N => MPZ_ROINIT_N_

extern "C"

const __GMP_HAVE_HOST_CPU_FAMILY_power = 0
const __GMP_HAVE_HOST_CPU_FAMILY_powerpc = 0
#define GMP_LIMB_BITS (8 * sizeof(mp_limb_t))
const GMP_NAIL_BITS = 0
#define GMP_NUMB_BITS (GMP_LIMB_BITS - GMP_NAIL_BITS)
#define GMP_NUMB_MASK ((not __GMP_CAST(mp_limb_t, 0)) shr GMP_NAIL_BITS)
#define GMP_NUMB_MAX GMP_NUMB_MASK
#define GMP_NAIL_MASK (not GMP_NUMB_MASK)
const __GNU_MP__ = 5

#if defined(__FB_WIN32__) and defined(LIBGMP_DLL)
	const __GMP_LIBGMP_DLL = 1
#else
	const __GMP_LIBGMP_DLL = 0
#endif

type mp_limb_t as culong
type mp_limb_signed_t as clong
type mp_bitcnt_t as culong

type __mpz_struct
	_mp_alloc as long
	_mp_size as long
	_mp_d as mp_limb_t ptr
end type

type MP_INT as __mpz_struct
type mp_ptr as mp_limb_t ptr
type mp_srcptr as const mp_limb_t ptr
const __GMP_MP_SIZE_T_INT = 0
type mp_size_t as clong
type mp_exp_t as clong

type __mpq_struct
	_mp_num as __mpz_struct
	_mp_den as __mpz_struct
end type

type MP_RAT as __mpq_struct

type __mpf_struct
	_mp_prec as long
	_mp_size as long
	_mp_exp as mp_exp_t
	_mp_d as mp_limb_t ptr
end type

type gmp_randalg_t as long
enum
	GMP_RAND_ALG_DEFAULT = 0
	GMP_RAND_ALG_LC = GMP_RAND_ALG_DEFAULT
end enum

union __gmp_randstate_struct__mp_algdata
	_mp_lc as any ptr
end union

type __gmp_randstate_struct
	_mp_seed(0 to 0) as __mpz_struct
	_mp_alg as gmp_randalg_t
	_mp_algdata as __gmp_randstate_struct__mp_algdata
end type

type mpz_srcptr as const __mpz_struct ptr
type mpz_ptr as __mpz_struct ptr
type mpf_srcptr as const __mpf_struct ptr
type mpf_ptr as __mpf_struct ptr
type mpq_srcptr as const __mpq_struct ptr
type mpq_ptr as __mpq_struct ptr

#define __MPN(x) __gmpn_##x
const _GMP_H_HAVE_FILE = 1
const _GMP_H_HAVE_VA_LIST = 1
#define __GMP_GNUC_PREREQ(maj, min) (((__GNUC__ shl 16) + __GNUC_MINOR__) >= (((maj) shl 16) + (min)))
#define __GMP_CAST(type, expr) cast((type), (expr))
const __GMP_INLINE_PROTOTYPES = 1
#define __GMP_ABS(x) iif((x) >= 0, (x), -(x))
#define __GMP_MAX(h, i) iif((h) > (i), (h), (i))
const __GMP_UINT_MAX = culng(not culng(0))
const __GMP_ULONG_MAX = not cast(culong, 0)
const __GMP_USHRT_MAX = 0 + cushort(not 0)
#define mpq_numref(Q) (@(Q)->_mp_num)
#define mpq_denref(Q) (@(Q)->_mp_den)

declare sub __gmp_set_memory_functions(byval as function(byval as uinteger) as any ptr, byval as function(byval as any ptr, byval as uinteger, byval as uinteger) as any ptr, byval as sub(byval as any ptr, byval as uinteger))
declare sub mp_set_memory_functions alias "__gmp_set_memory_functions"(byval as function(byval as uinteger) as any ptr, byval as function(byval as any ptr, byval as uinteger, byval as uinteger) as any ptr, byval as sub(byval as any ptr, byval as uinteger))
declare sub __gmp_get_memory_functions(byval as typeof(function(byval as uinteger) as any ptr) ptr, byval as typeof(function(byval as any ptr, byval as uinteger, byval as uinteger) as any ptr) ptr, byval as typeof(sub(byval as any ptr, byval as uinteger)) ptr)
declare sub mp_get_memory_functions alias "__gmp_get_memory_functions"(byval as typeof(function(byval as uinteger) as any ptr) ptr, byval as typeof(function(byval as any ptr, byval as uinteger, byval as uinteger) as any ptr) ptr, byval as typeof(sub(byval as any ptr, byval as uinteger)) ptr)

#if defined(__FB_WIN32__) and defined(LIBGMP_DLL)
	extern import __gmp_bits_per_limb as const long
	extern import mp_bits_per_limb alias "__gmp_bits_per_limb" as const long
	extern import __gmp_errno as long
	extern import gmp_errno alias "__gmp_errno" as long
	extern import __gmp_version as const zstring const ptr
	extern import gmp_version alias "__gmp_version" as const zstring const ptr
#else
	extern __gmp_bits_per_limb as const long
	extern mp_bits_per_limb alias "__gmp_bits_per_limb" as const long
	extern __gmp_errno as long
	extern gmp_errno alias "__gmp_errno" as long
	extern __gmp_version as const zstring const ptr
	extern gmp_version alias "__gmp_version" as const zstring const ptr
#endif

declare sub __gmp_randinit(byval as __gmp_randstate_struct ptr, byval as gmp_randalg_t, ...)
declare sub gmp_randinit alias "__gmp_randinit"(byval as __gmp_randstate_struct ptr, byval as gmp_randalg_t, ...)
declare sub __gmp_randinit_default(byval as __gmp_randstate_struct ptr)
declare sub gmp_randinit_default alias "__gmp_randinit_default"(byval as __gmp_randstate_struct ptr)
declare sub __gmp_randinit_lc_2exp(byval as __gmp_randstate_struct ptr, byval as mpz_srcptr, byval as culong, byval as mp_bitcnt_t)
declare sub gmp_randinit_lc_2exp alias "__gmp_randinit_lc_2exp"(byval as __gmp_randstate_struct ptr, byval as mpz_srcptr, byval as culong, byval as mp_bitcnt_t)
declare function __gmp_randinit_lc_2exp_size(byval as __gmp_randstate_struct ptr, byval as mp_bitcnt_t) as long
declare function gmp_randinit_lc_2exp_size alias "__gmp_randinit_lc_2exp_size"(byval as __gmp_randstate_struct ptr, byval as mp_bitcnt_t) as long
declare sub __gmp_randinit_mt(byval as __gmp_randstate_struct ptr)
declare sub gmp_randinit_mt alias "__gmp_randinit_mt"(byval as __gmp_randstate_struct ptr)
declare sub __gmp_randinit_set(byval as __gmp_randstate_struct ptr, byval as const __gmp_randstate_struct ptr)
declare sub gmp_randinit_set alias "__gmp_randinit_set"(byval as __gmp_randstate_struct ptr, byval as const __gmp_randstate_struct ptr)
declare sub __gmp_randseed(byval as __gmp_randstate_struct ptr, byval as mpz_srcptr)
declare sub gmp_randseed alias "__gmp_randseed"(byval as __gmp_randstate_struct ptr, byval as mpz_srcptr)
declare sub __gmp_randseed_ui(byval as __gmp_randstate_struct ptr, byval as culong)
declare sub gmp_randseed_ui alias "__gmp_randseed_ui"(byval as __gmp_randstate_struct ptr, byval as culong)
declare sub __gmp_randclear(byval as __gmp_randstate_struct ptr)
declare sub gmp_randclear alias "__gmp_randclear"(byval as __gmp_randstate_struct ptr)
declare function __gmp_urandomb_ui(byval as __gmp_randstate_struct ptr, byval as culong) as culong
declare function gmp_urandomb_ui alias "__gmp_urandomb_ui"(byval as __gmp_randstate_struct ptr, byval as culong) as culong
declare function __gmp_urandomm_ui(byval as __gmp_randstate_struct ptr, byval as culong) as culong
declare function gmp_urandomm_ui alias "__gmp_urandomm_ui"(byval as __gmp_randstate_struct ptr, byval as culong) as culong
declare function __gmp_asprintf(byval as zstring ptr ptr, byval as const zstring ptr, ...) as long
declare function gmp_asprintf alias "__gmp_asprintf"(byval as zstring ptr ptr, byval as const zstring ptr, ...) as long
declare function __gmp_fprintf(byval as FILE ptr, byval as const zstring ptr, ...) as long
declare function gmp_fprintf alias "__gmp_fprintf"(byval as FILE ptr, byval as const zstring ptr, ...) as long
#define gmp_obstack_printf __gmp_obstack_printf
#define gmp_obstack_vprintf __gmp_obstack_vprintf
declare function __gmp_printf(byval as const zstring ptr, ...) as long
declare function gmp_printf alias "__gmp_printf"(byval as const zstring ptr, ...) as long
declare function __gmp_snprintf(byval as zstring ptr, byval as uinteger, byval as const zstring ptr, ...) as long
declare function gmp_snprintf alias "__gmp_snprintf"(byval as zstring ptr, byval as uinteger, byval as const zstring ptr, ...) as long
declare function __gmp_sprintf(byval as zstring ptr, byval as const zstring ptr, ...) as long
declare function gmp_sprintf alias "__gmp_sprintf"(byval as zstring ptr, byval as const zstring ptr, ...) as long
declare function __gmp_vasprintf(byval as zstring ptr ptr, byval as const zstring ptr, byval as va_list) as long
declare function gmp_vasprintf alias "__gmp_vasprintf"(byval as zstring ptr ptr, byval as const zstring ptr, byval as va_list) as long
declare function __gmp_vfprintf(byval as FILE ptr, byval as const zstring ptr, byval as va_list) as long
declare function gmp_vfprintf alias "__gmp_vfprintf"(byval as FILE ptr, byval as const zstring ptr, byval as va_list) as long
declare function __gmp_vprintf(byval as const zstring ptr, byval as va_list) as long
declare function gmp_vprintf alias "__gmp_vprintf"(byval as const zstring ptr, byval as va_list) as long
declare function __gmp_vsnprintf(byval as zstring ptr, byval as uinteger, byval as const zstring ptr, byval as va_list) as long
declare function gmp_vsnprintf alias "__gmp_vsnprintf"(byval as zstring ptr, byval as uinteger, byval as const zstring ptr, byval as va_list) as long
declare function __gmp_vsprintf(byval as zstring ptr, byval as const zstring ptr, byval as va_list) as long
declare function gmp_vsprintf alias "__gmp_vsprintf"(byval as zstring ptr, byval as const zstring ptr, byval as va_list) as long
declare function __gmp_fscanf(byval as FILE ptr, byval as const zstring ptr, ...) as long
declare function gmp_fscanf alias "__gmp_fscanf"(byval as FILE ptr, byval as const zstring ptr, ...) as long
declare function __gmp_scanf(byval as const zstring ptr, ...) as long
declare function gmp_scanf alias "__gmp_scanf"(byval as const zstring ptr, ...) as long
declare function __gmp_sscanf(byval as const zstring ptr, byval as const zstring ptr, ...) as long
declare function gmp_sscanf alias "__gmp_sscanf"(byval as const zstring ptr, byval as const zstring ptr, ...) as long
declare function __gmp_vfscanf(byval as FILE ptr, byval as const zstring ptr, byval as va_list) as long
declare function gmp_vfscanf alias "__gmp_vfscanf"(byval as FILE ptr, byval as const zstring ptr, byval as va_list) as long
declare function __gmp_vscanf(byval as const zstring ptr, byval as va_list) as long
declare function gmp_vscanf alias "__gmp_vscanf"(byval as const zstring ptr, byval as va_list) as long
declare function __gmp_vsscanf(byval as const zstring ptr, byval as const zstring ptr, byval as va_list) as long
declare function gmp_vsscanf alias "__gmp_vsscanf"(byval as const zstring ptr, byval as const zstring ptr, byval as va_list) as long
declare function __gmpz_realloc(byval as mpz_ptr, byval as mp_size_t) as any ptr
declare function _mpz_realloc alias "__gmpz_realloc"(byval as mpz_ptr, byval as mp_size_t) as any ptr
declare function mpz_realloc alias "__gmpz_realloc"(byval as mpz_ptr, byval as mp_size_t) as any ptr
declare sub __gmpz_abs(byval as mpz_ptr, byval as mpz_srcptr)
declare sub mpz_abs alias "__gmpz_abs"(byval as mpz_ptr, byval as mpz_srcptr)
declare sub __gmpz_add(byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare sub mpz_add alias "__gmpz_add"(byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare sub __gmpz_add_ui(byval as mpz_ptr, byval as mpz_srcptr, byval as culong)
declare sub mpz_add_ui alias "__gmpz_add_ui"(byval as mpz_ptr, byval as mpz_srcptr, byval as culong)
declare sub __gmpz_addmul(byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare sub mpz_addmul alias "__gmpz_addmul"(byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare sub __gmpz_addmul_ui(byval as mpz_ptr, byval as mpz_srcptr, byval as culong)
declare sub mpz_addmul_ui alias "__gmpz_addmul_ui"(byval as mpz_ptr, byval as mpz_srcptr, byval as culong)
declare sub __gmpz_and(byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare sub mpz_and alias "__gmpz_and"(byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare sub __gmpz_array_init(byval as mpz_ptr, byval as mp_size_t, byval as mp_size_t)
declare sub mpz_array_init alias "__gmpz_array_init"(byval as mpz_ptr, byval as mp_size_t, byval as mp_size_t)
declare sub __gmpz_bin_ui(byval as mpz_ptr, byval as mpz_srcptr, byval as culong)
declare sub mpz_bin_ui alias "__gmpz_bin_ui"(byval as mpz_ptr, byval as mpz_srcptr, byval as culong)
declare sub __gmpz_bin_uiui(byval as mpz_ptr, byval as culong, byval as culong)
declare sub mpz_bin_uiui alias "__gmpz_bin_uiui"(byval as mpz_ptr, byval as culong, byval as culong)
declare sub __gmpz_cdiv_q(byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare sub mpz_cdiv_q alias "__gmpz_cdiv_q"(byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare sub __gmpz_cdiv_q_2exp(byval as mpz_ptr, byval as mpz_srcptr, byval as mp_bitcnt_t)
declare sub mpz_cdiv_q_2exp alias "__gmpz_cdiv_q_2exp"(byval as mpz_ptr, byval as mpz_srcptr, byval as mp_bitcnt_t)
declare function __gmpz_cdiv_q_ui(byval as mpz_ptr, byval as mpz_srcptr, byval as culong) as culong
declare function mpz_cdiv_q_ui alias "__gmpz_cdiv_q_ui"(byval as mpz_ptr, byval as mpz_srcptr, byval as culong) as culong
declare sub __gmpz_cdiv_qr(byval as mpz_ptr, byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare sub mpz_cdiv_qr alias "__gmpz_cdiv_qr"(byval as mpz_ptr, byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare function __gmpz_cdiv_qr_ui(byval as mpz_ptr, byval as mpz_ptr, byval as mpz_srcptr, byval as culong) as culong
declare function mpz_cdiv_qr_ui alias "__gmpz_cdiv_qr_ui"(byval as mpz_ptr, byval as mpz_ptr, byval as mpz_srcptr, byval as culong) as culong
declare sub __gmpz_cdiv_r(byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare sub mpz_cdiv_r alias "__gmpz_cdiv_r"(byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare sub __gmpz_cdiv_r_2exp(byval as mpz_ptr, byval as mpz_srcptr, byval as mp_bitcnt_t)
declare sub mpz_cdiv_r_2exp alias "__gmpz_cdiv_r_2exp"(byval as mpz_ptr, byval as mpz_srcptr, byval as mp_bitcnt_t)
declare function __gmpz_cdiv_r_ui(byval as mpz_ptr, byval as mpz_srcptr, byval as culong) as culong
declare function mpz_cdiv_r_ui alias "__gmpz_cdiv_r_ui"(byval as mpz_ptr, byval as mpz_srcptr, byval as culong) as culong
declare function __gmpz_cdiv_ui(byval as mpz_srcptr, byval as culong) as culong
declare function mpz_cdiv_ui alias "__gmpz_cdiv_ui"(byval as mpz_srcptr, byval as culong) as culong
declare sub __gmpz_clear(byval as mpz_ptr)
declare sub mpz_clear alias "__gmpz_clear"(byval as mpz_ptr)
declare sub __gmpz_clears(byval as mpz_ptr, ...)
declare sub mpz_clears alias "__gmpz_clears"(byval as mpz_ptr, ...)
declare sub __gmpz_clrbit(byval as mpz_ptr, byval as mp_bitcnt_t)
declare sub mpz_clrbit alias "__gmpz_clrbit"(byval as mpz_ptr, byval as mp_bitcnt_t)
declare function __gmpz_cmp(byval as mpz_srcptr, byval as mpz_srcptr) as long
declare function mpz_cmp alias "__gmpz_cmp"(byval as mpz_srcptr, byval as mpz_srcptr) as long
declare function __gmpz_cmp_d(byval as mpz_srcptr, byval as double) as long
declare function mpz_cmp_d alias "__gmpz_cmp_d"(byval as mpz_srcptr, byval as double) as long
declare function __gmpz_cmp_si(byval as mpz_srcptr, byval as clong) as long
declare function _mpz_cmp_si alias "__gmpz_cmp_si"(byval as mpz_srcptr, byval as clong) as long
declare function __gmpz_cmp_ui(byval as mpz_srcptr, byval as culong) as long
declare function _mpz_cmp_ui alias "__gmpz_cmp_ui"(byval as mpz_srcptr, byval as culong) as long
declare function __gmpz_cmpabs(byval as mpz_srcptr, byval as mpz_srcptr) as long
declare function mpz_cmpabs alias "__gmpz_cmpabs"(byval as mpz_srcptr, byval as mpz_srcptr) as long
declare function __gmpz_cmpabs_d(byval as mpz_srcptr, byval as double) as long
declare function mpz_cmpabs_d alias "__gmpz_cmpabs_d"(byval as mpz_srcptr, byval as double) as long
declare function __gmpz_cmpabs_ui(byval as mpz_srcptr, byval as culong) as long
declare function mpz_cmpabs_ui alias "__gmpz_cmpabs_ui"(byval as mpz_srcptr, byval as culong) as long
declare sub __gmpz_com(byval as mpz_ptr, byval as mpz_srcptr)
declare sub mpz_com alias "__gmpz_com"(byval as mpz_ptr, byval as mpz_srcptr)
declare sub __gmpz_combit(byval as mpz_ptr, byval as mp_bitcnt_t)
declare sub mpz_combit alias "__gmpz_combit"(byval as mpz_ptr, byval as mp_bitcnt_t)
declare function __gmpz_congruent_p(byval as mpz_srcptr, byval as mpz_srcptr, byval as mpz_srcptr) as long
declare function mpz_congruent_p alias "__gmpz_congruent_p"(byval as mpz_srcptr, byval as mpz_srcptr, byval as mpz_srcptr) as long
declare function __gmpz_congruent_2exp_p(byval as mpz_srcptr, byval as mpz_srcptr, byval as mp_bitcnt_t) as long
declare function mpz_congruent_2exp_p alias "__gmpz_congruent_2exp_p"(byval as mpz_srcptr, byval as mpz_srcptr, byval as mp_bitcnt_t) as long
declare function __gmpz_congruent_ui_p(byval as mpz_srcptr, byval as culong, byval as culong) as long
declare function mpz_congruent_ui_p alias "__gmpz_congruent_ui_p"(byval as mpz_srcptr, byval as culong, byval as culong) as long
declare sub __gmpz_divexact(byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare sub mpz_divexact alias "__gmpz_divexact"(byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare sub __gmpz_divexact_ui(byval as mpz_ptr, byval as mpz_srcptr, byval as culong)
declare sub mpz_divexact_ui alias "__gmpz_divexact_ui"(byval as mpz_ptr, byval as mpz_srcptr, byval as culong)
declare function __gmpz_divisible_p(byval as mpz_srcptr, byval as mpz_srcptr) as long
declare function mpz_divisible_p alias "__gmpz_divisible_p"(byval as mpz_srcptr, byval as mpz_srcptr) as long
declare function __gmpz_divisible_ui_p(byval as mpz_srcptr, byval as culong) as long
declare function mpz_divisible_ui_p alias "__gmpz_divisible_ui_p"(byval as mpz_srcptr, byval as culong) as long
declare function __gmpz_divisible_2exp_p(byval as mpz_srcptr, byval as mp_bitcnt_t) as long
declare function mpz_divisible_2exp_p alias "__gmpz_divisible_2exp_p"(byval as mpz_srcptr, byval as mp_bitcnt_t) as long
declare sub __gmpz_dump(byval as mpz_srcptr)
declare sub mpz_dump alias "__gmpz_dump"(byval as mpz_srcptr)
declare function __gmpz_export(byval as any ptr, byval as uinteger ptr, byval as long, byval as uinteger, byval as long, byval as uinteger, byval as mpz_srcptr) as any ptr
declare function mpz_export alias "__gmpz_export"(byval as any ptr, byval as uinteger ptr, byval as long, byval as uinteger, byval as long, byval as uinteger, byval as mpz_srcptr) as any ptr
declare sub __gmpz_fac_ui(byval as mpz_ptr, byval as culong)
declare sub mpz_fac_ui alias "__gmpz_fac_ui"(byval as mpz_ptr, byval as culong)
declare sub __gmpz_2fac_ui(byval as mpz_ptr, byval as culong)
declare sub mpz_2fac_ui alias "__gmpz_2fac_ui"(byval as mpz_ptr, byval as culong)
declare sub __gmpz_mfac_uiui(byval as mpz_ptr, byval as culong, byval as culong)
declare sub mpz_mfac_uiui alias "__gmpz_mfac_uiui"(byval as mpz_ptr, byval as culong, byval as culong)
declare sub __gmpz_primorial_ui(byval as mpz_ptr, byval as culong)
declare sub mpz_primorial_ui alias "__gmpz_primorial_ui"(byval as mpz_ptr, byval as culong)
declare sub __gmpz_fdiv_q(byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare sub mpz_fdiv_q alias "__gmpz_fdiv_q"(byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare sub __gmpz_fdiv_q_2exp(byval as mpz_ptr, byval as mpz_srcptr, byval as mp_bitcnt_t)
declare sub mpz_fdiv_q_2exp alias "__gmpz_fdiv_q_2exp"(byval as mpz_ptr, byval as mpz_srcptr, byval as mp_bitcnt_t)
declare function __gmpz_fdiv_q_ui(byval as mpz_ptr, byval as mpz_srcptr, byval as culong) as culong
declare function mpz_fdiv_q_ui alias "__gmpz_fdiv_q_ui"(byval as mpz_ptr, byval as mpz_srcptr, byval as culong) as culong
declare sub __gmpz_fdiv_qr(byval as mpz_ptr, byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare sub mpz_fdiv_qr alias "__gmpz_fdiv_qr"(byval as mpz_ptr, byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare function __gmpz_fdiv_qr_ui(byval as mpz_ptr, byval as mpz_ptr, byval as mpz_srcptr, byval as culong) as culong
declare function mpz_fdiv_qr_ui alias "__gmpz_fdiv_qr_ui"(byval as mpz_ptr, byval as mpz_ptr, byval as mpz_srcptr, byval as culong) as culong
declare sub __gmpz_fdiv_r(byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare sub mpz_fdiv_r alias "__gmpz_fdiv_r"(byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare sub __gmpz_fdiv_r_2exp(byval as mpz_ptr, byval as mpz_srcptr, byval as mp_bitcnt_t)
declare sub mpz_fdiv_r_2exp alias "__gmpz_fdiv_r_2exp"(byval as mpz_ptr, byval as mpz_srcptr, byval as mp_bitcnt_t)
declare function __gmpz_fdiv_r_ui(byval as mpz_ptr, byval as mpz_srcptr, byval as culong) as culong
declare function mpz_fdiv_r_ui alias "__gmpz_fdiv_r_ui"(byval as mpz_ptr, byval as mpz_srcptr, byval as culong) as culong
declare function __gmpz_fdiv_ui(byval as mpz_srcptr, byval as culong) as culong
declare function mpz_fdiv_ui alias "__gmpz_fdiv_ui"(byval as mpz_srcptr, byval as culong) as culong
declare sub __gmpz_fib_ui(byval as mpz_ptr, byval as culong)
declare sub mpz_fib_ui alias "__gmpz_fib_ui"(byval as mpz_ptr, byval as culong)
declare sub __gmpz_fib2_ui(byval as mpz_ptr, byval as mpz_ptr, byval as culong)
declare sub mpz_fib2_ui alias "__gmpz_fib2_ui"(byval as mpz_ptr, byval as mpz_ptr, byval as culong)
declare function __gmpz_fits_sint_p(byval as mpz_srcptr) as long
declare function mpz_fits_sint_p alias "__gmpz_fits_sint_p"(byval as mpz_srcptr) as long
declare function __gmpz_fits_slong_p(byval as mpz_srcptr) as long
declare function mpz_fits_slong_p alias "__gmpz_fits_slong_p"(byval as mpz_srcptr) as long
declare function __gmpz_fits_sshort_p(byval as mpz_srcptr) as long
declare function mpz_fits_sshort_p alias "__gmpz_fits_sshort_p"(byval as mpz_srcptr) as long
declare function __gmpz_fits_uint_p(byval as mpz_srcptr) as long
declare function mpz_fits_uint_p alias "__gmpz_fits_uint_p"(byval as mpz_srcptr) as long
declare function __gmpz_fits_ulong_p(byval as mpz_srcptr) as long
declare function mpz_fits_ulong_p alias "__gmpz_fits_ulong_p"(byval as mpz_srcptr) as long
declare function __gmpz_fits_ushort_p(byval as mpz_srcptr) as long
declare function mpz_fits_ushort_p alias "__gmpz_fits_ushort_p"(byval as mpz_srcptr) as long
declare sub __gmpz_gcd(byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare sub mpz_gcd alias "__gmpz_gcd"(byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare function __gmpz_gcd_ui(byval as mpz_ptr, byval as mpz_srcptr, byval as culong) as culong
declare function mpz_gcd_ui alias "__gmpz_gcd_ui"(byval as mpz_ptr, byval as mpz_srcptr, byval as culong) as culong
declare sub __gmpz_gcdext(byval as mpz_ptr, byval as mpz_ptr, byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare sub mpz_gcdext alias "__gmpz_gcdext"(byval as mpz_ptr, byval as mpz_ptr, byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare function __gmpz_get_d(byval as mpz_srcptr) as double
declare function mpz_get_d alias "__gmpz_get_d"(byval as mpz_srcptr) as double
declare function __gmpz_get_d_2exp(byval as clong ptr, byval as mpz_srcptr) as double
declare function mpz_get_d_2exp alias "__gmpz_get_d_2exp"(byval as clong ptr, byval as mpz_srcptr) as double
declare function __gmpz_get_si(byval as mpz_srcptr) as clong
declare function mpz_get_si alias "__gmpz_get_si"(byval as mpz_srcptr) as clong
declare function __gmpz_get_str(byval as zstring ptr, byval as long, byval as mpz_srcptr) as zstring ptr
declare function mpz_get_str alias "__gmpz_get_str"(byval as zstring ptr, byval as long, byval as mpz_srcptr) as zstring ptr
declare function __gmpz_get_ui(byval as mpz_srcptr) as culong
declare function mpz_get_ui alias "__gmpz_get_ui"(byval as mpz_srcptr) as culong
declare function __gmpz_getlimbn(byval as mpz_srcptr, byval as mp_size_t) as mp_limb_t
declare function mpz_getlimbn alias "__gmpz_getlimbn"(byval as mpz_srcptr, byval as mp_size_t) as mp_limb_t
declare function __gmpz_hamdist(byval as mpz_srcptr, byval as mpz_srcptr) as mp_bitcnt_t
declare function mpz_hamdist alias "__gmpz_hamdist"(byval as mpz_srcptr, byval as mpz_srcptr) as mp_bitcnt_t
declare sub __gmpz_import(byval as mpz_ptr, byval as uinteger, byval as long, byval as uinteger, byval as long, byval as uinteger, byval as const any ptr)
declare sub mpz_import alias "__gmpz_import"(byval as mpz_ptr, byval as uinteger, byval as long, byval as uinteger, byval as long, byval as uinteger, byval as const any ptr)
declare sub __gmpz_init(byval as mpz_ptr)
declare sub mpz_init alias "__gmpz_init"(byval as mpz_ptr)
declare sub __gmpz_init2(byval as mpz_ptr, byval as mp_bitcnt_t)
declare sub mpz_init2 alias "__gmpz_init2"(byval as mpz_ptr, byval as mp_bitcnt_t)
declare sub __gmpz_inits(byval as mpz_ptr, ...)
declare sub mpz_inits alias "__gmpz_inits"(byval as mpz_ptr, ...)
declare sub __gmpz_init_set(byval as mpz_ptr, byval as mpz_srcptr)
declare sub mpz_init_set alias "__gmpz_init_set"(byval as mpz_ptr, byval as mpz_srcptr)
declare sub __gmpz_init_set_d(byval as mpz_ptr, byval as double)
declare sub mpz_init_set_d alias "__gmpz_init_set_d"(byval as mpz_ptr, byval as double)
declare sub __gmpz_init_set_si(byval as mpz_ptr, byval as clong)
declare sub mpz_init_set_si alias "__gmpz_init_set_si"(byval as mpz_ptr, byval as clong)
declare function __gmpz_init_set_str(byval as mpz_ptr, byval as const zstring ptr, byval as long) as long
declare function mpz_init_set_str alias "__gmpz_init_set_str"(byval as mpz_ptr, byval as const zstring ptr, byval as long) as long
declare sub __gmpz_init_set_ui(byval as mpz_ptr, byval as culong)
declare sub mpz_init_set_ui alias "__gmpz_init_set_ui"(byval as mpz_ptr, byval as culong)
declare function __gmpz_inp_raw(byval as mpz_ptr, byval as FILE ptr) as uinteger
declare function mpz_inp_raw alias "__gmpz_inp_raw"(byval as mpz_ptr, byval as FILE ptr) as uinteger
declare function __gmpz_inp_str(byval as mpz_ptr, byval as FILE ptr, byval as long) as uinteger
declare function mpz_inp_str alias "__gmpz_inp_str"(byval as mpz_ptr, byval as FILE ptr, byval as long) as uinteger
declare function __gmpz_invert(byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr) as long
declare function mpz_invert alias "__gmpz_invert"(byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr) as long
declare sub __gmpz_ior(byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare sub mpz_ior alias "__gmpz_ior"(byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare function __gmpz_jacobi(byval as mpz_srcptr, byval as mpz_srcptr) as long
declare function mpz_jacobi alias "__gmpz_jacobi"(byval as mpz_srcptr, byval as mpz_srcptr) as long
declare function mpz_kronecker alias "__gmpz_jacobi"(byval as mpz_srcptr, byval as mpz_srcptr) as long
declare function __gmpz_kronecker_si(byval as mpz_srcptr, byval as clong) as long
declare function mpz_kronecker_si alias "__gmpz_kronecker_si"(byval as mpz_srcptr, byval as clong) as long
declare function __gmpz_kronecker_ui(byval as mpz_srcptr, byval as culong) as long
declare function mpz_kronecker_ui alias "__gmpz_kronecker_ui"(byval as mpz_srcptr, byval as culong) as long
declare function __gmpz_si_kronecker(byval as clong, byval as mpz_srcptr) as long
declare function mpz_si_kronecker alias "__gmpz_si_kronecker"(byval as clong, byval as mpz_srcptr) as long
declare function __gmpz_ui_kronecker(byval as culong, byval as mpz_srcptr) as long
declare function mpz_ui_kronecker alias "__gmpz_ui_kronecker"(byval as culong, byval as mpz_srcptr) as long
declare sub __gmpz_lcm(byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare sub mpz_lcm alias "__gmpz_lcm"(byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare sub __gmpz_lcm_ui(byval as mpz_ptr, byval as mpz_srcptr, byval as culong)
declare sub mpz_lcm_ui alias "__gmpz_lcm_ui"(byval as mpz_ptr, byval as mpz_srcptr, byval as culong)
declare function mpz_legendre alias "__gmpz_jacobi"(byval as mpz_srcptr, byval as mpz_srcptr) as long
declare sub __gmpz_lucnum_ui(byval as mpz_ptr, byval as culong)
declare sub mpz_lucnum_ui alias "__gmpz_lucnum_ui"(byval as mpz_ptr, byval as culong)
declare sub __gmpz_lucnum2_ui(byval as mpz_ptr, byval as mpz_ptr, byval as culong)
declare sub mpz_lucnum2_ui alias "__gmpz_lucnum2_ui"(byval as mpz_ptr, byval as mpz_ptr, byval as culong)
declare function __gmpz_millerrabin(byval as mpz_srcptr, byval as long) as long
declare function mpz_millerrabin alias "__gmpz_millerrabin"(byval as mpz_srcptr, byval as long) as long
declare sub __gmpz_mod(byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare sub mpz_mod alias "__gmpz_mod"(byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare function mpz_mod_ui alias "__gmpz_fdiv_r_ui"(byval as mpz_ptr, byval as mpz_srcptr, byval as culong) as culong
declare sub __gmpz_mul(byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare sub mpz_mul alias "__gmpz_mul"(byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare sub __gmpz_mul_2exp(byval as mpz_ptr, byval as mpz_srcptr, byval as mp_bitcnt_t)
declare sub mpz_mul_2exp alias "__gmpz_mul_2exp"(byval as mpz_ptr, byval as mpz_srcptr, byval as mp_bitcnt_t)
declare sub __gmpz_mul_si(byval as mpz_ptr, byval as mpz_srcptr, byval as clong)
declare sub mpz_mul_si alias "__gmpz_mul_si"(byval as mpz_ptr, byval as mpz_srcptr, byval as clong)
declare sub __gmpz_mul_ui(byval as mpz_ptr, byval as mpz_srcptr, byval as culong)
declare sub mpz_mul_ui alias "__gmpz_mul_ui"(byval as mpz_ptr, byval as mpz_srcptr, byval as culong)
declare sub __gmpz_neg(byval as mpz_ptr, byval as mpz_srcptr)
declare sub mpz_neg alias "__gmpz_neg"(byval as mpz_ptr, byval as mpz_srcptr)
declare sub __gmpz_nextprime(byval as mpz_ptr, byval as mpz_srcptr)
declare sub mpz_nextprime alias "__gmpz_nextprime"(byval as mpz_ptr, byval as mpz_srcptr)
declare function __gmpz_out_raw(byval as FILE ptr, byval as mpz_srcptr) as uinteger
declare function mpz_out_raw alias "__gmpz_out_raw"(byval as FILE ptr, byval as mpz_srcptr) as uinteger
declare function __gmpz_out_str(byval as FILE ptr, byval as long, byval as mpz_srcptr) as uinteger
declare function mpz_out_str alias "__gmpz_out_str"(byval as FILE ptr, byval as long, byval as mpz_srcptr) as uinteger
declare function __gmpz_perfect_power_p(byval as mpz_srcptr) as long
declare function mpz_perfect_power_p alias "__gmpz_perfect_power_p"(byval as mpz_srcptr) as long
declare function __gmpz_perfect_square_p(byval as mpz_srcptr) as long
declare function mpz_perfect_square_p alias "__gmpz_perfect_square_p"(byval as mpz_srcptr) as long
declare function __gmpz_popcount(byval as mpz_srcptr) as mp_bitcnt_t
declare function mpz_popcount alias "__gmpz_popcount"(byval as mpz_srcptr) as mp_bitcnt_t
declare sub __gmpz_pow_ui(byval as mpz_ptr, byval as mpz_srcptr, byval as culong)
declare sub mpz_pow_ui alias "__gmpz_pow_ui"(byval as mpz_ptr, byval as mpz_srcptr, byval as culong)
declare sub __gmpz_powm(byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare sub mpz_powm alias "__gmpz_powm"(byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare sub __gmpz_powm_sec(byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare sub mpz_powm_sec alias "__gmpz_powm_sec"(byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare sub __gmpz_powm_ui(byval as mpz_ptr, byval as mpz_srcptr, byval as culong, byval as mpz_srcptr)
declare sub mpz_powm_ui alias "__gmpz_powm_ui"(byval as mpz_ptr, byval as mpz_srcptr, byval as culong, byval as mpz_srcptr)
declare function __gmpz_probab_prime_p(byval as mpz_srcptr, byval as long) as long
declare function mpz_probab_prime_p alias "__gmpz_probab_prime_p"(byval as mpz_srcptr, byval as long) as long
declare sub __gmpz_random(byval as mpz_ptr, byval as mp_size_t)
declare sub mpz_random alias "__gmpz_random"(byval as mpz_ptr, byval as mp_size_t)
declare sub __gmpz_random2(byval as mpz_ptr, byval as mp_size_t)
declare sub mpz_random2 alias "__gmpz_random2"(byval as mpz_ptr, byval as mp_size_t)
declare sub __gmpz_realloc2(byval as mpz_ptr, byval as mp_bitcnt_t)
declare sub mpz_realloc2 alias "__gmpz_realloc2"(byval as mpz_ptr, byval as mp_bitcnt_t)
declare function __gmpz_remove(byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr) as mp_bitcnt_t
declare function mpz_remove alias "__gmpz_remove"(byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr) as mp_bitcnt_t
declare function __gmpz_root(byval as mpz_ptr, byval as mpz_srcptr, byval as culong) as long
declare function mpz_root alias "__gmpz_root"(byval as mpz_ptr, byval as mpz_srcptr, byval as culong) as long
declare sub __gmpz_rootrem(byval as mpz_ptr, byval as mpz_ptr, byval as mpz_srcptr, byval as culong)
declare sub mpz_rootrem alias "__gmpz_rootrem"(byval as mpz_ptr, byval as mpz_ptr, byval as mpz_srcptr, byval as culong)
declare sub __gmpz_rrandomb(byval as mpz_ptr, byval as __gmp_randstate_struct ptr, byval as mp_bitcnt_t)
declare sub mpz_rrandomb alias "__gmpz_rrandomb"(byval as mpz_ptr, byval as __gmp_randstate_struct ptr, byval as mp_bitcnt_t)
declare function __gmpz_scan0(byval as mpz_srcptr, byval as mp_bitcnt_t) as mp_bitcnt_t
declare function mpz_scan0 alias "__gmpz_scan0"(byval as mpz_srcptr, byval as mp_bitcnt_t) as mp_bitcnt_t
declare function __gmpz_scan1(byval as mpz_srcptr, byval as mp_bitcnt_t) as mp_bitcnt_t
declare function mpz_scan1 alias "__gmpz_scan1"(byval as mpz_srcptr, byval as mp_bitcnt_t) as mp_bitcnt_t
declare sub __gmpz_set(byval as mpz_ptr, byval as mpz_srcptr)
declare sub mpz_set alias "__gmpz_set"(byval as mpz_ptr, byval as mpz_srcptr)
declare sub __gmpz_set_d(byval as mpz_ptr, byval as double)
declare sub mpz_set_d alias "__gmpz_set_d"(byval as mpz_ptr, byval as double)
declare sub __gmpz_set_f(byval as mpz_ptr, byval as mpf_srcptr)
declare sub mpz_set_f alias "__gmpz_set_f"(byval as mpz_ptr, byval as mpf_srcptr)
declare sub __gmpz_set_q(byval as mpz_ptr, byval as mpq_srcptr)
declare sub mpz_set_q alias "__gmpz_set_q"(byval as mpz_ptr, byval as mpq_srcptr)
declare sub __gmpz_set_si(byval as mpz_ptr, byval as clong)
declare sub mpz_set_si alias "__gmpz_set_si"(byval as mpz_ptr, byval as clong)
declare function __gmpz_set_str(byval as mpz_ptr, byval as const zstring ptr, byval as long) as long
declare function mpz_set_str alias "__gmpz_set_str"(byval as mpz_ptr, byval as const zstring ptr, byval as long) as long
declare sub __gmpz_set_ui(byval as mpz_ptr, byval as culong)
declare sub mpz_set_ui alias "__gmpz_set_ui"(byval as mpz_ptr, byval as culong)
declare sub __gmpz_setbit(byval as mpz_ptr, byval as mp_bitcnt_t)
declare sub mpz_setbit alias "__gmpz_setbit"(byval as mpz_ptr, byval as mp_bitcnt_t)
declare function __gmpz_size(byval as mpz_srcptr) as uinteger
declare function mpz_size alias "__gmpz_size"(byval as mpz_srcptr) as uinteger
declare function __gmpz_sizeinbase(byval as mpz_srcptr, byval as long) as uinteger
declare function mpz_sizeinbase alias "__gmpz_sizeinbase"(byval as mpz_srcptr, byval as long) as uinteger
declare sub __gmpz_sqrt(byval as mpz_ptr, byval as mpz_srcptr)
declare sub mpz_sqrt alias "__gmpz_sqrt"(byval as mpz_ptr, byval as mpz_srcptr)
declare sub __gmpz_sqrtrem(byval as mpz_ptr, byval as mpz_ptr, byval as mpz_srcptr)
declare sub mpz_sqrtrem alias "__gmpz_sqrtrem"(byval as mpz_ptr, byval as mpz_ptr, byval as mpz_srcptr)
declare sub __gmpz_sub(byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare sub mpz_sub alias "__gmpz_sub"(byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare sub __gmpz_sub_ui(byval as mpz_ptr, byval as mpz_srcptr, byval as culong)
declare sub mpz_sub_ui alias "__gmpz_sub_ui"(byval as mpz_ptr, byval as mpz_srcptr, byval as culong)
declare sub __gmpz_ui_sub(byval as mpz_ptr, byval as culong, byval as mpz_srcptr)
declare sub mpz_ui_sub alias "__gmpz_ui_sub"(byval as mpz_ptr, byval as culong, byval as mpz_srcptr)
declare sub __gmpz_submul(byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare sub mpz_submul alias "__gmpz_submul"(byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare sub __gmpz_submul_ui(byval as mpz_ptr, byval as mpz_srcptr, byval as culong)
declare sub mpz_submul_ui alias "__gmpz_submul_ui"(byval as mpz_ptr, byval as mpz_srcptr, byval as culong)
declare sub __gmpz_swap(byval as mpz_ptr, byval as mpz_ptr)
declare sub mpz_swap alias "__gmpz_swap"(byval as mpz_ptr, byval as mpz_ptr)
declare function __gmpz_tdiv_ui(byval as mpz_srcptr, byval as culong) as culong
declare function mpz_tdiv_ui alias "__gmpz_tdiv_ui"(byval as mpz_srcptr, byval as culong) as culong
declare sub __gmpz_tdiv_q(byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare sub mpz_tdiv_q alias "__gmpz_tdiv_q"(byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare sub __gmpz_tdiv_q_2exp(byval as mpz_ptr, byval as mpz_srcptr, byval as mp_bitcnt_t)
declare sub mpz_tdiv_q_2exp alias "__gmpz_tdiv_q_2exp"(byval as mpz_ptr, byval as mpz_srcptr, byval as mp_bitcnt_t)
declare function __gmpz_tdiv_q_ui(byval as mpz_ptr, byval as mpz_srcptr, byval as culong) as culong
declare function mpz_tdiv_q_ui alias "__gmpz_tdiv_q_ui"(byval as mpz_ptr, byval as mpz_srcptr, byval as culong) as culong
declare sub __gmpz_tdiv_qr(byval as mpz_ptr, byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare sub mpz_tdiv_qr alias "__gmpz_tdiv_qr"(byval as mpz_ptr, byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare function __gmpz_tdiv_qr_ui(byval as mpz_ptr, byval as mpz_ptr, byval as mpz_srcptr, byval as culong) as culong
declare function mpz_tdiv_qr_ui alias "__gmpz_tdiv_qr_ui"(byval as mpz_ptr, byval as mpz_ptr, byval as mpz_srcptr, byval as culong) as culong
declare sub __gmpz_tdiv_r(byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare sub mpz_tdiv_r alias "__gmpz_tdiv_r"(byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare sub __gmpz_tdiv_r_2exp(byval as mpz_ptr, byval as mpz_srcptr, byval as mp_bitcnt_t)
declare sub mpz_tdiv_r_2exp alias "__gmpz_tdiv_r_2exp"(byval as mpz_ptr, byval as mpz_srcptr, byval as mp_bitcnt_t)
declare function __gmpz_tdiv_r_ui(byval as mpz_ptr, byval as mpz_srcptr, byval as culong) as culong
declare function mpz_tdiv_r_ui alias "__gmpz_tdiv_r_ui"(byval as mpz_ptr, byval as mpz_srcptr, byval as culong) as culong
declare function __gmpz_tstbit(byval as mpz_srcptr, byval as mp_bitcnt_t) as long
declare function mpz_tstbit alias "__gmpz_tstbit"(byval as mpz_srcptr, byval as mp_bitcnt_t) as long
declare sub __gmpz_ui_pow_ui(byval as mpz_ptr, byval as culong, byval as culong)
declare sub mpz_ui_pow_ui alias "__gmpz_ui_pow_ui"(byval as mpz_ptr, byval as culong, byval as culong)
declare sub __gmpz_urandomb(byval as mpz_ptr, byval as __gmp_randstate_struct ptr, byval as mp_bitcnt_t)
declare sub mpz_urandomb alias "__gmpz_urandomb"(byval as mpz_ptr, byval as __gmp_randstate_struct ptr, byval as mp_bitcnt_t)
declare sub __gmpz_urandomm(byval as mpz_ptr, byval as __gmp_randstate_struct ptr, byval as mpz_srcptr)
declare sub mpz_urandomm alias "__gmpz_urandomm"(byval as mpz_ptr, byval as __gmp_randstate_struct ptr, byval as mpz_srcptr)
declare sub __gmpz_xor(byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare sub mpz_xor alias "__gmpz_xor"(byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare sub mpz_eor alias "__gmpz_xor"(byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare function __gmpz_limbs_read(byval as mpz_srcptr) as mp_srcptr
declare function mpz_limbs_read alias "__gmpz_limbs_read"(byval as mpz_srcptr) as mp_srcptr
declare function __gmpz_limbs_write(byval as mpz_ptr, byval as mp_size_t) as mp_ptr
declare function mpz_limbs_write alias "__gmpz_limbs_write"(byval as mpz_ptr, byval as mp_size_t) as mp_ptr
declare function __gmpz_limbs_modify(byval as mpz_ptr, byval as mp_size_t) as mp_ptr
declare function mpz_limbs_modify alias "__gmpz_limbs_modify"(byval as mpz_ptr, byval as mp_size_t) as mp_ptr
declare sub __gmpz_limbs_finish(byval as mpz_ptr, byval as mp_size_t)
declare sub mpz_limbs_finish alias "__gmpz_limbs_finish"(byval as mpz_ptr, byval as mp_size_t)
declare function __gmpz_roinit_n(byval as mpz_ptr, byval as mp_srcptr, byval as mp_size_t) as mpz_srcptr
declare function mpz_roinit_n alias "__gmpz_roinit_n"(byval as mpz_ptr, byval as mp_srcptr, byval as mp_size_t) as mpz_srcptr
#define MPZ_ROINIT_N_(xp, xs) ((0, (xs), (xp)))
declare sub __gmpq_abs(byval as mpq_ptr, byval as mpq_srcptr)
declare sub mpq_abs alias "__gmpq_abs"(byval as mpq_ptr, byval as mpq_srcptr)
declare sub __gmpq_add(byval as mpq_ptr, byval as mpq_srcptr, byval as mpq_srcptr)
declare sub mpq_add alias "__gmpq_add"(byval as mpq_ptr, byval as mpq_srcptr, byval as mpq_srcptr)
declare sub __gmpq_canonicalize(byval as mpq_ptr)
declare sub mpq_canonicalize alias "__gmpq_canonicalize"(byval as mpq_ptr)
declare sub __gmpq_clear(byval as mpq_ptr)
declare sub mpq_clear alias "__gmpq_clear"(byval as mpq_ptr)
declare sub __gmpq_clears(byval as mpq_ptr, ...)
declare sub mpq_clears alias "__gmpq_clears"(byval as mpq_ptr, ...)
declare function __gmpq_cmp(byval as mpq_srcptr, byval as mpq_srcptr) as long
declare function mpq_cmp alias "__gmpq_cmp"(byval as mpq_srcptr, byval as mpq_srcptr) as long
declare function __gmpq_cmp_si(byval as mpq_srcptr, byval as clong, byval as culong) as long
declare function _mpq_cmp_si alias "__gmpq_cmp_si"(byval as mpq_srcptr, byval as clong, byval as culong) as long
declare function __gmpq_cmp_ui(byval as mpq_srcptr, byval as culong, byval as culong) as long
declare function _mpq_cmp_ui alias "__gmpq_cmp_ui"(byval as mpq_srcptr, byval as culong, byval as culong) as long
declare sub __gmpq_div(byval as mpq_ptr, byval as mpq_srcptr, byval as mpq_srcptr)
declare sub mpq_div alias "__gmpq_div"(byval as mpq_ptr, byval as mpq_srcptr, byval as mpq_srcptr)
declare sub __gmpq_div_2exp(byval as mpq_ptr, byval as mpq_srcptr, byval as mp_bitcnt_t)
declare sub mpq_div_2exp alias "__gmpq_div_2exp"(byval as mpq_ptr, byval as mpq_srcptr, byval as mp_bitcnt_t)
declare function __gmpq_equal(byval as mpq_srcptr, byval as mpq_srcptr) as long
declare function mpq_equal alias "__gmpq_equal"(byval as mpq_srcptr, byval as mpq_srcptr) as long
declare sub __gmpq_get_num(byval as mpz_ptr, byval as mpq_srcptr)
declare sub mpq_get_num alias "__gmpq_get_num"(byval as mpz_ptr, byval as mpq_srcptr)
declare sub __gmpq_get_den(byval as mpz_ptr, byval as mpq_srcptr)
declare sub mpq_get_den alias "__gmpq_get_den"(byval as mpz_ptr, byval as mpq_srcptr)
declare function __gmpq_get_d(byval as mpq_srcptr) as double
declare function mpq_get_d alias "__gmpq_get_d"(byval as mpq_srcptr) as double
declare function __gmpq_get_str(byval as zstring ptr, byval as long, byval as mpq_srcptr) as zstring ptr
declare function mpq_get_str alias "__gmpq_get_str"(byval as zstring ptr, byval as long, byval as mpq_srcptr) as zstring ptr
declare sub __gmpq_init(byval as mpq_ptr)
declare sub mpq_init alias "__gmpq_init"(byval as mpq_ptr)
declare sub __gmpq_inits(byval as mpq_ptr, ...)
declare sub mpq_inits alias "__gmpq_inits"(byval as mpq_ptr, ...)
declare function __gmpq_inp_str(byval as mpq_ptr, byval as FILE ptr, byval as long) as uinteger
declare function mpq_inp_str alias "__gmpq_inp_str"(byval as mpq_ptr, byval as FILE ptr, byval as long) as uinteger
declare sub __gmpq_inv(byval as mpq_ptr, byval as mpq_srcptr)
declare sub mpq_inv alias "__gmpq_inv"(byval as mpq_ptr, byval as mpq_srcptr)
declare sub __gmpq_mul(byval as mpq_ptr, byval as mpq_srcptr, byval as mpq_srcptr)
declare sub mpq_mul alias "__gmpq_mul"(byval as mpq_ptr, byval as mpq_srcptr, byval as mpq_srcptr)
declare sub __gmpq_mul_2exp(byval as mpq_ptr, byval as mpq_srcptr, byval as mp_bitcnt_t)
declare sub mpq_mul_2exp alias "__gmpq_mul_2exp"(byval as mpq_ptr, byval as mpq_srcptr, byval as mp_bitcnt_t)
declare sub __gmpq_neg(byval as mpq_ptr, byval as mpq_srcptr)
declare sub mpq_neg alias "__gmpq_neg"(byval as mpq_ptr, byval as mpq_srcptr)
declare function __gmpq_out_str(byval as FILE ptr, byval as long, byval as mpq_srcptr) as uinteger
declare function mpq_out_str alias "__gmpq_out_str"(byval as FILE ptr, byval as long, byval as mpq_srcptr) as uinteger
declare sub __gmpq_set(byval as mpq_ptr, byval as mpq_srcptr)
declare sub mpq_set alias "__gmpq_set"(byval as mpq_ptr, byval as mpq_srcptr)
declare sub __gmpq_set_d(byval as mpq_ptr, byval as double)
declare sub mpq_set_d alias "__gmpq_set_d"(byval as mpq_ptr, byval as double)
declare sub __gmpq_set_den(byval as mpq_ptr, byval as mpz_srcptr)
declare sub mpq_set_den alias "__gmpq_set_den"(byval as mpq_ptr, byval as mpz_srcptr)
declare sub __gmpq_set_f(byval as mpq_ptr, byval as mpf_srcptr)
declare sub mpq_set_f alias "__gmpq_set_f"(byval as mpq_ptr, byval as mpf_srcptr)
declare sub __gmpq_set_num(byval as mpq_ptr, byval as mpz_srcptr)
declare sub mpq_set_num alias "__gmpq_set_num"(byval as mpq_ptr, byval as mpz_srcptr)
declare sub __gmpq_set_si(byval as mpq_ptr, byval as clong, byval as culong)
declare sub mpq_set_si alias "__gmpq_set_si"(byval as mpq_ptr, byval as clong, byval as culong)
declare function __gmpq_set_str(byval as mpq_ptr, byval as const zstring ptr, byval as long) as long
declare function mpq_set_str alias "__gmpq_set_str"(byval as mpq_ptr, byval as const zstring ptr, byval as long) as long
declare sub __gmpq_set_ui(byval as mpq_ptr, byval as culong, byval as culong)
declare sub mpq_set_ui alias "__gmpq_set_ui"(byval as mpq_ptr, byval as culong, byval as culong)
declare sub __gmpq_set_z(byval as mpq_ptr, byval as mpz_srcptr)
declare sub mpq_set_z alias "__gmpq_set_z"(byval as mpq_ptr, byval as mpz_srcptr)
declare sub __gmpq_sub(byval as mpq_ptr, byval as mpq_srcptr, byval as mpq_srcptr)
declare sub mpq_sub alias "__gmpq_sub"(byval as mpq_ptr, byval as mpq_srcptr, byval as mpq_srcptr)
declare sub __gmpq_swap(byval as mpq_ptr, byval as mpq_ptr)
declare sub mpq_swap alias "__gmpq_swap"(byval as mpq_ptr, byval as mpq_ptr)
declare sub __gmpf_abs(byval as mpf_ptr, byval as mpf_srcptr)
declare sub mpf_abs alias "__gmpf_abs"(byval as mpf_ptr, byval as mpf_srcptr)
declare sub __gmpf_add(byval as mpf_ptr, byval as mpf_srcptr, byval as mpf_srcptr)
declare sub mpf_add alias "__gmpf_add"(byval as mpf_ptr, byval as mpf_srcptr, byval as mpf_srcptr)
declare sub __gmpf_add_ui(byval as mpf_ptr, byval as mpf_srcptr, byval as culong)
declare sub mpf_add_ui alias "__gmpf_add_ui"(byval as mpf_ptr, byval as mpf_srcptr, byval as culong)
declare sub __gmpf_ceil(byval as mpf_ptr, byval as mpf_srcptr)
declare sub mpf_ceil alias "__gmpf_ceil"(byval as mpf_ptr, byval as mpf_srcptr)
declare sub __gmpf_clear(byval as mpf_ptr)
declare sub mpf_clear alias "__gmpf_clear"(byval as mpf_ptr)
declare sub __gmpf_clears(byval as mpf_ptr, ...)
declare sub mpf_clears alias "__gmpf_clears"(byval as mpf_ptr, ...)
declare function __gmpf_cmp(byval as mpf_srcptr, byval as mpf_srcptr) as long
declare function mpf_cmp alias "__gmpf_cmp"(byval as mpf_srcptr, byval as mpf_srcptr) as long
declare function __gmpf_cmp_d(byval as mpf_srcptr, byval as double) as long
declare function mpf_cmp_d alias "__gmpf_cmp_d"(byval as mpf_srcptr, byval as double) as long
declare function __gmpf_cmp_si(byval as mpf_srcptr, byval as clong) as long
declare function mpf_cmp_si alias "__gmpf_cmp_si"(byval as mpf_srcptr, byval as clong) as long
declare function __gmpf_cmp_ui(byval as mpf_srcptr, byval as culong) as long
declare function mpf_cmp_ui alias "__gmpf_cmp_ui"(byval as mpf_srcptr, byval as culong) as long
declare sub __gmpf_div(byval as mpf_ptr, byval as mpf_srcptr, byval as mpf_srcptr)
declare sub mpf_div alias "__gmpf_div"(byval as mpf_ptr, byval as mpf_srcptr, byval as mpf_srcptr)
declare sub __gmpf_div_2exp(byval as mpf_ptr, byval as mpf_srcptr, byval as mp_bitcnt_t)
declare sub mpf_div_2exp alias "__gmpf_div_2exp"(byval as mpf_ptr, byval as mpf_srcptr, byval as mp_bitcnt_t)
declare sub __gmpf_div_ui(byval as mpf_ptr, byval as mpf_srcptr, byval as culong)
declare sub mpf_div_ui alias "__gmpf_div_ui"(byval as mpf_ptr, byval as mpf_srcptr, byval as culong)
declare sub __gmpf_dump(byval as mpf_srcptr)
declare sub mpf_dump alias "__gmpf_dump"(byval as mpf_srcptr)
declare function __gmpf_eq(byval as mpf_srcptr, byval as mpf_srcptr, byval as mp_bitcnt_t) as long
declare function mpf_eq alias "__gmpf_eq"(byval as mpf_srcptr, byval as mpf_srcptr, byval as mp_bitcnt_t) as long
declare function __gmpf_fits_sint_p(byval as mpf_srcptr) as long
declare function mpf_fits_sint_p alias "__gmpf_fits_sint_p"(byval as mpf_srcptr) as long
declare function __gmpf_fits_slong_p(byval as mpf_srcptr) as long
declare function mpf_fits_slong_p alias "__gmpf_fits_slong_p"(byval as mpf_srcptr) as long
declare function __gmpf_fits_sshort_p(byval as mpf_srcptr) as long
declare function mpf_fits_sshort_p alias "__gmpf_fits_sshort_p"(byval as mpf_srcptr) as long
declare function __gmpf_fits_uint_p(byval as mpf_srcptr) as long
declare function mpf_fits_uint_p alias "__gmpf_fits_uint_p"(byval as mpf_srcptr) as long
declare function __gmpf_fits_ulong_p(byval as mpf_srcptr) as long
declare function mpf_fits_ulong_p alias "__gmpf_fits_ulong_p"(byval as mpf_srcptr) as long
declare function __gmpf_fits_ushort_p(byval as mpf_srcptr) as long
declare function mpf_fits_ushort_p alias "__gmpf_fits_ushort_p"(byval as mpf_srcptr) as long
declare sub __gmpf_floor(byval as mpf_ptr, byval as mpf_srcptr)
declare sub mpf_floor alias "__gmpf_floor"(byval as mpf_ptr, byval as mpf_srcptr)
declare function __gmpf_get_d(byval as mpf_srcptr) as double
declare function mpf_get_d alias "__gmpf_get_d"(byval as mpf_srcptr) as double
declare function __gmpf_get_d_2exp(byval as clong ptr, byval as mpf_srcptr) as double
declare function mpf_get_d_2exp alias "__gmpf_get_d_2exp"(byval as clong ptr, byval as mpf_srcptr) as double
declare function __gmpf_get_default_prec() as mp_bitcnt_t
declare function mpf_get_default_prec alias "__gmpf_get_default_prec"() as mp_bitcnt_t
declare function __gmpf_get_prec(byval as mpf_srcptr) as mp_bitcnt_t
declare function mpf_get_prec alias "__gmpf_get_prec"(byval as mpf_srcptr) as mp_bitcnt_t
declare function __gmpf_get_si(byval as mpf_srcptr) as clong
declare function mpf_get_si alias "__gmpf_get_si"(byval as mpf_srcptr) as clong
declare function __gmpf_get_str(byval as zstring ptr, byval as mp_exp_t ptr, byval as long, byval as uinteger, byval as mpf_srcptr) as zstring ptr
declare function mpf_get_str alias "__gmpf_get_str"(byval as zstring ptr, byval as mp_exp_t ptr, byval as long, byval as uinteger, byval as mpf_srcptr) as zstring ptr
declare function __gmpf_get_ui(byval as mpf_srcptr) as culong
declare function mpf_get_ui alias "__gmpf_get_ui"(byval as mpf_srcptr) as culong
declare sub __gmpf_init(byval as mpf_ptr)
declare sub mpf_init alias "__gmpf_init"(byval as mpf_ptr)
declare sub __gmpf_init2(byval as mpf_ptr, byval as mp_bitcnt_t)
declare sub mpf_init2 alias "__gmpf_init2"(byval as mpf_ptr, byval as mp_bitcnt_t)
declare sub __gmpf_inits(byval as mpf_ptr, ...)
declare sub mpf_inits alias "__gmpf_inits"(byval as mpf_ptr, ...)
declare sub __gmpf_init_set(byval as mpf_ptr, byval as mpf_srcptr)
declare sub mpf_init_set alias "__gmpf_init_set"(byval as mpf_ptr, byval as mpf_srcptr)
declare sub __gmpf_init_set_d(byval as mpf_ptr, byval as double)
declare sub mpf_init_set_d alias "__gmpf_init_set_d"(byval as mpf_ptr, byval as double)
declare sub __gmpf_init_set_si(byval as mpf_ptr, byval as clong)
declare sub mpf_init_set_si alias "__gmpf_init_set_si"(byval as mpf_ptr, byval as clong)
declare function __gmpf_init_set_str(byval as mpf_ptr, byval as const zstring ptr, byval as long) as long
declare function mpf_init_set_str alias "__gmpf_init_set_str"(byval as mpf_ptr, byval as const zstring ptr, byval as long) as long
declare sub __gmpf_init_set_ui(byval as mpf_ptr, byval as culong)
declare sub mpf_init_set_ui alias "__gmpf_init_set_ui"(byval as mpf_ptr, byval as culong)
declare function __gmpf_inp_str(byval as mpf_ptr, byval as FILE ptr, byval as long) as uinteger
declare function mpf_inp_str alias "__gmpf_inp_str"(byval as mpf_ptr, byval as FILE ptr, byval as long) as uinteger
declare function __gmpf_integer_p(byval as mpf_srcptr) as long
declare function mpf_integer_p alias "__gmpf_integer_p"(byval as mpf_srcptr) as long
declare sub __gmpf_mul(byval as mpf_ptr, byval as mpf_srcptr, byval as mpf_srcptr)
declare sub mpf_mul alias "__gmpf_mul"(byval as mpf_ptr, byval as mpf_srcptr, byval as mpf_srcptr)
declare sub __gmpf_mul_2exp(byval as mpf_ptr, byval as mpf_srcptr, byval as mp_bitcnt_t)
declare sub mpf_mul_2exp alias "__gmpf_mul_2exp"(byval as mpf_ptr, byval as mpf_srcptr, byval as mp_bitcnt_t)
declare sub __gmpf_mul_ui(byval as mpf_ptr, byval as mpf_srcptr, byval as culong)
declare sub mpf_mul_ui alias "__gmpf_mul_ui"(byval as mpf_ptr, byval as mpf_srcptr, byval as culong)
declare sub __gmpf_neg(byval as mpf_ptr, byval as mpf_srcptr)
declare sub mpf_neg alias "__gmpf_neg"(byval as mpf_ptr, byval as mpf_srcptr)
declare function __gmpf_out_str(byval as FILE ptr, byval as long, byval as uinteger, byval as mpf_srcptr) as uinteger
declare function mpf_out_str alias "__gmpf_out_str"(byval as FILE ptr, byval as long, byval as uinteger, byval as mpf_srcptr) as uinteger
declare sub __gmpf_pow_ui(byval as mpf_ptr, byval as mpf_srcptr, byval as culong)
declare sub mpf_pow_ui alias "__gmpf_pow_ui"(byval as mpf_ptr, byval as mpf_srcptr, byval as culong)
declare sub __gmpf_random2(byval as mpf_ptr, byval as mp_size_t, byval as mp_exp_t)
declare sub mpf_random2 alias "__gmpf_random2"(byval as mpf_ptr, byval as mp_size_t, byval as mp_exp_t)
declare sub __gmpf_reldiff(byval as mpf_ptr, byval as mpf_srcptr, byval as mpf_srcptr)
declare sub mpf_reldiff alias "__gmpf_reldiff"(byval as mpf_ptr, byval as mpf_srcptr, byval as mpf_srcptr)
declare sub __gmpf_set(byval as mpf_ptr, byval as mpf_srcptr)
declare sub mpf_set alias "__gmpf_set"(byval as mpf_ptr, byval as mpf_srcptr)
declare sub __gmpf_set_d(byval as mpf_ptr, byval as double)
declare sub mpf_set_d alias "__gmpf_set_d"(byval as mpf_ptr, byval as double)
declare sub __gmpf_set_default_prec(byval as mp_bitcnt_t)
declare sub mpf_set_default_prec alias "__gmpf_set_default_prec"(byval as mp_bitcnt_t)
declare sub __gmpf_set_prec(byval as mpf_ptr, byval as mp_bitcnt_t)
declare sub mpf_set_prec alias "__gmpf_set_prec"(byval as mpf_ptr, byval as mp_bitcnt_t)
declare sub __gmpf_set_prec_raw(byval as mpf_ptr, byval as mp_bitcnt_t)
declare sub mpf_set_prec_raw alias "__gmpf_set_prec_raw"(byval as mpf_ptr, byval as mp_bitcnt_t)
declare sub __gmpf_set_q(byval as mpf_ptr, byval as mpq_srcptr)
declare sub mpf_set_q alias "__gmpf_set_q"(byval as mpf_ptr, byval as mpq_srcptr)
declare sub __gmpf_set_si(byval as mpf_ptr, byval as clong)
declare sub mpf_set_si alias "__gmpf_set_si"(byval as mpf_ptr, byval as clong)
declare function __gmpf_set_str(byval as mpf_ptr, byval as const zstring ptr, byval as long) as long
declare function mpf_set_str alias "__gmpf_set_str"(byval as mpf_ptr, byval as const zstring ptr, byval as long) as long
declare sub __gmpf_set_ui(byval as mpf_ptr, byval as culong)
declare sub mpf_set_ui alias "__gmpf_set_ui"(byval as mpf_ptr, byval as culong)
declare sub __gmpf_set_z(byval as mpf_ptr, byval as mpz_srcptr)
declare sub mpf_set_z alias "__gmpf_set_z"(byval as mpf_ptr, byval as mpz_srcptr)
declare function __gmpf_size(byval as mpf_srcptr) as uinteger
declare function mpf_size alias "__gmpf_size"(byval as mpf_srcptr) as uinteger
declare sub __gmpf_sqrt(byval as mpf_ptr, byval as mpf_srcptr)
declare sub mpf_sqrt alias "__gmpf_sqrt"(byval as mpf_ptr, byval as mpf_srcptr)
declare sub __gmpf_sqrt_ui(byval as mpf_ptr, byval as culong)
declare sub mpf_sqrt_ui alias "__gmpf_sqrt_ui"(byval as mpf_ptr, byval as culong)
declare sub __gmpf_sub(byval as mpf_ptr, byval as mpf_srcptr, byval as mpf_srcptr)
declare sub mpf_sub alias "__gmpf_sub"(byval as mpf_ptr, byval as mpf_srcptr, byval as mpf_srcptr)
declare sub __gmpf_sub_ui(byval as mpf_ptr, byval as mpf_srcptr, byval as culong)
declare sub mpf_sub_ui alias "__gmpf_sub_ui"(byval as mpf_ptr, byval as mpf_srcptr, byval as culong)
declare sub __gmpf_swap(byval as mpf_ptr, byval as mpf_ptr)
declare sub mpf_swap alias "__gmpf_swap"(byval as mpf_ptr, byval as mpf_ptr)
declare sub __gmpf_trunc(byval as mpf_ptr, byval as mpf_srcptr)
declare sub mpf_trunc alias "__gmpf_trunc"(byval as mpf_ptr, byval as mpf_srcptr)
declare sub __gmpf_ui_div(byval as mpf_ptr, byval as culong, byval as mpf_srcptr)
declare sub mpf_ui_div alias "__gmpf_ui_div"(byval as mpf_ptr, byval as culong, byval as mpf_srcptr)
declare sub __gmpf_ui_sub(byval as mpf_ptr, byval as culong, byval as mpf_srcptr)
declare sub mpf_ui_sub alias "__gmpf_ui_sub"(byval as mpf_ptr, byval as culong, byval as mpf_srcptr)
declare sub __gmpf_urandomb(byval as __mpf_struct ptr, byval as __gmp_randstate_struct ptr, byval as mp_bitcnt_t)
declare sub mpf_urandomb alias "__gmpf_urandomb"(byval as __mpf_struct ptr, byval as __gmp_randstate_struct ptr, byval as mp_bitcnt_t)
declare function __gmpn_add(byval as mp_ptr, byval as mp_srcptr, byval as mp_size_t, byval as mp_srcptr, byval as mp_size_t) as mp_limb_t
declare function mpn_add alias "__gmpn_add"(byval as mp_ptr, byval as mp_srcptr, byval as mp_size_t, byval as mp_srcptr, byval as mp_size_t) as mp_limb_t
declare function __gmpn_add_1(byval as mp_ptr, byval as mp_srcptr, byval as mp_size_t, byval as mp_limb_t) as mp_limb_t
declare function mpn_add_1 alias "__gmpn_add_1"(byval as mp_ptr, byval as mp_srcptr, byval as mp_size_t, byval as mp_limb_t) as mp_limb_t
declare function __gmpn_add_n(byval as mp_ptr, byval as mp_srcptr, byval as mp_srcptr, byval as mp_size_t) as mp_limb_t
declare function mpn_add_n alias "__gmpn_add_n"(byval as mp_ptr, byval as mp_srcptr, byval as mp_srcptr, byval as mp_size_t) as mp_limb_t
declare function __gmpn_addmul_1(byval as mp_ptr, byval as mp_srcptr, byval as mp_size_t, byval as mp_limb_t) as mp_limb_t
declare function mpn_addmul_1 alias "__gmpn_addmul_1"(byval as mp_ptr, byval as mp_srcptr, byval as mp_size_t, byval as mp_limb_t) as mp_limb_t
declare function __gmpn_cmp(byval as mp_srcptr, byval as mp_srcptr, byval as mp_size_t) as long
declare function mpn_cmp alias "__gmpn_cmp"(byval as mp_srcptr, byval as mp_srcptr, byval as mp_size_t) as long
#define mpn_divexact_by3(dst, src, size) mpn_divexact_by3c(dst, src, size, cast(mp_limb_t, 0))
declare function __gmpn_divexact_by3c(byval as mp_ptr, byval as mp_srcptr, byval as mp_size_t, byval as mp_limb_t) as mp_limb_t
declare function mpn_divexact_by3c alias "__gmpn_divexact_by3c"(byval as mp_ptr, byval as mp_srcptr, byval as mp_size_t, byval as mp_limb_t) as mp_limb_t
#define mpn_divmod_1(qp, np, nsize, dlimb) mpn_divrem_1(qp, cast(mp_size_t, 0), np, nsize, dlimb)
declare function __gmpn_divrem(byval as mp_ptr, byval as mp_size_t, byval as mp_ptr, byval as mp_size_t, byval as mp_srcptr, byval as mp_size_t) as mp_limb_t
declare function mpn_divrem alias "__gmpn_divrem"(byval as mp_ptr, byval as mp_size_t, byval as mp_ptr, byval as mp_size_t, byval as mp_srcptr, byval as mp_size_t) as mp_limb_t
declare function __gmpn_divrem_1(byval as mp_ptr, byval as mp_size_t, byval as mp_srcptr, byval as mp_size_t, byval as mp_limb_t) as mp_limb_t
declare function mpn_divrem_1 alias "__gmpn_divrem_1"(byval as mp_ptr, byval as mp_size_t, byval as mp_srcptr, byval as mp_size_t, byval as mp_limb_t) as mp_limb_t
declare function __gmpn_divrem_2(byval as mp_ptr, byval as mp_size_t, byval as mp_ptr, byval as mp_size_t, byval as mp_srcptr) as mp_limb_t
declare function mpn_divrem_2 alias "__gmpn_divrem_2"(byval as mp_ptr, byval as mp_size_t, byval as mp_ptr, byval as mp_size_t, byval as mp_srcptr) as mp_limb_t
declare function __gmpn_div_qr_1(byval as mp_ptr, byval as mp_limb_t ptr, byval as mp_srcptr, byval as mp_size_t, byval as mp_limb_t) as mp_limb_t
declare function mpn_div_qr_1 alias "__gmpn_div_qr_1"(byval as mp_ptr, byval as mp_limb_t ptr, byval as mp_srcptr, byval as mp_size_t, byval as mp_limb_t) as mp_limb_t
declare function __gmpn_div_qr_2(byval as mp_ptr, byval as mp_ptr, byval as mp_srcptr, byval as mp_size_t, byval as mp_srcptr) as mp_limb_t
declare function mpn_div_qr_2 alias "__gmpn_div_qr_2"(byval as mp_ptr, byval as mp_ptr, byval as mp_srcptr, byval as mp_size_t, byval as mp_srcptr) as mp_limb_t
declare function __gmpn_gcd(byval as mp_ptr, byval as mp_ptr, byval as mp_size_t, byval as mp_ptr, byval as mp_size_t) as mp_size_t
declare function mpn_gcd alias "__gmpn_gcd"(byval as mp_ptr, byval as mp_ptr, byval as mp_size_t, byval as mp_ptr, byval as mp_size_t) as mp_size_t
declare function __gmpn_gcd_1(byval as mp_srcptr, byval as mp_size_t, byval as mp_limb_t) as mp_limb_t
declare function mpn_gcd_1 alias "__gmpn_gcd_1"(byval as mp_srcptr, byval as mp_size_t, byval as mp_limb_t) as mp_limb_t
declare function __gmpn_gcdext_1(byval as mp_limb_signed_t ptr, byval as mp_limb_signed_t ptr, byval as mp_limb_t, byval as mp_limb_t) as mp_limb_t
declare function mpn_gcdext_1 alias "__gmpn_gcdext_1"(byval as mp_limb_signed_t ptr, byval as mp_limb_signed_t ptr, byval as mp_limb_t, byval as mp_limb_t) as mp_limb_t
declare function __gmpn_gcdext(byval as mp_ptr, byval as mp_ptr, byval as mp_size_t ptr, byval as mp_ptr, byval as mp_size_t, byval as mp_ptr, byval as mp_size_t) as mp_size_t
declare function mpn_gcdext alias "__gmpn_gcdext"(byval as mp_ptr, byval as mp_ptr, byval as mp_size_t ptr, byval as mp_ptr, byval as mp_size_t, byval as mp_ptr, byval as mp_size_t) as mp_size_t
declare function __gmpn_get_str(byval as ubyte ptr, byval as long, byval as mp_ptr, byval as mp_size_t) as uinteger
declare function mpn_get_str alias "__gmpn_get_str"(byval as ubyte ptr, byval as long, byval as mp_ptr, byval as mp_size_t) as uinteger
declare function __gmpn_hamdist(byval as mp_srcptr, byval as mp_srcptr, byval as mp_size_t) as mp_bitcnt_t
declare function mpn_hamdist alias "__gmpn_hamdist"(byval as mp_srcptr, byval as mp_srcptr, byval as mp_size_t) as mp_bitcnt_t
declare function __gmpn_lshift(byval as mp_ptr, byval as mp_srcptr, byval as mp_size_t, byval as ulong) as mp_limb_t
declare function mpn_lshift alias "__gmpn_lshift"(byval as mp_ptr, byval as mp_srcptr, byval as mp_size_t, byval as ulong) as mp_limb_t
declare function __gmpn_mod_1(byval as mp_srcptr, byval as mp_size_t, byval as mp_limb_t) as mp_limb_t
declare function mpn_mod_1 alias "__gmpn_mod_1"(byval as mp_srcptr, byval as mp_size_t, byval as mp_limb_t) as mp_limb_t
declare function __gmpn_mul(byval as mp_ptr, byval as mp_srcptr, byval as mp_size_t, byval as mp_srcptr, byval as mp_size_t) as mp_limb_t
declare function mpn_mul alias "__gmpn_mul"(byval as mp_ptr, byval as mp_srcptr, byval as mp_size_t, byval as mp_srcptr, byval as mp_size_t) as mp_limb_t
declare function __gmpn_mul_1(byval as mp_ptr, byval as mp_srcptr, byval as mp_size_t, byval as mp_limb_t) as mp_limb_t
declare function mpn_mul_1 alias "__gmpn_mul_1"(byval as mp_ptr, byval as mp_srcptr, byval as mp_size_t, byval as mp_limb_t) as mp_limb_t
declare sub __gmpn_mul_n(byval as mp_ptr, byval as mp_srcptr, byval as mp_srcptr, byval as mp_size_t)
declare sub mpn_mul_n alias "__gmpn_mul_n"(byval as mp_ptr, byval as mp_srcptr, byval as mp_srcptr, byval as mp_size_t)
declare sub __gmpn_sqr(byval as mp_ptr, byval as mp_srcptr, byval as mp_size_t)
declare sub mpn_sqr alias "__gmpn_sqr"(byval as mp_ptr, byval as mp_srcptr, byval as mp_size_t)
declare function __gmpn_neg(byval as mp_ptr, byval as mp_srcptr, byval as mp_size_t) as mp_limb_t
declare function mpn_neg alias "__gmpn_neg"(byval as mp_ptr, byval as mp_srcptr, byval as mp_size_t) as mp_limb_t
declare sub __gmpn_com(byval as mp_ptr, byval as mp_srcptr, byval as mp_size_t)
declare sub mpn_com alias "__gmpn_com"(byval as mp_ptr, byval as mp_srcptr, byval as mp_size_t)
declare function __gmpn_perfect_square_p(byval as mp_srcptr, byval as mp_size_t) as long
declare function mpn_perfect_square_p alias "__gmpn_perfect_square_p"(byval as mp_srcptr, byval as mp_size_t) as long
declare function __gmpn_perfect_power_p(byval as mp_srcptr, byval as mp_size_t) as long
declare function mpn_perfect_power_p alias "__gmpn_perfect_power_p"(byval as mp_srcptr, byval as mp_size_t) as long
declare function __gmpn_popcount(byval as mp_srcptr, byval as mp_size_t) as mp_bitcnt_t
declare function mpn_popcount alias "__gmpn_popcount"(byval as mp_srcptr, byval as mp_size_t) as mp_bitcnt_t
declare function __gmpn_pow_1(byval as mp_ptr, byval as mp_srcptr, byval as mp_size_t, byval as mp_limb_t, byval as mp_ptr) as mp_size_t
declare function mpn_pow_1 alias "__gmpn_pow_1"(byval as mp_ptr, byval as mp_srcptr, byval as mp_size_t, byval as mp_limb_t, byval as mp_ptr) as mp_size_t
declare function __gmpn_preinv_mod_1(byval as mp_srcptr, byval as mp_size_t, byval as mp_limb_t, byval as mp_limb_t) as mp_limb_t
declare function mpn_preinv_mod_1 alias "__gmpn_preinv_mod_1"(byval as mp_srcptr, byval as mp_size_t, byval as mp_limb_t, byval as mp_limb_t) as mp_limb_t
declare sub __gmpn_random(byval as mp_ptr, byval as mp_size_t)
declare sub mpn_random alias "__gmpn_random"(byval as mp_ptr, byval as mp_size_t)
declare sub __gmpn_random2(byval as mp_ptr, byval as mp_size_t)
declare sub mpn_random2 alias "__gmpn_random2"(byval as mp_ptr, byval as mp_size_t)
declare function __gmpn_rshift(byval as mp_ptr, byval as mp_srcptr, byval as mp_size_t, byval as ulong) as mp_limb_t
declare function mpn_rshift alias "__gmpn_rshift"(byval as mp_ptr, byval as mp_srcptr, byval as mp_size_t, byval as ulong) as mp_limb_t
declare function __gmpn_scan0(byval as mp_srcptr, byval as mp_bitcnt_t) as mp_bitcnt_t
declare function mpn_scan0 alias "__gmpn_scan0"(byval as mp_srcptr, byval as mp_bitcnt_t) as mp_bitcnt_t
declare function __gmpn_scan1(byval as mp_srcptr, byval as mp_bitcnt_t) as mp_bitcnt_t
declare function mpn_scan1 alias "__gmpn_scan1"(byval as mp_srcptr, byval as mp_bitcnt_t) as mp_bitcnt_t
declare function __gmpn_set_str(byval as mp_ptr, byval as const ubyte ptr, byval as uinteger, byval as long) as mp_size_t
declare function mpn_set_str alias "__gmpn_set_str"(byval as mp_ptr, byval as const ubyte ptr, byval as uinteger, byval as long) as mp_size_t
declare function __gmpn_sizeinbase(byval as mp_srcptr, byval as mp_size_t, byval as long) as uinteger
declare function mpn_sizeinbase alias "__gmpn_sizeinbase"(byval as mp_srcptr, byval as mp_size_t, byval as long) as uinteger
declare function __gmpn_sqrtrem(byval as mp_ptr, byval as mp_ptr, byval as mp_srcptr, byval as mp_size_t) as mp_size_t
declare function mpn_sqrtrem alias "__gmpn_sqrtrem"(byval as mp_ptr, byval as mp_ptr, byval as mp_srcptr, byval as mp_size_t) as mp_size_t
declare function __gmpn_sub(byval as mp_ptr, byval as mp_srcptr, byval as mp_size_t, byval as mp_srcptr, byval as mp_size_t) as mp_limb_t
declare function mpn_sub alias "__gmpn_sub"(byval as mp_ptr, byval as mp_srcptr, byval as mp_size_t, byval as mp_srcptr, byval as mp_size_t) as mp_limb_t
declare function __gmpn_sub_1(byval as mp_ptr, byval as mp_srcptr, byval as mp_size_t, byval as mp_limb_t) as mp_limb_t
declare function mpn_sub_1 alias "__gmpn_sub_1"(byval as mp_ptr, byval as mp_srcptr, byval as mp_size_t, byval as mp_limb_t) as mp_limb_t
declare function __gmpn_sub_n(byval as mp_ptr, byval as mp_srcptr, byval as mp_srcptr, byval as mp_size_t) as mp_limb_t
declare function mpn_sub_n alias "__gmpn_sub_n"(byval as mp_ptr, byval as mp_srcptr, byval as mp_srcptr, byval as mp_size_t) as mp_limb_t
declare function __gmpn_submul_1(byval as mp_ptr, byval as mp_srcptr, byval as mp_size_t, byval as mp_limb_t) as mp_limb_t
declare function mpn_submul_1 alias "__gmpn_submul_1"(byval as mp_ptr, byval as mp_srcptr, byval as mp_size_t, byval as mp_limb_t) as mp_limb_t
declare sub __gmpn_tdiv_qr(byval as mp_ptr, byval as mp_ptr, byval as mp_size_t, byval as mp_srcptr, byval as mp_size_t, byval as mp_srcptr, byval as mp_size_t)
declare sub mpn_tdiv_qr alias "__gmpn_tdiv_qr"(byval as mp_ptr, byval as mp_ptr, byval as mp_size_t, byval as mp_srcptr, byval as mp_size_t, byval as mp_srcptr, byval as mp_size_t)
declare sub __gmpn_and_n(byval as mp_ptr, byval as mp_srcptr, byval as mp_srcptr, byval as mp_size_t)
declare sub mpn_and_n alias "__gmpn_and_n"(byval as mp_ptr, byval as mp_srcptr, byval as mp_srcptr, byval as mp_size_t)
declare sub __gmpn_andn_n(byval as mp_ptr, byval as mp_srcptr, byval as mp_srcptr, byval as mp_size_t)
declare sub mpn_andn_n alias "__gmpn_andn_n"(byval as mp_ptr, byval as mp_srcptr, byval as mp_srcptr, byval as mp_size_t)
declare sub __gmpn_nand_n(byval as mp_ptr, byval as mp_srcptr, byval as mp_srcptr, byval as mp_size_t)
declare sub mpn_nand_n alias "__gmpn_nand_n"(byval as mp_ptr, byval as mp_srcptr, byval as mp_srcptr, byval as mp_size_t)
declare sub __gmpn_ior_n(byval as mp_ptr, byval as mp_srcptr, byval as mp_srcptr, byval as mp_size_t)
declare sub mpn_ior_n alias "__gmpn_ior_n"(byval as mp_ptr, byval as mp_srcptr, byval as mp_srcptr, byval as mp_size_t)
declare sub __gmpn_iorn_n(byval as mp_ptr, byval as mp_srcptr, byval as mp_srcptr, byval as mp_size_t)
declare sub mpn_iorn_n alias "__gmpn_iorn_n"(byval as mp_ptr, byval as mp_srcptr, byval as mp_srcptr, byval as mp_size_t)
declare sub __gmpn_nior_n(byval as mp_ptr, byval as mp_srcptr, byval as mp_srcptr, byval as mp_size_t)
declare sub mpn_nior_n alias "__gmpn_nior_n"(byval as mp_ptr, byval as mp_srcptr, byval as mp_srcptr, byval as mp_size_t)
declare sub __gmpn_xor_n(byval as mp_ptr, byval as mp_srcptr, byval as mp_srcptr, byval as mp_size_t)
declare sub mpn_xor_n alias "__gmpn_xor_n"(byval as mp_ptr, byval as mp_srcptr, byval as mp_srcptr, byval as mp_size_t)
declare sub __gmpn_xnor_n(byval as mp_ptr, byval as mp_srcptr, byval as mp_srcptr, byval as mp_size_t)
declare sub mpn_xnor_n alias "__gmpn_xnor_n"(byval as mp_ptr, byval as mp_srcptr, byval as mp_srcptr, byval as mp_size_t)
declare sub __gmpn_copyi(byval as mp_ptr, byval as mp_srcptr, byval as mp_size_t)
declare sub mpn_copyi alias "__gmpn_copyi"(byval as mp_ptr, byval as mp_srcptr, byval as mp_size_t)
declare sub __gmpn_copyd(byval as mp_ptr, byval as mp_srcptr, byval as mp_size_t)
declare sub mpn_copyd alias "__gmpn_copyd"(byval as mp_ptr, byval as mp_srcptr, byval as mp_size_t)
declare sub __gmpn_zero(byval as mp_ptr, byval as mp_size_t)
declare sub mpn_zero alias "__gmpn_zero"(byval as mp_ptr, byval as mp_size_t)
declare function __gmpn_cnd_add_n(byval as mp_limb_t, byval as mp_ptr, byval as mp_srcptr, byval as mp_srcptr, byval as mp_size_t) as mp_limb_t
declare function mpn_cnd_add_n alias "__gmpn_cnd_add_n"(byval as mp_limb_t, byval as mp_ptr, byval as mp_srcptr, byval as mp_srcptr, byval as mp_size_t) as mp_limb_t
declare function __gmpn_cnd_sub_n(byval as mp_limb_t, byval as mp_ptr, byval as mp_srcptr, byval as mp_srcptr, byval as mp_size_t) as mp_limb_t
declare function mpn_cnd_sub_n alias "__gmpn_cnd_sub_n"(byval as mp_limb_t, byval as mp_ptr, byval as mp_srcptr, byval as mp_srcptr, byval as mp_size_t) as mp_limb_t
declare function __gmpn_sec_add_1(byval as mp_ptr, byval as mp_srcptr, byval as mp_size_t, byval as mp_limb_t, byval as mp_ptr) as mp_limb_t
declare function mpn_sec_add_1 alias "__gmpn_sec_add_1"(byval as mp_ptr, byval as mp_srcptr, byval as mp_size_t, byval as mp_limb_t, byval as mp_ptr) as mp_limb_t
declare function __gmpn_sec_add_1_itch(byval as mp_size_t) as mp_size_t
declare function mpn_sec_add_1_itch alias "__gmpn_sec_add_1_itch"(byval as mp_size_t) as mp_size_t
declare function __gmpn_sec_sub_1(byval as mp_ptr, byval as mp_srcptr, byval as mp_size_t, byval as mp_limb_t, byval as mp_ptr) as mp_limb_t
declare function mpn_sec_sub_1 alias "__gmpn_sec_sub_1"(byval as mp_ptr, byval as mp_srcptr, byval as mp_size_t, byval as mp_limb_t, byval as mp_ptr) as mp_limb_t
declare function __gmpn_sec_sub_1_itch(byval as mp_size_t) as mp_size_t
declare function mpn_sec_sub_1_itch alias "__gmpn_sec_sub_1_itch"(byval as mp_size_t) as mp_size_t
declare sub __gmpn_sec_mul(byval as mp_ptr, byval as mp_srcptr, byval as mp_size_t, byval as mp_srcptr, byval as mp_size_t, byval as mp_ptr)
declare sub mpn_sec_mul alias "__gmpn_sec_mul"(byval as mp_ptr, byval as mp_srcptr, byval as mp_size_t, byval as mp_srcptr, byval as mp_size_t, byval as mp_ptr)
declare function __gmpn_sec_mul_itch(byval as mp_size_t, byval as mp_size_t) as mp_size_t
declare function mpn_sec_mul_itch alias "__gmpn_sec_mul_itch"(byval as mp_size_t, byval as mp_size_t) as mp_size_t
declare sub __gmpn_sec_sqr(byval as mp_ptr, byval as mp_srcptr, byval as mp_size_t, byval as mp_ptr)
declare sub mpn_sec_sqr alias "__gmpn_sec_sqr"(byval as mp_ptr, byval as mp_srcptr, byval as mp_size_t, byval as mp_ptr)
declare function __gmpn_sec_sqr_itch(byval as mp_size_t) as mp_size_t
declare function mpn_sec_sqr_itch alias "__gmpn_sec_sqr_itch"(byval as mp_size_t) as mp_size_t
declare sub __gmpn_sec_powm(byval as mp_ptr, byval as mp_srcptr, byval as mp_size_t, byval as mp_srcptr, byval as mp_bitcnt_t, byval as mp_srcptr, byval as mp_size_t, byval as mp_ptr)
declare sub mpn_sec_powm alias "__gmpn_sec_powm"(byval as mp_ptr, byval as mp_srcptr, byval as mp_size_t, byval as mp_srcptr, byval as mp_bitcnt_t, byval as mp_srcptr, byval as mp_size_t, byval as mp_ptr)
declare function __gmpn_sec_powm_itch(byval as mp_size_t, byval as mp_bitcnt_t, byval as mp_size_t) as mp_size_t
declare function mpn_sec_powm_itch alias "__gmpn_sec_powm_itch"(byval as mp_size_t, byval as mp_bitcnt_t, byval as mp_size_t) as mp_size_t
declare sub __gmpn_sec_tabselect(byval as mp_limb_t ptr, byval as const mp_limb_t ptr, byval as mp_size_t, byval as mp_size_t, byval as mp_size_t)
declare sub mpn_sec_tabselect alias "__gmpn_sec_tabselect"(byval as mp_limb_t ptr, byval as const mp_limb_t ptr, byval as mp_size_t, byval as mp_size_t, byval as mp_size_t)
declare function __gmpn_sec_div_qr(byval as mp_ptr, byval as mp_ptr, byval as mp_size_t, byval as mp_srcptr, byval as mp_size_t, byval as mp_ptr) as mp_limb_t
declare function mpn_sec_div_qr alias "__gmpn_sec_div_qr"(byval as mp_ptr, byval as mp_ptr, byval as mp_size_t, byval as mp_srcptr, byval as mp_size_t, byval as mp_ptr) as mp_limb_t
declare function __gmpn_sec_div_qr_itch(byval as mp_size_t, byval as mp_size_t) as mp_size_t
declare function mpn_sec_div_qr_itch alias "__gmpn_sec_div_qr_itch"(byval as mp_size_t, byval as mp_size_t) as mp_size_t
declare sub __gmpn_sec_div_r(byval as mp_ptr, byval as mp_size_t, byval as mp_srcptr, byval as mp_size_t, byval as mp_ptr)
declare sub mpn_sec_div_r alias "__gmpn_sec_div_r"(byval as mp_ptr, byval as mp_size_t, byval as mp_srcptr, byval as mp_size_t, byval as mp_ptr)
declare function __gmpn_sec_div_r_itch(byval as mp_size_t, byval as mp_size_t) as mp_size_t
declare function mpn_sec_div_r_itch alias "__gmpn_sec_div_r_itch"(byval as mp_size_t, byval as mp_size_t) as mp_size_t
declare function __gmpn_sec_invert(byval as mp_ptr, byval as mp_ptr, byval as mp_srcptr, byval as mp_size_t, byval as mp_bitcnt_t, byval as mp_ptr) as long
declare function mpn_sec_invert alias "__gmpn_sec_invert"(byval as mp_ptr, byval as mp_ptr, byval as mp_srcptr, byval as mp_size_t, byval as mp_bitcnt_t, byval as mp_ptr) as long
declare function __gmpn_sec_invert_itch(byval as mp_size_t) as mp_size_t
declare function mpn_sec_invert_itch alias "__gmpn_sec_invert_itch"(byval as mp_size_t) as mp_size_t

#define mpz_sgn(Z) iif((Z)->_mp_size < 0, -1, -((Z)->_mp_size > 0))
#define mpf_sgn(F) iif((F)->_mp_size < 0, -1, -((F)->_mp_size > 0))
#define mpq_sgn(Q) iif((Q)->_mp_num._mp_size < 0, -1, -((Q)->_mp_num._mp_size > 0))
#define mpz_cmp_ui(Z, UI) _mpz_cmp_ui(Z, UI)
#define mpz_cmp_si(Z, SI) _mpz_cmp_si(Z, SI)
#define mpq_cmp_ui(Q, NUI, DUI) _mpq_cmp_ui(Q, NUI, DUI)
#define mpq_cmp_si(q, n, d) _mpq_cmp_si(q, n, d)
#define mpz_odd_p(z) ((-((z)->_mp_size <> 0)) and clng((z)->_mp_d[0]))
#define mpz_even_p(z) (mpz_odd_p(z) = 0)
#define mpn_divmod(qp, np, nsize, dp, dsize) mpn_divrem(qp, cast(mp_size_t, 0), np, nsize, dp, dsize)

declare sub mpz_mdiv alias "__gmpz_fdiv_q"(byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare sub mpz_mdivmod alias "__gmpz_fdiv_qr"(byval as mpz_ptr, byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare sub mpz_mmod alias "__gmpz_fdiv_r"(byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare function mpz_mdiv_ui alias "__gmpz_fdiv_q_ui"(byval as mpz_ptr, byval as mpz_srcptr, byval as culong) as culong
#define mpz_mdivmod_ui(q, r, n, d) iif((r) = 0, mpz_fdiv_q_ui(q, n, d), mpz_fdiv_qr_ui(q, r, n, d))
#define mpz_mmod_ui(r, n, d) iif((r) = 0, mpz_fdiv_ui(n, d), mpz_fdiv_r_ui(r, n, d))
declare sub mpz_div alias "__gmpz_fdiv_q"(byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare sub mpz_divmod alias "__gmpz_fdiv_qr"(byval as mpz_ptr, byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare function mpz_div_ui alias "__gmpz_fdiv_q_ui"(byval as mpz_ptr, byval as mpz_srcptr, byval as culong) as culong
declare function mpz_divmod_ui alias "__gmpz_fdiv_qr_ui"(byval as mpz_ptr, byval as mpz_ptr, byval as mpz_srcptr, byval as culong) as culong
declare sub mpz_div_2exp alias "__gmpz_fdiv_q_2exp"(byval as mpz_ptr, byval as mpz_srcptr, byval as mp_bitcnt_t)
declare sub mpz_mod_2exp alias "__gmpz_fdiv_r_2exp"(byval as mpz_ptr, byval as mpz_srcptr, byval as mp_bitcnt_t)

enum
	GMP_ERROR_NONE = 0
	GMP_ERROR_UNSUPPORTED_ARGUMENT = 1
	GMP_ERROR_DIVISION_BY_ZERO = 2
	GMP_ERROR_SQRT_OF_NEGATIVE = 4
	GMP_ERROR_INVALID_ARGUMENT = 8
end enum

#define __GMP_CC ""
#define __GMP_CFLAGS ""
const __GNU_MP_VERSION = 6
const __GNU_MP_VERSION_MINOR = 0
const __GNU_MP_VERSION_PATCHLEVEL = 0
const __GNU_MP_RELEASE = ((__GNU_MP_VERSION * 10000) + (__GNU_MP_VERSION_MINOR * 100)) + __GNU_MP_VERSION_PATCHLEVEL
#define __GMP_H__

end extern
