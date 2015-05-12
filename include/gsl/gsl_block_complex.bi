''
''
'' gsl_block_complex -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gsl_block_complex_bi__
#define __gsl_block_complex_bi__

#define  GSL_BLOCK_REAL(z, i)  (z->data[2*(i)])
#define  GSL_BLOCK_IMAG(z, i)  (z->data[2*(i) + 1])

#define GSL_BLOCK_COMPLEX_(zv, i) (GSL_COMPLEX_AT((zv),(i)))

#ifndef GSL_COMPLEX_AT
#define GSL_COMPLEX_AT(zv,i) (zv->data[2*(i)])
#define GSL_COMPLEX_FLOAT_AT(zv,i) (zv->data[2*(i)])
#define GSL_COMPLEX_LONG_DOUBLE_AT(zv,i) (zv->data[2*(i)])
#endif

#endif
