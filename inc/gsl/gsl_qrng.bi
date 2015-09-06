'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''    Author: G. Jungman + modifications from O. Teytaud
''    
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

extern "C"

#define __GSL_QRNG_H__

type gsl_qrng_type
	name as const zstring ptr
	max_dimension as ulong
	state_size as function(byval dimension as ulong) as uinteger
	init_state as function(byval state as any ptr, byval dimension as ulong) as long
	get as function(byval state as any ptr, byval dimension as ulong, byval x as double ptr) as long
end type

type gsl_qrng
	as const gsl_qrng_type ptr type
	dimension as ulong
	state_size as uinteger
	state as any ptr
end type

extern gsl_qrng_niederreiter_2 as const gsl_qrng_type ptr
extern gsl_qrng_sobol as const gsl_qrng_type ptr
extern gsl_qrng_halton as const gsl_qrng_type ptr
extern gsl_qrng_reversehalton as const gsl_qrng_type ptr

declare function gsl_qrng_alloc(byval T as const gsl_qrng_type ptr, byval dimension as ulong) as gsl_qrng ptr
declare function gsl_qrng_memcpy(byval dest as gsl_qrng ptr, byval src as const gsl_qrng ptr) as long
declare function gsl_qrng_clone(byval q as const gsl_qrng ptr) as gsl_qrng ptr
declare sub gsl_qrng_free(byval q as gsl_qrng ptr)
declare sub gsl_qrng_init(byval q as gsl_qrng ptr)
declare function gsl_qrng_name(byval q as const gsl_qrng ptr) as const zstring ptr
declare function gsl_qrng_size(byval q as const gsl_qrng ptr) as uinteger
declare function gsl_qrng_state(byval q as const gsl_qrng ptr) as any ptr
declare function gsl_qrng_get(byval q as const gsl_qrng ptr, byval x as double ptr) as long

end extern
