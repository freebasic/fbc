''
''
'' gsl_statistics_long_double -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_statistics_long_double_bi__
#define __gsl_statistics_long_double_bi__

#include once "gsl_types.bi"

extern "c"
declare function gsl_stats_long_double_mean (byval data as double ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_long_double_variance (byval data as double ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_long_double_sd (byval data as double ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_long_double_variance_with_fixed_mean (byval data as double ptr, byval stride as integer, byval n as integer, byval mean as double) as double
declare function gsl_stats_long_double_sd_with_fixed_mean (byval data as double ptr, byval stride as integer, byval n as integer, byval mean as double) as double
declare function gsl_stats_long_double_absdev (byval data as double ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_long_double_skew (byval data as double ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_long_double_kurtosis (byval data as double ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_long_double_lag1_autocorrelation (byval data as double ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_long_double_covariance (byval data1 as double ptr, byval stride1 as integer, byval data2 as double ptr, byval stride2 as integer, byval n as integer) as double
declare function gsl_stats_long_double_variance_m (byval data as double ptr, byval stride as integer, byval n as integer, byval mean as double) as double
declare function gsl_stats_long_double_sd_m (byval data as double ptr, byval stride as integer, byval n as integer, byval mean as double) as double
declare function gsl_stats_long_double_absdev_m (byval data as double ptr, byval stride as integer, byval n as integer, byval mean as double) as double
declare function gsl_stats_long_double_skew_m_sd (byval data as double ptr, byval stride as integer, byval n as integer, byval mean as double, byval sd as double) as double
declare function gsl_stats_long_double_kurtosis_m_sd (byval data as double ptr, byval stride as integer, byval n as integer, byval mean as double, byval sd as double) as double
declare function gsl_stats_long_double_lag1_autocorrelation_m (byval data as double ptr, byval stride as integer, byval n as integer, byval mean as double) as double
declare function gsl_stats_long_double_covariance_m (byval data1 as double ptr, byval stride1 as integer, byval data2 as double ptr, byval stride2 as integer, byval n as integer, byval mean1 as double, byval mean2 as double) as double
declare function gsl_stats_long_double_wmean (byval w as double ptr, byval wstride as integer, byval data as double ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_long_double_wvariance (byval w as double ptr, byval wstride as integer, byval data as double ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_long_double_wsd (byval w as double ptr, byval wstride as integer, byval data as double ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_long_double_wvariance_with_fixed_mean (byval w as double ptr, byval wstride as integer, byval data as double ptr, byval stride as integer, byval n as integer, byval mean as double) as double
declare function gsl_stats_long_double_wsd_with_fixed_mean (byval w as double ptr, byval wstride as integer, byval data as double ptr, byval stride as integer, byval n as integer, byval mean as double) as double
declare function gsl_stats_long_double_wabsdev (byval w as double ptr, byval wstride as integer, byval data as double ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_long_double_wskew (byval w as double ptr, byval wstride as integer, byval data as double ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_long_double_wkurtosis (byval w as double ptr, byval wstride as integer, byval data as double ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_long_double_wvariance_m (byval w as double ptr, byval wstride as integer, byval data as double ptr, byval stride as integer, byval n as integer, byval wmean as double) as double
declare function gsl_stats_long_double_wsd_m (byval w as double ptr, byval wstride as integer, byval data as double ptr, byval stride as integer, byval n as integer, byval wmean as double) as double
declare function gsl_stats_long_double_wabsdev_m (byval w as double ptr, byval wstride as integer, byval data as double ptr, byval stride as integer, byval n as integer, byval wmean as double) as double
declare function gsl_stats_long_double_wskew_m_sd (byval w as double ptr, byval wstride as integer, byval data as double ptr, byval stride as integer, byval n as integer, byval wmean as double, byval wsd as double) as double
declare function gsl_stats_long_double_wkurtosis_m_sd (byval w as double ptr, byval wstride as integer, byval data as double ptr, byval stride as integer, byval n as integer, byval wmean as double, byval wsd as double) as double
declare function gsl_stats_long_double_pvariance (byval data1 as double ptr, byval stride1 as integer, byval n1 as integer, byval data2 as double ptr, byval stride2 as integer, byval n2 as integer) as double
declare function gsl_stats_long_double_ttest (byval data1 as double ptr, byval stride1 as integer, byval n1 as integer, byval data2 as double ptr, byval stride2 as integer, byval n2 as integer) as double
declare function gsl_stats_long_double_max (byval data as double ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_long_double_min (byval data as double ptr, byval stride as integer, byval n as integer) as double
declare sub gsl_stats_long_double_minmax (byval min as double ptr, byval max as double ptr, byval data as double ptr, byval stride as integer, byval n as integer)
declare function gsl_stats_long_double_max_index (byval data as double ptr, byval stride as integer, byval n as integer) as integer
declare function gsl_stats_long_double_min_index (byval data as double ptr, byval stride as integer, byval n as integer) as integer
declare sub gsl_stats_long_double_minmax_index (byval min_index as integer ptr, byval max_index as integer ptr, byval data as double ptr, byval stride as integer, byval n as integer)
declare function gsl_stats_long_double_median_from_sorted_data (byval sorted_data as double ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_long_double_quantile_from_sorted_data (byval sorted_data as double ptr, byval stride as integer, byval n as integer, byval f as double) as double
end extern

#endif
