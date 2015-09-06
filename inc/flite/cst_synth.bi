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
#include once "cst_tokenstream.bi"
#include once "cst_voice.bi"
#include once "cst_wave.bi"

extern "C"

#define _SYNTH_H__
type cst_breakfunc as function(byval ts as cst_tokenstream ptr, byval token as const zstring ptr, byval tokens as cst_relation ptr) as long
extern cst_val_type_breakfunc as const long
declare function val_breakfunc(byval v as const cst_val ptr) as cst_breakfunc
declare function breakfunc_val(byval v as const cst_breakfunc) as cst_val ptr
declare function default_utt_break(byval ts as cst_tokenstream ptr, byval token as const zstring ptr, byval tokens as cst_relation ptr) as long
declare function utt_init(byval u as cst_utterance ptr, byval vox as cst_voice ptr) as cst_utterance ptr
declare function utt_synth(byval u as cst_utterance ptr) as cst_utterance ptr
declare function utt_synth_phones(byval u as cst_utterance ptr) as cst_utterance ptr
declare function utt_synth_tokens(byval u as cst_utterance ptr) as cst_utterance ptr
declare function utt_synth_wave(byval w as cst_wave ptr, byval v as cst_voice ptr) as cst_utterance ptr

type cst_dur_stats_struct
	phone as zstring ptr
	mean as single
	stddev as single
end type

type dur_stat as cst_dur_stats_struct
type dur_stats as dur_stat ptr
extern cst_val_type_dur_stats as const long
declare function val_dur_stats(byval v as const cst_val ptr) as dur_stats ptr
declare function dur_stats_val(byval v as const dur_stats ptr) as cst_val ptr
declare function default_segmentanalysis(byval u as cst_utterance ptr) as cst_utterance ptr
declare function default_tokenization(byval u as cst_utterance ptr) as cst_utterance ptr
declare function default_textanalysis(byval u as cst_utterance ptr) as cst_utterance ptr
declare function default_tokentowords(byval i as cst_item ptr) as cst_val ptr
declare function default_phrasing(byval u as cst_utterance ptr) as cst_utterance ptr
declare function default_pos_tagger(byval u as cst_utterance ptr) as cst_utterance ptr
declare function default_lexical_insertion(byval u as cst_utterance ptr) as cst_utterance ptr
declare function default_pause_insertion(byval u as cst_utterance ptr) as cst_utterance ptr
declare function cart_intonation(byval u as cst_utterance ptr) as cst_utterance ptr
declare function cart_duration(byval u as cst_utterance ptr) as cst_utterance ptr
declare function flat_prosody(byval u as cst_utterance ptr) as cst_utterance ptr

type cst_synth_module_struct
	hookname as const zstring ptr
	defhook as cst_uttfunc
end type

type cst_synth_module as cst_synth_module_struct
declare function apply_synth_module(byval u as cst_utterance ptr, byval mod_ as const cst_synth_module ptr) as cst_utterance ptr
declare function apply_synth_method(byval u as cst_utterance ptr, byval meth as const cst_synth_module ptr) as cst_utterance ptr

end extern
