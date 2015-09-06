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
#include once "cst_hrg.bi"

extern "C"

#define _CST_AUDIO_H__
const CST_AUDIOBUFFSIZE = 128
const CST_AUDIO_DEFAULT_PORT = 1746
#define CST_AUDIO_DEFAULT_SERVER "localhost"
#define CST_AUDIO_DEFAULT_ENCODING "short"

type cst_audiofmt as long
enum
	CST_AUDIO_LINEAR16 = 0
	CST_AUDIO_LINEAR8
	CST_AUDIO_MULAW
end enum

declare function audio_bps(byval fmt as cst_audiofmt) as long

type cst_audiodev_struct
	sps as long
	real_sps as long
	channels as long
	real_channels as long
	fmt as cst_audiofmt
	real_fmt as cst_audiofmt
	byteswap as long
	rateconv as cst_rateconv ptr
	platform_data as any ptr
end type

type cst_audiodev as cst_audiodev_struct
declare function audio_open(byval sps as long, byval channels as long, byval fmt as cst_audiofmt) as cst_audiodev ptr
declare function audio_close(byval ad as cst_audiodev ptr) as long
declare function audio_write(byval ad as cst_audiodev ptr, byval buff as any ptr, byval num_bytes as long) as long
declare function audio_flush(byval ad as cst_audiodev ptr) as long
declare function audio_drain(byval ad as cst_audiodev ptr) as long
declare function play_wave(byval w as cst_wave ptr) as long
declare function play_wave_sync(byval w as cst_wave ptr, byval rel as cst_relation ptr, byval call_back as function(byval as cst_item ptr) as long) as long
declare function play_wave_client(byval w as cst_wave ptr, byval servername as const zstring ptr, byval port as long, byval encoding as const zstring ptr) as long
declare function auserver(byval port as long) as long
declare function play_wave_device(byval w as cst_wave ptr, byval ad as cst_audiodev ptr) as long
declare function audio_open_file(byval sps as long, byval channels as long, byval fmt as cst_audiofmt, byval filename as const zstring ptr) as cst_audiodev ptr
declare function audio_close_file(byval ad as cst_audiodev ptr) as long
declare function audio_write_file(byval ad as cst_audiodev ptr, byval buff as any ptr, byval num_bytes as long) as long
declare function audio_drain_file(byval ad as cst_audiodev ptr) as long
declare function audio_flush_file(byval ad as cst_audiodev ptr) as long
const CST_AUDIO_STREAM_STOP = -1
const CST_AUDIO_STREAM_CONT = 0

type cst_audio_streaming_info_struct
	min_buffsize as long
	asc as function(byval w as const cst_wave ptr, byval start as long, byval size as long, byval last as long, byval asi as cst_audio_streaming_info_struct ptr) as long
	utt as const cst_utterance ptr
	item as const cst_item ptr
	userdata as any ptr
end type

type cst_audio_streaming_info as cst_audio_streaming_info_struct
declare function new_audio_streaming_info() as cst_audio_streaming_info ptr
declare sub delete_audio_streaming_info(byval asi as cst_audio_streaming_info ptr)
extern cst_val_type_audio_streaming_info as const long
declare function val_audio_streaming_info(byval v as const cst_val ptr) as cst_audio_streaming_info ptr
declare function audio_streaming_info_val(byval v as const cst_audio_streaming_info ptr) as cst_val ptr
type cst_audio_stream_callback as function(byval w as const cst_wave ptr, byval start as long, byval size as long, byval last as long, byval asi as cst_audio_streaming_info ptr) as long
declare function audio_stream_chunk(byval w as const cst_wave ptr, byval start as long, byval size as long, byval last as long, byval asi as cst_audio_streaming_info ptr) as long

end extern
