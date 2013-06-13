''
''
'' wd -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wd_bi__
#define __wd_bi__

declare sub wdCanvasWindow cdecl alias "wdCanvasWindow" (byval canvas as cdCanvas ptr, byval xmin as double, byval xmax as double, byval ymin as double, byval ymax as double)
declare sub wdCanvasGetWindow cdecl alias "wdCanvasGetWindow" (byval canvas as cdCanvas ptr, byval xmin as double ptr, byval xmax as double ptr, byval ymin as double ptr, byval ymax as double ptr)
declare sub wdCanvasViewport cdecl alias "wdCanvasViewport" (byval canvas as cdCanvas ptr, byval xmin as integer, byval xmax as integer, byval ymin as integer, byval ymax as integer)
declare sub wdCanvasGetViewport cdecl alias "wdCanvasGetViewport" (byval canvas as cdCanvas ptr, byval xmin as integer ptr, byval xmax as integer ptr, byval ymin as integer ptr, byval ymax as integer ptr)
declare sub wdCanvasWorld2Canvas cdecl alias "wdCanvasWorld2Canvas" (byval canvas as cdCanvas ptr, byval xw as double, byval yw as double, byval xv as integer ptr, byval yv as integer ptr)
declare sub wdCanvasWorld2CanvasSize cdecl alias "wdCanvasWorld2CanvasSize" (byval canvas as cdCanvas ptr, byval hw as double, byval vw as double, byval hv as integer ptr, byval vv as integer ptr)
declare sub wdCanvasCanvas2World cdecl alias "wdCanvasCanvas2World" (byval canvas as cdCanvas ptr, byval xv as integer, byval yv as integer, byval xw as double ptr, byval yw as double ptr)
declare sub wdCanvasSetTransform cdecl alias "wdCanvasSetTransform" (byval canvas as cdCanvas ptr, byval sx as double, byval sy as double, byval tx as double, byval ty as double)
declare sub wdCanvasGetTransform cdecl alias "wdCanvasGetTransform" (byval canvas as cdCanvas ptr, byval sx as double ptr, byval sy as double ptr, byval tx as double ptr, byval ty as double ptr)
declare sub wdCanvasTranslate cdecl alias "wdCanvasTranslate" (byval canvas as cdCanvas ptr, byval dtx as double, byval dty as double)
declare sub wdCanvasScale cdecl alias "wdCanvasScale" (byval canvas as cdCanvas ptr, byval dsx as double, byval dsy as double)
declare sub wdCanvasClipArea cdecl alias "wdCanvasClipArea" (byval canvas as cdCanvas ptr, byval xmin as double, byval xmax as double, byval ymin as double, byval ymax as double)
declare function wdCanvasGetClipArea cdecl alias "wdCanvasGetClipArea" (byval canvas as cdCanvas ptr, byval xmin as double ptr, byval xmax as double ptr, byval ymin as double ptr, byval ymax as double ptr) as integer
declare function wdCanvasIsPointInRegion cdecl alias "wdCanvasIsPointInRegion" (byval canvas as cdCanvas ptr, byval x as double, byval y as double) as integer
declare sub wdCanvasOffsetRegion cdecl alias "wdCanvasOffsetRegion" (byval canvas as cdCanvas ptr, byval x as double, byval y as double)
declare sub wdCanvasGetRegionBox cdecl alias "wdCanvasGetRegionBox" (byval canvas as cdCanvas ptr, byval xmin as double ptr, byval xmax as double ptr, byval ymin as double ptr, byval ymax as double ptr)
declare sub wdCanvasHardcopy cdecl alias "wdCanvasHardcopy" (byval canvas as cdCanvas ptr, byval ctx as cdContext ptr, byval data as any ptr, byval draw_func as sub cdecl(byval as cdCanvas ptr))
declare sub wdCanvasPixel cdecl alias "wdCanvasPixel" (byval canvas as cdCanvas ptr, byval x as double, byval y as double, byval color as integer)
declare sub wdCanvasMark cdecl alias "wdCanvasMark" (byval canvas as cdCanvas ptr, byval x as double, byval y as double)
declare sub wdCanvasLine cdecl alias "wdCanvasLine" (byval canvas as cdCanvas ptr, byval x1 as double, byval y1 as double, byval x2 as double, byval y2 as double)
declare sub wdCanvasVertex cdecl alias "wdCanvasVertex" (byval canvas as cdCanvas ptr, byval x as double, byval y as double)
declare sub wdCanvasRect cdecl alias "wdCanvasRect" (byval canvas as cdCanvas ptr, byval xmin as double, byval xmax as double, byval ymin as double, byval ymax as double)
declare sub wdCanvasBox cdecl alias "wdCanvasBox" (byval canvas as cdCanvas ptr, byval xmin as double, byval xmax as double, byval ymin as double, byval ymax as double)
declare sub wdCanvasArc cdecl alias "wdCanvasArc" (byval canvas as cdCanvas ptr, byval xc as double, byval yc as double, byval w as double, byval h as double, byval angle1 as double, byval angle2 as double)
declare sub wdCanvasSector cdecl alias "wdCanvasSector" (byval canvas as cdCanvas ptr, byval xc as double, byval yc as double, byval w as double, byval h as double, byval angle1 as double, byval angle2 as double)
declare sub wdCanvasChord cdecl alias "wdCanvasChord" (byval canvas as cdCanvas ptr, byval xc as double, byval yc as double, byval w as double, byval h as double, byval angle1 as double, byval angle2 as double)
declare sub wdCanvasText cdecl alias "wdCanvasText" (byval canvas as cdCanvas ptr, byval x as double, byval y as double, byval s as zstring ptr)
declare sub wdCanvasPutImageRect cdecl alias "wdCanvasPutImageRect" (byval canvas as cdCanvas ptr, byval image as cdImage ptr, byval x as double, byval y as double, byval xmin as integer, byval xmax as integer, byval ymin as integer, byval ymax as integer)
declare sub wdCanvasPutImageRectRGB cdecl alias "wdCanvasPutImageRectRGB" (byval canvas as cdCanvas ptr, byval iw as integer, byval ih as integer, byval r as ubyte ptr, byval g as ubyte ptr, byval b as ubyte ptr, byval x as double, byval y as double, byval w as double, byval h as double, byval xmin as integer, byval xmax as integer, byval ymin as integer, byval ymax as integer)
declare sub wdCanvasPutImageRectRGBA cdecl alias "wdCanvasPutImageRectRGBA" (byval canvas as cdCanvas ptr, byval iw as integer, byval ih as integer, byval r as ubyte ptr, byval g as ubyte ptr, byval b as ubyte ptr, byval a as ubyte ptr, byval x as double, byval y as double, byval w as double, byval h as double, byval xmin as integer, byval xmax as integer, byval ymin as integer, byval ymax as integer)
declare sub wdCanvasPutImageRectMap cdecl alias "wdCanvasPutImageRectMap" (byval canvas as cdCanvas ptr, byval iw as integer, byval ih as integer, byval index as ubyte ptr, byval colors as integer ptr, byval x as double, byval y as double, byval w as double, byval h as double, byval xmin as integer, byval xmax as integer, byval ymin as integer, byval ymax as integer)
declare sub wdCanvasPutBitmap cdecl alias "wdCanvasPutBitmap" (byval canvas as cdCanvas ptr, byval bitmap as cdBitmap ptr, byval x as double, byval y as double, byval w as double, byval h as double)
declare function wdCanvasLineWidth cdecl alias "wdCanvasLineWidth" (byval canvas as cdCanvas ptr, byval width as double) as double
declare function wdCanvasFont cdecl alias "wdCanvasFont" (byval canvas as cdCanvas ptr, byval type_face as zstring ptr, byval style as integer, byval size as double) as integer
declare sub wdCanvasGetFont cdecl alias "wdCanvasGetFont" (byval canvas as cdCanvas ptr, byval type_face as zstring ptr, byval style as integer ptr, byval size as double ptr)
declare function wdCanvasMarkSize cdecl alias "wdCanvasMarkSize" (byval canvas as cdCanvas ptr, byval size as double) as double
declare sub wdCanvasGetFontDim cdecl alias "wdCanvasGetFontDim" (byval canvas as cdCanvas ptr, byval max_width as double ptr, byval height as double ptr, byval ascent as double ptr, byval descent as double ptr)
declare sub wdCanvasGetTextSize cdecl alias "wdCanvasGetTextSize" (byval canvas as cdCanvas ptr, byval s as zstring ptr, byval width as double ptr, byval height as double ptr)
declare sub wdCanvasGetTextBox cdecl alias "wdCanvasGetTextBox" (byval canvas as cdCanvas ptr, byval x as double, byval y as double, byval s as zstring ptr, byval xmin as double ptr, byval xmax as double ptr, byval ymin as double ptr, byval ymax as double ptr)
declare sub wdCanvasGetTextBounds cdecl alias "wdCanvasGetTextBounds" (byval canvas as cdCanvas ptr, byval x as double, byval y as double, byval s as zstring ptr, byval rect as double ptr)
declare sub wdCanvasStipple cdecl alias "wdCanvasStipple" (byval canvas as cdCanvas ptr, byval w as integer, byval h as integer, byval fgbg as ubyte ptr, byval w_mm as double, byval h_mm as double)
declare sub wdCanvasPattern cdecl alias "wdCanvasPattern" (byval canvas as cdCanvas ptr, byval w as integer, byval h as integer, byval color as integer ptr, byval w_mm as double, byval h_mm as double)
declare sub wdCanvasVectorTextDirection cdecl alias "wdCanvasVectorTextDirection" (byval canvas as cdCanvas ptr, byval x1 as double, byval y1 as double, byval x2 as double, byval y2 as double)
declare sub wdCanvasVectorTextSize cdecl alias "wdCanvasVectorTextSize" (byval canvas as cdCanvas ptr, byval size_x as double, byval size_y as double, byval s as zstring ptr)
declare sub wdCanvasGetVectorTextSize cdecl alias "wdCanvasGetVectorTextSize" (byval canvas as cdCanvas ptr, byval s as zstring ptr, byval x as double ptr, byval y as double ptr)
declare function wdCanvasVectorCharSize cdecl alias "wdCanvasVectorCharSize" (byval canvas as cdCanvas ptr, byval size as double) as double
declare sub wdCanvasVectorText cdecl alias "wdCanvasVectorText" (byval canvas as cdCanvas ptr, byval x as double, byval y as double, byval s as zstring ptr)
declare sub wdCanvasMultiLineVectorText cdecl alias "wdCanvasMultiLineVectorText" (byval canvas as cdCanvas ptr, byval x as double, byval y as double, byval s as zstring ptr)
declare sub wdCanvasGetVectorTextBounds cdecl alias "wdCanvasGetVectorTextBounds" (byval canvas as cdCanvas ptr, byval s as zstring ptr, byval x as double, byval y as double, byval rect as double ptr)
declare sub wdCanvasGetVectorTextBox cdecl alias "wdCanvasGetVectorTextBox" (byval canvas as cdCanvas ptr, byval x as double, byval y as double, byval s as zstring ptr, byval xmin as double ptr, byval xmax as double ptr, byval ymin as double ptr, byval ymax as double ptr)

#endif
