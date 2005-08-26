''
''
'' gsl_block_long -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_block_long_bi__
#define __gsl_block_long_bi__

#include once "gsl/gsl_errno.bi"
#include once "gsl/gsl_types.bi"

type gsl_block_long_struct
	size as integer
	data as integer ptr
end type

type gsl_block_long as gsl_block_long_struct

declare function gsl_block_long_alloc cdecl alias "gsl_block_long_alloc" (byval n as integer) as gsl_block_long ptr
declare function gsl_block_long_calloc cdecl alias "gsl_block_long_calloc" (byval n as integer) as gsl_block_long ptr
declare sub gsl_block_long_free cdecl alias "gsl_block_long_free" (byval b as gsl_block_long ptr)
declare function gsl_block_long_fread cdecl alias "gsl_block_long_fread" (byval stream as FILE ptr, byval b as gsl_block_long ptr) as integer
declare function gsl_block_long_fwrite cdecl alias "gsl_block_long_fwrite" (byval stream as FILE ptr, byval b as gsl_block_long ptr) as integer
declare function gsl_block_long_fscanf cdecl alias "gsl_block_long_fscanf" (byval stream as FILE ptr, byval b as gsl_block_long ptr) as integer
declare function gsl_block_long_fprintf cdecl alias "gsl_block_long_fprintf" (byval stream as FILE ptr, byval b as gsl_block_long ptr, byval format as zstring ptr) as integer
declare function gsl_block_long_raw_fread cdecl alias "gsl_block_long_raw_fread" (byval stream as FILE ptr, byval b as integer ptr, byval n as integer, byval stride as integer) as integer
declare function gsl_block_long_raw_fwrite cdecl alias "gsl_block_long_raw_fwrite" (byval stream as FILE ptr, byval b as integer ptr, byval n as integer, byval stride as integer) as integer
declare function gsl_block_long_raw_fscanf cdecl alias "gsl_block_long_raw_fscanf" (byval stream as FILE ptr, byval b as integer ptr, byval n as integer, byval stride as integer) as integer
declare function gsl_block_long_raw_fprintf cdecl alias "gsl_block_long_raw_fprintf" (byval stream as FILE ptr, byval b as integer ptr, byval n as integer, byval stride as integer, byval format as zstring ptr) as integer
declare function gsl_block_long_size cdecl alias "gsl_block_long_size" (byval b as gsl_block_long ptr) as integer
declare function gsl_block_long_data cdecl alias "gsl_block_long_data" (byval b as gsl_block_long ptr) as integer ptr

#endif
