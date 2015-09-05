'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   statistics/gsl_statistics_uchar.h
''
''   Copyright (C) 1996, 1997, 1998, 1999, 2000, 2007 Jim Davies, Brian Gough
''
''   This program is free software; you can redistribute it and/or modify
''   it under the terms of the GNU General Public License as published by
''   the Free Software Foundation; either version 3 of the License, or (at
''   your option) any later version.
''
''   This program is distributed in the hope that it will be useful, but
''   WITHOUT ANY WARRANTY; without even the implied warranty of
''   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
''   General Public License for more details.
''
''   You should have received a copy of the GNU General Public License
''   along with this program; if not, write to the Free Software
''   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/stddef.bi"

extern "C"

#define __GSL_STATISTICS_UCHAR_H__
declare function gsl_stats_uchar_mean(byval data as const ubyte ptr, byval stride as const uinteger, byval n as const uinteger) as double
declare function gsl_stats_uchar_variance(byval data as const ubyte ptr, byval stride as const uinteger, byval n as const uinteger) as double
declare function gsl_stats_uchar_sd(byval data as const ubyte ptr, byval stride as const uinteger, byval n as const uinteger) as double
declare function gsl_stats_uchar_variance_with_fixed_mean(byval data as const ubyte ptr, byval stride as const uinteger, byval n as const uinteger, byval mean as const double) as double
declare function gsl_stats_uchar_sd_with_fixed_mean(byval data as const ubyte ptr, byval stride as const uinteger, byval n as const uinteger, byval mean as const double) as double
declare function gsl_stats_uchar_tss(byval data as const ubyte ptr, byval stride as const uinteger, byval n as const uinteger) as double
declare function gsl_stats_uchar_tss_m(byval data as const ubyte ptr, byval stride as const uinteger, byval n as const uinteger, byval mean as const double) as double
declare function gsl_stats_uchar_absdev(byval data as const ubyte ptr, byval stride as const uinteger, byval n as const uinteger) as double
declare function gsl_stats_uchar_skew(byval data as const ubyte ptr, byval stride as const uinteger, byval n as const uinteger) as double
declare function gsl_stats_uchar_kurtosis(byval data as const ubyte ptr, byval stride as const uinteger, byval n as const uinteger) as double
declare function gsl_stats_uchar_lag1_autocorrelation(byval data as const ubyte ptr, byval stride as const uinteger, byval n as const uinteger) as double
declare function gsl_stats_uchar_covariance(byval data1 as const ubyte ptr, byval stride1 as const uinteger, byval data2 as const ubyte ptr, byval stride2 as const uinteger, byval n as const uinteger) as double
declare function gsl_stats_uchar_correlation(byval data1 as const ubyte ptr, byval stride1 as const uinteger, byval data2 as const ubyte ptr, byval stride2 as const uinteger, byval n as const uinteger) as double
declare function gsl_stats_uchar_spearman(byval data1 as const ubyte ptr, byval stride1 as const uinteger, byval data2 as const ubyte ptr, byval stride2 as const uinteger, byval n as const uinteger, byval work as double ptr) as double
declare function gsl_stats_uchar_variance_m(byval data as const ubyte ptr, byval stride as const uinteger, byval n as const uinteger, byval mean as const double) as double
declare function gsl_stats_uchar_sd_m(byval data as const ubyte ptr, byval stride as const uinteger, byval n as const uinteger, byval mean as const double) as double
declare function gsl_stats_uchar_absdev_m(byval data as const ubyte ptr, byval stride as const uinteger, byval n as const uinteger, byval mean as const double) as double
declare function gsl_stats_uchar_skew_m_sd(byval data as const ubyte ptr, byval stride as const uinteger, byval n as const uinteger, byval mean as const double, byval sd as const double) as double
declare function gsl_stats_uchar_kurtosis_m_sd(byval data as const ubyte ptr, byval stride as const uinteger, byval n as const uinteger, byval mean as const double, byval sd as const double) as double
declare function gsl_stats_uchar_lag1_autocorrelation_m(byval data as const ubyte ptr, byval stride as const uinteger, byval n as const uinteger, byval mean as const double) as double
declare function gsl_stats_uchar_covariance_m(byval data1 as const ubyte ptr, byval stride1 as const uinteger, byval data2 as const ubyte ptr, byval stride2 as const uinteger, byval n as const uinteger, byval mean1 as const double, byval mean2 as const double) as double
declare function gsl_stats_uchar_pvariance(byval data1 as const ubyte ptr, byval stride1 as const uinteger, byval n1 as const uinteger, byval data2 as const ubyte ptr, byval stride2 as const uinteger, byval n2 as const uinteger) as double
declare function gsl_stats_uchar_ttest(byval data1 as const ubyte ptr, byval stride1 as const uinteger, byval n1 as const uinteger, byval data2 as const ubyte ptr, byval stride2 as const uinteger, byval n2 as const uinteger) as double
declare function gsl_stats_uchar_max(byval data as const ubyte ptr, byval stride as const uinteger, byval n as const uinteger) as ubyte
declare function gsl_stats_uchar_min(byval data as const ubyte ptr, byval stride as const uinteger, byval n as const uinteger) as ubyte
declare sub gsl_stats_uchar_minmax(byval min as ubyte ptr, byval max as ubyte ptr, byval data as const ubyte ptr, byval stride as const uinteger, byval n as const uinteger)
declare function gsl_stats_uchar_max_index(byval data as const ubyte ptr, byval stride as const uinteger, byval n as const uinteger) as uinteger
declare function gsl_stats_uchar_min_index(byval data as const ubyte ptr, byval stride as const uinteger, byval n as const uinteger) as uinteger
declare sub gsl_stats_uchar_minmax_index(byval min_index as uinteger ptr, byval max_index as uinteger ptr, byval data as const ubyte ptr, byval stride as const uinteger, byval n as const uinteger)
declare function gsl_stats_uchar_median_from_sorted_data(byval sorted_data as const ubyte ptr, byval stride as const uinteger, byval n as const uinteger) as double
declare function gsl_stats_uchar_quantile_from_sorted_data(byval sorted_data as const ubyte ptr, byval stride as const uinteger, byval n as const uinteger, byval f as const double) as double

end extern
