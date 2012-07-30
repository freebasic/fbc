''
''
'' Xcms -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __Xcms_bi__
#define __Xcms_bi__

#define XcmsFailure 0
#define XcmsSuccess 1
#define XcmsSuccessWithCompression 2
#define XcmsInitNone &h00
#define XcmsInitSuccess &h01
#define XcmsInitFailure &hff

type XcmsColorFormat as uinteger
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
	Y as XcmsFloat
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

type XcmsColor
	pixel as uinteger
	format as XcmsColorFormat
	spec as XcmsColor__NESTED__spec
end type

union XcmsColor__NESTED__spec
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

type _XcmsPerScrnInfo
	screenWhitePt as XcmsColor
	functionSet as XPointer
	screenData as XPointer
	state as ubyte
	pad as zstring * 3
end type

type XcmsPerScrnInfo as _XcmsPerScrnInfo
type XcmsCCC as _XcmsCCC ptr
type XcmsCompressionProc as function cdecl(byval as XcmsCCC, byval as XcmsColor ptr, byval as uinteger, byval as uinteger, byval as Bool ptr) as Status
type XcmsWhiteAdjustProc as function cdecl(byval as XcmsCCC, byval as XcmsColor ptr, byval as XcmsColor ptr, byval as XcmsColorFormat, byval as XcmsColor ptr, byval as uinteger, byval as Bool ptr) as Status

type _XcmsCCC
	dpy as Display ptr
	screenNumber as integer
	visual as Visual ptr
	clientWhitePt as XcmsColor
	gamutCompProc as XcmsCompressionProc
	gamutCompClientData as XPointer
	whitePtAdjProc as XcmsWhiteAdjustProc
	whitePtAdjClientData as XPointer
	pPerScrnInfo as XcmsPerScrnInfo ptr
end type

type XcmsCCCRec as _XcmsCCC
type XcmsScreenInitProc as function cdecl(byval as Display ptr, byval as integer, byval as XcmsPerScrnInfo ptr) as Status
type XcmsScreenFreeProc as sub cdecl(byval as XPointer)
type XcmsDDConversionProc as function cdecl(byval as XcmsCCC, byval as XcmsColor ptr, byval as uinteger, byval as Bool ptr) as Status
type XcmsDIConversionProc as function cdecl(byval as XcmsCCC, byval as XcmsColor ptr, byval as XcmsColor ptr, byval as uinteger) as Status
type XcmsConversionProc as XcmsDIConversionProc
type XcmsFuncListPtr as XcmsConversionProc ptr
type XcmsParseStringProc as function cdecl(byval as zstring ptr, byval as XcmsColor ptr) as integer

type _XcmsColorSpace
	prefix as zstring ptr
	id as XcmsColorFormat
	parseString as XcmsParseStringProc
	to_CIEXYZ as XcmsFuncListPtr
	from_CIEXYZ as XcmsFuncListPtr
	inverse_flag as integer
end type

type XcmsColorSpace as _XcmsColorSpace

type _XcmsFunctionSet
	DDColorSpaces as XcmsColorSpace ptr ptr
	screenInitProc as XcmsScreenInitProc
	screenFreeProc as XcmsScreenFreeProc
end type

type XcmsFunctionSet as _XcmsFunctionSet

declare function XcmsAddFunctionSet cdecl alias "XcmsAddFunctionSet" (byval as XcmsFunctionSet ptr) as Status
declare function XcmsAllocColor cdecl alias "XcmsAllocColor" (byval as Display ptr, byval as Colormap, byval as XcmsColor ptr, byval as XcmsColorFormat) as Status
declare function XcmsCCCOfColormap cdecl alias "XcmsCCCOfColormap" (byval as Display ptr, byval as Colormap) as XcmsCCC
declare function XcmsCIELabClipab cdecl alias "XcmsCIELabClipab" (byval as XcmsCCC, byval as XcmsColor ptr, byval as uinteger, byval as uinteger, byval as Bool ptr) as Status
declare function XcmsCIELabClipL cdecl alias "XcmsCIELabClipL" (byval as XcmsCCC, byval as XcmsColor ptr, byval as uinteger, byval as uinteger, byval as Bool ptr) as Status
declare function XcmsCIELabClipLab cdecl alias "XcmsCIELabClipLab" (byval as XcmsCCC, byval as XcmsColor ptr, byval as uinteger, byval as uinteger, byval as Bool ptr) as Status
declare function XcmsCIELabQueryMaxC cdecl alias "XcmsCIELabQueryMaxC" (byval as XcmsCCC, byval as XcmsFloat, byval as XcmsFloat, byval as XcmsColor ptr) as Status
declare function XcmsCIELabQueryMaxL cdecl alias "XcmsCIELabQueryMaxL" (byval as XcmsCCC, byval as XcmsFloat, byval as XcmsFloat, byval as XcmsColor ptr) as Status
declare function XcmsCIELabQueryMaxLC cdecl alias "XcmsCIELabQueryMaxLC" (byval as XcmsCCC, byval as XcmsFloat, byval as XcmsColor ptr) as Status
declare function XcmsCIELabQueryMinL cdecl alias "XcmsCIELabQueryMinL" (byval as XcmsCCC, byval as XcmsFloat, byval as XcmsFloat, byval as XcmsColor ptr) as Status
declare function XcmsCIELabToCIEXYZ cdecl alias "XcmsCIELabToCIEXYZ" (byval as XcmsCCC, byval as XcmsColor ptr, byval as XcmsColor ptr, byval as uinteger) as Status
declare function XcmsCIELabWhiteShiftColors cdecl alias "XcmsCIELabWhiteShiftColors" (byval as XcmsCCC, byval as XcmsColor ptr, byval as XcmsColor ptr, byval as XcmsColorFormat, byval as XcmsColor ptr, byval as uinteger, byval as Bool ptr) as Status
declare function XcmsCIELuvClipL cdecl alias "XcmsCIELuvClipL" (byval as XcmsCCC, byval as XcmsColor ptr, byval as uinteger, byval as uinteger, byval as Bool ptr) as Status
declare function XcmsCIELuvClipLuv cdecl alias "XcmsCIELuvClipLuv" (byval as XcmsCCC, byval as XcmsColor ptr, byval as uinteger, byval as uinteger, byval as Bool ptr) as Status
declare function XcmsCIELuvClipuv cdecl alias "XcmsCIELuvClipuv" (byval as XcmsCCC, byval as XcmsColor ptr, byval as uinteger, byval as uinteger, byval as Bool ptr) as Status
declare function XcmsCIELuvQueryMaxC cdecl alias "XcmsCIELuvQueryMaxC" (byval as XcmsCCC, byval as XcmsFloat, byval as XcmsFloat, byval as XcmsColor ptr) as Status
declare function XcmsCIELuvQueryMaxL cdecl alias "XcmsCIELuvQueryMaxL" (byval as XcmsCCC, byval as XcmsFloat, byval as XcmsFloat, byval as XcmsColor ptr) as Status
declare function XcmsCIELuvQueryMaxLC cdecl alias "XcmsCIELuvQueryMaxLC" (byval as XcmsCCC, byval as XcmsFloat, byval as XcmsColor ptr) as Status
declare function XcmsCIELuvQueryMinL cdecl alias "XcmsCIELuvQueryMinL" (byval as XcmsCCC, byval as XcmsFloat, byval as XcmsFloat, byval as XcmsColor ptr) as Status
declare function XcmsCIELuvToCIEuvY cdecl alias "XcmsCIELuvToCIEuvY" (byval as XcmsCCC, byval as XcmsColor ptr, byval as XcmsColor ptr, byval as uinteger) as Status
declare function XcmsCIELuvWhiteShiftColors cdecl alias "XcmsCIELuvWhiteShiftColors" (byval as XcmsCCC, byval as XcmsColor ptr, byval as XcmsColor ptr, byval as XcmsColorFormat, byval as XcmsColor ptr, byval as uinteger, byval as Bool ptr) as Status
declare function XcmsCIEXYZToCIELab cdecl alias "XcmsCIEXYZToCIELab" (byval as XcmsCCC, byval as XcmsColor ptr, byval as XcmsColor ptr, byval as uinteger) as Status
declare function XcmsCIEXYZToCIEuvY cdecl alias "XcmsCIEXYZToCIEuvY" (byval as XcmsCCC, byval as XcmsColor ptr, byval as XcmsColor ptr, byval as uinteger) as Status
declare function XcmsCIEXYZToCIExyY cdecl alias "XcmsCIEXYZToCIExyY" (byval as XcmsCCC, byval as XcmsColor ptr, byval as XcmsColor ptr, byval as uinteger) as Status
declare function XcmsCIEXYZToRGBi cdecl alias "XcmsCIEXYZToRGBi" (byval as XcmsCCC, byval as XcmsColor ptr, byval as uinteger, byval as Bool ptr) as Status
declare function XcmsCIEuvYToCIELuv cdecl alias "XcmsCIEuvYToCIELuv" (byval as XcmsCCC, byval as XcmsColor ptr, byval as XcmsColor ptr, byval as uinteger) as Status
declare function XcmsCIEuvYToCIEXYZ cdecl alias "XcmsCIEuvYToCIEXYZ" (byval as XcmsCCC, byval as XcmsColor ptr, byval as XcmsColor ptr, byval as uinteger) as Status
declare function XcmsCIEuvYToTekHVC cdecl alias "XcmsCIEuvYToTekHVC" (byval as XcmsCCC, byval as XcmsColor ptr, byval as XcmsColor ptr, byval as uinteger) as Status
declare function XcmsCIExyYToCIEXYZ cdecl alias "XcmsCIExyYToCIEXYZ" (byval as XcmsCCC, byval as XcmsColor ptr, byval as XcmsColor ptr, byval as uinteger) as Status
declare function XcmsClientWhitePointOfCCC cdecl alias "XcmsClientWhitePointOfCCC" (byval as XcmsCCC) as XcmsColor ptr
declare function XcmsConvertColors cdecl alias "XcmsConvertColors" (byval as XcmsCCC, byval as XcmsColor ptr, byval as uinteger, byval as XcmsColorFormat, byval as Bool ptr) as Status
declare function XcmsCreateCCC cdecl alias "XcmsCreateCCC" (byval as Display ptr, byval as integer, byval as Visual ptr, byval as XcmsColor ptr, byval as XcmsCompressionProc, byval as XPointer, byval as XcmsWhiteAdjustProc, byval as XPointer) as XcmsCCC
declare function XcmsDefaultCCC cdecl alias "XcmsDefaultCCC" (byval as Display ptr, byval as integer) as XcmsCCC
declare function XcmsDisplayOfCCC cdecl alias "XcmsDisplayOfCCC" (byval as XcmsCCC) as Display ptr
declare function XcmsFormatOfPrefix cdecl alias "XcmsFormatOfPrefix" (byval as zstring ptr) as XcmsColorFormat
declare sub XcmsFreeCCC cdecl alias "XcmsFreeCCC" (byval as XcmsCCC)
declare function XcmsPrefixOfFormat cdecl alias "XcmsPrefixOfFormat" (byval as XcmsColorFormat) as zstring ptr
declare function XcmsQueryBlack cdecl alias "XcmsQueryBlack" (byval as XcmsCCC, byval as XcmsColorFormat, byval as XcmsColor ptr) as Status
declare function XcmsQueryBlue cdecl alias "XcmsQueryBlue" (byval as XcmsCCC, byval as XcmsColorFormat, byval as XcmsColor ptr) as Status
declare function XcmsQueryColor cdecl alias "XcmsQueryColor" (byval as Display ptr, byval as Colormap, byval as XcmsColor ptr, byval as XcmsColorFormat) as Status
declare function XcmsQueryColors cdecl alias "XcmsQueryColors" (byval as Display ptr, byval as Colormap, byval as XcmsColor ptr, byval as uinteger, byval as XcmsColorFormat) as Status
declare function XcmsQueryGreen cdecl alias "XcmsQueryGreen" (byval as XcmsCCC, byval as XcmsColorFormat, byval as XcmsColor ptr) as Status
declare function XcmsQueryRed cdecl alias "XcmsQueryRed" (byval as XcmsCCC, byval as XcmsColorFormat, byval as XcmsColor ptr) as Status
declare function XcmsQueryWhite cdecl alias "XcmsQueryWhite" (byval as XcmsCCC, byval as XcmsColorFormat, byval as XcmsColor ptr) as Status
declare function XcmsRGBiToCIEXYZ cdecl alias "XcmsRGBiToCIEXYZ" (byval as XcmsCCC, byval as XcmsColor ptr, byval as uinteger, byval as Bool ptr) as Status
declare function XcmsRGBiToRGB cdecl alias "XcmsRGBiToRGB" (byval as XcmsCCC, byval as XcmsColor ptr, byval as uinteger, byval as Bool ptr) as Status
declare function XcmsRGBToRGBi cdecl alias "XcmsRGBToRGBi" (byval as XcmsCCC, byval as XcmsColor ptr, byval as uinteger, byval as Bool ptr) as Status
declare function XcmsScreenNumberOfCCC cdecl alias "XcmsScreenNumberOfCCC" (byval as XcmsCCC) as integer
declare function XcmsScreenWhitePointOfCCC cdecl alias "XcmsScreenWhitePointOfCCC" (byval as XcmsCCC) as XcmsColor ptr
declare function XcmsSetCCCOfColormap cdecl alias "XcmsSetCCCOfColormap" (byval as Display ptr, byval as Colormap, byval as XcmsCCC) as XcmsCCC
declare function XcmsSetCompressionProc cdecl alias "XcmsSetCompressionProc" (byval as XcmsCCC, byval as XcmsCompressionProc, byval as XPointer) as XcmsCompressionProc
declare function XcmsSetWhiteAdjustProc cdecl alias "XcmsSetWhiteAdjustProc" (byval as XcmsCCC, byval as XcmsWhiteAdjustProc, byval as XPointer) as XcmsWhiteAdjustProc
declare function XcmsSetWhitePoint cdecl alias "XcmsSetWhitePoint" (byval as XcmsCCC, byval as XcmsColor ptr) as Status
declare function XcmsStoreColor cdecl alias "XcmsStoreColor" (byval as Display ptr, byval as Colormap, byval as XcmsColor ptr) as Status
declare function XcmsStoreColors cdecl alias "XcmsStoreColors" (byval as Display ptr, byval as Colormap, byval as XcmsColor ptr, byval as uinteger, byval as Bool ptr) as Status
declare function XcmsTekHVCClipC cdecl alias "XcmsTekHVCClipC" (byval as XcmsCCC, byval as XcmsColor ptr, byval as uinteger, byval as uinteger, byval as Bool ptr) as Status
declare function XcmsTekHVCClipV cdecl alias "XcmsTekHVCClipV" (byval as XcmsCCC, byval as XcmsColor ptr, byval as uinteger, byval as uinteger, byval as Bool ptr) as Status
declare function XcmsTekHVCClipVC cdecl alias "XcmsTekHVCClipVC" (byval as XcmsCCC, byval as XcmsColor ptr, byval as uinteger, byval as uinteger, byval as Bool ptr) as Status
declare function XcmsTekHVCQueryMaxC cdecl alias "XcmsTekHVCQueryMaxC" (byval as XcmsCCC, byval as XcmsFloat, byval as XcmsFloat, byval as XcmsColor ptr) as Status
declare function XcmsTekHVCQueryMaxV cdecl alias "XcmsTekHVCQueryMaxV" (byval as XcmsCCC, byval as XcmsFloat, byval as XcmsFloat, byval as XcmsColor ptr) as Status
declare function XcmsTekHVCQueryMaxVC cdecl alias "XcmsTekHVCQueryMaxVC" (byval as XcmsCCC, byval as XcmsFloat, byval as XcmsColor ptr) as Status
declare function XcmsTekHVCQueryMaxVSamples cdecl alias "XcmsTekHVCQueryMaxVSamples" (byval as XcmsCCC, byval as XcmsFloat, byval as XcmsColor ptr, byval as uinteger) as Status
declare function XcmsTekHVCQueryMinV cdecl alias "XcmsTekHVCQueryMinV" (byval as XcmsCCC, byval as XcmsFloat, byval as XcmsFloat, byval as XcmsColor ptr) as Status
declare function XcmsTekHVCToCIEuvY cdecl alias "XcmsTekHVCToCIEuvY" (byval as XcmsCCC, byval as XcmsColor ptr, byval as XcmsColor ptr, byval as uinteger) as Status
declare function XcmsTekHVCWhiteShiftColors cdecl alias "XcmsTekHVCWhiteShiftColors" (byval as XcmsCCC, byval as XcmsColor ptr, byval as XcmsColor ptr, byval as XcmsColorFormat, byval as XcmsColor ptr, byval as uinteger, byval as Bool ptr) as Status
declare function XcmsVisualOfCCC cdecl alias "XcmsVisualOfCCC" (byval as XcmsCCC) as Visual ptr

#endif
