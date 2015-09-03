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

#include once "cst_val.bi"

extern "C"

#define _CST_LTS_H__
type cst_lts_addr as ushort
type cst_lts_phone as long
type cst_lts_feat as ubyte
type cst_lts_letter as ubyte
type cst_lts_model as ubyte
const CST_LTS_EOR = 255

type cst_lts_rules_struct
	name as zstring ptr
	letter_index as const cst_lts_addr ptr
	models as const cst_lts_model ptr
	phone_table as const zstring const ptr ptr
	context_window_size as long
	context_extra_feats as long
	letter_table as const zstring const ptr ptr
end type

type cst_lts_rules as cst_lts_rules_struct

type cst_lts_rule_struct
	feat as cst_lts_feat
	val as cst_lts_letter
	qtrue as cst_lts_addr
	qfalse as cst_lts_addr
end type

type cst_lts_rule as cst_lts_rule_struct
declare function new_lts_rules() as cst_lts_rules ptr
declare function lts_apply(byval word as const zstring ptr, byval feats as const zstring ptr, byval r as const cst_lts_rules ptr) as cst_val ptr
declare function lts_apply_val(byval wlist as const cst_val ptr, byval feats as const zstring ptr, byval r as const cst_lts_rules ptr) as cst_val ptr

end extern
