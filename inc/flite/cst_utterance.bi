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
#include once "cst_relation.bi"
#include once "cst_alloc.bi"

extern "C"

#define _CST_UTTERANCE_H__

type cst_utterance_struct
	features as cst_features ptr
	ffunctions as cst_features ptr
	relations as cst_features ptr
	ctx as cst_alloc_context
end type

declare function new_utterance() as cst_utterance ptr
declare sub delete_utterance(byval u as cst_utterance ptr)
declare function utt_relation(byval u as const cst_utterance ptr, byval name as const zstring ptr) as cst_relation ptr
declare function utt_relation_create(byval u as cst_utterance ptr, byval name as const zstring ptr) as cst_relation ptr
declare function utt_relation_delete(byval u as cst_utterance ptr, byval name as const zstring ptr) as long
declare function utt_relation_present(byval u as cst_utterance ptr, byval name as const zstring ptr) as long
type cst_uttfunc as function(byval i as cst_utterance ptr) as cst_utterance ptr
extern cst_val_type_uttfunc as const long
declare function val_uttfunc(byval v as const cst_val ptr) as cst_uttfunc
declare function uttfunc_val(byval v as const cst_uttfunc) as cst_val ptr
#define cst_utt_alloc(UTT, TYPE, SIZE) cptr(TYPE ptr, cst_local_alloc((UTT)->ctx, sizeof(TYPE) * (SIZE)))
#define cst_utt_free(UTT, PTR) cst_local_free((UTT)->ctx, (PTR))

end extern
