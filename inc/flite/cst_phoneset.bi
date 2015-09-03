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
#include once "cst_val.bi"
#include once "cst_features.bi"
#include once "cst_item.bi"

extern "C"

#define _CST_PHONESET_H__

type cst_phoneset_struct
	name as const zstring ptr
	featnames as const zstring const ptr ptr
	featvals as const cst_val const ptr ptr
	phonenames as const zstring const ptr ptr
	silence as const zstring ptr
	num_phones as const long
	fvtable as const long const ptr ptr
	freeable as long
end type

type cst_phoneset as cst_phoneset_struct
declare function new_phoneset() as cst_phoneset ptr
declare sub delete_phoneset(byval u as const cst_phoneset ptr)
declare function phone_feature(byval ps as const cst_phoneset ptr, byval phonename as const zstring ptr, byval featname as const zstring ptr) as const cst_val ptr
declare function phone_feature_string(byval ps as const cst_phoneset ptr, byval phonename as const zstring ptr, byval featname as const zstring ptr) as const zstring ptr
declare function phone_id(byval ps as const cst_phoneset ptr, byval phonename as const zstring ptr) as long
declare function phone_feat_id(byval ps as const cst_phoneset ptr, byval featname as const zstring ptr) as long
declare function item_phoneset(byval i as const cst_item ptr) as const cst_phoneset ptr
extern cst_val_type_phoneset as const long
declare function val_phoneset(byval v as const cst_val ptr) as cst_phoneset ptr
declare function phoneset_val(byval v as const cst_phoneset ptr) as cst_val ptr

end extern
