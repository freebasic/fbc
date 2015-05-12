#Ifndef __gridsizer_bi__
#Define __gridsizer_bi__

#Include Once "common.bi"

Declare Function wxGridSizer_ctor WXCALL Alias "wxGridSizer_ctor" (rows As wxInt, cols As wxInt, vgap As wxInt, hgap As wxInt) As wxGridSizer Ptr
Declare Sub wxGridSizer_RecalcSizes WXCALL Alias "wxGridSizer_RecalcSizes" (self As wxGridSizer Ptr)
Declare Sub wxGridSizer_CalcMin WXCALL Alias "wxGridSizer_CalcMin" (self As wxGridSizer Ptr, size As wxSize Ptr)
Declare Sub wxGridSizer_SetCols WXCALL Alias "wxGridSizer_SetCols" (self As wxGridSizer Ptr, cols As wxInt)
Declare Function wxGridSizer_GetCols WXCALL Alias "wxGridSizer_GetCols" (self As wxGridSizer Ptr) As wxInt
Declare Sub wxGridSizer_SetRows WXCALL Alias "wxGridSizer_SetRows" (self As wxGridSizer Ptr, rows As wxInt)
Declare Function wxGridSizer_GetRows WXCALL Alias "wxGridSizer_GetRows" (self As wxGridSizer Ptr) As wxInt
Declare Sub wxGridSizer_SetVGap WXCALL Alias "wxGridSizer_SetVGap" (self As wxGridSizer Ptr, vgap As wxInt)
Declare Function wxGridSizer_GetVGap WXCALL Alias "wxGridSizer_GetVGap" (self As wxGridSizer Ptr) As wxInt
Declare Sub wxGridSizer_SetHGap WXCALL Alias "wxGridSizer_SetHGap" (self As wxGridSizer Ptr, hgap As wxInt)
Declare Function wxGridSizer_GetHGap WXCALL Alias "wxGridSizer_GetHGap" (self As wxGridSizer Ptr) As wxInt

#EndIf ' __gridsizer_bi__

