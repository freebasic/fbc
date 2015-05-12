''
''
'' gsl_block_uint -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_block_uint_bi__
#define __gsl_block_uint_bi__

#include once "gsl_errno.bi"
#include once "gsl_types.bi"

type gsl_block_uint_struct
	size as integer
	data as uinteger ptr
end type

type gsl_block_uint as gsl_block_uint_struct

extern "c"
declare function gsl_block_uint_alloc (byval n as integer) as gsl_block_uint ptr
declare function gsl_block_uint_calloc (byval n as integer) as gsl_block_uint ptr
declare sub gsl_block_uint_free (byval b as gsl_block_uint ptr)
declare function gsl_block_uint_fread (byval stream as FILE ptr, byval b as gsl_block_uint ptr) as integer
declare function gsl_block_uint_fwrite (byval stream as FILE ptr, byval b as gsl_block_uint ptr) as integer
declare function gsl_block_uint_fscanf (byval stream as FILE ptr, byval b as gsl_block_uint ptr) as integer
declare function gsl_block_uint_fprintf (byval stream as FILE ptr, byval b as gsl_block_uint ptr, byval format as zstring ptr) as integer
declare function gsl_block_uint_raw_fread (byval stream as FILE ptr, byval b as uinteger ptr, byval n as integer, byval stride as integer) as integer
declare function gsl_block_uint_raw_fwrite (byval stream as FILE ptr, byval b as uinteger ptr, byval n as integer, byval stride as integer) as integer
declare function gsl_block_uint_raw_fscanf (byval stream as FILE ptr, byval b as uinteger ptr, byval n as integer, byval stride as integer) as integer
declare function gsl_block_uint_raw_fprintf (byval stream as FILE ptr, byval b as uinteger ptr, byval n as integer, byval stride as integer, byval format as zstring ptr) as integer
declare function gsl_block_uint_size (byval b as gsl_block_uint ptr) as integer
declare function gsl_block_uint_data (byval b as gsl_block_uint ptr) as uinteger ptr
end extern

#endif
