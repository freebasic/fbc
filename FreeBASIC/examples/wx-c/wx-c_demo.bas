'$include: "libwx-c.bi"
declare function fixstring(a as string) as string

dim shared wx_app,wx_frame,mydiag
'it's a good idea to put ids into an enum to keep things neat
enum ids
   Frame
   Panel
   Button
end enum

function fixstring(a as string) as string
   
   dim fixed as string
   for i=0 to wxString_Length(@a)
      fixed+=chr$(wxString_CharAt(@a,i))
   next i
   fixstring=fixed
   
end function

sub ButtonClick (byval event as long, byval listener as long)
   'this sub gets executed when you press the button
   result=wxDialog_ShowModal(mydiag)
   wxMsgBox ( wx_frame, "Bang!", "You've been shot", 0, wxSize_ctor ( 150, 50 ))
   'close the window because the user's been shot
   wxWindow_Close(wx_frame,0)
end sub

sub App_OnInit ()
   
   'create the main window
   wx_Frame = wxFrame_ctor ()
   wxFrame_Create (wx_Frame, 0, Frame, "Welcome to WX-C", wxSize_ctor ( 200, 200), wxSize_ctor ( 500, 300), wxDEFAULT_FRAME_STYLE or wxCLOSE_BOX, "frame" )
   
   'make a dialog :)
   mydiag=wxDialog_ctor()
   wxDialog_create(mydiag, wx_frame, -1, "Hit the X",wxSize_ctor(10,10),wxSize_ctor(500,400),wxDEFAULT_FRAME_STYLE or wxCLOSE_BOX,0)
   'add widgets to the dialog
   ypos=1
   size=27
   Gotoo=wxButton_ctor()
   wxButton_Create(Gotoo,mydiag,-1,"&Goto",wxSize_ctor(405,ypos),wxSize_ctor(85,-1),0,0,0)
   ypos+=size
   
   Selectt=wxButton_ctor()
   wxButton_Create(Selectt,mydiag,-1,"&Select",wxSize_ctor(405,ypos),wxSize_ctor(85,-1),0,0,0)
   ypos+=size
   
   Edit=wxButton_ctor()
   wxButton_create(Edit,mydiag,-1,"E&dit",wxsize_ctor(405,ypos),wxSize_ctor(85,-1),0,0,0)
   ypos+=size
   
   Add=wxButton_ctor()
   wxButton_create(add,mydiag,-1,"&Add",wxsize_ctor(405,ypos),wxSize_ctor(85,-1),0,0,0)
   ypos+=size
   
   Exitt=wxButton_ctor()
   wxbutton_create(exitt,mydiag,-1,"&Exit",wxsize_ctor(405,ypos),wxSize_ctor(85,-1),0,0,0)
   
   SFSelector = wxListBox_ctor()
   wxListBox_Create(SFSelector, mydiag,-1,wxSize_ctor(-1,-1),wxSize_ctor(400,350),0,0,wxLB_SINGLE or wxLB_NEEDED_SB or wxLB_HSCROLL,0,0 )
   LbFont=wxFont_ctor(12, wxMODERN, wxNORMAL, wxNORMAL, false,0,0)
   wxWindow_SetFont(SFSelector,LbFont)
   wxListBox_Append(SFSelector,"hit the x and die")
   
   
   'create the main panel (makes the background pretty ;) )
   wx_panel = wxPanel_ctor ()
   wxPanel_Create (wx_panel, wx_frame, Panel, 0, 0, 0, 0)
   
   'create a text widget
   'we're not using this thing for any events so it gets an id of -1
   wx_text=wxTextCtrl_ctor ()
   wxTextCtrl_Create(wx_text,wx_panel,-1,"hello from wx-c in fb!",wxsize_ctor(-1,-1),wxsize_ctor(200,90),wxSUNKEN_BORDER or wxVSCROLL,0,0)
   
   'make a button (sending a wxsize_ctor(-1,-1) means take the default size - you can specify just x or y as -1 if
   'you want the other one to be a fixed size
   teh_button=wxButton_ctor()
   wxButton_Create(teh_button,wx_panel,Button,"click me and die",wxsize_ctor(5,100),wxsize_ctor(-1,-1),0,0,0)
   
   'connect the button to the button event handler sub
   wxEvtHandler_proxy( teh_button, @ButtonClick )
   wxEvtHandler_connect(teh_button,wxEvent_EVT_COMMAND_BUTTON_CLICKED(),Button,-1,0)
   
   wxWindow_CenterOnScreen(wx_frame,wxBOTH)
   wxWindow_Show ( wx_frame, 1 )
end sub

sub App_OnExit()

    ' here your code executed on exit
    wx_msgbox_size = wxSize_ctor ( 150, 50)
    wxMsgBox ( 0, "Bye Bye...", "Window Closed!", 0, wx_msgbox_size)

end sub

' main code...

  wx_app = wxApp_ctor()
  wxApp_RegisterVirtual ( wx_app, @App_OnInit, @App_OnExit)
  wxApp_Run(0,0)