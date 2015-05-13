''
'' wx-c wxWindow example, by dumbledore
''


#Include "wx-c/wx.bi"

Const FRAME_W = 500
Const FRAME_H = 400

''
'' ids
''
Enum
	ID_FRAME
	ID_PANEL
	ID_CLICKMEBUTTON
	ID_EXITBUTTON
	ID_DIAG_EXITBUTTON
End Enum

Declare Function app_oninit_cb WXCALL () As wxBool
Declare Function app_onexit_cb WXCALL () As wxInt

''
'' globals
''
	Dim Shared As wxApp Ptr app
	Dim Shared As wxFrame Ptr frame
   	Dim Shared As wxDialog Ptr dialog

'':::::
''
'' main  
''
  	app = wxApp_ctor( )
  	wxApp_RegisterVirtual( app, @app_oninit_cb, @app_onexit_cb )
  	wxApp_Run( 0, 0 )
  	
	End 0

'':::::
''
'' dialog's exit button callback
''
Sub diag_exitbutton_cb(ByVal event As wxEvent Ptr, ByVal iListener As Integer)

	wxDialog_EndModal( dialog, 0 )
	
End Sub

'':::::
''
'' panel's click-me button callback
''
Sub panel_clickmebutton_cb (ByVal event As wxEvent Ptr, ByVal iListener As Integer)
   
	wxDialog_ShowModal( dialog )
   
End Sub

'':::::
''
'' panel's exit button callback
''
Sub panel_exitbutton_cb (ByVal event As wxEvent Ptr, ByVal iListener As Integer)
   
	wxWindow_Close( frame, 0 )
   
End Sub

'':::::
''
'' on init callback
''
Function app_oninit_cb WXCALL () As wxBool
	Dim As Integer ypos, size
   
	'' create the main window
   	frame = wxFrame_ctor( )
   	wxFrame_Create( frame, 0, ID_FRAME, wxString_ctorUTF8("Welcome to WX-C"), _
   				   	200, 200, FRAME_W, FRAME_H, _
   				   	wxFRAME_DEFAULT_STYLE, WX_NULL )
   
   	'' make a dialog
   	dialog = wxDialog_ctor( )
   	wxDialog_Create( dialog, frame, -1, wxString_ctorUTF8("Press Exit"),_
   					 10, 10, 500, 400, _
   				     wxFRAME_DEFAULT_STYLE, 0 )
   
   	'' add widgets to the dialog
   	size = 27
   	ypos=1

   	wxButton_Create( wxButton_ctor( ), dialog, -1, wxString_ctorUTF8("&Goto"), _
   					405, ypos, 85, -1, 0, 0, 0 )
   	ypos += size
   
   	wxButton_Create( wxButton_ctor( ), dialog, -1, wxString_ctorUTF8("&Select"), _
   					 405, ypos, 85, -1, 0, 0, 0 )
   	ypos += size
   
   	wxButton_Create( wxButton_ctor( ), dialog, -1, wxString_ctorUTF8("E&dit"), _
   					 405, ypos, 85, -1, 0, 0, 0 )
   	ypos += size
   
   	wxButton_Create( wxButton_ctor( ), dialog, -1, wxString_ctorUTF8("&Add"), _
   					 405, ypos, 85, -1, 0, 0, 0 )
   	ypos += size
   
   	Dim As wxButton Ptr diag_exitbutton = wxButton_ctor( )
   	wxButton_Create( diag_exitbutton, dialog, ID_DIAG_EXITBUTTON, wxString_ctorUTF8("&Exit"), _
   					 405, ypos, 85, -1, 0, 0, 0 )
   
   	wxEvtHandler_proxy( diag_exitbutton, @diag_exitbutton_cb )
   	wxEvtHandler_Connect( diag_exitbutton, wxEvent_EVT_COMMAND_BUTTON_CLICKED( ), ID_DIAG_EXITBUTTON, -1, 0 )

   	Dim As wxListBox Ptr selector = wxListBox_ctor( )
   	wxListBox_Create( selector, dialog, -1, _
   					  wxPoint_ctor(-1, -1), wxSize_ctor(400, 350), 0, _
   					  wxLB_SINGLE Or wxLB_NEED_SB Or wxLB_HSCROLL, 0, 0 )
   	
   	Dim As wxFont Ptr font = wxFont_ctor( 10, wxMODERN, wxNORMAL, wxNORMAL, 0, 0, 0 )
   	wxWindow_SetFont( selector, font )
   	
   	Dim As Integer i
   	Dim As wxArrayString Ptr tempString = wxArrayString_ctor( )
   	For i = 0 To 15
   		wxArrayString_Add( tempString, wxString_ctorUTF8("list item " + Str( i+1 )) )
   		wxListBox_InsertItems( selector, tempString, i )
   		wxArrayString_Clear( tempString )
   	Next i
   
   	'' create the main panel
   	Dim As wxPanel Ptr panel = wxPanel_ctor2( frame, ID_PANEL, -1, -1, -1, -1, 0, 0 )
   
   	'' create a text widget
   	'' we're not using this thing for any events so it gets an id of -1
   	Dim As wxTextCtrl Ptr text = wxTextCtrl_ctor( )
   	wxTextCtrl_Create( text, panel, -1, wxString_ctorUTF8("Hello from wx-c in fb!"), _
   					   8, 8, FRAME_W - 24, FRAME_H - 200, _
   					   wxVSCROLL, 0, 0 )
   					   
   	wxTextCtrl_SetFont( text, font )
   
   	'' make a button (sending a wxsize(-1,-1) means take the default size - 
   	'' you can specify just x or y as -1 if you want the other one to be a fixed size
   	Dim As wxButton Ptr panel_clickmebutton = wxButton_ctor( )
   	wxButton_Create( panel_clickmebutton, panel, ID_CLICKMEBUTTON, wxString_ctorUTF8("Click me!"), _
   					 FRAME_W\2 - 100, FRAME_H - 60, -1, -1, 0, 0, 0 )
   
   	'' connect the button to the button event handler sub
   	wxEvtHandler_proxy( panel_clickmebutton, @panel_clickmebutton_cb )
   	wxEvtHandler_Connect( panel_clickmebutton, wxEvent_EVT_COMMAND_BUTTON_CLICKED( ), ID_CLICKMEBUTTON, -1, 0 )

   	''
   	Dim As wxButton Ptr panel_exitbutton = wxButton_ctor( )
   	wxButton_Create( panel_exitbutton, panel, ID_EXITBUTTON, wxString_ctorUTF8("Exit"), _
   					 FRAME_W\2 + 40, FRAME_H - 60, -1, -1, 0, 0, 0 )
   
   	'' connect the button to the button event handler sub
   	wxEvtHandler_proxy( panel_exitbutton, @panel_exitbutton_cb )
   	wxEvtHandler_Connect( panel_exitbutton, wxEvent_EVT_COMMAND_BUTTON_CLICKED( ), ID_EXITBUTTON, -1, 0 )
   
   	'' center it
   	wxWindow_CenterOnScreen( frame, wxBOTH )
   	
   	'' show window
   	wxWindow_Show( frame, 1 )

	Function = wxApp_OnInit( app )
	
End Function

'':::::
''
'' on exit callback
''
Function app_onexit_cb () As Integer

	wxMsgBox( 0, wxString_ctorUTF8("Bye Bye..."), wxString_ctorUTF8("Window Closed!"), 0, -1, -1 )

	Function = wxApp_OnExit( app )
	
End Function
