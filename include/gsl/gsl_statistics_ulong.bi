''
''
'' gsl_statistics_ulong -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_statistics_ulong_bi__
#define __gsl_statistics_ulong_bi__

#include once "gsl_types.bi"

extern "c"
declare function gsl_stats_ulong_mean (byval data as uinteger ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_ulong_variance (byval data as uinteger ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_ulong_sd (byval data as uinteger ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_ulong_variance_with_fixed_mean (byval data as uinteger ptr, byval stride as integer, byval n as integer, byval mean as double) as double
declare function gsl_stats_ulong_sd_with_fixed_mean (byval data as uinteger ptr, byval stride as integer, byval n as integer, byval mean as double) as double
declare function gsl_stats_ulong_absdev (byval data as uinteger ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_ulong_skew (byval data as uinteger ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_ulong_kurtosis (byval data as uinteger ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_ulong_lag1_autocorrelation (byval data as uinteger ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_ulong_covariance (byval data1 as uinteger ptr, byval stride1 as integer, byval data2 as uinteger ptr, byval stride2 as integer, byval n as integer) as double
declare function gsl_stats_ulong_variance_m (byval data as uinteger ptr, byval stride as integer, byval n as integer, byval mean as double) as double
declare function gsl_stats_ulong_sd_m (byval data as uinteger ptr, byval stride as integer, byval n as integer, byval mean as double) as double
declare function gsl_stats_ulong_absdev_m (byval data as uinteger ptr, byval stride as integer, byval n as integer, byval mean as double) as double
declare function gsl_stats_ulong_skew_m_sd (byval data as uinteger ptr, byval stride as integer, byval n as integer, byval mean as double, byval sd as double) as double
declare function gsl_stats_ulong_kurtosis_m_sd (byval data as uinteger ptr, byval stride as integer, byval n as integer, byval mean as double, byval sd as double) as double
declare function gsl_stats_ulong_lag1_autocorrelation_m (byval data as uinteger ptr, byval stride as integer, byval n as integer, byval mean as double) as double
declare function gsl_stats_ulong_covariance_m (byval data1 as uinteger ptr, byval stride1 as integer, byval data2 as uinteger ptr, byval stride2 as integer, byval n as integer, byval mean1 as double, byval mean2 as double) as double
declare function gsl_stats_ulong_pvariance (byval data1 as uinteger ptr, byval stride1 as integer, byval n1 as integer, byval data2 as uinteger ptr, byval stride2 as integer, byval n2 as integer) as double
declare function gsl_stats_ulong_ttest (byval data1 as uinteger ptr, byval stride1 as integer, byval n1 as integer, byval data2 as uinteger ptr, byval stride2 as integer, byval n2 as integer) as double
declare function gsl_stats_ulong_max (byval data as uinteger ptr, byval stride as integer, byval n as integer) as uinteger
declare function gsl_stats_ulong_min (byval data as uinteger ptr, byval stride as integer, byval n as integer) as uinteger
declare sub gsl_stats_ulong_minmax (byval min as uinteger ptr, byval max as uinteger ptr, byval data as uinteger ptr, byval stride as integer, byval n as integer)
declare function gsl_stats_ulong_max_index (byval data as uinteger ptr, byval stride as integer, byval n as integer) as integer
declare function gsl_stats_ulong_min_index (byval data as uinteger ptr, byval stride as integer, byval n as integer) as integer
declare sub gsl_stats_ulong_minmax_index (byval min_index as integer ptr, byval max_index as integer ptr, byval data as uinteger ptr, byval stride as integer, byval n as integer)
declare function gsl_stats_ulong_median_from_sorted_data (byval sorted_data as uinteger ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_ulong_quantile_from_sorted_data (byval sorted_data as uinteger ptr, byval stride as integer, byval n as integer, byval f as double) as double
end extern

#endif
