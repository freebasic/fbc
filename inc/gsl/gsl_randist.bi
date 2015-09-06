'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   randist/gsl_randist.h
''
''   Copyright (C) 1996, 1997, 1998, 1999, 2000, 2007 James Theiler, Brian Gough
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

#include once "gsl/gsl_rng.bi"

extern "C"

#define __GSL_RANDIST_H__
declare function gsl_ran_bernoulli(byval r as const gsl_rng ptr, byval p as double) as ulong
declare function gsl_ran_bernoulli_pdf(byval k as const ulong, byval p as double) as double
declare function gsl_ran_beta(byval r as const gsl_rng ptr, byval a as const double, byval b as const double) as double
declare function gsl_ran_beta_pdf(byval x as const double, byval a as const double, byval b as const double) as double
declare function gsl_ran_binomial(byval r as const gsl_rng ptr, byval p as double, byval n as ulong) as ulong
declare function gsl_ran_binomial_knuth(byval r as const gsl_rng ptr, byval p as double, byval n as ulong) as ulong
declare function gsl_ran_binomial_tpe(byval r as const gsl_rng ptr, byval p as double, byval n as ulong) as ulong
declare function gsl_ran_binomial_pdf(byval k as const ulong, byval p as const double, byval n as const ulong) as double
declare function gsl_ran_exponential(byval r as const gsl_rng ptr, byval mu as const double) as double
declare function gsl_ran_exponential_pdf(byval x as const double, byval mu as const double) as double
declare function gsl_ran_exppow(byval r as const gsl_rng ptr, byval a as const double, byval b as const double) as double
declare function gsl_ran_exppow_pdf(byval x as const double, byval a as const double, byval b as const double) as double
declare function gsl_ran_cauchy(byval r as const gsl_rng ptr, byval a as const double) as double
declare function gsl_ran_cauchy_pdf(byval x as const double, byval a as const double) as double
declare function gsl_ran_chisq(byval r as const gsl_rng ptr, byval nu as const double) as double
declare function gsl_ran_chisq_pdf(byval x as const double, byval nu as const double) as double
declare sub gsl_ran_dirichlet(byval r as const gsl_rng ptr, byval K as const uinteger, byval alpha as const double ptr, byval theta as double ptr)
declare function gsl_ran_dirichlet_pdf(byval K as const uinteger, byval alpha as const double ptr, byval theta as const double ptr) as double
declare function gsl_ran_dirichlet_lnpdf(byval K as const uinteger, byval alpha as const double ptr, byval theta as const double ptr) as double
declare function gsl_ran_erlang(byval r as const gsl_rng ptr, byval a as const double, byval n as const double) as double
declare function gsl_ran_erlang_pdf(byval x as const double, byval a as const double, byval n as const double) as double
declare function gsl_ran_fdist(byval r as const gsl_rng ptr, byval nu1 as const double, byval nu2 as const double) as double
declare function gsl_ran_fdist_pdf(byval x as const double, byval nu1 as const double, byval nu2 as const double) as double
declare function gsl_ran_flat(byval r as const gsl_rng ptr, byval a as const double, byval b as const double) as double
declare function gsl_ran_flat_pdf(byval x as double, byval a as const double, byval b as const double) as double
declare function gsl_ran_gamma(byval r as const gsl_rng ptr, byval a as const double, byval b as const double) as double
declare function gsl_ran_gamma_int(byval r as const gsl_rng ptr, byval a as const ulong) as double
declare function gsl_ran_gamma_pdf(byval x as const double, byval a as const double, byval b as const double) as double
declare function gsl_ran_gamma_mt(byval r as const gsl_rng ptr, byval a as const double, byval b as const double) as double
declare function gsl_ran_gamma_knuth(byval r as const gsl_rng ptr, byval a as const double, byval b as const double) as double
declare function gsl_ran_gaussian(byval r as const gsl_rng ptr, byval sigma as const double) as double
declare function gsl_ran_gaussian_ratio_method(byval r as const gsl_rng ptr, byval sigma as const double) as double
declare function gsl_ran_gaussian_ziggurat(byval r as const gsl_rng ptr, byval sigma as const double) as double
declare function gsl_ran_gaussian_pdf(byval x as const double, byval sigma as const double) as double
declare function gsl_ran_ugaussian(byval r as const gsl_rng ptr) as double
declare function gsl_ran_ugaussian_ratio_method(byval r as const gsl_rng ptr) as double
declare function gsl_ran_ugaussian_pdf(byval x as const double) as double
declare function gsl_ran_gaussian_tail(byval r as const gsl_rng ptr, byval a as const double, byval sigma as const double) as double
declare function gsl_ran_gaussian_tail_pdf(byval x as const double, byval a as const double, byval sigma as const double) as double
declare function gsl_ran_ugaussian_tail(byval r as const gsl_rng ptr, byval a as const double) as double
declare function gsl_ran_ugaussian_tail_pdf(byval x as const double, byval a as const double) as double
declare sub gsl_ran_bivariate_gaussian(byval r as const gsl_rng ptr, byval sigma_x as double, byval sigma_y as double, byval rho as double, byval x as double ptr, byval y as double ptr)
declare function gsl_ran_bivariate_gaussian_pdf(byval x as const double, byval y as const double, byval sigma_x as const double, byval sigma_y as const double, byval rho as const double) as double
declare function gsl_ran_landau(byval r as const gsl_rng ptr) as double
declare function gsl_ran_landau_pdf(byval x as const double) as double
declare function gsl_ran_geometric(byval r as const gsl_rng ptr, byval p as const double) as ulong
declare function gsl_ran_geometric_pdf(byval k as const ulong, byval p as const double) as double
declare function gsl_ran_hypergeometric(byval r as const gsl_rng ptr, byval n1 as ulong, byval n2 as ulong, byval t as ulong) as ulong
declare function gsl_ran_hypergeometric_pdf(byval k as const ulong, byval n1 as const ulong, byval n2 as const ulong, byval t as ulong) as double
declare function gsl_ran_gumbel1(byval r as const gsl_rng ptr, byval a as const double, byval b as const double) as double
declare function gsl_ran_gumbel1_pdf(byval x as const double, byval a as const double, byval b as const double) as double
declare function gsl_ran_gumbel2(byval r as const gsl_rng ptr, byval a as const double, byval b as const double) as double
declare function gsl_ran_gumbel2_pdf(byval x as const double, byval a as const double, byval b as const double) as double
declare function gsl_ran_logistic(byval r as const gsl_rng ptr, byval a as const double) as double
declare function gsl_ran_logistic_pdf(byval x as const double, byval a as const double) as double
declare function gsl_ran_lognormal(byval r as const gsl_rng ptr, byval zeta as const double, byval sigma as const double) as double
declare function gsl_ran_lognormal_pdf(byval x as const double, byval zeta as const double, byval sigma as const double) as double
declare function gsl_ran_logarithmic(byval r as const gsl_rng ptr, byval p as const double) as ulong
declare function gsl_ran_logarithmic_pdf(byval k as const ulong, byval p as const double) as double
declare sub gsl_ran_multinomial(byval r as const gsl_rng ptr, byval K as const uinteger, byval N as const ulong, byval p as const double ptr, byval n as ulong ptr)
declare function gsl_ran_multinomial_pdf(byval K as const uinteger, byval p as const double ptr, byval n as const ulong ptr) as double
declare function gsl_ran_multinomial_lnpdf(byval K as const uinteger, byval p as const double ptr, byval n as const ulong ptr) as double
declare function gsl_ran_negative_binomial(byval r as const gsl_rng ptr, byval p as double, byval n as double) as ulong
declare function gsl_ran_negative_binomial_pdf(byval k as const ulong, byval p as const double, byval n as double) as double
declare function gsl_ran_pascal(byval r as const gsl_rng ptr, byval p as double, byval n as ulong) as ulong
declare function gsl_ran_pascal_pdf(byval k as const ulong, byval p as const double, byval n as ulong) as double
declare function gsl_ran_pareto(byval r as const gsl_rng ptr, byval a as double, byval b as const double) as double
declare function gsl_ran_pareto_pdf(byval x as const double, byval a as const double, byval b as const double) as double
declare function gsl_ran_poisson(byval r as const gsl_rng ptr, byval mu as double) as ulong
declare sub gsl_ran_poisson_array(byval r as const gsl_rng ptr, byval n as uinteger, byval array as ulong ptr, byval mu as double)
declare function gsl_ran_poisson_pdf(byval k as const ulong, byval mu as const double) as double
declare function gsl_ran_rayleigh(byval r as const gsl_rng ptr, byval sigma as const double) as double
declare function gsl_ran_rayleigh_pdf(byval x as const double, byval sigma as const double) as double
declare function gsl_ran_rayleigh_tail(byval r as const gsl_rng ptr, byval a as const double, byval sigma as const double) as double
declare function gsl_ran_rayleigh_tail_pdf(byval x as const double, byval a as const double, byval sigma as const double) as double
declare function gsl_ran_tdist(byval r as const gsl_rng ptr, byval nu as const double) as double
declare function gsl_ran_tdist_pdf(byval x as const double, byval nu as const double) as double
declare function gsl_ran_laplace(byval r as const gsl_rng ptr, byval a as const double) as double
declare function gsl_ran_laplace_pdf(byval x as const double, byval a as const double) as double
declare function gsl_ran_levy(byval r as const gsl_rng ptr, byval c as const double, byval alpha as const double) as double
declare function gsl_ran_levy_skew(byval r as const gsl_rng ptr, byval c as const double, byval alpha as const double, byval beta as const double) as double
declare function gsl_ran_weibull(byval r as const gsl_rng ptr, byval a as const double, byval b as const double) as double
declare function gsl_ran_weibull_pdf(byval x as const double, byval a as const double, byval b as const double) as double
declare sub gsl_ran_dir_2d(byval r as const gsl_rng ptr, byval x as double ptr, byval y as double ptr)
declare sub gsl_ran_dir_2d_trig_method(byval r as const gsl_rng ptr, byval x as double ptr, byval y as double ptr)
declare sub gsl_ran_dir_3d(byval r as const gsl_rng ptr, byval x as double ptr, byval y as double ptr, byval z as double ptr)
declare sub gsl_ran_dir_nd(byval r as const gsl_rng ptr, byval n as uinteger, byval x as double ptr)
declare sub gsl_ran_shuffle(byval r as const gsl_rng ptr, byval base as any ptr, byval nmembm as uinteger, byval size as uinteger)
declare function gsl_ran_choose(byval r as const gsl_rng ptr, byval dest as any ptr, byval k as uinteger, byval src as any ptr, byval n as uinteger, byval size as uinteger) as long
declare sub gsl_ran_sample(byval r as const gsl_rng ptr, byval dest as any ptr, byval k as uinteger, byval src as any ptr, byval n as uinteger, byval size as uinteger)

type gsl_ran_discrete_t
	K as uinteger
	A as uinteger ptr
	F as double ptr
end type

declare function gsl_ran_discrete_preproc(byval K as uinteger, byval P as const double ptr) as gsl_ran_discrete_t ptr
declare sub gsl_ran_discrete_free(byval g as gsl_ran_discrete_t ptr)
declare function gsl_ran_discrete(byval r as const gsl_rng ptr, byval g as const gsl_ran_discrete_t ptr) as uinteger
declare function gsl_ran_discrete_pdf(byval k as uinteger, byval g as const gsl_ran_discrete_t ptr) as double

end extern
