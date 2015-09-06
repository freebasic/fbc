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

#include once "cst_cart.bi"
#include once "cst_track.bi"
#include once "cst_wave.bi"
#include once "cst_audio.bi"
#include once "cst_synth.bi"

extern "C"

#define _CST_CG_H__

type cst_cg_db_struct
	name as const zstring ptr
	types as const zstring const ptr ptr
	num_types as long
	sample_rate as long
	f0_mean as single
	f0_stddev as single
	f0_trees as const cst_cart const ptr ptr
	num_param_models as long
	param_trees as const cst_cart ptr ptr ptr
	spamf0_accent_tree as const cst_cart ptr
	spamf0_phrase_tree as const cst_cart ptr
	num_channels as long ptr
	num_frames as long ptr
	model_vectors as const ushort ptr ptr ptr
	num_channels_spamf0_accent as long
	num_frames_spamf0_accent as long
	spamf0_accent_vectors as const single const ptr ptr
	model_min as const single ptr
	model_range as const single ptr
	frame_advance as single
	num_dur_models as long
	dur_stats as const dur_stat ptr ptr ptr
	dur_cart as const cst_cart ptr ptr
	phone_states as const zstring const ptr const ptr ptr
	do_mlpg as long
	dynwin as single ptr
	dynwinsize as long
	mlsa_alpha as single
	mlsa_beta as single
	multimodel as long
	mixed_excitation as long
	ME_num as long
	ME_order as long
	me_h as const double const ptr ptr
	spamf0 as long
	gain as single
	freeable as long
end type

type cst_cg_db as cst_cg_db_struct
#define CG_MODEL_VECTOR(M, N, X, Y) (M->model_min[Y] + ((csng(M->N[X][Y]) / 65535.0) * M->model_range[Y]))
extern cst_val_type_cg_db as const long
declare function val_cg_db(byval v as const cst_val ptr) as cst_cg_db ptr
declare function cg_db_val(byval v as const cst_cg_db ptr) as cst_val ptr
declare sub delete_cg_db(byval db as cst_cg_db ptr)
declare function cg_synth(byval utt as cst_utterance ptr) as cst_utterance ptr
declare function mlsa_resynthesis(byval t as const cst_track ptr, byval str as const cst_track ptr, byval cg_db as cst_cg_db ptr, byval asc as cst_audio_streaming_info ptr) as cst_wave ptr
declare function mlpg(byval param_track as const cst_track ptr, byval cg_db as cst_cg_db ptr) as cst_track ptr
declare function cst_cg_load_voice(byval voxdir as const zstring ptr, byval lang_table as const cst_lang ptr) as cst_voice ptr
declare function cst_cg_dump_voice(byval v as const cst_voice ptr, byval filename as const cst_string ptr) as long

end extern
