''
''
'' jit-intrinsic -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __jit_intrinsic_bi__
#define __jit_intrinsic_bi__

#include "jit/jit-common.bi"

declare function jit_int_add cdecl alias "jit_int_add" (byval value1 as jit_int, byval value2 as jit_int) as jit_int
declare function jit_int_sub cdecl alias "jit_int_sub" (byval value1 as jit_int, byval value2 as jit_int) as jit_int
declare function jit_int_mul cdecl alias "jit_int_mul" (byval value1 as jit_int, byval value2 as jit_int) as jit_int
declare function jit_int_div cdecl alias "jit_int_div" (byval result as jit_int ptr, byval value1 as jit_int, byval value2 as jit_int) as jit_int
declare function jit_int_rem cdecl alias "jit_int_rem" (byval result as jit_int ptr, byval value1 as jit_int, byval value2 as jit_int) as jit_int
declare function jit_int_add_ovf cdecl alias "jit_int_add_ovf" (byval result as jit_int ptr, byval value1 as jit_int, byval value2 as jit_int) as jit_int
declare function jit_int_sub_ovf cdecl alias "jit_int_sub_ovf" (byval result as jit_int ptr, byval value1 as jit_int, byval value2 as jit_int) as jit_int
declare function jit_int_mul_ovf cdecl alias "jit_int_mul_ovf" (byval result as jit_int ptr, byval value1 as jit_int, byval value2 as jit_int) as jit_int
declare function jit_int_neg cdecl alias "jit_int_neg" (byval value1 as jit_int) as jit_int
declare function jit_int_and cdecl alias "jit_int_and" (byval value1 as jit_int, byval value2 as jit_int) as jit_int
declare function jit_int_or cdecl alias "jit_int_or" (byval value1 as jit_int, byval value2 as jit_int) as jit_int
declare function jit_int_xor cdecl alias "jit_int_xor" (byval value1 as jit_int, byval value2 as jit_int) as jit_int
declare function jit_int_not cdecl alias "jit_int_not" (byval value1 as jit_int) as jit_int
declare function jit_int_shl cdecl alias "jit_int_shl" (byval value1 as jit_int, byval value2 as jit_uint) as jit_int
declare function jit_int_shr cdecl alias "jit_int_shr" (byval value1 as jit_int, byval value2 as jit_uint) as jit_int
declare function jit_int_eq cdecl alias "jit_int_eq" (byval value1 as jit_int, byval value2 as jit_int) as jit_int
declare function jit_int_ne cdecl alias "jit_int_ne" (byval value1 as jit_int, byval value2 as jit_int) as jit_int
declare function jit_int_lt cdecl alias "jit_int_lt" (byval value1 as jit_int, byval value2 as jit_int) as jit_int
declare function jit_int_le cdecl alias "jit_int_le" (byval value1 as jit_int, byval value2 as jit_int) as jit_int
declare function jit_int_gt cdecl alias "jit_int_gt" (byval value1 as jit_int, byval value2 as jit_int) as jit_int
declare function jit_int_ge cdecl alias "jit_int_ge" (byval value1 as jit_int, byval value2 as jit_int) as jit_int
declare function jit_int_cmp cdecl alias "jit_int_cmp" (byval value1 as jit_int, byval value2 as jit_int) as jit_int
declare function jit_int_abs cdecl alias "jit_int_abs" (byval value1 as jit_int) as jit_int
declare function jit_int_min cdecl alias "jit_int_min" (byval value1 as jit_int, byval value2 as jit_int) as jit_int
declare function jit_int_max cdecl alias "jit_int_max" (byval value1 as jit_int, byval value2 as jit_int) as jit_int
declare function jit_int_sign cdecl alias "jit_int_sign" (byval value1 as jit_int) as jit_int
declare function jit_uint_add cdecl alias "jit_uint_add" (byval value1 as jit_uint, byval value2 as jit_uint) as jit_uint
declare function jit_uint_sub cdecl alias "jit_uint_sub" (byval value1 as jit_uint, byval value2 as jit_uint) as jit_uint
declare function jit_uint_mul cdecl alias "jit_uint_mul" (byval value1 as jit_uint, byval value2 as jit_uint) as jit_uint
declare function jit_uint_div cdecl alias "jit_uint_div" (byval result as jit_uint ptr, byval value1 as jit_uint, byval value2 as jit_uint) as jit_int
declare function jit_uint_rem cdecl alias "jit_uint_rem" (byval result as jit_uint ptr, byval value1 as jit_uint, byval value2 as jit_uint) as jit_int
declare function jit_uint_add_ovf cdecl alias "jit_uint_add_ovf" (byval result as jit_uint ptr, byval value1 as jit_uint, byval value2 as jit_uint) as jit_int
declare function jit_uint_sub_ovf cdecl alias "jit_uint_sub_ovf" (byval result as jit_uint ptr, byval value1 as jit_uint, byval value2 as jit_uint) as jit_int
declare function jit_uint_mul_ovf cdecl alias "jit_uint_mul_ovf" (byval result as jit_uint ptr, byval value1 as jit_uint, byval value2 as jit_uint) as jit_int
declare function jit_uint_neg cdecl alias "jit_uint_neg" (byval value1 as jit_uint) as jit_uint
declare function jit_uint_and cdecl alias "jit_uint_and" (byval value1 as jit_uint, byval value2 as jit_uint) as jit_uint
declare function jit_uint_or cdecl alias "jit_uint_or" (byval value1 as jit_uint, byval value2 as jit_uint) as jit_uint
declare function jit_uint_xor cdecl alias "jit_uint_xor" (byval value1 as jit_uint, byval value2 as jit_uint) as jit_uint
declare function jit_uint_not cdecl alias "jit_uint_not" (byval value1 as jit_uint) as jit_uint
declare function jit_uint_shl cdecl alias "jit_uint_shl" (byval value1 as jit_uint, byval value2 as jit_uint) as jit_uint
declare function jit_uint_shr cdecl alias "jit_uint_shr" (byval value1 as jit_uint, byval value2 as jit_uint) as jit_uint
declare function jit_uint_eq cdecl alias "jit_uint_eq" (byval value1 as jit_uint, byval value2 as jit_uint) as jit_int
declare function jit_uint_ne cdecl alias "jit_uint_ne" (byval value1 as jit_uint, byval value2 as jit_uint) as jit_int
declare function jit_uint_lt cdecl alias "jit_uint_lt" (byval value1 as jit_uint, byval value2 as jit_uint) as jit_int
declare function jit_uint_le cdecl alias "jit_uint_le" (byval value1 as jit_uint, byval value2 as jit_uint) as jit_int
declare function jit_uint_gt cdecl alias "jit_uint_gt" (byval value1 as jit_uint, byval value2 as jit_uint) as jit_int
declare function jit_uint_ge cdecl alias "jit_uint_ge" (byval value1 as jit_uint, byval value2 as jit_uint) as jit_int
declare function jit_uint_cmp cdecl alias "jit_uint_cmp" (byval value1 as jit_uint, byval value2 as jit_uint) as jit_int
declare function jit_uint_min cdecl alias "jit_uint_min" (byval value1 as jit_uint, byval value2 as jit_uint) as jit_uint
declare function jit_uint_max cdecl alias "jit_uint_max" (byval value1 as jit_uint, byval value2 as jit_uint) as jit_uint
declare function jit_long_add cdecl alias "jit_long_add" (byval value1 as jit_long, byval value2 as jit_long) as jit_long
declare function jit_long_sub cdecl alias "jit_long_sub" (byval value1 as jit_long, byval value2 as jit_long) as jit_long
declare function jit_long_mul cdecl alias "jit_long_mul" (byval value1 as jit_long, byval value2 as jit_long) as jit_long
declare function jit_long_div cdecl alias "jit_long_div" (byval result as jit_long ptr, byval value1 as jit_long, byval value2 as jit_long) as jit_int
declare function jit_long_rem cdecl alias "jit_long_rem" (byval result as jit_long ptr, byval value1 as jit_long, byval value2 as jit_long) as jit_int
declare function jit_long_add_ovf cdecl alias "jit_long_add_ovf" (byval result as jit_long ptr, byval value1 as jit_long, byval value2 as jit_long) as jit_int
declare function jit_long_sub_ovf cdecl alias "jit_long_sub_ovf" (byval result as jit_long ptr, byval value1 as jit_long, byval value2 as jit_long) as jit_int
declare function jit_long_mul_ovf cdecl alias "jit_long_mul_ovf" (byval result as jit_long ptr, byval value1 as jit_long, byval value2 as jit_long) as jit_int
declare function jit_long_neg cdecl alias "jit_long_neg" (byval value1 as jit_long) as jit_long
declare function jit_long_and cdecl alias "jit_long_and" (byval value1 as jit_long, byval value2 as jit_long) as jit_long
declare function jit_long_or cdecl alias "jit_long_or" (byval value1 as jit_long, byval value2 as jit_long) as jit_long
declare function jit_long_xor cdecl alias "jit_long_xor" (byval value1 as jit_long, byval value2 as jit_long) as jit_long
declare function jit_long_not cdecl alias "jit_long_not" (byval value1 as jit_long) as jit_long
declare function jit_long_shl cdecl alias "jit_long_shl" (byval value1 as jit_long, byval value2 as jit_uint) as jit_long
declare function jit_long_shr cdecl alias "jit_long_shr" (byval value1 as jit_long, byval value2 as jit_uint) as jit_long
declare function jit_long_eq cdecl alias "jit_long_eq" (byval value1 as jit_long, byval value2 as jit_long) as jit_int
declare function jit_long_ne cdecl alias "jit_long_ne" (byval value1 as jit_long, byval value2 as jit_long) as jit_int
declare function jit_long_lt cdecl alias "jit_long_lt" (byval value1 as jit_long, byval value2 as jit_long) as jit_int
declare function jit_long_le cdecl alias "jit_long_le" (byval value1 as jit_long, byval value2 as jit_long) as jit_int
declare function jit_long_gt cdecl alias "jit_long_gt" (byval value1 as jit_long, byval value2 as jit_long) as jit_int
declare function jit_long_ge cdecl alias "jit_long_ge" (byval value1 as jit_long, byval value2 as jit_long) as jit_int
declare function jit_long_cmp cdecl alias "jit_long_cmp" (byval value1 as jit_long, byval value2 as jit_long) as jit_int
declare function jit_long_abs cdecl alias "jit_long_abs" (byval value1 as jit_long) as jit_long
declare function jit_long_min cdecl alias "jit_long_min" (byval value1 as jit_long, byval value2 as jit_long) as jit_long
declare function jit_long_max cdecl alias "jit_long_max" (byval value1 as jit_long, byval value2 as jit_long) as jit_long
declare function jit_long_sign cdecl alias "jit_long_sign" (byval value1 as jit_long) as jit_int
declare function jit_ulong_add cdecl alias "jit_ulong_add" (byval value1 as jit_ulong, byval value2 as jit_ulong) as jit_ulong
declare function jit_ulong_sub cdecl alias "jit_ulong_sub" (byval value1 as jit_ulong, byval value2 as jit_ulong) as jit_ulong
declare function jit_ulong_mul cdecl alias "jit_ulong_mul" (byval value1 as jit_ulong, byval value2 as jit_ulong) as jit_ulong
declare function jit_ulong_div cdecl alias "jit_ulong_div" (byval result as jit_ulong ptr, byval value1 as jit_ulong, byval value2 as jit_ulong) as jit_int
declare function jit_ulong_rem cdecl alias "jit_ulong_rem" (byval result as jit_ulong ptr, byval value1 as jit_ulong, byval value2 as jit_ulong) as jit_int
declare function jit_ulong_add_ovf cdecl alias "jit_ulong_add_ovf" (byval result as jit_ulong ptr, byval value1 as jit_ulong, byval value2 as jit_ulong) as jit_int
declare function jit_ulong_sub_ovf cdecl alias "jit_ulong_sub_ovf" (byval result as jit_ulong ptr, byval value1 as jit_ulong, byval value2 as jit_ulong) as jit_int
declare function jit_ulong_mul_ovf cdecl alias "jit_ulong_mul_ovf" (byval result as jit_ulong ptr, byval value1 as jit_ulong, byval value2 as jit_ulong) as jit_int
declare function jit_ulong_neg cdecl alias "jit_ulong_neg" (byval value1 as jit_ulong) as jit_ulong
declare function jit_ulong_and cdecl alias "jit_ulong_and" (byval value1 as jit_ulong, byval value2 as jit_ulong) as jit_ulong
declare function jit_ulong_or cdecl alias "jit_ulong_or" (byval value1 as jit_ulong, byval value2 as jit_ulong) as jit_ulong
declare function jit_ulong_xor cdecl alias "jit_ulong_xor" (byval value1 as jit_ulong, byval value2 as jit_ulong) as jit_ulong
declare function jit_ulong_not cdecl alias "jit_ulong_not" (byval value1 as jit_ulong) as jit_ulong
declare function jit_ulong_shl cdecl alias "jit_ulong_shl" (byval value1 as jit_ulong, byval value2 as jit_uint) as jit_ulong
declare function jit_ulong_shr cdecl alias "jit_ulong_shr" (byval value1 as jit_ulong, byval value2 as jit_uint) as jit_ulong
declare function jit_ulong_eq cdecl alias "jit_ulong_eq" (byval value1 as jit_ulong, byval value2 as jit_ulong) as jit_int
declare function jit_ulong_ne cdecl alias "jit_ulong_ne" (byval value1 as jit_ulong, byval value2 as jit_ulong) as jit_int
declare function jit_ulong_lt cdecl alias "jit_ulong_lt" (byval value1 as jit_ulong, byval value2 as jit_ulong) as jit_int
declare function jit_ulong_le cdecl alias "jit_ulong_le" (byval value1 as jit_ulong, byval value2 as jit_ulong) as jit_int
declare function jit_ulong_gt cdecl alias "jit_ulong_gt" (byval value1 as jit_ulong, byval value2 as jit_ulong) as jit_int
declare function jit_ulong_ge cdecl alias "jit_ulong_ge" (byval value1 as jit_ulong, byval value2 as jit_ulong) as jit_int
declare function jit_ulong_cmp cdecl alias "jit_ulong_cmp" (byval value1 as jit_ulong, byval value2 as jit_ulong) as jit_int
declare function jit_ulong_min cdecl alias "jit_ulong_min" (byval value1 as jit_ulong, byval value2 as jit_ulong) as jit_ulong
declare function jit_ulong_max cdecl alias "jit_ulong_max" (byval value1 as jit_ulong, byval value2 as jit_ulong) as jit_ulong
declare function jit_float32_add cdecl alias "jit_float32_add" (byval value1 as jit_float32, byval value2 as jit_float32) as jit_float32
declare function jit_float32_sub cdecl alias "jit_float32_sub" (byval value1 as jit_float32, byval value2 as jit_float32) as jit_float32
declare function jit_float32_mul cdecl alias "jit_float32_mul" (byval value1 as jit_float32, byval value2 as jit_float32) as jit_float32
declare function jit_float32_div cdecl alias "jit_float32_div" (byval value1 as jit_float32, byval value2 as jit_float32) as jit_float32
declare function jit_float32_rem cdecl alias "jit_float32_rem" (byval value1 as jit_float32, byval value2 as jit_float32) as jit_float32
declare function jit_float32_ieee_rem cdecl alias "jit_float32_ieee_rem" (byval value1 as jit_float32, byval value2 as jit_float32) as jit_float32
declare function jit_float32_neg cdecl alias "jit_float32_neg" (byval value1 as jit_float32) as jit_float32
declare function jit_float32_eq cdecl alias "jit_float32_eq" (byval value1 as jit_float32, byval value2 as jit_float32) as jit_int
declare function jit_float32_ne cdecl alias "jit_float32_ne" (byval value1 as jit_float32, byval value2 as jit_float32) as jit_int
declare function jit_float32_lt cdecl alias "jit_float32_lt" (byval value1 as jit_float32, byval value2 as jit_float32) as jit_int
declare function jit_float32_le cdecl alias "jit_float32_le" (byval value1 as jit_float32, byval value2 as jit_float32) as jit_int
declare function jit_float32_gt cdecl alias "jit_float32_gt" (byval value1 as jit_float32, byval value2 as jit_float32) as jit_int
declare function jit_float32_ge cdecl alias "jit_float32_ge" (byval value1 as jit_float32, byval value2 as jit_float32) as jit_int
declare function jit_float32_cmpl cdecl alias "jit_float32_cmpl" (byval value1 as jit_float32, byval value2 as jit_float32) as jit_int
declare function jit_float32_cmpg cdecl alias "jit_float32_cmpg" (byval value1 as jit_float32, byval value2 as jit_float32) as jit_int
declare function jit_float32_acos cdecl alias "jit_float32_acos" (byval value1 as jit_float32) as jit_float32
declare function jit_float32_asin cdecl alias "jit_float32_asin" (byval value1 as jit_float32) as jit_float32
declare function jit_float32_atan cdecl alias "jit_float32_atan" (byval value1 as jit_float32) as jit_float32
declare function jit_float32_atan2 cdecl alias "jit_float32_atan2" (byval value1 as jit_float32, byval value2 as jit_float32) as jit_float32
declare function jit_float32_ceil cdecl alias "jit_float32_ceil" (byval value1 as jit_float32) as jit_float32
declare function jit_float32_cos cdecl alias "jit_float32_cos" (byval value1 as jit_float32) as jit_float32
declare function jit_float32_cosh cdecl alias "jit_float32_cosh" (byval value1 as jit_float32) as jit_float32
declare function jit_float32_exp cdecl alias "jit_float32_exp" (byval value1 as jit_float32) as jit_float32
declare function jit_float32_floor cdecl alias "jit_float32_floor" (byval value1 as jit_float32) as jit_float32
declare function jit_float32_log cdecl alias "jit_float32_log" (byval value1 as jit_float32) as jit_float32
declare function jit_float32_log10 cdecl alias "jit_float32_log10" (byval value1 as jit_float32) as jit_float32
declare function jit_float32_pow cdecl alias "jit_float32_pow" (byval value1 as jit_float32, byval value2 as jit_float32) as jit_float32
declare function jit_float32_rint cdecl alias "jit_float32_rint" (byval value1 as jit_float32) as jit_float32
declare function jit_float32_round cdecl alias "jit_float32_round" (byval value1 as jit_float32) as jit_float32
declare function jit_float32_sin cdecl alias "jit_float32_sin" (byval value1 as jit_float32) as jit_float32
declare function jit_float32_sinh cdecl alias "jit_float32_sinh" (byval value1 as jit_float32) as jit_float32
declare function jit_float32_sqrt cdecl alias "jit_float32_sqrt" (byval value1 as jit_float32) as jit_float32
declare function jit_float32_tan cdecl alias "jit_float32_tan" (byval value1 as jit_float32) as jit_float32
declare function jit_float32_tanh cdecl alias "jit_float32_tanh" (byval value1 as jit_float32) as jit_float32
declare function jit_float32_is_finite cdecl alias "jit_float32_is_finite" (byval value as jit_float32) as jit_int
declare function jit_float32_is_nan cdecl alias "jit_float32_is_nan" (byval value as jit_float32) as jit_int
declare function jit_float32_is_inf cdecl alias "jit_float32_is_inf" (byval value as jit_float32) as jit_int
declare function jit_float32_abs cdecl alias "jit_float32_abs" (byval value1 as jit_float32) as jit_float32
declare function jit_float32_min cdecl alias "jit_float32_min" (byval value1 as jit_float32, byval value2 as jit_float32) as jit_float32
declare function jit_float32_max cdecl alias "jit_float32_max" (byval value1 as jit_float32, byval value2 as jit_float32) as jit_float32
declare function jit_float32_sign cdecl alias "jit_float32_sign" (byval value1 as jit_float32) as jit_int
declare function jit_float64_add cdecl alias "jit_float64_add" (byval value1 as jit_float64, byval value2 as jit_float64) as jit_float64
declare function jit_float64_sub cdecl alias "jit_float64_sub" (byval value1 as jit_float64, byval value2 as jit_float64) as jit_float64
declare function jit_float64_mul cdecl alias "jit_float64_mul" (byval value1 as jit_float64, byval value2 as jit_float64) as jit_float64
declare function jit_float64_div cdecl alias "jit_float64_div" (byval value1 as jit_float64, byval value2 as jit_float64) as jit_float64
declare function jit_float64_rem cdecl alias "jit_float64_rem" (byval value1 as jit_float64, byval value2 as jit_float64) as jit_float64
declare function jit_float64_ieee_rem cdecl alias "jit_float64_ieee_rem" (byval value1 as jit_float64, byval value2 as jit_float64) as jit_float64
declare function jit_float64_neg cdecl alias "jit_float64_neg" (byval value1 as jit_float64) as jit_float64
declare function jit_float64_eq cdecl alias "jit_float64_eq" (byval value1 as jit_float64, byval value2 as jit_float64) as jit_int
declare function jit_float64_ne cdecl alias "jit_float64_ne" (byval value1 as jit_float64, byval value2 as jit_float64) as jit_int
declare function jit_float64_lt cdecl alias "jit_float64_lt" (byval value1 as jit_float64, byval value2 as jit_float64) as jit_int
declare function jit_float64_le cdecl alias "jit_float64_le" (byval value1 as jit_float64, byval value2 as jit_float64) as jit_int
declare function jit_float64_gt cdecl alias "jit_float64_gt" (byval value1 as jit_float64, byval value2 as jit_float64) as jit_int
declare function jit_float64_ge cdecl alias "jit_float64_ge" (byval value1 as jit_float64, byval value2 as jit_float64) as jit_int
declare function jit_float64_cmpl cdecl alias "jit_float64_cmpl" (byval value1 as jit_float64, byval value2 as jit_float64) as jit_int
declare function jit_float64_cmpg cdecl alias "jit_float64_cmpg" (byval value1 as jit_float64, byval value2 as jit_float64) as jit_int
declare function jit_float64_acos cdecl alias "jit_float64_acos" (byval value1 as jit_float64) as jit_float64
declare function jit_float64_asin cdecl alias "jit_float64_asin" (byval value1 as jit_float64) as jit_float64
declare function jit_float64_atan cdecl alias "jit_float64_atan" (byval value1 as jit_float64) as jit_float64
declare function jit_float64_atan2 cdecl alias "jit_float64_atan2" (byval value1 as jit_float64, byval value2 as jit_float64) as jit_float64
declare function jit_float64_ceil cdecl alias "jit_float64_ceil" (byval value1 as jit_float64) as jit_float64
declare function jit_float64_cos cdecl alias "jit_float64_cos" (byval value1 as jit_float64) as jit_float64
declare function jit_float64_cosh cdecl alias "jit_float64_cosh" (byval value1 as jit_float64) as jit_float64
declare function jit_float64_exp cdecl alias "jit_float64_exp" (byval value1 as jit_float64) as jit_float64
declare function jit_float64_floor cdecl alias "jit_float64_floor" (byval value1 as jit_float64) as jit_float64
declare function jit_float64_log cdecl alias "jit_float64_log" (byval value1 as jit_float64) as jit_float64
declare function jit_float64_log10 cdecl alias "jit_float64_log10" (byval value1 as jit_float64) as jit_float64
declare function jit_float64_pow cdecl alias "jit_float64_pow" (byval value1 as jit_float64, byval value2 as jit_float64) as jit_float64
declare function jit_float64_rint cdecl alias "jit_float64_rint" (byval value1 as jit_float64) as jit_float64
declare function jit_float64_round cdecl alias "jit_float64_round" (byval value1 as jit_float64) as jit_float64
declare function jit_float64_sin cdecl alias "jit_float64_sin" (byval value1 as jit_float64) as jit_float64
declare function jit_float64_sinh cdecl alias "jit_float64_sinh" (byval value1 as jit_float64) as jit_float64
declare function jit_float64_sqrt cdecl alias "jit_float64_sqrt" (byval value1 as jit_float64) as jit_float64
declare function jit_float64_tan cdecl alias "jit_float64_tan" (byval value1 as jit_float64) as jit_float64
declare function jit_float64_tanh cdecl alias "jit_float64_tanh" (byval value1 as jit_float64) as jit_float64
declare function jit_float64_is_finite cdecl alias "jit_float64_is_finite" (byval value as jit_float64) as jit_int
declare function jit_float64_is_nan cdecl alias "jit_float64_is_nan" (byval value as jit_float64) as jit_int
declare function jit_float64_is_inf cdecl alias "jit_float64_is_inf" (byval value as jit_float64) as jit_int
declare function jit_float64_abs cdecl alias "jit_float64_abs" (byval value1 as jit_float64) as jit_float64
declare function jit_float64_min cdecl alias "jit_float64_min" (byval value1 as jit_float64, byval value2 as jit_float64) as jit_float64
declare function jit_float64_max cdecl alias "jit_float64_max" (byval value1 as jit_float64, byval value2 as jit_float64) as jit_float64
declare function jit_float64_sign cdecl alias "jit_float64_sign" (byval value1 as jit_float64) as jit_int
declare function jit_nfloat_add cdecl alias "jit_nfloat_add" (byval value1 as jit_nfloat, byval value2 as jit_nfloat) as jit_nfloat
declare function jit_nfloat_sub cdecl alias "jit_nfloat_sub" (byval value1 as jit_nfloat, byval value2 as jit_nfloat) as jit_nfloat
declare function jit_nfloat_mul cdecl alias "jit_nfloat_mul" (byval value1 as jit_nfloat, byval value2 as jit_nfloat) as jit_nfloat
declare function jit_nfloat_div cdecl alias "jit_nfloat_div" (byval value1 as jit_nfloat, byval value2 as jit_nfloat) as jit_nfloat
declare function jit_nfloat_rem cdecl alias "jit_nfloat_rem" (byval value1 as jit_nfloat, byval value2 as jit_nfloat) as jit_nfloat
declare function jit_nfloat_ieee_rem cdecl alias "jit_nfloat_ieee_rem" (byval value1 as jit_nfloat, byval value2 as jit_nfloat) as jit_nfloat
declare function jit_nfloat_neg cdecl alias "jit_nfloat_neg" (byval value1 as jit_nfloat) as jit_nfloat
declare function jit_nfloat_eq cdecl alias "jit_nfloat_eq" (byval value1 as jit_nfloat, byval value2 as jit_nfloat) as jit_int
declare function jit_nfloat_ne cdecl alias "jit_nfloat_ne" (byval value1 as jit_nfloat, byval value2 as jit_nfloat) as jit_int
declare function jit_nfloat_lt cdecl alias "jit_nfloat_lt" (byval value1 as jit_nfloat, byval value2 as jit_nfloat) as jit_int
declare function jit_nfloat_le cdecl alias "jit_nfloat_le" (byval value1 as jit_nfloat, byval value2 as jit_nfloat) as jit_int
declare function jit_nfloat_gt cdecl alias "jit_nfloat_gt" (byval value1 as jit_nfloat, byval value2 as jit_nfloat) as jit_int
declare function jit_nfloat_ge cdecl alias "jit_nfloat_ge" (byval value1 as jit_nfloat, byval value2 as jit_nfloat) as jit_int
declare function jit_nfloat_cmpl cdecl alias "jit_nfloat_cmpl" (byval value1 as jit_nfloat, byval value2 as jit_nfloat) as jit_int
declare function jit_nfloat_cmpg cdecl alias "jit_nfloat_cmpg" (byval value1 as jit_nfloat, byval value2 as jit_nfloat) as jit_int
declare function jit_nfloat_acos cdecl alias "jit_nfloat_acos" (byval value1 as jit_nfloat) as jit_nfloat
declare function jit_nfloat_asin cdecl alias "jit_nfloat_asin" (byval value1 as jit_nfloat) as jit_nfloat
declare function jit_nfloat_atan cdecl alias "jit_nfloat_atan" (byval value1 as jit_nfloat) as jit_nfloat
declare function jit_nfloat_atan2 cdecl alias "jit_nfloat_atan2" (byval value1 as jit_nfloat, byval value2 as jit_nfloat) as jit_nfloat
declare function jit_nfloat_ceil cdecl alias "jit_nfloat_ceil" (byval value1 as jit_nfloat) as jit_nfloat
declare function jit_nfloat_cos cdecl alias "jit_nfloat_cos" (byval value1 as jit_nfloat) as jit_nfloat
declare function jit_nfloat_cosh cdecl alias "jit_nfloat_cosh" (byval value1 as jit_nfloat) as jit_nfloat
declare function jit_nfloat_exp cdecl alias "jit_nfloat_exp" (byval value1 as jit_nfloat) as jit_nfloat
declare function jit_nfloat_floor cdecl alias "jit_nfloat_floor" (byval value1 as jit_nfloat) as jit_nfloat
declare function jit_nfloat_log cdecl alias "jit_nfloat_log" (byval value1 as jit_nfloat) as jit_nfloat
declare function jit_nfloat_log10 cdecl alias "jit_nfloat_log10" (byval value1 as jit_nfloat) as jit_nfloat
declare function jit_nfloat_pow cdecl alias "jit_nfloat_pow" (byval value1 as jit_nfloat, byval value2 as jit_nfloat) as jit_nfloat
declare function jit_nfloat_rint cdecl alias "jit_nfloat_rint" (byval value1 as jit_nfloat) as jit_nfloat
declare function jit_nfloat_round cdecl alias "jit_nfloat_round" (byval value1 as jit_nfloat) as jit_nfloat
declare function jit_nfloat_sin cdecl alias "jit_nfloat_sin" (byval value1 as jit_nfloat) as jit_nfloat
declare function jit_nfloat_sinh cdecl alias "jit_nfloat_sinh" (byval value1 as jit_nfloat) as jit_nfloat
declare function jit_nfloat_sqrt cdecl alias "jit_nfloat_sqrt" (byval value1 as jit_nfloat) as jit_nfloat
declare function jit_nfloat_tan cdecl alias "jit_nfloat_tan" (byval value1 as jit_nfloat) as jit_nfloat
declare function jit_nfloat_tanh cdecl alias "jit_nfloat_tanh" (byval value1 as jit_nfloat) as jit_nfloat
declare function jit_nfloat_is_finite cdecl alias "jit_nfloat_is_finite" (byval value as jit_nfloat) as jit_int
declare function jit_nfloat_is_nan cdecl alias "jit_nfloat_is_nan" (byval value as jit_nfloat) as jit_int
declare function jit_nfloat_is_inf cdecl alias "jit_nfloat_is_inf" (byval value as jit_nfloat) as jit_int
declare function jit_nfloat_abs cdecl alias "jit_nfloat_abs" (byval value1 as jit_nfloat) as jit_nfloat
declare function jit_nfloat_min cdecl alias "jit_nfloat_min" (byval value1 as jit_nfloat, byval value2 as jit_nfloat) as jit_nfloat
declare function jit_nfloat_max cdecl alias "jit_nfloat_max" (byval value1 as jit_nfloat, byval value2 as jit_nfloat) as jit_nfloat
declare function jit_nfloat_sign cdecl alias "jit_nfloat_sign" (byval value1 as jit_nfloat) as jit_int
declare function jit_int_to_sbyte cdecl alias "jit_int_to_sbyte" (byval value as jit_int) as jit_int
declare function jit_int_to_ubyte cdecl alias "jit_int_to_ubyte" (byval value as jit_int) as jit_int
declare function jit_int_to_short cdecl alias "jit_int_to_short" (byval value as jit_int) as jit_int
declare function jit_int_to_ushort cdecl alias "jit_int_to_ushort" (byval value as jit_int) as jit_int
declare function jit_int_to_int cdecl alias "jit_int_to_int" (byval value as jit_int) as jit_int
declare function jit_int_to_uint cdecl alias "jit_int_to_uint" (byval value as jit_int) as jit_uint
declare function jit_int_to_long cdecl alias "jit_int_to_long" (byval value as jit_int) as jit_long
declare function jit_int_to_ulong cdecl alias "jit_int_to_ulong" (byval value as jit_int) as jit_ulong
declare function jit_uint_to_int cdecl alias "jit_uint_to_int" (byval value as jit_uint) as jit_int
declare function jit_uint_to_uint cdecl alias "jit_uint_to_uint" (byval value as jit_uint) as jit_uint
declare function jit_uint_to_long cdecl alias "jit_uint_to_long" (byval value as jit_uint) as jit_long
declare function jit_uint_to_ulong cdecl alias "jit_uint_to_ulong" (byval value as jit_uint) as jit_ulong
declare function jit_long_to_int cdecl alias "jit_long_to_int" (byval value as jit_long) as jit_int
declare function jit_long_to_uint cdecl alias "jit_long_to_uint" (byval value as jit_long) as jit_uint
declare function jit_long_to_long cdecl alias "jit_long_to_long" (byval value as jit_long) as jit_long
declare function jit_long_to_ulong cdecl alias "jit_long_to_ulong" (byval value as jit_long) as jit_ulong
declare function jit_ulong_to_int cdecl alias "jit_ulong_to_int" (byval value as jit_ulong) as jit_int
declare function jit_ulong_to_uint cdecl alias "jit_ulong_to_uint" (byval value as jit_ulong) as jit_uint
declare function jit_ulong_to_long cdecl alias "jit_ulong_to_long" (byval value as jit_ulong) as jit_long
declare function jit_ulong_to_ulong cdecl alias "jit_ulong_to_ulong" (byval value as jit_ulong) as jit_ulong
declare function jit_int_to_sbyte_ovf cdecl alias "jit_int_to_sbyte_ovf" (byval result as jit_int ptr, byval value as jit_int) as jit_int
declare function jit_int_to_ubyte_ovf cdecl alias "jit_int_to_ubyte_ovf" (byval result as jit_int ptr, byval value as jit_int) as jit_int
declare function jit_int_to_short_ovf cdecl alias "jit_int_to_short_ovf" (byval result as jit_int ptr, byval value as jit_int) as jit_int
declare function jit_int_to_ushort_ovf cdecl alias "jit_int_to_ushort_ovf" (byval result as jit_int ptr, byval value as jit_int) as jit_int
declare function jit_int_to_int_ovf cdecl alias "jit_int_to_int_ovf" (byval result as jit_int ptr, byval value as jit_int) as jit_int
declare function jit_int_to_uint_ovf cdecl alias "jit_int_to_uint_ovf" (byval result as jit_uint ptr, byval value as jit_int) as jit_int
declare function jit_int_to_long_ovf cdecl alias "jit_int_to_long_ovf" (byval result as jit_long ptr, byval value as jit_int) as jit_int
declare function jit_int_to_ulong_ovf cdecl alias "jit_int_to_ulong_ovf" (byval result as jit_ulong ptr, byval value as jit_int) as jit_int
declare function jit_uint_to_int_ovf cdecl alias "jit_uint_to_int_ovf" (byval result as jit_int ptr, byval value as jit_uint) as jit_int
declare function jit_uint_to_uint_ovf cdecl alias "jit_uint_to_uint_ovf" (byval result as jit_uint ptr, byval value as jit_uint) as jit_int
declare function jit_uint_to_long_ovf cdecl alias "jit_uint_to_long_ovf" (byval result as jit_long ptr, byval value as jit_uint) as jit_int
declare function jit_uint_to_ulong_ovf cdecl alias "jit_uint_to_ulong_ovf" (byval result as jit_ulong ptr, byval value as jit_uint) as jit_int
declare function jit_long_to_int_ovf cdecl alias "jit_long_to_int_ovf" (byval result as jit_int ptr, byval value as jit_long) as jit_int
declare function jit_long_to_uint_ovf cdecl alias "jit_long_to_uint_ovf" (byval result as jit_uint ptr, byval value as jit_long) as jit_int
declare function jit_long_to_long_ovf cdecl alias "jit_long_to_long_ovf" (byval result as jit_long ptr, byval value as jit_long) as jit_int
declare function jit_long_to_ulong_ovf cdecl alias "jit_long_to_ulong_ovf" (byval result as jit_ulong ptr, byval value as jit_long) as jit_int
declare function jit_ulong_to_int_ovf cdecl alias "jit_ulong_to_int_ovf" (byval result as jit_int ptr, byval value as jit_ulong) as jit_int
declare function jit_ulong_to_uint_ovf cdecl alias "jit_ulong_to_uint_ovf" (byval result as jit_uint ptr, byval value as jit_ulong) as jit_int
declare function jit_ulong_to_long_ovf cdecl alias "jit_ulong_to_long_ovf" (byval result as jit_long ptr, byval value as jit_ulong) as jit_int
declare function jit_ulong_to_ulong_ovf cdecl alias "jit_ulong_to_ulong_ovf" (byval result as jit_ulong ptr, byval value as jit_ulong) as jit_int
declare function jit_nfloat_to_int cdecl alias "jit_nfloat_to_int" (byval value as jit_nfloat) as jit_int
declare function jit_nfloat_to_uint cdecl alias "jit_nfloat_to_uint" (byval value as jit_nfloat) as jit_uint
declare function jit_nfloat_to_long cdecl alias "jit_nfloat_to_long" (byval value as jit_nfloat) as jit_long
declare function jit_nfloat_to_ulong cdecl alias "jit_nfloat_to_ulong" (byval value as jit_nfloat) as jit_ulong
declare function jit_nfloat_to_int_ovf cdecl alias "jit_nfloat_to_int_ovf" (byval result as jit_int ptr, byval value as jit_nfloat) as jit_int
declare function jit_nfloat_to_uint_ovf cdecl alias "jit_nfloat_to_uint_ovf" (byval result as jit_uint ptr, byval value as jit_nfloat) as jit_int
declare function jit_nfloat_to_long_ovf cdecl alias "jit_nfloat_to_long_ovf" (byval result as jit_long ptr, byval value as jit_nfloat) as jit_int
declare function jit_nfloat_to_ulong_ovf cdecl alias "jit_nfloat_to_ulong_ovf" (byval result as jit_ulong ptr, byval value as jit_nfloat) as jit_int
declare function jit_int_to_nfloat cdecl alias "jit_int_to_nfloat" (byval value as jit_int) as jit_nfloat
declare function jit_uint_to_nfloat cdecl alias "jit_uint_to_nfloat" (byval value as jit_uint) as jit_nfloat
declare function jit_long_to_nfloat cdecl alias "jit_long_to_nfloat" (byval value as jit_long) as jit_nfloat
declare function jit_ulong_to_nfloat cdecl alias "jit_ulong_to_nfloat" (byval value as jit_ulong) as jit_nfloat
declare function jit_float32_to_nfloat cdecl alias "jit_float32_to_nfloat" (byval value as jit_float32) as jit_nfloat
declare function jit_float64_to_nfloat cdecl alias "jit_float64_to_nfloat" (byval value as jit_float64) as jit_nfloat
declare function jit_nfloat_to_float32 cdecl alias "jit_nfloat_to_float32" (byval value as jit_nfloat) as jit_float32
declare function jit_nfloat_to_float64 cdecl alias "jit_nfloat_to_float64" (byval value as jit_nfloat) as jit_float64

#endif
