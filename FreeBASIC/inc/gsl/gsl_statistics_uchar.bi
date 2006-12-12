''
''
'' gsl_statistics_uchar -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_statistics_uchar_bi__
#define __gsl_statistics_uchar_bi__

#include once "gsl_types.bi"

extern "c"
declare function gsl_stats_uchar_mean (byval data as ubyte ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_uchar_variance (byval data as ubyte ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_uchar_sd (byval data as ubyte ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_uchar_variance_with_fixed_mean (byval data as ubyte ptr, byval stride as integer, byval n as integer, byval mean as double) as double
declare function gsl_stats_uchar_sd_with_fixed_mean (byval data as ubyte ptr, byval stride as integer, byval n as integer, byval mean as double) as double
declare function gsl_stats_uchar_absdev (byval data as ubyte ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_uchar_skew (byval data as ubyte ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_uchar_kurtosis (byval data as ubyte ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_uchar_lag1_autocorrelation (byval data as ubyte ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_uchar_covariance (byval data1 as ubyte ptr, byval stride1 as integer, byval data2 as ubyte ptr, byval stride2 as integer, byval n as integer) as double
declare function gsl_stats_uchar_variance_m (byval data as ubyte ptr, byval stride as integer, byval n as integer, byval mean as double) as double
declare function gsl_stats_uchar_sd_m (byval data as ubyte ptr, byval stride as integer, byval n as integer, byval mean as double) as double
declare function gsl_stats_uchar_absdev_m (byval data as ubyte ptr, byval stride as integer, byval n as integer, byval mean as double) as double
declare function gsl_stats_uchar_skew_m_sd (byval data as ubyte ptr, byval stride as integer, byval n as integer, byval mean as double, byval sd as double) as double
declare function gsl_stats_uchar_kurtosis_m_sd (byval data as ubyte ptr, byval stride as integer, byval n as integer, byval mean as double, byval sd as double) as double
declare function gsl_stats_uchar_lag1_autocorrelation_m (byval data as ubyte ptr, byval stride as integer, byval n as integer, byval mean as double) as double
declare function gsl_stats_uchar_covariance_m (byval data1 as ubyte ptr, byval stride1 as integer, byval data2 as ubyte ptr, byval stride2 as integer, byval n as integer, byval mean1 as double, byval mean2 as double) as double
declare function gsl_stats_uchar_pvariance (byval data1 as ubyte ptr, byval stride1 as integer, byval n1 as integer, byval data2 as ubyte ptr, byval stride2 as integer, byval n2 as integer) as double
declare function gsl_stats_uchar_ttest (byval data1 as ubyte ptr, byval stride1 as integer, byval n1 as integer, byval data2 as ubyte ptr, byval stride2 as integer, byval n2 as integer) as double
declare function gsl_stats_uchar_max (byval data as ubyte ptr, byval stride as integer, byval n as integer) as ubyte
declare function gsl_stats_uchar_min (byval data as ubyte ptr, byval stride as integer, byval n as integer) as ubyte
declare sub gsl_stats_uchar_minmax (byval min as ubyte ptr, byval max as ubyte ptr, byval data as ubyte ptr, byval stride as integer, byval n as integer)
declare function gsl_stats_uchar_max_index (byval data as ubyte ptr, byval stride as integer, byval n as integer) as integer
declare function gsl_stats_uchar_min_index (byval data as ubyte ptr, byval stride as integer, byval n as integer) as integer
declare sub gsl_stats_uchar_minmax_index (byval min_index as integer ptr, byval max_index as integer ptr, byval data as ubyte ptr, byval stride as integer, byval n as integer)
declare function gsl_stats_uchar_median_from_sorted_data (byval sorted_data as ubyte ptr, byval stride as integer, byval n as integer) as double
declare function gsl_stats_uchar_quantile_from_sorted_data (byval sorted_data as ubyte ptr, byval stride as integer, byval n as integer, byval f as double) as double
end extern

#endif
