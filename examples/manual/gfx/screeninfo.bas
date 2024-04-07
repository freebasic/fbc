'' examples/manual/gfx/screeninfo.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'SCREENINFO'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgScreeninfo
'' --------

Dim w As Long, h As Long
Dim depth As Long
Dim driver_name As String

Screen 15, 32 
' Obtain info about current mode 
ScreenInfo w, h, depth,,,,driver_name
Print Str(w) + "x" + Str(h) + "x" + Str(depth); 
Print " using " + driver_name + " driver" 
Sleep 
' Quit graphics mode and obtain info about desktop 
Screen 0 
ScreenInfo w, h, depth 
Print "Desktop running at " + Str(w) + "x" + Str(h) + "x" + Str(depth); 
