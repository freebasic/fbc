#Ifndef __gridctrl_bi__
#Define __gridctrl_bi__



#Include Once "common.bi"


' class wxGridCellDateTimeRenderer
Declare Function wxGridCellDateTimeRenderer_ctor WXCALL Alias "wxGridCellDateTimeRenderer_ctor" (ofmt As wxString Ptr, ifmt As wxString Ptr) As wxGridCellDateTimeRenderer Ptr
Declare Sub wxGridCellDateTimeRenderer_dtor WXCALL Alias "wxGridCellDateTimeRenderer_dtor" (self As wxGridCellDateTimeRenderer Ptr)
Declare Sub wxGridCellDateTimeRenderer_Draw WXCALL Alias "wxGridCellDateTimeRenderer_Draw" (self As wxGridCellDateTimeRenderer Ptr, grid As wxGrid Ptr, attr As wxGridCellAttr Ptr, dc As wxDC Ptr, r As wxRect Ptr, row As wxInt, col As wxInt, IsSelected As wxBool)
Declare Sub wxGridCellDateTimeRenderer_GetBestSize WXCALL Alias "wxGridCellDateTimeRenderer_GetBestSize" (self As wxGridCellDateTimeRenderer Ptr, grid As wxGrid Ptr, attr As wxGridCellAttr Ptr, dc As wxDC Ptr, row As wxInt, col As wxInt, size As wxSize Ptr)
Declare Function wxGridCellDateTimeRenderer_Clone WXCALL Alias "wxGridCellDateTimeRenderer_Clone" (self As wxGridCellDateTimeRenderer Ptr) As wxGridCellRenderer Ptr 
Declare Sub wxGridCellDateTimeRenderer_SetParameters WXCALL Alias "wxGridCellDateTimeRenderer_SetParameters" (self As wxGridCellDateTimeRenderer Ptr, params As wxString Ptr)

' class wxGridCellEnumRenderer
Declare Function wxGridCellEnumRenderer_ctor WXCALL Alias "wxGridCellEnumRenderer_ctor" (choices As wxString Ptr) As wxGridCellEnumRenderer Ptr
Declare Sub wxGridCellEnumRenderer_dtor WXCALL Alias "wxGridCellEnumRenderer_dtor" (self As wxGridCellEnumRenderer Ptr)
Declare Sub wxGridCellEnumRenderer_Draw WXCALL Alias "wxGridCellEnumRenderer_Draw" (self As wxGridCellEnumRenderer Ptr, grid As wxGrid Ptr, attr As wxGridCellAttr Ptr, dc As wxDC Ptr, r As wxRect Ptr, row As wxInt, col As wxInt, IsSelected As wxBool)
Declare Sub wxGridCellEnumRenderer_GetBestSize WXCALL Alias "wxGridCellEnumRenderer_GetBestSize" (self As wxGridCellEnumRenderer Ptr, grid As wxGrid Ptr, attr As wxGridCellAttr Ptr, dc As wxDC Ptr, row As wxInt, col As wxInt, size As wxSize Ptr)
Declare Function wxGridCellEnumRenderer_Clone WXCALL Alias "wxGridCellEnumRenderer_Clone" (self As wxGridCellEnumRenderer Ptr) As wxGridCellRenderer Ptr
Declare Sub wxGridCellEnumRenderer_SetParameters WXCALL Alias "wxGridCellEnumRenderer_SetParameters" (self As wxGridCellEnumRenderer Ptr, params As wxString Ptr)


' class wxGridCellAutoWrapStringRenderer
Declare Function wxGridCellAutoWrapStringRenderer_ctor WXCALL Alias "wxGridCellAutoWrapStringRenderer_ctor" () As wxGridCellAutoWrapStringRenderer Ptr
Declare Sub wxGridCellAutoWrapStringRenderer_dtor WXCALL Alias "wxGridCellAutoWrapStringRenderer_dtor" (self As wxGridCellAutoWrapStringRenderer Ptr)
Declare Sub wxGridCellAutoWrapStringRenderer_RegisterDisposable WXCALL Alias "wxGridCellAutoWrapStringRenderer_RegisterDisposable" (self As wxGridCellAutoWrapStringRenderer Ptr, on_dispose As Virtual_Dispose)
Declare Sub wxGridCellAutoWrapStringRenderer_Draw WXCALL Alias "wxGridCellAutoWrapStringRenderer_Draw" (self As wxGridCellAutoWrapStringRenderer Ptr, grid As wxGrid Ptr, attr As wxGridCellAttr Ptr, dc As wxDC Ptr, r As wxRect Ptr, row As wxInt, col As wxInt, IsSelected As wxBool)
Declare Sub wxGridCellAutoWrapStringRenderer_GetBestSize WXCALL Alias "wxGridCellAutoWrapStringRenderer_GetBestSize" (self As wxGridCellAutoWrapStringRenderer Ptr, grid As wxGrid Ptr, attr As wxGridCellAttr Ptr, dc As wxDC Ptr, row As wxInt, col As wxInt, size As wxSize Ptr)
Declare Function wxGridCellAutoWrapStringRenderer_Clone WXCALL Alias "wxGridCellAutoWrapStringRenderer_Clone" (self As wxGridCellAutoWrapStringRenderer Ptr) As wxGridCellRenderer Ptr

' class wxGridCellEnumEditor
Declare Function wxGridCellEnumEditor_ctor WXCALL Alias "wxGridCellEnumEditor_ctor" (choices As wxString Ptr) As wxGridCellEnumEditor Ptr
Declare Sub wxGridCellEnumEditor_dtor WXCALL Alias "wxGridCellEnumEditor_dtor" (self As wxGridCellEnumEditor Ptr)
Declare Sub wxGridCellEnumEditor_BeginEdit WXCALL Alias "wxGridCellEnumEditor_BeginEdit" (self As wxGridCellEnumEditor Ptr, row As wxInt, col As wxInt, grid As wxGrid Ptr)
Declare Function wxGridCellEnumEditor_EndEdit WXCALL Alias "wxGridCellEnumEditor_EndEdit" (self As wxGridCellEnumEditor Ptr, row As wxInt, col As wxInt, grid As wxGrid Ptr) As wxBool
Declare Function wxGridCellEnumEditor_Clone WXCALL Alias "wxGridCellEnumEditor_Clone" (self As wxGridCellEnumEditor Ptr) As wxGridCellEditor Ptr

' class wxGridCellAutoWrapStringEditor
Declare Function wxGridCellAutoWrapStringEditor_ctor WXCALL Alias "wxGridCellAutoWrapStringEditor_ctor" () As wxGridCellAutoWrapStringEditor Ptr
Declare Sub wxGridCellAutoWrapStringEditor_dtor WXCALL Alias "wxGridCellAutoWrapStringEditor_dtor" (self As wxGridCellAutoWrapStringEditor Ptr)
Declare Sub wxGridCellAutoWrapStringEditor_RegisterDisposable WXCALL Alias "wxGridCellAutoWrapStringEditor_RegisterDisposable" (self As wxGridCellAutoWrapStringEditor Ptr, on_dispose As Virtual_Dispose)
Declare Sub wxGridCellAutoWrapStringEditor_Create WXCALL Alias "wxGridCellAutoWrapStringEditor_Create" (self As wxGridCellAutoWrapStringEditor Ptr, parent As wxWindow Ptr, id As wxWindowID, evtHandler As wxEventHandler Ptr)
Declare Function wxGridCellAutoWrapStringEditor_Clone WXCALL Alias "wxGridCellAutoWrapStringEditor_Clone" (self As wxGridCellAutoWrapStringEditor Ptr) As wxGridCellEditor Ptr

#EndIf ' __gridctrl_bi__

