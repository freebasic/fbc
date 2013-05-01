
#include once "IUP/iup.bi"

#define NULL 0

  '' IUP identifiers
  dim as Ihandle ptr frame, dialog

  '' Initializes IUP 
  IupOpen( NULL, NULL )

  '' Creates frame with a label
  frame = IupFrame _
          ( _
            IupHbox _
            ( _
              IupFill(), _
              IupLabel (!"IupFrame Attributes:\nFGCOLOR = \"255 0 0\"\nSIZE = \"EIGHTHxEIGHTH\"\nTITLE = \"This is the frame\"\nMARGIN = \"10x10\""), _
              IupFill(), _
              NULL _
            ) _
          )

  '' Sets frame's attributes
  IupSetAttributes(frame, !"FGCOLOR=\"255 0 0\", SIZE=EIGHTHxEIGHTH, TITLE=\"This is the frame\", MARGIN=10x10")

  '' Creates dialog 
  dialog = IupDialog(frame)

  '' Sets dialog's title
  IupSetAttribute(dialog, IUP_TITLE, "IupFrame")

  '' Shows dialog in the center of the screen
  IupShow( dialog )  
  
  '' Initializes IUP main loop
  IupMainLoop()      
  
  '' Finishes IUP
  IupClose()
