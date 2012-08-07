''
'' wx-c MDI example, by dumbledore
''

#Include "wx-c/wx.bi"

Const CHILDREN = 4

'' globals
	Dim Shared As wxApp Ptr app
	Dim Shared As wxMDIParentFrame Ptr mdiparent


'' obligatory callback when creating parent MDI frames
Function mdiparent_OnCreateClient(  ) As wxMDIClientWindow Ptr

    Function = wxMDIParentFrame_OnCreateClient( mdiparent )

End Function

''
Sub init_frames( )

    '' create the parent MDI frame
    mdiparent = wxMDIParentFrame_ctor( )
    wxMDIParentFrame_RegisterVirtual( mdiparent, @mdiparent_OnCreateClient )
    wxMDIParentFrame_Create( mdiparent, 0, -1, wxString_ctorUTF8("parent"), -1, -1, 500, 500, _
                             wxFRAME_DEFAULT_STYLE Or wxCLOSE_BOX Or wxVSCROLL Or wxHSCROLL, 0 )

    '' now the child ones
    Dim As wxMDIChildFrame Ptr childframe
    Dim As Integer i
    For i = 1 To CHILDREN
        childframe = wxMDIChildFrame_ctor( )
        wxMDIChildFrame_Create( childframe, mdiparent, -1, wxString_ctorUTF8("child_" + Str(i)), _
                                10*i, 10*i, 120, 100, _
                                wxFRAME_DEFAULT_STYLE Or wxCLOSE_BOX, 0 )
    Next

End Sub

''
Sub init_menus( )

    '' add a menu bar
    Dim As wxMenuBar Ptr mbar = wxMenuBar_ctor( )

    '' and the menus
    Dim As wxMenu Ptr menu = wxMenu_ctor( wxString_ctorUTF8(""), 0 )
    wxMenuBase_Append( menu, -1, wxString_ctorUTF8("&Nothing"), wxString_ctorUTF8("This does squat."), 0 )
    wxMenuBar_Append( mbar, menu, wxString_ctorUTF8("&File") )
    wxFrame_SetMenuBar( mdiparent, mbar )

End Sub

''
Function App_OnInit WXCALL ( ) As wxBool

    ''
    init_frames( )

    ''
    init_menus( )

    ''
    wxWindow_Show( mdiparent, WX_TRUE )

    Function = wxApp_OnInit( app )

End Function

''
Function App_OnExit WXCALL ( ) As wxInt

    Function = wxApp_OnExit( app )

End Function

'' main
	app = wxApp_ctor( )
	wxApp_RegisterVirtual( app, @App_OnInit, @App_OnExit )
	wxApp_Run( 0, 0 )
