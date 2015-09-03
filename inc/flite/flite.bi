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

#include once "cst_string.bi"
#include once "cst_regex.bi"
#include once "cst_val.bi"
#include once "cst_features.bi"
#include once "cst_item.bi"
#include once "cst_relation.bi"
#include once "cst_utterance.bi"
#include once "cst_wave.bi"
#include once "cst_track.bi"
#include once "cst_cart.bi"
#include once "cst_phoneset.bi"
#include once "cst_voice.bi"
#include once "cst_audio.bi"
#include once "cst_utt_utils.bi"
#include once "cst_lexicon.bi"
#include once "cst_synth.bi"
#include once "cst_units.bi"
#include once "cst_tokenstream.bi"

extern "C"

#define _FLITE_H__
extern flite_voice_list as cst_val ptr
extern flite_lang_list(0 to 19) as cst_lang
declare function flite_init() as long
declare function flite_voice_select(byval name as const zstring ptr) as cst_voice ptr
declare function flite_voice_load(byval voice_filename as const zstring ptr) as cst_voice ptr
declare function flite_voice_dump(byval voice as cst_voice ptr, byval voice_filename as const zstring ptr) as long
declare function flite_file_to_speech(byval filename as const zstring ptr, byval voice as cst_voice ptr, byval outtype as const zstring ptr) as single
declare function flite_text_to_speech(byval text as const zstring ptr, byval voice as cst_voice ptr, byval outtype as const zstring ptr) as single
declare function flite_phones_to_speech(byval text as const zstring ptr, byval voice as cst_voice ptr, byval outtype as const zstring ptr) as single
declare function flite_ssml_file_to_speech(byval filename as const zstring ptr, byval voice as cst_voice ptr, byval outtype as const zstring ptr) as single
declare function flite_ssml_text_to_speech(byval text as const zstring ptr, byval voice as cst_voice ptr, byval outtype as const zstring ptr) as single
declare function flite_voice_add_lex_addenda(byval v as cst_voice ptr, byval lexfile as const cst_string ptr) as long
declare function flite_text_to_wave(byval text as const zstring ptr, byval voice as cst_voice ptr) as cst_wave ptr
declare function flite_synth_text(byval text as const zstring ptr, byval voice as cst_voice ptr) as cst_utterance ptr
declare function flite_synth_phones(byval phones as const zstring ptr, byval voice as cst_voice ptr) as cst_utterance ptr
declare function flite_ts_to_speech(byval ts as cst_tokenstream ptr, byval voice as cst_voice ptr, byval outtype as const zstring ptr) as single
declare function flite_do_synth(byval u as cst_utterance ptr, byval voice as cst_voice ptr, byval synth as cst_uttfunc) as cst_utterance ptr
declare function flite_process_output(byval u as cst_utterance ptr, byval outtype as const zstring ptr, byval append as long) as single
declare function flite_mmap_clunit_voxdata(byval voxdir as const zstring ptr, byval voice as cst_voice ptr) as long
declare function flite_munmap_clunit_voxdata(byval voice as cst_voice ptr) as long
declare function flite_get_param_int(byval f as const cst_features ptr, byval name as const zstring ptr, byval def as long) as long
declare function flite_get_param_float(byval f as const cst_features ptr, byval name as const zstring ptr, byval def as single) as single
declare function flite_get_param_string(byval f as const cst_features ptr, byval name as const zstring ptr, byval def as const zstring ptr) as const zstring ptr
declare function flite_get_param_val(byval f as const cst_features ptr, byval name as const zstring ptr, byval def as cst_val ptr) as const cst_val ptr
declare sub flite_feat_set_int(byval f as cst_features ptr, byval name as const zstring ptr, byval v as long)
declare sub flite_feat_set_float(byval f as cst_features ptr, byval name as const zstring ptr, byval v as single)
declare sub flite_feat_set_string(byval f as cst_features ptr, byval name as const zstring ptr, byval v as const zstring ptr)
declare sub flite_feat_set(byval f as cst_features ptr, byval name as const zstring ptr, byval v as const cst_val ptr)
declare function flite_feat_remove(byval f as cst_features ptr, byval name as const zstring ptr) as long
declare function flite_ffeature_string(byval item as const cst_item ptr, byval featpath as const zstring ptr) as const zstring ptr
declare function flite_ffeature_int(byval item as const cst_item ptr, byval featpath as const zstring ptr) as long
declare function flite_ffeature_float(byval item as const cst_item ptr, byval featpath as const zstring ptr) as single
declare function flite_ffeature(byval item as const cst_item ptr, byval featpath as const zstring ptr) as const cst_val ptr
declare function flite_path_to_item(byval item as const cst_item ptr, byval featpath as const zstring ptr) as cst_item ptr
declare function flite_add_voice(byval voice as cst_voice ptr) as long
declare function flite_add_lang(byval langname as const zstring ptr, byval lang_init as sub(byval vox as cst_voice ptr), byval lex_init as function() as cst_lexicon ptr) as long
declare sub utf8_grapheme_lang_init(byval v as cst_voice ptr)
declare function utf8_grapheme_lex_init() as cst_lexicon ptr

end extern
