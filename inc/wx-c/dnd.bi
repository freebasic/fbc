#Ifndef __dnd_bi__
#Define __dnd_bi__

#Include Once "common.bi"

Type DoDragDrop  As Function WXCALL (ivalue As wxInt) As wxDragResult
Type OnDragOver  As Function WXCALL (x As wxCoord, y As wxCoord, dr As wxDragResult) As wxDragResult
Type OnDrop      As Function WXCALL (x As wxCoord, y As wxCoord) As wxBool
Type OnData3     As Function WXCALL (x As wxCoord, y As wxCoord, dr As wxDragResult) As wxDragResult
Type GetData     As Function WXCALL As wxBool
Type OnLeave     As Sub      WXCALL
Type OnEnter     As Function WXCALL (x As wxCoord, y As wxCoord, dr As wxDragResult) As wxDragResult
Type OnDropText  As Function WXCALL (x As wxCoord, y As wxCoord, txt As wxString Ptr) As wxBool
Type OnData      As Function WXCALL (x As wxCoord, y As wxCoord, dr As wxDragResult) As wxDragResult
Type OnDropFiles As Function WXCALL (x As wxCoord, y As wxCoord, files As wxArrayString Ptr) As wxBool
Type OnData2     As Function WXCALL (x As wxCoord, y As wxCoord, dr As wxDragResult) As wxDragResult

' class wxDropSource
Declare Function wxDropSource_Win_ctor WXCALL Alias "wxDropSource_Win_ctor" (win As wxWindow Ptr) As wxDropSource Ptr
Declare Function wxDropSource_DataObject_ctor WXCALL Alias "wxDropSource_DataObject_ctor" (dataObject As wxDataObject Ptr, win As wxWindow Ptr) As wxDropSource Ptr
Declare Sub wxDropSource_dtor WXCALL Alias "wxDropSource_dtor" (self As wxDropSource Ptr)
Declare Sub wxDropSource_RegisterVirtual WXCALL Alias "wxDropSource_RegisterVirtual" (self As wxDropSource Ptr,do_DragDrop As DoDragDrop )
Declare Function wxDropSource_DoDragDrop WXCALL Alias "wxDropSource_DoDragDrop" (self As wxDropSource Ptr, flags As wxInt) As wxInt
Declare Sub wxDropSource_SetData WXCALL Alias "wxDropSource_SetData" (self As wxDropSource Ptr, pData As wxDataObject Ptr)
Declare Function wxDropSource_GetDataObject WXCALL Alias "wxDropSource_GetDataObject" (self As wxDropSource Ptr) As wxDataObject Ptr
Declare Sub wxDropSource_SetCursor WXCALL Alias "wxDropSource_SetCursor" (self As wxDropSource Ptr, pRes As wxDragResult Ptr, cursor As wxCursor Ptr)
Declare Function wxDropSource_GiveFeedback WXCALL Alias "wxDropSource_GiveFeedback" (self As wxDropSource Ptr, pEffect As wxDragResult Ptr) As wxBool

' class wxDropTarget
Declare Function wxDropTarget_ctor WXCALL Alias "wxDropTarget_ctor" (dataObject As wxDataObject Ptr) As wxDropTarget Ptr
Declare Sub wxDropTarget_dtor WXCALL Alias "wxDropTarget_dtor" (self As wxDropTarget Ptr)
Declare Sub wxDropTarget_RegisterVirtual WXCALL Alias "wxDropTarget_RegisterVirtual" (self As wxDropTarget Ptr, _
                                 on_DragOver As OnDragOver , _
                                 on_Drop     As OnDrop, _
                                 on_Data     As OnData3, _
                                 get_Data    As GetData, _
                                 on_Leave    As OnLeave, _
                                 on_Enter    As OnEnter)
Declare Sub wxDropTarget_RegisterDisposable WXCALL Alias "wxDropTarget_RegisterDisposable" (self As wxDropTarget Ptr, on_onDispose As Virtual_Dispose)
Declare Sub wxDropTarget_SetDataObject WXCALL Alias "wxDropTarget_SetDataObject" (self As wxDropTarget Ptr, dataObject As wxDataObject Ptr)
Declare Function wxDropTarget_OnEnter WXCALL Alias "wxDropTarget_OnEnter" (self As wxDropTarget Ptr, x As wxCoord, y As wxCoord, dr As wxDragResult) As wxDragResult
Declare Function wxDropTarget_OnDragOver WXCALL Alias "wxDropTarget_OnDragOver" (self As wxDropTarget Ptr, x As wxCoord,y As wxCoord, dr As wxDragResult) As wxDragResult
Declare Sub wxDropTarget_OnLeave WXCALL Alias "wxDropTarget_OnLeave" (self As wxDropTarget Ptr)
Declare Function wxDropTarget_OnDrop WXCALL Alias "wxDropTarget_OnDrop" (self As wxDropTarget Ptr, x As wxCoord, y As wxCoord) As wxBool
Declare Function wxDropTarget_GetData WXCALL Alias "wxDropTarget_GetData" (self As wxDropTarget Ptr) As wxBool

' class wxTextDropTarget
Declare Function wxTextDropTarget_ctor WXCALL Alias "wxTextDropTarget_ctor" () As wxTextDropTarget Ptr
Declare Sub wxTextDropTarget_RegisterVirtual WXCALL Alias "wxTextDropTarget_RegisterVirtual" (self As wxTextDropTarget Ptr, on_DropText As OnDropText, on_Data As OnData)
Declare Function wxTextDropTarget_OnData WXCALL Alias "wxTextDropTarget_OnData" (self As wxTextDropTarget Ptr, x As wxCoord, y As wxCoord, dr As wxDragResult) As wxDragResult
Declare Function wxTextDropTarget_OnDrop WXCALL Alias "wxTextDropTarget_OnDrop" (self As wxTextDropTarget Ptr, x As wxInt, y As wxInt) As wxBool
Declare Function wxTextDropTarget_GetData WXCALL Alias "wxTextDropTarget_GetData" (self As wxTextDropTarget Ptr) As wxBool

' class wxFileDropTarget
Declare Function wxFileDropTarget_ctor WXCALL Alias "wxFileDropTarget_ctor" () As wxFileDropTarget Ptr
Declare Sub wxFileDropTarget_RegisterVirtual WXCALL Alias "wxFileDropTarget_RegisterVirtual" (self As wxFileDropTarget Ptr, on_DropFiles As OnDropFiles, on_Data As OnData2)
Declare Function wxFileDropTarget_OnData WXCALL Alias "wxFileDropTarget_OnData" (self As wxFileDropTarget Ptr, x As wxCoord, y As wxCoord, dr As wxDragResult) As wxDragResult
Declare Function wxFileDropTarget_OnDrop WXCALL Alias "wxFileDropTarget_OnDrop" (self As wxFileDropTarget Ptr, x As wxInt, y As wxInt) As wxBool
Declare Function wxFileDropTarget_GetData WXCALL Alias "wxFileDropTarget_GetData" (self As wxFileDropTarget Ptr) As wxBool

#EndIf ' __dnd_bi__


