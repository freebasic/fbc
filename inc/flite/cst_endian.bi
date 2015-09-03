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

#include once "crt/long.bi"

extern "C"

#define __CST_ENDIAN_H__
extern cst_endian_loc as const long
#define CST_BIG_ENDIAN (cptr(zstring ptr, @cst_endian_loc)[0] = 0)
#define CST_LITTLE_ENDIAN (cptr(zstring ptr, @cst_endian_loc)[0] <> 0)
#define BYTE_ORDER_BIG "10"
#define BYTE_ORDER_LITTLE "01"
#define SWAPINT(x) culng(culng(culng(culng(culng(culng(x) and &hff) shl 24) or culng(culng(culng(x) and &hff00) shl 8)) or culng(culng(culng(x) and &hff0000) shr 8)) or culng(culng(culng(x) and &hff000000) shr 24))
#define SWAPLONG(x) (((((cast(culong, x) and &hff) shl 24) or ((cast(culong, x) and &hff00) shl 8)) or ((cast(culong, x) and &hff0000) shr 8)) or ((cast(culong, x) and &hff000000) shr 24))
#define SWAPSHORT(x) (((cushort(x) and &hff) shl 8) or ((cushort(x) and &hff00) shr 8))

declare sub swap_bytes_short(byval b as short ptr, byval n as long)
declare sub swapdouble(byval d as double ptr)
declare sub swapfloat(byval f as single ptr)

end extern
