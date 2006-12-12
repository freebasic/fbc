''
''
'' gsl_block_char -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_block_char_bi__
#define __gsl_block_char_bi__

#include once "gsl_errno.bi"
#include once "gsl_types.bi"

type gsl_block_char_struct
	size as integer
	data as byte ptr
end type

type gsl_block_char as gsl_block_char_struct

extern "c"
declare function gsl_block_char_alloc (byval n as integer) as gsl_block_char ptr
declare function gsl_block_char_calloc (byval n as integer) as gsl_block_char ptr
declare sub gsl_block_char_free (byval b as gsl_block_char ptr)
declare function gsl_block_char_fread (byval stream as FILE ptr, byval b as gsl_block_char ptr) as integer
declare function gsl_block_char_fwrite (byval stream as FILE ptr, byval b as gsl_block_char ptr) as integer
declare function gsl_block_char_fscanf (byval stream as FILE ptr, byval b as gsl_block_char ptr) as integer
declare function gsl_block_char_fprintf (byval stream as FILE ptr, byval b as gsl_block_char ptr, byval format as zstring ptr) as integer
declare function gsl_block_char_raw_fread (byval stream as FILE ptr, byval b as zstring ptr, byval n as integer, byval stride as integer) as integer
declare function gsl_block_char_raw_fwrite (byval stream as FILE ptr, byval b as zstring ptr, byval n as integer, byval stride as integer) as integer
declare function gsl_block_char_raw_fscanf (byval stream as FILE ptr, byval b as zstring ptr, byval n as integer, byval stride as integer) as integer
declare function gsl_block_char_raw_fprintf (byval stream as FILE ptr, byval b as zstring ptr, byval n as integer, byval stride as integer, byval format as zstring ptr) as integer
declare function gsl_block_char_size (byval b as gsl_block_char ptr) as integer
declare function gsl_block_char_data (byval b as gsl_block_char ptr) as zstring ptr
end extern

#endif
