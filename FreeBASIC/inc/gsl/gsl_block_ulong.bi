''
''
'' gsl_block_ulong -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_block_ulong_bi__
#define __gsl_block_ulong_bi__

#include once "gsl_errno.bi"
#include once "gsl_types.bi"

type gsl_block_ulong_struct
	size as integer
	data as uinteger ptr
end type

type gsl_block_ulong as gsl_block_ulong_struct

extern "c"
declare function gsl_block_ulong_alloc (byval n as integer) as gsl_block_ulong ptr
declare function gsl_block_ulong_calloc (byval n as integer) as gsl_block_ulong ptr
declare sub gsl_block_ulong_free (byval b as gsl_block_ulong ptr)
declare function gsl_block_ulong_fread (byval stream as FILE ptr, byval b as gsl_block_ulong ptr) as integer
declare function gsl_block_ulong_fwrite (byval stream as FILE ptr, byval b as gsl_block_ulong ptr) as integer
declare function gsl_block_ulong_fscanf (byval stream as FILE ptr, byval b as gsl_block_ulong ptr) as integer
declare function gsl_block_ulong_fprintf (byval stream as FILE ptr, byval b as gsl_block_ulong ptr, byval format as zstring ptr) as integer
declare function gsl_block_ulong_raw_fread (byval stream as FILE ptr, byval b as uinteger ptr, byval n as integer, byval stride as integer) as integer
declare function gsl_block_ulong_raw_fwrite (byval stream as FILE ptr, byval b as uinteger ptr, byval n as integer, byval stride as integer) as integer
declare function gsl_block_ulong_raw_fscanf (byval stream as FILE ptr, byval b as uinteger ptr, byval n as integer, byval stride as integer) as integer
declare function gsl_block_ulong_raw_fprintf (byval stream as FILE ptr, byval b as uinteger ptr, byval n as integer, byval stride as integer, byval format as zstring ptr) as integer
declare function gsl_block_ulong_size (byval b as gsl_block_ulong ptr) as integer
declare function gsl_block_ulong_data (byval b as gsl_block_ulong ptr) as uinteger ptr
end extern

#endif
