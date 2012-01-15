#Ifndef __flexgridsizer_bi__
#Define __flexgridsizer_bi__

#Include Once "common.bi"

Declare Function wxFlexGridSizer_ctor WXCALL Alias "wxFlexGridSizer_ctor" (rows As wxInt, cols As wxInt, vgap As wxInt, hgap As wxInt) As wxFlexGridSizer Ptr
Declare Sub wxFlexGridSizer_dtor WXCALL Alias "wxFlexGridSizer_dtor" (self As wxFlexGridSizer Ptr)
Declare Sub wxFlexGridSizer_RecalcSizes WXCALL Alias "wxFlexGridSizer_RecalcSizes" (self As wxFlexGridSizer Ptr)
Declare Sub wxFlexGridSizer_CalcMin WXCALL Alias "wxFlexGridSizer_CalcMin" (self As wxFlexGridSizer Ptr, size As wxSize Ptr)
Declare Sub wxFlexGridSizer_AddGrowableRow WXCALL Alias "wxFlexGridSizer_AddGrowableRow" (self As wxFlexGridSizer Ptr, idx As size_t)
Declare Sub wxFlexGridSizer_RemoveGrowableRow WXCALL Alias "wxFlexGridSizer_RemoveGrowableRow" (self As wxFlexGridSizer Ptr, idx As size_t)
Declare Sub wxFlexGridSizer_AddGrowableCol WXCALL Alias "wxFlexGridSizer_AddGrowableCol" (self As wxFlexGridSizer Ptr, idx As size_t)
Declare Sub wxFlexGridSizer_RemoveGrowableCol WXCALL Alias "wxFlexGridSizer_RemoveGrowableCol" (self As wxFlexGridSizer Ptr, idx As size_t)

#EndIf ' __flexgridsizer_bi__

