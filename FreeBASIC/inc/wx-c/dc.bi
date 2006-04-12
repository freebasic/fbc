''
''
'' dc -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_dc_bi__
#define __wxc_dc_bi__

#include once "wx-c/wx.bi"

declare sub wxDC_dtor cdecl alias "wxDC_dtor" (byval dc as wxDC ptr)
declare sub wxDC_DrawBitmap cdecl alias "wxDC_DrawBitmap" (byval self as wxDC ptr, byval bmp as wxBitmap ptr, byval x as wxCoord, byval y as wxCoord, byval transparent as integer)
declare sub wxDC_DrawPolygon cdecl alias "wxDC_DrawPolygon" (byval self as wxDC ptr, byval n as integer, byval points as wxPoint ptr, byval xoffset as wxCoord, byval yoffset as wxCoord, byval fill_style as integer)
declare sub wxDC_DrawLine cdecl alias "wxDC_DrawLine" (byval self as wxDC ptr, byval x1 as wxCoord, byval y1 as wxCoord, byval x2 as wxCoord, byval y2 as wxCoord)
declare sub wxDC_DrawRectangle cdecl alias "wxDC_DrawRectangle" (byval self as wxDC ptr, byval x1 as wxCoord, byval y1 as wxCoord, byval x2 as wxCoord, byval y2 as wxCoord)
declare sub wxDC_DrawText cdecl alias "wxDC_DrawText" (byval self as wxDC ptr, byval text as zstring ptr, byval x as integer, byval y as integer)
declare sub wxDC_DrawEllipse cdecl alias "wxDC_DrawEllipse" (byval self as wxDC ptr, byval x as integer, byval y as integer, byval width as integer, byval height as integer)
declare sub wxDC_DrawPoint cdecl alias "wxDC_DrawPoint" (byval self as wxDC ptr, byval x as integer, byval y as integer)
declare sub wxDC_DrawRoundedRectangle cdecl alias "wxDC_DrawRoundedRectangle" (byval self as wxDC ptr, byval x as integer, byval y as integer, byval width as integer, byval height as integer, byval radius as double)
declare sub wxDC_SetBackgroundMode cdecl alias "wxDC_SetBackgroundMode" (byval self as wxDC ptr, byval mode as integer)
declare sub wxDC_SetBrush cdecl alias "wxDC_SetBrush" (byval self as wxDC ptr, byval brush as wxBrush ptr)
declare function wxDC_GetBrush cdecl alias "wxDC_GetBrush" (byval self as wxDC ptr) as wxBrush ptr
declare sub wxDC_SetBackground cdecl alias "wxDC_SetBackground" (byval self as wxDC ptr, byval brush as wxBrush ptr)
declare function wxDC_GetBackground cdecl alias "wxDC_GetBackground" (byval self as wxDC ptr) as wxBrush ptr
declare sub wxDC_SetPen cdecl alias "wxDC_SetPen" (byval self as wxDC ptr, byval pen as wxPen ptr)
declare function wxDC_GetPen cdecl alias "wxDC_GetPen" (byval self as wxDC ptr) as wxPen ptr
declare function wxDC_GetTextForeground cdecl alias "wxDC_GetTextForeground" (byval self as wxDC ptr) as wxColour ptr
declare sub wxDC_SetTextForeground cdecl alias "wxDC_SetTextForeground" (byval self as wxDC ptr, byval colour as wxColour ptr)
declare function wxDC_GetTextBackground cdecl alias "wxDC_GetTextBackground" (byval self as wxDC ptr) as wxColour ptr
declare sub wxDC_SetTextBackground cdecl alias "wxDC_SetTextBackground" (byval self as wxDC ptr, byval colour as wxColour ptr)
declare function wxDC_GetFont cdecl alias "wxDC_GetFont" (byval self as wxDC ptr) as wxFont ptr
declare sub wxDC_SetFont cdecl alias "wxDC_SetFont" (byval self as wxDC ptr, byval font as wxFont ptr)
declare sub wxDC_GetTextExtent cdecl alias "wxDC_GetTextExtent" (byval self as wxDC ptr, byval string as zstring ptr, byval x as integer ptr, byval y as integer ptr, byval descent as integer ptr, byval externalLeading as integer ptr, byval theFont as wxFont ptr)
declare sub wxDC_Clear cdecl alias "wxDC_Clear" (byval self as wxDC ptr)
declare sub wxDC_DestroyClippingRegion cdecl alias "wxDC_DestroyClippingRegion" (byval self as wxDC ptr)
declare sub wxDC_SetClippingRegion cdecl alias "wxDC_SetClippingRegion" (byval self as wxDC ptr, byval x as wxCoord, byval y as wxCoord, byval width as wxCoord, byval height as wxCoord)
declare sub wxDC_SetClippingRegionPos cdecl alias "wxDC_SetClippingRegionPos" (byval self as wxDC ptr, byval pos as wxPoint ptr, byval size as wxSize ptr)
declare sub wxDC_SetClippingRegionRect cdecl alias "wxDC_SetClippingRegionRect" (byval self as wxDC ptr, byval rect as wxRect ptr)
declare sub wxDC_SetClippingRegionReg cdecl alias "wxDC_SetClippingRegionReg" (byval self as wxDC ptr, byval reg as wxRegion ptr)
declare function wxDC_GetLogicalFunction cdecl alias "wxDC_GetLogicalFunction" (byval self as wxDC ptr) as integer
declare sub wxDC_SetLogicalFunction cdecl alias "wxDC_SetLogicalFunction" (byval self as wxDC ptr, byval function as integer)
declare sub wxDC_BeginDrawing cdecl alias "wxDC_BeginDrawing" (byval self as wxDC ptr)
declare function wxDC_Blit cdecl alias "wxDC_Blit" (byval self as wxDC ptr, byval xdest as wxCoord, byval ydest as wxCoord, byval width as wxCoord, byval height as wxCoord, byval source as wxDC ptr, byval xsrc as wxCoord, byval ysrc as wxCoord, byval rop as integer, byval useMask as integer, byval xsrcMask as wxCoord, byval ysrcMask as wxCoord) as integer
declare sub wxDC_EndDrawing cdecl alias "wxDC_EndDrawing" (byval self as wxDC ptr)
declare function wxDC_FloodFill cdecl alias "wxDC_FloodFill" (byval self as wxDC ptr, byval x as integer, byval y as integer, byval col as wxColour ptr, byval style as integer) as integer
declare function wxDC_GetPixel cdecl alias "wxDC_GetPixel" (byval self as wxDC ptr, byval x as integer, byval y as integer, byval col as wxColour ptr) as integer
declare sub wxDC_CrossHair cdecl alias "wxDC_CrossHair" (byval self as wxDC ptr, byval x as integer, byval y as integer)
declare sub wxDC_DrawArc cdecl alias "wxDC_DrawArc" (byval self as wxDC ptr, byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer, byval xc as integer, byval yc as integer)
declare sub wxDC_DrawCheckMark cdecl alias "wxDC_DrawCheckMark" (byval self as wxDC ptr, byval x as integer, byval y as integer, byval width as integer, byval height as integer)
declare sub wxDC_DrawEllipticArc cdecl alias "wxDC_DrawEllipticArc" (byval self as wxDC ptr, byval x as integer, byval y as integer, byval w as integer, byval h as integer, byval sa as double, byval ea as double)
declare sub wxDC_DrawLines cdecl alias "wxDC_DrawLines" (byval self as wxDC ptr, byval n as integer, byval points as wxPoint ptr, byval xoffset as integer, byval yoffset as integer)
declare sub wxDC_DrawCircle cdecl alias "wxDC_DrawCircle" (byval self as wxDC ptr, byval x as integer, byval y as integer, byval radius as integer)
declare sub wxDC_DrawIcon cdecl alias "wxDC_DrawIcon" (byval self as wxDC ptr, byval icon as wxIcon ptr, byval x as integer, byval y as integer)
declare sub wxDC_DrawRotatedText cdecl alias "wxDC_DrawRotatedText" (byval self as wxDC ptr, byval text as zstring ptr, byval x as integer, byval y as integer, byval angle as double)
declare sub wxDC_DrawLabel cdecl alias "wxDC_DrawLabel" (byval self as wxDC ptr, byval text as zstring ptr, byval image as wxBitmap ptr, byval rect as wxRect ptr, byval alignment as integer, byval indexAccel as integer, byval rectBounding as wxRect ptr)
declare sub wxDC_DrawLabel2 cdecl alias "wxDC_DrawLabel2" (byval self as wxDC ptr, byval text as zstring ptr, byval rect as wxRect ptr, byval alignment as integer, byval indexAccel as integer)
declare sub wxDC_DrawSpline cdecl alias "wxDC_DrawSpline" (byval self as wxDC ptr, byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer, byval x3 as integer, byval y3 as integer)
declare sub wxDC_DrawSpline2 cdecl alias "wxDC_DrawSpline2" (byval self as wxDC ptr, byval n as integer, byval points as wxPoint ptr)
declare function wxDC_StartDoc cdecl alias "wxDC_StartDoc" (byval self as wxDC ptr, byval message as zstring ptr) as integer
declare sub wxDC_EndDoc cdecl alias "wxDC_EndDoc" (byval self as wxDC ptr)
declare sub wxDC_StartPage cdecl alias "wxDC_StartPage" (byval self as wxDC ptr)
declare sub wxDC_EndPage cdecl alias "wxDC_EndPage" (byval self as wxDC ptr)
declare sub wxDC_GetClippingBox cdecl alias "wxDC_GetClippingBox" (byval self as wxDC ptr, byval x as integer ptr, byval y as integer ptr, byval w as integer ptr, byval h as integer ptr)
declare sub wxDC_GetClippingBox2 cdecl alias "wxDC_GetClippingBox2" (byval self as wxDC ptr, byval rect as wxRect ptr)
declare sub wxDC_GetMultiLineTextExtent cdecl alias "wxDC_GetMultiLineTextExtent" (byval self as wxDC ptr, byval text as zstring ptr, byval width as integer ptr, byval height as integer ptr, byval heightLine as integer ptr, byval font as wxFont ptr)
declare function wxDC_GetPartialTextExtents cdecl alias "wxDC_GetPartialTextExtents" (byval self as wxDC ptr, byval text as zstring ptr, byval widths as wxArrayInt ptr) as integer
declare sub wxDC_GetSize cdecl alias "wxDC_GetSize" (byval self as wxDC ptr, byval width as integer ptr, byval height as integer ptr)
declare sub wxDC_GetSize2 cdecl alias "wxDC_GetSize2" (byval self as wxDC ptr, byval size as wxSize ptr)
declare sub wxDC_GetSizeMM cdecl alias "wxDC_GetSizeMM" (byval self as wxDC ptr, byval width as integer ptr, byval height as integer ptr)
declare sub wxDC_GetSizeMM2 cdecl alias "wxDC_GetSizeMM2" (byval self as wxDC ptr, byval size as wxSize ptr)
declare function wxDC_DeviceToLogicalX cdecl alias "wxDC_DeviceToLogicalX" (byval self as wxDC ptr, byval x as integer) as integer
declare function wxDC_DeviceToLogicalY cdecl alias "wxDC_DeviceToLogicalY" (byval self as wxDC ptr, byval y as integer) as integer
declare function wxDC_DeviceToLogicalXRel cdecl alias "wxDC_DeviceToLogicalXRel" (byval self as wxDC ptr, byval x as integer) as integer
declare function wxDC_DeviceToLogicalYRel cdecl alias "wxDC_DeviceToLogicalYRel" (byval self as wxDC ptr, byval y as integer) as integer
declare function wxDC_LogicalToDeviceX cdecl alias "wxDC_LogicalToDeviceX" (byval self as wxDC ptr, byval x as integer) as integer
declare function wxDC_LogicalToDeviceY cdecl alias "wxDC_LogicalToDeviceY" (byval self as wxDC ptr, byval y as integer) as integer
declare function wxDC_LogicalToDeviceXRel cdecl alias "wxDC_LogicalToDeviceXRel" (byval self as wxDC ptr, byval x as integer) as integer
declare function wxDC_LogicalToDeviceYRel cdecl alias "wxDC_LogicalToDeviceYRel" (byval self as wxDC ptr, byval y as integer) as integer
declare function wxDC_Ok cdecl alias "wxDC_Ok" (byval self as wxDC ptr) as integer
declare function wxDC_GetBackgroundMode cdecl alias "wxDC_GetBackgroundMode" (byval self as wxDC ptr) as integer
declare function wxDC_GetMapMode cdecl alias "wxDC_GetMapMode" (byval self as wxDC ptr) as integer
declare sub wxDC_SetMapMode cdecl alias "wxDC_SetMapMode" (byval self as wxDC ptr, byval mode as integer)
declare sub wxDC_GetUserScale cdecl alias "wxDC_GetUserScale" (byval self as wxDC ptr, byval x as double ptr, byval y as double ptr)
declare sub wxDC_SetUserScale cdecl alias "wxDC_SetUserScale" (byval self as wxDC ptr, byval x as double, byval y as double)
declare sub wxDC_GetLogicalScale cdecl alias "wxDC_GetLogicalScale" (byval self as wxDC ptr, byval x as double ptr, byval y as double ptr)
declare sub wxDC_SetLogicalScale cdecl alias "wxDC_SetLogicalScale" (byval self as wxDC ptr, byval x as double, byval y as double)
declare sub wxDC_GetLogicalOrigin cdecl alias "wxDC_GetLogicalOrigin" (byval self as wxDC ptr, byval x as integer ptr, byval y as integer ptr)
declare sub wxDC_GetLogicalOrigin2 cdecl alias "wxDC_GetLogicalOrigin2" (byval self as wxDC ptr, byval pt as wxPoint ptr)
declare sub wxDC_SetLogicalOrigin cdecl alias "wxDC_SetLogicalOrigin" (byval self as wxDC ptr, byval x as integer, byval y as integer)
declare sub wxDC_GetDeviceOrigin cdecl alias "wxDC_GetDeviceOrigin" (byval self as wxDC ptr, byval x as integer ptr, byval y as integer ptr)
declare sub wxDC_GetDeviceOrigin2 cdecl alias "wxDC_GetDeviceOrigin2" (byval self as wxDC ptr, byval pt as wxPoint ptr)
declare sub wxDC_SetDeviceOrigin cdecl alias "wxDC_SetDeviceOrigin" (byval self as wxDC ptr, byval x as integer, byval y as integer)
declare sub wxDC_SetAxisOrientation cdecl alias "wxDC_SetAxisOrientation" (byval self as wxDC ptr, byval xLeftRight as integer, byval yBottomUp as integer)
declare sub wxDC_CalcBoundingBox cdecl alias "wxDC_CalcBoundingBox" (byval self as wxDC ptr, byval x as integer, byval y as integer)
declare sub wxDC_ResetBoundingBox cdecl alias "wxDC_ResetBoundingBox" (byval self as wxDC ptr)
declare function wxDC_MinX cdecl alias "wxDC_MinX" (byval self as wxDC ptr) as integer
declare function wxDC_MaxX cdecl alias "wxDC_MaxX" (byval self as wxDC ptr) as integer
declare function wxDC_MinY cdecl alias "wxDC_MinY" (byval self as wxDC ptr) as integer
declare function wxDC_MaxY cdecl alias "wxDC_MaxY" (byval self as wxDC ptr) as integer
declare function wxWindowDC cdecl alias "wxWindowDC_ctor" () as wxWindowDC ptr
declare function wxWindowDC_ctor2 cdecl alias "wxWindowDC_ctor2" (byval win as wxWindow ptr) as wxWindowDC ptr
declare function wxWindowDC_CanDrawBitmap cdecl alias "wxWindowDC_CanDrawBitmap" (byval self as wxWindowDC ptr) as integer
declare function wxWindowDC_CanGetTextExtent cdecl alias "wxWindowDC_CanGetTextExtent" (byval self as wxWindowDC ptr) as integer
declare function wxWindowDC_GetCharWidth cdecl alias "wxWindowDC_GetCharWidth" (byval self as wxWindowDC ptr) as integer
declare function wxWindowDC_GetCharHeight cdecl alias "wxWindowDC_GetCharHeight" (byval self as wxWindowDC ptr) as integer
declare sub wxWindowDC_Clear cdecl alias "wxWindowDC_Clear" (byval self as wxWindowDC ptr)
declare sub wxWindowDC_SetFont cdecl alias "wxWindowDC_SetFont" (byval self as wxWindowDC ptr, byval font as wxFont ptr)
declare function wxWindowDC_GetFont cdecl alias "wxWindowDC_GetFont" (byval self as wxDCBase ptr) as wxFont ptr
declare sub wxWindowDC_SetPen cdecl alias "wxWindowDC_SetPen" (byval self as wxWindowDC ptr, byval pen as wxPen ptr)
declare function wxWindowDC_GetPen cdecl alias "wxWindowDC_GetPen" (byval self as wxWindowDC ptr) as wxPen ptr
declare sub wxWindowDC_SetBrush cdecl alias "wxWindowDC_SetBrush" (byval self as wxWindowDC ptr, byval brush as wxBrush ptr)
declare sub wxWindowDC_SetBackground cdecl alias "wxWindowDC_SetBackground" (byval self as wxWindowDC ptr, byval brush as wxBrush ptr)
declare function wxWindowDC_GetBackground cdecl alias "wxWindowDC_GetBackground" (byval self as wxDCBase ptr) as wxBrush ptr
declare sub wxWindowDC_SetLogicalFunction cdecl alias "wxWindowDC_SetLogicalFunction" (byval self as wxWindowDC ptr, byval function as integer)
declare sub wxWindowDC_SetTextForeground cdecl alias "wxWindowDC_SetTextForeground" (byval self as wxWindowDC ptr, byval colour as wxColour ptr)
declare function wxWindowDC_GetTextForeground cdecl alias "wxWindowDC_GetTextForeground" (byval self as wxDCBase ptr) as wxColour ptr
declare sub wxWindowDC_SetTextBackground cdecl alias "wxWindowDC_SetTextBackground" (byval self as wxWindowDC ptr, byval colour as wxColour ptr)
declare sub wxWindowDC_SetBackgroundMode cdecl alias "wxWindowDC_SetBackgroundMode" (byval self as wxWindowDC ptr, byval mode as integer)
declare function wxWindowDC_GetBackgroundMode cdecl alias "wxWindowDC_GetBackgroundMode" (byval self as wxDCBase ptr) as integer
declare sub wxWindowDC_SetPalette cdecl alias "wxWindowDC_SetPalette" (byval self as wxWindowDC ptr, byval palette as wxPalette ptr)
declare sub wxWindowDC_GetPPI cdecl alias "wxWindowDC_GetPPI" (byval self as wxWindowDC ptr, byval size as wxSize ptr)
declare function wxWindowDC_GetDepth cdecl alias "wxWindowDC_GetDepth" (byval self as wxWindowDC ptr) as integer
declare function wxClientDC cdecl alias "wxClientDC_ctor" () as wxClientDC ptr
declare function wxClientDC_ctor2 cdecl alias "wxClientDC_ctor2" (byval win as wxWindow ptr) as wxClientDC ptr
declare function wxPaintDC cdecl alias "wxPaintDC_ctor" () as wxPaintDC ptr
declare function wxPaintDC_ctor2 cdecl alias "wxPaintDC_ctor2" (byval window as wxWindow ptr) as wxPaintDC ptr

#endif
