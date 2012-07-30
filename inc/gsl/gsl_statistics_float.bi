''
''
'' gsl_statistics_float -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_statistics_float_bi__
#define __gsl_statistics_float_bi__

#include once "gsl_types.bi"

extern "c"
declare function gsl_stats_float_mean (byval data as single ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_float_variance (byval data as single ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_float_sd (byval data as single ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_float_variance_with_fixed_mean (byval data as single ptr, byval stride as integer, byval n as integer, byval mean as double) as double
declare function gsl_stats_float_sd_with_fixed_mean (byval data as single ptr, byval stride as integer, byval n as integer, byval mean as double) as double
declare function gsl_stats_float_absdev (byval data as single ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_float_skew (byval data as single ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_float_kurtosis (byval data as single ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_float_lag1_autocorrelation (byval data as single ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_float_covariance (byval data1 as single ptr, byval stride1 as integer, byval data2 as single ptr, byval stride2 as integer, byval n as integer) as double
declare function gsl_stats_float_variance_m (byval data as single ptr, byval stride as integer, byval n as integer, byval mean as double) as double
declare function gsl_stats_float_sd_m (byval data as single ptr, byval stride as integer, byval n as integer, byval mean as double) as double
declare function gsl_stats_float_absdev_m (byval data as single ptr, byval stride as integer, byval n as integer, byval mean as double) as double
declare function gsl_stats_float_skew_m_sd (byval data as single ptr, byval stride as integer, byval n as integer, byval mean as double, byval sd as double) as double
declare function gsl_stats_float_kurtosis_m_sd (byval data as single ptr, byval stride as integer, byval n as integer, byval mean as double, byval sd as double) as double
declare function gsl_stats_float_lag1_autocorrelation_m (byval data as single ptr, byval stride as integer, byval n as integer, byval mean as double) as double
declare function gsl_stats_float_covariance_m (byval data1 as single ptr, byval stride1 as integer, byval data2 as single ptr, byval stride2 as integer, byval n as integer, byval mean1 as double, byval mean2 as double) as double
declare function gsl_stats_float_wmean (byval w as single ptr, byval wstride as integer, byval data as single ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_float_wvariance (byval w as single ptr, byval wstride as integer, byval data as single ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_float_wsd (byval w as single ptr, byval wstride as integer, byval data as single ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_float_wvariance_with_fixed_mean (byval w as single ptr, byval wstride as integer, byval data as single ptr, byval stride as integer, byval n as integer, byval mean as double) as double
declare function gsl_stats_float_wsd_with_fixed_mean (byval w as single ptr, byval wstride as integer, byval data as single ptr, byval stride as integer, byval n as integer, byval mean as double) as double
declare function gsl_stats_float_wabsdev (byval w as single ptr, byval wstride as integer, byval data as single ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_float_wskew (byval w as single ptr, byval wstride as integer, byval data as single ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_float_wkurtosis (byval w as single ptr, byval wstride as integer, byval data as single ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_float_wvariance_m (byval w as single ptr, byval wstride as integer, byval data as single ptr, byval stride as integer, byval n as integer, byval wmean as double) as double
declare function gsl_stats_float_wsd_m (byval w as single ptr, byval wstride as integer, byval data as single ptr, byval stride as integer, byval n as integer, byval wmean as double) as double
declare function gsl_stats_float_wabsdev_m (byval w as single ptr, byval wstride as integer, byval data as single ptr, byval stride as integer, byval n as integer, byval wmean as double) as double
declare function gsl_stats_float_wskew_m_sd (byval w as single ptr, byval wstride as integer, byval data as single ptr, byval stride as integer, byval n as integer, byval wmean as double, byval wsd as double) as double
declare function gsl_stats_float_wkurtosis_m_sd (byval w as single ptr, byval wstride as integer, byval data as single ptr, byval stride as integer, byval n as integer, byval wmean as double, byval wsd as double) as double
declare function gsl_stats_float_pvariance (byval data1 as single ptr, byval stride1 as integer, byval n1 as integer, byval data2 as single ptr, byval stride2 as integer, byval n2 as integer) as double
declare function gsl_stats_float_ttest (byval data1 as single ptr, byval stride1 as integer, byval n1 as integer, byval data2 as single ptr, byval stride2 as integer, byval n2 as integer) as double
declare function gsl_stats_float_max (byval data as single ptr, byval stride as integer, byval n as integer) as single
declare function gsl_stats_float_min (byval data as single ptr, byval stride as integer, byval n as integer) as single
declare sub gsl_stats_float_minmax (byval min as single ptr, byval max as single ptr, byval data as single ptr, byval stride as integer, byval n as integer)
declare function gsl_stats_float_max_index (byval data as single ptr, byval stride as integer, byval n as integer) as integer
declare function gsl_stats_float_min_index (byval data as single ptr, byval stride as integer, byval n as integer) as integer
declare sub gsl_stats_float_minmax_index (byval min_index as integer ptr, byval max_index as integer ptr, byval data as single ptr, byval stride as integer, byval n as integer)
declare function gsl_stats_float_median_from_sorted_data (byval sorted_data as single ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_float_quantile_from_sorted_data (byval sorted_data as single ptr, byval stride as integer, byval n as integer, byval f as double) as double
end extern

#endif
