'' examples/manual/gfx/screeninfo.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgScreeninfo
'' --------

Dim w As Integer, h As Integer
Dim depth As Integer
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
