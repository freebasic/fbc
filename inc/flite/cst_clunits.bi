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

#include once "cst_wave.bi"
#include once "cst_cart.bi"
#include once "cst_viterbi.bi"
#include once "cst_track.bi"
#include once "cst_sts.bi"

extern "C"

#define _CST_CLUNITS_H__
const CLUNIT_NONE = cushort(65535)

type cst_clunit_struct
	as ushort type
	phone as ushort
	start as long
	as long end
	prev as long
	next as long
end type

type cst_clunit as cst_clunit_struct

type cst_clunit_type_struct
	name as const zstring ptr
	start as long
	count as long
end type

type cst_clunit_type as cst_clunit_type_struct

type cst_clunit_db_struct
	name as const zstring ptr
	types as const cst_clunit_type ptr
	trees as const cst_cart const ptr ptr
	units as const cst_clunit ptr
	num_types as long
	num_units as long
	sts as cst_sts_list ptr
	mcep as cst_sts_list ptr
	join_weights as const long ptr
	optimal_coupling as long
	extend_selections as long
	f0_weight as long
	unit_name_func as function(byval s as cst_item ptr) as zstring ptr
end type

type cst_clunit_db as cst_clunit_db_struct
extern cst_val_type_clunit_db as const long
declare function val_clunit_db(byval v as const cst_val ptr) as cst_clunit_db ptr
declare function clunit_db_val(byval v as const cst_clunit_db ptr) as cst_val ptr
extern cst_val_type_vit_cand as const long
declare function val_vit_cand(byval v as const cst_val ptr) as cst_vit_cand ptr
declare function vit_cand_val(byval v as const cst_vit_cand ptr) as cst_val ptr
declare function clunits_synth(byval utt as cst_utterance ptr) as cst_utterance ptr
declare function clunits_dump_units(byval utt as cst_utterance ptr) as cst_utterance ptr
declare function clunits_ldom_phone_word(byval s as cst_item ptr) as zstring ptr
declare function clunit_get_unit_index(byval cludb as cst_clunit_db ptr, byval unit_type as const zstring ptr, byval instance as long) as long
declare function clunit_get_unit_index_name(byval cludb as cst_clunit_db ptr, byval name as const zstring ptr) as long
declare function clunit_get_unit_type_index(byval cludb as cst_clunit_db ptr, byval name as const zstring ptr) as long
#define UNIT_TYPE(db, u) (db)->types[(db)->units[(u)].type].name
#define UNIT_INDEX(db, u) ((u) - (db)->types[(db)->units[(u)].type].start)

end extern
