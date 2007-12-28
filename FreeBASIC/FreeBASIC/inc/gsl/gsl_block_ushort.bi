''
''
'' gsl_block_ushort -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_block_ushort_bi__
#define __gsl_block_ushort_bi__

#include once "gsl_errno.bi"
#include once "gsl_types.bi"

type gsl_block_ushort_struct
	size as integer
	data as ushort ptr
end type

type gsl_block_ushort as gsl_block_ushort_struct

extern "c"
declare function gsl_block_ushort_alloc (byval n as integer) as gsl_block_ushort ptr
declare function gsl_block_ushort_calloc (byval n as integer) as gsl_block_ushort ptr
declare sub gsl_block_ushort_free (byval b as gsl_block_ushort ptr)
declare function gsl_block_ushort_fread (byval stream as FILE ptr, byval b as gsl_block_ushort ptr) as integer
declare function gsl_block_ushort_fwrite (byval stream as FILE ptr, byval b as gsl_block_ushort ptr) as integer
declare function gsl_block_ushort_fscanf (byval stream as FILE ptr, byval b as gsl_block_ushort ptr) as integer
declare function gsl_block_ushort_fprintf (byval stream as FILE ptr, byval b as gsl_block_ushort ptr, byval format as zstring ptr) as integer
declare function gsl_block_ushort_raw_fread (byval stream as FILE ptr, byval b as ushort ptr, byval n as integer, byval stride as integer) as integer
declare function gsl_block_ushort_raw_fwrite (byval stream as FILE ptr, byval b as ushort ptr, byval n as integer, byval stride as integer) as integer
declare function gsl_block_ushort_raw_fscanf (byval stream as FILE ptr, byval b as ushort ptr, byval n as integer, byval stride as integer) as integer
declare function gsl_block_ushort_raw_fprintf (byval stream as FILE ptr, byval b as ushort ptr, byval n as integer, byval stride as integer, byval format as zstring ptr) as integer
declare function gsl_block_ushort_size (byval b as gsl_block_ushort ptr) as integer
declare function gsl_block_ushort_data (byval b as gsl_block_ushort ptr) as ushort ptr
end extern

#endif
