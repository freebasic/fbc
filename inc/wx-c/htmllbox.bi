#Ifndef __htmllbox_bi__
#Define __htmllbox_bi__

#Include Once "common.bi"

Type Virtual_VoidNoParams     As Sub      WXCALL 
Type Virtual_VoidSizeT        As Sub      WXCALL (s As size_t)
Type Virtual_wxStringSizeT    As Function WXCALL (s As size_t) As _DisposableStringBox Ptr
Type Virtual_wxColourwxColour As Function WXCALL (col As wxColour Ptr) As wxColour Ptr
Type Virtual_OnDrawItem       As Sub      WXCALL (dc As wxDC Ptr, r As wxRect Ptr, s As size_t)
Type Virtual_OnMeasureItem    As Function WXCALL (s As size_t) As wxCoord


Declare Function wxHtmlListBox_ctor2 WXCALL Alias "wxHtmlListBox_ctor2" (parent  As wxWindow Ptr, _
                         id      As  wxWindowID   = -1, _
                         x       As  wxInt        = -1, _
                         y       As  wxInt        = -1, _
                         w       As  wxInt        = -1, _
                         h       As  wxInt        = -1, _
                         style   As  wxUInt       =  0, _
                         nameArg As wxString Ptr = WX_NULL) As wxHtmlListBox Ptr
Declare Sub wxHtmlListBox_RegisterVirtual WXCALL Alias "wxHtmlListBox_RegisterVirtual" (self As wxHtmlListBox Ptr, _
                                   refreshAll              As Virtual_VoidNoParams, _
                                   setItemCount            As Virtual_VoidSizeT, _
                                   onGetItem               As Virtual_wxStringSizeT, _
                                   onGetItemMarkup         As Virtual_wxStringSizeT, _
                                   getSelectedTextColour   As Virtual_wxColourwxColour, _
                                   getSelectedTextBgColour As Virtual_wxColourwxColour, _
                                   onDrawItem              As Virtual_OnDrawItem, _
                                   onMeasureItem           As Virtual_OnMeasureItem, _
                                   onDrawSeparator         As Virtual_OnDrawItem, _
                                   onDrawBackground        As Virtual_OnDrawItem , _
                                   onGetLineHeight         As Virtual_OnMeasureItem )
Declare Function wxHtmlListBox_Create WXCALL Alias "wxHtmlListBox_Create" (self As wxHtmlListBox Ptr, _
                          parent  As wxWindow Ptr, _
                          id      As  wxWindowID, _
                          x       As  wxInt , _
                          y       As  wxInt, _
                          w       As  wxInt, _
                          h       As  wxInt, _
                          style   As  wxUInt, _
                          nameArg As wxString Ptr) As wxBool
Declare Sub wxHtmlListBox_RefreshAll WXCALL Alias "wxHtmlListBox_RefreshAll" (self As wxHtmlListBox Ptr)
Declare Sub wxHtmlListBox_SetItemCount WXCALL Alias "wxHtmlListBox_SetItemCount" (self As wxHtmlListBox Ptr, count As wxInt)
Declare Function wxHtmlListBox_OnGetItemMarkup WXCALL Alias "wxHtmlListBox_OnGetItemMarkup" (self As wxHtmlListBox Ptr, n As wxInt) As wxString Ptr
Declare Function wxHtmlListBox_GetSelectedTextColour WXCALL Alias "wxHtmlListBox_GetSelectedTextColour" (self As wxHtmlListBox Ptr, colFg As wxColour Ptr) As wxColour Ptr
Declare Function wxHtmlListBox_GetSelectedTextBgColour WXCALL Alias "wxHtmlListBox_GetSelectedTextBgColour" (self As wxHtmlListBox Ptr, colBg As wxColour Ptr) As wxColour Ptr
Declare Sub wxHtmlListBox_OnDrawItem WXCALL Alias "wxHtmlListBox_OnDrawItem" (self As wxHtmlListBox Ptr, dc As wxDC Ptr, r As wxRect Ptr, n As wxInt)
Declare Function wxHtmlListBox_OnMeasureItem WXCALL Alias "wxHtmlListBox_OnMeasureItem" (self As wxHtmlListBox Ptr, n As wxInt) As wxCoord
Declare Sub wxHtmlListBox_OnSize WXCALL Alias "wxHtmlListBox_OnSize" (self As wxHtmlListBox Ptr, event As wxSizeEvent Ptr)
Declare Sub wxHtmlListBox_Init WXCALL Alias "wxHtmlListBox_Init" (self As wxHtmlListBox Ptr)
Declare Sub wxHtmlListBox_CacheItem WXCALL Alias "wxHtmlListBox_CacheItem" (self As wxHtmlListBox Ptr, n As wxInt)
Declare Sub wxHtmlListBox_OnDrawSeparator WXCALL Alias "wxHtmlListBox_OnDrawSeparator" (self As wxHtmlListBox Ptr, dc As wxDC Ptr, r As wxRect Ptr, n As wxInt)
Declare Sub wxHtmlListBox_OnDrawBackground WXCALL Alias "wxHtmlListBox_OnDrawBackground" (self As wxHtmlListBox Ptr, dc As wxDC Ptr, r As wxRect Ptr, n As wxInt)
Declare Function wxHtmlListBox_OnGetLineHeight WXCALL Alias "wxHtmlListBox_OnGetLineHeight" (self As wxHtmlListBox Ptr, line_ As wxInt) As wxCoord

#EndIf ' __htmllbox_bi__


