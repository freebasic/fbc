''
''
'' gsl_dht -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_dht_bi__
#define __gsl_dht_bi__

#include once "gsl_types.bi"

type gsl_dht_struct
	size as integer
	nu as double
	xmax as double
	kmax as double
	j as double ptr
	Jjj as double ptr
	J2 as double ptr
end type

type gsl_dht as gsl_dht_struct

extern "c"
declare function gsl_dht_alloc (byval size as integer) as gsl_dht ptr
declare function gsl_dht_new (byval size as integer, byval nu as double, byval xmax as double) as gsl_dht ptr
declare function gsl_dht_init (byval t as gsl_dht ptr, byval nu as double, byval xmax as double) as integer
declare function gsl_dht_x_sample (byval t as gsl_dht ptr, byval n as integer) as double
declare function gsl_dht_k_sample (byval t as gsl_dht ptr, byval n as integer) as double
declare sub gsl_dht_free (byval t as gsl_dht ptr)
declare function gsl_dht_apply (byval t as gsl_dht ptr, byval f_in as double ptr, byval f_out as double ptr) as integer
end extern

#endif
