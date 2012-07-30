#Ifndef __dc_bi__
#Define __dc_bi__

#Include Once "common.bi"

' class wxDC
Declare Sub wxDC_dtor WXCALL Alias "wxDC_dtor" (self As wxDC Ptr)
Declare Function wxDC_Ok WXCALL Alias "wxDC_Ok" (self As wxDC Ptr) As wxBool
Declare Sub wxDC_DrawBitmap WXCALL Alias "wxDC_DrawBitmap" (self As wxDC Ptr, bitmap As wxBitmap Ptr, x As wxCoord, y As wxCoord, transp As wxBool)
Declare Sub wxDC_DrawPolygon WXCALL Alias "wxDC_DrawPolygon" (self As wxDC Ptr, n As wxInt, pPonts As wxPoint Ptr, xoffset As wxCoord, yoffset As wxCoord, fill_style As wxPolygonFillStyle)
Declare Sub wxDC_DrawLine WXCALL Alias "wxDC_DrawLine" (self As wxDC Ptr, x1 As wxCoord, y1 As wxCoord, x2 As wxCoord, y2 As wxCoord)
Declare Sub wxDC_DrawRectangle WXCALL Alias "wxDC_DrawRectangle" (self As wxDC Ptr, x1 As wxCoord, y1 As wxCoord, x2 As wxCoord, y2 As wxCoord)
Declare Sub wxDC_DrawText WXCALL Alias "wxDC_DrawText" (self As wxDC Ptr, txt As wxString Ptr, x As wxInt, y As wxInt)
Declare Sub wxDC_DrawEllipse WXCALL Alias "wxDC_DrawEllipse" (self As wxDC Ptr, x As wxInt, y As wxInt, w As wxInt, h As wxInt)
Declare Sub wxDC_DrawPoint WXCALL Alias "wxDC_DrawPoint" (self As wxDC Ptr, x As wxInt, y As wxInt)
Declare Sub wxDC_DrawRoundedRectangle WXCALL Alias "wxDC_DrawRoundedRectangle" (self As wxDC Ptr, x As wxInt, y As wxInt, w As wxInt, h As wxInt, radius As wxDouble)
Declare Sub wxDC_SetBackgroundMode WXCALL Alias "wxDC_SetBackgroundMode" (self As wxDC Ptr, mode As wxBackgroundMode)
Declare Sub wxDC_SetBrush WXCALL Alias "wxDC_SetBrush" (self As wxDC Ptr, brush As wxBrush Ptr)
Declare Function wxDC_GetBrush WXCALL Alias "wxDC_GetBrush" (self As wxDC Ptr) As wxBrush Ptr
Declare Sub wxDC_SetBackground WXCALL Alias "wxDC_SetBackground" (self As wxDC Ptr, brush As wxBrush Ptr)
Declare Function wxDC_GetBackground WXCALL Alias "wxDC_GetBackground" (self As wxDC Ptr) As wxBrush Ptr
Declare Sub wxDC_SetPen WXCALL Alias "wxDC_SetPen" (self As wxDC Ptr, pen As wxPen Ptr)
Declare Function wxDC_GetPen WXCALL Alias "wxDC_GetPen" (self As wxDC Ptr) As wxPen Ptr
Declare Function wxDC_GetTextForeground WXCALL Alias "wxDC_GetTextForeground" (self As wxDC Ptr) As wxColour Ptr
Declare Sub wxDC_SetTextForeground WXCALL Alias "wxDC_SetTextForeground" (self As wxDC Ptr, col As wxColour Ptr)
Declare Function wxDC_GetTextBackground WXCALL Alias "wxDC_GetTextBackground" (self As wxDC Ptr) As wxColour Ptr
Declare Sub wxDC_SetTextBackground WXCALL Alias "wxDC_SetTextBackground" (self As wxDC Ptr, col As wxColour Ptr)
Declare Function wxDC_GetFont WXCALL Alias "wxDC_GetFont" (self As wxDC Ptr) As wxFont Ptr
Declare Sub wxDC_SetFont WXCALL Alias "wxDC_SetFont" (self As wxDC Ptr, font As wxFont Ptr)
Declare Sub wxDC_GetTextExtent WXCALL Alias "wxDC_GetTextExtent" (self As wxDC Ptr, txt As wxString Ptr, x As wxInt Ptr, y As wxInt Ptr, descent As wxInt Ptr, externalLeading As wxInt Ptr, font As wxFont Ptr)
Declare Sub wxDC_Clear WXCALL Alias "wxDC_Clear" (self As wxDC Ptr)
Declare Sub wxDC_DestroyClippingRegion WXCALL Alias "wxDC_DestroyClippingRegion" (self As wxDC Ptr)
Declare Sub wxDC_SetClippingRegion WXCALL Alias "wxDC_SetClippingRegion" (self As wxDC Ptr, x As wxCoord, y As wxCoord, w As wxCoord, h As wxCoord)
Declare Sub wxDC_SetClippingRegionPos WXCALL Alias "wxDC_SetClippingRegionPos" (self As wxDC Ptr, p As wxPoint Ptr, s As wxSize Ptr)
Declare Sub wxDC_SetClippingRegionRect WXCALL Alias "wxDC_SetClippingRegionRect" (self As wxDC Ptr, r As wxRect Ptr)
Declare Sub wxDC_SetClippingRegionReg WXCALL Alias "wxDC_SetClippingRegionReg" (self As wxDC Ptr, reg As wxRegion Ptr)
Declare Function wxDC_GetLogicalFunction WXCALL Alias "wxDC_GetLogicalFunction" (self As wxDC Ptr) As wxRASTEROPS
Declare Sub wxDC_SetLogicalFunction WXCALL Alias "wxDC_SetLogicalFunction" (self As wxDC Ptr, func As wxRASTEROPS)
Declare Function wxDC_Blit WXCALL Alias "wxDC_Blit" ( _
			   self As wxDC Ptr, xdes As wxCoord, ydes As wxCoord, w As wxCoord, h As wxCoord, _
               src  As wxDC Ptr, xsrc As wxCoord, ysrc As wxCoord, rop As wxInt, _
               useMask As wxBool, xsrcMask As wxCoord, ysrcMask As wxCoord) As wxBool
Declare Function wxDC_FloodFill WXCALL Alias "wxDC_FloodFill" (self As wxDC Ptr, x As wxInt, y As wxInt, col As wxColour Ptr, style As wxFloodStyle) As wxBool
Declare Function wxDC_GetPixel WXCALL Alias "wxDC_GetPixel" (self As wxDC Ptr, x As wxInt, y As wxInt, col As wxColour Ptr) As wxBool
Declare Sub wxDC_CrossHair WXCALL Alias "wxDC_CrossHair" (self As wxDC Ptr, x As wxInt, y As wxInt)
Declare Sub wxDC_DrawArc WXCALL Alias "wxDC_DrawArc" (self As wxDC Ptr, x1 As wxInt, y1 As wxInt, x2 As wxInt, y2 As wxInt, xc As wxInt, yc As wxInt)
Declare Sub wxDC_DrawCheckMark WXCALL Alias "wxDC_DrawCheckMark" (self As wxDC Ptr, x As wxInt, y As wxInt, w As wxInt, h As wxInt)
Declare Sub wxDC_DrawEllipticArc WXCALL Alias "wxDC_DrawEllipticArc" (self As wxDC Ptr, x As wxInt, y As wxInt, w As wxInt, h As wxInt, sa As wxDouble, ea As wxDouble)
Declare Sub wxDC_DrawLines WXCALL Alias "wxDC_DrawLines" (self As wxDC Ptr, n As wxInt, pPoints As wxPoint Ptr, xoffset As wxInt, yoffset As wxInt)
Declare Sub wxDC_DrawCircle WXCALL Alias "wxDC_DrawCircle" (self As wxDC Ptr, x As wxInt, y As wxInt, radius As wxInt)
Declare Sub wxDC_DrawIcon WXCALL Alias "wxDC_DrawIcon" (self As wxDC Ptr, icon As wxIcon Ptr, x As wxInt, y As wxInt)
Declare Sub wxDC_DrawRotatedText WXCALL Alias "wxDC_DrawRotatedText" (self As wxDC Ptr, txt As wxString Ptr, x As wxInt, y As wxInt, angle As wxDouble)
Declare Sub wxDC_DrawLabel WXCALL Alias "wxDC_DrawLabel" (self As wxDC Ptr, txt As wxString Ptr, bitmap As wxBitmap Ptr, r As wxRect Ptr, alignment As wxInt, indexAccel As wxInt, bounding As wxRect Ptr)
Declare Sub wxDC_DrawLabel2 WXCALL Alias "wxDC_DrawLabel2" (self As wxDC Ptr, txt As wxString Ptr, r As wxRect Ptr, alignment As wxInt, indexAccel As wxInt)
Declare Sub wxDC_DrawSpline WXCALL Alias "wxDC_DrawSpline" (self As wxDC Ptr, x1 As wxInt, y1 As wxInt, x2 As wxInt, y2 As wxInt, x3 As wxInt, y3 As wxInt)
Declare Sub wxDC_DrawSpline2 WXCALL Alias "wxDC_DrawSpline2" (self As wxDC Ptr, n As wxInt, pPoints As wxPoint Ptr)
Declare Sub wxDC_GetClippingBox WXCALL Alias "wxDC_GetClippingBox" (self As wxDC Ptr, x As wxInt Ptr, y As wxInt Ptr, w As wxInt Ptr, h As wxInt Ptr)
Declare Sub wxDC_GetClippingBox2 WXCALL Alias "wxDC_GetClippingBox2" (self As wxDC Ptr, r As wxRect Ptr)
Declare Sub wxDC_GetMultiLineTextExtent WXCALL Alias "wxDC_GetMultiLineTextExtent" (self As wxDC Ptr, txt As wxString Ptr, w As wxInt Ptr, h As wxInt Ptr, heightLine As wxInt Ptr, font As wxFont Ptr)
Declare Function wxDC_GetPartialTextExtents WXCALL Alias "wxDC_GetPartialTextExtents" (self As wxDC Ptr, txt As wxString Ptr, pWidth As wxArrayInt Ptr) As wxBool
Declare Sub wxDC_GetSize WXCALL Alias "wxDC_GetSize" (self As wxDC Ptr, w As wxInt Ptr, h As wxInt Ptr)
Declare Sub wxDC_GetSize2 WXCALL Alias "wxDC_GetSize2" (self As wxDC Ptr, s As wxSize Ptr)
Declare Sub wxDC_GetSizeMM WXCALL Alias "wxDC_GetSizeMM" (self As wxDC Ptr, w As wxInt Ptr, h As wxInt Ptr)
Declare Sub wxDC_GetSizeMM2 WXCALL Alias "wxDC_GetSizeMM2" (self As wxDC Ptr, s As wxSize Ptr)
Declare Function wxDC_DeviceToLogicalX WXCALL Alias "wxDC_DeviceToLogicalX" (self As wxDC Ptr, x As wxInt) As wxInt
Declare Function wxDC_DeviceToLogicalY WXCALL Alias "wxDC_DeviceToLogicalY" (self As wxDC Ptr, y As wxInt) As wxInt
Declare Function wxDC_DeviceToLogicalXRel WXCALL Alias "wxDC_DeviceToLogicalXRel" (self As wxDC Ptr, x As wxInt) As wxInt
Declare Function wxDC_DeviceToLogicalYRel WXCALL Alias "wxDC_DeviceToLogicalYRel" (self As wxDC Ptr, y As wxInt) As wxInt
Declare Function wxDC_LogicalToDeviceX WXCALL Alias "wxDC_LogicalToDeviceX" (self As wxDC Ptr, x As wxInt) As wxInt
Declare Function wxDC_LogicalToDeviceY WXCALL Alias "wxDC_LogicalToDeviceY" (self As wxDC Ptr, y As wxInt) As wxInt
Declare Function wxDC_LogicalToDeviceXRel WXCALL Alias "wxDC_LogicalToDeviceXRel" (self As wxDC Ptr, x As wxInt) As wxInt
Declare Function wxDC_LogicalToDeviceYRel WXCALL Alias "wxDC_LogicalToDeviceYRel" (self As wxDC Ptr, y As wxInt) As wxInt
Declare Function wxDC_GetBackgroundMode WXCALL Alias "wxDC_GetBackgroundMode" (self As wxDC Ptr) As wxBackgroundMode
Declare Function wxDC_GetMapMode WXCALL Alias "wxDC_GetMapMode" (self As wxDC Ptr) As wxMappingMode
Declare Sub wxDC_SetMapMode WXCALL Alias "wxDC_SetMapMode" (self As wxDC Ptr, mode As wxMappingMode)
Declare Sub wxDC_GetUserScale WXCALL Alias "wxDC_GetUserScale" (self As wxDC Ptr, x As wxDouble Ptr, y As wxDouble Ptr)
Declare Sub wxDC_SetUserScale WXCALL Alias "wxDC_SetUserScale" (self As wxDC Ptr, x As wxDouble, y As wxDouble)
Declare Sub wxDC_GetLogicalScale WXCALL Alias "wxDC_GetLogicalScale" (self As wxDC Ptr, x As wxDouble Ptr, y As wxDouble Ptr)
Declare Sub wxDC_SetLogicalScale WXCALL Alias "wxDC_SetLogicalScale" (self As wxDC Ptr, x As wxDouble, y As wxDouble)
Declare Sub wxDC_GetLogicalOrigin WXCALL Alias "wxDC_GetLogicalOrigin" (self As wxDC Ptr, x As wxInt Ptr, y As wxInt Ptr)
Declare Sub wxDC_GetLogicalOrigin2 WXCALL Alias "wxDC_GetLogicalOrigin2" (self As wxDC Ptr, p As wxPoint Ptr)
Declare Sub wxDC_SetLogicalOrigin WXCALL Alias "wxDC_SetLogicalOrigin" (self As wxDC Ptr, x As wxInt, y As wxInt)
Declare Sub wxDC_GetDeviceOrigin WXCALL Alias "wxDC_GetDeviceOrigin" (self As wxDC Ptr, x As wxInt Ptr, y As wxInt Ptr)
Declare Sub wxDC_GetDeviceOrigin2 WXCALL Alias "wxDC_GetDeviceOrigin2" (self As wxDC Ptr, p As wxPoint Ptr)
Declare Sub wxDC_SetDeviceOrigin WXCALL Alias "wxDC_SetDeviceOrigin" (self As wxDC Ptr, x As wxInt, y As wxInt)
Declare Sub wxDC_SetAxisOrientation WXCALL Alias "wxDC_SetAxisOrientation" (self As wxDC Ptr, xLeftRight As wxBool, yBottomUp As wxBool)
Declare Sub wxDC_CalcBoundingBox WXCALL Alias "wxDC_CalcBoundingBox" (self As wxDC Ptr, x As wxInt, y As wxInt)
Declare Sub wxDC_ResetBoundingBox WXCALL Alias "wxDC_ResetBoundingBox" (self As wxDC Ptr)
Declare Function wxDC_MinX WXCALL Alias "wxDC_MinX" (self As wxDC Ptr) As wxInt
Declare Function wxDC_MaxX WXCALL Alias "wxDC_MaxX" (self As wxDC Ptr) As wxInt
Declare Function wxDC_MinY WXCALL Alias "wxDC_MinY" (self As wxDC Ptr) As wxInt
Declare Function wxDC_MaxY WXCALL Alias "wxDC_MaxY" (self As wxDC Ptr) As wxInt

' printer
Declare Function wxDC_StartDoc WXCALL Alias "wxDC_StartDoc" (self As wxDC Ptr, txt As wxString Ptr) As wxBool
Declare Sub wxDC_EndDoc WXCALL Alias "wxDC_EndDoc" (self As wxDC Ptr)
Declare Sub wxDC_StartPage WXCALL Alias "wxDC_StartPage" (self As wxDC Ptr)
Declare Sub wxDC_EndPage WXCALL Alias "wxDC_EndPage" (self As wxDC Ptr)

' class wxWindowDC
Declare Function wxWindowDC_ctor WXCALL Alias "wxWindowDC_ctor" () As wxWindowDC Ptr
Declare Function wxWindowDC_ctor2 WXCALL Alias "wxWindowDC_ctor2" (win As wxWindow Ptr) As wxWindowDC Ptr
Declare Function wxWindowDC_CanDrawBitmap WXCALL Alias "wxWindowDC_CanDrawBitmap" (self As wxWindowDC Ptr) As wxBool
Declare Function wxWindowDC_CanGetTextExtent WXCALL Alias "wxWindowDC_CanGetTextExtent" (self As wxWindowDC Ptr) As wxBool
Declare Function wxWindowDC_GetCharWidth WXCALL Alias "wxWindowDC_GetCharWidth" (self As wxWindowDC Ptr) As wxInt
Declare Function wxWindowDC_GetCharHeight WXCALL Alias "wxWindowDC_GetCharHeight" (self As wxWindowDC Ptr) As wxInt
Declare Sub wxWindowDC_Clear WXCALL Alias "wxWindowDC_Clear" (self As wxWindowDC Ptr)
Declare Sub wxWindowDC_SetFont WXCALL Alias "wxWindowDC_SetFont" (self As wxWindowDC Ptr, font As wxFont Ptr)

' !!! wxDCBase
Declare Function wxWindowDC_GetFont WXCALL Alias "wxWindowDC_GetFont" (self As wxWindowDC Ptr) As wxFont Ptr
Declare Function wxWindowDC_GetBackground WXCALL Alias "wxWindowDC_GetBackground" (self As wxWindowDC Ptr) As wxBrush Ptr
Declare Function wxWindowDC_GetTextForeground WXCALL Alias "wxWindowDC_GetTextForeground" (self As wxWindowDC Ptr) As wxColour Ptr
Declare Function wxWindowDC_GetBackgroundMode WXCALL Alias "wxWindowDC_GetBackgroundMode" (self As wxWindowDC Ptr) As wxBackGroundMode
Declare Sub wxWindowDC_SetPen WXCALL Alias "wxWindowDC_SetPen" (self As wxWindowDC Ptr, pen As wxPen Ptr)
Declare Function wxWindowDC_GetPen WXCALL Alias "wxWindowDC_GetPen" (self As wxWindowDC Ptr) As wxPen Ptr
Declare Sub wxWindowDC_SetBrush WXCALL Alias "wxWindowDC_SetBrush" (self As wxWindowDC Ptr, brush As wxBrush Ptr)
Declare Sub wxWindowDC_SetBackground WXCALL Alias "wxWindowDC_SetBackground" (self As wxWindowDC Ptr, brush As wxBrush Ptr)
Declare Sub wxWindowDC_SetLogicalFunction WXCALL Alias "wxWindowDC_SetLogicalFunction" (self As wxWindowDC Ptr, func As wxRASTEROPS)
Declare Sub wxWindowDC_SetTextForeground WXCALL Alias "wxWindowDC_SetTextForeground" (self As wxWindowDC Ptr, col As wxColour Ptr)
Declare Sub wxWindowDC_SetTextBackground WXCALL Alias "wxWindowDC_SetTextBackground" (self As wxWindowDC Ptr, col As wxColour Ptr)
Declare Sub wxWindowDC_SetBackgroundMode WXCALL Alias "wxWindowDC_SetBackgroundMode" (self As wxWindowDC Ptr, mode As wxBackGroundMode)
Declare Sub wxWindowDC_SetPalette WXCALL Alias "wxWindowDC_SetPalette" (self As wxWindowDC Ptr, pal As wxPalette Ptr)
Declare Sub wxWindowDC_GetPPI WXCALL Alias "wxWindowDC_GetPPI" (self As wxWindowDC Ptr, s As wxSize Ptr)
Declare Function wxWindowDC_GetDepth WXCALL Alias "wxWindowDC_GetDepth" (self As wxWindowDC Ptr) As wxInt

' class wxClientDC
Declare Function wxClientDC_ctor WXCALL Alias "wxClientDC_ctor" () As wxClientDC Ptr
Declare Function wxClientDC_ctor2 WXCALL Alias "wxClientDC_ctor2" (win As wxWindow Ptr) As wxClientDC Ptr

' class wxPaintDC
Declare Function wxPaintDC_ctor WXCALL Alias "wxPaintDC_ctor" () As wxPaintDC Ptr
Declare Function wxPaintDC_ctor2 WXCALL Alias "wxPaintDC_ctor2" (win As wxWindow Ptr) As wxPaintDC Ptr

#EndIf ' __dc_bi__

