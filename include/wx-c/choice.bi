#Ifndef __choice_bi__
#Define __choice_bi__

#Include Once "common.bi"

' class wxChoice
Declare Function wxChoice_ctor WXCALL Alias "wxChoice_ctor" () As wxChoice Ptr
Declare Function wxChoice_Create WXCALL Alias "wxChoice_Create" ( _
								  self      As wxChoice      Ptr          , _
                                  parent    As wxWindow      Ptr          , _
                                  id        As  wxWindowID        = -1     , _
                                  x         As  wxInt             = -1     , _
                                  y         As  wxInt             = -1     , _
                                  w         As  wxInt             = -1     , _
                                  h         As  wxInt             = -1     , _
                                  pChoices  As wxArrayString Ptr = WX_NULL, _
                                  style     As  wxUInt            =  0     , _
                                  validator As wxValidator   Ptr = WX_NULL, _
                                  nameArg   As wxString      Ptr = WX_NULL) As wxBool
Declare Sub wxChoice_dtor WXCALL Alias "wxChoice_dtor" (self As wxChoice Ptr)
Declare Sub wxChoice_SetColumns WXCALL Alias "wxChoice_SetColumns" (self As wxChoice Ptr, n As wxInt)
Declare Function wxChoice_GetColumns WXCALL Alias "wxChoice_GetColumns" (self As wxChoice Ptr) As wxInt
Declare Sub wxChoice_Command WXCALL Alias "wxChoice_Command" (self As wxChoice Ptr, evnt As wxCommandEvent Ptr)
Declare Function wxChoice_GetCurrentSelection WXCALL Alias "wxChoice_GetCurrentSelection" (self As wxChoice Ptr) As wxInt

#EndIf ' __choice_bi__

