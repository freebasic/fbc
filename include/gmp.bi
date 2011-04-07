''
''
'' gmp -- GNU Multiple Precision Arithmetic Library
''        (header translated with help of SWIG FB wrapper)
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gmp_bi__
#define __gmp_bi__

#inclib "gmp"

#define __GMP_BITS_PER_MP_LIMB 32
#define GMP_LIMB_BITS 32
#define GMP_NAIL_BITS 0
#define GMP_NUMB_BITS (32-0)
#define __GNU_MP__ 4

type mp_limb_t as uinteger
type mp_limb_signed_t as integer
type mp_ptr as mp_limb_t ptr
type mp_srcptr as mp_limb_t ptr

#define __GMP_MP_SIZE_T_INT 0

type mp_size_t as integer
type mp_exp_t as integer

type __mpz_struct
	_mp_alloc as integer
	_mp_size as integer
	_mp_d as mp_limb_t ptr
end type

type MP_INT as __mpz_struct
type mpz_t as __mpz_struct

type __mpq_struct
	_mp_num as __mpz_struct
	_mp_den as __mpz_struct
end type

type MP_RAT as __mpq_struct
type mpq_t as __mpq_struct

type __mpf_struct
	_mp_prec as integer
	_mp_size as integer
	_mp_exp as mp_exp_t
	_mp_d as mp_limb_t ptr
end type

type mpf_t as __mpf_struct

enum gmp_randalg_t
	GMP_RAND_ALG_DEFAULT = 0
	GMP_RAND_ALG_LC = GMP_RAND_ALG_DEFAULT
end enum


type __gmp_randata_lc
	_mp_a as mpz_t
	_mp_c as uinteger
	_mp_m as mpz_t
	_mp_m2exp as uinteger
end type

union _mp_algdata
	_mp_lc as __gmp_randata_lc ptr
end union

type __gmp_randstate_struct
	_mp_seed as mpz_t
	_mp_alg as gmp_randalg_t
	_mp_algdata as _mp_algdata
end type

type gmp_randstate_t as __gmp_randstate_struct
type mpz_srcptr as __mpz_struct ptr
type mpz_ptr as __mpz_struct ptr
type mpf_srcptr as __mpf_struct ptr
type mpf_ptr as __mpf_struct ptr
type mpq_srcptr as __mpq_struct ptr
type mpq_ptr as __mpq_struct ptr

#define __GMP_INLINE_PROTOTYPES 1

declare sub gmp_randinit cdecl alias "__gmp_randinit" (byval as gmp_randstate_t, byval as gmp_randalg_t, ...)
declare sub gmp_randinit_default cdecl alias "__gmp_randinit_default" (byval as gmp_randstate_t)
declare sub gmp_randinit_lc cdecl alias "__gmp_randinit_lc" (byval as gmp_randstate_t, byval as mpz_srcptr, byval as uinteger, byval as mpz_srcptr)
declare sub gmp_randinit_lc_2exp cdecl alias "__gmp_randinit_lc_2exp" (byval as gmp_randstate_t, byval as mpz_srcptr, byval as uinteger, byval as uinteger)
declare function gmp_randinit_lc_2exp_size cdecl alias "__gmp_randinit_lc_2exp_size" (byval as gmp_randstate_t, byval as uinteger) as integer
declare sub gmp_randseed cdecl alias "__gmp_randseed" (byval as gmp_randstate_t, byval as mpz_srcptr)
declare sub gmp_randseed_ui cdecl alias "__gmp_randseed_ui" (byval as gmp_randstate_t, byval as uinteger)
declare sub gmp_randclear cdecl alias "__gmp_randclear" (byval as gmp_randstate_t)
declare function gmp_asprintf cdecl alias "__gmp_asprintf" (byval as byte ptr ptr, byval as zstring ptr, ...) as integer
declare function gmp_printf cdecl alias "__gmp_printf" (byval as zstring ptr, ...) as integer
declare function gmp_snprintf cdecl alias "__gmp_snprintf" (byval as zstring ptr, byval as integer, byval as zstring ptr, ...) as integer
declare function gmp_sprintf cdecl alias "__gmp_sprintf" (byval as zstring ptr, byval as zstring ptr, ...) as integer
declare function gmp_scanf cdecl alias "__gmp_scanf" (byval as zstring ptr, ...) as integer
declare function gmp_sscanf cdecl alias "__gmp_sscanf" (byval as zstring ptr, byval as zstring ptr, ...) as integer

''**************** Integer (i.e. Z) routines.  ****************

declare function mpz_realloc cdecl alias "__gmpz_realloc" (byval as mpz_ptr, byval as mp_size_t) as any ptr
declare sub mpz_abs cdecl alias "__gmpz_abs" (byval as mpz_ptr, byval as mpz_srcptr)
declare sub mpz_add cdecl alias "__gmpz_add" (byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare sub mpz_add_ui cdecl alias "__gmpz_add_ui" (byval as mpz_ptr, byval as mpz_srcptr, byval as uinteger)
declare sub mpz_addmul cdecl alias "__gmpz_addmul" (byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare sub mpz_addmul_ui cdecl alias "__gmpz_addmul_ui" (byval as mpz_ptr, byval as mpz_srcptr, byval as uinteger)
declare sub mpz_and cdecl alias "__gmpz_and" (byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare sub mpz_array_init cdecl alias "__gmpz_array_init" (byval as mpz_ptr, byval as mp_size_t, byval as mp_size_t)
declare sub mpz_bin_ui cdecl alias "__gmpz_bin_ui" (byval as mpz_ptr, byval as mpz_srcptr, byval as uinteger)
declare sub mpz_bin_uiui cdecl alias "__gmpz_bin_uiui" (byval as mpz_ptr, byval as uinteger, byval as uinteger)
declare sub mpz_cdiv_q cdecl alias "__gmpz_cdiv_q" (byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare sub mpz_cdiv_q_2exp cdecl alias "__gmpz_cdiv_q_2exp" (byval as mpz_ptr, byval as mpz_srcptr, byval as uinteger)
declare function mpz_cdiv_q_ui cdecl alias "__gmpz_cdiv_q_ui" (byval as mpz_ptr, byval as mpz_srcptr, byval as uinteger) as uinteger
declare sub mpz_cdiv_qr cdecl alias "__gmpz_cdiv_qr" (byval as mpz_ptr, byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare function mpz_cdiv_qr_ui cdecl alias "__gmpz_cdiv_qr_ui" (byval as mpz_ptr, byval as mpz_ptr, byval as mpz_srcptr, byval as uinteger) as uinteger
declare sub mpz_cdiv_r cdecl alias "__gmpz_cdiv_r" (byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare sub mpz_cdiv_r_2exp cdecl alias "__gmpz_cdiv_r_2exp" (byval as mpz_ptr, byval as mpz_srcptr, byval as uinteger)
declare function mpz_cdiv_r_ui cdecl alias "__gmpz_cdiv_r_ui" (byval as mpz_ptr, byval as mpz_srcptr, byval as uinteger) as uinteger
declare function mpz_cdiv_ui cdecl alias "__gmpz_cdiv_ui" (byval as mpz_srcptr, byval as uinteger) as uinteger
declare sub mpz_clear cdecl alias "__gmpz_clear" (byval as mpz_ptr)
declare sub mpz_clrbit cdecl alias "__gmpz_clrbit" (byval as mpz_ptr, byval as uinteger)
declare function mpz_cmp cdecl alias "__gmpz_cmp" (byval as mpz_srcptr, byval as mpz_srcptr) as integer
declare function mpz_cmp_d cdecl alias "__gmpz_cmp_d" (byval as mpz_srcptr, byval as double) as integer
declare function mpz_cmp_si cdecl alias "__gmpz_cmp_si" (byval as mpz_srcptr, byval as integer) as integer
declare function mpz_cmp_ui cdecl alias "__gmpz_cmp_ui" (byval as mpz_srcptr, byval as uinteger) as integer
declare function mpz_cmpabs cdecl alias "__gmpz_cmpabs" (byval as mpz_srcptr, byval as mpz_srcptr) as integer
declare function mpz_cmpabs_d cdecl alias "__gmpz_cmpabs_d" (byval as mpz_srcptr, byval as double) as integer
declare function mpz_cmpabs_ui cdecl alias "__gmpz_cmpabs_ui" (byval as mpz_srcptr, byval as uinteger) as integer
declare sub mpz_com cdecl alias "__gmpz_com" (byval as mpz_ptr, byval as mpz_srcptr)
declare function mpz_congruent_p cdecl alias "__gmpz_congruent_p" (byval as mpz_srcptr, byval as mpz_srcptr, byval as mpz_srcptr) as integer
declare function mpz_congruent_2exp_p cdecl alias "__gmpz_congruent_2exp_p" (byval as mpz_srcptr, byval as mpz_srcptr, byval as uinteger) as integer
declare function mpz_congruent_ui_p cdecl alias "__gmpz_congruent_ui_p" (byval as mpz_srcptr, byval as uinteger, byval as uinteger) as integer
declare sub mpz_divexact cdecl alias "__gmpz_divexact" (byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare sub mpz_divexact_ui cdecl alias "__gmpz_divexact_ui" (byval as mpz_ptr, byval as mpz_srcptr, byval as uinteger)
declare function mpz_divisible_p cdecl alias "__gmpz_divisible_p" (byval as mpz_srcptr, byval as mpz_srcptr) as integer
declare function mpz_divisible_ui_p cdecl alias "__gmpz_divisible_ui_p" (byval as mpz_srcptr, byval as uinteger) as integer
declare function mpz_divisible_2exp_p cdecl alias "__gmpz_divisible_2exp_p" (byval as mpz_srcptr, byval as uinteger) as integer
declare sub mpz_dump cdecl alias "__gmpz_dump" (byval as mpz_srcptr)
declare function mpz_export cdecl alias "__gmpz_export" (byval as any ptr, byval as integer ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as mpz_srcptr) as any ptr
declare sub mpz_fac_ui cdecl alias "__gmpz_fac_ui" (byval as mpz_ptr, byval as uinteger)
declare sub mpz_fdiv_q cdecl alias "__gmpz_fdiv_q" (byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare sub mpz_fdiv_q_2exp cdecl alias "__gmpz_fdiv_q_2exp" (byval as mpz_ptr, byval as mpz_srcptr, byval as uinteger)
declare function mpz_fdiv_q_ui cdecl alias "__gmpz_fdiv_q_ui" (byval as mpz_ptr, byval as mpz_srcptr, byval as uinteger) as uinteger
declare sub mpz_fdiv_qr cdecl alias "__gmpz_fdiv_qr" (byval as mpz_ptr, byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare function mpz_fdiv_qr_ui cdecl alias "__gmpz_fdiv_qr_ui" (byval as mpz_ptr, byval as mpz_ptr, byval as mpz_srcptr, byval as uinteger) as uinteger
declare sub mpz_fdiv_r cdecl alias "__gmpz_fdiv_r" (byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare sub mpz_fdiv_r_2exp cdecl alias "__gmpz_fdiv_r_2exp" (byval as mpz_ptr, byval as mpz_srcptr, byval as uinteger)
declare function mpz_fdiv_r_ui cdecl alias "__gmpz_fdiv_r_ui" (byval as mpz_ptr, byval as mpz_srcptr, byval as uinteger) as uinteger
declare function mpz_fdiv_ui cdecl alias "__gmpz_fdiv_ui" (byval as mpz_srcptr, byval as uinteger) as uinteger
declare sub mpz_fib_ui cdecl alias "__gmpz_fib_ui" (byval as mpz_ptr, byval as uinteger)
declare sub mpz_fib2_ui cdecl alias "__gmpz_fib2_ui" (byval as mpz_ptr, byval as mpz_ptr, byval as uinteger)
declare function mpz_fits_sint_p cdecl alias "__gmpz_fits_sint_p" (byval as mpz_srcptr) as integer
declare function mpz_fits_slong_p cdecl alias "__gmpz_fits_slong_p" (byval as mpz_srcptr) as integer
declare function mpz_fits_sshort_p cdecl alias "__gmpz_fits_sshort_p" (byval as mpz_srcptr) as integer
declare function mpz_fits_uint_p cdecl alias "__gmpz_fits_uint_p" (byval as mpz_srcptr) as integer
declare function mpz_fits_ulong_p cdecl alias "__gmpz_fits_ulong_p" (byval as mpz_srcptr) as integer
declare function mpz_fits_ushort_p cdecl alias "__gmpz_fits_ushort_p" (byval as mpz_srcptr) as integer
declare sub mpz_gcd cdecl alias "__gmpz_gcd" (byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare function mpz_gcd_ui cdecl alias "__gmpz_gcd_ui" (byval as mpz_ptr, byval as mpz_srcptr, byval as uinteger) as uinteger
declare sub mpz_gcdext cdecl alias "__gmpz_gcdext" (byval as mpz_ptr, byval as mpz_ptr, byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare function mpz_get_d cdecl alias "__gmpz_get_d" (byval as mpz_srcptr) as double
declare function mpz_get_d_2exp cdecl alias "__gmpz_get_d_2exp" (byval as integer ptr, byval as mpz_srcptr) as double
declare function mpz_get_si cdecl alias "__gmpz_get_si" (byval as mpz_srcptr) as integer
declare function mpz_get_str cdecl alias "__gmpz_get_str" (byval as zstring ptr, byval as integer, byval as mpz_srcptr) as zstring ptr
declare function mpz_get_ui cdecl alias "__gmpz_get_ui" (byval as mpz_srcptr) as uinteger
declare function mpz_hamdist cdecl alias "__gmpz_hamdist" (byval as mpz_srcptr, byval as mpz_srcptr) as uinteger
declare sub mpz_import cdecl alias "__gmpz_import" (byval as mpz_ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as any ptr)
declare sub mpz_init cdecl alias "__gmpz_init" (byval as mpz_ptr)
declare sub mpz_init2 cdecl alias "__gmpz_init2" (byval as mpz_ptr, byval as uinteger)
declare sub mpz_init_set cdecl alias "__gmpz_init_set" (byval as mpz_ptr, byval as mpz_srcptr)
declare sub mpz_init_set_d cdecl alias "__gmpz_init_set_d" (byval as mpz_ptr, byval as double)
declare sub mpz_init_set_si cdecl alias "__gmpz_init_set_si" (byval as mpz_ptr, byval as integer)
declare function mpz_init_set_str cdecl alias "__gmpz_init_set_str" (byval as mpz_ptr, byval as zstring ptr, byval as integer) as integer
declare sub mpz_init_set_ui cdecl alias "__gmpz_init_set_ui" (byval as mpz_ptr, byval as uinteger)
declare function mpz_invert cdecl alias "__gmpz_invert" (byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr) as integer
declare sub mpz_ior cdecl alias "__gmpz_ior" (byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare function mpz_jacobi cdecl alias "__gmpz_jacobi" (byval as mpz_srcptr, byval as mpz_srcptr) as integer
declare function mpz_kronecker_si cdecl alias "__gmpz_kronecker_si" (byval as mpz_srcptr, byval as integer) as integer
declare function mpz_kronecker_ui cdecl alias "__gmpz_kronecker_ui" (byval as mpz_srcptr, byval as uinteger) as integer
declare function mpz_si_kronecker cdecl alias "__gmpz_si_kronecker" (byval as integer, byval as mpz_srcptr) as integer
declare function mpz_ui_kronecker cdecl alias "__gmpz_ui_kronecker" (byval as uinteger, byval as mpz_srcptr) as integer
declare sub mpz_lcm cdecl alias "__gmpz_lcm" (byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare sub mpz_lcm_ui cdecl alias "__gmpz_lcm_ui" (byval as mpz_ptr, byval as mpz_srcptr, byval as uinteger)
declare sub mpz_lucnum_ui cdecl alias "__gmpz_lucnum_ui" (byval as mpz_ptr, byval as uinteger)
declare sub mpz_lucnum2_ui cdecl alias "__gmpz_lucnum2_ui" (byval as mpz_ptr, byval as mpz_ptr, byval as uinteger)
declare function mpz_millerrabin cdecl alias "__gmpz_millerrabin" (byval as mpz_srcptr, byval as integer) as integer
declare sub mpz_mod cdecl alias "__gmpz_mod" (byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare sub mpz_mul cdecl alias "__gmpz_mul" (byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare sub mpz_mul_2exp cdecl alias "__gmpz_mul_2exp" (byval as mpz_ptr, byval as mpz_srcptr, byval as uinteger)
declare sub mpz_mul_si cdecl alias "__gmpz_mul_si" (byval as mpz_ptr, byval as mpz_srcptr, byval as integer)
declare sub mpz_mul_ui cdecl alias "__gmpz_mul_ui" (byval as mpz_ptr, byval as mpz_srcptr, byval as uinteger)
declare sub mpz_neg cdecl alias "__gmpz_neg" (byval as mpz_ptr, byval as mpz_srcptr)
declare sub mpz_nextprime cdecl alias "__gmpz_nextprime" (byval as mpz_ptr, byval as mpz_srcptr)
declare function mpz_perfect_power_p cdecl alias "__gmpz_perfect_power_p" (byval as mpz_srcptr) as integer
declare function mpz_perfect_square_p cdecl alias "__gmpz_perfect_square_p" (byval as mpz_srcptr) as integer
declare function mpz_popcount cdecl alias "__gmpz_popcount" (byval as mpz_srcptr) as uinteger
declare sub mpz_pow_ui cdecl alias "__gmpz_pow_ui" (byval as mpz_ptr, byval as mpz_srcptr, byval as uinteger)
declare sub mpz_powm cdecl alias "__gmpz_powm" (byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare sub mpz_powm_ui cdecl alias "__gmpz_powm_ui" (byval as mpz_ptr, byval as mpz_srcptr, byval as uinteger, byval as mpz_srcptr)
declare function mpz_probab_prime_p cdecl alias "__gmpz_probab_prime_p" (byval as mpz_srcptr, byval as integer) as integer
declare sub mpz_random cdecl alias "__gmpz_random" (byval as mpz_ptr, byval as mp_size_t)
declare sub mpz_random2 cdecl alias "__gmpz_random2" (byval as mpz_ptr, byval as mp_size_t)
declare sub mpz_realloc2 cdecl alias "__gmpz_realloc2" (byval as mpz_ptr, byval as uinteger)
declare function mpz_remove cdecl alias "__gmpz_remove" (byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr) as uinteger
declare function mpz_root cdecl alias "__gmpz_root" (byval as mpz_ptr, byval as mpz_srcptr, byval as uinteger) as integer
declare sub mpz_rrandomb cdecl alias "__gmpz_rrandomb" (byval as mpz_ptr, byval as gmp_randstate_t, byval as uinteger)
declare function mpz_scan0 cdecl alias "__gmpz_scan0" (byval as mpz_srcptr, byval as uinteger) as uinteger
declare function mpz_scan1 cdecl alias "__gmpz_scan1" (byval as mpz_srcptr, byval as uinteger) as uinteger
declare sub mpz_set cdecl alias "__gmpz_set" (byval as mpz_ptr, byval as mpz_srcptr)
declare sub mpz_set_d cdecl alias "__gmpz_set_d" (byval as mpz_ptr, byval as double)
declare sub mpz_set_f cdecl alias "__gmpz_set_f" (byval as mpz_ptr, byval as mpf_srcptr)
declare sub mpz_set_q cdecl alias "__gmpz_set_q" (byval as mpz_ptr, byval as mpq_srcptr)
declare sub mpz_set_si cdecl alias "__gmpz_set_si" (byval as mpz_ptr, byval as integer)
declare function mpz_set_str cdecl alias "__gmpz_set_str" (byval as mpz_ptr, byval as zstring ptr, byval as integer) as integer
declare sub mpz_set_ui cdecl alias "__gmpz_set_ui" (byval as mpz_ptr, byval as uinteger)
declare sub mpz_setbit cdecl alias "__gmpz_setbit" (byval as mpz_ptr, byval as uinteger)
declare function mpz_size cdecl alias "__gmpz_size" (byval as mpz_srcptr) as integer
declare function mpz_sizeinbase cdecl alias "__gmpz_sizeinbase" (byval as mpz_srcptr, byval as integer) as integer
declare sub mpz_sqrt cdecl alias "__gmpz_sqrt" (byval as mpz_ptr, byval as mpz_srcptr)
declare sub mpz_sqrtrem cdecl alias "__gmpz_sqrtrem" (byval as mpz_ptr, byval as mpz_ptr, byval as mpz_srcptr)
declare sub mpz_sub cdecl alias "__gmpz_sub" (byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare sub mpz_sub_ui cdecl alias "__gmpz_sub_ui" (byval as mpz_ptr, byval as mpz_srcptr, byval as uinteger)
declare sub mpz_ui_sub cdecl alias "__gmpz_ui_sub" (byval as mpz_ptr, byval as uinteger, byval as mpz_srcptr)
declare sub mpz_submul cdecl alias "__gmpz_submul" (byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare sub mpz_submul_ui cdecl alias "__gmpz_submul_ui" (byval as mpz_ptr, byval as mpz_srcptr, byval as uinteger)
declare sub mpz_swap cdecl alias "__gmpz_swap" (byval as mpz_ptr, byval as mpz_ptr)
declare function mpz_tdiv_ui cdecl alias "__gmpz_tdiv_ui" (byval as mpz_srcptr, byval as uinteger) as uinteger
declare sub mpz_tdiv_q cdecl alias "__gmpz_tdiv_q" (byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare sub mpz_tdiv_q_2exp cdecl alias "__gmpz_tdiv_q_2exp" (byval as mpz_ptr, byval as mpz_srcptr, byval as uinteger)
declare function mpz_tdiv_q_ui cdecl alias "__gmpz_tdiv_q_ui" (byval as mpz_ptr, byval as mpz_srcptr, byval as uinteger) as uinteger
declare sub mpz_tdiv_qr cdecl alias "__gmpz_tdiv_qr" (byval as mpz_ptr, byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare function mpz_tdiv_qr_ui cdecl alias "__gmpz_tdiv_qr_ui" (byval as mpz_ptr, byval as mpz_ptr, byval as mpz_srcptr, byval as uinteger) as uinteger
declare sub mpz_tdiv_r cdecl alias "__gmpz_tdiv_r" (byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)
declare sub mpz_tdiv_r_2exp cdecl alias "__gmpz_tdiv_r_2exp" (byval as mpz_ptr, byval as mpz_srcptr, byval as uinteger)
declare function mpz_tdiv_r_ui cdecl alias "__gmpz_tdiv_r_ui" (byval as mpz_ptr, byval as mpz_srcptr, byval as uinteger) as uinteger
declare function mpz_tstbit cdecl alias "__gmpz_tstbit" (byval as mpz_srcptr, byval as uinteger) as integer
declare sub mpz_ui_pow_ui cdecl alias "__gmpz_ui_pow_ui" (byval as mpz_ptr, byval as uinteger, byval as uinteger)
declare sub mpz_urandomb cdecl alias "__gmpz_urandomb" (byval as mpz_ptr, byval as gmp_randstate_t, byval as uinteger)
declare sub mpz_urandomm cdecl alias "__gmpz_urandomm" (byval as mpz_ptr, byval as gmp_randstate_t, byval as mpz_srcptr)
declare sub mpz_xor cdecl alias "__gmpz_xor" (byval as mpz_ptr, byval as mpz_srcptr, byval as mpz_srcptr)

''**************** Rational (i.e. Q) routines.  ****************

declare sub mpq_abs cdecl alias "__gmpq_abs" (byval as mpq_ptr, byval as mpq_srcptr)
declare sub mpq_add cdecl alias "__gmpq_add" (byval as mpq_ptr, byval as mpq_srcptr, byval as mpq_srcptr)
declare sub mpq_canonicalize cdecl alias "__gmpq_canonicalize" (byval as mpq_ptr)
declare sub mpq_clear cdecl alias "__gmpq_clear" (byval as mpq_ptr)
declare function mpq_cmp cdecl alias "__gmpq_cmp" (byval as mpq_srcptr, byval as mpq_srcptr) as integer
declare function mpq_cmp_si cdecl alias "__gmpq_cmp_si" (byval as mpq_srcptr, byval as integer, byval as uinteger) as integer
declare function mpq_cmp_ui cdecl alias "__gmpq_cmp_ui" (byval as mpq_srcptr, byval as uinteger, byval as uinteger) as integer
declare sub mpq_div cdecl alias "__gmpq_div" (byval as mpq_ptr, byval as mpq_srcptr, byval as mpq_srcptr)
declare sub mpq_div_2exp cdecl alias "__gmpq_div_2exp" (byval as mpq_ptr, byval as mpq_srcptr, byval as uinteger)
declare function mpq_equal cdecl alias "__gmpq_equal" (byval as mpq_srcptr, byval as mpq_srcptr) as integer
declare sub mpq_get_num cdecl alias "__gmpq_get_num" (byval as mpz_ptr, byval as mpq_srcptr)
declare sub mpq_get_den cdecl alias "__gmpq_get_den" (byval as mpz_ptr, byval as mpq_srcptr)
declare function mpq_get_d cdecl alias "__gmpq_get_d" (byval as mpq_srcptr) as double
declare function mpq_get_str cdecl alias "__gmpq_get_str" (byval as zstring ptr, byval as integer, byval as mpq_srcptr) as zstring ptr
declare sub mpq_init cdecl alias "__gmpq_init" (byval as mpq_ptr)
declare sub mpq_inv cdecl alias "__gmpq_inv" (byval as mpq_ptr, byval as mpq_srcptr)
declare sub mpq_mul cdecl alias "__gmpq_mul" (byval as mpq_ptr, byval as mpq_srcptr, byval as mpq_srcptr)
declare sub mpq_mul_2exp cdecl alias "__gmpq_mul_2exp" (byval as mpq_ptr, byval as mpq_srcptr, byval as uinteger)
declare sub mpq_neg cdecl alias "__gmpq_neg" (byval as mpq_ptr, byval as mpq_srcptr)
declare sub mpq_set cdecl alias "__gmpq_set" (byval as mpq_ptr, byval as mpq_srcptr)
declare sub mpq_set_d cdecl alias "__gmpq_set_d" (byval as mpq_ptr, byval as double)
declare sub mpq_set_den cdecl alias "__gmpq_set_den" (byval as mpq_ptr, byval as mpz_srcptr)
declare sub mpq_set_f cdecl alias "__gmpq_set_f" (byval as mpq_ptr, byval as mpf_srcptr)
declare sub mpq_set_num cdecl alias "__gmpq_set_num" (byval as mpq_ptr, byval as mpz_srcptr)
declare sub mpq_set_si cdecl alias "__gmpq_set_si" (byval as mpq_ptr, byval as integer, byval as uinteger)
declare function mpq_set_str cdecl alias "__gmpq_set_str" (byval as mpq_ptr, byval as zstring ptr, byval as integer) as integer
declare sub mpq_set_ui cdecl alias "__gmpq_set_ui" (byval as mpq_ptr, byval as uinteger, byval as uinteger)
declare sub mpq_set_z cdecl alias "__gmpq_set_z" (byval as mpq_ptr, byval as mpz_srcptr)
declare sub mpq_sub cdecl alias "__gmpq_sub" (byval as mpq_ptr, byval as mpq_srcptr, byval as mpq_srcptr)
declare sub mpq_swap cdecl alias "__gmpq_swap" (byval as mpq_ptr, byval as mpq_ptr)

''**************** Float (i.e. F) routines.  ****************

declare sub mpf_abs cdecl alias "__gmpf_abs" (byval as mpf_ptr, byval as mpf_srcptr)
declare sub mpf_add cdecl alias "__gmpf_add" (byval as mpf_ptr, byval as mpf_srcptr, byval as mpf_srcptr)
declare sub mpf_add_ui cdecl alias "__gmpf_add_ui" (byval as mpf_ptr, byval as mpf_srcptr, byval as uinteger)
declare sub mpf_ceil cdecl alias "__gmpf_ceil" (byval as mpf_ptr, byval as mpf_srcptr)
declare sub mpf_clear cdecl alias "__gmpf_clear" (byval as mpf_ptr)
declare function mpf_cmp cdecl alias "__gmpf_cmp" (byval as mpf_srcptr, byval as mpf_srcptr) as integer
declare function mpf_cmp_d cdecl alias "__gmpf_cmp_d" (byval as mpf_srcptr, byval as double) as integer
declare function mpf_cmp_si cdecl alias "__gmpf_cmp_si" (byval as mpf_srcptr, byval as integer) as integer
declare function mpf_cmp_ui cdecl alias "__gmpf_cmp_ui" (byval as mpf_srcptr, byval as uinteger) as integer
declare sub mpf_div cdecl alias "__gmpf_div" (byval as mpf_ptr, byval as mpf_srcptr, byval as mpf_srcptr)
declare sub mpf_div_2exp cdecl alias "__gmpf_div_2exp" (byval as mpf_ptr, byval as mpf_srcptr, byval as uinteger)
declare sub mpf_div_ui cdecl alias "__gmpf_div_ui" (byval as mpf_ptr, byval as mpf_srcptr, byval as uinteger)
declare sub mpf_dump cdecl alias "__gmpf_dump" (byval as mpf_srcptr)
declare function mpf_eq cdecl alias "__gmpf_eq" (byval as mpf_srcptr, byval as mpf_srcptr, byval as uinteger) as integer
declare function mpf_fits_sint_p cdecl alias "__gmpf_fits_sint_p" (byval as mpf_srcptr) as integer
declare function mpf_fits_slong_p cdecl alias "__gmpf_fits_slong_p" (byval as mpf_srcptr) as integer
declare function mpf_fits_sshort_p cdecl alias "__gmpf_fits_sshort_p" (byval as mpf_srcptr) as integer
declare function mpf_fits_uint_p cdecl alias "__gmpf_fits_uint_p" (byval as mpf_srcptr) as integer
declare function mpf_fits_ulong_p cdecl alias "__gmpf_fits_ulong_p" (byval as mpf_srcptr) as integer
declare function mpf_fits_ushort_p cdecl alias "__gmpf_fits_ushort_p" (byval as mpf_srcptr) as integer
declare sub mpf_floor cdecl alias "__gmpf_floor" (byval as mpf_ptr, byval as mpf_srcptr)
declare function mpf_get_d cdecl alias "__gmpf_get_d" (byval as mpf_srcptr) as double
declare function mpf_get_d_2exp cdecl alias "__gmpf_get_d_2exp" (byval as integer ptr, byval as mpf_srcptr) as double
declare function mpf_get_default_prec cdecl alias "__gmpf_get_default_prec" () as uinteger
declare function mpf_get_prec cdecl alias "__gmpf_get_prec" (byval as mpf_srcptr) as uinteger
declare function mpf_get_si cdecl alias "__gmpf_get_si" (byval as mpf_srcptr) as integer
declare function mpf_get_str cdecl alias "__gmpf_get_str" (byval as zstring ptr, byval as mp_exp_t ptr, byval as integer, byval as integer, byval as mpf_srcptr) as zstring ptr
declare function mpf_get_ui cdecl alias "__gmpf_get_ui" (byval as mpf_srcptr) as uinteger
declare sub mpf_init cdecl alias "__gmpf_init" (byval as mpf_ptr)
declare sub mpf_init2 cdecl alias "__gmpf_init2" (byval as mpf_ptr, byval as uinteger)
declare sub mpf_init_set cdecl alias "__gmpf_init_set" (byval as mpf_ptr, byval as mpf_srcptr)
declare sub mpf_init_set_d cdecl alias "__gmpf_init_set_d" (byval as mpf_ptr, byval as double)
declare sub mpf_init_set_si cdecl alias "__gmpf_init_set_si" (byval as mpf_ptr, byval as integer)
declare function mpf_init_set_str cdecl alias "__gmpf_init_set_str" (byval as mpf_ptr, byval as zstring ptr, byval as integer) as integer
declare sub mpf_init_set_ui cdecl alias "__gmpf_init_set_ui" (byval as mpf_ptr, byval as uinteger)
declare function mpf_integer_p cdecl alias "__gmpf_integer_p" (byval as mpf_srcptr) as integer
declare sub mpf_mul cdecl alias "__gmpf_mul" (byval as mpf_ptr, byval as mpf_srcptr, byval as mpf_srcptr)
declare sub mpf_mul_2exp cdecl alias "__gmpf_mul_2exp" (byval as mpf_ptr, byval as mpf_srcptr, byval as uinteger)
declare sub mpf_mul_ui cdecl alias "__gmpf_mul_ui" (byval as mpf_ptr, byval as mpf_srcptr, byval as uinteger)
declare sub mpf_neg cdecl alias "__gmpf_neg" (byval as mpf_ptr, byval as mpf_srcptr)
declare sub mpf_pow_ui cdecl alias "__gmpf_pow_ui" (byval as mpf_ptr, byval as mpf_srcptr, byval as uinteger)
declare sub mpf_random2 cdecl alias "__gmpf_random2" (byval as mpf_ptr, byval as mp_size_t, byval as mp_exp_t)
declare sub mpf_reldiff cdecl alias "__gmpf_reldiff" (byval as mpf_ptr, byval as mpf_srcptr, byval as mpf_srcptr)
declare sub mpf_set cdecl alias "__gmpf_set" (byval as mpf_ptr, byval as mpf_srcptr)
declare sub mpf_set_d cdecl alias "__gmpf_set_d" (byval as mpf_ptr, byval as double)
declare sub mpf_set_default_prec cdecl alias "__gmpf_set_default_prec" (byval as uinteger)
declare sub mpf_set_prec cdecl alias "__gmpf_set_prec" (byval as mpf_ptr, byval as uinteger)
declare sub mpf_set_prec_raw cdecl alias "__gmpf_set_prec_raw" (byval as mpf_ptr, byval as uinteger)
declare sub mpf_set_q cdecl alias "__gmpf_set_q" (byval as mpf_ptr, byval as mpq_srcptr)
declare sub mpf_set_si cdecl alias "__gmpf_set_si" (byval as mpf_ptr, byval as integer)
declare function mpf_set_str cdecl alias "__gmpf_set_str" (byval as mpf_ptr, byval as zstring ptr, byval as integer) as integer
declare sub mpf_set_ui cdecl alias "__gmpf_set_ui" (byval as mpf_ptr, byval as uinteger)
declare sub mpf_set_z cdecl alias "__gmpf_set_z" (byval as mpf_ptr, byval as mpz_srcptr)
declare function mpf_size cdecl alias "__gmpf_size" (byval as mpf_srcptr) as integer
declare sub mpf_sqrt cdecl alias "__gmpf_sqrt" (byval as mpf_ptr, byval as mpf_srcptr)
declare sub mpf_sqrt_ui cdecl alias "__gmpf_sqrt_ui" (byval as mpf_ptr, byval as uinteger)
declare sub mpf_sub cdecl alias "__gmpf_sub" (byval as mpf_ptr, byval as mpf_srcptr, byval as mpf_srcptr)
declare sub mpf_sub_ui cdecl alias "__gmpf_sub_ui" (byval as mpf_ptr, byval as mpf_srcptr, byval as uinteger)
declare sub mpf_swap cdecl alias "__gmpf_swap" (byval as mpf_ptr, byval as mpf_ptr)
declare sub mpf_trunc cdecl alias "__gmpf_trunc" (byval as mpf_ptr, byval as mpf_srcptr)
declare sub mpf_ui_div cdecl alias "__gmpf_ui_div" (byval as mpf_ptr, byval as uinteger, byval as mpf_srcptr)
declare sub mpf_ui_sub cdecl alias "__gmpf_ui_sub" (byval as mpf_ptr, byval as uinteger, byval as mpf_srcptr)
declare sub mpf_urandomb cdecl alias "__gmpf_urandomb" (byval as mpf_t, byval as gmp_randstate_t, byval as uinteger)

''************ Low level positive-integer (i.e. N) routines.  ************

declare function mpn_cmp cdecl alias "__gmpn_cmp" (byval as mp_srcptr, byval as mp_srcptr, byval as mp_size_t) as integer
declare function mpn_get_str cdecl alias "__gmpn_get_str" (byval as ubyte ptr, byval as integer, byval as mp_ptr, byval as mp_size_t) as integer
declare function mpn_hamdist cdecl alias "__gmpn_hamdist" (byval as mp_srcptr, byval as mp_srcptr, byval as mp_size_t) as uinteger
declare sub mpn_mul_n cdecl alias "__gmpn_mul_n" (byval as mp_ptr, byval as mp_srcptr, byval as mp_srcptr, byval as mp_size_t)
declare function mpn_perfect_square_p cdecl alias "__gmpn_perfect_square_p" (byval as mp_srcptr, byval as mp_size_t) as integer
declare function mpn_popcount cdecl alias "__gmpn_popcount" (byval as mp_srcptr, byval as mp_size_t) as uinteger
declare sub mpn_random cdecl alias "__gmpn_random" (byval as mp_ptr, byval as mp_size_t)
declare sub mpn_random2 cdecl alias "__gmpn_random2" (byval as mp_ptr, byval as mp_size_t)
declare function mpn_scan0 cdecl alias "__gmpn_scan0" (byval as mp_srcptr, byval as uinteger) as uinteger
declare function mpn_scan1 cdecl alias "__gmpn_scan1" (byval as mp_srcptr, byval as uinteger) as uinteger
declare sub mpn_tdiv_qr cdecl alias "__gmpn_tdiv_qr" (byval as mp_ptr, byval as mp_ptr, byval as mp_size_t, byval as mp_srcptr, byval as mp_size_t, byval as mp_srcptr, byval as mp_size_t)

enum 
	GMP_ERROR_NONE = 0
	GMP_ERROR_UNSUPPORTED_ARGUMENT = 1
	GMP_ERROR_DIVISION_BY_ZERO = 2
	GMP_ERROR_SQRT_OF_NEGATIVE = 4
	GMP_ERROR_INVALID_ARGUMENT = 8
	GMP_ERROR_ALLOCATE = 16
	GMP_ERROR_BAD_STRING = 32
	GMP_ERROR_UNUSED_ERROR
end enum

#define __GNU_MP_VERSION 4
#define __GNU_MP_VERSION_MINOR 1
#define __GNU_MP_VERSION_PATCHLEVEL 4

#endif
