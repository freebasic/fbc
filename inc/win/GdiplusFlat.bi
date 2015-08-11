''
''
'' GdiplusFlat -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_GdiplusFlat_bi__
#define __win_GdiplusFlat_bi__

extern "windows"
declare function GdipCreatePath (byval brushMode as GpFillMode, byval path as GpPath ptr ptr) as GpStatus
declare function GdipCreatePath2 (byval as GpPointF ptr, byval as UBYTE ptr, byval as INT_, byval as GpFillMode, byval path as GpPath ptr ptr) as GpStatus
declare function GdipCreatePath2I (byval as GpPoint ptr, byval as UBYTE ptr, byval as INT_, byval as GpFillMode, byval path as GpPath ptr ptr) as GpStatus
declare function GdipClonePath (byval path as GpPath ptr, byval clonePath as GpPath ptr ptr) as GpStatus
declare function GdipDeletePath (byval path as GpPath ptr) as GpStatus
declare function GdipResetPath (byval path as GpPath ptr) as GpStatus
declare function GdipGetPointCount (byval path as GpPath ptr, byval count as INT_ ptr) as GpStatus
declare function GdipGetPathTypes (byval path as GpPath ptr, byval types as UBYTE ptr, byval count as INT_) as GpStatus
declare function GdipGetPathPoints (byval as GpPath ptr, byval points as GpPointF ptr, byval count as INT_) as GpStatus
declare function GdipGetPathPointsI (byval as GpPath ptr, byval points as GpPoint ptr, byval count as INT_) as GpStatus
declare function GdipGetPathFillMode (byval path as GpPath ptr, byval fillmode as GpFillMode ptr) as GpStatus
declare function GdipSetPathFillMode (byval path as GpPath ptr, byval fillmode as GpFillMode) as GpStatus
declare function GdipGetPathData (byval path as GpPath ptr, byval pathData as GpPathData ptr) as GpStatus
declare function GdipStartPathFigure (byval path as GpPath ptr) as GpStatus
declare function GdipClosePathFigure (byval path as GpPath ptr) as GpStatus
declare function GdipClosePathFigures (byval path as GpPath ptr) as GpStatus
declare function GdipSetPathMarker (byval path as GpPath ptr) as GpStatus
declare function GdipClearPathMarkers (byval path as GpPath ptr) as GpStatus
declare function GdipReversePath (byval path as GpPath ptr) as GpStatus
declare function GdipGetPathLastPoint (byval path as GpPath ptr, byval lastPoint as GpPointF ptr) as GpStatus
declare function GdipAddPathLine (byval path as GpPath ptr, byval x1 as REAL, byval y1 as REAL, byval x2 as REAL, byval y2 as REAL) as GpStatus
declare function GdipAddPathLine2 (byval path as GpPath ptr, byval points as GpPointF ptr, byval count as INT_) as GpStatus
declare function GdipAddPathArc (byval path as GpPath ptr, byval x as REAL, byval y as REAL, byval width as REAL, byval height as REAL, byval startAngle as REAL, byval sweepAngle as REAL) as GpStatus
declare function GdipAddPathBezier (byval path as GpPath ptr, byval x1 as REAL, byval y1 as REAL, byval x2 as REAL, byval y2 as REAL, byval x3 as REAL, byval y3 as REAL, byval x4 as REAL, byval y4 as REAL) as GpStatus
declare function GdipAddPathBeziers (byval path as GpPath ptr, byval points as GpPointF ptr, byval count as INT_) as GpStatus
declare function GdipAddPathCurve (byval path as GpPath ptr, byval points as GpPointF ptr, byval count as INT_) as GpStatus
declare function GdipAddPathCurve2 (byval path as GpPath ptr, byval points as GpPointF ptr, byval count as INT_, byval tension as REAL) as GpStatus
declare function GdipAddPathCurve3 (byval path as GpPath ptr, byval points as GpPointF ptr, byval count as INT_, byval offset as INT_, byval numberOfSegments as INT_, byval tension as REAL) as GpStatus
declare function GdipAddPathClosedCurve (byval path as GpPath ptr, byval points as GpPointF ptr, byval count as INT_) as GpStatus
declare function GdipAddPathClosedCurve2 (byval path as GpPath ptr, byval points as GpPointF ptr, byval count as INT_, byval tension as REAL) as GpStatus
declare function GdipAddPathRectangle (byval path as GpPath ptr, byval x as REAL, byval y as REAL, byval width as REAL, byval height as REAL) as GpStatus
declare function GdipAddPathRectangles (byval path as GpPath ptr, byval rects as GpRectF ptr, byval count as INT_) as GpStatus
declare function GdipAddPathEllipse (byval path as GpPath ptr, byval x as REAL, byval y as REAL, byval width as REAL, byval height as REAL) as GpStatus
declare function GdipAddPathPie (byval path as GpPath ptr, byval x as REAL, byval y as REAL, byval width as REAL, byval height as REAL, byval startAngle as REAL, byval sweepAngle as REAL) as GpStatus
declare function GdipAddPathPolygon (byval path as GpPath ptr, byval points as GpPointF ptr, byval count as INT_) as GpStatus
declare function GdipAddPathPath (byval path as GpPath ptr, byval addingPath as GpPath ptr, byval connect as BOOL) as GpStatus
declare function GdipAddPathString (byval path as GpPath ptr, byval string as LPCWSTR, byval length as INT_, byval family as GpFontFamily ptr, byval style as INT_, byval emSize as REAL, byval layoutRect as RectF ptr, byval format as GpStringFormat ptr) as GpStatus
declare function GdipAddPathStringI (byval path as GpPath ptr, byval string as LPCWSTR, byval length as INT_, byval family as GpFontFamily ptr, byval style as INT_, byval emSize as REAL, byval layoutRect as Rect ptr, byval format as GpStringFormat ptr) as GpStatus
declare function GdipAddPathLineI (byval path as GpPath ptr, byval x1 as INT_, byval y1 as INT_, byval x2 as INT_, byval y2 as INT_) as GpStatus
declare function GdipAddPathLine2I (byval path as GpPath ptr, byval points as GpPoint ptr, byval count as INT_) as GpStatus
declare function GdipAddPathArcI (byval path as GpPath ptr, byval x as INT_, byval y as INT_, byval width as INT_, byval height as INT_, byval startAngle as REAL, byval sweepAngle as REAL) as GpStatus
declare function GdipAddPathBezierI (byval path as GpPath ptr, byval x1 as INT_, byval y1 as INT_, byval x2 as INT_, byval y2 as INT_, byval x3 as INT_, byval y3 as INT_, byval x4 as INT_, byval y4 as INT_) as GpStatus
declare function GdipAddPathBeziersI (byval path as GpPath ptr, byval points as GpPoint ptr, byval count as INT_) as GpStatus
declare function GdipAddPathCurveI (byval path as GpPath ptr, byval points as GpPoint ptr, byval count as INT_) as GpStatus
declare function GdipAddPathCurve2I (byval path as GpPath ptr, byval points as GpPoint ptr, byval count as INT_, byval tension as REAL) as GpStatus
declare function GdipAddPathCurve3I (byval path as GpPath ptr, byval points as GpPoint ptr, byval count as INT_, byval offset as INT_, byval numberOfSegments as INT_, byval tension as REAL) as GpStatus
declare function GdipAddPathClosedCurveI (byval path as GpPath ptr, byval points as GpPoint ptr, byval count as INT_) as GpStatus
declare function GdipAddPathClosedCurve2I (byval path as GpPath ptr, byval points as GpPoint ptr, byval count as INT_, byval tension as REAL) as GpStatus
declare function GdipAddPathRectangleI (byval path as GpPath ptr, byval x as INT_, byval y as INT_, byval width as INT_, byval height as INT_) as GpStatus
declare function GdipAddPathRectanglesI (byval path as GpPath ptr, byval rects as GpRect ptr, byval count as INT_) as GpStatus
declare function GdipAddPathEllipseI (byval path as GpPath ptr, byval x as INT_, byval y as INT_, byval width as INT_, byval height as INT_) as GpStatus
declare function GdipAddPathPieI (byval path as GpPath ptr, byval x as INT_, byval y as INT_, byval width as INT_, byval height as INT_, byval startAngle as REAL, byval sweepAngle as REAL) as GpStatus
declare function GdipAddPathPolygonI (byval path as GpPath ptr, byval points as GpPoint ptr, byval count as INT_) as GpStatus
declare function GdipFlattenPath (byval path as GpPath ptr, byval matrix as GpMatrix ptr, byval flatness as REAL) as GpStatus
declare function GdipWindingModeOutline (byval path as GpPath ptr, byval matrix as GpMatrix ptr, byval flatness as REAL) as GpStatus
declare function GdipWidenPath (byval nativePath as GpPath ptr, byval pen as GpPen ptr, byval matrix as GpMatrix ptr, byval flatness as REAL) as GpStatus
declare function GdipWarpPath (byval path as GpPath ptr, byval matrix as GpMatrix ptr, byval points as GpPointF ptr, byval count as INT_, byval srcx as REAL, byval srcy as REAL, byval srcwidth as REAL, byval srcheight as REAL, byval warpMode as WarpMode, byval flatness as REAL) as GpStatus
declare function GdipTransformPath (byval path as GpPath ptr, byval matrix as GpMatrix ptr) as GpStatus
declare function GdipGetPathWorldBounds (byval path as GpPath ptr, byval bounds as GpRectF ptr, byval matrix as GpMatrix ptr, byval pen as GpPen ptr) as GpStatus
declare function GdipGetPathWorldBoundsI (byval path as GpPath ptr, byval bounds as GpRect ptr, byval matrix as GpMatrix ptr, byval pen as GpPen ptr) as GpStatus
declare function GdipIsVisiblePathPoint (byval path as GpPath ptr, byval x as REAL, byval y as REAL, byval graphics as GpGraphics ptr, byval result as BOOL ptr) as GpStatus
declare function GdipIsVisiblePathPointI (byval path as GpPath ptr, byval x as INT_, byval y as INT_, byval graphics as GpGraphics ptr, byval result as BOOL ptr) as GpStatus
declare function GdipIsOutlineVisiblePathPoint (byval path as GpPath ptr, byval x as REAL, byval y as REAL, byval pen as GpPen ptr, byval graphics as GpGraphics ptr, byval result as BOOL ptr) as GpStatus
declare function GdipIsOutlineVisiblePathPointI (byval path as GpPath ptr, byval x as INT_, byval y as INT_, byval pen as GpPen ptr, byval graphics as GpGraphics ptr, byval result as BOOL ptr) as GpStatus
declare function GdipCreatePathIter (byval iterator as GpPathIterator ptr ptr, byval path as GpPath ptr) as GpStatus
declare function GdipDeletePathIter (byval iterator as GpPathIterator ptr) as GpStatus
declare function GdipPathIterNextSubpath (byval iterator as GpPathIterator ptr, byval resultCount as INT_ ptr, byval startIndex as INT_ ptr, byval endIndex as INT_ ptr, byval isClosed as BOOL ptr) as GpStatus
declare function GdipPathIterNextSubpathPath (byval iterator as GpPathIterator ptr, byval resultCount as INT_ ptr, byval path as GpPath ptr, byval isClosed as BOOL ptr) as GpStatus
declare function GdipPathIterNextPathType (byval iterator as GpPathIterator ptr, byval resultCount as INT_ ptr, byval pathType as UBYTE ptr, byval startIndex as INT_ ptr, byval endIndex as INT_ ptr) as GpStatus
declare function GdipPathIterNextMarker (byval iterator as GpPathIterator ptr, byval resultCount as INT_ ptr, byval startIndex as INT_ ptr, byval endIndex as INT_ ptr) as GpStatus
declare function GdipPathIterNextMarkerPath (byval iterator as GpPathIterator ptr, byval resultCount as INT_ ptr, byval path as GpPath ptr) as GpStatus
declare function GdipPathIterGetCount (byval iterator as GpPathIterator ptr, byval count as INT_ ptr) as GpStatus
declare function GdipPathIterGetSubpathCount (byval iterator as GpPathIterator ptr, byval count as INT_ ptr) as GpStatus
declare function GdipPathIterIsValid (byval iterator as GpPathIterator ptr, byval valid as BOOL ptr) as GpStatus
declare function GdipPathIterHasCurve (byval iterator as GpPathIterator ptr, byval hasCurve as BOOL ptr) as GpStatus
declare function GdipPathIterRewind (byval iterator as GpPathIterator ptr) as GpStatus
declare function GdipPathIterEnumerate (byval iterator as GpPathIterator ptr, byval resultCount as INT_ ptr, byval points as GpPointF ptr, byval types as UBYTE ptr, byval count as INT_) as GpStatus
declare function GdipPathIterCopyData (byval iterator as GpPathIterator ptr, byval resultCount as INT_ ptr, byval points as GpPointF ptr, byval types as UBYTE ptr, byval startIndex as INT_, byval endIndex as INT_) as GpStatus
declare function GdipCreateMatrix (byval matrix as GpMatrix ptr ptr) as GpStatus
declare function GdipCreateMatrix2 (byval m11 as REAL, byval m12 as REAL, byval m21 as REAL, byval m22 as REAL, byval dx as REAL, byval dy as REAL, byval matrix as GpMatrix ptr ptr) as GpStatus
declare function GdipCreateMatrix3 (byval rect as GpRectF ptr, byval dstplg as GpPointF ptr, byval matrix as GpMatrix ptr ptr) as GpStatus
declare function GdipCreateMatrix3I (byval rect as GpRect ptr, byval dstplg as GpPoint ptr, byval matrix as GpMatrix ptr ptr) as GpStatus
declare function GdipCloneMatrix (byval matrix as GpMatrix ptr, byval cloneMatrix as GpMatrix ptr ptr) as GpStatus
declare function GdipDeleteMatrix (byval matrix as GpMatrix ptr) as GpStatus
declare function GdipSetMatrixElements (byval matrix as GpMatrix ptr, byval m11 as REAL, byval m12 as REAL, byval m21 as REAL, byval m22 as REAL, byval dx as REAL, byval dy as REAL) as GpStatus
declare function GdipMultiplyMatrix (byval matrix as GpMatrix ptr, byval matrix2 as GpMatrix ptr, byval order as GpMatrixOrder) as GpStatus
declare function GdipTranslateMatrix (byval matrix as GpMatrix ptr, byval offsetX as REAL, byval offsetY as REAL, byval order as GpMatrixOrder) as GpStatus
declare function GdipScaleMatrix (byval matrix as GpMatrix ptr, byval scaleX as REAL, byval scaleY as REAL, byval order as GpMatrixOrder) as GpStatus
declare function GdipRotateMatrix (byval matrix as GpMatrix ptr, byval angle as REAL, byval order as GpMatrixOrder) as GpStatus
declare function GdipShearMatrix (byval matrix as GpMatrix ptr, byval shearX as REAL, byval shearY as REAL, byval order as GpMatrixOrder) as GpStatus
declare function GdipInvertMatrix (byval matrix as GpMatrix ptr) as GpStatus
declare function GdipTransformMatrixPoints (byval matrix as GpMatrix ptr, byval pts as GpPointF ptr, byval count as INT_) as GpStatus
declare function GdipTransformMatrixPointsI (byval matrix as GpMatrix ptr, byval pts as GpPoint ptr, byval count as INT_) as GpStatus
declare function GdipVectorTransformMatrixPoints (byval matrix as GpMatrix ptr, byval pts as GpPointF ptr, byval count as INT_) as GpStatus
declare function GdipVectorTransformMatrixPointsI (byval matrix as GpMatrix ptr, byval pts as GpPoint ptr, byval count as INT_) as GpStatus
declare function GdipGetMatrixElements (byval matrix as GpMatrix ptr, byval matrixOut as REAL ptr) as GpStatus
declare function GdipIsMatrixInvertible (byval matrix as GpMatrix ptr, byval result as BOOL ptr) as GpStatus
declare function GdipIsMatrixIdentity (byval matrix as GpMatrix ptr, byval result as BOOL ptr) as GpStatus
declare function GdipIsMatrixEqual (byval matrix as GpMatrix ptr, byval matrix2 as GpMatrix ptr, byval result as BOOL ptr) as GpStatus
declare function GdipCreateRegion (byval region as GpRegion ptr ptr) as GpStatus
declare function GdipCreateRegionRect (byval rect as GpRectF ptr, byval region as GpRegion ptr ptr) as GpStatus
declare function GdipCreateRegionRectI (byval rect as GpRect ptr, byval region as GpRegion ptr ptr) as GpStatus
declare function GdipCreateRegionPath (byval path as GpPath ptr, byval region as GpRegion ptr ptr) as GpStatus
declare function GdipCreateRegionRgnData (byval regionData as UBYTE ptr, byval size as INT_, byval region as GpRegion ptr ptr) as GpStatus
declare function GdipCreateRegionHrgn (byval hRgn as HRGN, byval region as GpRegion ptr ptr) as GpStatus
declare function GdipCloneRegion (byval region as GpRegion ptr, byval cloneRegion as GpRegion ptr ptr) as GpStatus
declare function GdipDeleteRegion (byval region as GpRegion ptr) as GpStatus
declare function GdipSetInfinite (byval region as GpRegion ptr) as GpStatus
declare function GdipSetEmpty (byval region as GpRegion ptr) as GpStatus
declare function GdipCombineRegionRect (byval region as GpRegion ptr, byval rect as GpRectF ptr, byval combineMode as CombineMode) as GpStatus
declare function GdipCombineRegionRectI (byval region as GpRegion ptr, byval rect as GpRect ptr, byval combineMode as CombineMode) as GpStatus
declare function GdipCombineRegionPath (byval region as GpRegion ptr, byval path as GpPath ptr, byval combineMode as CombineMode) as GpStatus
declare function GdipCombineRegionRegion (byval region as GpRegion ptr, byval region2 as GpRegion ptr, byval combineMode as CombineMode) as GpStatus
declare function GdipTranslateRegion (byval region as GpRegion ptr, byval dx as REAL, byval dy as REAL) as GpStatus
declare function GdipTranslateRegionI (byval region as GpRegion ptr, byval dx as INT_, byval dy as INT_) as GpStatus
declare function GdipTransformRegion (byval region as GpRegion ptr, byval matrix as GpMatrix ptr) as GpStatus
declare function GdipGetRegionBounds (byval region as GpRegion ptr, byval graphics as GpGraphics ptr, byval rect as GpRectF ptr) as GpStatus
declare function GdipGetRegionBoundsI (byval region as GpRegion ptr, byval graphics as GpGraphics ptr, byval rect as GpRect ptr) as GpStatus
declare function GdipGetRegionHRgn (byval region as GpRegion ptr, byval graphics as GpGraphics ptr, byval hRgn as HRGN ptr) as GpStatus
declare function GdipIsEmptyRegion (byval region as GpRegion ptr, byval graphics as GpGraphics ptr, byval result as BOOL ptr) as GpStatus
declare function GdipIsInfiniteRegion (byval region as GpRegion ptr, byval graphics as GpGraphics ptr, byval result as BOOL ptr) as GpStatus
declare function GdipIsEqualRegion (byval region as GpRegion ptr, byval region2 as GpRegion ptr, byval graphics as GpGraphics ptr, byval result as BOOL ptr) as GpStatus
declare function GdipGetRegionDataSize (byval region as GpRegion ptr, byval bufferSize as UINT ptr) as GpStatus
declare function GdipGetRegionData (byval region as GpRegion ptr, byval buffer as UBYTE ptr, byval bufferSize as UINT, byval sizeFilled as UINT ptr) as GpStatus
declare function GdipIsVisibleRegionPoint (byval region as GpRegion ptr, byval x as REAL, byval y as REAL, byval graphics as GpGraphics ptr, byval result as BOOL ptr) as GpStatus
declare function GdipIsVisibleRegionPointI (byval region as GpRegion ptr, byval x as INT_, byval y as INT_, byval graphics as GpGraphics ptr, byval result as BOOL ptr) as GpStatus
declare function GdipIsVisibleRegionRect (byval region as GpRegion ptr, byval x as REAL, byval y as REAL, byval width as REAL, byval height as REAL, byval graphics as GpGraphics ptr, byval result as BOOL ptr) as GpStatus
declare function GdipIsVisibleRegionRectI (byval region as GpRegion ptr, byval x as INT_, byval y as INT_, byval width as INT_, byval height as INT_, byval graphics as GpGraphics ptr, byval result as BOOL ptr) as GpStatus
declare function GdipGetRegionScansCount (byval region as GpRegion ptr, byval count as UINT ptr, byval matrix as GpMatrix ptr) as GpStatus
declare function GdipGetRegionScans (byval region as GpRegion ptr, byval rects as GpRectF ptr, byval count as INT_ ptr, byval matrix as GpMatrix ptr) as GpStatus
declare function GdipGetRegionScansI (byval region as GpRegion ptr, byval rects as GpRect ptr, byval count as INT_ ptr, byval matrix as GpMatrix ptr) as GpStatus
declare function GdipCloneBrush (byval brush as GpBrush ptr, byval cloneBrush as GpBrush ptr ptr) as GpStatus
declare function GdipDeleteBrush (byval brush as GpBrush ptr) as GpStatus
declare function GdipGetBrushType (byval brush as GpBrush ptr, byval type as GpBrushType ptr) as GpStatus
declare function GdipCreateHatchBrush (byval hatchstyle as GpHatchStyle, byval forecol as ARGB, byval backcol as ARGB, byval brush as GpHatch ptr ptr) as GpStatus
declare function GdipGetHatchStyle (byval brush as GpHatch ptr, byval hatchstyle as GpHatchStyle ptr) as GpStatus
declare function GdipGetHatchForegroundColor (byval brush as GpHatch ptr, byval forecol as ARGB ptr) as GpStatus
declare function GdipGetHatchBackgroundColor (byval brush as GpHatch ptr, byval backcol as ARGB ptr) as GpStatus
declare function GdipCreateTexture (byval image as GpImage ptr, byval wrapmode as GpWrapMode, byval texture as GpTexture ptr ptr) as GpStatus
declare function GdipCreateTexture2 (byval image as GpImage ptr, byval wrapmode as GpWrapMode, byval x as REAL, byval y as REAL, byval width as REAL, byval height as REAL, byval texture as GpTexture ptr ptr) as GpStatus
declare function GdipCreateTextureIA (byval image as GpImage ptr, byval imageAttributes as GpImageAttributes ptr, byval x as REAL, byval y as REAL, byval width as REAL, byval height as REAL, byval texture as GpTexture ptr ptr) as GpStatus
declare function GdipCreateTexture2I (byval image as GpImage ptr, byval wrapmode as GpWrapMode, byval x as INT_, byval y as INT_, byval width as INT_, byval height as INT_, byval texture as GpTexture ptr ptr) as GpStatus
declare function GdipCreateTextureIAI (byval image as GpImage ptr, byval imageAttributes as GpImageAttributes ptr, byval x as INT_, byval y as INT_, byval width as INT_, byval height as INT_, byval texture as GpTexture ptr ptr) as GpStatus
declare function GdipGetTextureTransform (byval brush as GpTexture ptr, byval matrix as GpMatrix ptr) as GpStatus
declare function GdipSetTextureTransform (byval brush as GpTexture ptr, byval matrix as GpMatrix ptr) as GpStatus
declare function GdipResetTextureTransform (byval brush as GpTexture ptr) as GpStatus
declare function GdipMultiplyTextureTransform (byval brush as GpTexture ptr, byval matrix as GpMatrix ptr, byval order as GpMatrixOrder) as GpStatus
declare function GdipTranslateTextureTransform (byval brush as GpTexture ptr, byval dx as REAL, byval dy as REAL, byval order as GpMatrixOrder) as GpStatus
declare function GdipScaleTextureTransform (byval brush as GpTexture ptr, byval sx as REAL, byval sy as REAL, byval order as GpMatrixOrder) as GpStatus
declare function GdipRotateTextureTransform (byval brush as GpTexture ptr, byval angle as REAL, byval order as GpMatrixOrder) as GpStatus
declare function GdipSetTextureWrapMode (byval brush as GpTexture ptr, byval wrapmode as GpWrapMode) as GpStatus
declare function GdipGetTextureWrapMode (byval brush as GpTexture ptr, byval wrapmode as GpWrapMode ptr) as GpStatus
declare function GdipGetTextureImage (byval brush as GpTexture ptr, byval image as GpImage ptr ptr) as GpStatus
declare function GdipCreateSolidFill (byval color as ARGB, byval brush as GpSolidFill ptr ptr) as GpStatus
declare function GdipSetSolidFillColor (byval brush as GpSolidFill ptr, byval color as ARGB) as GpStatus
declare function GdipGetSolidFillColor (byval brush as GpSolidFill ptr, byval color as ARGB ptr) as GpStatus
declare function GdipCreateLineBrush (byval point1 as GpPointF ptr, byval point2 as GpPointF ptr, byval color1 as ARGB, byval color2 as ARGB, byval wrapMode as GpWrapMode, byval lineGradient as GpLineGradient ptr ptr) as GpStatus
declare function GdipCreateLineBrushI (byval point1 as GpPoint ptr, byval point2 as GpPoint ptr, byval color1 as ARGB, byval color2 as ARGB, byval wrapMode as GpWrapMode, byval lineGradient as GpLineGradient ptr ptr) as GpStatus
declare function GdipCreateLineBrushFromRect (byval rect as GpRectF ptr, byval color1 as ARGB, byval color2 as ARGB, byval mode as LinearGradientMode, byval wrapMode as GpWrapMode, byval lineGradient as GpLineGradient ptr ptr) as GpStatus
declare function GdipCreateLineBrushFromRectI (byval rect as GpRect ptr, byval color1 as ARGB, byval color2 as ARGB, byval mode as LinearGradientMode, byval wrapMode as GpWrapMode, byval lineGradient as GpLineGradient ptr ptr) as GpStatus
declare function GdipCreateLineBrushFromRectWithAngle (byval rect as GpRectF ptr, byval color1 as ARGB, byval color2 as ARGB, byval angle as REAL, byval isAngleScalable as BOOL, byval wrapMode as GpWrapMode, byval lineGradient as GpLineGradient ptr ptr) as GpStatus
declare function GdipCreateLineBrushFromRectWithAngleI (byval rect as GpRect ptr, byval color1 as ARGB, byval color2 as ARGB, byval angle as REAL, byval isAngleScalable as BOOL, byval wrapMode as GpWrapMode, byval lineGradient as GpLineGradient ptr ptr) as GpStatus
declare function GdipSetLineColors (byval brush as GpLineGradient ptr, byval color1 as ARGB, byval color2 as ARGB) as GpStatus
declare function GdipGetLineColors (byval brush as GpLineGradient ptr, byval colors as ARGB ptr) as GpStatus
declare function GdipGetLineRect (byval brush as GpLineGradient ptr, byval rect as GpRectF ptr) as GpStatus
declare function GdipGetLineRectI (byval brush as GpLineGradient ptr, byval rect as GpRect ptr) as GpStatus
declare function GdipSetLineGammaCorrection (byval brush as GpLineGradient ptr, byval useGammaCorrection as BOOL) as GpStatus
declare function GdipGetLineGammaCorrection (byval brush as GpLineGradient ptr, byval useGammaCorrection as BOOL ptr) as GpStatus
declare function GdipGetLineBlendCount (byval brush as GpLineGradient ptr, byval count as INT_ ptr) as GpStatus
declare function GdipGetLineBlend (byval brush as GpLineGradient ptr, byval blend as REAL ptr, byval positions as REAL ptr, byval count as INT_) as GpStatus
declare function GdipSetLineBlend (byval brush as GpLineGradient ptr, byval blend as REAL ptr, byval positions as REAL ptr, byval count as INT_) as GpStatus
declare function GdipGetLinePresetBlendCount (byval brush as GpLineGradient ptr, byval count as INT_ ptr) as GpStatus
declare function GdipGetLinePresetBlend (byval brush as GpLineGradient ptr, byval blend as ARGB ptr, byval positions as REAL ptr, byval count as INT_) as GpStatus
declare function GdipSetLinePresetBlend (byval brush as GpLineGradient ptr, byval blend as ARGB ptr, byval positions as REAL ptr, byval count as INT_) as GpStatus
declare function GdipSetLineSigmaBlend (byval brush as GpLineGradient ptr, byval focus as REAL, byval scale as REAL) as GpStatus
declare function GdipSetLineLinearBlend (byval brush as GpLineGradient ptr, byval focus as REAL, byval scale as REAL) as GpStatus
declare function GdipSetLineWrapMode (byval brush as GpLineGradient ptr, byval wrapmode as GpWrapMode) as GpStatus
declare function GdipGetLineWrapMode (byval brush as GpLineGradient ptr, byval wrapmode as GpWrapMode ptr) as GpStatus
declare function GdipGetLineTransform (byval brush as GpLineGradient ptr, byval matrix as GpMatrix ptr) as GpStatus
declare function GdipSetLineTransform (byval brush as GpLineGradient ptr, byval matrix as GpMatrix ptr) as GpStatus
declare function GdipResetLineTransform (byval brush as GpLineGradient ptr) as GpStatus
declare function GdipMultiplyLineTransform (byval brush as GpLineGradient ptr, byval matrix as GpMatrix ptr, byval order as GpMatrixOrder) as GpStatus
declare function GdipTranslateLineTransform (byval brush as GpLineGradient ptr, byval dx as REAL, byval dy as REAL, byval order as GpMatrixOrder) as GpStatus
declare function GdipScaleLineTransform (byval brush as GpLineGradient ptr, byval sx as REAL, byval sy as REAL, byval order as GpMatrixOrder) as GpStatus
declare function GdipRotateLineTransform (byval brush as GpLineGradient ptr, byval angle as REAL, byval order as GpMatrixOrder) as GpStatus
declare function GdipCreatePathGradient (byval points as GpPointF ptr, byval count as INT_, byval wrapMode as GpWrapMode, byval polyGradient as GpPathGradient ptr ptr) as GpStatus
declare function GdipCreatePathGradientI (byval points as GpPoint ptr, byval count as INT_, byval wrapMode as GpWrapMode, byval polyGradient as GpPathGradient ptr ptr) as GpStatus
declare function GdipCreatePathGradientFromPath (byval path as GpPath ptr, byval polyGradient as GpPathGradient ptr ptr) as GpStatus
declare function GdipGetPathGradientCenterColor (byval brush as GpPathGradient ptr, byval colors as ARGB ptr) as GpStatus
declare function GdipSetPathGradientCenterColor (byval brush as GpPathGradient ptr, byval colors as ARGB) as GpStatus
declare function GdipGetPathGradientSurroundColorsWithCount (byval brush as GpPathGradient ptr, byval color as ARGB ptr, byval count as INT_ ptr) as GpStatus
declare function GdipSetPathGradientSurroundColorsWithCount (byval brush as GpPathGradient ptr, byval color as ARGB ptr, byval count as INT_ ptr) as GpStatus
declare function GdipGetPathGradientPath (byval brush as GpPathGradient ptr, byval path as GpPath ptr) as GpStatus
declare function GdipSetPathGradientPath (byval brush as GpPathGradient ptr, byval path as GpPath ptr) as GpStatus
declare function GdipGetPathGradientCenterPoint (byval brush as GpPathGradient ptr, byval points as GpPointF ptr) as GpStatus
declare function GdipGetPathGradientCenterPointI (byval brush as GpPathGradient ptr, byval points as GpPoint ptr) as GpStatus
declare function GdipSetPathGradientCenterPoint (byval brush as GpPathGradient ptr, byval points as GpPointF ptr) as GpStatus
declare function GdipSetPathGradientCenterPointI (byval brush as GpPathGradient ptr, byval points as GpPoint ptr) as GpStatus
declare function GdipGetPathGradientRect (byval brush as GpPathGradient ptr, byval rect as GpRectF ptr) as GpStatus
declare function GdipGetPathGradientRectI (byval brush as GpPathGradient ptr, byval rect as GpRect ptr) as GpStatus
declare function GdipGetPathGradientPointCount (byval brush as GpPathGradient ptr, byval count as INT_ ptr) as GpStatus
declare function GdipGetPathGradientSurroundColorCount (byval brush as GpPathGradient ptr, byval count as INT_ ptr) as GpStatus
declare function GdipSetPathGradientGammaCorrection (byval brush as GpPathGradient ptr, byval useGammaCorrection as BOOL) as GpStatus
declare function GdipGetPathGradientGammaCorrection (byval brush as GpPathGradient ptr, byval useGammaCorrection as BOOL ptr) as GpStatus
declare function GdipGetPathGradientBlendCount (byval brush as GpPathGradient ptr, byval count as INT_ ptr) as GpStatus
declare function GdipGetPathGradientBlend (byval brush as GpPathGradient ptr, byval blend as REAL ptr, byval positions as REAL ptr, byval count as INT_) as GpStatus
declare function GdipSetPathGradientBlend (byval brush as GpPathGradient ptr, byval blend as REAL ptr, byval positions as REAL ptr, byval count as INT_) as GpStatus
declare function GdipGetPathGradientPresetBlendCount (byval brush as GpPathGradient ptr, byval count as INT_ ptr) as GpStatus
declare function GdipGetPathGradientPresetBlend (byval brush as GpPathGradient ptr, byval blend as ARGB ptr, byval positions as REAL ptr, byval count as INT_) as GpStatus
declare function GdipSetPathGradientPresetBlend (byval brush as GpPathGradient ptr, byval blend as ARGB ptr, byval positions as REAL ptr, byval count as INT_) as GpStatus
declare function GdipSetPathGradientSigmaBlend (byval brush as GpPathGradient ptr, byval focus as REAL, byval scale as REAL) as GpStatus
declare function GdipSetPathGradientLinearBlend (byval brush as GpPathGradient ptr, byval focus as REAL, byval scale as REAL) as GpStatus
declare function GdipGetPathGradientWrapMode (byval brush as GpPathGradient ptr, byval wrapmode as GpWrapMode ptr) as GpStatus
declare function GdipSetPathGradientWrapMode (byval brush as GpPathGradient ptr, byval wrapmode as GpWrapMode) as GpStatus
declare function GdipGetPathGradientTransform (byval brush as GpPathGradient ptr, byval matrix as GpMatrix ptr) as GpStatus
declare function GdipSetPathGradientTransform (byval brush as GpPathGradient ptr, byval matrix as GpMatrix ptr) as GpStatus
declare function GdipResetPathGradientTransform (byval brush as GpPathGradient ptr) as GpStatus
declare function GdipMultiplyPathGradientTransform (byval brush as GpPathGradient ptr, byval matrix as GpMatrix ptr, byval order as GpMatrixOrder) as GpStatus
declare function GdipTranslatePathGradientTransform (byval brush as GpPathGradient ptr, byval dx as REAL, byval dy as REAL, byval order as GpMatrixOrder) as GpStatus
declare function GdipScalePathGradientTransform (byval brush as GpPathGradient ptr, byval sx as REAL, byval sy as REAL, byval order as GpMatrixOrder) as GpStatus
declare function GdipRotatePathGradientTransform (byval brush as GpPathGradient ptr, byval angle as REAL, byval order as GpMatrixOrder) as GpStatus
declare function GdipGetPathGradientFocusScales (byval brush as GpPathGradient ptr, byval xScale as REAL ptr, byval yScale as REAL ptr) as GpStatus
declare function GdipSetPathGradientFocusScales (byval brush as GpPathGradient ptr, byval xScale as REAL, byval yScale as REAL) as GpStatus
declare function GdipCreatePen1 (byval color as ARGB, byval width as REAL, byval unit as GpUnit, byval pen as GpPen ptr ptr) as GpStatus
declare function GdipCreatePen2 (byval brush as GpBrush ptr, byval width as REAL, byval unit as GpUnit, byval pen as GpPen ptr ptr) as GpStatus
declare function GdipClonePen (byval pen as GpPen ptr, byval clonepen as GpPen ptr ptr) as GpStatus
declare function GdipDeletePen (byval pen as GpPen ptr) as GpStatus
declare function GdipSetPenWidth (byval pen as GpPen ptr, byval width as REAL) as GpStatus
declare function GdipGetPenWidth (byval pen as GpPen ptr, byval width as REAL ptr) as GpStatus
declare function GdipSetPenUnit (byval pen as GpPen ptr, byval unit as GpUnit) as GpStatus
declare function GdipGetPenUnit (byval pen as GpPen ptr, byval unit as GpUnit ptr) as GpStatus
declare function GdipSetPenLineCap197819 (byval pen as GpPen ptr, byval startCap as GpLineCap, byval endCap as GpLineCap, byval dashCap as GpDashCap) as GpStatus
declare function GdipSetPenStartCap (byval pen as GpPen ptr, byval startCap as GpLineCap) as GpStatus
declare function GdipSetPenEndCap (byval pen as GpPen ptr, byval endCap as GpLineCap) as GpStatus
declare function GdipSetPenDashCap197819 (byval pen as GpPen ptr, byval dashCap as GpDashCap) as GpStatus
declare function GdipGetPenStartCap (byval pen as GpPen ptr, byval startCap as GpLineCap ptr) as GpStatus
declare function GdipGetPenEndCap (byval pen as GpPen ptr, byval endCap as GpLineCap ptr) as GpStatus
declare function GdipGetPenDashCap197819 (byval pen as GpPen ptr, byval dashCap as GpDashCap ptr) as GpStatus
declare function GdipSetPenLineJoin (byval pen as GpPen ptr, byval lineJoin as GpLineJoin) as GpStatus
declare function GdipGetPenLineJoin (byval pen as GpPen ptr, byval lineJoin as GpLineJoin ptr) as GpStatus
declare function GdipSetPenCustomStartCap (byval pen as GpPen ptr, byval customCap as GpCustomLineCap ptr) as GpStatus
declare function GdipGetPenCustomStartCap (byval pen as GpPen ptr, byval customCap as GpCustomLineCap ptr ptr) as GpStatus
declare function GdipSetPenCustomEndCap (byval pen as GpPen ptr, byval customCap as GpCustomLineCap ptr) as GpStatus
declare function GdipGetPenCustomEndCap (byval pen as GpPen ptr, byval customCap as GpCustomLineCap ptr ptr) as GpStatus
declare function GdipSetPenMiterLimit (byval pen as GpPen ptr, byval miterLimit as REAL) as GpStatus
declare function GdipGetPenMiterLimit (byval pen as GpPen ptr, byval miterLimit as REAL ptr) as GpStatus
declare function GdipSetPenMode (byval pen as GpPen ptr, byval penMode as GpPenAlignment) as GpStatus
declare function GdipGetPenMode (byval pen as GpPen ptr, byval penMode as GpPenAlignment ptr) as GpStatus
declare function GdipSetPenTransform (byval pen as GpPen ptr, byval matrix as GpMatrix ptr) as GpStatus
declare function GdipGetPenTransform (byval pen as GpPen ptr, byval matrix as GpMatrix ptr) as GpStatus
declare function GdipResetPenTransform (byval pen as GpPen ptr) as GpStatus
declare function GdipMultiplyPenTransform (byval pen as GpPen ptr, byval matrix as GpMatrix ptr, byval order as GpMatrixOrder) as GpStatus
declare function GdipTranslatePenTransform (byval pen as GpPen ptr, byval dx as REAL, byval dy as REAL, byval order as GpMatrixOrder) as GpStatus
declare function GdipScalePenTransform (byval pen as GpPen ptr, byval sx as REAL, byval sy as REAL, byval order as GpMatrixOrder) as GpStatus
declare function GdipRotatePenTransform (byval pen as GpPen ptr, byval angle as REAL, byval order as GpMatrixOrder) as GpStatus
declare function GdipSetPenColor (byval pen as GpPen ptr, byval argb as ARGB) as GpStatus
declare function GdipGetPenColor (byval pen as GpPen ptr, byval argb as ARGB ptr) as GpStatus
declare function GdipSetPenBrushFill (byval pen as GpPen ptr, byval brush as GpBrush ptr) as GpStatus
declare function GdipGetPenBrushFill (byval pen as GpPen ptr, byval brush as GpBrush ptr ptr) as GpStatus
declare function GdipGetPenFillType (byval pen as GpPen ptr, byval type as GpPenType ptr) as GpStatus
declare function GdipGetPenDashStyle (byval pen as GpPen ptr, byval dashstyle as GpDashStyle ptr) as GpStatus
declare function GdipSetPenDashStyle (byval pen as GpPen ptr, byval dashstyle as GpDashStyle) as GpStatus
declare function GdipGetPenDashOffset (byval pen as GpPen ptr, byval offset as REAL ptr) as GpStatus
declare function GdipSetPenDashOffset (byval pen as GpPen ptr, byval offset as REAL) as GpStatus
declare function GdipGetPenDashCount (byval pen as GpPen ptr, byval count as INT_ ptr) as GpStatus
declare function GdipSetPenDashArray (byval pen as GpPen ptr, byval dash as REAL ptr, byval count as INT_) as GpStatus
declare function GdipGetPenDashArray (byval pen as GpPen ptr, byval dash as REAL ptr, byval count as INT_) as GpStatus
declare function GdipGetPenCompoundCount (byval pen as GpPen ptr, byval count as INT_ ptr) as GpStatus
declare function GdipSetPenCompoundArray (byval pen as GpPen ptr, byval dash as REAL ptr, byval count as INT_) as GpStatus
declare function GdipGetPenCompoundArray (byval pen as GpPen ptr, byval dash as REAL ptr, byval count as INT_) as GpStatus
declare function GdipCreateCustomLineCap (byval fillPath as GpPath ptr, byval strokePath as GpPath ptr, byval baseCap as GpLineCap, byval baseInset as REAL, byval customCap as GpCustomLineCap ptr ptr) as GpStatus
declare function GdipDeleteCustomLineCap (byval customCap as GpCustomLineCap ptr) as GpStatus
declare function GdipCloneCustomLineCap (byval customCap as GpCustomLineCap ptr, byval clonedCap as GpCustomLineCap ptr ptr) as GpStatus
declare function GdipGetCustomLineCapType (byval customCap as GpCustomLineCap ptr, byval capType as CustomLineCapType ptr) as GpStatus
declare function GdipSetCustomLineCapStrokeCaps (byval customCap as GpCustomLineCap ptr, byval startCap as GpLineCap, byval endCap as GpLineCap) as GpStatus
declare function GdipGetCustomLineCapStrokeCaps (byval customCap as GpCustomLineCap ptr, byval startCap as GpLineCap ptr, byval endCap as GpLineCap ptr) as GpStatus
declare function GdipSetCustomLineCapStrokeJoin (byval customCap as GpCustomLineCap ptr, byval lineJoin as GpLineJoin) as GpStatus
declare function GdipGetCustomLineCapStrokeJoin (byval customCap as GpCustomLineCap ptr, byval lineJoin as GpLineJoin ptr) as GpStatus
declare function GdipSetCustomLineCapBaseCap (byval customCap as GpCustomLineCap ptr, byval baseCap as GpLineCap) as GpStatus
declare function GdipGetCustomLineCapBaseCap (byval customCap as GpCustomLineCap ptr, byval baseCap as GpLineCap ptr) as GpStatus
declare function GdipSetCustomLineCapBaseInset (byval customCap as GpCustomLineCap ptr, byval inset as REAL) as GpStatus
declare function GdipGetCustomLineCapBaseInset (byval customCap as GpCustomLineCap ptr, byval inset as REAL ptr) as GpStatus
declare function GdipSetCustomLineCapWidthScale (byval customCap as GpCustomLineCap ptr, byval widthScale as REAL) as GpStatus
declare function GdipGetCustomLineCapWidthScale (byval customCap as GpCustomLineCap ptr, byval widthScale as REAL ptr) as GpStatus
declare function GdipCreateAdjustableArrowCap (byval height as REAL, byval width as REAL, byval isFilled as BOOL, byval cap as GpAdjustableArrowCap ptr ptr) as GpStatus
declare function GdipSetAdjustableArrowCapHeight (byval cap as GpAdjustableArrowCap ptr, byval height as REAL) as GpStatus
declare function GdipGetAdjustableArrowCapHeight (byval cap as GpAdjustableArrowCap ptr, byval height as REAL ptr) as GpStatus
declare function GdipSetAdjustableArrowCapWidth (byval cap as GpAdjustableArrowCap ptr, byval width as REAL) as GpStatus
declare function GdipGetAdjustableArrowCapWidth (byval cap as GpAdjustableArrowCap ptr, byval width as REAL ptr) as GpStatus
declare function GdipSetAdjustableArrowCapMiddleInset (byval cap as GpAdjustableArrowCap ptr, byval middleInset as REAL) as GpStatus
declare function GdipGetAdjustableArrowCapMiddleInset (byval cap as GpAdjustableArrowCap ptr, byval middleInset as REAL ptr) as GpStatus
declare function GdipSetAdjustableArrowCapFillState (byval cap as GpAdjustableArrowCap ptr, byval fillState as BOOL) as GpStatus
declare function GdipGetAdjustableArrowCapFillState (byval cap as GpAdjustableArrowCap ptr, byval fillState as BOOL ptr) as GpStatus
declare function GdipLoadImageFromStream (byval stream as IStream ptr, byval image as GpImage ptr ptr) as GpStatus
declare function GdipLoadImageFromFile (byval filename as LPCWSTR, byval image as GpImage ptr ptr) as GpStatus
declare function GdipLoadImageFromStreamICM (byval stream as IStream ptr, byval image as GpImage ptr ptr) as GpStatus
declare function GdipLoadImageFromFileICM (byval filename as LPCWSTR, byval image as GpImage ptr ptr) as GpStatus
declare function GdipCloneImage (byval image as GpImage ptr, byval cloneImage as GpImage ptr ptr) as GpStatus
declare function GdipDisposeImage (byval image as GpImage ptr) as GpStatus
declare function GdipSaveImageToFile (byval image as GpImage ptr, byval filename as LPCWSTR, byval clsidEncoder as CLSID ptr, byval encoderParams as EncoderParameters ptr) as GpStatus
declare function GdipSaveImageToStream (byval image as GpImage ptr, byval stream as IStream ptr, byval clsidEncoder as CLSID ptr, byval encoderParams as EncoderParameters ptr) as GpStatus
declare function GdipSaveAdd (byval image as GpImage ptr, byval encoderParams as EncoderParameters ptr) as GpStatus
declare function GdipSaveAddImage (byval image as GpImage ptr, byval newImage as GpImage ptr, byval encoderParams as EncoderParameters ptr) as GpStatus
declare function GdipGetImageGraphicsContext (byval image as GpImage ptr, byval graphics as GpGraphics ptr ptr) as GpStatus
declare function GdipGetImageBounds (byval image as GpImage ptr, byval srcRect as GpRectF ptr, byval srcUnit as GpUnit ptr) as GpStatus
declare function GdipGetImageDimension (byval image as GpImage ptr, byval width as REAL ptr, byval height as REAL ptr) as GpStatus
declare function GdipGetImageType (byval image as GpImage ptr, byval type as ImageType ptr) as GpStatus
declare function GdipGetImageWidth (byval image as GpImage ptr, byval width as UINT ptr) as GpStatus
declare function GdipGetImageHeight (byval image as GpImage ptr, byval height as UINT ptr) as GpStatus
declare function GdipGetImageHorizontalResolution (byval image as GpImage ptr, byval resolution as REAL ptr) as GpStatus
declare function GdipGetImageVerticalResolution (byval image as GpImage ptr, byval resolution as REAL ptr) as GpStatus
declare function GdipGetImageFlags (byval image as GpImage ptr, byval flags as UINT ptr) as GpStatus
declare function GdipGetImageRawFormat (byval image as GpImage ptr, byval format as GUID ptr) as GpStatus
declare function GdipGetImagePixelFormat (byval image as GpImage ptr, byval format as PixelFormat ptr) as GpStatus
declare function GdipGetImageThumbnail (byval image as GpImage ptr, byval thumbWidth as UINT, byval thumbHeight as UINT, byval thumbImage as GpImage ptr ptr, byval callback as GetThumbnailImageAbort, byval callbackData as any ptr) as GpStatus
declare function GdipGetEncoderParameterListSize (byval image as GpImage ptr, byval clsidEncoder as CLSID ptr, byval size as UINT ptr) as GpStatus
declare function GdipGetEncoderParameterList (byval image as GpImage ptr, byval clsidEncoder as CLSID ptr, byval size as UINT, byval buffer as EncoderParameters ptr) as GpStatus
declare function GdipImageGetFrameDimensionsCount (byval image as GpImage ptr, byval count as UINT ptr) as GpStatus
declare function GdipImageGetFrameDimensionsList (byval image as GpImage ptr, byval dimensionIDs as GUID ptr, byval count as UINT) as GpStatus
declare function GdipImageGetFrameCount (byval image as GpImage ptr, byval dimensionID as GUID ptr, byval count as UINT ptr) as GpStatus
declare function GdipImageSelectActiveFrame (byval image as GpImage ptr, byval dimensionID as GUID ptr, byval frameIndex as UINT) as GpStatus
declare function GdipImageRotateFlip (byval image as GpImage ptr, byval rfType as RotateFlipType) as GpStatus
declare function GdipGetImagePalette (byval image as GpImage ptr, byval palette as ColorPalette ptr, byval size as INT_) as GpStatus
declare function GdipSetImagePalette (byval image as GpImage ptr, byval palette as ColorPalette ptr) as GpStatus
declare function GdipGetImagePaletteSize (byval image as GpImage ptr, byval size as INT_ ptr) as GpStatus
declare function GdipGetPropertyCount (byval image as GpImage ptr, byval numOfProperty as UINT ptr) as GpStatus
declare function GdipGetPropertyIdList (byval image as GpImage ptr, byval numOfProperty as UINT, byval list as PROPID ptr) as GpStatus
declare function GdipGetPropertyItemSize (byval image as GpImage ptr, byval propId as PROPID, byval size as UINT ptr) as GpStatus
declare function GdipGetPropertyItem (byval image as GpImage ptr, byval propId as PROPID, byval propSize as UINT, byval buffer as PropertyItem ptr) as GpStatus
declare function GdipGetPropertySize (byval image as GpImage ptr, byval totalBufferSize as UINT ptr, byval numProperties as UINT ptr) as GpStatus
declare function GdipGetAllPropertyItems (byval image as GpImage ptr, byval totalBufferSize as UINT, byval numProperties as UINT, byval allItems as PropertyItem ptr) as GpStatus
declare function GdipRemovePropertyItem (byval image as GpImage ptr, byval propId as PROPID) as GpStatus
declare function GdipSetPropertyItem (byval image as GpImage ptr, byval item as PropertyItem ptr) as GpStatus
declare function GdipImageForceValidation (byval image as GpImage ptr) as GpStatus
declare function GdipCreateBitmapFromStream (byval stream as IStream ptr, byval bitmap as GpBitmap ptr ptr) as GpStatus
declare function GdipCreateBitmapFromFile (byval filename as LPCWSTR, byval bitmap as GpBitmap ptr ptr) as GpStatus
declare function GdipCreateBitmapFromStreamICM (byval stream as IStream ptr, byval bitmap as GpBitmap ptr ptr) as GpStatus
declare function GdipCreateBitmapFromFileICM (byval filename as LPCWSTR, byval bitmap as GpBitmap ptr ptr) as GpStatus
declare function GdipCreateBitmapFromScan0 (byval width as INT_, byval height as INT_, byval stride as INT_, byval format as PixelFormat, byval scan0 as UBYTE ptr, byval bitmap as GpBitmap ptr ptr) as GpStatus
declare function GdipCreateBitmapFromGraphics (byval width as INT_, byval height as INT_, byval target as GpGraphics ptr, byval bitmap as GpBitmap ptr ptr) as GpStatus
#ifdef IDirectDrawSurface7
declare function GdipCreateBitmapFromDirectDrawSurface (byval surface as IDirectDrawSurface7 ptr, byval bitmap as GpBitmap ptr ptr) as GpStatus
#endif
declare function GdipCreateBitmapFromGdiDib (byval gdiBitmapInfo as BITMAPINFO ptr, byval gdiBitmapData as any ptr, byval bitmap as GpBitmap ptr ptr) as GpStatus
declare function GdipCreateBitmapFromHBITMAP (byval hbm as HBITMAP, byval hpal as HPALETTE, byval bitmap as GpBitmap ptr ptr) as GpStatus
declare function GdipCreateHBITMAPFromBitmap (byval bitmap as GpBitmap ptr, byval hbmReturn as HBITMAP ptr, byval background as ARGB) as GpStatus
declare function GdipCreateBitmapFromHICON (byval hicon as HICON, byval bitmap as GpBitmap ptr ptr) as GpStatus
declare function GdipCreateHICONFromBitmap (byval bitmap as GpBitmap ptr, byval hbmReturn as HICON ptr) as GpStatus
declare function GdipCreateBitmapFromResource (byval hInstance as HINSTANCE, byval lpBitmapName as LPCWSTR, byval bitmap as GpBitmap ptr ptr) as GpStatus
declare function GdipCloneBitmapArea (byval x as REAL, byval y as REAL, byval width as REAL, byval height as REAL, byval format as PixelFormat, byval srcBitmap as GpBitmap ptr, byval dstBitmap as GpBitmap ptr ptr) as GpStatus
declare function GdipCloneBitmapAreaI (byval x as INT_, byval y as INT_, byval width as INT_, byval height as INT_, byval format as PixelFormat, byval srcBitmap as GpBitmap ptr, byval dstBitmap as GpBitmap ptr ptr) as GpStatus
declare function GdipBitmapLockBits (byval bitmap as GpBitmap ptr, byval rect as GpRect ptr, byval flags as UINT, byval format as PixelFormat, byval lockedBitmapData as BitmapData ptr) as GpStatus
declare function GdipBitmapUnlockBits (byval bitmap as GpBitmap ptr, byval lockedBitmapData as BitmapData ptr) as GpStatus
declare function GdipBitmapGetPixel (byval bitmap as GpBitmap ptr, byval x as INT_, byval y as INT_, byval color as ARGB ptr) as GpStatus
declare function GdipBitmapSetPixel (byval bitmap as GpBitmap ptr, byval x as INT_, byval y as INT_, byval color as ARGB) as GpStatus
declare function GdipBitmapSetResolution (byval bitmap as GpBitmap ptr, byval xdpi as REAL, byval ydpi as REAL) as GpStatus
declare function GdipCreateImageAttributes (byval imageattr as GpImageAttributes ptr ptr) as GpStatus
declare function GdipCloneImageAttributes (byval imageattr as GpImageAttributes ptr, byval cloneImageattr as GpImageAttributes ptr ptr) as GpStatus
declare function GdipDisposeImageAttributes (byval imageattr as GpImageAttributes ptr) as GpStatus
declare function GdipSetImageAttributesToIdentity (byval imageattr as GpImageAttributes ptr, byval type as ColorAdjustType) as GpStatus
declare function GdipResetImageAttributes (byval imageattr as GpImageAttributes ptr, byval type as ColorAdjustType) as GpStatus
declare function GdipSetImageAttributesColorMatrix (byval imageattr as GpImageAttributes ptr, byval type as ColorAdjustType, byval enableFlag as BOOL, byval colorMatrix as ColorMatrix ptr, byval grayMatrix as ColorMatrix ptr, byval flags as ColorMatrixFlags) as GpStatus
declare function GdipSetImageAttributesThreshold (byval imageattr as GpImageAttributes ptr, byval type as ColorAdjustType, byval enableFlag as BOOL, byval threshold as REAL) as GpStatus
declare function GdipSetImageAttributesGamma (byval imageattr as GpImageAttributes ptr, byval type as ColorAdjustType, byval enableFlag as BOOL, byval gamma as REAL) as GpStatus
declare function GdipSetImageAttributesNoOp (byval imageattr as GpImageAttributes ptr, byval type as ColorAdjustType, byval enableFlag as BOOL) as GpStatus
declare function GdipSetImageAttributesColorKeys (byval imageattr as GpImageAttributes ptr, byval type as ColorAdjustType, byval enableFlag as BOOL, byval colorLow as ARGB, byval colorHigh as ARGB) as GpStatus
declare function GdipSetImageAttributesOutputChannel (byval imageattr as GpImageAttributes ptr, byval type as ColorAdjustType, byval enableFlag as BOOL, byval channelFlags as ColorChannelFlags) as GpStatus
declare function GdipSetImageAttributesOutputChannelColorProfile (byval imageattr as GpImageAttributes ptr, byval type as ColorAdjustType, byval enableFlag as BOOL, byval colorProfileFilename as LPCWSTR) as GpStatus
declare function GdipSetImageAttributesRemapTable (byval imageattr as GpImageAttributes ptr, byval type as ColorAdjustType, byval enableFlag as BOOL, byval mapSize as UINT, byval map as ColorMap ptr) as GpStatus
declare function GdipSetImageAttributesWrapMode (byval imageAttr as GpImageAttributes ptr, byval wrap as WrapMode, byval argb as ARGB, byval clamp as BOOL) as GpStatus
declare function GdipSetImageAttributesICMMode (byval imageAttr as GpImageAttributes ptr, byval on as BOOL) as GpStatus
declare function GdipGetImageAttributesAdjustedPalette (byval imageAttr as GpImageAttributes ptr, byval colorPalette as ColorPalette ptr, byval colorAdjustType as ColorAdjustType) as GpStatus
declare function GdipFlush (byval graphics as GpGraphics ptr, byval intention as GpFlushIntention) as GpStatus
declare function GdipCreateFromHDC (byval hdc as HDC, byval graphics as GpGraphics ptr ptr) as GpStatus
declare function GdipCreateFromHDC2 (byval hdc as HDC, byval hDevice as HANDLE, byval graphics as GpGraphics ptr ptr) as GpStatus
declare function GdipCreateFromHWND (byval hwnd as HWND, byval graphics as GpGraphics ptr ptr) as GpStatus
declare function GdipCreateFromHWNDICM (byval hwnd as HWND, byval graphics as GpGraphics ptr ptr) as GpStatus
declare function GdipDeleteGraphics (byval graphics as GpGraphics ptr) as GpStatus
declare function GdipGetDC (byval graphics as GpGraphics ptr, byval hdc as HDC ptr) as GpStatus
declare function GdipReleaseDC (byval graphics as GpGraphics ptr, byval hdc as HDC) as GpStatus
declare function GdipSetCompositingMode (byval graphics as GpGraphics ptr, byval compositingMode as CompositingMode) as GpStatus
declare function GdipGetCompositingMode (byval graphics as GpGraphics ptr, byval compositingMode as CompositingMode ptr) as GpStatus
declare function GdipSetRenderingOrigin (byval graphics as GpGraphics ptr, byval x as INT_, byval y as INT_) as GpStatus
declare function GdipGetRenderingOrigin (byval graphics as GpGraphics ptr, byval x as INT_ ptr, byval y as INT_ ptr) as GpStatus
declare function GdipSetCompositingQuality (byval graphics as GpGraphics ptr, byval compositingQuality as CompositingQuality) as GpStatus
declare function GdipGetCompositingQuality (byval graphics as GpGraphics ptr, byval compositingQuality as CompositingQuality ptr) as GpStatus
declare function GdipSetSmoothingMode (byval graphics as GpGraphics ptr, byval smoothingMode as SmoothingMode) as GpStatus
declare function GdipGetSmoothingMode (byval graphics as GpGraphics ptr, byval smoothingMode as SmoothingMode ptr) as GpStatus
declare function GdipSetPixelOffsetMode (byval graphics as GpGraphics ptr, byval pixelOffsetMode as PixelOffsetMode) as GpStatus
declare function GdipGetPixelOffsetMode (byval graphics as GpGraphics ptr, byval pixelOffsetMode as PixelOffsetMode ptr) as GpStatus
declare function GdipSetTextRenderingHint (byval graphics as GpGraphics ptr, byval mode as TextRenderingHint) as GpStatus
declare function GdipGetTextRenderingHint (byval graphics as GpGraphics ptr, byval mode as TextRenderingHint ptr) as GpStatus
declare function GdipSetTextContrast (byval graphics as GpGraphics ptr, byval contrast as UINT) as GpStatus
declare function GdipGetTextContrast (byval graphics as GpGraphics ptr, byval contrast as UINT ptr) as GpStatus
declare function GdipSetInterpolationMode (byval graphics as GpGraphics ptr, byval interpolationMode as InterpolationMode) as GpStatus
declare function GdipGetInterpolationMode (byval graphics as GpGraphics ptr, byval interpolationMode as InterpolationMode ptr) as GpStatus
declare function GdipSetWorldTransform (byval graphics as GpGraphics ptr, byval matrix as GpMatrix ptr) as GpStatus
declare function GdipResetWorldTransform (byval graphics as GpGraphics ptr) as GpStatus
declare function GdipMultiplyWorldTransform (byval graphics as GpGraphics ptr, byval matrix as GpMatrix ptr, byval order as GpMatrixOrder) as GpStatus
declare function GdipTranslateWorldTransform (byval graphics as GpGraphics ptr, byval dx as REAL, byval dy as REAL, byval order as GpMatrixOrder) as GpStatus
declare function GdipScaleWorldTransform (byval graphics as GpGraphics ptr, byval sx as REAL, byval sy as REAL, byval order as GpMatrixOrder) as GpStatus
declare function GdipRotateWorldTransform (byval graphics as GpGraphics ptr, byval angle as REAL, byval order as GpMatrixOrder) as GpStatus
declare function GdipGetWorldTransform (byval graphics as GpGraphics ptr, byval matrix as GpMatrix ptr) as GpStatus
declare function GdipResetPageTransform (byval graphics as GpGraphics ptr) as GpStatus
declare function GdipGetPageUnit (byval graphics as GpGraphics ptr, byval unit as GpUnit ptr) as GpStatus
declare function GdipGetPageScale (byval graphics as GpGraphics ptr, byval scale as REAL ptr) as GpStatus
declare function GdipSetPageUnit (byval graphics as GpGraphics ptr, byval unit as GpUnit) as GpStatus
declare function GdipSetPageScale (byval graphics as GpGraphics ptr, byval scale as REAL) as GpStatus
declare function GdipGetDpiX (byval graphics as GpGraphics ptr, byval dpi as REAL ptr) as GpStatus
declare function GdipGetDpiY (byval graphics as GpGraphics ptr, byval dpi as REAL ptr) as GpStatus
declare function GdipTransformPoints (byval graphics as GpGraphics ptr, byval destSpace as GpCoordinateSpace, byval srcSpace as GpCoordinateSpace, byval points as GpPointF ptr, byval count as INT_) as GpStatus
declare function GdipTransformPointsI (byval graphics as GpGraphics ptr, byval destSpace as GpCoordinateSpace, byval srcSpace as GpCoordinateSpace, byval points as GpPoint ptr, byval count as INT_) as GpStatus
declare function GdipGetNearestColor (byval graphics as GpGraphics ptr, byval argb as ARGB ptr) as GpStatus
declare function GdipCreateHalftonePalette () as HPALETTE
declare function GdipDrawLine (byval graphics as GpGraphics ptr, byval pen as GpPen ptr, byval x1 as REAL, byval y1 as REAL, byval x2 as REAL, byval y2 as REAL) as GpStatus
declare function GdipDrawLineI (byval graphics as GpGraphics ptr, byval pen as GpPen ptr, byval x1 as INT_, byval y1 as INT_, byval x2 as INT_, byval y2 as INT_) as GpStatus
declare function GdipDrawLines (byval graphics as GpGraphics ptr, byval pen as GpPen ptr, byval points as GpPointF ptr, byval count as INT_) as GpStatus
declare function GdipDrawLinesI (byval graphics as GpGraphics ptr, byval pen as GpPen ptr, byval points as GpPoint ptr, byval count as INT_) as GpStatus
declare function GdipDrawArc (byval graphics as GpGraphics ptr, byval pen as GpPen ptr, byval x as REAL, byval y as REAL, byval width as REAL, byval height as REAL, byval startAngle as REAL, byval sweepAngle as REAL) as GpStatus
declare function GdipDrawArcI (byval graphics as GpGraphics ptr, byval pen as GpPen ptr, byval x as INT_, byval y as INT_, byval width as INT_, byval height as INT_, byval startAngle as REAL, byval sweepAngle as REAL) as GpStatus
declare function GdipDrawBezier (byval graphics as GpGraphics ptr, byval pen as GpPen ptr, byval x1 as REAL, byval y1 as REAL, byval x2 as REAL, byval y2 as REAL, byval x3 as REAL, byval y3 as REAL, byval x4 as REAL, byval y4 as REAL) as GpStatus
declare function GdipDrawBezierI (byval graphics as GpGraphics ptr, byval pen as GpPen ptr, byval x1 as INT_, byval y1 as INT_, byval x2 as INT_, byval y2 as INT_, byval x3 as INT_, byval y3 as INT_, byval x4 as INT_, byval y4 as INT_) as GpStatus
declare function GdipDrawBeziers (byval graphics as GpGraphics ptr, byval pen as GpPen ptr, byval points as GpPointF ptr, byval count as INT_) as GpStatus
declare function GdipDrawBeziersI (byval graphics as GpGraphics ptr, byval pen as GpPen ptr, byval points as GpPoint ptr, byval count as INT_) as GpStatus
declare function GdipDrawRectangle (byval graphics as GpGraphics ptr, byval pen as GpPen ptr, byval x as REAL, byval y as REAL, byval width as REAL, byval height as REAL) as GpStatus
declare function GdipDrawRectangleI (byval graphics as GpGraphics ptr, byval pen as GpPen ptr, byval x as INT_, byval y as INT_, byval width as INT_, byval height as INT_) as GpStatus
declare function GdipDrawRectangles (byval graphics as GpGraphics ptr, byval pen as GpPen ptr, byval rects as GpRectF ptr, byval count as INT_) as GpStatus
declare function GdipDrawRectanglesI (byval graphics as GpGraphics ptr, byval pen as GpPen ptr, byval rects as GpRect ptr, byval count as INT_) as GpStatus
declare function GdipDrawEllipse (byval graphics as GpGraphics ptr, byval pen as GpPen ptr, byval x as REAL, byval y as REAL, byval width as REAL, byval height as REAL) as GpStatus
declare function GdipDrawEllipseI (byval graphics as GpGraphics ptr, byval pen as GpPen ptr, byval x as INT_, byval y as INT_, byval width as INT_, byval height as INT_) as GpStatus
declare function GdipDrawPie (byval graphics as GpGraphics ptr, byval pen as GpPen ptr, byval x as REAL, byval y as REAL, byval width as REAL, byval height as REAL, byval startAngle as REAL, byval sweepAngle as REAL) as GpStatus
declare function GdipDrawPieI (byval graphics as GpGraphics ptr, byval pen as GpPen ptr, byval x as INT_, byval y as INT_, byval width as INT_, byval height as INT_, byval startAngle as REAL, byval sweepAngle as REAL) as GpStatus
declare function GdipDrawPolygon (byval graphics as GpGraphics ptr, byval pen as GpPen ptr, byval points as GpPointF ptr, byval count as INT_) as GpStatus
declare function GdipDrawPolygonI (byval graphics as GpGraphics ptr, byval pen as GpPen ptr, byval points as GpPoint ptr, byval count as INT_) as GpStatus
declare function GdipDrawPath (byval graphics as GpGraphics ptr, byval pen as GpPen ptr, byval path as GpPath ptr) as GpStatus
declare function GdipDrawCurve (byval graphics as GpGraphics ptr, byval pen as GpPen ptr, byval points as GpPointF ptr, byval count as INT_) as GpStatus
declare function GdipDrawCurveI (byval graphics as GpGraphics ptr, byval pen as GpPen ptr, byval points as GpPoint ptr, byval count as INT_) as GpStatus
declare function GdipDrawCurve2 (byval graphics as GpGraphics ptr, byval pen as GpPen ptr, byval points as GpPointF ptr, byval count as INT_, byval tension as REAL) as GpStatus
declare function GdipDrawCurve2I (byval graphics as GpGraphics ptr, byval pen as GpPen ptr, byval points as GpPoint ptr, byval count as INT_, byval tension as REAL) as GpStatus
declare function GdipDrawCurve3 (byval graphics as GpGraphics ptr, byval pen as GpPen ptr, byval points as GpPointF ptr, byval count as INT_, byval offset as INT_, byval numberOfSegments as INT_, byval tension as REAL) as GpStatus
declare function GdipDrawCurve3I (byval graphics as GpGraphics ptr, byval pen as GpPen ptr, byval points as GpPoint ptr, byval count as INT_, byval offset as INT_, byval numberOfSegments as INT_, byval tension as REAL) as GpStatus
declare function GdipDrawClosedCurve (byval graphics as GpGraphics ptr, byval pen as GpPen ptr, byval points as GpPointF ptr, byval count as INT_) as GpStatus
declare function GdipDrawClosedCurveI (byval graphics as GpGraphics ptr, byval pen as GpPen ptr, byval points as GpPoint ptr, byval count as INT_) as GpStatus
declare function GdipDrawClosedCurve2 (byval graphics as GpGraphics ptr, byval pen as GpPen ptr, byval points as GpPointF ptr, byval count as INT_, byval tension as REAL) as GpStatus
declare function GdipDrawClosedCurve2I (byval graphics as GpGraphics ptr, byval pen as GpPen ptr, byval points as GpPoint ptr, byval count as INT_, byval tension as REAL) as GpStatus
declare function GdipGraphicsClear (byval graphics as GpGraphics ptr, byval color as ARGB) as GpStatus
declare function GdipFillRectangle (byval graphics as GpGraphics ptr, byval brush as GpBrush ptr, byval x as REAL, byval y as REAL, byval width as REAL, byval height as REAL) as GpStatus
declare function GdipFillRectangleI (byval graphics as GpGraphics ptr, byval brush as GpBrush ptr, byval x as INT_, byval y as INT_, byval width as INT_, byval height as INT_) as GpStatus
declare function GdipFillRectangles (byval graphics as GpGraphics ptr, byval brush as GpBrush ptr, byval rects as GpRectF ptr, byval count as INT_) as GpStatus
declare function GdipFillRectanglesI (byval graphics as GpGraphics ptr, byval brush as GpBrush ptr, byval rects as GpRect ptr, byval count as INT_) as GpStatus
declare function GdipFillPolygon (byval graphics as GpGraphics ptr, byval brush as GpBrush ptr, byval points as GpPointF ptr, byval count as INT_, byval fillMode as GpFillMode) as GpStatus
declare function GdipFillPolygonI (byval graphics as GpGraphics ptr, byval brush as GpBrush ptr, byval points as GpPoint ptr, byval count as INT_, byval fillMode as GpFillMode) as GpStatus
declare function GdipFillPolygon2 (byval graphics as GpGraphics ptr, byval brush as GpBrush ptr, byval points as GpPointF ptr, byval count as INT_) as GpStatus
declare function GdipFillPolygon2I (byval graphics as GpGraphics ptr, byval brush as GpBrush ptr, byval points as GpPoint ptr, byval count as INT_) as GpStatus
declare function GdipFillEllipse (byval graphics as GpGraphics ptr, byval brush as GpBrush ptr, byval x as REAL, byval y as REAL, byval width as REAL, byval height as REAL) as GpStatus
declare function GdipFillEllipseI (byval graphics as GpGraphics ptr, byval brush as GpBrush ptr, byval x as INT_, byval y as INT_, byval width as INT_, byval height as INT_) as GpStatus
declare function GdipFillPie (byval graphics as GpGraphics ptr, byval brush as GpBrush ptr, byval x as REAL, byval y as REAL, byval width as REAL, byval height as REAL, byval startAngle as REAL, byval sweepAngle as REAL) as GpStatus
declare function GdipFillPieI (byval graphics as GpGraphics ptr, byval brush as GpBrush ptr, byval x as INT_, byval y as INT_, byval width as INT_, byval height as INT_, byval startAngle as REAL, byval sweepAngle as REAL) as GpStatus
declare function GdipFillPath (byval graphics as GpGraphics ptr, byval brush as GpBrush ptr, byval path as GpPath ptr) as GpStatus
declare function GdipFillClosedCurve (byval graphics as GpGraphics ptr, byval brush as GpBrush ptr, byval points as GpPointF ptr, byval count as INT_) as GpStatus
declare function GdipFillClosedCurveI (byval graphics as GpGraphics ptr, byval brush as GpBrush ptr, byval points as GpPoint ptr, byval count as INT_) as GpStatus
declare function GdipFillClosedCurve2 (byval graphics as GpGraphics ptr, byval brush as GpBrush ptr, byval points as GpPointF ptr, byval count as INT_, byval tension as REAL, byval fillMode as GpFillMode) as GpStatus
declare function GdipFillClosedCurve2I (byval graphics as GpGraphics ptr, byval brush as GpBrush ptr, byval points as GpPoint ptr, byval count as INT_, byval tension as REAL, byval fillMode as GpFillMode) as GpStatus
declare function GdipFillRegion (byval graphics as GpGraphics ptr, byval brush as GpBrush ptr, byval region as GpRegion ptr) as GpStatus
declare function GdipDrawImage (byval graphics as GpGraphics ptr, byval image as GpImage ptr, byval x as REAL, byval y as REAL) as GpStatus
declare function GdipDrawImageI (byval graphics as GpGraphics ptr, byval image as GpImage ptr, byval x as INT_, byval y as INT_) as GpStatus
declare function GdipDrawImageRect (byval graphics as GpGraphics ptr, byval image as GpImage ptr, byval x as REAL, byval y as REAL, byval width as REAL, byval height as REAL) as GpStatus
declare function GdipDrawImageRectI (byval graphics as GpGraphics ptr, byval image as GpImage ptr, byval x as INT_, byval y as INT_, byval width as INT_, byval height as INT_) as GpStatus
declare function GdipDrawImagePoints (byval graphics as GpGraphics ptr, byval image as GpImage ptr, byval dstpoints as GpPointF ptr, byval count as INT_) as GpStatus
declare function GdipDrawImagePointsI (byval graphics as GpGraphics ptr, byval image as GpImage ptr, byval dstpoints as GpPoint ptr, byval count as INT_) as GpStatus
declare function GdipDrawImagePointRect (byval graphics as GpGraphics ptr, byval image as GpImage ptr, byval x as REAL, byval y as REAL, byval srcx as REAL, byval srcy as REAL, byval srcwidth as REAL, byval srcheight as REAL, byval srcUnit as GpUnit) as GpStatus
declare function GdipDrawImagePointRectI (byval graphics as GpGraphics ptr, byval image as GpImage ptr, byval x as INT_, byval y as INT_, byval srcx as INT_, byval srcy as INT_, byval srcwidth as INT_, byval srcheight as INT_, byval srcUnit as GpUnit) as GpStatus
declare function GdipDrawImageRectRect (byval graphics as GpGraphics ptr, byval image as GpImage ptr, byval dstx as REAL, byval dsty as REAL, byval dstwidth as REAL, byval dstheight as REAL, byval srcx as REAL, byval srcy as REAL, byval srcwidth as REAL, byval srcheight as REAL, byval srcUnit as GpUnit, byval imageAttributes as GpImageAttributes ptr, byval callback as DrawImageAbort, byval callbackData as any ptr) as GpStatus
declare function GdipDrawImageRectRectI (byval graphics as GpGraphics ptr, byval image as GpImage ptr, byval dstx as INT_, byval dsty as INT_, byval dstwidth as INT_, byval dstheight as INT_, byval srcx as INT_, byval srcy as INT_, byval srcwidth as INT_, byval srcheight as INT_, byval srcUnit as GpUnit, byval imageAttributes as GpImageAttributes ptr, byval callback as DrawImageAbort, byval callbackData as any ptr) as GpStatus
declare function GdipDrawImagePointsRect (byval graphics as GpGraphics ptr, byval image as GpImage ptr, byval points as GpPointF ptr, byval count as INT_, byval srcx as REAL, byval srcy as REAL, byval srcwidth as REAL, byval srcheight as REAL, byval srcUnit as GpUnit, byval imageAttributes as GpImageAttributes ptr, byval callback as DrawImageAbort, byval callbackData as any ptr) as GpStatus
declare function GdipDrawImagePointsRectI (byval graphics as GpGraphics ptr, byval image as GpImage ptr, byval points as GpPoint ptr, byval count as INT_, byval srcx as INT_, byval srcy as INT_, byval srcwidth as INT_, byval srcheight as INT_, byval srcUnit as GpUnit, byval imageAttributes as GpImageAttributes ptr, byval callback as DrawImageAbort, byval callbackData as any ptr) as GpStatus
declare function GdipEnumerateMetafileDestPoint (byval graphics as GpGraphics ptr, byval metafile as GpMetafile ptr, byval destPoint as PointF, byval callback as EnumerateMetafileProc, byval callbackData as any ptr, byval imageAttributes as GpImageAttributes ptr) as GpStatus
declare function GdipEnumerateMetafileDestPointI (byval graphics as GpGraphics ptr, byval metafile as GpMetafile ptr, byval destPoint as Point, byval callback as EnumerateMetafileProc, byval callbackData as any ptr, byval imageAttributes as GpImageAttributes ptr) as GpStatus
declare function GdipEnumerateMetafileDestRect (byval graphics as GpGraphics ptr, byval metafile as GpMetafile ptr, byval destRect as RectF, byval callback as EnumerateMetafileProc, byval callbackData as any ptr, byval imageAttributes as GpImageAttributes ptr) as GpStatus
declare function GdipEnumerateMetafileDestRectI (byval graphics as GpGraphics ptr, byval metafile as GpMetafile ptr, byval destRect as Rect, byval callback as EnumerateMetafileProc, byval callbackData as any ptr, byval imageAttributes as GpImageAttributes ptr) as GpStatus
declare function GdipEnumerateMetafileDestPoints (byval graphics as GpGraphics ptr, byval metafile as GpMetafile ptr, byval destPoints as PointF ptr, byval count as INT_, byval callback as EnumerateMetafileProc, byval callbackData as any ptr, byval imageAttributes as GpImageAttributes ptr) as GpStatus
declare function GdipEnumerateMetafileDestPointsI (byval graphics as GpGraphics ptr, byval metafile as GpMetafile ptr, byval destPoints as Point ptr, byval count as INT_, byval callback as EnumerateMetafileProc, byval callbackData as any ptr, byval imageAttributes as GpImageAttributes ptr) as GpStatus
declare function GdipEnumerateMetafileSrcRectDestPoint (byval graphics as GpGraphics ptr, byval metafile as GpMetafile ptr, byval destPoint as PointF, byval srcRect as RectF, byval srcUnit as Unit, byval callback as EnumerateMetafileProc, byval callbackData as any ptr, byval imageAttributes as GpImageAttributes ptr) as GpStatus
declare function GdipEnumerateMetafileSrcRectDestPointI (byval graphics as GpGraphics ptr, byval metafile as GpMetafile ptr, byval destPoint as Point, byval srcRect as Rect, byval srcUnit as Unit, byval callback as EnumerateMetafileProc, byval callbackData as any ptr, byval imageAttributes as GpImageAttributes ptr) as GpStatus
declare function GdipEnumerateMetafileSrcRectDestRect (byval graphics as GpGraphics ptr, byval metafile as GpMetafile ptr, byval destRect as RectF, byval srcRect as RectF, byval srcUnit as Unit, byval callback as EnumerateMetafileProc, byval callbackData as any ptr, byval imageAttributes as GpImageAttributes ptr) as GpStatus
declare function GdipEnumerateMetafileSrcRectDestRectI (byval graphics as GpGraphics ptr, byval metafile as GpMetafile ptr, byval destRect as Rect, byval srcRect as Rect, byval srcUnit as Unit, byval callback as EnumerateMetafileProc, byval callbackData as any ptr, byval imageAttributes as GpImageAttributes ptr) as GpStatus
declare function GdipEnumerateMetafileSrcRectDestPoints (byval graphics as GpGraphics ptr, byval metafile as GpMetafile ptr, byval destPoints as PointF ptr, byval count as INT_, byval srcRect as RectF, byval srcUnit as Unit, byval callback as EnumerateMetafileProc, byval callbackData as any ptr, byval imageAttributes as GpImageAttributes ptr) as GpStatus
declare function GdipEnumerateMetafileSrcRectDestPointsI (byval graphics as GpGraphics ptr, byval metafile as GpMetafile ptr, byval destPoints as Point ptr, byval count as INT_, byval srcRect as Rect, byval srcUnit as Unit, byval callback as EnumerateMetafileProc, byval callbackData as any ptr, byval imageAttributes as GpImageAttributes ptr) as GpStatus
declare function GdipPlayMetafileRecord (byval metafile as GpMetafile ptr, byval recordType as EmfPlusRecordType, byval flags as UINT, byval dataSize as UINT, byval data as UBYTE ptr) as GpStatus
declare function GdipSetClipGraphics (byval graphics as GpGraphics ptr, byval srcgraphics as GpGraphics ptr, byval combineMode as CombineMode) as GpStatus
declare function GdipSetClipRect (byval graphics as GpGraphics ptr, byval x as REAL, byval y as REAL, byval width as REAL, byval height as REAL, byval combineMode as CombineMode) as GpStatus
declare function GdipSetClipRectI (byval graphics as GpGraphics ptr, byval x as INT_, byval y as INT_, byval width as INT_, byval height as INT_, byval combineMode as CombineMode) as GpStatus
declare function GdipSetClipPath (byval graphics as GpGraphics ptr, byval path as GpPath ptr, byval combineMode as CombineMode) as GpStatus
declare function GdipSetClipRegion (byval graphics as GpGraphics ptr, byval region as GpRegion ptr, byval combineMode as CombineMode) as GpStatus
declare function GdipSetClipHrgn (byval graphics as GpGraphics ptr, byval hRgn as HRGN, byval combineMode as CombineMode) as GpStatus
declare function GdipResetClip (byval graphics as GpGraphics ptr) as GpStatus
declare function GdipTranslateClip (byval graphics as GpGraphics ptr, byval dx as REAL, byval dy as REAL) as GpStatus
declare function GdipTranslateClipI (byval graphics as GpGraphics ptr, byval dx as INT_, byval dy as INT_) as GpStatus
declare function GdipGetClip (byval graphics as GpGraphics ptr, byval region as GpRegion ptr) as GpStatus
declare function GdipGetClipBounds (byval graphics as GpGraphics ptr, byval rect as GpRectF ptr) as GpStatus
declare function GdipGetClipBoundsI (byval graphics as GpGraphics ptr, byval rect as GpRect ptr) as GpStatus
declare function GdipIsClipEmpty (byval graphics as GpGraphics ptr, byval result as BOOL ptr) as GpStatus
declare function GdipGetVisibleClipBounds (byval graphics as GpGraphics ptr, byval rect as GpRectF ptr) as GpStatus
declare function GdipGetVisibleClipBoundsI (byval graphics as GpGraphics ptr, byval rect as GpRect ptr) as GpStatus
declare function GdipIsVisibleClipEmpty (byval graphics as GpGraphics ptr, byval result as BOOL ptr) as GpStatus
declare function GdipIsVisiblePoint (byval graphics as GpGraphics ptr, byval x as REAL, byval y as REAL, byval result as BOOL ptr) as GpStatus
declare function GdipIsVisiblePointI (byval graphics as GpGraphics ptr, byval x as INT_, byval y as INT_, byval result as BOOL ptr) as GpStatus
declare function GdipIsVisibleRect (byval graphics as GpGraphics ptr, byval x as REAL, byval y as REAL, byval width as REAL, byval height as REAL, byval result as BOOL ptr) as GpStatus
declare function GdipIsVisibleRectI (byval graphics as GpGraphics ptr, byval x as INT_, byval y as INT_, byval width as INT_, byval height as INT_, byval result as BOOL ptr) as GpStatus
declare function GdipSaveGraphics (byval graphics as GpGraphics ptr, byval state as GraphicsState ptr) as GpStatus
declare function GdipRestoreGraphics (byval graphics as GpGraphics ptr, byval state as GraphicsState) as GpStatus
declare function GdipBeginContainer (byval graphics as GpGraphics ptr, byval dstrect as GpRectF ptr, byval srcrect as GpRectF ptr, byval unit as GpUnit, byval state as GraphicsContainer ptr) as GpStatus
declare function GdipBeginContainerI (byval graphics as GpGraphics ptr, byval dstrect as GpRect ptr, byval srcrect as GpRect ptr, byval unit as GpUnit, byval state as GraphicsContainer ptr) as GpStatus
declare function GdipBeginContainer2 (byval graphics as GpGraphics ptr, byval state as GraphicsContainer ptr) as GpStatus
declare function GdipEndContainer (byval graphics as GpGraphics ptr, byval state as GraphicsContainer) as GpStatus
declare function GdipGetMetafileHeaderFromWmf (byval hWmf as HMETAFILE, byval wmfPlaceableFileHeader as WmfPlaceableFileHeader ptr, byval header as MetafileHeader ptr) as GpStatus
declare function GdipGetMetafileHeaderFromEmf (byval hEmf as HENHMETAFILE, byval header as MetafileHeader ptr) as GpStatus
declare function GdipGetMetafileHeaderFromFile (byval filename as LPCWSTR, byval header as MetafileHeader ptr) as GpStatus
declare function GdipGetMetafileHeaderFromStream (byval stream as IStream ptr, byval header as MetafileHeader ptr) as GpStatus
declare function GdipGetMetafileHeaderFromMetafile (byval metafile as GpMetafile ptr, byval header as MetafileHeader ptr) as GpStatus
declare function GdipGetHemfFromMetafile (byval metafile as GpMetafile ptr, byval hEmf as HENHMETAFILE ptr) as GpStatus
declare function GdipCreateStreamOnFile (byval filename as LPCWSTR, byval access as UINT, byval stream as IStream ptr ptr) as GpStatus
declare function GdipCreateMetafileFromWmf (byval hWmf as HMETAFILE, byval deleteWmf as BOOL, byval wmfPlaceableFileHeader as WmfPlaceableFileHeader ptr, byval metafile as GpMetafile ptr ptr) as GpStatus
declare function GdipCreateMetafileFromEmf (byval hEmf as HENHMETAFILE, byval deleteEmf as BOOL, byval metafile as GpMetafile ptr ptr) as GpStatus
declare function GdipCreateMetafileFromFile (byval file as LPCWSTR, byval metafile as GpMetafile ptr ptr) as GpStatus
declare function GdipCreateMetafileFromWmfFile (byval file as LPCWSTR, byval wmfPlaceableFileHeader as WmfPlaceableFileHeader ptr, byval metafile as GpMetafile ptr ptr) as GpStatus
declare function GdipCreateMetafileFromStream (byval stream as IStream ptr, byval metafile as GpMetafile ptr ptr) as GpStatus
declare function GdipRecordMetafile (byval referenceHdc as HDC, byval type as EmfType, byval frameRect as GpRectF ptr, byval frameUnit as MetafileFrameUnit, byval description as LPCWSTR, byval metafile as GpMetafile ptr ptr) as GpStatus
declare function GdipRecordMetafileI (byval referenceHdc as HDC, byval type as EmfType, byval frameRect as GpRect ptr, byval frameUnit as MetafileFrameUnit, byval description as LPCWSTR, byval metafile as GpMetafile ptr ptr) as GpStatus
declare function GdipRecordMetafileFileName (byval fileName as LPCWSTR, byval referenceHdc as HDC, byval type as EmfType, byval frameRect as GpRectF ptr, byval frameUnit as MetafileFrameUnit, byval description as LPCWSTR, byval metafile as GpMetafile ptr ptr) as GpStatus
declare function GdipRecordMetafileFileNameI (byval fileName as LPCWSTR, byval referenceHdc as HDC, byval type as EmfType, byval frameRect as GpRect ptr, byval frameUnit as MetafileFrameUnit, byval description as LPCWSTR, byval metafile as GpMetafile ptr ptr) as GpStatus
declare function GdipRecordMetafileStream (byval stream as IStream ptr, byval referenceHdc as HDC, byval type as EmfType, byval frameRect as GpRectF ptr, byval frameUnit as MetafileFrameUnit, byval description as LPCWSTR, byval metafile as GpMetafile ptr ptr) as GpStatus
declare function GdipRecordMetafileStreamI (byval stream as IStream ptr, byval referenceHdc as HDC, byval type as EmfType, byval frameRect as GpRect ptr, byval frameUnit as MetafileFrameUnit, byval description as LPCWSTR, byval metafile as GpMetafile ptr ptr) as GpStatus
declare function GdipSetMetafileDownLevelRasterizationLimit (byval metafile as GpMetafile ptr, byval metafileRasterizationLimitDpi as UINT) as GpStatus
declare function GdipGetMetafileDownLevelRasterizationLimit (byval metafile as GpMetafile ptr, byval metafileRasterizationLimitDpi as UINT ptr) as GpStatus
declare function GdipGetImageDecodersSize (byval numDecoders as UINT ptr, byval size as UINT ptr) as GpStatus
declare function GdipGetImageDecoders (byval numDecoders as UINT, byval size as UINT, byval decoders as ImageCodecInfo ptr) as GpStatus
declare function GdipGetImageEncodersSize (byval numEncoders as UINT ptr, byval size as UINT ptr) as GpStatus
declare function GdipGetImageEncoders (byval numEncoders as UINT, byval size as UINT, byval encoders as ImageCodecInfo ptr) as GpStatus
declare function GdipComment (byval graphics as GpGraphics ptr, byval sizeData as UINT, byval data as UBYTE ptr) as GpStatus
declare function GdipCreateFontFamilyFromName (byval name as LPCWSTR, byval fontCollection as GpFontCollection ptr, byval FontFamily as GpFontFamily ptr ptr) as GpStatus
declare function GdipDeleteFontFamily (byval FontFamily as GpFontFamily ptr) as GpStatus
declare function GdipCloneFontFamily (byval FontFamily as GpFontFamily ptr, byval clonedFontFamily as GpFontFamily ptr ptr) as GpStatus
declare function GdipGetGenericFontFamilySansSerif (byval nativeFamily as GpFontFamily ptr ptr) as GpStatus
declare function GdipGetGenericFontFamilySerif (byval nativeFamily as GpFontFamily ptr ptr) as GpStatus
declare function GdipGetGenericFontFamilyMonospace (byval nativeFamily as GpFontFamily ptr ptr) as GpStatus
declare function GdipGetFamilyName (byval family as GpFontFamily ptr, byval name as LPCWSTR, byval language as LANGID) as GpStatus
declare function GdipIsStyleAvailable (byval family as GpFontFamily ptr, byval style as INT_, byval IsStyleAvailable as BOOL ptr) as GpStatus
declare function GdipFontCollectionEnumerable (byval fontCollection as GpFontCollection ptr, byval graphics as GpGraphics ptr, byval numFound as INT_ ptr) as GpStatus
declare function GdipFontCollectionEnumerate (byval fontCollection as GpFontCollection ptr, byval numSought as INT_, byval gpfamilies as GpFontFamily ptr ptr, byval numFound as INT_ ptr, byval graphics as GpGraphics ptr) as GpStatus
declare function GdipGetEmHeight (byval family as GpFontFamily ptr, byval style as INT_, byval EmHeight as UINT16 ptr) as GpStatus
declare function GdipGetCellAscent (byval family as GpFontFamily ptr, byval style as INT_, byval CellAscent as UINT16 ptr) as GpStatus
declare function GdipGetCellDescent (byval family as GpFontFamily ptr, byval style as INT_, byval CellDescent as UINT16 ptr) as GpStatus
declare function GdipGetLineSpacing (byval family as GpFontFamily ptr, byval style as INT_, byval LineSpacing as UINT16 ptr) as GpStatus
declare function GdipCreateFontFromDC (byval hdc as HDC, byval font as GpFont ptr ptr) as GpStatus

declare function GdipCreateFont (byval fontFamily as GpFontFamily ptr, byval emSize as REAL, byval style as INT_, byval unit as Unit, byval font as GpFont ptr ptr) as GpStatus
declare function GdipCloneFont (byval font as GpFont ptr, byval cloneFont as GpFont ptr ptr) as GpStatus
declare function GdipDeleteFont (byval font as GpFont ptr) as GpStatus
declare function GdipGetFamily (byval font as GpFont ptr, byval family as GpFontFamily ptr ptr) as GpStatus
declare function GdipGetFontStyle (byval font as GpFont ptr, byval style as INT_ ptr) as GpStatus
declare function GdipGetFontSize (byval font as GpFont ptr, byval size as REAL ptr) as GpStatus
declare function GdipGetFontUnit (byval font as GpFont ptr, byval unit as Unit ptr) as GpStatus
declare function GdipGetFontHeight (byval font as GpFont ptr, byval graphics as GpGraphics ptr, byval height as REAL ptr) as GpStatus
declare function GdipGetFontHeightGivenDPI (byval font as GpFont ptr, byval dpi as REAL, byval height as REAL ptr) as GpStatus
declare function GdipNewInstalledFontCollection (byval fontCollection as GpFontCollection ptr ptr) as GpStatus
declare function GdipNewPrivateFontCollection (byval fontCollection as GpFontCollection ptr ptr) as GpStatus
declare function GdipDeletePrivateFontCollection (byval fontCollection as GpFontCollection ptr ptr) as GpStatus
declare function GdipGetFontCollectionFamilyCount (byval fontCollection as GpFontCollection ptr, byval numFound as INT_ ptr) as GpStatus
declare function GdipGetFontCollectionFamilyList (byval fontCollection as GpFontCollection ptr, byval numSought as INT_, byval gpfamilies as GpFontFamily ptr ptr, byval numFound as INT_ ptr) as GpStatus
declare function GdipPrivateAddFontFile (byval fontCollection as GpFontCollection ptr, byval filename as LPCWSTR) as GpStatus
declare function GdipPrivateAddMemoryFont (byval fontCollection as GpFontCollection ptr, byval memory as any ptr, byval length as INT_) as GpStatus
declare function GdipDrawString (byval graphics as GpGraphics ptr, byval string as LPCWSTR, byval length as INT_, byval font as GpFont ptr, byval layoutRect as RectF ptr, byval stringFormat as GpStringFormat ptr, byval brush as GpBrush ptr) as GpStatus
declare function GdipMeasureString (byval graphics as GpGraphics ptr, byval string as LPCWSTR, byval length as INT_, byval font as GpFont ptr, byval layoutRect as RectF ptr, byval stringFormat as GpStringFormat ptr, byval boundingBox as RectF ptr, byval codepointsFitted as INT_ ptr, byval linesFilled as INT_ ptr) as GpStatus
declare function GdipMeasureCharacterRanges (byval graphics as GpGraphics ptr, byval string as LPCWSTR, byval length as INT_, byval font as GpFont ptr, byval layoutRect as RectF ptr, byval stringFormat as GpStringFormat ptr, byval regionCount as INT_, byval regions as GpRegion ptr ptr) as GpStatus
declare function GdipDrawDriverString (byval graphics as GpGraphics ptr, byval text as UINT16 ptr, byval length as INT_, byval font as GpFont ptr, byval brush as GpBrush ptr, byval positions as PointF ptr, byval flags as INT_, byval matrix as GpMatrix ptr) as GpStatus
declare function GdipMeasureDriverString (byval graphics as GpGraphics ptr, byval text as UINT16 ptr, byval length as INT_, byval font as GpFont ptr, byval positions as PointF ptr, byval flags as INT_, byval matrix as GpMatrix ptr, byval boundingBox as RectF ptr) as GpStatus
declare function GdipCreateStringFormat (byval formatAttributes as INT_, byval language as LANGID, byval format as GpStringFormat ptr ptr) as GpStatus
declare function GdipStringFormatGetGenericDefault (byval format as GpStringFormat ptr ptr) as GpStatus
declare function GdipStringFormatGetGenericTypographic (byval format as GpStringFormat ptr ptr) as GpStatus
declare function GdipDeleteStringFormat (byval format as GpStringFormat ptr) as GpStatus
declare function GdipCloneStringFormat (byval format as GpStringFormat ptr, byval newFormat as GpStringFormat ptr ptr) as GpStatus
declare function GdipSetStringFormatFlags (byval format as GpStringFormat ptr, byval flags as INT_) as GpStatus
declare function GdipGetStringFormatFlags (byval format as GpStringFormat ptr, byval flags as INT_ ptr) as GpStatus
declare function GdipSetStringFormatAlign (byval format as GpStringFormat ptr, byval align as StringAlignment) as GpStatus
declare function GdipGetStringFormatAlign (byval format as GpStringFormat ptr, byval align as StringAlignment ptr) as GpStatus
declare function GdipSetStringFormatLineAlign (byval format as GpStringFormat ptr, byval align as StringAlignment) as GpStatus
declare function GdipGetStringFormatLineAlign (byval format as GpStringFormat ptr, byval align as StringAlignment ptr) as GpStatus
declare function GdipSetStringFormatTrimming (byval format as GpStringFormat ptr, byval trimming as StringTrimming) as GpStatus
declare function GdipGetStringFormatTrimming (byval format as GpStringFormat ptr, byval trimming as StringTrimming ptr) as GpStatus
declare function GdipSetStringFormatHotkeyPrefix (byval format as GpStringFormat ptr, byval hotkeyPrefix as INT_) as GpStatus
declare function GdipGetStringFormatHotkeyPrefix (byval format as GpStringFormat ptr, byval hotkeyPrefix as INT_ ptr) as GpStatus
declare function GdipSetStringFormatTabStops (byval format as GpStringFormat ptr, byval firstTabOffset as REAL, byval count as INT_, byval tabStops as REAL ptr) as GpStatus
declare function GdipGetStringFormatTabStops (byval format as GpStringFormat ptr, byval count as INT_, byval firstTabOffset as REAL ptr, byval tabStops as REAL ptr) as GpStatus
declare function GdipGetStringFormatTabStopCount (byval format as GpStringFormat ptr, byval count as INT_ ptr) as GpStatus
declare function GdipSetStringFormatDigitSubstitution (byval format as GpStringFormat ptr, byval language as LANGID, byval substitute as StringDigitSubstitute) as GpStatus
declare function GdipGetStringFormatDigitSubstitution (byval format as GpStringFormat ptr, byval language as LANGID ptr, byval substitute as StringDigitSubstitute ptr) as GpStatus
declare function GdipGetStringFormatMeasurableCharacterRangeCount (byval format as GpStringFormat ptr, byval count as INT_ ptr) as GpStatus
declare function GdipSetStringFormatMeasurableCharacterRanges (byval format as GpStringFormat ptr, byval rangeCount as INT_, byval ranges as CharacterRange ptr) as GpStatus
declare function GdipCreateCachedBitmap (byval bitmap as GpBitmap ptr, byval graphics as GpGraphics ptr, byval cachedBitmap as GpCachedBitmap ptr ptr) as GpStatus
declare function GdipDeleteCachedBitmap (byval cachedBitmap as GpCachedBitmap ptr) as GpStatus
declare function GdipDrawCachedBitmap (byval graphics as GpGraphics ptr, byval cachedBitmap as GpCachedBitmap ptr, byval x as INT_, byval y as INT_) as GpStatus
declare function GdipEmfToWmfBits (byval hemf as HENHMETAFILE, byval cbData16 as UINT, byval pData16 as LPBYTE, byval iMapMode as INT_, byval eFlags as INT_) as UINT
declare function GdipSetImageAttributesCachedBackground (byval imageattr as GpImageAttributes ptr, byval enableFlag as BOOL) as GpStatus
declare function GdipTestControl (byval control as GpTestControlEnum, byval param as any ptr) as GpStatus
declare function GdiplusNotificationHook (byval token as ULONG_PTR ptr) as GpStatus
declare sub GdiplusNotificationUnhook (byval token as ULONG_PTR)
end extern

#ifdef UNICODE
declare function GdipCreateFontFromLogfont alias "GdipCreateFontFromLogfontW" (byval hdc as HDC, byval logfont as LOGFONTW ptr, byval font as GpFont ptr ptr) as GpStatus
declare function GdipGetLogFont alias "GdipGetLogFontW" (byval font as GpFont ptr, byval graphics as GpGraphics ptr, byval logfontW as LOGFONTW ptr) as GpStatus
#else
declare function GdipCreateFontFromLogfont alias "GdipCreateFontFromLogfontA" (byval hdc as HDC, byval logfont as LOGFONTA ptr, byval font as GpFont ptr ptr) as GpStatus
declare function GdipGetLogFont alias "GdipGetLogFontA" (byval font as GpFont ptr, byval graphics as GpGraphics ptr, byval logfontA as LOGFONTA ptr) as GpStatus
#endif

#endif
