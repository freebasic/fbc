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

#include once "crt/long.bi"

extern "C"

#define __IM_PALETTE_H
declare function imPaletteFindNearest(byval palette as const clong ptr, byval palette_count as long, byval color as clong) as long
declare function imPaletteFindColor(byval palette as const clong ptr, byval palette_count as long, byval color as clong, byval tol as ubyte) as long
declare function imPaletteGray() as clong ptr
declare function imPaletteRed() as clong ptr
declare function imPaletteGreen() as clong ptr
declare function imPaletteBlue() as clong ptr
declare function imPaletteYellow() as clong ptr
declare function imPaletteMagenta() as clong ptr
declare function imPaletteCian() as clong ptr
declare function imPaletteRainbow() as clong ptr
declare function imPaletteHues() as clong ptr
declare function imPaletteBlueIce() as clong ptr
declare function imPaletteHotIron() as clong ptr
declare function imPaletteBlackBody() as clong ptr
declare function imPaletteHighContrast() as clong ptr
declare function imPaletteLinear() as clong ptr
declare function imPaletteUniform() as clong ptr
declare function imPaletteUniformIndex(byval color as clong) as long
declare function imPaletteUniformIndexHalftoned(byval color as clong, byval x as long, byval y as long) as long

end extern
