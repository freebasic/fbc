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

#define _CST_WAVE_H__

type cst_wave_struct
	as const zstring ptr type
	sample_rate as long
	num_samples as long
	num_channels as long
	samples as short ptr
end type

type cst_wave as cst_wave_struct

type cst_wave_header_struct
	as const zstring ptr type
	hsize as long
	num_bytes as long
	sample_rate as long
	num_samples as long
	num_channels as long
end type

type cst_wave_header as cst_wave_header_struct
declare function new_wave() as cst_wave ptr
declare function copy_wave(byval w as const cst_wave ptr) as cst_wave ptr
declare sub delete_wave(byval val as cst_wave ptr)
declare function concat_wave(byval dest as cst_wave ptr, byval src as const cst_wave ptr) as cst_wave ptr

#define cst_wave_num_samples(w) iif(w, w->num_samples, 0)
#define cst_wave_num_channels(w) iif(w, w->num_channels, 0)
#define cst_wave_sample_rate(w) iif(w, w->sample_rate, 0)
#define cst_wave_samples(w) w->samples
#define cst_wave_set_num_samples(w, s) scope : w->num_samples = s : end scope
#define cst_wave_set_num_channels(w, s) scope : w->num_channels = s : end scope
#define cst_wave_set_sample_rate(w, s) scope : w->sample_rate = s : end scope

declare function cst_wave_save(byval w as cst_wave ptr, byval filename as const zstring ptr, byval type as const zstring ptr) as long
declare function cst_wave_save_riff(byval w as cst_wave ptr, byval filename as const zstring ptr) as long
declare function cst_wave_save_raw(byval w as cst_wave ptr, byval filename as const zstring ptr) as long
declare function cst_wave_append_riff(byval w as cst_wave ptr, byval filename as const zstring ptr) as long
declare function cst_wave_save_riff_fd(byval w as cst_wave ptr, byval fd as cst_file) as long
declare function cst_wave_save_raw_fd(byval w as cst_wave ptr, byval fd as cst_file) as long
declare function cst_wave_load(byval w as cst_wave ptr, byval filename as const zstring ptr, byval type as const zstring ptr) as long
declare function cst_wave_load_riff(byval w as cst_wave ptr, byval filename as const zstring ptr) as long
declare function cst_wave_load_raw(byval w as cst_wave ptr, byval filename as const zstring ptr, byval bo as const zstring ptr, byval sample_rate as long) as long
declare function cst_wave_load_riff_header(byval header as cst_wave_header ptr, byval fd as cst_file) as long
declare function cst_wave_load_riff_fd(byval w as cst_wave ptr, byval fd as cst_file) as long
declare function cst_wave_load_raw_fd(byval w as cst_wave ptr, byval fd as cst_file, byval bo as const zstring ptr, byval sample_rate as long) as long
declare sub cst_wave_resize(byval w as cst_wave ptr, byval samples as long, byval num_channels as long)
declare sub cst_wave_resample(byval w as cst_wave ptr, byval sample_rate as long)
declare sub cst_wave_rescale(byval w as cst_wave ptr, byval factor as long)

type cst_rateconv_struct
	channels as long
	up as long
	down as long
	gain as double
	lag as long
	sin as long ptr
	sout as long ptr
	coep as long ptr
	insize as long
	outsize as long
	incount as long
	len as long
	fsin as double
	fgk as double
	fgg as double
	inbaseidx as long
	inoffset as long
	cycctr as long
	outidx as long
end type

type cst_rateconv as cst_rateconv_struct
declare function new_rateconv(byval up as long, byval down as long, byval channels as long) as cst_rateconv ptr
declare sub delete_rateconv(byval filt as cst_rateconv ptr)
declare function cst_rateconv_in(byval filt as cst_rateconv ptr, byval inptr as const short ptr, byval max as long) as long
declare function cst_rateconv_leadout(byval filt as cst_rateconv ptr) as long
declare function cst_rateconv_out(byval filt as cst_rateconv ptr, byval outptr as short ptr, byval max as long) as long

const RIFF_FORMAT_PCM = &h0001
const RIFF_FORMAT_ADPCM = &h0002
const RIFF_FORMAT_MULAW = &h0006
const RIFF_FORMAT_ALAW = &h0007

type snd_header
	magic as ulong
	hdr_size as ulong
	data_size as long
	encoding as ulong
	sample_rate as ulong
	channels as ulong
end type

const CST_SND_MAGIC = culng(&h2e736e64)
const CST_SND_ULAW = 1
const CST_SND_UCHAR = 2
const CST_SND_SHORT = 3
declare function cst_short_to_ulaw(byval sample as short) as ubyte
declare function cst_ulaw_to_short(byval ulawbyte as ubyte) as short
const CST_G721_LEADIN = 8
declare function cst_g721_decode(byval actual_size as long ptr, byval size as long, byval packed_residual as const ubyte ptr) as ubyte ptr
declare function cst_g721_encode(byval packed_size as long ptr, byval actual_size as long, byval unpacked_residual as const ubyte ptr) as ubyte ptr
extern cst_val_type_wave as const long
declare function val_wave(byval v as const cst_val ptr) as cst_wave ptr
declare function wave_val(byval v as const cst_wave ptr) as cst_val ptr

end extern
