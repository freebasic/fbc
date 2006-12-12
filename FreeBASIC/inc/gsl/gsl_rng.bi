''
''
'' gsl_rng -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_rng_bi__
#define __gsl_rng_bi__

#include once "gsl_types.bi"
#include once "gsl_errno.bi"

type gsl_rng_type
	name as byte ptr
	max as uinteger
	min as uinteger
	size as integer
	set as sub cdecl(byval as any ptr, byval as uinteger)
	get as function cdecl(byval as any ptr) as uinteger
	get_double as function cdecl(byval as any ptr) as double
end type

type gsl_rng
	type as gsl_rng_type ptr
	state as any ptr
end type

extern "c"
declare function gsl_rng_types_setup () as gsl_rng_type ptr ptr
declare function gsl_rng_alloc (byval T as gsl_rng_type ptr) as gsl_rng ptr
declare function gsl_rng_memcpy (byval dest as gsl_rng ptr, byval src as gsl_rng ptr) as integer
declare function gsl_rng_clone (byval r as gsl_rng ptr) as gsl_rng ptr
declare sub gsl_rng_free (byval r as gsl_rng ptr)
declare sub gsl_rng_set (byval r as gsl_rng ptr, byval seed as uinteger)
declare function gsl_rng_max (byval r as gsl_rng ptr) as uinteger
declare function gsl_rng_min (byval r as gsl_rng ptr) as uinteger
declare function gsl_rng_name (byval r as gsl_rng ptr) as zstring ptr
declare function gsl_rng_fread (byval stream as FILE ptr, byval r as gsl_rng ptr) as integer
declare function gsl_rng_fwrite (byval stream as FILE ptr, byval r as gsl_rng ptr) as integer
declare function gsl_rng_size (byval r as gsl_rng ptr) as integer
declare function gsl_rng_state (byval r as gsl_rng ptr) as any ptr
declare sub gsl_rng_print_state (byval r as gsl_rng ptr)
declare function gsl_rng_env_setup () as gsl_rng_type ptr
declare function gsl_rng_get (byval r as gsl_rng ptr) as uinteger
declare function gsl_rng_uniform (byval r as gsl_rng ptr) as double
declare function gsl_rng_uniform_pos (byval r as gsl_rng ptr) as double
declare function gsl_rng_uniform_int (byval r as gsl_rng ptr, byval n as uinteger) as uinteger
end extern

#endif
