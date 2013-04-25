''
''
'' cd -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __cd_bi__
#define __cd_bi__

#inclib "cd"

#define CD_NAME "CD - Canvas Draw"
#define CD_DESCRIPTION "A 2D Graphics Library"
#define CD_COPYRIGHT "Copyright (C) 1994-2012 Tecgraf, PUC-Rio."
#define CD_VERSION "5.6"
#define CD_VERSION_NUMBER 506000
#define CD_VERSION_DATE "2012/11/28"

type cdContext as _cdContext
type cdCanvas as _cdCanvas
type cdState as _cdCanvas
type cdImage as _cdImage

type _cdBitmap
	w as integer
	h as integer
	type as integer
	data as any ptr
end type

type cdBitmap as _cdBitmap

declare function cdVersion cdecl alias "cdVersion" () as zstring ptr
declare function cdVersionDate cdecl alias "cdVersionDate" () as zstring ptr
declare function cdVersionNumber cdecl alias "cdVersionNumber" () as integer
declare function cdCreateCanvas cdecl alias "cdCreateCanvas" (byval context as cdContext ptr, byval data as any ptr) as cdCanvas ptr
declare function cdCreateCanvasf cdecl alias "cdCreateCanvasf" (byval context as cdContext ptr, byval format as zstring ptr, ...) as cdCanvas ptr
declare sub cdKillCanvas cdecl alias "cdKillCanvas" (byval canvas as cdCanvas ptr)
declare function cdCanvasGetContext cdecl alias "cdCanvasGetContext" (byval canvas as cdCanvas ptr) as cdContext ptr
declare function cdCanvasActivate cdecl alias "cdCanvasActivate" (byval canvas as cdCanvas ptr) as integer
declare sub cdCanvasDeactivate cdecl alias "cdCanvasDeactivate" (byval canvas as cdCanvas ptr)
declare function cdUseContextPlus cdecl alias "cdUseContextPlus" (byval use as integer) as integer
declare sub cdInitContextPlus cdecl alias "cdInitContextPlus" ()
declare sub cdFinishContextPlus cdecl alias "cdFinishContextPlus" ()

type cdCallback as function cdecl(byval as cdCanvas ptr, ...) as integer

declare function cdContextRegisterCallback cdecl alias "cdContextRegisterCallback" (byval context as cdContext ptr, byval cb as integer, byval func as cdCallback) as integer
declare function cdContextCaps cdecl alias "cdContextCaps" (byval context as cdContext ptr) as uinteger
declare function cdContextIsPlus cdecl alias "cdContextIsPlus" (byval context as cdContext ptr) as integer
declare function cdContextType cdecl alias "cdContextType" (byval context as cdContext ptr) as integer
declare function cdCanvasSimulate cdecl alias "cdCanvasSimulate" (byval canvas as cdCanvas ptr, byval mode as integer) as integer
declare sub cdCanvasFlush cdecl alias "cdCanvasFlush" (byval canvas as cdCanvas ptr)
declare sub cdCanvasClear cdecl alias "cdCanvasClear" (byval canvas as cdCanvas ptr)
declare function cdCanvasSaveState cdecl alias "cdCanvasSaveState" (byval canvas as cdCanvas ptr) as cdState ptr
declare sub cdCanvasRestoreState cdecl alias "cdCanvasRestoreState" (byval canvas as cdCanvas ptr, byval state as cdState ptr)
declare sub cdReleaseState cdecl alias "cdReleaseState" (byval state as cdState ptr)
declare sub cdCanvasSetAttribute cdecl alias "cdCanvasSetAttribute" (byval canvas as cdCanvas ptr, byval name as zstring ptr, byval data as zstring ptr)
declare sub cdCanvasSetfAttribute cdecl alias "cdCanvasSetfAttribute" (byval canvas as cdCanvas ptr, byval name as zstring ptr, byval format as zstring ptr, ...)
declare function cdCanvasGetAttribute cdecl alias "cdCanvasGetAttribute" (byval canvas as cdCanvas ptr, byval name as zstring ptr) as zstring ptr
declare function cdCanvasPlay cdecl alias "cdCanvasPlay" (byval canvas as cdCanvas ptr, byval context as cdContext ptr, byval xmin as integer, byval xmax as integer, byval ymin as integer, byval ymax as integer, byval data as any ptr) as integer
declare sub cdCanvasGetSize cdecl alias "cdCanvasGetSize" (byval canvas as cdCanvas ptr, byval width as integer ptr, byval height as integer ptr, byval width_mm as double ptr, byval height_mm as double ptr)
declare function cdCanvasUpdateYAxis cdecl alias "cdCanvasUpdateYAxis" (byval canvas as cdCanvas ptr, byval y as integer ptr) as integer
declare function cdfCanvasUpdateYAxis cdecl alias "cdfCanvasUpdateYAxis" (byval canvas as cdCanvas ptr, byval y as double ptr) as double
declare function cdCanvasInvertYAxis cdecl alias "cdCanvasInvertYAxis" (byval canvas as cdCanvas ptr, byval y as integer) as integer
declare function cdfCanvasInvertYAxis cdecl alias "cdfCanvasInvertYAxis" (byval canvas as cdCanvas ptr, byval y as double) as double
declare sub cdCanvasMM2Pixel cdecl alias "cdCanvasMM2Pixel" (byval canvas as cdCanvas ptr, byval mm_dx as double, byval mm_dy as double, byval dx as integer ptr, byval dy as integer ptr)
declare sub cdCanvasPixel2MM cdecl alias "cdCanvasPixel2MM" (byval canvas as cdCanvas ptr, byval dx as integer, byval dy as integer, byval mm_dx as double ptr, byval mm_dy as double ptr)
declare sub cdfCanvasMM2Pixel cdecl alias "cdfCanvasMM2Pixel" (byval canvas as cdCanvas ptr, byval mm_dx as double, byval mm_dy as double, byval dx as double ptr, byval dy as double ptr)
declare sub cdfCanvasPixel2MM cdecl alias "cdfCanvasPixel2MM" (byval canvas as cdCanvas ptr, byval dx as double, byval dy as double, byval mm_dx as double ptr, byval mm_dy as double ptr)
declare sub cdCanvasOrigin cdecl alias "cdCanvasOrigin" (byval canvas as cdCanvas ptr, byval x as integer, byval y as integer)
declare sub cdfCanvasOrigin cdecl alias "cdfCanvasOrigin" (byval canvas as cdCanvas ptr, byval x as double, byval y as double)
declare sub cdCanvasGetOrigin cdecl alias "cdCanvasGetOrigin" (byval canvas as cdCanvas ptr, byval x as integer ptr, byval y as integer ptr)
declare sub cdfCanvasGetOrigin cdecl alias "cdfCanvasGetOrigin" (byval canvas as cdCanvas ptr, byval x as double ptr, byval y as double ptr)
declare sub cdCanvasTransform cdecl alias "cdCanvasTransform" (byval canvas as cdCanvas ptr, byval matrix as double ptr)
declare function cdCanvasGetTransform cdecl alias "cdCanvasGetTransform" (byval canvas as cdCanvas ptr) as double ptr
declare sub cdCanvasTransformMultiply cdecl alias "cdCanvasTransformMultiply" (byval canvas as cdCanvas ptr, byval matrix as double ptr)
declare sub cdCanvasTransformRotate cdecl alias "cdCanvasTransformRotate" (byval canvas as cdCanvas ptr, byval angle as double)
declare sub cdCanvasTransformScale cdecl alias "cdCanvasTransformScale" (byval canvas as cdCanvas ptr, byval sx as double, byval sy as double)
declare sub cdCanvasTransformTranslate cdecl alias "cdCanvasTransformTranslate" (byval canvas as cdCanvas ptr, byval dx as double, byval dy as double)
declare sub cdCanvasTransformPoint cdecl alias "cdCanvasTransformPoint" (byval canvas as cdCanvas ptr, byval x as integer, byval y as integer, byval tx as integer ptr, byval ty as integer ptr)
declare sub cdfCanvasTransformPoint cdecl alias "cdfCanvasTransformPoint" (byval canvas as cdCanvas ptr, byval x as double, byval y as double, byval tx as double ptr, byval ty as double ptr)
declare function cdCanvasClip cdecl alias "cdCanvasClip" (byval canvas as cdCanvas ptr, byval mode as integer) as integer
declare sub cdCanvasClipArea cdecl alias "cdCanvasClipArea" (byval canvas as cdCanvas ptr, byval xmin as integer, byval xmax as integer, byval ymin as integer, byval ymax as integer)
declare function cdCanvasGetClipArea cdecl alias "cdCanvasGetClipArea" (byval canvas as cdCanvas ptr, byval xmin as integer ptr, byval xmax as integer ptr, byval ymin as integer ptr, byval ymax as integer ptr) as integer
declare sub cdfCanvasClipArea cdecl alias "cdfCanvasClipArea" (byval canvas as cdCanvas ptr, byval xmin as double, byval xmax as double, byval ymin as double, byval ymax as double)
declare function cdfCanvasGetClipArea cdecl alias "cdfCanvasGetClipArea" (byval canvas as cdCanvas ptr, byval xmin as double ptr, byval xmax as double ptr, byval ymin as double ptr, byval ymax as double ptr) as integer
declare function cdCanvasIsPointInRegion cdecl alias "cdCanvasIsPointInRegion" (byval canvas as cdCanvas ptr, byval x as integer, byval y as integer) as integer
declare sub cdCanvasOffsetRegion cdecl alias "cdCanvasOffsetRegion" (byval canvas as cdCanvas ptr, byval x as integer, byval y as integer)
declare sub cdCanvasGetRegionBox cdecl alias "cdCanvasGetRegionBox" (byval canvas as cdCanvas ptr, byval xmin as integer ptr, byval xmax as integer ptr, byval ymin as integer ptr, byval ymax as integer ptr)
declare function cdCanvasRegionCombineMode cdecl alias "cdCanvasRegionCombineMode" (byval canvas as cdCanvas ptr, byval mode as integer) as integer
declare sub cdCanvasPixel cdecl alias "cdCanvasPixel" (byval canvas as cdCanvas ptr, byval x as integer, byval y as integer, byval color as integer)
declare sub cdCanvasMark cdecl alias "cdCanvasMark" (byval canvas as cdCanvas ptr, byval x as integer, byval y as integer)
declare sub cdCanvasBegin cdecl alias "cdCanvasBegin" (byval canvas as cdCanvas ptr, byval mode as integer)
declare sub cdCanvasPathSet cdecl alias "cdCanvasPathSet" (byval canvas as cdCanvas ptr, byval action as integer)
declare sub cdCanvasEnd cdecl alias "cdCanvasEnd" (byval canvas as cdCanvas ptr)
declare sub cdCanvasLine cdecl alias "cdCanvasLine" (byval canvas as cdCanvas ptr, byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer)
declare sub cdCanvasVertex cdecl alias "cdCanvasVertex" (byval canvas as cdCanvas ptr, byval x as integer, byval y as integer)
declare sub cdCanvasRect cdecl alias "cdCanvasRect" (byval canvas as cdCanvas ptr, byval xmin as integer, byval xmax as integer, byval ymin as integer, byval ymax as integer)
declare sub cdCanvasBox cdecl alias "cdCanvasBox" (byval canvas as cdCanvas ptr, byval xmin as integer, byval xmax as integer, byval ymin as integer, byval ymax as integer)
declare sub cdCanvasArc cdecl alias "cdCanvasArc" (byval canvas as cdCanvas ptr, byval xc as integer, byval yc as integer, byval w as integer, byval h as integer, byval angle1 as double, byval angle2 as double)
declare sub cdCanvasSector cdecl alias "cdCanvasSector" (byval canvas as cdCanvas ptr, byval xc as integer, byval yc as integer, byval w as integer, byval h as integer, byval angle1 as double, byval angle2 as double)
declare sub cdCanvasChord cdecl alias "cdCanvasChord" (byval canvas as cdCanvas ptr, byval xc as integer, byval yc as integer, byval w as integer, byval h as integer, byval angle1 as double, byval angle2 as double)
declare sub cdCanvasText cdecl alias "cdCanvasText" (byval canvas as cdCanvas ptr, byval x as integer, byval y as integer, byval s as zstring ptr)
declare sub cdfCanvasLine cdecl alias "cdfCanvasLine" (byval canvas as cdCanvas ptr, byval x1 as double, byval y1 as double, byval x2 as double, byval y2 as double)
declare sub cdfCanvasVertex cdecl alias "cdfCanvasVertex" (byval canvas as cdCanvas ptr, byval x as double, byval y as double)
declare sub cdfCanvasRect cdecl alias "cdfCanvasRect" (byval canvas as cdCanvas ptr, byval xmin as double, byval xmax as double, byval ymin as double, byval ymax as double)
declare sub cdfCanvasBox cdecl alias "cdfCanvasBox" (byval canvas as cdCanvas ptr, byval xmin as double, byval xmax as double, byval ymin as double, byval ymax as double)
declare sub cdfCanvasArc cdecl alias "cdfCanvasArc" (byval canvas as cdCanvas ptr, byval xc as double, byval yc as double, byval w as double, byval h as double, byval angle1 as double, byval angle2 as double)
declare sub cdfCanvasSector cdecl alias "cdfCanvasSector" (byval canvas as cdCanvas ptr, byval xc as double, byval yc as double, byval w as double, byval h as double, byval angle1 as double, byval angle2 as double)
declare sub cdfCanvasChord cdecl alias "cdfCanvasChord" (byval canvas as cdCanvas ptr, byval xc as double, byval yc as double, byval w as double, byval h as double, byval angle1 as double, byval angle2 as double)
declare sub cdfCanvasText cdecl alias "cdfCanvasText" (byval canvas as cdCanvas ptr, byval x as double, byval y as double, byval s as zstring ptr)
declare sub cdCanvasSetBackground cdecl alias "cdCanvasSetBackground" (byval canvas as cdCanvas ptr, byval color as integer)
declare sub cdCanvasSetForeground cdecl alias "cdCanvasSetForeground" (byval canvas as cdCanvas ptr, byval color as integer)
declare function cdCanvasBackground cdecl alias "cdCanvasBackground" (byval canvas as cdCanvas ptr, byval color as integer) as integer
declare function cdCanvasForeground cdecl alias "cdCanvasForeground" (byval canvas as cdCanvas ptr, byval color as integer) as integer
declare function cdCanvasBackOpacity cdecl alias "cdCanvasBackOpacity" (byval canvas as cdCanvas ptr, byval opacity as integer) as integer
declare function cdCanvasWriteMode cdecl alias "cdCanvasWriteMode" (byval canvas as cdCanvas ptr, byval mode as integer) as integer
declare function cdCanvasLineStyle cdecl alias "cdCanvasLineStyle" (byval canvas as cdCanvas ptr, byval style as integer) as integer
declare sub cdCanvasLineStyleDashes cdecl alias "cdCanvasLineStyleDashes" (byval canvas as cdCanvas ptr, byval dashes as integer ptr, byval count as integer)
declare function cdCanvasLineWidth cdecl alias "cdCanvasLineWidth" (byval canvas as cdCanvas ptr, byval width as integer) as integer
declare function cdCanvasLineJoin cdecl alias "cdCanvasLineJoin" (byval canvas as cdCanvas ptr, byval join as integer) as integer
declare function cdCanvasLineCap cdecl alias "cdCanvasLineCap" (byval canvas as cdCanvas ptr, byval cap as integer) as integer
declare function cdCanvasInteriorStyle cdecl alias "cdCanvasInteriorStyle" (byval canvas as cdCanvas ptr, byval style as integer) as integer
declare function cdCanvasHatch cdecl alias "cdCanvasHatch" (byval canvas as cdCanvas ptr, byval style as integer) as integer
declare sub cdCanvasStipple cdecl alias "cdCanvasStipple" (byval canvas as cdCanvas ptr, byval w as integer, byval h as integer, byval stipple as ubyte ptr)
declare function cdCanvasGetStipple cdecl alias "cdCanvasGetStipple" (byval canvas as cdCanvas ptr, byval n as integer ptr, byval m as integer ptr) as ubyte ptr
declare function cdCanvasGetPattern cdecl alias "cdCanvasGetPattern" (byval canvas as cdCanvas ptr, byval n as integer ptr, byval m as integer ptr) as integer ptr
declare function cdCanvasFillMode cdecl alias "cdCanvasFillMode" (byval canvas as cdCanvas ptr, byval mode as integer) as integer
declare function cdCanvasFont cdecl alias "cdCanvasFont" (byval canvas as cdCanvas ptr, byval type_face as zstring ptr, byval style as integer, byval size as integer) as integer
declare sub cdCanvasGetFont cdecl alias "cdCanvasGetFont" (byval canvas as cdCanvas ptr, byval type_face as zstring ptr, byval style as integer ptr, byval size as integer ptr)
declare function cdCanvasNativeFont cdecl alias "cdCanvasNativeFont" (byval canvas as cdCanvas ptr, byval font as zstring ptr) as zstring ptr
declare function cdCanvasTextAlignment cdecl alias "cdCanvasTextAlignment" (byval canvas as cdCanvas ptr, byval alignment as integer) as integer
declare function cdCanvasTextOrientation cdecl alias "cdCanvasTextOrientation" (byval canvas as cdCanvas ptr, byval angle as double) as double
declare function cdCanvasMarkType cdecl alias "cdCanvasMarkType" (byval canvas as cdCanvas ptr, byval type as integer) as integer
declare function cdCanvasMarkSize cdecl alias "cdCanvasMarkSize" (byval canvas as cdCanvas ptr, byval size as integer) as integer
declare sub cdCanvasVectorText cdecl alias "cdCanvasVectorText" (byval canvas as cdCanvas ptr, byval x as integer, byval y as integer, byval s as zstring ptr)
declare sub cdCanvasMultiLineVectorText cdecl alias "cdCanvasMultiLineVectorText" (byval canvas as cdCanvas ptr, byval x as integer, byval y as integer, byval s as zstring ptr)
declare function cdCanvasVectorFont cdecl alias "cdCanvasVectorFont" (byval canvas as cdCanvas ptr, byval filename as zstring ptr) as zstring ptr
declare sub cdCanvasVectorTextDirection cdecl alias "cdCanvasVectorTextDirection" (byval canvas as cdCanvas ptr, byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer)
declare function cdCanvasVectorTextTransform cdecl alias "cdCanvasVectorTextTransform" (byval canvas as cdCanvas ptr, byval matrix as double ptr) as double ptr
declare sub cdCanvasVectorTextSize cdecl alias "cdCanvasVectorTextSize" (byval canvas as cdCanvas ptr, byval size_x as integer, byval size_y as integer, byval s as zstring ptr)
declare function cdCanvasVectorCharSize cdecl alias "cdCanvasVectorCharSize" (byval canvas as cdCanvas ptr, byval size as integer) as integer
declare sub cdCanvasVectorFontSize cdecl alias "cdCanvasVectorFontSize" (byval canvas as cdCanvas ptr, byval size_x as double, byval size_y as double)
declare sub cdCanvasGetVectorFontSize cdecl alias "cdCanvasGetVectorFontSize" (byval canvas as cdCanvas ptr, byval size_x as double ptr, byval size_y as double ptr)
declare sub cdCanvasGetVectorTextSize cdecl alias "cdCanvasGetVectorTextSize" (byval canvas as cdCanvas ptr, byval s as zstring ptr, byval x as integer ptr, byval y as integer ptr)
declare sub cdCanvasGetVectorTextBounds cdecl alias "cdCanvasGetVectorTextBounds" (byval canvas as cdCanvas ptr, byval s as zstring ptr, byval x as integer, byval y as integer, byval rect as integer ptr)
declare sub cdCanvasGetVectorTextBox cdecl alias "cdCanvasGetVectorTextBox" (byval canvas as cdCanvas ptr, byval x as integer, byval y as integer, byval s as zstring ptr, byval xmin as integer ptr, byval xmax as integer ptr, byval ymin as integer ptr, byval ymax as integer ptr)
declare sub cdCanvasGetFontDim cdecl alias "cdCanvasGetFontDim" (byval canvas as cdCanvas ptr, byval max_width as integer ptr, byval height as integer ptr, byval ascent as integer ptr, byval descent as integer ptr)
declare sub cdCanvasGetTextSize cdecl alias "cdCanvasGetTextSize" (byval canvas as cdCanvas ptr, byval s as zstring ptr, byval width as integer ptr, byval height as integer ptr)
declare sub cdCanvasGetTextBox cdecl alias "cdCanvasGetTextBox" (byval canvas as cdCanvas ptr, byval x as integer, byval y as integer, byval s as zstring ptr, byval xmin as integer ptr, byval xmax as integer ptr, byval ymin as integer ptr, byval ymax as integer ptr)
declare sub cdCanvasGetTextBounds cdecl alias "cdCanvasGetTextBounds" (byval canvas as cdCanvas ptr, byval x as integer, byval y as integer, byval s as zstring ptr, byval rect as integer ptr)
declare function cdCanvasGetColorPlanes cdecl alias "cdCanvasGetColorPlanes" (byval canvas as cdCanvas ptr) as integer
declare sub cdCanvasPalette cdecl alias "cdCanvasPalette" (byval canvas as cdCanvas ptr, byval n as integer, byval palette as integer ptr, byval mode as integer)
declare sub cdCanvasGetImageRGB cdecl alias "cdCanvasGetImageRGB" (byval canvas as cdCanvas ptr, byval r as ubyte ptr, byval g as ubyte ptr, byval b as ubyte ptr, byval x as integer, byval y as integer, byval w as integer, byval h as integer)
declare sub cdCanvasPutImageRectRGB cdecl alias "cdCanvasPutImageRectRGB" (byval canvas as cdCanvas ptr, byval iw as integer, byval ih as integer, byval r as ubyte ptr, byval g as ubyte ptr, byval b as ubyte ptr, byval x as integer, byval y as integer, byval w as integer, byval h as integer, byval xmin as integer, byval xmax as integer, byval ymin as integer, byval ymax as integer)
declare sub cdCanvasPutImageRectRGBA cdecl alias "cdCanvasPutImageRectRGBA" (byval canvas as cdCanvas ptr, byval iw as integer, byval ih as integer, byval r as ubyte ptr, byval g as ubyte ptr, byval b as ubyte ptr, byval a as ubyte ptr, byval x as integer, byval y as integer, byval w as integer, byval h as integer, byval xmin as integer, byval xmax as integer, byval ymin as integer, byval ymax as integer)
declare sub cdCanvasPutImageRectMap cdecl alias "cdCanvasPutImageRectMap" (byval canvas as cdCanvas ptr, byval iw as integer, byval ih as integer, byval index as ubyte ptr, byval colors as integer ptr, byval x as integer, byval y as integer, byval w as integer, byval h as integer, byval xmin as integer, byval xmax as integer, byval ymin as integer, byval ymax as integer)
declare function cdCanvasCreateImage cdecl alias "cdCanvasCreateImage" (byval canvas as cdCanvas ptr, byval w as integer, byval h as integer) as cdImage ptr
declare sub cdKillImage cdecl alias "cdKillImage" (byval image as cdImage ptr)
declare sub cdCanvasGetImage cdecl alias "cdCanvasGetImage" (byval canvas as cdCanvas ptr, byval image as cdImage ptr, byval x as integer, byval y as integer)
declare sub cdCanvasPutImageRect cdecl alias "cdCanvasPutImageRect" (byval canvas as cdCanvas ptr, byval image as cdImage ptr, byval x as integer, byval y as integer, byval xmin as integer, byval xmax as integer, byval ymin as integer, byval ymax as integer)
declare sub cdCanvasScrollArea cdecl alias "cdCanvasScrollArea" (byval canvas as cdCanvas ptr, byval xmin as integer, byval xmax as integer, byval ymin as integer, byval ymax as integer, byval dx as integer, byval dy as integer)
declare function cdCreateBitmap cdecl alias "cdCreateBitmap" (byval w as integer, byval h as integer, byval type as integer) as cdBitmap ptr
declare function cdInitBitmap cdecl alias "cdInitBitmap" (byval w as integer, byval h as integer, byval type as integer, ...) as cdBitmap ptr
declare sub cdKillBitmap cdecl alias "cdKillBitmap" (byval bitmap as cdBitmap ptr)
declare function cdBitmapGetData cdecl alias "cdBitmapGetData" (byval bitmap as cdBitmap ptr, byval dataptr as integer) as ubyte ptr
declare sub cdBitmapSetRect cdecl alias "cdBitmapSetRect" (byval bitmap as cdBitmap ptr, byval xmin as integer, byval xmax as integer, byval ymin as integer, byval ymax as integer)
declare sub cdCanvasPutBitmap cdecl alias "cdCanvasPutBitmap" (byval canvas as cdCanvas ptr, byval bitmap as cdBitmap ptr, byval x as integer, byval y as integer, byval w as integer, byval h as integer)
declare sub cdCanvasGetBitmap cdecl alias "cdCanvasGetBitmap" (byval canvas as cdCanvas ptr, byval bitmap as cdBitmap ptr, byval x as integer, byval y as integer)
declare sub cdBitmapRGB2Map cdecl alias "cdBitmapRGB2Map" (byval bitmap_rgb as cdBitmap ptr, byval bitmap_map as cdBitmap ptr)
declare function cdEncodeColor cdecl alias "cdEncodeColor" (byval red as ubyte, byval green as ubyte, byval blue as ubyte) as integer
declare sub cdDecodeColor cdecl alias "cdDecodeColor" (byval color as integer, byval red as ubyte ptr, byval green as ubyte ptr, byval blue as ubyte ptr)
declare function cdDecodeAlpha cdecl alias "cdDecodeAlpha" (byval color as integer) as ubyte
declare function cdEncodeAlpha cdecl alias "cdEncodeAlpha" (byval color as integer, byval alpha as ubyte) as integer
declare sub cdRGB2Map cdecl alias "cdRGB2Map" (byval width as integer, byval height as integer, byval red as ubyte ptr, byval green as ubyte ptr, byval blue as ubyte ptr, byval index as ubyte ptr, byval pal_size as integer, byval color as integer ptr)

#define CD_QUERY -1

enum 
	CD_RGB
	CD_MAP
	CD_RGBA = &h100
end enum

enum 
	CD_IRED
	CD_IGREEN
	CD_IBLUE
	CD_IALPHA
	CD_INDEX
	CD_COLORS
end enum

enum 
	CD_ERROR = -1
	CD_OK = 0
end enum

enum 
	CD_CLIPOFF
	CD_CLIPAREA
	CD_CLIPPOLYGON
	CD_CLIPREGION
end enum

enum 
	CD_UNION
	CD_INTERSECT
	CD_DIFFERENCE
	CD_NOTINTERSECT
end enum

enum 
	CD_FILL
	CD_OPEN_LINES
	CD_CLOSED_LINES
	CD_CLIP
	CD_BEZIER
	CD_REGION
	CD_PATH
end enum

#define CD_POLYCUSTOM 10

enum 
	CD_PATH_NEW
	CD_PATH_MOVETO
	CD_PATH_LINETO
	CD_PATH_ARC
	CD_PATH_CURVETO
	CD_PATH_CLOSE
	CD_PATH_FILL
	CD_PATH_STROKE
	CD_PATH_FILLSTROKE
	CD_PATH_CLIP
end enum

enum 
	CD_EVENODD
	CD_WINDING
end enum

enum 
	CD_MITER
	CD_BEVEL
	CD_ROUND
end enum

enum 
	CD_CAPFLAT
	CD_CAPSQUARE
	CD_CAPROUND
end enum

enum 
	CD_OPAQUE
	CD_TRANSPARENT
end enum

enum 
	CD_REPLACE
	CD_XOR
	CD_NOT_XOR
end enum

enum 
	CD_POLITE
	CD_FORCE
end enum

enum 
	CD_CONTINUOUS
	CD_DASHED
	CD_DOTTED
	CD_DASH_DOT
	CD_DASH_DOT_DOT
	CD_CUSTOM
end enum

enum 
	CD_PLUS
	CD_STAR
	CD_CIRCLE
	CD_X
	CD_BOX
	CD_DIAMOND
	CD_HOLLOW_CIRCLE
	CD_HOLLOW_BOX
	CD_HOLLOW_DIAMOND
end enum

enum 
	CD_HORIZONTAL
	CD_VERTICAL
	CD_FDIAGONAL
	CD_BDIAGONAL
	CD_CROSS
	CD_DIAGCROSS
end enum

enum 
	CD_SOLID
	CD_HATCH
	CD_STIPPLE
	CD_PATTERN
	CD_HOLLOW
end enum

enum 
	CD_NORTH
	CD_SOUTH
	CD_EAST
	CD_WEST
	CD_NORTH_EAST
	CD_NORTH_WEST
	CD_SOUTH_EAST
	CD_SOUTH_WEST
	CD_CENTER
	CD_BASE_LEFT
	CD_BASE_CENTER
	CD_BASE_RIGHT
end enum

enum 
	CD_PLAIN = 0
	CD_BOLD = 1
	CD_ITALIC = 2
	CD_UNDERLINE = 4
	CD_STRIKEOUT = 8
end enum

enum 
	CD_SMALL = 8
	CD_STANDARD = 12
	CD_LARGE = 18
end enum

#define CD_CAP_NONE &h00000000
#define CD_CAP_FLUSH &h00000001
#define CD_CAP_CLEAR &h00000002
#define CD_CAP_PLAY &h00000004
#define CD_CAP_YAXIS &h00000008
#define CD_CAP_CLIPAREA &h00000010
#define CD_CAP_CLIPPOLY &h00000020
#define CD_CAP_REGION &h00000040
#define CD_CAP_RECT &h00000080
#define CD_CAP_CHORD &h00000100
#define CD_CAP_IMAGERGB &h00000200
#define CD_CAP_IMAGERGBA &h00000400
#define CD_CAP_IMAGEMAP &h00000800
#define CD_CAP_GETIMAGERGB &h00001000
#define CD_CAP_IMAGESRV &h00002000
#define CD_CAP_BACKGROUND &h00004000
#define CD_CAP_BACKOPACITY &h00008000
#define CD_CAP_WRITEMODE &h00010000
#define CD_CAP_LINESTYLE &h00020000
#define CD_CAP_LINEWITH &h00040000
#define CD_CAP_FPRIMTIVES &h00080000
#define CD_CAP_HATCH &h00100000
#define CD_CAP_STIPPLE &h00200000
#define CD_CAP_PATTERN &h00400000
#define CD_CAP_FONT &h00800000
#define CD_CAP_FONTDIM &h01000000
#define CD_CAP_TEXTSIZE &h02000000
#define CD_CAP_TEXTORIENTATION &h04000000
#define CD_CAP_PALETTE &h08000000
#define CD_CAP_LINECAP &h10000000
#define CD_CAP_LINEJOIN &h20000000
#define CD_CAP_PATH &h40000000
#define CD_CAP_BEZIER &h80000000
#define CD_CAP_ALL &hFFFFFFFF

enum 
	CD_CTX_WINDOW
	CD_CTX_DEVICE
	CD_CTX_IMAGE
	CD_CTX_FILE
end enum

#define CD_SIZECB 0

type cdSizeCB as function cdecl(byval as cdCanvas ptr, byval as integer, byval as integer, byval as double, byval as double) as integer

#define CD_ABORT 1
#define CD_CONTINUE 0
#define CD_SIM_NONE &h0000
#define CD_SIM_LINE &h0001
#define CD_SIM_RECT &h0002
#define CD_SIM_BOX &h0004
#define CD_SIM_ARC &h0008
#define CD_SIM_SECTOR &h0010
#define CD_SIM_CHORD &h0020
#define CD_SIM_POLYLINE &h0040
#define CD_SIM_POLYGON &h0080
#define CD_SIM_TEXT &h0100
#define CD_SIM_ALL &hFFFF
#define CD_SIM_LINES (&h0001 or &h0002 or &h0008 or &h0040)
#define CD_SIM_FILLS (&h0004 or &h0010 or &h0020 or &h0080)
#define CD_RED &hFF0000L
#define CD_DARK_RED &h800000L
#define CD_GREEN &h00FF00L
#define CD_DARK_GREEN &h008000L
#define CD_BLUE &h0000FFL
#define CD_DARK_BLUE &h000080L
#define CD_YELLOW &hFFFF00L
#define CD_DARK_YELLOW &h808000L
#define CD_MAGENTA &hFF00FFL
#define CD_DARK_MAGENTA &h800080L
#define CD_CYAN &h00FFFFL
#define CD_DARK_CYAN &h008080L
#define CD_WHITE &hFFFFFFL
#define CD_BLACK &h000000L
#define CD_DARK_GRAY &h808080L
#define CD_GRAY &hC0C0C0L
#define CD_MM2PT 2.834645669
#define CD_RAD2DEG 57.295779513
#define CD_DEG2RAD 0.01745329252

enum 
	CD_A0
	CD_A1
	CD_A2
	CD_A3
	CD_A4
	CD_A5
	CD_LETTER
	CD_LEGAL
end enum

#endif
