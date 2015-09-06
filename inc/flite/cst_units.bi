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
#include once "cst_hrg.bi"
#include once "cst_sts.bi"

extern "C"

#define _CST_UNITS_H__
declare function join_units(byval utt as cst_utterance ptr) as cst_utterance ptr
declare function join_units_windowed(byval utt as cst_utterance ptr) as cst_utterance ptr
declare function join_units_simple(byval utt as cst_utterance ptr) as cst_utterance ptr
declare function join_units_modified_lpc(byval utt as cst_utterance ptr) as cst_utterance ptr
declare function asis_to_pm(byval utt as cst_utterance ptr) as cst_utterance ptr
declare function f0_targets_to_pm(byval utt as cst_utterance ptr) as cst_utterance ptr
declare function concat_units(byval utt as cst_utterance ptr) as cst_utterance ptr
declare sub add_residual(byval targ_size as long, byval targ_residual as ubyte ptr, byval unit_size as long, byval unit_residual as const ubyte ptr)
declare sub add_residual_pulse(byval targ_size as long, byval targ_residual as ubyte ptr, byval unit_size as long, byval unit_residual as const ubyte ptr)

end extern
