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

declare function cdActivate cdecl alias "cdActivate" (byval canvas as cdCanvas ptr) as integer
declare function cdActiveCanvas cdecl alias "cdActiveCanvas" () as cdCanvas ptr
declare function cdSimulate cdecl alias "cdSimulate" (byval mode as integer) as integer
declare sub cdFlush cdecl alias "cdFlush" ()
declare sub cdClear cdecl alias "cdClear" ()
declare function cdSaveState cdecl alias "cdSaveState" () as cdState ptr
declare sub cdRestoreState cdecl alias "cdRestoreState" (byval state as cdState ptr)
declare sub cdSetAttribute cdecl alias "cdSetAttribute" (byval name as zstring ptr, byval data as zstring ptr)
declare sub cdSetfAttribute cdecl alias "cdSetfAttribute" (byval name as zstring ptr, byval format as zstring ptr, ...)
declare function cdGetAttribute cdecl alias "cdGetAttribute" (byval name as zstring ptr) as zstring ptr
declare function cdGetContext cdecl alias "cdGetContext" (byval canvas as cdCanvas ptr) as cdContext ptr
declare function cdRegisterCallback cdecl alias "cdRegisterCallback" (byval context as cdContext ptr, byval cb as integer, byval func as cdCallback) as integer
declare function cdPlay cdecl alias "cdPlay" (byval context as cdContext ptr, byval xmin as integer, byval xmax as integer, byval ymin as integer, byval ymax as integer, byval data as any ptr) as integer
declare sub cdGetCanvasSize cdecl alias "cdGetCanvasSize" (byval width as integer ptr, byval height as integer ptr, byval width_mm as double ptr, byval height_mm as double ptr)
declare function cdUpdateYAxis cdecl alias "cdUpdateYAxis" (byval y as integer ptr) as integer
declare sub cdMM2Pixel cdecl alias "cdMM2Pixel" (byval mm_dx as double, byval mm_dy as double, byval dx as integer ptr, byval dy as integer ptr)
declare sub cdPixel2MM cdecl alias "cdPixel2MM" (byval dx as integer, byval dy as integer, byval mm_dx as double ptr, byval mm_dy as double ptr)
declare sub cdOrigin cdecl alias "cdOrigin" (byval x as integer, byval y as integer)
declare function cdClip cdecl alias "cdClip" (byval mode as integer) as integer
declare function cdGetClipPoly cdecl alias "cdGetClipPoly" (byval n as integer ptr) as integer ptr
declare sub cdClipArea cdecl alias "cdClipArea" (byval xmin as integer, byval xmax as integer, byval ymin as integer, byval ymax as integer)
declare function cdGetClipArea cdecl alias "cdGetClipArea" (byval xmin as integer ptr, byval xmax as integer ptr, byval ymin as integer ptr, byval ymax as integer ptr) as integer
declare function cdPointInRegion cdecl alias "cdPointInRegion" (byval x as integer, byval y as integer) as integer
declare sub cdOffsetRegion cdecl alias "cdOffsetRegion" (byval x as integer, byval y as integer)
declare sub cdRegionBox cdecl alias "cdRegionBox" (byval xmin as integer ptr, byval xmax as integer ptr, byval ymin as integer ptr, byval ymax as integer ptr)
declare function cdRegionCombineMode cdecl alias "cdRegionCombineMode" (byval mode as integer) as integer
declare sub cdPixel cdecl alias "cdPixel" (byval x as integer, byval y as integer, byval color as integer)
declare sub cdMark cdecl alias "cdMark" (byval x as integer, byval y as integer)
declare sub cdLine cdecl alias "cdLine" (byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer)
declare sub cdBegin cdecl alias "cdBegin" (byval mode as integer)
declare sub cdVertex cdecl alias "cdVertex" (byval x as integer, byval y as integer)
declare sub cdEnd cdecl alias "cdEnd" ()
declare sub cdRect cdecl alias "cdRect" (byval xmin as integer, byval xmax as integer, byval ymin as integer, byval ymax as integer)
declare sub cdBox cdecl alias "cdBox" (byval xmin as integer, byval xmax as integer, byval ymin as integer, byval ymax as integer)
declare sub cdArc cdecl alias "cdArc" (byval xc as integer, byval yc as integer, byval w as integer, byval h as integer, byval angle1 as double, byval angle2 as double)
declare sub cdSector cdecl alias "cdSector" (byval xc as integer, byval yc as integer, byval w as integer, byval h as integer, byval angle1 as double, byval angle2 as double)
declare sub cdChord cdecl alias "cdChord" (byval xc as integer, byval yc as integer, byval w as integer, byval h as integer, byval angle1 as double, byval angle2 as double)
declare sub cdText cdecl alias "cdText" (byval x as integer, byval y as integer, byval s as zstring ptr)
declare function cdBackground cdecl alias "cdBackground" (byval color as integer) as integer
declare function cdForeground cdecl alias "cdForeground" (byval color as integer) as integer
declare function cdBackOpacity cdecl alias "cdBackOpacity" (byval opacity as integer) as integer
declare function cdWriteMode cdecl alias "cdWriteMode" (byval mode as integer) as integer
declare function cdLineStyle cdecl alias "cdLineStyle" (byval style as integer) as integer
declare sub cdLineStyleDashes cdecl alias "cdLineStyleDashes" (byval dashes as integer ptr, byval count as integer)
declare function cdLineWidth cdecl alias "cdLineWidth" (byval width as integer) as integer
declare function cdLineJoin cdecl alias "cdLineJoin" (byval join as integer) as integer
declare function cdLineCap cdecl alias "cdLineCap" (byval cap as integer) as integer
declare function cdInteriorStyle cdecl alias "cdInteriorStyle" (byval style as integer) as integer
declare function cdHatch cdecl alias "cdHatch" (byval style as integer) as integer
declare sub cdStipple cdecl alias "cdStipple" (byval w as integer, byval h as integer, byval stipple as ubyte ptr)
declare function cdGetStipple cdecl alias "cdGetStipple" (byval n as integer ptr, byval m as integer ptr) as ubyte ptr
declare sub cdPattern cdecl alias "cdPattern" (byval w as integer, byval h as integer, byval pattern as integer ptr)
declare function cdGetPattern cdecl alias "cdGetPattern" (byval n as integer ptr, byval m as integer ptr) as integer ptr
declare function cdFillMode cdecl alias "cdFillMode" (byval mode as integer) as integer
declare sub cdFont cdecl alias "cdFont" (byval type_face as integer, byval style as integer, byval size as integer)
declare sub cdGetFont cdecl alias "cdGetFont" (byval type_face as integer ptr, byval style as integer ptr, byval size as integer ptr)
declare function cdNativeFont cdecl alias "cdNativeFont" (byval font as zstring ptr) as zstring ptr
declare function cdTextAlignment cdecl alias "cdTextAlignment" (byval alignment as integer) as integer
declare function cdTextOrientation cdecl alias "cdTextOrientation" (byval angle as double) as double
declare function cdMarkType cdecl alias "cdMarkType" (byval type as integer) as integer
declare function cdMarkSize cdecl alias "cdMarkSize" (byval size as integer) as integer
declare sub cdVectorText cdecl alias "cdVectorText" (byval x as integer, byval y as integer, byval s as zstring ptr)
declare sub cdMultiLineVectorText cdecl alias "cdMultiLineVectorText" (byval x as integer, byval y as integer, byval s as zstring ptr)
declare function cdVectorFont cdecl alias "cdVectorFont" (byval filename as zstring ptr) as zstring ptr
declare sub cdVectorTextDirection cdecl alias "cdVectorTextDirection" (byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer)
declare function cdVectorTextTransform cdecl alias "cdVectorTextTransform" (byval matrix as double ptr) as double ptr
declare sub cdVectorTextSize cdecl alias "cdVectorTextSize" (byval size_x as integer, byval size_y as integer, byval s as zstring ptr)
declare function cdVectorCharSize cdecl alias "cdVectorCharSize" (byval size as integer) as integer
declare sub cdGetVectorTextSize cdecl alias "cdGetVectorTextSize" (byval s as zstring ptr, byval x as integer ptr, byval y as integer ptr)
declare sub cdGetVectorTextBounds cdecl alias "cdGetVectorTextBounds" (byval s as zstring ptr, byval x as integer, byval y as integer, byval rect as integer ptr)
declare sub cdFontDim cdecl alias "cdFontDim" (byval max_width as integer ptr, byval height as integer ptr, byval ascent as integer ptr, byval descent as integer ptr)
declare sub cdTextSize cdecl alias "cdTextSize" (byval s as zstring ptr, byval width as integer ptr, byval height as integer ptr)
declare sub cdTextBox cdecl alias "cdTextBox" (byval x as integer, byval y as integer, byval s as zstring ptr, byval xmin as integer ptr, byval xmax as integer ptr, byval ymin as integer ptr, byval ymax as integer ptr)
declare sub cdTextBounds cdecl alias "cdTextBounds" (byval x as integer, byval y as integer, byval s as zstring ptr, byval rect as integer ptr)
declare function cdGetColorPlanes cdecl alias "cdGetColorPlanes" () as integer
declare sub cdPalette cdecl alias "cdPalette" (byval n as integer, byval palette as integer ptr, byval mode as integer)
declare sub cdGetImageRGB cdecl alias "cdGetImageRGB" (byval r as ubyte ptr, byval g as ubyte ptr, byval b as ubyte ptr, byval x as integer, byval y as integer, byval w as integer, byval h as integer)
declare sub cdPutImageRectRGB cdecl alias "cdPutImageRectRGB" (byval iw as integer, byval ih as integer, byval r as ubyte ptr, byval g as ubyte ptr, byval b as ubyte ptr, byval x as integer, byval y as integer, byval w as integer, byval h as integer, byval xmin as integer, byval xmax as integer, byval ymin as integer, byval ymax as integer)
declare sub cdPutImageRectRGBA cdecl alias "cdPutImageRectRGBA" (byval iw as integer, byval ih as integer, byval r as ubyte ptr, byval g as ubyte ptr, byval b as ubyte ptr, byval a as ubyte ptr, byval x as integer, byval y as integer, byval w as integer, byval h as integer, byval xmin as integer, byval xmax as integer, byval ymin as integer, byval ymax as integer)
declare sub cdPutImageRectMap cdecl alias "cdPutImageRectMap" (byval iw as integer, byval ih as integer, byval index as ubyte ptr, byval colors as integer ptr, byval x as integer, byval y as integer, byval w as integer, byval h as integer, byval xmin as integer, byval xmax as integer, byval ymin as integer, byval ymax as integer)
declare function cdCreateImage cdecl alias "cdCreateImage" (byval w as integer, byval h as integer) as cdImage ptr
declare sub cdGetImage cdecl alias "cdGetImage" (byval image as cdImage ptr, byval x as integer, byval y as integer)
declare sub cdPutImageRect cdecl alias "cdPutImageRect" (byval image as cdImage ptr, byval x as integer, byval y as integer, byval xmin as integer, byval xmax as integer, byval ymin as integer, byval ymax as integer)
declare sub cdScrollArea cdecl alias "cdScrollArea" (byval xmin as integer, byval xmax as integer, byval ymin as integer, byval ymax as integer, byval dx as integer, byval dy as integer)
declare sub cdPutBitmap cdecl alias "cdPutBitmap" (byval bitmap as cdBitmap ptr, byval x as integer, byval y as integer, byval w as integer, byval h as integer)
declare sub cdGetBitmap cdecl alias "cdGetBitmap" (byval bitmap as cdBitmap ptr, byval x as integer, byval y as integer)

enum 
	CD_SYSTEM
	CD_COURIER
	CD_TIMES_ROMAN
	CD_HELVETICA
	CD_NATIVE
end enum

#endif
