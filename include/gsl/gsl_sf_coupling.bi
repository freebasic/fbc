''
''
'' gsl_sf_coupling -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_sf_coupling_bi__
#define __gsl_sf_coupling_bi__

#include once "gsl_sf_result.bi"
#include once "gsl_types.bi"

extern "c"
declare function gsl_sf_coupling_3j_e (byval two_ja as integer, byval two_jb as integer, byval two_jc as integer, byval two_ma as integer, byval two_mb as integer, byval two_mc as integer, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_coupling_3j (byval two_ja as integer, byval two_jb as integer, byval two_jc as integer, byval two_ma as integer, byval two_mb as integer, byval two_mc as integer) as double
declare function gsl_sf_coupling_6j_e (byval two_ja as integer, byval two_jb as integer, byval two_jc as integer, byval two_jd as integer, byval two_je as integer, byval two_jf as integer, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_coupling_6j (byval two_ja as integer, byval two_jb as integer, byval two_jc as integer, byval two_jd as integer, byval two_je as integer, byval two_jf as integer) as double
declare function gsl_sf_coupling_RacahW_e (byval two_ja as integer, byval two_jb as integer, byval two_jc as integer, byval two_jd as integer, byval two_je as integer, byval two_jf as integer, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_coupling_RacahW (byval two_ja as integer, byval two_jb as integer, byval two_jc as integer, byval two_jd as integer, byval two_je as integer, byval two_jf as integer) as double
declare function gsl_sf_coupling_9j_e (byval two_ja as integer, byval two_jb as integer, byval two_jc as integer, byval two_jd as integer, byval two_je as integer, byval two_jf as integer, byval two_jg as integer, byval two_jh as integer, byval two_ji as integer, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_coupling_9j (byval two_ja as integer, byval two_jb as integer, byval two_jc as integer, byval two_jd as integer, byval two_je as integer, byval two_jf as integer, byval two_jg as integer, byval two_jh as integer, byval two_ji as integer) as double
declare function gsl_sf_coupling_6j_INCORRECT_e (byval two_ja as integer, byval two_jb as integer, byval two_jc as integer, byval two_jd as integer, byval two_je as integer, byval two_jf as integer, byval result as gsl_sf_result ptr) as integer
declare function gsl_sf_coupling_6j_INCORRECT (byval two_ja as integer, byval two_jb as integer, byval two_jc as integer, byval two_jd as integer, byval two_je as integer, byval two_jf as integer) as double
end extern

#endif
