''
''
'' gsl_test -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_test_bi__
#define __gsl_test_bi__

#include once "gsl_types.bi"

extern "c"
declare sub gsl_test (byval status as integer, byval test_description as zstring ptr, ...)
declare sub gsl_test_rel (byval result as double, byval expected as double, byval relative_error as double, byval test_description as zstring ptr, ...)
declare sub gsl_test_abs (byval result as double, byval expected as double, byval absolute_error as double, byval test_description as zstring ptr, ...)
declare sub gsl_test_factor (byval result as double, byval expected as double, byval factor as double, byval test_description as zstring ptr, ...)
declare sub gsl_test_int (byval result as integer, byval expected as integer, byval test_description as zstring ptr, ...)
declare sub gsl_test_str (byval result as zstring ptr, byval expected as zstring ptr, byval test_description as zstring ptr, ...)
declare sub gsl_test_verbose (byval verbose as integer)
declare sub gsl_test_extra_verbose (byval verbose as integer)
declare sub gsl_test_print_summary (byval verbose as integer)
declare function gsl_test_summary () as integer
end extern

#endif
