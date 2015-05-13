''
''
'' gsl_eigen -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_eigen_bi__
#define __gsl_eigen_bi__

#include once "gsl_vector.bi"
#include once "gsl_matrix.bi"
#include once "gsl_types.bi"

type gsl_eigen_symm_workspace
	size as integer
	d as double ptr
	sd as double ptr
end type

extern "c"
declare function gsl_eigen_symm_alloc (byval n as integer) as gsl_eigen_symm_workspace ptr
declare sub gsl_eigen_symm_free (byval w as gsl_eigen_symm_workspace ptr)
declare function gsl_eigen_symm (byval A as gsl_matrix ptr, byval eval as gsl_vector ptr, byval w as gsl_eigen_symm_workspace ptr) as integer
end extern

type gsl_eigen_symmv_workspace
	size as integer
	d as double ptr
	sd as double ptr
	gc as double ptr
	gs as double ptr
end type

extern "c"
declare function gsl_eigen_symmv_alloc (byval n as integer) as gsl_eigen_symmv_workspace ptr
declare sub gsl_eigen_symmv_free (byval w as gsl_eigen_symmv_workspace ptr)
declare function gsl_eigen_symmv (byval A as gsl_matrix ptr, byval eval as gsl_vector ptr, byval evec as gsl_matrix ptr, byval w as gsl_eigen_symmv_workspace ptr) as integer
end extern

type gsl_eigen_herm_workspace
	size as integer
	d as double ptr
	sd as double ptr
	tau as double ptr
end type

extern "c"
declare function gsl_eigen_herm_alloc (byval n as integer) as gsl_eigen_herm_workspace ptr
declare sub gsl_eigen_herm_free (byval w as gsl_eigen_herm_workspace ptr)
declare function gsl_eigen_herm (byval A as gsl_matrix_complex ptr, byval eval as gsl_vector ptr, byval w as gsl_eigen_herm_workspace ptr) as integer
end extern

type gsl_eigen_hermv_workspace
	size as integer
	d as double ptr
	sd as double ptr
	tau as double ptr
	gc as double ptr
	gs as double ptr
end type

extern "c"
declare function gsl_eigen_hermv_alloc (byval n as integer) as gsl_eigen_hermv_workspace ptr
declare sub gsl_eigen_hermv_free (byval w as gsl_eigen_hermv_workspace ptr)
declare function gsl_eigen_hermv (byval A as gsl_matrix_complex ptr, byval eval as gsl_vector ptr, byval evec as gsl_matrix_complex ptr, byval w as gsl_eigen_hermv_workspace ptr) as integer
end extern

enum gsl_eigen_sort_t
	GSL_EIGEN_SORT_VAL_ASC
	GSL_EIGEN_SORT_VAL_DESC
	GSL_EIGEN_SORT_ABS_ASC
	GSL_EIGEN_SORT_ABS_DESC
end enum


extern "c"
declare function gsl_eigen_symmv_sort (byval eval as gsl_vector ptr, byval evec as gsl_matrix ptr, byval sort_type as gsl_eigen_sort_t) as integer
declare function gsl_eigen_hermv_sort (byval eval as gsl_vector ptr, byval evec as gsl_matrix_complex ptr, byval sort_type as gsl_eigen_sort_t) as integer
declare function gsl_eigen_jacobi (byval matrix as gsl_matrix ptr, byval eval as gsl_vector ptr, byval evec as gsl_matrix ptr, byval max_rot as uinteger, byval nrot as uinteger ptr) as integer
declare function gsl_eigen_invert_jacobi (byval matrix as gsl_matrix ptr, byval ainv as gsl_matrix ptr, byval max_rot as uinteger) as integer
end extern

#endif
