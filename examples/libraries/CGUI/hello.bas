'' CGUI Example program showing how open a window with one close button. The program is 100% meaningless.


#include once "allegro.bi"
#include once "cgui.bi"

declare sub make_a_window ()

sub new_window cdecl (byval userdata as any ptr)
   make_a_window()
end sub

sub stop_program cdecl (byval userdata as any ptr)
   end 0
end sub

sub close_window cdecl (byval userdata as any ptr)
   '' This terminates the top level of event proscessing
   StopProcessEvents()
   CloseWin(NULL)
end sub

sub make_a_window( )
  
   MkDialogue(CGUI_ADAPTIVE, "Hello world", 0)
   
   AddButton(CGUI_TOPLEFT, "A new_window", @new_window, NULL)
   
   AddTextBox(CGUI_RIGHT, "A simple window showing some buttons. Press the button to the left and you will get a new identical window.", 200, 0, 0)
   
   AddButton(CGUI_DOWNLEFT, "E~xit", @stop_program, NULL)
   
   AddButton(CGUI_RIGHT, "Close", @close_window, NULL)
   DisplayWin()

   '' Check for events - like mouse clicks and key-presses
   ProcessEvents()
end sub

   InitCgui(1024, 768, 15)
   make_a_window()
   END_OF_MAIN()