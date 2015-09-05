'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   cdf/gsl_cdf.h
''
''   Copyright (C) 2002 Jason H. Stover.
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
''   along with this program; if not, write to the Free Software Foundation,
''   Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

extern "C"

#define __GSL_CDF_H__
declare function gsl_cdf_ugaussian_P(byval x as const double) as double
declare function gsl_cdf_ugaussian_Q(byval x as const double) as double
declare function gsl_cdf_ugaussian_Pinv(byval P as const double) as double
declare function gsl_cdf_ugaussian_Qinv(byval Q as const double) as double
declare function gsl_cdf_gaussian_P(byval x as const double, byval sigma as const double) as double
declare function gsl_cdf_gaussian_Q(byval x as const double, byval sigma as const double) as double
declare function gsl_cdf_gaussian_Pinv(byval P as const double, byval sigma as const double) as double
declare function gsl_cdf_gaussian_Qinv(byval Q as const double, byval sigma as const double) as double
declare function gsl_cdf_gamma_P(byval x as const double, byval a as const double, byval b as const double) as double
declare function gsl_cdf_gamma_Q(byval x as const double, byval a as const double, byval b as const double) as double
declare function gsl_cdf_gamma_Pinv(byval P as const double, byval a as const double, byval b as const double) as double
declare function gsl_cdf_gamma_Qinv(byval Q as const double, byval a as const double, byval b as const double) as double
declare function gsl_cdf_cauchy_P(byval x as const double, byval a as const double) as double
declare function gsl_cdf_cauchy_Q(byval x as const double, byval a as const double) as double
declare function gsl_cdf_cauchy_Pinv(byval P as const double, byval a as const double) as double
declare function gsl_cdf_cauchy_Qinv(byval Q as const double, byval a as const double) as double
declare function gsl_cdf_laplace_P(byval x as const double, byval a as const double) as double
declare function gsl_cdf_laplace_Q(byval x as const double, byval a as const double) as double
declare function gsl_cdf_laplace_Pinv(byval P as const double, byval a as const double) as double
declare function gsl_cdf_laplace_Qinv(byval Q as const double, byval a as const double) as double
declare function gsl_cdf_rayleigh_P(byval x as const double, byval sigma as const double) as double
declare function gsl_cdf_rayleigh_Q(byval x as const double, byval sigma as const double) as double
declare function gsl_cdf_rayleigh_Pinv(byval P as const double, byval sigma as const double) as double
declare function gsl_cdf_rayleigh_Qinv(byval Q as const double, byval sigma as const double) as double
declare function gsl_cdf_chisq_P(byval x as const double, byval nu as const double) as double
declare function gsl_cdf_chisq_Q(byval x as const double, byval nu as const double) as double
declare function gsl_cdf_chisq_Pinv(byval P as const double, byval nu as const double) as double
declare function gsl_cdf_chisq_Qinv(byval Q as const double, byval nu as const double) as double
declare function gsl_cdf_exponential_P(byval x as const double, byval mu as const double) as double
declare function gsl_cdf_exponential_Q(byval x as const double, byval mu as const double) as double
declare function gsl_cdf_exponential_Pinv(byval P as const double, byval mu as const double) as double
declare function gsl_cdf_exponential_Qinv(byval Q as const double, byval mu as const double) as double
declare function gsl_cdf_exppow_P(byval x as const double, byval a as const double, byval b as const double) as double
declare function gsl_cdf_exppow_Q(byval x as const double, byval a as const double, byval b as const double) as double
declare function gsl_cdf_tdist_P(byval x as const double, byval nu as const double) as double
declare function gsl_cdf_tdist_Q(byval x as const double, byval nu as const double) as double
declare function gsl_cdf_tdist_Pinv(byval P as const double, byval nu as const double) as double
declare function gsl_cdf_tdist_Qinv(byval Q as const double, byval nu as const double) as double
declare function gsl_cdf_fdist_P(byval x as const double, byval nu1 as const double, byval nu2 as const double) as double
declare function gsl_cdf_fdist_Q(byval x as const double, byval nu1 as const double, byval nu2 as const double) as double
declare function gsl_cdf_fdist_Pinv(byval P as const double, byval nu1 as const double, byval nu2 as const double) as double
declare function gsl_cdf_fdist_Qinv(byval Q as const double, byval nu1 as const double, byval nu2 as const double) as double
declare function gsl_cdf_beta_P(byval x as const double, byval a as const double, byval b as const double) as double
declare function gsl_cdf_beta_Q(byval x as const double, byval a as const double, byval b as const double) as double
declare function gsl_cdf_beta_Pinv(byval P as const double, byval a as const double, byval b as const double) as double
declare function gsl_cdf_beta_Qinv(byval Q as const double, byval a as const double, byval b as const double) as double
declare function gsl_cdf_flat_P(byval x as const double, byval a as const double, byval b as const double) as double
declare function gsl_cdf_flat_Q(byval x as const double, byval a as const double, byval b as const double) as double
declare function gsl_cdf_flat_Pinv(byval P as const double, byval a as const double, byval b as const double) as double
declare function gsl_cdf_flat_Qinv(byval Q as const double, byval a as const double, byval b as const double) as double
declare function gsl_cdf_lognormal_P(byval x as const double, byval zeta as const double, byval sigma as const double) as double
declare function gsl_cdf_lognormal_Q(byval x as const double, byval zeta as const double, byval sigma as const double) as double
declare function gsl_cdf_lognormal_Pinv(byval P as const double, byval zeta as const double, byval sigma as const double) as double
declare function gsl_cdf_lognormal_Qinv(byval Q as const double, byval zeta as const double, byval sigma as const double) as double
declare function gsl_cdf_gumbel1_P(byval x as const double, byval a as const double, byval b as const double) as double
declare function gsl_cdf_gumbel1_Q(byval x as const double, byval a as const double, byval b as const double) as double
declare function gsl_cdf_gumbel1_Pinv(byval P as const double, byval a as const double, byval b as const double) as double
declare function gsl_cdf_gumbel1_Qinv(byval Q as const double, byval a as const double, byval b as const double) as double
declare function gsl_cdf_gumbel2_P(byval x as const double, byval a as const double, byval b as const double) as double
declare function gsl_cdf_gumbel2_Q(byval x as const double, byval a as const double, byval b as const double) as double
declare function gsl_cdf_gumbel2_Pinv(byval P as const double, byval a as const double, byval b as const double) as double
declare function gsl_cdf_gumbel2_Qinv(byval Q as const double, byval a as const double, byval b as const double) as double
declare function gsl_cdf_weibull_P(byval x as const double, byval a as const double, byval b as const double) as double
declare function gsl_cdf_weibull_Q(byval x as const double, byval a as const double, byval b as const double) as double
declare function gsl_cdf_weibull_Pinv(byval P as const double, byval a as const double, byval b as const double) as double
declare function gsl_cdf_weibull_Qinv(byval Q as const double, byval a as const double, byval b as const double) as double
declare function gsl_cdf_pareto_P(byval x as const double, byval a as const double, byval b as const double) as double
declare function gsl_cdf_pareto_Q(byval x as const double, byval a as const double, byval b as const double) as double
declare function gsl_cdf_pareto_Pinv(byval P as const double, byval a as const double, byval b as const double) as double
declare function gsl_cdf_pareto_Qinv(byval Q as const double, byval a as const double, byval b as const double) as double
declare function gsl_cdf_logistic_P(byval x as const double, byval a as const double) as double
declare function gsl_cdf_logistic_Q(byval x as const double, byval a as const double) as double
declare function gsl_cdf_logistic_Pinv(byval P as const double, byval a as const double) as double
declare function gsl_cdf_logistic_Qinv(byval Q as const double, byval a as const double) as double
declare function gsl_cdf_binomial_P(byval k as const ulong, byval p as const double, byval n as const ulong) as double
declare function gsl_cdf_binomial_Q(byval k as const ulong, byval p as const double, byval n as const ulong) as double
declare function gsl_cdf_poisson_P(byval k as const ulong, byval mu as const double) as double
declare function gsl_cdf_poisson_Q(byval k as const ulong, byval mu as const double) as double
declare function gsl_cdf_geometric_P(byval k as const ulong, byval p as const double) as double
declare function gsl_cdf_geometric_Q(byval k as const ulong, byval p as const double) as double
declare function gsl_cdf_negative_binomial_P(byval k as const ulong, byval p as const double, byval n as const double) as double
declare function gsl_cdf_negative_binomial_Q(byval k as const ulong, byval p as const double, byval n as const double) as double
declare function gsl_cdf_pascal_P(byval k as const ulong, byval p as const double, byval n as const ulong) as double
declare function gsl_cdf_pascal_Q(byval k as const ulong, byval p as const double, byval n as const ulong) as double
declare function gsl_cdf_hypergeometric_P(byval k as const ulong, byval n1 as const ulong, byval n2 as const ulong, byval t as const ulong) as double
declare function gsl_cdf_hypergeometric_Q(byval k as const ulong, byval n1 as const ulong, byval n2 as const ulong, byval t as const ulong) as double

end extern
