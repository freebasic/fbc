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

#include once "cst_alloc.bi"
#include once "cst_string.bi"
#include once "cst_file.bi"
#include once "cst_features.bi"

extern "C"

#define _CST_TOKENSTREAM_H__

type cst_tokenstream_struct
	fd as cst_file
	file_pos as long
	line_number as long
	eof_flag as long
	string_buffer as cst_string ptr
	current_char as long
	token_pos as long
	ws_max as long
	whitespace as cst_string ptr
	prep_max as long
	prepunctuation as cst_string ptr
	token_max as long
	token as cst_string ptr
	postp_max as long
	postpunctuation as cst_string ptr
	tags as cst_features ptr
	utf8_explode_mode as long
	streamtype_data as any ptr
	p_whitespacesymbols as const cst_string ptr
	p_singlecharsymbols as const cst_string ptr
	p_prepunctuationsymbols as const cst_string ptr
	p_postpunctuationsymbols as const cst_string ptr
	charclass as zstring * 256
	open as function(byval ts as cst_tokenstream_struct ptr, byval filename as const zstring ptr) as long
	close as sub(byval ts as cst_tokenstream_struct ptr)
	eof as function(byval ts as cst_tokenstream_struct ptr) as long
	seek as function(byval ts as cst_tokenstream_struct ptr, byval pos as long) as long
	tell as function(byval ts as cst_tokenstream_struct ptr) as long
	size as function(byval ts as cst_tokenstream_struct ptr) as long
	getc as function(byval ts as cst_tokenstream_struct ptr) as long
end type

type cst_tokenstream as cst_tokenstream_struct
const TS_CHARCLASS_NONE = 0
const TS_CHARCLASS_WHITESPACE = 2
const TS_CHARCLASS_SINGLECHAR = 4
const TS_CHARCLASS_PREPUNCT = 8
const TS_CHARCLASS_POSTPUNCT = 16
const TS_CHARCLASS_QUOTE = 32
#define ts_charclass(C, CLASS, TS) ((TS)->charclass[cubyte(C)] and CLASS)

extern cst_ts_default_whitespacesymbols as const cst_string const ptr
extern cst_ts_default_prepunctuationsymbols as const cst_string const ptr
extern cst_ts_default_postpunctuationsymbols as const cst_string const ptr
extern cst_ts_default_singlecharsymbols as const cst_string const ptr

declare function ts_open(byval filename as const zstring ptr, byval whitespacesymbols as const cst_string ptr, byval singlecharsymbols as const cst_string ptr, byval prepunctsymbols as const cst_string ptr, byval postpunctsymbols as const cst_string ptr) as cst_tokenstream ptr
declare function ts_open_string(byval string as const cst_string ptr, byval whitespacesymbols as const cst_string ptr, byval singlecharsymbols as const cst_string ptr, byval prepunctsymbols as const cst_string ptr, byval postpunctsymbols as const cst_string ptr) as cst_tokenstream ptr
declare function ts_open_generic(byval filename as const zstring ptr, byval whitespacesymbols as const cst_string ptr, byval singlecharsymbols as const cst_string ptr, byval prepunctsymbols as const cst_string ptr, byval postpunctsymbols as const cst_string ptr, byval streamtype_data as any ptr, byval open as function(byval ts as cst_tokenstream ptr, byval filename as const zstring ptr) as long, byval close as sub(byval ts as cst_tokenstream ptr), byval eof as function(byval ts as cst_tokenstream ptr) as long, byval seek as function(byval ts as cst_tokenstream ptr, byval pos as long) as long, byval tell as function(byval ts as cst_tokenstream ptr) as long, byval size as function(byval ts as cst_tokenstream ptr) as long, byval getc as function(byval ts as cst_tokenstream ptr) as long) as cst_tokenstream ptr
declare sub ts_close(byval ts as cst_tokenstream ptr)
declare function ts_eof(byval ts as cst_tokenstream ptr) as long
declare function ts_get(byval ts as cst_tokenstream ptr) as const cst_string ptr
declare function ts_get_quoted_token(byval ts as cst_tokenstream ptr, byval quote as byte, byval escape as byte) as const cst_string ptr
declare function private_ts_getc(byval ts as cst_tokenstream ptr) as byte
declare sub set_charclasses(byval ts as cst_tokenstream ptr, byval whitespace as const cst_string ptr, byval singlecharsymbols as const cst_string ptr, byval prepunctuation as const cst_string ptr, byval postpunctuation as const cst_string ptr)
declare function ts_read(byval buff as any ptr, byval size as long, byval num as long, byval ts as cst_tokenstream ptr) as long
declare function ts_set_stream_pos(byval ts as cst_tokenstream ptr, byval pos as long) as long
declare function ts_get_stream_pos(byval ts as cst_tokenstream ptr) as long
declare function ts_get_stream_size(byval ts as cst_tokenstream ptr) as long

end extern
