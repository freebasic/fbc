#Ifndef __global_bi__
#Define __global_bi__

#Include Once "common.bi"

Declare Sub wxGlobal_Bell WXCALL Alias "wxGlobal_Bell" ()
Declare Sub wxGlobal_Exit WXCALL Alias "wxGlobal_Exit" ()
Declare Function wxGlobal_GetNumberFromUser WXCALL Alias "wxGlobal_GetNumberFromUser" (Mesage   As wxString Ptr, _
                                Prompt   As wxString Ptr, _
                                Caption  As wxString Ptr, _
                                Value    As wxInt, _
                                Min      As wxInt, _
                                Max      As wxInt, _
                                Parent   As wxWindow Ptr, _
                                Position As wxPoint Ptr) As wxInt
Declare Function wxGlobal_GetHomeDir WXCALL Alias "wxGlobal_GetHomeDir" () As wxString Ptr
Declare Function wxGlobal_FileSelector WXCALL Alias "wxGlobal_FileSelector" (Message   As wxString Ptr, _
                           Path      As wxString Ptr, _
                           Filename  As wxString Ptr, _
                           Extension As wxString Ptr, _
                           Wildcard  As wxString Ptr, _
                           Flags     As wxInt, _
                           Parent    As wxWindow Ptr, _
                           x         As wxInt, _
                           y         As wxInt) As wxString Ptr
Declare Function wxGlobal_DirSelector WXCALL Alias "wxGlobal_DirSelector" (Message   As wxString Ptr, _
                           Path      As wxString Ptr, _
                           Flags     As wxInt, _
                           Parent    As wxWindow Ptr, _
                           x         As wxInt, _
                           y         As wxInt) As wxString Ptr

' class ByteBuffer
Declare Function ByteBuffer_ctor WXCALL Alias "ByteBuffer_ctor" (reserved As size_t) As _ByteBuffer Ptr
Declare Function ByteBuffer_reserved WXCALL Alias "ByteBuffer_reserved" (self As _ByteBuffer Ptr) As size_t
Declare Function ByteBuffer_filled WXCALL Alias "ByteBuffer_filled" (self As _ByteBuffer Ptr) As size_t
Declare Sub ByteBuffer_atSet WXCALL Alias "ByteBuffer_atSet" (self As _ByteBuffer Ptr, index As size_t, b As wxChar)
Declare Function ByteBuffer_at WXCALL Alias "ByteBuffer_at" (self As _ByteBuffer Ptr, index As size_t) As wxChar
Declare Function ByteBuffer_ptrToBuffer WXCALL Alias "ByteBuffer_ptrToBuffer" (self As _ByteBuffer Ptr) As wxChar Ptr

' class wxArrayInt
Declare Function wxArrayInt_ctor WXCALL Alias "wxArrayInt_ctor" () As wxArrayInt Ptr
Declare Sub wxArrayInt_dtor WXCALL Alias "wxArrayInt_dtor" (self As wxArrayInt Ptr)
Declare Sub wxArrayInt_Add WXCALL Alias "wxArrayInt_Add" (self As wxArrayInt Ptr, toadd As wxInt)
Declare Function wxArrayInt_GetCount WXCALL Alias "wxArrayInt_GetCount" (self As wxArrayInt Ptr) As wxInt
Declare Function wxArrayInt_Item WXCALL Alias "wxArrayInt_Item" (self As wxArrayInt Ptr, num As wxInt) As wxInt

' class wxArrayIntPtr
Declare Function wxArrayIntPtr_ctor WXCALL Alias "wxArrayIntPtr_ctor" (length As wxInt) As wxArrayIntPtr Ptr
Declare Sub wxArrayIntPtr_dtor WXCALL Alias "wxArrayIntPtr_dtor" (self As wxArrayIntPtr Ptr)
Declare Sub wxArrayIntPtr_Set WXCALL Alias "wxArrayIntPtr_Set" (self As wxArrayIntPtr Ptr, index As wxInt, value As Any Ptr)
Declare Function wxArrayIntPtr_Get WXCALL Alias "wxArrayIntPtr_Get" (self As wxArrayIntPtr Ptr, index As wxInt) As Any Ptr

' class wxArrayString
Declare Function wxArrayString_ctor WXCALL Alias "wxArrayString_ctor" () As wxArrayString Ptr
Declare Sub wxArrayString_dtor WXCALL Alias "wxArrayString_dtor" (self As wxArrayString Ptr)
Declare Function wxArrayString_GetCount WXCALL Alias "wxArrayString_GetCount" (self As wxArrayString Ptr) As wxInt
Declare Sub wxArrayString_Add WXCALL Alias "wxArrayString_Add" (self As wxArrayString Ptr, item As wxString Ptr)
Declare Function wxArrayString_Item WXCALL Alias "wxArrayString_Item" (self As wxArrayString Ptr, ind As wxInt) As wxString Ptr
Declare Function wxArrayString_Index WXCALL Alias "wxArrayString_Index" (self As wxArrayString Ptr, sz As wxString Ptr, bCase As wxBool, bFromEnd As wxBool) As wxInt 
Declare Sub wxArrayString_Remove WXCALL Alias "wxArrayString_Remove" (self As wxArrayString Ptr, sz As wxString Ptr)
Declare Sub wxArrayString_RemoveAt WXCALL Alias "wxArrayString_RemoveAt" (self As wxArrayString Ptr, ind As wxInt)
Declare Sub wxArrayString_Clear WXCALL Alias "wxArrayString_Clear" (self As wxArrayString Ptr)
Declare Sub wxArrayString_Sort WXCALL Alias "wxArrayString_Sort" (self As wxArrayString Ptr, inReversedOrder As wxBool)

' class wxWindowDisabler
Declare Function wxWindowDisabler_ctor WXCALL Alias "wxWindowDisabler_ctor" (winToSkip As wxWindow Ptr) As wxWindowDisabler Ptr
Declare Sub wxWindowDisabler_dtor WXCALL Alias "wxWindowDisabler_dtor" (self As wxWindowDisabler Ptr)

' class wxBusyInfo
Declare Function wxBusyInfo_ctor WXCALL Alias "wxBusyInfo_ctor" (msg As wxString Ptr, parent As wxWindow Ptr) As wxBusyInfo Ptr 
Declare Sub wxBusyInfo_dtor WXCALL Alias "wxBusyInfo_dtor" (self As wxBusyInfo Ptr)

' wxMutex
Declare Sub wxMutexGuiEnter_func WXCALL Alias "wxMutexGuiEnter_func" ()
Declare Sub wxMutexGuiLeave_func WXCALL Alias "wxMutexGuiLeave_func" ()

Declare Sub wxSleep_func WXCALL Alias "wxSleep_func" (num As wxInt)

Declare Function wxYield_func WXCALL Alias "wxYield_func" () As wxBool

Declare Sub wxBeginBusyCursor_func WXCALL Alias "wxBeginBusyCursor_func" ()
Declare Sub wxEndBusyCursor_func WXCALL Alias "wxEndBusyCursor_func" ()

' class wxSize
Declare Function wxSize_ctor WXCALL Alias "wxSize_ctor" (w As wxInt, h As wxInt) As wxSize Ptr
Declare Sub wxSize_dtor WXCALL Alias "wxSize_dtor" (self As wxSize Ptr)
Declare Sub wxSize_SetWidth WXCALL Alias "wxSize_SetWidth" (self As wxSize Ptr,w As wxInt)
Declare Function wxSize_GetWidth WXCALL Alias "wxSize_GetWidth" (self As wxSize Ptr) As wxInt
Declare Sub wxSize_SetHeight WXCALL Alias "wxSize_SetHeight" (self As wxSize Ptr,h As wxInt)
Declare Function wxSize_GetHeight WXCALL Alias "wxSize_GetHeight" (self As wxSize Ptr) As wxInt

' class wxRect
Declare Function wxRect_ctor WXCALL Alias "wxRect_ctor" (x As wxInt, y As wxInt, w As wxInt, h As wxInt) As wxRect Ptr
Declare Sub wxRect_dtor WXCALL Alias "wxRect_dtor" (self As wxRect Ptr)
Declare Sub wxRect_RegisterDisposable WXCALL Alias "wxRect_RegisterDisposable" (self As wxRect Ptr, on_dispose As Virtual_Dispose)
Declare Sub wxRect_SetX WXCALL Alias "wxRect_SetX" (self As wxRect Ptr, x As wxInt)
Declare Function wxRect_GetX WXCALL Alias "wxRect_GetX" (self As wxRect Ptr) As wxInt
Declare Sub wxRect_SetY WXCALL Alias "wxRect_SetY" (self As wxRect Ptr, y As wxInt)
Declare Function wxRect_GetY WXCALL Alias "wxRect_GetY" (self As wxRect Ptr) As wxInt
Declare Sub wxRect_SetWidth WXCALL Alias "wxRect_SetWidth" (self As wxRect Ptr, w As wxInt)
Declare Function wxRect_GetWidth WXCALL Alias "wxRect_GetWidth" (self As wxRect Ptr) As wxInt
Declare Sub wxRect_SetHeight WXCALL Alias "wxRect_SetHeight" (self As wxRect Ptr, h As wxInt)
Declare Function wxRect_GetHeight WXCALL Alias "wxRect_GetHeight" (self As wxRect Ptr) As wxInt

' class wxPoint
Declare Function wxPoint_ctor WXCALL Alias "wxPoint_ctor" (x As wxInt, y As wxInt) As wxPoint Ptr
Declare Sub wxPoint_SetX WXCALL Alias "wxPoint_SetX" (self As wxPoint Ptr, x As wxInt)
Declare Function wxPoint_GetX WXCALL Alias "wxPoint_GetX" (self As wxPoint Ptr) As wxInt
Declare Sub wxPoint_SetY WXCALL Alias "wxPoint_SetY" (self As wxPoint Ptr, y As wxInt)
Declare Function wxPoint_GetY WXCALL Alias "wxPoint_GetY" (self As wxPoint Ptr) As wxInt

#EndIf ' __global_bi__

