''
''
'' Xmu -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __Xmu_bi__
#define __Xmu_bi__

type _XmuSegment
	x1 as integer
	x2 as integer
	next as _XmuSegment ptr
end type

type XmuSegment as _XmuSegment

type _XmuScanline
	y as integer
	segment as XmuSegment ptr
	next as _XmuScanline ptr
end type

type XmuScanline as _XmuScanline

type _XmuArea
	scanline as XmuScanline ptr
end type

type XmuArea as _XmuArea

declare function XmuNewArea cdecl alias "XmuNewArea" (byval as integer, byval as integer, byval as integer, byval as integer) as XmuArea ptr
declare function XmuAreaDup cdecl alias "XmuAreaDup" (byval as XmuArea ptr) as XmuArea ptr
declare function XmuAreaCopy cdecl alias "XmuAreaCopy" (byval as XmuArea ptr, byval as XmuArea ptr) as XmuArea ptr
declare function XmuAreaNot cdecl alias "XmuAreaNot" (byval as XmuArea ptr, byval as integer, byval as integer, byval as integer, byval as integer) as XmuArea ptr
declare function XmuAreaOrXor cdecl alias "XmuAreaOrXor" (byval as XmuArea ptr, byval as XmuArea ptr, byval as Bool) as XmuArea ptr
declare function XmuAreaAnd cdecl alias "XmuAreaAnd" (byval as XmuArea ptr, byval as XmuArea ptr) as XmuArea ptr
declare function XmuValidArea cdecl alias "XmuValidArea" (byval as XmuArea ptr) as Bool
declare function XmuValidScanline cdecl alias "XmuValidScanline" (byval as XmuScanline ptr) as Bool
declare function XmuScanlineEqu cdecl alias "XmuScanlineEqu" (byval as XmuScanline ptr, byval as XmuScanline ptr) as Bool
declare function XmuNewSegment cdecl alias "XmuNewSegment" (byval as integer, byval as integer) as XmuSegment ptr
declare sub XmuDestroySegmentList cdecl alias "XmuDestroySegmentList" (byval as XmuSegment ptr)
declare function XmuScanlineCopy cdecl alias "XmuScanlineCopy" (byval as XmuScanline ptr, byval as XmuScanline ptr) as XmuScanline ptr
declare function XmuAppendSegment cdecl alias "XmuAppendSegment" (byval as XmuSegment ptr, byval as XmuSegment ptr) as Bool
declare function XmuOptimizeScanline cdecl alias "XmuOptimizeScanline" (byval as XmuScanline ptr) as XmuScanline ptr
declare function XmuScanlineNot cdecl alias "XmuScanlineNot" (byval scanline as XmuScanline ptr, byval as integer, byval as integer) as XmuScanline ptr
declare function XmuScanlineOr cdecl alias "XmuScanlineOr" (byval as XmuScanline ptr, byval as XmuScanline ptr) as XmuScanline ptr
declare function XmuScanlineAnd cdecl alias "XmuScanlineAnd" (byval as XmuScanline ptr, byval as XmuScanline ptr) as XmuScanline ptr
declare function XmuScanlineXor cdecl alias "XmuScanlineXor" (byval as XmuScanline ptr, byval as XmuScanline ptr) as XmuScanline ptr
declare function XmuNewScanline cdecl alias "XmuNewScanline" (byval as integer, byval as integer, byval as integer) as XmuScanline ptr
declare sub XmuDestroyScanlineList cdecl alias "XmuDestroyScanlineList" (byval as XmuScanline ptr)
declare function XmuOptimizeArea cdecl alias "XmuOptimizeArea" (byval area as XmuArea ptr) as XmuArea ptr
declare function XmuScanlineOrSegment cdecl alias "XmuScanlineOrSegment" (byval as XmuScanline ptr, byval as XmuSegment ptr) as XmuScanline ptr
declare function XmuScanlineAndSegment cdecl alias "XmuScanlineAndSegment" (byval as XmuScanline ptr, byval as XmuSegment ptr) as XmuScanline ptr
declare function XmuScanlineXorSegment cdecl alias "XmuScanlineXorSegment" (byval as XmuScanline ptr, byval as XmuSegment ptr) as XmuScanline ptr

#endif
