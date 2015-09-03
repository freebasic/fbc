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

#include once "cst_file.bi"
#include once "cst_string.bi"
#include once "cst_error.bi"
#include once "cst_alloc.bi"
#include once "cst_val_defs.bi"

extern "C"

#define _CST_VAL_H__
const CST_VAL_TYPE_CONS = 0
const CST_VAL_TYPE_INT = 1
const CST_VAL_TYPE_FLOAT = 3
const CST_VAL_TYPE_STRING = 5
const CST_VAL_TYPE_FIRST_FREE = 7
const CST_VAL_TYPE_MAX = 54
type cst_val_struct as cst_val_struct_

type cst_val_cons_struct
	car as cst_val_struct ptr
	cdr as cst_val_struct ptr
end type

type cst_val_cons as cst_val_cons_struct

union cst_val_atom_struct_v
	#if defined(__FB_64BIT__) and (defined(__FB_DARWIN__) or defined(__FB_WIN32__) or defined(__FB_CYGWIN__) or ((not defined(__FB_ARM__)) and (defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__))))
		fval as double
		ival as longint
	#else
		fval as single
		ival as long
	#endif

	vval as any ptr
end union

type cst_val_atom_struct
	#if defined(__FB_64BIT__) and (defined(__FB_DARWIN__) or defined(__FB_WIN32__) or defined(__FB_CYGWIN__) or ((not defined(__FB_ARM__)) and (defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__))))
		as long type
		ref_count as long
	#else
		as short type
		ref_count as short
	#endif

	v as cst_val_atom_struct_v
end type

type cst_val_atom as cst_val_atom_struct

union cst_val_struct_c
	cc as cst_val_cons
	a as cst_val_atom
end union

type cst_val_struct_
	c as cst_val_struct_c
end type

type cst_val as cst_val_struct

type cst_val_def_struct
	name as const zstring ptr
	delete_function as sub(byval as any ptr)
end type

type cst_val_def as cst_val_def_struct
declare function int_val(byval i as long) as cst_val ptr
declare function float_val(byval f as single) as cst_val ptr
declare function string_val(byval s as const zstring ptr) as cst_val ptr
declare function val_new_typed(byval type as long, byval vv as any ptr) as cst_val ptr
declare function cons_val(byval a as const cst_val ptr, byval b as const cst_val ptr) as cst_val ptr
declare sub delete_val(byval val as cst_val ptr)
declare sub delete_val_list(byval val as cst_val ptr)
declare function val_int(byval v as const cst_val ptr) as long
declare function val_float(byval v as const cst_val ptr) as single
declare function val_string(byval v as const cst_val ptr) as const zstring ptr
declare function val_void(byval v as const cst_val ptr) as any ptr
declare function val_generic(byval v as const cst_val ptr, byval type as long, byval stype as const zstring ptr) as any ptr
declare function val_car(byval v as const cst_val ptr) as const cst_val ptr
declare function val_cdr(byval v as const cst_val ptr) as const cst_val ptr
declare function set_cdr(byval v1 as cst_val ptr, byval v2 as const cst_val ptr) as const cst_val ptr
declare function set_car(byval v1 as cst_val ptr, byval v2 as const cst_val ptr) as const cst_val ptr
declare function cst_val_consp(byval v as const cst_val ptr) as long

#define CST_VAL_STRING_LVAL(X) (X)->c.a.v.vval
#define CST_VAL_TYPE(X) (X)->c.a.type
#define CST_VAL_INT(X) (X)->c.a.v.ival
#define CST_VAL_FLOAT(X) (X)->c.a.v.fval
#define CST_VAL_STRING(X) cptr(const zstring ptr, CST_VAL_STRING_LVAL(X))
#define CST_VAL_VOID(X) (X)->c.a.v.vval
#define CST_VAL_CAR(X) (X)->c.cc.car
#define CST_VAL_CDR(X) (X)->c.cc.cdr
#define CST_VAL_REFCOUNT(X) (X)->c.a.ref_count

declare function val_equal(byval a as const cst_val ptr, byval b as const cst_val ptr) as long
declare function val_less(byval a as const cst_val ptr, byval b as const cst_val ptr) as long
declare function val_greater(byval a as const cst_val ptr, byval b as const cst_val ptr) as long
declare function val_member(byval a as const cst_val ptr, byval b as const cst_val ptr) as long
declare function val_member_string(byval a as const zstring ptr, byval b as const cst_val ptr) as long
declare function val_stringp(byval a as const cst_val ptr) as long
declare function val_assoc_string(byval v1 as const zstring ptr, byval al as const cst_val ptr) as const cst_val ptr
declare sub val_print(byval fd as cst_file, byval v as const cst_val ptr)
declare function val_readlist_string(byval str as const zstring ptr) as cst_val ptr
declare function val_reverse(byval v as cst_val ptr) as cst_val ptr
declare function val_append(byval a as cst_val ptr, byval b as cst_val ptr) as cst_val ptr
declare function val_length(byval l as const cst_val ptr) as long
declare function cst_utf8_explode(byval utf8string as const cst_string ptr) as cst_val ptr
declare function cst_implode(byval string_list as const cst_val ptr) as cst_string ptr
declare function cst_utf8_ord(byval utf8_char as const cst_val ptr) as cst_val ptr
declare function cst_utf8_chr(byval ord as const cst_val ptr) as cst_val ptr
declare function cst_utf8_ord_string(byval utf8_char as const zstring ptr) as long
declare function val_dec_refcount(byval b as const cst_val ptr) as long
declare function val_inc_refcount(byval b as const cst_val ptr) as cst_val ptr

end extern

#include once "cst_val_const.bi"

extern "C"

#define cst_val_defs(i) ((@__cst_val_defs)[i])
extern __cst_val_defs alias "cst_val_defs" as const cst_val_def
type cst_userdata as any
extern cst_val_type_userdata as const long
declare function val_userdata(byval v as const cst_val ptr) as cst_userdata ptr
declare function userdata_val(byval v as const cst_userdata ptr) as cst_val ptr

end extern
