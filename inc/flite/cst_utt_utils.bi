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

#include once "cst_hrg.bi"
#include once "cst_wave.bi"

extern "C"

#define _UTT_UTILS_H__
declare function utt_set_wave(byval u as cst_utterance ptr, byval w as cst_wave ptr) as long
declare function utt_wave(byval u as cst_utterance ptr) as cst_wave ptr
declare function utt_input_text(byval u as cst_utterance ptr) as const zstring ptr
declare function utt_set_input_text(byval u as cst_utterance ptr, byval text as const zstring ptr) as long

#define utt_feat_string(U, F) feat_string((U)->features, F)
#define utt_feat_int(U, F) feat_int((U)->features, F)
#define utt_feat_float(U, F) feat_float((U)->features, F)
#define utt_feat_val(U, F) feat_val((U)->features, F)
#define utt_set_feat_string(U, F, V) feat_set_string((U)->features, F, V)
#define utt_set_feat_int(U, F, V) feat_set_int((U)->features, F, V)
#define utt_set_feat_float(U, F, V) feat_set_float((U)->features, F, V)
#define utt_set_feat(U, F, V) feat_set((U)->features, F, V)
#define utt_rel_head(U, R) relation_head(utt_relation((U), R))

end extern
