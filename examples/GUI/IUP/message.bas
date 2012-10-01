#include once "IUP/iup.bi"

  '' Initializes IUP
  IupOpen()
  
  '' Program begin
  
  '' Executes IupMessage
  IupMessage("IupMessage Example", "Press the button")

  '' Initializes IUP main loop
  IupMainLoop ()

  '' Finishes IUP
  IupClose ()
