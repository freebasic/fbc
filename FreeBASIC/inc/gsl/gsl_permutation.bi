''
''
'' gsl_permutation -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_permutation_bi__
#define __gsl_permutation_bi__

#include once "gsl/gsl_types.bi"
#include once "gsl/gsl_errno.bi"
#include once "gsl/gsl_check_range.bi"

type gsl_permutation_struct
	size as integer
	data as integer ptr
end type

type gsl_permutation as gsl_permutation_struct

declare function gsl_permutation_alloc cdecl alias "gsl_permutation_alloc" (byval n as integer) as gsl_permutation ptr
declare function gsl_permutation_calloc cdecl alias "gsl_permutation_calloc" (byval n as integer) as gsl_permutation ptr
declare sub gsl_permutation_init cdecl alias "gsl_permutation_init" (byval p as gsl_permutation ptr)
declare sub gsl_permutation_free cdecl alias "gsl_permutation_free" (byval p as gsl_permutation ptr)
declare function gsl_permutation_memcpy cdecl alias "gsl_permutation_memcpy" (byval dest as gsl_permutation ptr, byval src as gsl_permutation ptr) as integer
declare function gsl_permutation_fread cdecl alias "gsl_permutation_fread" (byval stream as FILE ptr, byval p as gsl_permutation ptr) as integer
declare function gsl_permutation_fwrite cdecl alias "gsl_permutation_fwrite" (byval stream as FILE ptr, byval p as gsl_permutation ptr) as integer
declare function gsl_permutation_fscanf cdecl alias "gsl_permutation_fscanf" (byval stream as FILE ptr, byval p as gsl_permutation ptr) as integer
declare function gsl_permutation_fprintf cdecl alias "gsl_permutation_fprintf" (byval stream as FILE ptr, byval p as gsl_permutation ptr, byval format as string) as integer
declare function gsl_permutation_size cdecl alias "gsl_permutation_size" (byval p as gsl_permutation ptr) as integer
declare function gsl_permutation_data cdecl alias "gsl_permutation_data" (byval p as gsl_permutation ptr) as integer ptr
declare function gsl_permutation_get cdecl alias "gsl_permutation_get" (byval p as gsl_permutation ptr, byval i as integer) as integer
declare function gsl_permutation_swap cdecl alias "gsl_permutation_swap" (byval p as gsl_permutation ptr, byval i as integer, byval j as integer) as integer
declare function gsl_permutation_valid cdecl alias "gsl_permutation_valid" (byval p as gsl_permutation ptr) as integer
declare sub gsl_permutation_reverse cdecl alias "gsl_permutation_reverse" (byval p as gsl_permutation ptr)
declare function gsl_permutation_inverse cdecl alias "gsl_permutation_inverse" (byval inv as gsl_permutation ptr, byval p as gsl_permutation ptr) as integer
declare function gsl_permutation_next cdecl alias "gsl_permutation_next" (byval p as gsl_permutation ptr) as integer
declare function gsl_permutation_prev cdecl alias "gsl_permutation_prev" (byval p as gsl_permutation ptr) as integer
declare function gsl_permutation_mul cdecl alias "gsl_permutation_mul" (byval p as gsl_permutation ptr, byval pa as gsl_permutation ptr, byval pb as gsl_permutation ptr) as integer
declare function gsl_permutation_linear_to_canonical cdecl alias "gsl_permutation_linear_to_canonical" (byval q as gsl_permutation ptr, byval p as gsl_permutation ptr) as integer
declare function gsl_permutation_canonical_to_linear cdecl alias "gsl_permutation_canonical_to_linear" (byval p as gsl_permutation ptr, byval q as gsl_permutation ptr) as integer
declare function gsl_permutation_inversions cdecl alias "gsl_permutation_inversions" (byval p as gsl_permutation ptr) as integer
declare function gsl_permutation_linear_cycles cdecl alias "gsl_permutation_linear_cycles" (byval p as gsl_permutation ptr) as integer
declare function gsl_permutation_canonical_cycles cdecl alias "gsl_permutation_canonical_cycles" (byval q as gsl_permutation ptr) as integer

#endif
