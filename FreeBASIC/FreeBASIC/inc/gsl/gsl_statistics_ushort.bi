''
''
'' gsl_statistics_ushort -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_statistics_ushort_bi__
#define __gsl_statistics_ushort_bi__

#include once "gsl_types.bi"

extern "c"
declare function gsl_stats_ushort_mean (byval data as ushort ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_ushort_variance (byval data as ushort ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_ushort_sd (byval data as ushort ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_ushort_variance_with_fixed_mean (byval data as ushort ptr, byval stride as integer, byval n as integer, byval mean as double) as double
declare function gsl_stats_ushort_sd_with_fixed_mean (byval data as ushort ptr, byval stride as integer, byval n as integer, byval mean as double) as double
declare function gsl_stats_ushort_absdev (byval data as ushort ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_ushort_skew (byval data as ushort ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_ushort_kurtosis (byval data as ushort ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_ushort_lag1_autocorrelation (byval data as ushort ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_ushort_covariance (byval data1 as ushort ptr, byval stride1 as integer, byval data2 as ushort ptr, byval stride2 as integer, byval n as integer) as double
declare function gsl_stats_ushort_variance_m (byval data as ushort ptr, byval stride as integer, byval n as integer, byval mean as double) as double
declare function gsl_stats_ushort_sd_m (byval data as ushort ptr, byval stride as integer, byval n as integer, byval mean as double) as double
declare function gsl_stats_ushort_absdev_m (byval data as ushort ptr, byval stride as integer, byval n as integer, byval mean as double) as double
declare function gsl_stats_ushort_skew_m_sd (byval data as ushort ptr, byval stride as integer, byval n as integer, byval mean as double, byval sd as double) as double
declare function gsl_stats_ushort_kurtosis_m_sd (byval data as ushort ptr, byval stride as integer, byval n as integer, byval mean as double, byval sd as double) as double
declare function gsl_stats_ushort_lag1_autocorrelation_m (byval data as ushort ptr, byval stride as integer, byval n as integer, byval mean as double) as double
declare function gsl_stats_ushort_covariance_m (byval data1 as ushort ptr, byval stride1 as integer, byval data2 as ushort ptr, byval stride2 as integer, byval n as integer, byval mean1 as double, byval mean2 as double) as double
declare function gsl_stats_ushort_pvariance (byval data1 as ushort ptr, byval stride1 as integer, byval n1 as integer, byval data2 as ushort ptr, byval stride2 as integer, byval n2 as integer) as double
declare function gsl_stats_ushort_ttest (byval data1 as ushort ptr, byval stride1 as integer, byval n1 as integer, byval data2 as ushort ptr, byval stride2 as integer, byval n2 as integer) as double
declare function gsl_stats_ushort_max (byval data as ushort ptr, byval stride as integer, byval n as integer) as ushort
declare function gsl_stats_ushort_min (byval data as ushort ptr, byval stride as integer, byval n as integer) as ushort
declare sub gsl_stats_ushort_minmax (byval min as ushort ptr, byval max as ushort ptr, byval data as ushort ptr, byval stride as integer, byval n as integer)
declare function gsl_stats_ushort_max_index (byval data as ushort ptr, byval stride as integer, byval n as integer) as integer
declare function gsl_stats_ushort_min_index (byval data as ushort ptr, byval stride as integer, byval n as integer) as integer
declare sub gsl_stats_ushort_minmax_index (byval min_index as integer ptr, byval max_index as integer ptr, byval data as ushort ptr, byval stride as integer, byval n as integer)
declare function gsl_stats_ushort_median_from_sorted_data (byval sorted_data as ushort ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_ushort_quantile_from_sorted_data (byval sorted_data as ushort ptr, byval stride as integer, byval n as integer, byval f as double) as double
end extern

#endif
