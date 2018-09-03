
#include once "IUP/iup.bi"

#define NULL 0

'':::::
function ok_cb cdecl (byval handler as Ihandle ptr) as long
  dim as Ihandle ptr red_text
  dim as Ihandle ptr green_text
  dim as Ihandle ptr blue_text
  dim as Ihandle ptr color_text
  dim as integer red
  dim as integer green
  dim as integer blue
  
  red_text = IupGetHandle("red_text")
  green_text = IupGetHandle("green_text")
  blue_text = IupGetHandle("blue_text")
  color_text = IupGetHandle("color_text")

  red = IupGetInt(red_text, IUP_VALUE)
  green = IupGetInt(green_text, IUP_VALUE)
  blue = IupGetInt(blue_text, IUP_VALUE)
  
  if(red < 0 or red > 255) then red = 0 
  if(green < 0 or green > 255) then green = 0 
  if(blue < 0 or blue > 255) then blue = 0 

  '' The color can be set by passing a string like "255 128 0", i.e. "R G B".
  '' IUP will keep a pointer to our string and use it, so we must ensure it
  '' stays valid even when this function returns.
  static clr as zstring * 12
  clr = red & " " & green & " " & blue
  IupSetAttribute(color_text, IUP_BGCOLOR, strptr(clr))
  
  return IUP_DEFAULT
end function

'' main  
  dim as Ihandle ptr label
  dim as Ihandle ptr red_label
  dim as Ihandle ptr green_label
  dim as Ihandle ptr blue_label
  dim as Ihandle ptr color_label
  dim as Ihandle ptr red_text
  dim as Ihandle ptr green_text
  dim as Ihandle ptr blue_text
  dim as Ihandle ptr color_text
  dim as Ihandle ptr ok_button
  dim as Ihandle ptr main_dlg

  IupOpen( NULL, NULL )

  label = IupLabel("Enter RGB values")
  red_label = IupLabel("Red")
  green_label = IupLabel("Green")
  blue_label = IupLabel("Blue")
  color_label = IupLabel("Color")
  red_text = IupText(NULL)
  green_text = IupText(NULL)
  blue_text = IupText(NULL)
  color_text = IupText(NULL)
  ok_button = IupButton("Apply","ok_act")

  main_dlg = IupDialog _
	  ( IupVbox _
	     ( IupHbox ( IupFill(), label, IupFill(), NULL), _
	       IupHbox _
		( IupVbox ( IupFill(), red_label, IupFill(), NULL), _
		  IupFill(), red_text, NULL _
		), _
               IupHbox _
  	        ( IupVbox ( IupFill(), green_label, IupFill(), NULL), _
		  IupFill(), green_text, NULL _
		), _
	       IupHbox _
	        ( IupVbox ( IupFill(), blue_label, IupFill(), NULL), _
		  IupFill(), blue_text, NULL _
		), _
	       IupHbox _
	        ( IupVbox ( IupFill(), color_label, IupFill(), NULL), _
		  IupFill(), color_text, NULL _
		), _
               IupHbox ( IupFill(), ok_button, IupFill(), NULL), _
	     NULL _
	     ) _
	  )

  IupSetAttribute(red_text, IUP_NC, "3")
  IupSetAttribute(green_text, IUP_NC, "3")
  IupSetAttribute(blue_text, IUP_NC, "3")
  
  IupSetAttribute(color_text, IUP_BGCOLOR, "0 0 0")
  IupSetAttribute(color_text, IUP_READONLY, IUP_YES)


  IupSetAttributes(main_dlg, "TITLE=IupColor, DEFAULTENTER=ok_button, MAXBOX=NO, MINBOX=NO, RESIZE=NO")
  
  IupSetHandle("main_dlg", main_dlg)
  IupSetHandle("red_text", red_text)
  IupSetHandle("green_text", green_text)
  IupSetHandle("blue_text", blue_text)
  IupSetHandle("color_text", color_text)
  IupSetHandle("ok_button", ok_button)
  
  IupSetFunction("ok_act", @ok_cb)

  IupShowXY(main_dlg, IUP_CENTER, IUP_CENTER)

  IupMainLoop()
  IupClose()
