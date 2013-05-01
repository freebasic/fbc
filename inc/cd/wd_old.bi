''
''
'' wd_old -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wd_old_bi__
#define __wd_old_bi__

declare sub wdWindow cdecl alias "wdWindow" (byval xmin as double, byval xmax as double, byval ymin as double, byval ymax as double)
declare sub wdGetWindow cdecl alias "wdGetWindow" (byval xmin as double ptr, byval xmax as double ptr, byval ymin as double ptr, byval ymax as double ptr)
declare sub wdViewport cdecl alias "wdViewport" (byval xmin as integer, byval xmax as integer, byval ymin as integer, byval ymax as integer)
declare sub wdGetViewport cdecl alias "wdGetViewport" (byval xmin as integer ptr, byval xmax as integer ptr, byval ymin as integer ptr, byval ymax as integer ptr)
declare sub wdWorld2Canvas cdecl alias "wdWorld2Canvas" (byval xw as double, byval yw as double, byval xv as integer ptr, byval yv as integer ptr)
declare sub wdWorld2CanvasSize cdecl alias "wdWorld2CanvasSize" (byval hw as double, byval vw as double, byval hv as integer ptr, byval vv as integer ptr)
declare sub wdCanvas2World cdecl alias "wdCanvas2World" (byval xv as integer, byval yv as integer, byval xw as double ptr, byval yw as double ptr)
declare sub wdClipArea cdecl alias "wdClipArea" (byval xmin as double, byval xmax as double, byval ymin as double, byval ymax as double)
declare function wdGetClipArea cdecl alias "wdGetClipArea" (byval xmin as double ptr, byval xmax as double ptr, byval ymin as double ptr, byval ymax as double ptr) as integer
declare function wdGetClipPoly cdecl alias "wdGetClipPoly" (byval n as integer ptr) as double ptr
declare function wdPointInRegion cdecl alias "wdPointInRegion" (byval x as double, byval y as double) as integer
declare sub wdOffsetRegion cdecl alias "wdOffsetRegion" (byval x as double, byval y as double)
declare sub wdRegionBox cdecl alias "wdRegionBox" (byval xmin as double ptr, byval xmax as double ptr, byval ymin as double ptr, byval ymax as double ptr)
declare sub wdHardcopy cdecl alias "wdHardcopy" (byval ctx as cdContext ptr, byval data as any ptr, byval cnv as cdCanvas ptr, byval draw_func as sub cdecl())
declare sub wdPixel cdecl alias "wdPixel" (byval x as double, byval y as double, byval color as integer)
declare sub wdMark cdecl alias "wdMark" (byval x as double, byval y as double)
declare sub wdLine cdecl alias "wdLine" (byval x1 as double, byval y1 as double, byval x2 as double, byval y2 as double)
declare sub wdVertex cdecl alias "wdVertex" (byval x as double, byval y as double)
declare sub wdRect cdecl alias "wdRect" (byval xmin as double, byval xmax as double, byval ymin as double, byval ymax as double)
declare sub wdBox cdecl alias "wdBox" (byval xmin as double, byval xmax as double, byval ymin as double, byval ymax as double)
declare sub wdArc cdecl alias "wdArc" (byval xc as double, byval yc as double, byval w as double, byval h as double, byval angle1 as double, byval angle2 as double)
declare sub wdSector cdecl alias "wdSector" (byval xc as double, byval yc as double, byval w as double, byval h as double, byval angle1 as double, byval angle2 as double)
declare sub wdChord cdecl alias "wdChord" (byval xc as double, byval yc as double, byval w as double, byval h as double, byval angle1 as double, byval angle2 as double)
declare sub wdText cdecl alias "wdText" (byval x as double, byval y as double, byval s as zstring ptr)
declare sub wdPutImageRect cdecl alias "wdPutImageRect" (byval image as cdImage ptr, byval x as double, byval y as double, byval xmin as integer, byval xmax as integer, byval ymin as integer, byval ymax as integer)
declare sub wdPutImageRectRGB cdecl alias "wdPutImageRectRGB" (byval iw as integer, byval ih as integer, byval r as ubyte ptr, byval g as ubyte ptr, byval b as ubyte ptr, byval x as double, byval y as double, byval w as double, byval h as double, byval xmin as integer, byval xmax as integer, byval ymin as integer, byval ymax as integer)
declare sub wdPutImageRectRGBA cdecl alias "wdPutImageRectRGBA" (byval iw as integer, byval ih as integer, byval r as ubyte ptr, byval g as ubyte ptr, byval b as ubyte ptr, byval a as ubyte ptr, byval x as double, byval y as double, byval w as double, byval h as double, byval xmin as integer, byval xmax as integer, byval ymin as integer, byval ymax as integer)
declare sub wdPutImageRectMap cdecl alias "wdPutImageRectMap" (byval iw as integer, byval ih as integer, byval index as ubyte ptr, byval colors as integer ptr, byval x as double, byval y as double, byval w as double, byval h as double, byval xmin as integer, byval xmax as integer, byval ymin as integer, byval ymax as integer)
declare sub wdPutBitmap cdecl alias "wdPutBitmap" (byval bitmap as cdBitmap ptr, byval x as double, byval y as double, byval w as double, byval h as double)
declare function wdLineWidth cdecl alias "wdLineWidth" (byval width as double) as double
declare sub wdFont cdecl alias "wdFont" (byval type_face as integer, byval style as integer, byval size as double)
declare sub wdGetFont cdecl alias "wdGetFont" (byval type_face as integer ptr, byval style as integer ptr, byval size as double ptr)
declare function wdMarkSize cdecl alias "wdMarkSize" (byval size as double) as double
declare sub wdFontDim cdecl alias "wdFontDim" (byval max_width as double ptr, byval height as double ptr, byval ascent as double ptr, byval descent as double ptr)
declare sub wdTextSize cdecl alias "wdTextSize" (byval s as zstring ptr, byval width as double ptr, byval height as double ptr)
declare sub wdTextBox cdecl alias "wdTextBox" (byval x as double, byval y as double, byval s as zstring ptr, byval xmin as double ptr, byval xmax as double ptr, byval ymin as double ptr, byval ymax as double ptr)
declare sub wdTextBounds cdecl alias "wdTextBounds" (byval x as double, byval y as double, byval s as zstring ptr, byval rect as double ptr)
declare sub wdStipple cdecl alias "wdStipple" (byval w as integer, byval h as integer, byval stipple as ubyte ptr, byval w_mm as double, byval h_mm as double)
declare sub wdPattern cdecl alias "wdPattern" (byval w as integer, byval h as integer, byval pattern as integer ptr, byval w_mm as double, byval h_mm as double)
declare sub wdVectorTextDirection cdecl alias "wdVectorTextDirection" (byval x1 as double, byval y1 as double, byval x2 as double, byval y2 as double)
declare sub wdVectorTextSize cdecl alias "wdVectorTextSize" (byval size_x as double, byval size_y as double, byval s as zstring ptr)
declare sub wdGetVectorTextSize cdecl alias "wdGetVectorTextSize" (byval s as zstring ptr, byval x as double ptr, byval y as double ptr)
declare function wdVectorCharSize cdecl alias "wdVectorCharSize" (byval size as double) as double
declare sub wdVectorText cdecl alias "wdVectorText" (byval x as double, byval y as double, byval s as zstring ptr)
declare sub wdMultiLineVectorText cdecl alias "wdMultiLineVectorText" (byval x as double, byval y as double, byval s as zstring ptr)
declare sub wdGetVectorTextBounds cdecl alias "wdGetVectorTextBounds" (byval s as zstring ptr, byval x as double, byval y as double, byval rect as double ptr)

#endif
