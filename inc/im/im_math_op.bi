''
''
'' im_math_op -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __im_math_op_bi__
#define __im_math_op_bi__

declare function sub_op cdecl alias "sub_op" (byval v1 as r.q(const).T1, byval v2 as r.q(const).T2) as T1
declare function mul_op cdecl alias "mul_op" (byval v1 as r.q(const).T1, byval v2 as r.q(const).T2) as T1
declare function div_op cdecl alias "div_op" (byval v1 as r.q(const).T1, byval v2 as r.q(const).T2) as T1
declare function inv_op cdecl alias "inv_op" (byval v as r.q(const).T) as T
declare function diff_op cdecl alias "diff_op" (byval v1 as r.q(const).T1, byval v2 as r.q(const).T2) as T1
declare function min_op cdecl alias "min_op" (byval v1 as r.q(const).T1, byval v2 as r.q(const).T2) as T1
declare function max_op cdecl alias "max_op" (byval v1 as r.q(const).T1, byval v2 as r.q(const).T2) as T1
declare function pow_op cdecl alias "pow_op" (byval v1 as r.q(const).short, byval v2 as r.q(const).short) as short
declare function pow_op cdecl alias "pow_op" (byval v1 as r.q(const).int, byval v2 as r.q(const).int) as integer
declare function pow_op cdecl alias "pow_op" (byval v1 as r.q(const).T1, byval v2 as r.q(const).T2) as T1
declare function abs_op cdecl alias "abs_op" (byval v as r.q(const).T) as T
declare function less_op cdecl alias "less_op" (byval v as r.q(const).T) as T
declare function sqr_op cdecl alias "sqr_op" (byval v as r.q(const).T) as T
declare function sqrt cdecl alias "sqrt" (byval C as r.q(const).int) as integer
declare function sqrt_op cdecl alias "sqrt_op" (byval v as r.q(const).T) as T
declare function exp cdecl alias "exp" (byval v as r.q(const).int) as integer
declare function exp_op cdecl alias "exp_op" (byval v as r.q(const).T) as T
declare function log cdecl alias "log" (byval v as r.q(const).int) as integer
declare function log_op cdecl alias "log_op" (byval v as r.q(const).T) as T
declare function sin cdecl alias "sin" (byval v as r.q(const).int) as integer
declare function sin_op cdecl alias "sin_op" (byval v as r.q(const).T) as T
declare function cos cdecl alias "cos" (byval v as r.q(const).int) as integer
declare function cos_op cdecl alias "cos_op" (byval v as r.q(const).T) as T
declare sub imDataBitSet cdecl alias "imDataBitSet" (byval data as imbyte ptr, byval index as integer, byval bit as integer)
declare function imDataBitGet cdecl alias "imDataBitGet" (byval data as imbyte ptr, byval index as integer) as integer

#endif
