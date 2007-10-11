''
''
'' gsl_block_int -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_block_int_bi__
#define __gsl_block_int_bi__

#include once "gsl_errno.bi"
#include once "gsl_types.bi"

type gsl_block_int_struct
	size as integer
	data as integer ptr
end type

type gsl_block_int as gsl_block_int_struct

extern "c"
declare function gsl_block_int_alloc (byval n as integer) as gsl_block_int ptr
declare function gsl_block_int_calloc (byval n as integer) as gsl_block_int ptr
declare sub gsl_block_int_free (byval b as gsl_block_int ptr)
declare function gsl_block_int_fread (byval stream as FILE ptr, byval b as gsl_block_int ptr) as integer
declare function gsl_block_int_fwrite (byval stream as FILE ptr, byval b as gsl_block_int ptr) as integer
declare function gsl_block_int_fscanf (byval stream as FILE ptr, byval b as gsl_block_int ptr) as integer
declare function gsl_block_int_fprintf (byval stream as FILE ptr, byval b as gsl_block_int ptr, byval format as zstring ptr) as integer
declare function gsl_block_int_raw_fread (byval stream as FILE ptr, byval b as integer ptr, byval n as integer, byval stride as integer) as integer
declare function gsl_block_int_raw_fwrite (byval stream as FILE ptr, byval b as integer ptr, byval n as integer, byval stride as integer) as integer
declare function gsl_block_int_raw_fscanf (byval stream as FILE ptr, byval b as integer ptr, byval n as integer, byval stride as integer) as integer
declare function gsl_block_int_raw_fprintf (byval stream as FILE ptr, byval b as integer ptr, byval n as integer, byval stride as integer, byval format as zstring ptr) as integer
declare function gsl_block_int_size (byval b as gsl_block_int ptr) as integer
declare function gsl_block_int_data (byval b as gsl_block_int ptr) as integer ptr
end extern

#endif
