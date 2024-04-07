'' examples/manual/system/setenviron2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'SETENVIRON'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgSetenviron
'' --------

  '' WINDOWS ONLY EXAMPLE! - We just set the graphics method to use
  '' GDI rather than DirectX (or Direct2D added on new systems).
  '' You may note a difference in FPS.
SetEnviron("fbgfx=GDI")

  '' Desktop width/height
Dim As Long ScrW, ScrH, BPP
ScreenInfo ScrW, ScrH, BPP

  '' Create a screen at the half width/height of your monitor.
  '' Normally this would be slow, but GDI is fairly fast for this kind
  '' of thing.
ScreenRes ScrW/2, ScrH/2, BPP

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
