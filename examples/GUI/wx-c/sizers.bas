''
'' wx-c sizers example, by dumbledore
''

#Include "wx-c/wx.bi"

'' globals
	Dim Shared As wxApp Ptr app
	Dim Shared As wxSizer Ptr sizer

''
Sub sizer_OnDispose( )

End Sub

''
Sub sizer_OnRecalcSizes( )

    wxBoxSizer_RecalcSizes( sizer )

End Sub

''
Function App_OnInit WXCALL ( ) As wxBool

    '' create the main window
    Dim As wxFrame Ptr frame = wxFrame_ctor( )
    wxFrame_Create( frame, 0, 1, wxString_ctorUTF8("Welcome to WX-C"), -1, -1, -1, -1, _
                    wxFRAME_DEFAULT_STYLE Or wxCLOSE_BOX, WX_NULL )

    '' create a box sizer and set as the new layout
    sizer = wxBoxSizer_ctor( wxVERTICAL )
    wxBoxSizer_RegisterVirtual( sizer, @sizer_OnRecalcSizes )
    wxBoxSizer_RegisterDisposable( sizer, @sizer_OnDispose )
    wxWindow_SetAutoLayout( frame, WX_TRUE )

    '' create button 1 and add to sizer
    Dim As wxButton Ptr button1 = wxButton_ctor( )
    wxButton_Create( button1, frame, 1, wxString_ctorUTF8("Button1"), -1,-1, -1, -1, 0, 0, 0 )
    wxSizer_AddWindow( sizer, button1, -1, -1, -1, 0 )

    '' create button 2 and add to sizer
    Dim As wxButton Ptr button2 = wxButton_ctor( )
    wxButton_Create( button2, frame, 2, wxString_ctorUTF8("Button2"), -1, -1, -1, -1, 0, 0, 0 )
    wxSizer_AddWindow( sizer, button2, -1, -1, -1, 0 )

    '' 
    wxWindow_SetSizerAndFit( frame, sizer, 0 )

    ''
    wxWindow_CenterOnScreen( frame, wxBOTH )

    wxWindow_Show( frame, 1 )

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
