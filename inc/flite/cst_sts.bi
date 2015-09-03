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
#include once "cst_audio.bi"

extern "C"

#define _CST_STS_H__

type cst_sts_struct
	frame as const ushort ptr
	size as const long
	residual as const ubyte ptr
end type

type cst_sts as cst_sts_struct

type cst_sts_paged_struct
	frame_offset as const ulong
	res_size as const ushort
	res_offset as const ulong
	frame_page as const ushort ptr
	res_page as const ubyte ptr
end type

type cst_sts_paged as cst_sts_paged_struct

type cst_sts_list_struct
	sts as const cst_sts ptr
	sts_paged as const cst_sts_paged ptr
	frames as const ushort ptr
	residuals as const ubyte ptr
	resoffs as const ulong ptr
	ressizes as const ubyte ptr
	num_sts as long
	num_channels as long
	sample_rate as long
	coeff_min as single
	coeff_range as single
	codec as const zstring ptr
end type

type cst_sts_list as cst_sts_list_struct

type cst_lpcres_struct
	frames as const ushort ptr ptr
	times as long ptr
	num_frames as long
	num_channels as long
	lpc_min as single
	lpc_range as single
	num_samples as long
	sample_rate as long
	sizes as long ptr
	residual as ubyte ptr
	asi as cst_audio_streaming_info ptr
	packed_residuals as const ubyte ptr ptr
	delayed_decoding as long
end type

type cst_lpcres as cst_lpcres_struct
declare function new_lpcres() as cst_lpcres ptr
declare sub delete_lpcres(byval l as cst_lpcres ptr)
declare function lpcres_frame_shift(byval t as cst_lpcres ptr, byval frame as long) as single
declare sub lpcres_resize_frames(byval l as cst_lpcres ptr, byval num_frames as long)
declare sub lpcres_resize_samples(byval l as cst_lpcres ptr, byval num_samples as long)
declare function new_sts_list() as cst_sts_list ptr
declare sub delete_sts_list(byval l as cst_sts_list ptr)
declare function get_sts_frame(byval sts_list as const cst_sts_list ptr, byval frame as long) as const ushort ptr
declare function get_sts_residual(byval sts_list as const cst_sts_list ptr, byval frame as long) as const ubyte ptr
declare function get_sts_residual_fixed(byval sts_list as const cst_sts_list ptr, byval frame as long) as const ubyte ptr
declare function get_frame_size(byval sts_list as const cst_sts_list ptr, byval frame as long) as long
declare function get_unit_size(byval s as const cst_sts_list ptr, byval start as long, byval end as long) as long
extern cst_val_type_lpcres as const long
declare function val_lpcres(byval v as const cst_val ptr) as cst_lpcres ptr
declare function lpcres_val(byval v as const cst_lpcres ptr) as cst_val ptr
extern cst_val_type_sts_list as const long
declare function val_sts_list(byval v as const cst_val ptr) as cst_sts_list ptr
declare function sts_list_val(byval v as const cst_sts_list ptr) as cst_val ptr

end extern
