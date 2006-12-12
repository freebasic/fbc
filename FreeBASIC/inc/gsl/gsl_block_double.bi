''
''
'' gsl_block_double -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_block_double_bi__
#define __gsl_block_double_bi__

#include once "gsl_errno.bi"
#include once "gsl_types.bi"

type gsl_block_struct
	size as integer
	data as double ptr
end type

type gsl_block as gsl_block_struct

extern "c"
declare function gsl_block_alloc (byval n as integer) as gsl_block ptr
declare function gsl_block_calloc (byval n as integer) as gsl_block ptr
declare sub gsl_block_free (byval b as gsl_block ptr)
declare function gsl_block_fread (byval stream as FILE ptr, byval b as gsl_block ptr) as integer
declare function gsl_block_fwrite (byval stream as FILE ptr, byval b as gsl_block ptr) as integer
declare function gsl_block_fscanf (byval stream as FILE ptr, byval b as gsl_block ptr) as integer
declare function gsl_block_fprintf (byval stream as FILE ptr, byval b as gsl_block ptr, byval format as zstring ptr) as integer
declare function gsl_block_raw_fread (byval stream as FILE ptr, byval b as double ptr, byval n as integer, byval stride as integer) as integer
declare function gsl_block_raw_fwrite (byval stream as FILE ptr, byval b as double ptr, byval n as integer, byval stride as integer) as integer
declare function gsl_block_raw_fscanf (byval stream as FILE ptr, byval b as double ptr, byval n as integer, byval stride as integer) as integer
declare function gsl_block_raw_fprintf (byval stream as FILE ptr, byval b as double ptr, byval n as integer, byval stride as integer, byval format as zstring ptr) as integer
declare function gsl_block_size (byval b as gsl_block ptr) as integer
declare function gsl_block_data (byval b as gsl_block ptr) as double ptr
end extern

#endif
