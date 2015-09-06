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
#include once "cst_features.bi"

extern "C"

#define _CST_ITEM_H__
type cst_relation as cst_relation_struct
type cst_utterance as cst_utterance_struct
type cst_item as cst_item_struct
extern cst_val_type_relation as const long
declare function val_relation(byval v as const cst_val ptr) as cst_relation ptr
declare function relation_val(byval v as const cst_relation ptr) as cst_val ptr
extern cst_val_type_item as const long
declare function val_item(byval v as const cst_val ptr) as cst_item ptr
declare function item_val(byval v as const cst_item ptr) as cst_val ptr
extern cst_val_type_utterance as const long
declare function val_utterance(byval v as const cst_val ptr) as cst_utterance ptr
declare function utterance_val(byval v as const cst_utterance ptr) as cst_val ptr

type cst_item_contents_struct
	features as cst_features ptr
	relations as cst_features ptr
end type

type cst_item_contents as cst_item_contents_struct

type cst_item_struct
	contents as cst_item_contents ptr
	relation as cst_relation ptr
	n as cst_item ptr
	p as cst_item ptr
	u as cst_item ptr
	d as cst_item ptr
end type

declare function new_item_relation(byval r as cst_relation ptr, byval i as cst_item ptr) as cst_item ptr
declare function new_item_contents(byval i as cst_item ptr) as cst_item_contents ptr
declare sub delete_item(byval item as cst_item ptr)
declare sub item_contents_set(byval current as cst_item ptr, byval i as cst_item ptr)
declare sub item_unref_contents(byval i as cst_item ptr)
declare function item_as(byval i as const cst_item ptr, byval rname as const zstring ptr) as cst_item ptr
declare function item_utt(byval i as const cst_item ptr) as cst_utterance ptr
declare function item_next(byval i as const cst_item ptr) as cst_item ptr
declare function item_prev(byval i as const cst_item ptr) as cst_item ptr
declare function item_append(byval i as cst_item ptr, byval new_item as cst_item ptr) as cst_item ptr
declare function item_prepend(byval i as cst_item ptr, byval new_item as cst_item ptr) as cst_item ptr
declare function item_parent(byval i as const cst_item ptr) as cst_item ptr
declare function item_nth_daughter(byval i as const cst_item ptr, byval n as long) as cst_item ptr
declare function item_daughter(byval i as const cst_item ptr) as cst_item ptr
declare function item_last_daughter(byval i as const cst_item ptr) as cst_item ptr
declare function item_add_daughter(byval i as cst_item ptr, byval new_item as cst_item ptr) as cst_item ptr
declare function item_append_sibling(byval i as cst_item ptr, byval new_item as cst_item ptr) as cst_item ptr
declare function item_prepend_sibling(byval i as cst_item ptr, byval new_item as cst_item ptr) as cst_item ptr
declare function item_feat_present(byval i as const cst_item ptr, byval name as const zstring ptr) as long
declare function item_feat_remove(byval i as const cst_item ptr, byval name as const zstring ptr) as long
declare function item_feats(byval i as const cst_item ptr) as cst_features ptr
declare function item_feat(byval i as const cst_item ptr, byval name as const zstring ptr) as const cst_val ptr
declare function item_feat_int(byval i as const cst_item ptr, byval name as const zstring ptr) as long
declare function item_feat_float(byval i as const cst_item ptr, byval name as const zstring ptr) as single
declare function item_feat_string(byval i as const cst_item ptr, byval name as const zstring ptr) as const zstring ptr
declare sub item_set(byval i as const cst_item ptr, byval name as const zstring ptr, byval val as const cst_val ptr)
declare sub item_set_int(byval i as const cst_item ptr, byval name as const zstring ptr, byval val as long)
declare sub item_set_float(byval i as const cst_item ptr, byval name as const zstring ptr, byval val as single)
declare sub item_set_string(byval i as const cst_item ptr, byval name as const zstring ptr, byval val as const zstring ptr)
#define item_name(I) item_feat_string(I, "name")
declare function item_equal(byval a as const cst_item ptr, byval b as const cst_item ptr) as long
declare function ffeature_string(byval item as const cst_item ptr, byval featpath as const zstring ptr) as const zstring ptr
declare function ffeature_int(byval item as const cst_item ptr, byval featpath as const zstring ptr) as long
declare function ffeature_float(byval item as const cst_item ptr, byval featpath as const zstring ptr) as single
declare function ffeature(byval item as const cst_item ptr, byval featpath as const zstring ptr) as const cst_val ptr
declare function path_to_item(byval item as const cst_item ptr, byval featpath as const zstring ptr) as cst_item ptr
type cst_ffunction as function(byval i as const cst_item ptr) as const cst_val ptr
extern cst_val_type_ffunc as const long
declare function val_ffunc(byval v as const cst_val ptr) as cst_ffunction
declare function ffunc_val(byval v as const cst_ffunction) as cst_val ptr
declare sub ff_register(byval ffeatures as cst_features ptr, byval name as const zstring ptr, byval f as cst_ffunction)
declare sub ff_unregister(byval ffeatures as cst_features ptr, byval name as const zstring ptr)
type cst_itemfunc as function(byval i as cst_item ptr) as cst_val ptr
extern cst_val_type_itemfunc as const long
declare function val_itemfunc(byval v as const cst_val ptr) as cst_itemfunc
declare function itemfunc_val(byval v as const cst_itemfunc) as cst_val ptr

end extern
