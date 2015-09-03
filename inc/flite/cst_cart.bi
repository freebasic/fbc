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

extern "C"

#define _CST_CART_H__
const CST_CART_OP_NONE = 255
const CST_CART_OP_LEAF = 255
const CST_CART_OP_IS = 0
const CST_CART_OP_IN = 1
const CST_CART_OP_LESS = 2
const CST_CART_OP_GREATER = 3
const CST_CART_OP_MATCHES = 4
const CST_CART_OP_EQUALS = 5

type cst_cart_node_struct
	feat as ubyte
	op as ubyte
	no_node as ushort
	val as const cst_val ptr
end type

type cst_cart_node as cst_cart_node_struct

type cst_cart_struct
	rule_table as const cst_cart_node ptr
	feat_table as const zstring const ptr ptr
end type

type cst_cart as cst_cart_struct
declare sub delete_cart(byval c as cst_cart ptr)
extern cst_val_type_cart as const long
declare function val_cart(byval v as const cst_val ptr) as cst_cart ptr
declare function cart_val(byval v as const cst_cart ptr) as cst_val ptr
declare function cart_interpret(byval item as cst_item ptr, byval tree as const cst_cart ptr) as const cst_val ptr

end extern
