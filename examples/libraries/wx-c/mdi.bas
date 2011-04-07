''
'' wx-c MDI example, by dumbledore
''
 

#include once "wx-c/wx.bi" 
#define wxCLOSE_BOX &h1000 

const FALSE = 0 
const TRUE = NOT FALSE
const CHILDREN = 4

'' globals
	dim shared as wxApp ptr app 
	dim shared as _MDIParentFrame ptr mdiparent


'' obligatory callback when creating parent MDI frames
function mdiparent_OnCreateClient(  ) as wxMDIClientWindow ptr 
    
    function = wxMDIParentFrame_OnCreateClient( mdiparent ) 

end function

''
sub init_frames( )

    '' create the parent MDI frame
    mdiparent = wxMDIParentFrame( ) 
    wxMDIParentFrame_RegisterVirtual( mdiparent, @mdiparent_OnCreateClient )
    wxMDIParentFrame_Create( mdiparent, 0, -1, "parent", wxSize( -1, -1 ), wxSize( 500, 500 ), _
    						 wxDEFAULT_FRAME_STYLE or wxCLOSE_BOX or wxVSCROLL or wxHSCROLL, 0 ) 
    
    '' now the child ones
    dim as wxMDIChildFrame ptr childframe
    dim as integer i
    for i = 1 to CHILDREN
    	childframe = wxMDIChildFrame( ) 
    	wxMDIChildFrame_Create( childframe, mdiparent, -1, "child_" + str(i), _
    							wxSize( 10*i, 10*i ), wxSize( 120, 100 ), _
    							wxDEFAULT_FRAME_STYLE or wxCLOSE_BOX, 0 ) 
	next

end sub

''
sub init_menus( )

    '' add a menu bar
    dim as wxmenubar ptr mbar = wxMenuBar( ) 
    
    '' and the menus
    dim as wxMenu ptr menu = wxMenu( 0, 0 ) 
    wxMenuBase_Append( menu, -1, "&Nothing", "This does squat.", 0 ) 
    wxMenuBar_Append( mbar, menu, "&File" ) 
    wxFrame_SetMenuBar( mdiparent, mbar ) 

end sub

''
function App_OnInit( ) as integer

    ''
    init_frames( )
    
    ''
    init_menus( )
    
    ''
    wxWindow_Show( mdiparent, TRUE ) 
    
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
