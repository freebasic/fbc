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

#define __IM_COLORHSI_H
declare function imColorHSI_ImaxS(byval h as single, byval cosh as double, byval sinh as double) as single
declare sub imColorRGB2HSI(byval r as single, byval g as single, byval b as single, byval h as single ptr, byval s as single ptr, byval i as single ptr)
declare sub imColorRGB2HSIbyte(byval r as ubyte, byval g as ubyte, byval b as ubyte, byval h as single ptr, byval s as single ptr, byval i as single ptr)
declare sub imColorHSI2RGB(byval h as single, byval s as single, byval i as single, byval r as single ptr, byval g as single ptr, byval b as single ptr)
declare sub imColorHSI2RGBbyte(byval h as single, byval s as single, byval i as single, byval r as ubyte ptr, byval g as ubyte ptr, byval b as ubyte ptr)

end extern
