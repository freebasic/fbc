'' FreeBASIC binding for libX11-1.6.3
''
'' based on the C header files:
''    Code and supporting documentation (c) Copyright 1990 1991 Tektronix, Inc.
''    	All Rights Reserved
''
''    This file is a component of an X Window System-specific implementation
''    of Xcms based on the TekColor Color Management System.  Permission is
''    hereby granted to use, copy, modify, sell, and otherwise distribute this
''    software and its documentation for any purpose and without fee, provided
''    that this copyright, permission, and disclaimer notice is reproduced in
''    all copies of this software and in supporting documentation.  TekColor
''    is a trademark of Tektronix, Inc.
''
''    Tektronix makes no representation about the suitability of this software
''    for any purpose.  It is provided "as is" and with all faults.
''
''    TEKTRONIX DISCLAIMS ALL WARRANTIES APPLICABLE TO THIS SOFTWARE,
''    INCLUDING THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
''    PARTICULAR PURPOSE.  IN NO EVENT SHALL TEKTRONIX BE LIABLE FOR ANY
''    SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER
''    RESULTING FROM LOSS OF USE, DATA, OR PROFITS, WHETHER IN AN ACTION OF
''    CONTRACT, NEGLIGENCE, OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
''    CONNECTION WITH THE USE OR THE PERFORMANCE OF THIS SOFTWARE.
''
''
''   	DESCRIPTION
''   		Public include file for X Color Management System
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/long.bi"
#include once "X11/Xlib.bi"

extern "C"

#define _X11_XCMS_H_
const XcmsFailure = 0
const XcmsSuccess = 1
const XcmsSuccessWithCompression = 2
#define XcmsUndefinedFormat cast(XcmsColorFormat, &h00000000)
#define XcmsCIEXYZFormat cast(XcmsColorFormat, &h00000001)
#define XcmsCIEuvYFormat cast(XcmsColorFormat, &h00000002)
#define XcmsCIExyYFormat cast(XcmsColorFormat, &h00000003)
#define XcmsCIELabFormat cast(XcmsColorFormat, &h00000004)
#define XcmsCIELuvFormat cast(XcmsColorFormat, &h00000005)
#define XcmsTekHVCFormat cast(XcmsColorFormat, &h00000006)
#define XcmsRGBFormat cast(XcmsColorFormat, &h80000000)
#define XcmsRGBiFormat cast(XcmsColorFormat, &h80000001)
const XcmsInitNone = &h00
const XcmsInitSuccess = &h01
const XcmsInitFailure = &hff
#define DisplayOfCCC(ccc) (ccc)->dpy
#define ScreenNumberOfCCC(ccc) (ccc)->screenNumber
#define VisualOfCCC(ccc) (ccc)->visual
#define ClientWhitePointOfCCC(ccc) (@(ccc)->clientWhitePt)
#define ScreenWhitePointOfCCC(ccc) (@(ccc)->pPerScrnInfo->screenWhitePt)
#define FunctionSetOfCCC(ccc) (ccc)->pPerScrnInfo->functionSet
type XcmsColorFormat as culong
type XcmsFloat as double

type XcmsRGB
	red as ushort
	green as ushort
	blue as ushort
end type

type XcmsRGBi
	red as XcmsFloat
	green as XcmsFloat
	blue as XcmsFloat
end type

type XcmsCIEXYZ
	X as XcmsFloat
	Y as XcmsFloat
	Z as XcmsFloat
end type

type XcmsCIEuvY
	u_prime as XcmsFloat
	v_prime as XcmsFloat
	Y as XcmsFloat
end type

type XcmsCIExyY
	x as XcmsFloat
	y as XcmsFloat
	Y_ as XcmsFloat
end type

type XcmsCIELab
	L_star as XcmsFloat
	a_star as XcmsFloat
	b_star as XcmsFloat
end type

type XcmsCIELuv
	L_star as XcmsFloat
	u_star as XcmsFloat
	v_star as XcmsFloat
end type

type XcmsTekHVC
	H as XcmsFloat
	V as XcmsFloat
	C as XcmsFloat
end type

type XcmsPad
	pad0 as XcmsFloat
	pad1 as XcmsFloat
	pad2 as XcmsFloat
	pad3 as XcmsFloat
end type

union XcmsColor_spec
	RGB as XcmsRGB
	RGBi as XcmsRGBi
	CIEXYZ as XcmsCIEXYZ
	CIEuvY as XcmsCIEuvY
	CIExyY as XcmsCIExyY
	CIELab as XcmsCIELab
	CIELuv as XcmsCIELuv
	TekHVC as XcmsTekHVC
	Pad as XcmsPad
end union

type XcmsColor
	spec as XcmsColor_spec
	pixel as culong
	format as XcmsColorFormat
end type

type _XcmsPerScrnInfo
	screenWhitePt as XcmsColor
	functionSet as XPointer
	screenData as XPointer
	state as ubyte
	pad as zstring * 3
end type

type XcmsPerScrnInfo as _XcmsPerScrnInfo
type XcmsCCC as _XcmsCCC ptr
type XcmsCompressionProc as function(byval as XcmsCCC, byval as XcmsColor ptr, byval as ulong, byval as ulong, byval as long ptr) as long
type XcmsWhiteAdjustProc as function(byval as XcmsCCC, byval as XcmsColor ptr, byval as XcmsColor ptr, byval as XcmsColorFormat, byval as XcmsColor ptr, byval as ulong, byval as long ptr) as long

type _XcmsCCC
	dpy as Display ptr
	screenNumber as long
	visual as Visual ptr
	clientWhitePt as XcmsColor
	gamutCompProc as XcmsCompressionProc
	gamutCompClientData as XPointer
	whitePtAdjProc as XcmsWhiteAdjustProc
	whitePtAdjClientData as XPointer
	pPerScrnInfo as XcmsPerScrnInfo ptr
end type

type XcmsCCCRec as _XcmsCCC
type XcmsScreenInitProc as function(byval as Display ptr, byval as long, byval as XcmsPerScrnInfo ptr) as long
type XcmsScreenFreeProc as sub(byval as XPointer)
type XcmsDDConversionProc as function(byval as XcmsCCC, byval as XcmsColor ptr, byval as ulong, byval as long ptr) as long
type XcmsDIConversionProc as function(byval as XcmsCCC, byval as XcmsColor ptr, byval as XcmsColor ptr, byval as ulong) as long
type XcmsConversionProc as XcmsDIConversionProc
type XcmsFuncListPtr as XcmsConversionProc ptr
type XcmsParseStringProc as function(byval as zstring ptr, byval as XcmsColor ptr) as long

type _XcmsColorSpace
	prefix as const zstring ptr
	id as XcmsColorFormat
	parseString as XcmsParseStringProc
	to_CIEXYZ as XcmsFuncListPtr
	from_CIEXYZ as XcmsFuncListPtr
	inverse_flag as long
end type

type XcmsColorSpace as _XcmsColorSpace

type _XcmsFunctionSet
	DDColorSpaces as XcmsColorSpace ptr ptr
	screenInitProc as XcmsScreenInitProc
	screenFreeProc as XcmsScreenFreeProc
end type

type XcmsFunctionSet as _XcmsFunctionSet
declare function XcmsAddColorSpace(byval as XcmsColorSpace ptr) as long
declare function XcmsAddFunctionSet(byval as XcmsFunctionSet ptr) as long
declare function XcmsAllocColor(byval as Display ptr, byval as Colormap, byval as XcmsColor ptr, byval as XcmsColorFormat) as long
declare function XcmsAllocNamedColor(byval as Display ptr, byval as Colormap, byval as const zstring ptr, byval as XcmsColor ptr, byval as XcmsColor ptr, byval as XcmsColorFormat) as long
declare function XcmsCCCOfColormap(byval as Display ptr, byval as Colormap) as XcmsCCC
declare function XcmsCIELabClipab(byval as XcmsCCC, byval as XcmsColor ptr, byval as ulong, byval as ulong, byval as long ptr) as long
declare function XcmsCIELabClipL(byval as XcmsCCC, byval as XcmsColor ptr, byval as ulong, byval as ulong, byval as long ptr) as long
declare function XcmsCIELabClipLab(byval as XcmsCCC, byval as XcmsColor ptr, byval as ulong, byval as ulong, byval as long ptr) as long
declare function XcmsCIELabQueryMaxC(byval as XcmsCCC, byval as XcmsFloat, byval as XcmsFloat, byval as XcmsColor ptr) as long
declare function XcmsCIELabQueryMaxL(byval as XcmsCCC, byval as XcmsFloat, byval as XcmsFloat, byval as XcmsColor ptr) as long
declare function XcmsCIELabQueryMaxLC(byval as XcmsCCC, byval as XcmsFloat, byval as XcmsColor ptr) as long
declare function XcmsCIELabQueryMinL(byval as XcmsCCC, byval as XcmsFloat, byval as XcmsFloat, byval as XcmsColor ptr) as long
declare function XcmsCIELabToCIEXYZ(byval as XcmsCCC, byval as XcmsColor ptr, byval as XcmsColor ptr, byval as ulong) as long
declare function XcmsCIELabWhiteShiftColors(byval as XcmsCCC, byval as XcmsColor ptr, byval as XcmsColor ptr, byval as XcmsColorFormat, byval as XcmsColor ptr, byval as ulong, byval as long ptr) as long
declare function XcmsCIELuvClipL(byval as XcmsCCC, byval as XcmsColor ptr, byval as ulong, byval as ulong, byval as long ptr) as long
declare function XcmsCIELuvClipLuv(byval as XcmsCCC, byval as XcmsColor ptr, byval as ulong, byval as ulong, byval as long ptr) as long
declare function XcmsCIELuvClipuv(byval as XcmsCCC, byval as XcmsColor ptr, byval as ulong, byval as ulong, byval as long ptr) as long
declare function XcmsCIELuvQueryMaxC(byval as XcmsCCC, byval as XcmsFloat, byval as XcmsFloat, byval as XcmsColor ptr) as long
declare function XcmsCIELuvQueryMaxL(byval as XcmsCCC, byval as XcmsFloat, byval as XcmsFloat, byval as XcmsColor ptr) as long
declare function XcmsCIELuvQueryMaxLC(byval as XcmsCCC, byval as XcmsFloat, byval as XcmsColor ptr) as long
declare function XcmsCIELuvQueryMinL(byval as XcmsCCC, byval as XcmsFloat, byval as XcmsFloat, byval as XcmsColor ptr) as long
declare function XcmsCIELuvToCIEuvY(byval as XcmsCCC, byval as XcmsColor ptr, byval as XcmsColor ptr, byval as ulong) as long
declare function XcmsCIELuvWhiteShiftColors(byval as XcmsCCC, byval as XcmsColor ptr, byval as XcmsColor ptr, byval as XcmsColorFormat, byval as XcmsColor ptr, byval as ulong, byval as long ptr) as long
declare function XcmsCIEXYZToCIELab(byval as XcmsCCC, byval as XcmsColor ptr, byval as XcmsColor ptr, byval as ulong) as long
declare function XcmsCIEXYZToCIEuvY(byval as XcmsCCC, byval as XcmsColor ptr, byval as XcmsColor ptr, byval as ulong) as long
declare function XcmsCIEXYZToCIExyY(byval as XcmsCCC, byval as XcmsColor ptr, byval as XcmsColor ptr, byval as ulong) as long
declare function XcmsCIEXYZToRGBi(byval as XcmsCCC, byval as XcmsColor ptr, byval as ulong, byval as long ptr) as long
declare function XcmsCIEuvYToCIELuv(byval as XcmsCCC, byval as XcmsColor ptr, byval as XcmsColor ptr, byval as ulong) as long
declare function XcmsCIEuvYToCIEXYZ(byval as XcmsCCC, byval as XcmsColor ptr, byval as XcmsColor ptr, byval as ulong) as long
declare function XcmsCIEuvYToTekHVC(byval as XcmsCCC, byval as XcmsColor ptr, byval as XcmsColor ptr, byval as ulong) as long
declare function XcmsCIExyYToCIEXYZ(byval as XcmsCCC, byval as XcmsColor ptr, byval as XcmsColor ptr, byval as ulong) as long
declare function XcmsClientWhitePointOfCCC(byval as XcmsCCC) as XcmsColor ptr
declare function XcmsConvertColors(byval as XcmsCCC, byval as XcmsColor ptr, byval as ulong, byval as XcmsColorFormat, byval as long ptr) as long
declare function XcmsCreateCCC(byval as Display ptr, byval as long, byval as Visual ptr, byval as XcmsColor ptr, byval as XcmsCompressionProc, byval as XPointer, byval as XcmsWhiteAdjustProc, byval as XPointer) as XcmsCCC
declare function XcmsDefaultCCC(byval as Display ptr, byval as long) as XcmsCCC
declare function XcmsDisplayOfCCC(byval as XcmsCCC) as Display ptr
declare function XcmsFormatOfPrefix(byval as zstring ptr) as XcmsColorFormat
declare sub XcmsFreeCCC(byval as XcmsCCC)
declare function XcmsLookupColor(byval as Display ptr, byval as Colormap, byval as const zstring ptr, byval as XcmsColor ptr, byval as XcmsColor ptr, byval as XcmsColorFormat) as long
declare function XcmsPrefixOfFormat(byval as XcmsColorFormat) as zstring ptr
declare function XcmsQueryBlack(byval as XcmsCCC, byval as XcmsColorFormat, byval as XcmsColor ptr) as long
declare function XcmsQueryBlue(byval as XcmsCCC, byval as XcmsColorFormat, byval as XcmsColor ptr) as long
declare function XcmsQueryColor(byval as Display ptr, byval as Colormap, byval as XcmsColor ptr, byval as XcmsColorFormat) as long
declare function XcmsQueryColors(byval as Display ptr, byval as Colormap, byval as XcmsColor ptr, byval as ulong, byval as XcmsColorFormat) as long
declare function XcmsQueryGreen(byval as XcmsCCC, byval as XcmsColorFormat, byval as XcmsColor ptr) as long
declare function XcmsQueryRed(byval as XcmsCCC, byval as XcmsColorFormat, byval as XcmsColor ptr) as long
declare function XcmsQueryWhite(byval as XcmsCCC, byval as XcmsColorFormat, byval as XcmsColor ptr) as long
declare function XcmsRGBiToCIEXYZ(byval as XcmsCCC, byval as XcmsColor ptr, byval as ulong, byval as long ptr) as long
declare function XcmsRGBiToRGB(byval as XcmsCCC, byval as XcmsColor ptr, byval as ulong, byval as long ptr) as long
declare function XcmsRGBToRGBi(byval as XcmsCCC, byval as XcmsColor ptr, byval as ulong, byval as long ptr) as long
declare function XcmsScreenNumberOfCCC(byval as XcmsCCC) as long
declare function XcmsScreenWhitePointOfCCC(byval as XcmsCCC) as XcmsColor ptr
declare function XcmsSetCCCOfColormap(byval as Display ptr, byval as Colormap, byval as XcmsCCC) as XcmsCCC
declare function XcmsSetCompressionProc(byval as XcmsCCC, byval as XcmsCompressionProc, byval as XPointer) as XcmsCompressionProc
declare function XcmsSetWhiteAdjustProc(byval as XcmsCCC, byval as XcmsWhiteAdjustProc, byval as XPointer) as XcmsWhiteAdjustProc
declare function XcmsSetWhitePoint(byval as XcmsCCC, byval as XcmsColor ptr) as long
declare function XcmsStoreColor(byval as Display ptr, byval as Colormap, byval as XcmsColor ptr) as long
declare function XcmsStoreColors(byval as Display ptr, byval as Colormap, byval as XcmsColor ptr, byval as ulong, byval as long ptr) as long
declare function XcmsTekHVCClipC(byval as XcmsCCC, byval as XcmsColor ptr, byval as ulong, byval as ulong, byval as long ptr) as long
declare function XcmsTekHVCClipV(byval as XcmsCCC, byval as XcmsColor ptr, byval as ulong, byval as ulong, byval as long ptr) as long
declare function XcmsTekHVCClipVC(byval as XcmsCCC, byval as XcmsColor ptr, byval as ulong, byval as ulong, byval as long ptr) as long
declare function XcmsTekHVCQueryMaxC(byval as XcmsCCC, byval as XcmsFloat, byval as XcmsFloat, byval as XcmsColor ptr) as long
declare function XcmsTekHVCQueryMaxV(byval as XcmsCCC, byval as XcmsFloat, byval as XcmsFloat, byval as XcmsColor ptr) as long
declare function XcmsTekHVCQueryMaxVC(byval as XcmsCCC, byval as XcmsFloat, byval as XcmsColor ptr) as long
declare function XcmsTekHVCQueryMaxVSamples(byval as XcmsCCC, byval as XcmsFloat, byval as XcmsColor ptr, byval as ulong) as long
declare function XcmsTekHVCQueryMinV(byval as XcmsCCC, byval as XcmsFloat, byval as XcmsFloat, byval as XcmsColor ptr) as long
declare function XcmsTekHVCToCIEuvY(byval as XcmsCCC, byval as XcmsColor ptr, byval as XcmsColor ptr, byval as ulong) as long
declare function XcmsTekHVCWhiteShiftColors(byval as XcmsCCC, byval as XcmsColor ptr, byval as XcmsColor ptr, byval as XcmsColorFormat, byval as XcmsColor ptr, byval as ulong, byval as long ptr) as long
declare function XcmsVisualOfCCC(byval as XcmsCCC) as Visual ptr

end extern
