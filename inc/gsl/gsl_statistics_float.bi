'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   statistics/gsl_statistics_float.h
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

#define __GSL_STATISTICS_FLOAT_H__
declare function gsl_stats_float_mean(byval data as const single ptr, byval stride as const uinteger, byval n as const uinteger) as double
declare function gsl_stats_float_variance(byval data as const single ptr, byval stride as const uinteger, byval n as const uinteger) as double
declare function gsl_stats_float_sd(byval data as const single ptr, byval stride as const uinteger, byval n as const uinteger) as double
declare function gsl_stats_float_variance_with_fixed_mean(byval data as const single ptr, byval stride as const uinteger, byval n as const uinteger, byval mean as const double) as double
declare function gsl_stats_float_sd_with_fixed_mean(byval data as const single ptr, byval stride as const uinteger, byval n as const uinteger, byval mean as const double) as double
declare function gsl_stats_float_tss(byval data as const single ptr, byval stride as const uinteger, byval n as const uinteger) as double
declare function gsl_stats_float_tss_m(byval data as const single ptr, byval stride as const uinteger, byval n as const uinteger, byval mean as const double) as double
declare function gsl_stats_float_absdev(byval data as const single ptr, byval stride as const uinteger, byval n as const uinteger) as double
declare function gsl_stats_float_skew(byval data as const single ptr, byval stride as const uinteger, byval n as const uinteger) as double
declare function gsl_stats_float_kurtosis(byval data as const single ptr, byval stride as const uinteger, byval n as const uinteger) as double
declare function gsl_stats_float_lag1_autocorrelation(byval data as const single ptr, byval stride as const uinteger, byval n as const uinteger) as double
declare function gsl_stats_float_covariance(byval data1 as const single ptr, byval stride1 as const uinteger, byval data2 as const single ptr, byval stride2 as const uinteger, byval n as const uinteger) as double
declare function gsl_stats_float_correlation(byval data1 as const single ptr, byval stride1 as const uinteger, byval data2 as const single ptr, byval stride2 as const uinteger, byval n as const uinteger) as double
declare function gsl_stats_float_spearman(byval data1 as const single ptr, byval stride1 as const uinteger, byval data2 as const single ptr, byval stride2 as const uinteger, byval n as const uinteger, byval work as double ptr) as double
declare function gsl_stats_float_variance_m(byval data as const single ptr, byval stride as const uinteger, byval n as const uinteger, byval mean as const double) as double
declare function gsl_stats_float_sd_m(byval data as const single ptr, byval stride as const uinteger, byval n as const uinteger, byval mean as const double) as double
declare function gsl_stats_float_absdev_m(byval data as const single ptr, byval stride as const uinteger, byval n as const uinteger, byval mean as const double) as double
declare function gsl_stats_float_skew_m_sd(byval data as const single ptr, byval stride as const uinteger, byval n as const uinteger, byval mean as const double, byval sd as const double) as double
declare function gsl_stats_float_kurtosis_m_sd(byval data as const single ptr, byval stride as const uinteger, byval n as const uinteger, byval mean as const double, byval sd as const double) as double
declare function gsl_stats_float_lag1_autocorrelation_m(byval data as const single ptr, byval stride as const uinteger, byval n as const uinteger, byval mean as const double) as double
declare function gsl_stats_float_covariance_m(byval data1 as const single ptr, byval stride1 as const uinteger, byval data2 as const single ptr, byval stride2 as const uinteger, byval n as const uinteger, byval mean1 as const double, byval mean2 as const double) as double
declare function gsl_stats_float_wmean(byval w as const single ptr, byval wstride as const uinteger, byval data as const single ptr, byval stride as const uinteger, byval n as const uinteger) as double
declare function gsl_stats_float_wvariance(byval w as const single ptr, byval wstride as const uinteger, byval data as const single ptr, byval stride as const uinteger, byval n as const uinteger) as double
declare function gsl_stats_float_wsd(byval w as const single ptr, byval wstride as const uinteger, byval data as const single ptr, byval stride as const uinteger, byval n as const uinteger) as double
declare function gsl_stats_float_wvariance_with_fixed_mean(byval w as const single ptr, byval wstride as const uinteger, byval data as const single ptr, byval stride as const uinteger, byval n as const uinteger, byval mean as const double) as double
declare function gsl_stats_float_wsd_with_fixed_mean(byval w as const single ptr, byval wstride as const uinteger, byval data as const single ptr, byval stride as const uinteger, byval n as const uinteger, byval mean as const double) as double
declare function gsl_stats_float_wtss(byval w as const single ptr, byval wstride as const uinteger, byval data as const single ptr, byval stride as const uinteger, byval n as const uinteger) as double
declare function gsl_stats_float_wtss_m(byval w as const single ptr, byval wstride as const uinteger, byval data as const single ptr, byval stride as const uinteger, byval n as const uinteger, byval wmean as const double) as double
declare function gsl_stats_float_wabsdev(byval w as const single ptr, byval wstride as const uinteger, byval data as const single ptr, byval stride as const uinteger, byval n as const uinteger) as double
declare function gsl_stats_float_wskew(byval w as const single ptr, byval wstride as const uinteger, byval data as const single ptr, byval stride as const uinteger, byval n as const uinteger) as double
declare function gsl_stats_float_wkurtosis(byval w as const single ptr, byval wstride as const uinteger, byval data as const single ptr, byval stride as const uinteger, byval n as const uinteger) as double
declare function gsl_stats_float_wvariance_m(byval w as const single ptr, byval wstride as const uinteger, byval data as const single ptr, byval stride as const uinteger, byval n as const uinteger, byval wmean as const double) as double
declare function gsl_stats_float_wsd_m(byval w as const single ptr, byval wstride as const uinteger, byval data as const single ptr, byval stride as const uinteger, byval n as const uinteger, byval wmean as const double) as double
declare function gsl_stats_float_wabsdev_m(byval w as const single ptr, byval wstride as const uinteger, byval data as const single ptr, byval stride as const uinteger, byval n as const uinteger, byval wmean as const double) as double
declare function gsl_stats_float_wskew_m_sd(byval w as const single ptr, byval wstride as const uinteger, byval data as const single ptr, byval stride as const uinteger, byval n as const uinteger, byval wmean as const double, byval wsd as const double) as double
declare function gsl_stats_float_wkurtosis_m_sd(byval w as const single ptr, byval wstride as const uinteger, byval data as const single ptr, byval stride as const uinteger, byval n as const uinteger, byval wmean as const double, byval wsd as const double) as double
declare function gsl_stats_float_pvariance(byval data1 as const single ptr, byval stride1 as const uinteger, byval n1 as const uinteger, byval data2 as const single ptr, byval stride2 as const uinteger, byval n2 as const uinteger) as double
declare function gsl_stats_float_ttest(byval data1 as const single ptr, byval stride1 as const uinteger, byval n1 as const uinteger, byval data2 as const single ptr, byval stride2 as const uinteger, byval n2 as const uinteger) as double
declare function gsl_stats_float_max(byval data as const single ptr, byval stride as const uinteger, byval n as const uinteger) as single
declare function gsl_stats_float_min(byval data as const single ptr, byval stride as const uinteger, byval n as const uinteger) as single
declare sub gsl_stats_float_minmax(byval min as single ptr, byval max as single ptr, byval data as const single ptr, byval stride as const uinteger, byval n as const uinteger)
declare function gsl_stats_float_max_index(byval data as const single ptr, byval stride as const uinteger, byval n as const uinteger) as uinteger
declare function gsl_stats_float_min_index(byval data as const single ptr, byval stride as const uinteger, byval n as const uinteger) as uinteger
declare sub gsl_stats_float_minmax_index(byval min_index as uinteger ptr, byval max_index as uinteger ptr, byval data as const single ptr, byval stride as const uinteger, byval n as const uinteger)
declare function gsl_stats_float_median_from_sorted_data(byval sorted_data as const single ptr, byval stride as const uinteger, byval n as const uinteger) as double
declare function gsl_stats_float_quantile_from_sorted_data(byval sorted_data as const single ptr, byval stride as const uinteger, byval n as const uinteger, byval f as const double) as double

end extern
