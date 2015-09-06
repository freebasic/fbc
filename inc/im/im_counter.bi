'' FreeBASIC binding for im-3.9.1
''
'' based on the C header files:
''   Copyright (C) 1994-2014 Tecgraf, PUC-Rio.                                
''                                                                            
''   Permission is hereby granted, free of charge, to any person obtaining    
''   a copy of this software and associated documentation files (the          
''   "Software"), to deal in the Software without restriction, including      
''   without limitation the rights to use, copy, modify, merge, publish,      
''   distribute, sublicense, and/or sell copies of the Software, and to       
''   permit persons to whom the Software is furnished to do so, subject to    
''   the following conditions:                                                
''                                                                            
''   The above copyright notice and this permission notice shall be           
''   included in all copies or substantial portions of the Software.          
''                                                                            
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,          
''   EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF       
''   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.   
''   IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY     
''   CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,     
''   TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE        
''   SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.                   
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

extern "C"

#define __IM_COUNTER_H
type imCounterCallback as function(byval counter as long, byval user_data as any ptr, byval text as const zstring ptr, byval progress as long) as long
declare function imCounterSetCallback(byval user_data as any ptr, byval counter_func as imCounterCallback) as imCounterCallback
declare function imCounterHasCallback() as long
declare function imCounterBegin(byval title as const zstring ptr) as long
declare sub imCounterEnd(byval counter as long)
declare function imCounterInc(byval counter as long) as long
declare function imCounterIncTo(byval counter as long, byval count as long) as long
declare sub imCounterTotal(byval counter as long, byval total as long, byval message as const zstring ptr)
declare function imCounterGetUserData(byval counter as long) as any ptr
declare sub imCounterSetUserData(byval counter as long, byval userdata as any ptr)

end extern
