''
'' wx-c sizers example, by dumbledore
''


#include once "wx-c/wx.bi" 
#define TRUE -1 
#define FALSE 0 
#define wxCLOSE_BOX &h1000 

'' globals
	dim shared as wxApp ptr app
	dim shared as wxSizer ptr sizer 

''
sub sizer_OnDispose( )

end sub

''
sub sizer_OnRecalcSizes( ) 
    
    wxBoxSizer_RecalcSizes( sizer ) 
    
end sub 

''
function sizer_OnCalcMin( ) as wxSize ptr
    
    function = wxBoxSizer_CalcMin( sizer ) 
    
end function 

''
function App_OnInit( ) as integer

    '' create the main window
    dim as wxFrame ptr frame = wxFrame( ) 
    wxFrame_Create( frame, 0, 1, "Welcome to WX-C", wxSize( -1, -1 ), wxSize( -1, -1 ), _
    				wxDEFAULT_FRAME_STYLE or wxCLOSE_BOX, "frame" ) 
    
    '' create a box sizer and set as the new layout
    sizer = wxBoxSizer( wxVERTICAL)  
    wxBoxSizer_RegisterVirtual( sizer, @sizer_OnRecalcSizes, @sizer_OnCalcMin ) 
    wxBoxSizer_RegisterDisposable( sizer, @sizer_OnDispose )
    wxWindow_SetAutoLayout( frame, TRUE ) 
    
    '' create button 1 and add to sizer
    dim as wxButton ptr button1 = wxButton( ) 
    wxButton_Create( button1, frame, 1, "Button1", wxSize( -1,-1 ), wxSize( -1, -1 ), 0, 0, 0 ) 
    wxSizer_AddWindow( sizer, button1, -1, -1, -1, 0 ) 
    
    '' create button 2 and add to sizer
    dim as wxButton ptr button2 = wxButton( ) 
    wxButton_Create( button2, frame, 2, "Button2", wxSize( -1, -1 ), wxSize( -1, -1 ), 0, 0, 0 ) 
    wxSizer_AddWindow( sizer, button2, -1, -1, -1, 0 ) 
    
    '' 
    wxWindow_SetSizerAndFit( frame, sizer, 0 ) 
    
    ''
    wxWindow_CenterOnScreen( frame, wxBOTH ) 
    
    wxWindow_Show( frame, 1 ) 
    
    function = wxApp_OnInit( app ) 
    
end function

''
function App_OnExit( ) as integer

    function = wxApp_OnExit( app ) 

end function

'' main
  app = wxApp( ) 
  wxApp_RegisterVirtual( app, @App_OnInit, @App_OnExit ) 
  wxApp_Run( 0, 0 )
