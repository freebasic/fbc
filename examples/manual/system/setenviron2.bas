'' examples/manual/system/setenviron2.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgSetenviron
'' --------

  '' WINDOWS ONLY EXAMPLE! - We just set the graphics method to use
  '' GDI rather than DirectX.
  '' You may note a difference in FPS.
SetEnviron("fbgfx=GDI")

  '' Desktop width/height
Dim As Integer ScrW, ScrH, BPP
ScreenInfo ScrW, ScrH, BPP

  '' Create a screen at the width/height of your monitor.
  '' Normally this would be slow, but GDI is fairly fast for this kind
  '' of thing.
ScreenRes ScrW, ScrH, BPP

  '' Start our timer/
Dim As Double T = Timer

  '' Lock our page
ScreenLock
Do
  
	'' Print time since last frame
  Locate 1, 1
  Print "FPS: " & 1 / ( Timer - T )
  T = Timer
  
	'' Flip our screen
  ScreenUnlock
  ScreenLock
	'' Commit a graphical change to our screen.
  Cls
  
Loop Until Len(Inkey)

  '' unlock our page.
ScreenUnlock
