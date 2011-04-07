''
''
'' gsl_cdf -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_cdf_bi__
#define __gsl_cdf_bi__

#include once "gsl_types.bi"

extern "c"
declare function gsl_cdf_ugaussian_P (byval x as double) as double
declare function gsl_cdf_ugaussian_Q (byval x as double) as double
declare function gsl_cdf_ugaussian_Pinv (byval P as double) as double
declare function gsl_cdf_ugaussian_Qinv (byval Q as double) as double
declare function gsl_cdf_gaussian_P (byval x as double, byval sigma as double) as double
declare function gsl_cdf_gaussian_Q (byval x as double, byval sigma as double) as double
declare function gsl_cdf_gaussian_Pinv (byval P as double, byval sigma as double) as double
declare function gsl_cdf_gaussian_Qinv (byval Q as double, byval sigma as double) as double
declare function gsl_cdf_gamma_P (byval x as double, byval a as double, byval b as double) as double
declare function gsl_cdf_gamma_Q (byval x as double, byval a as double, byval b as double) as double
declare function gsl_cdf_gamma_Pinv (byval P as double, byval a as double, byval b as double) as double
declare function gsl_cdf_gamma_Qinv (byval Q as double, byval a as double, byval b as double) as double
declare function gsl_cdf_cauchy_P (byval x as double, byval a as double) as double
declare function gsl_cdf_cauchy_Q (byval x as double, byval a as double) as double
declare function gsl_cdf_cauchy_Pinv (byval P as double, byval a as double) as double
declare function gsl_cdf_cauchy_Qinv (byval Q as double, byval a as double) as double
declare function gsl_cdf_laplace_P (byval x as double, byval a as double) as double
declare function gsl_cdf_laplace_Q (byval x as double, byval a as double) as double
declare function gsl_cdf_laplace_Pinv (byval P as double, byval a as double) as double
declare function gsl_cdf_laplace_Qinv (byval Q as double, byval a as double) as double
declare function gsl_cdf_rayleigh_P (byval x as double, byval sigma as double) as double
declare function gsl_cdf_rayleigh_Q (byval x as double, byval sigma as double) as double
declare function gsl_cdf_rayleigh_Pinv (byval P as double, byval sigma as double) as double
declare function gsl_cdf_rayleigh_Qinv (byval Q as double, byval sigma as double) as double
declare function gsl_cdf_chisq_P (byval x as double, byval nu as double) as double
declare function gsl_cdf_chisq_Q (byval x as double, byval nu as double) as double
declare function gsl_cdf_chisq_Pinv (byval P as double, byval nu as double) as double
declare function gsl_cdf_chisq_Qinv (byval Q as double, byval nu as double) as double
declare function gsl_cdf_exponential_P (byval x as double, byval mu as double) as double
declare function gsl_cdf_exponential_Q (byval x as double, byval mu as double) as double
declare function gsl_cdf_exponential_Pinv (byval P as double, byval mu as double) as double
declare function gsl_cdf_exponential_Qinv (byval Q as double, byval mu as double) as double
declare function gsl_cdf_exppow_P (byval x as double, byval a as double, byval b as double) as double
declare function gsl_cdf_exppow_Q (byval x as double, byval a as double, byval b as double) as double
declare function gsl_cdf_tdist_P (byval x as double, byval nu as double) as double
declare function gsl_cdf_tdist_Q (byval x as double, byval nu as double) as double
declare function gsl_cdf_tdist_Pinv (byval P as double, byval nu as double) as double
declare function gsl_cdf_tdist_Qinv (byval Q as double, byval nu as double) as double
declare function gsl_cdf_fdist_P (byval x as double, byval nu1 as double, byval nu2 as double) as double
declare function gsl_cdf_fdist_Q (byval x as double, byval nu1 as double, byval nu2 as double) as double
declare function gsl_cdf_beta_P (byval x as double, byval a as double, byval b as double) as double
declare function gsl_cdf_beta_Q (byval x as double, byval a as double, byval b as double) as double
declare function gsl_cdf_flat_P (byval x as double, byval a as double, byval b as double) as double
declare function gsl_cdf_flat_Q (byval x as double, byval a as double, byval b as double) as double
declare function gsl_cdf_flat_Pinv (byval P as double, byval a as double, byval b as double) as double
declare function gsl_cdf_flat_Qinv (byval Q as double, byval a as double, byval b as double) as double
declare function gsl_cdf_lognormal_P (byval x as double, byval zeta as double, byval sigma as double) as double
declare function gsl_cdf_lognormal_Q (byval x as double, byval zeta as double, byval sigma as double) as double
declare function gsl_cdf_lognormal_Pinv (byval P as double, byval zeta as double, byval sigma as double) as double
declare function gsl_cdf_lognormal_Qinv (byval Q as double, byval zeta as double, byval sigma as double) as double
declare function gsl_cdf_gumbel1_P (byval x as double, byval a as double, byval b as double) as double
declare function gsl_cdf_gumbel1_Q (byval x as double, byval a as double, byval b as double) as double
declare function gsl_cdf_gumbel1_Pinv (byval P as double, byval a as double, byval b as double) as double
declare function gsl_cdf_gumbel1_Qinv (byval Q as double, byval a as double, byval b as double) as double
declare function gsl_cdf_gumbel2_P (byval x as double, byval a as double, byval b as double) as double
declare function gsl_cdf_gumbel2_Q (byval x as double, byval a as double, byval b as double) as double
declare function gsl_cdf_gumbel2_Pinv (byval P as double, byval a as double, byval b as double) as double
declare function gsl_cdf_gumbel2_Qinv (byval Q as double, byval a as double, byval b as double) as double
declare function gsl_cdf_weibull_P (byval x as double, byval a as double, byval b as double) as double
declare function gsl_cdf_weibull_Q (byval x as double, byval a as double, byval b as double) as double
declare function gsl_cdf_weibull_Pinv (byval P as double, byval a as double, byval b as double) as double
declare function gsl_cdf_weibull_Qinv (byval Q as double, byval a as double, byval b as double) as double
declare function gsl_cdf_pareto_P (byval x as double, byval a as double, byval b as double) as double
declare function gsl_cdf_pareto_Q (byval x as double, byval a as double, byval b as double) as double
declare function gsl_cdf_pareto_Pinv (byval P as double, byval a as double, byval b as double) as double
declare function gsl_cdf_pareto_Qinv (byval Q as double, byval a as double, byval b as double) as double
declare function gsl_cdf_logistic_P (byval x as double, byval a as double) as double
declare function gsl_cdf_logistic_Q (byval x as double, byval a as double) as double
declare function gsl_cdf_logistic_Pinv (byval P as double, byval a as double) as double
declare function gsl_cdf_logistic_Qinv (byval Q as double, byval a as double) as double
end extern

#endif
