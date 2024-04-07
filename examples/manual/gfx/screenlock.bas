'' examples/manual/gfx/screenlock.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'SCREENLOCK'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgScreenlock
'' --------

'' Draws a circle on-screen at the mouse cursor
Dim As Long mx, my
Dim As String key

ScreenRes 640, 480, 32

Do

  'process
  GetMouse(mx, my)
  key = Inkey()

  'draw
  ScreenLock()
  Cls()
  Circle (mx, my), 8, RGB(255, 255, 255)
  ScreenUnlock()

  'free up CPU time
  Sleep(18, 1)
  
Loop Until key = Chr(27) Or key = Chr(255, 107)
