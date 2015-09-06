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

#include once "cst_item.bi"
#include once "cst_lts.bi"

extern "C"

#define _CST_LEXICON_H__

type lexicon_struct
	name as zstring ptr
	num_entries as long
	data as ubyte ptr
	num_bytes as long
	phone_table as zstring ptr ptr
	lts_rule_set as cst_lts_rules ptr
	syl_boundary as function(byval i as const cst_item ptr, byval p as const cst_val ptr) as long
	lts_function as function(byval l as const lexicon_struct ptr, byval word as const zstring ptr, byval pos as const zstring ptr, byval feats as const cst_features ptr) as cst_val ptr
	addenda as zstring ptr ptr ptr
	phone_hufftable as const zstring const ptr ptr
	entry_hufftable as const zstring const ptr ptr
	postlex as function(byval u as cst_utterance ptr) as cst_utterance ptr
	lex_addenda as cst_val ptr
end type

type cst_lexicon as lexicon_struct
declare function new_lexicon() as cst_lexicon ptr
declare sub delete_lexicon(byval lex as cst_lexicon ptr)
declare function cst_lex_make_entry(byval lex as const cst_lexicon ptr, byval entry as const cst_string ptr) as cst_val ptr
declare function cst_lex_load_addenda(byval lex as const cst_lexicon ptr, byval lexfile as const zstring ptr) as cst_val ptr
declare function lex_lookup(byval l as const cst_lexicon ptr, byval word as const zstring ptr, byval pos as const zstring ptr, byval feats as const cst_features ptr) as cst_val ptr
declare function in_lex(byval l as const cst_lexicon ptr, byval word as const zstring ptr, byval pos as const zstring ptr, byval feats as const cst_features ptr) as long
extern cst_val_type_lexicon as const long
declare function val_lexicon(byval v as const cst_val ptr) as cst_lexicon ptr
declare function lexicon_val(byval v as const cst_lexicon ptr) as cst_val ptr

end extern
