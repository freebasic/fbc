'' FreeBASIC binding for flite-2.0.0-release
''
'' based on the C header files:
''                     Language Technologies Institute                      
''                        Carnegie Mellon University                        
''                         Copyright (c) 1999-2014                          
''                           All Rights Reserved.                           
''                                                                          
''     Permission is hereby granted, free of charge, to use and distribute  
''     this software and its documentation without restriction, including   
''     without limitation the rights to use, copy, modify, merge, publish,  
''     distribute, sublicense, and/or sell copies of this work, and to      
''     permit persons to whom this work is furnished to do so, subject to   
''     the following conditions:                                            
''      1. The code must retain the above copyright notice, this list of    
''         conditions and the following disclaimer.                         
''      2. Any modifications must be clearly marked as such.                
''      3. Original authors' names are not deleted.                         
''      4. The authors' names are not used to endorse or promote products   
''         derived from this software without specific prior written        
''         permission.                                                      
''                                                                          
''     CARNEGIE MELLON UNIVERSITY AND THE CONTRIBUTORS TO THIS WORK         
''     DISCLAIM ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING      
''     ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO EVENT   
''     SHALL CARNEGIE MELLON UNIVERSITY NOR THE CONTRIBUTORS BE LIABLE      
''     FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES    
''     WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN   
''     AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION,          
''     ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF       
''     THIS SOFTWARE.                                                       
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "cst_val_defs.bi"

'' The following symbols have been renamed:
''     typedef cst_val_float => cst_val_float_
''     typedef cst_val_int => cst_val_int_
''     typedef cst_val_void => cst_val_void_
''     variable val_int_0 => val_int_0_
''     variable val_int_1 => val_int_1_
''     variable val_int_2 => val_int_2_
''     variable val_int_3 => val_int_3_
''     variable val_int_4 => val_int_4_
''     variable val_int_5 => val_int_5_
''     variable val_int_6 => val_int_6_
''     variable val_int_7 => val_int_7_
''     variable val_int_8 => val_int_8_
''     variable val_int_9 => val_int_9_
''     variable val_int_10 => val_int_10_
''     variable val_int_11 => val_int_11_
''     variable val_int_12 => val_int_12_
''     variable val_int_13 => val_int_13_
''     variable val_int_14 => val_int_14_
''     variable val_int_15 => val_int_15_
''     variable val_int_16 => val_int_16_
''     variable val_int_17 => val_int_17_
''     variable val_int_18 => val_int_18_
''     variable val_int_19 => val_int_19_
''     variable val_int_20 => val_int_20_
''     variable val_int_21 => val_int_21_
''     variable val_int_22 => val_int_22_
''     variable val_int_23 => val_int_23_
''     variable val_int_24 => val_int_24_
''     variable val_string_0 => val_string_0_
''     variable val_string_1 => val_string_1_
''     variable val_string_2 => val_string_2_
''     variable val_string_3 => val_string_3_
''     variable val_string_4 => val_string_4_
''     variable val_string_5 => val_string_5_
''     variable val_string_6 => val_string_6_
''     variable val_string_7 => val_string_7_
''     variable val_string_8 => val_string_8_
''     variable val_string_9 => val_string_9_
''     variable val_string_10 => val_string_10_
''     variable val_string_11 => val_string_11_
''     variable val_string_12 => val_string_12_
''     variable val_string_13 => val_string_13_
''     variable val_string_14 => val_string_14_
''     variable val_string_15 => val_string_15_
''     variable val_string_16 => val_string_16_
''     variable val_string_17 => val_string_17_
''     variable val_string_18 => val_string_18_
''     variable val_string_19 => val_string_19_
''     variable val_string_20 => val_string_20_
''     variable val_string_21 => val_string_21_
''     variable val_string_22 => val_string_22_
''     variable val_string_23 => val_string_23_
''     variable val_string_24 => val_string_24_

extern "C"

#define _CST_VAL_CONSTS_H__
const CST_CONST_INT_MAX = 19

type cst_val_atom_struct_float
	#if defined(__FB_64BIT__) and (defined(__FB_DARWIN__) or defined(__FB_WIN32__) or defined(__FB_CYGWIN__) or ((not defined(__FB_ARM__)) and (defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__))))
		as long type
		ref_count as long
		fval as double
	#else
		as short type
		ref_count as short
		fval as single
	#endif
end type

type cst_val_float_ as cst_val_atom_struct_float

type cst_val_atom_struct_int
	#if defined(__FB_64BIT__) and (defined(__FB_DARWIN__) or defined(__FB_WIN32__) or defined(__FB_CYGWIN__) or ((not defined(__FB_ARM__)) and (defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__))))
		as long type
		ref_count as long
		ival as longint
	#else
		as short type
		ref_count as short
		ival as long
	#endif
end type

type cst_val_int_ as cst_val_atom_struct_int

type cst_val_atom_struct_void
	#if defined(__FB_64BIT__) and (defined(__FB_DARWIN__) or defined(__FB_WIN32__) or defined(__FB_CYGWIN__) or ((not defined(__FB_ARM__)) and (defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__))))
		as long type
		ref_count as long
	#else
		as short type
		ref_count as short
	#endif

	vval as any ptr
end type

type cst_val_void_ as cst_val_atom_struct_void
#define DEF_CONST_VAL_INT(N, V) dim as const cst_val_int N = (CST_VAL_TYPE_INT, -1, V)
#define DEF_CONST_VAL_STRING(N, S) dim as const cst_val_void N = (CST_VAL_TYPE_STRING, -1, cptr(any ptr, S))
#define DEF_CONST_VAL_FLOAT(N, F) dim as const cst_val_float N = (CST_VAL_TYPE_FLOAT, -1, csng(F))
#define DEF_CONST_VAL_CONS(N, A, D) dim as const cst_val_cons N = (A, D)

extern val_int_0_ alias "val_int_0" as const cst_val_int_
extern val_int_1_ alias "val_int_1" as const cst_val_int_
extern val_int_2_ alias "val_int_2" as const cst_val_int_
extern val_int_3_ alias "val_int_3" as const cst_val_int_
extern val_int_4_ alias "val_int_4" as const cst_val_int_
extern val_int_5_ alias "val_int_5" as const cst_val_int_
extern val_int_6_ alias "val_int_6" as const cst_val_int_
extern val_int_7_ alias "val_int_7" as const cst_val_int_
extern val_int_8_ alias "val_int_8" as const cst_val_int_
extern val_int_9_ alias "val_int_9" as const cst_val_int_
extern val_int_10_ alias "val_int_10" as const cst_val_int_
extern val_int_11_ alias "val_int_11" as const cst_val_int_
extern val_int_12_ alias "val_int_12" as const cst_val_int_
extern val_int_13_ alias "val_int_13" as const cst_val_int_
extern val_int_14_ alias "val_int_14" as const cst_val_int_
extern val_int_15_ alias "val_int_15" as const cst_val_int_
extern val_int_16_ alias "val_int_16" as const cst_val_int_
extern val_int_17_ alias "val_int_17" as const cst_val_int_
extern val_int_18_ alias "val_int_18" as const cst_val_int_
extern val_int_19_ alias "val_int_19" as const cst_val_int_
extern val_int_20_ alias "val_int_20" as const cst_val_int_
extern val_int_21_ alias "val_int_21" as const cst_val_int_
extern val_int_22_ alias "val_int_22" as const cst_val_int_
extern val_int_23_ alias "val_int_23" as const cst_val_int_
extern val_int_24_ alias "val_int_24" as const cst_val_int_
extern val_string_0_ alias "val_string_0" as const cst_val_void_
extern val_string_1_ alias "val_string_1" as const cst_val_void_
extern val_string_2_ alias "val_string_2" as const cst_val_void_
extern val_string_3_ alias "val_string_3" as const cst_val_void_
extern val_string_4_ alias "val_string_4" as const cst_val_void_
extern val_string_5_ alias "val_string_5" as const cst_val_void_
extern val_string_6_ alias "val_string_6" as const cst_val_void_
extern val_string_7_ alias "val_string_7" as const cst_val_void_
extern val_string_8_ alias "val_string_8" as const cst_val_void_
extern val_string_9_ alias "val_string_9" as const cst_val_void_
extern val_string_10_ alias "val_string_10" as const cst_val_void_
extern val_string_11_ alias "val_string_11" as const cst_val_void_
extern val_string_12_ alias "val_string_12" as const cst_val_void_
extern val_string_13_ alias "val_string_13" as const cst_val_void_
extern val_string_14_ alias "val_string_14" as const cst_val_void_
extern val_string_15_ alias "val_string_15" as const cst_val_void_
extern val_string_16_ alias "val_string_16" as const cst_val_void_
extern val_string_17_ alias "val_string_17" as const cst_val_void_
extern val_string_18_ alias "val_string_18" as const cst_val_void_
extern val_string_19_ alias "val_string_19" as const cst_val_void_
extern val_string_20_ alias "val_string_20" as const cst_val_void_
extern val_string_21_ alias "val_string_21" as const cst_val_void_
extern val_string_22_ alias "val_string_22" as const cst_val_void_
extern val_string_23_ alias "val_string_23" as const cst_val_void_
extern val_string_24_ alias "val_string_24" as const cst_val_void_
#define DEF_STATIC_CONST_VAL_INT(N, V) static as const cst_val_int N = (CST_VAL_TYPE_INT, -1, V)
#define DEF_STATIC_CONST_VAL_STRING(N, S) static as const cst_val_void N = (CST_VAL_TYPE_STRING, -1, cptr(any ptr, S))
#define DEF_STATIC_CONST_VAL_FLOAT(N, F) static as const cst_val_float N = (CST_VAL_TYPE_FLOAT, -1, csng(F))
#define DEF_STATIC_CONST_VAL_CONS(N, A, D) static as const cst_val_cons N = (A, D)

#define VAL_INT_0 cptr(cst_val ptr, @val_int_0_)
#define VAL_INT_1 cptr(cst_val ptr, @val_int_1_)
#define VAL_INT_2 cptr(cst_val ptr, @val_int_2_)
#define VAL_INT_3 cptr(cst_val ptr, @val_int_3_)
#define VAL_INT_4 cptr(cst_val ptr, @val_int_4_)
#define VAL_INT_5 cptr(cst_val ptr, @val_int_5_)
#define VAL_INT_6 cptr(cst_val ptr, @val_int_6_)
#define VAL_INT_7 cptr(cst_val ptr, @val_int_7_)
#define VAL_INT_8 cptr(cst_val ptr, @val_int_8_)
#define VAL_INT_9 cptr(cst_val ptr, @val_int_9_)
#define VAL_INT_10 cptr(cst_val ptr, @val_int_10_)
#define VAL_INT_11 cptr(cst_val ptr, @val_int_11_)
#define VAL_INT_12 cptr(cst_val ptr, @val_int_12_)
#define VAL_INT_13 cptr(cst_val ptr, @val_int_13_)
#define VAL_INT_14 cptr(cst_val ptr, @val_int_14_)
#define VAL_INT_15 cptr(cst_val ptr, @val_int_15_)
#define VAL_INT_16 cptr(cst_val ptr, @val_int_16_)
#define VAL_INT_17 cptr(cst_val ptr, @val_int_17_)
#define VAL_INT_18 cptr(cst_val ptr, @val_int_18_)
#define VAL_INT_19 cptr(cst_val ptr, @val_int_19_)
#define VAL_INT_20 cptr(cst_val ptr, @val_int_20_)
#define VAL_INT_21 cptr(cst_val ptr, @val_int_21_)
#define VAL_INT_22 cptr(cst_val ptr, @val_int_22_)
#define VAL_INT_23 cptr(cst_val ptr, @val_int_23_)
#define VAL_INT_24 cptr(cst_val ptr, @val_int_24_)
declare function val_int_n(byval n as long) as const cst_val ptr
#define VAL_STRING_0 cptr(cst_val ptr, @val_string_0_)
#define VAL_STRING_1 cptr(cst_val ptr, @val_string_1_)
#define VAL_STRING_2 cptr(cst_val ptr, @val_string_2_)
#define VAL_STRING_3 cptr(cst_val ptr, @val_string_3_)
#define VAL_STRING_4 cptr(cst_val ptr, @val_string_4_)
#define VAL_STRING_5 cptr(cst_val ptr, @val_string_5_)
#define VAL_STRING_6 cptr(cst_val ptr, @val_string_6_)
#define VAL_STRING_7 cptr(cst_val ptr, @val_string_7_)
#define VAL_STRING_8 cptr(cst_val ptr, @val_string_8_)
#define VAL_STRING_9 cptr(cst_val ptr, @val_string_9_)
#define VAL_STRING_10 cptr(cst_val ptr, @val_string_10_)
#define VAL_STRING_11 cptr(cst_val ptr, @val_string_11_)
#define VAL_STRING_12 cptr(cst_val ptr, @val_string_12_)
#define VAL_STRING_13 cptr(cst_val ptr, @val_string_13_)
#define VAL_STRING_14 cptr(cst_val ptr, @val_string_14_)
#define VAL_STRING_15 cptr(cst_val ptr, @val_string_15_)
#define VAL_STRING_16 cptr(cst_val ptr, @val_string_16_)
#define VAL_STRING_17 cptr(cst_val ptr, @val_string_17_)
#define VAL_STRING_18 cptr(cst_val ptr, @val_string_18_)
#define VAL_STRING_19 cptr(cst_val ptr, @val_string_19_)
#define VAL_STRING_20 cptr(cst_val ptr, @val_string_20_)
#define VAL_STRING_21 cptr(cst_val ptr, @val_string_21_)
#define VAL_STRING_22 cptr(cst_val ptr, @val_string_22_)
#define VAL_STRING_23 cptr(cst_val ptr, @val_string_23_)
#define VAL_STRING_24 cptr(cst_val ptr, @val_string_24_)
declare function val_string_n(byval n as long) as const cst_val ptr

end extern
