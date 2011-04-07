''
'' wxWindows-c example, by dumbledore
''


#include once "wx-c/wx.bi"

const FRAME_W = 500
const FRAME_H = 400

''
'' ids
''
enum
	ID_FRAME
	ID_PANEL
	ID_CLICKMEBUTTON
	ID_EXITBUTTON
	ID_DIAG_EXITBUTTON
end enum

declare function app_oninit_cb () as integer
declare function app_onexit_cb () as integer

''
'' globals
''
	dim shared as wxApp ptr app
	dim shared as wxFrame ptr frame
   	dim shared as wxDialog ptr dialog

'':::::
''
'' main  
''
  	app = wxApp( )
  	wxApp_RegisterVirtual( app, @app_oninit_cb, @app_onexit_cb )
  	wxApp_Run( 0, 0 )
  	
	end 0

'':::::
''
'' dialog's exit button callback
''
sub diag_exitbutton_cb(byval event as wxEvent ptr, byval iListener as integer)

	wxDialog_EndModal( dialog, 0 )
	
end sub

'':::::
''
'' panel's click-me button callback
''
sub panel_clickmebutton_cb (byval event as wxEvent ptr, byval iListener as integer)
   
	wxDialog_ShowModal( dialog )
   
end sub

'':::::
''
'' panel's exit button callback
''
sub panel_exitbutton_cb (byval event as wxEvent ptr, byval iListener as integer)
   
	wxWindow_Close( frame, 0 )
   
end sub

'':::::
''
'' on init callback
''
function app_oninit_cb () as integer
	dim as integer ypos, size
   
	'' create the main window
   	frame = wxFrame( )
   	wxFrame_Create( frame, 0, ID_FRAME, "Welcome to WX-C", _
   				   	wxSize( 200, 200 ), wxSize( FRAME_W, FRAME_H ), _
   				   	wxDEFAULT_FRAME_STYLE, "frame" )
   
   	'' make a dialog
   	dialog = wxDialog( )
   	wxDialog_create( dialog, frame, -1, "Press Exit",_
   					 wxSize( 10, 10 ), wxSize( 500, 400 ), _
   				     wxDEFAULT_FRAME_STYLE, 0 )
   
   	'' add widgets to the dialog
   	size = 27
   	ypos=1

   	wxButton_Create( wxButton( ), dialog, -1, "&Goto", _
   					wxSize( 405, ypos ), wxSize( 85, -1), 0, 0, 0 )
   	ypos += size
   
   	wxButton_Create( wxButton(), dialog, -1, "&Select", _
   					 wxSize( 405, ypos ), wxSize( 85, -1 ), 0, 0, 0 )
   	ypos += size
   
   	wxButton_create( wxButton( ), dialog, -1, "E&dit", _
   					 wxsize( 405, ypos ), wxSize( 85, -1 ), 0, 0, 0 )
   	ypos += size
   
   	wxButton_create( wxButton( ), dialog, -1, "&Add", _
   					 wxsize( 405, ypos), wxSize( 85,-1 ), 0, 0, 0 )
   	ypos += size
   
   	dim as wxButton ptr diag_exitbutton = wxButton()
   	wxbutton_create( diag_exitbutton, dialog, ID_DIAG_EXITBUTTON, "&Exit", _
   					 wxsize( 405, ypos ), wxSize( 85,-1 ), 0, 0, 0 )
   
   	wxEvtHandler_proxy( diag_exitbutton, @diag_exitbutton_cb )
   	wxEvtHandler_connect( diag_exitbutton, wxEvent_EVT_COMMAND_BUTTON_CLICKED( ), ID_DIAG_EXITBUTTON, -1, 0 )

   	dim as wxListBox ptr selector = wxListBox( )
   	wxListBox_Create( selector, dialog, -1, _
   					  wxSize( -1, -1), wxSize( 400, 350 ), 0, 0, _
   					  wxLB_SINGLE or wxLB_NEEDED_SB or wxLB_HSCROLL, 0, 0 )
   	
   	dim as wxFont ptr font = wxFont( 10, wxMODERN, wxNORMAL, wxNORMAL, 0, 0, 0 )
   	wxWindow_SetFont( selector, font )
   	
   	dim as integer i
   	for i = 0 to 15
   		wxListBox_Append( selector, "list item " + str( i+1 ) )
   	next i
   
   	'' create the main panel
   	dim as wxPanel ptr panel = wxPanel( )
   	wxPanel_Create( panel, frame, ID_PANEL, 0, 0, 0, 0 )
   
   	'' create a text widget
   	'' we're not using this thing for any events so it gets an id of -1
   	dim as wxTextCtrl ptr text = wxTextCtrl( )
   	wxTextCtrl_Create( text, panel, -1, "Hello from wx-c in fb!", _
   					   wxsize( 8, 8 ), wxsize( FRAME_W - 24, FRAME_H - 200 ), _
   					   wxVSCROLL, 0, 0 )
   					   
   	wxTextCtrl_SetFont( text, font )
   
   	'' make a button (sending a wxsize(-1,-1) means take the default size - 
   	'' you can specify just x or y as -1 if you want the other one to be a fixed size
   	dim as wxButton ptr panel_clickmebutton = wxButton( )
   	wxButton_Create( panel_clickmebutton, panel, ID_CLICKMEBUTTON, "Click me!", _
   					 wxsize( FRAME_W\2 - 100, FRAME_H - 60 ), wxsize( -1, -1 ), 0, 0, 0 )
   
   	'' connect the button to the button event handler sub
   	wxEvtHandler_proxy( panel_clickmebutton, @panel_clickmebutton_cb )
   	wxEvtHandler_connect( panel_clickmebutton, wxEvent_EVT_COMMAND_BUTTON_CLICKED( ), ID_CLICKMEBUTTON, -1, 0 )

   	''
   	dim as wxButton ptr panel_exitbutton = wxButton( )
   	wxButton_Create( panel_exitbutton, panel, ID_EXITBUTTON, "Exit", _
   					 wxsize( FRAME_W\2 + 40, FRAME_H - 60 ), wxsize( -1, -1 ), 0, 0, 0 )
   
   	'' connect the button to the button event handler sub
   	wxEvtHandler_proxy( panel_exitbutton, @panel_exitbutton_cb )
   	wxEvtHandler_connect( panel_exitbutton, wxEvent_EVT_COMMAND_BUTTON_CLICKED( ), ID_EXITBUTTON, -1, 0 )
   
   	'' center it
   	wxWindow_CenterOnScreen( frame, wxBOTH )
   	
   	'' show window
   	wxWindow_Show( frame, 1 )

	function = wxApp_OnInit( app )
	
end function

'':::::
''
'' on exit callback
''
function app_onexit_cb () as integer

	wxMsgBox( 0, "Bye Bye...", "Window Closed!", 0, wxSize( -1, -1 ) )

	function = wxApp_OnExit( app )
	
end function
