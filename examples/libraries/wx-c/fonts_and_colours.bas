#Include "wx-c/wx.bi"

Declare Function App_OnInit WXCALL ( ) As wxBool
Declare Function App_OnExit WXCALL ( ) As wxInt

Dim Shared As wxApp Ptr wx_app
Dim Shared As wxFrame Ptr wx_frame
Dim Shared As wxPanel Ptr wx_panel

Function App_OnInit WXCALL ( ) As wxBool
	
	wx_frame = wxFrame_ctor( )
	wxFrame_Create( wx_frame, WX_NULL, -1, wxString_ctorUTF8( "Fonts and Colours" ), -1, -1, 250, 100, wxFRAME_DEFAULT_STYLE Or wxCLOSE_BOX Xor wxMAXIMIZE_BOX Xor wxRESIZE_BORDER, WX_NULL )
	wx_panel = wxPanel_ctor2( wx_frame, -1, -1, -1, -1, -1, 0, WX_NULL )
	
	'' create global font
	Dim As wxFont Ptr globalFont = wxFont_ctor( 8, wxMODERN, wxNORMAL, wxNORMAL, 0, 0, 0 )
	wxFont_SetPointSize( globalFont, 12 )
	
	'' apply font for all widgets on wx_panel
	wxWindow_SetFont( wx_panel, globalFont )
	
	
	'' widget stattext
	Dim As wxStaticText Ptr stattext
	stattext = wxStaticText_ctor( )
	wxStaticText_Create( stattext, wx_panel, -1, wxString_ctorUTF8( "Label:" ), 10, 10, 80, 15, 0, 0 )
	
	'' set colour for stattext
	Dim As wxColour Ptr sCol = wxColour_ctor( )
	wxColour_Set( sCol, 255, 0, 0, 0 )
	wxWindow_SetForegroundColour( stattext, sCol )
	
	
	'' widget textctrl
	Dim As wxTextCtrl Ptr textctrl
	textctrl = wxTextCtrl_ctor( )
	wxTextCtrl_Create( textctrl, wx_panel, -1, wxString_ctorUTF8( "Text" ), 10, 30, -1, -1, 0, 0, 0 )
	
	'' set another font for textctrl
	wxTextCtrl_SetFont( textctrl, wxFont_SMALL_FONT )
	
	
	'' set focus to wx_panel
	wxWindow_SetFocus( wx_panel )
	
	wxWindow_Show( wx_frame, 1 )
	wxApp_OnInit( wx_app )
	Return 1
	
End Function

Function App_OnExit WXCALL ( ) As wxInt
	
	Return wxApp_OnExit( wx_app )
	
End Function


''main
wx_app = wxApp_ctor( )
wxApp_RegisterVirtual ( wx_app, @App_OnInit, @App_OnExit )
wxApp_Run( 0, 0 )
