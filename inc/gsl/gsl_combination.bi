'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   combination/gsl_combination.h
''   based on permutation/gsl_permutation.h by Brian Gough
''
''   Copyright (C) 2001 Szymon Jaroszewicz
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
#include once "gsl/gsl_errno.bi"
#include once "gsl/gsl_types.bi"
#include once "gsl/gsl_inline.bi"
#include once "gsl/gsl_check_range.bi"

extern "C"

#define __GSL_COMBINATION_H__

type gsl_combination_struct
	n as uinteger
	k as uinteger
	data as uinteger ptr
end type

type gsl_combination as gsl_combination_struct
declare function gsl_combination_alloc(byval n as const uinteger, byval k as const uinteger) as gsl_combination ptr
declare function gsl_combination_calloc(byval n as const uinteger, byval k as const uinteger) as gsl_combination ptr
declare sub gsl_combination_init_first(byval c as gsl_combination ptr)
declare sub gsl_combination_init_last(byval c as gsl_combination ptr)
declare sub gsl_combination_free(byval c as gsl_combination ptr)
declare function gsl_combination_memcpy(byval dest as gsl_combination ptr, byval src as const gsl_combination ptr) as long
declare function gsl_combination_fread(byval stream as FILE ptr, byval c as gsl_combination ptr) as long
declare function gsl_combination_fwrite(byval stream as FILE ptr, byval c as const gsl_combination ptr) as long
declare function gsl_combination_fscanf(byval stream as FILE ptr, byval c as gsl_combination ptr) as long
declare function gsl_combination_fprintf(byval stream as FILE ptr, byval c as const gsl_combination ptr, byval format as const zstring ptr) as long
declare function gsl_combination_n(byval c as const gsl_combination ptr) as uinteger
declare function gsl_combination_k(byval c as const gsl_combination ptr) as uinteger
declare function gsl_combination_data(byval c as const gsl_combination ptr) as uinteger ptr
declare function gsl_combination_valid(byval c as gsl_combination ptr) as long
declare function gsl_combination_next(byval c as gsl_combination ptr) as long
declare function gsl_combination_prev(byval c as gsl_combination ptr) as long
declare function gsl_combination_get(byval c as const gsl_combination ptr, byval i as const uinteger) as uinteger

end extern
