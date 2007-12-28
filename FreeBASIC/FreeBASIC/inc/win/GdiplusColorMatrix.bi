''
''
'' GdiplusColorMatrix -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_GdiplusColorMatrix_bi__
#define __win_GdiplusColorMatrix_bi__

type ColorMatrix
	m(0 to 5-1, 0 to 5-1) as REAL
end type

enum ColorMatrixFlags
	ColorMatrixFlagsDefault = 0
	ColorMatrixFlagsSkipGrays = 1
	ColorMatrixFlagsAltGray = 2
end enum

enum ColorAdjustType
	ColorAdjustTypeDefault
	ColorAdjustTypeBitmap
	ColorAdjustTypeBrush
	ColorAdjustTypePen
	ColorAdjustTypeText
	ColorAdjustTypeCount
	ColorAdjustTypeAny
end enum

type ColorMap
	oldColor as Color
	newColor as Color
end type

#endif
