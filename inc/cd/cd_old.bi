''
''
'' cd_old -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __cd_old_bi__
#define __cd_old_bi__

extern "C"

declare function cdActivate (byval canvas as cdCanvas ptr) as integer
declare function cdActiveCanvas () as cdCanvas ptr
declare function cdSimulate (byval mode as integer) as integer
declare sub cdFlush ()
declare sub cdClear ()
declare function cdSaveState () as cdState ptr
declare sub cdRestoreState (byval state as cdState ptr)
declare sub cdSetAttribute (byval name as zstring ptr, byval data as zstring ptr)
declare sub cdSetfAttribute (byval name as zstring ptr, byval format as zstring ptr, ...)
declare function cdGetAttribute (byval name as zstring ptr) as zstring ptr
declare function cdGetContext (byval canvas as cdCanvas ptr) as cdContext ptr
declare function cdRegisterCallback (byval context as cdContext ptr, byval cb as integer, byval func as cdCallback) as integer
declare function cdPlay (byval context as cdContext ptr, byval xmin as integer, byval xmax as integer, byval ymin as integer, byval ymax as integer, byval data as any ptr) as integer
declare sub cdGetCanvasSize (byval width as integer ptr, byval height as integer ptr, byval width_mm as double ptr, byval height_mm as double ptr)
declare function cdUpdateYAxis (byval y as integer ptr) as integer
declare sub cdMM2Pixel (byval mm_dx as double, byval mm_dy as double, byval dx as integer ptr, byval dy as integer ptr)
declare sub cdPixel2MM (byval dx as integer, byval dy as integer, byval mm_dx as double ptr, byval mm_dy as double ptr)
declare sub cdOrigin (byval x as integer, byval y as integer)
declare function cdClip (byval mode as integer) as integer
declare function cdGetClipPoly (byval n as integer ptr) as integer ptr
declare sub cdClipArea (byval xmin as integer, byval xmax as integer, byval ymin as integer, byval ymax as integer)
declare function cdGetClipArea (byval xmin as integer ptr, byval xmax as integer ptr, byval ymin as integer ptr, byval ymax as integer ptr) as integer
declare function cdPointInRegion (byval x as integer, byval y as integer) as integer
declare sub cdOffsetRegion (byval x as integer, byval y as integer)
declare sub cdRegionBox (byval xmin as integer ptr, byval xmax as integer ptr, byval ymin as integer ptr, byval ymax as integer ptr)
declare function cdRegionCombineMode (byval mode as integer) as integer
declare sub cdPixel (byval x as integer, byval y as integer, byval color as integer)
declare sub cdMark (byval x as integer, byval y as integer)
declare sub cdLine (byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer)
declare sub cdBegin (byval mode as integer)
declare sub cdVertex (byval x as integer, byval y as integer)
declare sub cdEnd ()
declare sub cdRect (byval xmin as integer, byval xmax as integer, byval ymin as integer, byval ymax as integer)
declare sub cdBox (byval xmin as integer, byval xmax as integer, byval ymin as integer, byval ymax as integer)
declare sub cdArc (byval xc as integer, byval yc as integer, byval w as integer, byval h as integer, byval angle1 as double, byval angle2 as double)
declare sub cdSector (byval xc as integer, byval yc as integer, byval w as integer, byval h as integer, byval angle1 as double, byval angle2 as double)
declare sub cdChord (byval xc as integer, byval yc as integer, byval w as integer, byval h as integer, byval angle1 as double, byval angle2 as double)
declare sub cdText (byval x as integer, byval y as integer, byval s as zstring ptr)
declare function cdBackground (byval color as integer) as integer
declare function cdForeground (byval color as integer) as integer
declare function cdBackOpacity (byval opacity as integer) as integer
declare function cdWriteMode (byval mode as integer) as integer
declare function cdLineStyle (byval style as integer) as integer
declare sub cdLineStyleDashes (byval dashes as integer ptr, byval count as integer)
declare function cdLineWidth (byval width as integer) as integer
declare function cdLineJoin (byval join as integer) as integer
declare function cdLineCap (byval cap as integer) as integer
declare function cdInteriorStyle (byval style as integer) as integer
declare function cdHatch (byval style as integer) as integer
declare sub cdStipple (byval w as integer, byval h as integer, byval stipple as ubyte ptr)
declare function cdGetStipple (byval n as integer ptr, byval m as integer ptr) as ubyte ptr
declare sub cdPattern (byval w as integer, byval h as integer, byval pattern as integer ptr)
declare function cdGetPattern (byval n as integer ptr, byval m as integer ptr) as integer ptr
declare function cdFillMode (byval mode as integer) as integer
declare sub cdFont (byval type_face as integer, byval style as integer, byval size as integer)
declare sub cdGetFont (byval type_face as integer ptr, byval style as integer ptr, byval size as integer ptr)
declare function cdNativeFont (byval font as zstring ptr) as zstring ptr
declare function cdTextAlignment (byval alignment as integer) as integer
declare function cdTextOrientation (byval angle as double) as double
declare function cdMarkType (byval type as integer) as integer
declare function cdMarkSize (byval size as integer) as integer
declare sub cdVectorText (byval x as integer, byval y as integer, byval s as zstring ptr)
declare sub cdMultiLineVectorText (byval x as integer, byval y as integer, byval s as zstring ptr)
declare function cdVectorFont (byval filename as zstring ptr) as zstring ptr
declare sub cdVectorTextDirection (byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer)
declare function cdVectorTextTransform (byval matrix as double ptr) as double ptr
declare sub cdVectorTextSize (byval size_x as integer, byval size_y as integer, byval s as zstring ptr)
declare function cdVectorCharSize (byval size as integer) as integer
declare sub cdGetVectorTextSize (byval s as zstring ptr, byval x as integer ptr, byval y as integer ptr)
declare sub cdGetVectorTextBounds (byval s as zstring ptr, byval x as integer, byval y as integer, byval rect as integer ptr)
declare sub cdFontDim (byval max_width as integer ptr, byval height as integer ptr, byval ascent as integer ptr, byval descent as integer ptr)
declare sub cdTextSize (byval s as zstring ptr, byval width as integer ptr, byval height as integer ptr)
declare sub cdTextBox (byval x as integer, byval y as integer, byval s as zstring ptr, byval xmin as integer ptr, byval xmax as integer ptr, byval ymin as integer ptr, byval ymax as integer ptr)
declare sub cdTextBounds (byval x as integer, byval y as integer, byval s as zstring ptr, byval rect as integer ptr)
declare function cdGetColorPlanes () as integer
declare sub cdPalette (byval n as integer, byval palette as integer ptr, byval mode as integer)
declare sub cdGetImageRGB (byval r as ubyte ptr, byval g as ubyte ptr, byval b as ubyte ptr, byval x as integer, byval y as integer, byval w as integer, byval h as integer)
declare sub cdPutImageRectRGB (byval iw as integer, byval ih as integer, byval r as ubyte ptr, byval g as ubyte ptr, byval b as ubyte ptr, byval x as integer, byval y as integer, byval w as integer, byval h as integer, byval xmin as integer, byval xmax as integer, byval ymin as integer, byval ymax as integer)
declare sub cdPutImageRectRGBA (byval iw as integer, byval ih as integer, byval r as ubyte ptr, byval g as ubyte ptr, byval b as ubyte ptr, byval a as ubyte ptr, byval x as integer, byval y as integer, byval w as integer, byval h as integer, byval xmin as integer, byval xmax as integer, byval ymin as integer, byval ymax as integer)
declare sub cdPutImageRectMap (byval iw as integer, byval ih as integer, byval index as ubyte ptr, byval colors as integer ptr, byval x as integer, byval y as integer, byval w as integer, byval h as integer, byval xmin as integer, byval xmax as integer, byval ymin as integer, byval ymax as integer)
declare function cdCreateImage (byval w as integer, byval h as integer) as cdImage ptr
declare sub cdGetImage (byval image as cdImage ptr, byval x as integer, byval y as integer)
declare sub cdPutImageRect (byval image as cdImage ptr, byval x as integer, byval y as integer, byval xmin as integer, byval xmax as integer, byval ymin as integer, byval ymax as integer)
declare sub cdScrollArea (byval xmin as integer, byval xmax as integer, byval ymin as integer, byval ymax as integer, byval dx as integer, byval dy as integer)
declare sub cdPutBitmap (byval bitmap as cdBitmap ptr, byval x as integer, byval y as integer, byval w as integer, byval h as integer)
declare sub cdGetBitmap (byval bitmap as cdBitmap ptr, byval x as integer, byval y as integer)

end extern

enum 
	CD_SYSTEM
	CD_COURIER
	CD_TIMES_ROMAN
	CD_HELVETICA
	CD_NATIVE
end enum

#endif
