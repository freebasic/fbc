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

#include once "cst_alloc.bi"
#include once "cst_val.bi"
#include once "cst_string.bi"

extern "C"

#define _CST_FEATURES_H__

type cst_featvalpair_struct
	name as const zstring ptr
	val as cst_val ptr
	next as cst_featvalpair_struct ptr
end type

type cst_featvalpair as cst_featvalpair_struct

type cst_features_struct
	head as cst_featvalpair_struct ptr
	ctx as cst_alloc_context
	owned_strings as cst_val ptr
	linked as const cst_features_struct ptr
end type

type cst_features as cst_features_struct
declare function new_features() as cst_features ptr
declare function new_features_local(byval ctx as cst_alloc_context) as cst_features ptr
declare sub delete_features(byval f as cst_features ptr)
declare function feat_int(byval f as const cst_features ptr, byval name as const zstring ptr) as long
declare function feat_float(byval f as const cst_features ptr, byval name as const zstring ptr) as single
declare function feat_string(byval f as const cst_features ptr, byval name as const zstring ptr) as const zstring ptr
declare function feat_val(byval f as const cst_features ptr, byval name as const zstring ptr) as const cst_val ptr
declare function get_param_int(byval f as const cst_features ptr, byval name as const zstring ptr, byval def as long) as long
declare function get_param_float(byval f as const cst_features ptr, byval name as const zstring ptr, byval def as single) as single
declare function get_param_string(byval f as const cst_features ptr, byval name as const zstring ptr, byval def as const zstring ptr) as const zstring ptr
declare function get_param_val(byval f as const cst_features ptr, byval name as const zstring ptr, byval def as cst_val ptr) as const cst_val ptr
declare sub feat_set_int(byval f as cst_features ptr, byval name as const zstring ptr, byval v as long)
declare sub feat_set_float(byval f as cst_features ptr, byval name as const zstring ptr, byval v as single)
declare sub feat_set_string(byval f as cst_features ptr, byval name as const zstring ptr, byval v as const zstring ptr)
declare sub feat_set(byval f as cst_features ptr, byval name as const zstring ptr, byval v as const cst_val ptr)
declare function feat_remove(byval f as cst_features ptr, byval name as const zstring ptr) as long
declare function feat_present(byval f as const cst_features ptr, byval name as const zstring ptr) as long
declare function feat_length(byval f as const cst_features ptr) as long
declare function feat_own_string(byval f as cst_features ptr, byval name as const zstring ptr) as const zstring ptr
extern cst_val_type_features as const long
declare function val_features(byval v as const cst_val ptr) as cst_features ptr
declare function features_val(byval v as const cst_features ptr) as cst_val ptr
declare function feat_copy_into(byval from as const cst_features ptr, byval to as cst_features ptr) as long
declare function feat_link_into(byval from as const cst_features ptr, byval to as cst_features ptr) as long
declare function cst_feat_print(byval fd as cst_file, byval f as const cst_features ptr) as long

end extern
