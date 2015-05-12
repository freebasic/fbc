''
''
'' gsl_statistics_uint -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_statistics_uint_bi__
#define __gsl_statistics_uint_bi__

#include once "gsl_types.bi"

extern "c"
declare function gsl_stats_uint_mean (byval data as uinteger ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_uint_variance (byval data as uinteger ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_uint_sd (byval data as uinteger ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_uint_variance_with_fixed_mean (byval data as uinteger ptr, byval stride as integer, byval n as integer, byval mean as double) as double
declare function gsl_stats_uint_sd_with_fixed_mean (byval data as uinteger ptr, byval stride as integer, byval n as integer, byval mean as double) as double
declare function gsl_stats_uint_absdev (byval data as uinteger ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_uint_skew (byval data as uinteger ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_uint_kurtosis (byval data as uinteger ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_uint_lag1_autocorrelation (byval data as uinteger ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_uint_covariance (byval data1 as uinteger ptr, byval stride1 as integer, byval data2 as uinteger ptr, byval stride2 as integer, byval n as integer) as double
declare function gsl_stats_uint_variance_m (byval data as uinteger ptr, byval stride as integer, byval n as integer, byval mean as double) as double
declare function gsl_stats_uint_sd_m (byval data as uinteger ptr, byval stride as integer, byval n as integer, byval mean as double) as double
declare function gsl_stats_uint_absdev_m (byval data as uinteger ptr, byval stride as integer, byval n as integer, byval mean as double) as double
declare function gsl_stats_uint_skew_m_sd (byval data as uinteger ptr, byval stride as integer, byval n as integer, byval mean as double, byval sd as double) as double
declare function gsl_stats_uint_kurtosis_m_sd (byval data as uinteger ptr, byval stride as integer, byval n as integer, byval mean as double, byval sd as double) as double
declare function gsl_stats_uint_lag1_autocorrelation_m (byval data as uinteger ptr, byval stride as integer, byval n as integer, byval mean as double) as double
declare function gsl_stats_uint_covariance_m (byval data1 as uinteger ptr, byval stride1 as integer, byval data2 as uinteger ptr, byval stride2 as integer, byval n as integer, byval mean1 as double, byval mean2 as double) as double
declare function gsl_stats_uint_pvariance (byval data1 as uinteger ptr, byval stride1 as integer, byval n1 as integer, byval data2 as uinteger ptr, byval stride2 as integer, byval n2 as integer) as double
declare function gsl_stats_uint_ttest (byval data1 as uinteger ptr, byval stride1 as integer, byval n1 as integer, byval data2 as uinteger ptr, byval stride2 as integer, byval n2 as integer) as double
declare function gsl_stats_uint_max (byval data as uinteger ptr, byval stride as integer, byval n as integer) as uinteger
declare function gsl_stats_uint_min (byval data as uinteger ptr, byval stride as integer, byval n as integer) as uinteger
declare sub gsl_stats_uint_minmax (byval min as uinteger ptr, byval max as uinteger ptr, byval data as uinteger ptr, byval stride as integer, byval n as integer)
declare function gsl_stats_uint_max_index (byval data as uinteger ptr, byval stride as integer, byval n as integer) as integer
declare function gsl_stats_uint_min_index (byval data as uinteger ptr, byval stride as integer, byval n as integer) as integer
declare sub gsl_stats_uint_minmax_index (byval min_index as integer ptr, byval max_index as integer ptr, byval data as uinteger ptr, byval stride as integer, byval n as integer)
declare function gsl_stats_uint_median_from_sorted_data (byval sorted_data as uinteger ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_uint_quantile_from_sorted_data (byval sorted_data as uinteger ptr, byval stride as integer, byval n as integer, byval f as double) as double
end extern

#endif
