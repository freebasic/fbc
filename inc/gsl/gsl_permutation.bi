'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   permutation/gsl_permutation.h
''
''   Copyright (C) 1996, 1997, 1998, 1999, 2000, 2004, 2007 Brian Gough
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

#include once "crt/stdlib.bi"
#include once "gsl/gsl_types.bi"
#include once "gsl/gsl_errno.bi"
#include once "gsl/gsl_inline.bi"
#include once "gsl/gsl_check_range.bi"

extern "C"

#define __GSL_PERMUTATION_H__

type gsl_permutation_struct
	size as uinteger
	data as uinteger ptr
end type

type gsl_permutation as gsl_permutation_struct
declare function gsl_permutation_alloc(byval n as const uinteger) as gsl_permutation ptr
declare function gsl_permutation_calloc(byval n as const uinteger) as gsl_permutation ptr
declare sub gsl_permutation_init(byval p as gsl_permutation ptr)
declare sub gsl_permutation_free(byval p as gsl_permutation ptr)
declare function gsl_permutation_memcpy(byval dest as gsl_permutation ptr, byval src as const gsl_permutation ptr) as long
declare function gsl_permutation_fread(byval stream as FILE ptr, byval p as gsl_permutation ptr) as long
declare function gsl_permutation_fwrite(byval stream as FILE ptr, byval p as const gsl_permutation ptr) as long
declare function gsl_permutation_fscanf(byval stream as FILE ptr, byval p as gsl_permutation ptr) as long
declare function gsl_permutation_fprintf(byval stream as FILE ptr, byval p as const gsl_permutation ptr, byval format as const zstring ptr) as long
declare function gsl_permutation_size(byval p as const gsl_permutation ptr) as uinteger
declare function gsl_permutation_data(byval p as const gsl_permutation ptr) as uinteger ptr
declare function gsl_permutation_swap(byval p as gsl_permutation ptr, byval i as const uinteger, byval j as const uinteger) as long
declare function gsl_permutation_valid(byval p as const gsl_permutation ptr) as long
declare sub gsl_permutation_reverse(byval p as gsl_permutation ptr)
declare function gsl_permutation_inverse(byval inv as gsl_permutation ptr, byval p as const gsl_permutation ptr) as long
declare function gsl_permutation_next(byval p as gsl_permutation ptr) as long
declare function gsl_permutation_prev(byval p as gsl_permutation ptr) as long
declare function gsl_permutation_mul(byval p as gsl_permutation ptr, byval pa as const gsl_permutation ptr, byval pb as const gsl_permutation ptr) as long
declare function gsl_permutation_linear_to_canonical(byval q as gsl_permutation ptr, byval p as const gsl_permutation ptr) as long
declare function gsl_permutation_canonical_to_linear(byval p as gsl_permutation ptr, byval q as const gsl_permutation ptr) as long
declare function gsl_permutation_inversions(byval p as const gsl_permutation ptr) as uinteger
declare function gsl_permutation_linear_cycles(byval p as const gsl_permutation ptr) as uinteger
declare function gsl_permutation_canonical_cycles(byval q as const gsl_permutation ptr) as uinteger
declare function gsl_permutation_get(byval p as const gsl_permutation ptr, byval i as const uinteger) as uinteger

end extern
