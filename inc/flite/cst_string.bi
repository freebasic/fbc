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

#include once "crt/string.bi"

extern "C"

#define __CST_STRING_H__
type cst_string as zstring
declare function cst_atof(byval str as const zstring ptr) as double
declare function cst_strdup(byval s as const cst_string ptr) as cst_string ptr
declare function cst_strchr(byval s as const cst_string ptr, byval c as long) as cst_string ptr
declare function cst_strrchr(byval str as const cst_string ptr, byval c as long) as cst_string ptr

#define cst_strstr(h, n) cptr(cst_string ptr, strstr(cptr(const zstring ptr, h), cptr(const zstring ptr, n)))
#define cst_strlen(s) strlen(cptr(const zstring ptr, s))
#define cst_streq(A, B) (strcmp(A, B) = 0)
#define cst_streqn(A, B, N) (strncmp(A, B, N) = 0)

declare function cst_member_string(byval str as const zstring ptr, byval slist as const zstring const ptr ptr) as long
declare function cst_substr(byval str as const zstring ptr, byval start as long, byval length as long) as zstring ptr
declare function cst_string_before(byval s as const zstring ptr, byval c as const zstring ptr) as zstring ptr
declare function cst_strcat(byval a as const zstring ptr, byval b as const zstring ptr) as zstring ptr
declare function cst_strcat3(byval a as const zstring ptr, byval b as const zstring ptr, byval c as const zstring ptr) as zstring ptr
declare function cst_downcase(byval str as const cst_string ptr) as cst_string ptr
declare function cst_upcase(byval str as const cst_string ptr) as cst_string ptr

end extern
