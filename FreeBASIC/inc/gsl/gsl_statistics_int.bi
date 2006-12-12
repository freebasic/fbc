''
''
'' gsl_statistics_int -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_statistics_int_bi__
#define __gsl_statistics_int_bi__

#include once "gsl_types.bi"

extern "c"
declare function gsl_stats_int_mean (byval data as integer ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_int_variance (byval data as integer ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_int_sd (byval data as integer ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_int_variance_with_fixed_mean (byval data as integer ptr, byval stride as integer, byval n as integer, byval mean as double) as double
declare function gsl_stats_int_sd_with_fixed_mean (byval data as integer ptr, byval stride as integer, byval n as integer, byval mean as double) as double
declare function gsl_stats_int_absdev (byval data as integer ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_int_skew (byval data as integer ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_int_kurtosis (byval data as integer ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_int_lag1_autocorrelation (byval data as integer ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_int_covariance (byval data1 as integer ptr, byval stride1 as integer, byval data2 as integer ptr, byval stride2 as integer, byval n as integer) as double
declare function gsl_stats_int_variance_m (byval data as integer ptr, byval stride as integer, byval n as integer, byval mean as double) as double
declare function gsl_stats_int_sd_m (byval data as integer ptr, byval stride as integer, byval n as integer, byval mean as double) as double
declare function gsl_stats_int_absdev_m (byval data as integer ptr, byval stride as integer, byval n as integer, byval mean as double) as double
declare function gsl_stats_int_skew_m_sd (byval data as integer ptr, byval stride as integer, byval n as integer, byval mean as double, byval sd as double) as double
declare function gsl_stats_int_kurtosis_m_sd (byval data as integer ptr, byval stride as integer, byval n as integer, byval mean as double, byval sd as double) as double
declare function gsl_stats_int_lag1_autocorrelation_m (byval data as integer ptr, byval stride as integer, byval n as integer, byval mean as double) as double
declare function gsl_stats_int_covariance_m (byval data1 as integer ptr, byval stride1 as integer, byval data2 as integer ptr, byval stride2 as integer, byval n as integer, byval mean1 as double, byval mean2 as double) as double
declare function gsl_stats_int_pvariance (byval data1 as integer ptr, byval stride1 as integer, byval n1 as integer, byval data2 as integer ptr, byval stride2 as integer, byval n2 as integer) as double
declare function gsl_stats_int_ttest (byval data1 as integer ptr, byval stride1 as integer, byval n1 as integer, byval data2 as integer ptr, byval stride2 as integer, byval n2 as integer) as double
declare function gsl_stats_int_max (byval data as integer ptr, byval stride as integer, byval n as integer) as integer
declare function gsl_stats_int_min (byval data as integer ptr, byval stride as integer, byval n as integer) as integer
declare sub gsl_stats_int_minmax (byval min as integer ptr, byval max as integer ptr, byval data as integer ptr, byval stride as integer, byval n as integer)
declare function gsl_stats_int_max_index (byval data as integer ptr, byval stride as integer, byval n as integer) as integer
declare function gsl_stats_int_min_index (byval data as integer ptr, byval stride as integer, byval n as integer) as integer
declare sub gsl_stats_int_minmax_index (byval min_index as integer ptr, byval max_index as integer ptr, byval data as integer ptr, byval stride as integer, byval n as integer)
declare function gsl_stats_int_median_from_sorted_data (byval sorted_data as integer ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_int_quantile_from_sorted_data (byval sorted_data as integer ptr, byval stride as integer, byval n as integer, byval f as double) as double
end extern

#endif
