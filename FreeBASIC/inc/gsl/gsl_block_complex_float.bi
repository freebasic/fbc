''
''
'' gsl_block_complex_float -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_block_complex_float_bi__
#define __gsl_block_complex_float_bi__

#include once "gsl_errno.bi"
#include once "gsl_types.bi"

type gsl_block_complex_float_struct
	size as integer
	data as single ptr
end type

type gsl_block_complex_float as gsl_block_complex_float_struct

extern "c"
declare function gsl_block_complex_float_alloc (byval n as integer) as gsl_block_complex_float ptr
declare function gsl_block_complex_float_calloc (byval n as integer) as gsl_block_complex_float ptr
declare sub gsl_block_complex_float_free (byval b as gsl_block_complex_float ptr)
declare function gsl_block_complex_float_fread (byval stream as FILE ptr, byval b as gsl_block_complex_float ptr) as integer
declare function gsl_block_complex_float_fwrite (byval stream as FILE ptr, byval b as gsl_block_complex_float ptr) as integer
declare function gsl_block_complex_float_fscanf (byval stream as FILE ptr, byval b as gsl_block_complex_float ptr) as integer
declare function gsl_block_complex_float_fprintf (byval stream as FILE ptr, byval b as gsl_block_complex_float ptr, byval format as zstring ptr) as integer
declare function gsl_block_complex_float_raw_fread (byval stream as FILE ptr, byval b as single ptr, byval n as integer, byval stride as integer) as integer
declare function gsl_block_complex_float_raw_fwrite (byval stream as FILE ptr, byval b as single ptr, byval n as integer, byval stride as integer) as integer
declare function gsl_block_complex_float_raw_fscanf (byval stream as FILE ptr, byval b as single ptr, byval n as integer, byval stride as integer) as integer
declare function gsl_block_complex_float_raw_fprintf (byval stream as FILE ptr, byval b as single ptr, byval n as integer, byval stride as integer, byval format as zstring ptr) as integer
declare function gsl_block_complex_float_size (byval b as gsl_block_complex_float ptr) as integer
declare function gsl_block_complex_float_data (byval b as gsl_block_complex_float ptr) as single ptr
end extern

#endif
