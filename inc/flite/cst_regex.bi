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
#include once "cst_string.bi"

extern "C"

#define _CST_REGEX_H__
const CST_REGMAGIC = &o234

type cst_regex_struct
	regstart as byte
	reganch as byte
	regmust as zstring ptr
	regmlen as long
	regsize as long
	program as zstring ptr
end type

type cst_regex as cst_regex_struct
const CST_NSUBEXP = 10

type cst_regstate_struct
	startp(0 to 9) as const zstring ptr
	endp(0 to 9) as const zstring ptr
	input as const zstring ptr
	bol as const zstring ptr
end type

type cst_regstate as cst_regstate_struct
declare function new_cst_regex(byval str as const zstring ptr) as cst_regex ptr
declare sub delete_cst_regex(byval r as cst_regex ptr)
declare function cst_regex_match(byval r as const cst_regex ptr, byval str as const zstring ptr) as long
declare function cst_regex_match_return(byval r as const cst_regex ptr, byval str as const zstring ptr) as cst_regstate ptr
declare function hs_regcomp(byval as const zstring ptr) as cst_regex ptr
declare function hs_regexec(byval as const cst_regex ptr, byval as const zstring ptr) as cst_regstate ptr
declare sub hs_regdelete(byval as cst_regex ptr)
declare function cst_regsub(byval r as const cst_regstate ptr, byval in as const zstring ptr, byval out as zstring ptr, byval max as uinteger) as uinteger
declare sub cst_regex_init()

extern cst_rx_white as const cst_regex const ptr
extern cst_rx_alpha as const cst_regex const ptr
extern cst_rx_uppercase as const cst_regex const ptr
extern cst_rx_lowercase as const cst_regex const ptr
extern cst_rx_alphanum as const cst_regex const ptr
extern cst_rx_identifier as const cst_regex const ptr
extern cst_rx_int as const cst_regex const ptr
extern cst_rx_double as const cst_regex const ptr
extern cst_rx_commaint as const cst_regex const ptr
extern cst_rx_digits as const cst_regex const ptr
extern cst_rx_dotted_abbrev as const cst_regex const ptr
extern cst_regex_table(0 to 1 - 1) as const cst_regex const ptr
const CST_RX_dotted_abbrev_NUM = 0

end extern
