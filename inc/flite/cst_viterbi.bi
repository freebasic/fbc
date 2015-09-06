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
#include once "cst_math.bi"
#include once "cst_utterance.bi"

extern "C"

#define _CST_VITERBI_H__

type cst_vit_cand_struct
	score as long
	val as cst_val ptr
	ival as long
	pos as long
	item as cst_item ptr
	next as cst_vit_cand_struct ptr
end type

type cst_vit_cand as cst_vit_cand_struct
declare function new_vit_cand() as cst_vit_cand ptr
declare sub vit_cand_set(byval vc as cst_vit_cand ptr, byval val as cst_val ptr)
declare sub vit_cand_set_int(byval vc as cst_vit_cand ptr, byval ival as long)
declare sub delete_vit_cand(byval vc as cst_vit_cand ptr)

type cst_vit_path_struct
	score as long
	state as long
	cand as cst_vit_cand ptr
	f as cst_features ptr
	from as cst_vit_path_struct ptr
	next as cst_vit_path_struct ptr
end type

type cst_vit_path as cst_vit_path_struct
declare function new_vit_path() as cst_vit_path ptr
declare sub delete_vit_path(byval vp as cst_vit_path ptr)

type cst_vit_point_struct
	item as cst_item ptr
	num_states as long
	num_paths as long
	cands as cst_vit_cand ptr
	paths as cst_vit_path ptr
	state_paths as cst_vit_path ptr ptr
	next as cst_vit_point_struct ptr
end type

type cst_vit_point as cst_vit_point_struct
declare function new_vit_point() as cst_vit_point ptr
declare sub delete_vit_point(byval vp as cst_vit_point ptr)

type cst_viterbi_struct
	num_states as long
	cand_func as function(byval s as cst_item ptr, byval vd as cst_viterbi_struct ptr) as cst_vit_cand ptr
	path_func as function(byval p as cst_vit_path ptr, byval c as cst_vit_cand ptr, byval vd as cst_viterbi_struct ptr) as cst_vit_path ptr
	big_is_good as long
	timeline as cst_vit_point ptr
	last_point as cst_vit_point ptr
	f as cst_features ptr
end type

type cst_viterbi as cst_viterbi_struct
declare function new_viterbi(byval cand_func as function(byval s as cst_item ptr, byval vd as cst_viterbi_struct ptr) as cst_vit_cand ptr, byval path_func as function(byval p as cst_vit_path ptr, byval c as cst_vit_cand ptr, byval vd as cst_viterbi_struct ptr) as cst_vit_path ptr) as cst_viterbi ptr
declare sub delete_viterbi(byval vd as cst_viterbi ptr)
declare sub viterbi_initialise(byval vd as cst_viterbi ptr, byval r as cst_relation ptr)
declare sub viterbi_decode(byval vd as cst_viterbi ptr)
declare function viterbi_result(byval vd as cst_viterbi ptr, byval n as const zstring ptr) as long
declare sub viterbi_copy_feature(byval vd as cst_viterbi ptr, byval featname as const zstring ptr)

end extern
