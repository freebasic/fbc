''
''
'' gsl_randist -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_randist_bi__
#define __gsl_randist_bi__

#include once "gsl_rng.bi"
#include once "gsl_types.bi"

type gsl_ran_discrete_t
	K as integer
	A as integer ptr
	F as double ptr
end type

extern "c"
declare function gsl_ran_bernoulli (byval r as gsl_rng ptr, byval p as double) as uinteger
declare function gsl_ran_bernoulli_pdf (byval k as uinteger, byval p as double) as double
declare function gsl_ran_beta (byval r as gsl_rng ptr, byval a as double, byval b as double) as double
declare function gsl_ran_beta_pdf (byval x as double, byval a as double, byval b as double) as double
declare function gsl_ran_binomial (byval r as gsl_rng ptr, byval p as double, byval n as uinteger) as uinteger
declare function gsl_ran_binomial_tpe (byval r as gsl_rng ptr, byval pp as double, byval n as uinteger) as uinteger
declare function gsl_ran_binomial_pdf (byval k as uinteger, byval p as double, byval n as uinteger) as double
declare function gsl_ran_exponential (byval r as gsl_rng ptr, byval mu as double) as double
declare function gsl_ran_exponential_pdf (byval x as double, byval mu as double) as double
declare function gsl_ran_exppow (byval r as gsl_rng ptr, byval a as double, byval b as double) as double
declare function gsl_ran_exppow_pdf (byval x as double, byval a as double, byval b as double) as double
declare function gsl_ran_cauchy (byval r as gsl_rng ptr, byval a as double) as double
declare function gsl_ran_cauchy_pdf (byval x as double, byval a as double) as double
declare function gsl_ran_chisq (byval r as gsl_rng ptr, byval nu as double) as double
declare function gsl_ran_chisq_pdf (byval x as double, byval nu as double) as double
declare sub gsl_ran_dirichlet (byval r as gsl_rng ptr, byval K as integer, byval alpha as double ptr, byval theta as double ptr)
declare function gsl_ran_dirichlet_pdf (byval K as integer, byval alpha as double ptr, byval theta as double ptr) as double
declare function gsl_ran_dirichlet_lnpdf (byval K as integer, byval alpha as double ptr, byval theta as double ptr) as double
declare function gsl_ran_erlang (byval r as gsl_rng ptr, byval a as double, byval n as double) as double
declare function gsl_ran_erlang_pdf (byval x as double, byval a as double, byval n as double) as double
declare function gsl_ran_fdist (byval r as gsl_rng ptr, byval nu1 as double, byval nu2 as double) as double
declare function gsl_ran_fdist_pdf (byval x as double, byval nu1 as double, byval nu2 as double) as double
declare function gsl_ran_flat (byval r as gsl_rng ptr, byval a as double, byval b as double) as double
declare function gsl_ran_flat_pdf (byval x as double, byval a as double, byval b as double) as double
declare function gsl_ran_gamma (byval r as gsl_rng ptr, byval a as double, byval b as double) as double
declare function gsl_ran_gamma_int (byval r as gsl_rng ptr, byval a as uinteger) as double
declare function gsl_ran_gamma_pdf (byval x as double, byval a as double, byval b as double) as double
declare function gsl_ran_gaussian (byval r as gsl_rng ptr, byval sigma as double) as double
declare function gsl_ran_gaussian_ratio_method (byval r as gsl_rng ptr, byval sigma as double) as double
declare function gsl_ran_gaussian_pdf (byval x as double, byval sigma as double) as double
declare function gsl_ran_ugaussian (byval r as gsl_rng ptr) as double
declare function gsl_ran_ugaussian_ratio_method (byval r as gsl_rng ptr) as double
declare function gsl_ran_ugaussian_pdf (byval x as double) as double
declare function gsl_ran_gaussian_tail (byval r as gsl_rng ptr, byval a as double, byval sigma as double) as double
declare function gsl_ran_gaussian_tail_pdf (byval x as double, byval a as double, byval sigma as double) as double
declare function gsl_ran_ugaussian_tail (byval r as gsl_rng ptr, byval a as double) as double
declare function gsl_ran_ugaussian_tail_pdf (byval x as double, byval a as double) as double
declare sub gsl_ran_bivariate_gaussian (byval r as gsl_rng ptr, byval sigma_x as double, byval sigma_y as double, byval rho as double, byval x as double ptr, byval y as double ptr)
declare function gsl_ran_bivariate_gaussian_pdf (byval x as double, byval y as double, byval sigma_x as double, byval sigma_y as double, byval rho as double) as double
declare function gsl_ran_landau (byval r as gsl_rng ptr) as double
declare function gsl_ran_landau_pdf (byval x as double) as double
declare function gsl_ran_geometric (byval r as gsl_rng ptr, byval p as double) as uinteger
declare function gsl_ran_geometric_pdf (byval k as uinteger, byval p as double) as double
declare function gsl_ran_hypergeometric (byval r as gsl_rng ptr, byval n1 as uinteger, byval n2 as uinteger, byval t as uinteger) as uinteger
declare function gsl_ran_hypergeometric_pdf (byval k as uinteger, byval n1 as uinteger, byval n2 as uinteger, byval t as uinteger) as double
declare function gsl_ran_gumbel1 (byval r as gsl_rng ptr, byval a as double, byval b as double) as double
declare function gsl_ran_gumbel1_pdf (byval x as double, byval a as double, byval b as double) as double
declare function gsl_ran_gumbel2 (byval r as gsl_rng ptr, byval a as double, byval b as double) as double
declare function gsl_ran_gumbel2_pdf (byval x as double, byval a as double, byval b as double) as double
declare function gsl_ran_logistic (byval r as gsl_rng ptr, byval a as double) as double
declare function gsl_ran_logistic_pdf (byval x as double, byval a as double) as double
declare function gsl_ran_lognormal (byval r as gsl_rng ptr, byval zeta as double, byval sigma as double) as double
declare function gsl_ran_lognormal_pdf (byval x as double, byval zeta as double, byval sigma as double) as double
declare function gsl_ran_logarithmic (byval r as gsl_rng ptr, byval p as double) as uinteger
declare function gsl_ran_logarithmic_pdf (byval k as uinteger, byval p as double) as double
declare sub gsl_ran_multinomial (byval r as gsl_rng ptr, byval K as integer, byval N as uinteger, byval p as double ptr, byval n as uinteger ptr)
declare function gsl_ran_multinomial_pdf (byval K as integer, byval p as double ptr, byval n as uinteger ptr) as double
declare function gsl_ran_multinomial_lnpdf (byval K as integer, byval p as double ptr, byval n as uinteger ptr) as double
declare function gsl_ran_negative_binomial (byval r as gsl_rng ptr, byval p as double, byval n as double) as uinteger
declare function gsl_ran_negative_binomial_pdf (byval k as uinteger, byval p as double, byval n as double) as double
declare function gsl_ran_pascal (byval r as gsl_rng ptr, byval p as double, byval n as uinteger) as uinteger
declare function gsl_ran_pascal_pdf (byval k as uinteger, byval p as double, byval n as uinteger) as double
declare function gsl_ran_pareto (byval r as gsl_rng ptr, byval a as double, byval b as double) as double
declare function gsl_ran_pareto_pdf (byval x as double, byval a as double, byval b as double) as double
declare function gsl_ran_poisson (byval r as gsl_rng ptr, byval mu as double) as uinteger
declare sub gsl_ran_poisson_array (byval r as gsl_rng ptr, byval n as integer, byval array as uinteger ptr, byval mu as double)
declare function gsl_ran_poisson_pdf (byval k as uinteger, byval mu as double) as double
declare function gsl_ran_rayleigh (byval r as gsl_rng ptr, byval sigma as double) as double
declare function gsl_ran_rayleigh_pdf (byval x as double, byval sigma as double) as double
declare function gsl_ran_rayleigh_tail (byval r as gsl_rng ptr, byval a as double, byval sigma as double) as double
declare function gsl_ran_rayleigh_tail_pdf (byval x as double, byval a as double, byval sigma as double) as double
declare function gsl_ran_tdist (byval r as gsl_rng ptr, byval nu as double) as double
declare function gsl_ran_tdist_pdf (byval x as double, byval nu as double) as double
declare function gsl_ran_laplace (byval r as gsl_rng ptr, byval a as double) as double
declare function gsl_ran_laplace_pdf (byval x as double, byval a as double) as double
declare function gsl_ran_levy (byval r as gsl_rng ptr, byval c as double, byval alpha as double) as double
declare function gsl_ran_levy_skew (byval r as gsl_rng ptr, byval c as double, byval alpha as double, byval beta as double) as double
declare function gsl_ran_weibull (byval r as gsl_rng ptr, byval a as double, byval b as double) as double
declare function gsl_ran_weibull_pdf (byval x as double, byval a as double, byval b as double) as double
declare sub gsl_ran_dir_2d (byval r as gsl_rng ptr, byval x as double ptr, byval y as double ptr)
declare sub gsl_ran_dir_2d_trig_method (byval r as gsl_rng ptr, byval x as double ptr, byval y as double ptr)
declare sub gsl_ran_dir_3d (byval r as gsl_rng ptr, byval x as double ptr, byval y as double ptr, byval z as double ptr)
declare sub gsl_ran_dir_nd (byval r as gsl_rng ptr, byval n as integer, byval x as double ptr)
declare sub gsl_ran_shuffle (byval r as gsl_rng ptr, byval base as any ptr, byval nmembm as integer, byval size as integer)
declare function gsl_ran_choose (byval r as gsl_rng ptr, byval dest as any ptr, byval k as integer, byval src as any ptr, byval n as integer, byval size as integer) as integer
declare sub gsl_ran_sample (byval r as gsl_rng ptr, byval dest as any ptr, byval k as integer, byval src as any ptr, byval n as integer, byval size as integer)
declare function gsl_ran_discrete_preproc (byval K as integer, byval P as double ptr) as gsl_ran_discrete_t ptr
declare sub gsl_ran_discrete_free (byval g as gsl_ran_discrete_t ptr)
declare function gsl_ran_discrete (byval r as gsl_rng ptr, byval g as gsl_ran_discrete_t ptr) as integer
declare function gsl_ran_discrete_pdf (byval k as integer, byval g as gsl_ran_discrete_t ptr) as double
end extern

#endif
