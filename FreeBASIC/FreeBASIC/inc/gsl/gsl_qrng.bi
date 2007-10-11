''
''
'' gsl_qrng -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_qrng_bi__
#define __gsl_qrng_bi__

#include once "gsl_types.bi"
#include once "gsl_errno.bi"

type gsl_qrng_type
	name as byte ptr
	max_dimension as uinteger
	state_size as function cdecl(byval as uinteger) as integer
	init_state as function cdecl(byval as any ptr, byval as uinteger) as integer
	get as function cdecl(byval as any ptr, byval as uinteger, byval as double ptr) as integer
end type

type gsl_qrng
	type as gsl_qrng_type ptr
	dimension as uinteger
	state_size as integer
	state as any ptr
end type

extern "c"
declare function gsl_qrng_alloc (byval T as gsl_qrng_type ptr, byval dimension as uinteger) as gsl_qrng ptr
declare function gsl_qrng_memcpy (byval dest as gsl_qrng ptr, byval src as gsl_qrng ptr) as integer
declare function gsl_qrng_clone (byval r as gsl_qrng ptr) as gsl_qrng ptr
declare sub gsl_qrng_free (byval r as gsl_qrng ptr)
declare sub gsl_qrng_init (byval r as gsl_qrng ptr)
declare function gsl_qrng_name (byval r as gsl_qrng ptr) as zstring ptr
declare function gsl_qrng_size (byval r as gsl_qrng ptr) as integer
declare function gsl_qrng_state (byval r as gsl_qrng ptr) as any ptr
declare function gsl_qrng_get (byval r as gsl_qrng ptr, byval x as double ptr) as integer
end extern

#endif
