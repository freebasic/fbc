''
''
'' gsl_statistics_short -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_statistics_short_bi__
#define __gsl_statistics_short_bi__

#include once "gsl_types.bi"

extern "c"
declare function gsl_stats_short_mean (byval data as short ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_short_variance (byval data as short ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_short_sd (byval data as short ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_short_variance_with_fixed_mean (byval data as short ptr, byval stride as integer, byval n as integer, byval mean as double) as double
declare function gsl_stats_short_sd_with_fixed_mean (byval data as short ptr, byval stride as integer, byval n as integer, byval mean as double) as double
declare function gsl_stats_short_absdev (byval data as short ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_short_skew (byval data as short ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_short_kurtosis (byval data as short ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_short_lag1_autocorrelation (byval data as short ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_short_covariance (byval data1 as short ptr, byval stride1 as integer, byval data2 as short ptr, byval stride2 as integer, byval n as integer) as double
declare function gsl_stats_short_variance_m (byval data as short ptr, byval stride as integer, byval n as integer, byval mean as double) as double
declare function gsl_stats_short_sd_m (byval data as short ptr, byval stride as integer, byval n as integer, byval mean as double) as double
declare function gsl_stats_short_absdev_m (byval data as short ptr, byval stride as integer, byval n as integer, byval mean as double) as double
declare function gsl_stats_short_skew_m_sd (byval data as short ptr, byval stride as integer, byval n as integer, byval mean as double, byval sd as double) as double
declare function gsl_stats_short_kurtosis_m_sd (byval data as short ptr, byval stride as integer, byval n as integer, byval mean as double, byval sd as double) as double
declare function gsl_stats_short_lag1_autocorrelation_m (byval data as short ptr, byval stride as integer, byval n as integer, byval mean as double) as double
declare function gsl_stats_short_covariance_m (byval data1 as short ptr, byval stride1 as integer, byval data2 as short ptr, byval stride2 as integer, byval n as integer, byval mean1 as double, byval mean2 as double) as double
declare function gsl_stats_short_pvariance (byval data1 as short ptr, byval stride1 as integer, byval n1 as integer, byval data2 as short ptr, byval stride2 as integer, byval n2 as integer) as double
declare function gsl_stats_short_ttest (byval data1 as short ptr, byval stride1 as integer, byval n1 as integer, byval data2 as short ptr, byval stride2 as integer, byval n2 as integer) as double
declare function gsl_stats_short_max (byval data as short ptr, byval stride as integer, byval n as integer) as short
declare function gsl_stats_short_min (byval data as short ptr, byval stride as integer, byval n as integer) as short
declare sub gsl_stats_short_minmax (byval min as short ptr, byval max as short ptr, byval data as short ptr, byval stride as integer, byval n as integer)
declare function gsl_stats_short_max_index (byval data as short ptr, byval stride as integer, byval n as integer) as integer
declare function gsl_stats_short_min_index (byval data as short ptr, byval stride as integer, byval n as integer) as integer
declare sub gsl_stats_short_minmax_index (byval min_index as integer ptr, byval max_index as integer ptr, byval data as short ptr, byval stride as integer, byval n as integer)
declare function gsl_stats_short_median_from_sorted_data (byval sorted_data as short ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_short_quantile_from_sorted_data (byval sorted_data as short ptr, byval stride as integer, byval n as integer, byval f as double) as double
end extern

#endif
