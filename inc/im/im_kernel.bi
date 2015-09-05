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

#define __IM_KERNEL_H
declare function imKernelSobel() as imImage ptr
declare function imKernelPrewitt() as imImage ptr
declare function imKernelKirsh() as imImage ptr
declare function imKernelLaplacian4() as imImage ptr
declare function imKernelLaplacian8() as imImage ptr
declare function imKernelLaplacian5x5() as imImage ptr
declare function imKernelLaplacian7x7() as imImage ptr
declare function imKernelGradian3x3() as imImage ptr
declare function imKernelGradian7x7() as imImage ptr
declare function imKernelSculpt() as imImage ptr
declare function imKernelMean3x3() as imImage ptr
declare function imKernelMean5x5() as imImage ptr
declare function imKernelCircularMean5x5() as imImage ptr
declare function imKernelMean7x7() as imImage ptr
declare function imKernelCircularMean7x7() as imImage ptr
declare function imKernelGaussian3x3() as imImage ptr
declare function imKernelGaussian5x5() as imImage ptr
declare function imKernelBarlett5x5() as imImage ptr
declare function imKernelTopHat5x5() as imImage ptr
declare function imKernelTopHat7x7() as imImage ptr
declare function imKernelEnhance() as imImage ptr

end extern
