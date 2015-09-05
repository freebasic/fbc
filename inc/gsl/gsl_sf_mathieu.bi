'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   specfunc/gsl_sf_mathieu.h
''
''   Copyright (C) 2002 Lowell Johnson
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
''   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "gsl/gsl_sf_result.bi"
#include once "gsl/gsl_eigen.bi"

extern "C"

#define __GSL_SF_MATHIEU_H__
const GSL_SF_MATHIEU_COEFF = 100

type gsl_sf_mathieu_workspace
	size as uinteger
	even_order as uinteger
	odd_order as uinteger
	extra_values as long
	qa as double
	qb as double
	aa as double ptr
	bb as double ptr
	dd as double ptr
	ee as double ptr
	tt as double ptr
	e2 as double ptr
	zz as double ptr
	eval as gsl_vector ptr
	evec as gsl_matrix ptr
	wmat as gsl_eigen_symmv_workspace ptr
end type

declare function gsl_sf_mathieu_a_array(byval order_min as long, byval order_max as long, byval qq as double, byval work as gsl_sf_mathieu_workspace ptr, byval result_array as double ptr) as long
declare function gsl_sf_mathieu_b_array(byval order_min as long, byval order_max as long, byval qq as double, byval work as gsl_sf_mathieu_workspace ptr, byval result_array as double ptr) as long
declare function gsl_sf_mathieu_a(byval order as long, byval qq as double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_mathieu_b(byval order as long, byval qq as double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_mathieu_a_coeff(byval order as long, byval qq as double, byval aa as double, byval coeff as double ptr) as long
declare function gsl_sf_mathieu_b_coeff(byval order as long, byval qq as double, byval aa as double, byval coeff as double ptr) as long
declare function gsl_sf_mathieu_alloc(byval nn as const uinteger, byval qq as const double) as gsl_sf_mathieu_workspace ptr
declare sub gsl_sf_mathieu_free(byval workspace as gsl_sf_mathieu_workspace ptr)
declare function gsl_sf_mathieu_ce(byval order as long, byval qq as double, byval zz as double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_mathieu_se(byval order as long, byval qq as double, byval zz as double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_mathieu_ce_array(byval nmin as long, byval nmax as long, byval qq as double, byval zz as double, byval work as gsl_sf_mathieu_workspace ptr, byval result_array as double ptr) as long
declare function gsl_sf_mathieu_se_array(byval nmin as long, byval nmax as long, byval qq as double, byval zz as double, byval work as gsl_sf_mathieu_workspace ptr, byval result_array as double ptr) as long
declare function gsl_sf_mathieu_Mc(byval kind as long, byval order as long, byval qq as double, byval zz as double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_mathieu_Ms(byval kind as long, byval order as long, byval qq as double, byval zz as double, byval result as gsl_sf_result ptr) as long
declare function gsl_sf_mathieu_Mc_array(byval kind as long, byval nmin as long, byval nmax as long, byval qq as double, byval zz as double, byval work as gsl_sf_mathieu_workspace ptr, byval result_array as double ptr) as long
declare function gsl_sf_mathieu_Ms_array(byval kind as long, byval nmin as long, byval nmax as long, byval qq as double, byval zz as double, byval work as gsl_sf_mathieu_workspace ptr, byval result_array as double ptr) as long

end extern
