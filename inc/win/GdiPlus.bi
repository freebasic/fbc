#pragma once

#inclib "gdiplus"

#ifdef __FB_64BIT__

'' Even though the C++ API isn't translated for 64bit, we can still wrap the
'' C API in the same namespace, allowing lots of existing code to work.
'' The namespace doesn't hurt the function name mangling because everything
'' is inside an Extern block anyways.
namespace Gdiplus

#include "gdiplus-c.bi"

end namespace

#else

''
''
'' GdiPlus -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''

#include once "win/ole2.bi"

namespace Gdiplus

type INT16 as short
type UINT16 as ushort

#include once "win/GdiplusMem.bi"
#include once "win/GdiplusBase.bi"
#include once "win/GdiplusEnums.bi"
#include once "win/GdiplusTypes.bi"
#include once "win/GdiplusInit.bi"
#include once "win/GdiplusPixelFormats.bi"
#include once "win/GdiplusColor.bi"
#include once "win/GdiplusMetaHeader.bi"
#include once "win/GdiplusImaging.bi"
#include once "win/GdiplusColorMatrix.bi"
#include once "win/GdiplusGpStubs.bi"
#include once "win/GdiplusHeaders.bi"
#include once "win/GdiplusFlat.bi"

end namespace

#endif
