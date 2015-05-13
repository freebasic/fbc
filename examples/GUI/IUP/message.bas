#include once "IUP/iup.bi"
#define NULL 0

  '' Initializes IUP
  IupOpen( NULL, NULL )

  '' Shows a Message Box
  IupMessage("IupMessage Example", "Hi! Press the button:")

  '' Finishes IUP
  IupClose ()
