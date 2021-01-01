'' FreeBASIC binding for SDL_gfx-2.0.26
''
'' based on the C header files:
''   Copyright (C) 2001-2013  Andreas Schiffler
''
''   This software is provided 'as-is', without any express or implied
''   warranty. In no event will the authors be held liable for any damages
''   arising from the use of this software.
''
''   Permission is granted to anyone to use this software for any purpose,
''   including commercial applications, and to alter it and redistribute it
''   freely, subject to the following restrictions:
''
''   1. The origin of this software must not be misrepresented; you must not
''   claim that you wrote the original software. If you use this software
''   in a product, an acknowledgment in the product documentation would be
''   appreciated but is not required.
''
''   2. Altered source versions must be plainly marked as such, and must not be
''   misrepresented as being the original software.
''
''   3. This notice may not be removed or altered from any source
''   distribution.
''
''   Andreas Schiffler -- aschiffler at ferzkopp dot net
''
'' translated to FreeBASIC by:
''   Copyright © 2020 FreeBASIC development team

#pragma once

#inclib "SDL_gfx"

extern "C"

#define _SDL_imageFilter_h
declare function SDL_imageFilterMMXdetect() as long
declare sub SDL_imageFilterMMXoff()
declare sub SDL_imageFilterMMXon()
declare function SDL_imageFilterAdd(byval Src1 as ubyte ptr, byval Src2 as ubyte ptr, byval Dest as ubyte ptr, byval length as ulong) as long
declare function SDL_imageFilterMean(byval Src1 as ubyte ptr, byval Src2 as ubyte ptr, byval Dest as ubyte ptr, byval length as ulong) as long
declare function SDL_imageFilterSub(byval Src1 as ubyte ptr, byval Src2 as ubyte ptr, byval Dest as ubyte ptr, byval length as ulong) as long
declare function SDL_imageFilterAbsDiff(byval Src1 as ubyte ptr, byval Src2 as ubyte ptr, byval Dest as ubyte ptr, byval length as ulong) as long
declare function SDL_imageFilterMult(byval Src1 as ubyte ptr, byval Src2 as ubyte ptr, byval Dest as ubyte ptr, byval length as ulong) as long
declare function SDL_imageFilterMultNor(byval Src1 as ubyte ptr, byval Src2 as ubyte ptr, byval Dest as ubyte ptr, byval length as ulong) as long
declare function SDL_imageFilterMultDivby2(byval Src1 as ubyte ptr, byval Src2 as ubyte ptr, byval Dest as ubyte ptr, byval length as ulong) as long
declare function SDL_imageFilterMultDivby4(byval Src1 as ubyte ptr, byval Src2 as ubyte ptr, byval Dest as ubyte ptr, byval length as ulong) as long
declare function SDL_imageFilterBitAnd(byval Src1 as ubyte ptr, byval Src2 as ubyte ptr, byval Dest as ubyte ptr, byval length as ulong) as long
declare function SDL_imageFilterBitOr(byval Src1 as ubyte ptr, byval Src2 as ubyte ptr, byval Dest as ubyte ptr, byval length as ulong) as long
declare function SDL_imageFilterDiv(byval Src1 as ubyte ptr, byval Src2 as ubyte ptr, byval Dest as ubyte ptr, byval length as ulong) as long
declare function SDL_imageFilterBitNegation(byval Src1 as ubyte ptr, byval Dest as ubyte ptr, byval length as ulong) as long
declare function SDL_imageFilterAddByte(byval Src1 as ubyte ptr, byval Dest as ubyte ptr, byval length as ulong, byval C as ubyte) as long
declare function SDL_imageFilterAddUint(byval Src1 as ubyte ptr, byval Dest as ubyte ptr, byval length as ulong, byval C as ulong) as long
declare function SDL_imageFilterAddByteToHalf(byval Src1 as ubyte ptr, byval Dest as ubyte ptr, byval length as ulong, byval C as ubyte) as long
declare function SDL_imageFilterSubByte(byval Src1 as ubyte ptr, byval Dest as ubyte ptr, byval length as ulong, byval C as ubyte) as long
declare function SDL_imageFilterSubUint(byval Src1 as ubyte ptr, byval Dest as ubyte ptr, byval length as ulong, byval C as ulong) as long
declare function SDL_imageFilterShiftRight(byval Src1 as ubyte ptr, byval Dest as ubyte ptr, byval length as ulong, byval N as ubyte) as long
declare function SDL_imageFilterShiftRightUint(byval Src1 as ubyte ptr, byval Dest as ubyte ptr, byval length as ulong, byval N as ubyte) as long
declare function SDL_imageFilterMultByByte(byval Src1 as ubyte ptr, byval Dest as ubyte ptr, byval length as ulong, byval C as ubyte) as long
declare function SDL_imageFilterShiftRightAndMultByByte(byval Src1 as ubyte ptr, byval Dest as ubyte ptr, byval length as ulong, byval N as ubyte, byval C as ubyte) as long
declare function SDL_imageFilterShiftLeftByte(byval Src1 as ubyte ptr, byval Dest as ubyte ptr, byval length as ulong, byval N as ubyte) as long
declare function SDL_imageFilterShiftLeftUint(byval Src1 as ubyte ptr, byval Dest as ubyte ptr, byval length as ulong, byval N as ubyte) as long
declare function SDL_imageFilterShiftLeft(byval Src1 as ubyte ptr, byval Dest as ubyte ptr, byval length as ulong, byval N as ubyte) as long
declare function SDL_imageFilterBinarizeUsingThreshold(byval Src1 as ubyte ptr, byval Dest as ubyte ptr, byval length as ulong, byval T as ubyte) as long
declare function SDL_imageFilterClipToRange(byval Src1 as ubyte ptr, byval Dest as ubyte ptr, byval length as ulong, byval Tmin as ubyte, byval Tmax as ubyte) as long
declare function SDL_imageFilterNormalizeLinear(byval Src as ubyte ptr, byval Dest as ubyte ptr, byval length as ulong, byval Cmin as long, byval Cmax as long, byval Nmin as long, byval Nmax as long) as long
declare function SDL_imageFilterConvolveKernel3x3Divide(byval Src as ubyte ptr, byval Dest as ubyte ptr, byval rows as long, byval columns as long, byval Kernel as short ptr, byval Divisor as ubyte) as long
declare function SDL_imageFilterConvolveKernel5x5Divide(byval Src as ubyte ptr, byval Dest as ubyte ptr, byval rows as long, byval columns as long, byval Kernel as short ptr, byval Divisor as ubyte) as long
declare function SDL_imageFilterConvolveKernel7x7Divide(byval Src as ubyte ptr, byval Dest as ubyte ptr, byval rows as long, byval columns as long, byval Kernel as short ptr, byval Divisor as ubyte) as long
declare function SDL_imageFilterConvolveKernel9x9Divide(byval Src as ubyte ptr, byval Dest as ubyte ptr, byval rows as long, byval columns as long, byval Kernel as short ptr, byval Divisor as ubyte) as long
declare function SDL_imageFilterConvolveKernel3x3ShiftRight(byval Src as ubyte ptr, byval Dest as ubyte ptr, byval rows as long, byval columns as long, byval Kernel as short ptr, byval NRightShift as ubyte) as long
declare function SDL_imageFilterConvolveKernel5x5ShiftRight(byval Src as ubyte ptr, byval Dest as ubyte ptr, byval rows as long, byval columns as long, byval Kernel as short ptr, byval NRightShift as ubyte) as long
declare function SDL_imageFilterConvolveKernel7x7ShiftRight(byval Src as ubyte ptr, byval Dest as ubyte ptr, byval rows as long, byval columns as long, byval Kernel as short ptr, byval NRightShift as ubyte) as long
declare function SDL_imageFilterConvolveKernel9x9ShiftRight(byval Src as ubyte ptr, byval Dest as ubyte ptr, byval rows as long, byval columns as long, byval Kernel as short ptr, byval NRightShift as ubyte) as long
declare function SDL_imageFilterSobelX(byval Src as ubyte ptr, byval Dest as ubyte ptr, byval rows as long, byval columns as long) as long
declare function SDL_imageFilterSobelXShiftRight(byval Src as ubyte ptr, byval Dest as ubyte ptr, byval rows as long, byval columns as long, byval NRightShift as ubyte) as long
declare sub SDL_imageFilterAlignStack()
declare sub SDL_imageFilterRestoreStack()

end extern
