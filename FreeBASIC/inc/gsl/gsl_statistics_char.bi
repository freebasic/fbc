''
''
'' gsl_statistics_char -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_statistics_char_bi__
#define __gsl_statistics_char_bi__

#include once "gsl_types.bi"

extern "c"
declare function gsl_stats_char_mean (byval data as zstring ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_char_variance (byval data as zstring ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_char_sd (byval data as zstring ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_char_variance_with_fixed_mean (byval data as zstring ptr, byval stride as integer, byval n as integer, byval mean as double) as double
declare function gsl_stats_char_sd_with_fixed_mean (byval data as zstring ptr, byval stride as integer, byval n as integer, byval mean as double) as double
declare function gsl_stats_char_absdev (byval data as zstring ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_char_skew (byval data as zstring ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_char_kurtosis (byval data as zstring ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_char_lag1_autocorrelation (byval data as zstring ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_char_covariance (byval data1 as zstring ptr, byval stride1 as integer, byval data2 as zstring ptr, byval stride2 as integer, byval n as integer) as double
declare function gsl_stats_char_variance_m (byval data as zstring ptr, byval stride as integer, byval n as integer, byval mean as double) as double
declare function gsl_stats_char_sd_m (byval data as zstring ptr, byval stride as integer, byval n as integer, byval mean as double) as double
declare function gsl_stats_char_absdev_m (byval data as zstring ptr, byval stride as integer, byval n as integer, byval mean as double) as double
declare function gsl_stats_char_skew_m_sd (byval data as zstring ptr, byval stride as integer, byval n as integer, byval mean as double, byval sd as double) as double
declare function gsl_stats_char_kurtosis_m_sd (byval data as zstring ptr, byval stride as integer, byval n as integer, byval mean as double, byval sd as double) as double
declare function gsl_stats_char_lag1_autocorrelation_m (byval data as zstring ptr, byval stride as integer, byval n as integer, byval mean as double) as double
declare function gsl_stats_char_covariance_m (byval data1 as zstring ptr, byval stride1 as integer, byval data2 as zstring ptr, byval stride2 as integer, byval n as integer, byval mean1 as double, byval mean2 as double) as double
declare function gsl_stats_char_pvariance (byval data1 as zstring ptr, byval stride1 as integer, byval n1 as integer, byval data2 as zstring ptr, byval stride2 as integer, byval n2 as integer) as double
declare function gsl_stats_char_ttest (byval data1 as zstring ptr, byval stride1 as integer, byval n1 as integer, byval data2 as zstring ptr, byval stride2 as integer, byval n2 as integer) as double
declare function gsl_stats_char_max (byval data as zstring ptr, byval stride as integer, byval n as integer) as byte
declare function gsl_stats_char_min (byval data as zstring ptr, byval stride as integer, byval n as integer) as byte
declare sub gsl_stats_char_minmax (byval min as zstring ptr, byval max as zstring ptr, byval data as zstring ptr, byval stride as integer, byval n as integer)
declare function gsl_stats_char_max_index (byval data as zstring ptr, byval stride as integer, byval n as integer) as integer
declare function gsl_stats_char_min_index (byval data as zstring ptr, byval stride as integer, byval n as integer) as integer
declare sub gsl_stats_char_minmax_index (byval min_index as integer ptr, byval max_index as integer ptr, byval data as zstring ptr, byval stride as integer, byval n as integer)
declare function gsl_stats_char_median_from_sorted_data (byval sorted_data as zstring ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_char_quantile_from_sorted_data (byval sorted_data as zstring ptr, byval stride as integer, byval n as integer, byval f as double) as double
end extern

#endif
