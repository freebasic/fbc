''
''
'' gsl_block_complex_double -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_block_complex_double_bi__
#define __gsl_block_complex_double_bi__

#include once "gsl_errno.bi"
#include once "gsl_types.bi"

type gsl_block_complex_struct
	size as integer
	data as double ptr
end type

type gsl_block_complex as gsl_block_complex_struct

extern "c"
declare function gsl_block_complex_alloc (byval n as integer) as gsl_block_complex ptr
declare function gsl_block_complex_calloc (byval n as integer) as gsl_block_complex ptr
declare sub gsl_block_complex_free (byval b as gsl_block_complex ptr)
declare function gsl_block_complex_fread (byval stream as FILE ptr, byval b as gsl_block_complex ptr) as integer
declare function gsl_block_complex_fwrite (byval stream as FILE ptr, byval b as gsl_block_complex ptr) as integer
declare function gsl_block_complex_fscanf (byval stream as FILE ptr, byval b as gsl_block_complex ptr) as integer
declare function gsl_block_complex_fprintf (byval stream as FILE ptr, byval b as gsl_block_complex ptr, byval format as zstring ptr) as integer
declare function gsl_block_complex_raw_fread (byval stream as FILE ptr, byval b as double ptr, byval n as integer, byval stride as integer) as integer
declare function gsl_block_complex_raw_fwrite (byval stream as FILE ptr, byval b as double ptr, byval n as integer, byval stride as integer) as integer
declare function gsl_block_complex_raw_fscanf (byval stream as FILE ptr, byval b as double ptr, byval n as integer, byval stride as integer) as integer
declare function gsl_block_complex_raw_fprintf (byval stream as FILE ptr, byval b as double ptr, byval n as integer, byval stride as integer, byval format as zstring ptr) as integer
declare function gsl_block_complex_size (byval b as gsl_block_complex ptr) as integer
declare function gsl_block_complex_data (byval b as gsl_block_complex ptr) as double ptr
end extern

#endif
