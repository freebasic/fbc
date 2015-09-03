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
#include once "cst_item.bi"

extern "C"

#define _CST_FFEATURES_H
declare function ph_vc(byval p as const cst_item ptr) as const cst_val ptr
declare function ph_vlng(byval p as const cst_item ptr) as const cst_val ptr
declare function ph_vheight(byval p as const cst_item ptr) as const cst_val ptr
declare function ph_vrnd(byval p as const cst_item ptr) as const cst_val ptr
declare function ph_vfront(byval p as const cst_item ptr) as const cst_val ptr
declare function ph_ctype(byval p as const cst_item ptr) as const cst_val ptr
declare function ph_cplace(byval p as const cst_item ptr) as const cst_val ptr
declare function ph_cvox(byval p as const cst_item ptr) as const cst_val ptr
declare function cg_duration(byval p as const cst_item ptr) as const cst_val ptr
declare function cg_state_pos(byval p as const cst_item ptr) as const cst_val ptr
declare function cg_state_place(byval p as const cst_item ptr) as const cst_val ptr
declare function cg_state_index(byval p as const cst_item ptr) as const cst_val ptr
declare function cg_state_rindex(byval p as const cst_item ptr) as const cst_val ptr
declare function cg_phone_place(byval p as const cst_item ptr) as const cst_val ptr
declare function cg_phone_index(byval p as const cst_item ptr) as const cst_val ptr
declare function cg_phone_rindex(byval p as const cst_item ptr) as const cst_val ptr
declare sub basic_ff_register(byval ffunctions as cst_features ptr)

end extern
