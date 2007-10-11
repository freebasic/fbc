''
'' 
'' SDL_imageFilter - bytes-image "filter" routines 
'' (uses inline x86 MMX optimizations if available)
'' 
'' LGPL (c) A. Schiffler
''
''

#ifndef SDL_imageFilter_h
#define SDL_imageFilter_h

#inclib "SDL_gfx"

#include once "SDL.bi"

extern "c"
    declare function SDL_imageFilterMMXdetect () as integer
    declare sub SDL_imageFilterMMXoff ()
    declare sub SDL_imageFilterMMXon ()
    declare function SDL_imageFilterAdd (byval Src1 as ubyte ptr, byval Src2 as ubyte ptr, byval Dest as ubyte ptr, byval length as integer) as integer
    declare function SDL_imageFilterMean (byval Src1 as ubyte ptr, byval Src2 as ubyte ptr, byval Dest as ubyte ptr, byval length as integer) as integer
    declare function SDL_imageFilterSub (byval Src1 as ubyte ptr, byval Src2 as ubyte ptr, byval Dest as ubyte ptr, byval length as integer) as integer
    declare function SDL_imageFilterAbsDiff (byval Src1 as ubyte ptr, byval Src2 as ubyte ptr, byval Dest as ubyte ptr, byval length as integer) as integer
    declare function SDL_imageFilterMult (byval Src1 as ubyte ptr, byval Src2 as ubyte ptr, byval Dest as ubyte ptr, byval length as integer) as integer
    declare function SDL_imageFilterMultNor (byval Src1 as ubyte ptr, byval Src2 as ubyte ptr, byval Dest as ubyte ptr, byval length as integer) as integer
    declare function SDL_imageFilterMultDivby2 (byval Src1 as ubyte ptr, byval Src2 as ubyte ptr, byval Dest as ubyte ptr, byval length as integer) as integer
    declare function SDL_imageFilterMultDivby4 (byval Src1 as ubyte ptr, byval Src2 as ubyte ptr, byval Dest as ubyte ptr, byval length as integer) as integer
    declare function SDL_imageFilterBitAnd (byval Src1 as ubyte ptr, byval Src2 as ubyte ptr, byval Dest as ubyte ptr, byval length as integer) as integer
    declare function SDL_imageFilterBitOr (byval Src1 as ubyte ptr, byval Src2 as ubyte ptr, byval Dest as ubyte ptr, byval length as integer) as integer
    declare function SDL_imageFilterDiv (byval Src1 as ubyte ptr, byval Src2 as ubyte ptr, byval Dest as ubyte ptr, byval length as integer) as integer
    declare function SDL_imageFilterBitNegation (byval Src1 as ubyte ptr, byval Dest as ubyte ptr, byval length as integer) as integer
    declare function SDL_imageFilterAddByte (byval Src1 as ubyte ptr, byval Dest as ubyte ptr, byval length as integer, byval C as ubyte) as integer
    declare function SDL_imageFilterAddUint (byval Src1 as ubyte ptr, byval Dest as ubyte ptr, byval length as integer, byval C as uinteger) as integer
    declare function SDL_imageFilterAddByteToHalf (byval Src1 as ubyte ptr, byval Dest as ubyte ptr, byval length as integer, byval C as ubyte) as integer
    declare function SDL_imageFilterSubByte (byval Src1 as ubyte ptr, byval Dest as ubyte ptr, byval length as integer, byval C as ubyte) as integer
    declare function SDL_imageFilterSubUint (byval Src1 as ubyte ptr, byval Dest as ubyte ptr, byval length as integer, byval C as uinteger) as integer
    declare function SDL_imageFilterShiftRight (byval Src1 as ubyte ptr, byval Dest as ubyte ptr, byval length as integer, byval N as ubyte) as integer
    declare function SDL_imageFilterShiftRightUint (byval Src1 as ubyte ptr, byval Dest as ubyte ptr, byval length as integer, byval N as ubyte) as integer
    declare function SDL_imageFilterMultByByte (byval Src1 as ubyte ptr, byval Dest as ubyte ptr, byval length as integer, byval C as ubyte) as integer
    declare function SDL_imageFilterShiftRightAndMultByByte (byval Src1 as ubyte ptr, byval Dest as ubyte ptr, byval length as integer, byval N as ubyte, byval C as ubyte) as integer
    declare function SDL_imageFilterShiftLeftByte (byval Src1 as ubyte ptr, byval Dest as ubyte ptr, byval length as integer, byval N as ubyte) as integer
    declare function SDL_imageFilterShiftLeftUint (byval Src1 as ubyte ptr, byval Dest as ubyte ptr, byval length as integer, byval N as ubyte) as integer
    declare function SDL_imageFilterShiftLeft (byval Src1 as ubyte ptr, byval Dest as ubyte ptr, byval length as integer, byval N as ubyte) as integer
    declare function SDL_imageFilterBinarizeUsingThreshold (byval Src1 as ubyte ptr, byval Dest as ubyte ptr, byval length as integer, byval T as ubyte) as integer
    declare function SDL_imageFilterClipToRange (byval Src1 as ubyte ptr, byval Dest as ubyte ptr, byval length as integer, byval Tmin as ubyte, byval Tmax as ubyte) as integer
    declare function SDL_imageFilterNormalizeLinear (byval Src1 as ubyte ptr, byval Dest as ubyte ptr, byval length as integer, byval Cmin as integer, byval Cmax as integer, byval Nmin as integer, byval Nmax as integer) as integer
    declare function SDL_imageFilterConvolveKernel3x3Divide (byval Src as ubyte ptr, byval Dest as ubyte ptr, byval rows as integer, byval columns as integer, byval Kernel as short ptr, byval Divisor as ubyte) as integer
    declare function SDL_imageFilterConvolveKernel5x5Divide (byval Src as ubyte ptr, byval Dest as ubyte ptr, byval rows as integer, byval columns as integer, byval Kernel as short ptr, byval Divisor as ubyte) as integer
    declare function SDL_imageFilterConvolveKernel7x7Divide (byval Src as ubyte ptr, byval Dest as ubyte ptr, byval rows as integer, byval columns as integer, byval Kernel as short ptr, byval Divisor as ubyte) as integer
    declare function SDL_imageFilterConvolveKernel9x9Divide (byval Src as ubyte ptr, byval Dest as ubyte ptr, byval rows as integer, byval columns as integer, byval Kernel as short ptr, byval Divisor as ubyte) as integer
    declare function SDL_imageFilterConvolveKernel3x3ShiftRight (byval Src as ubyte ptr, byval Dest as ubyte ptr, byval rows as integer, byval columns as integer, byval Kernel as short ptr, byval NRightShift as ubyte) as integer
    declare function SDL_imageFilterConvolveKernel5x5ShiftRight (byval Src as ubyte ptr, byval Dest as ubyte ptr, byval rows as integer, byval columns as integer, byval Kernel as short ptr, byval NRightShift as ubyte) as integer
    declare function SDL_imageFilterConvolveKernel7x7ShiftRight (byval Src as ubyte ptr, byval Dest as ubyte ptr, byval rows as integer, byval columns as integer, byval Kernel as short ptr, byval NRightShift as ubyte) as integer
    declare function SDL_imageFilterConvolveKernel9x9ShiftRight (byval Src as ubyte ptr, byval Dest as ubyte ptr, byval rows as integer, byval columns as integer, byval Kernel as short ptr, byval NRightShift as ubyte) as integer
    declare function SDL_imageFilterSobelX (byval Src as ubyte ptr, byval Dest as ubyte ptr, byval rows as integer, byval columns as integer) as integer
    declare function SDL_imageFilterSobelXShiftRight (byval Src as ubyte ptr, byval Dest as ubyte ptr, byval rows as integer, byval columns as integer, byval NRightShift as ubyte) as integer
    declare sub SDL_imageFilterAlignStack ()
    declare sub SDL_imageFilterRestoreStack ()
end extern

#endif				'' _SDL_imageFilter_h
