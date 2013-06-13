''
''
'' cd_private -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __cd_private_bi__
#define __cd_private_bi__

type _cdCtxCanvasBase
	canvas as cdCanvas ptr
end type

type cdCtxCanvasBase as _cdCtxCanvasBase
type cdCtxCanvas as _cdCtxCanvas
type cdCtxImage as _cdCtxImage
type cdVectorFont as _cdVectorFont
type cdSimulation as _cdSimulation

type _cdPoint
	x as integer
	y as integer
end type

type cdPoint as _cdPoint

type _cdfPoint
	x as double
	y as double
end type

type cdfPoint as _cdfPoint

type _cdRect
	xmin as integer
	xmax as integer
	ymin as integer
	ymax as integer
end type

type cdRect as _cdRect

type _cdfRect
	xmin as double
	xmax as double
	ymin as double
	ymax as double
end type

type cdfRect as _cdfRect

type _cdAttribute
	name as zstring ptr
	set as sub cdecl(byval as cdCtxCanvas ptr, byval as zstring ptr)
	get as function cdecl(byval as cdCtxCanvas ptr) as byte ptr
end type

type cdAttribute as _cdAttribute

type _cdImage
	w as integer
	h as integer
	ctximage as cdCtxImage ptr
	cxGetImage as sub cdecl(byval as cdCtxCanvas ptr, byval as cdCtxImage ptr, byval as integer, byval as integer)
	cxPutImageRect as sub cdecl(byval as cdCtxCanvas ptr, byval as cdCtxImage ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer)
	cxKillImage as sub cdecl(byval as cdCtxImage ptr)
end type

type _cdContext
	caps as uinteger
	type as integer
	cxCreateCanvas as sub cdecl(byval as cdCanvas ptr, byval as any ptr)
	cxInitTable as sub cdecl(byval as cdCanvas ptr)
	cxPlay as function cdecl(byval as cdCanvas ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as any ptr) as integer
	cxRegisterCallback as function cdecl(byval as integer, byval as cdCallback) as integer
end type

type _cdCanvas
	signature as zstring * 2
	cxPixel as sub cdecl(byval as cdCtxCanvas ptr, byval as integer, byval as integer, byval as integer)
	cxLine as sub cdecl(byval as cdCtxCanvas ptr, byval as integer, byval as integer, byval as integer, byval as integer)
	cxPoly as sub cdecl(byval as cdCtxCanvas ptr, byval as integer, byval as cdPoint ptr, byval as integer)
	cxRect as sub cdecl(byval as cdCtxCanvas ptr, byval as integer, byval as integer, byval as integer, byval as integer)
	cxBox as sub cdecl(byval as cdCtxCanvas ptr, byval as integer, byval as integer, byval as integer, byval as integer)
	cxArc as sub cdecl(byval as cdCtxCanvas ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as double, byval as double)
	cxSector as sub cdecl(byval as cdCtxCanvas ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as double, byval as double)
	cxChord as sub cdecl(byval as cdCtxCanvas ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as double, byval as double)
	cxText as sub cdecl(byval as cdCtxCanvas ptr, byval as integer, byval as integer, byval as zstring ptr, byval as integer)
	cxKillCanvas as sub cdecl(byval as cdCtxCanvas ptr)
	cxFont as function cdecl(byval as cdCtxCanvas ptr, byval as zstring ptr, byval as integer, byval as integer) as integer
	cxPutImageRectMap as sub cdecl(byval as cdCtxCanvas ptr, byval as integer, byval as integer, byval as ubyte ptr, byval as integer ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer)
	cxPutImageRectRGB as sub cdecl(byval as cdCtxCanvas ptr, byval as integer, byval as integer, byval as ubyte ptr, byval as ubyte ptr, byval as ubyte ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer)
	cxGetFontDim as sub cdecl(byval as cdCtxCanvas ptr, byval as integer ptr, byval as integer ptr, byval as integer ptr, byval as integer ptr)
	cxGetTextSize as sub cdecl(byval as cdCtxCanvas ptr, byval as zstring ptr, byval as integer, byval as integer ptr, byval as integer ptr)
	cxFlush as sub cdecl(byval as cdCtxCanvas ptr)
	cxClear as sub cdecl(byval as cdCtxCanvas ptr)
	cxFLine as sub cdecl(byval as cdCtxCanvas ptr, byval as double, byval as double, byval as double, byval as double)
	cxFPoly as sub cdecl(byval as cdCtxCanvas ptr, byval as integer, byval as cdfPoint ptr, byval as integer)
	cxFRect as sub cdecl(byval as cdCtxCanvas ptr, byval as double, byval as double, byval as double, byval as double)
	cxFBox as sub cdecl(byval as cdCtxCanvas ptr, byval as double, byval as double, byval as double, byval as double)
	cxFArc as sub cdecl(byval as cdCtxCanvas ptr, byval as double, byval as double, byval as double, byval as double, byval as double, byval as double)
	cxFSector as sub cdecl(byval as cdCtxCanvas ptr, byval as double, byval as double, byval as double, byval as double, byval as double, byval as double)
	cxFChord as sub cdecl(byval as cdCtxCanvas ptr, byval as double, byval as double, byval as double, byval as double, byval as double, byval as double)
	cxFText as sub cdecl(byval as cdCtxCanvas ptr, byval as double, byval as double, byval as zstring ptr, byval as integer)
	cxClip as function cdecl(byval as cdCtxCanvas ptr, byval as integer) as integer
	cxClipArea as sub cdecl(byval as cdCtxCanvas ptr, byval as integer, byval as integer, byval as integer, byval as integer)
	cxFClipArea as sub cdecl(byval as cdCtxCanvas ptr, byval as double, byval as double, byval as double, byval as double)
	cxBackOpacity as function cdecl(byval as cdCtxCanvas ptr, byval as integer) as integer
	cxWriteMode as function cdecl(byval as cdCtxCanvas ptr, byval as integer) as integer
	cxLineStyle as function cdecl(byval as cdCtxCanvas ptr, byval as integer) as integer
	cxLineWidth as function cdecl(byval as cdCtxCanvas ptr, byval as integer) as integer
	cxLineJoin as function cdecl(byval as cdCtxCanvas ptr, byval as integer) as integer
	cxLineCap as function cdecl(byval as cdCtxCanvas ptr, byval as integer) as integer
	cxInteriorStyle as function cdecl(byval as cdCtxCanvas ptr, byval as integer) as integer
	cxHatch as function cdecl(byval as cdCtxCanvas ptr, byval as integer) as integer
	cxStipple as sub cdecl(byval as cdCtxCanvas ptr, byval as integer, byval as integer, byval as ubyte ptr)
	cxPattern as sub cdecl(byval as cdCtxCanvas ptr, byval as integer, byval as integer, byval as integer ptr)
	cxNativeFont as function cdecl(byval as cdCtxCanvas ptr, byval as zstring ptr) as integer
	cxTextAlignment as function cdecl(byval as cdCtxCanvas ptr, byval as integer) as integer
	cxTextOrientation as function cdecl(byval as cdCtxCanvas ptr, byval as double) as double
	cxPalette as sub cdecl(byval as cdCtxCanvas ptr, byval as integer, byval as integer ptr, byval as integer)
	cxBackground as function cdecl(byval as cdCtxCanvas ptr, byval as integer) as integer
	cxForeground as function cdecl(byval as cdCtxCanvas ptr, byval as integer) as integer
	cxTransform as sub cdecl(byval as cdCtxCanvas ptr, byval as double ptr)
	cxPutImageRectRGBA as sub cdecl(byval as cdCtxCanvas ptr, byval as integer, byval as integer, byval as ubyte ptr, byval as ubyte ptr, byval as ubyte ptr, byval as ubyte ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer)
	cxGetImageRGB as sub cdecl(byval as cdCtxCanvas ptr, byval as ubyte ptr, byval as ubyte ptr, byval as ubyte ptr, byval as integer, byval as integer, byval as integer, byval as integer)
	cxScrollArea as sub cdecl(byval as cdCtxCanvas ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer)
	cxCreateImage as function cdecl(byval as cdCtxCanvas ptr, byval as integer, byval as integer) as cdCtxImage ptr
	cxKillImage as sub cdecl(byval as cdCtxImage ptr)
	cxGetImage as sub cdecl(byval as cdCtxCanvas ptr, byval as cdCtxImage ptr, byval as integer, byval as integer)
	cxPutImageRect as sub cdecl(byval as cdCtxCanvas ptr, byval as cdCtxImage ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer)
	cxNewRegion as sub cdecl(byval as cdCtxCanvas ptr)
	cxIsPointInRegion as function cdecl(byval as cdCtxCanvas ptr, byval as integer, byval as integer) as integer
	cxOffsetRegion as sub cdecl(byval as cdCtxCanvas ptr, byval as integer, byval as integer)
	cxGetRegionBox as sub cdecl(byval as cdCtxCanvas ptr, byval as integer ptr, byval as integer ptr, byval as integer ptr, byval as integer ptr)
	cxActivate as function cdecl(byval as cdCtxCanvas ptr) as integer
	cxDeactivate as sub cdecl(byval as cdCtxCanvas ptr)
	w as integer
	h as integer
	w_mm as double
	h_mm as double
	xres as double
	yres as double
	bpp as integer
	invert_yaxis as integer
	matrix(0 to 6-1) as double
	use_matrix as integer
	clip_mode as integer
	clip_rect as cdRect
	clip_frect as cdfRect
	clip_poly_n as integer
	clip_poly as cdPoint ptr
	clip_fpoly as cdfPoint ptr
	new_region as integer
	combine_mode as integer
	foreground as integer
	background as integer
	back_opacity as integer
	write_mode as integer
	mark_type as integer
	mark_size as integer
	line_style as integer
	line_width as integer
	line_cap as integer
	line_join as integer
	line_dashes as integer ptr
	line_dashes_count as integer
	interior_style as integer
	hatch_style as integer
	fill_mode as integer
	font_type_face as zstring * 1024
	font_style as integer
	font_size as integer
	text_alignment as integer
	text_orientation as double
	native_font as zstring * 1024
	pattern_w as integer
	pattern_h as integer
	pattern_size as integer
	pattern as integer ptr
	stipple_w as integer
	stipple_h as integer
	stipple_size as integer
	stipple as ubyte ptr
	use_origin as integer
	origin as cdPoint
	forigin as cdfPoint
	poly_mode as integer
	poly_n as integer
	poly_size as integer
	fpoly_size as integer
	poly as cdPoint ptr
	fpoly as cdfPoint ptr
	use_fpoly as integer
	path_n as integer
	path_size as integer
	path as integer ptr
	sim_mode as integer
	s as double
	sx as double
	tx as double
	sy as double
	ty as double
	window as cdfRect
	viewport as cdRect
	attrib_list(0 to 50-1) as cdAttribute ptr
	attrib_n as integer
	vector_font as cdVectorFont ptr
	simulation as cdSimulation ptr
	ctxcanvas as cdCtxCanvas ptr
	context as cdContext ptr
end type

enum 
	CD_BASE_WIN
	CD_BASE_X
	CD_BASE_GDK
end enum

declare function cdBaseDriver cdecl alias "cdBaseDriver" () as integer
declare sub cdRegisterAttribute cdecl alias "cdRegisterAttribute" (byval canvas as cdCanvas ptr, byval attrib as cdAttribute ptr)
declare sub cdUpdateAttributes cdecl alias "cdUpdateAttributes" (byval canvas as cdCanvas ptr)
declare function cdCreateVectorFont cdecl alias "cdCreateVectorFont" (byval canvas as cdCanvas ptr) as cdVectorFont ptr
declare sub cdKillVectorFont cdecl alias "cdKillVectorFont" (byval vector_font_data as cdVectorFont ptr)
declare sub wdSetDefaults cdecl alias "wdSetDefaults" (byval canvas as cdCanvas ptr)
declare sub cdInitContextPlusList cdecl alias "cdInitContextPlusList" (byval ctx_list as cdContext ptr ptr)
declare function cdGetContextPlus cdecl alias "cdGetContextPlus" (byval ctx as integer) as cdContext ptr

enum 
	CD_CTXPLUS_NATIVEWINDOW
	CD_CTXPLUS_IMAGE
	CD_CTXPLUS_DBUFFER
	CD_CTXPLUS_PRINTER
	CD_CTXPLUS_EMF
	CD_CTXPLUS_CLIPBOARD
end enum

#define CD_CTXPLUS_COUNT 6
#define CD_CTX_PLUS &hFF00

declare function cdRound cdecl alias "cdRound" (byval x as double) as integer
declare function cdCheckBoxSize cdecl alias "cdCheckBoxSize" (byval xmin as integer ptr, byval xmax as integer ptr, byval ymin as integer ptr, byval ymax as integer ptr) as integer
declare function cdfCheckBoxSize cdecl alias "cdfCheckBoxSize" (byval xmin as double ptr, byval xmax as double ptr, byval ymin as double ptr, byval ymax as double ptr) as integer
declare sub cdNormalizeLimits cdecl alias "cdNormalizeLimits" (byval w as integer, byval h as integer, byval xmin as integer ptr, byval xmax as integer ptr, byval ymin as integer ptr, byval ymax as integer ptr)
declare function cdGetFileName cdecl alias "cdGetFileName" (byval strdata as zstring ptr, byval filename as zstring ptr) as integer
declare function cdStrEqualNoCase cdecl alias "cdStrEqualNoCase" (byval str1 as zstring ptr, byval str2 as zstring ptr) as integer
declare function cdStrEqualNoCasePartial cdecl alias "cdStrEqualNoCasePartial" (byval str1 as zstring ptr, byval str2 as zstring ptr) as integer
declare function cdStrLineCount cdecl alias "cdStrLineCount" (byval str as zstring ptr) as integer
declare function cdStrDup cdecl alias "cdStrDup" (byval str as zstring ptr) as zstring ptr
declare function cdStrDupN cdecl alias "cdStrDupN" (byval str as zstring ptr, byval len as integer) as zstring ptr
declare sub cdSetPaperSize cdecl alias "cdSetPaperSize" (byval size as integer, byval w_pt as double ptr, byval h_pt as double ptr)
declare function cdGetFontFileName cdecl alias "cdGetFontFileName" (byval type_face as zstring ptr, byval filename as zstring ptr) as integer
declare function cdGetFontFileNameDefault cdecl alias "cdGetFontFileNameDefault" (byval type_face as zstring ptr, byval style as integer, byval filename as zstring ptr) as integer
declare function cdGetFontFileNameSystem cdecl alias "cdGetFontFileNameSystem" (byval type_face as zstring ptr, byval style as integer, byval filename as zstring ptr) as integer
declare function cdStrTmpFileName cdecl alias "cdStrTmpFileName" (byval filename as zstring ptr) as integer
declare sub cdCanvasPoly cdecl alias "cdCanvasPoly" (byval canvas as cdCanvas ptr, byval mode as integer, byval points as cdPoint ptr, byval n as integer)
declare sub cdCanvasGetArcBox cdecl alias "cdCanvasGetArcBox" (byval xc as integer, byval yc as integer, byval w as integer, byval h as integer, byval a1 as double, byval a2 as double, byval xmin as integer ptr, byval xmax as integer ptr, byval ymin as integer ptr, byval ymax as integer ptr)
declare function cdCanvasGetArcPathF cdecl alias "cdCanvasGetArcPathF" (byval canvas as cdCanvas ptr, byval poly as cdPoint ptr, byval xc as double ptr, byval yc as double ptr, byval w as double ptr, byval h as double ptr, byval a1 as double ptr, byval a2 as double ptr) as integer
declare function cdfCanvasGetArcPath cdecl alias "cdfCanvasGetArcPath" (byval canvas as cdCanvas ptr, byval poly as cdfPoint ptr, byval xc as double ptr, byval yc as double ptr, byval w as double ptr, byval h as double ptr, byval a1 as double ptr, byval a2 as double ptr) as integer
declare function cdCanvasGetArcPath cdecl alias "cdCanvasGetArcPath" (byval canvas as cdCanvas ptr, byval poly as cdPoint ptr, byval xc as integer ptr, byval yc as integer ptr, byval w as integer ptr, byval h as integer ptr, byval a1 as double ptr, byval a2 as double ptr) as integer
declare sub cdCanvasGetArcStartEnd cdecl alias "cdCanvasGetArcStartEnd" (byval xc as integer, byval yc as integer, byval w as integer, byval h as integer, byval a1 as double, byval a2 as double, byval x1 as integer ptr, byval y1 as integer ptr, byval x2 as integer ptr, byval y2 as integer ptr)
declare sub cdfCanvasGetArcStartEnd cdecl alias "cdfCanvasGetArcStartEnd" (byval xc as double, byval yc as double, byval w as double, byval h as double, byval a1 as double, byval a2 as double, byval x1 as double ptr, byval y1 as double ptr, byval x2 as double ptr, byval y2 as double ptr)
declare sub cdMatrixTransformPoint cdecl alias "cdMatrixTransformPoint" (byval matrix as double ptr, byval x as integer, byval y as integer, byval rx as integer ptr, byval ry as integer ptr)
declare sub cdfMatrixTransformPoint cdecl alias "cdfMatrixTransformPoint" (byval matrix as double ptr, byval x as double, byval y as double, byval rx as double ptr, byval ry as double ptr)
declare sub cdMatrixMultiply cdecl alias "cdMatrixMultiply" (byval matrix as double ptr, byval mul_matrix as double ptr)
declare sub cdMatrixInverse cdecl alias "cdMatrixInverse" (byval matrix as double ptr, byval inv_matrix as double ptr)
declare sub cdfRotatePoint cdecl alias "cdfRotatePoint" (byval canvas as cdCanvas ptr, byval x as double, byval y as double, byval cx as double, byval cy as double, byval rx as double ptr, byval ry as double ptr, byval sin_theta as double, byval cos_theta as double)
declare sub cdRotatePoint cdecl alias "cdRotatePoint" (byval canvas as cdCanvas ptr, byval x as integer, byval y as integer, byval cx as integer, byval cy as integer, byval rx as integer ptr, byval ry as integer ptr, byval sin_teta as double, byval cos_teta as double)
declare sub cdRotatePointY cdecl alias "cdRotatePointY" (byval canvas as cdCanvas ptr, byval x as integer, byval y as integer, byval cx as integer, byval cy as integer, byval ry as integer ptr, byval sin_theta as double, byval cos_theta as double)
declare sub cdTextTranslatePoint cdecl alias "cdTextTranslatePoint" (byval canvas as cdCanvas ptr, byval x as integer, byval y as integer, byval w as integer, byval h as integer, byval baseline as integer, byval rx as integer ptr, byval ry as integer ptr)
declare sub cdMovePoint cdecl alias "cdMovePoint" (byval x as integer ptr, byval y as integer ptr, byval dx as double, byval dy as double, byval sin_theta as double, byval cos_theta as double)
declare sub cdfMovePoint cdecl alias "cdfMovePoint" (byval x as double ptr, byval y as double ptr, byval dx as double, byval dy as double, byval sin_theta as double, byval cos_theta as double)
declare function cdParsePangoFont cdecl alias "cdParsePangoFont" (byval nativefont as zstring ptr, byval type_face as zstring ptr, byval style as integer ptr, byval size as integer ptr) as integer
declare function cdParseIupWinFont cdecl alias "cdParseIupWinFont" (byval nativefont as zstring ptr, byval type_face as zstring ptr, byval style as integer ptr, byval size as integer ptr) as integer
declare function cdParseXWinFont cdecl alias "cdParseXWinFont" (byval nativefont as zstring ptr, byval type_face as zstring ptr, byval style as integer ptr, byval size as integer ptr) as integer
declare function cdGetFontSizePixels cdecl alias "cdGetFontSizePixels" (byval canvas as cdCanvas ptr, byval size as integer) as integer
declare function cdGetFontSizePoints cdecl alias "cdGetFontSizePoints" (byval canvas as cdCanvas ptr, byval size as integer) as integer
declare sub cdgetfontdimEX cdecl alias "cdgetfontdimEX" (byval ctxcanvas as cdCtxCanvas ptr, byval max_width as integer ptr, byval height as integer ptr, byval ascent as integer ptr, byval descent as integer ptr)
declare sub cdgettextsizeEX cdecl alias "cdgettextsizeEX" (byval ctxcanvas as cdCtxCanvas ptr, byval s as zstring ptr, byval len as integer, byval width as integer ptr, byval height as integer ptr)
declare function cdZeroOrderInterpolation cdecl alias "cdZeroOrderInterpolation" (byval width as integer, byval height as integer, byval map as ubyte ptr, byval xl as single, byval yl as single) as ubyte
declare function cdBilinearInterpolation cdecl alias "cdBilinearInterpolation" (byval width as integer, byval height as integer, byval map as ubyte ptr, byval xl as single, byval yl as single) as ubyte
declare sub cdImageRGBInitInverseTransform cdecl alias "cdImageRGBInitInverseTransform" (byval w as integer, byval h as integer, byval xmin as integer, byval xmax as integer, byval ymin as integer, byval ymax as integer, byval xfactor as single ptr, byval yfactor as single ptr, byval matrix as double ptr, byval inv_matrix as double ptr)
declare sub cdImageRGBInverseTransform cdecl alias "cdImageRGBInverseTransform" (byval t_x as integer, byval t_y as integer, byval i_x as single ptr, byval i_y as single ptr, byval xfactor as single, byval yfactor as single, byval xmin as integer, byval ymin as integer, byval x as integer, byval y as integer, byval inv_matrix as double ptr)
declare sub cdImageRGBCalcDstLimits cdecl alias "cdImageRGBCalcDstLimits" (byval canvas as cdCanvas ptr, byval x as integer, byval y as integer, byval w as integer, byval h as integer, byval xmin as integer ptr, byval xmax as integer ptr, byval ymin as integer ptr, byval ymax as integer ptr, byval rect as integer ptr)
declare sub cdRGB2Gray cdecl alias "cdRGB2Gray" (byval width as integer, byval height as integer, byval red as ubyte ptr, byval green as ubyte ptr, byval blue as ubyte ptr, byval index as ubyte ptr, byval color as integer ptr)
declare function cdGetZoomTable cdecl alias "cdGetZoomTable" (byval w as integer, byval rw as integer, byval xmin as integer) as integer ptr
declare function cdCalcZoom cdecl alias "cdCalcZoom" (byval canvas_size as integer, byval cnv_rect_pos as integer, byval cnv_rect_size as integer, byval new_cnv_rect_pos as integer ptr, byval new_cnv_rect_size as integer ptr, byval img_rect_pos as integer, byval img_rect_size as integer, byval new_img_rect_pos as integer ptr, byval new_img_rect_size as integer ptr, byval is_horizontal as integer) as integer
declare function cdCreateSimulation cdecl alias "cdCreateSimulation" (byval canvas as cdCanvas ptr) as cdSimulation ptr
declare sub cdKillSimulation cdecl alias "cdKillSimulation" (byval simulation as cdSimulation ptr)
declare sub cdSimInitText cdecl alias "cdSimInitText" (byval simulation as cdSimulation ptr)
declare sub cdSimTextFT cdecl alias "cdSimTextFT" (byval ctxcanvas as cdCtxCanvas ptr, byval x as integer, byval y as integer, byval s as zstring ptr, byval len as integer)
declare function cdSimFontFT cdecl alias "cdSimFontFT" (byval ctxcanvas as cdCtxCanvas ptr, byval type_face as zstring ptr, byval style as integer, byval size as integer) as integer
declare sub cdSimGetFontDimFT cdecl alias "cdSimGetFontDimFT" (byval ctxcanvas as cdCtxCanvas ptr, byval max_width as integer ptr, byval height as integer ptr, byval ascent as integer ptr, byval descent as integer ptr)
declare sub cdSimGetTextSizeFT cdecl alias "cdSimGetTextSizeFT" (byval ctxcanvas as cdCtxCanvas ptr, byval s as zstring ptr, byval len as integer, byval width as integer ptr, byval height as integer ptr)
declare sub cdSimMark cdecl alias "cdSimMark" (byval canvas as cdCanvas ptr, byval x as integer, byval y as integer)
declare sub cdSimPutImageRectRGBA cdecl alias "cdSimPutImageRectRGBA" (byval canvas as cdCanvas ptr, byval iw as integer, byval ih as integer, byval r as ubyte ptr, byval g as ubyte ptr, byval b as ubyte ptr, byval a as ubyte ptr, byval x as integer, byval y as integer, byval w as integer, byval h as integer, byval xmin as integer, byval xmax as integer, byval ymin as integer, byval ymax as integer)
declare sub cdSimPutImageRectRGB cdecl alias "cdSimPutImageRectRGB" (byval canvas as cdCanvas ptr, byval iw as integer, byval ih as integer, byval r as ubyte ptr, byval g as ubyte ptr, byval b as ubyte ptr, byval x as integer, byval y as integer, byval w as integer, byval h as integer, byval xmin as integer, byval xmax as integer, byval ymin as integer, byval ymax as integer)
declare sub cdSimLine cdecl alias "cdSimLine" (byval ctxcanvas as cdCtxCanvas ptr, byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer)
declare sub cdSimRect cdecl alias "cdSimRect" (byval ctxcanvas as cdCtxCanvas ptr, byval xmin as integer, byval xmax as integer, byval ymin as integer, byval ymax as integer)
declare sub cdSimBox cdecl alias "cdSimBox" (byval ctxcanvas as cdCtxCanvas ptr, byval xmin as integer, byval xmax as integer, byval ymin as integer, byval ymax as integer)
declare sub cdSimArc cdecl alias "cdSimArc" (byval ctxcanvas as cdCtxCanvas ptr, byval xc as integer, byval yc as integer, byval width as integer, byval height as integer, byval angle1 as double, byval angle2 as double)
declare sub cdSimSector cdecl alias "cdSimSector" (byval ctxcanvas as cdCtxCanvas ptr, byval xc as integer, byval yc as integer, byval width as integer, byval height as integer, byval angle1 as double, byval angle2 as double)
declare sub cdSimChord cdecl alias "cdSimChord" (byval ctxcanvas as cdCtxCanvas ptr, byval xc as integer, byval yc as integer, byval width as integer, byval height as integer, byval angle1 as double, byval angle2 as double)
declare sub cdSimPoly cdecl alias "cdSimPoly" (byval ctxcanvas as cdCtxCanvas ptr, byval mode as integer, byval points as cdPoint ptr, byval n as integer)
declare sub cdSimPolyBezier cdecl alias "cdSimPolyBezier" (byval canvas as cdCanvas ptr, byval points as cdPoint ptr, byval n as integer)
declare sub cdSimPolyPath cdecl alias "cdSimPolyPath" (byval canvas as cdCanvas ptr, byval points as cdPoint ptr, byval n as integer)
declare sub cdfSimLine cdecl alias "cdfSimLine" (byval ctxcanvas as cdCtxCanvas ptr, byval x1 as double, byval y1 as double, byval x2 as double, byval y2 as double)
declare sub cdfSimRect cdecl alias "cdfSimRect" (byval ctxcanvas as cdCtxCanvas ptr, byval xmin as double, byval xmax as double, byval ymin as double, byval ymax as double)
declare sub cdfSimBox cdecl alias "cdfSimBox" (byval ctxcanvas as cdCtxCanvas ptr, byval xmin as double, byval xmax as double, byval ymin as double, byval ymax as double)
declare sub cdfSimArc cdecl alias "cdfSimArc" (byval ctxcanvas as cdCtxCanvas ptr, byval xc as double, byval yc as double, byval width as double, byval height as double, byval angle1 as double, byval angle2 as double)
declare sub cdfSimSector cdecl alias "cdfSimSector" (byval ctxcanvas as cdCtxCanvas ptr, byval xc as double, byval yc as double, byval width as double, byval height as double, byval angle1 as double, byval angle2 as double)
declare sub cdfSimChord cdecl alias "cdfSimChord" (byval ctxcanvas as cdCtxCanvas ptr, byval xc as double, byval yc as double, byval width as double, byval height as double, byval angle1 as double, byval angle2 as double)
declare sub cdfSimPoly cdecl alias "cdfSimPoly" (byval ctxcanvas as cdCtxCanvas ptr, byval mode as integer, byval fpoly as cdfPoint ptr, byval n as integer)
declare sub cdfSimPolyBezier cdecl alias "cdfSimPolyBezier" (byval canvas as cdCanvas ptr, byval points as cdfPoint ptr, byval n as integer)
declare sub cdfSimPolyPath cdecl alias "cdfSimPolyPath" (byval canvas as cdCanvas ptr, byval points as cdfPoint ptr, byval n as integer)

#endif
