''
''
'' im_kernel -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __im_kernel_bi__
#define __im_kernel_bi__

declare function imKernelSobel cdecl alias "imKernelSobel" () as imImage ptr
declare function imKernelPrewitt cdecl alias "imKernelPrewitt" () as imImage ptr
declare function imKernelKirsh cdecl alias "imKernelKirsh" () as imImage ptr
declare function imKernelLaplacian4 cdecl alias "imKernelLaplacian4" () as imImage ptr
declare function imKernelLaplacian8 cdecl alias "imKernelLaplacian8" () as imImage ptr
declare function imKernelLaplacian5x5 cdecl alias "imKernelLaplacian5x5" () as imImage ptr
declare function imKernelLaplacian7x7 cdecl alias "imKernelLaplacian7x7" () as imImage ptr
declare function imKernelGradian3x3 cdecl alias "imKernelGradian3x3" () as imImage ptr
declare function imKernelGradian7x7 cdecl alias "imKernelGradian7x7" () as imImage ptr
declare function imKernelSculpt cdecl alias "imKernelSculpt" () as imImage ptr
declare function imKernelMean3x3 cdecl alias "imKernelMean3x3" () as imImage ptr
declare function imKernelMean5x5 cdecl alias "imKernelMean5x5" () as imImage ptr
declare function imKernelCircularMean5x5 cdecl alias "imKernelCircularMean5x5" () as imImage ptr
declare function imKernelMean7x7 cdecl alias "imKernelMean7x7" () as imImage ptr
declare function imKernelCircularMean7x7 cdecl alias "imKernelCircularMean7x7" () as imImage ptr
declare function imKernelGaussian3x3 cdecl alias "imKernelGaussian3x3" () as imImage ptr
declare function imKernelGaussian5x5 cdecl alias "imKernelGaussian5x5" () as imImage ptr
declare function imKernelBarlett5x5 cdecl alias "imKernelBarlett5x5" () as imImage ptr
declare function imKernelTopHat5x5 cdecl alias "imKernelTopHat5x5" () as imImage ptr
declare function imKernelTopHat7x7 cdecl alias "imKernelTopHat7x7" () as imImage ptr
declare function imKernelEnhance cdecl alias "imKernelEnhance" () as imImage ptr

#endif
