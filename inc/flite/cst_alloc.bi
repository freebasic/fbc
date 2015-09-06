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

'' The following symbols have been renamed:
''     constant TRUE => CTRUE

extern "C"

#define __CST_ALLOC_H__
#ifndef CTRUE
	const CTRUE = 1
#endif
#ifndef TRUE
	const TRUE = 0
#endif
#ifndef FALSE
	const FALSE = 0
#endif

declare function cst_safe_alloc(byval size as long) as any ptr
declare function cst_safe_calloc(byval size as long) as any ptr
declare function cst_safe_realloc(byval p as any ptr, byval size as long) as any ptr
type cst_alloc_context as any ptr

#define new_alloc_context(size) NULL
#define delete_alloc_context(ctx)
#define cst_local_alloc(ctx, size) cst_safe_alloc(size)
#define cst_local_free(cst, p) cst_free(p)
#define cst_alloc(TYPE, SIZE) cptr(TYPE ptr, cst_safe_alloc(sizeof(TYPE) * (SIZE)))
#define cst_calloc(TYPE, SIZE) cptr(TYPE ptr, cst_safe_calloc(sizeof(TYPE) * (SIZE)))
#define cst_realloc(P, TYPE, SIZE) cptr(TYPE ptr, cst_safe_realloc(cptr(any ptr, (P)), sizeof(TYPE) * (SIZE)))
declare sub cst_free(byval p as any ptr)

end extern
