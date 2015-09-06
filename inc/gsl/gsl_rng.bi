'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   rng/gsl_rng.h
''
''   Copyright (C) 1996, 1997, 1998, 1999, 2000, 2004, 2007 James Theiler, Brian Gough
''
''   This program is free software; you can redistribute it and/or modify
''   it under the terms of the GNU General Public License as published by
''   the Free Software Foundation; either version 3 of the License, or (at
''   your option) any later version.
''
''   This program is distributed in the hope that it will be useful, but
''   WITHOUT ANY WARRANTY; without even the implied warranty of
''   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
''   General Public License for more details.
''
''   You should have received a copy of the GNU General Public License
''   along with this program; if not, write to the Free Software
''   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/long.bi"
#include once "crt/stdlib.bi"
#include once "gsl/gsl_types.bi"
#include once "gsl/gsl_errno.bi"
#include once "gsl/gsl_inline.bi"

extern "C"

#define __GSL_RNG_H__

type gsl_rng_type
	name as const zstring ptr
	max as culong
	min as culong
	size as uinteger
	set as sub(byval state as any ptr, byval seed as culong)
	get as function(byval state as any ptr) as culong
	get_double as function(byval state as any ptr) as double
end type

type gsl_rng
	as const gsl_rng_type ptr type
	state as any ptr
end type

extern gsl_rng_borosh13 as const gsl_rng_type ptr
extern gsl_rng_coveyou as const gsl_rng_type ptr
extern gsl_rng_cmrg as const gsl_rng_type ptr
extern gsl_rng_fishman18 as const gsl_rng_type ptr
extern gsl_rng_fishman20 as const gsl_rng_type ptr
extern gsl_rng_fishman2x as const gsl_rng_type ptr
extern gsl_rng_gfsr4 as const gsl_rng_type ptr
extern gsl_rng_knuthran as const gsl_rng_type ptr
extern gsl_rng_knuthran2 as const gsl_rng_type ptr
extern gsl_rng_knuthran2002 as const gsl_rng_type ptr
extern gsl_rng_lecuyer21 as const gsl_rng_type ptr
extern gsl_rng_minstd as const gsl_rng_type ptr
extern gsl_rng_mrg as const gsl_rng_type ptr
extern gsl_rng_mt19937 as const gsl_rng_type ptr
extern gsl_rng_mt19937_1999 as const gsl_rng_type ptr
extern gsl_rng_mt19937_1998 as const gsl_rng_type ptr
extern gsl_rng_r250 as const gsl_rng_type ptr
extern gsl_rng_ran0 as const gsl_rng_type ptr
extern gsl_rng_ran1 as const gsl_rng_type ptr
extern gsl_rng_ran2 as const gsl_rng_type ptr
extern gsl_rng_ran3 as const gsl_rng_type ptr
extern gsl_rng_rand as const gsl_rng_type ptr
extern gsl_rng_rand48 as const gsl_rng_type ptr
extern gsl_rng_random128_bsd as const gsl_rng_type ptr
extern gsl_rng_random128_glibc2 as const gsl_rng_type ptr
extern gsl_rng_random128_libc5 as const gsl_rng_type ptr
extern gsl_rng_random256_bsd as const gsl_rng_type ptr
extern gsl_rng_random256_glibc2 as const gsl_rng_type ptr
extern gsl_rng_random256_libc5 as const gsl_rng_type ptr
extern gsl_rng_random32_bsd as const gsl_rng_type ptr
extern gsl_rng_random32_glibc2 as const gsl_rng_type ptr
extern gsl_rng_random32_libc5 as const gsl_rng_type ptr
extern gsl_rng_random64_bsd as const gsl_rng_type ptr
extern gsl_rng_random64_glibc2 as const gsl_rng_type ptr
extern gsl_rng_random64_libc5 as const gsl_rng_type ptr
extern gsl_rng_random8_bsd as const gsl_rng_type ptr
extern gsl_rng_random8_glibc2 as const gsl_rng_type ptr
extern gsl_rng_random8_libc5 as const gsl_rng_type ptr
extern gsl_rng_random_bsd as const gsl_rng_type ptr
extern gsl_rng_random_glibc2 as const gsl_rng_type ptr
extern gsl_rng_random_libc5 as const gsl_rng_type ptr
extern gsl_rng_randu as const gsl_rng_type ptr
extern gsl_rng_ranf as const gsl_rng_type ptr
extern gsl_rng_ranlux as const gsl_rng_type ptr
extern gsl_rng_ranlux389 as const gsl_rng_type ptr
extern gsl_rng_ranlxd1 as const gsl_rng_type ptr
extern gsl_rng_ranlxd2 as const gsl_rng_type ptr
extern gsl_rng_ranlxs0 as const gsl_rng_type ptr
extern gsl_rng_ranlxs1 as const gsl_rng_type ptr
extern gsl_rng_ranlxs2 as const gsl_rng_type ptr
extern gsl_rng_ranmar as const gsl_rng_type ptr
extern gsl_rng_slatec as const gsl_rng_type ptr
extern gsl_rng_taus as const gsl_rng_type ptr
extern gsl_rng_taus2 as const gsl_rng_type ptr
extern gsl_rng_taus113 as const gsl_rng_type ptr
extern gsl_rng_transputer as const gsl_rng_type ptr
extern gsl_rng_tt800 as const gsl_rng_type ptr
extern gsl_rng_uni as const gsl_rng_type ptr
extern gsl_rng_uni32 as const gsl_rng_type ptr
extern gsl_rng_vax as const gsl_rng_type ptr
extern gsl_rng_waterman14 as const gsl_rng_type ptr
extern gsl_rng_zuf as const gsl_rng_type ptr
declare function gsl_rng_types_setup() as const gsl_rng_type ptr ptr
extern gsl_rng_default as const gsl_rng_type ptr
extern gsl_rng_default_seed as culong

declare function gsl_rng_alloc(byval T as const gsl_rng_type ptr) as gsl_rng ptr
declare function gsl_rng_memcpy(byval dest as gsl_rng ptr, byval src as const gsl_rng ptr) as long
declare function gsl_rng_clone(byval r as const gsl_rng ptr) as gsl_rng ptr
declare sub gsl_rng_free(byval r as gsl_rng ptr)
declare sub gsl_rng_set(byval r as const gsl_rng ptr, byval seed as culong)
declare function gsl_rng_max(byval r as const gsl_rng ptr) as culong
declare function gsl_rng_min(byval r as const gsl_rng ptr) as culong
declare function gsl_rng_name(byval r as const gsl_rng ptr) as const zstring ptr
declare function gsl_rng_fread(byval stream as FILE ptr, byval r as gsl_rng ptr) as long
declare function gsl_rng_fwrite(byval stream as FILE ptr, byval r as const gsl_rng ptr) as long
declare function gsl_rng_size(byval r as const gsl_rng ptr) as uinteger
declare function gsl_rng_state(byval r as const gsl_rng ptr) as any ptr
declare sub gsl_rng_print_state(byval r as const gsl_rng ptr)
declare function gsl_rng_env_setup() as const gsl_rng_type ptr
declare function gsl_rng_get(byval r as const gsl_rng ptr) as culong
declare function gsl_rng_uniform(byval r as const gsl_rng ptr) as double
declare function gsl_rng_uniform_pos(byval r as const gsl_rng ptr) as double
declare function gsl_rng_uniform_int(byval r as const gsl_rng ptr, byval n as culong) as culong

end extern
