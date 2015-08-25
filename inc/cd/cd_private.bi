'' FreeBASIC binding for cd-5.8.2
''
'' based on the C header files:
''   Copyright (C) 1994-2014 Tecgraf, PUC-Rio.
''
''   Permission is hereby granted, free of charge, to any person obtaining
''   a copy of this software and associated documentation files (the
''   "Software"), to deal in the Software without restriction, including
''   without limitation the rights to use, copy, modify, merge, publish,
''   distribute, sublicense, and/or sell copies of the Software, and to
''   permit persons to whom the Software is furnished to do so, subject to
''   the following conditions:
''
''   The above copyright notice and this permission notice shall be
''   included in all copies or substantial portions of the Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
''   EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
''   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
''   IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
''   CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
''   TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
''   SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/long.bi"
#include once "crt/stdarg.bi"

extern "C"

#define __CD_PRIVATE_H

type _cdCtxCanvasBase
	canvas as cdCanvas ptr
end type

type cdCtxCanvasBase as _cdCtxCanvasBase
type cdCtxCanvas as _cdCtxCanvas
type cdCtxImage as _cdCtxImage
type cdVectorFont as _cdVectorFont
type cdSimulation as _cdSimulation

type _cdPoint
	x as long
	y as long
end type

type cdPoint as _cdPoint

type _cdfPoint
	x as double
	y as double
end type

type cdfPoint as _cdfPoint

type _cdRect
	xmin as long
	xmax as long
	ymin as long
	ymax as long
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
	name as const zstring ptr
	set as sub(byval ctxcanvas as cdCtxCanvas ptr, byval data as zstring ptr)
	get as function(byval ctxcanvas as cdCtxCanvas ptr) as zstring ptr
end type

type cdAttribute as _cdAttribute

type _cdImage
	w as long
	h as long
	ctximage as cdCtxImage ptr
	cxGetImage as sub(byval ctxcanvas as cdCtxCanvas ptr, byval ctximage as cdCtxImage ptr, byval x as long, byval y as long)
	cxPutImageRect as sub(byval ctxcanvas as cdCtxCanvas ptr, byval ctximage as cdCtxImage ptr, byval x as long, byval y as long, byval xmin as long, byval xmax as long, byval ymin as long, byval ymax as long)
	cxKillImage as sub(byval ctximage as cdCtxImage ptr)
end type

type _cdContext
	caps as culong
	as long type
	cxCreateCanvas as sub(byval canvas as cdCanvas ptr, byval data as any ptr)
	cxInitTable as sub(byval canvas as cdCanvas ptr)
	cxPlay as function(byval canvas as cdCanvas ptr, byval xmin as long, byval xmax as long, byval ymin as long, byval ymax as long, byval data as any ptr) as long
	cxRegisterCallback as function(byval cb as long, byval func as cdCallback) as long
end type

type _cdCanvas
	signature as zstring * 2
	cxPixel as sub(byval ctxcanvas as cdCtxCanvas ptr, byval x as long, byval y as long, byval color as clong)
	cxLine as sub(byval ctxcanvas as cdCtxCanvas ptr, byval x1 as long, byval y1 as long, byval x2 as long, byval y2 as long)
	cxPoly as sub(byval ctxcanvas as cdCtxCanvas ptr, byval mode as long, byval points as cdPoint ptr, byval n as long)
	cxRect as sub(byval ctxcanvas as cdCtxCanvas ptr, byval xmin as long, byval xmax as long, byval ymin as long, byval ymax as long)
	cxBox as sub(byval ctxcanvas as cdCtxCanvas ptr, byval xmin as long, byval xmax as long, byval ymin as long, byval ymax as long)
	cxArc as sub(byval ctxcanvas as cdCtxCanvas ptr, byval xc as long, byval yc as long, byval w as long, byval h as long, byval angle1 as double, byval angle2 as double)
	cxSector as sub(byval ctxcanvas as cdCtxCanvas ptr, byval xc as long, byval yc as long, byval w as long, byval h as long, byval angle1 as double, byval angle2 as double)
	cxChord as sub(byval ctxcanvas as cdCtxCanvas ptr, byval xc as long, byval yc as long, byval w as long, byval h as long, byval angle1 as double, byval angle2 as double)
	cxText as sub(byval ctxcanvas as cdCtxCanvas ptr, byval x as long, byval y as long, byval s as const zstring ptr, byval len as long)
	cxKillCanvas as sub(byval ctxcanvas as cdCtxCanvas ptr)
	cxFont as function(byval ctxcanvas as cdCtxCanvas ptr, byval type_face as const zstring ptr, byval style as long, byval size as long) as long
	cxPutImageRectMap as sub(byval ctxcanvas as cdCtxCanvas ptr, byval iw as long, byval ih as long, byval index as const ubyte ptr, byval colors as const clong ptr, byval x as long, byval y as long, byval w as long, byval h as long, byval xmin as long, byval xmax as long, byval ymin as long, byval ymax as long)
	cxPutImageRectRGB as sub(byval ctxcanvas as cdCtxCanvas ptr, byval iw as long, byval ih as long, byval r as const ubyte ptr, byval g as const ubyte ptr, byval b as const ubyte ptr, byval x as long, byval y as long, byval w as long, byval h as long, byval xmin as long, byval xmax as long, byval ymin as long, byval ymax as long)
	cxGetFontDim as sub(byval ctxcanvas as cdCtxCanvas ptr, byval max_width as long ptr, byval height as long ptr, byval ascent as long ptr, byval descent as long ptr)
	cxGetTextSize as sub(byval ctxcanvas as cdCtxCanvas ptr, byval s as const zstring ptr, byval len as long, byval width as long ptr, byval height as long ptr)
	cxFlush as sub(byval ctxcanvas as cdCtxCanvas ptr)
	cxClear as sub(byval ctxcanvas as cdCtxCanvas ptr)
	cxFLine as sub(byval ctxcanvas as cdCtxCanvas ptr, byval x1 as double, byval y1 as double, byval x2 as double, byval y2 as double)
	cxFPoly as sub(byval ctxcanvas as cdCtxCanvas ptr, byval mode as long, byval points as cdfPoint ptr, byval n as long)
	cxFRect as sub(byval ctxcanvas as cdCtxCanvas ptr, byval xmin as double, byval xmax as double, byval ymin as double, byval ymax as double)
	cxFBox as sub(byval ctxcanvas as cdCtxCanvas ptr, byval xmin as double, byval xmax as double, byval ymin as double, byval ymax as double)
	cxFArc as sub(byval ctxcanvas as cdCtxCanvas ptr, byval xc as double, byval yc as double, byval w as double, byval h as double, byval angle1 as double, byval angle2 as double)
	cxFSector as sub(byval ctxcanvas as cdCtxCanvas ptr, byval xc as double, byval yc as double, byval w as double, byval h as double, byval angle1 as double, byval angle2 as double)
	cxFChord as sub(byval ctxcanvas as cdCtxCanvas ptr, byval xc as double, byval yc as double, byval w as double, byval h as double, byval angle1 as double, byval angle2 as double)
	cxFText as sub(byval ctxcanvas as cdCtxCanvas ptr, byval x as double, byval y as double, byval s as const zstring ptr, byval len as long)
	cxClip as function(byval ctxcanvas as cdCtxCanvas ptr, byval mode as long) as long
	cxClipArea as sub(byval ctxcanvas as cdCtxCanvas ptr, byval xmin as long, byval xmax as long, byval ymin as long, byval ymax as long)
	cxFClipArea as sub(byval ctxcanvas as cdCtxCanvas ptr, byval xmin as double, byval xmax as double, byval ymin as double, byval ymax as double)
	cxBackOpacity as function(byval ctxcanvas as cdCtxCanvas ptr, byval opacity as long) as long
	cxWriteMode as function(byval ctxcanvas as cdCtxCanvas ptr, byval mode as long) as long
	cxLineStyle as function(byval ctxcanvas as cdCtxCanvas ptr, byval style as long) as long
	cxLineWidth as function(byval ctxcanvas as cdCtxCanvas ptr, byval width as long) as long
	cxLineJoin as function(byval ctxcanvas as cdCtxCanvas ptr, byval join as long) as long
	cxLineCap as function(byval ctxcanvas as cdCtxCanvas ptr, byval cap as long) as long
	cxInteriorStyle as function(byval ctxcanvas as cdCtxCanvas ptr, byval style as long) as long
	cxHatch as function(byval ctxcanvas as cdCtxCanvas ptr, byval style as long) as long
	cxStipple as sub(byval ctxcanvas as cdCtxCanvas ptr, byval w as long, byval h as long, byval stipple as const ubyte ptr)
	cxPattern as sub(byval ctxcanvas as cdCtxCanvas ptr, byval w as long, byval h as long, byval pattern as const clong ptr)
	cxNativeFont as function(byval ctxcanvas as cdCtxCanvas ptr, byval font as const zstring ptr) as long
	cxTextAlignment as function(byval ctxcanvas as cdCtxCanvas ptr, byval alignment as long) as long
	cxTextOrientation as function(byval ctxcanvas as cdCtxCanvas ptr, byval angle as double) as double
	cxPalette as sub(byval ctxcanvas as cdCtxCanvas ptr, byval n as long, byval palette as const clong ptr, byval mode as long)
	cxBackground as function(byval ctxcanvas as cdCtxCanvas ptr, byval color as clong) as clong
	cxForeground as function(byval ctxcanvas as cdCtxCanvas ptr, byval color as clong) as clong
	cxTransform as sub(byval ctxcanvas as cdCtxCanvas ptr, byval matrix as const double ptr)
	cxPutImageRectRGBA as sub(byval ctxcanvas as cdCtxCanvas ptr, byval iw as long, byval ih as long, byval r as const ubyte ptr, byval g as const ubyte ptr, byval b as const ubyte ptr, byval a as const ubyte ptr, byval x as long, byval y as long, byval w as long, byval h as long, byval xmin as long, byval xmax as long, byval ymin as long, byval ymax as long)
	cxGetImageRGB as sub(byval ctxcanvas as cdCtxCanvas ptr, byval r as ubyte ptr, byval g as ubyte ptr, byval b as ubyte ptr, byval x as long, byval y as long, byval w as long, byval h as long)
	cxScrollArea as sub(byval ctxcanvas as cdCtxCanvas ptr, byval xmin as long, byval xmax as long, byval ymin as long, byval ymax as long, byval dx as long, byval dy as long)
	cxCreateImage as function(byval ctxcanvas as cdCtxCanvas ptr, byval w as long, byval h as long) as cdCtxImage ptr
	cxKillImage as sub(byval ctximage as cdCtxImage ptr)
	cxGetImage as sub(byval ctxcanvas as cdCtxCanvas ptr, byval ctximage as cdCtxImage ptr, byval x as long, byval y as long)
	cxPutImageRect as sub(byval ctxcanvas as cdCtxCanvas ptr, byval ctximage as cdCtxImage ptr, byval x as long, byval y as long, byval xmin as long, byval xmax as long, byval ymin as long, byval ymax as long)
	cxNewRegion as sub(byval ctxcanvas as cdCtxCanvas ptr)
	cxIsPointInRegion as function(byval ctxcanvas as cdCtxCanvas ptr, byval x as long, byval y as long) as long
	cxOffsetRegion as sub(byval ctxcanvas as cdCtxCanvas ptr, byval x as long, byval y as long)
	cxGetRegionBox as sub(byval ctxcanvas as cdCtxCanvas ptr, byval xmin as long ptr, byval xmax as long ptr, byval ymin as long ptr, byval ymax as long ptr)
	cxActivate as function(byval ctxcanvas as cdCtxCanvas ptr) as long
	cxDeactivate as sub(byval ctxcanvas as cdCtxCanvas ptr)
	w as long
	h as long
	w_mm as double
	h_mm as double
	xres as double
	yres as double
	bpp as long
	invert_yaxis as long
	matrix(0 to 5) as double
	use_matrix as long
	clip_mode as long
	clip_rect as cdRect
	clip_frect as cdfRect
	clip_poly_n as long
	clip_poly as cdPoint ptr
	clip_fpoly as cdfPoint ptr
	new_region as long
	combine_mode as long
	foreground as clong
	background as clong
	back_opacity as long
	write_mode as long
	mark_type as long
	mark_size as long
	line_style as long
	line_width as long
	line_cap as long
	line_join as long
	line_dashes as long ptr
	line_dashes_count as long
	interior_style as long
	hatch_style as long
	fill_mode as long
	font_type_face as zstring * 1024
	font_style as long
	font_size as long
	text_alignment as long
	text_orientation as double
	native_font as zstring * 1024
	pattern_w as long
	pattern_h as long
	pattern_size as long
	pattern as clong ptr
	stipple_w as long
	stipple_h as long
	stipple_size as long
	stipple as ubyte ptr
	use_origin as long
	origin as cdPoint
	forigin as cdfPoint
	poly_mode as long
	poly_n as long
	poly_size as long
	fpoly_size as long
	poly as cdPoint ptr
	fpoly as cdfPoint ptr
	use_fpoly as long
	path_n as long
	path_size as long
	path as long ptr
	path_arc_index as long
	sim_mode as long
	s as double
	sx as double
	tx as double
	sy as double
	ty as double
	window as cdfRect
	viewport as cdRect
	attrib_list(0 to 49) as cdAttribute ptr
	attrib_n as long
	vector_font as cdVectorFont ptr
	simulation as cdSimulation ptr
	ctxcanvas as cdCtxCanvas ptr
	context as cdContext ptr
end type

enum
	CD_BASE_WIN
	CD_BASE_X
	CD_BASE_GDK
	CD_BASE_HAIKU
end enum

declare function cdBaseDriver() as long
declare sub cdRegisterAttribute(byval canvas as cdCanvas ptr, byval attrib as cdAttribute ptr)
declare sub cdUpdateAttributes(byval canvas as cdCanvas ptr)
declare function cdCreateVectorFont(byval canvas as cdCanvas ptr) as cdVectorFont ptr
declare sub cdKillVectorFont(byval vector_font_data as cdVectorFont ptr)
declare sub wdSetDefaults(byval canvas as cdCanvas ptr)
declare sub cdInitContextPlusList(byval ctx_list as cdContext ptr ptr)
declare function cdGetContextPlus(byval ctx as long) as cdContext ptr

enum
	CD_CTXPLUS_NATIVEWINDOW
	CD_CTXPLUS_IMAGE
	CD_CTXPLUS_DBUFFER
	CD_CTXPLUS_PRINTER
	CD_CTXPLUS_EMF
	CD_CTXPLUS_CLIPBOARD
end enum

const CD_CTXPLUS_COUNT = 6
const CD_CTX_PLUS = &hFF00
declare function cdRound(byval x as double) as long
declare function cdCheckBoxSize(byval xmin as long ptr, byval xmax as long ptr, byval ymin as long ptr, byval ymax as long ptr) as long
declare function cdfCheckBoxSize(byval xmin as double ptr, byval xmax as double ptr, byval ymin as double ptr, byval ymax as double ptr) as long
declare sub cdNormalizeLimits(byval w as long, byval h as long, byval xmin as long ptr, byval xmax as long ptr, byval ymin as long ptr, byval ymax as long ptr)
declare function cdGetFileName(byval strdata as const zstring ptr, byval filename as zstring ptr) as long
declare function cdStrEqualNoCase(byval str1 as const zstring ptr, byval str2 as const zstring ptr) as long
declare function cdStrEqualNoCasePartial(byval str1 as const zstring ptr, byval str2 as const zstring ptr) as long
declare function cdStrLineCount(byval str as const zstring ptr) as long
declare function cdStrDup(byval str as const zstring ptr) as zstring ptr
declare function cdStrDupN(byval str as const zstring ptr, byval len as long) as zstring ptr
declare function cdStrIsAscii(byval str as const zstring ptr) as long
declare sub cdSetPaperSize(byval size as long, byval w_pt as double ptr, byval h_pt as double ptr)
declare function cdGetFontFileName(byval type_face as const zstring ptr, byval filename as zstring ptr) as long
declare function cdGetFontFileNameDefault(byval type_face as const zstring ptr, byval style as long, byval filename as zstring ptr) as long
declare function cdGetFontFileNameSystem(byval type_face as const zstring ptr, byval style as long, byval filename as zstring ptr) as long
declare function cdStrTmpFileName(byval filename as zstring ptr) as long
declare sub cdCanvasPoly(byval canvas as cdCanvas ptr, byval mode as long, byval points as cdPoint ptr, byval n as long)
declare sub cdCanvasGetArcBox(byval xc as long, byval yc as long, byval w as long, byval h as long, byval a1 as double, byval a2 as double, byval xmin as long ptr, byval xmax as long ptr, byval ymin as long ptr, byval ymax as long ptr)
declare function cdCanvasGetArcPathF(byval poly as const cdPoint ptr, byval xc as double ptr, byval yc as double ptr, byval w as double ptr, byval h as double ptr, byval a1 as double ptr, byval a2 as double ptr) as long
declare function cdfCanvasGetArcPath(byval poly as const cdfPoint ptr, byval xc as double ptr, byval yc as double ptr, byval w as double ptr, byval h as double ptr, byval a1 as double ptr, byval a2 as double ptr) as long
declare function cdCanvasGetArcPath(byval poly as const cdPoint ptr, byval xc as long ptr, byval yc as long ptr, byval w as long ptr, byval h as long ptr, byval a1 as double ptr, byval a2 as double ptr) as long
declare sub cdCanvasGetArcStartEnd(byval xc as long, byval yc as long, byval w as long, byval h as long, byval a1 as double, byval a2 as double, byval x1 as long ptr, byval y1 as long ptr, byval x2 as long ptr, byval y2 as long ptr)
declare sub cdfCanvasGetArcStartEnd(byval xc as double, byval yc as double, byval w as double, byval h as double, byval a1 as double, byval a2 as double, byval x1 as double ptr, byval y1 as double ptr, byval x2 as double ptr, byval y2 as double ptr)

#define _cdCheckCanvas(_canvas) (((_canvas <> NULL) andalso (cptr(ubyte ptr, _canvas)[0] = asc("C"))) andalso (cptr(ubyte ptr, _canvas)[1] = asc("D")))
#macro _cdSwapInt(_a, _b)
	scope
		dim _c as long = _a
		_a = _b
		_b = _c
	end scope
#endmacro
#macro _cdSwapDouble(_a, _b)
	scope
		dim _c as double = _a
		_a = _b
		_b = _c
	end scope
#endmacro
#define _cdRound(_x) clng(iif(_x < 0, _x - 0.5, _x + 0.5))
#define _cdRotateHatch(_x) scope : (_x) = ((_x) shl 1) or ((_x) shr 7) : end scope
#define _cdInvertYAxis(_canvas, _y) ((_canvas->h - (_y)) - 1)

declare sub cdMatrixTransformPoint(byval matrix as double ptr, byval x as long, byval y as long, byval rx as long ptr, byval ry as long ptr)
declare sub cdfMatrixTransformPoint(byval matrix as double ptr, byval x as double, byval y as double, byval rx as double ptr, byval ry as double ptr)
declare sub cdMatrixMultiply(byval matrix as const double ptr, byval mul_matrix as double ptr)
declare sub cdMatrixInverse(byval matrix as const double ptr, byval inv_matrix as double ptr)
declare sub cdfRotatePoint(byval canvas as cdCanvas ptr, byval x as double, byval y as double, byval cx as double, byval cy as double, byval rx as double ptr, byval ry as double ptr, byval sin_theta as double, byval cos_theta as double)
declare sub cdRotatePoint(byval canvas as cdCanvas ptr, byval x as long, byval y as long, byval cx as long, byval cy as long, byval rx as long ptr, byval ry as long ptr, byval sin_teta as double, byval cos_teta as double)
declare sub cdRotatePointY(byval canvas as cdCanvas ptr, byval x as long, byval y as long, byval cx as long, byval cy as long, byval ry as long ptr, byval sin_theta as double, byval cos_theta as double)
declare sub cdTextTranslatePoint(byval canvas as cdCanvas ptr, byval x as long, byval y as long, byval w as long, byval h as long, byval baseline as long, byval rx as long ptr, byval ry as long ptr)
declare sub cdMovePoint(byval x as long ptr, byval y as long ptr, byval dx as double, byval dy as double, byval sin_theta as double, byval cos_theta as double)
declare sub cdfMovePoint(byval x as double ptr, byval y as double ptr, byval dx as double, byval dy as double, byval sin_theta as double, byval cos_theta as double)
declare function cdParsePangoFont(byval nativefont as const zstring ptr, byval type_face as zstring ptr, byval style as long ptr, byval size as long ptr) as long
declare function cdParseIupWinFont(byval nativefont as const zstring ptr, byval type_face as zstring ptr, byval style as long ptr, byval size as long ptr) as long
declare function cdParseXWinFont(byval nativefont as const zstring ptr, byval type_face as zstring ptr, byval style as long ptr, byval size as long ptr) as long
declare function cdGetFontSizePixels(byval canvas as cdCanvas ptr, byval size as long) as long
declare function cdGetFontSizePoints(byval canvas as cdCanvas ptr, byval size as long) as long
declare sub cdgetfontdimEX(byval ctxcanvas as cdCtxCanvas ptr, byval max_width as long ptr, byval height as long ptr, byval ascent as long ptr, byval descent as long ptr)
declare sub cdgettextsizeEX(byval ctxcanvas as cdCtxCanvas ptr, byval s as const zstring ptr, byval len as long, byval width as long ptr, byval height as long ptr)
declare function cdZeroOrderInterpolation(byval width as long, byval height as long, byval map as const ubyte ptr, byval xl as double, byval yl as double) as ubyte
declare function cdBilinearInterpolation(byval width as long, byval height as long, byval map as const ubyte ptr, byval xl as double, byval yl as double) as ubyte
declare sub cdImageRGBInitInverseTransform(byval w as long, byval h as long, byval xmin as long, byval xmax as long, byval ymin as long, byval ymax as long, byval xfactor as double ptr, byval yfactor as double ptr, byval matrix as const double ptr, byval inv_matrix as double ptr)
declare sub cdImageRGBInverseTransform(byval t_x as long, byval t_y as long, byval i_x as double ptr, byval i_y as double ptr, byval xfactor as double, byval yfactor as double, byval xmin as long, byval ymin as long, byval x as long, byval y as long, byval inv_matrix as double ptr)
declare sub cdImageRGBCalcDstLimits(byval canvas as cdCanvas ptr, byval x as long, byval y as long, byval w as long, byval h as long, byval xmin as long ptr, byval xmax as long ptr, byval ymin as long ptr, byval ymax as long ptr, byval rect as long ptr)
declare sub cdRGB2Gray(byval width as long, byval height as long, byval red as const ubyte ptr, byval green as const ubyte ptr, byval blue as const ubyte ptr, byval index as ubyte ptr, byval color as clong ptr)
#define CD_ALPHA_BLEND(_src, _dst, _alpha) cubyte((((_src) * (_alpha)) + ((_dst) * (255 - (_alpha)))) / 255)
declare function cdGetZoomTable(byval w as long, byval rw as long, byval xmin as long) as long ptr
declare function cdCalcZoom(byval canvas_size as long, byval cnv_rect_pos as long, byval cnv_rect_size as long, byval new_cnv_rect_pos as long ptr, byval new_cnv_rect_size as long ptr, byval img_rect_pos as long, byval img_rect_size as long, byval new_img_rect_pos as long ptr, byval new_img_rect_size as long ptr, byval is_horizontal as long) as long
declare function cdCreateSimulation(byval canvas as cdCanvas ptr) as cdSimulation ptr
declare sub cdKillSimulation(byval simulation as cdSimulation ptr)
declare sub cdSimInitText(byval simulation as cdSimulation ptr)
declare sub cdSimTextFT(byval ctxcanvas as cdCtxCanvas ptr, byval x as long, byval y as long, byval s as const zstring ptr, byval len as long)
declare function cdSimFontFT(byval ctxcanvas as cdCtxCanvas ptr, byval type_face as const zstring ptr, byval style as long, byval size as long) as long
declare sub cdSimGetFontDimFT(byval ctxcanvas as cdCtxCanvas ptr, byval max_width as long ptr, byval height as long ptr, byval ascent as long ptr, byval descent as long ptr)
declare sub cdSimGetTextSizeFT(byval ctxcanvas as cdCtxCanvas ptr, byval s as const zstring ptr, byval len as long, byval width as long ptr, byval height as long ptr)
declare sub cdSimMark(byval canvas as cdCanvas ptr, byval x as long, byval y as long)
declare sub cdSimPutImageRectRGBA(byval canvas as cdCanvas ptr, byval iw as long, byval ih as long, byval r as const ubyte ptr, byval g as const ubyte ptr, byval b as const ubyte ptr, byval a as const ubyte ptr, byval x as long, byval y as long, byval w as long, byval h as long, byval xmin as long, byval xmax as long, byval ymin as long, byval ymax as long)
declare sub cdSimPutImageRectRGB(byval canvas as cdCanvas ptr, byval iw as long, byval ih as long, byval r as const ubyte ptr, byval g as const ubyte ptr, byval b as const ubyte ptr, byval x as long, byval y as long, byval w as long, byval h as long, byval xmin as long, byval xmax as long, byval ymin as long, byval ymax as long)
declare sub cdSimLine(byval ctxcanvas as cdCtxCanvas ptr, byval x1 as long, byval y1 as long, byval x2 as long, byval y2 as long)
declare sub cdSimRect(byval ctxcanvas as cdCtxCanvas ptr, byval xmin as long, byval xmax as long, byval ymin as long, byval ymax as long)
declare sub cdSimBox(byval ctxcanvas as cdCtxCanvas ptr, byval xmin as long, byval xmax as long, byval ymin as long, byval ymax as long)
declare sub cdSimArc(byval ctxcanvas as cdCtxCanvas ptr, byval xc as long, byval yc as long, byval width as long, byval height as long, byval angle1 as double, byval angle2 as double)
declare sub cdSimSector(byval ctxcanvas as cdCtxCanvas ptr, byval xc as long, byval yc as long, byval width as long, byval height as long, byval angle1 as double, byval angle2 as double)
declare sub cdSimChord(byval ctxcanvas as cdCtxCanvas ptr, byval xc as long, byval yc as long, byval width as long, byval height as long, byval angle1 as double, byval angle2 as double)
declare sub cdSimPoly(byval ctxcanvas as cdCtxCanvas ptr, byval mode as long, byval points as cdPoint ptr, byval n as long)
declare sub cdSimPolyBezier(byval canvas as cdCanvas ptr, byval points as const cdPoint ptr, byval n as long)
declare sub cdSimPolyPath(byval canvas as cdCanvas ptr, byval points as const cdPoint ptr, byval n as long)
declare sub cdfSimLine(byval ctxcanvas as cdCtxCanvas ptr, byval x1 as double, byval y1 as double, byval x2 as double, byval y2 as double)
declare sub cdfSimRect(byval ctxcanvas as cdCtxCanvas ptr, byval xmin as double, byval xmax as double, byval ymin as double, byval ymax as double)
declare sub cdfSimBox(byval ctxcanvas as cdCtxCanvas ptr, byval xmin as double, byval xmax as double, byval ymin as double, byval ymax as double)
declare sub cdfSimArc(byval ctxcanvas as cdCtxCanvas ptr, byval xc as double, byval yc as double, byval width as double, byval height as double, byval angle1 as double, byval angle2 as double)
declare sub cdfSimSector(byval ctxcanvas as cdCtxCanvas ptr, byval xc as double, byval yc as double, byval width as double, byval height as double, byval angle1 as double, byval angle2 as double)
declare sub cdfSimChord(byval ctxcanvas as cdCtxCanvas ptr, byval xc as double, byval yc as double, byval width as double, byval height as double, byval angle1 as double, byval angle2 as double)
declare sub cdfSimPoly(byval ctxcanvas as cdCtxCanvas ptr, byval mode as long, byval fpoly as cdfPoint ptr, byval n as long)
declare sub cdfSimPolyBezier(byval canvas as cdCanvas ptr, byval points as const cdfPoint ptr, byval n as long)
declare sub cdfSimPolyPath(byval canvas as cdCanvas ptr, byval points as const cdfPoint ptr, byval n as long)

end extern
