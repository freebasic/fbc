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

#include once "crt/stdlib.bi"

#define _CST_VAL_DEFS_H__
#macro CST_VAL_USER_TYPE_DCLS(NAME, TYPE)
	extern "C"
		extern cst_val_type_##NAME as const long
		declare function val_##NAME(byval v as const cst_val ptr) as TYPE ptr
		declare function NAME##_val(byval v as const TYPE ptr) as cst_val ptr
	end extern
#endmacro
#macro CST_VAL_USER_FUNCPTR_DCLS(NAME, TYPE)
	extern "C"
		extern cst_val_type_##NAME as const long
		declare function val_##NAME(byval v as const cst_val ptr) as TYPE
		declare function NAME##_val(byval v as const TYPE) as cst_val ptr
	end extern
#endmacro
#macro CST_VAL_REGISTER_TYPE(NAME, TYPE)
	extern "C"
		function val_##NAME(byval v as const cst_val ptr) as TYPE ptr
			return cptr(TYPE ptr, val_generic(v, cst_val_type_##NAME, #NAME))
		end function
		sub val_delete_##NAME(byval v as any ptr)
			delete_##NAME(cptr(TYPE ptr, v))
		end sub
		function NAME##_val(byval v as const TYPE ptr) as cst_val ptr
			return val_new_typed(cst_val_type_##NAME, cptr(any ptr, v))
		end function
	end extern
#endmacro
#macro CST_VAL_REG_TD_TYPE(NAME, TYPE, NUM)
	extern "C"
		extern cst_val_type_##NAME as const long
		const cst_val_type_##NAME as long = NUM
		declare sub val_delete_##NAME(byval v as any ptr)
	end extern
#endmacro
#macro CST_VAL_REGISTER_TYPE_NODEL(NAME, TYPE)
	extern "C"
		function val_##NAME(byval v as const cst_val ptr) as TYPE ptr
			return cptr(TYPE ptr, val_generic(v, cst_val_type_##NAME, #NAME))
		end function
		function NAME##_val(byval v as const TYPE ptr) as cst_val ptr
			return val_new_typed(cst_val_type_##NAME, cptr(any ptr, v))
		end function
	end extern
#endmacro
#macro CST_VAL_REG_TD_TYPE_NODEL(NAME, TYPE, NUM)
	extern "C"
		extern cst_val_type_##NAME as const long
		const cst_val_type_##NAME as long = NUM
		sub val_delete_##NAME(byval v as any ptr)
		end sub
	end extern
#endmacro
#macro CST_VAL_REGISTER_FUNCPTR(NAME, TYPE)
	extern "C"
		function val_##NAME(byval v as const cst_val ptr) as TYPE
			return cast(TYPE, val_generic(v, cst_val_type_##NAME, #NAME))
		end function
		function NAME##_val(byval v as const TYPE) as cst_val ptr
			return val_new_typed(cst_val_type_##NAME, cptr(any ptr, v))
		end function
	end extern
#endmacro
#macro CST_VAL_REG_TD_FUNCPTR(NAME, TYPE, NUM)
	extern "C"
		extern cst_val_type_##NAME as const long
		const cst_val_type_##NAME as long = NUM
		sub val_delete_##NAME(byval v as any ptr)
		end sub
	end extern
#endmacro
