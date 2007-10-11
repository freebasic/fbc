''
''
'' gsl_block_short -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_block_short_bi__
#define __gsl_block_short_bi__

#include once "gsl_errno.bi"
#include once "gsl_types.bi"

type gsl_block_short_struct
	size as integer
	data as short ptr
end type

type gsl_block_short as gsl_block_short_struct

extern "c"
declare function gsl_block_short_alloc (byval n as integer) as gsl_block_short ptr
declare function gsl_block_short_calloc (byval n as integer) as gsl_block_short ptr
declare sub gsl_block_short_free (byval b as gsl_block_short ptr)
declare function gsl_block_short_fread (byval stream as FILE ptr, byval b as gsl_block_short ptr) as integer
declare function gsl_block_short_fwrite (byval stream as FILE ptr, byval b as gsl_block_short ptr) as integer
declare function gsl_block_short_fscanf (byval stream as FILE ptr, byval b as gsl_block_short ptr) as integer
declare function gsl_block_short_fprintf (byval stream as FILE ptr, byval b as gsl_block_short ptr, byval format as zstring ptr) as integer
declare function gsl_block_short_raw_fread (byval stream as FILE ptr, byval b as short ptr, byval n as integer, byval stride as integer) as integer
declare function gsl_block_short_raw_fwrite (byval stream as FILE ptr, byval b as short ptr, byval n as integer, byval stride as integer) as integer
declare function gsl_block_short_raw_fscanf (byval stream as FILE ptr, byval b as short ptr, byval n as integer, byval stride as integer) as integer
declare function gsl_block_short_raw_fprintf (byval stream as FILE ptr, byval b as short ptr, byval n as integer, byval stride as integer, byval format as zstring ptr) as integer
declare function gsl_block_short_size (byval b as gsl_block_short ptr) as integer
declare function gsl_block_short_data (byval b as gsl_block_short ptr) as short ptr
end extern

#endif
