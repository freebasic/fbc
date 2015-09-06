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
#include once "cst_error.bi"
#include once "cst_alloc.bi"
#include once "cst_endian.bi"
#include once "cst_val.bi"

extern "C"

#define _CST_TRACK_H__

type cst_track_struct
	as const zstring ptr type
	num_frames as long
	num_channels as long
	times as single ptr
	frames as single ptr ptr
end type

type cst_track as cst_track_struct
declare function new_track() as cst_track ptr
declare sub delete_track(byval val as cst_track ptr)
declare function track_frame_shift(byval t as cst_track ptr, byval frame as long) as single
declare sub cst_track_resize(byval t as cst_track ptr, byval num_frames as long, byval num_channels as long)
declare function cst_track_copy(byval t as const cst_track ptr) as cst_track ptr
declare function cst_track_save_est(byval t as cst_track ptr, byval filename as const zstring ptr) as long
declare function cst_track_save_est_binary(byval t as cst_track ptr, byval filename as const zstring ptr) as long
declare function cst_track_load_est(byval t as cst_track ptr, byval filename as const zstring ptr) as long
extern cst_val_type_track as const long
declare function val_track(byval v as const cst_val ptr) as cst_track ptr
declare function track_val(byval v as const cst_track ptr) as cst_val ptr

end extern
