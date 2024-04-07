'' examples/manual/proguide/events/event2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Event Handling'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgEventHandling
'' --------

'   The main code (main thread) tests Inkey in a loop.
'   The other thread tests ScreenEvent in a loop.
'   The ESC character allows to exit the two loops.

#include "fbgfx.bi"
Using FB

Function getAscii (ByVal ascii As Long) As String
	If ((ascii>0) And (ascii<255)) Then
		Return "'" & Chr(ascii) & "'"
	Else
		Return "???"
	End If
End Function

Sub Thread (ByVal p As Any Ptr)
	Dim e As Event
	Do
		If (ScreenEvent(@e)) Then
			Select Case As Const e.Type
			Case EVENT_KEY_PRESS                                      '' test key-pressed event
				Print getAscii(e.ascii) &_ 
				" is pressed    (from ScreenEvent)   (other thread)"
				If (e.scancode=SC_ESCAPE) Then                        '' test ESC
					Exit Sub
				End If
			Case EVENT_KEY_RELEASE                                    '' test key-released event
				Print getAscii(e.ascii) &_ 
				" is released   (from ScreenEvent)   (other thread)"
			Case EVENT_KEY_REPEAT                                     '' test key-repeated event
				Print getAscii(e.ascii) &_ 
				" is repeated   (from ScreenEvent)   (other thread)"
			End Select
		End If
		Sleep 10, 1
	Loop
End Sub

Screen 12

Dim As String s
Dim As Any Ptr pt
pt = ThreadCreate(@Thread)

Do
	s = Inkey
	If s <> "" Then                                                   '' test inkey return
		Print getAscii(s[0]) &_ 
		" is viewed     (from Inkey)         (main thread)"
	End If
	Sleep 10, 1
Loop Until s = Chr(27)                                                '' test ESC

ThreadWait(pt)
Print "main and other thread completed"

Sleep
		
